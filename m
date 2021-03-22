Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840F8344805
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 15:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhCVOuY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 10:50:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231237AbhCVOtl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616424579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=69DYhwT5xB2HAhx/Tr5I8TuWYr5//KxtYgUgHfgI45Y=;
        b=I8Sv/u52g6Of6Fy6UYSPFxiVeCrrAGNyV21VFyniFV9TPIwro6KrYVOtYdyzCMWGZuVKDb
        UCCGxQ/NjjNBK64VC10vfDe1RvyQV/3XsKgbFHb9oirKxPCt09UP0j936fcvLEQUoBcYZ4
        4RRLn08+1rTMBe4LLQVwgU5BDe4r3qI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-Mkh0h7xrPjamYl7xz4upuA-1; Mon, 22 Mar 2021 10:49:38 -0400
X-MC-Unique: Mkh0h7xrPjamYl7xz4upuA-1
Received: by mail-ej1-f72.google.com with SMTP id t21so12005646ejf.14
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 07:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=69DYhwT5xB2HAhx/Tr5I8TuWYr5//KxtYgUgHfgI45Y=;
        b=PD2wHxD4FSXomwaVFjXBMtVBcFQUb3Nj7+AEZYPKj1XQm4bgmnFkQHOhPjoWRAvtFd
         hQ2dJQWjByPaiklVZuaNav3IvxXw1HTZ+xLA8POR++1Ist2q9dHNmyIdUY1uy1LzuX66
         JgrM7hBX1BedZ3d1qsuU5y4/WNk8X3g2pl+ThWD3ZcanhwdiCIWAHkPNDudSpg+SmpKw
         3SchBgGm37QHVrfrLljaiWs32VRSIMzId0LviEMC8II/u2d+hhKu8DwVxny9s6X1bYsg
         ypGUmpiprf2JWr+QRjQfZKSeOQ8IY5A+lXoGptqVKXXMovLSDLi2//1CcEOZcyR1q25+
         Z8Lw==
X-Gm-Message-State: AOAM5302/R1ilqo76nyy5xMcVF7Vx6NhJY9nivj33paO4TEd5M/J2J1b
        Kzl3Vdd2rzXt9pM79xzcq/YZvEpSQ0PHbwr+2/Yg5FWQp3sY9Bqbg3cWM3+gNhj/n5MpKVybSRE
        0CrTpS1IjbF1adP21u8BSttraOB9t5XfKHYDAUEdYmQvVl4DokjO1NfWByTkI01vzU4nQMby+3x
        W4vA==
X-Received: by 2002:a17:906:a896:: with SMTP id ha22mr62704ejb.503.1616424576777;
        Mon, 22 Mar 2021 07:49:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgxjDgf0jKR6n6QloHOiLhHT0Iw1VMJEHAtI03b7e6ceDKVUlWEgSWmP2nFfv9p3fyHPIWlA==
X-Received: by 2002:a17:906:a896:: with SMTP id ha22mr62683ejb.503.1616424576527;
        Mon, 22 Mar 2021 07:49:36 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id r4sm9793117ejd.125.2021.03.22.07.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:49:36 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>
Subject: [PATCH v2 15/18] ocfs2: convert to miscattr
Date:   Mon, 22 Mar 2021 15:49:13 +0100
Message-Id: <20210322144916.137245-16-mszeredi@redhat.com>
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
Cc: Joel Becker <jlbec@evilplan.org>
---
 fs/ocfs2/file.c        |  2 ++
 fs/ocfs2/ioctl.c       | 59 ++++++++++++++----------------------------
 fs/ocfs2/ioctl.h       |  3 +++
 fs/ocfs2/namei.c       |  3 +++
 fs/ocfs2/ocfs2_ioctl.h |  8 ------
 5 files changed, 27 insertions(+), 48 deletions(-)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 6611c64ca0be..fa92629ff285 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2645,6 +2645,8 @@ const struct inode_operations ocfs2_file_iops = {
 	.fiemap		= ocfs2_fiemap,
 	.get_acl	= ocfs2_iop_get_acl,
 	.set_acl	= ocfs2_iop_set_acl,
+	.miscattr_get	= ocfs2_miscattr_get,
+	.miscattr_set	= ocfs2_miscattr_set,
 };
 
 const struct inode_operations ocfs2_special_file_iops = {
diff --git a/fs/ocfs2/ioctl.c b/fs/ocfs2/ioctl.c
index 50c9b30ee9f6..34ea3cde01bb 100644
--- a/fs/ocfs2/ioctl.c
+++ b/fs/ocfs2/ioctl.c
@@ -10,6 +10,7 @@
 #include <linux/mount.h>
 #include <linux/blkdev.h>
 #include <linux/compat.h>
+#include <linux/miscattr.h>
 
 #include <cluster/masklog.h>
 
@@ -61,8 +62,10 @@ static inline int o2info_coherent(struct ocfs2_info_request *req)
 	return (!(req->ir_flags & OCFS2_INFO_FL_NON_COHERENT));
 }
 
-static int ocfs2_get_inode_attr(struct inode *inode, unsigned *flags)
+int ocfs2_miscattr_get(struct dentry *dentry, struct miscattr *ma)
 {
+	struct inode *inode = d_inode(dentry);
+	unsigned int flags;
 	int status;
 
 	status = ocfs2_inode_lock(inode, NULL, 0);
@@ -71,15 +74,19 @@ static int ocfs2_get_inode_attr(struct inode *inode, unsigned *flags)
 		return status;
 	}
 	ocfs2_get_inode_flags(OCFS2_I(inode));
-	*flags = OCFS2_I(inode)->ip_attr;
+	flags = OCFS2_I(inode)->ip_attr;
 	ocfs2_inode_unlock(inode, 0);
 
+	miscattr_fill_flags(ma, flags & OCFS2_FL_VISIBLE);
+
 	return status;
 }
 
-static int ocfs2_set_inode_attr(struct inode *inode, unsigned flags,
-				unsigned mask)
+int ocfs2_miscattr_set(struct user_namespace *mnt_userns,
+		       struct dentry *dentry, struct miscattr *ma)
 {
+	struct inode *inode = d_inode(dentry);
+	unsigned int flags = ma->flags;
 	struct ocfs2_inode_info *ocfs2_inode = OCFS2_I(inode);
 	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 	handle_t *handle = NULL;
@@ -87,7 +94,8 @@ static int ocfs2_set_inode_attr(struct inode *inode, unsigned flags,
 	unsigned oldflags;
 	int status;
 
-	inode_lock(inode);
+	if (miscattr_has_xattr(ma))
+		return -EOPNOTSUPP;
 
 	status = ocfs2_inode_lock(inode, &bh, 1);
 	if (status < 0) {
@@ -95,19 +103,17 @@ static int ocfs2_set_inode_attr(struct inode *inode, unsigned flags,
 		goto bail;
 	}
 
-	status = -EACCES;
-	if (!inode_owner_or_capable(&init_user_ns, inode))
-		goto bail_unlock;
-
 	if (!S_ISDIR(inode->i_mode))
 		flags &= ~OCFS2_DIRSYNC_FL;
 
 	oldflags = ocfs2_inode->ip_attr;
-	flags = flags & mask;
-	flags |= oldflags & ~mask;
+	flags = flags & OCFS2_FL_MODIFIABLE;
+	flags |= oldflags & ~OCFS2_FL_MODIFIABLE;
 
-	status = vfs_ioc_setflags_prepare(inode, oldflags, flags);
-	if (status)
+	/* Check already done by VFS, but repeat with ocfs lock */
+	status = -EPERM;
+	if ((flags ^ oldflags) & (FS_APPEND_FL | FS_IMMUTABLE_FL) &&
+	    !capable(CAP_LINUX_IMMUTABLE))
 		goto bail_unlock;
 
 	handle = ocfs2_start_trans(osb, OCFS2_INODE_UPDATE_CREDITS);
@@ -129,8 +135,6 @@ static int ocfs2_set_inode_attr(struct inode *inode, unsigned flags,
 bail_unlock:
 	ocfs2_inode_unlock(inode, 1);
 bail:
-	inode_unlock(inode);
-
 	brelse(bh);
 
 	return status;
@@ -836,7 +840,6 @@ static int ocfs2_info_handle(struct inode *inode, struct ocfs2_info *info,
 long ocfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
-	unsigned int flags;
 	int new_clusters;
 	int status;
 	struct ocfs2_space_resv sr;
@@ -849,24 +852,6 @@ long ocfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	void __user *argp = (void __user *)arg;
 
 	switch (cmd) {
-	case OCFS2_IOC_GETFLAGS:
-		status = ocfs2_get_inode_attr(inode, &flags);
-		if (status < 0)
-			return status;
-
-		flags &= OCFS2_FL_VISIBLE;
-		return put_user(flags, (int __user *) arg);
-	case OCFS2_IOC_SETFLAGS:
-		if (get_user(flags, (int __user *) arg))
-			return -EFAULT;
-
-		status = mnt_want_write_file(filp);
-		if (status)
-			return status;
-		status = ocfs2_set_inode_attr(inode, flags,
-			OCFS2_FL_MODIFIABLE);
-		mnt_drop_write_file(filp);
-		return status;
 	case OCFS2_IOC_RESVSP:
 	case OCFS2_IOC_RESVSP64:
 	case OCFS2_IOC_UNRESVSP:
@@ -959,12 +944,6 @@ long ocfs2_compat_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 	void __user *argp = (void __user *)arg;
 
 	switch (cmd) {
-	case OCFS2_IOC32_GETFLAGS:
-		cmd = OCFS2_IOC_GETFLAGS;
-		break;
-	case OCFS2_IOC32_SETFLAGS:
-		cmd = OCFS2_IOC_SETFLAGS;
-		break;
 	case OCFS2_IOC_RESVSP:
 	case OCFS2_IOC_RESVSP64:
 	case OCFS2_IOC_UNRESVSP:
diff --git a/fs/ocfs2/ioctl.h b/fs/ocfs2/ioctl.h
index 9f5e4d95e37f..575e754b7d16 100644
--- a/fs/ocfs2/ioctl.h
+++ b/fs/ocfs2/ioctl.h
@@ -11,6 +11,9 @@
 #ifndef OCFS2_IOCTL_PROTO_H
 #define OCFS2_IOCTL_PROTO_H
 
+int ocfs2_miscattr_get(struct dentry *dentry, struct miscattr *ma);
+int ocfs2_miscattr_set(struct user_namespace *mnt_userns,
+		       struct dentry *dentry, struct miscattr *ma);
 long ocfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long ocfs2_compat_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 3abdd36da2e2..ec8c3b813532 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -50,6 +50,7 @@
 #include "xattr.h"
 #include "acl.h"
 #include "ocfs2_trace.h"
+#include "ioctl.h"
 
 #include "buffer_head_io.h"
 
@@ -2918,4 +2919,6 @@ const struct inode_operations ocfs2_dir_iops = {
 	.fiemap         = ocfs2_fiemap,
 	.get_acl	= ocfs2_iop_get_acl,
 	.set_acl	= ocfs2_iop_set_acl,
+	.miscattr_get	= ocfs2_miscattr_get,
+	.miscattr_set	= ocfs2_miscattr_set,
 };
diff --git a/fs/ocfs2/ocfs2_ioctl.h b/fs/ocfs2/ocfs2_ioctl.h
index d7b31734f6be..273616bd4f19 100644
--- a/fs/ocfs2/ocfs2_ioctl.h
+++ b/fs/ocfs2/ocfs2_ioctl.h
@@ -12,14 +12,6 @@
 #ifndef OCFS2_IOCTL_H
 #define OCFS2_IOCTL_H
 
-/*
- * ioctl commands
- */
-#define OCFS2_IOC_GETFLAGS	FS_IOC_GETFLAGS
-#define OCFS2_IOC_SETFLAGS	FS_IOC_SETFLAGS
-#define OCFS2_IOC32_GETFLAGS	FS_IOC32_GETFLAGS
-#define OCFS2_IOC32_SETFLAGS	FS_IOC32_SETFLAGS
-
 /*
  * Space reservation / allocation / free ioctls and argument structure
  * are designed to be compatible with XFS.
-- 
2.30.2

