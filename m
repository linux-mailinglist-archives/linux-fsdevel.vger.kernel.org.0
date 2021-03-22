Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4AF3447FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 15:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhCVOuI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 10:50:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41195 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231162AbhCVOtc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616424572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Cwv/A5Pnk5CT0fyBXdfr9uvoDC2TwyHyBwylJYn+jg=;
        b=OaWD2fAA2hXZmjtxnTrPIMJW3xe/u25jXJ/Y2s9DFVCUKgUR/iGFQBM7Ia/BErPbUdlzID
        eIPKMXkdH9RpWfcIBN8hOwMj7i/Ot5RiU9KLy9vELZdNufFi/IpQFbhcS97QkqmlhRzoJ+
        dpDKeP+byySNSk1LR0NcErmEerdgCNY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-sorSDT8kMmuqhFIN5vJo-g-1; Mon, 22 Mar 2021 10:49:30 -0400
X-MC-Unique: sorSDT8kMmuqhFIN5vJo-g-1
Received: by mail-ej1-f71.google.com with SMTP id si4so20098926ejb.23
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 07:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Cwv/A5Pnk5CT0fyBXdfr9uvoDC2TwyHyBwylJYn+jg=;
        b=k58xkB8wLGcOGgbOCU5XXmUt2zWBAv9Vi6dMSKBhHre25Mk8R4rcpLFCFsQafTM7Dc
         57zipEZSvNPDhpD2uL0SXcghHNic7dmD5duPt48rRW8p3wum3VTdI4tJUnhCuCl/A1FL
         YH+aNPoqZFbJ+SahaGpZodl0YgTjIrPFeJQaNVPWB5xM9n+KuZ+kNsMlU+M/lb7VdKtp
         RZuuoC5moPUmHxyxnedQugXIdHglqEslO95l9mmISVGDOHmMyDBs5I1UkwQ+XClV2HzD
         BjmZupud2SupbNydkWKsv7v5ae9XFeu6ZbHpXoAOwg9FR18E/dJwV21p5pRx+e+bpCAC
         lWYw==
X-Gm-Message-State: AOAM532jGseLL0xLXsaYm+fMq2sWnB4Atk6+NA21JqnC+dnGhF8Bu1wi
        pT1o/r4XJuj1jnZD0Fx1MnR+zxsG5xjOGeXVX65Pv3VzhjVLUzdH8OkL5S0nWadEE4PdVQhzEGr
        zI3BkV/+jpzWGCExPY2enSINx9+5opN1At0Bv7QvMviWy+pH2af95CxrIQp0oOXokxorqGDo4on
        Kq0Q==
X-Received: by 2002:a17:906:1182:: with SMTP id n2mr141744eja.234.1616424569298;
        Mon, 22 Mar 2021 07:49:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJIYmOlDKByJ9Dk+F+G0oPabnbfghfW6yyl+j7PzALL3UI4Hs/OS2XUo6XBJRDxLON7Oh6bg==
X-Received: by 2002:a17:906:1182:: with SMTP id n2mr141722eja.234.1616424569052;
        Mon, 22 Mar 2021 07:49:29 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id r4sm9793117ejd.125.2021.03.22.07.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:49:28 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH v2 09/18] orangefs: convert to miscattr
Date:   Mon, 22 Mar 2021 15:49:07 +0100
Message-Id: <20210322144916.137245-10-mszeredi@redhat.com>
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
Cc: Mike Marshall <hubcap@omnibond.com>
---
 fs/orangefs/file.c  | 79 ---------------------------------------------
 fs/orangefs/inode.c | 50 ++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 79 deletions(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index 9b28a7132466..ccef8c9dd516 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -375,84 +375,6 @@ static ssize_t orangefs_file_write_iter(struct kiocb *iocb,
 	return ret;
 }
 
-static int orangefs_getflags(struct inode *inode, unsigned long *uval)
-{
-	__u64 val = 0;
-	int ret;
-
-	ret = orangefs_inode_getxattr(inode,
-				      "user.pvfs2.meta_hint",
-				      &val, sizeof(val));
-	if (ret < 0 && ret != -ENODATA)
-		return ret;
-	else if (ret == -ENODATA)
-		val = 0;
-	*uval = val;
-	return 0;
-}
-
-/*
- * Perform a miscellaneous operation on a file.
- */
-static long orangefs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	struct inode *inode = file_inode(file);
-	int ret = -ENOTTY;
-	__u64 val = 0;
-	unsigned long uval;
-
-	gossip_debug(GOSSIP_FILE_DEBUG,
-		     "orangefs_ioctl: called with cmd %d\n",
-		     cmd);
-
-	/*
-	 * we understand some general ioctls on files, such as the immutable
-	 * and append flags
-	 */
-	if (cmd == FS_IOC_GETFLAGS) {
-		ret = orangefs_getflags(inode, &uval);
-		if (ret)
-			return ret;
-		gossip_debug(GOSSIP_FILE_DEBUG,
-			     "orangefs_ioctl: FS_IOC_GETFLAGS: %llu\n",
-			     (unsigned long long)uval);
-		return put_user(uval, (int __user *)arg);
-	} else if (cmd == FS_IOC_SETFLAGS) {
-		unsigned long old_uval;
-
-		ret = 0;
-		if (get_user(uval, (int __user *)arg))
-			return -EFAULT;
-		/*
-		 * ORANGEFS_MIRROR_FL is set internally when the mirroring mode
-		 * is turned on for a file. The user is not allowed to turn
-		 * on this bit, but the bit is present if the user first gets
-		 * the flags and then updates the flags with some new
-		 * settings. So, we ignore it in the following edit. bligon.
-		 */
-		if ((uval & ~ORANGEFS_MIRROR_FL) &
-		    (~(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NOATIME_FL))) {
-			gossip_err("orangefs_ioctl: the FS_IOC_SETFLAGS only supports setting one of FS_IMMUTABLE_FL|FS_APPEND_FL|FS_NOATIME_FL\n");
-			return -EINVAL;
-		}
-		ret = orangefs_getflags(inode, &old_uval);
-		if (ret)
-			return ret;
-		ret = vfs_ioc_setflags_prepare(inode, old_uval, uval);
-		if (ret)
-			return ret;
-		val = uval;
-		gossip_debug(GOSSIP_FILE_DEBUG,
-			     "orangefs_ioctl: FS_IOC_SETFLAGS: %llu\n",
-			     (unsigned long long)val);
-		ret = orangefs_inode_setxattr(inode,
-					      "user.pvfs2.meta_hint",
-					      &val, sizeof(val), 0);
-	}
-
-	return ret;
-}
-
 static vm_fault_t orangefs_fault(struct vm_fault *vmf)
 {
 	struct file *file = vmf->vma->vm_file;
@@ -657,7 +579,6 @@ const struct file_operations orangefs_file_operations = {
 	.read_iter	= orangefs_file_read_iter,
 	.write_iter	= orangefs_file_write_iter,
 	.lock		= orangefs_lock,
-	.unlocked_ioctl	= orangefs_ioctl,
 	.mmap		= orangefs_file_mmap,
 	.open		= generic_file_open,
 	.splice_read    = generic_file_splice_read,
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 5079cfafa8d7..63d420d091f8 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/bvec.h>
+#include <linux/miscattr.h>
 #include "protocol.h"
 #include "orangefs-kernel.h"
 #include "orangefs-bufmap.h"
@@ -954,6 +955,53 @@ int orangefs_update_time(struct inode *inode, struct timespec64 *time, int flags
 	return __orangefs_setattr(inode, &iattr);
 }
 
+static int orangefs_miscattr_get(struct dentry *dentry, struct miscattr *ma)
+{
+	u64 val = 0;
+	int ret;
+
+	gossip_debug(GOSSIP_FILE_DEBUG, "%s: called on %pd\n", __func__,
+		     dentry);
+
+	ret = orangefs_inode_getxattr(d_inode(dentry),
+				      "user.pvfs2.meta_hint",
+				      &val, sizeof(val));
+	if (ret < 0 && ret != -ENODATA)
+		return ret;
+
+	gossip_debug(GOSSIP_FILE_DEBUG, "%s: flags=%u\n", __func__, (u32) val);
+
+	miscattr_fill_flags(ma, val);
+	return 0;
+}
+
+static int orangefs_miscattr_set(struct user_namespace *mnt_userns,
+				 struct dentry *dentry, struct miscattr *ma)
+{
+	u64 val = 0;
+
+	gossip_debug(GOSSIP_FILE_DEBUG, "%s: called on %pd\n", __func__,
+		     dentry);
+	/*
+	 * ORANGEFS_MIRROR_FL is set internally when the mirroring mode is
+	 * turned on for a file. The user is not allowed to turn on this bit,
+	 * but the bit is present if the user first gets the flags and then
+	 * updates the flags with some new settings. So, we ignore it in the
+	 * following edit. bligon.
+	 */
+	if (miscattr_has_xattr(ma) ||
+	    (ma->flags & ~(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NOATIME_FL | ORANGEFS_MIRROR_FL))) {
+		gossip_err("%s: only supports setting one of FS_IMMUTABLE_FL|FS_APPEND_FL|FS_NOATIME_FL\n",
+			   __func__);
+		return -EOPNOTSUPP;
+	}
+	val = ma->flags;
+	gossip_debug(GOSSIP_FILE_DEBUG, "%s: flags=%u\n", __func__, (u32) val);
+	return orangefs_inode_setxattr(d_inode(dentry),
+				       "user.pvfs2.meta_hint",
+				       &val, sizeof(val), 0);
+}
+
 /* ORANGEFS2 implementation of VFS inode operations for files */
 static const struct inode_operations orangefs_file_inode_operations = {
 	.get_acl = orangefs_get_acl,
@@ -963,6 +1011,8 @@ static const struct inode_operations orangefs_file_inode_operations = {
 	.listxattr = orangefs_listxattr,
 	.permission = orangefs_permission,
 	.update_time = orangefs_update_time,
+	.miscattr_get = orangefs_miscattr_get,
+	.miscattr_set = orangefs_miscattr_set,
 };
 
 static int orangefs_init_iops(struct inode *inode)
-- 
2.30.2

