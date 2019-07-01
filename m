Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E442E5C44E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 22:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfGAU0v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 16:26:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbfGAU0t (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 16:26:49 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C3E22183F;
        Mon,  1 Jul 2019 20:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562012808;
        bh=0cbNlz5thpQTzDjL2iC3/D1sFOhgoRjTU/G57B/uHos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VE207eP4YrlwzadxlffCTs4jWNIAksZmTAt45yaOZAlvxnO/hBxjkES5ybiT+MO/R
         ETlW6hOZiBGcJ5lGy1mBBTJPQ9y/Vo7hjvC/Rb/XqWHL94eoxc7Yz2tLcUhBJUqDoV
         niPetrQc6a+dYK36yVKUoA5bMlvk1ASuWiyurKh4=
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] f2fs: use generic checking function for FS_IOC_FSSETXATTR
Date:   Mon,  1 Jul 2019 13:26:29 -0700
Message-Id: <20190701202630.43776-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190701202630.43776-1-ebiggers@kernel.org>
References: <20190701202630.43776-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Make the f2fs implementation of FS_IOC_FSSETXATTR use the new VFS helper
function vfs_ioc_fssetxattr_check(), and remove the project quota check
since it's now done by the helper function.

This is based on a patch from Darrick Wong, but reworked to apply after
commit 360985573b55 ("f2fs: separate f2fs i_flags from fs_flags and ext4
i_flags").

Originally-from: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/file.c | 45 ++++++++++++++-------------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b5b941e6448657..ae1a54ecc9fccc 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2857,52 +2857,32 @@ static inline u32 f2fs_xflags_to_iflags(u32 xflags)
 	return iflags;
 }
 
-static int f2fs_ioc_fsgetxattr(struct file *filp, unsigned long arg)
+static void f2fs_fill_fsxattr(struct inode *inode, struct fsxattr *fa)
 {
-	struct inode *inode = file_inode(filp);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	struct fsxattr fa;
 
-	memset(&fa, 0, sizeof(struct fsxattr));
-	fa.fsx_xflags = f2fs_iflags_to_xflags(fi->i_flags);
+	simple_fill_fsxattr(fa, f2fs_iflags_to_xflags(fi->i_flags));
 
 	if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)))
-		fa.fsx_projid = (__u32)from_kprojid(&init_user_ns,
-							fi->i_projid);
-
-	if (copy_to_user((struct fsxattr __user *)arg, &fa, sizeof(fa)))
-		return -EFAULT;
-	return 0;
+		fa->fsx_projid = from_kprojid(&init_user_ns, fi->i_projid);
 }
 
-static int f2fs_ioctl_check_project(struct inode *inode, struct fsxattr *fa)
+static int f2fs_ioc_fsgetxattr(struct file *filp, unsigned long arg)
 {
-	/*
-	 * Project Quota ID state is only allowed to change from within the init
-	 * namespace. Enforce that restriction only if we are trying to change
-	 * the quota ID state. Everything else is allowed in user namespaces.
-	 */
-	if (current_user_ns() == &init_user_ns)
-		return 0;
-
-	if (__kprojid_val(F2FS_I(inode)->i_projid) != fa->fsx_projid)
-		return -EINVAL;
+	struct inode *inode = file_inode(filp);
+	struct fsxattr fa;
 
-	if (F2FS_I(inode)->i_flags & F2FS_PROJINHERIT_FL) {
-		if (!(fa->fsx_xflags & FS_XFLAG_PROJINHERIT))
-			return -EINVAL;
-	} else {
-		if (fa->fsx_xflags & FS_XFLAG_PROJINHERIT)
-			return -EINVAL;
-	}
+	f2fs_fill_fsxattr(inode, &fa);
 
+	if (copy_to_user((struct fsxattr __user *)arg, &fa, sizeof(fa)))
+		return -EFAULT;
 	return 0;
 }
 
 static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
-	struct fsxattr fa;
+	struct fsxattr fa, old_fa;
 	u32 iflags;
 	int err;
 
@@ -2925,9 +2905,12 @@ static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
 		return err;
 
 	inode_lock(inode);
-	err = f2fs_ioctl_check_project(inode, &fa);
+
+	f2fs_fill_fsxattr(inode, &old_fa);
+	err = vfs_ioc_fssetxattr_check(inode, &old_fa, &fa);
 	if (err)
 		goto out;
+
 	err = f2fs_setflags_common(inode, iflags,
 			f2fs_xflags_to_iflags(F2FS_SUPPORTED_XFLAGS));
 	if (err)
-- 
2.22.0.410.gd8fdbe21b5-goog

