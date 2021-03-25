Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCA6349A69
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 20:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhCYTim (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 15:38:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24907 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230260AbhCYTiI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616701088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SfY0z2dyuWV5OkbnCJF2jdzX6hJ3uBxTOX5BsnnHzYI=;
        b=QrJJW3F4HpnIA0H9dT1FN0um6tBReZte6LehbYkZVklHkpDdCge2EWb/iTgaLj5rpQK0Qu
        19qZdgQakF/a0aaAlhZhRK10OTIgeCQK3+t+AhIDTwBHlWIYfspCZTDw9BaWfjHoGwjH5A
        PD2waSgOSKrYx3fSqjZyAHHcVVt/218=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-iTi_AGXDOtSqPuHUg6QV5g-1; Thu, 25 Mar 2021 15:38:05 -0400
X-MC-Unique: iTi_AGXDOtSqPuHUg6QV5g-1
Received: by mail-ej1-f71.google.com with SMTP id li22so3082522ejb.18
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 12:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SfY0z2dyuWV5OkbnCJF2jdzX6hJ3uBxTOX5BsnnHzYI=;
        b=X63cLBpVU9bp43tZeiwYhB8M7IIbJAdR5hAUC3FqkItkqHZZYG+XLgSMrlBe/gfMXy
         o9BchXhZzf1gT/OCL+aX3Afv3DYqP/C+0luNVrQqHdh0EEvSsvp0stLWY47MgOkC9dZL
         TXCjZhQT/WuQht0U0U8RFBFYdgyb+NrQ70hluU16iecr9h4k29bPHUHwppzsyJ165jNa
         a9Lr4b1pEIvYdIYthw2eWUqUopQUmFlGloKru97U3mBOA7rjYHLK6jCFMLQYAbDshdiy
         F2b4xOpdRQdzw0BycRoLkVQdJVNM2dF+kIs5LA6VsKoUYcyOpXCqdZtHqQBr2tWyXgYc
         Vcpg==
X-Gm-Message-State: AOAM5339DP23khmBaPgD9paYDOgaF88FxJRiuEVqkR3yV7+5Ejj/+/T4
        EaC4ILlgl7ddYSF54/8e3o9Qv+PJ71I+/AQTwbHODVuCSvv/054ndiLzHw/cAJWn7dzx6hDdsJx
        V4spxfvG02mdc0JHfGs67olKD6xEfPbqX/CSzE029YI60JuTFIgIUu/Hx5Se12sE6XxW2g+wcFH
        EW6g==
X-Received: by 2002:a17:906:5607:: with SMTP id f7mr11031885ejq.262.1616701084259;
        Thu, 25 Mar 2021 12:38:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMZe98Ce0Tu9vIMEMjZX2e7clAsWQZr2GTed8wrRVZNbbidX9MKw61PjL1CnFMjwREX4ebFA==
X-Received: by 2002:a17:906:5607:: with SMTP id f7mr11031860ejq.262.1616701083990;
        Thu, 25 Mar 2021 12:38:03 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id si7sm2881996ejb.84.2021.03.25.12.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 12:38:03 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH v3 06/18] ext4: convert to fileattr
Date:   Thu, 25 Mar 2021 20:37:43 +0100
Message-Id: <20210325193755.294925-7-mszeredi@redhat.com>
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
Cc: "Theodore Ts'o" <tytso@mit.edu>
---
 fs/ext4/ext4.h  |  12 +--
 fs/ext4/file.c  |   2 +
 fs/ext4/ioctl.c | 208 ++++++++++--------------------------------------
 fs/ext4/namei.c |   2 +
 4 files changed, 50 insertions(+), 174 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 826a56e3bbd2..18f021c988a1 100644
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
@@ -2928,6 +2919,9 @@ extern int ext4_ind_remove_space(handle_t *handle, struct inode *inode,
 /* ioctl.c */
 extern long ext4_ioctl(struct file *, unsigned int, unsigned long);
 extern long ext4_compat_ioctl(struct file *, unsigned int, unsigned long);
+int ext4_fileattr_set(struct user_namespace *mnt_userns,
+		      struct dentry *dentry, struct fileattr *fa);
+int ext4_fileattr_get(struct dentry *dentry, struct fileattr *fa);
 extern void ext4_reset_inode_seed(struct inode *inode);
 
 /* migrate.c */
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 194f5d00fa32..5332dd3ea7e2 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -919,5 +919,7 @@ const struct inode_operations ext4_file_inode_operations = {
 	.get_acl	= ext4_get_acl,
 	.set_acl	= ext4_set_acl,
 	.fiemap		= ext4_fiemap,
+	.fileattr_get	= ext4_fileattr_get,
+	.fileattr_set	= ext4_fileattr_set,
 };
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index a2cf35066f46..e9b0a1fa2ba8 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -20,6 +20,7 @@
 #include <linux/uaccess.h>
 #include <linux/delay.h>
 #include <linux/iversion.h>
+#include <linux/fileattr.h>
 #include "ext4_jbd2.h"
 #include "ext4.h"
 #include <linux/fsmap.h>
@@ -344,11 +345,6 @@ static int ext4_ioctl_setflags(struct inode *inode,
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
@@ -459,9 +455,8 @@ static int ext4_ioctl_setflags(struct inode *inode,
 }
 
 #ifdef CONFIG_QUOTA
-static int ext4_ioctl_setproject(struct file *filp, __u32 projid)
+static int ext4_ioctl_setproject(struct inode *inode, __u32 projid)
 {
-	struct inode *inode = file_inode(filp);
 	struct super_block *sb = inode->i_sb;
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	int err, rc;
@@ -545,7 +540,7 @@ static int ext4_ioctl_setproject(struct file *filp, __u32 projid)
 	return err;
 }
 #else
-static int ext4_ioctl_setproject(struct file *filp, __u32 projid)
+static int ext4_ioctl_setproject(struct inode *inode, __u32 projid)
 {
 	if (projid != EXT4_DEF_PROJID)
 		return -EOPNOTSUPP;
@@ -553,56 +548,6 @@ static int ext4_ioctl_setproject(struct file *filp, __u32 projid)
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
@@ -770,15 +715,52 @@ static long ext4_ioctl_group_add(struct file *file,
 	return err;
 }
 
-static void ext4_fill_fsxattr(struct inode *inode, struct fsxattr *fa)
+int ext4_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
+	struct inode *inode = d_inode(dentry);
 	struct ext4_inode_info *ei = EXT4_I(inode);
+	u32 flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
 
-	simple_fill_fsxattr(fa, ext4_iflags_to_xflags(ei->i_flags &
-						      EXT4_FL_USER_VISIBLE));
+	if (S_ISREG(inode->i_mode))
+		flags &= ~FS_PROJINHERIT_FL;
 
+	fileattr_fill_flags(fa, flags);
 	if (ext4_has_feature_project(inode->i_sb))
 		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
+
+	return 0;
+}
+
+int ext4_fileattr_set(struct user_namespace *mnt_userns,
+		      struct dentry *dentry, struct fileattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	u32 flags = fa->flags;
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
@@ -816,55 +798,13 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 	struct super_block *sb = inode->i_sb;
-	struct ext4_inode_info *ei = EXT4_I(inode);
 	struct user_namespace *mnt_userns = file_mnt_user_ns(filp);
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
-		if (!inode_owner_or_capable(mnt_userns, inode))
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
@@ -1246,60 +1186,6 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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
-		if (!inode_owner_or_capable(mnt_userns, inode))
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
 
@@ -1340,12 +1226,6 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
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
@@ -1405,8 +1285,6 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case EXT4_IOC_CLEAR_ES_CACHE:
 	case EXT4_IOC_GETSTATE:
 	case EXT4_IOC_GET_ES_CACHE:
-	case FS_IOC_FSGETXATTR:
-	case FS_IOC_FSSETXATTR:
 		break;
 	default:
 		return -ENOIOCTLCMD;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 883e2a7cd4ab..a37a19fabee4 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -4172,6 +4172,8 @@ const struct inode_operations ext4_dir_inode_operations = {
 	.get_acl	= ext4_get_acl,
 	.set_acl	= ext4_set_acl,
 	.fiemap         = ext4_fiemap,
+	.fileattr_get	= ext4_fileattr_get,
+	.fileattr_set	= ext4_fileattr_set,
 };
 
 const struct inode_operations ext4_special_inode_operations = {
-- 
2.30.2

