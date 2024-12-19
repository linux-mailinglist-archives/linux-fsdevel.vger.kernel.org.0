Return-Path: <linux-fsdevel+bounces-37834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368AC9F80EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C95A1673E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14B019CD07;
	Thu, 19 Dec 2024 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coSZE1xR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6020D199934
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627710; cv=none; b=WtK0D+f0j6DuG2LvmNBweXj3M7WTxp1XoUMTvENMVODKJ7S2Gc+Hlm12rkL2phVknK82/bIbUJHxZycnYqFx8KfmLbnZXTX3YBdR0us36mMyxCf5BgSYKBrUPIeL+Q04dUKWAveKX63DRvQoYFoN5bse170E3yo2M0cYNOUbXM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627710; c=relaxed/simple;
	bh=qmEB2Y6bezr+nfIPJCxY7JwaxXfLApJFaBdmJHlBgvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yb9FPaKjRDTVfu34FUTkzJ8Qk4QpNj6gIcXY6CBQNDafih+qrWgAwa7QqHkTO69PaT/N/dMZaPvaDPMdFZ0cdhAD3utsRkWTtcAUQW65QKwP17VlEyu5gnRaMFkkNgcPEjcWDRzncMrvI4aiKXCOo77FnXtrn5kljQ0KKrct8iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coSZE1xR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87A5C4CED6;
	Thu, 19 Dec 2024 17:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734627709;
	bh=qmEB2Y6bezr+nfIPJCxY7JwaxXfLApJFaBdmJHlBgvQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=coSZE1xRsMw/n9/E24pXN2YMmNGtcFqk8dluSq6Xt2awo9CCD4khasa+hjnYyniqA
	 ECrUCFYAVwLCNKj0A9oLZ/CjJJbvc6n5KSXEID5lnM4+5waqzNG69WaAb6juRdc36W
	 PbKjxg8c7SwWXpdm4sU1gSpr63i1gjH+u1N7dL7XWzF0lweYJ9ZnZIRaUfg6XT0NPz
	 bOSHlCeYUXY/qlMRjwBKLeBQVrkIYsc2OSeVub487sCSUKGvhUjoWF7woMy+HyFK65
	 RikPdKxzX5EhQB6Zttn12JUXJzmJJgPMMdSltB19B8zzvI2ZPXaFZTHxr0o1XJznwC
	 WzRgcaq8lLFfw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 19 Dec 2024 18:01:33 +0100
Subject: [PATCH RFC 2/2] selftests: add pidfd bind-mount tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-work-pidfs-mount-v1-2-dbc56198b839@kernel.org>
References: <20241219-work-pidfs-mount-v1-0-dbc56198b839@kernel.org>
In-Reply-To: <20241219-work-pidfs-mount-v1-0-dbc56198b839@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6996; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qmEB2Y6bezr+nfIPJCxY7JwaxXfLApJFaBdmJHlBgvQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSnBFbM2H2Hz//C2vU8oXLNUWwTc9P/3Gi8dUIwe6Gzo
 cTNI1F9HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZu5ThD8+7oIrHljaNbyoP
 StwV10i/mJ967LlG8nUmy/7kiW95fjH8r3nUckiroTHsZ8QzvsoG4dP6Cq0TuJ9/EHtpccf6/VE
 jFgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/.gitignore         |   1 +
 tools/testing/selftests/pidfd/Makefile           |   2 +-
 tools/testing/selftests/pidfd/pidfd_bind_mount.c | 188 +++++++++++++++++++++++
 3 files changed, 190 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/.gitignore b/tools/testing/selftests/pidfd/.gitignore
index 224260e1a4a24a235309a8fdd2186f44845773ed..bf92481f925c32ad4b2e49a9183711ec235bdadc 100644
--- a/tools/testing/selftests/pidfd/.gitignore
+++ b/tools/testing/selftests/pidfd/.gitignore
@@ -7,3 +7,4 @@ pidfd_fdinfo_test
 pidfd_getfd_test
 pidfd_setns_test
 pidfd_file_handle_test
+pidfd_bind_mount
diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index 3c16d8e776843f10d09f553ce6915317522d01dc..301343a11b62ecdf25d9f8ffeba690b84dc5c378 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -3,7 +3,7 @@ CFLAGS += -g $(KHDR_INCLUDES) -pthread -Wall
 
 TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test \
 	pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test \
-	pidfd_file_handle_test
+	pidfd_file_handle_test pidfd_bind_mount
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/pidfd/pidfd_bind_mount.c b/tools/testing/selftests/pidfd/pidfd_bind_mount.c
new file mode 100644
index 0000000000000000000000000000000000000000..7822dd080258b12786660c3a7d94f8dd5fe5b76f
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_bind_mount.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2024 Christian Brauner <brauner@kernel.org>
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <limits.h>
+#include <sched.h>
+#include <stdio.h>
+#include <string.h>
+#include <linux/fs.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/mount.h>
+#include <unistd.h>
+
+#include "pidfd.h"
+#include "../kselftest_harness.h"
+
+#ifndef __NR_open_tree
+	#if defined __alpha__
+		#define __NR_open_tree 538
+	#elif defined _MIPS_SIM
+		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
+			#define __NR_open_tree 4428
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
+			#define __NR_open_tree 6428
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
+			#define __NR_open_tree 5428
+		#endif
+	#elif defined __ia64__
+		#define __NR_open_tree (428 + 1024)
+	#else
+		#define __NR_open_tree 428
+	#endif
+#endif
+
+#ifndef __NR_move_mount
+	#if defined __alpha__
+		#define __NR_move_mount 539
+	#elif defined _MIPS_SIM
+		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
+			#define __NR_move_mount 4429
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
+			#define __NR_move_mount 6429
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
+			#define __NR_move_mount 5429
+		#endif
+	#elif defined __ia64__
+		#define __NR_move_mount (428 + 1024)
+	#else
+		#define __NR_move_mount 429
+	#endif
+#endif
+
+#ifndef MOVE_MOUNT_F_EMPTY_PATH
+#define MOVE_MOUNT_F_EMPTY_PATH 0x00000004 /* Empty from path permitted */
+#endif
+
+#ifndef MOVE_MOUNT_F_EMPTY_PATH
+#define MOVE_MOUNT_T_EMPTY_PATH 0x00000040 /* Empty to path permitted */
+#endif
+
+static inline int sys_move_mount(int from_dfd, const char *from_pathname,
+                                 int to_dfd, const char *to_pathname,
+                                 unsigned int flags)
+{
+        return syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd,
+                       to_pathname, flags);
+}
+
+#ifndef OPEN_TREE_CLONE
+#define OPEN_TREE_CLONE 1
+#endif
+
+#ifndef OPEN_TREE_CLOEXEC
+#define OPEN_TREE_CLOEXEC O_CLOEXEC
+#endif
+
+#ifndef AT_RECURSIVE
+#define AT_RECURSIVE 0x8000 /* Apply to the entire subtree */
+#endif
+
+static inline int sys_open_tree(int dfd, const char *filename, unsigned int flags)
+{
+	return syscall(__NR_open_tree, dfd, filename, flags);
+}
+
+FIXTURE(pidfd_bind_mount) {
+	char template[PATH_MAX];
+	int fd_tmp;
+	int pidfd;
+	struct stat st1;
+	struct stat st2;
+	__u32 gen1;
+	__u32 gen2;
+	bool must_unmount;
+};
+
+FIXTURE_SETUP(pidfd_bind_mount)
+{
+	self->fd_tmp = -EBADF;
+	self->must_unmount = false;
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_LE(snprintf(self->template, PATH_MAX, "%s", P_tmpdir "/pidfd_bind_mount_XXXXXX"), PATH_MAX);
+	self->fd_tmp = mkstemp(self->template);
+	ASSERT_GE(self->fd_tmp, 0);
+	self->pidfd = sys_pidfd_open(getpid(), 0);
+	ASSERT_GE(self->pidfd, 0);
+	ASSERT_GE(fstat(self->pidfd, &self->st1), 0);
+	ASSERT_EQ(ioctl(self->pidfd, FS_IOC_GETVERSION, &self->gen1), 0);
+}
+
+FIXTURE_TEARDOWN(pidfd_bind_mount)
+{
+	ASSERT_EQ(close(self->fd_tmp), 0);
+	if (self->must_unmount)
+		ASSERT_EQ(umount2(self->template, 0), 0);
+	ASSERT_EQ(unlink(self->template), 0);
+}
+
+/*
+ * Test that a detached mount can be created for a pidfd and then
+ * attached to the filesystem hierarchy.
+ */
+TEST_F(pidfd_bind_mount, bind_mount)
+{
+	int fd_tree;
+
+	fd_tree = sys_open_tree(self->pidfd, "", OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC | AT_EMPTY_PATH);
+	ASSERT_GE(fd_tree, 0);
+
+	ASSERT_EQ(move_mount(fd_tree, "", self->fd_tmp, "", MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_T_EMPTY_PATH), 0);
+	self->must_unmount = true;
+
+	ASSERT_EQ(close(fd_tree), 0);
+}
+
+/* Test that a pidfd can be reopened through procfs. */
+TEST_F(pidfd_bind_mount, reopen)
+{
+	int pidfd;
+	char proc_path[PATH_MAX];
+
+	sprintf(proc_path, "/proc/self/fd/%d", self->pidfd);
+	pidfd = open(proc_path, O_RDONLY | O_NOCTTY | O_CLOEXEC);
+	ASSERT_GE(pidfd, 0);
+
+	ASSERT_GE(fstat(self->pidfd, &self->st2), 0);
+	ASSERT_EQ(ioctl(self->pidfd, FS_IOC_GETVERSION, &self->gen2), 0);
+
+	ASSERT_TRUE(self->st1.st_dev == self->st2.st_dev && self->st1.st_ino == self->st2.st_ino);
+	ASSERT_TRUE(self->gen1 == self->gen2);
+
+	ASSERT_EQ(close(pidfd), 0);
+}
+
+/*
+ * Test that a detached mount can be created for a pidfd and then
+ * attached to the filesystem hierarchy and reopened.
+ */
+TEST_F(pidfd_bind_mount, bind_mount_reopen)
+{
+	int fd_tree, fd_pidfd_mnt;
+
+	fd_tree = sys_open_tree(self->pidfd, "", OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC | AT_EMPTY_PATH);
+	ASSERT_GE(fd_tree, 0);
+
+	ASSERT_EQ(move_mount(fd_tree, "", self->fd_tmp, "", MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_T_EMPTY_PATH), 0);
+	self->must_unmount = true;
+
+	fd_pidfd_mnt = openat(-EBADF, self->template, O_RDONLY | O_NOCTTY | O_CLOEXEC);
+	ASSERT_GE(fd_pidfd_mnt, 0);
+
+	ASSERT_GE(fstat(fd_tree, &self->st2), 0);
+	ASSERT_EQ(ioctl(fd_pidfd_mnt, FS_IOC_GETVERSION, &self->gen2), 0);
+
+	ASSERT_TRUE(self->st1.st_dev == self->st2.st_dev && self->st1.st_ino == self->st2.st_ino);
+	ASSERT_TRUE(self->gen1 == self->gen2);
+
+	ASSERT_EQ(close(fd_tree), 0);
+	ASSERT_EQ(close(fd_pidfd_mnt), 0);
+}
+
+TEST_HARNESS_MAIN

-- 
2.45.2


