Return-Path: <linux-fsdevel+bounces-48407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD0EAAE685
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 18:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593991BC0890
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 16:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C6728C2D7;
	Wed,  7 May 2025 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lv9u8LxM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3903128C2D2;
	Wed,  7 May 2025 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634477; cv=none; b=jnCcl2wghm6I75d8JELT+Z8l2cccm6EmxQYe6d63c4jYWQiUoutdKi11dCUkNaxgrkpZQFXZLqUwtGUd3PKD/+n+0OuREQLd/tPrnETwKRGiAdVtGZYm881oPYaBJm/XbovG02trHFDjaUa1kE4cywSedFeiYiLxXlmNs2L447M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634477; c=relaxed/simple;
	bh=mMQMwLxi2MCFyRld7ql6OOPUv4ZPktnYFa2FfvFYeVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o8giI3/SC8/99UnuueudPj6VixY/z4ilH6Opg/at8NtUxzBeere/y0fIV7LuZzhw/nFLyXnSPQy2g6vyLwJIyeJdO+Ah7VhTOVlor0CdG/gm9moHOKdGjYobyWaEIcVSjdL7dDOT4WXpA3Gmbk1za5df0ueu+Gn47VrsUFTQvdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lv9u8LxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE70C4CEE2;
	Wed,  7 May 2025 16:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746634476;
	bh=mMQMwLxi2MCFyRld7ql6OOPUv4ZPktnYFa2FfvFYeVA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lv9u8LxMkKUcqbP+6wfitDelliIHX6l+NpKakqtT6CWKYqmMuHDE1z+5eCX3b1qHB
	 p8wkA8sjyZ+YJuvX9juivSdIUpky43LcjQC4cR6UIyj43jtJ/DwrfD2BK7+wbb6Wio
	 jIucYMirqzEaECmfck1t8HWA2yxZ/UhuCHMUG96okp01+fAo/w/zflR75hUmQDnXDk
	 /a1FAS+ur8rzXnksfDbeXc+A7g79qFaBjzCHgC/XbvJBxPmmobCuM/WiYtbPL1MqUW
	 s11UZfBTMKQxaYKox2FKi/LReWnJePshNSdyGa3DyEG4a6AMKj6+HifEtA/NKNb6Nb
	 2nZqg7S5VpUxA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 07 May 2025 18:13:44 +0200
Subject: [PATCH v4 11/11] selftests/coredump: add tests for AF_UNIX
 coredumps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-work-coredump-socket-v4-11-af0ef317b2d0@kernel.org>
References: <20250507-work-coredump-socket-v4-0-af0ef317b2d0@kernel.org>
In-Reply-To: <20250507-work-coredump-socket-v4-0-af0ef317b2d0@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, linux-fsdevel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=9262; i=brauner@kernel.org;
 h=from:subject:message-id; bh=mMQMwLxi2MCFyRld7ql6OOPUv4ZPktnYFa2FfvFYeVA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRIt219NXVSxeau3O3e+61X9izbf1SF63yvf7UV09J+L
 omC32/2dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykYg4jw+6j//+9cdxsvWjb
 xDbuUo4T71XUDWPd067lG59kTJa1z2X4K3jy0bG2iX5VcY92v5E1Yzr6Zf6W2WHWLKKVuzkyUmS
 FuQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a simple test for generating coredumps via AF_UNIX sockets.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/coredump/stackdump_test.c | 273 +++++++++++++++++++++-
 1 file changed, 272 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/testing/selftests/coredump/stackdump_test.c
index fe3c728cd6be..a86f4ba0a367 100644
--- a/tools/testing/selftests/coredump/stackdump_test.c
+++ b/tools/testing/selftests/coredump/stackdump_test.c
@@ -5,10 +5,15 @@
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
@@ -35,6 +40,7 @@ static void crashing_child(void)
 FIXTURE(coredump)
 {
 	char original_core_pattern[256];
+	pid_t pid_coredump_server;
 };
 
 FIXTURE_SETUP(coredump)
@@ -44,6 +50,7 @@ FIXTURE_SETUP(coredump)
 	char *dir;
 	int ret;
 
+	self->pid_coredump_server = -ESRCH;
 	file = fopen("/proc/sys/kernel/core_pattern", "r");
 	ASSERT_NE(NULL, file);
 
@@ -61,10 +68,15 @@ FIXTURE_TEARDOWN(coredump)
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
+
 	file = fopen("/proc/sys/kernel/core_pattern", "w");
 	if (!file) {
 		reason = "Unable to open core_pattern";
@@ -154,4 +166,263 @@ TEST_F_TIMEOUT(coredump, stackdump, 120)
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
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL), 0);
+	ASSERT_EQ(mount(NULL, "/tmp", "tmpfs", 0, NULL), 0);
+
+	file = fopen("/proc/sys/kernel/core_pattern", "w");
+	ASSERT_NE(NULL, file);
+
+	ret = fprintf(file, "@linuxafsk/coredump.socket");
+	ASSERT_EQ(ret, strlen("@linuxafsk/coredump.socket"));
+	ASSERT_EQ(fclose(file), 0);
+
+	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		int fd_socket, fd_coredump, fd_peer_pidfd, fd_core_file;
+		__u64 peer_cookie;
+		socklen_t fd_peer_pidfd_len, peer_cookie_len;
+		static const struct sockaddr_un coredump_sk = {
+			.sun_family = AF_UNIX,
+			.sun_path = "\0linuxafsk/coredump.socket",
+		};
+		static const size_t coredump_sk_len =
+			offsetof(struct sockaddr_un, sun_path) +
+			sizeof("linuxafsk/coredump.socket"); /* +1 for leading NUL */
+
+		close(ipc_sockets[0]);
+
+		fd_socket = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+		if (fd_socket < 0)
+			_exit(EXIT_FAILURE);
+
+		ret = bind(fd_socket, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
+		if (ret < 0) {
+			fprintf(stderr, "Failed to bind coredump socket\n");
+			close(fd_socket);
+			close(ipc_sockets[1]);
+			_exit(EXIT_FAILURE);
+		}
+
+		ret = listen(fd_socket, 1);
+		if (ret < 0) {
+			fprintf(stderr, "Failed to listen on coredump socket\n");
+			close(fd_socket);
+			close(ipc_sockets[1]);
+			_exit(EXIT_FAILURE);
+		}
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
+			close(fd_socket);
+			close(ipc_sockets[1]);
+			_exit(EXIT_FAILURE);
+		}
+
+		close(ipc_sockets[1]);
+
+		fd_coredump = accept4(fd_socket, NULL, NULL, SOCK_CLOEXEC);
+		if (fd_coredump < 0) {
+			fprintf(stderr, "Failed to accept coredump socket connection\n");
+			close(fd_socket);
+			_exit(EXIT_FAILURE);
+		}
+
+		peer_cookie_len = sizeof(peer_cookie);
+		ret = getsockopt(fd_coredump, SOL_SOCKET, SO_COOKIE,
+				 &peer_cookie, &peer_cookie_len);
+		if (ret < 0) {
+			fprintf(stderr, "%m - Failed to retrieve cookie for coredump socket connection\n");
+			close(fd_coredump);
+			close(fd_socket);
+			_exit(EXIT_FAILURE);
+		}
+
+		fd_peer_pidfd_len = sizeof(fd_peer_pidfd);
+		ret = getsockopt(fd_coredump, SOL_SOCKET, SO_PEERPIDFD,
+				 &fd_peer_pidfd, &fd_peer_pidfd_len);
+		if (ret < 0) {
+			fprintf(stderr, "%m - Failed to retrieve peer pidfd for coredump socket connection\n");
+			close(fd_coredump);
+			close(fd_socket);
+			_exit(EXIT_FAILURE);
+		}
+
+		memset(&info, 0, sizeof(info));
+		info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
+		ret = ioctl(fd_peer_pidfd, PIDFD_GET_INFO, &info);
+		if (ret < 0) {
+			fprintf(stderr, "Failed to retrieve pidfd info from peer pidfd for coredump socket connection\n");
+			close(fd_coredump);
+			close(fd_socket);
+			close(fd_peer_pidfd);
+			_exit(EXIT_FAILURE);
+		}
+
+		if (!(info.mask & PIDFD_INFO_COREDUMP)) {
+			fprintf(stderr, "Missing coredump information from coredumping task\n");
+			close(fd_coredump);
+			close(fd_socket);
+			close(fd_peer_pidfd);
+			_exit(EXIT_FAILURE);
+		}
+
+		if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
+			fprintf(stderr, "Received connection from non-coredumping task\n");
+			close(fd_coredump);
+			close(fd_socket);
+			close(fd_peer_pidfd);
+			_exit(EXIT_FAILURE);
+		}
+
+		if (!info.coredump_cookie) {
+			fprintf(stderr, "Missing coredump cookie\n");
+			close(fd_coredump);
+			close(fd_socket);
+			close(fd_peer_pidfd);
+			_exit(EXIT_FAILURE);
+		}
+
+		if (info.coredump_cookie != peer_cookie) {
+			fprintf(stderr, "Mismatching coredump cookies\n");
+			close(fd_coredump);
+			close(fd_socket);
+			close(fd_peer_pidfd);
+			_exit(EXIT_FAILURE);
+		}
+
+		fd_core_file = creat("/tmp/coredump.file", 0644);
+		if (fd_core_file < 0) {
+			fprintf(stderr, "Failed to create coredump file\n");
+			close(fd_coredump);
+			close(fd_socket);
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
+				close(fd_socket);
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
+				close(fd_socket);
+				close(fd_peer_pidfd);
+				close(fd_core_file);
+				_exit(EXIT_FAILURE);
+			}
+		}
+
+		close(fd_coredump);
+		close(fd_socket);
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
+TEST_F(coredump, socket_econnrefused)
+{
+	int fd_socket;
+	static const struct sockaddr_un linuxafsk = {
+		.sun_family = AF_UNIX,
+		.sun_path = "\0linuxafsk/",
+	};
+	static const size_t linuxafsk_len =
+		offsetof(struct sockaddr_un, sun_path) +
+		sizeof("linuxafsk/"); /* +1 for leading NUL */
+
+	fd_socket = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	ASSERT_GT(fd_socket, 0);
+
+	ASSERT_NE(bind(fd_socket, (const struct sockaddr *)&linuxafsk, linuxafsk_len), 0);
+	ASSERT_EQ(errno, ECONNREFUSED);
+	EXPECT_EQ(close(fd_socket), 0);
+}
+
+TEST_F(coredump, socket_econnrefused_privilege)
+{
+	int fd_socket;
+	static const struct sockaddr_un linuxafsk = {
+		.sun_family = AF_UNIX,
+		.sun_path = "\0linuxafsk/nope",
+	};
+	static const size_t linuxafsk_len =
+		offsetof(struct sockaddr_un, sun_path) +
+		sizeof("linuxafsk/nope"); /* +1 for leading NUL */
+
+	ASSERT_EQ(seteuid(1234), 0);
+
+	fd_socket = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	ASSERT_GT(fd_socket, 0);
+
+	ASSERT_NE(bind(fd_socket, (const struct sockaddr *)&linuxafsk, linuxafsk_len), 0);
+	ASSERT_EQ(errno, ECONNREFUSED);
+	EXPECT_EQ(close(fd_socket), 0);
+
+	ASSERT_EQ(seteuid(0), 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2


