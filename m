Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82C130DA1D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 13:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhBCMr0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 07:47:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46421 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231274AbhBCMnW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612356115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nqnHuTDlhnF+gYa6ACau/xbRllmODRsNtHRALQ2cj0c=;
        b=GnRgYTm02QwbD+nDXfSzUx38x92OL15b9NF1nK3+r2WJsnANgLFlnjMR0nu19WKaTV39Qp
        NT+pByXM1yDOv36JNEQvr/i5j9QHFWiCJEN7/xdy53PZ9oJHptKF1EfnXDQOis+fdedQ1B
        /OqIuCBXMfERFRyzjYTMM6ecfruyV3Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-uu_-gRcnNWC-hMzF149hSA-1; Wed, 03 Feb 2021 07:41:54 -0500
X-MC-Unique: uu_-gRcnNWC-hMzF149hSA-1
Received: by mail-ed1-f71.google.com with SMTP id j12so11369286edq.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 04:41:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nqnHuTDlhnF+gYa6ACau/xbRllmODRsNtHRALQ2cj0c=;
        b=Bohv1eHLP3ShnxH/N+R3hL73PRBB4VdoQtynyIUrX1oufbz7IZy7aDcelHR+0be5he
         mQ2grFCqe/DRrQhhWyM6MCno0tiCq5+xdfSz3ySqW1NYwP+xI36179Q92RF5LeuiMsxP
         vmeHTQIZlZtmc1KmHiliU8jR7UxFXF68NsW0Iwmntxb4FpT1uNopIVsqHX6MezxNROXs
         UzMy3t76ZZgPwOuqz3oWOv2XO+afX9YTYk9J1//+lDYJZ+CgEOQajKRuWBUNSp/c5mi+
         5MBHXFBMXzU4sXE90UldFWMGkpcF0x1XU62e7ObGiL4Qj4c1DE38tlqK2ECQOiHqG95D
         xS+A==
X-Gm-Message-State: AOAM5323KoaNMVVHrkD1xRsAQVtMV99eJksscmIvDdXeFL8fwkEjoeqE
        E+Irdf8UKKhesHrcP+Nkh0qokGcZihDWdQWwrgDLMsCv2JE5hWowLxLQasLdodZU35QlnxgMFkf
        VYM9aBzskWHY5m9qFyVJACqBlc9G+qL0aj8Bz2ixYU58Kl7K4ipBzSXGypeblghugEvV3XpS8Wg
        r7rA==
X-Received: by 2002:a50:ed97:: with SMTP id h23mr2626301edr.278.1612356112706;
        Wed, 03 Feb 2021 04:41:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSwFtClNmUsvW3coEeu6yObspJkncW5Brh+PiFq6DIqTdKrbHPO9g5cKL0+2OaWluUe7mSyw==
X-Received: by 2002:a50:ed97:: with SMTP id h23mr2626284edr.278.1612356112400;
        Wed, 03 Feb 2021 04:41:52 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id u9sm953320ejc.57.2021.02.03.04.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:41:51 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH 16/18] reiserfs: convert to miscattr
Date:   Wed,  3 Feb 2021 13:41:10 +0100
Message-Id: <20210203124112.1182614-17-mszeredi@redhat.com>
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
 fs/reiserfs/file.c     |   2 +
 fs/reiserfs/ioctl.c    | 120 +++++++++++++++++++----------------------
 fs/reiserfs/namei.c    |   2 +
 fs/reiserfs/reiserfs.h |   6 +--
 fs/reiserfs/super.c    |   2 +-
 5 files changed, 62 insertions(+), 70 deletions(-)

diff --git a/fs/reiserfs/file.c b/fs/reiserfs/file.c
index 0b641ae694f1..be86ddf898a9 100644
--- a/fs/reiserfs/file.c
+++ b/fs/reiserfs/file.c
@@ -258,4 +258,6 @@ const struct inode_operations reiserfs_file_inode_operations = {
 	.permission = reiserfs_permission,
 	.get_acl = reiserfs_get_acl,
 	.set_acl = reiserfs_set_acl,
+	.miscattr_get = reiserfs_miscattr_get,
+	.miscattr_set = reiserfs_miscattr_set,
 };
diff --git a/fs/reiserfs/ioctl.c b/fs/reiserfs/ioctl.c
index adb21bea3d60..68f4cae19c59 100644
--- a/fs/reiserfs/ioctl.c
+++ b/fs/reiserfs/ioctl.c
@@ -10,6 +10,58 @@
 #include <linux/uaccess.h>
 #include <linux/pagemap.h>
 #include <linux/compat.h>
+#include <linux/miscattr.h>
+
+int reiserfs_miscattr_get(struct dentry *dentry, struct miscattr *ma)
+{
+	struct inode *inode = d_inode(dentry);
+
+	if (!reiserfs_attrs(inode->i_sb))
+		return -ENOTTY;
+
+	miscattr_fill_flags(ma, REISERFS_I(inode)->i_attrs);
+
+	return 0;
+}
+
+int reiserfs_miscattr_set(struct dentry *dentry, struct miscattr *ma)
+{
+	struct inode *inode = d_inode(dentry);
+	unsigned int flags = ma->flags;
+	int err;
+
+	reiserfs_write_lock(inode->i_sb);
+
+	err = -ENOTTY;
+	if (!reiserfs_attrs(inode->i_sb))
+		goto unlock;
+
+	err = -EOPNOTSUPP;
+	if (miscattr_has_xattr(ma))
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
@@ -23,7 +75,6 @@
 long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
-	unsigned int flags;
 	int err = 0;
 
 	reiserfs_write_lock(inode->i_sb);
@@ -32,7 +83,7 @@ long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case REISERFS_IOC_UNPACK:
 		if (S_ISREG(inode->i_mode)) {
 			if (arg)
-				err = reiserfs_unpack(inode, filp);
+				err = reiserfs_unpack(inode);
 		} else
 			err = -ENOTTY;
 		break;
@@ -40,63 +91,6 @@ long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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
-			if (!inode_owner_or_capable(inode)) {
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
@@ -138,12 +132,6 @@ long reiserfs_compat_ioctl(struct file *file, unsigned int cmd,
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
@@ -165,7 +153,7 @@ int reiserfs_commit_write(struct file *f, struct page *page,
  * Function try to convert tail from direct item into indirect.
  * It set up nopack attribute in the REISERFS_I(inode)->nopack
  */
-int reiserfs_unpack(struct inode *inode, struct file *filp)
+int reiserfs_unpack(struct inode *inode)
 {
 	int retval = 0;
 	int index;
diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index 1594687582f0..d595b7f23fac 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -1657,6 +1657,8 @@ const struct inode_operations reiserfs_dir_inode_operations = {
 	.permission = reiserfs_permission,
 	.get_acl = reiserfs_get_acl,
 	.set_acl = reiserfs_set_acl,
+	.miscattr_get = reiserfs_miscattr_get,
+	.miscattr_set = reiserfs_miscattr_set,
 };
 
 /*
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index f69871516167..b7e06fbca65a 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -18,8 +18,6 @@
 
 /* the 32 bit compat definitions with int argument */
 #define REISERFS_IOC32_UNPACK		_IOW(0xCD, 1, int)
-#define REISERFS_IOC32_GETFLAGS		FS_IOC32_GETFLAGS
-#define REISERFS_IOC32_SETFLAGS		FS_IOC32_SETFLAGS
 #define REISERFS_IOC32_GETVERSION	FS_IOC32_GETVERSION
 #define REISERFS_IOC32_SETVERSION	FS_IOC32_SETVERSION
 
@@ -3407,7 +3405,9 @@ __u32 r5_hash(const signed char *msg, int len);
 #define SPARE_SPACE 500
 
 /* prototypes from ioctl.c */
+int reiserfs_miscattr_get(struct dentry *dentry, struct miscattr *ma);
+int reiserfs_miscattr_set(struct dentry *dentry, struct miscattr *ma);
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
2.26.2

