Return-Path: <linux-fsdevel+bounces-42562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBA8A43B2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 11:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4413B8D9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 10:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF7826658B;
	Tue, 25 Feb 2025 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ1izVIK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF0114A4F0
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478606; cv=none; b=tcP8uKZZ9TAOYzZC4Y3Whck2Cai0/xOGXJT4oIQ1z3h1uTWZGJ9XL955chuNzL6o5qwrVDSNQVVIB6nZl18LXxw8hQBe3lIW9lPmxgX98ram7UWQEMn/qjHBk7S1l3OnkIZk7bFwonnwgU82qazLlA1ywuH4jkuXWk3Z3Fk5wCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478606; c=relaxed/simple;
	bh=iPrR37BBXOx9IRo48W6rJpjeqaaJCo1O5tNwCbxmp1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dDEhkDeXI4+HEymZP/4svpmFOw/cAeiBcKkqH4ka+0L6vYeZphJbc5V/WJ0dWXgZjoDNI3MUoH+n6ZzoWwlr+4znC6DWALn2ErMS8LoB2HEZB4+QKdkiFjwJaYcnKjATYh5h32iov0EEuadCA2l6OzodsM6n7SN0kV6XojfBznk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJ1izVIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2063EC4CEE8;
	Tue, 25 Feb 2025 10:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740478605;
	bh=iPrR37BBXOx9IRo48W6rJpjeqaaJCo1O5tNwCbxmp1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jJ1izVIKLFM+E5sAO6wmarQOtqEcJdxjUcOrlJl/OzF3EqnYP8zQQDaztkYggkMFr
	 3EkX+mjNukdXvpUjX6yW5n3nKM+Btio+PpCZbHzqcNiETzrVtDdIMPH0bjgcNNRLat
	 +0ekbaKRZwyEPDBZtAtI2aOSDZ+FNQvphYzsBJrQHMTbBKOtSiIw0r8cQl2Ds2EXeH
	 BwdNLoKIJc3Rt4FcYUMeBEQjSkhtlRPiYCR24e5Pl06+a0FbZu+afL8ptLrvxXE0VX
	 rxoBTJnitz+lb2pSZOCsynxFPl5ptB8SpuGUTQTK4ceU7Ni9nfvq3nPDJqbbWXSCav
	 flD3KV0yiaLTQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 25 Feb 2025 11:15:48 +0100
Subject: [PATCH 3/3] selftests: test subdirectory mounting
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-work-mount-propagation-v1-3-e6e3724500eb@kernel.org>
References: <20250225-work-mount-propagation-v1-0-e6e3724500eb@kernel.org>
In-Reply-To: <20250225-work-mount-propagation-v1-0-e6e3724500eb@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Seth Forshee <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=3619; i=brauner@kernel.org;
 h=from:subject:message-id; bh=iPrR37BBXOx9IRo48W6rJpjeqaaJCo1O5tNwCbxmp1s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvndFabbm6eYLfSise8UAO9XOK8zYfu+jXqV+z8OVlC
 QnrVc+qO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby/Rojwxnl7h38BqozOldY
 /Oq+qdDyduLbXyJ/5HmXb5v7snJ3lzXDXzn7SZOSzOu/s9Z5nfn8n3/+qYOlZo07jj+r09d48u5
 yBwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This tests mounting a subdirectory without ever having to expose the
filesystem to a non-anonymous mount namespace.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/mount_setattr/mount_setattr_test.c   | 81 ++++++++++------------
 1 file changed, 36 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 33fa1f53fdf5..48a000cabc97 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -20,6 +20,7 @@
 #include <stdarg.h>
 #include <linux/mount.h>
 
+#include "../filesystems/overlayfs/wrappers.h"
 #include "../kselftest_harness.h"
 
 #ifndef CLONE_NEWNS
@@ -177,51 +178,6 @@ static inline int sys_open_tree(int dfd, const char *filename, unsigned int flag
 	return syscall(__NR_open_tree, dfd, filename, flags);
 }
 
-/* move_mount() flags */
-#ifndef MOVE_MOUNT_F_SYMLINKS
-#define MOVE_MOUNT_F_SYMLINKS 0x00000001 /* Follow symlinks on from path */
-#endif
-
-#ifndef MOVE_MOUNT_F_AUTOMOUNTS
-#define MOVE_MOUNT_F_AUTOMOUNTS 0x00000002 /* Follow automounts on from path */
-#endif
-
-#ifndef MOVE_MOUNT_F_EMPTY_PATH
-#define MOVE_MOUNT_F_EMPTY_PATH 0x00000004 /* Empty from path permitted */
-#endif
-
-#ifndef MOVE_MOUNT_T_SYMLINKS
-#define MOVE_MOUNT_T_SYMLINKS 0x00000010 /* Follow symlinks on to path */
-#endif
-
-#ifndef MOVE_MOUNT_T_AUTOMOUNTS
-#define MOVE_MOUNT_T_AUTOMOUNTS 0x00000020 /* Follow automounts on to path */
-#endif
-
-#ifndef MOVE_MOUNT_T_EMPTY_PATH
-#define MOVE_MOUNT_T_EMPTY_PATH 0x00000040 /* Empty to path permitted */
-#endif
-
-#ifndef MOVE_MOUNT_SET_GROUP
-#define MOVE_MOUNT_SET_GROUP 0x00000100 /* Set sharing group instead */
-#endif
-
-#ifndef MOVE_MOUNT_BENEATH
-#define MOVE_MOUNT_BENEATH 0x00000200 /* Mount beneath top mount */
-#endif
-
-#ifndef MOVE_MOUNT__MASK
-#define MOVE_MOUNT__MASK 0x00000377
-#endif
-
-static inline int sys_move_mount(int from_dfd, const char *from_pathname,
-				 int to_dfd, const char *to_pathname,
-				 unsigned int flags)
-{
-	return syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd,
-		       to_pathname, flags);
-}
-
 static ssize_t write_nointr(int fd, const void *buf, size_t count)
 {
 	ssize_t ret;
@@ -1789,6 +1745,41 @@ TEST_F(mount_setattr, open_tree_detached_fail3)
 	ASSERT_EQ(errno, EINVAL);
 }
 
+TEST_F(mount_setattr, open_tree_subfolder)
+{
+	int fd_context, fd_tmpfs, fd_tree;
+
+	fd_context = sys_fsopen("tmpfs", 0);
+	ASSERT_GE(fd_context, 0);
+
+	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0), 0);
+
+	fd_tmpfs = sys_fsmount(fd_context, 0, 0);
+	ASSERT_GE(fd_tmpfs, 0);
+
+	EXPECT_EQ(close(fd_context), 0);
+
+	ASSERT_EQ(mkdirat(fd_tmpfs, "subdir", 0755), 0);
+
+	fd_tree = sys_open_tree(fd_tmpfs, "subdir",
+				AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				AT_RECURSIVE | OPEN_TREE_CLOEXEC |
+				OPEN_TREE_CLONE);
+	ASSERT_GE(fd_tree, 0);
+
+	EXPECT_EQ(close(fd_tmpfs), 0);
+
+	ASSERT_EQ(mkdirat(-EBADF, "/mnt/open_tree_subfolder", 0755), 0);
+
+	ASSERT_EQ(sys_move_mount(fd_tree, "", -EBADF, "/mnt/open_tree_subfolder", MOVE_MOUNT_F_EMPTY_PATH), 0);
+
+	EXPECT_EQ(close(fd_tree), 0);
+
+	ASSERT_EQ(umount2("/mnt/open_tree_subfolder", 0), 0);
+
+	EXPECT_EQ(rmdir("/mnt/open_tree_subfolder"), 0);
+}
+
 TEST_F(mount_setattr, mount_detached_mount_on_detached_mount_then_close)
 {
 	int fd_tree_base = -EBADF, fd_tree_subdir = -EBADF;

-- 
2.47.2


