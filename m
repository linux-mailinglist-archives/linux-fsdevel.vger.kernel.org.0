Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8973447F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 15:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhCVOuC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 10:50:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28629 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230510AbhCVOt2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616424568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5u9SppafS3lTo/ie9QXPmsGSZMKkK44cjZgzUVYcroI=;
        b=P4XOGpPNE7WbGeAcSx6P6UmAvCSVUEQajMk5Pu5K01Wlh//d0KfhHYjKTnzaZGpzjLgLCd
        T8UF/u/rU6+hBCRChV+KVNJfeRTml84W7NNjBDr7kXBouA725yslYzNNyNqyGXoFYmLxcH
        X8EsdwsYcWhfh8HGblxb0A2PKJyj2dg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-mQYY0wX3MluKU3TjMxYtBg-1; Mon, 22 Mar 2021 10:49:26 -0400
X-MC-Unique: mQYY0wX3MluKU3TjMxYtBg-1
Received: by mail-ej1-f72.google.com with SMTP id 11so19935449ejz.20
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 07:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5u9SppafS3lTo/ie9QXPmsGSZMKkK44cjZgzUVYcroI=;
        b=Wxyi1UYW40y+SulzOotSgbs3rxBBZ3o0DOAVbYY7nyZ8ehyYh+XKSUYG16/q0kw2cr
         8E7NTN8fsTtIjo3JIz1lhKLHfoz2T+GNRWbuvijRtmqoGmr90xro9ybMtwyrdeTIL5DT
         oLY4HM+tHT6k0RPMgchNo3hfME4QXwUcLot1QGhWYUXT/LpXAgvPQPLeI9RvGGqhx/xr
         USq57R3NXNawbSmMSO+qLB+n0DUvMkngL4gzXbwYMazaBAAftYvkXwu+ZFN6E3mcALPp
         QmETRmrwMFR7lNAuVqSv/0CZ1NKsFWaz2iuYsPVtmtSnqSCdoBDcgdL1CmYBMaFWieqz
         ipcA==
X-Gm-Message-State: AOAM533SD3cQ4YaFE8KTDC7d5uxWnr/+treVcnj0F50cvlMPI2TlcFeq
        mfBEZlfrg01ii441DloO/H3JTDVczZ5RwxWJuiSP+zVrT/dJ29xVK8Y4mvdAsmxfpek8wTagsig
        tkuqa86bBrM8C5Ne7VGr/KzfqmND4pI50k2d36KepS0LjSyKgMI9qvZ6pGZ5VUACwTgiJJUO5Lx
        HQaQ==
X-Received: by 2002:a17:907:7684:: with SMTP id jv4mr92168ejc.231.1616424565138;
        Mon, 22 Mar 2021 07:49:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYAiu8PvvALtGPtq/A7nK6wwCGYCNDiiqLXYXy9QiYeyDoQytSdKjdcHqPHnUrG3yYlgtjtQ==
X-Received: by 2002:a17:907:7684:: with SMTP id jv4mr92149ejc.231.1616424564916;
        Mon, 22 Mar 2021 07:49:24 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id r4sm9793117ejd.125.2021.03.22.07.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:49:24 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 05/18] ext2: convert to miscattr
Date:   Mon, 22 Mar 2021 15:49:03 +0100
Message-Id: <20210322144916.137245-6-mszeredi@redhat.com>
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
Cc: Jan Kara <jack@suse.cz>
---
 fs/ext2/ext2.h  |  7 ++--
 fs/ext2/file.c  |  2 ++
 fs/ext2/ioctl.c | 88 ++++++++++++++++++-------------------------------
 fs/ext2/namei.c |  2 ++
 4 files changed, 39 insertions(+), 60 deletions(-)

diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 3309fb2d327a..b58f27b1412b 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -283,8 +283,6 @@ static inline __u32 ext2_mask_flags(umode_t mode, __u32 flags)
 /*
  * ioctl commands
  */
-#define	EXT2_IOC_GETFLAGS		FS_IOC_GETFLAGS
-#define	EXT2_IOC_SETFLAGS		FS_IOC_SETFLAGS
 #define	EXT2_IOC_GETVERSION		FS_IOC_GETVERSION
 #define	EXT2_IOC_SETVERSION		FS_IOC_SETVERSION
 #define	EXT2_IOC_GETRSVSZ		_IOR('f', 5, long)
@@ -293,8 +291,6 @@ static inline __u32 ext2_mask_flags(umode_t mode, __u32 flags)
 /*
  * ioctl commands in 32 bit emulation
  */
-#define EXT2_IOC32_GETFLAGS		FS_IOC32_GETFLAGS
-#define EXT2_IOC32_SETFLAGS		FS_IOC32_SETFLAGS
 #define EXT2_IOC32_GETVERSION		FS_IOC32_GETVERSION
 #define EXT2_IOC32_SETVERSION		FS_IOC32_SETVERSION
 
@@ -772,6 +768,9 @@ extern int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		       u64 start, u64 len);
 
 /* ioctl.c */
+extern int ext2_miscattr_get(struct dentry *dentry, struct miscattr *ma);
+extern int ext2_miscattr_set(struct user_namespace *mnt_userns,
+			     struct dentry *dentry, struct miscattr *ma);
 extern long ext2_ioctl(struct file *, unsigned int, unsigned long);
 extern long ext2_compat_ioctl(struct file *, unsigned int, unsigned long);
 
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 96044f5dbc0e..096c03612129 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -204,4 +204,6 @@ const struct inode_operations ext2_file_inode_operations = {
 	.get_acl	= ext2_get_acl,
 	.set_acl	= ext2_set_acl,
 	.fiemap		= ext2_fiemap,
+	.miscattr_get	= ext2_miscattr_get,
+	.miscattr_set	= ext2_miscattr_set,
 };
diff --git a/fs/ext2/ioctl.c b/fs/ext2/ioctl.c
index b399cbb7022d..f841d4439c62 100644
--- a/fs/ext2/ioctl.c
+++ b/fs/ext2/ioctl.c
@@ -16,69 +16,51 @@
 #include <linux/mount.h>
 #include <asm/current.h>
 #include <linux/uaccess.h>
+#include <linux/miscattr.h>
 
-
-long ext2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+int ext2_miscattr_get(struct dentry *dentry, struct miscattr *ma)
 {
-	struct inode *inode = file_inode(filp);
-	struct ext2_inode_info *ei = EXT2_I(inode);
-	unsigned int flags;
-	unsigned short rsv_window_size;
-	int ret;
+	struct ext2_inode_info *ei = EXT2_I(d_inode(dentry));
 
-	ext2_debug ("cmd = %u, arg = %lu\n", cmd, arg);
+	miscattr_fill_flags(ma, ei->i_flags & EXT2_FL_USER_VISIBLE);
 
-	switch (cmd) {
-	case EXT2_IOC_GETFLAGS:
-		flags = ei->i_flags & EXT2_FL_USER_VISIBLE;
-		return put_user(flags, (int __user *) arg);
-	case EXT2_IOC_SETFLAGS: {
-		unsigned int oldflags;
+	return 0;
+}
 
-		ret = mnt_want_write_file(filp);
-		if (ret)
-			return ret;
+int ext2_miscattr_set(struct user_namespace *mnt_userns,
+		      struct dentry *dentry, struct miscattr *ma)
+{
+	struct inode *inode = d_inode(dentry);
+	struct ext2_inode_info *ei = EXT2_I(inode);
 
-		if (!inode_owner_or_capable(&init_user_ns, inode)) {
-			ret = -EACCES;
-			goto setflags_out;
-		}
+	if (miscattr_has_xattr(ma))
+		return -EOPNOTSUPP;
 
-		if (get_user(flags, (int __user *) arg)) {
-			ret = -EFAULT;
-			goto setflags_out;
-		}
+	/* Is it quota file? Do not allow user to mess with it */
+	if (IS_NOQUOTA(inode))
+		return -EPERM;
 
-		flags = ext2_mask_flags(inode->i_mode, flags);
+	ei->i_flags = (ei->i_flags & ~EXT2_FL_USER_MODIFIABLE) |
+		(ma->flags & EXT2_FL_USER_MODIFIABLE);
 
-		inode_lock(inode);
-		/* Is it quota file? Do not allow user to mess with it */
-		if (IS_NOQUOTA(inode)) {
-			inode_unlock(inode);
-			ret = -EPERM;
-			goto setflags_out;
-		}
-		oldflags = ei->i_flags;
+	ext2_set_inode_flags(inode);
+	inode->i_ctime = current_time(inode);
+	mark_inode_dirty(inode);
 
-		ret = vfs_ioc_setflags_prepare(inode, oldflags, flags);
-		if (ret) {
-			inode_unlock(inode);
-			goto setflags_out;
-		}
+	return 0;
+}
 
-		flags = flags & EXT2_FL_USER_MODIFIABLE;
-		flags |= oldflags & ~EXT2_FL_USER_MODIFIABLE;
-		ei->i_flags = flags;
 
-		ext2_set_inode_flags(inode);
-		inode->i_ctime = current_time(inode);
-		inode_unlock(inode);
+long ext2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct ext2_inode_info *ei = EXT2_I(inode);
+	unsigned short rsv_window_size;
+	int ret;
 
-		mark_inode_dirty(inode);
-setflags_out:
-		mnt_drop_write_file(filp);
-		return ret;
-	}
+	ext2_debug ("cmd = %u, arg = %lu\n", cmd, arg);
+
+	switch (cmd) {
 	case EXT2_IOC_GETVERSION:
 		return put_user(inode->i_generation, (int __user *) arg);
 	case EXT2_IOC_SETVERSION: {
@@ -163,12 +145,6 @@ long ext2_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	/* These are just misnamed, they actually get/put from/to user an int */
 	switch (cmd) {
-	case EXT2_IOC32_GETFLAGS:
-		cmd = EXT2_IOC_GETFLAGS;
-		break;
-	case EXT2_IOC32_SETFLAGS:
-		cmd = EXT2_IOC_SETFLAGS;
-		break;
 	case EXT2_IOC32_GETVERSION:
 		cmd = EXT2_IOC_GETVERSION;
 		break;
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 3367384d344d..c0fd2e025d49 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -427,6 +427,8 @@ const struct inode_operations ext2_dir_inode_operations = {
 	.get_acl	= ext2_get_acl,
 	.set_acl	= ext2_set_acl,
 	.tmpfile	= ext2_tmpfile,
+	.miscattr_get	= ext2_miscattr_get,
+	.miscattr_set	= ext2_miscattr_set,
 };
 
 const struct inode_operations ext2_special_inode_operations = {
-- 
2.30.2

