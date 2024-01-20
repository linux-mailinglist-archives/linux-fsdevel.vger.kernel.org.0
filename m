Return-Path: <linux-fsdevel+bounces-8358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910B0833539
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jan 2024 16:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F06A5B22783
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jan 2024 15:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA8B101F2;
	Sat, 20 Jan 2024 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMxaR02z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FC1F515;
	Sat, 20 Jan 2024 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705764224; cv=none; b=joDKX3gNKHe/4GXkDhQCQmUifeU9SjQtrm5zPbi6IspF31NUqpDs0uKd7kLZUjBZD+QzxqgqUod5o1Ao1DxDpT6l3MI9aIg07ZU1pnztLdo8z+9PTGvnl6YGTDlFb2tuW4ECd22lnTrdaRT/J9xi/iY1bZR8M9hVL7oSNaRvPUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705764224; c=relaxed/simple;
	bh=7+7RUx7Pil+a2kyG9u8gC474V725SmOCGQ9QaE+x60o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+C4NOiYbG1I+lXUGkt4SkW3gHNXBhdfMTXjL8l0eEo8Mviv5FegVABB50izzVaexFzvB6faLZvLRsNemgn5CZV5P+5CWOWncl+0OyE0oD1Wrec3/peq6fnKD/OQvX8ZAhtfUDnYfIkU9HMv1+z/Kpr0Qe3jF/wApiPsehlvYoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMxaR02z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E221CC433F1;
	Sat, 20 Jan 2024 15:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705764224;
	bh=7+7RUx7Pil+a2kyG9u8gC474V725SmOCGQ9QaE+x60o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HMxaR02zNPkYr4GYoX4GbP5gdggaPIpv+Tv16glt2UIdat2OWnXQ/tVwqgkKFji6U
	 1LN4tLyTuBpXEQdMIfx86T15FsiVRtj4B/l5NQnR00nn2ypsSITPzY3J2KsMa8PZy5
	 jat6D92FyKvVu0VLuJRYBfXdjHePJXL9RkQC2Mj+DVQU3O3+1k38m8lW5/b9I43e1x
	 KB4srI/lqSW25iecwNRrQEOyExtiIw3zAJOfZ0e99MoHNuIcam6R5PEizQ5bEk1nWR
	 ub9zJ6Evirkkq6GbpKifKjYSqPEmWOyI+vPXjI0e02jmbe7G9TRdEmVuTpL12TBIKF
	 0FQoQs8t5JzmA==
Date: Sat, 20 Jan 2024 16:23:38 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, stgraber@stgraber.org, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 6/9] fs/fuse: support idmapped ->setattr op
Message-ID: <20240120-zeitmanagement-abbezahlen-8a3e2b5de72a@brauner>
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
 <20240108120824.122178-7-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240108120824.122178-7-aleksandr.mikhalitsyn@canonical.com>

On Mon, Jan 08, 2024 at 01:08:21PM +0100, Alexander Mikhalitsyn wrote:
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Seth Forshee <sforshee@kernel.org>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Bernd Schubert <bschubert@ddn.com>
> Cc: <linux-fsdevel@vger.kernel.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
>  fs/fuse/dir.c    | 32 +++++++++++++++++++++-----------
>  fs/fuse/file.c   |  2 +-
>  fs/fuse/fuse_i.h |  4 ++--
>  3 files changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index f7c2c54f7122..5fbb7100ad1c 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1739,17 +1739,27 @@ static bool update_mtime(unsigned ivalid, bool trust_local_mtime)
>  	return true;
>  }
>  
> -static void iattr_to_fattr(struct fuse_conn *fc, struct iattr *iattr,
> -			   struct fuse_setattr_in *arg, bool trust_local_cmtime)
> +static void iattr_to_fattr(struct mnt_idmap *idmap, struct fuse_conn *fc,
> +			   struct iattr *iattr, struct fuse_setattr_in *arg,
> +			   bool trust_local_cmtime)
>  {
>  	unsigned ivalid = iattr->ia_valid;
>  
>  	if (ivalid & ATTR_MODE)
>  		arg->valid |= FATTR_MODE,   arg->mode = iattr->ia_mode;
> -	if (ivalid & ATTR_UID)
> -		arg->valid |= FATTR_UID,    arg->uid = from_kuid(fc->user_ns, iattr->ia_uid);
> -	if (ivalid & ATTR_GID)
> -		arg->valid |= FATTR_GID,    arg->gid = from_kgid(fc->user_ns, iattr->ia_gid);
> +
> +	if (ivalid & ATTR_UID) {
> +		kuid_t fsuid = from_vfsuid(idmap, fc->user_ns, iattr->ia_vfsuid);
> +		arg->valid |= FATTR_UID;
> +		arg->uid = from_kuid(fc->user_ns, fsuid);
> +	}
> +
> +	if (ivalid & ATTR_GID) {
> +		kgid_t fsgid = from_vfsgid(idmap, fc->user_ns, iattr->ia_vfsgid);
> +		arg->valid |= FATTR_GID;
> +		arg->gid = from_kgid(fc->user_ns, fsgid);
> +	}
> +
>  	if (ivalid & ATTR_SIZE)
>  		arg->valid |= FATTR_SIZE,   arg->size = iattr->ia_size;
>  	if (ivalid & ATTR_ATIME) {
> @@ -1869,8 +1879,8 @@ int fuse_flush_times(struct inode *inode, struct fuse_file *ff)
>   * vmtruncate() doesn't allow for this case, so do the rlimit checking
>   * and the actual truncation by hand.
>   */
> -int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
> -		    struct file *file)
> +int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +		    struct iattr *attr, struct file *file)
>  {
>  	struct inode *inode = d_inode(dentry);
>  	struct fuse_mount *fm = get_fuse_mount(inode);
> @@ -1890,7 +1900,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
>  	if (!fc->default_permissions)
>  		attr->ia_valid |= ATTR_FORCE;
>  
> -	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
> +	err = setattr_prepare(idmap, dentry, attr);
>  	if (err)
>  		return err;
>  
> @@ -1949,7 +1959,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
>  
>  	memset(&inarg, 0, sizeof(inarg));
>  	memset(&outarg, 0, sizeof(outarg));
> -	iattr_to_fattr(fc, attr, &inarg, trust_local_cmtime);
> +	iattr_to_fattr(idmap, fc, attr, &inarg, trust_local_cmtime);
>  	if (file) {
>  		struct fuse_file *ff = file->private_data;
>  		inarg.valid |= FATTR_FH;
> @@ -2084,7 +2094,7 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
>  	if (!attr->ia_valid)
>  		return 0;
>  
> -	ret = fuse_do_setattr(entry, attr, file);
> +	ret = fuse_do_setattr(idmap, entry, attr, file);
>  	if (!ret) {
>  		/*
>  		 * If filesystem supports acls it may have updated acl xattrs in
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index a660f1f21540..e0fe5497a548 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2870,7 +2870,7 @@ static void fuse_do_truncate(struct file *file)
>  	attr.ia_file = file;
>  	attr.ia_valid |= ATTR_FILE;
>  
> -	fuse_do_setattr(file_dentry(file), &attr, file);
> +	fuse_do_setattr(&nop_mnt_idmap, file_dentry(file), &attr, file);

Same as for the other patch. Please leave a comment in the commit
message that briefly explains why it's ok to pass &nop_mnt_idmap here.
It'll help us later. :)

