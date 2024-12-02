Return-Path: <linux-fsdevel+bounces-36290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EA29E0EFD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 23:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D97161F74
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 22:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF071DFD99;
	Mon,  2 Dec 2024 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7Kekg6+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877F11DFD84
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733179506; cv=none; b=t/s2yuR49fibuvdlAk9qL7PvHvfASnH6VYBxmHt6I5V42SjBLnca6qmNrMqFTdpcDJrEFSi9duFbfz0kTQqxc6qp1s3reIkHT00p09zJrVsqMQmnK9gAlW9vL2H9161EAbFCDUiPIzWQwXEWYY7WPawYN+XPfDzHbd0V8/G/3U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733179506; c=relaxed/simple;
	bh=lI2yAuDvFp9kwiSkP9u2uAmZvhjNDEMpvmeefWPbuSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eTvO4prxF2BNH+cZoL+7xynpghNy9psCZJJriM5066A7T4hO+KlmKgVYyMWaVnJzxvnGDLLfgTnb3mESJkngAna6m/6ZFaWSwXyXbQrWptb8Sopof1RD/MpDrLiQW5sgTkdQ8P9afQqPWXEeiYOmhhuxRJ54LS6gEqzSYhz/ev4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7Kekg6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40109C4CED1;
	Mon,  2 Dec 2024 22:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733179506;
	bh=lI2yAuDvFp9kwiSkP9u2uAmZvhjNDEMpvmeefWPbuSM=;
	h=From:To:Cc:Subject:Date:From;
	b=X7Kekg6+qDdi+EWzIZ64fAilrAC55YN+IUw8OO/o9jaxqIBcaa6SN6EvUo15oLtiY
	 eFw4W4YbD6j6PinZquchZYqE50yiXmRGOIX9igpXuEriwtJZ7DQUS8ux+mt3+X1pIY
	 VjwakipRjSwoa4jFjAroSEI242KG++306OgD9rbP7acKl1/Idifk5xAeVVDHAWNhvs
	 VL4L/62ScFMJssQEHeUDwbxyOE8PBTRqGmgPhRfWDYNmBwYzOscokM1z0YkbxjaxlX
	 1isLhkMrXaTe7a/lo+r/XJEQnfAoC9QlL3Mg4q0tXxTIZ8+kwPXip4jbfDYmPSko04
	 0O79MsOakn21A==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Erin Shepherd <erin.shepherd@e43.eu>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] selftests/pidfd: add pidfs file handle selftests
Date: Mon,  2 Dec 2024 23:44:52 +0100
Message-ID: <20241202-imstande-einsicht-d78753e1c632@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=20598; i=brauner@kernel.org; h=from:subject:message-id; bh=lI2yAuDvFp9kwiSkP9u2uAmZvhjNDEMpvmeefWPbuSM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT7WaTcZb57zyX0UevsizJ2mklSyWvb1c4U2VT+1L30s Hgrs6hwRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwES6ljIyzNC59UFnzbFjn88s q2OdGm9tO/nCT520GXmVk91PRpq8VmP4HzibpVHq0vabCv4zDiYcX7ZKcOOV7sW/DHMKNXU3OB8 6wgQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Add selftests for pidfs file handles.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/.gitignore      |   1 +
 tools/testing/selftests/pidfd/Makefile        |   3 +-
 tools/testing/selftests/pidfd/pidfd.h         |  39 ++
 .../selftests/pidfd/pidfd_file_handle_test.c  | 352 ++++++++++++++++++
 .../selftests/pidfd/pidfd_setns_test.c        |  47 +--
 tools/testing/selftests/pidfd/pidfd_wait.c    |  47 +--
 6 files changed, 416 insertions(+), 73 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_file_handle_test.c

diff --git a/tools/testing/selftests/pidfd/.gitignore b/tools/testing/selftests/pidfd/.gitignore
index 973198a3ec3d..224260e1a4a2 100644
--- a/tools/testing/selftests/pidfd/.gitignore
+++ b/tools/testing/selftests/pidfd/.gitignore
@@ -6,3 +6,4 @@ pidfd_wait
 pidfd_fdinfo_test
 pidfd_getfd_test
 pidfd_setns_test
+pidfd_file_handle_test
diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index d731e3e76d5b..3c16d8e77684 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -2,7 +2,8 @@
 CFLAGS += -g $(KHDR_INCLUDES) -pthread -Wall
 
 TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test \
-	pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test
+	pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test \
+	pidfd_file_handle_test
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 88d6830ee004..28a471c88c51 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -17,6 +17,7 @@
 #include <sys/wait.h>
 
 #include "../kselftest.h"
+#include "../clone3/clone3_selftests.h"
 
 #ifndef P_PIDFD
 #define P_PIDFD 3
@@ -68,6 +69,11 @@
 #define PIDFD_SKIP 3
 #define PIDFD_XFAIL 4
 
+static inline int sys_waitid(int which, pid_t pid, siginfo_t *info, int options)
+{
+	return syscall(__NR_waitid, which, pid, info, options, NULL);
+}
+
 static inline int wait_for_pid(pid_t pid)
 {
 	int status, ret;
@@ -114,4 +120,37 @@ static inline int sys_memfd_create(const char *name, unsigned int flags)
 	return syscall(__NR_memfd_create, name, flags);
 }
 
+static inline pid_t create_child(int *pidfd, unsigned flags)
+{
+	struct __clone_args args = {
+		.flags		= CLONE_PIDFD | flags,
+		.exit_signal	= SIGCHLD,
+		.pidfd		= ptr_to_u64(pidfd),
+	};
+
+	return sys_clone3(&args, sizeof(struct __clone_args));
+}
+
+static inline ssize_t read_nointr(int fd, void *buf, size_t count)
+{
+	ssize_t ret;
+
+	do {
+		ret = read(fd, buf, count);
+	} while (ret < 0 && errno == EINTR);
+
+	return ret;
+}
+
+static inline ssize_t write_nointr(int fd, const void *buf, size_t count)
+{
+	ssize_t ret;
+
+	do {
+		ret = write(fd, buf, count);
+	} while (ret < 0 && errno == EINTR);
+
+	return ret;
+}
+
 #endif /* __PIDFD_H */
diff --git a/tools/testing/selftests/pidfd/pidfd_file_handle_test.c b/tools/testing/selftests/pidfd/pidfd_file_handle_test.c
new file mode 100644
index 000000000000..08af47a599cd
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_file_handle_test.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <linux/types.h>
+#include <poll.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <linux/kcmp.h>
+#include <sys/stat.h>
+
+#include "pidfd.h"
+#include "../kselftest_harness.h"
+
+FIXTURE(file_handle)
+{
+	pid_t pid;
+	int pidfd;
+
+	pid_t child_pid1;
+	int child_pidfd1;
+
+	pid_t child_pid2;
+	int child_pidfd2;
+
+	pid_t child_pid3;
+	int child_pidfd3;
+};
+
+FIXTURE_SETUP(file_handle)
+{
+	int ret;
+	int ipc_sockets[2];
+	char c;
+
+	self->pid = getpid();
+	self->pidfd = sys_pidfd_open(self->pid, 0);
+	ASSERT_GE(self->pidfd, 0);
+
+	ret = socketpair(AF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	EXPECT_EQ(ret, 0);
+
+	self->child_pid1 = create_child(&self->child_pidfd1, CLONE_NEWUSER);
+	EXPECT_GE(self->child_pid1, 0);
+
+	if (self->child_pid1 == 0) {
+		close(ipc_sockets[0]);
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+			_exit(EXIT_FAILURE);
+
+		close(ipc_sockets[1]);
+
+		pause();
+		_exit(EXIT_SUCCESS);
+	}
+
+	close(ipc_sockets[1]);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	close(ipc_sockets[0]);
+
+	ret = socketpair(AF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	EXPECT_EQ(ret, 0);
+
+	self->child_pid2 = create_child(&self->child_pidfd2, CLONE_NEWUSER | CLONE_NEWPID);
+	EXPECT_GE(self->child_pid2, 0);
+
+	if (self->child_pid2 == 0) {
+		close(ipc_sockets[0]);
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+			_exit(EXIT_FAILURE);
+
+		close(ipc_sockets[1]);
+
+		pause();
+		_exit(EXIT_SUCCESS);
+	}
+
+	close(ipc_sockets[1]);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	close(ipc_sockets[0]);
+
+	ret = socketpair(AF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	EXPECT_EQ(ret, 0);
+
+	self->child_pid3 = create_child(&self->child_pidfd3, CLONE_NEWUSER | CLONE_NEWPID);
+	EXPECT_GE(self->child_pid3, 0);
+
+	if (self->child_pid3 == 0) {
+		close(ipc_sockets[0]);
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+			_exit(EXIT_FAILURE);
+
+		close(ipc_sockets[1]);
+
+		pause();
+		_exit(EXIT_SUCCESS);
+	}
+
+	close(ipc_sockets[1]);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	close(ipc_sockets[0]);
+}
+
+FIXTURE_TEARDOWN(file_handle)
+{
+	EXPECT_EQ(close(self->pidfd), 0);
+
+	EXPECT_EQ(sys_pidfd_send_signal(self->child_pidfd1, SIGKILL, NULL, 0), 0);
+	if (self->child_pidfd1 >= 0)
+		EXPECT_EQ(0, close(self->child_pidfd1));
+
+	EXPECT_EQ(sys_waitid(P_PID, self->child_pid1, NULL, WEXITED), 0);
+
+	EXPECT_EQ(sys_pidfd_send_signal(self->child_pidfd2, SIGKILL, NULL, 0), 0);
+	if (self->child_pidfd2 >= 0)
+		EXPECT_EQ(0, close(self->child_pidfd2));
+
+	EXPECT_EQ(sys_waitid(P_PID, self->child_pid2, NULL, WEXITED), 0);
+
+	if (self->child_pidfd3 >= 0) {
+		EXPECT_EQ(sys_pidfd_send_signal(self->child_pidfd3, SIGKILL, NULL, 0), 0);
+		EXPECT_EQ(0, close(self->child_pidfd3));
+		EXPECT_EQ(sys_waitid(P_PID, self->child_pid3, NULL, WEXITED), 0);
+	}
+}
+
+/*
+ * Test that we can decode a pidfs file handle in the same pid
+ * namespace.
+ */
+TEST_F(file_handle, file_handle_same_pidns)
+{
+	int mnt_id;
+	struct file_handle *fh;
+	int pidfd = -EBADF;
+	struct stat st1, st2;
+
+	fh = malloc(sizeof(struct file_handle) + MAX_HANDLE_SZ);
+	ASSERT_NE(fh, NULL);
+	memset(fh, 0, sizeof(struct file_handle) + MAX_HANDLE_SZ);
+	fh->handle_bytes = MAX_HANDLE_SZ;
+
+	ASSERT_EQ(name_to_handle_at(self->child_pidfd1, "", fh, &mnt_id, AT_EMPTY_PATH), 0);
+
+	ASSERT_EQ(fstat(self->child_pidfd1, &st1), 0);
+
+	pidfd = open_by_handle_at(self->pidfd, fh, O_PATH);
+	ASSERT_LT(pidfd, 0);
+
+	pidfd = open_by_handle_at(self->pidfd, fh, 0);
+	ASSERT_GE(pidfd, 0);
+
+	ASSERT_EQ(fstat(pidfd, &st2), 0);
+	ASSERT_TRUE(st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino);
+
+	ASSERT_EQ(close(pidfd), 0);
+
+	pidfd = open_by_handle_at(self->pidfd, fh, O_CLOEXEC);
+	ASSERT_GE(pidfd, 0);
+
+	ASSERT_EQ(fstat(pidfd, &st2), 0);
+	ASSERT_TRUE(st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino);
+
+	ASSERT_EQ(close(pidfd), 0);
+
+	pidfd = open_by_handle_at(self->pidfd, fh, O_NONBLOCK);
+	ASSERT_GE(pidfd, 0);
+
+	ASSERT_EQ(fstat(pidfd, &st2), 0);
+	ASSERT_TRUE(st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino);
+
+	ASSERT_EQ(close(pidfd), 0);
+
+	free(fh);
+}
+
+/*
+ * Test that we can decode a pidfs file handle from a child pid
+ * namespace.
+ */
+TEST_F(file_handle, file_handle_child_pidns)
+{
+	int mnt_id;
+	struct file_handle *fh;
+	int pidfd = -EBADF;
+	struct stat st1, st2;
+
+	fh = malloc(sizeof(struct file_handle) + MAX_HANDLE_SZ);
+	ASSERT_NE(fh, NULL);
+	memset(fh, 0, sizeof(struct file_handle) + MAX_HANDLE_SZ);
+	fh->handle_bytes = MAX_HANDLE_SZ;
+
+	ASSERT_EQ(name_to_handle_at(self->child_pidfd2, "", fh, &mnt_id, AT_EMPTY_PATH), 0);
+
+	ASSERT_EQ(fstat(self->child_pidfd2, &st1), 0);
+
+	pidfd = open_by_handle_at(self->pidfd, fh, O_PATH);
+	ASSERT_LT(pidfd, 0);
+
+	pidfd = open_by_handle_at(self->pidfd, fh, 0);
+	ASSERT_GE(pidfd, 0);
+
+	ASSERT_EQ(fstat(pidfd, &st2), 0);
+	ASSERT_TRUE(st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino);
+
+	ASSERT_EQ(close(pidfd), 0);
+
+	pidfd = open_by_handle_at(self->pidfd, fh, O_CLOEXEC);
+	ASSERT_GE(pidfd, 0);
+
+	ASSERT_EQ(fstat(pidfd, &st2), 0);
+	ASSERT_TRUE(st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino);
+
+	ASSERT_EQ(close(pidfd), 0);
+
+	pidfd = open_by_handle_at(self->pidfd, fh, O_NONBLOCK);
+	ASSERT_GE(pidfd, 0);
+
+	ASSERT_EQ(fstat(pidfd, &st2), 0);
+	ASSERT_TRUE(st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino);
+
+	ASSERT_EQ(close(pidfd), 0);
+
+	free(fh);
+}
+
+/*
+ * Test that we fail to decode a pidfs file handle from an ancestor
+ * child pid namespace.
+ */
+TEST_F(file_handle, file_handle_foreign_pidns)
+{
+	int mnt_id;
+	struct file_handle *fh;
+	pid_t pid;
+
+	fh = malloc(sizeof(struct file_handle) + MAX_HANDLE_SZ);
+	ASSERT_NE(fh, NULL);
+	memset(fh, 0, sizeof(struct file_handle) + MAX_HANDLE_SZ);
+	fh->handle_bytes = MAX_HANDLE_SZ;
+
+	ASSERT_EQ(name_to_handle_at(self->pidfd, "", fh, &mnt_id, AT_EMPTY_PATH), 0);
+
+	ASSERT_EQ(setns(self->child_pidfd2, CLONE_NEWUSER | CLONE_NEWPID), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		int pidfd = open_by_handle_at(self->pidfd, fh, 0);
+		if (pidfd >= 0) {
+			TH_LOG("Managed to open pidfd outside of the caller's pid namespace hierarchy");
+			_exit(1);
+		}
+		_exit(0);
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	free(fh);
+}
+
+/*
+ * Test that we can decode a pidfs file handle of a process who has
+ * exited but not been reaped.
+ */
+TEST_F(file_handle, pid_has_exited)
+{
+	int mnt_id, pidfd, child_pidfd3;
+	struct file_handle *fh;
+	struct stat st1, st2;
+
+	fh = malloc(sizeof(struct file_handle) + MAX_HANDLE_SZ);
+	ASSERT_NE(fh, NULL);
+	memset(fh, 0, sizeof(struct file_handle) + MAX_HANDLE_SZ);
+	fh->handle_bytes = MAX_HANDLE_SZ;
+
+	ASSERT_EQ(name_to_handle_at(self->child_pidfd3, "", fh, &mnt_id, AT_EMPTY_PATH), 0);
+
+	ASSERT_EQ(fstat(self->child_pidfd3, &st1), 0);
+
+	pidfd = open_by_handle_at(self->pidfd, fh, 0);
+	ASSERT_GE(pidfd, 0);
+
+	ASSERT_EQ(fstat(pidfd, &st2), 0);
+	ASSERT_TRUE(st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino);
+
+	ASSERT_EQ(close(pidfd), 0);
+
+	child_pidfd3 = self->child_pidfd3;
+	self->child_pidfd3 = -EBADF;
+	EXPECT_EQ(sys_pidfd_send_signal(child_pidfd3, SIGKILL, NULL, 0), 0);
+	EXPECT_EQ(close(child_pidfd3), 0);
+	EXPECT_EQ(sys_waitid(P_PID, self->child_pid3, NULL, WEXITED | WNOWAIT), 0);
+
+	pidfd = open_by_handle_at(self->pidfd, fh, 0);
+	ASSERT_GE(pidfd, 0);
+
+	EXPECT_EQ(sys_waitid(P_PID, self->child_pid3, NULL, WEXITED), 0);
+}
+
+/*
+ * Test that we fail to decode a pidfs file handle of a process who has
+ * already been reaped.
+ */
+TEST_F(file_handle, pid_has_been_reaped)
+{
+	int mnt_id, pidfd, child_pidfd3;
+	struct file_handle *fh;
+	struct stat st1, st2;
+
+	fh = malloc(sizeof(struct file_handle) + MAX_HANDLE_SZ);
+	ASSERT_NE(fh, NULL);
+	memset(fh, 0, sizeof(struct file_handle) + MAX_HANDLE_SZ);
+	fh->handle_bytes = MAX_HANDLE_SZ;
+
+	ASSERT_EQ(name_to_handle_at(self->child_pidfd3, "", fh, &mnt_id, AT_EMPTY_PATH), 0);
+
+	ASSERT_EQ(fstat(self->child_pidfd3, &st1), 0);
+
+	pidfd = open_by_handle_at(self->pidfd, fh, 0);
+	ASSERT_GE(pidfd, 0);
+
+	ASSERT_EQ(fstat(pidfd, &st2), 0);
+	ASSERT_TRUE(st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino);
+
+	ASSERT_EQ(close(pidfd), 0);
+
+	child_pidfd3 = self->child_pidfd3;
+	self->child_pidfd3 = -EBADF;
+	EXPECT_EQ(sys_pidfd_send_signal(child_pidfd3, SIGKILL, NULL, 0), 0);
+	EXPECT_EQ(close(child_pidfd3), 0);
+	EXPECT_EQ(sys_waitid(P_PID, self->child_pid3, NULL, WEXITED), 0);
+
+	pidfd = open_by_handle_at(self->pidfd, fh, 0);
+	ASSERT_LT(pidfd, 0);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 7c2a4349170a..222f8131283b 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -19,7 +19,6 @@
 #include <linux/ioctl.h>
 
 #include "pidfd.h"
-#include "../clone3/clone3_selftests.h"
 #include "../kselftest_harness.h"
 
 #ifndef PIDFS_IOCTL_MAGIC
@@ -118,22 +117,6 @@ FIXTURE(current_nsset)
 	int child_pidfd_derived_nsfds2[PIDFD_NS_MAX];
 };
 
-static int sys_waitid(int which, pid_t pid, int options)
-{
-	return syscall(__NR_waitid, which, pid, NULL, options, NULL);
-}
-
-pid_t create_child(int *pidfd, unsigned flags)
-{
-	struct __clone_args args = {
-		.flags		= CLONE_PIDFD | flags,
-		.exit_signal	= SIGCHLD,
-		.pidfd		= ptr_to_u64(pidfd),
-	};
-
-	return sys_clone3(&args, sizeof(struct clone_args));
-}
-
 static bool switch_timens(void)
 {
 	int fd, ret;
@@ -150,28 +133,6 @@ static bool switch_timens(void)
 	return ret == 0;
 }
 
-static ssize_t read_nointr(int fd, void *buf, size_t count)
-{
-	ssize_t ret;
-
-	do {
-		ret = read(fd, buf, count);
-	} while (ret < 0 && errno == EINTR);
-
-	return ret;
-}
-
-static ssize_t write_nointr(int fd, const void *buf, size_t count)
-{
-	ssize_t ret;
-
-	do {
-		ret = write(fd, buf, count);
-	} while (ret < 0 && errno == EINTR);
-
-	return ret;
-}
-
 FIXTURE_SETUP(current_nsset)
 {
 	int i, proc_fd, ret;
@@ -229,7 +190,7 @@ FIXTURE_SETUP(current_nsset)
 		_exit(EXIT_SUCCESS);
 	}
 
-	ASSERT_EQ(sys_waitid(P_PID, self->child_pid_exited, WEXITED | WNOWAIT), 0);
+	ASSERT_EQ(sys_waitid(P_PID, self->child_pid_exited, NULL, WEXITED | WNOWAIT), 0);
 
 	self->pidfd = sys_pidfd_open(self->pid, 0);
 	EXPECT_GE(self->pidfd, 0) {
@@ -432,9 +393,9 @@ FIXTURE_TEARDOWN(current_nsset)
 		EXPECT_EQ(0, close(self->child_pidfd1));
 	if (self->child_pidfd2 >= 0)
 		EXPECT_EQ(0, close(self->child_pidfd2));
-	ASSERT_EQ(sys_waitid(P_PID, self->child_pid_exited, WEXITED), 0);
-	ASSERT_EQ(sys_waitid(P_PID, self->child_pid1, WEXITED), 0);
-	ASSERT_EQ(sys_waitid(P_PID, self->child_pid2, WEXITED), 0);
+	ASSERT_EQ(sys_waitid(P_PID, self->child_pid_exited, NULL, WEXITED), 0);
+	ASSERT_EQ(sys_waitid(P_PID, self->child_pid1, NULL, WEXITED), 0);
+	ASSERT_EQ(sys_waitid(P_PID, self->child_pid2, NULL, WEXITED), 0);
 }
 
 static int preserve_ns(const int pid, const char *ns)
diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
index 0dcb8365ddc3..1e2d49751cde 100644
--- a/tools/testing/selftests/pidfd/pidfd_wait.c
+++ b/tools/testing/selftests/pidfd/pidfd_wait.c
@@ -26,22 +26,11 @@
 #define SKIP(s, ...)	XFAIL(s, ##__VA_ARGS__)
 #endif
 
-static pid_t sys_clone3(struct clone_args *args)
-{
-	return syscall(__NR_clone3, args, sizeof(struct clone_args));
-}
-
-static int sys_waitid(int which, pid_t pid, siginfo_t *info, int options,
-		      struct rusage *ru)
-{
-	return syscall(__NR_waitid, which, pid, info, options, ru);
-}
-
 TEST(wait_simple)
 {
 	int pidfd = -1;
 	pid_t parent_tid = -1;
-	struct clone_args args = {
+	struct __clone_args args = {
 		.parent_tid = ptr_to_u64(&parent_tid),
 		.pidfd = ptr_to_u64(&pidfd),
 		.flags = CLONE_PIDFD | CLONE_PARENT_SETTID,
@@ -55,7 +44,7 @@ TEST(wait_simple)
 	pidfd = open("/proc/self", O_DIRECTORY | O_RDONLY | O_CLOEXEC);
 	ASSERT_GE(pidfd, 0);
 
-	pid = sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL);
+	pid = sys_waitid(P_PIDFD, pidfd, &info, WEXITED);
 	ASSERT_NE(pid, 0);
 	EXPECT_EQ(close(pidfd), 0);
 	pidfd = -1;
@@ -63,18 +52,18 @@ TEST(wait_simple)
 	pidfd = open("/dev/null", O_RDONLY | O_CLOEXEC);
 	ASSERT_GE(pidfd, 0);
 
-	pid = sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL);
+	pid = sys_waitid(P_PIDFD, pidfd, &info, WEXITED);
 	ASSERT_NE(pid, 0);
 	EXPECT_EQ(close(pidfd), 0);
 	pidfd = -1;
 
-	pid = sys_clone3(&args);
+	pid = sys_clone3(&args, sizeof(args));
 	ASSERT_GE(pid, 0);
 
 	if (pid == 0)
 		exit(EXIT_SUCCESS);
 
-	pid = sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL);
+	pid = sys_waitid(P_PIDFD, pidfd, &info, WEXITED);
 	ASSERT_GE(pid, 0);
 	ASSERT_EQ(WIFEXITED(info.si_status), true);
 	ASSERT_EQ(WEXITSTATUS(info.si_status), 0);
@@ -89,7 +78,7 @@ TEST(wait_states)
 {
 	int pidfd = -1;
 	pid_t parent_tid = -1;
-	struct clone_args args = {
+	struct __clone_args args = {
 		.parent_tid = ptr_to_u64(&parent_tid),
 		.pidfd = ptr_to_u64(&pidfd),
 		.flags = CLONE_PIDFD | CLONE_PARENT_SETTID,
@@ -102,7 +91,7 @@ TEST(wait_states)
 	};
 
 	ASSERT_EQ(pipe(pfd), 0);
-	pid = sys_clone3(&args);
+	pid = sys_clone3(&args, sizeof(args));
 	ASSERT_GE(pid, 0);
 
 	if (pid == 0) {
@@ -117,28 +106,28 @@ TEST(wait_states)
 	}
 
 	close(pfd[0]);
-	ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WSTOPPED, NULL), 0);
+	ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WSTOPPED), 0);
 	ASSERT_EQ(info.si_signo, SIGCHLD);
 	ASSERT_EQ(info.si_code, CLD_STOPPED);
 	ASSERT_EQ(info.si_pid, parent_tid);
 
 	ASSERT_EQ(sys_pidfd_send_signal(pidfd, SIGCONT, NULL, 0), 0);
 
-	ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WCONTINUED, NULL), 0);
+	ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WCONTINUED), 0);
 	ASSERT_EQ(write(pfd[1], "C", 1), 1);
 	close(pfd[1]);
 	ASSERT_EQ(info.si_signo, SIGCHLD);
 	ASSERT_EQ(info.si_code, CLD_CONTINUED);
 	ASSERT_EQ(info.si_pid, parent_tid);
 
-	ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WUNTRACED, NULL), 0);
+	ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WUNTRACED), 0);
 	ASSERT_EQ(info.si_signo, SIGCHLD);
 	ASSERT_EQ(info.si_code, CLD_STOPPED);
 	ASSERT_EQ(info.si_pid, parent_tid);
 
 	ASSERT_EQ(sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0), 0);
 
-	ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL), 0);
+	ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WEXITED), 0);
 	ASSERT_EQ(info.si_signo, SIGCHLD);
 	ASSERT_EQ(info.si_code, CLD_KILLED);
 	ASSERT_EQ(info.si_pid, parent_tid);
@@ -151,7 +140,7 @@ TEST(wait_nonblock)
 	int pidfd;
 	unsigned int flags = 0;
 	pid_t parent_tid = -1;
-	struct clone_args args = {
+	struct __clone_args args = {
 		.parent_tid = ptr_to_u64(&parent_tid),
 		.flags = CLONE_PARENT_SETTID,
 		.exit_signal = SIGCHLD,
@@ -173,12 +162,12 @@ TEST(wait_nonblock)
 		SKIP(return, "Skipping PIDFD_NONBLOCK test");
 	}
 
-	ret = sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL);
+	ret = sys_waitid(P_PIDFD, pidfd, &info, WEXITED);
 	ASSERT_LT(ret, 0);
 	ASSERT_EQ(errno, ECHILD);
 	EXPECT_EQ(close(pidfd), 0);
 
-	pid = sys_clone3(&args);
+	pid = sys_clone3(&args, sizeof(args));
 	ASSERT_GE(pid, 0);
 
 	if (pid == 0) {
@@ -201,7 +190,7 @@ TEST(wait_nonblock)
 	 * Callers need to see EAGAIN/EWOULDBLOCK with non-blocking pidfd when
 	 * child processes exist but none have exited.
 	 */
-	ret = sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL);
+	ret = sys_waitid(P_PIDFD, pidfd, &info, WEXITED);
 	ASSERT_LT(ret, 0);
 	ASSERT_EQ(errno, EAGAIN);
 
@@ -210,19 +199,19 @@ TEST(wait_nonblock)
 	 * WNOHANG raised explicitly when child processes exist but none have
 	 * exited.
 	 */
-	ret = sys_waitid(P_PIDFD, pidfd, &info, WEXITED | WNOHANG, NULL);
+	ret = sys_waitid(P_PIDFD, pidfd, &info, WEXITED | WNOHANG);
 	ASSERT_EQ(ret, 0);
 
 	ASSERT_EQ(fcntl(pidfd, F_SETFL, (flags & ~O_NONBLOCK)), 0);
 
-	ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WSTOPPED, NULL), 0);
+	ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WSTOPPED), 0);
 	ASSERT_EQ(info.si_signo, SIGCHLD);
 	ASSERT_EQ(info.si_code, CLD_STOPPED);
 	ASSERT_EQ(info.si_pid, parent_tid);
 
 	ASSERT_EQ(sys_pidfd_send_signal(pidfd, SIGCONT, NULL, 0), 0);
 
-	ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL), 0);
+	ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WEXITED), 0);
 	ASSERT_EQ(info.si_signo, SIGCHLD);
 	ASSERT_EQ(info.si_code, CLD_EXITED);
 	ASSERT_EQ(info.si_pid, parent_tid);
-- 
2.45.2


