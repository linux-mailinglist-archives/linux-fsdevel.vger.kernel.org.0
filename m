Return-Path: <linux-fsdevel+bounces-65893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8653C139C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 09:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 858AD4F552A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 08:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B24C2E5B09;
	Tue, 28 Oct 2025 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laimPlMd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0762DCBFA;
	Tue, 28 Oct 2025 08:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641219; cv=none; b=QQwn9sdC0TrImU0NlEFGMK2Yd2aVusqJ5M4NW82SlOMEaCFyoh/k9qZ+ugxpa/f/sFEqBFyiTe/fok68zGoGnqAwuSsiL1jQilFjDPYfsTX19pBm9mSFCCmFpJUPUF0RBxwa0B0RIEZ+5+Cx6Blv4jov8GMpl/O8gfz9BjgEQKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641219; c=relaxed/simple;
	bh=OPfAGeM+ZBgPWvFckqnDtk+EMrhdCUCn6SieSCoZXTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xk0K1MAadmE1Rd7l5dR76ds+cE/9Ao8BXykXgad1HCLCFfzAZQXK8jizml+7m1FoZtUjnIrgPAEKps3EcvZMvDujnBDX5MI+Gycd8xk+wNIu2k/GIwEFm+YJCLXvLze9x6gUxY5ZeHkLK8Hmrwi1Xi79eIsPat99qerqbe3Qifs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laimPlMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0625C113D0;
	Tue, 28 Oct 2025 08:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761641219;
	bh=OPfAGeM+ZBgPWvFckqnDtk+EMrhdCUCn6SieSCoZXTo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=laimPlMdICzkDe/gDJma4tqu+02HWr1EpDGRupewh4m47kHo0e60QDpWbzlZ9fS9w
	 c/LKqPbSszZHtk0obIZ0r2h6tqXIFZkemoSrKEc8qA/4YEsgDIyNyLHaDw1Z51PKA8
	 /fwm+kvkDGEAGj9zDCoVX1Ynpiq441g1v9biuHtHRO1pjNrD3ETqqXifpiWHB5Nd5L
	 6paIIE797yuUJ1jEGM2MMU284ndGoneqoHebmLauuZ0kg7HaVpJfZdL5HwUu0ad5gQ
	 qfocy7/5EQB/DXjtyNpdaWHOg4whpvriqFxLP4g9j5e/uzkGNHjJKqjn/cCYo+2+iu
	 deVukgM2/YmXA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Oct 2025 09:45:58 +0100
Subject: [PATCH 13/22] selftests/coredump: split out coredump socket tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-work-coredump-signal-v1-13-ca449b7b7aa0@kernel.org>
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
 Aleksa Sarai <cyphar@cyphar.com>, 
 Yu Watanabe <watanabe.yu+github@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Luca Boccassi <luca.boccassi@gmail.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=92214; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OPfAGeM+ZBgPWvFckqnDtk+EMrhdCUCn6SieSCoZXTo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyNB16982RI6dK+9KJJl8Nw9dhPEn5Kud8snWfTg9ZM
 dn6wR/ZjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm0fWJkOBeyoT2Uv2f/01ni
 0fI++vclHl1qk7bsTPFbxyRjpxXAzsjwpXnJ5/VPlQITHrKHG03Zw3RjYuC+mO/mb7fONamtEc5
 lAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Split the coredump socket tests into separate files.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/coredump/.gitignore        |    4 +
 tools/testing/selftests/coredump/Makefile          |    8 +-
 .../coredump/coredump_socket_protocol_test.c       | 1315 ++++++++++++++++
 .../selftests/coredump/coredump_socket_test.c      |  394 +++++
 tools/testing/selftests/coredump/stackdump_test.c  | 1662 +-------------------
 5 files changed, 1722 insertions(+), 1661 deletions(-)

diff --git a/tools/testing/selftests/coredump/.gitignore b/tools/testing/selftests/coredump/.gitignore
new file mode 100644
index 000000000000..097f52db0be9
--- /dev/null
+++ b/tools/testing/selftests/coredump/.gitignore
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+stackdump_test
+coredump_socket_test
+coredump_socket_protocol_test
diff --git a/tools/testing/selftests/coredump/Makefile b/tools/testing/selftests/coredump/Makefile
index 77b3665c73c7..dece1a31d561 100644
--- a/tools/testing/selftests/coredump/Makefile
+++ b/tools/testing/selftests/coredump/Makefile
@@ -1,7 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O0 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 
-TEST_GEN_PROGS := stackdump_test
+TEST_GEN_PROGS := stackdump_test \
+		  coredump_socket_test \
+		  coredump_socket_protocol_test
 TEST_FILES := stackdump
 
 include ../lib.mk
+
+$(OUTPUT)/stackdump_test: coredump_test_helpers.c
+$(OUTPUT)/coredump_socket_test: coredump_test_helpers.c
+$(OUTPUT)/coredump_socket_protocol_test: coredump_test_helpers.c
diff --git a/tools/testing/selftests/coredump/coredump_socket_protocol_test.c b/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
new file mode 100644
index 000000000000..cc7364499c55
--- /dev/null
+++ b/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
@@ -0,0 +1,1315 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <sys/stat.h>
+#include <sys/epoll.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include "coredump_test.h"
+
+#define NUM_CRASHING_COREDUMPS 5
+
+FIXTURE_SETUP(coredump)
+{
+	FILE *file;
+	int ret;
+
+	self->pid_coredump_server = -ESRCH;
+	self->fd_tmpfs_detached = -1;
+	file = fopen("/proc/sys/kernel/core_pattern", "r");
+	ASSERT_NE(NULL, file);
+
+	ret = fread(self->original_core_pattern, 1, sizeof(self->original_core_pattern), file);
+	ASSERT_TRUE(ret || feof(file));
+	ASSERT_LT(ret, sizeof(self->original_core_pattern));
+
+	self->original_core_pattern[ret] = '\0';
+	self->fd_tmpfs_detached = create_detached_tmpfs();
+	ASSERT_GE(self->fd_tmpfs_detached, 0);
+
+	ret = fclose(file);
+	ASSERT_EQ(0, ret);
+}
+
+FIXTURE_TEARDOWN(coredump)
+{
+	const char *reason;
+	FILE *file;
+	int ret, status;
+
+	if (self->pid_coredump_server > 0) {
+		kill(self->pid_coredump_server, SIGTERM);
+		waitpid(self->pid_coredump_server, &status, 0);
+	}
+	unlink("/tmp/coredump.file");
+	unlink("/tmp/coredump.socket");
+
+	file = fopen("/proc/sys/kernel/core_pattern", "w");
+	if (!file) {
+		reason = "Unable to open core_pattern";
+		goto fail;
+	}
+
+	ret = fprintf(file, "%s", self->original_core_pattern);
+	if (ret < 0) {
+		reason = "Unable to write to core_pattern";
+		goto fail;
+	}
+
+	ret = fclose(file);
+	if (ret) {
+		reason = "Unable to close core_pattern";
+		goto fail;
+	}
+
+	if (self->fd_tmpfs_detached >= 0) {
+		ret = close(self->fd_tmpfs_detached);
+		if (ret < 0) {
+			reason = "Unable to close detached tmpfs";
+			goto fail;
+		}
+		self->fd_tmpfs_detached = -1;
+	}
+
+	return;
+fail:
+	/* This should never happen */
+	fprintf(stderr, "Failed to cleanup coredump test: %s\n", reason);
+}
+
+TEST_F(coredump, socket_request_kernel)
+{
+	int pidfd, ret, status;
+	pid_t pid, pid_coredump_server;
+	struct stat st;
+	struct pidfd_info info = {};
+	int ipc_sockets[2];
+	char c;
+
+	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
+
+	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		struct coredump_req req = {};
+		int fd_server = -1, fd_coredump = -1, fd_core_file = -1, fd_peer_pidfd = -1;
+		int exit_code = EXIT_FAILURE;
+
+		close(ipc_sockets[0]);
+
+		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
+		if (fd_server < 0)
+			goto out;
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+			goto out;
+
+		close(ipc_sockets[1]);
+
+		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
+		if (fd_coredump < 0)
+			goto out;
+
+		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
+		if (fd_peer_pidfd < 0)
+			goto out;
+
+		if (!get_pidfd_info(fd_peer_pidfd, &info))
+			goto out;
+
+		if (!(info.mask & PIDFD_INFO_COREDUMP))
+			goto out;
+
+		if (!(info.coredump_mask & PIDFD_COREDUMPED))
+			goto out;
+
+		fd_core_file = creat("/tmp/coredump.file", 0644);
+		if (fd_core_file < 0)
+			goto out;
+
+		if (!read_coredump_req(fd_coredump, &req))
+			goto out;
+
+		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
+					COREDUMP_KERNEL | COREDUMP_USERSPACE |
+					COREDUMP_REJECT | COREDUMP_WAIT))
+			goto out;
+
+		if (!send_coredump_ack(fd_coredump, &req,
+				       COREDUMP_KERNEL | COREDUMP_WAIT, 0))
+			goto out;
+
+		if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK))
+			goto out;
+
+		for (;;) {
+			char buffer[4096];
+			ssize_t bytes_read, bytes_write;
+
+			bytes_read = read(fd_coredump, buffer, sizeof(buffer));
+			if (bytes_read < 0)
+				goto out;
+
+			if (bytes_read == 0)
+				break;
+
+			bytes_write = write(fd_core_file, buffer, bytes_read);
+			if (bytes_read != bytes_write)
+				goto out;
+		}
+
+		exit_code = EXIT_SUCCESS;
+out:
+		if (fd_core_file >= 0)
+			close(fd_core_file);
+		if (fd_peer_pidfd >= 0)
+			close(fd_peer_pidfd);
+		if (fd_coredump >= 0)
+			close(fd_coredump);
+		if (fd_server >= 0)
+			close(fd_server);
+		_exit(exit_code);
+	}
+	self->pid_coredump_server = pid_coredump_server;
+
+	EXPECT_EQ(close(ipc_sockets[1]), 0);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	EXPECT_EQ(close(ipc_sockets[0]), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0)
+		crashing_child();
+
+	pidfd = sys_pidfd_open(pid, 0);
+	ASSERT_GE(pidfd, 0);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_TRUE(WCOREDUMP(status));
+
+	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
+	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
+	ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
+
+	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
+
+	ASSERT_EQ(stat("/tmp/coredump.file", &st), 0);
+	ASSERT_GT(st.st_size, 0);
+	system("file /tmp/coredump.file");
+}
+
+TEST_F(coredump, socket_request_userspace)
+{
+	int pidfd, ret, status;
+	pid_t pid, pid_coredump_server;
+	struct pidfd_info info = {};
+	int ipc_sockets[2];
+	char c;
+
+	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
+
+	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		struct coredump_req req = {};
+		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
+		int exit_code = EXIT_FAILURE;
+
+		close(ipc_sockets[0]);
+
+		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
+		if (fd_server < 0)
+			goto out;
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+			goto out;
+
+		close(ipc_sockets[1]);
+
+		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
+		if (fd_coredump < 0)
+			goto out;
+
+		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
+		if (fd_peer_pidfd < 0)
+			goto out;
+
+		if (!get_pidfd_info(fd_peer_pidfd, &info))
+			goto out;
+
+		if (!(info.mask & PIDFD_INFO_COREDUMP))
+			goto out;
+
+		if (!(info.coredump_mask & PIDFD_COREDUMPED))
+			goto out;
+
+		if (!read_coredump_req(fd_coredump, &req))
+			goto out;
+
+		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
+					COREDUMP_KERNEL | COREDUMP_USERSPACE |
+					COREDUMP_REJECT | COREDUMP_WAIT))
+			goto out;
+
+		if (!send_coredump_ack(fd_coredump, &req,
+				       COREDUMP_USERSPACE | COREDUMP_WAIT, 0))
+			goto out;
+
+		if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK))
+			goto out;
+
+		for (;;) {
+			char buffer[4096];
+			ssize_t bytes_read;
+
+			bytes_read = read(fd_coredump, buffer, sizeof(buffer));
+			if (bytes_read > 0)
+				goto out;
+
+			if (bytes_read < 0)
+				goto out;
+
+			if (bytes_read == 0)
+				break;
+		}
+
+		exit_code = EXIT_SUCCESS;
+out:
+		if (fd_peer_pidfd >= 0)
+			close(fd_peer_pidfd);
+		if (fd_coredump >= 0)
+			close(fd_coredump);
+		if (fd_server >= 0)
+			close(fd_server);
+		_exit(exit_code);
+	}
+	self->pid_coredump_server = pid_coredump_server;
+
+	EXPECT_EQ(close(ipc_sockets[1]), 0);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	EXPECT_EQ(close(ipc_sockets[0]), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0)
+		crashing_child();
+
+	pidfd = sys_pidfd_open(pid, 0);
+	ASSERT_GE(pidfd, 0);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_TRUE(WCOREDUMP(status));
+
+	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
+	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
+	ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
+
+	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
+}
+
+TEST_F(coredump, socket_request_reject)
+{
+	int pidfd, ret, status;
+	pid_t pid, pid_coredump_server;
+	struct pidfd_info info = {};
+	int ipc_sockets[2];
+	char c;
+
+	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
+
+	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		struct coredump_req req = {};
+		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
+		int exit_code = EXIT_FAILURE;
+
+		close(ipc_sockets[0]);
+
+		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
+		if (fd_server < 0)
+			goto out;
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+			goto out;
+
+		close(ipc_sockets[1]);
+
+		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
+		if (fd_coredump < 0)
+			goto out;
+
+		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
+		if (fd_peer_pidfd < 0)
+			goto out;
+
+		if (!get_pidfd_info(fd_peer_pidfd, &info))
+			goto out;
+
+		if (!(info.mask & PIDFD_INFO_COREDUMP))
+			goto out;
+
+		if (!(info.coredump_mask & PIDFD_COREDUMPED))
+			goto out;
+
+		if (!read_coredump_req(fd_coredump, &req))
+			goto out;
+
+		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
+					COREDUMP_KERNEL | COREDUMP_USERSPACE |
+					COREDUMP_REJECT | COREDUMP_WAIT))
+			goto out;
+
+		if (!send_coredump_ack(fd_coredump, &req,
+				       COREDUMP_REJECT | COREDUMP_WAIT, 0))
+			goto out;
+
+		if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK))
+			goto out;
+
+		for (;;) {
+			char buffer[4096];
+			ssize_t bytes_read;
+
+			bytes_read = read(fd_coredump, buffer, sizeof(buffer));
+			if (bytes_read > 0)
+				goto out;
+
+			if (bytes_read < 0)
+				goto out;
+
+			if (bytes_read == 0)
+				break;
+		}
+
+		exit_code = EXIT_SUCCESS;
+out:
+		if (fd_peer_pidfd >= 0)
+			close(fd_peer_pidfd);
+		if (fd_coredump >= 0)
+			close(fd_coredump);
+		if (fd_server >= 0)
+			close(fd_server);
+		_exit(exit_code);
+	}
+	self->pid_coredump_server = pid_coredump_server;
+
+	EXPECT_EQ(close(ipc_sockets[1]), 0);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	EXPECT_EQ(close(ipc_sockets[0]), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0)
+		crashing_child();
+
+	pidfd = sys_pidfd_open(pid, 0);
+	ASSERT_GE(pidfd, 0);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_FALSE(WCOREDUMP(status));
+
+	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
+	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
+	ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
+
+	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
+}
+
+TEST_F(coredump, socket_request_invalid_flag_combination)
+{
+	int pidfd, ret, status;
+	pid_t pid, pid_coredump_server;
+	struct pidfd_info info = {};
+	int ipc_sockets[2];
+	char c;
+
+	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
+
+	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		struct coredump_req req = {};
+		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
+		int exit_code = EXIT_FAILURE;
+
+		close(ipc_sockets[0]);
+
+		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
+		if (fd_server < 0)
+			goto out;
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+			goto out;
+
+		close(ipc_sockets[1]);
+
+		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
+		if (fd_coredump < 0)
+			goto out;
+
+		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
+		if (fd_peer_pidfd < 0)
+			goto out;
+
+		if (!get_pidfd_info(fd_peer_pidfd, &info))
+			goto out;
+
+		if (!(info.mask & PIDFD_INFO_COREDUMP))
+			goto out;
+
+		if (!(info.coredump_mask & PIDFD_COREDUMPED))
+			goto out;
+
+		if (!read_coredump_req(fd_coredump, &req))
+			goto out;
+
+		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
+					COREDUMP_KERNEL | COREDUMP_USERSPACE |
+					COREDUMP_REJECT | COREDUMP_WAIT))
+			goto out;
+
+		if (!send_coredump_ack(fd_coredump, &req,
+				       COREDUMP_KERNEL | COREDUMP_REJECT | COREDUMP_WAIT, 0))
+			goto out;
+
+		if (!read_marker(fd_coredump, COREDUMP_MARK_CONFLICTING))
+			goto out;
+
+		exit_code = EXIT_SUCCESS;
+out:
+		if (fd_peer_pidfd >= 0)
+			close(fd_peer_pidfd);
+		if (fd_coredump >= 0)
+			close(fd_coredump);
+		if (fd_server >= 0)
+			close(fd_server);
+		_exit(exit_code);
+	}
+	self->pid_coredump_server = pid_coredump_server;
+
+	EXPECT_EQ(close(ipc_sockets[1]), 0);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	EXPECT_EQ(close(ipc_sockets[0]), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0)
+		crashing_child();
+
+	pidfd = sys_pidfd_open(pid, 0);
+	ASSERT_GE(pidfd, 0);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_FALSE(WCOREDUMP(status));
+
+	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
+	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
+	ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
+
+	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
+}
+
+TEST_F(coredump, socket_request_unknown_flag)
+{
+	int pidfd, ret, status;
+	pid_t pid, pid_coredump_server;
+	struct pidfd_info info = {};
+	int ipc_sockets[2];
+	char c;
+
+	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
+
+	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		struct coredump_req req = {};
+		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
+		int exit_code = EXIT_FAILURE;
+
+		close(ipc_sockets[0]);
+
+		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
+		if (fd_server < 0)
+			goto out;
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+			goto out;
+
+		close(ipc_sockets[1]);
+
+		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
+		if (fd_coredump < 0)
+			goto out;
+
+		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
+		if (fd_peer_pidfd < 0)
+			goto out;
+
+		if (!get_pidfd_info(fd_peer_pidfd, &info))
+			goto out;
+
+		if (!(info.mask & PIDFD_INFO_COREDUMP))
+			goto out;
+
+		if (!(info.coredump_mask & PIDFD_COREDUMPED))
+			goto out;
+
+		if (!read_coredump_req(fd_coredump, &req))
+			goto out;
+
+		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
+					COREDUMP_KERNEL | COREDUMP_USERSPACE |
+					COREDUMP_REJECT | COREDUMP_WAIT))
+			goto out;
+
+		if (!send_coredump_ack(fd_coredump, &req, (1ULL << 63), 0))
+			goto out;
+
+		if (!read_marker(fd_coredump, COREDUMP_MARK_UNSUPPORTED))
+			goto out;
+
+		exit_code = EXIT_SUCCESS;
+out:
+		if (fd_peer_pidfd >= 0)
+			close(fd_peer_pidfd);
+		if (fd_coredump >= 0)
+			close(fd_coredump);
+		if (fd_server >= 0)
+			close(fd_server);
+		_exit(exit_code);
+	}
+	self->pid_coredump_server = pid_coredump_server;
+
+	EXPECT_EQ(close(ipc_sockets[1]), 0);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	EXPECT_EQ(close(ipc_sockets[0]), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0)
+		crashing_child();
+
+	pidfd = sys_pidfd_open(pid, 0);
+	ASSERT_GE(pidfd, 0);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_FALSE(WCOREDUMP(status));
+
+	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
+	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
+	ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
+
+	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
+}
+
+TEST_F(coredump, socket_request_invalid_size_small)
+{
+	int pidfd, ret, status;
+	pid_t pid, pid_coredump_server;
+	struct pidfd_info info = {};
+	int ipc_sockets[2];
+	char c;
+
+	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
+
+	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		struct coredump_req req = {};
+		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
+		int exit_code = EXIT_FAILURE;
+
+		close(ipc_sockets[0]);
+
+		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
+		if (fd_server < 0)
+			goto out;
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+			goto out;
+
+		close(ipc_sockets[1]);
+
+		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
+		if (fd_coredump < 0)
+			goto out;
+
+		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
+		if (fd_peer_pidfd < 0)
+			goto out;
+
+		if (!get_pidfd_info(fd_peer_pidfd, &info))
+			goto out;
+
+		if (!(info.mask & PIDFD_INFO_COREDUMP))
+			goto out;
+
+		if (!(info.coredump_mask & PIDFD_COREDUMPED))
+			goto out;
+
+		if (!read_coredump_req(fd_coredump, &req))
+			goto out;
+
+		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
+					COREDUMP_KERNEL | COREDUMP_USERSPACE |
+					COREDUMP_REJECT | COREDUMP_WAIT))
+			goto out;
+
+		if (!send_coredump_ack(fd_coredump, &req,
+				       COREDUMP_REJECT | COREDUMP_WAIT,
+				       COREDUMP_ACK_SIZE_VER0 / 2))
+			goto out;
+
+		if (!read_marker(fd_coredump, COREDUMP_MARK_MINSIZE))
+			goto out;
+
+		exit_code = EXIT_SUCCESS;
+out:
+		if (fd_peer_pidfd >= 0)
+			close(fd_peer_pidfd);
+		if (fd_coredump >= 0)
+			close(fd_coredump);
+		if (fd_server >= 0)
+			close(fd_server);
+		_exit(exit_code);
+	}
+	self->pid_coredump_server = pid_coredump_server;
+
+	EXPECT_EQ(close(ipc_sockets[1]), 0);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	EXPECT_EQ(close(ipc_sockets[0]), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0)
+		crashing_child();
+
+	pidfd = sys_pidfd_open(pid, 0);
+	ASSERT_GE(pidfd, 0);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_FALSE(WCOREDUMP(status));
+
+	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
+	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
+	ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
+
+	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
+}
+
+TEST_F(coredump, socket_request_invalid_size_large)
+{
+	int pidfd, ret, status;
+	pid_t pid, pid_coredump_server;
+	struct pidfd_info info = {};
+	int ipc_sockets[2];
+	char c;
+
+	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
+
+	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		struct coredump_req req = {};
+		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
+		int exit_code = EXIT_FAILURE;
+
+		close(ipc_sockets[0]);
+
+		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
+		if (fd_server < 0)
+			goto out;
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+			goto out;
+
+		close(ipc_sockets[1]);
+
+		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
+		if (fd_coredump < 0)
+			goto out;
+
+		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
+		if (fd_peer_pidfd < 0)
+			goto out;
+
+		if (!get_pidfd_info(fd_peer_pidfd, &info))
+			goto out;
+
+		if (!(info.mask & PIDFD_INFO_COREDUMP))
+			goto out;
+
+		if (!(info.coredump_mask & PIDFD_COREDUMPED))
+			goto out;
+
+		if (!read_coredump_req(fd_coredump, &req))
+			goto out;
+
+		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
+					COREDUMP_KERNEL | COREDUMP_USERSPACE |
+					COREDUMP_REJECT | COREDUMP_WAIT))
+			goto out;
+
+		if (!send_coredump_ack(fd_coredump, &req,
+				       COREDUMP_REJECT | COREDUMP_WAIT,
+				       COREDUMP_ACK_SIZE_VER0 + PAGE_SIZE))
+			goto out;
+
+		if (!read_marker(fd_coredump, COREDUMP_MARK_MAXSIZE))
+			goto out;
+
+		exit_code = EXIT_SUCCESS;
+out:
+		if (fd_peer_pidfd >= 0)
+			close(fd_peer_pidfd);
+		if (fd_coredump >= 0)
+			close(fd_coredump);
+		if (fd_server >= 0)
+			close(fd_server);
+		_exit(exit_code);
+	}
+	self->pid_coredump_server = pid_coredump_server;
+
+	EXPECT_EQ(close(ipc_sockets[1]), 0);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	EXPECT_EQ(close(ipc_sockets[0]), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0)
+		crashing_child();
+
+	pidfd = sys_pidfd_open(pid, 0);
+	ASSERT_GE(pidfd, 0);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_FALSE(WCOREDUMP(status));
+
+	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
+	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
+	ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
+
+	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
+}
+
+/*
+ * Test: PIDFD_INFO_COREDUMP_SIGNAL via socket coredump with SIGSEGV
+ *
+ * Verify that when using socket-based coredump protocol,
+ * the coredump_signal field is correctly exposed as SIGSEGV.
+ */
+TEST_F(coredump, socket_coredump_signal_sigsegv)
+{
+	int pidfd, ret, status;
+	pid_t pid, pid_coredump_server;
+	struct pidfd_info info = {};
+	int ipc_sockets[2];
+	char c;
+
+	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
+
+	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		struct coredump_req req = {};
+		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
+		int exit_code = EXIT_FAILURE;
+
+		close(ipc_sockets[0]);
+
+		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
+		if (fd_server < 0)
+			goto out;
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+			goto out;
+
+		close(ipc_sockets[1]);
+
+		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
+		if (fd_coredump < 0)
+			goto out;
+
+		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
+		if (fd_peer_pidfd < 0)
+			goto out;
+
+		if (!get_pidfd_info(fd_peer_pidfd, &info))
+			goto out;
+
+		if (!(info.mask & PIDFD_INFO_COREDUMP))
+			goto out;
+
+		if (!(info.coredump_mask & PIDFD_COREDUMPED))
+			goto out;
+
+		/* Verify coredump_signal is available and correct */
+		if (!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL))
+			goto out;
+
+		if (info.coredump_signal != SIGSEGV)
+			goto out;
+
+		if (!read_coredump_req(fd_coredump, &req))
+			goto out;
+
+		if (!send_coredump_ack(fd_coredump, &req,
+				       COREDUMP_REJECT | COREDUMP_WAIT, 0))
+			goto out;
+
+		if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK))
+			goto out;
+
+		exit_code = EXIT_SUCCESS;
+out:
+		if (fd_peer_pidfd >= 0)
+			close(fd_peer_pidfd);
+		if (fd_coredump >= 0)
+			close(fd_coredump);
+		if (fd_server >= 0)
+			close(fd_server);
+		_exit(exit_code);
+	}
+	self->pid_coredump_server = pid_coredump_server;
+
+	EXPECT_EQ(close(ipc_sockets[1]), 0);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	EXPECT_EQ(close(ipc_sockets[0]), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0)
+		crashing_child();
+
+	pidfd = sys_pidfd_open(pid, 0);
+	ASSERT_GE(pidfd, 0);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_EQ(WTERMSIG(status), SIGSEGV);
+
+	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP));
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL));
+	ASSERT_EQ(info.coredump_signal, SIGSEGV);
+
+	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
+}
+
+/*
+ * Test: PIDFD_INFO_COREDUMP_SIGNAL via socket coredump with SIGABRT
+ *
+ * Verify that when using socket-based coredump protocol,
+ * the coredump_signal field is correctly exposed as SIGABRT.
+ */
+TEST_F(coredump, socket_coredump_signal_sigabrt)
+{
+	int pidfd, ret, status;
+	pid_t pid, pid_coredump_server;
+	struct pidfd_info info = {};
+	int ipc_sockets[2];
+	char c;
+
+	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
+
+	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		struct coredump_req req = {};
+		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
+		int exit_code = EXIT_FAILURE;
+
+		close(ipc_sockets[0]);
+
+		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
+		if (fd_server < 0)
+			goto out;
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+			goto out;
+
+		close(ipc_sockets[1]);
+
+		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
+		if (fd_coredump < 0)
+			goto out;
+
+		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
+		if (fd_peer_pidfd < 0)
+			goto out;
+
+		if (!get_pidfd_info(fd_peer_pidfd, &info))
+			goto out;
+
+		if (!(info.mask & PIDFD_INFO_COREDUMP))
+			goto out;
+
+		if (!(info.coredump_mask & PIDFD_COREDUMPED))
+			goto out;
+
+		/* Verify coredump_signal is available and correct */
+		if (!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL))
+			goto out;
+
+		if (info.coredump_signal != SIGABRT)
+			goto out;
+
+		if (!read_coredump_req(fd_coredump, &req))
+			goto out;
+
+		if (!send_coredump_ack(fd_coredump, &req,
+				       COREDUMP_REJECT | COREDUMP_WAIT, 0))
+			goto out;
+
+		if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK))
+			goto out;
+
+		exit_code = EXIT_SUCCESS;
+out:
+		if (fd_peer_pidfd >= 0)
+			close(fd_peer_pidfd);
+		if (fd_coredump >= 0)
+			close(fd_coredump);
+		if (fd_server >= 0)
+			close(fd_server);
+		_exit(exit_code);
+	}
+	self->pid_coredump_server = pid_coredump_server;
+
+	EXPECT_EQ(close(ipc_sockets[1]), 0);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	EXPECT_EQ(close(ipc_sockets[0]), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0)
+		abort();
+
+	pidfd = sys_pidfd_open(pid, 0);
+	ASSERT_GE(pidfd, 0);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_EQ(WTERMSIG(status), SIGABRT);
+
+	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP));
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL));
+	ASSERT_EQ(info.coredump_signal, SIGABRT);
+
+	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
+}
+
+TEST_F_TIMEOUT(coredump, socket_multiple_crashing_coredumps, 500)
+{
+	int pidfd[NUM_CRASHING_COREDUMPS], status[NUM_CRASHING_COREDUMPS];
+	pid_t pid[NUM_CRASHING_COREDUMPS], pid_coredump_server;
+	struct pidfd_info info = {};
+	int ipc_sockets[2];
+	char c;
+
+	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets), 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1, fd_core_file = -1;
+		int exit_code = EXIT_FAILURE;
+		struct coredump_req req = {};
+
+		close(ipc_sockets[0]);
+		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
+		if (fd_server < 0) {
+			fprintf(stderr, "Failed to create and listen on unix socket\n");
+			goto out;
+		}
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
+			fprintf(stderr, "Failed to notify parent via ipc socket\n");
+			goto out;
+		}
+		close(ipc_sockets[1]);
+
+		for (int i = 0; i < NUM_CRASHING_COREDUMPS; i++) {
+			fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
+			if (fd_coredump < 0) {
+				fprintf(stderr, "accept4 failed: %m\n");
+				goto out;
+			}
+
+			fd_peer_pidfd = get_peer_pidfd(fd_coredump);
+			if (fd_peer_pidfd < 0) {
+				fprintf(stderr, "get_peer_pidfd failed for fd %d: %m\n", fd_coredump);
+				goto out;
+			}
+
+			if (!get_pidfd_info(fd_peer_pidfd, &info)) {
+				fprintf(stderr, "get_pidfd_info failed for fd %d\n", fd_peer_pidfd);
+				goto out;
+			}
+
+			if (!(info.mask & PIDFD_INFO_COREDUMP)) {
+				fprintf(stderr, "pidfd info missing PIDFD_INFO_COREDUMP for fd %d\n", fd_peer_pidfd);
+				goto out;
+			}
+			if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
+				fprintf(stderr, "pidfd info missing PIDFD_COREDUMPED for fd %d\n", fd_peer_pidfd);
+				goto out;
+			}
+
+			if (!read_coredump_req(fd_coredump, &req)) {
+				fprintf(stderr, "read_coredump_req failed for fd %d\n", fd_coredump);
+				goto out;
+			}
+
+			if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
+						COREDUMP_KERNEL | COREDUMP_USERSPACE |
+						COREDUMP_REJECT | COREDUMP_WAIT)) {
+				fprintf(stderr, "check_coredump_req failed for fd %d\n", fd_coredump);
+				goto out;
+			}
+
+			if (!send_coredump_ack(fd_coredump, &req,
+					       COREDUMP_KERNEL | COREDUMP_WAIT, 0)) {
+				fprintf(stderr, "send_coredump_ack failed for fd %d\n", fd_coredump);
+				goto out;
+			}
+
+			if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK)) {
+				fprintf(stderr, "read_marker failed for fd %d\n", fd_coredump);
+				goto out;
+			}
+
+			fd_core_file = open_coredump_tmpfile(self->fd_tmpfs_detached);
+			if (fd_core_file < 0) {
+				fprintf(stderr, "%m - open_coredump_tmpfile failed for fd %d\n", fd_coredump);
+				goto out;
+			}
+
+			for (;;) {
+				char buffer[4096];
+				ssize_t bytes_read, bytes_write;
+
+				bytes_read = read(fd_coredump, buffer, sizeof(buffer));
+				if (bytes_read < 0) {
+					fprintf(stderr, "read failed for fd %d: %m\n", fd_coredump);
+					goto out;
+				}
+
+				if (bytes_read == 0)
+					break;
+
+				bytes_write = write(fd_core_file, buffer, bytes_read);
+				if (bytes_read != bytes_write) {
+					fprintf(stderr, "write failed for fd %d: %m\n", fd_core_file);
+					goto out;
+				}
+			}
+
+			close(fd_core_file);
+			close(fd_peer_pidfd);
+			close(fd_coredump);
+			fd_peer_pidfd = -1;
+			fd_coredump = -1;
+		}
+
+		exit_code = EXIT_SUCCESS;
+out:
+		if (fd_core_file >= 0)
+			close(fd_core_file);
+		if (fd_peer_pidfd >= 0)
+			close(fd_peer_pidfd);
+		if (fd_coredump >= 0)
+			close(fd_coredump);
+		if (fd_server >= 0)
+			close(fd_server);
+		_exit(exit_code);
+	}
+	self->pid_coredump_server = pid_coredump_server;
+
+	EXPECT_EQ(close(ipc_sockets[1]), 0);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	EXPECT_EQ(close(ipc_sockets[0]), 0);
+
+	for (int i = 0; i < NUM_CRASHING_COREDUMPS; i++) {
+		pid[i] = fork();
+		ASSERT_GE(pid[i], 0);
+		if (pid[i] == 0)
+			crashing_child();
+		pidfd[i] = sys_pidfd_open(pid[i], 0);
+		ASSERT_GE(pidfd[i], 0);
+	}
+
+	for (int i = 0; i < NUM_CRASHING_COREDUMPS; i++) {
+		waitpid(pid[i], &status[i], 0);
+		ASSERT_TRUE(WIFSIGNALED(status[i]));
+		ASSERT_TRUE(WCOREDUMP(status[i]));
+	}
+
+	for (int i = 0; i < NUM_CRASHING_COREDUMPS; i++) {
+		info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
+		ASSERT_EQ(ioctl(pidfd[i], PIDFD_GET_INFO, &info), 0);
+		ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
+		ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
+	}
+
+	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
+}
+
+TEST_F_TIMEOUT(coredump, socket_multiple_crashing_coredumps_epoll_workers, 500)
+{
+	int pidfd[NUM_CRASHING_COREDUMPS], status[NUM_CRASHING_COREDUMPS];
+	pid_t pid[NUM_CRASHING_COREDUMPS], pid_coredump_server, worker_pids[NUM_CRASHING_COREDUMPS];
+	struct pidfd_info info = {};
+	int ipc_sockets[2];
+	char c;
+
+	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets), 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		int fd_server = -1, exit_code = EXIT_FAILURE, n_conns = 0;
+		fd_server = -1;
+		exit_code = EXIT_FAILURE;
+		n_conns = 0;
+		close(ipc_sockets[0]);
+		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
+		if (fd_server < 0)
+			goto out;
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+			goto out;
+		close(ipc_sockets[1]);
+
+		while (n_conns < NUM_CRASHING_COREDUMPS) {
+			int fd_coredump = -1, fd_peer_pidfd = -1, fd_core_file = -1;
+			struct coredump_req req = {};
+			fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
+			if (fd_coredump < 0) {
+				if (errno == EAGAIN || errno == EWOULDBLOCK)
+					continue;
+				goto out;
+			}
+			fd_peer_pidfd = get_peer_pidfd(fd_coredump);
+			if (fd_peer_pidfd < 0)
+				goto out;
+			if (!get_pidfd_info(fd_peer_pidfd, &info))
+				goto out;
+			if (!(info.mask & PIDFD_INFO_COREDUMP) || !(info.coredump_mask & PIDFD_COREDUMPED))
+				goto out;
+			if (!read_coredump_req(fd_coredump, &req))
+				goto out;
+			if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
+						COREDUMP_KERNEL | COREDUMP_USERSPACE |
+						COREDUMP_REJECT | COREDUMP_WAIT))
+				goto out;
+			if (!send_coredump_ack(fd_coredump, &req, COREDUMP_KERNEL | COREDUMP_WAIT, 0))
+				goto out;
+			if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK))
+				goto out;
+			fd_core_file = open_coredump_tmpfile(self->fd_tmpfs_detached);
+			if (fd_core_file < 0)
+				goto out;
+			pid_t worker = fork();
+			if (worker == 0) {
+				close(fd_server);
+				process_coredump_worker(fd_coredump, fd_peer_pidfd, fd_core_file);
+			}
+			worker_pids[n_conns] = worker;
+			if (fd_coredump >= 0)
+				close(fd_coredump);
+			if (fd_peer_pidfd >= 0)
+				close(fd_peer_pidfd);
+			if (fd_core_file >= 0)
+				close(fd_core_file);
+			n_conns++;
+		}
+		exit_code = EXIT_SUCCESS;
+out:
+		if (fd_server >= 0)
+			close(fd_server);
+
+		// Reap all worker processes
+		for (int i = 0; i < n_conns; i++) {
+			int wstatus;
+			if (waitpid(worker_pids[i], &wstatus, 0) < 0) {
+				fprintf(stderr, "Failed to wait for worker %d: %m\n", worker_pids[i]);
+			} else if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) != EXIT_SUCCESS) {
+				fprintf(stderr, "Worker %d exited with error code %d\n", worker_pids[i], WEXITSTATUS(wstatus));
+				exit_code = EXIT_FAILURE;
+			}
+		}
+
+		_exit(exit_code);
+	}
+	self->pid_coredump_server = pid_coredump_server;
+
+	EXPECT_EQ(close(ipc_sockets[1]), 0);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	EXPECT_EQ(close(ipc_sockets[0]), 0);
+
+	for (int i = 0; i < NUM_CRASHING_COREDUMPS; i++) {
+		pid[i] = fork();
+		ASSERT_GE(pid[i], 0);
+		if (pid[i] == 0)
+			crashing_child();
+		pidfd[i] = sys_pidfd_open(pid[i], 0);
+		ASSERT_GE(pidfd[i], 0);
+	}
+
+	for (int i = 0; i < NUM_CRASHING_COREDUMPS; i++) {
+		ASSERT_GE(waitpid(pid[i], &status[i], 0), 0);
+		ASSERT_TRUE(WIFSIGNALED(status[i]));
+		ASSERT_TRUE(WCOREDUMP(status[i]));
+	}
+
+	for (int i = 0; i < NUM_CRASHING_COREDUMPS; i++) {
+		info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
+		ASSERT_EQ(ioctl(pidfd[i], PIDFD_GET_INFO, &info), 0);
+		ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
+		ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
+	}
+
+	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/coredump/coredump_socket_test.c b/tools/testing/selftests/coredump/coredump_socket_test.c
new file mode 100644
index 000000000000..d5ad0e696ab3
--- /dev/null
+++ b/tools/testing/selftests/coredump/coredump_socket_test.c
@@ -0,0 +1,394 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <sys/stat.h>
+#include <sys/epoll.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include "coredump_test.h"
+
+FIXTURE_SETUP(coredump)
+{
+	FILE *file;
+	int ret;
+
+	self->pid_coredump_server = -ESRCH;
+	self->fd_tmpfs_detached = -1;
+	file = fopen("/proc/sys/kernel/core_pattern", "r");
+	ASSERT_NE(NULL, file);
+
+	ret = fread(self->original_core_pattern, 1, sizeof(self->original_core_pattern), file);
+	ASSERT_TRUE(ret || feof(file));
+	ASSERT_LT(ret, sizeof(self->original_core_pattern));
+
+	self->original_core_pattern[ret] = '\0';
+	self->fd_tmpfs_detached = create_detached_tmpfs();
+	ASSERT_GE(self->fd_tmpfs_detached, 0);
+
+	ret = fclose(file);
+	ASSERT_EQ(0, ret);
+}
+
+FIXTURE_TEARDOWN(coredump)
+{
+	const char *reason;
+	FILE *file;
+	int ret, status;
+
+	if (self->pid_coredump_server > 0) {
+		kill(self->pid_coredump_server, SIGTERM);
+		waitpid(self->pid_coredump_server, &status, 0);
+	}
+	unlink("/tmp/coredump.file");
+	unlink("/tmp/coredump.socket");
+
+	file = fopen("/proc/sys/kernel/core_pattern", "w");
+	if (!file) {
+		reason = "Unable to open core_pattern";
+		goto fail;
+	}
+
+	ret = fprintf(file, "%s", self->original_core_pattern);
+	if (ret < 0) {
+		reason = "Unable to write to core_pattern";
+		goto fail;
+	}
+
+	ret = fclose(file);
+	if (ret) {
+		reason = "Unable to close core_pattern";
+		goto fail;
+	}
+
+	if (self->fd_tmpfs_detached >= 0) {
+		ret = close(self->fd_tmpfs_detached);
+		if (ret < 0) {
+			reason = "Unable to close detached tmpfs";
+			goto fail;
+		}
+		self->fd_tmpfs_detached = -1;
+	}
+
+	return;
+fail:
+	/* This should never happen */
+	fprintf(stderr, "Failed to cleanup coredump test: %s\n", reason);
+}
+
+TEST_F(coredump, socket)
+{
+	int pidfd, ret, status;
+	pid_t pid, pid_coredump_server;
+	struct stat st;
+	struct pidfd_info info = {};
+	int ipc_sockets[2];
+	char c;
+
+	ASSERT_TRUE(set_core_pattern("@/tmp/coredump.socket"));
+
+	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1, fd_core_file = -1;
+		int exit_code = EXIT_FAILURE;
+
+		close(ipc_sockets[0]);
+
+		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
+		if (fd_server < 0)
+			goto out;
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+			goto out;
+
+		close(ipc_sockets[1]);
+
+		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
+		if (fd_coredump < 0)
+			goto out;
+
+		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
+		if (fd_peer_pidfd < 0)
+			goto out;
+
+		if (!get_pidfd_info(fd_peer_pidfd, &info))
+			goto out;
+
+		if (!(info.mask & PIDFD_INFO_COREDUMP))
+			goto out;
+
+		if (!(info.coredump_mask & PIDFD_COREDUMPED))
+			goto out;
+
+		fd_core_file = creat("/tmp/coredump.file", 0644);
+		if (fd_core_file < 0)
+			goto out;
+
+		for (;;) {
+			char buffer[4096];
+			ssize_t bytes_read, bytes_write;
+
+			bytes_read = read(fd_coredump, buffer, sizeof(buffer));
+			if (bytes_read < 0)
+				goto out;
+
+			if (bytes_read == 0)
+				break;
+
+			bytes_write = write(fd_core_file, buffer, bytes_read);
+			if (bytes_read != bytes_write)
+				goto out;
+		}
+
+		exit_code = EXIT_SUCCESS;
+out:
+		if (fd_core_file >= 0)
+			close(fd_core_file);
+		if (fd_peer_pidfd >= 0)
+			close(fd_peer_pidfd);
+		if (fd_coredump >= 0)
+			close(fd_coredump);
+		if (fd_server >= 0)
+			close(fd_server);
+		_exit(exit_code);
+	}
+	self->pid_coredump_server = pid_coredump_server;
+
+	EXPECT_EQ(close(ipc_sockets[1]), 0);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	EXPECT_EQ(close(ipc_sockets[0]), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0)
+		crashing_child();
+
+	pidfd = sys_pidfd_open(pid, 0);
+	ASSERT_GE(pidfd, 0);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_TRUE(WCOREDUMP(status));
+
+	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
+	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
+	ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
+
+	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
+
+	ASSERT_EQ(stat("/tmp/coredump.file", &st), 0);
+	ASSERT_GT(st.st_size, 0);
+}
+
+TEST_F(coredump, socket_detect_userspace_client)
+{
+	int pidfd, ret, status;
+	pid_t pid, pid_coredump_server;
+	struct stat st;
+	struct pidfd_info info = {};
+	int ipc_sockets[2];
+	char c;
+
+	ASSERT_TRUE(set_core_pattern("@/tmp/coredump.socket"));
+
+	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
+		int exit_code = EXIT_FAILURE;
+
+		close(ipc_sockets[0]);
+
+		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
+		if (fd_server < 0)
+			goto out;
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+			goto out;
+
+		close(ipc_sockets[1]);
+
+		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
+		if (fd_coredump < 0)
+			goto out;
+
+		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
+		if (fd_peer_pidfd < 0)
+			goto out;
+
+		if (!get_pidfd_info(fd_peer_pidfd, &info))
+			goto out;
+
+		if (!(info.mask & PIDFD_INFO_COREDUMP))
+			goto out;
+
+		if (info.coredump_mask & PIDFD_COREDUMPED)
+			goto out;
+
+		exit_code = EXIT_SUCCESS;
+out:
+		if (fd_peer_pidfd >= 0)
+			close(fd_peer_pidfd);
+		if (fd_coredump >= 0)
+			close(fd_coredump);
+		if (fd_server >= 0)
+			close(fd_server);
+		_exit(exit_code);
+	}
+	self->pid_coredump_server = pid_coredump_server;
+
+	EXPECT_EQ(close(ipc_sockets[1]), 0);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	EXPECT_EQ(close(ipc_sockets[0]), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		int fd_socket;
+		ssize_t ret;
+		const struct sockaddr_un coredump_sk = {
+			.sun_family = AF_UNIX,
+			.sun_path = "/tmp/coredump.socket",
+		};
+		size_t coredump_sk_len =
+			offsetof(struct sockaddr_un, sun_path) +
+			sizeof("/tmp/coredump.socket");
+
+		fd_socket = socket(AF_UNIX, SOCK_STREAM, 0);
+		if (fd_socket < 0)
+			_exit(EXIT_FAILURE);
+
+		ret = connect(fd_socket, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
+		if (ret < 0)
+			_exit(EXIT_FAILURE);
+
+		close(fd_socket);
+		_exit(EXIT_SUCCESS);
+	}
+
+	pidfd = sys_pidfd_open(pid, 0);
+	ASSERT_GE(pidfd, 0);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
+	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
+	ASSERT_EQ((info.coredump_mask & PIDFD_COREDUMPED), 0);
+
+	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
+
+	ASSERT_NE(stat("/tmp/coredump.file", &st), 0);
+	ASSERT_EQ(errno, ENOENT);
+}
+
+TEST_F(coredump, socket_enoent)
+{
+	int pidfd, status;
+	pid_t pid;
+
+	ASSERT_TRUE(set_core_pattern("@/tmp/coredump.socket"));
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0)
+		crashing_child();
+
+	pidfd = sys_pidfd_open(pid, 0);
+	ASSERT_GE(pidfd, 0);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_FALSE(WCOREDUMP(status));
+}
+
+TEST_F(coredump, socket_no_listener)
+{
+	int pidfd, ret, status;
+	pid_t pid, pid_coredump_server;
+	int ipc_sockets[2];
+	char c;
+	const struct sockaddr_un coredump_sk = {
+		.sun_family = AF_UNIX,
+		.sun_path = "/tmp/coredump.socket",
+	};
+	size_t coredump_sk_len = offsetof(struct sockaddr_un, sun_path) +
+				 sizeof("/tmp/coredump.socket");
+
+	ASSERT_TRUE(set_core_pattern("@/tmp/coredump.socket"));
+
+	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		int fd_server = -1;
+		int exit_code = EXIT_FAILURE;
+
+		close(ipc_sockets[0]);
+
+		fd_server = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+		if (fd_server < 0)
+			goto out;
+
+		ret = bind(fd_server, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
+		if (ret < 0)
+			goto out;
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+			goto out;
+
+		exit_code = EXIT_SUCCESS;
+out:
+		if (fd_server >= 0)
+			close(fd_server);
+		close(ipc_sockets[1]);
+		_exit(exit_code);
+	}
+	self->pid_coredump_server = pid_coredump_server;
+
+	EXPECT_EQ(close(ipc_sockets[1]), 0);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	EXPECT_EQ(close(ipc_sockets[0]), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0)
+		crashing_child();
+
+	pidfd = sys_pidfd_open(pid, 0);
+	ASSERT_GE(pidfd, 0);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_FALSE(WCOREDUMP(status));
+
+	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
+}
+
+TEST_F(coredump, socket_invalid_paths)
+{
+	ASSERT_FALSE(set_core_pattern("@ /tmp/coredump.socket"));
+	ASSERT_FALSE(set_core_pattern("@/tmp/../coredump.socket"));
+	ASSERT_FALSE(set_core_pattern("@../coredump.socket"));
+	ASSERT_FALSE(set_core_pattern("@/tmp/coredump.socket/.."));
+	ASSERT_FALSE(set_core_pattern("@.."));
+
+	ASSERT_FALSE(set_core_pattern("@@ /tmp/coredump.socket"));
+	ASSERT_FALSE(set_core_pattern("@@/tmp/../coredump.socket"));
+	ASSERT_FALSE(set_core_pattern("@@../coredump.socket"));
+	ASSERT_FALSE(set_core_pattern("@@/tmp/coredump.socket/.."));
+	ASSERT_FALSE(set_core_pattern("@@.."));
+
+	ASSERT_FALSE(set_core_pattern("@@@/tmp/coredump.socket"));
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/testing/selftests/coredump/stackdump_test.c
index a4ac80bb1003..c2e895bcc160 100644
--- a/tools/testing/selftests/coredump/stackdump_test.c
+++ b/tools/testing/selftests/coredump/stackdump_test.c
@@ -23,57 +23,15 @@
 #include "../filesystems/wrappers.h"
 #include "../pidfd/pidfd.h"
 
+#include "coredump_test.h"
+
 #define STACKDUMP_FILE "stack_values"
 #define STACKDUMP_SCRIPT "stackdump"
-#define NUM_THREAD_SPAWN 128
 
 #ifndef PAGE_SIZE
 #define PAGE_SIZE 4096
 #endif
 
-static void *do_nothing(void *)
-{
-	while (1)
-		pause();
-
-	return NULL;
-}
-
-static void crashing_child(void)
-{
-	pthread_t thread;
-	int i;
-
-	for (i = 0; i < NUM_THREAD_SPAWN; ++i)
-		pthread_create(&thread, NULL, do_nothing, NULL);
-
-	/* crash on purpose */
-	i = *(int *)NULL;
-}
-
-FIXTURE(coredump)
-{
-	char original_core_pattern[256];
-	pid_t pid_coredump_server;
-	int fd_tmpfs_detached;
-};
-
-static int create_detached_tmpfs(void)
-{
-	int fd_context, fd_tmpfs;
-
-	fd_context = sys_fsopen("tmpfs", 0);
-	if (fd_context < 0)
-		return -1;
-
-	if (sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0) < 0)
-		return -1;
-
-	fd_tmpfs = sys_fsmount(fd_context, 0, 0);
-	close(fd_context);
-	return fd_tmpfs;
-}
-
 FIXTURE_SETUP(coredump)
 {
 	FILE *file;
@@ -208,1620 +166,4 @@ TEST_F_TIMEOUT(coredump, stackdump, 120)
 	fclose(file);
 }
 
-static int create_and_listen_unix_socket(const char *path)
-{
-	struct sockaddr_un addr = {
-		.sun_family = AF_UNIX,
-	};
-	assert(strlen(path) < sizeof(addr.sun_path) - 1);
-	strncpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
-	size_t addr_len =
-		offsetof(struct sockaddr_un, sun_path) + strlen(path) + 1;
-	int fd, ret;
-
-	fd = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
-	if (fd < 0)
-		goto out;
-
-	ret = bind(fd, (const struct sockaddr *)&addr, addr_len);
-	if (ret < 0)
-		goto out;
-
-	ret = listen(fd, 128);
-	if (ret < 0)
-		goto out;
-
-	return fd;
-
-out:
-	if (fd >= 0)
-		close(fd);
-	return -1;
-}
-
-static bool set_core_pattern(const char *pattern)
-{
-	int fd;
-	ssize_t ret;
-
-	fd = open("/proc/sys/kernel/core_pattern", O_WRONLY | O_CLOEXEC);
-	if (fd < 0)
-		return false;
-
-	ret = write(fd, pattern, strlen(pattern));
-	close(fd);
-	if (ret < 0)
-		return false;
-
-	fprintf(stderr, "Set core_pattern to '%s' | %zu == %zu\n", pattern, ret, strlen(pattern));
-	return ret == strlen(pattern);
-}
-
-static int get_peer_pidfd(int fd)
-{
-	int fd_peer_pidfd;
-	socklen_t fd_peer_pidfd_len = sizeof(fd_peer_pidfd);
-	int ret = getsockopt(fd, SOL_SOCKET, SO_PEERPIDFD, &fd_peer_pidfd,
-			     &fd_peer_pidfd_len);
-	if (ret < 0) {
-		fprintf(stderr, "%m - Failed to retrieve peer pidfd for coredump socket connection\n");
-		return -1;
-	}
-	return fd_peer_pidfd;
-}
-
-static bool get_pidfd_info(int fd_peer_pidfd, struct pidfd_info *info)
-{
-	memset(info, 0, sizeof(*info));
-	info->mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
-	return ioctl(fd_peer_pidfd, PIDFD_GET_INFO, info) == 0;
-}
-
-static void
-wait_and_check_coredump_server(pid_t pid_coredump_server,
-			       struct __test_metadata *const _metadata,
-			       FIXTURE_DATA(coredump)* self)
-{
-	int status;
-	waitpid(pid_coredump_server, &status, 0);
-	self->pid_coredump_server = -ESRCH;
-	ASSERT_TRUE(WIFEXITED(status));
-	ASSERT_EQ(WEXITSTATUS(status), 0);
-}
-
-TEST_F(coredump, socket)
-{
-	int pidfd, ret, status;
-	pid_t pid, pid_coredump_server;
-	struct stat st;
-	struct pidfd_info info = {};
-	int ipc_sockets[2];
-	char c;
-
-	ASSERT_TRUE(set_core_pattern("@/tmp/coredump.socket"));
-
-	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
-	ASSERT_EQ(ret, 0);
-
-	pid_coredump_server = fork();
-	ASSERT_GE(pid_coredump_server, 0);
-	if (pid_coredump_server == 0) {
-		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1, fd_core_file = -1;
-		int exit_code = EXIT_FAILURE;
-
-		close(ipc_sockets[0]);
-
-		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0)
-			goto out;
-
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
-			goto out;
-
-		close(ipc_sockets[1]);
-
-		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0)
-			goto out;
-
-		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0)
-			goto out;
-
-		if (!get_pidfd_info(fd_peer_pidfd, &info))
-			goto out;
-
-		if (!(info.mask & PIDFD_INFO_COREDUMP))
-			goto out;
-
-		if (!(info.coredump_mask & PIDFD_COREDUMPED))
-			goto out;
-
-		fd_core_file = creat("/tmp/coredump.file", 0644);
-		if (fd_core_file < 0)
-			goto out;
-
-		for (;;) {
-			char buffer[4096];
-			ssize_t bytes_read, bytes_write;
-
-			bytes_read = read(fd_coredump, buffer, sizeof(buffer));
-			if (bytes_read < 0)
-				goto out;
-
-			if (bytes_read == 0)
-				break;
-
-			bytes_write = write(fd_core_file, buffer, bytes_read);
-			if (bytes_read != bytes_write)
-				goto out;
-		}
-
-		exit_code = EXIT_SUCCESS;
-out:
-		if (fd_core_file >= 0)
-			close(fd_core_file);
-		if (fd_peer_pidfd >= 0)
-			close(fd_peer_pidfd);
-		if (fd_coredump >= 0)
-			close(fd_coredump);
-		if (fd_server >= 0)
-			close(fd_server);
-		_exit(exit_code);
-	}
-	self->pid_coredump_server = pid_coredump_server;
-
-	EXPECT_EQ(close(ipc_sockets[1]), 0);
-	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
-	EXPECT_EQ(close(ipc_sockets[0]), 0);
-
-	pid = fork();
-	ASSERT_GE(pid, 0);
-	if (pid == 0)
-		crashing_child();
-
-	pidfd = sys_pidfd_open(pid, 0);
-	ASSERT_GE(pidfd, 0);
-
-	waitpid(pid, &status, 0);
-	ASSERT_TRUE(WIFSIGNALED(status));
-	ASSERT_TRUE(WCOREDUMP(status));
-
-	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
-	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
-	ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
-
-	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
-
-	ASSERT_EQ(stat("/tmp/coredump.file", &st), 0);
-	ASSERT_GT(st.st_size, 0);
-	system("file /tmp/coredump.file");
-}
-
-TEST_F(coredump, socket_detect_userspace_client)
-{
-	int pidfd, ret, status;
-	pid_t pid, pid_coredump_server;
-	struct stat st;
-	struct pidfd_info info = {};
-	int ipc_sockets[2];
-	char c;
-
-	ASSERT_TRUE(set_core_pattern("@/tmp/coredump.socket"));
-
-	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
-	ASSERT_EQ(ret, 0);
-
-	pid_coredump_server = fork();
-	ASSERT_GE(pid_coredump_server, 0);
-	if (pid_coredump_server == 0) {
-		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
-		int exit_code = EXIT_FAILURE;
-
-		close(ipc_sockets[0]);
-
-		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0)
-			goto out;
-
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
-			goto out;
-
-		close(ipc_sockets[1]);
-
-		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0)
-			goto out;
-
-		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0)
-			goto out;
-
-		if (!get_pidfd_info(fd_peer_pidfd, &info))
-			goto out;
-
-		if (!(info.mask & PIDFD_INFO_COREDUMP))
-			goto out;
-
-		if (info.coredump_mask & PIDFD_COREDUMPED)
-			goto out;
-
-		exit_code = EXIT_SUCCESS;
-out:
-		if (fd_peer_pidfd >= 0)
-			close(fd_peer_pidfd);
-		if (fd_coredump >= 0)
-			close(fd_coredump);
-		if (fd_server >= 0)
-			close(fd_server);
-		_exit(exit_code);
-	}
-	self->pid_coredump_server = pid_coredump_server;
-
-	EXPECT_EQ(close(ipc_sockets[1]), 0);
-	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
-	EXPECT_EQ(close(ipc_sockets[0]), 0);
-
-	pid = fork();
-	ASSERT_GE(pid, 0);
-	if (pid == 0) {
-		int fd_socket;
-		ssize_t ret;
-		const struct sockaddr_un coredump_sk = {
-			.sun_family = AF_UNIX,
-			.sun_path = "/tmp/coredump.socket",
-		};
-		size_t coredump_sk_len =
-			offsetof(struct sockaddr_un, sun_path) +
-			sizeof("/tmp/coredump.socket");
-
-		fd_socket = socket(AF_UNIX, SOCK_STREAM, 0);
-		if (fd_socket < 0)
-			_exit(EXIT_FAILURE);
-
-		ret = connect(fd_socket, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
-		if (ret < 0)
-			_exit(EXIT_FAILURE);
-
-		close(fd_socket);
-		_exit(EXIT_SUCCESS);
-	}
-
-	pidfd = sys_pidfd_open(pid, 0);
-	ASSERT_GE(pidfd, 0);
-
-	waitpid(pid, &status, 0);
-	ASSERT_TRUE(WIFEXITED(status));
-	ASSERT_EQ(WEXITSTATUS(status), 0);
-
-	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
-	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
-	ASSERT_EQ((info.coredump_mask & PIDFD_COREDUMPED), 0);
-
-	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
-
-	ASSERT_NE(stat("/tmp/coredump.file", &st), 0);
-	ASSERT_EQ(errno, ENOENT);
-}
-
-TEST_F(coredump, socket_enoent)
-{
-	int pidfd, status;
-	pid_t pid;
-
-	ASSERT_TRUE(set_core_pattern("@/tmp/coredump.socket"));
-
-	pid = fork();
-	ASSERT_GE(pid, 0);
-	if (pid == 0)
-		crashing_child();
-
-	pidfd = sys_pidfd_open(pid, 0);
-	ASSERT_GE(pidfd, 0);
-
-	waitpid(pid, &status, 0);
-	ASSERT_TRUE(WIFSIGNALED(status));
-	ASSERT_FALSE(WCOREDUMP(status));
-}
-
-TEST_F(coredump, socket_no_listener)
-{
-	int pidfd, ret, status;
-	pid_t pid, pid_coredump_server;
-	int ipc_sockets[2];
-	char c;
-	const struct sockaddr_un coredump_sk = {
-		.sun_family = AF_UNIX,
-		.sun_path = "/tmp/coredump.socket",
-	};
-	size_t coredump_sk_len = offsetof(struct sockaddr_un, sun_path) +
-				 sizeof("/tmp/coredump.socket");
-
-	ASSERT_TRUE(set_core_pattern("@/tmp/coredump.socket"));
-
-	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
-	ASSERT_EQ(ret, 0);
-
-	pid_coredump_server = fork();
-	ASSERT_GE(pid_coredump_server, 0);
-	if (pid_coredump_server == 0) {
-		int fd_server = -1;
-		int exit_code = EXIT_FAILURE;
-
-		close(ipc_sockets[0]);
-
-		fd_server = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
-		if (fd_server < 0)
-			goto out;
-
-		ret = bind(fd_server, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
-		if (ret < 0)
-			goto out;
-
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
-			goto out;
-
-		exit_code = EXIT_SUCCESS;
-out:
-		if (fd_server >= 0)
-			close(fd_server);
-		close(ipc_sockets[1]);
-		_exit(exit_code);
-	}
-	self->pid_coredump_server = pid_coredump_server;
-
-	EXPECT_EQ(close(ipc_sockets[1]), 0);
-	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
-	EXPECT_EQ(close(ipc_sockets[0]), 0);
-
-	pid = fork();
-	ASSERT_GE(pid, 0);
-	if (pid == 0)
-		crashing_child();
-
-	pidfd = sys_pidfd_open(pid, 0);
-	ASSERT_GE(pidfd, 0);
-
-	waitpid(pid, &status, 0);
-	ASSERT_TRUE(WIFSIGNALED(status));
-	ASSERT_FALSE(WCOREDUMP(status));
-
-	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
-}
-
-static ssize_t recv_marker(int fd)
-{
-	enum coredump_mark mark = COREDUMP_MARK_REQACK;
-	ssize_t ret;
-
-	ret = recv(fd, &mark, sizeof(mark), MSG_WAITALL);
-	if (ret != sizeof(mark))
-		return -1;
-
-	switch (mark) {
-	case COREDUMP_MARK_REQACK:
-		fprintf(stderr, "Received marker: ReqAck\n");
-		return COREDUMP_MARK_REQACK;
-	case COREDUMP_MARK_MINSIZE:
-		fprintf(stderr, "Received marker: MinSize\n");
-		return COREDUMP_MARK_MINSIZE;
-	case COREDUMP_MARK_MAXSIZE:
-		fprintf(stderr, "Received marker: MaxSize\n");
-		return COREDUMP_MARK_MAXSIZE;
-	case COREDUMP_MARK_UNSUPPORTED:
-		fprintf(stderr, "Received marker: Unsupported\n");
-		return COREDUMP_MARK_UNSUPPORTED;
-	case COREDUMP_MARK_CONFLICTING:
-		fprintf(stderr, "Received marker: Conflicting\n");
-		return COREDUMP_MARK_CONFLICTING;
-	default:
-		fprintf(stderr, "Received unknown marker: %u\n", mark);
-		break;
-	}
-	return -1;
-}
-
-static bool read_marker(int fd, enum coredump_mark mark)
-{
-	ssize_t ret;
-
-	ret = recv_marker(fd);
-	if (ret < 0)
-		return false;
-	return ret == mark;
-}
-
-static bool read_coredump_req(int fd, struct coredump_req *req)
-{
-	ssize_t ret;
-	size_t field_size, user_size, ack_size, kernel_size, remaining_size;
-
-	memset(req, 0, sizeof(*req));
-	field_size = sizeof(req->size);
-
-	/* Peek the size of the coredump request. */
-	ret = recv(fd, req, field_size, MSG_PEEK | MSG_WAITALL);
-	if (ret != field_size)
-		return false;
-	kernel_size = req->size;
-
-	if (kernel_size < COREDUMP_ACK_SIZE_VER0)
-		return false;
-	if (kernel_size >= PAGE_SIZE)
-		return false;
-
-	/* Use the minimum of user and kernel size to read the full request. */
-	user_size = sizeof(struct coredump_req);
-	ack_size = user_size < kernel_size ? user_size : kernel_size;
-	ret = recv(fd, req, ack_size, MSG_WAITALL);
-	if (ret != ack_size)
-		return false;
-
-	fprintf(stderr, "Read coredump request with size %u and mask 0x%llx\n",
-		req->size, (unsigned long long)req->mask);
-
-	if (user_size > kernel_size)
-		remaining_size = user_size - kernel_size;
-	else
-		remaining_size = kernel_size - user_size;
-
-	if (PAGE_SIZE <= remaining_size)
-		return false;
-
-	/*
-	 * Discard any additional data if the kernel's request was larger than
-	 * what we knew about or cared about.
-	 */
-	if (remaining_size) {
-		char buffer[PAGE_SIZE];
-
-		ret = recv(fd, buffer, sizeof(buffer), MSG_WAITALL);
-		if (ret != remaining_size)
-			return false;
-		fprintf(stderr, "Discarded %zu bytes of data after coredump request\n", remaining_size);
-	}
-
-	return true;
-}
-
-static bool send_coredump_ack(int fd, const struct coredump_req *req,
-			      __u64 mask, size_t size_ack)
-{
-	ssize_t ret;
-	/*
-	 * Wrap struct coredump_ack in a larger struct so we can
-	 * simulate sending to much data to the kernel.
-	 */
-	struct large_ack_for_size_testing {
-		struct coredump_ack ack;
-		char buffer[PAGE_SIZE];
-	} large_ack = {};
-
-	if (!size_ack)
-		size_ack = sizeof(struct coredump_ack) < req->size_ack ?
-				   sizeof(struct coredump_ack) :
-				   req->size_ack;
-	large_ack.ack.mask = mask;
-	large_ack.ack.size = size_ack;
-	ret = send(fd, &large_ack, size_ack, MSG_NOSIGNAL);
-	if (ret != size_ack)
-		return false;
-
-	fprintf(stderr, "Sent coredump ack with size %zu and mask 0x%llx\n",
-		size_ack, (unsigned long long)mask);
-	return true;
-}
-
-static bool check_coredump_req(const struct coredump_req *req, size_t min_size,
-			       __u64 required_mask)
-{
-	if (req->size < min_size)
-		return false;
-	if ((req->mask & required_mask) != required_mask)
-		return false;
-	if (req->mask & ~required_mask)
-		return false;
-	return true;
-}
-
-TEST_F(coredump, socket_request_kernel)
-{
-	int pidfd, ret, status;
-	pid_t pid, pid_coredump_server;
-	struct stat st;
-	struct pidfd_info info = {};
-	int ipc_sockets[2];
-	char c;
-
-	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
-
-	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
-	ASSERT_EQ(ret, 0);
-
-	pid_coredump_server = fork();
-	ASSERT_GE(pid_coredump_server, 0);
-	if (pid_coredump_server == 0) {
-		struct coredump_req req = {};
-		int fd_server = -1, fd_coredump = -1, fd_core_file = -1, fd_peer_pidfd = -1;
-		int exit_code = EXIT_FAILURE;
-
-		close(ipc_sockets[0]);
-
-		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0)
-			goto out;
-
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
-			goto out;
-
-		close(ipc_sockets[1]);
-
-		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0)
-			goto out;
-
-		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0)
-			goto out;
-
-		if (!get_pidfd_info(fd_peer_pidfd, &info))
-			goto out;
-
-		if (!(info.mask & PIDFD_INFO_COREDUMP))
-			goto out;
-
-		if (!(info.coredump_mask & PIDFD_COREDUMPED))
-			goto out;
-
-		fd_core_file = creat("/tmp/coredump.file", 0644);
-		if (fd_core_file < 0)
-			goto out;
-
-		if (!read_coredump_req(fd_coredump, &req))
-			goto out;
-
-		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT))
-			goto out;
-
-		if (!send_coredump_ack(fd_coredump, &req,
-				       COREDUMP_KERNEL | COREDUMP_WAIT, 0))
-			goto out;
-
-		if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK))
-			goto out;
-
-		for (;;) {
-			char buffer[4096];
-			ssize_t bytes_read, bytes_write;
-
-			bytes_read = read(fd_coredump, buffer, sizeof(buffer));
-			if (bytes_read < 0)
-				goto out;
-
-			if (bytes_read == 0)
-				break;
-
-			bytes_write = write(fd_core_file, buffer, bytes_read);
-			if (bytes_read != bytes_write)
-				goto out;
-		}
-
-		exit_code = EXIT_SUCCESS;
-out:
-		if (fd_core_file >= 0)
-			close(fd_core_file);
-		if (fd_peer_pidfd >= 0)
-			close(fd_peer_pidfd);
-		if (fd_coredump >= 0)
-			close(fd_coredump);
-		if (fd_server >= 0)
-			close(fd_server);
-		_exit(exit_code);
-	}
-	self->pid_coredump_server = pid_coredump_server;
-
-	EXPECT_EQ(close(ipc_sockets[1]), 0);
-	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
-	EXPECT_EQ(close(ipc_sockets[0]), 0);
-
-	pid = fork();
-	ASSERT_GE(pid, 0);
-	if (pid == 0)
-		crashing_child();
-
-	pidfd = sys_pidfd_open(pid, 0);
-	ASSERT_GE(pidfd, 0);
-
-	waitpid(pid, &status, 0);
-	ASSERT_TRUE(WIFSIGNALED(status));
-	ASSERT_TRUE(WCOREDUMP(status));
-
-	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
-	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
-	ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
-
-	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
-
-	ASSERT_EQ(stat("/tmp/coredump.file", &st), 0);
-	ASSERT_GT(st.st_size, 0);
-	system("file /tmp/coredump.file");
-}
-
-TEST_F(coredump, socket_request_userspace)
-{
-	int pidfd, ret, status;
-	pid_t pid, pid_coredump_server;
-	struct pidfd_info info = {};
-	int ipc_sockets[2];
-	char c;
-
-	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
-
-	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
-	ASSERT_EQ(ret, 0);
-
-	pid_coredump_server = fork();
-	ASSERT_GE(pid_coredump_server, 0);
-	if (pid_coredump_server == 0) {
-		struct coredump_req req = {};
-		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
-		int exit_code = EXIT_FAILURE;
-
-		close(ipc_sockets[0]);
-
-		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0)
-			goto out;
-
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
-			goto out;
-
-		close(ipc_sockets[1]);
-
-		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0)
-			goto out;
-
-		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0)
-			goto out;
-
-		if (!get_pidfd_info(fd_peer_pidfd, &info))
-			goto out;
-
-		if (!(info.mask & PIDFD_INFO_COREDUMP))
-			goto out;
-
-		if (!(info.coredump_mask & PIDFD_COREDUMPED))
-			goto out;
-
-		if (!read_coredump_req(fd_coredump, &req))
-			goto out;
-
-		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT))
-			goto out;
-
-		if (!send_coredump_ack(fd_coredump, &req,
-				       COREDUMP_USERSPACE | COREDUMP_WAIT, 0))
-			goto out;
-
-		if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK))
-			goto out;
-
-		for (;;) {
-			char buffer[4096];
-			ssize_t bytes_read;
-
-			bytes_read = read(fd_coredump, buffer, sizeof(buffer));
-			if (bytes_read > 0)
-				goto out;
-
-			if (bytes_read < 0)
-				goto out;
-
-			if (bytes_read == 0)
-				break;
-		}
-
-		exit_code = EXIT_SUCCESS;
-out:
-		if (fd_peer_pidfd >= 0)
-			close(fd_peer_pidfd);
-		if (fd_coredump >= 0)
-			close(fd_coredump);
-		if (fd_server >= 0)
-			close(fd_server);
-		_exit(exit_code);
-	}
-	self->pid_coredump_server = pid_coredump_server;
-
-	EXPECT_EQ(close(ipc_sockets[1]), 0);
-	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
-	EXPECT_EQ(close(ipc_sockets[0]), 0);
-
-	pid = fork();
-	ASSERT_GE(pid, 0);
-	if (pid == 0)
-		crashing_child();
-
-	pidfd = sys_pidfd_open(pid, 0);
-	ASSERT_GE(pidfd, 0);
-
-	waitpid(pid, &status, 0);
-	ASSERT_TRUE(WIFSIGNALED(status));
-	ASSERT_TRUE(WCOREDUMP(status));
-
-	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
-	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
-	ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
-
-	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
-}
-
-TEST_F(coredump, socket_request_reject)
-{
-	int pidfd, ret, status;
-	pid_t pid, pid_coredump_server;
-	struct pidfd_info info = {};
-	int ipc_sockets[2];
-	char c;
-
-	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
-
-	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
-	ASSERT_EQ(ret, 0);
-
-	pid_coredump_server = fork();
-	ASSERT_GE(pid_coredump_server, 0);
-	if (pid_coredump_server == 0) {
-		struct coredump_req req = {};
-		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
-		int exit_code = EXIT_FAILURE;
-
-		close(ipc_sockets[0]);
-
-		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0)
-			goto out;
-
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
-			goto out;
-
-		close(ipc_sockets[1]);
-
-		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0)
-			goto out;
-
-		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0)
-			goto out;
-
-		if (!get_pidfd_info(fd_peer_pidfd, &info))
-			goto out;
-
-		if (!(info.mask & PIDFD_INFO_COREDUMP))
-			goto out;
-
-		if (!(info.coredump_mask & PIDFD_COREDUMPED))
-			goto out;
-
-		if (!read_coredump_req(fd_coredump, &req))
-			goto out;
-
-		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT))
-			goto out;
-
-		if (!send_coredump_ack(fd_coredump, &req,
-				       COREDUMP_REJECT | COREDUMP_WAIT, 0))
-			goto out;
-
-		if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK))
-			goto out;
-
-		for (;;) {
-			char buffer[4096];
-			ssize_t bytes_read;
-
-			bytes_read = read(fd_coredump, buffer, sizeof(buffer));
-			if (bytes_read > 0)
-				goto out;
-
-			if (bytes_read < 0)
-				goto out;
-
-			if (bytes_read == 0)
-				break;
-		}
-
-		exit_code = EXIT_SUCCESS;
-out:
-		if (fd_peer_pidfd >= 0)
-			close(fd_peer_pidfd);
-		if (fd_coredump >= 0)
-			close(fd_coredump);
-		if (fd_server >= 0)
-			close(fd_server);
-		_exit(exit_code);
-	}
-	self->pid_coredump_server = pid_coredump_server;
-
-	EXPECT_EQ(close(ipc_sockets[1]), 0);
-	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
-	EXPECT_EQ(close(ipc_sockets[0]), 0);
-
-	pid = fork();
-	ASSERT_GE(pid, 0);
-	if (pid == 0)
-		crashing_child();
-
-	pidfd = sys_pidfd_open(pid, 0);
-	ASSERT_GE(pidfd, 0);
-
-	waitpid(pid, &status, 0);
-	ASSERT_TRUE(WIFSIGNALED(status));
-	ASSERT_FALSE(WCOREDUMP(status));
-
-	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
-	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
-	ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
-
-	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
-}
-
-TEST_F(coredump, socket_request_invalid_flag_combination)
-{
-	int pidfd, ret, status;
-	pid_t pid, pid_coredump_server;
-	struct pidfd_info info = {};
-	int ipc_sockets[2];
-	char c;
-
-	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
-
-	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
-	ASSERT_EQ(ret, 0);
-
-	pid_coredump_server = fork();
-	ASSERT_GE(pid_coredump_server, 0);
-	if (pid_coredump_server == 0) {
-		struct coredump_req req = {};
-		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
-		int exit_code = EXIT_FAILURE;
-
-		close(ipc_sockets[0]);
-
-		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0)
-			goto out;
-
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
-			goto out;
-
-		close(ipc_sockets[1]);
-
-		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0)
-			goto out;
-
-		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0)
-			goto out;
-
-		if (!get_pidfd_info(fd_peer_pidfd, &info))
-			goto out;
-
-		if (!(info.mask & PIDFD_INFO_COREDUMP))
-			goto out;
-
-		if (!(info.coredump_mask & PIDFD_COREDUMPED))
-			goto out;
-
-		if (!read_coredump_req(fd_coredump, &req))
-			goto out;
-
-		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT))
-			goto out;
-
-		if (!send_coredump_ack(fd_coredump, &req,
-				       COREDUMP_KERNEL | COREDUMP_REJECT | COREDUMP_WAIT, 0))
-			goto out;
-
-		if (!read_marker(fd_coredump, COREDUMP_MARK_CONFLICTING))
-			goto out;
-
-		exit_code = EXIT_SUCCESS;
-out:
-		if (fd_peer_pidfd >= 0)
-			close(fd_peer_pidfd);
-		if (fd_coredump >= 0)
-			close(fd_coredump);
-		if (fd_server >= 0)
-			close(fd_server);
-		_exit(exit_code);
-	}
-	self->pid_coredump_server = pid_coredump_server;
-
-	EXPECT_EQ(close(ipc_sockets[1]), 0);
-	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
-	EXPECT_EQ(close(ipc_sockets[0]), 0);
-
-	pid = fork();
-	ASSERT_GE(pid, 0);
-	if (pid == 0)
-		crashing_child();
-
-	pidfd = sys_pidfd_open(pid, 0);
-	ASSERT_GE(pidfd, 0);
-
-	waitpid(pid, &status, 0);
-	ASSERT_TRUE(WIFSIGNALED(status));
-	ASSERT_FALSE(WCOREDUMP(status));
-
-	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
-	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
-	ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
-
-	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
-}
-
-TEST_F(coredump, socket_request_unknown_flag)
-{
-	int pidfd, ret, status;
-	pid_t pid, pid_coredump_server;
-	struct pidfd_info info = {};
-	int ipc_sockets[2];
-	char c;
-
-	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
-
-	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
-	ASSERT_EQ(ret, 0);
-
-	pid_coredump_server = fork();
-	ASSERT_GE(pid_coredump_server, 0);
-	if (pid_coredump_server == 0) {
-		struct coredump_req req = {};
-		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
-		int exit_code = EXIT_FAILURE;
-
-		close(ipc_sockets[0]);
-
-		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0)
-			goto out;
-
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
-			goto out;
-
-		close(ipc_sockets[1]);
-
-		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0)
-			goto out;
-
-		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0)
-			goto out;
-
-		if (!get_pidfd_info(fd_peer_pidfd, &info))
-			goto out;
-
-		if (!(info.mask & PIDFD_INFO_COREDUMP))
-			goto out;
-
-		if (!(info.coredump_mask & PIDFD_COREDUMPED))
-			goto out;
-
-		if (!read_coredump_req(fd_coredump, &req))
-			goto out;
-
-		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT))
-			goto out;
-
-		if (!send_coredump_ack(fd_coredump, &req, (1ULL << 63), 0))
-			goto out;
-
-		if (!read_marker(fd_coredump, COREDUMP_MARK_UNSUPPORTED))
-			goto out;
-
-		exit_code = EXIT_SUCCESS;
-out:
-		if (fd_peer_pidfd >= 0)
-			close(fd_peer_pidfd);
-		if (fd_coredump >= 0)
-			close(fd_coredump);
-		if (fd_server >= 0)
-			close(fd_server);
-		_exit(exit_code);
-	}
-	self->pid_coredump_server = pid_coredump_server;
-
-	EXPECT_EQ(close(ipc_sockets[1]), 0);
-	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
-	EXPECT_EQ(close(ipc_sockets[0]), 0);
-
-	pid = fork();
-	ASSERT_GE(pid, 0);
-	if (pid == 0)
-		crashing_child();
-
-	pidfd = sys_pidfd_open(pid, 0);
-	ASSERT_GE(pidfd, 0);
-
-	waitpid(pid, &status, 0);
-	ASSERT_TRUE(WIFSIGNALED(status));
-	ASSERT_FALSE(WCOREDUMP(status));
-
-	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
-	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
-	ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
-
-	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
-}
-
-TEST_F(coredump, socket_request_invalid_size_small)
-{
-	int pidfd, ret, status;
-	pid_t pid, pid_coredump_server;
-	struct pidfd_info info = {};
-	int ipc_sockets[2];
-	char c;
-
-	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
-
-	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
-	ASSERT_EQ(ret, 0);
-
-	pid_coredump_server = fork();
-	ASSERT_GE(pid_coredump_server, 0);
-	if (pid_coredump_server == 0) {
-		struct coredump_req req = {};
-		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
-		int exit_code = EXIT_FAILURE;
-
-		close(ipc_sockets[0]);
-
-		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0)
-			goto out;
-
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
-			goto out;
-
-		close(ipc_sockets[1]);
-
-		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0)
-			goto out;
-
-		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0)
-			goto out;
-
-		if (!get_pidfd_info(fd_peer_pidfd, &info))
-			goto out;
-
-		if (!(info.mask & PIDFD_INFO_COREDUMP))
-			goto out;
-
-		if (!(info.coredump_mask & PIDFD_COREDUMPED))
-			goto out;
-
-		if (!read_coredump_req(fd_coredump, &req))
-			goto out;
-
-		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT))
-			goto out;
-
-		if (!send_coredump_ack(fd_coredump, &req,
-				       COREDUMP_REJECT | COREDUMP_WAIT,
-				       COREDUMP_ACK_SIZE_VER0 / 2))
-			goto out;
-
-		if (!read_marker(fd_coredump, COREDUMP_MARK_MINSIZE))
-			goto out;
-
-		exit_code = EXIT_SUCCESS;
-out:
-		if (fd_peer_pidfd >= 0)
-			close(fd_peer_pidfd);
-		if (fd_coredump >= 0)
-			close(fd_coredump);
-		if (fd_server >= 0)
-			close(fd_server);
-		_exit(exit_code);
-	}
-	self->pid_coredump_server = pid_coredump_server;
-
-	EXPECT_EQ(close(ipc_sockets[1]), 0);
-	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
-	EXPECT_EQ(close(ipc_sockets[0]), 0);
-
-	pid = fork();
-	ASSERT_GE(pid, 0);
-	if (pid == 0)
-		crashing_child();
-
-	pidfd = sys_pidfd_open(pid, 0);
-	ASSERT_GE(pidfd, 0);
-
-	waitpid(pid, &status, 0);
-	ASSERT_TRUE(WIFSIGNALED(status));
-	ASSERT_FALSE(WCOREDUMP(status));
-
-	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
-	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
-	ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
-
-	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
-}
-
-TEST_F(coredump, socket_request_invalid_size_large)
-{
-	int pidfd, ret, status;
-	pid_t pid, pid_coredump_server;
-	struct pidfd_info info = {};
-	int ipc_sockets[2];
-	char c;
-
-	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
-
-	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
-	ASSERT_EQ(ret, 0);
-
-	pid_coredump_server = fork();
-	ASSERT_GE(pid_coredump_server, 0);
-	if (pid_coredump_server == 0) {
-		struct coredump_req req = {};
-		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
-		int exit_code = EXIT_FAILURE;
-
-		close(ipc_sockets[0]);
-
-		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0)
-			goto out;
-
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
-			goto out;
-
-		close(ipc_sockets[1]);
-
-		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0)
-			goto out;
-
-		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0)
-			goto out;
-
-		if (!get_pidfd_info(fd_peer_pidfd, &info))
-			goto out;
-
-		if (!(info.mask & PIDFD_INFO_COREDUMP))
-			goto out;
-
-		if (!(info.coredump_mask & PIDFD_COREDUMPED))
-			goto out;
-
-		if (!read_coredump_req(fd_coredump, &req))
-			goto out;
-
-		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT))
-			goto out;
-
-		if (!send_coredump_ack(fd_coredump, &req,
-				       COREDUMP_REJECT | COREDUMP_WAIT,
-				       COREDUMP_ACK_SIZE_VER0 + PAGE_SIZE))
-			goto out;
-
-		if (!read_marker(fd_coredump, COREDUMP_MARK_MAXSIZE))
-			goto out;
-
-		exit_code = EXIT_SUCCESS;
-out:
-		if (fd_peer_pidfd >= 0)
-			close(fd_peer_pidfd);
-		if (fd_coredump >= 0)
-			close(fd_coredump);
-		if (fd_server >= 0)
-			close(fd_server);
-		_exit(exit_code);
-	}
-	self->pid_coredump_server = pid_coredump_server;
-
-	EXPECT_EQ(close(ipc_sockets[1]), 0);
-	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
-	EXPECT_EQ(close(ipc_sockets[0]), 0);
-
-	pid = fork();
-	ASSERT_GE(pid, 0);
-	if (pid == 0)
-		crashing_child();
-
-	pidfd = sys_pidfd_open(pid, 0);
-	ASSERT_GE(pidfd, 0);
-
-	waitpid(pid, &status, 0);
-	ASSERT_TRUE(WIFSIGNALED(status));
-	ASSERT_FALSE(WCOREDUMP(status));
-
-	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
-	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
-	ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
-
-	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
-}
-
-static int open_coredump_tmpfile(int fd_tmpfs_detached)
-{
-	return openat(fd_tmpfs_detached, ".", O_TMPFILE | O_RDWR | O_EXCL, 0600);
-}
-
-#define NUM_CRASHING_COREDUMPS 5
-
-TEST_F_TIMEOUT(coredump, socket_multiple_crashing_coredumps, 500)
-{
-	int pidfd[NUM_CRASHING_COREDUMPS], status[NUM_CRASHING_COREDUMPS];
-	pid_t pid[NUM_CRASHING_COREDUMPS], pid_coredump_server;
-	struct pidfd_info info = {};
-	int ipc_sockets[2];
-	char c;
-
-	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
-
-	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets), 0);
-
-	pid_coredump_server = fork();
-	ASSERT_GE(pid_coredump_server, 0);
-	if (pid_coredump_server == 0) {
-		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1, fd_core_file = -1;
-		int exit_code = EXIT_FAILURE;
-		struct coredump_req req = {};
-
-		close(ipc_sockets[0]);
-		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0) {
-			fprintf(stderr, "Failed to create and listen on unix socket\n");
-			goto out;
-		}
-
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
-			fprintf(stderr, "Failed to notify parent via ipc socket\n");
-			goto out;
-		}
-		close(ipc_sockets[1]);
-
-		for (int i = 0; i < NUM_CRASHING_COREDUMPS; i++) {
-			fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-			if (fd_coredump < 0) {
-				fprintf(stderr, "accept4 failed: %m\n");
-				goto out;
-			}
-
-			fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-			if (fd_peer_pidfd < 0) {
-				fprintf(stderr, "get_peer_pidfd failed for fd %d: %m\n", fd_coredump);
-				goto out;
-			}
-
-			if (!get_pidfd_info(fd_peer_pidfd, &info)) {
-				fprintf(stderr, "get_pidfd_info failed for fd %d\n", fd_peer_pidfd);
-				goto out;
-			}
-
-			if (!(info.mask & PIDFD_INFO_COREDUMP)) {
-				fprintf(stderr, "pidfd info missing PIDFD_INFO_COREDUMP for fd %d\n", fd_peer_pidfd);
-				goto out;
-			}
-			if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
-				fprintf(stderr, "pidfd info missing PIDFD_COREDUMPED for fd %d\n", fd_peer_pidfd);
-				goto out;
-			}
-
-			if (!read_coredump_req(fd_coredump, &req)) {
-				fprintf(stderr, "read_coredump_req failed for fd %d\n", fd_coredump);
-				goto out;
-			}
-
-			if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-						COREDUMP_KERNEL | COREDUMP_USERSPACE |
-						COREDUMP_REJECT | COREDUMP_WAIT)) {
-				fprintf(stderr, "check_coredump_req failed for fd %d\n", fd_coredump);
-				goto out;
-			}
-
-			if (!send_coredump_ack(fd_coredump, &req,
-					       COREDUMP_KERNEL | COREDUMP_WAIT, 0)) {
-				fprintf(stderr, "send_coredump_ack failed for fd %d\n", fd_coredump);
-				goto out;
-			}
-
-			if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK)) {
-				fprintf(stderr, "read_marker failed for fd %d\n", fd_coredump);
-				goto out;
-			}
-
-			fd_core_file = open_coredump_tmpfile(self->fd_tmpfs_detached);
-			if (fd_core_file < 0) {
-				fprintf(stderr, "%m - open_coredump_tmpfile failed for fd %d\n", fd_coredump);
-				goto out;
-			}
-
-			for (;;) {
-				char buffer[4096];
-				ssize_t bytes_read, bytes_write;
-
-				bytes_read = read(fd_coredump, buffer, sizeof(buffer));
-				if (bytes_read < 0) {
-					fprintf(stderr, "read failed for fd %d: %m\n", fd_coredump);
-					goto out;
-				}
-
-				if (bytes_read == 0)
-					break;
-
-				bytes_write = write(fd_core_file, buffer, bytes_read);
-				if (bytes_read != bytes_write) {
-					fprintf(stderr, "write failed for fd %d: %m\n", fd_core_file);
-					goto out;
-				}
-			}
-
-			close(fd_core_file);
-			close(fd_peer_pidfd);
-			close(fd_coredump);
-			fd_peer_pidfd = -1;
-			fd_coredump = -1;
-		}
-
-		exit_code = EXIT_SUCCESS;
-out:
-		if (fd_core_file >= 0)
-			close(fd_core_file);
-		if (fd_peer_pidfd >= 0)
-			close(fd_peer_pidfd);
-		if (fd_coredump >= 0)
-			close(fd_coredump);
-		if (fd_server >= 0)
-			close(fd_server);
-		_exit(exit_code);
-	}
-	self->pid_coredump_server = pid_coredump_server;
-
-	EXPECT_EQ(close(ipc_sockets[1]), 0);
-	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
-	EXPECT_EQ(close(ipc_sockets[0]), 0);
-
-	for (int i = 0; i < NUM_CRASHING_COREDUMPS; i++) {
-		pid[i] = fork();
-		ASSERT_GE(pid[i], 0);
-		if (pid[i] == 0)
-			crashing_child();
-		pidfd[i] = sys_pidfd_open(pid[i], 0);
-		ASSERT_GE(pidfd[i], 0);
-	}
-
-	for (int i = 0; i < NUM_CRASHING_COREDUMPS; i++) {
-		waitpid(pid[i], &status[i], 0);
-		ASSERT_TRUE(WIFSIGNALED(status[i]));
-		ASSERT_TRUE(WCOREDUMP(status[i]));
-	}
-
-	for (int i = 0; i < NUM_CRASHING_COREDUMPS; i++) {
-		info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
-		ASSERT_EQ(ioctl(pidfd[i], PIDFD_GET_INFO, &info), 0);
-		ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
-		ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
-	}
-
-	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
-}
-
-#define MAX_EVENTS 128
-
-static void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_file)
-{
-	int epfd = -1;
-	int exit_code = EXIT_FAILURE;
-
-	epfd = epoll_create1(0);
-	if (epfd < 0)
-		goto out;
-
-	struct epoll_event ev;
-	ev.events = EPOLLIN | EPOLLRDHUP | EPOLLET;
-	ev.data.fd = fd_coredump;
-	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fd_coredump, &ev) < 0)
-		goto out;
-
-	for (;;) {
-		struct epoll_event events[1];
-		int n = epoll_wait(epfd, events, 1, -1);
-		if (n < 0)
-			break;
-
-		if (events[0].events & (EPOLLIN | EPOLLRDHUP)) {
-			for (;;) {
-				char buffer[4096];
-				ssize_t bytes_read = read(fd_coredump, buffer, sizeof(buffer));
-				if (bytes_read < 0) {
-					if (errno == EAGAIN || errno == EWOULDBLOCK)
-						break;
-					goto out;
-				}
-				if (bytes_read == 0)
-					goto done;
-				ssize_t bytes_write = write(fd_core_file, buffer, bytes_read);
-				if (bytes_write != bytes_read)
-					goto out;
-			}
-		}
-	}
-
-done:
-	exit_code = EXIT_SUCCESS;
-out:
-	if (epfd >= 0)
-		close(epfd);
-	if (fd_core_file >= 0)
-		close(fd_core_file);
-	if (fd_peer_pidfd >= 0)
-		close(fd_peer_pidfd);
-	if (fd_coredump >= 0)
-		close(fd_coredump);
-	_exit(exit_code);
-}
-
-TEST_F_TIMEOUT(coredump, socket_multiple_crashing_coredumps_epoll_workers, 500)
-{
-	int pidfd[NUM_CRASHING_COREDUMPS], status[NUM_CRASHING_COREDUMPS];
-	pid_t pid[NUM_CRASHING_COREDUMPS], pid_coredump_server, worker_pids[NUM_CRASHING_COREDUMPS];
-	struct pidfd_info info = {};
-	int ipc_sockets[2];
-	char c;
-
-	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
-	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets), 0);
-
-	pid_coredump_server = fork();
-	ASSERT_GE(pid_coredump_server, 0);
-	if (pid_coredump_server == 0) {
-		int fd_server = -1, exit_code = EXIT_FAILURE, n_conns = 0;
-		fd_server = -1;
-		exit_code = EXIT_FAILURE;
-		n_conns = 0;
-		close(ipc_sockets[0]);
-		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0)
-			goto out;
-
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
-			goto out;
-		close(ipc_sockets[1]);
-
-		while (n_conns < NUM_CRASHING_COREDUMPS) {
-			int fd_coredump = -1, fd_peer_pidfd = -1, fd_core_file = -1;
-			struct coredump_req req = {};
-			fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-			if (fd_coredump < 0) {
-				if (errno == EAGAIN || errno == EWOULDBLOCK)
-					continue;
-				goto out;
-			}
-			fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-			if (fd_peer_pidfd < 0)
-				goto out;
-			if (!get_pidfd_info(fd_peer_pidfd, &info))
-				goto out;
-			if (!(info.mask & PIDFD_INFO_COREDUMP) || !(info.coredump_mask & PIDFD_COREDUMPED))
-				goto out;
-			if (!read_coredump_req(fd_coredump, &req))
-				goto out;
-			if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-						COREDUMP_KERNEL | COREDUMP_USERSPACE |
-						COREDUMP_REJECT | COREDUMP_WAIT))
-				goto out;
-			if (!send_coredump_ack(fd_coredump, &req, COREDUMP_KERNEL | COREDUMP_WAIT, 0))
-				goto out;
-			if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK))
-				goto out;
-			fd_core_file = open_coredump_tmpfile(self->fd_tmpfs_detached);
-			if (fd_core_file < 0)
-				goto out;
-			pid_t worker = fork();
-			if (worker == 0) {
-				close(fd_server);
-				process_coredump_worker(fd_coredump, fd_peer_pidfd, fd_core_file);
-			}
-			worker_pids[n_conns] = worker;
-			if (fd_coredump >= 0)
-				close(fd_coredump);
-			if (fd_peer_pidfd >= 0)
-				close(fd_peer_pidfd);
-			if (fd_core_file >= 0)
-				close(fd_core_file);
-			n_conns++;
-		}
-		exit_code = EXIT_SUCCESS;
-out:
-		if (fd_server >= 0)
-			close(fd_server);
-
-		// Reap all worker processes
-		for (int i = 0; i < n_conns; i++) {
-			int wstatus;
-			if (waitpid(worker_pids[i], &wstatus, 0) < 0) {
-				fprintf(stderr, "Failed to wait for worker %d: %m\n", worker_pids[i]);
-			} else if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) != EXIT_SUCCESS) {
-				fprintf(stderr, "Worker %d exited with error code %d\n", worker_pids[i], WEXITSTATUS(wstatus));
-				exit_code = EXIT_FAILURE;
-			}
-		}
-
-		_exit(exit_code);
-	}
-	self->pid_coredump_server = pid_coredump_server;
-
-	EXPECT_EQ(close(ipc_sockets[1]), 0);
-	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
-	EXPECT_EQ(close(ipc_sockets[0]), 0);
-
-	for (int i = 0; i < NUM_CRASHING_COREDUMPS; i++) {
-		pid[i] = fork();
-		ASSERT_GE(pid[i], 0);
-		if (pid[i] == 0)
-			crashing_child();
-		pidfd[i] = sys_pidfd_open(pid[i], 0);
-		ASSERT_GE(pidfd[i], 0);
-	}
-
-	for (int i = 0; i < NUM_CRASHING_COREDUMPS; i++) {
-		ASSERT_GE(waitpid(pid[i], &status[i], 0), 0);
-		ASSERT_TRUE(WIFSIGNALED(status[i]));
-		ASSERT_TRUE(WCOREDUMP(status[i]));
-	}
-
-	for (int i = 0; i < NUM_CRASHING_COREDUMPS; i++) {
-		info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
-		ASSERT_EQ(ioctl(pidfd[i], PIDFD_GET_INFO, &info), 0);
-		ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
-		ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
-	}
-
-	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
-}
-
-TEST_F(coredump, socket_invalid_paths)
-{
-	ASSERT_FALSE(set_core_pattern("@ /tmp/coredump.socket"));
-	ASSERT_FALSE(set_core_pattern("@/tmp/../coredump.socket"));
-	ASSERT_FALSE(set_core_pattern("@../coredump.socket"));
-	ASSERT_FALSE(set_core_pattern("@/tmp/coredump.socket/.."));
-	ASSERT_FALSE(set_core_pattern("@.."));
-
-	ASSERT_FALSE(set_core_pattern("@@ /tmp/coredump.socket"));
-	ASSERT_FALSE(set_core_pattern("@@/tmp/../coredump.socket"));
-	ASSERT_FALSE(set_core_pattern("@@../coredump.socket"));
-	ASSERT_FALSE(set_core_pattern("@@/tmp/coredump.socket/.."));
-	ASSERT_FALSE(set_core_pattern("@@.."));
-
-	ASSERT_FALSE(set_core_pattern("@@@/tmp/coredump.socket"));
-}
-
 TEST_HARNESS_MAIN

-- 
2.47.3


