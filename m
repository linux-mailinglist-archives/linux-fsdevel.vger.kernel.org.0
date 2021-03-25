Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F56D349A6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 20:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhCYTiq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 15:38:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47750 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230288AbhCYTiL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616701091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2a36sZlXTD2PebgeWXREn+rNLlA1N6ZqRns0rdZ0voA=;
        b=DzH+ZqnmIYIIFv8MfCxQ6+e4YEVFUMafVT4eG2sdnIUr07DcYmrDNhl3Tq9taX9FRQ1oZz
        0ttHQJ82FTX6LFm/1NtmKFoBE69NGR0Lgr3wKyBD8cfBVrA2pzSRS8xrnq0jkRbI2UP2K7
        B6t/PSoI+106ZYuFbieRumQ5TEosXaU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-1rKXCNZbO4KpYtENFINAsQ-1; Thu, 25 Mar 2021 15:38:09 -0400
X-MC-Unique: 1rKXCNZbO4KpYtENFINAsQ-1
Received: by mail-ed1-f70.google.com with SMTP id r19so3211598edv.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 12:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2a36sZlXTD2PebgeWXREn+rNLlA1N6ZqRns0rdZ0voA=;
        b=E10Gp7byUqQIw1p5kHD2Cm0WtZSbtbMimyjCjNVMf3E01zLKeUgM42nCseI9SKHg47
         wQUgDEeXCkNSlrNxpCuLg0NVe8uZZM/TuN8MvjrvElDEpMd03JuL5xA41Z5p20LU2dcX
         twrY9wKhKtajrMS45VqfRVazk7S8BtylN/rrBxgnU01xfTJVTIC9te05bNiDx/qBhvNq
         H0o5hXLCpOjxcWylhF92ZPM28vtrYYkpDrOq8bBbk7vtq77zYrQyUq+/MhWnehafePCZ
         w2t7kVK/iS3acz4SrIFRrnP8EL5F3khrVLwcrcBv1AJCQBNocHcVgXMmRWsD3VGoafpo
         0cmQ==
X-Gm-Message-State: AOAM5307V65dnJMkOu4tjBbyRaG7oZ/ytQJQhQWR4fMS4/xExX/zYueb
        JJ/NBtlCU4YMfZPcbcGJYyn6sKdsa7p4TzfYhiqmbsFGHDJR26HkHBUMvaX0ELQgwb//zJix5sO
        244RXfDqQpoR/NRELsIB+ctF9KlXArSN3VRiW528pQpGbZra8CB1uY8zhTDZp8QsW3bvPHXl0aN
        4bqw==
X-Received: by 2002:a17:907:d15:: with SMTP id gn21mr10912185ejc.337.1616701087559;
        Thu, 25 Mar 2021 12:38:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNQN+alh++shpJRlMBgdF439eIFx8CFw/yNwHP1LgSd42bDZX6kGJ0UGvKibs/FSNIlUIXfQ==
X-Received: by 2002:a17:907:d15:: with SMTP id gn21mr10912155ejc.337.1616701087288;
        Thu, 25 Mar 2021 12:38:07 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id si7sm2881996ejb.84.2021.03.25.12.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 12:38:06 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH v3 09/18] orangefs: convert to fileattr
Date:   Thu, 25 Mar 2021 20:37:46 +0100
Message-Id: <20210325193755.294925-10-mszeredi@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325193755.294925-1-mszeredi@redhat.com>
References: <20210325193755.294925-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the fileattr API to let the VFS handle locking, permission checking and
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
index 5079cfafa8d7..85b3dd2d769d 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/bvec.h>
+#include <linux/fileattr.h>
 #include "protocol.h"
 #include "orangefs-kernel.h"
 #include "orangefs-bufmap.h"
@@ -954,6 +955,53 @@ int orangefs_update_time(struct inode *inode, struct timespec64 *time, int flags
 	return __orangefs_setattr(inode, &iattr);
 }
 
+static int orangefs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
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
+	fileattr_fill_flags(fa, val);
+	return 0;
+}
+
+static int orangefs_fileattr_set(struct user_namespace *mnt_userns,
+				 struct dentry *dentry, struct fileattr *fa)
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
+	if (fileattr_has_fsx(fa) ||
+	    (fa->flags & ~(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NOATIME_FL | ORANGEFS_MIRROR_FL))) {
+		gossip_err("%s: only supports setting one of FS_IMMUTABLE_FL|FS_APPEND_FL|FS_NOATIME_FL\n",
+			   __func__);
+		return -EOPNOTSUPP;
+	}
+	val = fa->flags;
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
+	.fileattr_get = orangefs_fileattr_get,
+	.fileattr_set = orangefs_fileattr_set,
 };
 
 static int orangefs_init_iops(struct inode *inode)
-- 
2.30.2

