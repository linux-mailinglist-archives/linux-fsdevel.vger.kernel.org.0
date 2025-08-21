Return-Path: <linux-fsdevel+bounces-58440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2D2B2E9C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E235C83D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F631E5B70;
	Thu, 21 Aug 2025 00:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJCxBYhA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A8B18991E
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737534; cv=none; b=eju3vNeRSYdlojLGj31BXppmz+km1nqs2v+xfGmGhnztsu4238pKPtvuXDTOlG8sFuVtfbGzVO7YUzN/LBYzbNWy2qd1oRHffI6BukYA5UOe/zQY2QDSLXocRIUQ+4Bu1tE47YTVcx/N/U8kG6+nw6zjnJrZgIpsFZXcV6Mm/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737534; c=relaxed/simple;
	bh=xFtELia09TtFXdHOT4MH8bPdJnoBXwQ97XQcec7/uS4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNzpslUB2pZc8CEDOfeLO/ERE2TWENoKeGlKM1HQvrtGTpaj52UKv/Pygb6W6mLkFoHGZt58pXwHKBml73kIjLIR06ss5+ABcHuxHSV9ykDmAD/qIvVDHe0CVkTvUIqM8sx4N2piqByP8JlfsE8Lf4XXJ1cDRlbOlJeG+gmsF2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJCxBYhA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE60C4CEE7;
	Thu, 21 Aug 2025 00:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737534;
	bh=xFtELia09TtFXdHOT4MH8bPdJnoBXwQ97XQcec7/uS4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=WJCxBYhAoZ6QQ9MF7K3FVQE47vLXwP01zNWO+v+pzwwO/HCjvHk0JJ5crppaySolq
	 HzMp5ZMu+UrA/mZLRfI++oVNobfdKo1svWyjecyrNOET2EGvENHq80qTgwVIG3okuH
	 qzbQhzHyCoMiCBjAO5RdjfhbD0l8CsNL/uz5Eg/j6AMdQjHLDIG4UY4yaMMHOgui1C
	 dMCGJhaJAqB2hbdA1fGa+BWVWreZ2xTuHbEDlyJNwzAlkomeNFBASO3SiRB/qcU4+Y
	 Bx8nWmqLQy3AfE10EuRIxpXAsJIryl88e3i60wmCwvOy7ADfcV7sU0brX6748YuXv1
	 fV6fTbb23uHIg==
Date: Wed, 20 Aug 2025 17:52:14 -0700
Subject: [PATCH 6/7] fuse: propagate default and file acls on creation
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573708671.15537.10523102978043581580.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Propagate the default and file access ACLs to new children when creating
them, just like the other kernel filesystems.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h |    4 ++
 fs/fuse/acl.c    |   65 ++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c    |   92 +++++++++++++++++++++++++++++++++++++++++-------------
 3 files changed, 138 insertions(+), 23 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index bb1fdae0bbc906..b80505f5431e0b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1452,6 +1452,10 @@ struct posix_acl *fuse_get_acl(struct mnt_idmap *idmap,
 			       struct dentry *dentry, int type);
 int fuse_set_acl(struct mnt_idmap *, struct dentry *dentry,
 		 struct posix_acl *acl, int type);
+int fuse_acl_create(struct inode *dir, umode_t *mode,
+		    struct posix_acl **default_acl, struct posix_acl **acl);
+int fuse_init_acls(struct inode *inode, const struct posix_acl *default_acl,
+		   const struct posix_acl *acl);
 
 /* readdir.c */
 int fuse_readdir(struct file *file, struct dir_context *ctx);
diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 63df349dee1caf..4f37390e3f3ce7 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -193,3 +193,68 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	return ret;
 }
+
+int fuse_acl_create(struct inode *dir, umode_t *mode,
+		    struct posix_acl **default_acl, struct posix_acl **acl)
+{
+	struct fuse_conn *fc = get_fuse_conn(dir);
+
+	if (fuse_is_bad(dir))
+		return -EIO;
+
+	if (IS_POSIXACL(dir))
+		return posix_acl_create(dir, mode, default_acl, acl);
+
+	if (!fc->dont_mask)
+		*mode &= ~current_umask();
+
+	*default_acl = NULL;
+	*acl = NULL;
+	return 0;
+}
+
+static int __fuse_set_acl(struct inode *inode, const char *name,
+			  const struct posix_acl *acl)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	size_t size = posix_acl_xattr_size(acl->a_count);
+	void *value;
+	int ret;
+
+	if (size > PAGE_SIZE)
+		return -E2BIG;
+
+	value = kmalloc(size, GFP_KERNEL);
+	if (!value)
+		return -ENOMEM;
+
+	ret = posix_acl_to_xattr(fc->user_ns, acl, value, size);
+	if (ret < 0)
+		goto out_value;
+
+	ret = fuse_setxattr(inode, name, value, size, 0, 0);
+out_value:
+	kfree(value);
+	return ret;
+}
+
+int fuse_init_acls(struct inode *inode, const struct posix_acl *default_acl,
+		   const struct posix_acl *acl)
+{
+	int ret;
+
+	if (default_acl) {
+		ret = __fuse_set_acl(inode, XATTR_NAME_POSIX_ACL_DEFAULT,
+				     default_acl);
+		if (ret)
+			return ret;
+	}
+
+	if (acl) {
+		ret = __fuse_set_acl(inode, XATTR_NAME_POSIX_ACL_ACCESS, acl);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2e4d1131ab8cbe..8e922dcadb8675 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -628,26 +628,28 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 	struct fuse_entry_out outentry;
 	struct fuse_inode *fi;
 	struct fuse_file *ff;
+	struct posix_acl *default_acl = NULL, *acl = NULL;
 	int epoch, err;
 	bool trunc = flags & O_TRUNC;
 
 	/* Userspace expects S_IFREG in create mode */
 	BUG_ON((mode & S_IFMT) != S_IFREG);
 
+	err = fuse_acl_create(dir, &mode, &default_acl, &acl);
+	if (err)
+		return err;
+
 	epoch = atomic_read(&fm->fc->epoch);
 	forget = fuse_alloc_forget();
 	err = -ENOMEM;
 	if (!forget)
-		goto out_err;
+		goto out_acl_release;
 
 	err = -ENOMEM;
 	ff = fuse_file_alloc(fm, true);
 	if (!ff)
 		goto out_put_forget_req;
 
-	if (!fm->fc->dont_mask)
-		mode &= ~current_umask();
-
 	flags &= ~O_NOCTTY;
 	memset(&inarg, 0, sizeof(inarg));
 	memset(&outentry, 0, sizeof(outentry));
@@ -699,12 +701,16 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 		fuse_sync_release(NULL, ff, flags);
 		fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
 		err = -ENOMEM;
-		goto out_err;
+		goto out_acl_release;
 	}
 	kfree(forget);
 	d_instantiate(entry, inode);
 	entry->d_time = epoch;
 	fuse_change_entry_timeout(entry, &outentry);
+
+	err = fuse_init_acls(inode, default_acl, acl);
+	if (err)
+		goto out_acl_release;
 	fuse_dir_changed(dir);
 	err = generic_file_open(inode, file);
 	if (!err) {
@@ -726,7 +732,9 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 	fuse_file_free(ff);
 out_put_forget_req:
 	kfree(forget);
-out_err:
+out_acl_release:
+	posix_acl_release(default_acl);
+	posix_acl_release(acl);
 	return err;
 }
 
@@ -785,7 +793,9 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
  */
 static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_mount *fm,
 				       struct fuse_args *args, struct inode *dir,
-				       struct dentry *entry, umode_t mode)
+				       struct dentry *entry, umode_t mode,
+				       struct posix_acl *default_acl,
+				       struct posix_acl *acl)
 {
 	struct fuse_entry_out outarg;
 	struct inode *inode;
@@ -793,14 +803,18 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
 	struct fuse_forget_link *forget;
 	int epoch, err;
 
-	if (fuse_is_bad(dir))
-		return ERR_PTR(-EIO);
+	if (fuse_is_bad(dir)) {
+		err = -EIO;
+		goto out_acl_release;
+	}
 
 	epoch = atomic_read(&fm->fc->epoch);
 
 	forget = fuse_alloc_forget();
-	if (!forget)
-		return ERR_PTR(-ENOMEM);
+	if (!forget) {
+		err = -ENOMEM;
+		goto out_acl_release;
+	}
 
 	memset(&outarg, 0, sizeof(outarg));
 	args->nodeid = get_node_id(dir);
@@ -830,7 +844,8 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
 			  &outarg.attr, ATTR_TIMEOUT(&outarg), 0, 0);
 	if (!inode) {
 		fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1);
-		return ERR_PTR(-ENOMEM);
+		err = -ENOMEM;
+		goto out_acl_release;
 	}
 	kfree(forget);
 
@@ -846,19 +861,31 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
 		entry->d_time = epoch;
 		fuse_change_entry_timeout(entry, &outarg);
 	}
+
+	err = fuse_init_acls(inode, default_acl, acl);
+	if (err)
+		goto out_acl_release;
 	fuse_dir_changed(dir);
+
+	posix_acl_release(default_acl);
+	posix_acl_release(acl);
 	return d;
 
  out_put_forget_req:
 	if (err == -EEXIST)
 		fuse_invalidate_entry(entry);
 	kfree(forget);
+ out_acl_release:
+	posix_acl_release(default_acl);
+	posix_acl_release(acl);
 	return ERR_PTR(err);
 }
 
 static int create_new_nondir(struct mnt_idmap *idmap, struct fuse_mount *fm,
 			     struct fuse_args *args, struct inode *dir,
-			     struct dentry *entry, umode_t mode)
+			     struct dentry *entry, umode_t mode,
+			     struct posix_acl *default_acl,
+			     struct posix_acl *acl)
 {
 	/*
 	 * Note that when creating anything other than a directory we
@@ -869,7 +896,8 @@ static int create_new_nondir(struct mnt_idmap *idmap, struct fuse_mount *fm,
 	 */
 	WARN_ON_ONCE(S_ISDIR(mode));
 
-	return PTR_ERR(create_new_entry(idmap, fm, args, dir, entry, mode));
+	return PTR_ERR(create_new_entry(idmap, fm, args, dir, entry, mode,
+					default_acl, acl));
 }
 
 static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
@@ -877,10 +905,13 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
 {
 	struct fuse_mknod_in inarg;
 	struct fuse_mount *fm = get_fuse_mount(dir);
+	struct posix_acl *default_acl, *acl;
 	FUSE_ARGS(args);
+	int err;
 
-	if (!fm->fc->dont_mask)
-		mode &= ~current_umask();
+	err = fuse_acl_create(dir, &mode, &default_acl, &acl);
+	if (err)
+		return err;
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.mode = mode;
@@ -892,7 +923,8 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = entry->d_name.len + 1;
 	args.in_args[1].value = entry->d_name.name;
-	return create_new_nondir(idmap, fm, &args, dir, entry, mode);
+	return create_new_nondir(idmap, fm, &args, dir, entry, mode,
+				 default_acl, acl);
 }
 
 static int fuse_create(struct mnt_idmap *idmap, struct inode *dir,
@@ -924,13 +956,17 @@ static struct dentry *fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 {
 	struct fuse_mkdir_in inarg;
 	struct fuse_mount *fm = get_fuse_mount(dir);
+	struct posix_acl *default_acl, *acl;
 	FUSE_ARGS(args);
+	int err;
 
-	if (!fm->fc->dont_mask)
-		mode &= ~current_umask();
+	mode |= S_IFDIR;	/* vfs doesn't set S_IFDIR for us */
+	err = fuse_acl_create(dir, &mode, &default_acl, &acl);
+	if (err)
+		return ERR_PTR(err);
 
 	memset(&inarg, 0, sizeof(inarg));
-	inarg.mode = mode;
+	inarg.mode = mode & ~S_IFDIR;
 	inarg.umask = current_umask();
 	args.opcode = FUSE_MKDIR;
 	args.in_numargs = 2;
@@ -938,7 +974,8 @@ static struct dentry *fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = entry->d_name.len + 1;
 	args.in_args[1].value = entry->d_name.name;
-	return create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR);
+	return create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR,
+				default_acl, acl);
 }
 
 static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
@@ -946,7 +983,14 @@ static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
 {
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	unsigned len = strlen(link) + 1;
+	struct posix_acl *default_acl, *acl;
+	umode_t mode = S_IFLNK | 0777;
 	FUSE_ARGS(args);
+	int err;
+
+	err = fuse_acl_create(dir, &mode, &default_acl, &acl);
+	if (err)
+		return err;
 
 	args.opcode = FUSE_SYMLINK;
 	args.in_numargs = 3;
@@ -955,7 +999,8 @@ static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[1].value = entry->d_name.name;
 	args.in_args[2].size = len;
 	args.in_args[2].value = link;
-	return create_new_nondir(idmap, fm, &args, dir, entry, S_IFLNK);
+	return create_new_nondir(idmap, fm, &args, dir, entry, S_IFLNK,
+				 default_acl, acl);
 }
 
 void fuse_flush_time_update(struct inode *inode)
@@ -1155,7 +1200,8 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = newent->d_name.len + 1;
 	args.in_args[1].value = newent->d_name.name;
-	err = create_new_nondir(&invalid_mnt_idmap, fm, &args, newdir, newent, inode->i_mode);
+	err = create_new_nondir(&invalid_mnt_idmap, fm, &args, newdir, newent,
+				inode->i_mode, NULL, NULL);
 	if (!err)
 		fuse_update_ctime_in_cache(inode);
 	else if (err == -EINTR)


