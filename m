Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2702030DA2C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 13:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhBCMum (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 07:50:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32298 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231254AbhBCMnV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612356114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N2F4JlUyi9rC6B6v+p4yaIoMc0QaXFnLLqtsLnyjj7M=;
        b=RloMhPMtYxenM6y7qZdKXtNONpze08IZWDCwcBdiFuSUoUYDsAx4hLnHOIpQ9/wRTxTlae
        N8s1YqTkGfao4us3cRO3fZZCVBAVI8PKYb1beMx4jtGuhyaPMaSIepHow1GAJ56F6wVWB9
        PCQmFQHC9rmdNoUDb7SNSnrOS9Ek2Ps=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-YyjE7nh5PQSVodfwKIG2gw-1; Wed, 03 Feb 2021 07:41:53 -0500
X-MC-Unique: YyjE7nh5PQSVodfwKIG2gw-1
Received: by mail-ej1-f71.google.com with SMTP id aq28so891795ejc.20
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 04:41:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N2F4JlUyi9rC6B6v+p4yaIoMc0QaXFnLLqtsLnyjj7M=;
        b=PzsOmEZLIy2HyIKdqyT+W0SxMpFZ0KCBDROn9fQuQSbxmbuQ5FRh+mrP4oQzszmb+r
         76mYbNgEs5L049AoutJFadL7DDLsDpz15q2J5NBms6gUHerWu0djM/b002KNcH5YgKoI
         lgfeclQGd1uIcIFhNcydTs9GB6znMbsBPCBlhZVcP2ghKY+/AgGzAeB/fbbsqY1XOI6w
         /+J/xxKWS7lFLuSw8EVyD2D3S8LXdCbi6OG0AkKuGNHPgZoQk45kl0plMRFYVdk7Nggn
         08Afya/FxkUtyaVqOeOchHRhNPIHPVbWT00oApeSs31c8eWx7V/QeQQQsYbaLPwwrqHF
         RYoQ==
X-Gm-Message-State: AOAM531tMFypFqNrLiAKpnKwEU9CZx+5xBAiFdb+q5tqrM5PBZXKvcwK
        D20iFEYG62ZZ2FHoUR/rqPU/V9o0BR236JStTG6xZqxBrf1/H2+LG263wO51LAhqf3/buUtvYP4
        r/6wYwaTYKfV+i1XwxxjquIFr29YTEI/rZt07e358Sfd5iF6PeBQMlxxyTKT1mZngo0Hg0hw1aR
        AnSA==
X-Received: by 2002:a05:6402:430c:: with SMTP id m12mr2790056edc.299.1612356111487;
        Wed, 03 Feb 2021 04:41:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKhZeqr+Wh5TYDloWpYGbn96dhPyDjIIYfIZB5nV2v/IeOrM+mJMxOZ0zap2FDw1wLjuVeJg==
X-Received: by 2002:a05:6402:430c:: with SMTP id m12mr2790034edc.299.1612356111247;
        Wed, 03 Feb 2021 04:41:51 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id u9sm953320ejc.57.2021.02.03.04.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:41:50 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Subject: [PATCH 15/18] ocfs2: convert to miscattr
Date:   Wed,  3 Feb 2021 13:41:09 +0100
Message-Id: <20210203124112.1182614-16-mszeredi@redhat.com>
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
Cc: Joel Becker <jlbec@evilplan.org>
---
 fs/ocfs2/file.c        |  2 ++
 fs/ocfs2/ioctl.c       | 58 +++++++++++++-----------------------------
 fs/ocfs2/ioctl.h       |  2 ++
 fs/ocfs2/namei.c       |  3 +++
 fs/ocfs2/ocfs2_ioctl.h |  8 ------
 5 files changed, 25 insertions(+), 48 deletions(-)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 85979e2214b3..4e04341c22bc 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2643,6 +2643,8 @@ const struct inode_operations ocfs2_file_iops = {
 	.fiemap		= ocfs2_fiemap,
 	.get_acl	= ocfs2_iop_get_acl,
 	.set_acl	= ocfs2_iop_set_acl,
+	.miscattr_get	= ocfs2_miscattr_get,
+	.miscattr_set	= ocfs2_miscattr_set,
 };
 
 const struct inode_operations ocfs2_special_file_iops = {
diff --git a/fs/ocfs2/ioctl.c b/fs/ocfs2/ioctl.c
index 89984172fc4a..1131a5bb8bb3 100644
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
@@ -71,15 +74,18 @@ static int ocfs2_get_inode_attr(struct inode *inode, unsigned *flags)
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
+int ocfs2_miscattr_set(struct dentry *dentry, struct miscattr *ma)
 {
+	struct inode *inode = d_inode(dentry);
+	unsigned int flags = ma->flags;
 	struct ocfs2_inode_info *ocfs2_inode = OCFS2_I(inode);
 	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 	handle_t *handle = NULL;
@@ -87,7 +93,8 @@ static int ocfs2_set_inode_attr(struct inode *inode, unsigned flags,
 	unsigned oldflags;
 	int status;
 
-	inode_lock(inode);
+	if (miscattr_has_xattr(ma))
+		return -EOPNOTSUPP;
 
 	status = ocfs2_inode_lock(inode, &bh, 1);
 	if (status < 0) {
@@ -95,19 +102,17 @@ static int ocfs2_set_inode_attr(struct inode *inode, unsigned flags,
 		goto bail;
 	}
 
-	status = -EACCES;
-	if (!inode_owner_or_capable(inode))
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
@@ -129,8 +134,6 @@ static int ocfs2_set_inode_attr(struct inode *inode, unsigned flags,
 bail_unlock:
 	ocfs2_inode_unlock(inode, 1);
 bail:
-	inode_unlock(inode);
-
 	brelse(bh);
 
 	return status;
@@ -836,7 +839,6 @@ static int ocfs2_info_handle(struct inode *inode, struct ocfs2_info *info,
 long ocfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
-	unsigned int flags;
 	int new_clusters;
 	int status;
 	struct ocfs2_space_resv sr;
@@ -849,24 +851,6 @@ long ocfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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
@@ -959,12 +943,6 @@ long ocfs2_compat_ioctl(struct file *file, unsigned cmd, unsigned long arg)
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
index 9f5e4d95e37f..f69ec2260865 100644
--- a/fs/ocfs2/ioctl.h
+++ b/fs/ocfs2/ioctl.h
@@ -11,6 +11,8 @@
 #ifndef OCFS2_IOCTL_PROTO_H
 #define OCFS2_IOCTL_PROTO_H
 
+int ocfs2_miscattr_get(struct dentry *dentry, struct miscattr *ma);
+int ocfs2_miscattr_set(struct dentry *dentry, struct miscattr *ma);
 long ocfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long ocfs2_compat_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 2a237ab00453..f955aa7891bb 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -50,6 +50,7 @@
 #include "xattr.h"
 #include "acl.h"
 #include "ocfs2_trace.h"
+#include "ioctl.h"
 
 #include "buffer_head_io.h"
 
@@ -2913,4 +2914,6 @@ const struct inode_operations ocfs2_dir_iops = {
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
2.26.2

