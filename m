Return-Path: <linux-fsdevel+bounces-72181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B93CFCE6D21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 14:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5658301989D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 13:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F19E27AC3A;
	Mon, 29 Dec 2025 13:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shbfyk42"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AFA1E8826
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767013426; cv=none; b=sHHwlO9VUpU5F/RXkOAIdxsTpFjelBAFKr/t3+H2Orr/NIJJaeqIB2hMsveL4VN7wSjm1AcIak+mrF7FR0ohEQ7v62tmqyCq//OfOOea2b269UAYG9VnyZtLErq/zRr5Y3um4zp/oUtaK3txVfJcM7zK6GY7x7KChW+JryOI4ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767013426; c=relaxed/simple;
	bh=i06q8JzdMBgIaReJlyv833T6625//6VXM2jutcOAA1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iSYjfFUjCXuHN8RixItkg6Yt3UdnkyMUFTvfCCnuoangnz3HDKggBplDnwD+tX+fmMYZlzzVSya+2ciQeasYk2x65gFApobnE/bNoBeKdAFUSGIWmbrGuwoHYjPa1VwBTYHKM0w/1YzRiLwwF4Bp7lZEZr2RMxwQtxEIJgamKBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shbfyk42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76265C4CEF7;
	Mon, 29 Dec 2025 13:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767013426;
	bh=i06q8JzdMBgIaReJlyv833T6625//6VXM2jutcOAA1E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=shbfyk42OOcOIMYWFUwva5ZCB8Tmw8mE3A0RBm46OrC8BzkTgzzkVpksqV/BzrDod
	 qUmUt4lmrKgZV7AVyLMDqYKnemJ1y8RIwBAxwXhIlIZiCzQXour0Tqvb14Z32k560h
	 X3THaQJCpiWcpRNhOhkbqcQBKJQD0IxLiENnQE1hpHVB2SkPedA3v0HLgJ3LmzXPFe
	 3O4dpnBLbnKTetMT536UFjkofYSIDELe/3OCQzQXaa6A+EyXU0XupYgat0hRFScfko
	 1ADkV/5OokSbqk0R7KGQEuX9alpf0gx9G44s0TnokQQSLYqEZxiGgle/809T9EdZxP
	 c8ZyqUY+nT4EQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 29 Dec 2025 14:03:25 +0100
Subject: [PATCH 2/2] selftests/open_tree: add OPEN_TREE_NAMESPACE tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251229-work-empty-namespace-v1-2-bfb24c7b061f@kernel.org>
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
In-Reply-To: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=27127; i=brauner@kernel.org;
 h=from:subject:message-id; bh=i06q8JzdMBgIaReJlyv833T6625//6VXM2jutcOAA1E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQG1ai726xyfpue5ioV36hr9FuiUVsmoSt7rVtqVdmUI
 +f0i9U6SlkYxLgYZMUUWRzaTcLllvNUbDbK1ICZw8oEMoSBi1MAJvKag5HhQ9myd9IMytyq4WXn
 c49vPDEh7sY8Zd9ld3RPpm/vvL5vEcM/+yBVPbEoLx6PfqP5qVccOE8cXazRbzjz7pcPHTEbeNq
 ZAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add tests for OPEN_TREE_NAMESPACE.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/filesystems/open_tree_ns/.gitignore  |    1 +
 .../selftests/filesystems/open_tree_ns/Makefile    |   10 +
 .../filesystems/open_tree_ns/open_tree_ns_test.c   | 1030 ++++++++++++++++++++
 tools/testing/selftests/filesystems/utils.c        |   26 +
 tools/testing/selftests/filesystems/utils.h        |    1 +
 5 files changed, 1068 insertions(+)

diff --git a/tools/testing/selftests/filesystems/open_tree_ns/.gitignore b/tools/testing/selftests/filesystems/open_tree_ns/.gitignore
new file mode 100644
index 000000000000..fb12b93fbcaa
--- /dev/null
+++ b/tools/testing/selftests/filesystems/open_tree_ns/.gitignore
@@ -0,0 +1 @@
+open_tree_ns_test
diff --git a/tools/testing/selftests/filesystems/open_tree_ns/Makefile b/tools/testing/selftests/filesystems/open_tree_ns/Makefile
new file mode 100644
index 000000000000..73c03c4a7ef6
--- /dev/null
+++ b/tools/testing/selftests/filesystems/open_tree_ns/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+TEST_GEN_PROGS := open_tree_ns_test
+
+CFLAGS := -Wall -Werror -g $(KHDR_INCLUDES)
+LDLIBS := -lcap
+
+include ../../lib.mk
+
+$(OUTPUT)/open_tree_ns_test: open_tree_ns_test.c ../utils.c
+	$(CC) $(CFLAGS) -o $@ $^ $(LDLIBS)
diff --git a/tools/testing/selftests/filesystems/open_tree_ns/open_tree_ns_test.c b/tools/testing/selftests/filesystems/open_tree_ns/open_tree_ns_test.c
new file mode 100644
index 000000000000..9711556280ae
--- /dev/null
+++ b/tools/testing/selftests/filesystems/open_tree_ns/open_tree_ns_test.c
@@ -0,0 +1,1030 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test for OPEN_TREE_NAMESPACE flag.
+ *
+ * Test that open_tree() with OPEN_TREE_NAMESPACE creates a new mount
+ * namespace containing the specified mount tree.
+ */
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <linux/nsfs.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "../wrappers.h"
+#include "../statmount/statmount.h"
+#include "../utils.h"
+#include "../../kselftest_harness.h"
+
+#ifndef OPEN_TREE_NAMESPACE
+#define OPEN_TREE_NAMESPACE	(1 << 1)
+#endif
+
+static int get_mnt_ns_id(int fd, uint64_t *mnt_ns_id)
+{
+	if (ioctl(fd, NS_GET_MNTNS_ID, mnt_ns_id) < 0)
+		return -errno;
+	return 0;
+}
+
+static int get_mnt_ns_id_from_path(const char *path, uint64_t *mnt_ns_id)
+{
+	int fd, ret;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -errno;
+
+	ret = get_mnt_ns_id(fd, mnt_ns_id);
+	close(fd);
+	return ret;
+}
+
+#define STATMOUNT_BUFSIZE (1 << 15)
+
+static struct statmount *statmount_alloc(uint64_t mnt_id, uint64_t mnt_ns_id, uint64_t mask)
+{
+	struct statmount *buf;
+	size_t bufsize = STATMOUNT_BUFSIZE;
+	int ret;
+
+	for (;;) {
+		buf = malloc(bufsize);
+		if (!buf)
+			return NULL;
+
+		ret = statmount(mnt_id, mnt_ns_id, mask, buf, bufsize, 0);
+		if (ret == 0)
+			return buf;
+
+		free(buf);
+		if (errno != EOVERFLOW)
+			return NULL;
+
+		bufsize <<= 1;
+	}
+}
+
+static void log_mount(struct __test_metadata *_metadata, struct statmount *sm)
+{
+	const char *fs_type = "";
+	const char *mnt_root = "";
+	const char *mnt_point = "";
+
+	if (sm->mask & STATMOUNT_FS_TYPE)
+		fs_type = sm->str + sm->fs_type;
+	if (sm->mask & STATMOUNT_MNT_ROOT)
+		mnt_root = sm->str + sm->mnt_root;
+	if (sm->mask & STATMOUNT_MNT_POINT)
+		mnt_point = sm->str + sm->mnt_point;
+
+	TH_LOG("  mnt_id: %llu, parent_id: %llu, fs_type: %s, root: %s, point: %s",
+	       (unsigned long long)sm->mnt_id,
+	       (unsigned long long)sm->mnt_parent_id,
+	       fs_type, mnt_root, mnt_point);
+}
+
+static void dump_mounts(struct __test_metadata *_metadata, uint64_t mnt_ns_id)
+{
+	uint64_t list[256];
+	ssize_t nr_mounts;
+
+	nr_mounts = listmount(LSMT_ROOT, mnt_ns_id, 0, list, 256, 0);
+	if (nr_mounts < 0) {
+		TH_LOG("listmount failed: %s", strerror(errno));
+		return;
+	}
+
+	TH_LOG("Mount namespace %llu contains %zd mount(s):",
+	       (unsigned long long)mnt_ns_id, nr_mounts);
+
+	for (ssize_t i = 0; i < nr_mounts; i++) {
+		struct statmount *sm;
+
+		sm = statmount_alloc(list[i], mnt_ns_id,
+				     STATMOUNT_MNT_BASIC |
+				     STATMOUNT_FS_TYPE |
+				     STATMOUNT_MNT_ROOT |
+				     STATMOUNT_MNT_POINT);
+		if (!sm) {
+			TH_LOG("  [%zd] mnt_id %llu: statmount failed: %s",
+			       i, (unsigned long long)list[i], strerror(errno));
+			continue;
+		}
+
+		log_mount(_metadata, sm);
+		free(sm);
+	}
+}
+
+FIXTURE(open_tree_ns)
+{
+	int fd;
+	uint64_t current_ns_id;
+};
+
+FIXTURE_VARIANT(open_tree_ns)
+{
+	const char *path;
+	unsigned int flags;
+	bool expect_success;
+	bool expect_different_ns;
+	int min_mounts;
+};
+
+FIXTURE_VARIANT_ADD(open_tree_ns, basic_root)
+{
+	.path = "/",
+	.flags = OPEN_TREE_NAMESPACE | OPEN_TREE_CLOEXEC,
+	.expect_success = true,
+	.expect_different_ns = true,
+	/*
+	 * The empty rootfs is hidden from listmount()/mountinfo,
+	 * so we only see the bind mount on top of it.
+	 */
+	.min_mounts = 1,
+};
+
+FIXTURE_VARIANT_ADD(open_tree_ns, recursive_root)
+{
+	.path = "/",
+	.flags = OPEN_TREE_NAMESPACE | AT_RECURSIVE | OPEN_TREE_CLOEXEC,
+	.expect_success = true,
+	.expect_different_ns = true,
+	.min_mounts = 1,
+};
+
+FIXTURE_VARIANT_ADD(open_tree_ns, subdir_tmp)
+{
+	.path = "/tmp",
+	.flags = OPEN_TREE_NAMESPACE | OPEN_TREE_CLOEXEC,
+	.expect_success = true,
+	.expect_different_ns = true,
+	.min_mounts = 1,
+};
+
+FIXTURE_VARIANT_ADD(open_tree_ns, subdir_proc)
+{
+	.path = "/proc",
+	.flags = OPEN_TREE_NAMESPACE | OPEN_TREE_CLOEXEC,
+	.expect_success = true,
+	.expect_different_ns = true,
+	.min_mounts = 1,
+};
+
+FIXTURE_VARIANT_ADD(open_tree_ns, recursive_tmp)
+{
+	.path = "/tmp",
+	.flags = OPEN_TREE_NAMESPACE | AT_RECURSIVE | OPEN_TREE_CLOEXEC,
+	.expect_success = true,
+	.expect_different_ns = true,
+	.min_mounts = 1,
+};
+
+FIXTURE_VARIANT_ADD(open_tree_ns, recursive_run)
+{
+	.path = "/run",
+	.flags = OPEN_TREE_NAMESPACE | AT_RECURSIVE | OPEN_TREE_CLOEXEC,
+	.expect_success = true,
+	.expect_different_ns = true,
+	.min_mounts = 1,
+};
+
+FIXTURE_VARIANT_ADD(open_tree_ns, invalid_recursive_alone)
+{
+	.path = "/",
+	.flags = AT_RECURSIVE | OPEN_TREE_CLOEXEC,
+	.expect_success = false,
+	.expect_different_ns = false,
+	.min_mounts = 0,
+};
+
+FIXTURE_SETUP(open_tree_ns)
+{
+	int ret;
+
+	self->fd = -1;
+
+	/* Check if open_tree syscall is supported */
+	ret = sys_open_tree(-1, NULL, 0);
+	if (ret == -1 && errno == ENOSYS)
+		SKIP(return, "open_tree() syscall not supported");
+
+	/* Check if statmount/listmount are supported */
+	ret = statmount(0, 0, 0, NULL, 0, 0);
+	if (ret == -1 && errno == ENOSYS)
+		SKIP(return, "statmount() syscall not supported");
+
+	/* Get current mount namespace ID for comparison */
+	ret = get_mnt_ns_id_from_path("/proc/self/ns/mnt", &self->current_ns_id);
+	if (ret < 0)
+		SKIP(return, "Failed to get current mount namespace ID");
+}
+
+FIXTURE_TEARDOWN(open_tree_ns)
+{
+	if (self->fd >= 0)
+		close(self->fd);
+}
+
+TEST_F(open_tree_ns, create_namespace)
+{
+	uint64_t new_ns_id;
+	uint64_t list[256];
+	ssize_t nr_mounts;
+	int ret;
+
+	self->fd = sys_open_tree(AT_FDCWD, variant->path, variant->flags);
+
+	if (!variant->expect_success) {
+		ASSERT_LT(self->fd, 0);
+		ASSERT_EQ(errno, EINVAL);
+		return;
+	}
+
+	if (self->fd < 0 && errno == EINVAL)
+		SKIP(return, "OPEN_TREE_NAMESPACE not supported");
+
+	ASSERT_GE(self->fd, 0);
+
+	/* Verify we can get the namespace ID */
+	ret = get_mnt_ns_id(self->fd, &new_ns_id);
+	ASSERT_EQ(ret, 0);
+
+	/* Verify it's a different namespace */
+	if (variant->expect_different_ns)
+		ASSERT_NE(new_ns_id, self->current_ns_id);
+
+	/* List mounts in the new namespace */
+	nr_mounts = listmount(LSMT_ROOT, new_ns_id, 0, list, 256, 0);
+	ASSERT_GE(nr_mounts, 0) {
+		TH_LOG("%m - listmount failed");
+	}
+
+	/* Verify minimum expected mounts */
+	ASSERT_GE(nr_mounts, variant->min_mounts);
+	TH_LOG("Namespace contains %zd mounts", nr_mounts);
+}
+
+TEST_F(open_tree_ns, setns_into_namespace)
+{
+	uint64_t new_ns_id;
+	pid_t pid;
+	int status;
+	int ret;
+
+	/* Only test with basic flags */
+	if (!(variant->flags & OPEN_TREE_NAMESPACE))
+		SKIP(return, "setns test only for basic / case");
+
+	self->fd = sys_open_tree(AT_FDCWD, variant->path, variant->flags);
+	if (self->fd < 0 && errno == EINVAL)
+		SKIP(return, "OPEN_TREE_NAMESPACE not supported");
+
+	ASSERT_GE(self->fd, 0);
+
+	/* Get namespace ID and dump all mounts */
+	ret = get_mnt_ns_id(self->fd, &new_ns_id);
+	ASSERT_EQ(ret, 0);
+
+	dump_mounts(_metadata, new_ns_id);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child: try to enter the namespace */
+		if (setns(self->fd, CLONE_NEWNS) < 0)
+			_exit(1);
+		_exit(0);
+	}
+
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+}
+
+TEST_F(open_tree_ns, verify_mount_properties)
+{
+	struct statmount sm;
+	uint64_t new_ns_id;
+	uint64_t list[256];
+	ssize_t nr_mounts;
+	int ret;
+
+	/* Only test with basic flags on root */
+	if (variant->flags != (OPEN_TREE_NAMESPACE | OPEN_TREE_CLOEXEC) ||
+	    strcmp(variant->path, "/") != 0)
+		SKIP(return, "mount properties test only for basic / case");
+
+	self->fd = sys_open_tree(AT_FDCWD, "/", OPEN_TREE_NAMESPACE | OPEN_TREE_CLOEXEC);
+	if (self->fd < 0 && errno == EINVAL)
+		SKIP(return, "OPEN_TREE_NAMESPACE not supported");
+
+	ASSERT_GE(self->fd, 0);
+
+	ret = get_mnt_ns_id(self->fd, &new_ns_id);
+	ASSERT_EQ(ret, 0);
+
+	nr_mounts = listmount(LSMT_ROOT, new_ns_id, 0, list, 256, 0);
+	ASSERT_GE(nr_mounts, 1);
+
+	/* Get info about the root mount (the bind mount, rootfs is hidden) */
+	ret = statmount(list[0], new_ns_id, STATMOUNT_MNT_BASIC, &sm, sizeof(sm), 0);
+	ASSERT_EQ(ret, 0);
+
+	ASSERT_NE(sm.mnt_id, sm.mnt_parent_id);
+
+	TH_LOG("Root mount id: %llu, parent: %llu",
+	       (unsigned long long)sm.mnt_id,
+	       (unsigned long long)sm.mnt_parent_id);
+}
+
+FIXTURE(open_tree_ns_caps)
+{
+	bool has_caps;
+};
+
+FIXTURE_SETUP(open_tree_ns_caps)
+{
+	int ret;
+
+	/* Check if open_tree syscall is supported */
+	ret = sys_open_tree(-1, NULL, 0);
+	if (ret == -1 && errno == ENOSYS)
+		SKIP(return, "open_tree() syscall not supported");
+
+	self->has_caps = (geteuid() == 0);
+}
+
+FIXTURE_TEARDOWN(open_tree_ns_caps)
+{
+}
+
+TEST_F(open_tree_ns_caps, requires_cap_sys_admin)
+{
+	pid_t pid;
+	int status;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		int fd;
+
+		/* Child: drop privileges using utils.h helper */
+		if (enter_userns() != 0)
+			_exit(2);
+
+		/* Drop all caps using utils.h helper */
+		if (caps_down() == 0)
+			_exit(3);
+
+		fd = sys_open_tree(AT_FDCWD, "/",
+				   OPEN_TREE_NAMESPACE | OPEN_TREE_CLOEXEC);
+		if (fd >= 0) {
+			close(fd);
+			/* Should have failed without caps */
+			_exit(1);
+		}
+
+		if (errno == EPERM)
+			_exit(0);
+
+		/* EINVAL means OPEN_TREE_NAMESPACE not supported */
+		if (errno == EINVAL)
+			_exit(4);
+
+		/* Unexpected error */
+		_exit(5);
+	}
+
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	ASSERT_TRUE(WIFEXITED(status));
+
+	switch (WEXITSTATUS(status)) {
+	case 0:
+		/* Expected: EPERM without caps */
+		break;
+	case 1:
+		ASSERT_FALSE(true) TH_LOG("OPEN_TREE_NAMESPACE succeeded without caps");
+		break;
+	case 2:
+		SKIP(return, "setup_userns failed");
+		break;
+	case 3:
+		SKIP(return, "caps_down failed");
+		break;
+	case 4:
+		SKIP(return, "OPEN_TREE_NAMESPACE not supported");
+		break;
+	default:
+		ASSERT_FALSE(true) TH_LOG("Unexpected error in child (exit %d)",
+					  WEXITSTATUS(status));
+		break;
+	}
+}
+
+FIXTURE(open_tree_ns_userns)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(open_tree_ns_userns)
+{
+	int ret;
+
+	self->fd = -1;
+
+	/* Check if open_tree syscall is supported */
+	ret = sys_open_tree(-1, NULL, 0);
+	if (ret == -1 && errno == ENOSYS)
+		SKIP(return, "open_tree() syscall not supported");
+
+	/* Check if statmount/listmount are supported */
+	ret = statmount(0, 0, 0, NULL, 0, 0);
+	if (ret == -1 && errno == ENOSYS)
+		SKIP(return, "statmount() syscall not supported");
+}
+
+FIXTURE_TEARDOWN(open_tree_ns_userns)
+{
+	if (self->fd >= 0)
+		close(self->fd);
+}
+
+TEST_F(open_tree_ns_userns, create_in_userns)
+{
+	pid_t pid;
+	int status;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		uint64_t new_ns_id;
+		uint64_t list[256];
+		ssize_t nr_mounts;
+		int fd;
+
+		/* Create new user namespace (also creates mount namespace) */
+		if (enter_userns() != 0)
+			_exit(2);
+
+		/* Now we have CAP_SYS_ADMIN in the user namespace */
+		fd = sys_open_tree(AT_FDCWD, "/",
+				   OPEN_TREE_NAMESPACE | OPEN_TREE_CLOEXEC);
+		if (fd < 0) {
+			if (errno == EINVAL)
+				_exit(4); /* OPEN_TREE_NAMESPACE not supported */
+			_exit(1);
+		}
+
+		/* Verify we can get the namespace ID */
+		if (get_mnt_ns_id(fd, &new_ns_id) != 0)
+			_exit(5);
+
+		/* Verify we can list mounts in the new namespace */
+		nr_mounts = listmount(LSMT_ROOT, new_ns_id, 0, list, 256, 0);
+		if (nr_mounts < 0)
+			_exit(6);
+
+		/* Should have at least 1 mount */
+		if (nr_mounts < 1)
+			_exit(7);
+
+		close(fd);
+		_exit(0);
+	}
+
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	ASSERT_TRUE(WIFEXITED(status));
+
+	switch (WEXITSTATUS(status)) {
+	case 0:
+		/* Success */
+		break;
+	case 1:
+		ASSERT_FALSE(true) TH_LOG("open_tree(OPEN_TREE_NAMESPACE) failed in userns");
+		break;
+	case 2:
+		SKIP(return, "setup_userns failed");
+		break;
+	case 4:
+		SKIP(return, "OPEN_TREE_NAMESPACE not supported");
+		break;
+	case 5:
+		ASSERT_FALSE(true) TH_LOG("Failed to get mount namespace ID");
+		break;
+	case 6:
+		ASSERT_FALSE(true) TH_LOG("listmount failed in new namespace");
+		break;
+	case 7:
+		ASSERT_FALSE(true) TH_LOG("New namespace has no mounts");
+		break;
+	default:
+		ASSERT_FALSE(true) TH_LOG("Unexpected error in child (exit %d)",
+					  WEXITSTATUS(status));
+		break;
+	}
+}
+
+TEST_F(open_tree_ns_userns, setns_in_userns)
+{
+	pid_t pid;
+	int status;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		uint64_t new_ns_id;
+		int fd;
+		pid_t inner_pid;
+		int inner_status;
+
+		/* Create new user namespace */
+		if (enter_userns() != 0)
+			_exit(2);
+
+		fd = sys_open_tree(AT_FDCWD, "/",
+				   OPEN_TREE_NAMESPACE | OPEN_TREE_CLOEXEC);
+		if (fd < 0) {
+			if (errno == EINVAL)
+				_exit(4);
+			_exit(1);
+		}
+
+		if (get_mnt_ns_id(fd, &new_ns_id) != 0)
+			_exit(5);
+
+		/* Fork again to test setns into the new namespace */
+		inner_pid = fork();
+		if (inner_pid < 0)
+			_exit(8);
+
+		if (inner_pid == 0) {
+			/* Inner child: enter the new namespace */
+			if (setns(fd, CLONE_NEWNS) < 0)
+				_exit(1);
+			_exit(0);
+		}
+
+		if (waitpid(inner_pid, &inner_status, 0) != inner_pid)
+			_exit(9);
+
+		if (!WIFEXITED(inner_status) || WEXITSTATUS(inner_status) != 0)
+			_exit(10);
+
+		close(fd);
+		_exit(0);
+	}
+
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	ASSERT_TRUE(WIFEXITED(status));
+
+	switch (WEXITSTATUS(status)) {
+	case 0:
+		/* Success */
+		break;
+	case 1:
+		ASSERT_FALSE(true) TH_LOG("open_tree or setns failed in userns");
+		break;
+	case 2:
+		SKIP(return, "setup_userns failed");
+		break;
+	case 4:
+		SKIP(return, "OPEN_TREE_NAMESPACE not supported");
+		break;
+	case 5:
+		ASSERT_FALSE(true) TH_LOG("Failed to get mount namespace ID");
+		break;
+	case 8:
+		ASSERT_FALSE(true) TH_LOG("Inner fork failed");
+		break;
+	case 9:
+		ASSERT_FALSE(true) TH_LOG("Inner waitpid failed");
+		break;
+	case 10:
+		ASSERT_FALSE(true) TH_LOG("setns into new namespace failed");
+		break;
+	default:
+		ASSERT_FALSE(true) TH_LOG("Unexpected error in child (exit %d)",
+					  WEXITSTATUS(status));
+		break;
+	}
+}
+
+TEST_F(open_tree_ns_userns, recursive_in_userns)
+{
+	pid_t pid;
+	int status;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		uint64_t new_ns_id;
+		uint64_t list[256];
+		ssize_t nr_mounts;
+		int fd;
+
+		/* Create new user namespace */
+		if (enter_userns() != 0)
+			_exit(2);
+
+		/* Test recursive flag in userns */
+		fd = sys_open_tree(AT_FDCWD, "/",
+				   OPEN_TREE_NAMESPACE | AT_RECURSIVE | OPEN_TREE_CLOEXEC);
+		if (fd < 0) {
+			if (errno == EINVAL)
+				_exit(4);
+			_exit(1);
+		}
+
+		if (get_mnt_ns_id(fd, &new_ns_id) != 0)
+			_exit(5);
+
+		nr_mounts = listmount(LSMT_ROOT, new_ns_id, 0, list, 256, 0);
+		if (nr_mounts < 0)
+			_exit(6);
+
+		/* Recursive should copy submounts too */
+		if (nr_mounts < 1)
+			_exit(7);
+
+		close(fd);
+		_exit(0);
+	}
+
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	ASSERT_TRUE(WIFEXITED(status));
+
+	switch (WEXITSTATUS(status)) {
+	case 0:
+		/* Success */
+		break;
+	case 1:
+		ASSERT_FALSE(true) TH_LOG("open_tree(OPEN_TREE_NAMESPACE|AT_RECURSIVE) failed in userns");
+		break;
+	case 2:
+		SKIP(return, "setup_userns failed");
+		break;
+	case 4:
+		SKIP(return, "OPEN_TREE_NAMESPACE not supported");
+		break;
+	case 5:
+		ASSERT_FALSE(true) TH_LOG("Failed to get mount namespace ID");
+		break;
+	case 6:
+		ASSERT_FALSE(true) TH_LOG("listmount failed in new namespace");
+		break;
+	case 7:
+		ASSERT_FALSE(true) TH_LOG("New namespace has no mounts");
+		break;
+	default:
+		ASSERT_FALSE(true) TH_LOG("Unexpected error in child (exit %d)",
+					  WEXITSTATUS(status));
+		break;
+	}
+}
+
+TEST_F(open_tree_ns_userns, umount_fails_einval)
+{
+	pid_t pid;
+	int status;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		uint64_t new_ns_id;
+		uint64_t list[256];
+		ssize_t nr_mounts;
+		int fd;
+		ssize_t i;
+
+		/* Create new user namespace */
+		if (enter_userns() != 0)
+			_exit(2);
+
+		fd = sys_open_tree(AT_FDCWD, "/",
+				   OPEN_TREE_NAMESPACE | AT_RECURSIVE | OPEN_TREE_CLOEXEC);
+		if (fd < 0) {
+			if (errno == EINVAL)
+				_exit(4);
+			_exit(1);
+		}
+
+		if (get_mnt_ns_id(fd, &new_ns_id) != 0)
+			_exit(5);
+
+		/* Get all mounts in the new namespace */
+		nr_mounts = listmount(LSMT_ROOT, new_ns_id, 0, list, 256, LISTMOUNT_REVERSE);
+		if (nr_mounts < 0)
+			_exit(9);
+
+		if (nr_mounts < 1)
+			_exit(10);
+
+		/* Enter the new namespace */
+		if (setns(fd, CLONE_NEWNS) < 0)
+			_exit(6);
+
+		for (i = 0; i < nr_mounts; i++) {
+			struct statmount *sm;
+			const char *mnt_point;
+
+			sm = statmount_alloc(list[i], new_ns_id,
+					     STATMOUNT_MNT_POINT);
+			if (!sm)
+				_exit(11);
+
+			mnt_point = sm->str + sm->mnt_point;
+
+			TH_LOG("Trying to umount %s", mnt_point);
+			if (umount2(mnt_point, MNT_DETACH) == 0) {
+				free(sm);
+				_exit(7);
+			}
+
+			if (errno != EINVAL) {
+				/* Wrong error */
+				free(sm);
+				_exit(8);
+			}
+
+			free(sm);
+		}
+
+		close(fd);
+		_exit(0);
+	}
+
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	ASSERT_TRUE(WIFEXITED(status));
+
+	switch (WEXITSTATUS(status)) {
+	case 0:
+		break;
+	case 1:
+		ASSERT_FALSE(true) TH_LOG("open_tree(OPEN_TREE_NAMESPACE) failed");
+		break;
+	case 2:
+		SKIP(return, "setup_userns failed");
+		break;
+	case 4:
+		SKIP(return, "OPEN_TREE_NAMESPACE not supported");
+		break;
+	case 5:
+		ASSERT_FALSE(true) TH_LOG("Failed to get mount namespace ID");
+		break;
+	case 6:
+		ASSERT_FALSE(true) TH_LOG("setns into new namespace failed");
+		break;
+	case 7:
+		ASSERT_FALSE(true) TH_LOG("umount succeeded but should have failed with EINVAL");
+		break;
+	case 8:
+		ASSERT_FALSE(true) TH_LOG("umount failed with wrong error (expected EINVAL)");
+		break;
+	case 9:
+		ASSERT_FALSE(true) TH_LOG("listmount failed");
+		break;
+	case 10:
+		ASSERT_FALSE(true) TH_LOG("No mounts in new namespace");
+		break;
+	case 11:
+		ASSERT_FALSE(true) TH_LOG("statmount_alloc failed");
+		break;
+	default:
+		ASSERT_FALSE(true) TH_LOG("Unexpected error in child (exit %d)",
+					  WEXITSTATUS(status));
+		break;
+	}
+}
+
+TEST_F(open_tree_ns_userns, umount_succeeds)
+{
+	pid_t pid;
+	int status;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		uint64_t new_ns_id;
+		uint64_t list[256];
+		ssize_t nr_mounts;
+		int fd;
+		ssize_t i;
+
+		if (unshare(CLONE_NEWNS))
+			_exit(1);
+
+		if (sys_mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL) != 0)
+			_exit(1);
+
+		fd = sys_open_tree(AT_FDCWD, "/",
+				   OPEN_TREE_NAMESPACE | AT_RECURSIVE | OPEN_TREE_CLOEXEC);
+		if (fd < 0) {
+			if (errno == EINVAL)
+				_exit(4);
+			_exit(1);
+		}
+
+		if (get_mnt_ns_id(fd, &new_ns_id) != 0)
+			_exit(5);
+
+		/* Get all mounts in the new namespace */
+		nr_mounts = listmount(LSMT_ROOT, new_ns_id, 0, list, 256, LISTMOUNT_REVERSE);
+		if (nr_mounts < 0)
+			_exit(9);
+
+		if (nr_mounts < 1)
+			_exit(10);
+
+		/* Enter the new namespace */
+		if (setns(fd, CLONE_NEWNS) < 0)
+			_exit(6);
+
+		for (i = 0; i < nr_mounts; i++) {
+			struct statmount *sm;
+			const char *mnt_point;
+
+			sm = statmount_alloc(list[i], new_ns_id,
+					     STATMOUNT_MNT_POINT);
+			if (!sm)
+				_exit(11);
+
+			mnt_point = sm->str + sm->mnt_point;
+
+			TH_LOG("Trying to umount %s", mnt_point);
+			if (umount2(mnt_point, MNT_DETACH) != 0) {
+				free(sm);
+				_exit(7);
+			}
+
+			free(sm);
+		}
+
+		close(fd);
+		_exit(0);
+	}
+
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	ASSERT_TRUE(WIFEXITED(status));
+
+	switch (WEXITSTATUS(status)) {
+	case 0:
+		break;
+	case 1:
+		ASSERT_FALSE(true) TH_LOG("open_tree(OPEN_TREE_NAMESPACE) failed");
+		break;
+	case 2:
+		SKIP(return, "setup_userns failed");
+		break;
+	case 4:
+		SKIP(return, "OPEN_TREE_NAMESPACE not supported");
+		break;
+	case 5:
+		ASSERT_FALSE(true) TH_LOG("Failed to get mount namespace ID");
+		break;
+	case 6:
+		ASSERT_FALSE(true) TH_LOG("setns into new namespace failed");
+		break;
+	case 7:
+		ASSERT_FALSE(true) TH_LOG("umount succeeded but should have failed with EINVAL");
+		break;
+	case 9:
+		ASSERT_FALSE(true) TH_LOG("listmount failed");
+		break;
+	case 10:
+		ASSERT_FALSE(true) TH_LOG("No mounts in new namespace");
+		break;
+	case 11:
+		ASSERT_FALSE(true) TH_LOG("statmount_alloc failed");
+		break;
+	default:
+		ASSERT_FALSE(true) TH_LOG("Unexpected error in child (exit %d)",
+					  WEXITSTATUS(status));
+		break;
+	}
+}
+
+FIXTURE(open_tree_ns_unbindable)
+{
+	char tmpdir[PATH_MAX];
+	bool mounted;
+};
+
+FIXTURE_SETUP(open_tree_ns_unbindable)
+{
+	int ret;
+
+	self->mounted = false;
+
+	/* Check if open_tree syscall is supported */
+	ret = sys_open_tree(-1, NULL, 0);
+	if (ret == -1 && errno == ENOSYS)
+		SKIP(return, "open_tree() syscall not supported");
+
+	/* Create a temporary directory for the test mount */
+	snprintf(self->tmpdir, sizeof(self->tmpdir),
+		 "/tmp/open_tree_ns_test.XXXXXX");
+	ASSERT_NE(mkdtemp(self->tmpdir), NULL);
+
+	/* Mount tmpfs there */
+	ret = mount("tmpfs", self->tmpdir, "tmpfs", 0, NULL);
+	if (ret < 0) {
+		rmdir(self->tmpdir);
+		SKIP(return, "Failed to mount tmpfs");
+	}
+	self->mounted = true;
+
+	ret = mount(NULL, self->tmpdir, NULL, MS_UNBINDABLE, NULL);
+	if (ret < 0) {
+		rmdir(self->tmpdir);
+		SKIP(return, "Failed to make tmpfs unbindable");
+	}
+}
+
+FIXTURE_TEARDOWN(open_tree_ns_unbindable)
+{
+	if (self->mounted)
+		umount2(self->tmpdir, MNT_DETACH);
+	rmdir(self->tmpdir);
+}
+
+TEST_F(open_tree_ns_unbindable, fails_on_unbindable)
+{
+	int fd;
+
+	fd = sys_open_tree(AT_FDCWD, self->tmpdir,
+			   OPEN_TREE_NAMESPACE | OPEN_TREE_CLOEXEC);
+	ASSERT_LT(fd, 0);
+}
+
+TEST_F(open_tree_ns_unbindable, recursive_skips_on_unbindable)
+{
+	uint64_t new_ns_id;
+	uint64_t list[256];
+	ssize_t nr_mounts;
+	int fd;
+	ssize_t i;
+	bool found_unbindable = false;
+
+	fd = sys_open_tree(AT_FDCWD, "/",
+			   OPEN_TREE_NAMESPACE | AT_RECURSIVE | OPEN_TREE_CLOEXEC);
+	ASSERT_GT(fd, 0);
+
+	ASSERT_EQ(get_mnt_ns_id(fd, &new_ns_id), 0);
+
+	nr_mounts = listmount(LSMT_ROOT, new_ns_id, 0, list, 256, 0);
+	ASSERT_GE(nr_mounts, 0) {
+		TH_LOG("listmount failed: %m");
+	}
+
+	/*
+	 * Iterate through all mounts in the new namespace and verify
+	 * the unbindable tmpfs mount was silently dropped.
+	 */
+	for (i = 0; i < nr_mounts; i++) {
+		struct statmount *sm;
+		const char *mnt_point;
+
+		sm = statmount_alloc(list[i], new_ns_id, STATMOUNT_MNT_POINT);
+		ASSERT_NE(sm, NULL) {
+			TH_LOG("statmount_alloc failed for mnt_id %llu",
+			       (unsigned long long)list[i]);
+		}
+
+		mnt_point = sm->str + sm->mnt_point;
+
+		if (strcmp(mnt_point, self->tmpdir) == 0) {
+			TH_LOG("Found unbindable mount at %s (should have been dropped)",
+			       mnt_point);
+			found_unbindable = true;
+		}
+
+		free(sm);
+	}
+
+	ASSERT_FALSE(found_unbindable) {
+		TH_LOG("Unbindable mount at %s was not dropped", self->tmpdir);
+	}
+
+	close(fd);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/filesystems/utils.c b/tools/testing/selftests/filesystems/utils.c
index c9dd5412b37b..d6f26f849053 100644
--- a/tools/testing/selftests/filesystems/utils.c
+++ b/tools/testing/selftests/filesystems/utils.c
@@ -515,6 +515,32 @@ int setup_userns(void)
 	return 0;
 }
 
+int enter_userns(void)
+{
+	int ret;
+	char buf[32];
+	uid_t uid = getuid();
+	gid_t gid = getgid();
+
+	ret = unshare(CLONE_NEWUSER);
+	if (ret)
+		return ret;
+
+	sprintf(buf, "0 %d 1", uid);
+	ret = write_file("/proc/self/uid_map", buf);
+	if (ret)
+		return ret;
+	ret = write_file("/proc/self/setgroups", "deny");
+	if (ret)
+		return ret;
+	sprintf(buf, "0 %d 1", gid);
+	ret = write_file("/proc/self/gid_map", buf);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 /* caps_down - lower all effective caps */
 int caps_down(void)
 {
diff --git a/tools/testing/selftests/filesystems/utils.h b/tools/testing/selftests/filesystems/utils.h
index 70f7ccc607f4..0bccfed666a9 100644
--- a/tools/testing/selftests/filesystems/utils.h
+++ b/tools/testing/selftests/filesystems/utils.h
@@ -28,6 +28,7 @@ extern int cap_down(cap_value_t down);
 
 extern bool switch_ids(uid_t uid, gid_t gid);
 extern int setup_userns(void);
+extern int enter_userns(void);
 
 static inline bool switch_userns(int fd, uid_t uid, gid_t gid, bool drop_caps)
 {

-- 
2.47.3


