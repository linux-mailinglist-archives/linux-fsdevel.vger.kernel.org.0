Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B10D349A71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 20:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhCYTis (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 15:38:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39144 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230153AbhCYTiO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616701093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4I62ZeV758StJHD6zAT4ZM8Oc+0WC8KR6jURCyMpN5A=;
        b=ihKsQ0zQbxIRZmE7XP1zMtqcuQtqAhDREUCRZlvi3ykyETWO8j5wnoVCO3t6urTkbxbX71
        QEASFOeijjxYp3MAHFDPOi8JiyCDFlCaTEA1jjfW/0dtKdjP4EX0Pez1tqjsODmgiHzmeB
        Oqbc2whnh9sPxUIoAskIx/gOBkBEylM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-ZkiNlUuPNFGKN5Cf73Janw-1; Thu, 25 Mar 2021 15:38:12 -0400
X-MC-Unique: ZkiNlUuPNFGKN5Cf73Janw-1
Received: by mail-ed1-f69.google.com with SMTP id k8so3190736edn.19
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 12:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4I62ZeV758StJHD6zAT4ZM8Oc+0WC8KR6jURCyMpN5A=;
        b=FO7QL9hp9/QBd9K9v+NOVlncHNEvl2bmCl99t89hkPx1yc2pEi9N6Q7++myzq3ovhY
         clF64+qYUo86GOdaj64ZFgm5WJ4JZo4P/fX4jPxezqGQqqA3TPvVMuRshWLylNVdZHZm
         bITwCw5RtorLzYAvY4Gfv/2a/XNfCmoaE5syscFCRznu/cRUaVHrKDtOTnFl03blNTLE
         sJSJSt/s7/ZmXrHXv6x59lyIh28NnwnfFknTQLsOBDegf8WHGolfSgjIpocvZqoh5Xhu
         izjEYhaD6kBYV7lSlgReVX4eRmGtdgo7WyJlVs/6SGiMApcwrVGWifXtuK4xaTHhi4w2
         EM7w==
X-Gm-Message-State: AOAM5308iBvhvz+xvxQmx5CawgGhlIx1rsy/xicCvh/yjWRaQevScNW9
        If7YWdddGwrDaFAY3bRp9BiVYjc6DJG1xE0RbsrmuBR22uegqu8/wywBhCrxlAmnDkOT1eYRi1W
        5tmLwoXcTOSMNP2LuomacJIxdyR30zXitTeYtyUQlMzDMSte3cm5qsNG68Q8jr1HMlXg7dfAIXp
        yqyQ==
X-Received: by 2002:a17:907:75c7:: with SMTP id jl7mr11739400ejc.191.1616701090768;
        Thu, 25 Mar 2021 12:38:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9IDCy14/ii/VXZ9lBkfgSodsD1DwmHTuVQzbXFXQATQ4fSIjHkw+R1FkaS/5paG3nCB+0zA==
X-Received: by 2002:a17:907:75c7:: with SMTP id jl7mr11739378ejc.191.1616701090538;
        Thu, 25 Mar 2021 12:38:10 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id si7sm2881996ejb.84.2021.03.25.12.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 12:38:10 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/18] hfsplus: convert to fileattr
Date:   Thu, 25 Mar 2021 20:37:49 +0100
Message-Id: <20210325193755.294925-13-mszeredi@redhat.com>
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
---
 fs/hfsplus/dir.c        |  2 +
 fs/hfsplus/hfsplus_fs.h | 14 ++-----
 fs/hfsplus/inode.c      | 54 ++++++++++++++++++++++++++
 fs/hfsplus/ioctl.c      | 84 -----------------------------------------
 4 files changed, 59 insertions(+), 95 deletions(-)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 03e6c046faf4..84714bbccc12 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -569,6 +569,8 @@ const struct inode_operations hfsplus_dir_inode_operations = {
 	.rename			= hfsplus_rename,
 	.getattr		= hfsplus_getattr,
 	.listxattr		= hfsplus_listxattr,
+	.fileattr_get		= hfsplus_fileattr_get,
+	.fileattr_set		= hfsplus_fileattr_set,
 };
 
 const struct file_operations hfsplus_dir_operations = {
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 12b20479ed2b..1798949f269b 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -344,17 +344,6 @@ static inline unsigned short hfsplus_min_io_size(struct super_block *sb)
 #define hfs_brec_goto hfsplus_brec_goto
 #define hfs_part_find hfsplus_part_find
 
-/*
- * definitions for ext2 flag ioctls (linux really needs a generic
- * interface for this).
- */
-
-/* ext2 ioctls (EXT2_IOC_GETFLAGS and EXT2_IOC_SETFLAGS) to support
- * chattr/lsattr */
-#define HFSPLUS_IOC_EXT2_GETFLAGS	FS_IOC_GETFLAGS
-#define HFSPLUS_IOC_EXT2_SETFLAGS	FS_IOC_SETFLAGS
-
-
 /*
  * hfs+-specific ioctl for making the filesystem bootable
  */
@@ -493,6 +482,9 @@ int hfsplus_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		    unsigned int query_flags);
 int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
 		       int datasync);
+int hfsplus_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+int hfsplus_fileattr_set(struct user_namespace *mnt_userns,
+			 struct dentry *dentry, struct fileattr *fa);
 
 /* ioctl.c */
 long hfsplus_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 078c5c8a5156..8ea447e5c470 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/cred.h>
 #include <linux/uio.h>
+#include <linux/fileattr.h>
 
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
@@ -353,6 +354,8 @@ static const struct inode_operations hfsplus_file_inode_operations = {
 	.setattr	= hfsplus_setattr,
 	.getattr	= hfsplus_getattr,
 	.listxattr	= hfsplus_listxattr,
+	.fileattr_get	= hfsplus_fileattr_get,
+	.fileattr_set	= hfsplus_fileattr_set,
 };
 
 static const struct file_operations hfsplus_file_operations = {
@@ -628,3 +631,54 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	hfs_find_exit(&fd);
 	return 0;
 }
+
+int hfsplus_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	unsigned int flags = 0;
+
+	if (inode->i_flags & S_IMMUTABLE)
+		flags |= FS_IMMUTABLE_FL;
+	if (inode->i_flags & S_APPEND)
+		flags |= FS_APPEND_FL;
+	if (hip->userflags & HFSPLUS_FLG_NODUMP)
+		flags |= FS_NODUMP_FL;
+
+	fileattr_fill_flags(fa, flags);
+
+	return 0;
+}
+
+int hfsplus_fileattr_set(struct user_namespace *mnt_userns,
+			 struct dentry *dentry, struct fileattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	unsigned int new_fl = 0;
+
+	if (fileattr_has_fsx(fa))
+		return -EOPNOTSUPP;
+
+	/* don't silently ignore unsupported ext2 flags */
+	if (fa->flags & ~(FS_IMMUTABLE_FL|FS_APPEND_FL|FS_NODUMP_FL))
+		return -EOPNOTSUPP;
+
+	if (fa->flags & FS_IMMUTABLE_FL)
+		new_fl |= S_IMMUTABLE;
+
+	if (fa->flags & FS_APPEND_FL)
+		new_fl |= S_APPEND;
+
+	inode_set_flags(inode, new_fl, S_IMMUTABLE | S_APPEND);
+
+	if (fa->flags & FS_NODUMP_FL)
+		hip->userflags |= HFSPLUS_FLG_NODUMP;
+	else
+		hip->userflags &= ~HFSPLUS_FLG_NODUMP;
+
+	inode->i_ctime = current_time(inode);
+	mark_inode_dirty(inode);
+
+	return 0;
+}
diff --git a/fs/hfsplus/ioctl.c b/fs/hfsplus/ioctl.c
index 3edb1926d127..5661a2e24d03 100644
--- a/fs/hfsplus/ioctl.c
+++ b/fs/hfsplus/ioctl.c
@@ -57,95 +57,11 @@ static int hfsplus_ioctl_bless(struct file *file, int __user *user_flags)
 	return 0;
 }
 
-static inline unsigned int hfsplus_getflags(struct inode *inode)
-{
-	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
-	unsigned int flags = 0;
-
-	if (inode->i_flags & S_IMMUTABLE)
-		flags |= FS_IMMUTABLE_FL;
-	if (inode->i_flags & S_APPEND)
-		flags |= FS_APPEND_FL;
-	if (hip->userflags & HFSPLUS_FLG_NODUMP)
-		flags |= FS_NODUMP_FL;
-	return flags;
-}
-
-static int hfsplus_ioctl_getflags(struct file *file, int __user *user_flags)
-{
-	struct inode *inode = file_inode(file);
-	unsigned int flags = hfsplus_getflags(inode);
-
-	return put_user(flags, user_flags);
-}
-
-static int hfsplus_ioctl_setflags(struct file *file, int __user *user_flags)
-{
-	struct inode *inode = file_inode(file);
-	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
-	unsigned int flags, new_fl = 0;
-	unsigned int oldflags = hfsplus_getflags(inode);
-	int err = 0;
-
-	err = mnt_want_write_file(file);
-	if (err)
-		goto out;
-
-	if (!inode_owner_or_capable(&init_user_ns, inode)) {
-		err = -EACCES;
-		goto out_drop_write;
-	}
-
-	if (get_user(flags, user_flags)) {
-		err = -EFAULT;
-		goto out_drop_write;
-	}
-
-	inode_lock(inode);
-
-	err = vfs_ioc_setflags_prepare(inode, oldflags, flags);
-	if (err)
-		goto out_unlock_inode;
-
-	/* don't silently ignore unsupported ext2 flags */
-	if (flags & ~(FS_IMMUTABLE_FL|FS_APPEND_FL|FS_NODUMP_FL)) {
-		err = -EOPNOTSUPP;
-		goto out_unlock_inode;
-	}
-
-	if (flags & FS_IMMUTABLE_FL)
-		new_fl |= S_IMMUTABLE;
-
-	if (flags & FS_APPEND_FL)
-		new_fl |= S_APPEND;
-
-	inode_set_flags(inode, new_fl, S_IMMUTABLE | S_APPEND);
-
-	if (flags & FS_NODUMP_FL)
-		hip->userflags |= HFSPLUS_FLG_NODUMP;
-	else
-		hip->userflags &= ~HFSPLUS_FLG_NODUMP;
-
-	inode->i_ctime = current_time(inode);
-	mark_inode_dirty(inode);
-
-out_unlock_inode:
-	inode_unlock(inode);
-out_drop_write:
-	mnt_drop_write_file(file);
-out:
-	return err;
-}
-
 long hfsplus_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
 
 	switch (cmd) {
-	case HFSPLUS_IOC_EXT2_GETFLAGS:
-		return hfsplus_ioctl_getflags(file, argp);
-	case HFSPLUS_IOC_EXT2_SETFLAGS:
-		return hfsplus_ioctl_setflags(file, argp);
 	case HFSPLUS_IOC_BLESS:
 		return hfsplus_ioctl_bless(file, argp);
 	default:
-- 
2.30.2

