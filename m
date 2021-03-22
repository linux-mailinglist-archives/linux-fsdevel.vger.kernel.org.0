Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6533447FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 15:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhCVOuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 10:50:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32993 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231202AbhCVOtf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616424575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fZ1kizA+LiFidVAaGzgHTkHThFh4LhWmsbGPiZbctac=;
        b=DmDXfaVxLyg/VDrDgTNZTuqDGIwn15MV6eqFd/4QMtARrUpwzau4jyW9ADPcbd4wQVQ/dz
        oFN/RJA4C2mZGhOw0UHArCkHCt3PWgsR1ceQ3lYucf+WPPu97SIuteiUPs0BEAPbVg3OMD
        jGwNNvBNBnUnRm3NssrwOE2YlPDrb2A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-Jm3LaqjNMQCTdOsuXpyBFQ-1; Mon, 22 Mar 2021 10:49:33 -0400
X-MC-Unique: Jm3LaqjNMQCTdOsuXpyBFQ-1
Received: by mail-ed1-f70.google.com with SMTP id n20so27700844edr.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 07:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZ1kizA+LiFidVAaGzgHTkHThFh4LhWmsbGPiZbctac=;
        b=jnmFuAZihQLCUjGKz+WoiVldwcytH8U4N42Mgd7pDVJT3GQKf2IVNomGoX+gir+/an
         YrPvNZWCexnB6XAKcQ88RmvWJSJfc0ECtf6r5SezFa8nHhLmqtpsddk8Sgg+gMPkR427
         n8JFue1FSpHVzDXuYaOCqbEwxl3G9qsGewwzkif6OZcMk23v4N4JqmXO7mM680ApfDK2
         2KCMJHyUi2udvHFRhqMZjGiUvsbHn29Snsc7sBGDl9APfeq8wI2XO870hdIX9EveGxb4
         E3+GobdB9lzInph/x9LXmF3expJXZE8EizOxWCQZRhaKLCtjvLfvzFSBTrKobV0jLfjW
         UZcw==
X-Gm-Message-State: AOAM530eq7jo79YE0w03E/3OgCAaHSPyliho9Tg8Sc95HqGxa7fHY7Oq
        bF2H9XvjxoeNZ4aTauhYgYGey8YRvYOBZCORhVliugIz9z+uFO0IL7YAEYtRJSh+Wmuqv+h3FrP
        05aSarMPQpWyWEgmbyYGEzQEMb3lpypYQlD/HuHuJs0ojUuXR7lBfMioPgquspYyDRQDT/x0Zs3
        FVbg==
X-Received: by 2002:a17:907:766f:: with SMTP id kk15mr162113ejc.24.1616424571880;
        Mon, 22 Mar 2021 07:49:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySxMs+2+TlVeih//2S1IHzOOCWeOijLxHeyriI4OXE0His8umI3R99StaabYK9VG9Oy1yaiw==
X-Received: by 2002:a17:907:766f:: with SMTP id kk15mr162099ejc.24.1616424571664;
        Mon, 22 Mar 2021 07:49:31 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id r4sm9793117ejd.125.2021.03.22.07.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:49:31 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH v2 11/18] efivars: convert to miscattr
Date:   Mon, 22 Mar 2021 15:49:09 +0100
Message-Id: <20210322144916.137245-12-mszeredi@redhat.com>
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
index 14e2947975fd..3ff034d86544 100644
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
@@ -138,3 +142,43 @@ const struct inode_operations efivarfs_dir_inode_operations = {
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
+efivarfs_miscattr_set(struct user_namespace *mnt_userns,
+		      struct dentry *dentry, struct miscattr *ma)
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
2.30.2

