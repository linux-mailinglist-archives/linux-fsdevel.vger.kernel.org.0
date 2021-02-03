Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B754330DA06
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 13:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhBCMoN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 07:44:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31070 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229966AbhBCMnL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612356102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YfxjKiRnmCeF45G82/Gu+rWSKN17ibHTLy7LnU1Eog8=;
        b=chfrSuaJ1IFDv3cLq0Ushlz2GnFNoaMMGiAfTNsv42IHNBWk3l62bFG3i1KFoCt5pwDsMg
        GED4plvcKY5SYIQY1SZ2pGr+wKe/rZmux0e4gVXrEm6n4hwiFGLAhXfQpALR2n7AIP19i6
        JWKq+h2hdxjpet1aQVpUFstDuaXD2oA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-D-Bp6AgLPxuPxym5dSiOFg-1; Wed, 03 Feb 2021 07:41:40 -0500
X-MC-Unique: D-Bp6AgLPxuPxym5dSiOFg-1
Received: by mail-ed1-f72.google.com with SMTP id ck25so11351484edb.16
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 04:41:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YfxjKiRnmCeF45G82/Gu+rWSKN17ibHTLy7LnU1Eog8=;
        b=b7ruEbo3EMSrjtC6+7MT2ZoTleClXKj6Dk050GgVK3mWcVXqw8wCq0W/hQhOauTbqO
         4HdSSBex6q1LtH/Pchci0zld3RLZyEGVfm13aV9ZY4o/tjyVUmxYPLCikPQ5gpKY19ZD
         t2eHXXbpCYygH3n1a7JyVTm3y9cK1445mvfANkgBcIdSp7MZfSiWZMbjaLE+pcMDSzL7
         /p55j96AEA9Xod5+ET1T7Zx2GXtw25p1kB9gqsKuelXrgWMVcNOS5AXTI/h7H/2jRwrP
         A3M2Kfh1bOhkk1crK3LAp8yJEaMTO1KryK6OmAF8luAtocoKK7g45lBd8lTxdagwPlHA
         Rf7g==
X-Gm-Message-State: AOAM530Qs0j7twc0tnHbETvlu23B9dPS9X2h6t63UJTIUf71I8ETFW+M
        uWuA/hlPpjnlu63q4syLJppiYUGz2HjG550ce19p0UFBcCf/5a+NF72u/omZqc8Zzh/EOMD+xWB
        hpyGA0AVgI9EK01uYyTbkjP+qosKtPv/wSuMLK+BbHy4MdNRqn/8Em6jz26nH7QbjEZNzC5v5Cj
        2x5g==
X-Received: by 2002:a17:906:4955:: with SMTP id f21mr2996136ejt.384.1612356099269;
        Wed, 03 Feb 2021 04:41:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZZS+7bMc2r67UGpYbKMdnQQ4ysm/vXcZ6Omhy+6Ft+rjEsE2YhCyE8dqhFXwxcSZom2k67g==
X-Received: by 2002:a17:906:4955:: with SMTP id f21mr2996120ejt.384.1612356099075;
        Wed, 03 Feb 2021 04:41:39 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id u9sm953320ejc.57.2021.02.03.04.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:41:38 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH 05/18] ext2: convert to miscattr
Date:   Wed,  3 Feb 2021 13:40:59 +0100
Message-Id: <20210203124112.1182614-6-mszeredi@redhat.com>
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
Cc: Jan Kara <jack@suse.cz>
---
 fs/ext2/ext2.h  |  6 ++--
 fs/ext2/file.c  |  2 ++
 fs/ext2/ioctl.c | 85 ++++++++++++++++---------------------------------
 fs/ext2/namei.c |  2 ++
 4 files changed, 34 insertions(+), 61 deletions(-)

diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 2a4175fbaf5e..fe06953770ad 100644
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
 
@@ -771,6 +767,8 @@ extern int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		       u64 start, u64 len);
 
 /* ioctl.c */
+extern int ext2_miscattr_get(struct dentry *dentry, struct miscattr *ma);
+extern int ext2_miscattr_set(struct dentry *dentry, struct miscattr *ma);
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
index 32a8d10b579d..9900d9054a02 100644
--- a/fs/ext2/ioctl.c
+++ b/fs/ext2/ioctl.c
@@ -16,69 +16,46 @@
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
-
-	ext2_debug ("cmd = %u, arg = %lu\n", cmd, arg);
+	struct ext2_inode_info *ei = EXT2_I(d_inode(dentry));
 
-	switch (cmd) {
-	case EXT2_IOC_GETFLAGS:
-		flags = ei->i_flags & EXT2_FL_USER_VISIBLE;
-		return put_user(flags, (int __user *) arg);
-	case EXT2_IOC_SETFLAGS: {
-		unsigned int oldflags;
+	ma->flags = ei->i_flags & EXT2_FL_USER_VISIBLE;
+	return 0;
+}
 
-		ret = mnt_want_write_file(filp);
-		if (ret)
-			return ret;
+int ext2_miscattr_set(struct dentry *dentry, struct miscattr *ma)
+{
+	struct inode *inode = d_inode(dentry);
+	struct ext2_inode_info *ei = EXT2_I(inode);
 
-		if (!inode_owner_or_capable(inode)) {
-			ret = -EACCES;
-			goto setflags_out;
-		}
+	/* Is it quota file? Do not allow user to mess with it */
+	if (IS_NOQUOTA(inode))
+		return -EPERM;
 
-		if (get_user(flags, (int __user *) arg)) {
-			ret = -EFAULT;
-			goto setflags_out;
-		}
+	ei->i_flags = (ei->i_flags & ~EXT2_FL_USER_MODIFIABLE) |
+		(ma->flags & EXT2_FL_USER_MODIFIABLE);
 
-		flags = ext2_mask_flags(inode->i_mode, flags);
+	ext2_set_inode_flags(inode);
+	inode->i_ctime = current_time(inode);
+	mark_inode_dirty(inode);
 
-		inode_lock(inode);
-		/* Is it quota file? Do not allow user to mess with it */
-		if (IS_NOQUOTA(inode)) {
-			inode_unlock(inode);
-			ret = -EPERM;
-			goto setflags_out;
-		}
-		oldflags = ei->i_flags;
+	return 0;
+}
 
-		ret = vfs_ioc_setflags_prepare(inode, oldflags, flags);
-		if (ret) {
-			inode_unlock(inode);
-			goto setflags_out;
-		}
 
-		flags = flags & EXT2_FL_USER_MODIFIABLE;
-		flags |= oldflags & ~EXT2_FL_USER_MODIFIABLE;
-		ei->i_flags = flags;
+long ext2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct ext2_inode_info *ei = EXT2_I(inode);
+	unsigned short rsv_window_size;
+	int ret;
 
-		ext2_set_inode_flags(inode);
-		inode->i_ctime = current_time(inode);
-		inode_unlock(inode);
+	ext2_debug ("cmd = %u, arg = %lu\n", cmd, arg);
 
-		mark_inode_dirty(inode);
-setflags_out:
-		mnt_drop_write_file(filp);
-		return ret;
-	}
+	switch (cmd) {
 	case EXT2_IOC_GETVERSION:
 		return put_user(inode->i_generation, (int __user *) arg);
 	case EXT2_IOC_SETVERSION: {
@@ -163,12 +140,6 @@ long ext2_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
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
index ea980f1e2e99..f1f81d07155d 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -421,6 +421,8 @@ const struct inode_operations ext2_dir_inode_operations = {
 	.get_acl	= ext2_get_acl,
 	.set_acl	= ext2_set_acl,
 	.tmpfile	= ext2_tmpfile,
+	.miscattr_get	= ext2_miscattr_get,
+	.miscattr_set	= ext2_miscattr_set,
 };
 
 const struct inode_operations ext2_special_inode_operations = {
-- 
2.26.2

