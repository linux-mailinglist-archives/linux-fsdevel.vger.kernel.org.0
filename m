Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E885BCE20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 16:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiISOLN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 10:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiISOLK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F74831EF4
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 07:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663596648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D8GWN68mp0xnKhyXIjx2aULUMOVtUcygRhxHd/PDryc=;
        b=UZLVchWmfHRtyKzGjsFEKKVHwH/v6+WUR+8pErJisMVi0dJUDqyK8rK6wW9HaQdPT+LhYT
        /HFyGjh4VXRvo6BxYw0CXIaL7ORtngfQI3SsO3ywPB3C9dszux+Nm+dwUNTFlrfpzOTLN8
        XYBMT1rNDgF7O+jMPxYO+2r9u77+vUs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-536-sy0OiUdhNq-Fsnylmhc4bQ-1; Mon, 19 Sep 2022 10:10:46 -0400
X-MC-Unique: sy0OiUdhNq-Fsnylmhc4bQ-1
Received: by mail-ed1-f70.google.com with SMTP id r11-20020a05640251cb00b004516feb8c09so17475317edd.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 07:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=D8GWN68mp0xnKhyXIjx2aULUMOVtUcygRhxHd/PDryc=;
        b=U5HEnKvqJTsBjMG3R2WXz9w+778DKdg4rKmU5yJHt4CWiTl0QZpHc9MKCu2yOjnEX+
         leUA96ClflhZW2mxtYXhbwmTqQtDm6X7FhV28yAbnOgcfVFqrt0KfeOblIVZWWSE0mZM
         9SKl7rLHwOmvfNMaIC/p3ensz5YRFbvXn56oxpmU2/1OhMIVEsKQoq3aWhXcR08gyTcM
         OdRY0Lhy0WNwzEM+itaZnUHJDzJvaIFdVadQ0Gk5SqX+qcKw6UpNjhPL/6XDEkwSs8Iu
         6Sk70BTASCLaQTaNbCJzFg7RfZ0sSaHxgzTZ+FQV7yiTTmF59ltcMbiwzu5666QgANox
         kmaA==
X-Gm-Message-State: ACrzQf18b8ddagU14jbT3AzDo3oxcpP2XvvTaqi18noDLxPSNkBEsYPW
        e8uF0rnjtpvBbQuCAU/um+9fkMzGGU/4a9+Tq1g+E88mCaAjKDTKLokywpF/TeecO0Mnx184cDt
        y+sqadMylUr9wQ9tbmEGh5nLHx+5k6ixk/QOWmq2efr/3kD6GfGn1RbsGyWXa0fDXTUbzQgSCCj
        4Lwg==
X-Received: by 2002:a17:906:a219:b0:6e4:86a3:44ea with SMTP id r25-20020a170906a21900b006e486a344eamr13560943ejy.385.1663596644559;
        Mon, 19 Sep 2022 07:10:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM41wDXaA+iOQgG2f7UhAqeOf/8a0vCRa8GCPdq3k/exkrDXx2uywgwqnYDHofnr0uFqj4zrRg==
X-Received: by 2002:a17:906:a219:b0:6e4:86a3:44ea with SMTP id r25-20020a170906a21900b006e486a344eamr13560912ejy.385.1663596644145;
        Mon, 19 Sep 2022 07:10:44 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id lb22-20020a170907785600b0073bdf71995dsm9849951ejc.139.2022.09.19.07.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 07:10:43 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v2 7/8] vfs: open inside ->tmpfile()
Date:   Mon, 19 Sep 2022 16:10:30 +0200
Message-Id: <20220919141031.1834447-8-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220919141031.1834447-1-mszeredi@redhat.com>
References: <20220919141031.1834447-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is in preparation for adding tmpfile support to fuse, which requires
that the tmpfile creation and opening are done as a single operation.

Replace the 'struct dentry *' argument of i_op->tmpfile with
'struct file *'.

Call finish_open_simple() as the last thing in ->tmpfile() instances (may be
omitted in the error case).

Change d_tmpfile() argument to 'struct file *' as well to make callers more
readable.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/bad_inode.c         |  2 +-
 fs/btrfs/inode.c       |  8 ++++----
 fs/dcache.c            |  4 +++-
 fs/ext2/namei.c        |  6 +++---
 fs/ext4/namei.c        |  6 +++---
 fs/f2fs/namei.c        | 13 ++++++++-----
 fs/hugetlbfs/inode.c   | 12 +++++++-----
 fs/minix/namei.c       |  6 +++---
 fs/namei.c             |  3 +--
 fs/ramfs/inode.c       |  6 +++---
 fs/ubifs/dir.c         |  7 ++++---
 fs/udf/namei.c         |  6 +++---
 fs/xfs/xfs_iops.c      | 16 +++++++++-------
 include/linux/dcache.h |  3 ++-
 include/linux/fs.h     |  2 +-
 mm/shmem.c             |  6 +++---
 16 files changed, 58 insertions(+), 48 deletions(-)

diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 12b8fdcc445b..9d1cde8066cf 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -147,7 +147,7 @@ static int bad_inode_atomic_open(struct inode *inode, struct dentry *dentry,
 }
 
 static int bad_inode_tmpfile(struct user_namespace *mnt_userns,
-			     struct inode *inode, struct dentry *dentry,
+			     struct inode *inode, struct file *file,
 			     umode_t mode)
 {
 	return -EIO;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1372210869b1..416373721085 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10168,7 +10168,7 @@ static int btrfs_permission(struct user_namespace *mnt_userns,
 }
 
 static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
-			 struct dentry *dentry, umode_t mode)
+			 struct file *file, umode_t mode)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct btrfs_trans_handle *trans;
@@ -10176,7 +10176,7 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	struct inode *inode;
 	struct btrfs_new_inode_args new_inode_args = {
 		.dir = dir,
-		.dentry = dentry,
+		.dentry = file->f_path.dentry,
 		.orphan = true,
 	};
 	unsigned int trans_num_items;
@@ -10213,7 +10213,7 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	set_nlink(inode, 1);
 
 	if (!ret) {
-		d_tmpfile(dentry, inode);
+		d_tmpfile(file, inode);
 		unlock_new_inode(inode);
 		mark_inode_dirty(inode);
 	}
@@ -10225,7 +10225,7 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 out_inode:
 	if (ret)
 		iput(inode);
-	return ret;
+	return finish_open_simple(file, ret);
 }
 
 void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end)
diff --git a/fs/dcache.c b/fs/dcache.c
index bb0c4d0038db..89dc61389102 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3258,8 +3258,10 @@ void d_genocide(struct dentry *parent)
 
 EXPORT_SYMBOL(d_genocide);
 
-void d_tmpfile(struct dentry *dentry, struct inode *inode)
+void d_tmpfile(struct file *file, struct inode *inode)
 {
+	struct dentry *dentry = file->f_path.dentry;
+
 	inode_dec_link_count(inode);
 	BUG_ON(dentry->d_name.name != dentry->d_iname ||
 		!hlist_unhashed(&dentry->d_u.d_alias) ||
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 5fd9a22d2b70..9125eab85146 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -120,7 +120,7 @@ static int ext2_create (struct user_namespace * mnt_userns,
 }
 
 static int ext2_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
-			struct dentry *dentry, umode_t mode)
+			struct file *file, umode_t mode)
 {
 	struct inode *inode = ext2_new_inode(dir, mode, NULL);
 	if (IS_ERR(inode))
@@ -128,9 +128,9 @@ static int ext2_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 
 	ext2_set_file_ops(inode);
 	mark_inode_dirty(inode);
-	d_tmpfile(dentry, inode);
+	d_tmpfile(file, inode);
 	unlock_new_inode(inode);
-	return 0;
+	return finish_open_simple(file, 0);
 }
 
 static int ext2_mknod (struct user_namespace * mnt_userns, struct inode * dir,
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 3a31b662f661..9c3fde633a6e 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2849,7 +2849,7 @@ static int ext4_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 }
 
 static int ext4_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
-			struct dentry *dentry, umode_t mode)
+			struct file *file, umode_t mode)
 {
 	handle_t *handle;
 	struct inode *inode;
@@ -2871,7 +2871,7 @@ static int ext4_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 		inode->i_op = &ext4_file_inode_operations;
 		inode->i_fop = &ext4_file_operations;
 		ext4_set_aops(inode);
-		d_tmpfile(dentry, inode);
+		d_tmpfile(file, inode);
 		err = ext4_orphan_add(handle, inode);
 		if (err)
 			goto err_unlock_inode;
@@ -2882,7 +2882,7 @@ static int ext4_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 		ext4_journal_stop(handle);
 	if (err == -ENOSPC && ext4_should_retry_alloc(dir->i_sb, &retries))
 		goto retry;
-	return err;
+	return finish_open_simple(file, err);
 err_unlock_inode:
 	ext4_journal_stop(handle);
 	unlock_new_inode(inode);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index bf00d5057abb..d5065a5af1f8 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -845,7 +845,7 @@ static int f2fs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 }
 
 static int __f2fs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
-			  struct dentry *dentry, umode_t mode, bool is_whiteout,
+			  struct file *file, umode_t mode, bool is_whiteout,
 			  struct inode **new_inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
@@ -892,8 +892,8 @@ static int __f2fs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 		inode->i_state |= I_LINKABLE;
 		spin_unlock(&inode->i_lock);
 	} else {
-		if (dentry)
-			d_tmpfile(dentry, inode);
+		if (file)
+			d_tmpfile(file, inode);
 		else
 			f2fs_i_links_write(inode, false);
 	}
@@ -915,16 +915,19 @@ static int __f2fs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 }
 
 static int f2fs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
-			struct dentry *dentry, umode_t mode)
+			struct file *file, umode_t mode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
+	int err;
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
 	if (!f2fs_is_checkpoint_ready(sbi))
 		return -ENOSPC;
 
-	return __f2fs_tmpfile(mnt_userns, dir, dentry, mode, false, NULL);
+	err = __f2fs_tmpfile(mnt_userns, dir, file, mode, false, NULL);
+
+	return finish_open_simple(file, err);
 }
 
 static int f2fs_create_whiteout(struct user_namespace *mnt_userns,
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index f7a5b5124d8a..eb8689c83369 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -889,7 +889,7 @@ static int do_hugetlbfs_mknod(struct inode *dir,
 			struct dentry *dentry,
 			umode_t mode,
 			dev_t dev,
-			bool tmpfile)
+			struct file *tmpfile)
 {
 	struct inode *inode;
 	int error = -ENOSPC;
@@ -898,7 +898,7 @@ static int do_hugetlbfs_mknod(struct inode *dir,
 	if (inode) {
 		dir->i_ctime = dir->i_mtime = current_time(dir);
 		if (tmpfile) {
-			d_tmpfile(dentry, inode);
+			d_tmpfile(tmpfile, inode);
 		} else {
 			d_instantiate(dentry, inode);
 			dget(dentry);/* Extra count - pin the dentry in core */
@@ -911,7 +911,7 @@ static int do_hugetlbfs_mknod(struct inode *dir,
 static int hugetlbfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 			   struct dentry *dentry, umode_t mode, dev_t dev)
 {
-	return do_hugetlbfs_mknod(dir, dentry, mode, dev, false);
+	return do_hugetlbfs_mknod(dir, dentry, mode, dev, NULL);
 }
 
 static int hugetlbfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
@@ -932,10 +932,12 @@ static int hugetlbfs_create(struct user_namespace *mnt_userns,
 }
 
 static int hugetlbfs_tmpfile(struct user_namespace *mnt_userns,
-			     struct inode *dir, struct dentry *dentry,
+			     struct inode *dir, struct file *file,
 			     umode_t mode)
 {
-	return do_hugetlbfs_mknod(dir, dentry, mode | S_IFREG, 0, true);
+	int err = do_hugetlbfs_mknod(dir, file->f_path.dentry, mode | S_IFREG, 0, file);
+
+	return finish_open_simple(file, err);
 }
 
 static int hugetlbfs_symlink(struct user_namespace *mnt_userns,
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 937fa5fae2b8..8afdc408ca4f 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -53,16 +53,16 @@ static int minix_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 }
 
 static int minix_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
-			 struct dentry *dentry, umode_t mode)
+			 struct file *file, umode_t mode)
 {
 	int error;
 	struct inode *inode = minix_new_inode(dir, mode, &error);
 	if (inode) {
 		minix_set_inode(inode, 0);
 		mark_inode_dirty(inode);
-		d_tmpfile(dentry, inode);
+		d_tmpfile(file, inode);
 	}
-	return error;
+	return finish_open_simple(file, error);
 }
 
 static int minix_create(struct user_namespace *mnt_userns, struct inode *dir,
diff --git a/fs/namei.c b/fs/namei.c
index eb1e1956450f..1548161b563c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3606,8 +3606,7 @@ static int vfs_tmpfile(struct user_namespace *mnt_userns,
 	file->f_path.mnt = parentpath->mnt;
 	file->f_path.dentry = child;
 	mode = vfs_prepare_mode(mnt_userns, dir, mode, mode, mode);
-	error = dir->i_op->tmpfile(mnt_userns, dir, child, mode);
-	error = finish_open_simple(file, error);
+	error = dir->i_op->tmpfile(mnt_userns, dir, file, mode);
 	dput(child);
 	if (error)
 		goto out_err;
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index bc66d0173e33..b3257e852820 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -146,15 +146,15 @@ static int ramfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 }
 
 static int ramfs_tmpfile(struct user_namespace *mnt_userns,
-			 struct inode *dir, struct dentry *dentry, umode_t mode)
+			 struct inode *dir, struct file *file, umode_t mode)
 {
 	struct inode *inode;
 
 	inode = ramfs_get_inode(dir->i_sb, dir, mode, 0);
 	if (!inode)
 		return -ENOSPC;
-	d_tmpfile(dentry, inode);
-	return 0;
+	d_tmpfile(file, inode);
+	return finish_open_simple(file, 0);
 }
 
 static const struct inode_operations ramfs_dir_inode_operations = {
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 86151889548e..f59acd6a3615 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -424,8 +424,9 @@ static void unlock_2_inodes(struct inode *inode1, struct inode *inode2)
 }
 
 static int ubifs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
-			 struct dentry *dentry, umode_t mode)
+			 struct file *file, umode_t mode)
 {
+	struct dentry *dentry = file->f_path.dentry;
 	struct inode *inode;
 	struct ubifs_info *c = dir->i_sb->s_fs_info;
 	struct ubifs_budget_req req = { .new_ino = 1, .new_dent = 1,
@@ -475,7 +476,7 @@ static int ubifs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 
 	mutex_lock(&ui->ui_mutex);
 	insert_inode_hash(inode);
-	d_tmpfile(dentry, inode);
+	d_tmpfile(file, inode);
 	ubifs_assert(c, ui->dirty);
 
 	instantiated = 1;
@@ -489,7 +490,7 @@ static int ubifs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 
 	ubifs_release_budget(c, &req);
 
-	return 0;
+	return finish_open_simple(file, 0);
 
 out_cancel:
 	unlock_2_inodes(dir, inode);
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index b3d5f97f16cd..fb4c30e05245 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -626,7 +626,7 @@ static int udf_create(struct user_namespace *mnt_userns, struct inode *dir,
 }
 
 static int udf_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
-		       struct dentry *dentry, umode_t mode)
+		       struct file *file, umode_t mode)
 {
 	struct inode *inode = udf_new_inode(dir, mode);
 
@@ -640,9 +640,9 @@ static int udf_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	inode->i_op = &udf_file_inode_operations;
 	inode->i_fop = &udf_file_operations;
 	mark_inode_dirty(inode);
-	d_tmpfile(dentry, inode);
+	d_tmpfile(file, inode);
 	unlock_new_inode(inode);
-	return 0;
+	return finish_open_simple(file, 0);
 }
 
 static int udf_mknod(struct user_namespace *mnt_userns, struct inode *dir,
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 45518b8c613c..764409c466fd 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -167,7 +167,7 @@ xfs_generic_create(
 	struct dentry	*dentry,
 	umode_t		mode,
 	dev_t		rdev,
-	bool		tmpfile)	/* unnamed file */
+	struct file	*tmpfile)	/* unnamed file */
 {
 	struct inode	*inode;
 	struct xfs_inode *ip = NULL;
@@ -234,7 +234,7 @@ xfs_generic_create(
 		 * d_tmpfile can immediately set it back to zero.
 		 */
 		set_nlink(inode, 1);
-		d_tmpfile(dentry, inode);
+		d_tmpfile(tmpfile, inode);
 	} else
 		d_instantiate(dentry, inode);
 
@@ -261,7 +261,7 @@ xfs_vn_mknod(
 	umode_t			mode,
 	dev_t			rdev)
 {
-	return xfs_generic_create(mnt_userns, dir, dentry, mode, rdev, false);
+	return xfs_generic_create(mnt_userns, dir, dentry, mode, rdev, NULL);
 }
 
 STATIC int
@@ -272,7 +272,7 @@ xfs_vn_create(
 	umode_t			mode,
 	bool			flags)
 {
-	return xfs_generic_create(mnt_userns, dir, dentry, mode, 0, false);
+	return xfs_generic_create(mnt_userns, dir, dentry, mode, 0, NULL);
 }
 
 STATIC int
@@ -283,7 +283,7 @@ xfs_vn_mkdir(
 	umode_t			mode)
 {
 	return xfs_generic_create(mnt_userns, dir, dentry, mode | S_IFDIR, 0,
-				  false);
+				  NULL);
 }
 
 STATIC struct dentry *
@@ -1080,10 +1080,12 @@ STATIC int
 xfs_vn_tmpfile(
 	struct user_namespace	*mnt_userns,
 	struct inode		*dir,
-	struct dentry		*dentry,
+	struct file		*file,
 	umode_t			mode)
 {
-	return xfs_generic_create(mnt_userns, dir, dentry, mode, 0, true);
+	int err = xfs_generic_create(mnt_userns, dir, file->f_path.dentry, mode, 0, file);
+
+	return finish_open_simple(file, err);
 }
 
 static const struct inode_operations xfs_inode_operations = {
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 92c78ed02b54..bde9f8ff8869 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -16,6 +16,7 @@
 #include <linux/wait.h>
 
 struct path;
+struct file;
 struct vfsmount;
 
 /*
@@ -250,7 +251,7 @@ extern struct dentry * d_make_root(struct inode *);
 /* <clickety>-<click> the ramfs-type tree */
 extern void d_genocide(struct dentry *);
 
-extern void d_tmpfile(struct dentry *, struct inode *);
+extern void d_tmpfile(struct file *, struct inode *);
 
 extern struct dentry *d_find_alias(struct inode *);
 extern void d_prune_aliases(struct inode *);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f0d17eefb966..e08efecd2644 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2168,7 +2168,7 @@ struct inode_operations {
 			   struct file *, unsigned open_flag,
 			   umode_t create_mode);
 	int (*tmpfile) (struct user_namespace *, struct inode *,
-			struct dentry *, umode_t);
+			struct file *, umode_t);
 	int (*set_acl)(struct user_namespace *, struct inode *,
 		       struct posix_acl *, int);
 	int (*fileattr_set)(struct user_namespace *mnt_userns,
diff --git a/mm/shmem.c b/mm/shmem.c
index 42e5888bf84d..f63c51bc373e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2912,7 +2912,7 @@ shmem_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 
 static int
 shmem_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
-	      struct dentry *dentry, umode_t mode)
+	      struct file *file, umode_t mode)
 {
 	struct inode *inode;
 	int error = -ENOSPC;
@@ -2927,9 +2927,9 @@ shmem_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 		error = simple_acl_create(dir, inode);
 		if (error)
 			goto out_iput;
-		d_tmpfile(dentry, inode);
+		d_tmpfile(file, inode);
 	}
-	return error;
+	return finish_open_simple(file, error);
 out_iput:
 	iput(inode);
 	return error;
-- 
2.37.3

