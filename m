Return-Path: <linux-fsdevel+bounces-49249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61799AB9B0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 13:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FFC03AC7E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 11:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C3C245032;
	Fri, 16 May 2025 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLMsPK0Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593F423BCEC;
	Fri, 16 May 2025 11:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747394793; cv=none; b=JEx0gL2PGkLt2Bg92wSXWxGq7YTAcOsJjzphkRKd2szj0G6q/jYvH4sh/V5+HVLNZXOnv5dcqsGNwUiw/bp7r46HizbaHj2PqDlSxidyz9MRJsxWKhOBSCsIuoOy9JfoYYmjrG2tUvmFe+nZQxTWPEVomQk8VVLAmpieSPJfxKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747394793; c=relaxed/simple;
	bh=CjMXLNxQTUQ+NVWK7UNF0LloR85gncPFDeQLLNmPQqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ft6+UeLJFiDMzgoqSpEwBUq0hBDTo73HRpPww1mbgRy/RvjOK62yl6+funSzypczC3TN+qV0wXEfooUD0imqjE1BikfpTFVtYAHvF1goijIwqQAfOrJVImG5SavHFwAIHB/O6YNn0BcmYettUsp+tvrnS6lP2hHZnkxpCDsrZWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLMsPK0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245D7C4CEE4;
	Fri, 16 May 2025 11:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747394792;
	bh=CjMXLNxQTUQ+NVWK7UNF0LloR85gncPFDeQLLNmPQqY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uLMsPK0YTvUJMuBgknFn24RjNHOZY5v8pcYt/B4WmpdAk1QNXchkrcADfUQm4OMO9
	 spjC1aTTIT1yCzbx/s+b+l0R0CxWAy1H02vuA2+FkxoRKnaUafIZdpRFu8BQ91LloW
	 yN/jovsq4P/mc1em774EgSw9mBF7Tn4ME26EoGottAIK9aI7JbiBuxxnHu0D1B8aFO
	 WpYoFvqxhJCYakY4caUMAyBNB4j+yv5+V9Z/HsxcCTJMHeclxT+OqHCwqcCfRUPmx2
	 TK4RSNtZ3Yd1illREo4g8FYQi5PzpO+FYpVsUl0glioOXN1E09rbNmkDCXUbBcm7+x
	 Ekqyf17L8xKAA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 16 May 2025 13:25:36 +0200
Subject: [PATCH v8 9/9] selftests/coredump: add tests for AF_UNIX coredumps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250516-work-coredump-socket-v8-9-664f3caf2516@kernel.org>
References: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org>
In-Reply-To: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Luca Boccassi <luca.boccassi@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-security-module@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=14551; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CjMXLNxQTUQ+NVWK7UNF0LloR85gncPFDeQLLNmPQqY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSoK2xTcjwQXP/kvOCKRzF3K/6Xq38Rumo42/7Gk3vnd
 gtu4jmwuqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAidQsZGabmJSa/mhh4M1Bd
 88MHHjGd11YXhRQzpm6bbRV4afPLOBeGfxbv3xy9wtRw68KlfxdaQ7Yo3NvmfHAW245nLgphpVt
 6l/MBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a simple test for generating coredumps via AF_UNIX sockets.

Acked-by: Luca Boccassi <luca.boccassi@gmail.com>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/coredump/stackdump_test.c | 467 +++++++++++++++++++++-
 1 file changed, 466 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/testing/selftests/coredump/stackdump_test.c
index fe3c728cd6be..9984413be9f0 100644
--- a/tools/testing/selftests/coredump/stackdump_test.c
+++ b/tools/testing/selftests/coredump/stackdump_test.c
@@ -1,14 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <fcntl.h>
+#include <inttypes.h>
 #include <libgen.h>
 #include <linux/limits.h>
 #include <pthread.h>
 #include <string.h>
+#include <sys/mount.h>
 #include <sys/resource.h>
+#include <sys/stat.h>
+#include <sys/socket.h>
+#include <sys/un.h>
 #include <unistd.h>
 
 #include "../kselftest_harness.h"
+#include "../pidfd/pidfd.h"
 
 #define STACKDUMP_FILE "stack_values"
 #define STACKDUMP_SCRIPT "stackdump"
@@ -35,6 +41,7 @@ static void crashing_child(void)
 FIXTURE(coredump)
 {
 	char original_core_pattern[256];
+	pid_t pid_coredump_server;
 };
 
 FIXTURE_SETUP(coredump)
@@ -44,6 +51,7 @@ FIXTURE_SETUP(coredump)
 	char *dir;
 	int ret;
 
+	self->pid_coredump_server = -ESRCH;
 	file = fopen("/proc/sys/kernel/core_pattern", "r");
 	ASSERT_NE(NULL, file);
 
@@ -61,10 +69,17 @@ FIXTURE_TEARDOWN(coredump)
 {
 	const char *reason;
 	FILE *file;
-	int ret;
+	int ret, status;
 
 	unlink(STACKDUMP_FILE);
 
+	if (self->pid_coredump_server > 0) {
+		kill(self->pid_coredump_server, SIGTERM);
+		waitpid(self->pid_coredump_server, &status, 0);
+	}
+	unlink("/tmp/coredump.file");
+	unlink("/tmp/coredump.socket");
+
 	file = fopen("/proc/sys/kernel/core_pattern", "w");
 	if (!file) {
 		reason = "Unable to open core_pattern";
@@ -154,4 +169,454 @@ TEST_F_TIMEOUT(coredump, stackdump, 120)
 	fclose(file);
 }
 
+TEST_F(coredump, socket)
+{
+	int fd, pidfd, ret, status;
+	FILE *file;
+	pid_t pid, pid_coredump_server;
+	struct stat st;
+	char core_file[PATH_MAX];
+	struct pidfd_info info = {};
+	int ipc_sockets[2];
+	char c;
+	const struct sockaddr_un coredump_sk = {
+		.sun_family = AF_UNIX,
+		.sun_path = "/tmp/coredump.socket",
+	};
+	size_t coredump_sk_len = offsetof(struct sockaddr_un, sun_path) +
+				 sizeof("/tmp/coredump.socket");
+
+	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	file = fopen("/proc/sys/kernel/core_pattern", "w");
+	ASSERT_NE(file, NULL);
+
+	ret = fprintf(file, "@/tmp/coredump.socket");
+	ASSERT_EQ(ret, strlen("@/tmp/coredump.socket"));
+	ASSERT_EQ(fclose(file), 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		int fd_server, fd_coredump, fd_peer_pidfd, fd_core_file;
+		socklen_t fd_peer_pidfd_len;
+
+		close(ipc_sockets[0]);
+
+		fd_server = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+		if (fd_server < 0)
+			_exit(EXIT_FAILURE);
+
+		ret = bind(fd_server, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
+		if (ret < 0) {
+			fprintf(stderr, "Failed to bind coredump socket\n");
+			close(fd_server);
+			close(ipc_sockets[1]);
+			_exit(EXIT_FAILURE);
+		}
+
+		ret = listen(fd_server, 1);
+		if (ret < 0) {
+			fprintf(stderr, "Failed to listen on coredump socket\n");
+			close(fd_server);
+			close(ipc_sockets[1]);
+			_exit(EXIT_FAILURE);
+		}
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
+			close(fd_server);
+			close(ipc_sockets[1]);
+			_exit(EXIT_FAILURE);
+		}
+
+		close(ipc_sockets[1]);
+
+		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
+		if (fd_coredump < 0) {
+			fprintf(stderr, "Failed to accept coredump socket connection\n");
+			close(fd_server);
+			_exit(EXIT_FAILURE);
+		}
+
+		fd_peer_pidfd_len = sizeof(fd_peer_pidfd);
+		ret = getsockopt(fd_coredump, SOL_SOCKET, SO_PEERPIDFD,
+				 &fd_peer_pidfd, &fd_peer_pidfd_len);
+		if (ret < 0) {
+			fprintf(stderr, "%m - Failed to retrieve peer pidfd for coredump socket connection\n");
+			close(fd_coredump);
+			close(fd_server);
+			_exit(EXIT_FAILURE);
+		}
+
+		memset(&info, 0, sizeof(info));
+		info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
+		ret = ioctl(fd_peer_pidfd, PIDFD_GET_INFO, &info);
+		if (ret < 0) {
+			fprintf(stderr, "Failed to retrieve pidfd info from peer pidfd for coredump socket connection\n");
+			close(fd_coredump);
+			close(fd_server);
+			close(fd_peer_pidfd);
+			_exit(EXIT_FAILURE);
+		}
+
+		if (!(info.mask & PIDFD_INFO_COREDUMP)) {
+			fprintf(stderr, "Missing coredump information from coredumping task\n");
+			close(fd_coredump);
+			close(fd_server);
+			close(fd_peer_pidfd);
+			_exit(EXIT_FAILURE);
+		}
+
+		if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
+			fprintf(stderr, "Received connection from non-coredumping task\n");
+			close(fd_coredump);
+			close(fd_server);
+			close(fd_peer_pidfd);
+			_exit(EXIT_FAILURE);
+		}
+
+		fd_core_file = creat("/tmp/coredump.file", 0644);
+		if (fd_core_file < 0) {
+			fprintf(stderr, "Failed to create coredump file\n");
+			close(fd_coredump);
+			close(fd_server);
+			close(fd_peer_pidfd);
+			_exit(EXIT_FAILURE);
+		}
+
+		for (;;) {
+			char buffer[4096];
+			ssize_t bytes_read, bytes_write;
+
+			bytes_read = read(fd_coredump, buffer, sizeof(buffer));
+			if (bytes_read < 0) {
+				close(fd_coredump);
+				close(fd_server);
+				close(fd_peer_pidfd);
+				close(fd_core_file);
+				_exit(EXIT_FAILURE);
+			}
+
+			if (bytes_read == 0)
+				break;
+
+			bytes_write = write(fd_core_file, buffer, bytes_read);
+			if (bytes_read != bytes_write) {
+				close(fd_coredump);
+				close(fd_server);
+				close(fd_peer_pidfd);
+				close(fd_core_file);
+				_exit(EXIT_FAILURE);
+			}
+		}
+
+		close(fd_coredump);
+		close(fd_server);
+		close(fd_peer_pidfd);
+		close(fd_core_file);
+		_exit(EXIT_SUCCESS);
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
+	info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
+	ASSERT_EQ(ioctl(pidfd, PIDFD_GET_INFO, &info), 0);
+	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
+	ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
+
+	waitpid(pid_coredump_server, &status, 0);
+	self->pid_coredump_server = -ESRCH;
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	ASSERT_EQ(stat("/tmp/coredump.file", &st), 0);
+	ASSERT_GT(st.st_size, 0);
+	/*
+	 * We should somehow validate the produced core file.
+	 * For now just allow for visual inspection
+	 */
+	system("file /tmp/coredump.file");
+}
+
+TEST_F(coredump, socket_detect_userspace_client)
+{
+	int fd, pidfd, ret, status;
+	FILE *file;
+	pid_t pid, pid_coredump_server;
+	struct stat st;
+	char core_file[PATH_MAX];
+	struct pidfd_info info = {};
+	int ipc_sockets[2];
+	char c;
+	const struct sockaddr_un coredump_sk = {
+		.sun_family = AF_UNIX,
+		.sun_path = "/tmp/coredump.socket",
+	};
+	size_t coredump_sk_len = offsetof(struct sockaddr_un, sun_path) +
+				 sizeof("/tmp/coredump.socket");
+
+	file = fopen("/proc/sys/kernel/core_pattern", "w");
+	ASSERT_NE(file, NULL);
+
+	ret = fprintf(file, "@/tmp/coredump.socket");
+	ASSERT_EQ(ret, strlen("@/tmp/coredump.socket"));
+	ASSERT_EQ(fclose(file), 0);
+
+	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		int fd_server, fd_coredump, fd_peer_pidfd, fd_core_file;
+		socklen_t fd_peer_pidfd_len;
+
+		close(ipc_sockets[0]);
+
+		fd_server = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+		if (fd_server < 0)
+			_exit(EXIT_FAILURE);
+
+		ret = bind(fd_server, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
+		if (ret < 0) {
+			fprintf(stderr, "Failed to bind coredump socket\n");
+			close(fd_server);
+			close(ipc_sockets[1]);
+			_exit(EXIT_FAILURE);
+		}
+
+		ret = listen(fd_server, 1);
+		if (ret < 0) {
+			fprintf(stderr, "Failed to listen on coredump socket\n");
+			close(fd_server);
+			close(ipc_sockets[1]);
+			_exit(EXIT_FAILURE);
+		}
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
+			close(fd_server);
+			close(ipc_sockets[1]);
+			_exit(EXIT_FAILURE);
+		}
+
+		close(ipc_sockets[1]);
+
+		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
+		if (fd_coredump < 0) {
+			fprintf(stderr, "Failed to accept coredump socket connection\n");
+			close(fd_server);
+			_exit(EXIT_FAILURE);
+		}
+
+		fd_peer_pidfd_len = sizeof(fd_peer_pidfd);
+		ret = getsockopt(fd_coredump, SOL_SOCKET, SO_PEERPIDFD,
+				 &fd_peer_pidfd, &fd_peer_pidfd_len);
+		if (ret < 0) {
+			fprintf(stderr, "%m - Failed to retrieve peer pidfd for coredump socket connection\n");
+			close(fd_coredump);
+			close(fd_server);
+			_exit(EXIT_FAILURE);
+		}
+
+		memset(&info, 0, sizeof(info));
+		info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
+		ret = ioctl(fd_peer_pidfd, PIDFD_GET_INFO, &info);
+		if (ret < 0) {
+			fprintf(stderr, "Failed to retrieve pidfd info from peer pidfd for coredump socket connection\n");
+			close(fd_coredump);
+			close(fd_server);
+			close(fd_peer_pidfd);
+			_exit(EXIT_FAILURE);
+		}
+
+		if (!(info.mask & PIDFD_INFO_COREDUMP)) {
+			fprintf(stderr, "Missing coredump information from coredumping task\n");
+			close(fd_coredump);
+			close(fd_server);
+			close(fd_peer_pidfd);
+			_exit(EXIT_FAILURE);
+		}
+
+		if (info.coredump_mask & PIDFD_COREDUMPED) {
+			fprintf(stderr, "Received unexpected connection from coredumping task\n");
+			close(fd_coredump);
+			close(fd_server);
+			close(fd_peer_pidfd);
+			_exit(EXIT_FAILURE);
+		}
+
+		close(fd_coredump);
+		close(fd_server);
+		close(fd_peer_pidfd);
+		close(fd_core_file);
+		_exit(EXIT_SUCCESS);
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
+
+		fd_socket = socket(AF_UNIX, SOCK_STREAM, 0);
+		if (fd_socket < 0)
+			_exit(EXIT_FAILURE);
+
+
+		ret = connect(fd_socket, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
+		if (ret < 0)
+			_exit(EXIT_FAILURE);
+
+		(void *)write(fd_socket, &(char){ 0 }, 1);
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
+	info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
+	ASSERT_EQ(ioctl(pidfd, PIDFD_GET_INFO, &info), 0);
+	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
+	ASSERT_EQ((info.coredump_mask & PIDFD_COREDUMPED), 0);
+
+	waitpid(pid_coredump_server, &status, 0);
+	self->pid_coredump_server = -ESRCH;
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	ASSERT_NE(stat("/tmp/coredump.file", &st), 0);
+	ASSERT_EQ(errno, ENOENT);
+}
+
+TEST_F(coredump, socket_enoent)
+{
+	int pidfd, ret, status;
+	FILE *file;
+	pid_t pid;
+	char core_file[PATH_MAX];
+
+	file = fopen("/proc/sys/kernel/core_pattern", "w");
+	ASSERT_NE(file, NULL);
+
+	ret = fprintf(file, "@/tmp/coredump.socket");
+	ASSERT_EQ(ret, strlen("@/tmp/coredump.socket"));
+	ASSERT_EQ(fclose(file), 0);
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
+	FILE *file;
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
+	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	file = fopen("/proc/sys/kernel/core_pattern", "w");
+	ASSERT_NE(file, NULL);
+
+	ret = fprintf(file, "@/tmp/coredump.socket");
+	ASSERT_EQ(ret, strlen("@/tmp/coredump.socket"));
+	ASSERT_EQ(fclose(file), 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		int fd_server;
+		socklen_t fd_peer_pidfd_len;
+
+		close(ipc_sockets[0]);
+
+		fd_server = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+		if (fd_server < 0)
+			_exit(EXIT_FAILURE);
+
+		ret = bind(fd_server, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
+		if (ret < 0) {
+			fprintf(stderr, "Failed to bind coredump socket\n");
+			close(fd_server);
+			close(ipc_sockets[1]);
+			_exit(EXIT_FAILURE);
+		}
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
+			close(fd_server);
+			close(ipc_sockets[1]);
+			_exit(EXIT_FAILURE);
+		}
+
+		close(fd_server);
+		close(ipc_sockets[1]);
+		_exit(EXIT_SUCCESS);
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
+	waitpid(pid_coredump_server, &status, 0);
+	self->pid_coredump_server = -ESRCH;
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2


