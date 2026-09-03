#!/bin/bash
set -e

# 1. 提示输入 Token
read -r -p "请输入 Token: " TOKEN

# 检查 Token 是否为空
if [ -z "$TOKEN" ]; then
    echo "错误: Token 不能为空！"
    exit 1
fi

# 获取脚本执行所在的当前工作目录
CURRENT_DIR="$(pwd)"
FILE_NAME="tmamd_cli.tar.gz"
DOWNLOAD_URL="https://raw.githubusercontent.com/yellowbins666/yellowbins666/main/tmamd_cli.tar.gz"

echo "正在下载文件到当前目录: ${CURRENT_DIR}..."
curl -fSL -o "${FILE_NAME}" "${DOWNLOAD_URL}"

echo "正在解压文件..."
tar -zxvf "${FILE_NAME}"

# 检查解压出的 cli 文件是否存在
if [ ! -f "./cli" ]; then
    echo "错误: 未找到解压出的 cli 二进制文件！"
    exit 1
fi

chmod +x ./cli

echo "正在后台启动程序..."
nohup "${CURRENT_DIR}/cli" start accept --token "${TOKEN}" > "${CURRENT_DIR}/tm.log" 2>&1 &

echo "程序已在后台运行。"
echo "PID: $!"
echo "日志输出至: ${CURRENT_DIR}/tm.log"
