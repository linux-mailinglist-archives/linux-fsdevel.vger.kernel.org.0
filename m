Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7B3349A6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 20:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhCYTir (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 15:38:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230304AbhCYTiN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616701092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bu7iD2JNFeJr1COLeY9ucECdTeYKd3yywrM1RjfNkh0=;
        b=WMrphnkkWyGGM8iKuXXHBURO3aYpTk3QUwNHplAd3kDype+sxU/aJq50Qdg7aLVVqBekZe
        46L1m9g0ZubBQZjgqb3CbsQjuMWtMhNe8NXRt253GcKr5HK4u9gOQsOWYRKGYKwfUNkqTi
        WAW6btp7wda4dCWaxfbuo7339FU82XM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-01hTavbENb-IMWwXtqxmNw-1; Thu, 25 Mar 2021 15:38:11 -0400
X-MC-Unique: 01hTavbENb-IMWwXtqxmNw-1
Received: by mail-ed1-f69.google.com with SMTP id p6so3184274edq.21
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 12:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bu7iD2JNFeJr1COLeY9ucECdTeYKd3yywrM1RjfNkh0=;
        b=avdpg7GPNVl39KPllT04jcvFwjNhM3NMW33u2zk1r0AwAxN4EljOYsy0uc7A9JMIdR
         OaxRfakytGcJ6c1TiQH2Qm7sm/D73jYQd4SHtIUkDCPRpPO40lKf0vJ8I51kyrScCrk9
         9ndrU/cRBA+II5DOajVs/ne6cNqcjf9TKmEXQ744v58AWt0pKBe6HGUGiLT2e0txic8D
         p/fAhVnb35KbFfM9TxH2rohhLhnYD15oL4SMKnp3Own9REv98l+HjrpFKu2TQTfuHSsf
         /p6ITdBgxCwKotwEXNpqjtQOOs3YyMdL/2o/vi6lsFl5YeYZ3V+BBlVIOOkGZ3QU++fE
         6l9A==
X-Gm-Message-State: AOAM533DPgvFJIvhTXW6YUH4lclAdNgNhSFcUyy6A4udYzTXQ4CL7sV3
        x8b2Y1WpmQjucjcjBja8PFdX2T+KffoFPTAznUttpYiNNXXVIFfnhZmvBJK10F2vM+yMN3YwE++
        lEpj1MDJMY6jzSAdFHjORv+wX48ymsbZaiJpBOOLcRNrjyTmeExgxw6bnMzmf43gGcw2eAkjfxP
        BqeQ==
X-Received: by 2002:a17:906:5012:: with SMTP id s18mr10790452ejj.100.1616701089861;
        Thu, 25 Mar 2021 12:38:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3TJ3DjfXm9eilGBXZGXHzWeb/gniKX0IvWcETDgfl6MJIL5RKcBa8i+baa+vnmjZmPNqBUA==
X-Received: by 2002:a17:906:5012:: with SMTP id s18mr10790434ejj.100.1616701089703;
        Thu, 25 Mar 2021 12:38:09 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id si7sm2881996ejb.84.2021.03.25.12.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 12:38:08 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH v3 11/18] efivars: convert to fileattr
Date:   Thu, 25 Mar 2021 20:37:48 +0100
Message-Id: <20210325193755.294925-12-mszeredi@redhat.com>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
---
 fs/efivarfs/file.c  | 77 ---------------------------------------------
 fs/efivarfs/inode.c | 44 ++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 77 deletions(-)

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index e6bc0302643b..d57ee15874f9 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -106,86 +106,9 @@ static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
 	return size;
 }
 
-static inline unsigned int efivarfs_getflags(struct inode *inode)
-{
-	unsigned int i_flags;
-	unsigned int flags = 0;
-
-	i_flags = inode->i_flags;
-	if (i_flags & S_IMMUTABLE)
-		flags |= FS_IMMUTABLE_FL;
-	return flags;
-}
-
-static int
-efivarfs_ioc_getxflags(struct file *file, void __user *arg)
-{
-	struct inode *inode = file->f_mapping->host;
-	unsigned int flags = efivarfs_getflags(inode);
-
-	if (copy_to_user(arg, &flags, sizeof(flags)))
-		return -EFAULT;
-	return 0;
-}
-
-static int
-efivarfs_ioc_setxflags(struct file *file, void __user *arg)
-{
-	struct inode *inode = file->f_mapping->host;
-	unsigned int flags;
-	unsigned int i_flags = 0;
-	unsigned int oldflags = efivarfs_getflags(inode);
-	int error;
-
-	if (!inode_owner_or_capable(&init_user_ns, inode))
-		return -EACCES;
-
-	if (copy_from_user(&flags, arg, sizeof(flags)))
-		return -EFAULT;
-
-	if (flags & ~FS_IMMUTABLE_FL)
-		return -EOPNOTSUPP;
-
-	if (flags & FS_IMMUTABLE_FL)
-		i_flags |= S_IMMUTABLE;
-
-
-	error = mnt_want_write_file(file);
-	if (error)
-		return error;
-
-	inode_lock(inode);
-
-	error = vfs_ioc_setflags_prepare(inode, oldflags, flags);
-	if (error)
-		goto out;
-
-	inode_set_flags(inode, i_flags, S_IMMUTABLE);
-out:
-	inode_unlock(inode);
-	mnt_drop_write_file(file);
-	return error;
-}
-
-static long
-efivarfs_file_ioctl(struct file *file, unsigned int cmd, unsigned long p)
-{
-	void __user *arg = (void __user *)p;
-
-	switch (cmd) {
-	case FS_IOC_GETFLAGS:
-		return efivarfs_ioc_getxflags(file, arg);
-	case FS_IOC_SETFLAGS:
-		return efivarfs_ioc_setxflags(file, arg);
-	}
-
-	return -ENOTTY;
-}
-
 const struct file_operations efivarfs_file_operations = {
 	.open	= simple_open,
 	.read	= efivarfs_file_read,
 	.write	= efivarfs_file_write,
 	.llseek	= no_llseek,
-	.unlocked_ioctl = efivarfs_file_ioctl,
 };
diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 14e2947975fd..939e5e242b98 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -10,9 +10,12 @@
 #include <linux/kmemleak.h>
 #include <linux/slab.h>
 #include <linux/uuid.h>
+#include <linux/fileattr.h>
 
 #include "internal.h"
 
+static const struct inode_operations efivarfs_file_inode_operations;
+
 struct inode *efivarfs_get_inode(struct super_block *sb,
 				const struct inode *dir, int mode,
 				dev_t dev, bool is_removable)
@@ -26,6 +29,7 @@ struct inode *efivarfs_get_inode(struct super_block *sb,
 		inode->i_flags = is_removable ? 0 : S_IMMUTABLE;
 		switch (mode & S_IFMT) {
 		case S_IFREG:
+			inode->i_op = &efivarfs_file_inode_operations;
 			inode->i_fop = &efivarfs_file_operations;
 			break;
 		case S_IFDIR:
@@ -138,3 +142,43 @@ const struct inode_operations efivarfs_dir_inode_operations = {
 	.unlink = efivarfs_unlink,
 	.create = efivarfs_create,
 };
+
+static int
+efivarfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+{
+	unsigned int i_flags;
+	unsigned int flags = 0;
+
+	i_flags = d_inode(dentry)->i_flags;
+	if (i_flags & S_IMMUTABLE)
+		flags |= FS_IMMUTABLE_FL;
+
+	fileattr_fill_flags(fa, flags);
+
+	return 0;
+}
+
+static int
+efivarfs_fileattr_set(struct user_namespace *mnt_userns,
+		      struct dentry *dentry, struct fileattr *fa)
+{
+	unsigned int i_flags = 0;
+
+	if (fileattr_has_fsx(fa))
+		return -EOPNOTSUPP;
+
+	if (fa->flags & ~FS_IMMUTABLE_FL)
+		return -EOPNOTSUPP;
+
+	if (fa->flags & FS_IMMUTABLE_FL)
+		i_flags |= S_IMMUTABLE;
+
+	inode_set_flags(d_inode(dentry), i_flags, S_IMMUTABLE);
+
+	return 0;
+}
+
+static const struct inode_operations efivarfs_file_inode_operations = {
+	.fileattr_get = efivarfs_fileattr_get,
+	.fileattr_set = efivarfs_fileattr_set,
+};
-- 
2.30.2

