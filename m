Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC4230DA62
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 13:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhBCM66 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 07:58:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27549 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230034AbhBCMnN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612356104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LcckQRLAPvk4WBoShHiBBErclkd3ZTfmw66b8irkIos=;
        b=X47NFR/ULP+11Do/ATXHDHn3VSB3/uofAPq+Eyi5TCqWlo5l7m19wudnrWyK7ZwSLEYXkm
        M8+CWB5n0dfBer4Zb79ZJY9a84cwiiLzYCF+bmXuoYt/7ElNkYL0DLo/yq82q340uI3qIA
        iF/VNyo8vl6yn+AUUHN8+J/fY9XoE5s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-YDf0ExX6MzWvUEqzF5PqGw-1; Wed, 03 Feb 2021 07:41:42 -0500
X-MC-Unique: YDf0ExX6MzWvUEqzF5PqGw-1
Received: by mail-ed1-f70.google.com with SMTP id m16so11351091edd.21
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 04:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LcckQRLAPvk4WBoShHiBBErclkd3ZTfmw66b8irkIos=;
        b=tQVIusgEOtepppGEIcbCUFSoZZqJ9kHGbaxnTZ5DXCyu+IazU08DX1SlIQjia+xvPl
         n46S3t8imUgMMHVf/RgMSTM23zmQh8vXqtzLerxCSkEde/ck7ghQ/oNmkpxr5pxeoGp+
         SzMZsoCxF/byNq+GrMjiXhrPpGL2xDCLp7A+Ks51JlsXQWv1GKG/0hOKnJbMAILOiZ+e
         tccDENzTNxGSYlhhnayDTcEyoTasxu6o6nNmAy2wyAkuBZBDGASGyZaggiEPrYzXdI2X
         IAQVtcmeFcju3GVq01cimtH4BjdWLvplF0rG4oo+NSUqoXHH8JjZiykxXqu5kucoa6My
         XplA==
X-Gm-Message-State: AOAM532AwQPhS377sjnTyz8V5GRRKzkel3tpBaIEaPNWrSfW3r5mQVYP
        RAzCsqb+dIJBniBSkPS7xIsPoemJQX9sHzSLVMoQXunUtEi4JRdR1IG5ARyp/IbfPE0jJ8sdAOg
        U6hKS3R1wWMH5nwnIR3F6ZbgPYYbD9CodSGccBAQ0zJYahWhDkLQSvvIC2cnoecqcQ3wmI0Y49H
        XPzQ==
X-Received: by 2002:a17:906:9ad3:: with SMTP id ah19mr2980445ejc.37.1612356100754;
        Wed, 03 Feb 2021 04:41:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqqvn0ScPLVQ+NYl2TgBi6H7crTylge3k3+dwGTV4zGmchV6jm+Ur8n/iRgRQ28Qa12t/gmA==
X-Received: by 2002:a17:906:9ad3:: with SMTP id ah19mr2980423ejc.37.1612356100441;
        Wed, 03 Feb 2021 04:41:40 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id u9sm953320ejc.57.2021.02.03.04.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:41:39 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 06/18] ext4: convert to miscattr
Date:   Wed,  3 Feb 2021 13:41:00 +0100
Message-Id: <20210203124112.1182614-7-mszeredi@redhat.com>
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
Cc: "Theodore Ts'o" <tytso@mit.edu>
---
 fs/ext4/ext4.h  |  11 +--
 fs/ext4/file.c  |   2 +
 fs/ext4/ioctl.c | 209 ++++++++++--------------------------------------
 fs/ext4/namei.c |   2 +
 4 files changed, 49 insertions(+), 175 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 2866d249f3d2..dc4f8c59f279 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -472,15 +472,6 @@ struct flex_groups {
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
@@ -2921,6 +2912,8 @@ extern int ext4_ind_remove_space(handle_t *handle, struct inode *inode,
 /* ioctl.c */
 extern long ext4_ioctl(struct file *, unsigned int, unsigned long);
 extern long ext4_compat_ioctl(struct file *, unsigned int, unsigned long);
+int ext4_miscattr_set(struct dentry *dentry, struct miscattr *ma);
+int ext4_miscattr_get(struct dentry *dentry, struct miscattr *ma);
 extern void ext4_reset_inode_seed(struct inode *inode);
 
 /* migrate.c */
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 349b27f0dda0..cbc35bd1a7da 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -920,5 +920,7 @@ const struct inode_operations ext4_file_inode_operations = {
 	.get_acl	= ext4_get_acl,
 	.set_acl	= ext4_set_acl,
 	.fiemap		= ext4_fiemap,
+	.miscattr_get	= ext4_miscattr_get,
+	.miscattr_set	= ext4_miscattr_set,
 };
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index d9665d2f82db..883f39340318 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -20,6 +20,7 @@
 #include <linux/uaccess.h>
 #include <linux/delay.h>
 #include <linux/iversion.h>
+#include <linux/miscattr.h>
 #include "ext4_jbd2.h"
 #include "ext4.h"
 #include <linux/fsmap.h>
@@ -341,11 +342,6 @@ static int ext4_ioctl_setflags(struct inode *inode,
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
@@ -456,9 +452,8 @@ static int ext4_ioctl_setflags(struct inode *inode,
 }
 
 #ifdef CONFIG_QUOTA
-static int ext4_ioctl_setproject(struct file *filp, __u32 projid)
+static int ext4_ioctl_setproject(struct inode *inode, __u32 projid)
 {
-	struct inode *inode = file_inode(filp);
 	struct super_block *sb = inode->i_sb;
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	int err, rc;
@@ -542,7 +537,7 @@ static int ext4_ioctl_setproject(struct file *filp, __u32 projid)
 	return err;
 }
 #else
-static int ext4_ioctl_setproject(struct file *filp, __u32 projid)
+static int ext4_ioctl_setproject(struct inode *inode, __u32 projid)
 {
 	if (projid != EXT4_DEF_PROJID)
 		return -EOPNOTSUPP;
@@ -550,56 +545,6 @@ static int ext4_ioctl_setproject(struct file *filp, __u32 projid)
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
@@ -767,15 +712,51 @@ static long ext4_ioctl_group_add(struct file *file,
 	return err;
 }
 
-static void ext4_fill_fsxattr(struct inode *inode, struct fsxattr *fa)
+int ext4_miscattr_get(struct dentry *dentry, struct miscattr *ma)
 {
+	struct inode *inode = d_inode(dentry);
 	struct ext4_inode_info *ei = EXT4_I(inode);
+	u32 flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
 
-	simple_fill_fsxattr(fa, ext4_iflags_to_xflags(ei->i_flags &
-						      EXT4_FL_USER_VISIBLE));
+	if (S_ISREG(inode->i_mode))
+		flags &= ~FS_PROJINHERIT_FL;
 
+	miscattr_fill_flags(ma, flags);
 	if (ext4_has_feature_project(inode->i_sb))
-		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
+		ma->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
+
+	return 0;
+}
+
+int ext4_miscattr_set(struct dentry *dentry, struct miscattr *ma)
+{
+	struct inode *inode = d_inode(dentry);
+	u32 flags = ma->flags;
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
+	err = ext4_ioctl_check_immutable(inode, ma->fsx_projid, flags);
+	if (err)
+		goto out;
+	err = ext4_ioctl_setflags(inode, flags);
+	if (err)
+		goto out;
+	err = ext4_ioctl_setproject(inode, ma->fsx_projid);
+out:
+	ext4_fc_stop_update(inode);
+	return err;
 }
 
 /* So that the fiemap access checks can't overflow on 32 bit machines. */
@@ -813,54 +794,12 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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
@@ -1242,60 +1181,6 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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
 
@@ -1330,12 +1215,6 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	/* These are just misnamed, they actually get/put from/to user an int */
 	switch (cmd) {
-	case FS_IOC32_GETFLAGS:
-		cmd = FS_IOC_GETFLAGS;
-		break;
-	case FS_IOC32_SETFLAGS:
-		cmd = FS_IOC_SETFLAGS;
-		break;
 	case EXT4_IOC32_GETVERSION:
 		cmd = EXT4_IOC_GETVERSION;
 		break;
@@ -1394,8 +1273,6 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case EXT4_IOC_CLEAR_ES_CACHE:
 	case EXT4_IOC_GETSTATE:
 	case EXT4_IOC_GET_ES_CACHE:
-	case FS_IOC_FSGETXATTR:
-	case FS_IOC_FSSETXATTR:
 		break;
 	default:
 		return -ENOIOCTLCMD;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index cf652ba3e74d..76dc27834322 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -4130,6 +4130,8 @@ const struct inode_operations ext4_dir_inode_operations = {
 	.get_acl	= ext4_get_acl,
 	.set_acl	= ext4_set_acl,
 	.fiemap         = ext4_fiemap,
+	.miscattr_get	= ext4_miscattr_get,
+	.miscattr_set	= ext4_miscattr_set,
 };
 
 const struct inode_operations ext4_special_inode_operations = {
-- 
2.26.2

