Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02A5349A66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 20:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhCYTil (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 15:38:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20140 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230085AbhCYTiG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616701085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ldpnCAyqee0inILd5QuhZCehz3siDcblCAejCeo9Kx4=;
        b=cuPwZFOONy/AYyc/XRYKSWAsBYxkDOIo/YKiOaRjfxI1PtRZPYDZHmVDKBkyAqy9Q37Bft
        kfs+vDLbDumXEopwIM117euNgyPLcTmI+5fMHnLtC0Iu2v/P2fs0uDyEmv/qnG1bxvxMT8
        sigaJMYgYFmlAzW/B4VjtCUKJede3jE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-jWI-nnviNeKF870HReeYsw-1; Thu, 25 Mar 2021 15:38:03 -0400
X-MC-Unique: jWI-nnviNeKF870HReeYsw-1
Received: by mail-ej1-f71.google.com with SMTP id sa29so3068842ejb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 12:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ldpnCAyqee0inILd5QuhZCehz3siDcblCAejCeo9Kx4=;
        b=CnLi0na5sRZIC0hPVRZvAQIMW0XKv4NHbWnHRZEF4nL4cDJQ1X4jSDlPpiw8h4+WjR
         pB/xTQYRr5pCbUNh/VQftOJ/HJFyQjyYgZBs4SPSZUWh6/roZCPnI7aPM2c0tvMIobEV
         qoqtaYpXiZpAUGTE3j7vED45w19CCDRtcUMPijn/EMg+PbAf6jtdkAH/8tfN5kG5H6OV
         cia/lDVfSSrDgkZ5pOE8qAKfQw4bSv2yuiw+dX/U3GTgOqPNPQXS+//7Ecf7Gxelb3G7
         pJSESbFVOdZFzaMFk7D2OG9AtXvuSNt5zbtnJBfPhBSpR1lWhh9pIAAy57YO1GGP68F0
         2fFA==
X-Gm-Message-State: AOAM533I7PK7ZgDQ5FZRYt1HNY8FlzLoanRye7hwqHwQr0zkiy8ZcD+e
        IqOSv5i2FfiisLroOvfk+kr7FqZBXMyuRrEGassKveqazljwOhS7mYOHaTXi2DZihTYn5bVVLT+
        sk5GwM6VeA/BfraixXPVMw8EPP7EhdbqHmMAgn1z7LlRrwVLzNerg+gPRYy9qK7F0kJ/abguaXu
        XEUA==
X-Received: by 2002:a17:906:aac6:: with SMTP id kt6mr11397553ejb.260.1616701082008;
        Thu, 25 Mar 2021 12:38:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBcTg1sRMuE3qH7yVjS0y6jmCFsuZ+y2OOVmBNONDWiUTHnotgm9JAt9W7vTLQJU/xipNHzQ==
X-Received: by 2002:a17:906:aac6:: with SMTP id kt6mr11397529ejb.260.1616701081739;
        Thu, 25 Mar 2021 12:38:01 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id si7sm2881996ejb.84.2021.03.25.12.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 12:38:01 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v3 04/18] btrfs: convert to fileattr
Date:   Thu, 25 Mar 2021 20:37:41 +0100
Message-Id: <20210325193755.294925-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325193755.294925-1-mszeredi@redhat.com>
References: <20210325193755.294925-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the fileattr API to let the VFS handle locking, permission checking and
conversion.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h |   3 +
 fs/btrfs/inode.c |   4 +
 fs/btrfs/ioctl.c | 226 +++++++----------------------------------------
 3 files changed, 41 insertions(+), 192 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9ae776ab3967..81178dd329c5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3189,6 +3189,9 @@ void btrfs_update_inode_bytes(struct btrfs_inode *inode,
 /* ioctl.c */
 long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 long btrfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+int btrfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+int btrfs_fileattr_set(struct user_namespace *mnt_userns,
+		       struct dentry *dentry, struct fileattr *fa);
 int btrfs_ioctl_get_supported_features(void __user *arg);
 void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
 int __pure btrfs_is_empty_uuid(u8 *uuid);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7cdf65be3707..b89c033489e6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10603,6 +10603,8 @@ static const struct inode_operations btrfs_dir_inode_operations = {
 	.set_acl	= btrfs_set_acl,
 	.update_time	= btrfs_update_time,
 	.tmpfile        = btrfs_tmpfile,
+	.fileattr_get	= btrfs_fileattr_get,
+	.fileattr_set	= btrfs_fileattr_set,
 };
 
 static const struct file_operations btrfs_dir_file_operations = {
@@ -10656,6 +10658,8 @@ static const struct inode_operations btrfs_file_inode_operations = {
 	.get_acl	= btrfs_get_acl,
 	.set_acl	= btrfs_set_acl,
 	.update_time	= btrfs_update_time,
+	.fileattr_get	= btrfs_fileattr_get,
+	.fileattr_set	= btrfs_fileattr_set,
 };
 static const struct inode_operations btrfs_special_inode_operations = {
 	.getattr	= btrfs_getattr,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e8d53fea4c61..534db336a718 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -26,6 +26,7 @@
 #include <linux/btrfs.h>
 #include <linux/uaccess.h>
 #include <linux/iversion.h>
+#include <linux/fileattr.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "export.h"
@@ -153,16 +154,6 @@ void btrfs_sync_inode_flags_to_i_flags(struct inode *inode)
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
@@ -201,9 +192,22 @@ static int check_fsflags_compatible(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
+/*
+ * Set flags/xflags from the internal inode flags. The remaining items of
+ * fsxattr are zeroed.
+ */
+int btrfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
-	struct inode *inode = file_inode(file);
+	struct btrfs_inode *binode = BTRFS_I(d_inode(dentry));
+
+	fileattr_fill_flags(fa, btrfs_inode_flags_to_fsflags(binode->flags));
+	return 0;
+}
+
+int btrfs_fileattr_set(struct user_namespace *mnt_userns,
+		       struct dentry *dentry, struct fileattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_inode *binode = BTRFS_I(inode);
 	struct btrfs_root *root = binode->root;
@@ -213,34 +217,21 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 	const char *comp = NULL;
 	u32 binode_flags;
 
-	if (!inode_owner_or_capable(&init_user_ns, inode))
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
+	if (fileattr_has_fsx(fa))
+		return -EOPNOTSUPP;
 
-	inode_lock(inode);
-	fsflags = btrfs_mask_fsflags_for_type(inode, fsflags);
+	fsflags = btrfs_mask_fsflags_for_type(inode, fa->flags);
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
 
 	ret = check_fsflags_compatible(fs_info, fsflags);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	binode_flags = binode->flags;
 	if (fsflags & FS_SYNC_FL)
@@ -263,6 +254,14 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 		binode_flags |= BTRFS_INODE_NOATIME;
 	else
 		binode_flags &= ~BTRFS_INODE_NOATIME;
+
+	/* If coming from FS_IOC_FSSETXATTR then skip unconverted flags */
+	if (!fa->flags_valid) {
+		/* 1 item for the inode */
+		trans = btrfs_start_transaction(root, 1);
+		goto update_flags;
+	}
+
 	if (fsflags & FS_DIRSYNC_FL)
 		binode_flags |= BTRFS_INODE_DIRSYNC;
 	else
@@ -303,10 +302,8 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
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
@@ -323,10 +320,8 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
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
@@ -344,6 +339,7 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 		}
 	}
 
+update_flags:
 	binode->flags = binode_flags;
 	btrfs_sync_inode_flags_to_i_flags(inode);
 	inode_inc_iversion(inode);
@@ -352,44 +348,9 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 
  out_end_trans:
 	btrfs_end_transaction(trans);
- out_unlock:
-	inode_unlock(inode);
-	mnt_drop_write_file(file);
 	return ret;
 }
 
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
 bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
 			enum btrfs_exclusive_operation type)
 {
@@ -402,111 +363,6 @@ void btrfs_exclop_finish(struct btrfs_fs_info *fs_info)
 	sysfs_notify(&fs_info->fs_devices->fsid_kobj, NULL, "exclusive_operation");
 }
 
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
-	if (!inode_owner_or_capable(&init_user_ns, inode))
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
-	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
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
-	return ret;
-}
-
 static int btrfs_ioctl_getversion(struct file *file, int __user *arg)
 {
 	struct inode *inode = file_inode(file);
@@ -4915,10 +4771,6 @@ long btrfs_ioctl(struct file *file, unsigned int
 	void __user *argp = (void __user *)arg;
 
 	switch (cmd) {
-	case FS_IOC_GETFLAGS:
-		return btrfs_ioctl_getflags(file, argp);
-	case FS_IOC_SETFLAGS:
-		return btrfs_ioctl_setflags(file, argp);
 	case FS_IOC_GETVERSION:
 		return btrfs_ioctl_getversion(file, argp);
 	case FS_IOC_GETFSLABEL:
@@ -5044,10 +4896,6 @@ long btrfs_ioctl(struct file *file, unsigned int
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
@@ -5067,12 +4915,6 @@ long btrfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
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
-- 
2.30.2

