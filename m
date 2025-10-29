Return-Path: <linux-fsdevel+bounces-65999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48358C179AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2FB81C675E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401A22D323F;
	Wed, 29 Oct 2025 00:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQzxhRDc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9789C22652D;
	Wed, 29 Oct 2025 00:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698652; cv=none; b=SIiFX+kI/qK6kgWktKPvm6c4WcNC6Xg7fFamj2N5hg19ZvmyPfnTS3kI6MsqONRCy71F/th1GGbUO5N+c3DoeZl5nsoowIn3NlwSk9MhInAVa+M0JDDwJhnQFHj0RCQmfMCr3xiqqeYI0kNeNoYV4kBM1GoxzBPBnUlNsVCNdic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698652; c=relaxed/simple;
	bh=NKhwwCNY6Y4TMvyi2UjgTcziPOBR/fKHrL/ldBNmUvc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JUEZdORiLLh+8HNN3jes8F/8lPv0teLusF22TkhnhSYVZXYjVG+JWeMFfRr2ypNBzNNrrtSVAbFXf30lgLrPKrFV8jU3cpzy7VQlVGsTJl8BSBJgr0ITd/PYfItfAIDwBSVSIsb1FAQ6fZ2Jh/+qEbs0X/9tq7EYUwvv41ATV7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQzxhRDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0743CC4CEE7;
	Wed, 29 Oct 2025 00:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698651;
	bh=NKhwwCNY6Y4TMvyi2UjgTcziPOBR/fKHrL/ldBNmUvc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=NQzxhRDcJE6ZC6KCnTawFu52b54+ioMuCW1GvTO3KD7h/Q9ri2rAS/MsTiN05xO7h
	 WhVZdsVs9a2zB1rHyIVy58nPjXtmNL8rDc9jRnSRK4MuYjo2byRUr2QHVF3hb3JIvq
	 rytVrM3fij+pS+ceJRIrbEAcOJioQpblP1IuH8JNOgRZqGeTWGWq+tSp9XWXE9Uk6p
	 QL01JW4h5I79AaaPOcvePhlM9z8J7uRT0fEf04N4mddh5mEQ+WaZdIZccZHGSE0ndV
	 zp+D8LMREcWaWI/tq17JaCsZdtwT329rnIKIyQfrOjpuHH1ALeujLEzSohscl7He5Y
	 Mfilmv8/fk1pw==
Date: Tue, 28 Oct 2025 17:44:10 -0700
Subject: [PATCH 5/5] fuse: propagate default and file acls on creation
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169809360.1424347.15464466375351097387.stgit@frogsfrogsfrogs>
In-Reply-To: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

For local filesystems, propagate the default and file access ACLs to new
children when creating them, just like the other in-kernel local
filesystems.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h |    4 ++
 fs/fuse/acl.c    |   65 ++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c    |   92 +++++++++++++++++++++++++++++++++++++++++-------------
 3 files changed, 138 insertions(+), 23 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d550937770e16e..1316c3853f68dc 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1527,6 +1527,10 @@ struct posix_acl *fuse_get_acl(struct mnt_idmap *idmap,
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
index 72bb4c94079b7b..4ba65ded008649 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -206,3 +206,68 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 
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
+	if (IS_POSIXACL(dir) && fuse_inode_has_local_acls(dir))
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
index 636d47a5127ca1..3c222b99d6e699 100644
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
 
@@ -778,7 +786,9 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
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
@@ -786,14 +796,18 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
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
@@ -823,7 +837,8 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
 			  &outarg.attr, ATTR_TIMEOUT(&outarg), 0, 0);
 	if (!inode) {
 		fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1);
-		return ERR_PTR(-ENOMEM);
+		err = -ENOMEM;
+		goto out_acl_release;
 	}
 	kfree(forget);
 
@@ -839,19 +854,31 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
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
@@ -862,7 +889,8 @@ static int create_new_nondir(struct mnt_idmap *idmap, struct fuse_mount *fm,
 	 */
 	WARN_ON_ONCE(S_ISDIR(mode));
 
-	return PTR_ERR(create_new_entry(idmap, fm, args, dir, entry, mode));
+	return PTR_ERR(create_new_entry(idmap, fm, args, dir, entry, mode,
+					default_acl, acl));
 }
 
 static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
@@ -870,10 +898,13 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
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
@@ -885,7 +916,8 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = entry->d_name.len + 1;
 	args.in_args[1].value = entry->d_name.name;
-	return create_new_nondir(idmap, fm, &args, dir, entry, mode);
+	return create_new_nondir(idmap, fm, &args, dir, entry, mode,
+				 default_acl, acl);
 }
 
 static int fuse_create(struct mnt_idmap *idmap, struct inode *dir,
@@ -917,13 +949,17 @@ static struct dentry *fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
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
@@ -931,7 +967,8 @@ static struct dentry *fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = entry->d_name.len + 1;
 	args.in_args[1].value = entry->d_name.name;
-	return create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR);
+	return create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR,
+				default_acl, acl);
 }
 
 static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
@@ -939,7 +976,14 @@ static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
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
@@ -948,7 +992,8 @@ static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[1].value = entry->d_name.name;
 	args.in_args[2].size = len;
 	args.in_args[2].value = link;
-	return create_new_nondir(idmap, fm, &args, dir, entry, S_IFLNK);
+	return create_new_nondir(idmap, fm, &args, dir, entry, S_IFLNK,
+				 default_acl, acl);
 }
 
 void fuse_flush_time_update(struct inode *inode)
@@ -1148,7 +1193,8 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = newent->d_name.len + 1;
 	args.in_args[1].value = newent->d_name.name;
-	err = create_new_nondir(&invalid_mnt_idmap, fm, &args, newdir, newent, inode->i_mode);
+	err = create_new_nondir(&invalid_mnt_idmap, fm, &args, newdir, newent,
+				inode->i_mode, NULL, NULL);
 	if (!err)
 		fuse_update_ctime_in_cache(inode);
 	else if (err == -EINTR)


