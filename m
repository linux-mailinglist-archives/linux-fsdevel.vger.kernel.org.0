Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059A8349A7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 20:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhCYTiv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 15:38:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22578 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230337AbhCYTiV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616701100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/7NIBk6La/dqb6C44uocZQB5NEP7IgsPWWcJ4ROLNwg=;
        b=H3aI0cKL8U5EEi3yg5yfTym9k3gu9rt7M/AZDL0dKDEJOicWL9pHZWMn5KKbXCbW5qgLJI
        wNIbI8mCkHiuEVFDjuA8KVIlfAaEJ7/8WqE5KX3KFM8JkSKt9EwwUbT+SG8wMgAPLFeUKM
        9eoPKTVxSZ/mFB/y+YWz65YcnASxfeE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-M6GCLAA5OBmVxUaMeaF14g-1; Thu, 25 Mar 2021 15:38:16 -0400
X-MC-Unique: M6GCLAA5OBmVxUaMeaF14g-1
Received: by mail-ed1-f71.google.com with SMTP id t27so3212284edi.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 12:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/7NIBk6La/dqb6C44uocZQB5NEP7IgsPWWcJ4ROLNwg=;
        b=PX5hZVGkabX0n/dFP6Kqobqnv6w1s/s+qNgWNizUXi37qZMn6LZZZXLk4heMxF8n0B
         ATtBTiG+NscQD6djTVWMAbilLFX3zGDThW6d26I74O91KFVoeC7s8RzUXFbn6bH0sejP
         t3R3d+COO7LBGRF6JMSxC6yTRT8Wy+9iExVdK412ISUoZ3JnEEx77YHIze3LpfSIwOov
         7T9ZsT9oLAeUVvSkn/uDu0GiXjVdhX3sWUnqP5FCgIrTrTlD3CMYfsR1/7ThHXtRGneQ
         FOB7VTjggl3ORGm99XFK7XIoPoQDQli3L9O6F5o55AOM8/dF0MYRfRMdv/xHApPYlLEX
         XrWQ==
X-Gm-Message-State: AOAM531VKm2AiIW8JHIIjhSzGmTF+CJc3vOpYvoigtsV6HaxP8nPGU+s
        +wR+1LG+uA2+idl0BlmdWjHi3rOnMzoRR/DE144dJeaIXiuR1Nsgv84/qPVuAOd+ZgSaQrK9QDC
        isAVktoILMNOMli4R2iw1nZ5Z2yxnIDZkMfpUC0Qff2LA0nbuyPw83u9GV2jhn/MiI+HFY8qW18
        y6Yg==
X-Received: by 2002:a17:906:f56:: with SMTP id h22mr11536022ejj.494.1616701094836;
        Thu, 25 Mar 2021 12:38:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCfaqxaWTKq4yEr10PfJzWo9c2H6UizAKocA4OFfSS/sXX8O4cA0AQjbWHuhc5l33bw+YTnA==
X-Received: by 2002:a17:906:f56:: with SMTP id h22mr11535997ejj.494.1616701094600;
        Thu, 25 Mar 2021 12:38:14 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id si7sm2881996ejb.84.2021.03.25.12.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 12:38:14 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v3 16/18] reiserfs: convert to fileattr
Date:   Thu, 25 Mar 2021 20:37:53 +0100
Message-Id: <20210325193755.294925-17-mszeredi@redhat.com>
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
Cc: Jan Kara <jack@suse.cz>
---
 fs/reiserfs/file.c     |   2 +
 fs/reiserfs/ioctl.c    | 121 +++++++++++++++++++----------------------
 fs/reiserfs/namei.c    |   2 +
 fs/reiserfs/reiserfs.h |   7 ++-
 fs/reiserfs/super.c    |   2 +-
 5 files changed, 64 insertions(+), 70 deletions(-)

diff --git a/fs/reiserfs/file.c b/fs/reiserfs/file.c
index 1db0254bc38b..203a47232707 100644
--- a/fs/reiserfs/file.c
+++ b/fs/reiserfs/file.c
@@ -258,4 +258,6 @@ const struct inode_operations reiserfs_file_inode_operations = {
 	.permission = reiserfs_permission,
 	.get_acl = reiserfs_get_acl,
 	.set_acl = reiserfs_set_acl,
+	.fileattr_get = reiserfs_fileattr_get,
+	.fileattr_set = reiserfs_fileattr_set,
 };
diff --git a/fs/reiserfs/ioctl.c b/fs/reiserfs/ioctl.c
index 4f1cbd930179..4b86ecf5817e 100644
--- a/fs/reiserfs/ioctl.c
+++ b/fs/reiserfs/ioctl.c
@@ -10,6 +10,59 @@
 #include <linux/uaccess.h>
 #include <linux/pagemap.h>
 #include <linux/compat.h>
+#include <linux/fileattr.h>
+
+int reiserfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+
+	if (!reiserfs_attrs(inode->i_sb))
+		return -ENOTTY;
+
+	fileattr_fill_flags(fa, REISERFS_I(inode)->i_attrs);
+
+	return 0;
+}
+
+int reiserfs_fileattr_set(struct user_namespace *mnt_userns,
+			  struct dentry *dentry, struct fileattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	unsigned int flags = fa->flags;
+	int err;
+
+	reiserfs_write_lock(inode->i_sb);
+
+	err = -ENOTTY;
+	if (!reiserfs_attrs(inode->i_sb))
+		goto unlock;
+
+	err = -EOPNOTSUPP;
+	if (fileattr_has_fsx(fa))
+		goto unlock;
+
+	/*
+	 * Is it quota file? Do not allow user to mess with it
+	 */
+	err = -EPERM;
+	if (IS_NOQUOTA(inode))
+		goto unlock;
+
+	if ((flags & REISERFS_NOTAIL_FL) && S_ISREG(inode->i_mode)) {
+		err = reiserfs_unpack(inode);
+		if (err)
+			goto unlock;
+	}
+	sd_attrs_to_i_attrs(flags, inode);
+	REISERFS_I(inode)->i_attrs = flags;
+	inode->i_ctime = current_time(inode);
+	mark_inode_dirty(inode);
+	err = 0;
+unlock:
+	reiserfs_write_unlock(inode->i_sb);
+
+	return err;
+}
 
 /*
  * reiserfs_ioctl - handler for ioctl for inode
@@ -23,7 +76,6 @@
 long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
-	unsigned int flags;
 	int err = 0;
 
 	reiserfs_write_lock(inode->i_sb);
@@ -32,7 +84,7 @@ long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case REISERFS_IOC_UNPACK:
 		if (S_ISREG(inode->i_mode)) {
 			if (arg)
-				err = reiserfs_unpack(inode, filp);
+				err = reiserfs_unpack(inode);
 		} else
 			err = -ENOTTY;
 		break;
@@ -40,63 +92,6 @@ long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		 * following two cases are taken from fs/ext2/ioctl.c by Remy
 		 * Card (card@masi.ibp.fr)
 		 */
-	case REISERFS_IOC_GETFLAGS:
-		if (!reiserfs_attrs(inode->i_sb)) {
-			err = -ENOTTY;
-			break;
-		}
-
-		flags = REISERFS_I(inode)->i_attrs;
-		err = put_user(flags, (int __user *)arg);
-		break;
-	case REISERFS_IOC_SETFLAGS:{
-			if (!reiserfs_attrs(inode->i_sb)) {
-				err = -ENOTTY;
-				break;
-			}
-
-			err = mnt_want_write_file(filp);
-			if (err)
-				break;
-
-			if (!inode_owner_or_capable(&init_user_ns, inode)) {
-				err = -EPERM;
-				goto setflags_out;
-			}
-			if (get_user(flags, (int __user *)arg)) {
-				err = -EFAULT;
-				goto setflags_out;
-			}
-			/*
-			 * Is it quota file? Do not allow user to mess with it
-			 */
-			if (IS_NOQUOTA(inode)) {
-				err = -EPERM;
-				goto setflags_out;
-			}
-			err = vfs_ioc_setflags_prepare(inode,
-						     REISERFS_I(inode)->i_attrs,
-						     flags);
-			if (err)
-				goto setflags_out;
-			if ((flags & REISERFS_NOTAIL_FL) &&
-			    S_ISREG(inode->i_mode)) {
-				int result;
-
-				result = reiserfs_unpack(inode, filp);
-				if (result) {
-					err = result;
-					goto setflags_out;
-				}
-			}
-			sd_attrs_to_i_attrs(flags, inode);
-			REISERFS_I(inode)->i_attrs = flags;
-			inode->i_ctime = current_time(inode);
-			mark_inode_dirty(inode);
-setflags_out:
-			mnt_drop_write_file(filp);
-			break;
-		}
 	case REISERFS_IOC_GETVERSION:
 		err = put_user(inode->i_generation, (int __user *)arg);
 		break;
@@ -138,12 +133,6 @@ long reiserfs_compat_ioctl(struct file *file, unsigned int cmd,
 	case REISERFS_IOC32_UNPACK:
 		cmd = REISERFS_IOC_UNPACK;
 		break;
-	case REISERFS_IOC32_GETFLAGS:
-		cmd = REISERFS_IOC_GETFLAGS;
-		break;
-	case REISERFS_IOC32_SETFLAGS:
-		cmd = REISERFS_IOC_SETFLAGS;
-		break;
 	case REISERFS_IOC32_GETVERSION:
 		cmd = REISERFS_IOC_GETVERSION;
 		break;
@@ -165,7 +154,7 @@ int reiserfs_commit_write(struct file *f, struct page *page,
  * Function try to convert tail from direct item into indirect.
  * It set up nopack attribute in the REISERFS_I(inode)->nopack
  */
-int reiserfs_unpack(struct inode *inode, struct file *filp)
+int reiserfs_unpack(struct inode *inode)
 {
 	int retval = 0;
 	int index;
diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index e6eb05e2b2f1..017db70d0f48 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -1660,6 +1660,8 @@ const struct inode_operations reiserfs_dir_inode_operations = {
 	.permission = reiserfs_permission,
 	.get_acl = reiserfs_get_acl,
 	.set_acl = reiserfs_set_acl,
+	.fileattr_get = reiserfs_fileattr_get,
+	.fileattr_set = reiserfs_fileattr_set,
 };
 
 /*
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index 0ca2ac62e534..3aa928ec527a 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -18,8 +18,6 @@
 
 /* the 32 bit compat definitions with int argument */
 #define REISERFS_IOC32_UNPACK		_IOW(0xCD, 1, int)
-#define REISERFS_IOC32_GETFLAGS		FS_IOC32_GETFLAGS
-#define REISERFS_IOC32_SETFLAGS		FS_IOC32_SETFLAGS
 #define REISERFS_IOC32_GETVERSION	FS_IOC32_GETVERSION
 #define REISERFS_IOC32_SETVERSION	FS_IOC32_SETVERSION
 
@@ -3408,7 +3406,10 @@ __u32 r5_hash(const signed char *msg, int len);
 #define SPARE_SPACE 500
 
 /* prototypes from ioctl.c */
+int reiserfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+int reiserfs_fileattr_set(struct user_namespace *mnt_userns,
+			  struct dentry *dentry, struct fileattr *fa);
 long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long reiserfs_compat_ioctl(struct file *filp,
 		   unsigned int cmd, unsigned long arg);
-int reiserfs_unpack(struct inode *inode, struct file *filp);
+int reiserfs_unpack(struct inode *inode);
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 1b9c7a387dc7..3ffafc73acf0 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -2408,7 +2408,7 @@ static int reiserfs_quota_on(struct super_block *sb, int type, int format_id,
 	 * IO to work
 	 */
 	if (!(REISERFS_I(inode)->i_flags & i_nopack_mask)) {
-		err = reiserfs_unpack(inode, NULL);
+		err = reiserfs_unpack(inode);
 		if (err) {
 			reiserfs_warning(sb, "super-6520",
 				"Unpacking tail of quota file failed"
-- 
2.30.2

