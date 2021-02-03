Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2666D30DA09
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 13:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhBCMod (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 07:44:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26702 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230138AbhBCMnN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612356104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cx/Y41iY+se1Uf3/9dWdvThvjrDXePAzqmqjp1TU3kk=;
        b=XaRNf7buxhtlASw8J1vq6PdS4zKxQYMhW8zgIyV348T+bp8Ggp1NCtRQq3cAGCInjZTymM
        wz1AArq1+kR9yVebYMB0SGJRIvxj2gjcdx47S6AyCalSLTsWpXWOWRLHJTpkF30eKxMCfT
        7bjkWNPfwLa2QhIamF+apptQa3nj9/g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-J3UE2snKPWmuqBTpE5VFrA-1; Wed, 03 Feb 2021 07:41:43 -0500
X-MC-Unique: J3UE2snKPWmuqBTpE5VFrA-1
Received: by mail-ed1-f69.google.com with SMTP id b1so714281edt.22
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 04:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cx/Y41iY+se1Uf3/9dWdvThvjrDXePAzqmqjp1TU3kk=;
        b=OXtoLCpnowHJe5kfBSpMZ1XrkyS565K69xjG+J00Ksl7QrLcvgWTm4PWHC2ObvN1GW
         o7wCgVKEpfALFOowvcQTCorexLAQubcS19detTQqkwAMURAnhIQ8jLDXQV1bycC/yTLo
         RE5oHpZhUCNkvjx0JPsYCvovPIWrRyJRsDTVBAEEvAKDP/qt243oEmnpuxxxafhAuGfI
         dTDJQBR+TWPuV7jBDT3JN6vkAquh/zLYCN80s+qcwA9L+2e8m1whSZa3lPHw6jO+RSOp
         82PlF3Mg1cbkC+g+AJ5RRQKGo0nwReV25kTq2aKfuhYvd9FXcpsPif3fUxG5t2qu8OSA
         U5SQ==
X-Gm-Message-State: AOAM532nCsZJz/p18Pb8CGJw8q74HqyM2gW+BPnut281Oe8RVZ9Q5/mj
        lU23tVTqlWg9/84gbKpCSTi1Z4RmExlW3BrZpN7+pZfDmBC2Qvz1bdYUWNlzCnTc2SdZjKUDFnD
        hrPzfLZLr80Ar1sYyWncQ6ZXBShEPU4OhKwoIUbkHrtB63TE+xFDQdsvFEJBmh36Xc+DViY0PMp
        t3HA==
X-Received: by 2002:a17:906:a149:: with SMTP id bu9mr3055954ejb.185.1612356101583;
        Wed, 03 Feb 2021 04:41:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLcuDmoSIIX/JNUaYtDbykOsxkknvVy5Ptcyz+5mTGckW2MvdLOpfyFbpvgWS4THQtQF5lsQ==
X-Received: by 2002:a17:906:a149:: with SMTP id bu9mr3055935ejb.185.1612356101377;
        Wed, 03 Feb 2021 04:41:41 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id u9sm953320ejc.57.2021.02.03.04.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:41:40 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 07/18] f2fs: convert to miscattr
Date:   Wed,  3 Feb 2021 13:41:01 +0100
Message-Id: <20210203124112.1182614-8-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210203124112.1182614-1-mszeredi@redhat.com>
References: <20210203124112.1182614-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the miscattr API to let the VFS handle locking, permission checking and
conversion.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  |   2 +
 fs/f2fs/file.c  | 212 ++++++++----------------------------------------
 fs/f2fs/namei.c |   2 +
 3 files changed, 38 insertions(+), 178 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bb11759191dc..6526516788de 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3141,6 +3141,8 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr);
 int f2fs_truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end);
 void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count);
 int f2fs_precache_extents(struct inode *inode);
+int f2fs_miscattr_get(struct dentry *dentry, struct miscattr *ma);
+int f2fs_miscattr_set(struct dentry *dentry, struct miscattr *ma);
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 int f2fs_transfer_project_quota(struct inode *inode, kprojid_t kprojid);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f585545277d7..404f989f6954 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -22,6 +22,7 @@
 #include <linux/file.h>
 #include <linux/nls.h>
 #include <linux/sched/signal.h>
+#include <linux/miscattr.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -971,6 +972,8 @@ const struct inode_operations f2fs_file_inode_operations = {
 	.set_acl	= f2fs_set_acl,
 	.listxattr	= f2fs_listxattr,
 	.fiemap		= f2fs_fiemap,
+	.miscattr_get	= f2fs_miscattr_get,
+	.miscattr_set	= f2fs_miscattr_set,
 };
 
 static int fill_zero(struct inode *inode, pgoff_t index,
@@ -1933,67 +1936,6 @@ static inline u32 f2fs_fsflags_to_iflags(u32 fsflags)
 	return iflags;
 }
 
-static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
-{
-	struct inode *inode = file_inode(filp);
-	struct f2fs_inode_info *fi = F2FS_I(inode);
-	u32 fsflags = f2fs_iflags_to_fsflags(fi->i_flags);
-
-	if (IS_ENCRYPTED(inode))
-		fsflags |= FS_ENCRYPT_FL;
-	if (IS_VERITY(inode))
-		fsflags |= FS_VERITY_FL;
-	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
-		fsflags |= FS_INLINE_DATA_FL;
-	if (is_inode_flag_set(inode, FI_PIN_FILE))
-		fsflags |= FS_NOCOW_FL;
-
-	fsflags &= F2FS_GETTABLE_FS_FL;
-
-	return put_user(fsflags, (int __user *)arg);
-}
-
-static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
-{
-	struct inode *inode = file_inode(filp);
-	struct f2fs_inode_info *fi = F2FS_I(inode);
-	u32 fsflags, old_fsflags;
-	u32 iflags;
-	int ret;
-
-	if (!inode_owner_or_capable(inode))
-		return -EACCES;
-
-	if (get_user(fsflags, (int __user *)arg))
-		return -EFAULT;
-
-	if (fsflags & ~F2FS_GETTABLE_FS_FL)
-		return -EOPNOTSUPP;
-	fsflags &= F2FS_SETTABLE_FS_FL;
-
-	iflags = f2fs_fsflags_to_iflags(fsflags);
-	if (f2fs_mask_flags(inode->i_mode, iflags) != iflags)
-		return -EOPNOTSUPP;
-
-	ret = mnt_want_write_file(filp);
-	if (ret)
-		return ret;
-
-	inode_lock(inode);
-
-	old_fsflags = f2fs_iflags_to_fsflags(fi->i_flags);
-	ret = vfs_ioc_setflags_prepare(inode, old_fsflags, fsflags);
-	if (ret)
-		goto out;
-
-	ret = f2fs_setflags_common(inode, iflags,
-			f2fs_fsflags_to_iflags(F2FS_SETTABLE_FS_FL));
-out:
-	inode_unlock(inode);
-	mnt_drop_write_file(filp);
-	return ret;
-}
-
 static int f2fs_ioc_getversion(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -3000,9 +2942,8 @@ int f2fs_transfer_project_quota(struct inode *inode, kprojid_t kprojid)
 	return err;
 }
 
-static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
+static int f2fs_ioc_setproject(struct inode *inode, __u32 projid)
 {
-	struct inode *inode = file_inode(filp);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct page *ipage;
@@ -3063,7 +3004,7 @@ int f2fs_transfer_project_quota(struct inode *inode, kprojid_t kprojid)
 	return 0;
 }
 
-static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
+static int f2fs_ioc_setproject(struct inode *inode, __u32 projid)
 {
 	if (projid != F2FS_DEF_PROJID)
 		return -EOPNOTSUPP;
@@ -3071,123 +3012,54 @@ static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
 }
 #endif
 
-/* FS_IOC_FSGETXATTR and FS_IOC_FSSETXATTR support */
-
-/*
- * To make a new on-disk f2fs i_flag gettable via FS_IOC_FSGETXATTR and settable
- * via FS_IOC_FSSETXATTR, add an entry for it to f2fs_xflags_map[], and add its
- * FS_XFLAG_* equivalent to F2FS_SUPPORTED_XFLAGS.
- */
-
-static const struct {
-	u32 iflag;
-	u32 xflag;
-} f2fs_xflags_map[] = {
-	{ F2FS_SYNC_FL,		FS_XFLAG_SYNC },
-	{ F2FS_IMMUTABLE_FL,	FS_XFLAG_IMMUTABLE },
-	{ F2FS_APPEND_FL,	FS_XFLAG_APPEND },
-	{ F2FS_NODUMP_FL,	FS_XFLAG_NODUMP },
-	{ F2FS_NOATIME_FL,	FS_XFLAG_NOATIME },
-	{ F2FS_PROJINHERIT_FL,	FS_XFLAG_PROJINHERIT },
-};
-
-#define F2FS_SUPPORTED_XFLAGS (		\
-		FS_XFLAG_SYNC |		\
-		FS_XFLAG_IMMUTABLE |	\
-		FS_XFLAG_APPEND |	\
-		FS_XFLAG_NODUMP |	\
-		FS_XFLAG_NOATIME |	\
-		FS_XFLAG_PROJINHERIT)
-
-/* Convert f2fs on-disk i_flags to FS_IOC_FS{GET,SET}XATTR flags */
-static inline u32 f2fs_iflags_to_xflags(u32 iflags)
-{
-	u32 xflags = 0;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(f2fs_xflags_map); i++)
-		if (iflags & f2fs_xflags_map[i].iflag)
-			xflags |= f2fs_xflags_map[i].xflag;
-
-	return xflags;
-}
-
-/* Convert FS_IOC_FS{GET,SET}XATTR flags to f2fs on-disk i_flags */
-static inline u32 f2fs_xflags_to_iflags(u32 xflags)
-{
-	u32 iflags = 0;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(f2fs_xflags_map); i++)
-		if (xflags & f2fs_xflags_map[i].xflag)
-			iflags |= f2fs_xflags_map[i].iflag;
-
-	return iflags;
-}
-
-static void f2fs_fill_fsxattr(struct inode *inode, struct fsxattr *fa)
+int f2fs_miscattr_get(struct dentry *dentry, struct miscattr *ma)
 {
+	struct inode *inode = d_inode(dentry);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
+	u32 fsflags = f2fs_iflags_to_fsflags(fi->i_flags);
 
-	simple_fill_fsxattr(fa, f2fs_iflags_to_xflags(fi->i_flags));
-
-	if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)))
-		fa->fsx_projid = from_kprojid(&init_user_ns, fi->i_projid);
-}
+	if (IS_ENCRYPTED(inode))
+		fsflags |= FS_ENCRYPT_FL;
+	if (IS_VERITY(inode))
+		fsflags |= FS_VERITY_FL;
+	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
+		fsflags |= FS_INLINE_DATA_FL;
+	if (is_inode_flag_set(inode, FI_PIN_FILE))
+		fsflags |= FS_NOCOW_FL;
 
-static int f2fs_ioc_fsgetxattr(struct file *filp, unsigned long arg)
-{
-	struct inode *inode = file_inode(filp);
-	struct fsxattr fa;
+	miscattr_fill_flags(ma, fsflags & F2FS_GETTABLE_FS_FL);
 
-	f2fs_fill_fsxattr(inode, &fa);
+	if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)))
+		ma->fsx_projid = from_kprojid(&init_user_ns, fi->i_projid);
 
-	if (copy_to_user((struct fsxattr __user *)arg, &fa, sizeof(fa)))
-		return -EFAULT;
 	return 0;
 }
 
-static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
+int f2fs_miscattr_set(struct dentry *dentry, struct miscattr *ma)
 {
-	struct inode *inode = file_inode(filp);
-	struct fsxattr fa, old_fa;
+	struct inode *inode = d_inode(dentry);
+	u32 fsflags = ma->flags, mask = F2FS_SETTABLE_FS_FL;
 	u32 iflags;
 	int err;
 
-	if (copy_from_user(&fa, (struct fsxattr __user *)arg, sizeof(fa)))
-		return -EFAULT;
-
-	/* Make sure caller has proper permission */
-	if (!inode_owner_or_capable(inode))
-		return -EACCES;
-
-	if (fa.fsx_xflags & ~F2FS_SUPPORTED_XFLAGS)
+	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
+		return -EIO;
+	if (!f2fs_is_checkpoint_ready(F2FS_I_SB(inode)))
+		return -ENOSPC;
+	if (fsflags & ~F2FS_GETTABLE_FS_FL)
 		return -EOPNOTSUPP;
+	fsflags &= F2FS_SETTABLE_FS_FL;
+	if (!ma->flags_valid)
+		mask &= FS_COMMON_FL;
 
-	iflags = f2fs_xflags_to_iflags(fa.fsx_xflags);
+	iflags = f2fs_fsflags_to_iflags(fsflags);
 	if (f2fs_mask_flags(inode->i_mode, iflags) != iflags)
 		return -EOPNOTSUPP;
 
-	err = mnt_want_write_file(filp);
-	if (err)
-		return err;
-
-	inode_lock(inode);
-
-	f2fs_fill_fsxattr(inode, &old_fa);
-	err = vfs_ioc_fssetxattr_check(inode, &old_fa, &fa);
-	if (err)
-		goto out;
-
-	err = f2fs_setflags_common(inode, iflags,
-			f2fs_xflags_to_iflags(F2FS_SUPPORTED_XFLAGS));
-	if (err)
-		goto out;
+	err = f2fs_setflags_common(inode, iflags, f2fs_fsflags_to_iflags(mask));
+	if (!err)
+		err = f2fs_ioc_setproject(inode, ma->fsx_projid);
 
-	err = f2fs_ioc_setproject(filp, fa.fsx_projid);
-out:
-	inode_unlock(inode);
-	mnt_drop_write_file(filp);
 	return err;
 }
 
@@ -4204,10 +4076,6 @@ static int f2fs_ioc_compress_file(struct file *filp, unsigned long arg)
 static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
-	case FS_IOC_GETFLAGS:
-		return f2fs_ioc_getflags(filp, arg);
-	case FS_IOC_SETFLAGS:
-		return f2fs_ioc_setflags(filp, arg);
 	case FS_IOC_GETVERSION:
 		return f2fs_ioc_getversion(filp, arg);
 	case F2FS_IOC_START_ATOMIC_WRITE:
@@ -4256,10 +4124,6 @@ static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_flush_device(filp, arg);
 	case F2FS_IOC_GET_FEATURES:
 		return f2fs_ioc_get_features(filp, arg);
-	case FS_IOC_FSGETXATTR:
-		return f2fs_ioc_fsgetxattr(filp, arg);
-	case FS_IOC_FSSETXATTR:
-		return f2fs_ioc_fssetxattr(filp, arg);
 	case F2FS_IOC_GET_PIN_FILE:
 		return f2fs_ioc_get_pin_file(filp, arg);
 	case F2FS_IOC_SET_PIN_FILE:
@@ -4481,12 +4345,6 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		return -ENOSPC;
 
 	switch (cmd) {
-	case FS_IOC32_GETFLAGS:
-		cmd = FS_IOC_GETFLAGS;
-		break;
-	case FS_IOC32_SETFLAGS:
-		cmd = FS_IOC_SETFLAGS;
-		break;
 	case FS_IOC32_GETVERSION:
 		cmd = FS_IOC_GETVERSION;
 		break;
@@ -4515,8 +4373,6 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_DEFRAGMENT:
 	case F2FS_IOC_FLUSH_DEVICE:
 	case F2FS_IOC_GET_FEATURES:
-	case FS_IOC_FSGETXATTR:
-	case FS_IOC_FSSETXATTR:
 	case F2FS_IOC_GET_PIN_FILE:
 	case F2FS_IOC_SET_PIN_FILE:
 	case F2FS_IOC_PRECACHE_EXTENTS:
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 6edb1ab579a1..0085d038abd7 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1316,6 +1316,8 @@ const struct inode_operations f2fs_dir_inode_operations = {
 	.set_acl	= f2fs_set_acl,
 	.listxattr	= f2fs_listxattr,
 	.fiemap		= f2fs_fiemap,
+	.miscattr_get	= f2fs_miscattr_get,
+	.miscattr_set	= f2fs_miscattr_set,
 };
 
 const struct inode_operations f2fs_symlink_inode_operations = {
-- 
2.26.2

