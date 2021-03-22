Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D763447F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 15:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhCVOt6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 10:49:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57264 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230492AbhCVOtZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616424565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EGYFcZIgz7V4SyvxtDTIzKTncUqnpA6CZvB0bGEcNv8=;
        b=PhEfmnbs8H2GzuE8gmTcs9036PMlr3IkS0BT+D8L9L0INygMJth7CgZ+kOgi8/t6wXZur2
        Oa1LG0TlHUml/cyWP2FLp/2HEdV8UhX1ReV8K2/jWdB/GodaAPs9Chzu1u3PB/YvpxLajR
        NLTJhfxiYoNFZHD3GdyBvya3QSDjN5E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-43S75rGRO-eur5XpXclEqQ-1; Mon, 22 Mar 2021 10:49:23 -0400
X-MC-Unique: 43S75rGRO-eur5XpXclEqQ-1
Received: by mail-ej1-f69.google.com with SMTP id au15so20098873ejc.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 07:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGYFcZIgz7V4SyvxtDTIzKTncUqnpA6CZvB0bGEcNv8=;
        b=tRURMv09OYMc3UUWAvMGK8Dgg1o3o4VMrG4SXZPbdW3ddOGFbHm03sLCWFeRq08SLn
         yUmoTxQJqa9D5LAK6Y2hjpEJeEjlfgjKnsHuWNKzYvyyaGEeAIv1Vg2UTJUnCh8An6UB
         QqejudeT1+FPMLElviwcAP3xOXYAzdkehRsY8FfT3t1cIcBIoxqINv2tvAVmgiQjzkgk
         ntstm67SPmkyxWQOwitetLyB7zblOj9ihmtmcz7kRBUwnHuAPuc2MY8PqUo0rn9qPnwr
         gsX1njLT869ZhsOIsek8LhvbMAFgWmz1AFkbMF2yblPJHpWrhHWfDeUWfYhkn7Bxv1S6
         4G3g==
X-Gm-Message-State: AOAM530Dd7Dk7WbmzPPxl1g67x7ZhgsW6X56RX+93BR+DnGblvAAslsW
        /+O1LxHbgcebn0ZZvoJdjSTOXQM2XT+6wscROkRyRednmRIJT55LzHakmNAQis5Kcrd56BHDO87
        /8q2Jjv5moG4qWZcrmO2/BI5CMXD1aW8Jr/nekc1exWeQt81ABlnsJlWSY7ClgqUJQOIvBLaKKA
        mltQ==
X-Received: by 2002:a17:906:ae88:: with SMTP id md8mr132574ejb.264.1616424562465;
        Mon, 22 Mar 2021 07:49:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzkql8FbFnQsCmMCsOiz5ks4FVtEnlZIw5Q3bV5H0qEzH+Ljhf8TMKKFEr6QaZUostPU0wRA==
X-Received: by 2002:a17:906:ae88:: with SMTP id md8mr132558ejb.264.1616424562275;
        Mon, 22 Mar 2021 07:49:22 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id r4sm9793117ejd.125.2021.03.22.07.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:49:21 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 03/18] ovl: stack miscattr ops
Date:   Mon, 22 Mar 2021 15:49:01 +0100
Message-Id: <20210322144916.137245-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210322144916.137245-1-mszeredi@redhat.com>
References: <20210322144916.137245-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add stacking for the miscattr operations.

Add hack for calling security_file_ioctl() for now.  Probably better to
have a pair of specific hooks for these operations.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/dir.c       |  2 ++
 fs/overlayfs/inode.c     | 77 ++++++++++++++++++++++++++++++++++++++++
 fs/overlayfs/overlayfs.h |  3 ++
 3 files changed, 82 insertions(+)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 836f14b9d3a6..3cf091d0d0ff 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1301,4 +1301,6 @@ const struct inode_operations ovl_dir_inode_operations = {
 	.listxattr	= ovl_listxattr,
 	.get_acl	= ovl_get_acl,
 	.update_time	= ovl_update_time,
+	.miscattr_get	= ovl_miscattr_get,
+	.miscattr_set	= ovl_miscattr_set,
 };
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 003cf83bf78a..4915eea6d115 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -11,6 +11,8 @@
 #include <linux/posix_acl.h>
 #include <linux/ratelimit.h>
 #include <linux/fiemap.h>
+#include <linux/miscattr.h>
+#include <linux/security.h>
 #include "overlayfs.h"
 
 
@@ -500,6 +502,79 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	return err;
 }
 
+/*
+ * Work around the fact that security_file_ioctl() takes a file argument.
+ * Introducing security_inode_miscattr_get/set() hooks would solve this issue
+ * properly.
+ */
+static int ovl_security_miscattr(struct dentry *dentry, struct miscattr *ma,
+				 bool set)
+{
+	struct path realpath;
+	struct file *file;
+	unsigned int cmd;
+	int err;
+
+	ovl_path_real(dentry, &realpath);
+	file = dentry_open(&realpath, O_RDONLY, current_cred());
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	if (set)
+		cmd = ma->xattr_valid ? FS_IOC_FSSETXATTR : FS_IOC_SETFLAGS;
+	else
+		cmd = ma->xattr_valid ? FS_IOC_FSGETXATTR : FS_IOC_GETFLAGS;
+
+	err = security_file_ioctl(file, cmd, 0);
+	fput(file);
+
+	return err;
+}
+
+int ovl_miscattr_set(struct user_namespace *mnt_userns,
+		     struct dentry *dentry, struct miscattr *ma)
+{
+	struct inode *inode = d_inode(dentry);
+	struct dentry *upperdentry;
+	const struct cred *old_cred;
+	int err;
+
+	err = ovl_want_write(dentry);
+	if (err)
+		goto out;
+
+	err = ovl_copy_up(dentry);
+	if (!err) {
+		upperdentry = ovl_dentry_upper(dentry);
+
+		old_cred = ovl_override_creds(inode->i_sb);
+		err = ovl_security_miscattr(dentry, ma, true);
+		if (!err)
+			err = vfs_miscattr_set(&init_user_ns, upperdentry, ma);
+		revert_creds(old_cred);
+		ovl_copyflags(ovl_inode_real(inode), inode);
+	}
+	ovl_drop_write(dentry);
+out:
+	return err;
+}
+
+int ovl_miscattr_get(struct dentry *dentry, struct miscattr *ma)
+{
+	struct inode *inode = d_inode(dentry);
+	struct dentry *realdentry = ovl_dentry_real(dentry);
+	const struct cred *old_cred;
+	int err;
+
+	old_cred = ovl_override_creds(inode->i_sb);
+	err = ovl_security_miscattr(dentry, ma, false);
+	if (!err)
+		err = vfs_miscattr_get(realdentry, ma);
+	revert_creds(old_cred);
+
+	return err;
+}
+
 static const struct inode_operations ovl_file_inode_operations = {
 	.setattr	= ovl_setattr,
 	.permission	= ovl_permission,
@@ -508,6 +583,8 @@ static const struct inode_operations ovl_file_inode_operations = {
 	.get_acl	= ovl_get_acl,
 	.update_time	= ovl_update_time,
 	.fiemap		= ovl_fiemap,
+	.miscattr_get	= ovl_miscattr_get,
+	.miscattr_set	= ovl_miscattr_set,
 };
 
 static const struct inode_operations ovl_symlink_inode_operations = {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 95cff83786a5..abd4d1316897 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -521,6 +521,9 @@ int __init ovl_aio_request_cache_init(void);
 void ovl_aio_request_cache_destroy(void);
 long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 long ovl_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+int ovl_miscattr_get(struct dentry *dentry, struct miscattr *ma);
+int ovl_miscattr_set(struct user_namespace *mnt_userns,
+		     struct dentry *dentry, struct miscattr *ma);
 
 /* copy_up.c */
 int ovl_copy_up(struct dentry *dentry);
-- 
2.30.2

