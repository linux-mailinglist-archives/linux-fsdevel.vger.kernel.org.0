Return-Path: <linux-fsdevel+bounces-14746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7725487ECD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 16:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2A09B210BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 15:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B0D53388;
	Mon, 18 Mar 2024 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0osGg8N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350C853370;
	Mon, 18 Mar 2024 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777472; cv=none; b=ebBrU+CvEPe4nWK8uwebz1iLWkPsnccD2kpXIYmKHhoByNSL3NCm0GM1P2FOI2f1McoIy2jGtzQPrEsFBU2J4jOFoYJMG2lezZZdEYH0rHC3NdZO+gcRyXhTQqqMROC5Ng8XtQeMk59jRr3ijY6yislXeWQr8TIPLwzC2RwWuxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777472; c=relaxed/simple;
	bh=3PGrgQ/GAS3VF9KtgV8zanRsYfd4CpmUM3lDnZCg69I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufQiVZWFJ1lWguepV1PqfPOkZoh/7k2cDoQ0SfqDnKR1AYqziUWWCz0SAIdzY/j1pTLLgL9QLJWzz4Qkt9d2R7U3l3Mv72pecXofcYAnrXPBojsRxKwiBWx1iq0Rr++DVczapcGTDvpA7zkglUchO9Tkwn6CBfTHSXGnE0ubDXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0osGg8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647AEC433F1;
	Mon, 18 Mar 2024 15:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710777471;
	bh=3PGrgQ/GAS3VF9KtgV8zanRsYfd4CpmUM3lDnZCg69I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W0osGg8NextrEzUMbhoaAHooYSoUn98MeDcIw4gLGcf1ttPyhsq/P7XGkCHJYfPZV
	 f9SS9viEtuBk9vj47pwoob9NKLNV4FWHqEjJybew8zV5CR7XCahQw5eXvQV4Q7n7Sf
	 /sl1cNjpsACcZRMk6XWEYrMHpmCw3oNCJARugjd2kqrugNERG88dn8POSiKFQ29Jzj
	 v4K5ag+7/G6PjaoghuL0sT7zopkTeETVWp+AQaJ1DF1NTIW6PtpsmK+W9Fj4I51hL9
	 lusEgB1nzEoovrHEfJpk7rrpms1iUNUUVugo9s5itwXmhbgjDIwMqY+PXYh/kGHmBa
	 Sy5GuceWmcRMQ==
Date: Mon, 18 Mar 2024 16:57:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: amir73il@gmail.com, hu1.chen@intel.com, miklos@szeredi.hu, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	lizhen.you@intel.com, linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 1/5] cleanup: Fix discarded const warning when defining
 lock guard
Message-ID: <20240318-dehnen-entdecken-dd436f42f91a@brauner>
References: <20240216051640.197378-1-vinicius.gomes@intel.com>
 <20240216051640.197378-2-vinicius.gomes@intel.com>
 <20240318-flocken-nagetiere-1e027955d06e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240318-flocken-nagetiere-1e027955d06e@brauner>

On Mon, Mar 18, 2024 at 04:13:12PM +0100, Christian Brauner wrote:
> On Thu, Feb 15, 2024 at 09:16:36PM -0800, Vinicius Costa Gomes wrote:
> > Fix the following warning when defining a cleanup guard for a "const"
> > pointer type:
> > 
> > ./include/linux/cleanup.h:211:18: warning: return discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
> >   211 |         return _T->lock;                                                \
> >       |                ~~^~~~~~
> > ./include/linux/cleanup.h:233:1: note: in expansion of macro ‘__DEFINE_UNLOCK_GUARD’
> >   233 | __DEFINE_UNLOCK_GUARD(_name, _type, _unlock, __VA_ARGS__)               \
> >       | ^~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/cred.h:193:1: note: in expansion of macro ‘DEFINE_LOCK_GUARD_1’
> >   193 | DEFINE_LOCK_GUARD_1(cred, const struct cred, _T->lock = override_creds_light(_T->lock),
> >       | ^~~~~~~~~~~~~~~~~~~
> > 
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > ---
> >  include/linux/cleanup.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> > index c2d09bc4f976..085482ef46c8 100644
> > --- a/include/linux/cleanup.h
> > +++ b/include/linux/cleanup.h
> > @@ -208,7 +208,7 @@ static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
> >  									\
> >  static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T)	\
> >  {									\
> > -	return _T->lock;						\
> > +	return (void *)_T->lock;					\
> >  }
> 
> I think both of these patches are a bit ugly as we burden the generic
> cleanup code with casting to void which could cause actual issues.
> 
> Casting from const to non-const is rather specific to the cred code so I
> would rather like to put the burden on the cred code instead of the
> generic code if possible.

So something like this? (Amir?)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index ed00ce93cad2..9610d5166736 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -152,7 +152,7 @@ ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 	    !(file->f_mode & FMODE_CAN_ODIRECT))
 		return -EINVAL;
 
-	guard(cred)(ctx->cred);
+	cred_guard(ctx->cred);
 	if (is_sync_kiocb(iocb)) {
 		rwf_t rwf = iocb_to_rw_flags(flags);
 
@@ -206,7 +206,7 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 	 */
 	flags &= ~IOCB_DIO_CALLER_COMP;
 
-	guard(cred)(ctx->cred);
+	cred_guard(ctx->cred);
 	if (is_sync_kiocb(iocb)) {
 		rwf_t rwf = iocb_to_rw_flags(flags);
 
@@ -250,7 +250,7 @@ ssize_t backing_file_splice_read(struct file *in, loff_t *ppos,
 	if (WARN_ON_ONCE(!(in->f_mode & FMODE_BACKING)))
 		return -EIO;
 
-	guard(cred)(ctx->cred);
+	cred_guard(ctx->cred);
 	ret = vfs_splice_read(in, ppos, pipe, len, flags);
 
 	if (ctx->accessed)
@@ -274,7 +274,7 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 	if (ret)
 		return ret;
 
-	guard(cred)(ctx->cred);
+	cred_guard(ctx->cred);
 	file_start_write(out);
 	ret = iter_file_splice_write(pipe, out, ppos, len, flags);
 	file_end_write(out);
@@ -300,7 +300,7 @@ int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 
 	vma_set_file(vma, file);
 
-	guard(cred)(ctx->cred);
+	cred_guard(ctx->cred);
 	ret = call_mmap(vma->vm_file, vma);
 
 	if (ctx->accessed)
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 192997837a56..156d0262ddad 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -1199,7 +1199,7 @@ static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 	if (err)
 		return err;
 
-	guard(cred)(ovl_creds(dentry->d_sb));
+	cred_guard(ovl_creds(dentry->d_sb));
 	while (!err) {
 		struct dentry *next;
 		struct dentry *parent = NULL;
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 3ea5ba7b980d..d9497e34b4c8 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -686,7 +686,7 @@ static int ovl_set_link_redirect(struct dentry *dentry)
 {
 	int err;
 
-	guard(cred)(ovl_creds(dentry->d_sb));
+	cred_guard(ovl_creds(dentry->d_sb));
 	err = ovl_set_redirect(dentry, false);
 
 	return err;
@@ -891,7 +891,7 @@ static int ovl_do_remove(struct dentry *dentry, bool is_dir)
 	if (err)
 		goto out;
 
-	guard(cred)(ovl_creds(dentry->d_sb));
+	cred_guard(ovl_creds(dentry->d_sb));
 	if (!lower_positive)
 		err = ovl_remove_upper(dentry, is_dir, &list);
 	else
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 44744196bf21..f97d4b106d52 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -41,7 +41,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 	if (flags & O_APPEND)
 		acc_mode |= MAY_APPEND;
 
-	guard(cred)(ovl_creds(inode->i_sb));
+	cred_guard(ovl_creds(inode->i_sb));
 	real_idmap = mnt_idmap(realpath->mnt);
 	err = inode_permission(real_idmap, realinode, MAY_OPEN | acc_mode);
 	if (err) {
@@ -211,7 +211,7 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 	ovl_inode_lock(inode);
 	real.file->f_pos = file->f_pos;
 
-	guard(cred)(ovl_creds(inode->i_sb));
+	cred_guard(ovl_creds(inode->i_sb));
 	ret = vfs_llseek(real.file, offset, whence);
 
 	file->f_pos = real.file->f_pos;
@@ -396,7 +396,7 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 
 	/* Don't sync lower file for fear of receiving EROFS error */
 	if (file_inode(real.file) == ovl_inode_upper(file_inode(file))) {
-		guard(cred)(ovl_creds(file_inode(file)->i_sb));
+		cred_guard(ovl_creds(file_inode(file)->i_sb));
 		ret = vfs_fsync_range(real.file, start, end, datasync);
 	}
 
@@ -434,7 +434,7 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 	if (ret)
 		goto out_unlock;
 
-	guard(cred)(ovl_creds(file_inode(file)->i_sb));
+	cred_guard(ovl_creds(file_inode(file)->i_sb));
 	ret = vfs_fallocate(real.file, mode, offset, len);
 
 	/* Update size */
@@ -457,7 +457,7 @@ static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 	if (ret)
 		return ret;
 
-	guard(cred)(ovl_creds(file_inode(file)->i_sb));
+	cred_guard(ovl_creds(file_inode(file)->i_sb));
 	ret = vfs_fadvise(real.file, offset, len, advice);
 
 	fdput(real);
@@ -498,7 +498,7 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 		goto out_unlock;
 	}
 
-	guard(cred)(ovl_creds(file_inode(file_out)->i_sb));
+	cred_guard(ovl_creds(file_inode(file_out)->i_sb));
 	switch (op) {
 	case OVL_COPY:
 		ret = vfs_copy_file_range(real_in.file, pos_in,
@@ -574,7 +574,7 @@ static int ovl_flush(struct file *file, fl_owner_t id)
 		return err;
 
 	if (real.file->f_op->flush) {
-		guard(cred)(ovl_creds(file_inode(file)->i_sb));
+		cred_guard(ovl_creds(file_inode(file)->i_sb));
 		err = real.file->f_op->flush(real.file, id);
 	}
 	fdput(real);
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 8e399b10ebba..2f3024d2a119 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -78,7 +78,7 @@ int ovl_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			goto out_put_write;
 
 		inode_lock(upperdentry->d_inode);
-		guard(cred)(ovl_creds(dentry->d_sb));
+		cred_guard(ovl_creds(dentry->d_sb));
 
 		err = ovl_do_notify_change(ofs, upperdentry, attr);
 
@@ -169,7 +169,7 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 	metacopy_blocks = ovl_is_metacopy_dentry(dentry);
 
 	type = ovl_path_real(dentry, &realpath);
-	guard(cred)(ovl_creds(dentry->d_sb));
+	cred_guard(ovl_creds(dentry->d_sb));
 	err = ovl_do_getattr(&realpath, stat, request_mask, flags);
 	if (err)
 		goto out;
@@ -306,7 +306,7 @@ int ovl_permission(struct mnt_idmap *idmap,
 	if (err)
 		return err;
 
-	guard(cred)(ovl_creds(inode->i_sb));
+	cred_guard(ovl_creds(inode->i_sb));
 
 	if (!upperinode &&
 	    !special_file(realinode->i_mode) && mask & MAY_WRITE) {
@@ -328,7 +328,7 @@ static const char *ovl_get_link(struct dentry *dentry,
 	if (!dentry)
 		return ERR_PTR(-ECHILD);
 
-	guard(cred)(ovl_creds(inode->i_sb));
+	cred_guard(ovl_creds(inode->i_sb));
 	p = vfs_get_link(ovl_dentry_real(dentry), done);
 
 	return p;
@@ -461,7 +461,7 @@ struct posix_acl *do_ovl_get_acl(struct mnt_idmap *idmap,
 
 		acl = get_cached_acl_rcu(realinode, type);
 	} else {
-		guard(cred)(ovl_creds(inode->i_sb));
+		cred_guard(ovl_creds(inode->i_sb));
 		acl = ovl_get_acl_path(&realpath, posix_acl_xattr_name(type), noperm);
 	}
 
@@ -487,7 +487,7 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 		struct posix_acl *real_acl;
 
 		ovl_path_lower(dentry, &realpath);
-		scoped_guard(cred, ovl_creds(dentry->d_sb))
+		cred_scoped_guard(ovl_creds(dentry->d_sb))
 			real_acl = vfs_get_acl(mnt_idmap(realpath.mnt), realdentry,
 					       acl_name);
 
@@ -510,7 +510,7 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 	if (err)
 		goto out;
 
-	scoped_guard(cred, ovl_creds(dentry->d_sb)) {
+	cred_scoped_guard(ovl_creds(dentry->d_sb)) {
 		if (acl)
 			err = ovl_do_set_acl(ofs, realdentry, acl_name, acl);
 		else
@@ -589,7 +589,7 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (!realinode->i_op->fiemap)
 		return -EOPNOTSUPP;
 
-	guard(cred)(ovl_creds(inode->i_sb));
+	cred_guard(ovl_creds(inode->i_sb));
 	err = realinode->i_op->fiemap(realinode, fieinfo, start, len);
 
 	return err;
@@ -649,7 +649,7 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 		if (err)
 			goto out;
 
-		guard(cred)(ovl_creds(inode->i_sb));
+		cred_guard(ovl_creds(inode->i_sb));
 		/*
 		 * Store immutable/append-only flags in xattr and clear them
 		 * in upper fileattr (in case they were set by older kernel)
@@ -717,7 +717,7 @@ int ovl_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 
 	ovl_path_real(dentry, &realpath);
 
-	guard(cred)(ovl_creds(inode->i_sb));
+	cred_guard(ovl_creds(inode->i_sb));
 	err = ovl_real_fileattr_get(&realpath, fa);
 	ovl_fileattr_prot_flags(inode, fa);
 
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 4b9137572cdc..193f7015c8f5 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -953,7 +953,7 @@ static int ovl_maybe_validate_verity(struct dentry *dentry)
 		return err;
 
 	if (!ovl_test_flag(OVL_VERIFIED_DIGEST, inode)) {
-		guard(cred)(ovl_creds(dentry->d_sb));
+		cred_guard(ovl_creds(dentry->d_sb));
 
 		err = ovl_validate_verity(ofs, &metapath, &datapath);
 		if (err == 0)
@@ -988,7 +988,7 @@ static int ovl_maybe_lookup_lowerdata(struct dentry *dentry)
 	if (ovl_dentry_lowerdata(dentry))
 		goto out;
 
-	guard(cred)(ovl_creds(dentry->d_sb));
+	cred_guard(ovl_creds(dentry->d_sb));
 	err = ovl_lookup_data_layers(dentry, redirect, &datapath);
 
 	if (err)
@@ -1055,7 +1055,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > ofs->namelen)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	guard(cred)(ovl_creds(dentry->d_sb));
+	cred_guard(ovl_creds(dentry->d_sb));
 	upperdir = ovl_dentry_upper(dentry->d_parent);
 	if (upperdir) {
 		d.layer = &ofs->layers[0];
@@ -1381,7 +1381,7 @@ bool ovl_lower_positive(struct dentry *dentry)
 	if (!ovl_dentry_upper(dentry))
 		return true;
 
-	guard(cred)(ovl_creds(dentry->d_sb));
+	cred_guard(ovl_creds(dentry->d_sb));
 	/* Positive upper -> have to look up lower to see whether it exists */
 	for (i = 0; !done && !positive && i < ovl_numlower(poe); i++) {
 		struct dentry *this;
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index d17f8a5aae6f..41e01fe3ae4a 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -274,7 +274,7 @@ static int ovl_check_whiteouts(const struct path *path, struct ovl_readdir_data
 	struct ovl_cache_entry *p;
 	struct dentry *dentry, *dir = path->dentry;
 
-	guard(cred)(ovl_creds(rdd->dentry->d_sb));
+	cred_guard(ovl_creds(rdd->dentry->d_sb));
 
 	err = down_write_killable(&dir->d_inode->i_rwsem);
 	if (!err) {
@@ -753,7 +753,7 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 	struct ovl_cache_entry *p;
 	int err;
 
-	guard(cred)(ovl_creds(dentry->d_sb));
+	cred_guard(ovl_creds(dentry->d_sb));
 	if (!ctx->pos)
 		ovl_dir_reset(file);
 
@@ -853,7 +853,7 @@ static struct file *ovl_dir_open_realfile(const struct file *file,
 {
 	struct file *res;
 
-	guard(cred)(ovl_creds(file_inode(file)->i_sb));
+	cred_guard(ovl_creds(file_inode(file)->i_sb));
 	res = ovl_path_open(realpath, O_RDONLY | (file->f_flags & O_LARGEFILE));
 
 	return res;
@@ -978,7 +978,7 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 	struct ovl_cache_entry *p, *n;
 	struct rb_root root = RB_ROOT;
 
-	guard(cred)(ovl_creds(dentry->d_sb));
+	cred_guard(ovl_creds(dentry->d_sb));
 	err = ovl_dir_read_merged(dentry, list, &root);
 	if (err)
 		return err;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 4f237de0836c..fdce1e453d40 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1169,7 +1169,7 @@ int ovl_nlink_start(struct dentry *dentry)
 	if (d_is_dir(dentry) || !ovl_test_flag(OVL_INDEX, inode))
 		return 0;
 
-	guard(cred)(ovl_creds(dentry->d_sb));
+	cred_guard(ovl_creds(dentry->d_sb));
 	/*
 	 * The overlay inode nlink should be incremented/decremented IFF the
 	 * upper operation succeeds, along with nlink change of upper inode.
@@ -1198,7 +1198,7 @@ void ovl_nlink_end(struct dentry *dentry)
 	ovl_drop_write(dentry);
 
 	if (ovl_test_flag(OVL_INDEX, inode) && inode->i_nlink == 0) {
-		guard(cred)(ovl_creds(dentry->d_sb));
+		cred_guard(ovl_creds(dentry->d_sb));
 		ovl_cleanup_index(dentry);
 	}
 
diff --git a/fs/overlayfs/xattrs.c b/fs/overlayfs/xattrs.c
index cc4ab2d81162..ad1a656e2798 100644
--- a/fs/overlayfs/xattrs.c
+++ b/fs/overlayfs/xattrs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/cred.h>
 #include <linux/fs.h>
 #include <linux/xattr.h>
 #include "overlayfs.h"
@@ -44,7 +45,7 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 
 	if (!value && !upperdentry) {
 		ovl_path_lower(dentry, &realpath);
-		scoped_guard(cred, ovl_creds(dentry->d_sb))
+		cred_scoped_guard(ovl_creds(dentry->d_sb))
 			err = vfs_getxattr(mnt_idmap(realpath.mnt), realdentry, name, NULL, 0);
 		if (err < 0)
 			goto out;
@@ -62,7 +63,7 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 	if (err)
 		goto out;
 
-	scoped_guard(cred, ovl_creds(dentry->d_sb)) {
+	cred_scoped_guard(ovl_creds(dentry->d_sb)) {
 		if (value) {
 			err = ovl_do_setxattr(ofs, realdentry, name, value, size,
 					      flags);
@@ -86,7 +87,7 @@ static int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char
 	struct path realpath;
 
 	ovl_i_path_real(inode, &realpath);
-	guard(cred)(ovl_creds(dentry->d_sb));
+	cred_guard(ovl_creds(dentry->d_sb));
 	res = vfs_getxattr(mnt_idmap(realpath.mnt), realpath.dentry, name, value, size);
 	return res;
 }
@@ -114,7 +115,7 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
 	char *s;
 	size_t prefix_len, name_len;
 
-	scoped_guard(cred, ovl_creds(dentry->d_sb))
+	cred_scoped_guard(ovl_creds(dentry->d_sb))
 		res = vfs_listxattr(realdentry, list, size);
 	if (res <= 0 || size == 0)
 		return res;
diff --git a/include/linux/cred.h b/include/linux/cred.h
index be1e211d82e0..5a532fce1713 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -171,7 +171,6 @@ static inline bool cap_ambient_invariant_ok(const struct cred *cred)
 			    cap_intersect(cred->cap_permitted,
 					  cred->cap_inheritable));
 }
-
 /*
  * Override creds without bumping reference count. Caller must ensure
  * reference remains valid or has taken reference. Almost always not the
@@ -190,8 +189,12 @@ static inline void revert_creds_light(const struct cred *revert_cred)
 	rcu_assign_pointer(current->cred, revert_cred);
 }
 
-DEFINE_LOCK_GUARD_1(cred, const struct cred, _T->lock = override_creds_light(_T->lock),
-	     revert_creds_light(_T->lock));
+DEFINE_LOCK_GUARD_1(cred, struct cred,
+		    _T->lock = (struct cred *)override_creds_light(_T->lock),
+		    revert_creds_light(_T->lock));
+
+#define cred_guard(_cred) guard(cred)(((struct cred *)_cred))
+#define cred_scoped_guard(_cred) scoped_guard(cred, ((struct cred *)_cred))
 
 /**
  * get_new_cred_many - Get references on a new set of credentials

