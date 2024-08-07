Return-Path: <linux-fsdevel+bounces-25254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8AA94A4E6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6111F22F3A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35EA1D1F75;
	Wed,  7 Aug 2024 10:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjaXtdj0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96FE3A267;
	Wed,  7 Aug 2024 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723024994; cv=none; b=cQevnuf+/HaMY2vlhEV88YJl1UWsC68fpNqRsMaM7qqs1H3XJtwQXp1sVaAbjttLAxbxWjIfx8CsJHZZuwu4OARdx0Gdoc6QNFwnn5ZpaLmBCKcyXamtoAnydmxK5TO3FWV8JzKZ9hjCryFKU0GEU04sGBSxCxQlVijoHr2Mthg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723024994; c=relaxed/simple;
	bh=nuA8I7Y8ffJxxkHPqZ/eRwOW3VtvVOP1ALTGr9adw6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ib0Qsvq2X5AJfnqpc0M/GykoZZbpn+ThF+9NiSXdozj1D/7qt9r1MPzynfNlpjcnY3K/kyXXary0B66SJwEbESGfCwVCQMly6qqpW0QHfkAe1BOdb40SnYj2vfS9xyU4JY+4ckUmkbSZN1QIncSyvsX0X8X5oVBffmtzqoGjZ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjaXtdj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8328AC32782;
	Wed,  7 Aug 2024 10:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723024993;
	bh=nuA8I7Y8ffJxxkHPqZ/eRwOW3VtvVOP1ALTGr9adw6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jjaXtdj083OirwYOMnJ8pkTZ+gMavr68qpkhsQdtpf+ykKNvrUR3g0LHYzCNFgj10
	 amLMbPk1FTvZ/qexTJSxz52hpf9qkIU1bhdmdeskB55laoaPDb2BVE3DL7vWM7KID7
	 54eE68PyXJD2P6hDwwScvw0M6RdYEqAP8vzvSemC5rJqgKRjy+GFYZ3ohodLSueQCB
	 akqCXE5f9uPyPwAARG3/cgcxW9UbRhDS7TK/SsPmzprJCvhfrVCr1+g2kSL0aAcVAU
	 BsgEtei108fDnPxkmbKuTZ9rv0CNTMn2/kVddlSyqEYap+AjlZxZVQ5SONLllFjLGv
	 0zSpiIY42TmAw==
Date: Wed, 7 Aug 2024 12:03:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 03/39] struct fd: representation change
Message-ID: <20240807-gecheckt-groll-94355086496f@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-3-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-3-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:15:49AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> 	The absolute majority of instances comes from fdget() and its
> relatives; the underlying primitives actually return a struct file
> reference and a couple of flags encoded into an unsigned long - the lower
> two bits of file address are always zero, so we can stash the flags
> into those.  On the way out we use __to_fd() to unpack that unsigned
> long into struct fd.
> 
> 	Let's use that representation for struct fd itself - make it
> a structure with a single unsigned long member (.word), with the value
> equal either to (unsigned long)p | flags, p being an address of some
> struct file instance, or to 0 for an empty fd.
> 
> 	Note that we never used a struct fd instance with NULL ->file
> and non-zero ->flags; the emptiness had been checked as (!f.file) and
> we expected e.g. fdput(empty) to be a no-op.  With new representation
> we can use (!f.word) for emptiness check; that is enough for compiler
> to figure out that (f.word & FDPUT_FPUT) will be false and that fdput(f)
> will be a no-op in such case.
> 
> 	For now the new predicate (fd_empty(f)) has no users; all the
> existing checks have form (!fd_file(f)).  We will convert to fd_empty()
> use later; here we only define it (and tell the compiler that it's
> unlikely to return true).
> 
> 	This commit only deals with representation change; there will
> be followups.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  drivers/infiniband/core/uverbs_cmd.c |  2 +-
>  fs/overlayfs/file.c                  | 28 +++++++++++++++-------------
>  fs/xfs/xfs_handle.c                  |  2 +-
>  include/linux/file.h                 | 22 ++++++++++++++++------
>  kernel/events/core.c                 |  2 +-
>  net/socket.c                         |  2 +-
>  6 files changed, 35 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 3f85575cf971..a4cce360df21 100644
> --- a/drivers/infiniband/core/uverbs_cmd.c
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -572,7 +572,7 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
>  	struct inode                   *inode = NULL;
>  	int				new_xrcd = 0;
>  	struct ib_device *ib_dev;
> -	struct fd f = {};
> +	struct fd f = EMPTY_FD;
>  	int ret;
>  
>  	ret = uverbs_request(attrs, &cmd, sizeof(cmd));
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index c4963d0c5549..2b7a5a3a7a2f 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -93,11 +93,11 @@ static int ovl_real_fdget_meta(const struct file *file, struct fd *real,
>  			       bool allow_meta)
>  {
>  	struct dentry *dentry = file_dentry(file);
> +	struct file *realfile = file->private_data;
>  	struct path realpath;
>  	int err;
>  
> -	real->flags = 0;
> -	real->file = file->private_data;
> +	real->word = (unsigned long)realfile;
>  
>  	if (allow_meta) {
>  		ovl_path_real(dentry, &realpath);
> @@ -113,16 +113,17 @@ static int ovl_real_fdget_meta(const struct file *file, struct fd *real,
>  		return -EIO;
>  
>  	/* Has it been copied up since we'd opened it? */
> -	if (unlikely(file_inode(real->file) != d_inode(realpath.dentry))) {
> -		real->flags = FDPUT_FPUT;
> -		real->file = ovl_open_realfile(file, &realpath);
> -
> -		return PTR_ERR_OR_ZERO(real->file);
> +	if (unlikely(file_inode(realfile) != d_inode(realpath.dentry))) {
> +		struct file *f = ovl_open_realfile(file, &realpath);
> +		if (IS_ERR(f))
> +			return PTR_ERR(f);
> +		real->word = (unsigned long)ovl_open_realfile(file, &realpath) | FDPUT_FPUT;
> +		return 0;
>  	}
>  
>  	/* Did the flags change since open? */
> -	if (unlikely((file->f_flags ^ real->file->f_flags) & ~OVL_OPEN_FLAGS))
> -		return ovl_change_flags(real->file, file->f_flags);
> +	if (unlikely((file->f_flags ^ realfile->f_flags) & ~OVL_OPEN_FLAGS))
> +		return ovl_change_flags(realfile, file->f_flags);
>  
>  	return 0;
>  }
> @@ -130,10 +131,11 @@ static int ovl_real_fdget_meta(const struct file *file, struct fd *real,
>  static int ovl_real_fdget(const struct file *file, struct fd *real)
>  {
>  	if (d_is_dir(file_dentry(file))) {
> -		real->flags = 0;
> -		real->file = ovl_dir_real_file(file, false);
> -
> -		return PTR_ERR_OR_ZERO(real->file);
> +		struct file *f = ovl_dir_real_file(file, false);
> +		if (IS_ERR(f))
> +			return PTR_ERR(f);
> +		real->word = (unsigned long)f;
> +		return 0;
>  	}
>  
>  	return ovl_real_fdget_meta(file, real, false);
> diff --git a/fs/xfs/xfs_handle.c b/fs/xfs/xfs_handle.c
> index 7bcc4f519cb8..49e5e5f04e60 100644
> --- a/fs/xfs/xfs_handle.c
> +++ b/fs/xfs/xfs_handle.c
> @@ -85,7 +85,7 @@ xfs_find_handle(
>  	int			hsize;
>  	xfs_handle_t		handle;
>  	struct inode		*inode;
> -	struct fd		f = {NULL};
> +	struct fd		f = EMPTY_FD;
>  	struct path		path;
>  	int			error;
>  	struct xfs_inode	*ip;
> diff --git a/include/linux/file.h b/include/linux/file.h
> index 0f3f369f2450..bdd6e1766839 100644
> --- a/include/linux/file.h
> +++ b/include/linux/file.h
> @@ -35,18 +35,28 @@ static inline void fput_light(struct file *file, int fput_needed)
>  		fput(file);
>  }
>  
> +/* either a reference to struct file + flags
> + * (cloned vs. borrowed, pos locked), with
> + * flags stored in lower bits of value,
> + * or empty (represented by 0).
> + */
>  struct fd {
> -	struct file *file;
> -	unsigned int flags;
> +	unsigned long word;
>  };
>  #define FDPUT_FPUT       1
>  #define FDPUT_POS_UNLOCK 2
>  
> -#define fd_file(f) ((f).file)
> +#define fd_file(f) ((struct file *)((f).word & ~3))

Minor thing but it would be nice if you'd use the macros for this
instead of the raw number:

#define fd_file(f) ((struct file *)((f).word & ~(FDPUT_FPUT | FDPUT_POS_UNLOCK))

Reviewed-by: Christian Brauner <brauner@kernel.org>

