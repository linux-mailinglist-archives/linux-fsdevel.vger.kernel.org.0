Return-Path: <linux-fsdevel+bounces-69005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BC6C6B17D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 19:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E10AE362A17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 18:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664172D7DDF;
	Tue, 18 Nov 2025 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Clz5V+EZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD612877E9;
	Tue, 18 Nov 2025 18:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763488868; cv=none; b=CvROjLHQnJaOKDccIZQ+gXwKoXDhGHP/+ER9PEIVc2Ys6L1GdEaVOWFjIekelqCOq4BJBiInHw+V52BccavaekT57dsnyYeTHjvi5EjmnNDSWRdYbCPbvqgDn+u3IVIDSDMOuhf6gM1+SSGEx1hzcFSBL8omVKLlpwbojxUoelU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763488868; c=relaxed/simple;
	bh=9i0tX+fm6GQ/4+C9FMLe3HpAnvy4obZVXZOsB1Ofq4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbVUwX4dl3BVJaUH0ryAVigNJb0QRV6amy3gX/EL4Kf7nA2WOtoo9iV5IwApDo/ff1WY2FXLgNj022kt60QQqLzYCEflrhVzB5pxqNy0WxBZFieUNdt/5fJjfM0ncujA9kCm9o0FefQJRvKf4japRGMuafPufSL8MEUNinnawBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Clz5V+EZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA430C4CEF1;
	Tue, 18 Nov 2025 18:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763488868;
	bh=9i0tX+fm6GQ/4+C9FMLe3HpAnvy4obZVXZOsB1Ofq4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Clz5V+EZQ+vUsNPLkub2y+gRMWGxDgzsLOKd5zX4xaAXauOTXJTLe4qSep4mKZLfZ
	 aAykgvHWaSdObQ8TYEJtqEagt2yoxRoHUzV0QKz/SQCSz7mpi+58+1mMw6JD2AuN74
	 enEUPAxOgBliafXs9b3yrbMemAcJRWzuWubmkrdkIc8VOi01q/Av5YjoKuHsluS4sx
	 Ed1seqw3nIMyvzlQ6ArbJxLzGk5JLUuS4rSRsW5/SpwnH++j6A9dXgeXC+5HX04UsD
	 GGxcU/rGbjv7IsWBlEwFhKJNOlIm1qfp+nTndyLWb7aZnPo/Fg1p5Yb6u7R0bpq+gz
	 78rHNQqvpTjIA==
Date: Tue, 18 Nov 2025 13:01:06 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Benjamin Coddington <bcodding@hammerspace.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>
Subject: Re: [PATCH v1 3/3] VFS/knfsd: Teach dentry_create() to use
 atomic_open()
Message-ID: <aRy0Yp-GvUrD3uJY@kernel.org>
References: <cover.1763483341.git.bcodding@hammerspace.com>
 <149570774f6cb48bf469514ca37cd636612f49b1.1763483341.git.bcodding@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149570774f6cb48bf469514ca37cd636612f49b1.1763483341.git.bcodding@hammerspace.com>

On Tue, Nov 18, 2025 at 11:33:59AM -0500, Benjamin Coddington wrote:
> While knfsd offers combined exclusive create and open results to clients,
> on some filesystems those results may not be atomic.  This behavior can be
> observed.  For example, an open O_CREAT with mode 0 will succeed in creating
> the file but unexpectedly return -EACCES from vfs_open().
> 
> Additionally reducing the number of remote RPC calls required for O_CREAT
> on network filesystem provides a performance benefit in the open path.
> 
> Teach knfsd's helper create_dentry() to use atomic_open() for filesystems
> that support it.
> 
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---
>  fs/namei.c         | 43 ++++++++++++++++++++++++++++++++++++-------
>  fs/nfsd/nfs4proc.c |  8 +++++---
>  include/linux/fs.h |  2 +-
>  3 files changed, 42 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 9c0aad5bbff7..70ab74fb5e95 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4208,21 +4208,50 @@ EXPORT_SYMBOL(user_path_create);
>   * On success, returns a "struct file *". Otherwise a ERR_PTR
>   * is returned.
>   */
> -struct file *dentry_create(const struct path *path, int flags, umode_t mode,
> +struct file *dentry_create(struct path *path, int flags, umode_t mode,
>  			   const struct cred *cred)
>  {
> +	struct dentry *dentry = path->dentry;
> +	struct dentry *dir = dentry->d_parent;
> +	struct inode *dir_inode = d_inode(dir);
> +	struct mnt_idmap *idmap;
>  	struct file *file;
> -	int error;
> +	int error, create_error;
>  
>  	file = alloc_empty_file(flags, cred);
>  	if (IS_ERR(file))
>  		return file;
>  
> -	error = vfs_create(mnt_idmap(path->mnt),
> -			   d_inode(path->dentry->d_parent),
> -			   path->dentry, mode, true);
> -	if (!error)
> -		error = vfs_open(path, file);
> +	idmap = mnt_idmap(path->mnt);
> +
> +	if (dir_inode->i_op->atomic_open) {
> +		path->dentry = dir;
> +		mode = vfs_prepare_mode(idmap, dir_inode, mode, S_IALLUGO, S_IFREG);
> +
> +		create_error = may_o_create(idmap, path, dentry, mode);
> +		if (create_error)
> +			flags &= ~O_CREAT;
> +
> +		dentry = atomic_open(path, dentry, file, flags, mode);
> +		error = PTR_ERR_OR_ZERO(dentry);
> +
> +		if (unlikely(create_error) && error == -ENOENT)
> +			error = create_error;
> +
> +		if (!error) {
> +			if (file->f_mode & FMODE_CREATED)
> +				fsnotify_create(dir->d_inode, dentry);
> +			if (file->f_mode & FMODE_OPENED)
> +				fsnotify_open(file);
> +		}
> +
> +		path->dentry = dentry;
> +
> +	} else {
> +		error = vfs_create(idmap, dir_inode, dentry, mode, true);
> +		if (!error)
> +			error = vfs_open(path, file);
> +	}
>  
>  	if (unlikely(error)) {
>  		fput(file);
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 71b428efcbb5..7ff7e5855e58 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -194,7 +194,7 @@ static inline bool nfsd4_create_is_exclusive(int createmode)
>  }
>  
>  static __be32
> -nfsd4_vfs_create(struct svc_fh *fhp, struct dentry *child,
> +nfsd4_vfs_create(struct svc_fh *fhp, struct dentry **child,
>  		 struct nfsd4_open *open)
>  {
>  	struct file *filp;
> @@ -214,9 +214,11 @@ nfsd4_vfs_create(struct svc_fh *fhp, struct dentry *child,
>  	}
>  
>  	path.mnt = fhp->fh_export->ex_path.mnt;
> -	path.dentry = child;
> +	path.dentry = *child;
>  	filp = dentry_create(&path, oflags, open->op_iattr.ia_mode,
>  			     current_cred());
> +	*child = path.dentry;
> +
>  	if (IS_ERR(filp))
>  		return nfserrno(PTR_ERR(filp));
>  

Given the potential for side-effect due to dentry_create() now using
atomic_open() if available, I think you'd do well to update the
comment block above dentry_create to make it clear that the caller
really should pass along the dentry (regardless of whether
dentry_create returns an ERR_PTR).

> @@ -353,7 +355,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	status = fh_fill_pre_attrs(fhp);
>  	if (status != nfs_ok)
>  		goto out;
> -	status = nfsd4_vfs_create(fhp, child, open);
> +	status = nfsd4_vfs_create(fhp, &child, open);
>  	if (status != nfs_ok)
>  		goto out;
>  	open->op_created = true;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 601d036a6c78..772b734477e5 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2878,7 +2878,7 @@ struct file *dentry_open(const struct path *path, int flags,
>  			 const struct cred *creds);
>  struct file *dentry_open_nonotify(const struct path *path, int flags,
>  				  const struct cred *cred);
> -struct file *dentry_create(const struct path *path, int flags, umode_t mode,
> +struct file *dentry_create(struct path *path, int flags, umode_t mode,
>  			   const struct cred *cred);
>  struct path *backing_file_user_path(const struct file *f);
>  
> -- 
> 2.50.1
> 

