Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22BB349A73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 20:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhCYTit (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 15:38:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35546 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230325AbhCYTiQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616701096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UYTfJUXxRAzn4/dvbmTGwaVaSFXYAQji9F1/7MmG7j0=;
        b=N/wFMTJfOCx6QStTVMnKWZ0TCzTtD/cUVA9lon2ddWvsKDONGV1xfQBWRpGZMhBqhXdHpf
        e83D1HCXz0qLr1fGOETpK2sl2QYMlxmNr4TPl9yTCKjHo4ZFRomUYfBQBe1gAqJmrXrcHZ
        1pA4ErSmS6eg8od7krmjD+rwEM0TBRc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-Tdxv1lo5OrCuyFkAf9DLZQ-1; Thu, 25 Mar 2021 15:38:14 -0400
X-MC-Unique: Tdxv1lo5OrCuyFkAf9DLZQ-1
Received: by mail-ed1-f72.google.com with SMTP id w16so3201620edc.22
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 12:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UYTfJUXxRAzn4/dvbmTGwaVaSFXYAQji9F1/7MmG7j0=;
        b=ZHhGHYeGJzgBwkwt/V9Y08X0tNei8RkAzzIOv43Bzzw+M+yk0WNpY8Sh+lHg7xkCqv
         nimEp0qXXRPrVaZxPSZzmtLtj+y4OT1VyvkI1gaMwlJDC/ZE+41uw/0nh/f+/oTjCGqq
         dDveWRrh19UF4Jav0Ox14134zyubIpTEbk+JJ4imNi9k6NMBVqZDQ62tsh7lip+xDQYu
         CN3fQK8DUMuycwOdj5KqYoHPOS/4bfy5IgAAKV6jHK0hLlCAPYom5zYiDmeUc7WDHZ77
         FG5LcH3/R1X5QrZxU+taPWnqYL5l6pUWRNBGTiRxSyiJCkvQc1voVUyfMnFJU72KvdSC
         6EKw==
X-Gm-Message-State: AOAM5307CP341Rg29Z6Lw5t6VhQ6+ypqzVgpZjJmVON8YB+kl1bRDS8W
        vejv14xyzkDI1S38812o2ZG7CP1uddUtOpkWhkgU5i6juxLmAlCQNvrCjj4rxWa4cTxS1k5foJa
        US4wfaZnO0gV/LguL0cy26oPk79NcHmGegUGnOGWrFjztIIngDQ751YqX6Eei136hR4Ps5tdq1B
        JSlg==
X-Received: by 2002:a17:906:934c:: with SMTP id p12mr11227997ejw.131.1616701092898;
        Thu, 25 Mar 2021 12:38:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyD+BjtNf+4ajIP8RM58I4wmYWi7tmvRwafaGqZm6yQlyjYox2yCKMqjIfx7XQ6qGZudzjidQ==
X-Received: by 2002:a17:906:934c:: with SMTP id p12mr11227976ejw.131.1616701092706;
        Thu, 25 Mar 2021 12:38:12 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id si7sm2881996ejb.84.2021.03.25.12.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 12:38:12 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v3 14/18] nilfs2: convert to fileattr
Date:   Thu, 25 Mar 2021 20:37:51 +0100
Message-Id: <20210325193755.294925-15-mszeredi@redhat.com>
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
Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/file.c  |  2 ++
 fs/nilfs2/ioctl.c | 61 ++++++++++++++---------------------------------
 fs/nilfs2/namei.c |  2 ++
 fs/nilfs2/nilfs.h |  3 +++
 4 files changed, 25 insertions(+), 43 deletions(-)

diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index e1bd592ce700..7cf765258fda 100644
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -148,6 +148,8 @@ const struct inode_operations nilfs_file_inode_operations = {
 	.setattr	= nilfs_setattr,
 	.permission     = nilfs_permission,
 	.fiemap		= nilfs_fiemap,
+	.fileattr_get	= nilfs_fileattr_get,
+	.fileattr_set	= nilfs_fileattr_set,
 };
 
 /* end of file */
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index b053b40315bf..3fcb9357bbfd 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -16,6 +16,7 @@
 #include <linux/compat.h>	/* compat_ptr() */
 #include <linux/mount.h>	/* mnt_want_write_file(), mnt_drop_write_file() */
 #include <linux/buffer_head.h>
+#include <linux/fileattr.h>
 #include "nilfs.h"
 #include "segment.h"
 #include "bmap.h"
@@ -113,51 +114,39 @@ static int nilfs_ioctl_wrap_copy(struct the_nilfs *nilfs,
 }
 
 /**
- * nilfs_ioctl_getflags - ioctl to support lsattr
+ * nilfs_fileattr_get - ioctl to support lsattr
  */
-static int nilfs_ioctl_getflags(struct inode *inode, void __user *argp)
+int nilfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
-	unsigned int flags = NILFS_I(inode)->i_flags & FS_FL_USER_VISIBLE;
+	struct inode *inode = d_inode(dentry);
 
-	return put_user(flags, (int __user *)argp);
+	fileattr_fill_flags(fa, NILFS_I(inode)->i_flags & FS_FL_USER_VISIBLE);
+
+	return 0;
 }
 
 /**
- * nilfs_ioctl_setflags - ioctl to support chattr
+ * nilfs_fileattr_set - ioctl to support chattr
  */
-static int nilfs_ioctl_setflags(struct inode *inode, struct file *filp,
-				void __user *argp)
+int nilfs_fileattr_set(struct user_namespace *mnt_userns,
+		       struct dentry *dentry, struct fileattr *fa)
 {
+	struct inode *inode = d_inode(dentry);
 	struct nilfs_transaction_info ti;
 	unsigned int flags, oldflags;
 	int ret;
 
-	if (!inode_owner_or_capable(&init_user_ns, inode))
-		return -EACCES;
-
-	if (get_user(flags, (int __user *)argp))
-		return -EFAULT;
-
-	ret = mnt_want_write_file(filp);
-	if (ret)
-		return ret;
-
-	flags = nilfs_mask_flags(inode->i_mode, flags);
-
-	inode_lock(inode);
-
-	oldflags = NILFS_I(inode)->i_flags;
+	if (fileattr_has_fsx(fa))
+		return -EOPNOTSUPP;
 
-	ret = vfs_ioc_setflags_prepare(inode, oldflags, flags);
-	if (ret)
-		goto out;
+	flags = nilfs_mask_flags(inode->i_mode, fa->flags);
 
 	ret = nilfs_transaction_begin(inode->i_sb, &ti, 0);
 	if (ret)
-		goto out;
+		return ret;
 
-	NILFS_I(inode)->i_flags = (oldflags & ~FS_FL_USER_MODIFIABLE) |
-		(flags & FS_FL_USER_MODIFIABLE);
+	oldflags = NILFS_I(inode)->i_flags & ~FS_FL_USER_MODIFIABLE;
+	NILFS_I(inode)->i_flags = oldflags | (flags & FS_FL_USER_MODIFIABLE);
 
 	nilfs_set_inode_flags(inode);
 	inode->i_ctime = current_time(inode);
@@ -165,11 +154,7 @@ static int nilfs_ioctl_setflags(struct inode *inode, struct file *filp,
 		nilfs_set_transaction_flag(NILFS_TI_SYNC);
 
 	nilfs_mark_inode_dirty(inode);
-	ret = nilfs_transaction_commit(inode->i_sb);
-out:
-	inode_unlock(inode);
-	mnt_drop_write_file(filp);
-	return ret;
+	return nilfs_transaction_commit(inode->i_sb);
 }
 
 /**
@@ -1282,10 +1267,6 @@ long nilfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	void __user *argp = (void __user *)arg;
 
 	switch (cmd) {
-	case FS_IOC_GETFLAGS:
-		return nilfs_ioctl_getflags(inode, argp);
-	case FS_IOC_SETFLAGS:
-		return nilfs_ioctl_setflags(inode, filp, argp);
 	case FS_IOC_GETVERSION:
 		return nilfs_ioctl_getversion(inode, argp);
 	case NILFS_IOCTL_CHANGE_CPMODE:
@@ -1331,12 +1312,6 @@ long nilfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 long nilfs_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index ecace5f96a95..189bd1007a2f 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -552,6 +552,8 @@ const struct inode_operations nilfs_dir_inode_operations = {
 	.setattr	= nilfs_setattr,
 	.permission	= nilfs_permission,
 	.fiemap		= nilfs_fiemap,
+	.fileattr_get	= nilfs_fileattr_get,
+	.fileattr_set	= nilfs_fileattr_set,
 };
 
 const struct inode_operations nilfs_special_inode_operations = {
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index c4a45a081ade..60b21b6eeac0 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -243,6 +243,9 @@ extern void nilfs_set_link(struct inode *, struct nilfs_dir_entry *,
 extern int nilfs_sync_file(struct file *, loff_t, loff_t, int);
 
 /* ioctl.c */
+int nilfs_fileattr_get(struct dentry *dentry, struct fileattr *m);
+int nilfs_fileattr_set(struct user_namespace *mnt_userns,
+		       struct dentry *dentry, struct fileattr *fa);
 long nilfs_ioctl(struct file *, unsigned int, unsigned long);
 long nilfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 int nilfs_ioctl_prepare_clean_segments(struct the_nilfs *, struct nilfs_argv *,
-- 
2.30.2

