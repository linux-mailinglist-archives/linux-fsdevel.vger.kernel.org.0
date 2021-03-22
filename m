Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742BC344808
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 15:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhCVOuf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 10:50:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230288AbhCVOtm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616424581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zh83JkhktP4ysipqS2U23lr0Hw3W6qLosekTGDxh+tI=;
        b=CKpsLNWXVWC3oxjrscg7/4Zcs+sO4iXdHOlS3vx08Ho/Ms6/Yr2nmtD5UhtYUEfA1CJxbW
        GrJuza1GPtxhK8LroviF9flMsoxU8nDUGVmPwjLOFji+D6d/LKAFHZpxN+SblsslkkVdzM
        TwrH8cXyGWta7xnJFT7+Si2YGqaBfPA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-5bqYnJfpMl-mL5t5x6Rx9A-1; Mon, 22 Mar 2021 10:49:40 -0400
X-MC-Unique: 5bqYnJfpMl-mL5t5x6Rx9A-1
Received: by mail-ej1-f70.google.com with SMTP id t21so12005688ejf.14
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 07:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zh83JkhktP4ysipqS2U23lr0Hw3W6qLosekTGDxh+tI=;
        b=FSclBvLT3fLkEikN2cFd7UHTQFAzxaa+LHPJiULkNvVXtMmT1BBGKqsuHRX0ly44/V
         Mq736tMkdeIZvBFnUGcEINXf5wHd5yRB4EUjHH4thdJfbWWc7E1S+aaJ1owar8k2biIV
         fCUAo15ScSrJn3QhaBM/5Di0oJs1h0kmhfclvAEGYn2rqBTShshQh9RI9rQe2LsPK++h
         sx3p4kqNmFHujdz/MNog3Q/pvWEsiSJx1zZwhQ5RDjxtzal6v7UP3NRYMOqKaIFgnyBl
         asSxqAdeJS45r9Nwd7ko4nyaKhoLW0TPU0V25M2q8QJwo7aK9TmcmssIXJrxy8aFLvhC
         BNdw==
X-Gm-Message-State: AOAM530ay/OhRNb+96F3iY73KaMb3noAqj8BPg/6lUzOdlv54vHoKUUm
        5FKGtCcjXAGTCYZfPdwjv9dZvFQfAwpTsPnMEVycrkTIMPq+RRDZ+1YGHvMwg9oRixTV6p2IQyp
        LVhMXHz1z3k/ySO6aIjTZod9WwH6rymYCSVltqc1BdtjcsYGgcv7tvr+0wKHuZxu97cJ0tJDXAM
        L2iA==
X-Received: by 2002:a17:907:7684:: with SMTP id jv4mr93177ejc.231.1616424579108;
        Mon, 22 Mar 2021 07:49:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzG5rnPxNZ5oGaCHvZUXeu7d2TZ2kP8r1pdCR02U9IOBl5+gOATfnUgGmJ2k38s0jwrpYNBpQ==
X-Received: by 2002:a17:907:7684:: with SMTP id jv4mr93152ejc.231.1616424578911;
        Mon, 22 Mar 2021 07:49:38 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id r4sm9793117ejd.125.2021.03.22.07.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:49:38 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH v2 17/18] ubifs: convert to miscattr
Date:   Mon, 22 Mar 2021 15:49:15 +0100
Message-Id: <20210322144916.137245-18-mszeredi@redhat.com>
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
Cc: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/dir.c   |  2 ++
 fs/ubifs/file.c  |  2 ++
 fs/ubifs/ioctl.c | 74 ++++++++++++++++++++----------------------------
 fs/ubifs/ubifs.h |  3 ++
 4 files changed, 38 insertions(+), 43 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index d9d8d7794eff..ed9a3127fcd9 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1637,6 +1637,8 @@ const struct inode_operations ubifs_dir_inode_operations = {
 	.listxattr   = ubifs_listxattr,
 	.update_time = ubifs_update_time,
 	.tmpfile     = ubifs_tmpfile,
+	.miscattr_get = ubifs_miscattr_get,
+	.miscattr_set = ubifs_miscattr_set,
 };
 
 const struct file_operations ubifs_dir_operations = {
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 0e4b4be3aa26..90bad37ed060 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1648,6 +1648,8 @@ const struct inode_operations ubifs_file_inode_operations = {
 	.getattr     = ubifs_getattr,
 	.listxattr   = ubifs_listxattr,
 	.update_time = ubifs_update_time,
+	.miscattr_get = ubifs_miscattr_get,
+	.miscattr_set = ubifs_miscattr_set,
 };
 
 const struct inode_operations ubifs_symlink_inode_operations = {
diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index 2326d5122beb..87a423ee09bc 100644
--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -14,6 +14,7 @@
 
 #include <linux/compat.h>
 #include <linux/mount.h>
+#include <linux/miscattr.h>
 #include "ubifs.h"
 
 /* Need to be kept consistent with checked flags in ioctl2ubifs() */
@@ -103,7 +104,7 @@ static int ubifs2ioctl(int ubifs_flags)
 
 static int setflags(struct inode *inode, int flags)
 {
-	int oldflags, err, release;
+	int err, release;
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	struct ubifs_budget_req req = { .dirtied_ino = 1,
@@ -114,11 +115,6 @@ static int setflags(struct inode *inode, int flags)
 		return err;
 
 	mutex_lock(&ui->ui_mutex);
-	oldflags = ubifs2ioctl(ui->flags);
-	err = vfs_ioc_setflags_prepare(inode, oldflags, flags);
-	if (err)
-		goto out_unlock;
-
 	ui->flags &= ~ioctl2ubifs(UBIFS_SETTABLE_IOCTL_FLAGS);
 	ui->flags |= ioctl2ubifs(flags);
 	ubifs_set_inode_flags(inode);
@@ -132,54 +128,46 @@ static int setflags(struct inode *inode, int flags)
 	if (IS_SYNC(inode))
 		err = write_inode_now(inode, 1);
 	return err;
-
-out_unlock:
-	mutex_unlock(&ui->ui_mutex);
-	ubifs_release_budget(c, &req);
-	return err;
 }
 
-long ubifs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+int ubifs_miscattr_get(struct dentry *dentry, struct miscattr *ma)
 {
-	int flags, err;
-	struct inode *inode = file_inode(file);
+	struct inode *inode = d_inode(dentry);
+	int flags = ubifs2ioctl(ubifs_inode(inode)->flags);
 
-	switch (cmd) {
-	case FS_IOC_GETFLAGS:
-		flags = ubifs2ioctl(ubifs_inode(inode)->flags);
+	dbg_gen("get flags: %#x, i_flags %#x", flags, inode->i_flags);
+	miscattr_fill_flags(ma, flags);
 
-		dbg_gen("get flags: %#x, i_flags %#x", flags, inode->i_flags);
-		return put_user(flags, (int __user *) arg);
+	return 0;
+}
 
-	case FS_IOC_SETFLAGS: {
-		if (IS_RDONLY(inode))
-			return -EROFS;
+int ubifs_miscattr_set(struct user_namespace *mnt_userns,
+		       struct dentry *dentry, struct miscattr *ma)
+{
+	struct inode *inode = d_inode(dentry);
+	int flags = ma->flags;
 
-		if (!inode_owner_or_capable(&init_user_ns, inode))
-			return -EACCES;
+	if (miscattr_has_xattr(ma))
+		return -EOPNOTSUPP;
 
-		if (get_user(flags, (int __user *) arg))
-			return -EFAULT;
+	if (flags & ~UBIFS_GETTABLE_IOCTL_FLAGS)
+		return -EOPNOTSUPP;
 
-		if (flags & ~UBIFS_GETTABLE_IOCTL_FLAGS)
-			return -EOPNOTSUPP;
-		flags &= UBIFS_SETTABLE_IOCTL_FLAGS;
+	flags &= UBIFS_SETTABLE_IOCTL_FLAGS;
 
-		if (!S_ISDIR(inode->i_mode))
-			flags &= ~FS_DIRSYNC_FL;
+	if (!S_ISDIR(inode->i_mode))
+		flags &= ~FS_DIRSYNC_FL;
 
-		/*
-		 * Make sure the file-system is read-write and make sure it
-		 * will not become read-only while we are changing the flags.
-		 */
-		err = mnt_want_write_file(file);
-		if (err)
-			return err;
-		dbg_gen("set flags: %#x, i_flags %#x", flags, inode->i_flags);
-		err = setflags(inode, flags);
-		mnt_drop_write_file(file);
-		return err;
-	}
+	dbg_gen("set flags: %#x, i_flags %#x", flags, inode->i_flags);
+	return setflags(inode, flags);
+}
+
+long ubifs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int err;
+	struct inode *inode = file_inode(file);
+
+	switch (cmd) {
 	case FS_IOC_SET_ENCRYPTION_POLICY: {
 		struct ubifs_info *c = inode->i_sb->s_fs_info;
 
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 7fdfdbda4b8a..f577cee6c548 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -2053,6 +2053,9 @@ int ubifs_recover_size(struct ubifs_info *c, bool in_place);
 void ubifs_destroy_size_tree(struct ubifs_info *c);
 
 /* ioctl.c */
+int ubifs_miscattr_get(struct dentry *dentry, struct miscattr *ma);
+int ubifs_miscattr_set(struct user_namespace *mnt_userns,
+		       struct dentry *dentry, struct miscattr *ma);
 long ubifs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 void ubifs_set_inode_flags(struct inode *inode);
 #ifdef CONFIG_COMPAT
-- 
2.30.2

