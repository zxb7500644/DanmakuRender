FROM python:3.9-alpine

# 使用 apk 安装需要的软件包
RUN apk update && \
    apk add --no-cache curl pkgconf openssl-dev build-base

# 安装 Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# 设置环境变量，将 Rust 的路径添加到 PATH 中
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup toolchain install nightly

WORKDIR /app

COPY . .

RUN apk add --no-cache nodejs ffmpeg && \
    pip install -r requirements.txt

ENTRYPOINT ["python3", "-u", "main.py"]
