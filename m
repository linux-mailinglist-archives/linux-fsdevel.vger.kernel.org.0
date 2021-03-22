Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A623447F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 15:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhCVOuE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 10:50:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53394 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230341AbhCVOtb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616424571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m0UT6buOCuHiMZiz7dgH8JIkhEVns2iHBom9UOEBNqw=;
        b=PDzWdknNKOKhansqCz6adfx91fg210Z65qdbye8BAr2zU5QNX69qaXN++qotSZVI0ZxsZ6
        f6qR2AnDCAO/7GWZVSuhXftcyjcGoJjPd9K5WcYOf/+JZiZPFIEWT3NUfRlLnB3B98UIqh
        eTC6NiF/hzZYJJubkGakcJVJ4US2g4g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-LgorbzdDPcamZdM7hXbekQ-1; Mon, 22 Mar 2021 10:49:29 -0400
X-MC-Unique: LgorbzdDPcamZdM7hXbekQ-1
Received: by mail-ej1-f72.google.com with SMTP id e13so19897246ejd.21
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 07:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m0UT6buOCuHiMZiz7dgH8JIkhEVns2iHBom9UOEBNqw=;
        b=ni1+rYEwbvQ8l1g4VTTtkqmJgLx/8ZuTkZKDnw127ORa51BRRjzHUVt/2aXb4SzeMm
         5G6skuqASgf0er7+autZcDioB3xkhknFE+1tAYHa6hZxpnXfdgNJ8UD7HRJsO3XQ4Nh1
         SeEiehhvrAiMxYYR2rqanR9yHa00eSEjmO5jFezBt3D1ZZ6x1gJf3/1rYCT3jU8VhdOJ
         XtCBaayFDfdBGhWAInTCnUmVlno06TzE+zZ+87PLu9xOo26wU65sSZ7bNvk2JiP8sSJW
         am/vREeTz42Z982rZO2lZcLg9khtHtyodjOvDtSSjRIj0VZ621zrVYbiXquBjPFBOoF0
         IbRQ==
X-Gm-Message-State: AOAM530Pvf2q6vYVHVil4h/oYt1x2h9UTlsMjc0BDTx7jYPbhaHfOFwk
        Zbc6E+6/zmBCZ5Nr9zroaekzz5OihJX0xLNRAC8gSvNfEmVpIq1dVDM2KIiw4j4Tzvdqa/6eZPh
        +OgFdh40LrfJ9XXJqYpqpmpWrttxYdTEr6b2AIIq5JLnUzJXE8OgM1k5FNnbHe9+DLzxpBw/JZG
        SYuQ==
X-Received: by 2002:aa7:c450:: with SMTP id n16mr25328823edr.16.1616424568149;
        Mon, 22 Mar 2021 07:49:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqQo93gPshAMY/nkGLVOa42liJvcoNs+fvYz3SgxSrOfsT/nVV8MKZ138x086vyC6g1I53Tg==
X-Received: by 2002:aa7:c450:: with SMTP id n16mr25328799edr.16.1616424567953;
        Mon, 22 Mar 2021 07:49:27 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id r4sm9793117ejd.125.2021.03.22.07.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:49:27 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 08/18] gfs2: convert to miscattr
Date:   Mon, 22 Mar 2021 15:49:06 +0100
Message-Id: <20210322144916.137245-9-mszeredi@redhat.com>
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
Cc: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/file.c  | 57 ++++++++++++-------------------------------------
 fs/gfs2/inode.c |  4 ++++
 fs/gfs2/inode.h |  3 +++
 3 files changed, 21 insertions(+), 43 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 2d500f90cdac..b77669089f9a 100644
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
-	if (!inode_owner_or_capable(&init_user_ns, inode))
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
 		error = gfs2_permission(&init_user_ns, inode, MAY_WRITE);
 		if (error)
@@ -291,20 +274,19 @@ static int do_gfs2_set_flags(struct file *filp, u32 reqflags, u32 mask,
 	gfs2_trans_end(sdp);
 out:
 	gfs2_glock_dq_uninit(&gh);
-out_drop_write:
-	mnt_drop_write_file(filp);
 	return error;
 }
 
-static int gfs2_set_flags(struct file *filp, u32 __user *ptr)
+int gfs2_miscattr_set(struct user_namespace *mnt_userns,
+		      struct dentry *dentry, struct miscattr *ma)
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
@@ -325,7 +307,7 @@ static int gfs2_set_flags(struct file *filp, u32 __user *ptr)
 		mask &= ~(GFS2_DIF_TOPDIR | GFS2_DIF_INHERIT_JDATA);
 	}
 
-	return do_gfs2_set_flags(filp, gfsflags, mask, fsflags);
+	return do_gfs2_set_flags(inode, gfsflags, mask, fsflags);
 }
 
 static int gfs2_getlabel(struct file *filp, char __user *label)
@@ -342,10 +324,6 @@ static int gfs2_getlabel(struct file *filp, char __user *label)
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
@@ -359,13 +337,6 @@ static long gfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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
index c9775d5c6594..c01d9cfb21e7 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2157,6 +2157,8 @@ static const struct inode_operations gfs2_file_iops = {
 	.get_acl = gfs2_get_acl,
 	.set_acl = gfs2_set_acl,
 	.update_time = gfs2_update_time,
+	.miscattr_get = gfs2_miscattr_get,
+	.miscattr_set = gfs2_miscattr_set,
 };
 
 static const struct inode_operations gfs2_dir_iops = {
@@ -2178,6 +2180,8 @@ static const struct inode_operations gfs2_dir_iops = {
 	.set_acl = gfs2_set_acl,
 	.update_time = gfs2_update_time,
 	.atomic_open = gfs2_atomic_open,
+	.miscattr_get = gfs2_miscattr_get,
+	.miscattr_set = gfs2_miscattr_set,
 };
 
 static const struct inode_operations gfs2_symlink_iops = {
diff --git a/fs/gfs2/inode.h b/fs/gfs2/inode.h
index c447bd5b3017..bd2fbbe58def 100644
--- a/fs/gfs2/inode.h
+++ b/fs/gfs2/inode.h
@@ -111,6 +111,9 @@ extern loff_t gfs2_seek_hole(struct file *file, loff_t offset);
 extern const struct file_operations gfs2_file_fops_nolock;
 extern const struct file_operations gfs2_dir_fops_nolock;
 
+extern int gfs2_miscattr_get(struct dentry *dentry, struct miscattr *ma);
+extern int gfs2_miscattr_set(struct user_namespace *mnt_userns,
+			     struct dentry *dentry, struct miscattr *ma);
 extern void gfs2_set_inode_flags(struct inode *inode);
  
 #ifdef CONFIG_GFS2_FS_LOCKING_DLM
-- 
2.30.2

