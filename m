Return-Path: <linux-fsdevel+bounces-42051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33192A3BB11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 11:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0837E188C7E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 10:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695F51D5ACD;
	Wed, 19 Feb 2025 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCNJ7EM4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C380017A302;
	Wed, 19 Feb 2025 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739959342; cv=none; b=WfxL5fV/X1kUvhtRUB/L3LNrK2L2BTBFTmAChOUtAzZ50mLB5Tu13M5hhhiamBdnqVel+diguxPoP9FxunY8xsoQD5NgR3xMUOk/NJ812TyDVWxMOZh0XIeg/Vz7OayZlfunFW4Nv1m3898ZcKiksUG1QZZ+o6tiJ1tBvlOFPOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739959342; c=relaxed/simple;
	bh=6OW/Tj543ffkvmtHRirmBr0cRM3S1s9/jMBAQ9RNELA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FityaVUC3nGUPGQK7Hu5g1byI5fRC3WC9EjwhFzqv2l8JageM/wZk25SF+7+aXaqyoUI3q8oHVrsEKCM7SG74Acp5g1gSTMK7ZS18mTGzWk+dFl6wCGp8v/tptzv32sHXvkaYvl43V6FLKua4wm5s5ZrilGwQ4Zl1gH700n66Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCNJ7EM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985B1C4CEE6;
	Wed, 19 Feb 2025 10:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739959342;
	bh=6OW/Tj543ffkvmtHRirmBr0cRM3S1s9/jMBAQ9RNELA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LCNJ7EM401PtjZ1ZOQNLtQNbuAElpQw3mnWe4EjefGlgTN7bwr74CG+m35Tz3/JjN
	 I1tPO87ygbd5iYVRWGX/OFKiarLBlfjOrTO2lqb9iSJcbJj7vpiheWjiEd5GYoaWco
	 T2CgDc6SRuWGgAdHv3xrjSv6UqlRo7XCvpOZvqFxnwV81cmxZ03jLiD1t+3nrV9Ldp
	 rgs7NtmiTw0YHERW7x+BY13oRRO+mc0TVZ2Duc3++2ktp35C3N4jq8+jPbk6htAtQw
	 NCFugcb7he3gsu8MzJB5m9+AKQWSghqCknajbJ2JI8i0qnkNY+whrH8PCZdMWkx/Pn
	 iPtLrnTG7ksWw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 19 Feb 2025 11:01:51 +0100
Subject: [PATCH v3 3/4] selftests/ovl: add second selftest for
 "override_creds"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-work-overlayfs-v3-3-46af55e4ceda@kernel.org>
References: <20250219-work-overlayfs-v3-0-46af55e4ceda@kernel.org>
In-Reply-To: <20250219-work-overlayfs-v3-0-46af55e4ceda@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>
Cc: Gopal Kakivaya <gopalk@microsoft.com>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=21049; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6OW/Tj543ffkvmtHRirmBr0cRM3S1s9/jMBAQ9RNELA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRvXaOWYLzZTcNg4oSW+ysCdjEy/tzI8C1I6CarzYZVi
 bx/T4ZIdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkwxNGhnXuX2cc7f/49Ew6
 h67f/leOE1aoizJetE1wfPj0YdujXkOG/zlMGb0ymquXTEl6GMUtr7/3ybvjDeIBrfurq2rfqe1
 4zAwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a simple test to verify that the new "override_creds" option works.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/filesystems/overlayfs/Makefile       |  11 +-
 .../filesystems/overlayfs/set_layers_via_fds.c     | 149 ++++++-
 tools/testing/selftests/filesystems/utils.c        | 474 +++++++++++++++++++++
 tools/testing/selftests/filesystems/utils.h        |  44 ++
 4 files changed, 665 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/filesystems/overlayfs/Makefile b/tools/testing/selftests/filesystems/overlayfs/Makefile
index e8d1adb021af..6c661232b3b5 100644
--- a/tools/testing/selftests/filesystems/overlayfs/Makefile
+++ b/tools/testing/selftests/filesystems/overlayfs/Makefile
@@ -1,7 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
 
-TEST_GEN_PROGS := dev_in_maps set_layers_via_fds
+CFLAGS += -Wall
+CFLAGS += $(KHDR_INCLUDES)
+LDLIBS += -lcap
 
-CFLAGS := -Wall -Werror
+LOCAL_HDRS += wrappers.h log.h
+
+TEST_GEN_PROGS := dev_in_maps
+TEST_GEN_PROGS += set_layers_via_fds
 
 include ../../lib.mk
+
+$(OUTPUT)/set_layers_via_fds: ../utils.c
diff --git a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
index 70acd833581d..6b65e3610578 100644
--- a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
+++ b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
@@ -6,6 +6,7 @@
 #include <sched.h>
 #include <stdio.h>
 #include <string.h>
+#include <sys/socket.h>
 #include <sys/stat.h>
 #include <sys/mount.h>
 #include <unistd.h>
@@ -13,20 +14,27 @@
 #include "../../kselftest_harness.h"
 #include "../../pidfd/pidfd.h"
 #include "log.h"
+#include "../utils.h"
 #include "wrappers.h"
 
 FIXTURE(set_layers_via_fds) {
+	int pidfd;
 };
 
 FIXTURE_SETUP(set_layers_via_fds)
 {
-	ASSERT_EQ(mkdir("/set_layers_via_fds", 0755), 0);
+	self->pidfd = -EBADF;
+	EXPECT_EQ(mkdir("/set_layers_via_fds", 0755), 0);
 }
 
 FIXTURE_TEARDOWN(set_layers_via_fds)
 {
+	if (self->pidfd >= 0) {
+		EXPECT_EQ(sys_pidfd_send_signal(self->pidfd, SIGKILL, NULL, 0), 0);
+		EXPECT_EQ(close(self->pidfd), 0);
+	}
 	umount2("/set_layers_via_fds", 0);
-	ASSERT_EQ(rmdir("/set_layers_via_fds"), 0);
+	EXPECT_EQ(rmdir("/set_layers_via_fds"), 0);
 }
 
 TEST_F(set_layers_via_fds, set_layers_via_fds)
@@ -266,7 +274,7 @@ TEST_F(set_layers_via_fds, set_override_creds)
 	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_STRING, "metacopy", "on", 0), 0);
 
 	pid = create_child(&pidfd, 0);
-	EXPECT_GE(pid, 0);
+	ASSERT_GE(pid, 0);
 	if (pid == 0) {
 		if (sys_fsconfig(fd_context, FSCONFIG_SET_FLAG, "override_creds", NULL, 0)) {
 			TH_LOG("sys_fsconfig should have succeeded");
@@ -275,11 +283,11 @@ TEST_F(set_layers_via_fds, set_override_creds)
 
 		_exit(EXIT_SUCCESS);
 	}
-	EXPECT_EQ(sys_waitid(P_PID, pid, NULL, WEXITED), 0);
-	EXPECT_EQ(close(pidfd), 0);
+	ASSERT_GE(sys_waitid(P_PID, pid, NULL, WEXITED), 0);
+	ASSERT_GE(close(pidfd), 0);
 
 	pid = create_child(&pidfd, 0);
-	EXPECT_GE(pid, 0);
+	ASSERT_GE(pid, 0);
 	if (pid == 0) {
 		if (sys_fsconfig(fd_context, FSCONFIG_SET_FLAG, "nooverride_creds", NULL, 0)) {
 			TH_LOG("sys_fsconfig should have succeeded");
@@ -288,11 +296,11 @@ TEST_F(set_layers_via_fds, set_override_creds)
 
 		_exit(EXIT_SUCCESS);
 	}
-	EXPECT_EQ(sys_waitid(P_PID, pid, NULL, WEXITED), 0);
-	EXPECT_EQ(close(pidfd), 0);
+	ASSERT_GE(sys_waitid(P_PID, pid, NULL, WEXITED), 0);
+	ASSERT_GE(close(pidfd), 0);
 
 	pid = create_child(&pidfd, 0);
-	EXPECT_GE(pid, 0);
+	ASSERT_GE(pid, 0);
 	if (pid == 0) {
 		if (sys_fsconfig(fd_context, FSCONFIG_SET_FLAG, "override_creds", NULL, 0)) {
 			TH_LOG("sys_fsconfig should have succeeded");
@@ -301,8 +309,125 @@ TEST_F(set_layers_via_fds, set_override_creds)
 
 		_exit(EXIT_SUCCESS);
 	}
-	EXPECT_EQ(sys_waitid(P_PID, pid, NULL, WEXITED), 0);
-	EXPECT_EQ(close(pidfd), 0);
+	ASSERT_GE(sys_waitid(P_PID, pid, NULL, WEXITED), 0);
+	ASSERT_GE(close(pidfd), 0);
+
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0), 0);
+
+	fd_overlay = sys_fsmount(fd_context, 0, 0);
+	ASSERT_GE(fd_overlay, 0);
+
+	ASSERT_EQ(sys_move_mount(fd_overlay, "", -EBADF, "/set_layers_via_fds", MOVE_MOUNT_F_EMPTY_PATH), 0);
+
+	ASSERT_EQ(close(fd_context), 0);
+	ASSERT_EQ(close(fd_overlay), 0);
+}
+
+TEST_F(set_layers_via_fds, set_override_creds_invalid)
+{
+	int fd_context, fd_tmpfs, fd_overlay, ret;
+	int layer_fds[] = { [0 ... 3] = -EBADF };
+	pid_t pid;
+	int fd_userns1, fd_userns2;
+	int ipc_sockets[2];
+	char c;
+	const unsigned int predictable_fd_context_nr = 123;
+
+	fd_userns1 = get_userns_fd(0, 0, 10000);
+	ASSERT_GE(fd_userns1, 0);
+
+	fd_userns2 = get_userns_fd(0, 1234, 10000);
+	ASSERT_GE(fd_userns2, 0);
+
+	ret = socketpair(AF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_GE(ret, 0);
+
+	pid = create_child(&self->pidfd, 0);
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		if (close(ipc_sockets[0])) {
+			TH_LOG("close should have succeeded");
+			_exit(EXIT_FAILURE);
+		}
+
+		if (!switch_userns(fd_userns2, 0, 0, false)) {
+			TH_LOG("switch_userns should have succeeded");
+			_exit(EXIT_FAILURE);
+		}
+
+		if (read_nointr(ipc_sockets[1], &c, 1) != 1) {
+			TH_LOG("read_nointr should have succeeded");
+			_exit(EXIT_FAILURE);
+		}
+
+		if (close(ipc_sockets[1])) {
+			TH_LOG("close should have succeeded");
+			_exit(EXIT_FAILURE);
+		}
+
+		if (!sys_fsconfig(predictable_fd_context_nr, FSCONFIG_SET_FLAG, "override_creds", NULL, 0)) {
+			TH_LOG("sys_fsconfig should have failed");
+			_exit(EXIT_FAILURE);
+		}
+
+		_exit(EXIT_SUCCESS);
+	}
+
+	ASSERT_EQ(close(ipc_sockets[1]), 0);
+	ASSERT_EQ(switch_userns(fd_userns1, 0, 0, false), true);
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(sys_mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL), 0);
+
+	fd_context = sys_fsopen("tmpfs", 0);
+	ASSERT_GE(fd_context, 0);
+
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0), 0);
+	fd_tmpfs = sys_fsmount(fd_context, 0, 0);
+	ASSERT_GE(fd_tmpfs, 0);
+	ASSERT_EQ(close(fd_context), 0);
+
+	ASSERT_EQ(mkdirat(fd_tmpfs, "w", 0755), 0);
+	ASSERT_EQ(mkdirat(fd_tmpfs, "u", 0755), 0);
+	ASSERT_EQ(mkdirat(fd_tmpfs, "l1", 0755), 0);
+	ASSERT_EQ(mkdirat(fd_tmpfs, "l2", 0755), 0);
+
+	layer_fds[0] = openat(fd_tmpfs, "w", O_DIRECTORY);
+	ASSERT_GE(layer_fds[0], 0);
+
+	layer_fds[1] = openat(fd_tmpfs, "u", O_DIRECTORY);
+	ASSERT_GE(layer_fds[1], 0);
+
+	layer_fds[2] = openat(fd_tmpfs, "l1", O_DIRECTORY);
+	ASSERT_GE(layer_fds[2], 0);
+
+	layer_fds[3] = openat(fd_tmpfs, "l2", O_DIRECTORY);
+	ASSERT_GE(layer_fds[3], 0);
+
+	ASSERT_EQ(sys_move_mount(fd_tmpfs, "", -EBADF, "/tmp", MOVE_MOUNT_F_EMPTY_PATH), 0);
+	ASSERT_EQ(close(fd_tmpfs), 0);
+
+	fd_context = sys_fsopen("overlay", 0);
+	ASSERT_GE(fd_context, 0);
+	ASSERT_EQ(dup3(fd_context, predictable_fd_context_nr, 0), predictable_fd_context_nr);
+	ASSERT_EQ(close(fd_context), 0);
+	fd_context = predictable_fd_context_nr;
+	ASSERT_EQ(write_nointr(ipc_sockets[0], "1", 1), 1);
+	ASSERT_EQ(close(ipc_sockets[0]), 0);
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+	ASSERT_EQ(close(self->pidfd), 0);
+	self->pidfd = -EBADF;
+
+	ASSERT_NE(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir", NULL, layer_fds[2]), 0);
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "workdir",   NULL, layer_fds[0]), 0);
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "upperdir",  NULL, layer_fds[1]), 0);
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[2]), 0);
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[3]), 0);
+
+	for (int i = 0; i < ARRAY_SIZE(layer_fds); i++)
+		ASSERT_EQ(close(layer_fds[i]), 0);
+
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FLAG, "userxattr", NULL, 0), 0);
 
 	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0), 0);
 
@@ -313,6 +438,8 @@ TEST_F(set_layers_via_fds, set_override_creds)
 
 	ASSERT_EQ(close(fd_context), 0);
 	ASSERT_EQ(close(fd_overlay), 0);
+	ASSERT_EQ(close(fd_userns1), 0);
+	ASSERT_EQ(close(fd_userns2), 0);
 }
 
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/filesystems/utils.c b/tools/testing/selftests/filesystems/utils.c
new file mode 100644
index 000000000000..0e8080bd0aea
--- /dev/null
+++ b/tools/testing/selftests/filesystems/utils.c
@@ -0,0 +1,474 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <fcntl.h>
+#include <sys/types.h>
+#include <dirent.h>
+#include <grp.h>
+#include <linux/limits.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/eventfd.h>
+#include <sys/fsuid.h>
+#include <sys/prctl.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/xattr.h>
+
+#include "utils.h"
+
+#define MAX_USERNS_LEVEL 32
+
+#define syserror(format, ...)                           \
+	({                                              \
+		fprintf(stderr, "%m - " format "\n", ##__VA_ARGS__); \
+		(-errno);                               \
+	})
+
+#define syserror_set(__ret__, format, ...)                    \
+	({                                                    \
+		typeof(__ret__) __internal_ret__ = (__ret__); \
+		errno = labs(__ret__);                        \
+		fprintf(stderr, "%m - " format "\n", ##__VA_ARGS__);       \
+		__internal_ret__;                             \
+	})
+
+#define STRLITERALLEN(x) (sizeof(""x"") - 1)
+
+#define INTTYPE_TO_STRLEN(type)             \
+	(2 + (sizeof(type) <= 1             \
+		  ? 3                       \
+		  : sizeof(type) <= 2       \
+			? 5                 \
+			: sizeof(type) <= 4 \
+			      ? 10          \
+			      : sizeof(type) <= 8 ? 20 : sizeof(int[-2 * (sizeof(type) > 8)])))
+
+#define list_for_each(__iterator, __list) \
+	for (__iterator = (__list)->next; __iterator != __list; __iterator = __iterator->next)
+
+typedef enum idmap_type_t {
+	ID_TYPE_UID,
+	ID_TYPE_GID
+} idmap_type_t;
+
+struct id_map {
+	idmap_type_t map_type;
+	__u32 nsid;
+	__u32 hostid;
+	__u32 range;
+};
+
+struct list {
+	void *elem;
+	struct list *next;
+	struct list *prev;
+};
+
+struct userns_hierarchy {
+	int fd_userns;
+	int fd_event;
+	unsigned int level;
+	struct list id_map;
+};
+
+static inline void list_init(struct list *list)
+{
+	list->elem = NULL;
+	list->next = list->prev = list;
+}
+
+static inline int list_empty(const struct list *list)
+{
+	return list == list->next;
+}
+
+static inline void __list_add(struct list *new, struct list *prev, struct list *next)
+{
+	next->prev = new;
+	new->next = next;
+	new->prev = prev;
+	prev->next = new;
+}
+
+static inline void list_add_tail(struct list *head, struct list *list)
+{
+	__list_add(list, head->prev, head);
+}
+
+static inline void list_del(struct list *list)
+{
+	struct list *next, *prev;
+
+	next = list->next;
+	prev = list->prev;
+	next->prev = prev;
+	prev->next = next;
+}
+
+static ssize_t read_nointr(int fd, void *buf, size_t count)
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
+static ssize_t write_nointr(int fd, const void *buf, size_t count)
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
+#define __STACK_SIZE (8 * 1024 * 1024)
+static pid_t do_clone(int (*fn)(void *), void *arg, int flags)
+{
+	void *stack;
+
+	stack = malloc(__STACK_SIZE);
+	if (!stack)
+		return -ENOMEM;
+
+#ifdef __ia64__
+	return __clone2(fn, stack, __STACK_SIZE, flags | SIGCHLD, arg, NULL);
+#else
+	return clone(fn, stack + __STACK_SIZE, flags | SIGCHLD, arg, NULL);
+#endif
+}
+
+static int get_userns_fd_cb(void *data)
+{
+	for (;;)
+		pause();
+	_exit(0);
+}
+
+static int wait_for_pid(pid_t pid)
+{
+	int status, ret;
+
+again:
+	ret = waitpid(pid, &status, 0);
+	if (ret == -1) {
+		if (errno == EINTR)
+			goto again;
+
+		return -1;
+	}
+
+	if (!WIFEXITED(status))
+		return -1;
+
+	return WEXITSTATUS(status);
+}
+
+static int write_id_mapping(idmap_type_t map_type, pid_t pid, const char *buf, size_t buf_size)
+{
+	int fd = -EBADF, setgroups_fd = -EBADF;
+	int fret = -1;
+	int ret;
+	char path[STRLITERALLEN("/proc/") + INTTYPE_TO_STRLEN(pid_t) +
+		  STRLITERALLEN("/setgroups") + 1];
+
+	if (geteuid() != 0 && map_type == ID_TYPE_GID) {
+		ret = snprintf(path, sizeof(path), "/proc/%d/setgroups", pid);
+		if (ret < 0 || ret >= sizeof(path))
+			goto out;
+
+		setgroups_fd = open(path, O_WRONLY | O_CLOEXEC);
+		if (setgroups_fd < 0 && errno != ENOENT) {
+			syserror("Failed to open \"%s\"", path);
+			goto out;
+		}
+
+		if (setgroups_fd >= 0) {
+			ret = write_nointr(setgroups_fd, "deny\n", STRLITERALLEN("deny\n"));
+			if (ret != STRLITERALLEN("deny\n")) {
+				syserror("Failed to write \"deny\" to \"/proc/%d/setgroups\"", pid);
+				goto out;
+			}
+		}
+	}
+
+	ret = snprintf(path, sizeof(path), "/proc/%d/%cid_map", pid, map_type == ID_TYPE_UID ? 'u' : 'g');
+	if (ret < 0 || ret >= sizeof(path))
+		goto out;
+
+	fd = open(path, O_WRONLY | O_CLOEXEC);
+	if (fd < 0) {
+		syserror("Failed to open \"%s\"", path);
+		goto out;
+	}
+
+	ret = write_nointr(fd, buf, buf_size);
+	if (ret != buf_size) {
+		syserror("Failed to write %cid mapping to \"%s\"",
+			 map_type == ID_TYPE_UID ? 'u' : 'g', path);
+		goto out;
+	}
+
+	fret = 0;
+out:
+	close(fd);
+	close(setgroups_fd);
+
+	return fret;
+}
+
+static int map_ids_from_idmap(struct list *idmap, pid_t pid)
+{
+	int fill, left;
+	char mapbuf[4096] = {};
+	bool had_entry = false;
+	idmap_type_t map_type, u_or_g;
+
+	if (list_empty(idmap))
+		return 0;
+
+	for (map_type = ID_TYPE_UID, u_or_g = 'u';
+	     map_type <= ID_TYPE_GID; map_type++, u_or_g = 'g') {
+		char *pos = mapbuf;
+		int ret;
+		struct list *iterator;
+
+
+		list_for_each(iterator, idmap) {
+			struct id_map *map = iterator->elem;
+			if (map->map_type != map_type)
+				continue;
+
+			had_entry = true;
+
+			left = 4096 - (pos - mapbuf);
+			fill = snprintf(pos, left, "%u %u %u\n", map->nsid, map->hostid, map->range);
+			/*
+			 * The kernel only takes <= 4k for writes to
+			 * /proc/<pid>/{g,u}id_map
+			 */
+			if (fill <= 0 || fill >= left)
+				return syserror_set(-E2BIG, "Too many %cid mappings defined", u_or_g);
+
+			pos += fill;
+		}
+		if (!had_entry)
+			continue;
+
+		ret = write_id_mapping(map_type, pid, mapbuf, pos - mapbuf);
+		if (ret < 0)
+			return syserror("Failed to write mapping: %s", mapbuf);
+
+		memset(mapbuf, 0, sizeof(mapbuf));
+	}
+
+	return 0;
+}
+
+static int get_userns_fd_from_idmap(struct list *idmap)
+{
+	int ret;
+	pid_t pid;
+	char path_ns[STRLITERALLEN("/proc/") + INTTYPE_TO_STRLEN(pid_t) +
+		     STRLITERALLEN("/ns/user") + 1];
+
+	pid = do_clone(get_userns_fd_cb, NULL, CLONE_NEWUSER | CLONE_NEWNS);
+	if (pid < 0)
+		return -errno;
+
+	ret = map_ids_from_idmap(idmap, pid);
+	if (ret < 0)
+		return ret;
+
+	ret = snprintf(path_ns, sizeof(path_ns), "/proc/%d/ns/user", pid);
+	if (ret < 0 || (size_t)ret >= sizeof(path_ns))
+		ret = -EIO;
+	else
+		ret = open(path_ns, O_RDONLY | O_CLOEXEC | O_NOCTTY);
+
+	(void)kill(pid, SIGKILL);
+	(void)wait_for_pid(pid);
+	return ret;
+}
+
+int get_userns_fd(unsigned long nsid, unsigned long hostid, unsigned long range)
+{
+	struct list head, uid_mapl, gid_mapl;
+	struct id_map uid_map = {
+		.map_type	= ID_TYPE_UID,
+		.nsid		= nsid,
+		.hostid		= hostid,
+		.range		= range,
+	};
+	struct id_map gid_map = {
+		.map_type	= ID_TYPE_GID,
+		.nsid		= nsid,
+		.hostid		= hostid,
+		.range		= range,
+	};
+
+	list_init(&head);
+	uid_mapl.elem = &uid_map;
+	gid_mapl.elem = &gid_map;
+	list_add_tail(&head, &uid_mapl);
+	list_add_tail(&head, &gid_mapl);
+
+	return get_userns_fd_from_idmap(&head);
+}
+
+bool switch_ids(uid_t uid, gid_t gid)
+{
+	if (setgroups(0, NULL))
+		return syserror("failure: setgroups");
+
+	if (setresgid(gid, gid, gid))
+		return syserror("failure: setresgid");
+
+	if (setresuid(uid, uid, uid))
+		return syserror("failure: setresuid");
+
+	/* Ensure we can access proc files from processes we can ptrace. */
+	if (prctl(PR_SET_DUMPABLE, 1, 0, 0, 0))
+		return syserror("failure: make dumpable");
+
+	return true;
+}
+
+static int create_userns_hierarchy(struct userns_hierarchy *h);
+
+static int userns_fd_cb(void *data)
+{
+	struct userns_hierarchy *h = data;
+	char c;
+	int ret;
+
+	ret = read_nointr(h->fd_event, &c, 1);
+	if (ret < 0)
+		return syserror("failure: read from socketpair");
+
+	/* Only switch ids if someone actually wrote a mapping for us. */
+	if (c == '1') {
+		if (!switch_ids(0, 0))
+			return syserror("failure: switch ids to 0");
+	}
+
+	ret = write_nointr(h->fd_event, "1", 1);
+	if (ret < 0)
+		return syserror("failure: write to socketpair");
+
+	ret = create_userns_hierarchy(++h);
+	if (ret < 0)
+		return syserror("failure: userns level %d", h->level);
+
+	return 0;
+}
+
+static int create_userns_hierarchy(struct userns_hierarchy *h)
+{
+	int fret = -1;
+	char c;
+	int fd_socket[2];
+	int fd_userns = -EBADF, ret = -1;
+	ssize_t bytes;
+	pid_t pid;
+	char path[256];
+
+	if (h->level == MAX_USERNS_LEVEL)
+		return 0;
+
+	ret = socketpair(AF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, fd_socket);
+	if (ret < 0)
+		return syserror("failure: create socketpair");
+
+	/* Note the CLONE_FILES | CLONE_VM when mucking with fds and memory. */
+	h->fd_event = fd_socket[1];
+	pid = do_clone(userns_fd_cb, h, CLONE_NEWUSER | CLONE_FILES | CLONE_VM);
+	if (pid < 0) {
+		syserror("failure: userns level %d", h->level);
+		goto out_close;
+	}
+
+	ret = map_ids_from_idmap(&h->id_map, pid);
+	if (ret < 0) {
+		kill(pid, SIGKILL);
+		syserror("failure: writing id mapping for userns level %d for %d", h->level, pid);
+		goto out_wait;
+	}
+
+	if (!list_empty(&h->id_map))
+		bytes = write_nointr(fd_socket[0], "1", 1); /* Inform the child we wrote a mapping. */
+	else
+		bytes = write_nointr(fd_socket[0], "0", 1); /* Inform the child we didn't write a mapping. */
+	if (bytes < 0) {
+		kill(pid, SIGKILL);
+		syserror("failure: write to socketpair");
+		goto out_wait;
+	}
+
+	/* Wait for child to set*id() and become dumpable. */
+	bytes = read_nointr(fd_socket[0], &c, 1);
+	if (bytes < 0) {
+		kill(pid, SIGKILL);
+		syserror("failure: read from socketpair");
+		goto out_wait;
+	}
+
+	snprintf(path, sizeof(path), "/proc/%d/ns/user", pid);
+	fd_userns = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd_userns < 0) {
+		kill(pid, SIGKILL);
+		syserror("failure: open userns level %d for %d", h->level, pid);
+		goto out_wait;
+	}
+
+	fret = 0;
+
+out_wait:
+	if (!wait_for_pid(pid) && !fret) {
+		h->fd_userns = fd_userns;
+		fd_userns = -EBADF;
+	}
+
+out_close:
+	if (fd_userns >= 0)
+		close(fd_userns);
+	close(fd_socket[0]);
+	close(fd_socket[1]);
+	return fret;
+}
+
+/* caps_down - lower all effective caps */
+int caps_down(void)
+{
+	bool fret = false;
+	cap_t caps = NULL;
+	int ret = -1;
+
+	caps = cap_get_proc();
+	if (!caps)
+		goto out;
+
+	ret = cap_clear_flag(caps, CAP_EFFECTIVE);
+	if (ret)
+		goto out;
+
+	ret = cap_set_proc(caps);
+	if (ret)
+		goto out;
+
+	fret = true;
+
+out:
+	cap_free(caps);
+	return fret;
+}
diff --git a/tools/testing/selftests/filesystems/utils.h b/tools/testing/selftests/filesystems/utils.h
new file mode 100644
index 000000000000..f35001a75f99
--- /dev/null
+++ b/tools/testing/selftests/filesystems/utils.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __IDMAP_UTILS_H
+#define __IDMAP_UTILS_H
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <errno.h>
+#include <linux/types.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <sys/capability.h>
+#include <sys/fsuid.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+extern int get_userns_fd(unsigned long nsid, unsigned long hostid,
+			 unsigned long range);
+
+extern int caps_down(void);
+
+extern bool switch_ids(uid_t uid, gid_t gid);
+
+static inline bool switch_userns(int fd, uid_t uid, gid_t gid, bool drop_caps)
+{
+	if (setns(fd, CLONE_NEWUSER))
+		return false;
+
+	if (!switch_ids(uid, gid))
+		return false;
+
+	if (drop_caps && !caps_down())
+		return false;
+
+	return true;
+}
+
+#endif /* __IDMAP_UTILS_H */

-- 
2.47.2


