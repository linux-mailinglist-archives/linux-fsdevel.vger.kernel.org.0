Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5A8344804
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 15:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhCVOuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 10:50:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231233AbhCVOtj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616424578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gR1g+wrmq8CNGMHC9HF+FPFW3/Mbla9HvLt7skHdCM8=;
        b=DI1amX7CsIOHlo/uCx0aTR2XKK882d9bw7/n6jrPgQcPrAAYb9JEImj3SuA/fzKorA7xql
        7yXgLsR3paaNLmyHB+GEjf8AagjzpRSchbcNIxTBPYT1nLdlcw3UclMzxgkWthWJIbmBU+
        SMsf3redvyy2zIRObWcMKdTsB16SG6o=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-x9FNFIeFOH2yCrj8jb-lxQ-1; Mon, 22 Mar 2021 10:49:37 -0400
X-MC-Unique: x9FNFIeFOH2yCrj8jb-lxQ-1
Received: by mail-ed1-f71.google.com with SMTP id o15so27615028edv.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 07:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gR1g+wrmq8CNGMHC9HF+FPFW3/Mbla9HvLt7skHdCM8=;
        b=uhRFf9A7cf1i7ySqXaFRrdu1tuDXbPN8Ufh6KQRBvolwJhhJTeJIdZEdobw87gyFzi
         86xWIxMzMcNf9D2mVRfCq6N4u1EiEUwCb4cb3Lwh+0nXNb0Btwuv72sM/hssO3ZN+vKu
         Pas3XZpy2Z/mHDB1fbGvYPldHPMB1nPUGSiBC3pJAeBqjnVgM0aPbMtJLe+CtKs1ynpd
         IR4lG+67tx83H/FcTxPOyp8Cx9pQSReo3YXp48A/Q/+sgxFkQTzkrvZNW/Tb6itwYTMC
         pup6dpAFTlhSLxIfd7ALfmWgkpY8tVmzmyBhh6Y+V08yCrOAbWAde5Fe9Ibyvp1SaRPU
         1L+A==
X-Gm-Message-State: AOAM533ncqjmKEDTKmuuZ6g1GrL0lqgBWqni4GF1RgA+nlS0c9ks5ah6
        vLAb7r6V0cbRzfQ+LiymaPCD/KlDWmd3xRCG6u7Cf1NgSTQamLZSmisMg0lkQkWkCg/Z2J2kg3b
        PQTO93Qy/ApBMRQ6vFKXp30zvbt05qRcc+rNSn92GY9OdzNRp66JJXVU0cU7BM+CmTDojRulMwm
        a82g==
X-Received: by 2002:a17:907:e88:: with SMTP id ho8mr99793ejc.199.1616424575577;
        Mon, 22 Mar 2021 07:49:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztIBTmpouYG8EVNmhdgk36jXeOwcmhhqjfU++DaRsUQo8mOQ4U/Zmdf5dp8EDtGvu++grrMg==
X-Received: by 2002:a17:907:e88:: with SMTP id ho8mr99776ejc.199.1616424575417;
        Mon, 22 Mar 2021 07:49:35 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id r4sm9793117ejd.125.2021.03.22.07.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:49:34 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v2 14/18] nilfs2: convert to miscattr
Date:   Mon, 22 Mar 2021 15:49:12 +0100
Message-Id: <20210322144916.137245-15-mszeredi@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210322144916.137245-1-mszeredi@redhat.com>
References: <20210322144916.137245-1-mszeredi@redhat.com>
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
 fs/nilfs2/ioctl.c | 61 ++++++++++++++---------------------------------
 fs/nilfs2/namei.c |  2 ++
 fs/nilfs2/nilfs.h |  3 +++
 4 files changed, 25 insertions(+), 43 deletions(-)

diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index e1bd592ce700..e2716ce4b95e 100644
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -148,6 +148,8 @@ const struct inode_operations nilfs_file_inode_operations = {
 	.setattr	= nilfs_setattr,
 	.permission     = nilfs_permission,
 	.fiemap		= nilfs_fiemap,
+	.miscattr_get	= nilfs_miscattr_get,
+	.miscattr_set	= nilfs_miscattr_set,
 };
 
 /* end of file */
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index b053b40315bf..4bb5f09b6efa 100644
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
@@ -113,51 +114,39 @@ static int nilfs_ioctl_wrap_copy(struct the_nilfs *nilfs,
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
+int nilfs_miscattr_set(struct user_namespace *mnt_userns,
+		       struct dentry *dentry, struct miscattr *ma)
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
index ecace5f96a95..5ed4b824a8fa 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -552,6 +552,8 @@ const struct inode_operations nilfs_dir_inode_operations = {
 	.setattr	= nilfs_setattr,
 	.permission	= nilfs_permission,
 	.fiemap		= nilfs_fiemap,
+	.miscattr_get	= nilfs_miscattr_get,
+	.miscattr_set	= nilfs_miscattr_set,
 };
 
 const struct inode_operations nilfs_special_inode_operations = {
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index c4a45a081ade..03184ea11287 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -243,6 +243,9 @@ extern void nilfs_set_link(struct inode *, struct nilfs_dir_entry *,
 extern int nilfs_sync_file(struct file *, loff_t, loff_t, int);
 
 /* ioctl.c */
+int nilfs_miscattr_get(struct dentry *dentry, struct miscattr *m);
+int nilfs_miscattr_set(struct user_namespace *mnt_userns,
+		       struct dentry *dentry, struct miscattr *ma);
 long nilfs_ioctl(struct file *, unsigned int, unsigned long);
 long nilfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 int nilfs_ioctl_prepare_clean_segments(struct the_nilfs *, struct nilfs_argv *,
-- 
2.30.2

