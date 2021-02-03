Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C862230DA59
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 13:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhBCM6C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 07:58:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58990 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229609AbhBCMnR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612356109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fQs32CFkeQee6Qi0d4yGgTdeHXtxqMgVVLnb5MenyYI=;
        b=CNol/xeee+Ez+KnzinaBZEK9YuL0fbkshHxqr9gofKH3J1XBXBygCsQuaf/+dg03h9bySu
        SviOdsni28C5qbpSbgJcDI/+DWaacae79e0BO3DL7rtyuEXvLoAqvk+Mmkg1kdwrcDFP6u
        vax+ZDmWtqLgOfWVLXkdfhqGRbK7xrs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-evo6eGmaMVC3RMOLoYk3fQ-1; Wed, 03 Feb 2021 07:41:48 -0500
X-MC-Unique: evo6eGmaMVC3RMOLoYk3fQ-1
Received: by mail-ej1-f71.google.com with SMTP id x22so11887023ejb.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 04:41:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fQs32CFkeQee6Qi0d4yGgTdeHXtxqMgVVLnb5MenyYI=;
        b=cMnYYPriXtlaSVha5DowFKRku+yVmY0HZTYg1za+R+rqluqeacEDPEANFJyXyiuOSr
         zQxAZxs+ojZ70VcDR29v6o6AlfawKYsk049p27muTfsLvYkOE+cmQbrnvtYmnHYVrcol
         +qnoVvKUAvHQ8zynA8bwmkdzRqHBjL/aqUHDNd9saZb+quFednPJB5DxLSTi97ZWaQy2
         etb1RWSnJu+zQlqR94sDZl2x9PfYNVL0V+f7w2HPWyTORYOiw59UIHb80YxzkJiQPwzr
         V6E3lcFbTZW6S0Tpp/06UuZrVW1cYN8zChjxZy9xU5L3L37q0OHVciF3lRR81R6XQ4D1
         G/3w==
X-Gm-Message-State: AOAM532eHf+Gc7lBsH4HXlaL0+Pizzw+N/7Ysvoz4M68iQ/BhO52nYyh
        tcbh0U3r02YEaRDYLRRGxFbSgcXN9k/VrjuQgAibxfdOdR7AIso2vAPgGDQ3Tjaudq+VKvH482s
        rKf77dcperknJptJY+5hpyhctaFC7pbBIxl6vhmODe4e+K/F9yZpYyoSS5JkPZissmnH5RqMj5J
        NO1g==
X-Received: by 2002:a17:906:798:: with SMTP id l24mr3084858ejc.92.1612356106658;
        Wed, 03 Feb 2021 04:41:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsdPBVvNj9IqaUZFQHNz02ZWeYAz/oTN9gUd/G5//vA3k+ad3DBApnA5PxgcqP2w/ZdpBpOQ==
X-Received: by 2002:a17:906:798:: with SMTP id l24mr3084836ejc.92.1612356106455;
        Wed, 03 Feb 2021 04:41:46 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id u9sm953320ejc.57.2021.02.03.04.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:41:45 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Matthew Garrett <matthew.garrett@nebula.com>
Subject: [PATCH 11/18] efivars: convert to miscattr
Date:   Wed,  3 Feb 2021 13:41:05 +0100
Message-Id: <20210203124112.1182614-12-mszeredi@redhat.com>
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
Cc: Matthew Garrett <matthew.garrett@nebula.com>
---
 fs/efivarfs/file.c  | 77 ---------------------------------------------
 fs/efivarfs/inode.c | 43 +++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 77 deletions(-)

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index feaa5e182b7b..d57ee15874f9 100644
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
-	if (!inode_owner_or_capable(inode))
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
index 0297ad95eb5c..35d9aba303a4 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -10,9 +10,12 @@
 #include <linux/kmemleak.h>
 #include <linux/slab.h>
 #include <linux/uuid.h>
+#include <linux/miscattr.h>
 
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
@@ -138,3 +142,42 @@ const struct inode_operations efivarfs_dir_inode_operations = {
 	.unlink = efivarfs_unlink,
 	.create = efivarfs_create,
 };
+
+static int
+efivarfs_miscattr_get(struct dentry *dentry, struct miscattr *ma)
+{
+	unsigned int i_flags;
+	unsigned int flags = 0;
+
+	i_flags = d_inode(dentry)->i_flags;
+	if (i_flags & S_IMMUTABLE)
+		flags |= FS_IMMUTABLE_FL;
+
+	miscattr_fill_flags(ma, flags);
+
+	return 0;
+}
+
+static int
+efivarfs_miscattr_set(struct dentry *dentry, struct miscattr *ma)
+{
+	unsigned int i_flags = 0;
+
+	if (miscattr_has_xattr(ma))
+		return -EOPNOTSUPP;
+
+	if (ma->flags & ~FS_IMMUTABLE_FL)
+		return -EOPNOTSUPP;
+
+	if (ma->flags & FS_IMMUTABLE_FL)
+		i_flags |= S_IMMUTABLE;
+
+	inode_set_flags(d_inode(dentry), i_flags, S_IMMUTABLE);
+
+	return 0;
+}
+
+static const struct inode_operations efivarfs_file_inode_operations = {
+	.miscattr_get = efivarfs_miscattr_get,
+	.miscattr_set = efivarfs_miscattr_set,
+};
-- 
2.26.2

