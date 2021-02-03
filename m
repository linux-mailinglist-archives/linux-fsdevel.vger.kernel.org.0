Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C592730DA2D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 13:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhBCMup (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 07:50:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38411 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231197AbhBCMnV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612356113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/dmWSSooKQGo/NJTB8vzC8us6mTc97PV2y1ybwSuu/I=;
        b=hlpDl+I0iodKGauUctV1BxymMIx6DpSo7jC6xlsEAGVSVkN4q4jLHEJ4tqEX9u5IUrSncH
        vN+Kc8fxxospHHiWTPRvTXCJDRm8XbBLkhvfLEhVFfb7mZG/Sm8w4DP3y4oFdqkN7Rb7cM
        qDna1ypQsA3/lMhPb4+3uRZylTgfouo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-27dRIrkmPeKua7cXmOzKHA-1; Wed, 03 Feb 2021 07:41:52 -0500
X-MC-Unique: 27dRIrkmPeKua7cXmOzKHA-1
Received: by mail-ed1-f71.google.com with SMTP id o8so11471131edh.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 04:41:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/dmWSSooKQGo/NJTB8vzC8us6mTc97PV2y1ybwSuu/I=;
        b=m5DE5XJhzYBeuCwz+G54nVWDH2d3VneOSYLxihS5Qrd7qhnnHi6bVfVFQWXKsoHkjG
         5N8O7dOxcdcoOUctSMC33ChOJsVM4aXny60ZpFN7tm+zrBMGPCOnRk+fW9WM01WAHBsN
         Oi2BkpUtn7JPy0paYzZ8m6NpKCIa6vBJyI/4u3NX7wwI3B8P7WO0qp+n2gKmVhK25xEh
         nqauevk6qhearj0HU9/XxKCnU2mYO5GuU24clDzXGuHcsrMfMIHuiLN3/E/kcsG8xHS8
         OZlvC2WVEVnPMhcgpZBt+8ehrYAx/KiHglgNYXk4vCvSjgJzp40oJCX+w0eAqtoHU579
         I1IQ==
X-Gm-Message-State: AOAM530a9Z5nKU36BxYa/0cCYoNy+mOM84Tg5pB2nyWCsnvGe9pOToA7
        Hz8E46fwHWMU26zyWlksIi8IBrhko7kti+m78ef7tQWO+vI022xO+C2nxqXUNpMwasH2zcm5tW5
        zORilM6wr9GVJFL1PAe9NjsEeDQqmm+EOj0ogQSRsph6mXH2U5wkMRWXrhS0LoL161zTONMYS1X
        QusA==
X-Received: by 2002:a17:906:5653:: with SMTP id v19mr734361ejr.481.1612356110430;
        Wed, 03 Feb 2021 04:41:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyp3mVOy88KhDj4CVHOHjZSTUmpsWJVd7ROAxiB/XMWYqYET3EkX7zGbee2brMaEbtuqA0AKw==
X-Received: by 2002:a17:906:5653:: with SMTP id v19mr734339ejr.481.1612356110220;
        Wed, 03 Feb 2021 04:41:50 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id u9sm953320ejc.57.2021.02.03.04.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:41:49 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH 14/18] nilfs2: convert to miscattr
Date:   Wed,  3 Feb 2021 13:41:08 +0100
Message-Id: <20210203124112.1182614-15-mszeredi@redhat.com>
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
Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/file.c  |  2 ++
 fs/nilfs2/ioctl.c | 60 ++++++++++++++---------------------------------
 fs/nilfs2/namei.c |  2 ++
 fs/nilfs2/nilfs.h |  2 ++
 4 files changed, 23 insertions(+), 43 deletions(-)

diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index 64bc81363c6c..2a9eefd12098 100644
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -147,6 +147,8 @@ const struct inode_operations nilfs_file_inode_operations = {
 	.setattr	= nilfs_setattr,
 	.permission     = nilfs_permission,
 	.fiemap		= nilfs_fiemap,
+	.miscattr_get	= nilfs_miscattr_get,
+	.miscattr_set	= nilfs_miscattr_set,
 };
 
 /* end of file */
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index 07d26f61f22a..571c48d8ab2e 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -16,6 +16,7 @@
 #include <linux/compat.h>	/* compat_ptr() */
 #include <linux/mount.h>	/* mnt_want_write_file(), mnt_drop_write_file() */
 #include <linux/buffer_head.h>
+#include <linux/miscattr.h>
 #include "nilfs.h"
 #include "segment.h"
 #include "bmap.h"
@@ -113,51 +114,38 @@ static int nilfs_ioctl_wrap_copy(struct the_nilfs *nilfs,
 }
 
 /**
- * nilfs_ioctl_getflags - ioctl to support lsattr
+ * nilfs_miscattr_get - ioctl to support lsattr
  */
-static int nilfs_ioctl_getflags(struct inode *inode, void __user *argp)
+int nilfs_miscattr_get(struct dentry *dentry, struct miscattr *ma)
 {
-	unsigned int flags = NILFS_I(inode)->i_flags & FS_FL_USER_VISIBLE;
+	struct inode *inode = d_inode(dentry);
 
-	return put_user(flags, (int __user *)argp);
+	miscattr_fill_flags(ma, NILFS_I(inode)->i_flags & FS_FL_USER_VISIBLE);
+
+	return 0;
 }
 
 /**
- * nilfs_ioctl_setflags - ioctl to support chattr
+ * nilfs_miscattr_set - ioctl to support chattr
  */
-static int nilfs_ioctl_setflags(struct inode *inode, struct file *filp,
-				void __user *argp)
+int nilfs_miscattr_set(struct dentry *dentry, struct miscattr *ma)
 {
+	struct inode *inode = d_inode(dentry);
 	struct nilfs_transaction_info ti;
 	unsigned int flags, oldflags;
 	int ret;
 
-	if (!inode_owner_or_capable(inode))
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
+	if (miscattr_has_xattr(ma))
+		return -EOPNOTSUPP;
 
-	ret = vfs_ioc_setflags_prepare(inode, oldflags, flags);
-	if (ret)
-		goto out;
+	flags = nilfs_mask_flags(inode->i_mode, ma->flags);
 
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
@@ -165,11 +153,7 @@ static int nilfs_ioctl_setflags(struct inode *inode, struct file *filp,
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
@@ -1282,10 +1266,6 @@ long nilfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	void __user *argp = (void __user *)arg;
 
 	switch (cmd) {
-	case FS_IOC_GETFLAGS:
-		return nilfs_ioctl_getflags(inode, argp);
-	case FS_IOC_SETFLAGS:
-		return nilfs_ioctl_setflags(inode, filp, argp);
 	case FS_IOC_GETVERSION:
 		return nilfs_ioctl_getversion(inode, argp);
 	case NILFS_IOCTL_CHANGE_CPMODE:
@@ -1331,12 +1311,6 @@ long nilfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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
index a6ec7961d4f5..ba32275fc999 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -549,6 +549,8 @@ const struct inode_operations nilfs_dir_inode_operations = {
 	.setattr	= nilfs_setattr,
 	.permission	= nilfs_permission,
 	.fiemap		= nilfs_fiemap,
+	.miscattr_get	= nilfs_miscattr_get,
+	.miscattr_set	= nilfs_miscattr_set,
 };
 
 const struct inode_operations nilfs_special_inode_operations = {
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index f8450ee3fd06..b642a730bdbd 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -243,6 +243,8 @@ extern void nilfs_set_link(struct inode *, struct nilfs_dir_entry *,
 extern int nilfs_sync_file(struct file *, loff_t, loff_t, int);
 
 /* ioctl.c */
+int nilfs_miscattr_get(struct dentry *dentry, struct miscattr *m);
+int nilfs_miscattr_set(struct dentry *dentry, struct miscattr *ma);
 long nilfs_ioctl(struct file *, unsigned int, unsigned long);
 long nilfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 int nilfs_ioctl_prepare_clean_segments(struct the_nilfs *, struct nilfs_argv *,
-- 
2.26.2

