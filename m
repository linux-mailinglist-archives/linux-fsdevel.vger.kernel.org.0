Return-Path: <linux-fsdevel+bounces-32470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8FF9A6716
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 13:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B711F21968
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 11:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94F51E7C13;
	Mon, 21 Oct 2024 11:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Otbi20lJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332FD1E1A3B;
	Mon, 21 Oct 2024 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729511694; cv=none; b=e2CUfaTYgW18vW27NFli7u/CLLoUAmgffpw0EwztLuMgJEf8HxADMVZgKk9vYCBhROPG67tfuVSlW7nsk8qFpi1vkVm9WWF5FKi+w2Fm5ZdEIfzS+zfPB/EJ7dFHwz/ZYW55Ku8aG3U6+q6d9a1fZtgQrYIsZG/ETw6qv4kbkJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729511694; c=relaxed/simple;
	bh=x3ho1/yZGCKOAQFm1EUD1MIlajBczY3haYK/uLsgjyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t98ufwMqDP/8LWWt4f63iX1rqYcQxZMXyyCCxSzA2nm9QDj/v1aE+gPmu1AECGpWhlVqueFRwOmkXM0Ck0pLzg8WksqznGNQueZ50mlWYpxwAK6epthfM/UaE57DqATSH97fY3HSi5iv6upx6RxXoanQDUde523bl+5x22giVWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Otbi20lJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62A4C4CEC3;
	Mon, 21 Oct 2024 11:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729511693;
	bh=x3ho1/yZGCKOAQFm1EUD1MIlajBczY3haYK/uLsgjyk=;
	h=From:To:Cc:Subject:Date:From;
	b=Otbi20lJ90GTzlOt2aZlHvMv9jvr7MB2e6kp117OfyddUc372hBwBDUOwbMLd0H/e
	 XWkX/htTLITx4vRxhUBLI5kt5mYvHd/stsbJlLtG+GQU041MsTR2q9pYjZb5Ob7WZw
	 tnX+cCTFUMBUICn10nLVXdNEx2p1UL1E46P6LHKCRc0eSR628fd5PiGfxNWfTYmPVA
	 lw7n/f+DzgDTx20bOVY9GzembCnzn22w8X3xt1mDiMF3rNe+gr3Dis7QsOnAD965Jr
	 eNNw9dEi8qo8uPYVqpQewEVuFsKPJqCjRu2lIkVSONCtEP8bdz330pzMhAMQfYV2vp
	 6JMofvGXkoznw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: add file SLAB_TYPESAFE_BY_RCU recycling stressor
Date: Mon, 21 Oct 2024 13:54:46 +0200
Message-ID: <20241021-vergab-streuen-924df15dceb9@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7625; i=brauner@kernel.org; h=from:subject:message-id; bh=x3ho1/yZGCKOAQFm1EUD1MIlajBczY3haYK/uLsgjyk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSLObJf9vxUrcBmfuV5/9vYLX/3+93fregmu7byprKxV L/I1vMWHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPJm8nI8PW1qrqFY8yZRT/5 mxqPH3SsP3+nUkRJ+96MbT4scgUpJxn+V8Tkuy5YcFwi3MzAINte6pDulnOVqhovZfxyLklfVhZ lAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Add a simple file stressor that lives directly in-tree. This will create
a bunch of processes that each open 500 file descriptors and then use
close_range() to close them all.

Concurrently, other processes read /proc/<pid>/fd/ which rougly does

    f = fget_task_next(p, &fd);
    if (!f)
           break;
    data.mode = f->f_mode;
    fput(f);

Which means that it'll try to get a reference to a file in another
task's file descriptor table.

Under heavy file load it is increasingly likely that the other task will
manage to close @file and @file will be recycled due to
SLAB_TYPEAFE_BY_RCU concurrently. This will trigger various warnings in
the file reference counting code.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
This is in vfs.file unless I hear objections.
---
 .../testing/selftests/filesystems/.gitignore  |   1 +
 tools/testing/selftests/filesystems/Makefile  |   2 +-
 .../selftests/filesystems/file_stressor.c     | 194 ++++++++++++++++++
 3 files changed, 196 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/filesystems/file_stressor.c

diff --git a/tools/testing/selftests/filesystems/.gitignore b/tools/testing/selftests/filesystems/.gitignore
index f0c0ff20d6cf..828b66a10c63 100644
--- a/tools/testing/selftests/filesystems/.gitignore
+++ b/tools/testing/selftests/filesystems/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 dnotify_test
 devpts_pts
+file_stressor
diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
index c647fd6a0446..66305fc34c60 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS += $(KHDR_INCLUDES)
-TEST_GEN_PROGS := devpts_pts
+TEST_GEN_PROGS := devpts_pts file_stressor
 TEST_GEN_PROGS_EXTENDED := dnotify_test
 
 include ../lib.mk
diff --git a/tools/testing/selftests/filesystems/file_stressor.c b/tools/testing/selftests/filesystems/file_stressor.c
new file mode 100644
index 000000000000..1136f93a9977
--- /dev/null
+++ b/tools/testing/selftests/filesystems/file_stressor.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__
+
+#include <fcntl.h>
+#include <limits.h>
+#include <pthread.h>
+#include <sched.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/mount.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+#include <linux/types.h>
+#include <linux/mount.h>
+#include <sys/syscall.h>
+
+static inline int sys_fsopen(const char *fsname, unsigned int flags)
+{
+	return syscall(__NR_fsopen, fsname, flags);
+}
+
+static inline int sys_fsconfig(int fd, unsigned int cmd, const char *key,
+			       const char *value, int aux)
+{
+	return syscall(__NR_fsconfig, fd, cmd, key, value, aux);
+}
+
+static inline int sys_fsmount(int fd, unsigned int flags,
+			      unsigned int attr_flags)
+{
+	return syscall(__NR_fsmount, fd, flags, attr_flags);
+}
+
+#ifndef MOVE_MOUNT_F_EMPTY_PATH
+#define MOVE_MOUNT_F_EMPTY_PATH 0x00000004 /* Empty from path permitted */
+#endif
+
+static inline int sys_move_mount(int from_dfd, const char *from_pathname,
+				 int to_dfd, const char *to_pathname,
+				 unsigned int flags)
+{
+	return syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd,
+		       to_pathname, flags);
+}
+
+FIXTURE(file_stressor) {
+	int fd_tmpfs;
+	int nr_procs;
+	int max_fds;
+	pid_t *pids_openers;
+	pid_t *pids_getdents;
+	int *fd_proc_pid;
+};
+
+FIXTURE_SETUP(file_stressor)
+{
+	int fd_context;
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL), 0);
+	ASSERT_EQ(mkdir("/slab_typesafe_by_rcu", 0755), 0);
+
+	fd_context = sys_fsopen("tmpfs", 0);
+	ASSERT_GE(fd_context, 0);
+
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0), 0);
+	self->fd_tmpfs = sys_fsmount(fd_context, 0, 0);
+	ASSERT_GE(self->fd_tmpfs, 0);
+	ASSERT_EQ(close(fd_context), 0);
+
+	ASSERT_EQ(sys_move_mount(self->fd_tmpfs, "", -EBADF, "/slab_typesafe_by_rcu", MOVE_MOUNT_F_EMPTY_PATH), 0);
+
+	self->nr_procs = sysconf(_SC_NPROCESSORS_ONLN);
+	self->pids_openers = malloc(sizeof(pid_t) * self->nr_procs);
+	ASSERT_NE(self->pids_openers, NULL);
+	self->pids_getdents = malloc(sizeof(pid_t) * self->nr_procs);
+	ASSERT_NE(self->pids_getdents, NULL);
+	self->fd_proc_pid = malloc(sizeof(int) * self->nr_procs);
+	ASSERT_NE(self->fd_proc_pid, NULL);
+	self->max_fds = 500;
+}
+
+FIXTURE_TEARDOWN(file_stressor)
+{
+	for (int i = 0; i < self->nr_procs; i++) {
+		int wstatus;
+		pid_t pid;
+
+		pid = waitpid(self->pids_openers[i], &wstatus, 0);
+		ASSERT_EQ(pid, self->pids_openers[i]);
+		ASSERT_TRUE(!WIFEXITED(wstatus) || !WIFSIGNALED(wstatus));
+
+		pid = waitpid(self->pids_getdents[i], &wstatus, 0);
+		ASSERT_EQ(pid, self->pids_getdents[i]);
+		ASSERT_TRUE(!WIFEXITED(wstatus) || !WIFSIGNALED(wstatus));
+	}
+	free(self->pids_openers);
+	free(self->pids_getdents);
+	ASSERT_EQ(close(self->fd_tmpfs), 0);
+
+	umount2("/slab_typesafe_by_rcu", 0);
+	ASSERT_EQ(rmdir("/slab_typesafe_by_rcu"), 0);
+}
+
+TEST_F_TIMEOUT(file_stressor, slab_typesafe_by_rcu, 900 * 2)
+{
+	for (int i = 0; i < self->nr_procs; i++) {
+		pid_t pid_self;
+
+		self->pids_openers[i] = fork();
+		ASSERT_GE(self->pids_openers[i], 0);
+
+		if (self->pids_openers[i] != 0)
+			continue;
+
+		self->pids_openers[i] = getpid();
+		for (;;) {
+			for (int i = 0; i < self->max_fds; i++) {
+				char path[PATH_MAX];
+				int fd;
+
+				sprintf(path, "/slab_typesafe_by_rcu/file-%d-%d", self->pids_openers[i], i);
+				fd = open(path, O_CREAT | O_RDONLY | O_CLOEXEC, 0644);
+				if (fd < 0)
+					continue;
+			}
+
+			close_range(3, ~0U, 0);
+		}
+
+		exit(0);
+	}
+
+	for (int i = 0; i < self->nr_procs; i++) {
+		char path[PATH_MAX];
+
+		sprintf(path, "/proc/%d/fd/", self->pids_openers[i]);
+		self->fd_proc_pid[i] = open(path, O_DIRECTORY | O_RDONLY | O_CLOEXEC);
+		ASSERT_GE(self->fd_proc_pid[i], 0);
+	}
+
+	for (int i = 0; i < self->nr_procs; i++) {
+		self->pids_getdents[i] = fork();
+		ASSERT_GE(self->pids_getdents[i], 0);
+
+		if (self->pids_getdents[i] != 0)
+			continue;
+
+		self->pids_getdents[i] = getpid();
+		for (;;) {
+			char ents[1024];
+			ssize_t nr_read;
+
+			/*
+			 * Concurrently read /proc/<pid>/fd/ which rougly does:
+			 *
+			 * f = fget_task_next(p, &fd);
+			 * if (!f)
+			 *	break;
+			 * data.mode = f->f_mode;
+			 * fput(f);
+			 *
+			 * Which means that it'll try to get a reference to a
+			 * file in another task's file descriptor table.
+			 *
+			 * Under heavy file load it is increasingly likely that
+			 * the other task will manage to close @file and @file
+			 * is being recycled due to SLAB_TYPEAFE_BY_RCU
+			 * concurrently. This will trigger various warnings in
+			 * the file reference counting code.
+			 */
+			do {
+				nr_read = syscall(SYS_getdents64, self->fd_proc_pid[i], ents, sizeof(ents));
+			} while (nr_read >= 0);
+
+			lseek(self->fd_proc_pid[i], 0, SEEK_SET);
+		}
+
+		exit(0);
+	}
+
+	ASSERT_EQ(clock_nanosleep(CLOCK_MONOTONIC, 0, &(struct timespec){ .tv_sec = 900 /* 15 min */ }, NULL), 0);
+
+	for (int i = 0; i < self->nr_procs; i++) {
+		kill(self->pids_openers[i], SIGKILL);
+		kill(self->pids_getdents[i], SIGKILL);
+	}
+}
+
+TEST_HARNESS_MAIN
-- 
2.45.2


