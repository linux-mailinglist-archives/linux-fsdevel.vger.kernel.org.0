Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4512130DA5A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 13:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhBCM6G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 07:58:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20536 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230226AbhBCMnR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612356105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wb+cqxZ2wA5gXcUiIS8MleIaYQSy1UsirMFGfkGX0v8=;
        b=iEsaGGNMPmUSNs0KmCPPMKrtSK1NsocDe7pFf98jsuT/jwAQ0ThkAyujn0YyKZFoQ3CvmW
        VqDhanQAfMKIL2FL9EdFAhiWZKN65sm0EpYgSQNClE2uRxKn11TAeCaQL5t788hbZSK6SO
        vNGGfNx4gdFv3N8kFqfQyo4GFwpdYLk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-HLYYJS21OMePmhTQ0qr-Ug-1; Wed, 03 Feb 2021 07:41:44 -0500
X-MC-Unique: HLYYJS21OMePmhTQ0qr-Ug-1
Received: by mail-ed1-f72.google.com with SMTP id y6so11429112edc.17
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 04:41:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wb+cqxZ2wA5gXcUiIS8MleIaYQSy1UsirMFGfkGX0v8=;
        b=nlsbCd8ieB1z241bbVN5mC4Xjpbank8B+QPk9cN9u5yMkosLP/SwT+EKt0+PabKuED
         qK/zCXBTfWaHmKM9gX+fkNSL6CVik1Lka/ff6Ew60rVxGi5iaqjRwBbC8ymtLydwX7Hh
         o2Caa78rkaQbjaaE4V3jh7zscBvYKlEH94u/uGCvmHwIAGiaEZrUAlnaVfADEZpYV6gb
         ++I6zp3kkks/dYjUT12keIJHc8pkxCu34HvAZs2+sTs6rD+0yyck8DuYU7p/r3IZj0VD
         rnqAm8px8oyt3/QF5trrPG8gkin1Ucq8ahRUab9kLBJv7wbcKRCW1w9uvLHRhV2BlWPD
         b+5g==
X-Gm-Message-State: AOAM532IbDT5vWoRwIH+EaJoXVWaKIQb6pbacavqcs8uBeBD4CEgmy43
        GwpVbGfXCiK2S2ao1lsckHbpl8wHgx6FtWNduIntCXfYGjbmP48wEwwfQ/L7RL9/1wK4IRacDkz
        KOzqYuvZ4Q/hK2e7XXy5QJn9a54UNqP4W1ADXP/mOYSMOjE0UMSHDmPcOpDFDSSe4Jh8VwVZ+fm
        cziQ==
X-Received: by 2002:a05:6402:40c4:: with SMTP id z4mr2682061edb.233.1612356102981;
        Wed, 03 Feb 2021 04:41:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNSRfa4/wVXpr7lN9/8YJ4Gq8vE+cyYx7Jg9ogQlftxMWE3S3q7mdb0imovWx4gSSBkaze6g==
X-Received: by 2002:a05:6402:40c4:: with SMTP id z4mr2682047edb.233.1612356102766;
        Wed, 03 Feb 2021 04:41:42 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id u9sm953320ejc.57.2021.02.03.04.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:41:41 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 08/18] gfs2: convert to miscattr
Date:   Wed,  3 Feb 2021 13:41:02 +0100
Message-Id: <20210203124112.1182614-9-mszeredi@redhat.com>
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
Cc: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/file.c  | 56 ++++++++++++-------------------------------------
 fs/gfs2/inode.c |  4 ++++
 fs/gfs2/inode.h |  2 ++
 3 files changed, 19 insertions(+), 43 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index b39b339feddc..d54c07965665 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -25,6 +25,7 @@
 #include <linux/dlm_plock.h>
 #include <linux/delay.h>
 #include <linux/backing-dev.h>
+#include <linux/miscattr.h>
 
 #include "gfs2.h"
 #include "incore.h"
@@ -153,9 +154,9 @@ static inline u32 gfs2_gfsflags_to_fsflags(struct inode *inode, u32 gfsflags)
 	return fsflags;
 }
 
-static int gfs2_get_flags(struct file *filp, u32 __user *ptr)
+int gfs2_miscattr_get(struct dentry *dentry, struct miscattr *ma)
 {
-	struct inode *inode = file_inode(filp);
+	struct inode *inode = d_inode(dentry);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
 	int error;
@@ -168,8 +169,7 @@ static int gfs2_get_flags(struct file *filp, u32 __user *ptr)
 
 	fsflags = gfs2_gfsflags_to_fsflags(inode, ip->i_diskflags);
 
-	if (put_user(fsflags, ptr))
-		error = -EFAULT;
+	miscattr_fill_flags(ma, fsflags);
 
 	gfs2_glock_dq(&gh);
 out_uninit:
@@ -213,33 +213,19 @@ void gfs2_set_inode_flags(struct inode *inode)
  * @fsflags: The FS_* inode flags passed in
  *
  */
-static int do_gfs2_set_flags(struct file *filp, u32 reqflags, u32 mask,
+static int do_gfs2_set_flags(struct inode *inode, u32 reqflags, u32 mask,
 			     const u32 fsflags)
 {
-	struct inode *inode = file_inode(filp);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct buffer_head *bh;
 	struct gfs2_holder gh;
 	int error;
-	u32 new_flags, flags, oldflags;
-
-	error = mnt_want_write_file(filp);
-	if (error)
-		return error;
+	u32 new_flags, flags;
 
 	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
 	if (error)
-		goto out_drop_write;
-
-	oldflags = gfs2_gfsflags_to_fsflags(inode, ip->i_diskflags);
-	error = vfs_ioc_setflags_prepare(inode, oldflags, fsflags);
-	if (error)
-		goto out;
-
-	error = -EACCES;
-	if (!inode_owner_or_capable(inode))
-		goto out;
+		return error;
 
 	error = 0;
 	flags = ip->i_diskflags;
@@ -252,9 +238,6 @@ static int do_gfs2_set_flags(struct file *filp, u32 reqflags, u32 mask,
 		goto out;
 	if (IS_APPEND(inode) && (new_flags & GFS2_DIF_APPENDONLY))
 		goto out;
-	if (((new_flags ^ flags) & GFS2_DIF_IMMUTABLE) &&
-	    !capable(CAP_LINUX_IMMUTABLE))
-		goto out;
 	if (!IS_IMMUTABLE(inode)) {
 		error = gfs2_permission(inode, MAY_WRITE);
 		if (error)
@@ -291,20 +274,18 @@ static int do_gfs2_set_flags(struct file *filp, u32 reqflags, u32 mask,
 	gfs2_trans_end(sdp);
 out:
 	gfs2_glock_dq_uninit(&gh);
-out_drop_write:
-	mnt_drop_write_file(filp);
 	return error;
 }
 
-static int gfs2_set_flags(struct file *filp, u32 __user *ptr)
+int gfs2_miscattr_set(struct dentry *dentry, struct miscattr *ma)
 {
-	struct inode *inode = file_inode(filp);
-	u32 fsflags, gfsflags = 0;
+	struct inode *inode = d_inode(dentry);
+	u32 fsflags = ma->flags, gfsflags = 0;
 	u32 mask;
 	int i;
 
-	if (get_user(fsflags, ptr))
-		return -EFAULT;
+	if (miscattr_has_xattr(ma))
+		return -EOPNOTSUPP;
 
 	for (i = 0; i < ARRAY_SIZE(fsflag_gfs2flag); i++) {
 		if (fsflags & fsflag_gfs2flag[i].fsflag) {
@@ -325,7 +306,7 @@ static int gfs2_set_flags(struct file *filp, u32 __user *ptr)
 		mask &= ~(GFS2_DIF_TOPDIR | GFS2_DIF_INHERIT_JDATA);
 	}
 
-	return do_gfs2_set_flags(filp, gfsflags, mask, fsflags);
+	return do_gfs2_set_flags(inode, gfsflags, mask, fsflags);
 }
 
 static int gfs2_getlabel(struct file *filp, char __user *label)
@@ -342,10 +323,6 @@ static int gfs2_getlabel(struct file *filp, char __user *label)
 static long gfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	switch(cmd) {
-	case FS_IOC_GETFLAGS:
-		return gfs2_get_flags(filp, (u32 __user *)arg);
-	case FS_IOC_SETFLAGS:
-		return gfs2_set_flags(filp, (u32 __user *)arg);
 	case FITRIM:
 		return gfs2_fitrim(filp, (void __user *)arg);
 	case FS_IOC_GETFSLABEL:
@@ -359,13 +336,6 @@ static long gfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 static long gfs2_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	switch(cmd) {
-	/* These are just misnamed, they actually get/put from/to user an int */
-	case FS_IOC32_GETFLAGS:
-		cmd = FS_IOC_GETFLAGS;
-		break;
-	case FS_IOC32_SETFLAGS:
-		cmd = FS_IOC_SETFLAGS;
-		break;
 	/* Keep this list in sync with gfs2_ioctl */
 	case FITRIM:
 	case FS_IOC_GETFSLABEL:
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index c1b77e8d6b1c..243c3862d43b 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2145,6 +2145,8 @@ static const struct inode_operations gfs2_file_iops = {
 	.get_acl = gfs2_get_acl,
 	.set_acl = gfs2_set_acl,
 	.update_time = gfs2_update_time,
+	.miscattr_get = gfs2_miscattr_get,
+	.miscattr_set = gfs2_miscattr_set,
 };
 
 static const struct inode_operations gfs2_dir_iops = {
@@ -2166,6 +2168,8 @@ static const struct inode_operations gfs2_dir_iops = {
 	.set_acl = gfs2_set_acl,
 	.update_time = gfs2_update_time,
 	.atomic_open = gfs2_atomic_open,
+	.miscattr_get = gfs2_miscattr_get,
+	.miscattr_set = gfs2_miscattr_set,
 };
 
 static const struct inode_operations gfs2_symlink_iops = {
diff --git a/fs/gfs2/inode.h b/fs/gfs2/inode.h
index 8073b8d2c7fa..446fbeb97045 100644
--- a/fs/gfs2/inode.h
+++ b/fs/gfs2/inode.h
@@ -110,6 +110,8 @@ extern loff_t gfs2_seek_hole(struct file *file, loff_t offset);
 extern const struct file_operations gfs2_file_fops_nolock;
 extern const struct file_operations gfs2_dir_fops_nolock;
 
+extern int gfs2_miscattr_get(struct dentry *dentry, struct miscattr *ma);
+extern int gfs2_miscattr_set(struct dentry *dentry, struct miscattr *ma);
 extern void gfs2_set_inode_flags(struct inode *inode);
  
 #ifdef CONFIG_GFS2_FS_LOCKING_DLM
-- 
2.26.2

