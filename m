Return-Path: <linux-fsdevel+bounces-42232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 055BEA3F574
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 14:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44D6D7A6E18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 13:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784ED211484;
	Fri, 21 Feb 2025 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRUUBBOk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78F920FAB4
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143628; cv=none; b=I3h+dA18ipixY0ZgnzUVT5dMUDBJcLLibc6xDhMBtIFvKdvPvqRG7UmsbEX6H9tdC4vDpzAdH3UeazJFZVYaxv1/ndMhXBWnewYlQGuvSPGWNDg54TT+Bf/kElpNbAG8mmPg6uFLnCviAK4y10blxBEw3ehH1acDGOY5NWhb1LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143628; c=relaxed/simple;
	bh=EpU9vR3iTxPrntp01yjIB1gXH0Ycl2lD2v7cQkn5z3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KD3wGxBRKZUHY7n+3EwHhV75wCRxKKbhfbEgrnZXOe39fiDdKVAEHNiHojm+otvzlbRo47mfwCI7Q8bTXiRe8wLIPekWlQUcvRtggB86M+PCfUxTFwtO9T13jTkKTHK9PSJGUwHA5QdKb6e4TawiaJpUidc8XzZnWNOeRmVWcm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRUUBBOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B24C4CED6;
	Fri, 21 Feb 2025 13:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740143628;
	bh=EpU9vR3iTxPrntp01yjIB1gXH0Ycl2lD2v7cQkn5z3k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XRUUBBOkTOP7YyYjRbo6onC9Ejuwu1LygyxLlb2hWsgC+xwRPhF26XqL2SGYwcw1c
	 FvkH4HCusd/CR7zJx/Vm7PMqQOP9K+z4YYYSnbSTJuIIwhE3yrPTn/h6UZVjgpqZeC
	 UCYDqbLyv1Ti2CALg06oocSsS72f3E0koUQfG2RONXIt8QyTJgwCC5qnjyY3F+LZ6Q
	 bAMou/S32duwEPENk/7XaAxSlslI0QHocV7O8CkL1pme8X7EzDFLgympr94gieC4bJ
	 gYgr0YueZC5YEfk51PlgzkhcSFQB8IMrrVUwy2Du/16MKnWL14d9OrfC7hPnNAqgIm
	 tOrXtSezshRfg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Feb 2025 14:13:06 +0100
Subject: [PATCH RFC 07/16] selftests: create detached mounts from detached
 mounts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-brauner-open_tree-v1-7-dbcfcb98c676@kernel.org>
References: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
In-Reply-To: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Seth Forshee <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=11831; i=brauner@kernel.org;
 h=from:subject:message-id; bh=EpU9vR3iTxPrntp01yjIB1gXH0Ycl2lD2v7cQkn5z3k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvqP41xavy3t8oU7b/ejeXcVS5iv6zCP+0vequveOhs
 kMpp1fHd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkxglGhruCxZGOT9Yce1Ew
 aX/s0m/x9zQfPDne/PQyZ+f7KNngl6UM/53vR34XN7cO2DhVuSzVaa7Oo8kS9lcOLjfZfD+hc/L
 +3WwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/mount_setattr/mount_setattr_test.c   | 283 +++++++++++++++++++++
 1 file changed, 283 insertions(+)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 70f65eb320a7..885d98f2d889 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -126,6 +126,26 @@
 	#endif
 #endif
 
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
 #ifndef MOUNT_ATTR_IDMAP
 #define MOUNT_ATTR_IDMAP 0x00100000
 #endif
@@ -157,6 +177,51 @@ static inline int sys_open_tree(int dfd, const char *filename, unsigned int flag
 	return syscall(__NR_open_tree, dfd, filename, flags);
 }
 
+/* move_mount() flags */
+#ifndef MOVE_MOUNT_F_SYMLINKS
+#define MOVE_MOUNT_F_SYMLINKS 0x00000001 /* Follow symlinks on from path */
+#endif
+
+#ifndef MOVE_MOUNT_F_AUTOMOUNTS
+#define MOVE_MOUNT_F_AUTOMOUNTS 0x00000002 /* Follow automounts on from path */
+#endif
+
+#ifndef MOVE_MOUNT_F_EMPTY_PATH
+#define MOVE_MOUNT_F_EMPTY_PATH 0x00000004 /* Empty from path permitted */
+#endif
+
+#ifndef MOVE_MOUNT_T_SYMLINKS
+#define MOVE_MOUNT_T_SYMLINKS 0x00000010 /* Follow symlinks on to path */
+#endif
+
+#ifndef MOVE_MOUNT_T_AUTOMOUNTS
+#define MOVE_MOUNT_T_AUTOMOUNTS 0x00000020 /* Follow automounts on to path */
+#endif
+
+#ifndef MOVE_MOUNT_T_EMPTY_PATH
+#define MOVE_MOUNT_T_EMPTY_PATH 0x00000040 /* Empty to path permitted */
+#endif
+
+#ifndef MOVE_MOUNT_SET_GROUP
+#define MOVE_MOUNT_SET_GROUP 0x00000100 /* Set sharing group instead */
+#endif
+
+#ifndef MOVE_MOUNT_BENEATH
+#define MOVE_MOUNT_BENEATH 0x00000200 /* Mount beneath top mount */
+#endif
+
+#ifndef MOVE_MOUNT__MASK
+#define MOVE_MOUNT__MASK 0x00000377
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
 static ssize_t write_nointr(int fd, const void *buf, size_t count)
 {
 	ssize_t ret;
@@ -397,6 +462,10 @@ FIXTURE_SETUP(mount_setattr)
 
 	ASSERT_EQ(mkdir("/tmp/B/BB", 0777), 0);
 
+	ASSERT_EQ(mkdir("/tmp/target1", 0777), 0);
+
+	ASSERT_EQ(mkdir("/tmp/target2", 0777), 0);
+
 	ASSERT_EQ(mount("testing", "/tmp/B/BB", "tmpfs", MS_NOATIME | MS_NODEV,
 			"size=100000,mode=700"), 0);
 
@@ -1506,4 +1575,218 @@ TEST_F(mount_setattr, mount_attr_nosymfollow)
 	ASSERT_EQ(close(fd), 0);
 }
 
+TEST_F(mount_setattr, open_tree_detached)
+{
+	int fd_tree_base = -EBADF, fd_tree_subdir = -EBADF;
+	struct statx stx;
+
+	fd_tree_base = sys_open_tree(-EBADF, "/mnt",
+				     AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				     AT_RECURSIVE | OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	ASSERT_GE(fd_tree_base, 0);
+	/*
+	 * /mnt                   testing tmpfs
+	 * |-/mnt/A               testing tmpfs
+	 * | `-/mnt/A/AA          testing tmpfs
+	 * |   `-/mnt/A/AA/B      testing tmpfs
+	 * |     `-/mnt/A/AA/B/BB testing tmpfs
+	 * `-/mnt/B               testing ramfs
+	 */
+	ASSERT_EQ(statx(fd_tree_base, "A", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+	ASSERT_EQ(statx(fd_tree_base, "A/AA", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+	ASSERT_EQ(statx(fd_tree_base, "A/AA/B", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+	ASSERT_EQ(statx(fd_tree_base, "A/AA/B/BB", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+
+	fd_tree_subdir = sys_open_tree(fd_tree_base, "A/AA",
+				       AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				       AT_RECURSIVE | OPEN_TREE_CLOEXEC |
+				       OPEN_TREE_CLONE);
+	ASSERT_GE(fd_tree_subdir, 0);
+	/*
+	 * /AA          testing tmpfs
+	 * `-/AA/B      testing tmpfs
+	 *   `-/AA/B/BB testing tmpfs
+	 */
+	ASSERT_EQ(statx(fd_tree_subdir, "B", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+	ASSERT_EQ(statx(fd_tree_subdir, "B/BB", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+
+	ASSERT_EQ(move_mount(fd_tree_subdir, "", -EBADF, "/tmp/target1", MOVE_MOUNT_F_EMPTY_PATH), 0);
+	/*
+	 * /tmp/target1          testing tmpfs
+	 * `-/tmp/target1/B      testing tmpfs
+	 *   `-/tmp/target1/B/BB testing tmpfs
+	 */
+	ASSERT_EQ(statx(-EBADF, "/tmp/target1", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+	ASSERT_EQ(statx(-EBADF, "/tmp/target1/B", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+	ASSERT_EQ(statx(-EBADF, "/tmp/target1/B/BB", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+
+	ASSERT_EQ(move_mount(fd_tree_base, "", -EBADF, "/tmp/target2", MOVE_MOUNT_F_EMPTY_PATH), 0);
+	/*
+	 * /tmp/target2                   testing tmpfs
+	 * |-/tmp/target2/A               testing tmpfs
+	 * | `-/tmp/target2/A/AA          testing tmpfs
+	 * |   `-/tmp/target2/A/AA/B      testing tmpfs
+	 * |     `-/tmp/target2/A/AA/B/BB testing tmpfs
+	 * `-/tmp/target2/B               testing ramfs
+	 */
+	ASSERT_EQ(statx(-EBADF, "/tmp/target2", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+	ASSERT_EQ(statx(-EBADF, "/tmp/target2/A", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+	ASSERT_EQ(statx(-EBADF, "/tmp/target2/A/AA", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+	ASSERT_EQ(statx(-EBADF, "/tmp/target2/A/AA/B", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+	ASSERT_EQ(statx(-EBADF, "/tmp/target2/A/AA/B/BB", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+	ASSERT_EQ(statx(-EBADF, "/tmp/target2/B", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+
+	EXPECT_EQ(close(fd_tree_base), 0);
+	EXPECT_EQ(close(fd_tree_subdir), 0);
+}
+
+TEST_F(mount_setattr, open_tree_detached_fail)
+{
+	int fd_tree_base = -EBADF, fd_tree_subdir = -EBADF;
+	struct statx stx;
+
+	fd_tree_base = sys_open_tree(-EBADF, "/mnt",
+				     AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				     AT_RECURSIVE | OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	ASSERT_GE(fd_tree_base, 0);
+	/*
+	 * /mnt                   testing tmpfs
+	 * |-/mnt/A               testing tmpfs
+	 * | `-/mnt/A/AA          testing tmpfs
+	 * |   `-/mnt/A/AA/B      testing tmpfs
+	 * |     `-/mnt/A/AA/B/BB testing tmpfs
+	 * `-/mnt/B               testing ramfs
+	 */
+	ASSERT_EQ(statx(fd_tree_base, "A", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+	ASSERT_EQ(statx(fd_tree_base, "A/AA", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+	ASSERT_EQ(statx(fd_tree_base, "A/AA/B", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+	ASSERT_EQ(statx(fd_tree_base, "A/AA/B/BB", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+
+	/*
+	 * The origin mount namespace of the anonymous mount namespace
+	 * of @fd_tree_base doesn't match the caller's mount namespace
+	 * anymore so creation of another detached mounts must fail.
+	 */
+	fd_tree_subdir = sys_open_tree(fd_tree_base, "A/AA",
+				       AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				       AT_RECURSIVE | OPEN_TREE_CLOEXEC |
+				       OPEN_TREE_CLONE);
+	ASSERT_LT(fd_tree_subdir, 0);
+	ASSERT_EQ(errno, EINVAL);
+}
+
+TEST_F(mount_setattr, open_tree_detached_fail2)
+{
+	int fd_tree_base = -EBADF, fd_tree_subdir = -EBADF;
+	struct statx stx;
+
+	fd_tree_base = sys_open_tree(-EBADF, "/mnt",
+				     AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				     AT_RECURSIVE | OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	ASSERT_GE(fd_tree_base, 0);
+	/*
+	 * /mnt                   testing tmpfs
+	 * |-/mnt/A               testing tmpfs
+	 * | `-/mnt/A/AA          testing tmpfs
+	 * |   `-/mnt/A/AA/B      testing tmpfs
+	 * |     `-/mnt/A/AA/B/BB testing tmpfs
+	 * `-/mnt/B               testing ramfs
+	 */
+	ASSERT_EQ(statx(fd_tree_base, "A", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+	ASSERT_EQ(statx(fd_tree_base, "A/AA", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+	ASSERT_EQ(statx(fd_tree_base, "A/AA/B", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+	ASSERT_EQ(statx(fd_tree_base, "A/AA/B/BB", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+
+	EXPECT_EQ(create_and_enter_userns(), 0);
+
+	/*
+	 * The caller entered a new user namespace. They will have
+	 * CAP_SYS_ADMIN in this user namespace. However, they're still
+	 * located in a mount namespace that is owned by an ancestor
+	 * user namespace in which they hold no privilege. Creating a
+	 * detached mount must thus fail.
+	 */
+	fd_tree_subdir = sys_open_tree(fd_tree_base, "A/AA",
+				       AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				       AT_RECURSIVE | OPEN_TREE_CLOEXEC |
+				       OPEN_TREE_CLONE);
+	ASSERT_LT(fd_tree_subdir, 0);
+	ASSERT_EQ(errno, EPERM);
+}
+
+TEST_F(mount_setattr, open_tree_detached_fail3)
+{
+	int fd_tree_base = -EBADF, fd_tree_subdir = -EBADF;
+	struct statx stx;
+
+	fd_tree_base = sys_open_tree(-EBADF, "/mnt",
+				     AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				     AT_RECURSIVE | OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	ASSERT_GE(fd_tree_base, 0);
+	/*
+        * /mnt                   testing tmpfs
+        * |-/mnt/A               testing tmpfs
+        * | `-/mnt/A/AA          testing tmpfs
+        * |   `-/mnt/A/AA/B      testing tmpfs
+        * |     `-/mnt/A/AA/B/BB testing tmpfs
+        * `-/mnt/B               testing ramfs
+        */
+	ASSERT_EQ(statx(fd_tree_base, "A", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+	ASSERT_EQ(statx(fd_tree_base, "A/AA", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+	ASSERT_EQ(statx(fd_tree_base, "A/AA/B", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+	ASSERT_EQ(statx(fd_tree_base, "A/AA/B/BB", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+
+	EXPECT_EQ(prepare_unpriv_mountns(), 0);
+
+	/*
+        * The caller entered a new mount namespace. They will have
+        * CAP_SYS_ADMIN in the owning user namespace of their mount
+        * namespace.
+        *
+        * However, the origin mount namespace of the anonymous mount
+        * namespace of @fd_tree_base doesn't match the caller's mount
+        * namespace anymore so creation of another detached mounts must
+        * fail.
+        */
+	fd_tree_subdir = sys_open_tree(fd_tree_base, "A/AA",
+			               AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				       AT_RECURSIVE | OPEN_TREE_CLOEXEC |
+				       OPEN_TREE_CLONE);
+	ASSERT_LT(fd_tree_subdir, 0);
+	ASSERT_EQ(errno, EINVAL);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2


