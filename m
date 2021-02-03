Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7ED630DA30
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 13:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhBCMvH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 07:51:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41330 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230136AbhBCMnU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612356112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IB8EwSgQUWrKKa98bYl3fi+fjuKXVC7Hb/mxBFwooYw=;
        b=XcpDoutbomXBFPN1aYvrbqk30mbDIXQh92/C7v6X2ox/FjVtA+G7tbBT2eqNkQDXF3d7Q8
        eacq7dc2UwtRG1zCf+zHNXWcAjwy9XHmPwNccM8BBl/hJspqZoQC/ZRnfdqkrXd1FrocEf
        XhXqa2pQ4m2EuAx5IoimoE2Ocm+/o/g=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-ewy0tiQAN62r3kuvM9IiGg-1; Wed, 03 Feb 2021 07:41:50 -0500
X-MC-Unique: ewy0tiQAN62r3kuvM9IiGg-1
Received: by mail-ed1-f70.google.com with SMTP id w14so3905467edv.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 04:41:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IB8EwSgQUWrKKa98bYl3fi+fjuKXVC7Hb/mxBFwooYw=;
        b=KqYsp0tNoJHxdCktSqaqm6w4jFlXKuSr1Q5Tc8YFzloXMr6dM9fbU9X9/xuCCVWfyT
         bSeH4n6kwkoeOOhaY4EL8FzPokaZsRuiMMxo+jJE7nqOAgHZBKu3fytrjHmQOXcQ2max
         JUFi86ttM9dNmmuUXU/WYLNT3+wZiMkQ4tsiWx5dXV4ep6b8YKOVHaVMXEmxw+j5tkG+
         +SXBWC/wvOmKiaERnI8UDZFs8BnQlt80zm0NtuwNlmbPJEhw9m7PvRXFopsqlUNFfbvd
         kGBppYavYKH6E1mSWO0AUDcs+SmHHYUF9WRlpcNTd/iz9XbligH0wHhLMLyAoaoXzonC
         77FQ==
X-Gm-Message-State: AOAM533VfsQC+RL8vJyeKqpe1kDoRWIFmrPXDaiB/fjCX9as+RcswWrV
        8V7hH3O2361ir4qEYkfVvx/wfGVRtsFYwAnGhmGcJ8rUyvybUkMyFJGyMfsbzv8Rx1Ep9Q7VR3K
        Qt2qafJnT1MeUy1d8AnCzlE3eD9iBR3Fz5uNEl5dZqBzR11BQvlZR4tU1Kcc+qsb5xV5M1SAcOG
        ZI3w==
X-Received: by 2002:a05:6402:ce:: with SMTP id i14mr2750502edu.42.1612356109182;
        Wed, 03 Feb 2021 04:41:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyd1/QnCpDH091xMGZhhaNFSRrn/VAk33P3Pj47u+uS0FzFA2zXg5aOB7JnyCv+kc9vKwcMZw==
X-Received: by 2002:a05:6402:ce:: with SMTP id i14mr2750490edu.42.1612356109011;
        Wed, 03 Feb 2021 04:41:49 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id u9sm953320ejc.57.2021.02.03.04.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:41:48 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dave Kleikamp <shaggy@kernel.org>
Subject: [PATCH 13/18] jfs: convert to miscattr
Date:   Wed,  3 Feb 2021 13:41:07 +0100
Message-Id: <20210203124112.1182614-14-mszeredi@redhat.com>
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
Cc: Dave Kleikamp <shaggy@kernel.org>
---
 fs/jfs/file.c       |   6 +--
 fs/jfs/ioctl.c      | 104 ++++++++++++++------------------------------
 fs/jfs/jfs_dinode.h |   7 ---
 fs/jfs/jfs_inode.h  |   3 +-
 fs/jfs/namei.c      |   6 +--
 5 files changed, 41 insertions(+), 85 deletions(-)

diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 930d2701f206..cb9c6bea6fff 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -129,6 +129,8 @@ int jfs_setattr(struct dentry *dentry, struct iattr *iattr)
 const struct inode_operations jfs_file_inode_operations = {
 	.listxattr	= jfs_listxattr,
 	.setattr	= jfs_setattr,
+	.miscattr_get	= jfs_miscattr_get,
+	.miscattr_set	= jfs_miscattr_set,
 #ifdef CONFIG_JFS_POSIX_ACL
 	.get_acl	= jfs_get_acl,
 	.set_acl	= jfs_set_acl,
@@ -146,7 +148,5 @@ const struct file_operations jfs_file_operations = {
 	.fsync		= jfs_fsync,
 	.release	= jfs_release,
 	.unlocked_ioctl = jfs_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	= jfs_compat_ioctl,
-#endif
+	.compat_ioctl	= compat_ptr_ioctl,
 };
diff --git a/fs/jfs/ioctl.c b/fs/jfs/ioctl.c
index 10ee0ecca1a8..954216662cbb 100644
--- a/fs/jfs/ioctl.c
+++ b/fs/jfs/ioctl.c
@@ -15,6 +15,7 @@
 #include <linux/blkdev.h>
 #include <asm/current.h>
 #include <linux/uaccess.h>
+#include <linux/miscattr.h>
 
 #include "jfs_filsys.h"
 #include "jfs_debug.h"
@@ -56,69 +57,49 @@ static long jfs_map_ext2(unsigned long flags, int from)
 	return mapped;
 }
 
+int jfs_miscattr_get(struct dentry *dentry, struct miscattr *ma)
+{
+	struct jfs_inode_info *jfs_inode = JFS_IP(d_inode(dentry));
+	unsigned int flags = jfs_inode->mode2 & JFS_FL_USER_VISIBLE;
 
-long jfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+	miscattr_fill_flags(ma, jfs_map_ext2(flags, 0));
+
+	return 0;
+}
+
+int jfs_miscattr_set(struct dentry *dentry, struct miscattr *ma)
 {
-	struct inode *inode = file_inode(filp);
+	struct inode *inode = d_inode(dentry);
 	struct jfs_inode_info *jfs_inode = JFS_IP(inode);
 	unsigned int flags;
 
-	switch (cmd) {
-	case JFS_IOC_GETFLAGS:
-		flags = jfs_inode->mode2 & JFS_FL_USER_VISIBLE;
-		flags = jfs_map_ext2(flags, 0);
-		return put_user(flags, (int __user *) arg);
-	case JFS_IOC_SETFLAGS: {
-		unsigned int oldflags;
-		int err;
-
-		err = mnt_want_write_file(filp);
-		if (err)
-			return err;
-
-		if (!inode_owner_or_capable(inode)) {
-			err = -EACCES;
-			goto setflags_out;
-		}
-		if (get_user(flags, (int __user *) arg)) {
-			err = -EFAULT;
-			goto setflags_out;
-		}
+	if (miscattr_has_xattr(ma))
+		return -EOPNOTSUPP;
 
-		flags = jfs_map_ext2(flags, 1);
-		if (!S_ISDIR(inode->i_mode))
-			flags &= ~JFS_DIRSYNC_FL;
+	flags = jfs_map_ext2(ma->flags, 1);
+	if (!S_ISDIR(inode->i_mode))
+		flags &= ~JFS_DIRSYNC_FL;
 
-		/* Is it quota file? Do not allow user to mess with it */
-		if (IS_NOQUOTA(inode)) {
-			err = -EPERM;
-			goto setflags_out;
-		}
+	/* Is it quota file? Do not allow user to mess with it */
+	if (IS_NOQUOTA(inode))
+		return -EPERM;
 
-		/* Lock against other parallel changes of flags */
-		inode_lock(inode);
+	flags = flags & JFS_FL_USER_MODIFIABLE;
+	flags |= jfs_inode->mode2 & ~JFS_FL_USER_MODIFIABLE;
+	jfs_inode->mode2 = flags;
 
-		oldflags = jfs_map_ext2(jfs_inode->mode2 & JFS_FL_USER_VISIBLE,
-					0);
-		err = vfs_ioc_setflags_prepare(inode, oldflags, flags);
-		if (err) {
-			inode_unlock(inode);
-			goto setflags_out;
-		}
+	jfs_set_inode_flags(inode);
+	inode->i_ctime = current_time(inode);
+	mark_inode_dirty(inode);
 
-		flags = flags & JFS_FL_USER_MODIFIABLE;
-		flags |= jfs_inode->mode2 & ~JFS_FL_USER_MODIFIABLE;
-		jfs_inode->mode2 = flags;
-
-		jfs_set_inode_flags(inode);
-		inode_unlock(inode);
-		inode->i_ctime = current_time(inode);
-		mark_inode_dirty(inode);
-setflags_out:
-		mnt_drop_write_file(filp);
-		return err;
-	}
+	return 0;
+}
+
+long jfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
 
+	switch (cmd) {
 	case FITRIM:
 	{
 		struct super_block *sb = inode->i_sb;
@@ -156,22 +137,3 @@ long jfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return -ENOTTY;
 	}
 }
-
-#ifdef CONFIG_COMPAT
-long jfs_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
-{
-	/* While these ioctl numbers defined with 'long' and have different
-	 * numbers than the 64bit ABI,
-	 * the actual implementation only deals with ints and is compatible.
-	 */
-	switch (cmd) {
-	case JFS_IOC_GETFLAGS32:
-		cmd = JFS_IOC_GETFLAGS;
-		break;
-	case JFS_IOC_SETFLAGS32:
-		cmd = JFS_IOC_SETFLAGS;
-		break;
-	}
-	return jfs_ioctl(filp, cmd, arg);
-}
-#endif
diff --git a/fs/jfs/jfs_dinode.h b/fs/jfs/jfs_dinode.h
index 5fa9fd594115..d6af79e94263 100644
--- a/fs/jfs/jfs_dinode.h
+++ b/fs/jfs/jfs_dinode.h
@@ -160,11 +160,4 @@ struct dinode {
 #define JFS_FL_USER_MODIFIABLE	0x03F80000
 #define JFS_FL_INHERIT		0x03C80000
 
-/* These are identical to EXT[23]_IOC_GETFLAGS/SETFLAGS */
-#define JFS_IOC_GETFLAGS	_IOR('f', 1, long)
-#define JFS_IOC_SETFLAGS	_IOW('f', 2, long)
-
-#define JFS_IOC_GETFLAGS32	_IOR('f', 1, int)
-#define JFS_IOC_SETFLAGS32	_IOW('f', 2, int)
-
 #endif /*_H_JFS_DINODE */
diff --git a/fs/jfs/jfs_inode.h b/fs/jfs/jfs_inode.h
index 70a0d12e427e..bfacad2b18e0 100644
--- a/fs/jfs/jfs_inode.h
+++ b/fs/jfs/jfs_inode.h
@@ -9,8 +9,9 @@ struct fid;
 
 extern struct inode *ialloc(struct inode *, umode_t);
 extern int jfs_fsync(struct file *, loff_t, loff_t, int);
+extern int jfs_miscattr_get(struct dentry *dentry, struct miscattr *ma);
+extern int jfs_miscattr_set(struct dentry *dentry, struct miscattr *ma);
 extern long jfs_ioctl(struct file *, unsigned int, unsigned long);
-extern long jfs_compat_ioctl(struct file *, unsigned int, unsigned long);
 extern struct inode *jfs_iget(struct super_block *, unsigned long);
 extern int jfs_commit_inode(struct inode *, int);
 extern int jfs_write_inode(struct inode *, struct writeback_control *);
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 7a55d14cc1af..2a45b7c51721 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -1521,6 +1521,8 @@ const struct inode_operations jfs_dir_inode_operations = {
 	.rename		= jfs_rename,
 	.listxattr	= jfs_listxattr,
 	.setattr	= jfs_setattr,
+	.miscattr_get	= jfs_miscattr_get,
+	.miscattr_set	= jfs_miscattr_set,
 #ifdef CONFIG_JFS_POSIX_ACL
 	.get_acl	= jfs_get_acl,
 	.set_acl	= jfs_set_acl,
@@ -1532,9 +1534,7 @@ const struct file_operations jfs_dir_operations = {
 	.iterate	= jfs_readdir,
 	.fsync		= jfs_fsync,
 	.unlocked_ioctl = jfs_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	= jfs_compat_ioctl,
-#endif
+	.compat_ioctl	= compat_ptr_ioctl,
 	.llseek		= generic_file_llseek,
 };
 
-- 
2.26.2

