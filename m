Return-Path: <linux-fsdevel+bounces-27337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5838B9605B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 11:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD891F22F10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 09:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B8819E825;
	Tue, 27 Aug 2024 09:36:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323B919D8BB;
	Tue, 27 Aug 2024 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751364; cv=none; b=b83qgsqu7Elty9J+ffNcHGF2iwWuNDqHpexVaseGk47NVdsF0GkmljAi0w4NNoWT8XCuXj/X5nAGSFuO7CY4CYqWnbap3OUdnsF8zPDFDPt9VP0Ipm/XCBODX1Iy4VjH9t4W9CwS3YdYRJGxtdnHDtJXyL1EjfNtLn7VLkXfkKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751364; c=relaxed/simple;
	bh=8/yhPNP2fc16XKIyoBg5uaMAZ24LIogx7cVJhDKd0NA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bl4mz8aHwpSIuG+tZdwTBL2MH2t6l92U2vHmf7IP26PZb+IJ78eFMSv395+i8HRtbT5hD3ooQqtvyoTQaEONyvafoPFF9g13WJ0XYdeVMPncDmVHPbrAZBH8cU5GXpAwYWOZsbczPh6QAb/YPjg1M9eZtlJpa91U7KTYApM/9fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WtMq81ZjWz1S8tJ;
	Tue, 27 Aug 2024 17:35:48 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id BCA7D1A016C;
	Tue, 27 Aug 2024 17:35:58 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemd100024.china.huawei.com
 (7.221.188.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 17:35:58 +0800
From: yangyun <yangyun50@huawei.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: <josef@toxicpanda.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lixiaokeng@huawei.com>
Subject: [PATCH v3 1/2] fuse: move fuse_forget_link allocation inside fuse_queue_forget()
Date: Tue, 27 Aug 2024 17:35:02 +0800
Message-ID: <20240827093503.3397562-2-yangyun50@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240827093503.3397562-1-yangyun50@huawei.com>
References: <20240827093503.3397562-1-yangyun50@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100024.china.huawei.com (7.221.188.41)

The `struct fuse_forget_link` is allocated outside `fuse_queue_forget()`
before this patch. This requires the allocation in advance. In some
cases (e.g., directory operations without errors), this struct is not
needed but allocated, which contributes to memory usage and performance
degradation. Besides, this messes up the code to some extent. So move
the `fuse_forget_link` allocation inside `fuse_queue_forget()` with
__GFP_NOFAIL in these cases. Since the inode eviction path can be
triggered from memory reclaim and may block the system, it is better to
preallocate it on inode creation.

`fuse_force_forget()` is used by `readdirplus` before this patch for
the reason that we do not know how many 'fuse_forget_link' structures
will be allocated in advance when error happens. After this patch, this
function is not needed any more and can be removed (The `noreply`
fuse_args can also be removed). By this way, all FUSE_FORGET requests are
sent by using `fuse_queue_forget()` function as e.g. virtiofs handles them
differently from regular requests.

Signed-off-by: yangyun <yangyun50@huawei.com>
---
 fs/fuse/dev.c     | 13 ++++++++---
 fs/fuse/dir.c     | 59 +++++++++++------------------------------------
 fs/fuse/fuse_i.h  | 10 ++++----
 fs/fuse/inode.c   |  9 ++------
 fs/fuse/readdir.c | 30 ++++++------------------
 5 files changed, 38 insertions(+), 83 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9eb191b5c4de..31ca97b1b32c 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -234,10 +234,18 @@ __releases(fiq->lock)
 }
 
 void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
-		       u64 nodeid, u64 nlookup)
+			u64 nodeid, u64 nlookup)
 {
 	struct fuse_iqueue *fiq = &fc->iq;
 
+	/*
+	 * The nullptr means that fuse_queue_forget() is used in error cases.
+	 * Avoid preallocating this structure because it is unlikely used.
+	 * Use __GFP_NOFAIL to make memory allocation always succeed.
+	 */
+	if (forget == NULL)
+		forget = fuse_alloc_forget(GFP_KERNEL_ACCOUNT | __GFP_NOFAIL);
+
 	forget->forget_one.nodeid = nodeid;
 	forget->forget_one.nlookup = nlookup;
 
@@ -508,8 +516,7 @@ ssize_t fuse_simple_request(struct fuse_mount *fm, struct fuse_args *args)
 	fuse_adjust_compat(fc, args);
 	fuse_args_to_req(req, args);
 
-	if (!args->noreply)
-		__set_bit(FR_ISREPLY, &req->flags);
+	__set_bit(FR_ISREPLY, &req->flags);
 	__fuse_request_send(req);
 	ret = req->out.h.error;
 	if (!ret && args->out_argvar) {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2b0d4781f394..583362492ce0 100644
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
+				fuse_queue_forget(fm->fc, NULL, outarg.nodeid, 1);
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
+		fuse_queue_forget(fm->fc, NULL, outarg->nodeid, 1);
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
+		fuse_queue_forget(fm->fc, NULL, outentry.nodeid, 1);
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
+		fuse_queue_forget(fm->fc, NULL, outarg.nodeid, 1);
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
index f23919610313..0b9a02b3155f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -298,7 +298,6 @@ struct fuse_args {
 	uint8_t out_numargs;
 	uint8_t ext_idx;
 	bool force:1;
-	bool noreply:1;
 	bool nocreds:1;
 	bool in_pages:1;
 	bool out_pages:1;
@@ -1048,10 +1047,13 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 /**
  * Send FORGET command
  */
-void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
-		       u64 nodeid, u64 nlookup);
+static inline struct fuse_forget_link *fuse_alloc_forget(gfp_t flags)
+{
+	return kzalloc(sizeof(struct fuse_forget_link), flags);
+}
 
-struct fuse_forget_link *fuse_alloc_forget(void);
+void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link* forget,
+			u64 nodeid, u64 nlookup);
 
 struct fuse_forget_link *fuse_dequeue_forget(struct fuse_iqueue *fiq,
 					     unsigned int max,
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 99e44ea7d875..ecc867e21acd 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -63,11 +63,6 @@ MODULE_PARM_DESC(max_user_congthresh,
 static struct file_system_type fuseblk_fs_type;
 #endif
 
-struct fuse_forget_link *fuse_alloc_forget(void)
-{
-	return kzalloc(sizeof(struct fuse_forget_link), GFP_KERNEL_ACCOUNT);
-}
-
 static struct fuse_submount_lookup *fuse_alloc_submount_lookup(void)
 {
 	struct fuse_submount_lookup *sl;
@@ -75,7 +70,7 @@ static struct fuse_submount_lookup *fuse_alloc_submount_lookup(void)
 	sl = kzalloc(sizeof(struct fuse_submount_lookup), GFP_KERNEL_ACCOUNT);
 	if (!sl)
 		return NULL;
-	sl->forget = fuse_alloc_forget();
+	sl->forget = fuse_alloc_forget(GFP_KERNEL_ACCOUNT);
 	if (!sl->forget)
 		goto out_free;
 
@@ -104,7 +99,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->submount_lookup = NULL;
 	mutex_init(&fi->mutex);
 	spin_lock_init(&fi->lock);
-	fi->forget = fuse_alloc_forget();
+	fi->forget = fuse_alloc_forget(GFP_KERNEL_ACCOUNT);
 	if (!fi->forget)
 		goto out_free;
 
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 0377b6dc24c8..70d161f420c6 100644
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
@@ -320,8 +299,13 @@ static int parse_dirplusfile(char *buf, size_t nbytes, struct file *file,
 		nbytes -= reclen;
 
 		ret = fuse_direntplus_link(file, direntplus, attr_version);
-		if (ret)
-			fuse_force_forget(file, direntplus->entry_out.nodeid);
+		if (ret) {
+			struct inode *inode = file_inode(file);
+			struct fuse_mount *fm = get_fuse_mount(inode);
+
+			fuse_queue_forget(fm->fc, NULL,
+					direntplus->entry_out.nodeid, 1);
+		}
 	}
 
 	return 0;
-- 
2.33.0


