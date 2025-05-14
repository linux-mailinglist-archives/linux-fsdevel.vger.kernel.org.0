Return-Path: <linux-fsdevel+bounces-49019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3BBAB78B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 00:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079751BA2F39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 22:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4E9236457;
	Wed, 14 May 2025 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxg69PNT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5D31E3DF2;
	Wed, 14 May 2025 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747260286; cv=none; b=S/5wGnxCPtKu28kuhMFznud/c816stXYOH4vsYIiRDwR72muFQT4oZFw6PTFlXUTuza7gHgbv1Is9NT0OTK8XBiZl7X/BsPu6UBfiiUIGJShujPhHEy9knvp3s342AoMIOg6kFzyZNXFEuahQxjIhclG6R87ErawzH/H/1PNz7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747260286; c=relaxed/simple;
	bh=cMw9+HWp3moZEEWC4MSD6FohmFLx1ThavaBKD/Br6y8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s8cpVix21unU3v2UilSyYivKYxVZJhtRyQsQ3glmBF8uR6I3L08tw+o9SDE9Qrok8VNfkkuwx4q7RZtDuYqgC1jnvwkylY4JxJd4T04QPVEaS/hwC2A5EDFOb4vJAL7RmuA8OkhgNwWyXvo/60/TP6kZbFKW/+VWM2eG8Lh1gAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxg69PNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C19C4CEEF;
	Wed, 14 May 2025 22:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747260285;
	bh=cMw9+HWp3moZEEWC4MSD6FohmFLx1ThavaBKD/Br6y8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gxg69PNTFLbdZ3RPo8za+Gg695ZOlbKjDW4KwnhTIsB+nSYaYyvlyH+LayoT0S+ID
	 s4qoMIU0gbvqAYnAVuxcx5BT+Kf9TZLj+Yn2JMSk40Sy3o8/f34dVA3mJ++H8Ia3XM
	 t6jRrUUg8nqkIUq7cK6pfQI+aUdJgce1l0gr9gv3tvg9b4QBlyFH9LOrEwqhC4HpFi
	 JzGV/HSZKKsis0pmWqRmW77NX+fRu3UDEKzV/sE4ThWR55YkJwXRfOe8vm+iRZt/rx
	 stJL5ebBmAt31/1i1jNmVdEU15SXA0WhM3uOn21jW0B1wFvwvLVABp7Htbt8IPNoAJ
	 oiJqgFUA7c8rg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 15 May 2025 00:03:42 +0200
Subject: [PATCH v7 9/9] selftests/coredump: add tests for AF_UNIX coredumps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-work-coredump-socket-v7-9-0a1329496c31@kernel.org>
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15862; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cMw9+HWp3moZEEWC4MSD6FohmFLx1ThavaBKD/Br6y8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSoCnveNzkUmVi29MOcyWezHX55OrGa7jE2urjd987Sh
 9bq8uodHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNRsmBk6F/aeqix+4Hlg+8N
 X3Idr0zcmFV6/+OUsvXvFl7bMd1ppiojw6wHK2c9uMGTyfjr5aEVL08EBJ35oxeRyBZ1Vsquo2a
 NNCMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a simple test for generating coredumps via AF_UNIX sockets.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/coredump/stackdump_test.c | 514 +++++++++++++++++++++-
 1 file changed, 513 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/testing/selftests/coredump/stackdump_test.c
index fe3c728cd6be..42ddcf0bdaf2 100644
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
@@ -154,4 +169,501 @@ TEST_F_TIMEOUT(coredump, stackdump, 120)
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
+		__u64 peer_cookie;
+		socklen_t fd_peer_pidfd_len, peer_cookie_len;
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
+		__u64 peer_cookie;
+		socklen_t fd_peer_pidfd_len, peer_cookie_len;
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
+		int fd_server, fd_coredump, fd_peer_pidfd, fd_core_file;
+		__u64 peer_cookie;
+		socklen_t fd_peer_pidfd_len, peer_cookie_len;
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


