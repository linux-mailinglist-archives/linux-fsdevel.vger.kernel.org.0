Return-Path: <linux-fsdevel+bounces-30951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E24A98FFE2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 11:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F941C225C4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 09:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DA2148302;
	Fri,  4 Oct 2024 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BC/uXTM0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD10146D6E
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Oct 2024 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034813; cv=none; b=s8iPVSVI35lGsX2NceoHNGxg/crwwhZxNn1wWvLgK3gYgoOQ7Pu4nABM1HxTMab6K/wKigl+yb/jIzsaaW7vpjHF8ULQRxX0tGpxRJ03J2cI3JHmFxwUTXuwCuqoaZ1cJYAlPmvQurmY9DR7BXqX0gaOjGAPWJAT+Uu2BPqsJ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034813; c=relaxed/simple;
	bh=Brjx7PM7oR3+Ylm9yg451SZr7KLLmKbZuQpVSFU2ADA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Inv+7bh1q/8k2Z4mVOc4ijQRFxd/EL04iQZDhbQVaYmG/3vRP22QP9voPO6Szew1YS0GvF5nsg9nBrwjm7x1If86yak9UWBTMNN5mSnJMaCilCvoh2r+Y4VZX3wo2q9iALxh69s/BHJVTHyaro/EHvHuL0aJHJXIQghccSg4sVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BC/uXTM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0458C4CEC6;
	Fri,  4 Oct 2024 09:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728034813;
	bh=Brjx7PM7oR3+Ylm9yg451SZr7KLLmKbZuQpVSFU2ADA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BC/uXTM0yoYHOBiPElHi5zRoAhBM7w9kk15F5TtbUUj4S9tUvNOhL+9VtovzllFfG
	 4hIOjp9y602qTTb1/Fm9RYYWWD+bBBKI3n36IEnCMadyWKNnZmL/JOgT996i/jQERX
	 Uzi6rT0q3ztkj/+01YuX8xjPfxZuS6y8zMC1s9PcEOMRuQYRSgr/vsFTwBXMVvwjwX
	 +ajcCp77MWyA4+MfTsL+g2JAXzZmBrJ8drSPxQMpsK6T9hb6o/h9yPLrqfoZtgkTSk
	 QF6EehfI3b5yeXBrXypHeKnbSP481sBGTNwJ0IHFRE+p+gjIpicl7VvDv4yic+Z2MB
	 tTQL1O5xKqJEg==
Date: Fri, 4 Oct 2024 11:40:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 2/3] experimental: convert fs/overlayfs/file.c to
 CLASS(...)
Message-ID: <20241004-amtsmissbrauch-ahndung-b629eb5ca587@brauner>
References: <20241003234534.GM4017910@ZenIV>
 <20241003234808.GC147780@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241003234808.GC147780@ZenIV>

On Fri, Oct 04, 2024 at 12:48:08AM GMT, Al Viro wrote:
> There are four places where we end up adding an extra scope
> covering just the range from constructor to destructor;

I don't think this is something to worry about. While there are cases
where the width of the scope might make a meaningful difference I doubt
it does here.

> not sure if that's the best way to handle that.
> 
> The functions in question are ovl_write_iter(), ovl_splice_write(),
> ovl_fadvise() and ovl_copyfile().
> 
> I still don't like the way we have to deal with the scopes, but...
> use of guard() for inode_lock()/inode_unlock() is a gutter too deep,
> as far as I'm concerned.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/overlayfs/file.c | 72 ++++++++++++++++++---------------------------
>  1 file changed, 29 insertions(+), 43 deletions(-)
> 
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index c711fa5d802f..a0ab981b13d9 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -131,6 +131,8 @@ static struct fderr ovl_real_fdget(const struct file *file)
>  	return ovl_real_fdget_meta(file, false);
>  }
>  
> +DEFINE_CLASS(fd_real, struct fderr, fdput(_T), ovl_real_fdget(file), struct file *file)
> +
>  static int ovl_open(struct inode *inode, struct file *file)
>  {
>  	struct dentry *dentry = file_dentry(file);
> @@ -173,7 +175,6 @@ static int ovl_release(struct inode *inode, struct file *file)
>  static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
>  {
>  	struct inode *inode = file_inode(file);
> -	struct fderr real;
>  	const struct cred *old_cred;
>  	loff_t ret;
>  
> @@ -189,7 +190,7 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
>  			return vfs_setpos(file, 0, 0);
>  	}
>  
> -	real = ovl_real_fdget(file);
> +	CLASS(fd_real, real)(file);
>  	if (fd_empty(real))
>  		return fd_err(real);
>  
> @@ -210,8 +211,6 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
>  	file->f_pos = fd_file(real)->f_pos;
>  	ovl_inode_unlock(inode);
>  
> -	fdput(real);
> -
>  	return ret;
>  }
>  
> @@ -252,8 +251,6 @@ static void ovl_file_accessed(struct file *file)
>  static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  {
>  	struct file *file = iocb->ki_filp;
> -	struct fderr real;
> -	ssize_t ret;
>  	struct backing_file_ctx ctx = {
>  		.cred = ovl_creds(file_inode(file)->i_sb),
>  		.user_file = file,
> @@ -263,22 +260,18 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	if (!iov_iter_count(iter))
>  		return 0;
>  
> -	real = ovl_real_fdget(file);
> +	CLASS(fd_real, real)(file);
>  	if (fd_empty(real))
>  		return fd_err(real);
>  
> -	ret = backing_file_read_iter(fd_file(real), iter, iocb, iocb->ki_flags,
> -				     &ctx);
> -	fdput(real);
> -
> -	return ret;
> +	return backing_file_read_iter(fd_file(real), iter, iocb, iocb->ki_flags,
> +				      &ctx);
>  }
>  
>  static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>  {
>  	struct file *file = iocb->ki_filp;
>  	struct inode *inode = file_inode(file);
> -	struct fderr real;
>  	ssize_t ret;
>  	int ifl = iocb->ki_flags;
>  	struct backing_file_ctx ctx = {
> @@ -294,7 +287,9 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	/* Update mode */
>  	ovl_copyattr(inode);
>  
> -	real = ovl_real_fdget(file);
> +	{
> +
> +	CLASS(fd_real, real)(file);
>  	if (fd_empty(real)) {
>  		ret = fd_err(real);
>  		goto out_unlock;
> @@ -309,7 +304,8 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	 */
>  	ifl &= ~IOCB_DIO_CALLER_COMP;
>  	ret = backing_file_write_iter(fd_file(real), iter, iocb, ifl, &ctx);
> -	fdput(real);
> +
> +	}
>  
>  out_unlock:
>  	inode_unlock(inode);
> @@ -321,22 +317,18 @@ static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
>  			       struct pipe_inode_info *pipe, size_t len,
>  			       unsigned int flags)
>  {
> -	struct fderr real;
> -	ssize_t ret;
> +	CLASS(fd_real, real)(in);
>  	struct backing_file_ctx ctx = {
>  		.cred = ovl_creds(file_inode(in)->i_sb),
>  		.user_file = in,
>  		.accessed = ovl_file_accessed,
>  	};
>  
> -	real = ovl_real_fdget(in);
>  	if (fd_empty(real))
>  		return fd_err(real);
>  
> -	ret = backing_file_splice_read(fd_file(real), ppos, pipe, len, flags, &ctx);
> -	fdput(real);
> -
> -	return ret;
> +	return backing_file_splice_read(fd_file(real), ppos, pipe, len, flags,
> +					&ctx);
>  }
>  
>  /*
> @@ -350,7 +342,6 @@ static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
>  static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
>  				loff_t *ppos, size_t len, unsigned int flags)
>  {
> -	struct fderr real;
>  	struct inode *inode = file_inode(out);
>  	ssize_t ret;
>  	struct backing_file_ctx ctx = {
> @@ -363,15 +354,17 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
>  	/* Update mode */
>  	ovl_copyattr(inode);
>  
> -	real = ovl_real_fdget(out);
> +	{
> +
> +	CLASS(fd_real, real)(out);
>  	if (fd_empty(real)) {
>  		ret = fd_err(real);
>  		goto out_unlock;
>  	}
>  
>  	ret = backing_file_splice_write(pipe, fd_file(real), ppos, len, flags, &ctx);
> -	fdput(real);
>  
> +	}
>  out_unlock:
>  	inode_unlock(inode);
>  
> @@ -419,7 +412,6 @@ static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
>  static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  {
>  	struct inode *inode = file_inode(file);
> -	struct fderr real;
>  	const struct cred *old_cred;
>  	int ret;
>  
> @@ -429,7 +421,9 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
>  	ret = file_remove_privs(file);
>  	if (ret)
>  		goto out_unlock;
> -	real = ovl_real_fdget(file);
> +	{
> +
> +	CLASS(fd_real, real)(file);
>  	if (fd_empty(real)) {
>  		ret = fd_err(real);
>  		goto out_unlock;
> @@ -442,8 +436,7 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
>  	/* Update size */
>  	ovl_file_modified(file);
>  
> -	fdput(real);
> -
> +	}
>  out_unlock:
>  	inode_unlock(inode);
>  
> @@ -452,11 +445,10 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
>  
>  static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
>  {
> -	struct fderr real;
> +	CLASS(fd_real, real)(file);
>  	const struct cred *old_cred;
>  	int ret;
>  
> -	real = ovl_real_fdget(file);
>  	if (fd_empty(real))
>  		return fd_err(real);
>  
> @@ -464,8 +456,6 @@ static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
>  	ret = vfs_fadvise(fd_file(real), offset, len, advice);
>  	revert_creds(old_cred);
>  
> -	fdput(real);
> -
>  	return ret;
>  }
>  
> @@ -480,7 +470,6 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
>  			    loff_t len, unsigned int flags, enum ovl_copyop op)
>  {
>  	struct inode *inode_out = file_inode(file_out);
> -	struct fderr real_in, real_out;
>  	const struct cred *old_cred;
>  	loff_t ret;
>  
> @@ -493,15 +482,16 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
>  			goto out_unlock;
>  	}
>  
> -	real_out = ovl_real_fdget(file_out);
> +	{
> +
> +	CLASS(fd_real, real_out)(file_out);
>  	if (fd_empty(real_out)) {
>  		ret = fd_err(real_out);
>  		goto out_unlock;
>  	}
>  
> -	real_in = ovl_real_fdget(file_in);
> +	CLASS(fd_real, real_in)(file_in);
>  	if (fd_empty(real_in)) {
> -		fdput(real_out);
>  		ret = fd_err(real_in);
>  		goto out_unlock;
>  	}
> @@ -529,8 +519,7 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
>  	/* Update size */
>  	ovl_file_modified(file_out);
>  
> -	fdput(real_in);
> -	fdput(real_out);
> +	}
>  
>  out_unlock:
>  	inode_unlock(inode_out);
> @@ -575,11 +564,10 @@ static loff_t ovl_remap_file_range(struct file *file_in, loff_t pos_in,
>  
>  static int ovl_flush(struct file *file, fl_owner_t id)
>  {
> -	struct fderr real;
> +	CLASS(fd_real, real)(file);
>  	const struct cred *old_cred;
>  	int err = 0;
>  
> -	real = ovl_real_fdget(file);
>  	if (fd_empty(real))
>  		return fd_err(real);
>  
> @@ -588,8 +576,6 @@ static int ovl_flush(struct file *file, fl_owner_t id)
>  		err = fd_file(real)->f_op->flush(fd_file(real), id);
>  		revert_creds(old_cred);
>  	}
> -	fdput(real);
> -
>  	return err;
>  }
>  
> -- 
> 2.39.5
> 

