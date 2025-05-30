Return-Path: <linux-fsdevel+bounces-50220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E273AC8CA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 13:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54FAB9E7688
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD50F22A4E4;
	Fri, 30 May 2025 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmveTWy0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4860B19AD70
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748603437; cv=none; b=CajewojRA8OMnPUnA0NOCnGg97Tazlmgrt4jyuthSn43GLwrJtnDzOY4AoTBV3Ip5sl57ywaBBh7SFtWMSsePQDA6vE641DtbYxu5BoZm1oEtyAUsYdMoLqHfwtFS9mZS7D35yG/wb4gyd8LkhbGJ9w+ugWvdlBQkkCPH7r6l9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748603437; c=relaxed/simple;
	bh=OH5lLRpp+Z71AtWQGzqPQ1JDwCd+6a5pxYrF5gg5xsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iUnX1QFiASeqmsJjnXxVu7jWeQufDEohwtxjWYkQlJzz6d9I+ASYqwgX8nesR8juu1kWYbuATSKF2mi9Ts8z7FJP3TCbMz0+L+0E6vhilcCFGkgrc3hf78xtxIiCtEfRZQQ38vgHQaW30UyU2d3Pu9MmxQ7JNJiIuFaGi4W6pxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmveTWy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D9DC4CEEB;
	Fri, 30 May 2025 11:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748603436;
	bh=OH5lLRpp+Z71AtWQGzqPQ1JDwCd+6a5pxYrF5gg5xsk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tmveTWy0Es8e7IkJt7ruyZxRrqxkpARfayLFuxnTEfwcoUgWH7aM/kDTuztso4D+Y
	 rMNfs19DrpG8RICzC/lTFruueJwl/DJN2e/3km1E+yf1mjo1gA/9d3XBH82fDEsRQo
	 NcxnR3/kP+0XtSP4/s0y+ajfgFXtXHw8PfOtAqmYpcdWRg7rYIZd/3CuKrS8vg+BRB
	 3ZPnd4fFoEA8kbVkyKu0sDTV1reyGOuZ9anPyqL12G9aHbzSx3Tzj0mNHUm8PqURPB
	 Exw7+9eFBqmeQCxlnUBZwosHH2XKFlkBZSjwEpp2Pv2ax0/e04bTR9a6wtfm7V6QFN
	 g5K0x5NQatlqA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 May 2025 13:10:01 +0200
Subject: [PATCH 3/5] selftests/coredump: cleanup coredump tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-work-coredump-socket-protocol-v1-3-20bde1cd4faa@kernel.org>
References: <20250530-work-coredump-socket-protocol-v1-0-20bde1cd4faa@kernel.org>
In-Reply-To: <20250530-work-coredump-socket-protocol-v1-0-20bde1cd4faa@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Jan Kara <jack@suse.cz>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=17369; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OH5lLRpp+Z71AtWQGzqPQ1JDwCd+6a5pxYrF5gg5xsk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRYTlJgl8wNCTvwodnM+MW793uuCtks5bFfk3Xk9P4JC
 Woh9qfOd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkzmtGhot928IvrXt322aW
 qbFqv2PRnqSMRi2jrdlbnKUmsT9Kes7IsMm95LD9jDxmmeectrMsZqhOXWfgZfgi2Ku9oOTy4hv
 CrAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make the selftests we added this cycle easier to read.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/coredump/stackdump_test.c | 409 +++++++++-------------
 1 file changed, 174 insertions(+), 235 deletions(-)

diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/testing/selftests/coredump/stackdump_test.c
index aa366e6f13a7..4d922e5f89fe 100644
--- a/tools/testing/selftests/coredump/stackdump_test.c
+++ b/tools/testing/selftests/coredump/stackdump_test.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <assert.h>
 #include <fcntl.h>
 #include <inttypes.h>
 #include <libgen.h>
@@ -20,6 +21,10 @@
 #define STACKDUMP_SCRIPT "stackdump"
 #define NUM_THREAD_SPAWN 128
 
+#ifndef PAGE_SIZE
+#define PAGE_SIZE 4096
+#endif
+
 static void *do_nothing(void *)
 {
 	while (1)
@@ -109,7 +114,7 @@ TEST_F_TIMEOUT(coredump, stackdump, 120)
 	unsigned long long stack;
 	char *test_dir, *line;
 	size_t line_length;
-	char buf[PATH_MAX];
+	char buf[PAGE_SIZE];
 	int ret, i, status;
 	FILE *file;
 	pid_t pid;
@@ -168,152 +173,163 @@ TEST_F_TIMEOUT(coredump, stackdump, 120)
 	fclose(file);
 }
 
+static int create_and_listen_unix_socket(const char *path)
+{
+	struct sockaddr_un addr = {
+		.sun_family = AF_UNIX,
+	};
+	assert(strlen(path) < sizeof(addr.sun_path) - 1);
+	strncpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
+	size_t addr_len =
+		offsetof(struct sockaddr_un, sun_path) + strlen(path) + 1;
+	int fd, ret;
+
+	fd = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	if (fd < 0)
+		goto out;
+
+	ret = bind(fd, (const struct sockaddr *)&addr, addr_len);
+	if (ret < 0)
+		goto out;
+
+	ret = listen(fd, 1);
+	if (ret < 0)
+		goto out;
+
+	return fd;
+
+out:
+	if (fd >= 0)
+		close(fd);
+	return -1;
+}
+
+static bool set_core_pattern(const char *pattern)
+{
+	FILE *file;
+	int ret;
+
+	file = fopen("/proc/sys/kernel/core_pattern", "w");
+	if (!file)
+		return false;
+
+	ret = fprintf(file, "%s", pattern);
+	fclose(file);
+
+	return ret == strlen(pattern);
+}
+
+static int get_peer_pidfd(int fd)
+{
+	int fd_peer_pidfd;
+	socklen_t fd_peer_pidfd_len = sizeof(fd_peer_pidfd);
+	int ret = getsockopt(fd, SOL_SOCKET, SO_PEERPIDFD, &fd_peer_pidfd,
+			     &fd_peer_pidfd_len);
+	if (ret < 0) {
+		fprintf(stderr, "%m - Failed to retrieve peer pidfd for coredump socket connection\n");
+		return -1;
+	}
+	return fd_peer_pidfd;
+}
+
+static bool get_pidfd_info(int fd_peer_pidfd, struct pidfd_info *info)
+{
+	memset(info, 0, sizeof(*info));
+	info->mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
+	return ioctl(fd_peer_pidfd, PIDFD_GET_INFO, info) == 0;
+}
+
+static void
+wait_and_check_coredump_server(pid_t pid_coredump_server,
+			       struct __test_metadata *const _metadata,
+			       FIXTURE_DATA(coredump)* self)
+{
+	int status;
+	waitpid(pid_coredump_server, &status, 0);
+	self->pid_coredump_server = -ESRCH;
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+}
+
 TEST_F(coredump, socket)
 {
 	int pidfd, ret, status;
-	FILE *file;
 	pid_t pid, pid_coredump_server;
 	struct stat st;
 	struct pidfd_info info = {};
 	int ipc_sockets[2];
 	char c;
-	const struct sockaddr_un coredump_sk = {
-		.sun_family = AF_UNIX,
-		.sun_path = "/tmp/coredump.socket",
-	};
-	size_t coredump_sk_len = offsetof(struct sockaddr_un, sun_path) +
-				 sizeof("/tmp/coredump.socket");
+
+	ASSERT_TRUE(set_core_pattern("@/tmp/coredump.socket"));
 
 	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
 	ASSERT_EQ(ret, 0);
 
-	file = fopen("/proc/sys/kernel/core_pattern", "w");
-	ASSERT_NE(file, NULL);
-
-	ret = fprintf(file, "@/tmp/coredump.socket");
-	ASSERT_EQ(ret, strlen("@/tmp/coredump.socket"));
-	ASSERT_EQ(fclose(file), 0);
-
 	pid_coredump_server = fork();
 	ASSERT_GE(pid_coredump_server, 0);
 	if (pid_coredump_server == 0) {
-		int fd_server, fd_coredump, fd_peer_pidfd, fd_core_file;
-		socklen_t fd_peer_pidfd_len;
+		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1, fd_core_file = -1;
+		int exit_code = EXIT_FAILURE;
 
 		close(ipc_sockets[0]);
 
-		fd_server = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
 		if (fd_server < 0)
-			_exit(EXIT_FAILURE);
-
-		ret = bind(fd_server, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
-		if (ret < 0) {
-			fprintf(stderr, "Failed to bind coredump socket\n");
-			close(fd_server);
-			close(ipc_sockets[1]);
-			_exit(EXIT_FAILURE);
-		}
-
-		ret = listen(fd_server, 1);
-		if (ret < 0) {
-			fprintf(stderr, "Failed to listen on coredump socket\n");
-			close(fd_server);
-			close(ipc_sockets[1]);
-			_exit(EXIT_FAILURE);
-		}
+			goto out;
 
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
-			close(fd_server);
-			close(ipc_sockets[1]);
-			_exit(EXIT_FAILURE);
-		}
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+			goto out;
 
 		close(ipc_sockets[1]);
 
 		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0) {
-			fprintf(stderr, "Failed to accept coredump socket connection\n");
-			close(fd_server);
-			_exit(EXIT_FAILURE);
-		}
+		if (fd_coredump < 0)
+			goto out;
 
-		fd_peer_pidfd_len = sizeof(fd_peer_pidfd);
-		ret = getsockopt(fd_coredump, SOL_SOCKET, SO_PEERPIDFD,
-				 &fd_peer_pidfd, &fd_peer_pidfd_len);
-		if (ret < 0) {
-			fprintf(stderr, "%m - Failed to retrieve peer pidfd for coredump socket connection\n");
-			close(fd_coredump);
-			close(fd_server);
-			_exit(EXIT_FAILURE);
-		}
+		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
+		if (fd_peer_pidfd < 0)
+			goto out;
 
-		memset(&info, 0, sizeof(info));
-		info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
-		ret = ioctl(fd_peer_pidfd, PIDFD_GET_INFO, &info);
-		if (ret < 0) {
-			fprintf(stderr, "Failed to retrieve pidfd info from peer pidfd for coredump socket connection\n");
-			close(fd_coredump);
-			close(fd_server);
-			close(fd_peer_pidfd);
-			_exit(EXIT_FAILURE);
-		}
+		if (!get_pidfd_info(fd_peer_pidfd, &info))
+			goto out;
 
-		if (!(info.mask & PIDFD_INFO_COREDUMP)) {
-			fprintf(stderr, "Missing coredump information from coredumping task\n");
-			close(fd_coredump);
-			close(fd_server);
-			close(fd_peer_pidfd);
-			_exit(EXIT_FAILURE);
-		}
+		if (!(info.mask & PIDFD_INFO_COREDUMP))
+			goto out;
 
-		if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
-			fprintf(stderr, "Received connection from non-coredumping task\n");
-			close(fd_coredump);
-			close(fd_server);
-			close(fd_peer_pidfd);
-			_exit(EXIT_FAILURE);
-		}
+		if (!(info.coredump_mask & PIDFD_COREDUMPED))
+			goto out;
 
 		fd_core_file = creat("/tmp/coredump.file", 0644);
-		if (fd_core_file < 0) {
-			fprintf(stderr, "Failed to create coredump file\n");
-			close(fd_coredump);
-			close(fd_server);
-			close(fd_peer_pidfd);
-			_exit(EXIT_FAILURE);
-		}
+		if (fd_core_file < 0)
+			goto out;
 
 		for (;;) {
 			char buffer[4096];
 			ssize_t bytes_read, bytes_write;
 
 			bytes_read = read(fd_coredump, buffer, sizeof(buffer));
-			if (bytes_read < 0) {
-				close(fd_coredump);
-				close(fd_server);
-				close(fd_peer_pidfd);
-				close(fd_core_file);
-				_exit(EXIT_FAILURE);
-			}
+			if (bytes_read < 0)
+				goto out;
 
 			if (bytes_read == 0)
 				break;
 
 			bytes_write = write(fd_core_file, buffer, bytes_read);
-			if (bytes_read != bytes_write) {
-				close(fd_coredump);
-				close(fd_server);
-				close(fd_peer_pidfd);
-				close(fd_core_file);
-				_exit(EXIT_FAILURE);
-			}
+			if (bytes_read != bytes_write)
+				goto out;
 		}
 
-		close(fd_coredump);
-		close(fd_server);
-		close(fd_peer_pidfd);
-		close(fd_core_file);
-		_exit(EXIT_SUCCESS);
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
 	}
 	self->pid_coredump_server = pid_coredump_server;
 
@@ -333,47 +349,27 @@ TEST_F(coredump, socket)
 	ASSERT_TRUE(WIFSIGNALED(status));
 	ASSERT_TRUE(WCOREDUMP(status));
 
-	info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
-	ASSERT_EQ(ioctl(pidfd, PIDFD_GET_INFO, &info), 0);
+	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
 	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
 	ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
 
-	waitpid(pid_coredump_server, &status, 0);
-	self->pid_coredump_server = -ESRCH;
-	ASSERT_TRUE(WIFEXITED(status));
-	ASSERT_EQ(WEXITSTATUS(status), 0);
+	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
 
 	ASSERT_EQ(stat("/tmp/coredump.file", &st), 0);
 	ASSERT_GT(st.st_size, 0);
-	/*
-	 * We should somehow validate the produced core file.
-	 * For now just allow for visual inspection
-	 */
 	system("file /tmp/coredump.file");
 }
 
 TEST_F(coredump, socket_detect_userspace_client)
 {
 	int pidfd, ret, status;
-	FILE *file;
 	pid_t pid, pid_coredump_server;
 	struct stat st;
 	struct pidfd_info info = {};
 	int ipc_sockets[2];
 	char c;
-	const struct sockaddr_un coredump_sk = {
-		.sun_family = AF_UNIX,
-		.sun_path = "/tmp/coredump.socket",
-	};
-	size_t coredump_sk_len = offsetof(struct sockaddr_un, sun_path) +
-				 sizeof("/tmp/coredump.socket");
 
-	file = fopen("/proc/sys/kernel/core_pattern", "w");
-	ASSERT_NE(file, NULL);
-
-	ret = fprintf(file, "@/tmp/coredump.socket");
-	ASSERT_EQ(ret, strlen("@/tmp/coredump.socket"));
-	ASSERT_EQ(fclose(file), 0);
+	ASSERT_TRUE(set_core_pattern("@/tmp/coredump.socket"));
 
 	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
 	ASSERT_EQ(ret, 0);
@@ -381,87 +377,46 @@ TEST_F(coredump, socket_detect_userspace_client)
 	pid_coredump_server = fork();
 	ASSERT_GE(pid_coredump_server, 0);
 	if (pid_coredump_server == 0) {
-		int fd_server, fd_coredump, fd_peer_pidfd;
-		socklen_t fd_peer_pidfd_len;
+		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
+		int exit_code = EXIT_FAILURE;
 
 		close(ipc_sockets[0]);
 
-		fd_server = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
 		if (fd_server < 0)
-			_exit(EXIT_FAILURE);
+			goto out;
 
-		ret = bind(fd_server, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
-		if (ret < 0) {
-			fprintf(stderr, "Failed to bind coredump socket\n");
-			close(fd_server);
-			close(ipc_sockets[1]);
-			_exit(EXIT_FAILURE);
-		}
-
-		ret = listen(fd_server, 1);
-		if (ret < 0) {
-			fprintf(stderr, "Failed to listen on coredump socket\n");
-			close(fd_server);
-			close(ipc_sockets[1]);
-			_exit(EXIT_FAILURE);
-		}
-
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
-			close(fd_server);
-			close(ipc_sockets[1]);
-			_exit(EXIT_FAILURE);
-		}
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+			goto out;
 
 		close(ipc_sockets[1]);
 
 		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0) {
-			fprintf(stderr, "Failed to accept coredump socket connection\n");
-			close(fd_server);
-			_exit(EXIT_FAILURE);
-		}
+		if (fd_coredump < 0)
+			goto out;
 
-		fd_peer_pidfd_len = sizeof(fd_peer_pidfd);
-		ret = getsockopt(fd_coredump, SOL_SOCKET, SO_PEERPIDFD,
-				 &fd_peer_pidfd, &fd_peer_pidfd_len);
-		if (ret < 0) {
-			fprintf(stderr, "%m - Failed to retrieve peer pidfd for coredump socket connection\n");
-			close(fd_coredump);
-			close(fd_server);
-			_exit(EXIT_FAILURE);
-		}
+		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
+		if (fd_peer_pidfd < 0)
+			goto out;
 
-		memset(&info, 0, sizeof(info));
-		info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
-		ret = ioctl(fd_peer_pidfd, PIDFD_GET_INFO, &info);
-		if (ret < 0) {
-			fprintf(stderr, "Failed to retrieve pidfd info from peer pidfd for coredump socket connection\n");
-			close(fd_coredump);
-			close(fd_server);
-			close(fd_peer_pidfd);
-			_exit(EXIT_FAILURE);
-		}
+		if (!get_pidfd_info(fd_peer_pidfd, &info))
+			goto out;
 
-		if (!(info.mask & PIDFD_INFO_COREDUMP)) {
-			fprintf(stderr, "Missing coredump information from coredumping task\n");
-			close(fd_coredump);
-			close(fd_server);
-			close(fd_peer_pidfd);
-			_exit(EXIT_FAILURE);
-		}
+		if (!(info.mask & PIDFD_INFO_COREDUMP))
+			goto out;
 
-		if (info.coredump_mask & PIDFD_COREDUMPED) {
-			fprintf(stderr, "Received unexpected connection from coredumping task\n");
+		if (info.coredump_mask & PIDFD_COREDUMPED)
+			goto out;
+
+		exit_code = EXIT_SUCCESS;
+out:
+		if (fd_peer_pidfd >= 0)
+			close(fd_peer_pidfd);
+		if (fd_coredump >= 0)
 			close(fd_coredump);
+		if (fd_server >= 0)
 			close(fd_server);
-			close(fd_peer_pidfd);
-			_exit(EXIT_FAILURE);
-		}
-
-		close(fd_coredump);
-		close(fd_server);
-		close(fd_peer_pidfd);
-		_exit(EXIT_SUCCESS);
+		_exit(exit_code);
 	}
 	self->pid_coredump_server = pid_coredump_server;
 
@@ -474,12 +429,18 @@ TEST_F(coredump, socket_detect_userspace_client)
 	if (pid == 0) {
 		int fd_socket;
 		ssize_t ret;
+		const struct sockaddr_un coredump_sk = {
+			.sun_family = AF_UNIX,
+			.sun_path = "/tmp/coredump.socket",
+		};
+		size_t coredump_sk_len =
+			offsetof(struct sockaddr_un, sun_path) +
+			sizeof("/tmp/coredump.socket");
 
 		fd_socket = socket(AF_UNIX, SOCK_STREAM, 0);
 		if (fd_socket < 0)
 			_exit(EXIT_FAILURE);
 
-
 		ret = connect(fd_socket, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
 		if (ret < 0)
 			_exit(EXIT_FAILURE);
@@ -495,15 +456,11 @@ TEST_F(coredump, socket_detect_userspace_client)
 	ASSERT_TRUE(WIFEXITED(status));
 	ASSERT_EQ(WEXITSTATUS(status), 0);
 
-	info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
-	ASSERT_EQ(ioctl(pidfd, PIDFD_GET_INFO, &info), 0);
+	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
 	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
 	ASSERT_EQ((info.coredump_mask & PIDFD_COREDUMPED), 0);
 
-	waitpid(pid_coredump_server, &status, 0);
-	self->pid_coredump_server = -ESRCH;
-	ASSERT_TRUE(WIFEXITED(status));
-	ASSERT_EQ(WEXITSTATUS(status), 0);
+	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
 
 	ASSERT_NE(stat("/tmp/coredump.file", &st), 0);
 	ASSERT_EQ(errno, ENOENT);
@@ -511,16 +468,10 @@ TEST_F(coredump, socket_detect_userspace_client)
 
 TEST_F(coredump, socket_enoent)
 {
-	int pidfd, ret, status;
-	FILE *file;
+	int pidfd, status;
 	pid_t pid;
 
-	file = fopen("/proc/sys/kernel/core_pattern", "w");
-	ASSERT_NE(file, NULL);
-
-	ret = fprintf(file, "@/tmp/coredump.socket");
-	ASSERT_EQ(ret, strlen("@/tmp/coredump.socket"));
-	ASSERT_EQ(fclose(file), 0);
+	ASSERT_TRUE(set_core_pattern("@/tmp/coredump.socket"));
 
 	pid = fork();
 	ASSERT_GE(pid, 0);
@@ -538,7 +489,6 @@ TEST_F(coredump, socket_enoent)
 TEST_F(coredump, socket_no_listener)
 {
 	int pidfd, ret, status;
-	FILE *file;
 	pid_t pid, pid_coredump_server;
 	int ipc_sockets[2];
 	char c;
@@ -549,44 +499,36 @@ TEST_F(coredump, socket_no_listener)
 	size_t coredump_sk_len = offsetof(struct sockaddr_un, sun_path) +
 				 sizeof("/tmp/coredump.socket");
 
+	ASSERT_TRUE(set_core_pattern("@/tmp/coredump.socket"));
+
 	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
 	ASSERT_EQ(ret, 0);
 
-	file = fopen("/proc/sys/kernel/core_pattern", "w");
-	ASSERT_NE(file, NULL);
-
-	ret = fprintf(file, "@/tmp/coredump.socket");
-	ASSERT_EQ(ret, strlen("@/tmp/coredump.socket"));
-	ASSERT_EQ(fclose(file), 0);
-
 	pid_coredump_server = fork();
 	ASSERT_GE(pid_coredump_server, 0);
 	if (pid_coredump_server == 0) {
-		int fd_server;
+		int fd_server = -1;
+		int exit_code = EXIT_FAILURE;
 
 		close(ipc_sockets[0]);
 
 		fd_server = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
 		if (fd_server < 0)
-			_exit(EXIT_FAILURE);
+			goto out;
 
 		ret = bind(fd_server, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
-		if (ret < 0) {
-			fprintf(stderr, "Failed to bind coredump socket\n");
-			close(fd_server);
-			close(ipc_sockets[1]);
-			_exit(EXIT_FAILURE);
-		}
+		if (ret < 0)
+			goto out;
 
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
-			close(fd_server);
-			close(ipc_sockets[1]);
-			_exit(EXIT_FAILURE);
-		}
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+			goto out;
 
-		close(fd_server);
+		exit_code = EXIT_SUCCESS;
+out:
+		if (fd_server >= 0)
+			close(fd_server);
 		close(ipc_sockets[1]);
-		_exit(EXIT_SUCCESS);
+		_exit(exit_code);
 	}
 	self->pid_coredump_server = pid_coredump_server;
 
@@ -606,10 +548,7 @@ TEST_F(coredump, socket_no_listener)
 	ASSERT_TRUE(WIFSIGNALED(status));
 	ASSERT_FALSE(WCOREDUMP(status));
 
-	waitpid(pid_coredump_server, &status, 0);
-	self->pid_coredump_server = -ESRCH;
-	ASSERT_TRUE(WIFEXITED(status));
-	ASSERT_EQ(WEXITSTATUS(status), 0);
+	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
 }
 
 TEST_HARNESS_MAIN

-- 
2.47.2


