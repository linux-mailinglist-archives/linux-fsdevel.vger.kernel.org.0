Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159F72C0D00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 15:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388358AbgKWOMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 09:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730039AbgKWOMO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:12:14 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB86FC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 06:12:12 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id 7so23494574ejm.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 06:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=XKdEon1blTEwWRRqFETe8W8E6Wd7Vc4+AYx11HuQw8I=;
        b=pPhhINZW5Ed2sBKR2yGK/dG1cnRW3vayp9LUeJ5JROoArXRtIAqf60dlFKmUWQphx+
         y6yo3If61iTR6JI8QHnTcKlaa/r444VpsqHFlq16gBlSnB3iBPMX4GUNhFUgFbuRt6m0
         r6GTOqt2jh0R+NqYwa+QFiXiHsd6fQ9XI28CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=XKdEon1blTEwWRRqFETe8W8E6Wd7Vc4+AYx11HuQw8I=;
        b=gsty90LKrZUANzZw79agjN+n2BpTRX7IHVEvxFFP1xWURAqAP0IBcNPCd3sIqQJ+dd
         Wl5pCqtbGrXclYx1+h8HhZEAdzG8FjHTzdgRPwHBb0/LBbtD+sG56LRMG/8wQhp7ptSd
         v9IB0oDgcnG7z7WMnm1gA/JvH/aXcsJAPSqlSlgTPJ5AdeImOfT7WrnfYFh4F0PvHtq/
         uco8aaAMemb/IGmsEIs2UOyDvIt2tCeEuvpZvnqxEzp5hzwzjGfzFlE3RHsqFwj9FHLc
         YqGXVYbMZ0PugXrBg3e8ZUKKKD6bHh/M5BLZzBHNJd+hRzD+uo6goch1WjOinS9TExcL
         86Kg==
X-Gm-Message-State: AOAM532qwHN18WPvaDp8t9n6uSh20Np1Zc6tkTSYfs/MtXj/x06SVTGY
        KFrLZBhvmRdIeWFuMpQIvbH+Vw==
X-Google-Smtp-Source: ABdhPJzu3Ktm0s/ozkgz1p07StaGP8eKyqr26B5yRqoAXF9veOZDV8/h1X2dwlcyfRUY8JufeR/gAQ==
X-Received: by 2002:a17:906:3608:: with SMTP id q8mr12846564ejb.39.1606140730597;
        Mon, 23 Nov 2020 06:12:10 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id lu33sm5043597ejb.49.2020.11.23.06.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 06:12:09 -0800 (PST)
Date:   Mon, 23 Nov 2020 15:12:07 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>
Cc:     Dmitry Vyukov <dvyukov@google.com>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [RFC PATCH] vfs: fs{set,get}attr iops
Message-ID: <20201123141207.GC327006@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dmitry found an issue with overlayfs's FS_IOC_SETFLAGS/FS_IOC_FSSETXATTR
implementation:

  https://lore.kernel.org/linux-unionfs/CACT4Y+bUfavwMVv2SEMve5pabE_AwsDO0YsRBGZtYqX59a77vA@mail.gmail.com/

I think the only proper soltuion is to move these into inode operations, which
should be a good cleanup as well.

This is a first cut, the FS_IOC_SETFLAGS conversion is not complete, and only
lightly tested on ext4 and xfs.

There are minor changes in behavior, like the exact errno value in case of
multiple error conditions.

Thanks,
Miklos

---
 fs/btrfs/ctree.h              |    2 
 fs/btrfs/inode.c              |    4 
 fs/btrfs/ioctl.c              |  246 ++++++------------------------------
 fs/ext2/ext2.h                |    6 
 fs/ext2/file.c                |    2 
 fs/ext2/ioctl.c               |   85 ++++--------
 fs/ext2/namei.c               |    2 
 fs/ext4/ext4.h                |   11 -
 fs/ext4/file.c                |    2 
 fs/ext4/ioctl.c               |  201 ++++++------------------------
 fs/ext4/namei.c               |    2 
 fs/f2fs/f2fs.h                |    2 
 fs/f2fs/file.c                |  210 ++++---------------------------
 fs/f2fs/namei.c               |    2 
 fs/gfs2/file.c                |   56 +-------
 fs/gfs2/inode.c               |    4 
 fs/gfs2/inode.h               |    2 
 fs/inode.c                    |   87 -------------
 fs/ioctl.c                    |  280 ++++++++++++++++++++++++++++++++++++++++++
 fs/orangefs/file.c            |   79 -----------
 fs/orangefs/inode.c           |   50 +++++++
 fs/overlayfs/dir.c            |    2 
 fs/overlayfs/file.c           |  181 ++++-----------------------
 fs/overlayfs/inode.c          |    2 
 fs/overlayfs/overlayfs.h      |    4 
 fs/overlayfs/readdir.c        |    4 
 fs/xfs/libxfs/xfs_fs.h        |    2 
 fs/xfs/xfs_ioctl.c            |  226 +++++++--------------------------
 fs/xfs/xfs_ioctl.h            |   10 +
 fs/xfs/xfs_ioctl32.c          |    2 
 fs/xfs/xfs_ioctl32.h          |    2 
 fs/xfs/xfs_iops.c             |    7 +
 include/linux/fs.h            |   15 --
 include/linux/ioctl_helpers.h |   46 ++++++
 34 files changed, 668 insertions(+), 1170 deletions(-)

--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3065,6 +3065,8 @@ ssize_t btrfs_direct_IO(struct kiocb *io
 /* ioctl.c */
 long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 long btrfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+int btrfs_fsgetxattr(struct dentry *dentry, struct kfsxattr *fa);
+int btrfs_fssetxattr(struct dentry *dentry, struct kfsxattr *fa);
 int btrfs_ioctl_get_supported_features(void __user *arg);
 void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
 int __pure btrfs_is_empty_uuid(u8 *uuid);
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10226,6 +10226,8 @@ static const struct inode_operations btr
 	.set_acl	= btrfs_set_acl,
 	.update_time	= btrfs_update_time,
 	.tmpfile        = btrfs_tmpfile,
+	.fsgetxattr	= btrfs_fsgetxattr,
+	.fssetxattr	= btrfs_fssetxattr,
 };
 
 static const struct file_operations btrfs_dir_file_operations = {
@@ -10279,6 +10281,8 @@ static const struct inode_operations btr
 	.get_acl	= btrfs_get_acl,
 	.set_acl	= btrfs_set_acl,
 	.update_time	= btrfs_update_time,
+	.fsgetxattr	= btrfs_fsgetxattr,
+	.fssetxattr	= btrfs_fssetxattr,
 };
 static const struct inode_operations btrfs_special_inode_operations = {
 	.getattr	= btrfs_getattr,
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -26,6 +26,7 @@
 #include <linux/btrfs.h>
 #include <linux/uaccess.h>
 #include <linux/iversion.h>
+#include <linux/ioctl_helpers.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "export.h"
@@ -154,16 +155,6 @@ void btrfs_sync_inode_flags_to_i_flags(s
 		      new_fl);
 }
 
-static int btrfs_ioctl_getflags(struct file *file, void __user *arg)
-{
-	struct btrfs_inode *binode = BTRFS_I(file_inode(file));
-	unsigned int flags = btrfs_inode_flags_to_fsflags(binode->flags);
-
-	if (copy_to_user(arg, &flags, sizeof(flags)))
-		return -EFAULT;
-	return 0;
-}
-
 /*
  * Check if @flags are a supported and valid set of FS_*_FL flags and that
  * the old and new flags are not conflicting
@@ -193,9 +184,33 @@ static int check_fsflags(unsigned int ol
 	return 0;
 }
 
-static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
+bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
+			enum btrfs_exclusive_operation type)
 {
-	struct inode *inode = file_inode(file);
+	return !cmpxchg(&fs_info->exclusive_operation, BTRFS_EXCLOP_NONE, type);
+}
+
+void btrfs_exclop_finish(struct btrfs_fs_info *fs_info)
+{
+	WRITE_ONCE(fs_info->exclusive_operation, BTRFS_EXCLOP_NONE);
+	sysfs_notify(&fs_info->fs_devices->fsid_kobj, NULL, "exclusive_operation");
+}
+
+/*
+ * Set flags/xflags from the internal inode flags. The remaining items of
+ * fsxattr are zeroed.
+ */
+int btrfs_fsgetxattr(struct dentry *dentry, struct kfsxattr *fa)
+{
+	struct btrfs_inode *binode = BTRFS_I(d_inode(dentry));
+
+	fsxattr_fill_flags(fa, btrfs_inode_flags_to_fsflags(binode->flags));
+	return 0;
+}
+
+int btrfs_fssetxattr(struct dentry *dentry, struct kfsxattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_inode *binode = BTRFS_I(inode);
 	struct btrfs_root *root = binode->root;
@@ -205,30 +220,17 @@ static int btrfs_ioctl_setflags(struct f
 	const char *comp = NULL;
 	u32 binode_flags;
 
-	if (!inode_owner_or_capable(inode))
-		return -EPERM;
-
 	if (btrfs_root_readonly(root))
 		return -EROFS;
 
-	if (copy_from_user(&fsflags, arg, sizeof(fsflags)))
-		return -EFAULT;
-
-	ret = mnt_want_write_file(file);
-	if (ret)
-		return ret;
+	if (fsxattr_has_xattr(fa))
+		return -EOPNOTSUPP;
 
-	inode_lock(inode);
-	fsflags = btrfs_mask_fsflags_for_type(inode, fsflags);
+	fsflags = btrfs_mask_fsflags_for_type(inode, fa->fsx_flags);
 	old_fsflags = btrfs_inode_flags_to_fsflags(binode->flags);
-
-	ret = vfs_ioc_setflags_prepare(inode, old_fsflags, fsflags);
-	if (ret)
-		goto out_unlock;
-
 	ret = check_fsflags(old_fsflags, fsflags);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	binode_flags = binode->flags;
 	if (fsflags & FS_SYNC_FL)
@@ -251,6 +253,13 @@ static int btrfs_ioctl_setflags(struct f
 		binode_flags |= BTRFS_INODE_NOATIME;
 	else
 		binode_flags &= ~BTRFS_INODE_NOATIME;
+
+	/* if coming from FS_IOC_FSSETXATTR then skip unconverted flags */
+	if (!fa->flags_valid) {
+		trans = btrfs_start_transaction(root, 1);
+		goto update_flags;
+	}
+
 	if (fsflags & FS_DIRSYNC_FL)
 		binode_flags |= BTRFS_INODE_DIRSYNC;
 	else
@@ -291,10 +300,8 @@ static int btrfs_ioctl_setflags(struct f
 		binode_flags |= BTRFS_INODE_NOCOMPRESS;
 	} else if (fsflags & FS_COMPR_FL) {
 
-		if (IS_SWAPFILE(inode)) {
-			ret = -ETXTBSY;
-			goto out_unlock;
-		}
+		if (IS_SWAPFILE(inode))
+			return -ETXTBSY;
 
 		binode_flags |= BTRFS_INODE_COMPRESS;
 		binode_flags &= ~BTRFS_INODE_NOCOMPRESS;
@@ -311,10 +318,8 @@ static int btrfs_ioctl_setflags(struct f
 	 * 2 for properties
 	 */
 	trans = btrfs_start_transaction(root, 3);
-	if (IS_ERR(trans)) {
-		ret = PTR_ERR(trans);
-		goto out_unlock;
-	}
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
 
 	if (comp) {
 		ret = btrfs_set_prop(trans, inode, "btrfs.compression", comp,
@@ -332,6 +337,7 @@ static int btrfs_ioctl_setflags(struct f
 		}
 	}
 
+update_flags:
 	binode->flags = binode_flags;
 	btrfs_sync_inode_flags_to_i_flags(inode);
 	inode_inc_iversion(inode);
@@ -340,158 +346,6 @@ static int btrfs_ioctl_setflags(struct f
 
  out_end_trans:
 	btrfs_end_transaction(trans);
- out_unlock:
-	inode_unlock(inode);
-	mnt_drop_write_file(file);
-	return ret;
-}
-
-/*
- * Translate btrfs internal inode flags to xflags as expected by the
- * FS_IOC_FSGETXATT ioctl. Filter only the supported ones, unknown flags are
- * silently dropped.
- */
-static unsigned int btrfs_inode_flags_to_xflags(unsigned int flags)
-{
-	unsigned int xflags = 0;
-
-	if (flags & BTRFS_INODE_APPEND)
-		xflags |= FS_XFLAG_APPEND;
-	if (flags & BTRFS_INODE_IMMUTABLE)
-		xflags |= FS_XFLAG_IMMUTABLE;
-	if (flags & BTRFS_INODE_NOATIME)
-		xflags |= FS_XFLAG_NOATIME;
-	if (flags & BTRFS_INODE_NODUMP)
-		xflags |= FS_XFLAG_NODUMP;
-	if (flags & BTRFS_INODE_SYNC)
-		xflags |= FS_XFLAG_SYNC;
-
-	return xflags;
-}
-
-/* Check if @flags are a supported and valid set of FS_XFLAGS_* flags */
-static int check_xflags(unsigned int flags)
-{
-	if (flags & ~(FS_XFLAG_APPEND | FS_XFLAG_IMMUTABLE | FS_XFLAG_NOATIME |
-		      FS_XFLAG_NODUMP | FS_XFLAG_SYNC))
-		return -EOPNOTSUPP;
-	return 0;
-}
-
-bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
-			enum btrfs_exclusive_operation type)
-{
-	return !cmpxchg(&fs_info->exclusive_operation, BTRFS_EXCLOP_NONE, type);
-}
-
-void btrfs_exclop_finish(struct btrfs_fs_info *fs_info)
-{
-	WRITE_ONCE(fs_info->exclusive_operation, BTRFS_EXCLOP_NONE);
-	sysfs_notify(&fs_info->fs_devices->fsid_kobj, NULL, "exclusive_operation");
-}
-
-/*
- * Set the xflags from the internal inode flags. The remaining items of fsxattr
- * are zeroed.
- */
-static int btrfs_ioctl_fsgetxattr(struct file *file, void __user *arg)
-{
-	struct btrfs_inode *binode = BTRFS_I(file_inode(file));
-	struct fsxattr fa;
-
-	simple_fill_fsxattr(&fa, btrfs_inode_flags_to_xflags(binode->flags));
-	if (copy_to_user(arg, &fa, sizeof(fa)))
-		return -EFAULT;
-
-	return 0;
-}
-
-static int btrfs_ioctl_fssetxattr(struct file *file, void __user *arg)
-{
-	struct inode *inode = file_inode(file);
-	struct btrfs_inode *binode = BTRFS_I(inode);
-	struct btrfs_root *root = binode->root;
-	struct btrfs_trans_handle *trans;
-	struct fsxattr fa, old_fa;
-	unsigned old_flags;
-	unsigned old_i_flags;
-	int ret = 0;
-
-	if (!inode_owner_or_capable(inode))
-		return -EPERM;
-
-	if (btrfs_root_readonly(root))
-		return -EROFS;
-
-	if (copy_from_user(&fa, arg, sizeof(fa)))
-		return -EFAULT;
-
-	ret = check_xflags(fa.fsx_xflags);
-	if (ret)
-		return ret;
-
-	if (fa.fsx_extsize != 0 || fa.fsx_projid != 0 || fa.fsx_cowextsize != 0)
-		return -EOPNOTSUPP;
-
-	ret = mnt_want_write_file(file);
-	if (ret)
-		return ret;
-
-	inode_lock(inode);
-
-	old_flags = binode->flags;
-	old_i_flags = inode->i_flags;
-
-	simple_fill_fsxattr(&old_fa,
-			    btrfs_inode_flags_to_xflags(binode->flags));
-	ret = vfs_ioc_fssetxattr_check(inode, &old_fa, &fa);
-	if (ret)
-		goto out_unlock;
-
-	if (fa.fsx_xflags & FS_XFLAG_SYNC)
-		binode->flags |= BTRFS_INODE_SYNC;
-	else
-		binode->flags &= ~BTRFS_INODE_SYNC;
-	if (fa.fsx_xflags & FS_XFLAG_IMMUTABLE)
-		binode->flags |= BTRFS_INODE_IMMUTABLE;
-	else
-		binode->flags &= ~BTRFS_INODE_IMMUTABLE;
-	if (fa.fsx_xflags & FS_XFLAG_APPEND)
-		binode->flags |= BTRFS_INODE_APPEND;
-	else
-		binode->flags &= ~BTRFS_INODE_APPEND;
-	if (fa.fsx_xflags & FS_XFLAG_NODUMP)
-		binode->flags |= BTRFS_INODE_NODUMP;
-	else
-		binode->flags &= ~BTRFS_INODE_NODUMP;
-	if (fa.fsx_xflags & FS_XFLAG_NOATIME)
-		binode->flags |= BTRFS_INODE_NOATIME;
-	else
-		binode->flags &= ~BTRFS_INODE_NOATIME;
-
-	/* 1 item for the inode */
-	trans = btrfs_start_transaction(root, 1);
-	if (IS_ERR(trans)) {
-		ret = PTR_ERR(trans);
-		goto out_unlock;
-	}
-
-	btrfs_sync_inode_flags_to_i_flags(inode);
-	inode_inc_iversion(inode);
-	inode->i_ctime = current_time(inode);
-	ret = btrfs_update_inode(trans, root, inode);
-
-	btrfs_end_transaction(trans);
-
-out_unlock:
-	if (ret) {
-		binode->flags = old_flags;
-		inode->i_flags = old_i_flags;
-	}
-
-	inode_unlock(inode);
-	mnt_drop_write_file(file);
-
 	return ret;
 }
 
@@ -4838,10 +4692,6 @@ long btrfs_ioctl(struct file *file, unsi
 	void __user *argp = (void __user *)arg;
 
 	switch (cmd) {
-	case FS_IOC_GETFLAGS:
-		return btrfs_ioctl_getflags(file, argp);
-	case FS_IOC_SETFLAGS:
-		return btrfs_ioctl_setflags(file, argp);
 	case FS_IOC_GETVERSION:
 		return btrfs_ioctl_getversion(file, argp);
 	case FS_IOC_GETFSLABEL:
@@ -4967,10 +4817,6 @@ long btrfs_ioctl(struct file *file, unsi
 		return btrfs_ioctl_get_features(fs_info, argp);
 	case BTRFS_IOC_SET_FEATURES:
 		return btrfs_ioctl_set_features(file, argp);
-	case FS_IOC_FSGETXATTR:
-		return btrfs_ioctl_fsgetxattr(file, argp);
-	case FS_IOC_FSSETXATTR:
-		return btrfs_ioctl_fssetxattr(file, argp);
 	case BTRFS_IOC_GET_SUBVOL_INFO:
 		return btrfs_ioctl_get_subvol_info(file, argp);
 	case BTRFS_IOC_GET_SUBVOL_ROOTREF:
@@ -4990,12 +4836,6 @@ long btrfs_compat_ioctl(struct file *fil
 	 * handling is necessary.
 	 */
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
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -281,8 +281,6 @@ static inline __u32 ext2_mask_flags(umod
 /*
  * ioctl commands
  */
-#define	EXT2_IOC_GETFLAGS		FS_IOC_GETFLAGS
-#define	EXT2_IOC_SETFLAGS		FS_IOC_SETFLAGS
 #define	EXT2_IOC_GETVERSION		FS_IOC_GETVERSION
 #define	EXT2_IOC_SETVERSION		FS_IOC_SETVERSION
 #define	EXT2_IOC_GETRSVSZ		_IOR('f', 5, long)
@@ -291,8 +289,6 @@ static inline __u32 ext2_mask_flags(umod
 /*
  * ioctl commands in 32 bit emulation
  */
-#define EXT2_IOC32_GETFLAGS		FS_IOC32_GETFLAGS
-#define EXT2_IOC32_SETFLAGS		FS_IOC32_SETFLAGS
 #define EXT2_IOC32_GETVERSION		FS_IOC32_GETVERSION
 #define EXT2_IOC32_SETVERSION		FS_IOC32_SETVERSION
 
@@ -764,6 +760,8 @@ extern int ext2_fiemap(struct inode *ino
 		       u64 start, u64 len);
 
 /* ioctl.c */
+extern int ext2_fsgetxattr(struct dentry *dentry, struct kfsxattr *fa);
+extern int ext2_fssetxattr(struct dentry *dentry, struct kfsxattr *fa);
 extern long ext2_ioctl(struct file *, unsigned int, unsigned long);
 extern long ext2_compat_ioctl(struct file *, unsigned int, unsigned long);
 
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -204,4 +204,6 @@ const struct inode_operations ext2_file_
 	.get_acl	= ext2_get_acl,
 	.set_acl	= ext2_set_acl,
 	.fiemap		= ext2_fiemap,
+	.fsgetxattr	= ext2_fsgetxattr,
+	.fssetxattr	= ext2_fssetxattr,
 };
--- a/fs/ext2/ioctl.c
+++ b/fs/ext2/ioctl.c
@@ -16,69 +16,46 @@
 #include <linux/mount.h>
 #include <asm/current.h>
 #include <linux/uaccess.h>
+#include <linux/ioctl_helpers.h>
+
+int ext2_fsgetxattr(struct dentry *dentry, struct kfsxattr *fa)
+{
+	struct ext2_inode_info *ei = EXT2_I(d_inode(dentry));
+
+	fa->fsx_flags = ei->i_flags & EXT2_FL_USER_VISIBLE;
+	return 0;
+}
+
+int ext2_fssetxattr(struct dentry *dentry, struct kfsxattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	struct ext2_inode_info *ei = EXT2_I(inode);
+
+	/* Is it quota file? Do not allow user to mess with it */
+	if (IS_NOQUOTA(inode))
+		return -EPERM;
+
+	ei->i_flags = (ei->i_flags & ~EXT2_FL_USER_MODIFIABLE) |
+		(fa->fsx_flags & EXT2_FL_USER_MODIFIABLE);
+
+	ext2_set_inode_flags(inode);
+	inode->i_ctime = current_time(inode);
+	mark_inode_dirty(inode);
+
+	return 0;
+}
 
 
 long ext2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 	struct ext2_inode_info *ei = EXT2_I(inode);
-	unsigned int flags;
 	unsigned short rsv_window_size;
 	int ret;
 
 	ext2_debug ("cmd = %u, arg = %lu\n", cmd, arg);
 
 	switch (cmd) {
-	case EXT2_IOC_GETFLAGS:
-		flags = ei->i_flags & EXT2_FL_USER_VISIBLE;
-		return put_user(flags, (int __user *) arg);
-	case EXT2_IOC_SETFLAGS: {
-		unsigned int oldflags;
-
-		ret = mnt_want_write_file(filp);
-		if (ret)
-			return ret;
-
-		if (!inode_owner_or_capable(inode)) {
-			ret = -EACCES;
-			goto setflags_out;
-		}
-
-		if (get_user(flags, (int __user *) arg)) {
-			ret = -EFAULT;
-			goto setflags_out;
-		}
-
-		flags = ext2_mask_flags(inode->i_mode, flags);
-
-		inode_lock(inode);
-		/* Is it quota file? Do not allow user to mess with it */
-		if (IS_NOQUOTA(inode)) {
-			inode_unlock(inode);
-			ret = -EPERM;
-			goto setflags_out;
-		}
-		oldflags = ei->i_flags;
-
-		ret = vfs_ioc_setflags_prepare(inode, oldflags, flags);
-		if (ret) {
-			inode_unlock(inode);
-			goto setflags_out;
-		}
-
-		flags = flags & EXT2_FL_USER_MODIFIABLE;
-		flags |= oldflags & ~EXT2_FL_USER_MODIFIABLE;
-		ei->i_flags = flags;
-
-		ext2_set_inode_flags(inode);
-		inode->i_ctime = current_time(inode);
-		inode_unlock(inode);
-
-		mark_inode_dirty(inode);
-setflags_out:
-		mnt_drop_write_file(filp);
-		return ret;
-	}
 	case EXT2_IOC_GETVERSION:
 		return put_user(inode->i_generation, (int __user *) arg);
 	case EXT2_IOC_SETVERSION: {
@@ -163,12 +140,6 @@ long ext2_compat_ioctl(struct file *file
 {
 	/* These are just misnamed, they actually get/put from/to user an int */
 	switch (cmd) {
-	case EXT2_IOC32_GETFLAGS:
-		cmd = EXT2_IOC_GETFLAGS;
-		break;
-	case EXT2_IOC32_SETFLAGS:
-		cmd = EXT2_IOC_SETFLAGS;
-		break;
 	case EXT2_IOC32_GETVERSION:
 		cmd = EXT2_IOC_GETVERSION;
 		break;
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -426,6 +426,8 @@ const struct inode_operations ext2_dir_i
 	.get_acl	= ext2_get_acl,
 	.set_acl	= ext2_set_acl,
 	.tmpfile	= ext2_tmpfile,
+	.fsgetxattr	= ext2_fsgetxattr,
+	.fssetxattr	= ext2_fssetxattr,
 };
 
 const struct inode_operations ext2_special_inode_operations = {
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -462,15 +462,6 @@ struct flex_groups {
 					 EXT4_VERITY_FL | \
 					 EXT4_INLINE_DATA_FL)
 
-/* Flags we can manipulate with through FS_IOC_FSSETXATTR */
-#define EXT4_FL_XFLAG_VISIBLE		(EXT4_SYNC_FL | \
-					 EXT4_IMMUTABLE_FL | \
-					 EXT4_APPEND_FL | \
-					 EXT4_NODUMP_FL | \
-					 EXT4_NOATIME_FL | \
-					 EXT4_PROJINHERIT_FL | \
-					 EXT4_DAX_FL)
-
 /* Flags that should be inherited by new inodes from their parent. */
 #define EXT4_FL_INHERITED (EXT4_SECRM_FL | EXT4_UNRM_FL | EXT4_COMPR_FL |\
 			   EXT4_SYNC_FL | EXT4_NODUMP_FL | EXT4_NOATIME_FL |\
@@ -2876,6 +2867,8 @@ extern int ext4_ind_remove_space(handle_
 /* ioctl.c */
 extern long ext4_ioctl(struct file *, unsigned int, unsigned long);
 extern long ext4_compat_ioctl(struct file *, unsigned int, unsigned long);
+int ext4_fssetxattr(struct dentry *dentry, struct kfsxattr *fa);
+int ext4_fsgetxattr(struct dentry *dentry, struct kfsxattr *fa);
 extern void ext4_reset_inode_seed(struct inode *inode);
 
 /* migrate.c */
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -919,5 +919,7 @@ const struct inode_operations ext4_file_
 	.get_acl	= ext4_get_acl,
 	.set_acl	= ext4_set_acl,
 	.fiemap		= ext4_fiemap,
+	.fsgetxattr	= ext4_fsgetxattr,
+	.fssetxattr	= ext4_fssetxattr,
 };
 
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -20,6 +20,7 @@
 #include <linux/uaccess.h>
 #include <linux/delay.h>
 #include <linux/iversion.h>
+#include <linux/ioctl_helpers.h>
 #include "ext4_jbd2.h"
 #include "ext4.h"
 #include <linux/fsmap.h>
@@ -341,11 +342,6 @@ static int ext4_ioctl_setflags(struct in
 		goto flags_out;
 
 	oldflags = ei->i_flags;
-
-	err = vfs_ioc_setflags_prepare(inode, oldflags, flags);
-	if (err)
-		goto flags_out;
-
 	/*
 	 * The JOURNAL_DATA flag can only be changed by
 	 * the relevant capability.
@@ -456,9 +452,8 @@ static int ext4_ioctl_setflags(struct in
 }
 
 #ifdef CONFIG_QUOTA
-static int ext4_ioctl_setproject(struct file *filp, __u32 projid)
+static int ext4_ioctl_setproject(struct inode *inode, __u32 projid)
 {
-	struct inode *inode = file_inode(filp);
 	struct super_block *sb = inode->i_sb;
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	int err, rc;
@@ -542,7 +537,7 @@ static int ext4_ioctl_setproject(struct
 	return err;
 }
 #else
-static int ext4_ioctl_setproject(struct file *filp, __u32 projid)
+static int ext4_ioctl_setproject(struct inode *inode, __u32 projid)
 {
 	if (projid != EXT4_DEF_PROJID)
 		return -EOPNOTSUPP;
@@ -550,56 +545,6 @@ static int ext4_ioctl_setproject(struct
 }
 #endif
 
-/* Transfer internal flags to xflags */
-static inline __u32 ext4_iflags_to_xflags(unsigned long iflags)
-{
-	__u32 xflags = 0;
-
-	if (iflags & EXT4_SYNC_FL)
-		xflags |= FS_XFLAG_SYNC;
-	if (iflags & EXT4_IMMUTABLE_FL)
-		xflags |= FS_XFLAG_IMMUTABLE;
-	if (iflags & EXT4_APPEND_FL)
-		xflags |= FS_XFLAG_APPEND;
-	if (iflags & EXT4_NODUMP_FL)
-		xflags |= FS_XFLAG_NODUMP;
-	if (iflags & EXT4_NOATIME_FL)
-		xflags |= FS_XFLAG_NOATIME;
-	if (iflags & EXT4_PROJINHERIT_FL)
-		xflags |= FS_XFLAG_PROJINHERIT;
-	if (iflags & EXT4_DAX_FL)
-		xflags |= FS_XFLAG_DAX;
-	return xflags;
-}
-
-#define EXT4_SUPPORTED_FS_XFLAGS (FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | \
-				  FS_XFLAG_APPEND | FS_XFLAG_NODUMP | \
-				  FS_XFLAG_NOATIME | FS_XFLAG_PROJINHERIT | \
-				  FS_XFLAG_DAX)
-
-/* Transfer xflags flags to internal */
-static inline unsigned long ext4_xflags_to_iflags(__u32 xflags)
-{
-	unsigned long iflags = 0;
-
-	if (xflags & FS_XFLAG_SYNC)
-		iflags |= EXT4_SYNC_FL;
-	if (xflags & FS_XFLAG_IMMUTABLE)
-		iflags |= EXT4_IMMUTABLE_FL;
-	if (xflags & FS_XFLAG_APPEND)
-		iflags |= EXT4_APPEND_FL;
-	if (xflags & FS_XFLAG_NODUMP)
-		iflags |= EXT4_NODUMP_FL;
-	if (xflags & FS_XFLAG_NOATIME)
-		iflags |= EXT4_NOATIME_FL;
-	if (xflags & FS_XFLAG_PROJINHERIT)
-		iflags |= EXT4_PROJINHERIT_FL;
-	if (xflags & FS_XFLAG_DAX)
-		iflags |= EXT4_DAX_FL;
-
-	return iflags;
-}
-
 static int ext4_shutdown(struct super_block *sb, unsigned long arg)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -767,15 +712,51 @@ static long ext4_ioctl_group_add(struct
 	return err;
 }
 
-static void ext4_fill_fsxattr(struct inode *inode, struct fsxattr *fa)
+int ext4_fsgetxattr(struct dentry *dentry, struct kfsxattr *fa)
 {
+	struct inode *inode = d_inode(dentry);
 	struct ext4_inode_info *ei = EXT4_I(inode);
+	u32 flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
 
-	simple_fill_fsxattr(fa, ext4_iflags_to_xflags(ei->i_flags &
-						      EXT4_FL_USER_VISIBLE));
+	if (S_ISREG(inode->i_mode))
+		flags &= ~FS_PROJINHERIT_FL;
 
+	fsxattr_fill_flags(fa, flags);
 	if (ext4_has_feature_project(inode->i_sb))
 		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
+
+	return 0;
+}
+
+int ext4_fssetxattr(struct dentry *dentry, struct kfsxattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	u32 flags = fa->fsx_flags;
+	int err = -EOPNOTSUPP;
+
+	ext4_fc_start_update(inode);
+	if (flags & ~EXT4_FL_USER_VISIBLE)
+		goto out;
+
+	/*
+	 * chattr(1) grabs flags via GETFLAGS, modifies the result and
+	 * passes that to SETFLAGS. So we cannot easily make SETFLAGS
+	 * more restrictive than just silently masking off visible but
+	 * not settable flags as we always did.
+	 */
+	flags &= EXT4_FL_USER_MODIFIABLE;
+	if (ext4_mask_flags(inode->i_mode, flags) != flags)
+		goto out;
+	err = ext4_ioctl_check_immutable(inode, fa->fsx_projid, flags);
+	if (err)
+		goto out;
+	err = ext4_ioctl_setflags(inode, flags);
+	if (err)
+		goto out;
+	err = ext4_ioctl_setproject(inode, fa->fsx_projid);
+out:
+	ext4_fc_stop_update(inode);
+	return err;
 }
 
 /* So that the fiemap access checks can't overflow on 32 bit machines. */
@@ -813,54 +794,12 @@ static long __ext4_ioctl(struct file *fi
 {
 	struct inode *inode = file_inode(filp);
 	struct super_block *sb = inode->i_sb;
-	struct ext4_inode_info *ei = EXT4_I(inode);
-	unsigned int flags;
 
 	ext4_debug("cmd = %u, arg = %lu\n", cmd, arg);
 
 	switch (cmd) {
 	case FS_IOC_GETFSMAP:
 		return ext4_ioc_getfsmap(sb, (void __user *)arg);
-	case FS_IOC_GETFLAGS:
-		flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
-		if (S_ISREG(inode->i_mode))
-			flags &= ~EXT4_PROJINHERIT_FL;
-		return put_user(flags, (int __user *) arg);
-	case FS_IOC_SETFLAGS: {
-		int err;
-
-		if (!inode_owner_or_capable(inode))
-			return -EACCES;
-
-		if (get_user(flags, (int __user *) arg))
-			return -EFAULT;
-
-		if (flags & ~EXT4_FL_USER_VISIBLE)
-			return -EOPNOTSUPP;
-		/*
-		 * chattr(1) grabs flags via GETFLAGS, modifies the result and
-		 * passes that to SETFLAGS. So we cannot easily make SETFLAGS
-		 * more restrictive than just silently masking off visible but
-		 * not settable flags as we always did.
-		 */
-		flags &= EXT4_FL_USER_MODIFIABLE;
-		if (ext4_mask_flags(inode->i_mode, flags) != flags)
-			return -EOPNOTSUPP;
-
-		err = mnt_want_write_file(filp);
-		if (err)
-			return err;
-
-		inode_lock(inode);
-		err = ext4_ioctl_check_immutable(inode,
-				from_kprojid(&init_user_ns, ei->i_projid),
-				flags);
-		if (!err)
-			err = ext4_ioctl_setflags(inode, flags);
-		inode_unlock(inode);
-		mnt_drop_write_file(filp);
-		return err;
-	}
 	case EXT4_IOC_GETVERSION:
 	case EXT4_IOC_GETVERSION_OLD:
 		return put_user(inode->i_generation, (int __user *) arg);
@@ -1239,60 +1178,6 @@ static long __ext4_ioctl(struct file *fi
 	case EXT4_IOC_GET_ES_CACHE:
 		return ext4_ioctl_get_es_cache(filp, arg);
 
-	case FS_IOC_FSGETXATTR:
-	{
-		struct fsxattr fa;
-
-		ext4_fill_fsxattr(inode, &fa);
-
-		if (copy_to_user((struct fsxattr __user *)arg,
-				 &fa, sizeof(fa)))
-			return -EFAULT;
-		return 0;
-	}
-	case FS_IOC_FSSETXATTR:
-	{
-		struct fsxattr fa, old_fa;
-		int err;
-
-		if (copy_from_user(&fa, (struct fsxattr __user *)arg,
-				   sizeof(fa)))
-			return -EFAULT;
-
-		/* Make sure caller has proper permission */
-		if (!inode_owner_or_capable(inode))
-			return -EACCES;
-
-		if (fa.fsx_xflags & ~EXT4_SUPPORTED_FS_XFLAGS)
-			return -EOPNOTSUPP;
-
-		flags = ext4_xflags_to_iflags(fa.fsx_xflags);
-		if (ext4_mask_flags(inode->i_mode, flags) != flags)
-			return -EOPNOTSUPP;
-
-		err = mnt_want_write_file(filp);
-		if (err)
-			return err;
-
-		inode_lock(inode);
-		ext4_fill_fsxattr(inode, &old_fa);
-		err = vfs_ioc_fssetxattr_check(inode, &old_fa, &fa);
-		if (err)
-			goto out;
-		flags = (ei->i_flags & ~EXT4_FL_XFLAG_VISIBLE) |
-			 (flags & EXT4_FL_XFLAG_VISIBLE);
-		err = ext4_ioctl_check_immutable(inode, fa.fsx_projid, flags);
-		if (err)
-			goto out;
-		err = ext4_ioctl_setflags(inode, flags);
-		if (err)
-			goto out;
-		err = ext4_ioctl_setproject(filp, fa.fsx_projid);
-out:
-		inode_unlock(inode);
-		mnt_drop_write_file(filp);
-		return err;
-	}
 	case EXT4_IOC_SHUTDOWN:
 		return ext4_shutdown(sb, arg);
 
@@ -1391,8 +1276,6 @@ long ext4_compat_ioctl(struct file *file
 	case EXT4_IOC_CLEAR_ES_CACHE:
 	case EXT4_IOC_GETSTATE:
 	case EXT4_IOC_GET_ES_CACHE:
-	case FS_IOC_FSGETXATTR:
-	case FS_IOC_FSSETXATTR:
 		break;
 	default:
 		return -ENOIOCTLCMD;
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -4138,6 +4138,8 @@ const struct inode_operations ext4_dir_i
 	.get_acl	= ext4_get_acl,
 	.set_acl	= ext4_set_acl,
 	.fiemap         = ext4_fiemap,
+	.fsgetxattr	= ext4_fsgetxattr,
+	.fssetxattr	= ext4_fssetxattr,
 };
 
 const struct inode_operations ext4_special_inode_operations = {
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3173,6 +3173,8 @@ int f2fs_setattr(struct dentry *dentry,
 int f2fs_truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end);
 void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count);
 int f2fs_precache_extents(struct inode *inode);
+int f2fs_fsgetxattr(struct dentry *dentry, struct kfsxattr *fa);
+int f2fs_fssetxattr(struct dentry *dentry, struct kfsxattr *fa);
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 int f2fs_transfer_project_quota(struct inode *inode, kprojid_t kprojid);
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -22,6 +22,7 @@
 #include <linux/file.h>
 #include <linux/nls.h>
 #include <linux/sched/signal.h>
+#include <linux/ioctl_helpers.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -965,6 +966,8 @@ const struct inode_operations f2fs_file_
 	.set_acl	= f2fs_set_acl,
 	.listxattr	= f2fs_listxattr,
 	.fiemap		= f2fs_fiemap,
+	.fsgetxattr	= f2fs_fsgetxattr,
+	.fssetxattr	= f2fs_fssetxattr,
 };
 
 static int fill_zero(struct inode *inode, pgoff_t index,
@@ -1927,67 +1930,6 @@ static inline u32 f2fs_fsflags_to_iflags
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
@@ -2995,9 +2937,8 @@ int f2fs_transfer_project_quota(struct i
 	return err;
 }
 
-static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
+static int f2fs_ioc_setproject(struct inode *inode, __u32 projid)
 {
-	struct inode *inode = file_inode(filp);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct page *ipage;
@@ -3058,7 +2999,7 @@ int f2fs_transfer_project_quota(struct i
 	return 0;
 }
 
-static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
+static int f2fs_ioc_setproject(struct inode *inode, __u32 projid)
 {
 	if (projid != F2FS_DEF_PROJID)
 		return -EOPNOTSUPP;
@@ -3066,123 +3007,54 @@ static int f2fs_ioc_setproject(struct fi
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
+int f2fs_fsgetxattr(struct dentry *dentry, struct kfsxattr *fa)
 {
+	struct inode *inode = d_inode(dentry);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
+	u32 fsflags = f2fs_iflags_to_fsflags(fi->i_flags);
 
-	simple_fill_fsxattr(fa, f2fs_iflags_to_xflags(fi->i_flags));
+	if (IS_ENCRYPTED(inode))
+		fsflags |= FS_ENCRYPT_FL;
+	if (IS_VERITY(inode))
+		fsflags |= FS_VERITY_FL;
+	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
+		fsflags |= FS_INLINE_DATA_FL;
+	if (is_inode_flag_set(inode, FI_PIN_FILE))
+		fsflags |= FS_NOCOW_FL;
+
+	fsxattr_fill_flags(fa, fsflags & F2FS_GETTABLE_FS_FL);
 
 	if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)))
 		fa->fsx_projid = from_kprojid(&init_user_ns, fi->i_projid);
-}
-
-static int f2fs_ioc_fsgetxattr(struct file *filp, unsigned long arg)
-{
-	struct inode *inode = file_inode(filp);
-	struct fsxattr fa;
 
-	f2fs_fill_fsxattr(inode, &fa);
-
-	if (copy_to_user((struct fsxattr __user *)arg, &fa, sizeof(fa)))
-		return -EFAULT;
 	return 0;
 }
 
-static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
+int f2fs_fssetxattr(struct dentry *dentry, struct kfsxattr *fa)
 {
-	struct inode *inode = file_inode(filp);
-	struct fsxattr fa, old_fa;
+	struct inode *inode = d_inode(dentry);
+	u32 fsflags = fa->fsx_flags, mask = F2FS_SETTABLE_FS_FL;
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
+	if (!fa->flags_valid)
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
+		err = f2fs_ioc_setproject(inode, fa->fsx_projid);
 
-	err = f2fs_ioc_setproject(filp, fa.fsx_projid);
-out:
-	inode_unlock(inode);
-	mnt_drop_write_file(filp);
 	return err;
 }
 
@@ -3947,10 +3819,6 @@ long f2fs_ioctl(struct file *filp, unsig
 		return -ENOSPC;
 
 	switch (cmd) {
-	case FS_IOC_GETFLAGS:
-		return f2fs_ioc_getflags(filp, arg);
-	case FS_IOC_SETFLAGS:
-		return f2fs_ioc_setflags(filp, arg);
 	case FS_IOC_GETVERSION:
 		return f2fs_ioc_getversion(filp, arg);
 	case F2FS_IOC_START_ATOMIC_WRITE:
@@ -3999,10 +3867,6 @@ long f2fs_ioctl(struct file *filp, unsig
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
@@ -4151,12 +4015,6 @@ static ssize_t f2fs_file_write_iter(stru
 long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
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
@@ -4183,8 +4041,6 @@ long f2fs_compat_ioctl(struct file *file
 	case F2FS_IOC_MOVE_RANGE:
 	case F2FS_IOC_FLUSH_DEVICE:
 	case F2FS_IOC_GET_FEATURES:
-	case FS_IOC_FSGETXATTR:
-	case FS_IOC_FSSETXATTR:
 	case F2FS_IOC_GET_PIN_FILE:
 	case F2FS_IOC_SET_PIN_FILE:
 	case F2FS_IOC_PRECACHE_EXTENTS:
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1315,6 +1315,8 @@ const struct inode_operations f2fs_dir_i
 	.set_acl	= f2fs_set_acl,
 	.listxattr	= f2fs_listxattr,
 	.fiemap		= f2fs_fiemap,
+	.fsgetxattr	= f2fs_fsgetxattr,
+	.fssetxattr	= f2fs_fssetxattr,
 };
 
 const struct inode_operations f2fs_symlink_inode_operations = {
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -25,6 +25,7 @@
 #include <linux/dlm_plock.h>
 #include <linux/delay.h>
 #include <linux/backing-dev.h>
+#include <linux/ioctl_helpers.h>
 
 #include "gfs2.h"
 #include "incore.h"
@@ -153,9 +154,9 @@ static inline u32 gfs2_gfsflags_to_fsfla
 	return fsflags;
 }
 
-static int gfs2_get_flags(struct file *filp, u32 __user *ptr)
+int gfs2_fsgetxattr(struct dentry *dentry, struct kfsxattr *fa)
 {
-	struct inode *inode = file_inode(filp);
+	struct inode *inode = d_inode(dentry);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
 	int error;
@@ -168,8 +169,7 @@ static int gfs2_get_flags(struct file *f
 
 	fsflags = gfs2_gfsflags_to_fsflags(inode, ip->i_diskflags);
 
-	if (put_user(fsflags, ptr))
-		error = -EFAULT;
+	fsxattr_fill_flags(fa, fsflags);
 
 	gfs2_glock_dq(&gh);
 out_uninit:
@@ -213,33 +213,19 @@ void gfs2_set_inode_flags(struct inode *
  * @fsflags: The FS_* inode flags passed in
  *
  */
-static int do_gfs2_set_flags(struct file *filp, u32 reqflags, u32 mask,
+static int do_gfs2_set_flags(struct inode *inode, u32 reqflags, u32 mask,
 			     const u32 fsflags)
 {
-	struct inode *inode = file_inode(filp);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct buffer_head *bh;
 	struct gfs2_holder gh;
 	int error;
-	u32 new_flags, flags, oldflags;
-
-	error = mnt_want_write_file(filp);
-	if (error)
-		return error;
+	u32 new_flags, flags;
 
 	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
 	if (error)
-		goto out_drop_write;
-
-	oldflags = gfs2_gfsflags_to_fsflags(inode, ip->i_diskflags);
-	error = vfs_ioc_setflags_prepare(inode, oldflags, fsflags);
-	if (error)
-		goto out;
-
-	error = -EACCES;
-	if (!inode_owner_or_capable(inode))
-		goto out;
+		return error;
 
 	error = 0;
 	flags = ip->i_diskflags;
@@ -252,9 +238,6 @@ static int do_gfs2_set_flags(struct file
 		goto out;
 	if (IS_APPEND(inode) && (new_flags & GFS2_DIF_APPENDONLY))
 		goto out;
-	if (((new_flags ^ flags) & GFS2_DIF_IMMUTABLE) &&
-	    !capable(CAP_LINUX_IMMUTABLE))
-		goto out;
 	if (!IS_IMMUTABLE(inode)) {
 		error = gfs2_permission(inode, MAY_WRITE);
 		if (error)
@@ -291,20 +274,18 @@ static int do_gfs2_set_flags(struct file
 	gfs2_trans_end(sdp);
 out:
 	gfs2_glock_dq_uninit(&gh);
-out_drop_write:
-	mnt_drop_write_file(filp);
 	return error;
 }
 
-static int gfs2_set_flags(struct file *filp, u32 __user *ptr)
+int gfs2_fssetxattr(struct dentry *dentry, struct kfsxattr *fa)
 {
-	struct inode *inode = file_inode(filp);
-	u32 fsflags, gfsflags = 0;
+	struct inode *inode = d_inode(dentry);
+	u32 fsflags = fa->fsx_flags, gfsflags = 0;
 	u32 mask;
 	int i;
 
-	if (get_user(fsflags, ptr))
-		return -EFAULT;
+	if (fsxattr_has_xattr(fa))
+		return -EOPNOTSUPP;
 
 	for (i = 0; i < ARRAY_SIZE(fsflag_gfs2flag); i++) {
 		if (fsflags & fsflag_gfs2flag[i].fsflag) {
@@ -325,7 +306,7 @@ static int gfs2_set_flags(struct file *f
 		mask &= ~(GFS2_DIF_TOPDIR | GFS2_DIF_INHERIT_JDATA);
 	}
 
-	return do_gfs2_set_flags(filp, gfsflags, mask, fsflags);
+	return do_gfs2_set_flags(inode, gfsflags, mask, fsflags);
 }
 
 static int gfs2_getlabel(struct file *filp, char __user *label)
@@ -342,10 +323,6 @@ static int gfs2_getlabel(struct file *fi
 static long gfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	switch(cmd) {
-	case FS_IOC_GETFLAGS:
-		return gfs2_get_flags(filp, (u32 __user *)arg);
-	case FS_IOC_SETFLAGS:
-		return gfs2_set_flags(filp, (u32 __user *)arg);
 	case FITRIM:
 		return gfs2_fitrim(filp, (void __user *)arg);
 	case FS_IOC_GETFSLABEL:
@@ -359,13 +336,6 @@ static long gfs2_ioctl(struct file *filp
 static long gfs2_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	switch(cmd) {
-	/* These are just misnamed, they actually get/put from/to user an int */
-	case FS_IOC32_GETFLAGS:
-		cmd = FS_IOC_GETFLAGS;
-		break;
-	case FS_IOC32_SETFLAGS:
-		cmd = FS_IOC_SETFLAGS;
-		break;
 	/* Keep this list in sync with gfs2_ioctl */
 	case FITRIM:
 	case FS_IOC_GETFSLABEL:
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2123,6 +2123,8 @@ const struct inode_operations gfs2_file_
 	.fiemap = gfs2_fiemap,
 	.get_acl = gfs2_get_acl,
 	.set_acl = gfs2_set_acl,
+	.fsgetxattr = gfs2_fsgetxattr,
+	.fssetxattr = gfs2_fssetxattr,
 };
 
 const struct inode_operations gfs2_dir_iops = {
@@ -2143,6 +2145,8 @@ const struct inode_operations gfs2_dir_i
 	.get_acl = gfs2_get_acl,
 	.set_acl = gfs2_set_acl,
 	.atomic_open = gfs2_atomic_open,
+	.fsgetxattr = gfs2_fsgetxattr,
+	.fssetxattr = gfs2_fssetxattr,
 };
 
 const struct inode_operations gfs2_symlink_iops = {
--- a/fs/gfs2/inode.h
+++ b/fs/gfs2/inode.h
@@ -113,6 +113,8 @@ extern const struct inode_operations gfs
 extern const struct file_operations gfs2_file_fops_nolock;
 extern const struct file_operations gfs2_dir_fops_nolock;
 
+extern int gfs2_fsgetxattr(struct dentry *dentry, struct kfsxattr *fa);
+extern int gfs2_fssetxattr(struct dentry *dentry, struct kfsxattr *fa);
 extern void gfs2_set_inode_flags(struct inode *inode);
  
 #ifdef CONFIG_GFS2_FS_LOCKING_DLM
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -12,7 +12,6 @@
 #include <linux/security.h>
 #include <linux/cdev.h>
 #include <linux/memblock.h>
-#include <linux/fscrypt.h>
 #include <linux/fsnotify.h>
 #include <linux/mount.h>
 #include <linux/posix_acl.h>
@@ -2294,89 +2293,3 @@ struct timespec64 current_time(struct in
 	return timestamp_truncate(now, inode);
 }
 EXPORT_SYMBOL(current_time);
-
-/*
- * Generic function to check FS_IOC_SETFLAGS values and reject any invalid
- * configurations.
- *
- * Note: the caller should be holding i_mutex, or else be sure that they have
- * exclusive access to the inode structure.
- */
-int vfs_ioc_setflags_prepare(struct inode *inode, unsigned int oldflags,
-			     unsigned int flags)
-{
-	/*
-	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
-	 * the relevant capability.
-	 *
-	 * This test looks nicer. Thanks to Pauline Middelink
-	 */
-	if ((flags ^ oldflags) & (FS_APPEND_FL | FS_IMMUTABLE_FL) &&
-	    !capable(CAP_LINUX_IMMUTABLE))
-		return -EPERM;
-
-	return fscrypt_prepare_setflags(inode, oldflags, flags);
-}
-EXPORT_SYMBOL(vfs_ioc_setflags_prepare);
-
-/*
- * Generic function to check FS_IOC_FSSETXATTR values and reject any invalid
- * configurations.
- *
- * Note: the caller should be holding i_mutex, or else be sure that they have
- * exclusive access to the inode structure.
- */
-int vfs_ioc_fssetxattr_check(struct inode *inode, const struct fsxattr *old_fa,
-			     struct fsxattr *fa)
-{
-	/*
-	 * Can't modify an immutable/append-only file unless we have
-	 * appropriate permission.
-	 */
-	if ((old_fa->fsx_xflags ^ fa->fsx_xflags) &
-			(FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND) &&
-	    !capable(CAP_LINUX_IMMUTABLE))
-		return -EPERM;
-
-	/*
-	 * Project Quota ID state is only allowed to change from within the init
-	 * namespace. Enforce that restriction only if we are trying to change
-	 * the quota ID state. Everything else is allowed in user namespaces.
-	 */
-	if (current_user_ns() != &init_user_ns) {
-		if (old_fa->fsx_projid != fa->fsx_projid)
-			return -EINVAL;
-		if ((old_fa->fsx_xflags ^ fa->fsx_xflags) &
-				FS_XFLAG_PROJINHERIT)
-			return -EINVAL;
-	}
-
-	/* Check extent size hints. */
-	if ((fa->fsx_xflags & FS_XFLAG_EXTSIZE) && !S_ISREG(inode->i_mode))
-		return -EINVAL;
-
-	if ((fa->fsx_xflags & FS_XFLAG_EXTSZINHERIT) &&
-			!S_ISDIR(inode->i_mode))
-		return -EINVAL;
-
-	if ((fa->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
-	    !S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
-		return -EINVAL;
-
-	/*
-	 * It is only valid to set the DAX flag on regular files and
-	 * directories on filesystems.
-	 */
-	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
-	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
-		return -EINVAL;
-
-	/* Extent size hints of zero turn off the flags. */
-	if (fa->fsx_extsize == 0)
-		fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);
-	if (fa->fsx_cowextsize == 0)
-		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
-
-	return 0;
-}
-EXPORT_SYMBOL(vfs_ioc_fssetxattr_check);
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -19,6 +19,9 @@
 #include <linux/falloc.h>
 #include <linux/sched/signal.h>
 #include <linux/fiemap.h>
+#include <linux/mount.h>
+#include <linux/fscrypt.h>
+#include <linux/ioctl_helpers.h>
 
 #include "internal.h"
 
@@ -657,6 +660,261 @@ static int ioctl_file_dedupe_range(struc
 	return ret;
 }
 
+void fsxattr_fill_xflags(struct kfsxattr *fa, u32 xflags)
+{
+	memset(fa, 0, sizeof(*fa));
+	fa->xattr_valid = true;
+	fa->fsx_xflags = xflags;
+	if (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)
+		fa->fsx_flags |= FS_IMMUTABLE_FL;
+	if (fa->fsx_xflags & FS_XFLAG_APPEND)
+		fa->fsx_flags |= FS_APPEND_FL;
+	if (fa->fsx_xflags & FS_XFLAG_SYNC)
+		fa->fsx_flags |= FS_SYNC_FL;
+	if (fa->fsx_xflags & FS_XFLAG_NOATIME)
+		fa->fsx_flags |= FS_NOATIME_FL;
+	if (fa->fsx_xflags & FS_XFLAG_NODUMP)
+		fa->fsx_flags |= FS_NODUMP_FL;
+	if (fa->fsx_xflags & FS_XFLAG_DAX)
+		fa->fsx_flags |= FS_DAX_FL;
+	if (fa->fsx_xflags & FS_XFLAG_PROJINHERIT)
+		fa->fsx_flags |= FS_PROJINHERIT_FL;
+}
+EXPORT_SYMBOL(fsxattr_fill_xflags);
+
+void fsxattr_fill_flags(struct kfsxattr *fa, u32 flags)
+{
+	memset(fa, 0, sizeof(*fa));
+	fa->flags_valid = true;
+	fa->fsx_flags = flags;
+	if (fa->fsx_flags & FS_SYNC_FL)
+		fa->fsx_xflags |= FS_XFLAG_SYNC;
+	if (fa->fsx_flags & FS_IMMUTABLE_FL)
+		fa->fsx_xflags |= FS_XFLAG_IMMUTABLE;
+	if (fa->fsx_flags & FS_APPEND_FL)
+		fa->fsx_xflags |= FS_XFLAG_APPEND;
+	if (fa->fsx_flags & FS_NODUMP_FL)
+		fa->fsx_xflags |= FS_XFLAG_NODUMP;
+	if (fa->fsx_flags & FS_NOATIME_FL)
+		fa->fsx_xflags |= FS_XFLAG_NOATIME;
+	if (fa->fsx_flags & FS_DAX_FL)
+		fa->fsx_xflags |= FS_XFLAG_DAX;
+	if (fa->fsx_flags & FS_PROJINHERIT_FL)
+		fa->fsx_xflags |= FS_XFLAG_PROJINHERIT;
+}
+EXPORT_SYMBOL(fsxattr_fill_flags);
+
+int vfs_fsgetxattr(struct dentry *dentry, struct kfsxattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+
+	if (d_is_special(dentry))
+		return -ENOTTY;
+
+	if (!inode->i_op->fsgetxattr)
+		return -ENOIOCTLCMD;
+
+	memset(fa, 0, sizeof(*fa));
+	return inode->i_op->fsgetxattr(dentry, fa);
+}
+EXPORT_SYMBOL(vfs_fsgetxattr);
+
+int fsxattr_copy_to_user(const struct kfsxattr *kfa, struct fsxattr __user *ufa)
+{
+	struct fsxattr fa = {
+		.fsx_xflags	= kfa->fsx_xflags,
+		.fsx_extsize	= kfa->fsx_extsize,
+		.fsx_nextents	= kfa->fsx_nextents,
+		.fsx_projid	= kfa->fsx_projid,
+		.fsx_cowextsize	= kfa->fsx_cowextsize,
+	};
+
+	if (copy_to_user(ufa, &fa, sizeof(fa)))
+		return -EFAULT;
+
+	return 0;
+}
+EXPORT_SYMBOL(fsxattr_copy_to_user);
+
+static int fsxattr_copy_from_user(struct kfsxattr *kfa,
+				  struct fsxattr __user *ufa)
+{
+	struct fsxattr fa;
+
+	if (copy_from_user(&fa, ufa, sizeof(fa)))
+		return -EFAULT;
+
+	fsxattr_fill_xflags(kfa, fa.fsx_xflags);
+	kfa->fsx_extsize = fa.fsx_extsize;
+	kfa->fsx_nextents = fa.fsx_nextents;
+	kfa->fsx_projid = fa.fsx_projid;
+	kfa->fsx_cowextsize = fa.fsx_cowextsize;
+
+	return 0;
+}
+
+/*
+ * Generic function to check FS_IOC_FSSETXATTR/FS_IOC_SETFLAGS values and reject
+ * any invalid configurations.
+ *
+ * Note: must be called with inode lock held.
+ */
+static int fssetxattr_prepare(struct inode *inode,
+			      const struct kfsxattr *old_fa,
+			      struct kfsxattr *fa)
+{
+       /*
+        * The IMMUTABLE and APPEND_ONLY flags can only be changed by
+        * the relevant capability.
+	*/
+	if ((fa->fsx_flags ^ old_fa->fsx_flags) & (FS_APPEND_FL | FS_IMMUTABLE_FL) &&
+	    !capable(CAP_LINUX_IMMUTABLE))
+		return -EPERM;
+
+	if (fa->flags_valid)
+		return fscrypt_prepare_setflags(inode, old_fa->fsx_flags, fa->fsx_flags);
+
+	/*
+	 * Project Quota ID state is only allowed to change from within the init
+	 * namespace. Enforce that restriction only if we are trying to change
+	 * the quota ID state. Everything else is allowed in user namespaces.
+	 */
+	if (current_user_ns() != &init_user_ns) {
+		if (old_fa->fsx_projid != fa->fsx_projid)
+			return -EINVAL;
+		if ((old_fa->fsx_xflags ^ fa->fsx_xflags) &
+				FS_XFLAG_PROJINHERIT)
+			return -EINVAL;
+	}
+
+	/* Check extent size hints. */
+	if ((fa->fsx_xflags & FS_XFLAG_EXTSIZE) && !S_ISREG(inode->i_mode))
+		return -EINVAL;
+
+	if ((fa->fsx_xflags & FS_XFLAG_EXTSZINHERIT) &&
+			!S_ISDIR(inode->i_mode))
+		return -EINVAL;
+
+	if ((fa->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
+	    !S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
+		return -EINVAL;
+
+	/*
+	 * It is only valid to set the DAX flag on regular files and
+	 * directories on filesystems.
+	 */
+	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
+	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
+		return -EINVAL;
+
+	/* Extent size hints of zero turn off the flags. */
+	if (fa->fsx_extsize == 0)
+		fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);
+	if (fa->fsx_cowextsize == 0)
+		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
+
+	return 0;
+}
+
+int vfs_fssetxattr(struct dentry *dentry, struct kfsxattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	struct kfsxattr old_fa;
+	int err;
+
+	if (d_is_special(dentry))
+		return -ENOTTY;
+
+	if (!inode->i_op->fssetxattr)
+		return -ENOIOCTLCMD;
+
+	if (!inode_owner_or_capable(inode))
+		return -EPERM;
+
+	inode_lock(inode);
+	err = vfs_fsgetxattr(dentry, &old_fa);
+	if (!err) {
+		/* initialize missing bits from old_fa */
+		if (fa->flags_valid) {
+			fa->fsx_xflags |= old_fa.fsx_xflags & ~FS_XFLAG_COMMON;
+			fa->fsx_extsize = old_fa.fsx_extsize;
+			fa->fsx_nextents = old_fa.fsx_nextents;
+			fa->fsx_projid = old_fa.fsx_projid;
+			fa->fsx_cowextsize = old_fa.fsx_cowextsize;
+		} else {
+			fa->fsx_flags |= old_fa.fsx_flags & ~FS_COMMON_FL;
+		}
+		err = fssetxattr_prepare(inode, &old_fa, fa);
+		if (!err)
+			err = inode->i_op->fssetxattr(dentry, fa);
+	}
+	inode_unlock(inode);
+
+	return err;
+}
+EXPORT_SYMBOL(vfs_fssetxattr);
+
+static int ioctl_getflags(struct file *file, void __user *argp)
+{
+	struct kfsxattr fa;
+	unsigned int flags;
+	int err;
+
+	err = vfs_fsgetxattr(file_dentry(file), &fa);
+	if (!err) {
+		flags = fa.fsx_flags;
+		if (copy_to_user(argp, &flags, sizeof(flags)))
+			err = -EFAULT;
+	}
+	return err;
+}
+
+static int ioctl_setflags(struct file *file, void __user *argp)
+{
+	struct kfsxattr fa;
+	unsigned int flags;
+	int err;
+
+	if (copy_from_user(&flags, argp, sizeof(flags)))
+		return -EFAULT;
+
+	err = mnt_want_write_file(file);
+	if (!err) {
+		fsxattr_fill_flags(&fa, flags);
+		err = vfs_fssetxattr(file_dentry(file), &fa);
+		mnt_drop_write_file(file);
+	}
+	return err;
+}
+
+static int ioctl_fsgetxattr(struct file *file, void __user *argp)
+{
+	struct kfsxattr fa;
+	int err;
+
+	err = vfs_fsgetxattr(file_dentry(file), &fa);
+	if (!err)
+		err = fsxattr_copy_to_user(&fa, argp);
+
+	return err;
+}
+
+static int ioctl_fssetxattr(struct file *file, void __user *argp)
+{
+	struct kfsxattr fa;
+	int err;
+
+	err = fsxattr_copy_from_user(&fa, argp);
+	if (!err) {
+		err = mnt_want_write_file(file);
+		if (!err) {
+			err = vfs_fssetxattr(file_dentry(file), &fa);
+			mnt_drop_write_file(file);
+		}
+	}
+	return err;
+}
+
 /*
  * do_vfs_ioctl() is not for drivers and not intended to be EXPORT_SYMBOL()'d.
  * It's just a simple helper for sys_ioctl and compat_sys_ioctl.
@@ -727,6 +985,18 @@ static int do_vfs_ioctl(struct file *fil
 		return put_user(i_size_read(inode) - filp->f_pos,
 				(int __user *)argp);
 
+	case FS_IOC_GETFLAGS:
+		return ioctl_getflags(filp, argp);
+
+	case FS_IOC_SETFLAGS:
+		return ioctl_setflags(filp, argp);
+
+	case FS_IOC_FSGETXATTR:
+		return ioctl_fsgetxattr(filp, argp);
+
+	case FS_IOC_FSSETXATTR:
+		return ioctl_fssetxattr(filp, argp);
+
 	default:
 		if (S_ISREG(inode->i_mode))
 			return file_ioctl(filp, cmd, argp);
@@ -810,6 +1080,7 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned i
 		error = ioctl_file_clone(f.file, arg, 0, 0, 0);
 		break;
 
+
 #if defined(CONFIG_X86_64)
 	/* these get messy on amd64 due to alignment differences */
 	case FS_IOC_RESVSP_32:
@@ -828,6 +1099,15 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned i
 #endif
 
 	/*
+	 * These access 32-bit values anyway so no further handling is
+	 * necessary.
+	 */
+	case FS_IOC32_GETFLAGS:
+	case FS_IOC32_SETFLAGS:
+		cmd = (cmd == FS_IOC32_GETFLAGS) ?
+			FS_IOC_GETFLAGS : FS_IOC_SETFLAGS;
+		fallthrough;
+	/*
 	 * everything else in do_vfs_ioctl() takes either a compatible
 	 * pointer argument or no argument -- call it with a modified
 	 * argument.
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -375,84 +375,6 @@ static ssize_t orangefs_file_write_iter(
 	return ret;
 }
 
-static int orangefs_getflags(struct inode *inode, unsigned long *uval)
-{
-	__u64 val = 0;
-	int ret;
-
-	ret = orangefs_inode_getxattr(inode,
-				      "user.pvfs2.meta_hint",
-				      &val, sizeof(val));
-	if (ret < 0 && ret != -ENODATA)
-		return ret;
-	else if (ret == -ENODATA)
-		val = 0;
-	*uval = val;
-	return 0;
-}
-
-/*
- * Perform a miscellaneous operation on a file.
- */
-static long orangefs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	struct inode *inode = file_inode(file);
-	int ret = -ENOTTY;
-	__u64 val = 0;
-	unsigned long uval;
-
-	gossip_debug(GOSSIP_FILE_DEBUG,
-		     "orangefs_ioctl: called with cmd %d\n",
-		     cmd);
-
-	/*
-	 * we understand some general ioctls on files, such as the immutable
-	 * and append flags
-	 */
-	if (cmd == FS_IOC_GETFLAGS) {
-		ret = orangefs_getflags(inode, &uval);
-		if (ret)
-			return ret;
-		gossip_debug(GOSSIP_FILE_DEBUG,
-			     "orangefs_ioctl: FS_IOC_GETFLAGS: %llu\n",
-			     (unsigned long long)uval);
-		return put_user(uval, (int __user *)arg);
-	} else if (cmd == FS_IOC_SETFLAGS) {
-		unsigned long old_uval;
-
-		ret = 0;
-		if (get_user(uval, (int __user *)arg))
-			return -EFAULT;
-		/*
-		 * ORANGEFS_MIRROR_FL is set internally when the mirroring mode
-		 * is turned on for a file. The user is not allowed to turn
-		 * on this bit, but the bit is present if the user first gets
-		 * the flags and then updates the flags with some new
-		 * settings. So, we ignore it in the following edit. bligon.
-		 */
-		if ((uval & ~ORANGEFS_MIRROR_FL) &
-		    (~(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NOATIME_FL))) {
-			gossip_err("orangefs_ioctl: the FS_IOC_SETFLAGS only supports setting one of FS_IMMUTABLE_FL|FS_APPEND_FL|FS_NOATIME_FL\n");
-			return -EINVAL;
-		}
-		ret = orangefs_getflags(inode, &old_uval);
-		if (ret)
-			return ret;
-		ret = vfs_ioc_setflags_prepare(inode, old_uval, uval);
-		if (ret)
-			return ret;
-		val = uval;
-		gossip_debug(GOSSIP_FILE_DEBUG,
-			     "orangefs_ioctl: FS_IOC_SETFLAGS: %llu\n",
-			     (unsigned long long)val);
-		ret = orangefs_inode_setxattr(inode,
-					      "user.pvfs2.meta_hint",
-					      &val, sizeof(val), 0);
-	}
-
-	return ret;
-}
-
 static vm_fault_t orangefs_fault(struct vm_fault *vmf)
 {
 	struct file *file = vmf->vma->vm_file;
@@ -660,7 +582,6 @@ const struct file_operations orangefs_fi
 	.read_iter	= orangefs_file_read_iter,
 	.write_iter	= orangefs_file_write_iter,
 	.lock		= orangefs_lock,
-	.unlocked_ioctl	= orangefs_ioctl,
 	.mmap		= orangefs_file_mmap,
 	.open		= generic_file_open,
 	.flush		= orangefs_flush,
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/bvec.h>
+#include <linux/ioctl_helpers.h>
 #include "protocol.h"
 #include "orangefs-kernel.h"
 #include "orangefs-bufmap.h"
@@ -952,6 +953,53 @@ int orangefs_update_time(struct inode *i
 	return __orangefs_setattr(inode, &iattr);
 }
 
+static int orangefs_fsgetxattr(struct dentry *dentry, struct kfsxattr *fa)
+{
+	u64 val = 0;
+	int ret;
+
+	gossip_debug(GOSSIP_FILE_DEBUG, "orangefs_fsgetxattr: called on %pd\n",
+		     dentry);
+
+	ret = orangefs_inode_getxattr(d_inode(dentry),
+				      "user.pvfs2.meta_hint",
+				      &val, sizeof(val));
+	if (ret < 0 && ret != -ENODATA)
+		return ret;
+
+	gossip_debug(GOSSIP_FILE_DEBUG, "orangefs_fsgetxattr: flags=%u\n",
+		     (u32) val);
+
+	fsxattr_fill_flags(fa, val);
+	return 0;
+}
+
+static int orangefs_fssetxattr(struct dentry *dentry, struct kfsxattr *fa)
+{
+	u64 val = 0;
+
+	gossip_debug(GOSSIP_FILE_DEBUG, "orangefs_fssetxattr: called on %pd\n",
+		     dentry);
+	/*
+	 * ORANGEFS_MIRROR_FL is set internally when the mirroring mode is
+	 * turned on for a file. The user is not allowed to turn on this bit,
+	 * but the bit is present if the user first gets the flags and then
+	 * updates the flags with some new settings. So, we ignore it in the
+	 * following edit. bligon.
+	 */
+	if (fsxattr_has_xattr(fa) ||
+	    (fa->fsx_flags & ~(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NOATIME_FL | ORANGEFS_MIRROR_FL))) {
+		gossip_err("orangefs_fssetxattr: only supports setting one of FS_IMMUTABLE_FL|FS_APPEND_FL|FS_NOATIME_FL\n");
+		return -EOPNOTSUPP;
+	}
+	val = fa->fsx_flags;
+	gossip_debug(GOSSIP_FILE_DEBUG, "orangefs_fssetxattr: flags=%u\n",
+		     (u32) val);
+	return orangefs_inode_setxattr(d_inode(dentry),
+				       "user.pvfs2.meta_hint",
+				       &val, sizeof(val), 0);
+}
+
 /* ORANGEFS2 implementation of VFS inode operations for files */
 static const struct inode_operations orangefs_file_inode_operations = {
 	.get_acl = orangefs_get_acl,
@@ -961,6 +1009,8 @@ static const struct inode_operations ora
 	.listxattr = orangefs_listxattr,
 	.permission = orangefs_permission,
 	.update_time = orangefs_update_time,
+	.fsgetxattr = orangefs_fsgetxattr,
+	.fssetxattr = orangefs_fssetxattr,
 };
 
 static int orangefs_init_iops(struct inode *inode)
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1300,4 +1300,6 @@ const struct inode_operations ovl_dir_in
 	.listxattr	= ovl_listxattr,
 	.get_acl	= ovl_get_acl,
 	.update_time	= ovl_update_time,
+	.fsgetxattr	= ovl_fsgetxattr,
+	.fssetxattr	= ovl_fssetxattr,
 };
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -13,6 +13,7 @@
 #include <linux/security.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
+#include <linux/ioctl_helpers.h>
 #include "overlayfs.h"
 
 struct ovl_aio_req {
@@ -537,166 +538,46 @@ static int ovl_fadvise(struct file *file
 	return ret;
 }
 
-static long ovl_real_ioctl(struct file *file, unsigned int cmd,
-			   unsigned long arg)
+int ovl_fssetxattr(struct dentry *dentry, struct kfsxattr *fa)
 {
-	struct fd real;
+	struct inode *inode = d_inode(dentry);
+	struct dentry *upperdentry;
 	const struct cred *old_cred;
-	long ret;
-
-	ret = ovl_real_fdget(file, &real);
-	if (ret)
-		return ret;
-
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = security_file_ioctl(real.file, cmd, arg);
-	if (!ret)
-		ret = vfs_ioctl(real.file, cmd, arg);
-	revert_creds(old_cred);
-
-	fdput(real);
-
-	return ret;
-}
-
-static unsigned int ovl_iflags_to_fsflags(unsigned int iflags)
-{
-	unsigned int flags = 0;
-
-	if (iflags & S_SYNC)
-		flags |= FS_SYNC_FL;
-	if (iflags & S_APPEND)
-		flags |= FS_APPEND_FL;
-	if (iflags & S_IMMUTABLE)
-		flags |= FS_IMMUTABLE_FL;
-	if (iflags & S_NOATIME)
-		flags |= FS_NOATIME_FL;
-
-	return flags;
-}
-
-static long ovl_ioctl_set_flags(struct file *file, unsigned int cmd,
-				unsigned long arg, unsigned int flags)
-{
-	long ret;
-	struct inode *inode = file_inode(file);
-	unsigned int oldflags;
-
-	if (!inode_owner_or_capable(inode))
-		return -EACCES;
-
-	ret = mnt_want_write_file(file);
-	if (ret)
-		return ret;
-
-	inode_lock(inode);
-
-	/* Check the capability before cred override */
-	oldflags = ovl_iflags_to_fsflags(READ_ONCE(inode->i_flags));
-	ret = vfs_ioc_setflags_prepare(inode, oldflags, flags);
-	if (ret)
-		goto unlock;
-
-	ret = ovl_maybe_copy_up(file_dentry(file), O_WRONLY);
-	if (ret)
-		goto unlock;
-
-	ret = ovl_real_ioctl(file, cmd, arg);
-
-	ovl_copyflags(ovl_inode_real(inode), inode);
-unlock:
-	inode_unlock(inode);
-
-	mnt_drop_write_file(file);
-
-	return ret;
-
-}
-
-static long ovl_ioctl_set_fsflags(struct file *file, unsigned int cmd,
-				  unsigned long arg)
-{
-	unsigned int flags;
-
-	if (get_user(flags, (int __user *) arg))
-		return -EFAULT;
-
-	return ovl_ioctl_set_flags(file, cmd, arg, flags);
-}
-
-static unsigned int ovl_fsxflags_to_fsflags(unsigned int xflags)
-{
-	unsigned int flags = 0;
-
-	if (xflags & FS_XFLAG_SYNC)
-		flags |= FS_SYNC_FL;
-	if (xflags & FS_XFLAG_APPEND)
-		flags |= FS_APPEND_FL;
-	if (xflags & FS_XFLAG_IMMUTABLE)
-		flags |= FS_IMMUTABLE_FL;
-	if (xflags & FS_XFLAG_NOATIME)
-		flags |= FS_NOATIME_FL;
-
-	return flags;
-}
-
-static long ovl_ioctl_set_fsxflags(struct file *file, unsigned int cmd,
-				   unsigned long arg)
-{
-	struct fsxattr fa;
-
-	memset(&fa, 0, sizeof(fa));
-	if (copy_from_user(&fa, (void __user *) arg, sizeof(fa)))
-		return -EFAULT;
-
-	return ovl_ioctl_set_flags(file, cmd, arg,
-				   ovl_fsxflags_to_fsflags(fa.fsx_xflags));
-}
-
-long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	long ret;
-
-	switch (cmd) {
-	case FS_IOC_GETFLAGS:
-	case FS_IOC_FSGETXATTR:
-		ret = ovl_real_ioctl(file, cmd, arg);
-		break;
+	int err;
 
-	case FS_IOC_SETFLAGS:
-		ret = ovl_ioctl_set_fsflags(file, cmd, arg);
-		break;
+	err = ovl_want_write(dentry);
+	if (err)
+		goto out;
 
-	case FS_IOC_FSSETXATTR:
-		ret = ovl_ioctl_set_fsxflags(file, cmd, arg);
-		break;
+	err = ovl_copy_up(dentry);
+	if (!err) {
+		upperdentry = ovl_dentry_upper(dentry);
+
+		old_cred = ovl_override_creds(inode->i_sb);
+		/* err = security_file_ioctl(real.file, cmd, arg); */
+		err = vfs_fssetxattr(upperdentry, fa);
+		revert_creds(old_cred);
 
-	default:
-		ret = -ENOTTY;
+		ovl_copyflags(ovl_inode_real(inode), inode);
 	}
-
-	return ret;
+	ovl_drop_write(dentry);
+out:
+	return err;
 }
 
-#ifdef CONFIG_COMPAT
-long ovl_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+int ovl_fsgetxattr(struct dentry *dentry, struct kfsxattr *fa)
 {
-	switch (cmd) {
-	case FS_IOC32_GETFLAGS:
-		cmd = FS_IOC_GETFLAGS;
-		break;
-
-	case FS_IOC32_SETFLAGS:
-		cmd = FS_IOC_SETFLAGS;
-		break;
+	struct inode *inode = d_inode(dentry);
+	struct dentry *realdentry = ovl_dentry_real(dentry);
+	const struct cred *old_cred;
+	int err;
 
-	default:
-		return -ENOIOCTLCMD;
-	}
+	old_cred = ovl_override_creds(inode->i_sb);
+	err = vfs_fsgetxattr(realdentry, fa);
+	revert_creds(old_cred);
 
-	return ovl_ioctl(file, cmd, arg);
+	return err;
 }
-#endif
 
 enum ovl_copyop {
 	OVL_COPY,
@@ -797,10 +678,6 @@ const struct file_operations ovl_file_op
 	.mmap		= ovl_mmap,
 	.fallocate	= ovl_fallocate,
 	.fadvise	= ovl_fadvise,
-	.unlocked_ioctl	= ovl_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	= ovl_compat_ioctl,
-#endif
 	.splice_read    = ovl_splice_read,
 	.splice_write   = ovl_splice_write,
 
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -497,6 +497,8 @@ static const struct inode_operations ovl
 	.get_acl	= ovl_get_acl,
 	.update_time	= ovl_update_time,
 	.fiemap		= ovl_fiemap,
+	.fsgetxattr	= ovl_fsgetxattr,
+	.fssetxattr	= ovl_fssetxattr,
 };
 
 static const struct inode_operations ovl_symlink_inode_operations = {
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -505,8 +505,8 @@ struct dentry *ovl_create_temp(struct de
 extern const struct file_operations ovl_file_operations;
 int __init ovl_aio_request_cache_init(void);
 void ovl_aio_request_cache_destroy(void);
-long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
-long ovl_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+int ovl_fsgetxattr(struct dentry *dentry, struct kfsxattr *fa);
+int ovl_fssetxattr(struct dentry *dentry, struct kfsxattr *fa);
 
 /* copy_up.c */
 int ovl_copy_up(struct dentry *dentry);
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -971,10 +971,6 @@ const struct file_operations ovl_dir_ope
 	.llseek		= ovl_dir_llseek,
 	.fsync		= ovl_dir_fsync,
 	.release	= ovl_dir_release,
-	.unlocked_ioctl	= ovl_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	= ovl_compat_ioctl,
-#endif
 };
 
 int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -781,8 +781,6 @@ struct xfs_scrub_metadata {
 #define XFS_IOC_ALLOCSP		_IOW ('X', 10, struct xfs_flock64)
 #define XFS_IOC_FREESP		_IOW ('X', 11, struct xfs_flock64)
 #define XFS_IOC_DIOINFO		_IOR ('X', 30, struct dioattr)
-#define XFS_IOC_FSGETXATTR	FS_IOC_FSGETXATTR
-#define XFS_IOC_FSSETXATTR	FS_IOC_FSSETXATTR
 #define XFS_IOC_ALLOCSP64	_IOW ('X', 36, struct xfs_flock64)
 #define XFS_IOC_FREESP64	_IOW ('X', 37, struct xfs_flock64)
 #define XFS_IOC_GETBMAP		_IOWR('X', 38, struct getbmap)
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -40,6 +40,7 @@
 
 #include <linux/mount.h>
 #include <linux/namei.h>
+#include <linux/ioctl_helpers.h>
 
 /*
  * xfs_find_handle maps from userspace xfs_fsop_handlereq structure to
@@ -1048,73 +1049,16 @@ xfs_ioc_ag_geometry(
  * Linux extended inode flags interface.
  */
 
-STATIC unsigned int
-xfs_merge_ioc_xflags(
-	unsigned int	flags,
-	unsigned int	start)
-{
-	unsigned int	xflags = start;
-
-	if (flags & FS_IMMUTABLE_FL)
-		xflags |= FS_XFLAG_IMMUTABLE;
-	else
-		xflags &= ~FS_XFLAG_IMMUTABLE;
-	if (flags & FS_APPEND_FL)
-		xflags |= FS_XFLAG_APPEND;
-	else
-		xflags &= ~FS_XFLAG_APPEND;
-	if (flags & FS_SYNC_FL)
-		xflags |= FS_XFLAG_SYNC;
-	else
-		xflags &= ~FS_XFLAG_SYNC;
-	if (flags & FS_NOATIME_FL)
-		xflags |= FS_XFLAG_NOATIME;
-	else
-		xflags &= ~FS_XFLAG_NOATIME;
-	if (flags & FS_NODUMP_FL)
-		xflags |= FS_XFLAG_NODUMP;
-	else
-		xflags &= ~FS_XFLAG_NODUMP;
-	if (flags & FS_DAX_FL)
-		xflags |= FS_XFLAG_DAX;
-	else
-		xflags &= ~FS_XFLAG_DAX;
-
-	return xflags;
-}
-
-STATIC unsigned int
-xfs_di2lxflags(
-	uint16_t	di_flags,
-	uint64_t	di_flags2)
-{
-	unsigned int	flags = 0;
-
-	if (di_flags & XFS_DIFLAG_IMMUTABLE)
-		flags |= FS_IMMUTABLE_FL;
-	if (di_flags & XFS_DIFLAG_APPEND)
-		flags |= FS_APPEND_FL;
-	if (di_flags & XFS_DIFLAG_SYNC)
-		flags |= FS_SYNC_FL;
-	if (di_flags & XFS_DIFLAG_NOATIME)
-		flags |= FS_NOATIME_FL;
-	if (di_flags & XFS_DIFLAG_NODUMP)
-		flags |= FS_NODUMP_FL;
-	if (di_flags2 & XFS_DIFLAG2_DAX) {
-		flags |= FS_DAX_FL;
-	}
-	return flags;
-}
-
 static void
 xfs_fill_fsxattr(
 	struct xfs_inode	*ip,
 	bool			attr,
-	struct fsxattr		*fa)
+	struct kfsxattr		*fa)
 {
 	struct xfs_ifork	*ifp = attr ? ip->i_afp : &ip->i_df;
 
-	simple_fill_fsxattr(fa, xfs_ip2xflags(ip));
+	fsxattr_fill_xflags(fa, xfs_ip2xflags(ip));
+	fa->fsx_flags &= ~FS_PROJINHERIT_FL; /* Accidental? */
 	fa->fsx_extsize = ip->i_d.di_extsize << ip->i_mount->m_sb.sb_blocklog;
 	fa->fsx_cowextsize = ip->i_d.di_cowextsize <<
 			ip->i_mount->m_sb.sb_blocklog;
@@ -1126,19 +1070,30 @@ xfs_fill_fsxattr(
 }
 
 STATIC int
-xfs_ioc_fsgetxattr(
+xfs_ioc_fsgetxattra(
 	xfs_inode_t		*ip,
-	int			attr,
 	void			__user *arg)
 {
-	struct fsxattr		fa;
+	struct kfsxattr		fa;
 
 	xfs_ilock(ip, XFS_ILOCK_SHARED);
-	xfs_fill_fsxattr(ip, attr, &fa);
+	xfs_fill_fsxattr(ip, true, &fa);
+	xfs_iunlock(ip, XFS_ILOCK_SHARED);
+
+	return fsxattr_copy_to_user(&fa, arg);
+}
+
+extern int
+xfs_fsgetxattr(
+	struct dentry		*dentry,
+	struct kfsxattr		*fa)
+{
+	xfs_inode_t		*ip = XFS_I(d_inode(dentry));
+
+	xfs_ilock(ip, XFS_ILOCK_SHARED);
+	xfs_fill_fsxattr(ip, false, fa);
 	xfs_iunlock(ip, XFS_ILOCK_SHARED);
 
-	if (copy_to_user(arg, &fa, sizeof(fa)))
-		return -EFAULT;
 	return 0;
 }
 
@@ -1205,7 +1160,7 @@ static int
 xfs_ioctl_setattr_xflags(
 	struct xfs_trans	*tp,
 	struct xfs_inode	*ip,
-	struct fsxattr		*fa)
+	struct kfsxattr		*fa)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	uint64_t		di_flags2;
@@ -1248,7 +1203,7 @@ xfs_ioctl_setattr_xflags(
 static void
 xfs_ioctl_setattr_prepare_dax(
 	struct xfs_inode	*ip,
-	struct fsxattr		*fa)
+	struct kfsxattr		*fa)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct inode            *inode = VFS_I(ip);
@@ -1335,7 +1290,7 @@ xfs_ioctl_setattr_get_trans(
 static int
 xfs_ioctl_setattr_check_extsize(
 	struct xfs_inode	*ip,
-	struct fsxattr		*fa)
+	struct kfsxattr		*fa)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_extlen_t		size;
@@ -1385,7 +1340,7 @@ xfs_ioctl_setattr_check_extsize(
 static int
 xfs_ioctl_setattr_check_cowextsize(
 	struct xfs_inode	*ip,
-	struct fsxattr		*fa)
+	struct kfsxattr		*fa)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_extlen_t		size;
@@ -1417,7 +1372,7 @@ xfs_ioctl_setattr_check_cowextsize(
 static int
 xfs_ioctl_setattr_check_projid(
 	struct xfs_inode	*ip,
-	struct fsxattr		*fa)
+	struct kfsxattr		*fa)
 {
 	/* Disallow 32bit project ids if projid32bit feature is not enabled. */
 	if (fa->fsx_projid > (uint16_t)-1 &&
@@ -1426,12 +1381,12 @@ xfs_ioctl_setattr_check_projid(
 	return 0;
 }
 
-STATIC int
-xfs_ioctl_setattr(
-	xfs_inode_t		*ip,
-	struct fsxattr		*fa)
+int
+xfs_fssetxattr(
+	struct dentry		*dentry,
+	struct kfsxattr		*fa)
 {
-	struct fsxattr		old_fa;
+	xfs_inode_t		*ip = XFS_I(d_inode(dentry));
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
 	struct xfs_dquot	*pdqp = NULL;
@@ -1440,6 +1395,16 @@ xfs_ioctl_setattr(
 
 	trace_xfs_ioctl_setattr(ip);
 
+	if (!fa->xattr_valid) {
+		/* FS_PROJINHERIT_FL not accepted, deliberate? */
+		if (fa->fsx_flags & ~(FS_IMMUTABLE_FL | FS_APPEND_FL | \
+				      FS_NOATIME_FL | FS_NODUMP_FL |   \
+				      FS_SYNC_FL | FS_DAX_FL))
+			return -EOPNOTSUPP;
+
+		goto skip_xattr_1;
+	}
+
 	code = xfs_ioctl_setattr_check_projid(ip, fa);
 	if (code)
 		return code;
@@ -1460,6 +1425,7 @@ xfs_ioctl_setattr(
 			return code;
 	}
 
+skip_xattr_1:
 	xfs_ioctl_setattr_prepare_dax(ip, fa);
 
 	tp = xfs_ioctl_setattr_get_trans(ip);
@@ -1468,6 +1434,9 @@ xfs_ioctl_setattr(
 		goto error_free_dquots;
 	}
 
+	if (!fa->xattr_valid)
+		goto skip_xattr_2;
+
 	if (XFS_IS_QUOTA_RUNNING(mp) && XFS_IS_PQUOTA_ON(mp) &&
 	    ip->i_d.di_projid != fa->fsx_projid) {
 		code = xfs_qm_vop_chown_reserve(tp, ip, NULL, NULL, pdqp,
@@ -1476,11 +1445,6 @@ xfs_ioctl_setattr(
 			goto error_trans_cancel;
 	}
 
-	xfs_fill_fsxattr(ip, false, &old_fa);
-	code = vfs_ioc_fssetxattr_check(VFS_I(ip), &old_fa, fa);
-	if (code)
-		goto error_trans_cancel;
-
 	code = xfs_ioctl_setattr_check_extsize(ip, fa);
 	if (code)
 		goto error_trans_cancel;
@@ -1489,10 +1453,13 @@ xfs_ioctl_setattr(
 	if (code)
 		goto error_trans_cancel;
 
+skip_xattr_2:
 	code = xfs_ioctl_setattr_xflags(tp, ip, fa);
 	if (code)
 		goto error_trans_cancel;
 
+	if (!fa->xattr_valid)
+		goto skip_xattr_3;
 	/*
 	 * Change file ownership.  Must be the owner or privileged.  CAP_FSETID
 	 * overrides the following restrictions:
@@ -1530,6 +1497,7 @@ xfs_ioctl_setattr(
 	else
 		ip->i_d.di_cowextsize = 0;
 
+skip_xattr_3:
 	code = xfs_trans_commit(tp);
 
 	/*
@@ -1547,92 +1515,6 @@ xfs_ioctl_setattr(
 	return code;
 }
 
-STATIC int
-xfs_ioc_fssetxattr(
-	xfs_inode_t		*ip,
-	struct file		*filp,
-	void			__user *arg)
-{
-	struct fsxattr		fa;
-	int error;
-
-	if (copy_from_user(&fa, arg, sizeof(fa)))
-		return -EFAULT;
-
-	error = mnt_want_write_file(filp);
-	if (error)
-		return error;
-	error = xfs_ioctl_setattr(ip, &fa);
-	mnt_drop_write_file(filp);
-	return error;
-}
-
-STATIC int
-xfs_ioc_getxflags(
-	xfs_inode_t		*ip,
-	void			__user *arg)
-{
-	unsigned int		flags;
-
-	flags = xfs_di2lxflags(ip->i_d.di_flags, ip->i_d.di_flags2);
-	if (copy_to_user(arg, &flags, sizeof(flags)))
-		return -EFAULT;
-	return 0;
-}
-
-STATIC int
-xfs_ioc_setxflags(
-	struct xfs_inode	*ip,
-	struct file		*filp,
-	void			__user *arg)
-{
-	struct xfs_trans	*tp;
-	struct fsxattr		fa;
-	struct fsxattr		old_fa;
-	unsigned int		flags;
-	int			error;
-
-	if (copy_from_user(&flags, arg, sizeof(flags)))
-		return -EFAULT;
-
-	if (flags & ~(FS_IMMUTABLE_FL | FS_APPEND_FL | \
-		      FS_NOATIME_FL | FS_NODUMP_FL | \
-		      FS_SYNC_FL | FS_DAX_FL))
-		return -EOPNOTSUPP;
-
-	fa.fsx_xflags = xfs_merge_ioc_xflags(flags, xfs_ip2xflags(ip));
-
-	error = mnt_want_write_file(filp);
-	if (error)
-		return error;
-
-	xfs_ioctl_setattr_prepare_dax(ip, &fa);
-
-	tp = xfs_ioctl_setattr_get_trans(ip);
-	if (IS_ERR(tp)) {
-		error = PTR_ERR(tp);
-		goto out_drop_write;
-	}
-
-	xfs_fill_fsxattr(ip, false, &old_fa);
-	error = vfs_ioc_fssetxattr_check(VFS_I(ip), &old_fa, &fa);
-	if (error) {
-		xfs_trans_cancel(tp);
-		goto out_drop_write;
-	}
-
-	error = xfs_ioctl_setattr_xflags(tp, ip, &fa);
-	if (error) {
-		xfs_trans_cancel(tp);
-		goto out_drop_write;
-	}
-
-	error = xfs_trans_commit(tp);
-out_drop_write:
-	mnt_drop_write_file(filp);
-	return error;
-}
-
 static bool
 xfs_getbmap_format(
 	struct kgetbmap		*p,
@@ -2139,16 +2021,8 @@ xfs_file_ioctl(
 	case XFS_IOC_GETVERSION:
 		return put_user(inode->i_generation, (int __user *)arg);
 
-	case XFS_IOC_FSGETXATTR:
-		return xfs_ioc_fsgetxattr(ip, 0, arg);
 	case XFS_IOC_FSGETXATTRA:
-		return xfs_ioc_fsgetxattr(ip, 1, arg);
-	case XFS_IOC_FSSETXATTR:
-		return xfs_ioc_fssetxattr(ip, filp, arg);
-	case XFS_IOC_GETXFLAGS:
-		return xfs_ioc_getxflags(ip, arg);
-	case XFS_IOC_SETXFLAGS:
-		return xfs_ioc_setxflags(ip, filp, arg);
+		return xfs_ioc_fsgetxattra(ip, arg);
 
 	case XFS_IOC_GETBMAP:
 	case XFS_IOC_GETBMAPA:
--- a/fs/xfs/xfs_ioctl.h
+++ b/fs/xfs/xfs_ioctl.h
@@ -47,6 +47,16 @@ xfs_handle_to_dentry(
 	void __user		*uhandle,
 	u32			hlen);
 
+extern int
+xfs_fsgetxattr(
+	struct dentry		*dentry,
+	struct kfsxattr		*fa);
+
+extern int
+xfs_fssetxattr(
+	struct dentry		*dentry,
+	struct kfsxattr		*fa);
+
 extern long
 xfs_file_ioctl(
 	struct file		*filp,
--- a/fs/xfs/xfs_ioctl32.c
+++ b/fs/xfs/xfs_ioctl32.c
@@ -483,8 +483,6 @@ xfs_file_compat_ioctl(
 	}
 #endif
 	/* long changes size, but xfs only copiese out 32 bits */
-	case XFS_IOC_GETXFLAGS_32:
-	case XFS_IOC_SETXFLAGS_32:
 	case XFS_IOC_GETVERSION_32:
 		cmd = _NATIVE_IOC(cmd, long);
 		return xfs_file_ioctl(filp, cmd, p);
--- a/fs/xfs/xfs_ioctl32.h
+++ b/fs/xfs/xfs_ioctl32.h
@@ -17,8 +17,6 @@
  */
 
 /* stock kernel-level ioctls we support */
-#define XFS_IOC_GETXFLAGS_32	FS_IOC32_GETFLAGS
-#define XFS_IOC_SETXFLAGS_32	FS_IOC32_SETFLAGS
 #define XFS_IOC_GETVERSION_32	FS_IOC32_GETVERSION
 
 /*
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -21,6 +21,7 @@
 #include "xfs_dir2.h"
 #include "xfs_iomap.h"
 #include "xfs_error.h"
+#include "xfs_ioctl.h"
 
 #include <linux/posix_acl.h>
 #include <linux/security.h>
@@ -1164,6 +1165,8 @@ static const struct inode_operations xfs
 	.listxattr		= xfs_vn_listxattr,
 	.fiemap			= xfs_vn_fiemap,
 	.update_time		= xfs_vn_update_time,
+	.fsgetxattr		= xfs_fsgetxattr,
+	.fssetxattr		= xfs_fssetxattr,
 };
 
 static const struct inode_operations xfs_dir_inode_operations = {
@@ -1189,6 +1192,8 @@ static const struct inode_operations xfs
 	.listxattr		= xfs_vn_listxattr,
 	.update_time		= xfs_vn_update_time,
 	.tmpfile		= xfs_vn_tmpfile,
+	.fsgetxattr		= xfs_fsgetxattr,
+	.fssetxattr		= xfs_fssetxattr,
 };
 
 static const struct inode_operations xfs_dir_ci_inode_operations = {
@@ -1214,6 +1219,8 @@ static const struct inode_operations xfs
 	.listxattr		= xfs_vn_listxattr,
 	.update_time		= xfs_vn_update_time,
 	.tmpfile		= xfs_vn_tmpfile,
+	.fsgetxattr		= xfs_fsgetxattr,
+	.fssetxattr		= xfs_fssetxattr,
 };
 
 static const struct inode_operations xfs_symlink_inode_operations = {
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -68,6 +68,7 @@ struct fsverity_info;
 struct fsverity_operations;
 struct fs_context;
 struct fs_parameter_spec;
+struct kfsxattr;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -1873,6 +1874,8 @@ struct inode_operations {
 			   umode_t create_mode);
 	int (*tmpfile) (struct inode *, struct dentry *, umode_t);
 	int (*set_acl)(struct inode *, struct posix_acl *, int);
+	int (*fssetxattr)(struct dentry *, struct kfsxattr *);
+	int (*fsgetxattr)(struct dentry *, struct kfsxattr *);
 } ____cacheline_aligned;
 
 static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
@@ -3437,18 +3440,6 @@ extern int vfs_fadvise(struct file *file
 extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
 			   int advice);
 
-int vfs_ioc_setflags_prepare(struct inode *inode, unsigned int oldflags,
-			     unsigned int flags);
-
-int vfs_ioc_fssetxattr_check(struct inode *inode, const struct fsxattr *old_fa,
-			     struct fsxattr *fa);
-
-static inline void simple_fill_fsxattr(struct fsxattr *fa, __u32 xflags)
-{
-	memset(fa, 0, sizeof(*fa));
-	fa->fsx_xflags = xflags;
-}
-
 /*
  * Flush file data before changing attributes.  Caller must hold any locks
  * required to prevent further writes to this file until we're done setting
--- /dev/null
+++ b/include/linux/ioctl_helpers.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_IOCTL_HELPERS_H
+#define _LINUX_IOCTL_HELPERS_H
+
+/* Flags shared betwen flags/xflags */
+#define FS_COMMON_FL \
+	(FS_SYNC_FL | FS_IMMUTABLE_FL | FS_APPEND_FL | \
+	 FS_NODUMP_FL |	FS_NOATIME_FL | FS_DAX_FL | \
+	 FS_PROJINHERIT_FL)
+
+#define FS_XFLAG_COMMON \
+	(FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND | \
+	 FS_XFLAG_NODUMP | FS_XFLAG_NOATIME | FS_XFLAG_DAX | \
+	 FS_XFLAG_PROJINHERIT)
+
+struct kfsxattr {
+	u32	fsx_flags;	/* flags (FS_IOC_GETFLAGS/FS_IOC_SETFLAGS) */
+	/* struct fsxattr: */
+	u32	fsx_xflags;	/* xflags field value (get/set) */
+	u32	fsx_extsize;	/* extsize field value (get/set)*/
+	u32	fsx_nextents;	/* nextents field value (get)	*/
+	u32	fsx_projid;	/* project identifier (get/set) */
+	u32	fsx_cowextsize;	/* CoW extsize field value (get/set)*/
+	/* selectors: */
+	bool	flags_valid:1;
+	bool	xattr_valid:1;
+};
+
+int fsxattr_copy_to_user(const struct kfsxattr *fa, struct fsxattr __user *ufa);
+
+void fsxattr_fill_xflags(struct kfsxattr *fa, u32 xflags);
+void fsxattr_fill_flags(struct kfsxattr *fa, u32 flags);
+
+static inline bool fsxattr_has_xattr(const struct kfsxattr *fa)
+{
+	return fa->xattr_valid &&
+		((fa->fsx_xflags & ~FS_XFLAG_COMMON) || fa->fsx_extsize != 0 ||
+		 fa->fsx_projid != 0 ||	fa->fsx_cowextsize != 0);
+}
+
+int vfs_fsgetxattr(struct dentry *dentry, struct kfsxattr *fa);
+int vfs_fssetxattr(struct dentry *dentry, struct kfsxattr *fa);
+
+
+#endif /* _LINUX_IOCTL_HELPERS_H */
