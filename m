Return-Path: <linux-fsdevel+bounces-37248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 151A79EFFCD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 00:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1F81884B18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 23:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B72E1DE4FC;
	Thu, 12 Dec 2024 23:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loChbCzr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989011DE8B3
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 23:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734044652; cv=none; b=sIQcVb0G5ti9PvcEaabdChd+1tDx8YJd9hdGMBaVsEEapmgtq771h3GNKx140tKG025dz+QkVKq6JcJsLdsDf3XKq8kJjzlJGqHuuhuuos+/85l49uAuuuxlFFOqNlwMq3bv16zBHGvNl8MyEluyebpGRxvhBoIYcqQx0zKu4gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734044652; c=relaxed/simple;
	bh=al/0U83Z/lglQjfYEzBk3wEY2KZcIRmum1v/l7IqoME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aukOzynXW4hBnrPMIqJHP02vICs54wWdEel5JEiJPB68sdEczb7zb8pB3COiS617mDtzewRp81+bGGi0HyfsG8TZWuiHLV4DCoWjxkIadOZ+StHBUAlCA2G2lqIRhxV3jvK53jWajPpBFdrBBjemGkx1yO4JFFQnzaRwxZ4TeII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loChbCzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0385FC4CED0;
	Thu, 12 Dec 2024 23:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734044652;
	bh=al/0U83Z/lglQjfYEzBk3wEY2KZcIRmum1v/l7IqoME=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=loChbCzrJz5uf1CKxBt/M7lj9TCnLugNY10oVCRQXteeb66LR21g/vnIxplz/OF7v
	 EabjpINwIOSEKMIdGCAJ/Wk3E5ASOk2HusHbQczkrcjZNvHtMMyMptX9YG2dS6M6uG
	 vSbBM37tjTB7ZGe4BkC9NGWXHQZaaLXV4PgI80KjoaAqFJZJWUd8sipA66seCieT0E
	 /+7Vd5XOvXdy/oPoCMRHMeF4h8YSnP3+rlnDCjctRC9knh0ITm74z4J/XgpPS9U4zp
	 hVcr/jH4ts/D7TWVuUScvThkDijeM+V9Jk9pzPJcTxIVTRZUUWN2T4I8E9+V/ia3Pu
	 SiRi6OU0j6INA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 13 Dec 2024 00:03:47 +0100
Subject: [PATCH v3 08/10] selftests: add tests for mntns iteration
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-work-mount-rbtree-lockless-v3-8-6e3cdaf9b280@kernel.org>
References: <20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
In-Reply-To: <20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
 Peter Ziljstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5730; i=brauner@kernel.org;
 h=from:subject:message-id; bh=al/0U83Z/lglQjfYEzBk3wEY2KZcIRmum1v/l7IqoME=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHZ9/a3bD81N0j0+d7Ff4+fPW1TYDaqmP11kk9Itbu5
 /+1beua0FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARJ2ZGhsWCphO5LpYeaAr0
 8shymXa0z3hG+Kvg0wvW8+X3+fdtFGdkuLZ3Terl7pNP+iYls6555r9A5nHP55Lz7VEOdl/7w8V
 CmQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that forward and backward iteration works correctly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/filesystems/nsfs/.gitignore  |   1 +
 tools/testing/selftests/filesystems/nsfs/Makefile  |   2 +-
 .../selftests/filesystems/nsfs/iterate_mntns.c     | 149 +++++++++++++++++++++
 3 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/nsfs/.gitignore b/tools/testing/selftests/filesystems/nsfs/.gitignore
index ed79ebdf286e4d945cfbbf80fb072ba3e05c9112..92a8249006d1e0817800df0057183a94ef0f939d 100644
--- a/tools/testing/selftests/filesystems/nsfs/.gitignore
+++ b/tools/testing/selftests/filesystems/nsfs/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 owner
 pidns
+iterate_mntns
diff --git a/tools/testing/selftests/filesystems/nsfs/Makefile b/tools/testing/selftests/filesystems/nsfs/Makefile
index c2f3ca6e488e9ddb49514e1b8e93909d5594259b..231aaa7dfd95c638c23e0a8e5a1d4f7f16f00f7b 100644
--- a/tools/testing/selftests/filesystems/nsfs/Makefile
+++ b/tools/testing/selftests/filesystems/nsfs/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-TEST_GEN_PROGS := owner pidns
+TEST_GEN_PROGS := owner pidns iterate_mntns
 
 CFLAGS := -Wall -Werror
 
diff --git a/tools/testing/selftests/filesystems/nsfs/iterate_mntns.c b/tools/testing/selftests/filesystems/nsfs/iterate_mntns.c
new file mode 100644
index 0000000000000000000000000000000000000000..457cf76f3c5f368872292714b44c037968de4ad3
--- /dev/null
+++ b/tools/testing/selftests/filesystems/nsfs/iterate_mntns.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2024 Christian Brauner <brauner@kernel.org>
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/mount.h>
+#include <unistd.h>
+
+#include "../../kselftest_harness.h"
+
+#define MNT_NS_COUNT 11
+#define MNT_NS_LAST_INDEX 10
+
+struct mnt_ns_info {
+	__u32 size;
+	__u32 nr_mounts;
+	__u64 mnt_ns_id;
+};
+
+#define MNT_NS_INFO_SIZE_VER0 16 /* size of first published struct */
+
+/* Get information about namespace. */
+#define NS_MNT_GET_INFO _IOR(0xb7, 10, struct mnt_ns_info)
+/* Get next namespace. */
+#define NS_MNT_GET_NEXT _IOR(0xb7, 11, struct mnt_ns_info)
+/* Get previous namespace. */
+#define NS_MNT_GET_PREV _IOR(0xb7, 12, struct mnt_ns_info)
+
+FIXTURE(iterate_mount_namespaces) {
+	int fd_mnt_ns[MNT_NS_COUNT];
+	__u64 mnt_ns_id[MNT_NS_COUNT];
+};
+
+FIXTURE_SETUP(iterate_mount_namespaces)
+{
+	for (int i = 0; i < MNT_NS_COUNT; i++)
+		self->fd_mnt_ns[i] = -EBADF;
+
+	/*
+	 * Creating a new user namespace let's us guarantee that we only see
+	 * mount namespaces that we did actually create.
+	 */
+	ASSERT_EQ(unshare(CLONE_NEWUSER), 0);
+
+	for (int i = 0; i < MNT_NS_COUNT; i++) {
+		struct mnt_ns_info info = {};
+
+		ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+		self->fd_mnt_ns[i] = open("/proc/self/ns/mnt", O_RDONLY | O_CLOEXEC);
+		ASSERT_GE(self->fd_mnt_ns[i], 0);
+		ASSERT_EQ(ioctl(self->fd_mnt_ns[i], NS_MNT_GET_INFO, &info), 0);
+		self->mnt_ns_id[i] = info.mnt_ns_id;
+	}
+}
+
+FIXTURE_TEARDOWN(iterate_mount_namespaces)
+{
+	for (int i = 0; i < MNT_NS_COUNT; i++) {
+		if (self->fd_mnt_ns[i] < 0)
+			continue;
+		ASSERT_EQ(close(self->fd_mnt_ns[i]), 0);
+	}
+}
+
+TEST_F(iterate_mount_namespaces, iterate_all_forward)
+{
+	int fd_mnt_ns_cur, count = 0;
+
+	fd_mnt_ns_cur = fcntl(self->fd_mnt_ns[0], F_DUPFD_CLOEXEC);
+	ASSERT_GE(fd_mnt_ns_cur, 0);
+
+	for (;; count++) {
+		struct mnt_ns_info info = {};
+		int fd_mnt_ns_next;
+
+		fd_mnt_ns_next = ioctl(fd_mnt_ns_cur, NS_MNT_GET_NEXT, &info);
+		if (fd_mnt_ns_next < 0 && errno == ENOENT)
+			break;
+		ASSERT_GE(fd_mnt_ns_next, 0);
+		ASSERT_EQ(close(fd_mnt_ns_cur), 0);
+		fd_mnt_ns_cur = fd_mnt_ns_next;
+	}
+	ASSERT_EQ(count, MNT_NS_LAST_INDEX);
+}
+
+TEST_F(iterate_mount_namespaces, iterate_all_backwards)
+{
+	int fd_mnt_ns_cur, count = 0;
+
+	fd_mnt_ns_cur = fcntl(self->fd_mnt_ns[MNT_NS_LAST_INDEX], F_DUPFD_CLOEXEC);
+	ASSERT_GE(fd_mnt_ns_cur, 0);
+
+	for (;; count++) {
+		struct mnt_ns_info info = {};
+		int fd_mnt_ns_prev;
+
+		fd_mnt_ns_prev = ioctl(fd_mnt_ns_cur, NS_MNT_GET_PREV, &info);
+		if (fd_mnt_ns_prev < 0 && errno == ENOENT)
+			break;
+		ASSERT_GE(fd_mnt_ns_prev, 0);
+		ASSERT_EQ(close(fd_mnt_ns_cur), 0);
+		fd_mnt_ns_cur = fd_mnt_ns_prev;
+	}
+	ASSERT_EQ(count, MNT_NS_LAST_INDEX);
+}
+
+TEST_F(iterate_mount_namespaces, iterate_forward)
+{
+	int fd_mnt_ns_cur;
+
+	ASSERT_EQ(setns(self->fd_mnt_ns[0], CLONE_NEWNS), 0);
+
+	fd_mnt_ns_cur = self->fd_mnt_ns[0];
+	for (int i = 1; i < MNT_NS_COUNT; i++) {
+		struct mnt_ns_info info = {};
+		int fd_mnt_ns_next;
+
+		fd_mnt_ns_next = ioctl(fd_mnt_ns_cur, NS_MNT_GET_NEXT, &info);
+		ASSERT_GE(fd_mnt_ns_next, 0);
+		ASSERT_EQ(close(fd_mnt_ns_cur), 0);
+		fd_mnt_ns_cur = fd_mnt_ns_next;
+		ASSERT_EQ(info.mnt_ns_id, self->mnt_ns_id[i]);
+	}
+}
+
+TEST_F(iterate_mount_namespaces, iterate_backward)
+{
+	int fd_mnt_ns_cur;
+
+	ASSERT_EQ(setns(self->fd_mnt_ns[MNT_NS_LAST_INDEX], CLONE_NEWNS), 0);
+
+	fd_mnt_ns_cur = self->fd_mnt_ns[MNT_NS_LAST_INDEX];
+	for (int i = MNT_NS_LAST_INDEX - 1; i >= 0; i--) {
+		struct mnt_ns_info info = {};
+		int fd_mnt_ns_prev;
+
+		fd_mnt_ns_prev = ioctl(fd_mnt_ns_cur, NS_MNT_GET_PREV, &info);
+		ASSERT_GE(fd_mnt_ns_prev, 0);
+		ASSERT_EQ(close(fd_mnt_ns_cur), 0);
+		fd_mnt_ns_cur = fd_mnt_ns_prev;
+		ASSERT_EQ(info.mnt_ns_id, self->mnt_ns_id[i]);
+	}
+}
+
+TEST_HARNESS_MAIN

-- 
2.45.2


