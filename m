Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0519530DA0D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 13:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhBCMph (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 07:45:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27849 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231314AbhBCMnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612356116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lO3+6IJT04iMcewcGdHLjCrHBvAdLlNE5bp9CQJEzSM=;
        b=e5S0OHVYNGX5aycIr9snbMyZuWzJH3BO2xBgeXBkAWDHX38wrzLrgp26CvEp/x7oCC7+nh
        nlTjlQc3v5cPWqNZSa5eS0RG5RHyDXhzGrMbgoYR32r62Y3UR9RxHMCKPAmG+FIw24W1gR
        9PCu0flIDDSYC1UqjJ9xC80ot0O6fH8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-t8-Gb4slMw6C0i599z6cqg-1; Wed, 03 Feb 2021 07:41:55 -0500
X-MC-Unique: t8-Gb4slMw6C0i599z6cqg-1
Received: by mail-ej1-f69.google.com with SMTP id yc4so289280ejb.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 04:41:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lO3+6IJT04iMcewcGdHLjCrHBvAdLlNE5bp9CQJEzSM=;
        b=K/CccIz4Ks/cEACLMER6P/o1yghkGAQhcAxmzD9RYLsITOZzi7ajiFeVEBap/N8jMi
         xR57GBfAMR11E8typG+wS4cQk4E7d4ZXcxy98JlmF6T4+G8/bgMLKS7FR9WPKXX2PdCJ
         nbYVxY5W7eY8ajv/iGMhOOmCjpERv/YUZdQ6DVd9iux9aQfAgdKIolK68JFhASn+W1xM
         W+ddhBo/0XiPutRI5YOe+4JKml3v1ZnFQxcROP5CVQ0R5f4PsHFK1vrctsR255IdoMB1
         tNUaRLUJoQj+9xbh3AbrLAhJn/+U+2dI7pYl7EmabDkgA9Uj++PMtdeEeNdu27yksTGw
         lRdw==
X-Gm-Message-State: AOAM531VYcDjJ2O+TyIworul8noZnFI1l56maQ2NTtu2CPBOJwFblyl9
        UombqyiYAsXJu+YqzjJYCmX4wY0kLhCW+jPpi55viQBszZt403R+mDFVPUfU5zP/2qLBUnObZUC
        zZ27cB2N9fkuPmuOIrqGMJqnvPl+xmhQnSZbCnGdXAsVZxPCx/fQWPDFobc8jILmkXfy8IsINoX
        VoQQ==
X-Received: by 2002:a17:906:39d0:: with SMTP id i16mr3005977eje.18.1612356113948;
        Wed, 03 Feb 2021 04:41:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzo62v1ohsYcoUGzoXx1oIZ8abx25zDwn5tBmZnMv/1Yxx/frV7WTihbpfn/2XH0TjUp7+Rng==
X-Received: by 2002:a17:906:39d0:: with SMTP id i16mr3005958eje.18.1612356113726;
        Wed, 03 Feb 2021 04:41:53 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id u9sm953320ejc.57.2021.02.03.04.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:41:52 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 17/18] ubifs: convert to miscattr
Date:   Wed,  3 Feb 2021 13:41:11 +0100
Message-Id: <20210203124112.1182614-18-mszeredi@redhat.com>
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
Cc: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/dir.c   |  2 ++
 fs/ubifs/file.c  |  2 ++
 fs/ubifs/ioctl.c | 73 ++++++++++++++++++++----------------------------
 fs/ubifs/ubifs.h |  2 ++
 4 files changed, 36 insertions(+), 43 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 9a6b8660425a..0e25e4c352eb 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1635,6 +1635,8 @@ const struct inode_operations ubifs_dir_inode_operations = {
 	.listxattr   = ubifs_listxattr,
 	.update_time = ubifs_update_time,
 	.tmpfile     = ubifs_tmpfile,
+	.miscattr_get = ubifs_miscattr_get,
+	.miscattr_set = ubifs_miscattr_set,
 };
 
 const struct file_operations ubifs_dir_operations = {
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 2bc7780d2963..3761bdc801bd 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1647,6 +1647,8 @@ const struct inode_operations ubifs_file_inode_operations = {
 	.getattr     = ubifs_getattr,
 	.listxattr   = ubifs_listxattr,
 	.update_time = ubifs_update_time,
+	.miscattr_get = ubifs_miscattr_get,
+	.miscattr_set = ubifs_miscattr_set,
 };
 
 const struct inode_operations ubifs_symlink_inode_operations = {
diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index 4363d85a3fd4..901530c56259 100644
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
@@ -132,54 +128,45 @@ static int setflags(struct inode *inode, int flags)
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
+int ubifs_miscattr_set(struct dentry *dentry, struct miscattr *ma)
+{
+	struct inode *inode = d_inode(dentry);
+	int flags = ma->flags;
 
-		if (!inode_owner_or_capable(inode))
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
index fc2cdde3b549..404ec58254e9 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -2052,6 +2052,8 @@ int ubifs_recover_size(struct ubifs_info *c, bool in_place);
 void ubifs_destroy_size_tree(struct ubifs_info *c);
 
 /* ioctl.c */
+int ubifs_miscattr_get(struct dentry *dentry, struct miscattr *ma);
+int ubifs_miscattr_set(struct dentry *dentry, struct miscattr *ma);
 long ubifs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 void ubifs_set_inode_flags(struct inode *inode);
 #ifdef CONFIG_COMPAT
-- 
2.26.2

