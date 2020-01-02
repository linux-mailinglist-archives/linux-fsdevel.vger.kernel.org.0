Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D575A12EA0F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 19:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgABStk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 13:49:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44799 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgABStk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 13:49:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id q10so1228759wrm.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jan 2020 10:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GvkfpMD5GVhWE1UV0B+CTK1rzKf0qd70Dw7hx2UwFso=;
        b=XdVOy9pnUKJkX9mwZFDER/L2z/91J5wQ9exMrCGTlyTr0ooLfOyWNkk6i/2uDGtklA
         YVhaFIuek+y9fVM6WHqeYOqEjsKyno1tlqAmGIE3W6dYa+0x30R+1suEAR7OXraiO32y
         mDgKy4jsRcz0f37iVq1L1+ruMeO4LdASHCsao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GvkfpMD5GVhWE1UV0B+CTK1rzKf0qd70Dw7hx2UwFso=;
        b=F95G89yXe97nNGefAk+2keo+rpR7vPyV8U4E2eDx2oI3PBe60aycMhNFC2bBgmAtfC
         UhX6lROImcej3XBajB/A3uZzvWgbNpEvAjbs335y8P9rU22twOaz4QKZqOIJymjpyzDh
         XEfV+h/1DUfOONEYAJEUe/Y1GQa7fXuHipME4GWu4CE9FJHZupzOQMviAchYX2Pxhm5P
         Ke8yBlQ3mJf9nY9RKpd5uwS/iOd4I4w8mnVxxXvCTHNk+hzg4g3nNe1pAKMpTVeDXsLi
         AbU5jTwVDXIaPLWBnI9BFSQkIvKjCAu8CUIYww4YXPxljWGlsAuz3JIwofp7D52VXvbc
         Q6ew==
X-Gm-Message-State: APjAAAUFSQVujnbUtssNX86Ev8dfyTzG5f4dxFXTAql8he6O0KJMkJ5/
        e0GcwQ30jZDNDS/BanZMUdNRmtZ66FKQ+Q==
X-Google-Smtp-Source: APXvYqzrF+wQK+De9bbrh2hVkGkH3+R9Dxc6lsWnk62kCCYH/6Ds5TUoYNfiw2dIZpPD8afAKDcEfg==
X-Received: by 2002:a5d:494b:: with SMTP id r11mr32795569wrs.184.1577990978122;
        Thu, 02 Jan 2020 10:49:38 -0800 (PST)
Received: from localhost ([2620:10d:c092:200::1:3256])
        by smtp.gmail.com with ESMTPSA id z21sm9697579wml.5.2020.01.02.10.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 10:49:37 -0800 (PST)
Date:   Thu, 2 Jan 2020 18:49:37 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 1/2] tmpfs: Add per-superblock i_ino support
Message-ID: <738b3d565fe7c65f41c38e439fe3cbfa14f87465.1577990599.git.chris@chrisdown.name>
References: <cover.1577990599.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1577990599.git.chris@chrisdown.name>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

get_next_ino has a number of problems:

- It uses and returns a uint, which is susceptible to become overflowed
  if a lot of volatile inodes that use get_next_ino are created.
- It's global, with no specificity per-sb or even per-filesystem. This
  means it's not that difficult to cause inode number wraparounds on a
  single device, which can result in having multiple distinct inodes
  with the same inode number.

This patch adds a per-superblock counter that mitigates the second case.
This design also allows us to later have a specific i_ino size
per-device, for example, allowing users to choose whether to use 32- or
64-bit inodes for each tmpfs mount. This is implemented in the next
commit.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@fb.com
---
 include/linux/shmem_fs.h |  1 +
 mm/shmem.c               | 55 ++++++++++++++++++++++++++++++++++------
 2 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index de8e4b71e3ba..dec4353cf3b7 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -35,6 +35,7 @@ struct shmem_sb_info {
 	unsigned char huge;	    /* Whether to try for hugepages */
 	kuid_t uid;		    /* Mount uid for root directory */
 	kgid_t gid;		    /* Mount gid for root directory */
+	ino_t last_ino;		    /* The last used per-sb inode number */
 	struct mempolicy *mpol;     /* default memory policy for mappings */
 	spinlock_t shrinklist_lock;   /* Protects shrinklist */
 	struct list_head shrinklist;  /* List of shinkable inodes */
diff --git a/mm/shmem.c b/mm/shmem.c
index 165fa6332993..8af9fb922a96 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2235,8 +2235,18 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+/*
+ * shmem_get_inode - reserve, allocate, and initialise a new inode
+ *
+ * If usb_sb_ino is true, we use the per-sb inode allocator to avoid wraparound.
+ * Otherwise, we use get_next_ino, which is global.
+ *
+ * If use_sb_ino is true or max_inodes is greater than 0, we may have to grab
+ * the per-sb stat_lock.
+ */
 static struct inode *shmem_get_inode(struct super_block *sb, const struct inode *dir,
-				     umode_t mode, dev_t dev, unsigned long flags)
+				     umode_t mode, dev_t dev,
+				     unsigned long flags, bool use_sb_ino)
 {
 	struct inode *inode;
 	struct shmem_inode_info *info;
@@ -2247,7 +2257,30 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 
 	inode = new_inode(sb);
 	if (inode) {
-		inode->i_ino = get_next_ino();
+		if (use_sb_ino) {
+			spin_lock(&sbinfo->stat_lock);
+			inode->i_ino = sbinfo->last_ino++;
+			if (unlikely(inode->i_ino >= UINT_MAX)) {
+				/*
+				 * Emulate get_next_ino uint wraparound for
+				 * compatibility
+				 */
+				pr_warn("%s: inode number overflow on device %d, consider using inode64 mount option\n",
+					__func__, MINOR(sb->s_dev));
+				inode->i_ino = sbinfo->last_ino = 1;
+			}
+			spin_unlock(&sbinfo->stat_lock);
+		} else {
+			/*
+			 * __shmem_file_setup, one of our callers, is lock-free:
+			 * it doesn't hold stat_lock in shmem_reserve_inode
+			 * since max_inodes is always 0, and is called from
+			 * potentially unknown contexts. As such, use the global
+			 * allocator which doesn't require the per-sb stat_lock.
+			 */
+			inode->i_ino = get_next_ino();
+		}
+
 		inode_init_owner(inode, dir, mode);
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
@@ -2881,7 +2914,7 @@ shmem_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
 	struct inode *inode;
 	int error = -ENOSPC;
 
-	inode = shmem_get_inode(dir->i_sb, dir, mode, dev, VM_NORESERVE);
+	inode = shmem_get_inode(dir->i_sb, dir, mode, dev, VM_NORESERVE, true);
 	if (inode) {
 		error = simple_acl_create(dir, inode);
 		if (error)
@@ -2910,7 +2943,7 @@ shmem_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 	struct inode *inode;
 	int error = -ENOSPC;
 
-	inode = shmem_get_inode(dir->i_sb, dir, mode, 0, VM_NORESERVE);
+	inode = shmem_get_inode(dir->i_sb, dir, mode, 0, VM_NORESERVE, true);
 	if (inode) {
 		error = security_inode_init_security(inode, dir,
 						     NULL,
@@ -3106,7 +3139,7 @@ static int shmem_symlink(struct inode *dir, struct dentry *dentry, const char *s
 		return -ENAMETOOLONG;
 
 	inode = shmem_get_inode(dir->i_sb, dir, S_IFLNK | 0777, 0,
-				VM_NORESERVE);
+				VM_NORESERVE, true);
 	if (!inode)
 		return -ENOSPC;
 
@@ -3378,6 +3411,8 @@ enum shmem_param {
 	Opt_nr_inodes,
 	Opt_size,
 	Opt_uid,
+	Opt_inode32,
+	Opt_inode64,
 };
 
 static const struct fs_parameter_spec shmem_param_specs[] = {
@@ -3389,6 +3424,8 @@ static const struct fs_parameter_spec shmem_param_specs[] = {
 	fsparam_string("nr_inodes",	Opt_nr_inodes),
 	fsparam_string("size",		Opt_size),
 	fsparam_u32   ("uid",		Opt_uid),
+	fsparam_flag  ("inode32",	Opt_inode32),
+	fsparam_flag  ("inode64",	Opt_inode64),
 	{}
 };
 
@@ -3690,7 +3727,8 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 #endif
 	uuid_gen(&sb->s_uuid);
 
-	inode = shmem_get_inode(sb, NULL, S_IFDIR | sbinfo->mode, 0, VM_NORESERVE);
+	inode = shmem_get_inode(sb, NULL, S_IFDIR | sbinfo->mode, 0,
+				VM_NORESERVE, true);
 	if (!inode)
 		goto failed;
 	inode->i_uid = sbinfo->uid;
@@ -4081,7 +4119,8 @@ EXPORT_SYMBOL_GPL(shmem_truncate_range);
 
 #define shmem_vm_ops				generic_file_vm_ops
 #define shmem_file_operations			ramfs_file_operations
-#define shmem_get_inode(sb, dir, mode, dev, flags)	ramfs_get_inode(sb, dir, mode, dev)
+#define shmem_get_inode(sb, dir, mode, dev, flags, use_sb_ino) \
+	ramfs_get_inode(sb, dir, mode, dev)
 #define shmem_acct_size(flags, size)		0
 #define shmem_unacct_size(flags, size)		do {} while (0)
 
@@ -4105,7 +4144,7 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name, l
 		return ERR_PTR(-ENOMEM);
 
 	inode = shmem_get_inode(mnt->mnt_sb, NULL, S_IFREG | S_IRWXUGO, 0,
-				flags);
+				flags, false);
 	if (unlikely(!inode)) {
 		shmem_unacct_size(flags, size);
 		return ERR_PTR(-ENOSPC);
-- 
2.24.1

