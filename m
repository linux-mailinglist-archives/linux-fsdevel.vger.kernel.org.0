Return-Path: <linux-fsdevel+bounces-48715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E02FAB3279
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 10:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A76D167E27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 08:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1336264FAB;
	Mon, 12 May 2025 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NodzJqK7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393EF25A2BA;
	Mon, 12 May 2025 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747040189; cv=none; b=XMcFrFElDhvTFscUKj0HojrAS/m3YdY1NQDaRSScP88fkjIEqnibaVLxIVUM3RMY8co5bhfP418bc3CjhEzuFLqpfbOlXqUHDMe0bh6hN0JE3dIrE2pBxvtb6sZ8wbmODNh4Bn55XExe5kO9k5fVgYvlJHu2dE/U49PBUgdTubg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747040189; c=relaxed/simple;
	bh=q/v2mAlkLcg0KsGCqgczqMc5SELp2xv2/mYAT5TDFss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dhJ9QQmb1cTwP8upfuCWktQwcSityjbxqLOPfMCsdP1mJzTC/1tGeYhUf5bHqYU/7Y/IcjPYaBT1EhC1b2b36WZK2BpIxd1cdwFFsTDOMb3XJ1zBjJMwZ5Xe2TTyXTDVVN2keVk7jUeqsi8TgwJEDYWS+MLq4gUk/PkrAGI3K4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NodzJqK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37483C4CEE9;
	Mon, 12 May 2025 08:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747040189;
	bh=q/v2mAlkLcg0KsGCqgczqMc5SELp2xv2/mYAT5TDFss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NodzJqK7fyaSDTRsaymrYOX+v1fpWq22DMFIVaIstRiYXJXa21WlyVtvLsI/3En4p
	 oHnRw5Vm+NRL/9VmgCSW/cbzuRIgPGoh1uY5ox/n8oWe3c2KRf2dv5BIkG7R4AHxw+
	 YUu+IH9BOtW3STnAMJTvy/j4oy6OwAKjg7cprzzKAJZ+ZEJAsw+EUZU2rG/hI/vSk6
	 hlOrtsLzJvEDwxbaXU6+CHnD3SLAJMw+FwMQ9aq41Gbe82zHsywkSxklDSuEloxWJx
	 eOfmizMhfvzupVJUyB0S2TgWhvAwKPFVp9tt9Kd1KKz/BiOwF5061gDAHuV7/QNkii
	 /QHW1Gt9ystmw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 May 2025 10:55:28 +0200
Subject: [PATCH v6 9/9] selftests/coredump: add tests for AF_UNIX coredumps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250512-work-coredump-socket-v6-9-c51bc3450727@kernel.org>
References: <20250512-work-coredump-socket-v6-0-c51bc3450727@kernel.org>
In-Reply-To: <20250512-work-coredump-socket-v6-0-c51bc3450727@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
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
 linux-security-module@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=29673; i=brauner@kernel.org;
 h=from:subject:message-id; bh=q/v2mAlkLcg0KsGCqgczqMc5SELp2xv2/mYAT5TDFss=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQobm8//rnNuGX/V9dJmRcNHjRFaHSnNVn3qW19cG3Wf
 c8yD69THaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPRvcDI0GJwunp2jei5i9zr
 fRqCHoc8Orr+lPBM7/d7r1+NdZTqqGH4H67VE/2ajSFAy1XKdbvcJku/txE/LgY+07jEG+Q1beF
 FHgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a simple test for generating coredumps via AF_UNIX sockets.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/coredump/stackdump_test.c | 956 +++++++++++++++++++++-
 1 file changed, 955 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/testing/selftests/coredump/stackdump_test.c
index fe3c728cd6be..5a74612ae42e 100644
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
 
@@ -61,10 +69,15 @@ FIXTURE_TEARDOWN(coredump)
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
@@ -154,4 +167,945 @@ TEST_F_TIMEOUT(coredump, stackdump, 120)
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
+	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		int fd_server, fd_coredump, fd_peer_pidfd, fd_core_file;
+		__u64 peer_cookie, server_cookie;
+		socklen_t fd_peer_pidfd_len, peer_cookie_len, server_cookie_len;
+		struct sockaddr_un coredump_sk = {
+			.sun_family = AF_UNIX,
+		};
+		size_t coredump_sk_len;
+
+		close(ipc_sockets[0]);
+
+		fd_server = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+		if (fd_server < 0)
+			_exit(EXIT_FAILURE);
+
+		server_cookie_len = sizeof(server_cookie);
+		ret = getsockopt(fd_server, SOL_SOCKET, SO_COOKIE,
+				 &server_cookie, &server_cookie_len);
+		if (ret < 0) {
+			fprintf(stderr, "%m - Failed to retrieve cookie for coredump socket server\n");
+			close(fd_server);
+			_exit(EXIT_FAILURE);
+		}
+
+		coredump_sk_len = snprintf(coredump_sk.sun_path,
+					   sizeof(coredump_sk.sun_path),
+					   "@coredump.socket %" PRIu64, server_cookie);
+		if (coredump_sk_len < 0 || coredump_sk_len >= sizeof(coredump_sk.sun_path)) {
+			fprintf(stderr, "Unable to create coredump socket path\n");
+			close(fd_server);
+			_exit(EXIT_FAILURE);
+		}
+
+		file = fopen("/proc/sys/kernel/core_pattern", "w");
+		if (!file) {
+			fprintf(stderr, "Unable to open core_pattern\n");
+			close(fd_server);
+			_exit(EXIT_FAILURE);
+		}
+
+		ret = fprintf(file, "%s", coredump_sk.sun_path);
+		fclose(file);
+		if (ret < 0) {
+			fprintf(stderr, "Unable to write to core_pattern\n");
+			close(fd_server);
+			_exit(EXIT_FAILURE);
+		}
+
+		coredump_sk.sun_path[0] = '\0';
+		memcpy(coredump_sk.sun_path, "\0coredump.socket", sizeof("coredump.socket"));
+		coredump_sk_len = offsetof(struct sockaddr_un, sun_path) + sizeof("coredump.socket");
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
+		peer_cookie_len = sizeof(peer_cookie);
+		ret = getsockopt(fd_coredump, SOL_SOCKET, SO_COOKIE,
+				 &peer_cookie, &peer_cookie_len);
+		if (ret < 0) {
+			fprintf(stderr, "%m - Failed to retrieve cookie for coredump socket connection\n");
+			close(fd_coredump);
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
+		if (!info.coredump_cookie) {
+			fprintf(stderr, "Missing coredump cookie\n");
+			close(fd_coredump);
+			close(fd_server);
+			close(fd_peer_pidfd);
+			_exit(EXIT_FAILURE);
+		}
+
+		if (info.coredump_cookie != peer_cookie) {
+			fprintf(stderr, "Mismatching coredump cookies\n");
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
+TEST_F(coredump, socket_recycled_cookie)
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
+	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		int fd_server, fd_coredump, fd_peer_pidfd, fd_core_file;
+		__u64 peer_cookie, server_cookie;
+		socklen_t fd_peer_pidfd_len, peer_cookie_len, server_cookie_len;
+		struct sockaddr_un coredump_sk = {
+			.sun_family = AF_UNIX,
+		};
+		size_t coredump_sk_len;
+
+		close(ipc_sockets[0]);
+
+		fd_server = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+		if (fd_server < 0)
+			_exit(EXIT_FAILURE);
+
+		server_cookie_len = sizeof(server_cookie);
+		ret = getsockopt(fd_server, SOL_SOCKET, SO_COOKIE,
+				 &server_cookie, &server_cookie_len);
+		if (ret < 0) {
+			fprintf(stderr, "%m - Failed to retrieve cookie for coredump socket server\n");
+			close(fd_server);
+			_exit(EXIT_FAILURE);
+		}
+
+		/* Write invalid socket cookie to core_pattern. */
+		coredump_sk_len = snprintf(coredump_sk.sun_path,
+					   sizeof(coredump_sk.sun_path),
+					   "@coredump.socket %" PRIu64, 0);
+		if (coredump_sk_len < 0 || coredump_sk_len >= sizeof(coredump_sk.sun_path)) {
+			fprintf(stderr, "Unable to create coredump socket path\n");
+			close(fd_server);
+			_exit(EXIT_FAILURE);
+		}
+
+		file = fopen("/proc/sys/kernel/core_pattern", "w");
+		if (!file) {
+			fprintf(stderr, "Unable to open core_pattern\n");
+			close(fd_server);
+			_exit(EXIT_FAILURE);
+		}
+
+		ret = fprintf(file, "%s", coredump_sk.sun_path);
+		fclose(file);
+		if (ret < 0) {
+			fprintf(stderr, "Unable to write to core_pattern\n");
+			close(fd_server);
+			_exit(EXIT_FAILURE);
+		}
+
+		coredump_sk.sun_path[0] = '\0';
+		memcpy(coredump_sk.sun_path, "\0coredump.socket", sizeof("coredump.socket"));
+		coredump_sk_len = offsetof(struct sockaddr_un, sun_path) + sizeof("coredump.socket");
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
+		peer_cookie_len = sizeof(peer_cookie);
+		ret = getsockopt(fd_coredump, SOL_SOCKET, SO_COOKIE,
+				 &peer_cookie, &peer_cookie_len);
+		if (ret < 0) {
+			fprintf(stderr, "%m - Failed to retrieve cookie for coredump socket connection\n");
+			close(fd_coredump);
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
+		if (!info.coredump_cookie) {
+			fprintf(stderr, "Missing coredump cookie\n");
+			close(fd_coredump);
+			close(fd_server);
+			close(fd_peer_pidfd);
+			_exit(EXIT_FAILURE);
+		}
+
+		if (info.coredump_cookie != peer_cookie) {
+			fprintf(stderr, "Mismatching coredump cookies\n");
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
+	ASSERT_FALSE(WCOREDUMP(status));
+
+	info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
+	ASSERT_EQ(ioctl(pidfd, PIDFD_GET_INFO, &info), 0);
+	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
+	ASSERT_EQ((info.coredump_mask & PIDFD_COREDUMPED), 0);
+
+	ASSERT_EQ(kill(pid_coredump_server, SIGKILL), 0);
+	waitpid(pid_coredump_server, &status, 0);
+	self->pid_coredump_server = -ESRCH;
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_EQ(WTERMSIG(status), SIGKILL);
+
+	ASSERT_NE(stat("/tmp/coredump.file", &st), 0);
+	ASSERT_EQ(errno, ENOENT);
+}
+
+TEST_F(coredump, socket_missing_cookie)
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
+	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		int fd_server, fd_coredump, fd_peer_pidfd, fd_core_file;
+		__u64 peer_cookie, server_cookie;
+		socklen_t fd_peer_pidfd_len, peer_cookie_len, server_cookie_len;
+		struct sockaddr_un coredump_sk = {
+			.sun_family = AF_UNIX,
+		};
+		size_t coredump_sk_len;
+
+		close(ipc_sockets[0]);
+
+		fd_server = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+		if (fd_server < 0)
+			_exit(EXIT_FAILURE);
+
+		server_cookie_len = sizeof(server_cookie);
+		ret = getsockopt(fd_server, SOL_SOCKET, SO_COOKIE,
+				 &server_cookie, &server_cookie_len);
+		if (ret < 0) {
+			fprintf(stderr, "%m - Failed to retrieve cookie for coredump socket server\n");
+			close(fd_server);
+			_exit(EXIT_FAILURE);
+		}
+
+		/* Don't write socket cookie to core_pattern. */
+		coredump_sk_len = snprintf(coredump_sk.sun_path,
+					   sizeof(coredump_sk.sun_path),
+					   "@coredump.socket");
+		if (coredump_sk_len < 0 || coredump_sk_len >= sizeof(coredump_sk.sun_path)) {
+			fprintf(stderr, "Unable to create coredump socket path\n");
+			close(fd_server);
+			_exit(EXIT_FAILURE);
+		}
+
+		file = fopen("/proc/sys/kernel/core_pattern", "w");
+		if (!file) {
+			fprintf(stderr, "Unable to open core_pattern\n");
+			close(fd_server);
+			_exit(EXIT_FAILURE);
+		}
+
+		ret = fprintf(file, "%s", coredump_sk.sun_path);
+		fclose(file);
+		if (ret < 0) {
+			fprintf(stderr, "Unable to write to core_pattern\n");
+			close(fd_server);
+			_exit(EXIT_FAILURE);
+		}
+
+		coredump_sk.sun_path[0] = '\0';
+		memcpy(coredump_sk.sun_path, "\0coredump.socket", sizeof("coredump.socket"));
+		coredump_sk_len = offsetof(struct sockaddr_un, sun_path) + sizeof("coredump.socket");
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
+		peer_cookie_len = sizeof(peer_cookie);
+		ret = getsockopt(fd_coredump, SOL_SOCKET, SO_COOKIE,
+				 &peer_cookie, &peer_cookie_len);
+		if (ret < 0) {
+			fprintf(stderr, "%m - Failed to retrieve cookie for coredump socket connection\n");
+			close(fd_coredump);
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
+		if (!info.coredump_cookie) {
+			fprintf(stderr, "Missing coredump cookie\n");
+			close(fd_coredump);
+			close(fd_server);
+			close(fd_peer_pidfd);
+			_exit(EXIT_FAILURE);
+		}
+
+		if (info.coredump_cookie != peer_cookie) {
+			fprintf(stderr, "Mismatching coredump cookies\n");
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
+	ASSERT_FALSE(WCOREDUMP(status));
+
+	info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
+	ASSERT_EQ(ioctl(pidfd, PIDFD_GET_INFO, &info), 0);
+	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
+	ASSERT_EQ((info.coredump_mask & PIDFD_COREDUMPED), 0);
+
+	ASSERT_EQ(kill(pid_coredump_server, SIGKILL), 0);
+	waitpid(pid_coredump_server, &status, 0);
+	self->pid_coredump_server = -ESRCH;
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_EQ(WTERMSIG(status), SIGKILL);
+
+	ASSERT_NE(stat("/tmp/coredump.file", &st), 0);
+	ASSERT_EQ(errno, ENOENT);
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
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL), 0);
+	ASSERT_EQ(mount(NULL, "/tmp", "tmpfs", 0, NULL), 0);
+
+	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		int fd_server, fd_coredump, fd_peer_pidfd, fd_core_file;
+		__u64 peer_cookie, server_cookie;
+		socklen_t fd_peer_pidfd_len, peer_cookie_len, server_cookie_len;
+		struct sockaddr_un coredump_sk = {
+			.sun_family = AF_UNIX,
+		};
+		size_t coredump_sk_len;
+
+		close(ipc_sockets[0]);
+
+		fd_server = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+		if (fd_server < 0)
+			_exit(EXIT_FAILURE);
+
+		server_cookie_len = sizeof(server_cookie);
+		ret = getsockopt(fd_server, SOL_SOCKET, SO_COOKIE,
+				 &server_cookie, &server_cookie_len);
+		if (ret < 0) {
+			fprintf(stderr, "%m - Failed to retrieve cookie for coredump socket server\n");
+			close(fd_server);
+			_exit(EXIT_FAILURE);
+		}
+
+		coredump_sk_len = snprintf(coredump_sk.sun_path,
+					   sizeof(coredump_sk.sun_path),
+					   "@coredump.socket %" PRIu64, server_cookie);
+		if (coredump_sk_len < 0 || coredump_sk_len >= sizeof(coredump_sk.sun_path)) {
+			fprintf(stderr, "Unable to create coredump socket path\n");
+			close(fd_server);
+			_exit(EXIT_FAILURE);
+		}
+
+		file = fopen("/proc/sys/kernel/core_pattern", "w");
+		if (!file) {
+			fprintf(stderr, "Unable to open core_pattern\n");
+			close(fd_server);
+			_exit(EXIT_FAILURE);
+		}
+
+		ret = fprintf(file, "%s", coredump_sk.sun_path);
+		fclose(file);
+		if (ret < 0) {
+			fprintf(stderr, "Unable to write to core_pattern\n");
+			close(fd_server);
+			_exit(EXIT_FAILURE);
+		}
+
+		coredump_sk.sun_path[0] = '\0';
+		memcpy(coredump_sk.sun_path, "\0coredump.socket", sizeof("coredump.socket"));
+		coredump_sk_len = offsetof(struct sockaddr_un, sun_path) + sizeof("coredump.socket");
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
+		peer_cookie_len = sizeof(peer_cookie);
+		ret = getsockopt(fd_coredump, SOL_SOCKET, SO_COOKIE,
+				 &peer_cookie, &peer_cookie_len);
+		if (ret < 0) {
+			fprintf(stderr, "%m - Failed to retrieve cookie for coredump socket connection\n");
+			close(fd_coredump);
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
+		if (info.coredump_cookie) {
+			fprintf(stderr, "Received unexpected coredump cookie\n");
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
+		struct sockaddr_un coredump_sk = {
+			.sun_family = AF_UNIX,
+		};
+		socklen_t coredump_sk_len;
+		int fd_socket;
+		ssize_t ret;
+
+		fd_socket = socket(AF_UNIX, SOCK_STREAM, 0);
+		if (fd_socket < 0)
+			_exit(EXIT_FAILURE);
+
+
+		coredump_sk.sun_path[0] = '\0';
+		memcpy(coredump_sk.sun_path, "\0coredump.socket", sizeof("coredump.socket"));
+		coredump_sk_len = offsetof(struct sockaddr_un, sun_path) + sizeof("coredump.socket");
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
 TEST_HARNESS_MAIN

-- 
2.47.2


