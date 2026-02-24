Return-Path: <linux-fsdevel+bounces-78212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gL8WGJvznGk5MQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 01:40:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EDF18049A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 01:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C991307035C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296AC230BF6;
	Tue, 24 Feb 2026 00:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAp4btHN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6081367
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 00:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771893641; cv=none; b=ukEENvBEIhuUsIP0qLmwXSkWJ82Y7vJ/N6bvF3DcczJvssfE5OV+Zf3fCXv1bf6j/Qgs25nQ0CaF4UsqJfFyGURePZPTAkzbI7BbOUO+ATJbwUIJWOWQmNaQuo8jRwMtUd9riyQNIYDVHgEnp3fI6HYKWQCSeBFcMKsqbhoSiDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771893641; c=relaxed/simple;
	bh=d22Db9pXYXXh3TsdMtjxi494sILdmPhvELafLaJsZnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HL+U+JCkg25647o2bgus2b7zSTqYejgn3n+O1dW/SvcH7FWDpZNfIUMuWHl0i7JybIDgWkBDXXLkVamY+3/t0KJLggjDq2oCyliZSNP50Jr5mEqubK/TIhY+no504Z1XRRcPA2euJsk9rTpsG7IJ5pcBYjFLX+NrX9D2pbHJn6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAp4btHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24178C116C6;
	Tue, 24 Feb 2026 00:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771893641;
	bh=d22Db9pXYXXh3TsdMtjxi494sILdmPhvELafLaJsZnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MAp4btHNlsbDsDi6heE9RWpBb46ME9Vg8u32QzMUIk99b0WrMBc+eJhiwlb8E+pKC
	 j2h+OrKaLeyP9aUEDgh95uixvMS+UCEFaakOQXoEN/ItjDmgAvyNIVLh5UkdJeigYS
	 WK4+S5kFocPqE/Z+IhkMBv/Q6eGxqFDitDja1glwZxX+9dV1w1Jtcpm0/XiAdL24XG
	 LcFuKacAGa1XlFJ9r6QblZYgvHFsp5NFsX4xNVz9MVHu1P7e4VAh5YGLVmnuNiotg9
	 TFvB8Qkdj6PcHWTwzlcV4nDBdo0pS6JVpvmHRiAI8tgStTjPtSy2zeI9xEjINOIu8b
	 /6IQkCt9bTscg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Feb 2026 01:40:28 +0100
Subject: [PATCH RFC 3/3] selftests/filesystems: add MOVE_MOUNT_BENEATH
 rootfs tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-work-mount-beneath-rootfs-v1-3-8c58bf08488f@kernel.org>
References: <20260224-work-mount-beneath-rootfs-v1-0-8c58bf08488f@kernel.org>
In-Reply-To: <20260224-work-mount-beneath-rootfs-v1-0-8c58bf08488f@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=16279; i=brauner@kernel.org;
 h=from:subject:message-id; bh=d22Db9pXYXXh3TsdMtjxi494sILdmPhvELafLaJsZnw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTO+dy8K/B4mbb6Io4khwlKCQXNTzQdN9a3izdYpSy5u
 /5117WUjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInUezH8d6njWfVxoVrFau6a
 04sin3UV7ypr3HLjzcNZe6r9c9K8jBgZ9rwMU1vyfqlu/iOt9i96W7R+uIW+OWw8432/yNqrvrc
 ucQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78212-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0EDF18049A
X-Rspamd-Action: no action

Add tests for mounting beneath the rootfs using MOVE_MOUNT_BENEATH:

- beneath_rootfs_success: mount beneath /, fchdir, chroot, umount2
  MNT_DETACH -- verify root changed
- beneath_rootfs_old_root_stacked: after mount-beneath, verify old root
  parent is clone via statmount
- beneath_rootfs_in_chroot_fail: chroot into subdir of same mount,
  mount-beneath fails (dentry != mnt_root)
- beneath_rootfs_in_chroot_success: chroot into separate tmpfs mount,
  mount-beneath succeeds
- beneath_rootfs_locked_transfer: in user+mount ns: mount-beneath
  rootfs succeeds, MNT_LOCKED transfers, old root unmountable
- beneath_rootfs_locked_containment: in user+mount ns: after full
  root-switch workflow, new root is MNT_LOCKED (containment preserved)
- beneath_non_rootfs_locked_transfer: mounts created before
  unshare(CLONE_NEWUSER | CLONE_NEWNS) become locked; mount-beneath
  transfers MNT_LOCKED, displaced mount can be unmounted
- beneath_non_rootfs_locked_containment: same setup, verify new mount
  is MNT_LOCKED (containment preserved)

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/Makefile                   |   1 +
 .../selftests/filesystems/move_mount/.gitignore    |   2 +
 .../selftests/filesystems/move_mount/Makefile      |  10 +
 .../filesystems/move_mount/move_mount_test.c       | 492 +++++++++++++++++++++
 4 files changed, 505 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 450f13ba4cca..2d05b3e1a26e 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -38,6 +38,7 @@ TARGETS += filesystems/overlayfs
 TARGETS += filesystems/statmount
 TARGETS += filesystems/mount-notify
 TARGETS += filesystems/fuse
+TARGETS += filesystems/move_mount
 TARGETS += firmware
 TARGETS += fpu
 TARGETS += ftrace
diff --git a/tools/testing/selftests/filesystems/move_mount/.gitignore b/tools/testing/selftests/filesystems/move_mount/.gitignore
new file mode 100644
index 000000000000..c7557db30671
--- /dev/null
+++ b/tools/testing/selftests/filesystems/move_mount/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+move_mount_test
diff --git a/tools/testing/selftests/filesystems/move_mount/Makefile b/tools/testing/selftests/filesystems/move_mount/Makefile
new file mode 100644
index 000000000000..5c5b199b464b
--- /dev/null
+++ b/tools/testing/selftests/filesystems/move_mount/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
+LDLIBS += -lcap
+
+TEST_GEN_PROGS := move_mount_test
+
+include ../../lib.mk
+
+$(OUTPUT)/move_mount_test: ../utils.c
diff --git a/tools/testing/selftests/filesystems/move_mount/move_mount_test.c b/tools/testing/selftests/filesystems/move_mount/move_mount_test.c
new file mode 100644
index 000000000000..f08f94b1f0ec
--- /dev/null
+++ b/tools/testing/selftests/filesystems/move_mount/move_mount_test.c
@@ -0,0 +1,492 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2026 Christian Brauner <brauner@kernel.org>
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/mount.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+
+#include "../wrappers.h"
+#include "../utils.h"
+#include "../statmount/statmount.h"
+#include "../../kselftest_harness.h"
+
+#include <linux/stat.h>
+
+#ifndef MOVE_MOUNT_BENEATH
+#define MOVE_MOUNT_BENEATH 0x00000200
+#endif
+
+static uint64_t get_unique_mnt_id_fd(int fd)
+{
+	struct statx sx;
+	int ret;
+
+	ret = statx(fd, "", AT_EMPTY_PATH, STATX_MNT_ID_UNIQUE, &sx);
+	if (ret)
+		return 0;
+
+	if (!(sx.stx_mask & STATX_MNT_ID_UNIQUE))
+		return 0;
+
+	return sx.stx_mnt_id;
+}
+
+/*
+ * Create a locked overmount stack at /mnt_dir for testing MNT_LOCKED
+ * transfer on non-rootfs mounts.
+ *
+ * Mounts tmpfs A at /mnt_dir, overmounts with tmpfs B, then enters a
+ * new user+mount namespace where both become locked. Returns the exit
+ * code to use on failure, or 0 on success.
+ */
+static int setup_locked_overmount(void)
+{
+	/* Isolate so mounts don't leak. */
+	if (unshare(CLONE_NEWNS))
+		return 1;
+	if (mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL))
+		return 2;
+
+	/*
+	 * Create mounts while still in the initial user namespace so
+	 * they become locked after the subsequent user namespace
+	 * unshare.
+	 */
+	rmdir("/mnt_dir");
+	if (mkdir("/mnt_dir", 0755))
+		return 3;
+
+	/* Mount tmpfs A */
+	if (mount("tmpfs", "/mnt_dir", "tmpfs", 0, NULL))
+		return 4;
+
+	/* Overmount with tmpfs B */
+	if (mount("tmpfs", "/mnt_dir", "tmpfs", 0, NULL))
+		return 5;
+
+	/*
+	 * Create user+mount namespace. Mounts A and B become locked
+	 * because they might be covering something that is not supposed
+	 * to be revealed.
+	 */
+	if (setup_userns())
+		return 6;
+
+	/* Sanity check: B must be locked */
+	if (!umount2("/mnt_dir", MNT_DETACH) || errno != EINVAL)
+		return 7;
+
+	return 0;
+}
+
+/*
+ * Create a detached tmpfs mount and return its fd, or -1 on failure.
+ */
+static int create_detached_tmpfs(void)
+{
+	int fs_fd, mnt_fd;
+
+	fs_fd = sys_fsopen("tmpfs", FSOPEN_CLOEXEC);
+	if (fs_fd < 0)
+		return -1;
+
+	if (sys_fsconfig(fs_fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0)) {
+		close(fs_fd);
+		return -1;
+	}
+
+	mnt_fd = sys_fsmount(fs_fd, FSMOUNT_CLOEXEC, 0);
+	close(fs_fd);
+	return mnt_fd;
+}
+
+FIXTURE(move_mount) {
+	uint64_t orig_root_id;
+};
+
+FIXTURE_SETUP(move_mount)
+{
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+
+	ASSERT_EQ(mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+
+	self->orig_root_id = get_unique_mnt_id("/");
+	ASSERT_NE(self->orig_root_id, 0);
+}
+
+FIXTURE_TEARDOWN(move_mount)
+{
+}
+
+/*
+ * Test successful MOVE_MOUNT_BENEATH on the rootfs.
+ * Mount a clone beneath /, fchdir to the clone, chroot to switch root,
+ * then detach the old root.
+ */
+TEST_F(move_mount, beneath_rootfs_success)
+{
+	int fd_tree, ret;
+	uint64_t clone_id, root_id;
+
+	fd_tree = sys_open_tree(AT_FDCWD, "/",
+				OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
+	ASSERT_GE(fd_tree, 0);
+
+	clone_id = get_unique_mnt_id_fd(fd_tree);
+	ASSERT_NE(clone_id, 0);
+	ASSERT_NE(clone_id, self->orig_root_id);
+
+	ASSERT_EQ(fchdir(fd_tree), 0);
+
+	ret = sys_move_mount(fd_tree, "", AT_FDCWD, "/",
+			     MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_BENEATH);
+	ASSERT_EQ(ret, 0);
+
+	close(fd_tree);
+
+	/* Switch root to the clone */
+	ASSERT_EQ(chroot("."), 0);
+
+	/* Verify "/" is now the clone */
+	root_id = get_unique_mnt_id("/");
+	ASSERT_NE(root_id, 0);
+	ASSERT_EQ(root_id, clone_id);
+
+	/* Detach old root */
+	ASSERT_EQ(umount2(".", MNT_DETACH), 0);
+}
+
+/*
+ * Test that after MOVE_MOUNT_BENEATH on the rootfs the old root is
+ * stacked on top of the clone. Verify via statmount that the old
+ * root's parent is the clone.
+ */
+TEST_F(move_mount, beneath_rootfs_old_root_stacked)
+{
+	int fd_tree, ret;
+	uint64_t clone_id;
+	struct statmount sm;
+
+	fd_tree = sys_open_tree(AT_FDCWD, "/",
+				OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
+	ASSERT_GE(fd_tree, 0);
+
+	clone_id = get_unique_mnt_id_fd(fd_tree);
+	ASSERT_NE(clone_id, 0);
+	ASSERT_NE(clone_id, self->orig_root_id);
+
+	ASSERT_EQ(fchdir(fd_tree), 0);
+
+	ret = sys_move_mount(fd_tree, "", AT_FDCWD, "/",
+			     MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_BENEATH);
+	ASSERT_EQ(ret, 0);
+
+	close(fd_tree);
+
+	ASSERT_EQ(chroot("."), 0);
+
+	/* Old root's parent should now be the clone */
+	ASSERT_EQ(statmount(self->orig_root_id, 0, 0,
+			     STATMOUNT_MNT_BASIC, &sm, sizeof(sm), 0), 0);
+	ASSERT_EQ(sm.mnt_parent_id, clone_id);
+
+	ASSERT_EQ(umount2(".", MNT_DETACH), 0);
+}
+
+/*
+ * Test that MOVE_MOUNT_BENEATH on rootfs fails when chroot'd into a
+ * subdirectory of the same mount. The caller's fs->root.dentry doesn't
+ * match mnt->mnt_root so the kernel rejects it.
+ */
+TEST_F(move_mount, beneath_rootfs_in_chroot_fail)
+{
+	int fd_tree, ret;
+	uint64_t chroot_id, clone_id;
+
+	rmdir("/chroot_dir");
+	ASSERT_EQ(mkdir("/chroot_dir", 0755), 0);
+
+	chroot_id = get_unique_mnt_id("/chroot_dir");
+	ASSERT_NE(chroot_id, 0);
+	ASSERT_EQ(self->orig_root_id, chroot_id);
+
+	ASSERT_EQ(chdir("/chroot_dir"), 0);
+	ASSERT_EQ(chroot("."), 0);
+
+	fd_tree = sys_open_tree(AT_FDCWD, "/",
+				OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
+	ASSERT_GE(fd_tree, 0);
+
+	clone_id = get_unique_mnt_id_fd(fd_tree);
+	ASSERT_NE(clone_id, 0);
+	ASSERT_NE(clone_id, chroot_id);
+
+	ASSERT_EQ(fchdir(fd_tree), 0);
+
+	/*
+	 * Should fail: fs->root.dentry (/chroot_dir) doesn't match
+	 * the mount's mnt_root (/).
+	 */
+	ret = sys_move_mount(fd_tree, "", AT_FDCWD, "/",
+			     MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_BENEATH);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	close(fd_tree);
+}
+
+/*
+ * Test that MOVE_MOUNT_BENEATH on rootfs succeeds when chroot'd into a
+ * separate tmpfs mount. The caller's root dentry matches the mount's
+ * mnt_root since it's a dedicated mount.
+ */
+TEST_F(move_mount, beneath_rootfs_in_chroot_success)
+{
+	int fd_tree, ret;
+	uint64_t chroot_id, clone_id, root_id;
+	struct statmount sm;
+
+	rmdir("/chroot_dir");
+	ASSERT_EQ(mkdir("/chroot_dir", 0755), 0);
+	ASSERT_EQ(mount("tmpfs", "/chroot_dir", "tmpfs", 0, NULL), 0);
+
+	chroot_id = get_unique_mnt_id("/chroot_dir");
+	ASSERT_NE(chroot_id, 0);
+
+	ASSERT_EQ(chdir("/chroot_dir"), 0);
+	ASSERT_EQ(chroot("."), 0);
+
+	ASSERT_EQ(get_unique_mnt_id("/"), chroot_id);
+
+	fd_tree = sys_open_tree(AT_FDCWD, "/",
+				OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
+	ASSERT_GE(fd_tree, 0);
+
+	clone_id = get_unique_mnt_id_fd(fd_tree);
+	ASSERT_NE(clone_id, 0);
+	ASSERT_NE(clone_id, chroot_id);
+
+	ASSERT_EQ(fchdir(fd_tree), 0);
+
+	ret = sys_move_mount(fd_tree, "", AT_FDCWD, "/",
+			     MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_BENEATH);
+	ASSERT_EQ(ret, 0);
+
+	close(fd_tree);
+
+	ASSERT_EQ(chroot("."), 0);
+
+	root_id = get_unique_mnt_id("/");
+	ASSERT_NE(root_id, 0);
+	ASSERT_EQ(root_id, clone_id);
+
+	ASSERT_EQ(statmount(chroot_id, 0, 0,
+			     STATMOUNT_MNT_BASIC, &sm, sizeof(sm), 0), 0);
+	ASSERT_EQ(sm.mnt_parent_id, clone_id);
+
+	ASSERT_EQ(umount2(".", MNT_DETACH), 0);
+}
+
+/*
+ * Test MNT_LOCKED transfer when mounting beneath rootfs in a user+mount
+ * namespace. After mount-beneath the new root gets MNT_LOCKED and the
+ * old root has MNT_LOCKED cleared so it can be unmounted.
+ */
+TEST_F(move_mount, beneath_rootfs_locked_transfer)
+{
+	int fd_tree, ret;
+	uint64_t clone_id, root_id;
+
+	ASSERT_EQ(setup_userns(), 0);
+
+	ASSERT_EQ(mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+
+	fd_tree = sys_open_tree(AT_FDCWD, "/",
+				OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC |
+				AT_RECURSIVE);
+	ASSERT_GE(fd_tree, 0);
+
+	clone_id = get_unique_mnt_id_fd(fd_tree);
+	ASSERT_NE(clone_id, 0);
+
+	ASSERT_EQ(fchdir(fd_tree), 0);
+
+	ret = sys_move_mount(fd_tree, "", AT_FDCWD, "/",
+			     MOVE_MOUNT_F_EMPTY_PATH |
+			     MOVE_MOUNT_BENEATH);
+	ASSERT_EQ(ret, 0);
+
+	close(fd_tree);
+
+	ASSERT_EQ(chroot("."), 0);
+
+	root_id = get_unique_mnt_id("/");
+	ASSERT_EQ(root_id, clone_id);
+
+	/*
+	 * The old root should be unmountable (MNT_LOCKED was
+	 * transferred to the clone). If MNT_LOCKED wasn't
+	 * cleared, this would fail with EINVAL.
+	 */
+	ASSERT_EQ(umount2(".", MNT_DETACH), 0);
+
+	/* Verify "/" is still the clone after detaching old root */
+	root_id = get_unique_mnt_id("/");
+	ASSERT_EQ(root_id, clone_id);
+}
+
+/*
+ * Test containment invariant: after mount-beneath rootfs in a user+mount
+ * namespace, the new root must be MNT_LOCKED. The lock transfer from the
+ * old root preserves containment -- the process cannot unmount the new root
+ * to escape the namespace.
+ */
+TEST_F(move_mount, beneath_rootfs_locked_containment)
+{
+	int fd_tree, ret;
+	uint64_t clone_id, root_id;
+
+	ASSERT_EQ(setup_userns(), 0);
+
+	ASSERT_EQ(mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+
+	/* Sanity: rootfs must be locked in the new userns */
+	ASSERT_EQ(umount2("/", MNT_DETACH), -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	fd_tree = sys_open_tree(AT_FDCWD, "/",
+				OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC |
+				AT_RECURSIVE);
+	ASSERT_GE(fd_tree, 0);
+
+	clone_id = get_unique_mnt_id_fd(fd_tree);
+	ASSERT_NE(clone_id, 0);
+
+	ASSERT_EQ(fchdir(fd_tree), 0);
+
+	ret = sys_move_mount(fd_tree, "", AT_FDCWD, "/",
+			     MOVE_MOUNT_F_EMPTY_PATH |
+			     MOVE_MOUNT_BENEATH);
+	ASSERT_EQ(ret, 0);
+
+	close(fd_tree);
+
+	ASSERT_EQ(chroot("."), 0);
+
+	root_id = get_unique_mnt_id("/");
+	ASSERT_EQ(root_id, clone_id);
+
+	/* Detach old root (MNT_LOCKED was cleared from it) */
+	ASSERT_EQ(umount2(".", MNT_DETACH), 0);
+
+	/* Verify "/" is still the clone after detaching old root */
+	root_id = get_unique_mnt_id("/");
+	ASSERT_EQ(root_id, clone_id);
+
+	/*
+	 * The new root must be locked (MNT_LOCKED was transferred
+	 * from the old root). Attempting to unmount it must fail
+	 * with EINVAL, preserving the containment invariant.
+	 */
+	ASSERT_EQ(umount2("/", MNT_DETACH), -1);
+	ASSERT_EQ(errno, EINVAL);
+}
+
+/*
+ * Test MNT_LOCKED transfer when mounting beneath a non-rootfs locked mount.
+ * Mounts created before unshare(CLONE_NEWUSER | CLONE_NEWNS) become locked
+ * in the new namespace. Mount-beneath transfers the lock from the displaced
+ * mount to the new mount, so the displaced mount can be unmounted.
+ */
+TEST_F(move_mount, beneath_non_rootfs_locked_transfer)
+{
+	int mnt_fd, ret;
+	uint64_t mnt_new_id, mnt_visible_id;
+
+	ASSERT_EQ(setup_locked_overmount(), 0);
+
+	mnt_fd = create_detached_tmpfs();
+	ASSERT_GE(mnt_fd, 0);
+
+	mnt_new_id = get_unique_mnt_id_fd(mnt_fd);
+	ASSERT_NE(mnt_new_id, 0);
+
+	/* Move mount beneath B (which is locked) */
+	ret = sys_move_mount(mnt_fd, "", AT_FDCWD, "/mnt_dir",
+			     MOVE_MOUNT_F_EMPTY_PATH |
+			     MOVE_MOUNT_BENEATH);
+	ASSERT_EQ(ret, 0);
+
+	close(mnt_fd);
+
+	/*
+	 * B should now be unmountable (MNT_LOCKED was transferred
+	 * to the new mount beneath it). If MNT_LOCKED wasn't
+	 * cleared from B, this would fail with EINVAL.
+	 */
+	ASSERT_EQ(umount2("/mnt_dir", MNT_DETACH), 0);
+
+	/* Verify the new mount is now visible */
+	mnt_visible_id = get_unique_mnt_id("/mnt_dir");
+	ASSERT_EQ(mnt_visible_id, mnt_new_id);
+}
+
+/*
+ * Test MNT_LOCKED containment when mounting beneath a non-rootfs mount
+ * that was locked during unshare(CLONE_NEWUSER | CLONE_NEWNS).
+ * Mounts created before unshare become locked in the new namespace.
+ * Mount-beneath transfers the lock, preserving containment: the new
+ * mount cannot be unmounted, but the displaced mount can.
+ */
+TEST_F(move_mount, beneath_non_rootfs_locked_containment)
+{
+	int mnt_fd, ret;
+	uint64_t mnt_new_id, mnt_visible_id;
+
+	ASSERT_EQ(setup_locked_overmount(), 0);
+
+	mnt_fd = create_detached_tmpfs();
+	ASSERT_GE(mnt_fd, 0);
+
+	mnt_new_id = get_unique_mnt_id_fd(mnt_fd);
+	ASSERT_NE(mnt_new_id, 0);
+
+	/*
+	 * Move new tmpfs beneath B at /mnt_dir.
+	 * Stack becomes: A -> new -> B
+	 * Lock transfers from B to new.
+	 */
+	ret = sys_move_mount(mnt_fd, "", AT_FDCWD, "/mnt_dir",
+			     MOVE_MOUNT_F_EMPTY_PATH |
+			     MOVE_MOUNT_BENEATH);
+	ASSERT_EQ(ret, 0);
+
+	close(mnt_fd);
+
+	/*
+	 * B lost MNT_LOCKED -- unmounting it must succeed.
+	 * This reveals the new mount at /mnt_dir.
+	 */
+	ASSERT_EQ(umount2("/mnt_dir", MNT_DETACH), 0);
+
+	/* Verify the new mount is now visible */
+	mnt_visible_id = get_unique_mnt_id("/mnt_dir");
+	ASSERT_EQ(mnt_visible_id, mnt_new_id);
+
+	/*
+	 * The new mount gained MNT_LOCKED -- unmounting it must
+	 * fail with EINVAL, preserving the containment invariant.
+	 */
+	ASSERT_EQ(umount2("/mnt_dir", MNT_DETACH), -1);
+	ASSERT_EQ(errno, EINVAL);
+}
+
+TEST_HARNESS_MAIN

-- 
2.47.3


