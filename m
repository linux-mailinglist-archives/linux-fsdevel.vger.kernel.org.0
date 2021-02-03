Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19F730DA4A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 13:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhBCMz2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 07:55:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231124AbhBCMnS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:43:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612356110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x6zKC2hfusHvIRBnChnTw4s6SuFE9KZ5qo7E9EL4qDI=;
        b=JscokQaIthFmf7NN4Qqv+0FevcITdmjsQ31pFwPyIECudzqws4OXPdZ8jID81a8ZIaEkpe
        Ps+dSOn89QRlJRuhXFIK9ISFzea6/sN/RK82rvMS/sXXB55rxnZtIWhTlidRfy5CYCn94s
        h7Mn4+Rg0uow/c1Jis940zJ370tENnE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-ETjNrAanNzqxFRMEsavZsg-1; Wed, 03 Feb 2021 07:41:49 -0500
X-MC-Unique: ETjNrAanNzqxFRMEsavZsg-1
Received: by mail-ej1-f69.google.com with SMTP id x22so11887050ejb.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 04:41:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x6zKC2hfusHvIRBnChnTw4s6SuFE9KZ5qo7E9EL4qDI=;
        b=uL3WgHio4l6Fih4rkBXaE7RBbpsd3jXx7beiJFZU6roh1zcRwj0is+fEj7YalTAGgw
         at7OgJRmuA0GbzLDA9bkHCOfWBIZ+3aDeLhbCCggFM88i1wWzB+x+QS+2Lg8/nQ5il71
         1eihN4f6pGbFT0Wy/8uzMI2SbIHnl4smLrbndxaer9ACD6z4dAWD9Eji0oVJA+/16Dqo
         Yfue0anr1h9wgAa3v+r7je4Ulzy8RdTk8hJfFg43XsdWdh1WpCfa6FHqNqQky7ClEO8U
         v+6abCbQTtzk2d6D5V6o4lQpbR57V/DgxkKPcyYq8nh01QowLAQYvESKajFYR+SZc4oF
         PzYQ==
X-Gm-Message-State: AOAM532P2arfUkLT9KdxOPIRC5qNxAqB9pWCZt+MOwtt4V4m/X/z3gJU
        bkWmlKa1ICjrg9FNpudh3cj0Z4TrSjljGuma22CoZdfXiVdutI4YH4odlr5JM3pAICeqdZshd5F
        Ko3JpXb45TvZismtHTkm/lFa8RdBE/EJiLB/tvbLzGDNURKQ+oJUFKHNlGVGcskcC87OJK8Kjn+
        rGzQ==
X-Received: by 2002:a17:906:eb88:: with SMTP id mh8mr2966109ejb.150.1612356107783;
        Wed, 03 Feb 2021 04:41:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx4qD1FuXM3YPzZ07bPTdelZpGdgJXEW3uCFtlx6oLIbkQmdP0oHMZ8xv9g4+VcOO7pUfF9aQ==
X-Received: by 2002:a17:906:eb88:: with SMTP id mh8mr2966087ejb.150.1612356107495;
        Wed, 03 Feb 2021 04:41:47 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id u9sm953320ejc.57.2021.02.03.04.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:41:46 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 12/18] hfsplus: convert to miscattr
Date:   Wed,  3 Feb 2021 13:41:06 +0100
Message-Id: <20210203124112.1182614-13-mszeredi@redhat.com>
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
---
 fs/hfsplus/dir.c        |  2 +
 fs/hfsplus/hfsplus_fs.h | 13 +------
 fs/hfsplus/inode.c      | 53 ++++++++++++++++++++++++++
 fs/hfsplus/ioctl.c      | 84 -----------------------------------------
 4 files changed, 57 insertions(+), 95 deletions(-)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 29a9dcfbe81f..8ac85c3f01df 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -567,6 +567,8 @@ const struct inode_operations hfsplus_dir_inode_operations = {
 	.rename			= hfsplus_rename,
 	.getattr		= hfsplus_getattr,
 	.listxattr		= hfsplus_listxattr,
+	.miscattr_get		= hfsplus_miscattr_get,
+	.miscattr_set		= hfsplus_miscattr_set,
 };
 
 const struct file_operations hfsplus_dir_operations = {
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index a92de5199ec3..55613fd3d176 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -344,17 +344,6 @@ static inline unsigned short hfsplus_min_io_size(struct super_block *sb)
 #define hfs_brec_goto hfsplus_brec_goto
 #define hfs_part_find hfsplus_part_find
 
-/*
- * definitions for ext2 flag ioctls (linux really needs a generic
- * interface for this).
- */
-
-/* ext2 ioctls (EXT2_IOC_GETFLAGS and EXT2_IOC_SETFLAGS) to support
- * chattr/lsattr */
-#define HFSPLUS_IOC_EXT2_GETFLAGS	FS_IOC_GETFLAGS
-#define HFSPLUS_IOC_EXT2_SETFLAGS	FS_IOC_SETFLAGS
-
-
 /*
  * hfs+-specific ioctl for making the filesystem bootable
  */
@@ -492,6 +481,8 @@ int hfsplus_getattr(const struct path *path, struct kstat *stat,
 		    u32 request_mask, unsigned int query_flags);
 int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
 		       int datasync);
+int hfsplus_miscattr_get(struct dentry *dentry, struct miscattr *ma);
+int hfsplus_miscattr_set(struct dentry *dentry, struct miscattr *ma);
 
 /* ioctl.c */
 long hfsplus_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index e3da9e96b835..400c7999968c 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/cred.h>
 #include <linux/uio.h>
+#include <linux/miscattr.h>
 
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
@@ -351,6 +352,8 @@ static const struct inode_operations hfsplus_file_inode_operations = {
 	.setattr	= hfsplus_setattr,
 	.getattr	= hfsplus_getattr,
 	.listxattr	= hfsplus_listxattr,
+	.miscattr_get	= hfsplus_miscattr_get,
+	.miscattr_set	= hfsplus_miscattr_set,
 };
 
 static const struct file_operations hfsplus_file_operations = {
@@ -626,3 +629,53 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	hfs_find_exit(&fd);
 	return 0;
 }
+
+int hfsplus_miscattr_get(struct dentry *dentry, struct miscattr *ma)
+{
+	struct inode *inode = d_inode(dentry);
+	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	unsigned int flags = 0;
+
+	if (inode->i_flags & S_IMMUTABLE)
+		flags |= FS_IMMUTABLE_FL;
+	if (inode->i_flags & S_APPEND)
+		flags |= FS_APPEND_FL;
+	if (hip->userflags & HFSPLUS_FLG_NODUMP)
+		flags |= FS_NODUMP_FL;
+
+	miscattr_fill_flags(ma, flags);
+
+	return 0;
+}
+
+int hfsplus_miscattr_set(struct dentry *dentry, struct miscattr *ma)
+{
+	struct inode *inode = d_inode(dentry);
+	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	unsigned int new_fl = 0;
+
+	if (miscattr_has_xattr(ma))
+		return -EOPNOTSUPP;
+
+	/* don't silently ignore unsupported ext2 flags */
+	if (ma->flags & ~(FS_IMMUTABLE_FL|FS_APPEND_FL|FS_NODUMP_FL))
+		return -EOPNOTSUPP;
+
+	if (ma->flags & FS_IMMUTABLE_FL)
+		new_fl |= S_IMMUTABLE;
+
+	if (ma->flags & FS_APPEND_FL)
+		new_fl |= S_APPEND;
+
+	inode_set_flags(inode, new_fl, S_IMMUTABLE | S_APPEND);
+
+	if (ma->flags & FS_NODUMP_FL)
+		hip->userflags |= HFSPLUS_FLG_NODUMP;
+	else
+		hip->userflags &= ~HFSPLUS_FLG_NODUMP;
+
+	inode->i_ctime = current_time(inode);
+	mark_inode_dirty(inode);
+
+	return 0;
+}
diff --git a/fs/hfsplus/ioctl.c b/fs/hfsplus/ioctl.c
index ce15b9496b77..5661a2e24d03 100644
--- a/fs/hfsplus/ioctl.c
+++ b/fs/hfsplus/ioctl.c
@@ -57,95 +57,11 @@ static int hfsplus_ioctl_bless(struct file *file, int __user *user_flags)
 	return 0;
 }
 
-static inline unsigned int hfsplus_getflags(struct inode *inode)
-{
-	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
-	unsigned int flags = 0;
-
-	if (inode->i_flags & S_IMMUTABLE)
-		flags |= FS_IMMUTABLE_FL;
-	if (inode->i_flags & S_APPEND)
-		flags |= FS_APPEND_FL;
-	if (hip->userflags & HFSPLUS_FLG_NODUMP)
-		flags |= FS_NODUMP_FL;
-	return flags;
-}
-
-static int hfsplus_ioctl_getflags(struct file *file, int __user *user_flags)
-{
-	struct inode *inode = file_inode(file);
-	unsigned int flags = hfsplus_getflags(inode);
-
-	return put_user(flags, user_flags);
-}
-
-static int hfsplus_ioctl_setflags(struct file *file, int __user *user_flags)
-{
-	struct inode *inode = file_inode(file);
-	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
-	unsigned int flags, new_fl = 0;
-	unsigned int oldflags = hfsplus_getflags(inode);
-	int err = 0;
-
-	err = mnt_want_write_file(file);
-	if (err)
-		goto out;
-
-	if (!inode_owner_or_capable(inode)) {
-		err = -EACCES;
-		goto out_drop_write;
-	}
-
-	if (get_user(flags, user_flags)) {
-		err = -EFAULT;
-		goto out_drop_write;
-	}
-
-	inode_lock(inode);
-
-	err = vfs_ioc_setflags_prepare(inode, oldflags, flags);
-	if (err)
-		goto out_unlock_inode;
-
-	/* don't silently ignore unsupported ext2 flags */
-	if (flags & ~(FS_IMMUTABLE_FL|FS_APPEND_FL|FS_NODUMP_FL)) {
-		err = -EOPNOTSUPP;
-		goto out_unlock_inode;
-	}
-
-	if (flags & FS_IMMUTABLE_FL)
-		new_fl |= S_IMMUTABLE;
-
-	if (flags & FS_APPEND_FL)
-		new_fl |= S_APPEND;
-
-	inode_set_flags(inode, new_fl, S_IMMUTABLE | S_APPEND);
-
-	if (flags & FS_NODUMP_FL)
-		hip->userflags |= HFSPLUS_FLG_NODUMP;
-	else
-		hip->userflags &= ~HFSPLUS_FLG_NODUMP;
-
-	inode->i_ctime = current_time(inode);
-	mark_inode_dirty(inode);
-
-out_unlock_inode:
-	inode_unlock(inode);
-out_drop_write:
-	mnt_drop_write_file(file);
-out:
-	return err;
-}
-
 long hfsplus_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
 
 	switch (cmd) {
-	case HFSPLUS_IOC_EXT2_GETFLAGS:
-		return hfsplus_ioctl_getflags(file, argp);
-	case HFSPLUS_IOC_EXT2_SETFLAGS:
-		return hfsplus_ioctl_setflags(file, argp);
 	case HFSPLUS_IOC_BLESS:
 		return hfsplus_ioctl_bless(file, argp);
 	default:
-- 
2.26.2

