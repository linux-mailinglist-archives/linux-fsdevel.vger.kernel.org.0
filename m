Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CC0349A72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 20:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhCYTit (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 15:38:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59386 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230322AbhCYTiQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616701095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wzCcUiqivuO+k929hnKrK45UEPb6Rt+2c6RvSJhKJOA=;
        b=B+JPTNq0qZO5Hw20c8AlwYMgbWON9o6f55lJqdqVT2Khs6QLKownj3hp8gpXgVD4KI0Gfh
        Dn5hmz0Q04JJ85JGG1EZ5UtyQeRPGkiuM91R10npLFRuUw0jlpvGqr9l3vSubWKEjrjsIb
        jI+61pit9ik4sQXpCcnncgpGyCbnNEs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-IbJgH4D7P_qKTEntBmbIHg-1; Thu, 25 Mar 2021 15:38:13 -0400
X-MC-Unique: IbJgH4D7P_qKTEntBmbIHg-1
Received: by mail-ej1-f70.google.com with SMTP id e13so3054105ejd.21
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 12:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wzCcUiqivuO+k929hnKrK45UEPb6Rt+2c6RvSJhKJOA=;
        b=AHSJh+4+wuBDjbNUaRRhJDgcOZFz8F6GxKoq/l9q6izpxMgJRXz2QVRyLQN5HSkpEy
         WJvhZ/1TRPOYmGVpPv7G79w5hkJC84SzsC3vJLIyvFboOkZawNe7oRt7eqEcUn4jyCzs
         29nFQY+tcXF8i3nNZU0jOP5P6D2H4WWdv+ZA5vFqoHfcB2VwHtX7AQV6epPS4U+H7ofx
         eP2g9NxVgyzKMu7ZNgyLW0FIXzzZvdIWzWD89UFXuY3LIASI+O+N8He8T1tBWjuc8JRz
         7nCSuGHeg3u8HIUOuQQ0ljDV3RGi8uq1h1HPYgDOOLbou6wEojLlQo/v0i5Xqx+/PViz
         MZiA==
X-Gm-Message-State: AOAM531TKUUL6r6qR/ohRrloxySZb7sFQipW//3Sjldd4wY73daKWDgL
        vDWJUiKPZSYHNjc8qqVVB+oMq3I1xETesBpBBSb/fs+GI6dIJBTiq4sKELUBaDW5zHRzKRLt6Bp
        bazopwCOtgNHyk5fqRWggqDbh6p1vSlyZEB7b/5seEarAaEF15Pb9Tm6O23FzvQ4qOmnfd3F6FS
        EYXA==
X-Received: by 2002:a17:906:1a4b:: with SMTP id j11mr11407417ejf.55.1616701091859;
        Thu, 25 Mar 2021 12:38:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxM7Wl2oqyRnlBjo34GjO/HbYyKTke3TuqEUQtc4DfPbUEyLxOPlu8uskNDtOTGecu348L5Kg==
X-Received: by 2002:a17:906:1a4b:: with SMTP id j11mr11407393ejf.55.1616701091560;
        Thu, 25 Mar 2021 12:38:11 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id si7sm2881996ejb.84.2021.03.25.12.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 12:38:11 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>
Subject: [PATCH v3 13/18] jfs: convert to fileattr
Date:   Thu, 25 Mar 2021 20:37:50 +0100
Message-Id: <20210325193755.294925-14-mszeredi@redhat.com>
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
Cc: Dave Kleikamp <shaggy@kernel.org>
---
 fs/jfs/file.c       |   6 +--
 fs/jfs/ioctl.c      | 105 ++++++++++++++------------------------------
 fs/jfs/jfs_dinode.h |   7 ---
 fs/jfs/jfs_inode.h  |   4 +-
 fs/jfs/namei.c      |   6 +--
 5 files changed, 43 insertions(+), 85 deletions(-)

diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 28b70e7c7dd4..1d732fd223d4 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -130,6 +130,8 @@ int jfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 const struct inode_operations jfs_file_inode_operations = {
 	.listxattr	= jfs_listxattr,
 	.setattr	= jfs_setattr,
+	.fileattr_get	= jfs_fileattr_get,
+	.fileattr_set	= jfs_fileattr_set,
 #ifdef CONFIG_JFS_POSIX_ACL
 	.get_acl	= jfs_get_acl,
 	.set_acl	= jfs_set_acl,
@@ -147,7 +149,5 @@ const struct file_operations jfs_file_operations = {
 	.fsync		= jfs_fsync,
 	.release	= jfs_release,
 	.unlocked_ioctl = jfs_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	= jfs_compat_ioctl,
-#endif
+	.compat_ioctl	= compat_ptr_ioctl,
 };
diff --git a/fs/jfs/ioctl.c b/fs/jfs/ioctl.c
index 2581d4db58ff..a7c36dac9ced 100644
--- a/fs/jfs/ioctl.c
+++ b/fs/jfs/ioctl.c
@@ -15,6 +15,7 @@
 #include <linux/blkdev.h>
 #include <asm/current.h>
 #include <linux/uaccess.h>
+#include <linux/fileattr.h>
 
 #include "jfs_filsys.h"
 #include "jfs_debug.h"
@@ -56,69 +57,50 @@ static long jfs_map_ext2(unsigned long flags, int from)
 	return mapped;
 }
 
+int jfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+{
+	struct jfs_inode_info *jfs_inode = JFS_IP(d_inode(dentry));
+	unsigned int flags = jfs_inode->mode2 & JFS_FL_USER_VISIBLE;
 
-long jfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+	fileattr_fill_flags(fa, jfs_map_ext2(flags, 0));
+
+	return 0;
+}
+
+int jfs_fileattr_set(struct user_namespace *mnt_userns,
+		     struct dentry *dentry, struct fileattr *fa)
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
-		if (!inode_owner_or_capable(&init_user_ns, inode)) {
-			err = -EACCES;
-			goto setflags_out;
-		}
-		if (get_user(flags, (int __user *) arg)) {
-			err = -EFAULT;
-			goto setflags_out;
-		}
+	if (fileattr_has_fsx(fa))
+		return -EOPNOTSUPP;
 
-		flags = jfs_map_ext2(flags, 1);
-		if (!S_ISDIR(inode->i_mode))
-			flags &= ~JFS_DIRSYNC_FL;
+	flags = jfs_map_ext2(fa->flags, 1);
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
@@ -156,22 +138,3 @@ long jfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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
index 01daa0cb0ae5..7de961a81862 100644
--- a/fs/jfs/jfs_inode.h
+++ b/fs/jfs/jfs_inode.h
@@ -9,8 +9,10 @@ struct fid;
 
 extern struct inode *ialloc(struct inode *, umode_t);
 extern int jfs_fsync(struct file *, loff_t, loff_t, int);
+extern int jfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+extern int jfs_fileattr_set(struct user_namespace *mnt_userns,
+			    struct dentry *dentry, struct fileattr *fa);
 extern long jfs_ioctl(struct file *, unsigned int, unsigned long);
-extern long jfs_compat_ioctl(struct file *, unsigned int, unsigned long);
 extern struct inode *jfs_iget(struct super_block *, unsigned long);
 extern int jfs_commit_inode(struct inode *, int);
 extern int jfs_write_inode(struct inode *, struct writeback_control *);
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 9abed0d750e5..9db4f5789c0e 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -1522,6 +1522,8 @@ const struct inode_operations jfs_dir_inode_operations = {
 	.rename		= jfs_rename,
 	.listxattr	= jfs_listxattr,
 	.setattr	= jfs_setattr,
+	.fileattr_get	= jfs_fileattr_get,
+	.fileattr_set	= jfs_fileattr_set,
 #ifdef CONFIG_JFS_POSIX_ACL
 	.get_acl	= jfs_get_acl,
 	.set_acl	= jfs_set_acl,
@@ -1533,9 +1535,7 @@ const struct file_operations jfs_dir_operations = {
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
2.30.2

