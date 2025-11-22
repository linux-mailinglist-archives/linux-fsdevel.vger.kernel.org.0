Return-Path: <linux-fsdevel+bounces-69501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9280DC7D939
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 23:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FCBF4E18C4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 22:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5142E8B63;
	Sat, 22 Nov 2025 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Ey4RFQnL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54592E8B9F
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763850279; cv=none; b=WuVlKWIb3OnPXN3wP1JCxOUqcT+jcoHJs7gwLkMJaU7ILWW6FTtn/YrBjt7luB4OuLMXhtJyY7QnRTe5DfD8a4yuI7xmE+P9xHk/7Rqc5ljN5Hy/JgqdvE0KZH1KwboZWEBwtTkHoTXdyBS7OGLS7XdkvLjvCD6hxc4H8XRZcro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763850279; c=relaxed/simple;
	bh=qyFA0AVLodsieu/MOUPeDtGYSXYLnzDYcmyFDoYZ4n4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCq3aeZo5V3LDfoKF2WA6+q3XLCG8L8Elw57Kjb5am+BnPa10mZCVkZMREtReLxOiqS2kkzkvlbSG/2sabSIYbTtXNM59Et5kRMUDtz/Y55eTdtrnSuZUUt4jDrkz7dvGAhbvCAAEdPVDOIWgsS9YDmHIC3K5O41Vdwkdw25wRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Ey4RFQnL; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-78a6a7654a4so31531287b3.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 14:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763850275; x=1764455075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5tajeHzp9hDN07gnwZlVCQmxSUhZpHiffHO9VM3nds=;
        b=Ey4RFQnL1todxo3JlT9zqrwifowIc1ThEPlnrf11Wx4lEHquk3UBgc7FKjWWKykQAJ
         5dzZnUJspafViNVxurays9MgBRe5dFe9OTebD+3JoGr4TiOWg0uCSI9mkQyPCPBEVa6E
         K3NXpWyQSUorqauurmLHzbvt4EaeIYi1i1XNUIJylkVXqi52OG3aP4vwkgegyDe7Ix2y
         JWqVNaCHxmf2qrHHU45m/uoMmbLrGf+Z0QMRSdDWwi4oPDPrBpbjZ4o8dcuejQHqSSrj
         cuvbTcCkgMzlk2smSC3tl8+s4zIUMcZtg0iltbRjwu3D900+uQy04uwi/laHy7xEuOXV
         NY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763850275; x=1764455075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F5tajeHzp9hDN07gnwZlVCQmxSUhZpHiffHO9VM3nds=;
        b=fj8+3Yw+VOrzpMiOs2/cfafTS4KF7tl8O8blweetstGStRKnyTvQXvp2NYvhLyJ5gy
         4NXr+/TTZGaF5X+HNCyrfjPpfQ/XY1zhFUW8O/euAdLIrGd+q2umoigpHJ9UpQVPlxlr
         2esoJe+pMDV/KY1etpsmQ8BpWocesgzcvN9rUMjtkIBgUeDdH6xO5ux8RqIo3dZLFLbO
         TxSg034fX4jo58QFjzDdYsDc8YqzSx8q1s7BPxuoS7OlTe9eYRckdGWQoXPcnGop7o3h
         2TSDGfsIk9aCXmk5JluIcqASydxIfpY+z+OAD9QTYOjEWpoL+BABNNubnMPpK8vdiqgJ
         nEvw==
X-Forwarded-Encrypted: i=1; AJvYcCVNRTrvf9DzpvETj6ya2feHdxSvjacEdIR1U1687ERPAFE5NlyK8BFSxqaR0wLNy1/mHiwQAeeqCvV3jy1z@vger.kernel.org
X-Gm-Message-State: AOJu0YyVMc8oIvtInnSdjAub6TnWZDE1sDXHl+PFSpoEzAtF/CsQKKtq
	lU0s+Nu84ptgc3MbuFLp9WdT4OYem5U3VzV+eCuoiH8Elb7SrQarolHgs4Q3RcyFisw=
X-Gm-Gg: ASbGncvP7eQOofG8Qh1jespI6LSByMEPKoEUB2C9qpLkNPB/IDaqo0KMnPuDlDmQIQv
	N7of8x+f5Btp+iUp124SJBmJyQQ/1WaxEaQjFdK5X60NCDhaCltu+Kz3FfnuknChtZalw94tuMm
	4/7dXKjg8zbzTxCNSeVHIXYWJuNYIMqwKcS7xg5r9Wd57Qqoy6Gh2Oo09dptaGZMI6se5YNh+5H
	gOn7VKbfkyguPadjKzsJUuLkpCKXLxv6FG9eZZ+/AYPo4SM5JVr9hVpfYdosHYVUDdH5F5HuLrY
	2deiiQ8VQUR5PK800pa1jaGGUsIRbJnVJeg73aizqBhJOpPOs84kByuu+hosCGzSFNt9tekaTop
	761FdV0yEnRS6cBeFGr5/G59T4UTo1zrtBTae5yO+54Cfg5/pw1o8DjB7nXDzOCcw7aLB3ouOga
	MYa/ZQIiFWbLJEbsE11pA48s3kkzNyYKB6VnWHaKLqsF9hoG70WxlfcTTovNetDxk5oFD0WLlot
	hcc2l0=
X-Google-Smtp-Source: AGHT+IFD6osaS2sP17uSKoOpkdrgAaGoOW4xxaV4WzN7kWyXMlqtMJ1zAdZWqXZh/Duto084HHI0jg==
X-Received: by 2002:a05:690c:968a:b0:786:896d:8858 with SMTP id 00721157ae682-78a8b54d4a4mr55406797b3.47.1763850274503;
        Sat, 22 Nov 2025 14:24:34 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a79779a4esm28858937b3.0.2025.11.22.14.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 14:24:33 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org
Subject: [PATCH v7 19/22] selftests/liveupdate: add test infrastructure and scripts
Date: Sat, 22 Nov 2025 17:23:46 -0500
Message-ID: <20251122222351.1059049-20-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
In-Reply-To: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the testing infrastructure required to verify the liveupdate
feature. This includes a custom init process, a test orchestration
script, and a batch runner.

The framework consists of:

init.c:
A lightweight init process that manages the kexec lifecycle.
It mounts necessary filesystems, determines the current execution
stage (1 or 2) via the kernel command line, and handles the
kexec_file_load() sequence to transition between kernels.

luo_test.sh:
The primary KTAP-compliant test driver. It handles:
- Kernel configuration merging and building.
- Cross-compilation detection for x86_64 and arm64.
- Generation of the initrd containing the test binary and init.
- QEMU execution with automatic accelerator detection (KVM, HVF,
 or TCG).

run.sh:
A wrapper script to discover and execute all `luo_*.c`
tests across supported architectures, providing a summary of
pass/fail/skip results.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 tools/testing/selftests/liveupdate/init.c     | 174 ++++++++++
 .../testing/selftests/liveupdate/luo_test.sh  | 296 ++++++++++++++++++
 tools/testing/selftests/liveupdate/run.sh     |  68 ++++
 3 files changed, 538 insertions(+)
 create mode 100644 tools/testing/selftests/liveupdate/init.c
 create mode 100755 tools/testing/selftests/liveupdate/luo_test.sh
 create mode 100755 tools/testing/selftests/liveupdate/run.sh

diff --git a/tools/testing/selftests/liveupdate/init.c b/tools/testing/selftests/liveupdate/init.c
new file mode 100644
index 000000000000..ed11e04d0796
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/init.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+#include <fcntl.h>
+#include <linux/kexec.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/reboot.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#define COMMAND_LINE_SIZE 2048
+#define KERNEL_IMAGE "/kernel"
+#define INITRD_IMAGE "/initrd.img"
+#define TEST_BINARY "/test_binary"
+
+static int mount_filesystems(void)
+{
+	if (mount("devtmpfs", "/dev", "devtmpfs", 0, NULL) < 0) {
+		fprintf(stderr, "INIT: Warning: Failed to mount devtmpfs\n");
+		return -1;
+	}
+
+	if (mount("debugfs", "/debugfs", "debugfs", 0, NULL) < 0) {
+		fprintf(stderr, "INIT: Failed to mount debugfs\n");
+		return -1;
+	}
+
+	if (mount("proc", "/proc", "proc", 0, NULL) < 0) {
+		fprintf(stderr, "INIT: Failed to mount proc\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static long kexec_file_load(int kernel_fd, int initrd_fd,
+			    unsigned long cmdline_len, const char *cmdline,
+			    unsigned long flags)
+{
+	return syscall(__NR_kexec_file_load, kernel_fd, initrd_fd, cmdline_len,
+		       cmdline, flags);
+}
+
+static int kexec_load(void)
+{
+	char cmdline[COMMAND_LINE_SIZE];
+	int kernel_fd, initrd_fd, err;
+	ssize_t len;
+	int fd;
+
+	fd = open("/proc/cmdline", O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "INIT: Failed to read /proc/cmdline\n");
+
+		return -1;
+	}
+
+	len = read(fd, cmdline, sizeof(cmdline) - 1);
+	close(fd);
+	if (len < 0)
+		return -1;
+
+	cmdline[len] = 0;
+	if (len > 0 && cmdline[len - 1] == '\n')
+		cmdline[len - 1] = 0;
+
+	strncat(cmdline, " luo_stage=2", sizeof(cmdline) - strlen(cmdline) - 1);
+
+	kernel_fd = open(KERNEL_IMAGE, O_RDONLY);
+	if (kernel_fd < 0) {
+		fprintf(stderr, "INIT: Failed to open kernel image\n");
+		return -1;
+	}
+
+	initrd_fd = open(INITRD_IMAGE, O_RDONLY);
+	if (initrd_fd < 0) {
+		fprintf(stderr, "INIT: Failed to open initrd image\n");
+		close(kernel_fd);
+		return -1;
+	}
+
+	err = kexec_file_load(kernel_fd, initrd_fd, strlen(cmdline) + 1,
+			      cmdline, 0);
+
+	close(initrd_fd);
+	close(kernel_fd);
+
+	return err ? : 0;
+}
+
+static int run_test(int stage)
+{
+	char stage_arg[32];
+	int status;
+	pid_t pid;
+
+	snprintf(stage_arg, sizeof(stage_arg), "--stage=%d", stage);
+
+	pid = fork();
+	if (pid < 0)
+		return -1;
+
+	if (!pid) {
+		static const char *const argv[] = {TEST_BINARY, stage_arg, NULL};
+
+		execve(TEST_BINARY, argv, NULL);
+		fprintf(stderr, "INIT: execve failed\n");
+		_exit(1);
+	}
+
+	waitpid(pid, &status, 0);
+
+	return (WIFEXITED(status) && WEXITSTATUS(status) == 0) ? 0 : -1;
+}
+
+static int is_stage_2(void)
+{
+	char cmdline[COMMAND_LINE_SIZE];
+	ssize_t len;
+	int fd;
+
+	fd = open("/proc/cmdline", O_RDONLY);
+	if (fd < 0)
+		return 0;
+
+	len = read(fd, cmdline, sizeof(cmdline) - 1);
+	close(fd);
+
+	if (len < 0)
+		return 0;
+
+	cmdline[len] = 0;
+
+	return !!strstr(cmdline, "luo_stage=2");
+}
+
+int main(int argc, char *argv[])
+{
+	int current_stage;
+
+	if (mount_filesystems())
+		goto err_reboot;
+
+	current_stage = is_stage_2() ? 2 : 1;
+
+	printf("INIT: Starting Stage %d\n", current_stage);
+
+	if (current_stage == 1 && kexec_load()) {
+		fprintf(stderr, "INIT: Failed to load kexec kernel\n");
+		goto err_reboot;
+	}
+
+	if (run_test(current_stage)) {
+		fprintf(stderr, "INIT: Test binary returned failure\n");
+		goto err_reboot;
+	}
+
+	printf("INIT: Stage %d completed successfully.\n", current_stage);
+	reboot(current_stage == 1 ? RB_KEXEC : RB_AUTOBOOT);
+
+	return 0;
+
+err_reboot:
+	reboot(RB_AUTOBOOT);
+
+	return -1;
+}
diff --git a/tools/testing/selftests/liveupdate/luo_test.sh b/tools/testing/selftests/liveupdate/luo_test.sh
new file mode 100755
index 000000000000..7d155956e2ff
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/luo_test.sh
@@ -0,0 +1,296 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+set -ue
+
+CROSS_COMPILE="${CROSS_COMPILE:-""}"
+
+test_dir=$(realpath "$(dirname "$0")")
+kernel_dir=$(realpath "$test_dir/../../../..")
+
+workspace_dir=""
+headers_dir=""
+initrd=""
+KEEP_WORKSPACE=0
+
+source "$test_dir/../kselftest/ktap_helpers.sh"
+
+function get_arch_conf() {
+	local arch=$1
+	if [[ "$arch" == "arm64" ]]; then
+		QEMU_CMD="qemu-system-aarch64 -M virt -cpu max"
+		KERNEL_IMAGE="Image"
+		KERNEL_CMDLINE="console=ttyAMA0"
+	elif [[ "$arch" == "x86" ]]; then
+		QEMU_CMD="qemu-system-x86_64"
+		KERNEL_IMAGE="bzImage"
+		KERNEL_CMDLINE="console=ttyS0"
+	else
+		echo "Unsupported architecture: $arch"
+		exit 1
+	fi
+}
+
+function usage() {
+	cat <<EOF
+$0 [-d build_dir] [-j jobs] [-t target_arch] [-T test_name] [-w workspace_dir] [-k] [-h]
+Options:
+	-d)	path to the kernel build directory (default: .luo_test_build.<arch>)
+	-j)	number of jobs for compilation
+	-t)	run test for target_arch (aarch64, x86_64)
+	-T)	test name to run (default: luo_kexec_simple)
+	-w)	custom workspace directory (default: creates temp dir)
+	-k)	keep workspace directory after successful test
+	-h)	display this help
+EOF
+}
+
+function cleanup() {
+	local exit_code=$?
+
+	if [ -z "$workspace_dir" ]; then
+		ktap_finished
+		return
+	fi
+
+	if [ $exit_code -ne 0 ]; then
+		echo "# Test failed (exit code $exit_code)."
+		echo "# Workspace preserved at: $workspace_dir"
+	elif [ "$KEEP_WORKSPACE" -eq 1 ]; then
+		echo "# Workspace preserved (user request) at: $workspace_dir"
+	else
+		rm -fr "$workspace_dir"
+	fi
+	ktap_finished
+}
+trap cleanup EXIT
+
+function skip() {
+	local msg=${1:-""}
+	ktap_test_skip "$msg"
+	exit "$KSFT_SKIP"
+}
+
+function fail() {
+	local msg=${1:-""}
+	ktap_test_fail "$msg"
+	exit "$KSFT_FAIL"
+}
+
+function detect_cross_compile() {
+	local target=$1
+	local host=$(uname -m)
+
+	if [ -n "$CROSS_COMPILE" ]; then
+		return
+	fi
+
+	[[ "$host" == "arm64" ]] && host="aarch64"
+	[[ "$target" == "arm64" ]] && target="aarch64"
+
+	if [[ "$host" == "$target" ]]; then
+		CROSS_COMPILE=""
+		return
+	fi
+
+	local candidate=""
+	case "$target" in
+		aarch64) candidate="aarch64-linux-gnu-" ;;
+		x86_64)  candidate="x86_64-linux-gnu-" ;;
+		*)       skip "Auto-detection for target '$target' not supported. Please set CROSS_COMPILE manually." ;;
+	esac
+
+	if command -v "${candidate}gcc" &> /dev/null; then
+		CROSS_COMPILE="$candidate"
+	else
+		skip "Compiler '${candidate}gcc' not found. Please install it (e.g., 'apt install gcc-aarch64-linux-gnu') or set CROSS_COMPILE."
+	fi
+}
+
+function build_kernel() {
+	local build_dir=$1
+	local make_cmd=$2
+	local kimage=$3
+	local target_arch=$4
+
+	local kconfig="$build_dir/.config"
+	local common_conf="$test_dir/config"
+	local arch_conf="$test_dir/config.$target_arch"
+
+	echo "# Building kernel in: $build_dir"
+	$make_cmd defconfig
+
+	local fragments=""
+	if [[ -f "$common_conf" ]]; then
+		fragments="$fragments $common_conf"
+	fi
+
+	if [[ -f "$arch_conf" ]]; then
+		fragments="$fragments $arch_conf"
+	fi
+
+	if [[ -n "$fragments" ]]; then
+		"$kernel_dir/scripts/kconfig/merge_config.sh" \
+			-Q -m -O "$build_dir" "$kconfig" $fragments >> /dev/null
+	fi
+
+	$make_cmd olddefconfig
+	$make_cmd "$kimage"
+	$make_cmd headers_install INSTALL_HDR_PATH="$headers_dir"
+}
+
+function mkinitrd() {
+	local build_dir=$1
+	local kernel_path=$2
+	local test_name=$3
+
+	# 1. Compile the test binary and the init process
+	"$CROSS_COMPILE"gcc -static -O2 \
+		-I "$headers_dir/include" \
+		-I "$test_dir" \
+		-o "$workspace_dir/test_binary" \
+		"$test_dir/$test_name.c" "$test_dir/luo_test_utils.c"
+
+	"$CROSS_COMPILE"gcc -s -static -Os -nostdinc -nostdlib		\
+			-fno-asynchronous-unwind-tables -fno-ident	\
+			-fno-stack-protector				\
+			-I "$headers_dir/include"			\
+			-I "$kernel_dir/tools/include/nolibc"		\
+			-o "$workspace_dir/init" "$test_dir/init.c"
+
+	cat > "$workspace_dir/cpio_list_inner" <<EOF
+dir /dev 0755 0 0
+dir /proc 0755 0 0
+dir /debugfs 0755 0 0
+nod /dev/console 0600 0 0 c 5 1
+file /init $workspace_dir/init 0755 0 0
+file /test_binary $workspace_dir/test_binary 0755 0 0
+EOF
+
+	# Generate inner_initrd.cpio
+	"$build_dir/usr/gen_init_cpio" "$workspace_dir/cpio_list_inner" > "$workspace_dir/inner_initrd.cpio"
+
+	cat > "$workspace_dir/cpio_list" <<EOF
+dir /dev 0755 0 0
+dir /proc 0755 0 0
+dir /debugfs 0755 0 0
+nod /dev/console 0600 0 0 c 5 1
+file /init $workspace_dir/init 0755 0 0
+file /kernel $kernel_path 0644 0 0
+file /test_binary $workspace_dir/test_binary 0755 0 0
+file /initrd.img $workspace_dir/inner_initrd.cpio 0644 0 0
+EOF
+
+	# Generate the final initrd
+	"$build_dir/usr/gen_init_cpio" "$workspace_dir/cpio_list" > "$initrd"
+	local size=$(du -h "$initrd" | cut -f1)
+}
+
+function run_qemu() {
+	local qemu_cmd=$1
+	local cmdline=$2
+	local kernel_path=$3
+	local serial="$workspace_dir/qemu.serial"
+
+	local accel="-accel tcg"
+	local host_machine=$(uname -m)
+
+	[[ "$host_machine" == "arm64" ]] && host_machine="aarch64"
+	[[ "$host_machine" == "x86_64" ]] && host_machine="x86_64"
+
+	if [[ "$qemu_cmd" == *"$host_machine"* ]]; then
+		if [ -w /dev/kvm ]; then
+			accel="-accel kvm"
+		fi
+	fi
+
+	cmdline="$cmdline liveupdate=on panic=-1"
+
+	echo "# Serial Log: $serial"
+	timeout 30s $qemu_cmd -m 1G -smp 2 -no-reboot -nographic -nodefaults	\
+		  $accel							\
+		  -serial file:"$serial"					\
+		  -append "$cmdline"						\
+		  -kernel "$kernel_path"					\
+		  -initrd "$initrd"
+
+	local ret=$?
+
+	if [ $ret -eq 124 ]; then
+		fail "QEMU timed out"
+	fi
+
+	grep "TEST PASSED" "$serial" &> /dev/null || fail "Liveupdate failed. Check $serial for details."
+}
+
+function target_to_arch() {
+	local target=$1
+	case $target in
+	     aarch64) echo "arm64" ;;
+	     x86_64) echo "x86" ;;
+	     *) skip "architecture $target is not supported"
+	esac
+}
+
+function main() {
+	local build_dir=""
+	local jobs=$(nproc)
+	local target="$(uname -m)"
+	local test_name="luo_kexec_simple"
+	local workspace_arg=""
+
+	set -o errtrace
+	trap skip ERR
+
+	while getopts 'hd:j:t:T:w:k' opt; do
+		case $opt in
+		d) build_dir="$OPTARG" ;;
+		j) jobs="$OPTARG" ;;
+		t) target="$OPTARG" ;;
+		T) test_name="$OPTARG" ;;
+		w) workspace_arg="$OPTARG" ;;
+		k) KEEP_WORKSPACE=1 ;;
+		h) usage; exit 0 ;;
+		*) echo "Unknown argument $opt"; usage; exit 1 ;;
+		esac
+	done
+
+	ktap_print_header
+	ktap_set_plan 1
+
+	if [ -n "$workspace_arg" ]; then
+		workspace_dir="$(realpath -m "$workspace_arg")"
+		mkdir -p "$workspace_dir"
+	else
+		workspace_dir=$(mktemp -d /tmp/luo-test.XXXXXXXX)
+	fi
+
+	echo "# Workspace created at: $workspace_dir"
+	headers_dir="$workspace_dir/usr"
+	initrd="$workspace_dir/initrd.cpio"
+
+	detect_cross_compile "$target"
+
+	local arch=$(target_to_arch "$target")
+
+	if [ -z "$build_dir" ]; then
+		build_dir="$kernel_dir/.luo_test_build.$arch"
+	fi
+
+	mkdir -p "$build_dir"
+	build_dir=$(realpath "$build_dir")
+	get_arch_conf "$arch"
+
+	local make_cmd="make -s ARCH=$arch CROSS_COMPILE=$CROSS_COMPILE -j$jobs"
+	local make_cmd_build="$make_cmd -C $kernel_dir O=$build_dir"
+
+	build_kernel "$build_dir" "$make_cmd_build" "$KERNEL_IMAGE" "$target"
+
+	local final_kernel="$build_dir/arch/$arch/boot/$KERNEL_IMAGE"
+	mkinitrd "$build_dir" "$final_kernel" "$test_name"
+
+	run_qemu "$QEMU_CMD" "$KERNEL_CMDLINE" "$final_kernel"
+	ktap_test_pass "$test_name succeeded"
+}
+
+main "$@"
diff --git a/tools/testing/selftests/liveupdate/run.sh b/tools/testing/selftests/liveupdate/run.sh
new file mode 100755
index 000000000000..3f6b29a26648
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/run.sh
@@ -0,0 +1,68 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+OUTPUT_DIR="results_$(date +%Y%m%d_%H%M%S)"
+SCRIPT_DIR=$(dirname "$(realpath "$0")")
+TEST_RUNNER="$SCRIPT_DIR/luo_test.sh"
+
+TARGETS=("x86_64" "aarch64")
+
+GREEN='\033[0;32m'
+RED='\033[0;31m'
+YELLOW='\033[1;33m'
+NC='\033[0m'
+
+PASSED=()
+FAILED=()
+SKIPPED=()
+
+mkdir -p "$OUTPUT_DIR"
+
+TEST_NAMES=()
+while IFS= read -r file; do
+    TEST_NAMES+=("$(basename "$file" .c)")
+done < <(find "$SCRIPT_DIR" -maxdepth 1 -name "luo_*.c" ! -name "luo_test_utils.c")
+
+if [ ${#TEST_NAMES[@]} -eq 0 ]; then
+    echo "No tests found in $SCRIPT_DIR"
+    exit 1
+fi
+
+for arch in "${TARGETS[@]}"; do
+    for test_name in "${TEST_NAMES[@]}"; do
+        log_file="$OUTPUT_DIR/${arch}_${test_name}.log"
+        echo -n "  -> $arch $test_name ... "
+
+        if "$TEST_RUNNER" -t "$arch" -T "$test_name" > "$log_file" 2>&1; then
+            echo -e "${GREEN}PASS${NC}"
+            PASSED+=("${arch}:${test_name}")
+        else
+            exit_code=$?
+            if [ $exit_code -eq 4 ]; then
+                echo -e "${YELLOW}SKIP${NC}"
+                SKIPPED+=("${arch}:${test_name}")
+            else
+                echo -e "${RED}FAIL${NC}"
+                FAILED+=("${arch}:${test_name}")
+            fi
+        fi
+    done
+    echo ""
+done
+
+echo "========================================="
+echo "             TEST SUMMARY                "
+echo "========================================="
+echo -e "PASSED: ${GREEN}${#PASSED[@]}${NC}"
+echo -e "FAILED: ${RED}${#FAILED[@]}${NC}"
+for fail in "${FAILED[@]}"; do
+    echo -e "  - $fail"
+done
+echo -e "SKIPPED: ${YELLOW}${#SKIPPED[@]}${NC}"
+echo "Logs: $OUTPUT_DIR"
+
+if [ ${#FAILED[@]} -eq 0 ]; then
+    exit 0
+else
+    exit 1
+fi
-- 
2.52.0.rc2.455.g230fcf2819-goog


