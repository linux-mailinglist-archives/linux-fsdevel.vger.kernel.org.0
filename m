Return-Path: <linux-fsdevel+bounces-24298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECD793CFB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 10:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32381C22210
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 08:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E3A176FA5;
	Fri, 26 Jul 2024 08:38:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210D136D;
	Fri, 26 Jul 2024 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721983084; cv=none; b=iHI87LIAxZPiyOmKHJdqfD8jf9OtM+oGWA7mfWBYQz44LVXX+uZaqUk6qlYFKtFjdgs5N35468Jtntdx9xTjKTTZDtv+mb41FNUiJEbGyX1o1oSrbFNiaKoNuWa8WIwpFSJ04vVqzwXLlco7pssQv69HAVik2jxnvx7QzU45dUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721983084; c=relaxed/simple;
	bh=JPN1/EqE7psG706zCMN7NasTfroP+IGNgL45o0xJS7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qu9JusmLuAmpCzi/skI2j06ARaU0dqARQOPhlIsWd6vzyn4DtEYzSIsWQrk6eMrIEBj/2koJkG9Fbt+NdJxMauDPGlqg2bs7ljMM28CKz+i6LtMqQ66ZgPzVWaP93jGtHXEXarOp52B43nshHlAm/5Uj71SiSZT8Xghr0HH5AvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WVh024Lsvz1HFQV;
	Fri, 26 Jul 2024 16:35:14 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id E1CF51404F5;
	Fri, 26 Jul 2024 16:37:57 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemd100024.china.huawei.com
 (7.221.188.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 26 Jul
 2024 16:37:57 +0800
From: yangyun <yangyun50@huawei.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] fuse: replace fuse_queue_forget with fuse_force_forget if error
Date: Fri, 26 Jul 2024 16:37:51 +0800
Message-ID: <20240726083752.302301-2-yangyun50@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240726083752.302301-1-yangyun50@huawei.com>
References: <20240726083752.302301-1-yangyun50@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100024.china.huawei.com (7.221.188.41)

Most usecases for 'fuse_queue_forget' in the code are about reverting
the lookup count when error happens, except 'fuse_evict_inode' and
'fuse_cleanup_submount_lookup'. Even if there are no errors, it
still needs alloc 'struct fuse_forget_link'. It is useless, which
contributes to performance degradation and code mess to some extent.

'fuse_force_forget' does not need allocate 'struct fuse_forget_link'in
advance, and is only used by readdirplus before this patch for the reason
that we do not know how many 'fuse_forget_link' structures will be
allocated when error happens.

Signed-off-by: yangyun <yangyun50@huawei.com>
---
 fs/fuse/dev.c     | 19 +++++++++++++++
 fs/fuse/dir.c     | 59 +++++++++++------------------------------------
 fs/fuse/fuse_i.h  |  2 ++
 fs/fuse/readdir.c | 29 +++++------------------
 4 files changed, 40 insertions(+), 69 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9eb191b5c4de..932356833b0d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -252,6 +252,25 @@ void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
 	}
 }
 
+void fuse_force_forget(struct fuse_mount *fm, u64 nodeid)
+{
+	struct fuse_forget_in inarg;
+	FUSE_ARGS(args);
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.nlookup = 1;
+	args.opcode = FUSE_FORGET;
+	args.nodeid = nodeid;
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(inarg);
+	args.in_args[0].value = &inarg;
+	args.force = true;
+	args.noreply = true;
+
+	fuse_simple_request(fm, &args);
+	/* ignore errors */
+}
+
 static void flush_bg_queue(struct fuse_conn *fc)
 {
 	struct fuse_iqueue *fiq = &fc->iq;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2b0d4781f394..6bfb3a128658 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -207,7 +207,6 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 		 (flags & (LOOKUP_EXCL | LOOKUP_REVAL | LOOKUP_RENAME_TARGET))) {
 		struct fuse_entry_out outarg;
 		FUSE_ARGS(args);
-		struct fuse_forget_link *forget;
 		u64 attr_version;
 
 		/* For negative dentries, always do a fresh lookup */
@@ -220,11 +219,6 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 
 		fm = get_fuse_mount(inode);
 
-		forget = fuse_alloc_forget();
-		ret = -ENOMEM;
-		if (!forget)
-			goto out;
-
 		attr_version = fuse_get_attr_version(fm->fc);
 
 		parent = dget_parent(entry);
@@ -239,15 +233,13 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 			fi = get_fuse_inode(inode);
 			if (outarg.nodeid != get_node_id(inode) ||
 			    (bool) IS_AUTOMOUNT(inode) != (bool) (outarg.attr.flags & FUSE_ATTR_SUBMOUNT)) {
-				fuse_queue_forget(fm->fc, forget,
-						  outarg.nodeid, 1);
+				fuse_force_forget(fm, outarg.nodeid);
 				goto invalid;
 			}
 			spin_lock(&fi->lock);
 			fi->nlookup++;
 			spin_unlock(&fi->lock);
 		}
-		kfree(forget);
 		if (ret == -ENOMEM || ret == -EINTR)
 			goto out;
 		if (ret || fuse_invalid_attr(&outarg.attr) ||
@@ -365,7 +357,6 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 {
 	struct fuse_mount *fm = get_fuse_mount_super(sb);
 	FUSE_ARGS(args);
-	struct fuse_forget_link *forget;
 	u64 attr_version;
 	int err;
 
@@ -374,23 +365,17 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	if (name->len > FUSE_NAME_MAX)
 		goto out;
 
-
-	forget = fuse_alloc_forget();
-	err = -ENOMEM;
-	if (!forget)
-		goto out;
-
 	attr_version = fuse_get_attr_version(fm->fc);
 
 	fuse_lookup_init(fm->fc, &args, nodeid, name, outarg);
 	err = fuse_simple_request(fm, &args);
 	/* Zero nodeid is same as -ENOENT, but with valid timeout */
 	if (err || !outarg->nodeid)
-		goto out_put_forget;
+		goto out;
 
 	err = -EIO;
 	if (fuse_invalid_attr(&outarg->attr))
-		goto out_put_forget;
+		goto out;
 	if (outarg->nodeid == FUSE_ROOT_ID && outarg->generation != 0) {
 		pr_warn_once("root generation should be zero\n");
 		outarg->generation = 0;
@@ -401,13 +386,11 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 			   attr_version);
 	err = -ENOMEM;
 	if (!*inode) {
-		fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1);
+		fuse_force_forget(fm, outarg->nodeid);
 		goto out;
 	}
 	err = 0;
 
- out_put_forget:
-	kfree(forget);
  out:
 	return err;
 }
@@ -617,7 +600,6 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	struct inode *inode;
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	FUSE_ARGS(args);
-	struct fuse_forget_link *forget;
 	struct fuse_create_in inarg;
 	struct fuse_open_out *outopenp;
 	struct fuse_entry_out outentry;
@@ -628,15 +610,10 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	/* Userspace expects S_IFREG in create mode */
 	BUG_ON((mode & S_IFMT) != S_IFREG);
 
-	forget = fuse_alloc_forget();
-	err = -ENOMEM;
-	if (!forget)
-		goto out_err;
-
 	err = -ENOMEM;
 	ff = fuse_file_alloc(fm, true);
 	if (!ff)
-		goto out_put_forget_req;
+		goto out_err;
 
 	if (!fm->fc->dont_mask)
 		mode &= ~current_umask();
@@ -670,7 +647,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 
 	err = get_create_ext(&args, dir, entry, mode);
 	if (err)
-		goto out_put_forget_req;
+		goto out_err;
 
 	err = fuse_simple_request(fm, &args);
 	free_ext_value(&args);
@@ -690,11 +667,10 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	if (!inode) {
 		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
 		fuse_sync_release(NULL, ff, flags);
-		fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
+		fuse_force_forget(fm, outentry.nodeid);
 		err = -ENOMEM;
 		goto out_err;
 	}
-	kfree(forget);
 	d_instantiate(entry, inode);
 	fuse_change_entry_timeout(entry, &outentry);
 	fuse_dir_changed(dir);
@@ -716,8 +692,6 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 
 out_free_ff:
 	fuse_file_free(ff);
-out_put_forget_req:
-	kfree(forget);
 out_err:
 	return err;
 }
@@ -782,15 +756,10 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 	struct inode *inode;
 	struct dentry *d;
 	int err;
-	struct fuse_forget_link *forget;
 
 	if (fuse_is_bad(dir))
 		return -EIO;
 
-	forget = fuse_alloc_forget();
-	if (!forget)
-		return -ENOMEM;
-
 	memset(&outarg, 0, sizeof(outarg));
 	args->nodeid = get_node_id(dir);
 	args->out_numargs = 1;
@@ -800,28 +769,27 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 	if (args->opcode != FUSE_LINK) {
 		err = get_create_ext(args, dir, entry, mode);
 		if (err)
-			goto out_put_forget_req;
+			goto out_err;
 	}
 
 	err = fuse_simple_request(fm, args);
 	free_ext_value(args);
 	if (err)
-		goto out_put_forget_req;
+		goto out_err;
 
 	err = -EIO;
 	if (invalid_nodeid(outarg.nodeid) || fuse_invalid_attr(&outarg.attr))
-		goto out_put_forget_req;
+		goto out_err;
 
 	if ((outarg.attr.mode ^ mode) & S_IFMT)
-		goto out_put_forget_req;
+		goto out_err;
 
 	inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
 			  &outarg.attr, ATTR_TIMEOUT(&outarg), 0);
 	if (!inode) {
-		fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1);
+		fuse_force_forget(fm, outarg.nodeid);
 		return -ENOMEM;
 	}
-	kfree(forget);
 
 	d_drop(entry);
 	d = d_splice_alias(inode, entry);
@@ -837,10 +805,9 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 	fuse_dir_changed(dir);
 	return 0;
 
- out_put_forget_req:
+ out_err:
 	if (err == -EEXIST)
 		fuse_invalidate_entry(entry);
-	kfree(forget);
 	return err;
 }
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f23919610313..b9a5b8ec0de5 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1051,6 +1051,8 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
 		       u64 nodeid, u64 nlookup);
 
+void fuse_force_forget(struct fuse_mount *fm, u64 nodeid);
+
 struct fuse_forget_link *fuse_alloc_forget(void);
 
 struct fuse_forget_link *fuse_dequeue_forget(struct fuse_iqueue *fiq,
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 0377b6dc24c8..39f01ac31f7c 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -262,27 +262,6 @@ static int fuse_direntplus_link(struct file *file,
 	return 0;
 }
 
-static void fuse_force_forget(struct file *file, u64 nodeid)
-{
-	struct inode *inode = file_inode(file);
-	struct fuse_mount *fm = get_fuse_mount(inode);
-	struct fuse_forget_in inarg;
-	FUSE_ARGS(args);
-
-	memset(&inarg, 0, sizeof(inarg));
-	inarg.nlookup = 1;
-	args.opcode = FUSE_FORGET;
-	args.nodeid = nodeid;
-	args.in_numargs = 1;
-	args.in_args[0].size = sizeof(inarg);
-	args.in_args[0].value = &inarg;
-	args.force = true;
-	args.noreply = true;
-
-	fuse_simple_request(fm, &args);
-	/* ignore errors */
-}
-
 static int parse_dirplusfile(char *buf, size_t nbytes, struct file *file,
 			     struct dir_context *ctx, u64 attr_version)
 {
@@ -320,8 +299,12 @@ static int parse_dirplusfile(char *buf, size_t nbytes, struct file *file,
 		nbytes -= reclen;
 
 		ret = fuse_direntplus_link(file, direntplus, attr_version);
-		if (ret)
-			fuse_force_forget(file, direntplus->entry_out.nodeid);
+		if (ret) {
+			struct inode *inode = file_inode(file);
+			struct fuse_mount *fm = get_fuse_mount(inode);
+
+			fuse_force_forget(fm, direntplus->entry_out.nodeid);
+		}
 	}
 
 	return 0;
-- 
2.33.0


