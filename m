Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F37A344800
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 15:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhCVOuM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 10:50:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52796 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231214AbhCVOth (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616424576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9vCEwIUmGd3ShhFCYwPPz97LFr0egAhHKCVaObC8MuI=;
        b=KchxE+7pz4Opgk5y/zCRlTxx7WD5WzlZ/yW1Rw4ANerq4ooYocQKQkzWMGk5moHnIja6wU
        TFeFooicEV+Rr3jDL4eIURNibjaclQqCvrYTEXZ8ydxM1h59BrYHnds2+vUVAXpMUcHee5
        VI9H1wLrRdCbKSY7EhaNXpjnU/f+Jnw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-7LrcZvz3OYut41dtNiSJqg-1; Mon, 22 Mar 2021 10:49:35 -0400
X-MC-Unique: 7LrcZvz3OYut41dtNiSJqg-1
Received: by mail-ej1-f70.google.com with SMTP id d6so833565ejd.15
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 07:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9vCEwIUmGd3ShhFCYwPPz97LFr0egAhHKCVaObC8MuI=;
        b=lJrNoO5l2kobFF6zkF5hDbNu+RAXODyUXNZP0RAdjIHzXNhgKejPXskGKcSPF05Tj8
         RiMoT/0xS/ApiugV+0asWYusDJ9lfK1/umJibtj8TkHAEPGq4YlzcvVtHqqwxMj4q09L
         ExUgHiQGFWKTolEZ7UjyaP2T4xxv6/d8P5XouN1oJrbUKTuxvNMW1nJo/gsR+Q4p2FsK
         NcOAfC40J6EXx8DepM2B0npZjW9PmyDopgG6Ltm2OX/4nSHr699r61Tshxu3ONShfXlZ
         b55HxdZzgjyOXD6COSFdzHzCZNMyrC+R2xibLmVZ7jds8WiADbxlpsjUIO5y9xteVx8y
         Ev7A==
X-Gm-Message-State: AOAM531NvkYEr7KUuaonMWG5O6XdQV6JsvDAtsNBX5ycAwjU9itiYYOV
        P7OCtBPIk/t6OT9If+xQpa5wAZhvElEyGs1BZ1+vf9UoSbu4FFhdGLI1JI6i7CzVPpdtfTCzbpa
        HWFpBRkKrDf3lTqf0fL7xgky/QgC4Yc2+O+i65EoINiTKRNNp1QS/K3Wi3IpGtjbtxKkp7O+WHx
        Goag==
X-Received: by 2002:a17:906:f56:: with SMTP id h22mr119901ejj.494.1616424573522;
        Mon, 22 Mar 2021 07:49:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPSF3TWmWE6nxg36tU3lsp04zqlZXn4U4XSAFJfh2lE5KtMufLSvf0mLqTtsyxeppYd/93pA==
X-Received: by 2002:a17:906:f56:: with SMTP id h22mr119877ejj.494.1616424573314;
        Mon, 22 Mar 2021 07:49:33 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id r4sm9793117ejd.125.2021.03.22.07.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:49:32 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 12/18] hfsplus: convert to miscattr
Date:   Mon, 22 Mar 2021 15:49:10 +0100
Message-Id: <20210322144916.137245-13-mszeredi@redhat.com>
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
---
 fs/hfsplus/dir.c        |  2 +
 fs/hfsplus/hfsplus_fs.h | 14 ++-----
 fs/hfsplus/inode.c      | 54 ++++++++++++++++++++++++++
 fs/hfsplus/ioctl.c      | 84 -----------------------------------------
 4 files changed, 59 insertions(+), 95 deletions(-)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 03e6c046faf4..34b446a8307e 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -569,6 +569,8 @@ const struct inode_operations hfsplus_dir_inode_operations = {
 	.rename			= hfsplus_rename,
 	.getattr		= hfsplus_getattr,
 	.listxattr		= hfsplus_listxattr,
+	.miscattr_get		= hfsplus_miscattr_get,
+	.miscattr_set		= hfsplus_miscattr_set,
 };
 
 const struct file_operations hfsplus_dir_operations = {
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 12b20479ed2b..75d397dcd123 100644
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
+int hfsplus_miscattr_get(struct dentry *dentry, struct miscattr *ma);
+int hfsplus_miscattr_set(struct user_namespace *mnt_userns,
+			 struct dentry *dentry, struct miscattr *ma);
 
 /* ioctl.c */
 long hfsplus_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 078c5c8a5156..808f2b8b5a8f 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/cred.h>
 #include <linux/uio.h>
+#include <linux/miscattr.h>
 
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
@@ -353,6 +354,8 @@ static const struct inode_operations hfsplus_file_inode_operations = {
 	.setattr	= hfsplus_setattr,
 	.getattr	= hfsplus_getattr,
 	.listxattr	= hfsplus_listxattr,
+	.miscattr_get	= hfsplus_miscattr_get,
+	.miscattr_set	= hfsplus_miscattr_set,
 };
 
 static const struct file_operations hfsplus_file_operations = {
@@ -628,3 +631,54 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	hfs_find_exit(&fd);
 	return 0;
 }
+
+int hfsplus_miscattr_get(struct dentry *dentry, struct miscattr *ma)
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
+	miscattr_fill_flags(ma, flags);
+
+	return 0;
+}
+
+int hfsplus_miscattr_set(struct user_namespace *mnt_userns,
+			 struct dentry *dentry, struct miscattr *ma)
+{
+	struct inode *inode = d_inode(dentry);
+	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	unsigned int new_fl = 0;
+
+	if (miscattr_has_xattr(ma))
+		return -EOPNOTSUPP;
+
+	/* don't silently ignore unsupported ext2 flags */
+	if (ma->flags & ~(FS_IMMUTABLE_FL|FS_APPEND_FL|FS_NODUMP_FL))
+		return -EOPNOTSUPP;
+
+	if (ma->flags & FS_IMMUTABLE_FL)
+		new_fl |= S_IMMUTABLE;
+
+	if (ma->flags & FS_APPEND_FL)
+		new_fl |= S_APPEND;
+
+	inode_set_flags(inode, new_fl, S_IMMUTABLE | S_APPEND);
+
+	if (ma->flags & FS_NODUMP_FL)
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

