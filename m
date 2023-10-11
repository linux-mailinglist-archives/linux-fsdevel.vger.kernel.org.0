Return-Path: <linux-fsdevel+bounces-13-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D61F7C46F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 03:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD1A1C20E2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 01:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93441A5D;
	Wed, 11 Oct 2023 01:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOnf8n4s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08257F9;
	Wed, 11 Oct 2023 01:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF31C433C8;
	Wed, 11 Oct 2023 01:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696986104;
	bh=pQX/H1/6m6Xdzj3lx8DHkqGsf2jJR7suqDH1hBEaBLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOnf8n4sbzrxiJX7HaFtLt9CNwqRouyTjtEIbXagMuUSjZOUpxvA/2ZBHtYk3t+Es
	 Dr3B8CH5Bl28TyCzDL+i4z1Lu4nD4u3AYuv6q6Wbo1PPe1onG3UJNaon1W5U2QVt6h
	 tFu7p99jHRU4YhKmL82uYPlw7ZU3i50ng9WDZRbmMXyAUArC+C0ULRQRo8aU42lqFT
	 GMpYQI+2uAImrVGS3aF1ylABTdmi/cOnW8v/NhEJb8JQUw3WLJ6rX2dHMO8IKtAXTa
	 lbdx9UFQ8LtV/Yf7Cm6V1K/kMp8qBqO53B9DMq95nhS0fL5XXIh1Y7nB3wgPrVMpH9
	 TDj8/tEFLL6CQ==
Date: Tue, 10 Oct 2023 18:01:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, ebiggers@kernel.org, david@fromorbit.com,
	dchinner@redhat.com,
	Allison Henderson <allison.henderson@oracle.com>
Subject: Re: [PATCH v3 04/28] xfs: Add xfs_verify_pptr
Message-ID: <20231011010143.GH21298@frogsfrogsfrogs>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-5-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006184922.252188-5-aalbersh@redhat.com>

On Fri, Oct 06, 2023 at 08:48:58PM +0200, Andrey Albershteyn wrote:
> From: Allison Henderson <allison.henderson@oracle.com>
> 
> Attribute names of parent pointers are not strings.  So we need to modify
> attr_namecheck to verify parent pointer records when the XFS_ATTR_PARENT flag is
> set.
> 
> Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Hi Andrey,

Could you take a look at the latest revision of the parent pointers
patchset, please?  Your version and mine have drifted very far apart
over the summer...

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=pptrs-fsck

--D

> ---
>  fs/xfs/libxfs/xfs_attr.c      | 47 ++++++++++++++++++++++++++++++++---
>  fs/xfs/libxfs/xfs_attr.h      |  3 ++-
>  fs/xfs/libxfs/xfs_da_format.h |  8 ++++++
>  fs/xfs/scrub/attr.c           |  2 +-
>  fs/xfs/xfs_attr_item.c        | 11 +++++---
>  fs/xfs/xfs_attr_list.c        | 17 +++++++++----
>  6 files changed, 74 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
> index 101823772bf9..711022742e34 100644
> --- a/fs/xfs/libxfs/xfs_attr.c
> +++ b/fs/xfs/libxfs/xfs_attr.c
> @@ -1577,9 +1577,33 @@ xfs_attr_node_get(
>  	return error;
>  }
>  
> -/* Returns true if the attribute entry name is valid. */
> -bool
> -xfs_attr_namecheck(
> +/*
> + * Verify parent pointer attribute is valid.
> + * Return true on success or false on failure
> + */
> +STATIC bool
> +xfs_verify_pptr(
> +	struct xfs_mount			*mp,
> +	const struct xfs_parent_name_rec	*rec)
> +{
> +	xfs_ino_t				p_ino;
> +	xfs_dir2_dataptr_t			p_diroffset;
> +
> +	p_ino = be64_to_cpu(rec->p_ino);
> +	p_diroffset = be32_to_cpu(rec->p_diroffset);
> +
> +	if (!xfs_verify_ino(mp, p_ino))
> +		return false;
> +
> +	if (p_diroffset > XFS_DIR2_MAX_DATAPTR)
> +		return false;
> +
> +	return true;
> +}
> +
> +/* Returns true if the string attribute entry name is valid. */
> +static bool
> +xfs_str_attr_namecheck(
>  	const void	*name,
>  	size_t		length)
>  {
> @@ -1594,6 +1618,23 @@ xfs_attr_namecheck(
>  	return !memchr(name, 0, length);
>  }
>  
> +/* Returns true if the attribute entry name is valid. */
> +bool
> +xfs_attr_namecheck(
> +	struct xfs_mount	*mp,
> +	const void		*name,
> +	size_t			length,
> +	int			flags)
> +{
> +	if (flags & XFS_ATTR_PARENT) {
> +		if (length != sizeof(struct xfs_parent_name_rec))
> +			return false;
> +		return xfs_verify_pptr(mp, (struct xfs_parent_name_rec *)name);
> +	}
> +
> +	return xfs_str_attr_namecheck(name, length);
> +}
> +
>  int __init
>  xfs_attr_intent_init_cache(void)
>  {
> diff --git a/fs/xfs/libxfs/xfs_attr.h b/fs/xfs/libxfs/xfs_attr.h
> index 3e81f3f48560..b79dae788cfb 100644
> --- a/fs/xfs/libxfs/xfs_attr.h
> +++ b/fs/xfs/libxfs/xfs_attr.h
> @@ -547,7 +547,8 @@ int xfs_attr_get(struct xfs_da_args *args);
>  int xfs_attr_set(struct xfs_da_args *args);
>  int xfs_attr_set_iter(struct xfs_attr_intent *attr);
>  int xfs_attr_remove_iter(struct xfs_attr_intent *attr);
> -bool xfs_attr_namecheck(const void *name, size_t length);
> +bool xfs_attr_namecheck(struct xfs_mount *mp, const void *name, size_t length,
> +			int flags);
>  int xfs_attr_calc_size(struct xfs_da_args *args, int *local);
>  void xfs_init_attr_trans(struct xfs_da_args *args, struct xfs_trans_res *tres,
>  			 unsigned int *total);
> diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
> index 307c8cdb6f10..6deefe03207f 100644
> --- a/fs/xfs/libxfs/xfs_da_format.h
> +++ b/fs/xfs/libxfs/xfs_da_format.h
> @@ -741,6 +741,14 @@ xfs_attr3_leaf_name(xfs_attr_leafblock_t *leafp, int idx)
>  	return &((char *)leafp)[be16_to_cpu(entries[idx].nameidx)];
>  }
>  
> +static inline int
> +xfs_attr3_leaf_flags(xfs_attr_leafblock_t *leafp, int idx)
> +{
> +	struct xfs_attr_leaf_entry *entries = xfs_attr3_leaf_entryp(leafp);
> +
> +	return entries[idx].flags;
> +}
> +
>  static inline xfs_attr_leaf_name_remote_t *
>  xfs_attr3_leaf_name_remote(xfs_attr_leafblock_t *leafp, int idx)
>  {
> diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
> index 8bc6aa274fa6..f35144704395 100644
> --- a/fs/xfs/scrub/attr.c
> +++ b/fs/xfs/scrub/attr.c
> @@ -195,7 +195,7 @@ xchk_xattr_listent(
>  	}
>  
>  	/* Does this name make sense? */
> -	if (!xfs_attr_namecheck(name, namelen)) {
> +	if (!xfs_attr_namecheck(sx->sc->mp, name, namelen, flags)) {
>  		xchk_fblock_set_corrupt(sx->sc, XFS_ATTR_FORK, args.blkno);
>  		goto fail_xref;
>  	}
> diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
> index 97ee9d89b5b8..63393216159f 100644
> --- a/fs/xfs/xfs_attr_item.c
> +++ b/fs/xfs/xfs_attr_item.c
> @@ -593,7 +593,8 @@ xfs_attri_item_recover(
>  	 */
>  	attrp = &attrip->attri_format;
>  	if (!xfs_attri_validate(mp, attrp) ||
> -	    !xfs_attr_namecheck(nv->name.i_addr, nv->name.i_len))
> +	    !xfs_attr_namecheck(mp, nv->name.i_addr, nv->name.i_len,
> +				attrp->alfi_attr_filter))
>  		return -EFSCORRUPTED;
>  
>  	error = xlog_recover_iget(mp,  attrp->alfi_ino, &ip);
> @@ -805,7 +806,8 @@ xlog_recover_attri_commit_pass2(
>  	}
>  
>  	attr_name = item->ri_buf[i].i_addr;
> -	if (!xfs_attr_namecheck(attr_name, attri_formatp->alfi_name_len)) {
> +	if (!xfs_attr_namecheck(mp, attr_name, attri_formatp->alfi_name_len,
> +				attri_formatp->alfi_attr_filter)) {
>  		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
>  				item->ri_buf[i].i_addr, item->ri_buf[i].i_len);
>  		return -EFSCORRUPTED;
> @@ -823,8 +825,9 @@ xlog_recover_attri_commit_pass2(
>  		}
>  
>  		attr_nname = item->ri_buf[i].i_addr;
> -		if (!xfs_attr_namecheck(attr_nname,
> -				attri_formatp->alfi_nname_len)) {
> +		if (!xfs_attr_namecheck(mp, attr_nname,
> +				attri_formatp->alfi_nname_len,
> +				attri_formatp->alfi_attr_filter)) {
>  			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
>  					item->ri_buf[i].i_addr,
>  					item->ri_buf[i].i_len);
> diff --git a/fs/xfs/xfs_attr_list.c b/fs/xfs/xfs_attr_list.c
> index 99bbbe1a0e44..a51f7f13a352 100644
> --- a/fs/xfs/xfs_attr_list.c
> +++ b/fs/xfs/xfs_attr_list.c
> @@ -58,9 +58,13 @@ xfs_attr_shortform_list(
>  	struct xfs_attr_sf_sort		*sbuf, *sbp;
>  	struct xfs_attr_shortform	*sf;
>  	struct xfs_attr_sf_entry	*sfe;
> +	struct xfs_mount		*mp;
>  	int				sbsize, nsbuf, count, i;
>  	int				error = 0;
>  
> +	ASSERT(context != NULL);
> +	ASSERT(dp != NULL);
> +	mp = dp->i_mount;
>  	sf = (struct xfs_attr_shortform *)dp->i_af.if_u1.if_data;
>  	ASSERT(sf != NULL);
>  	if (!sf->hdr.count)
> @@ -82,8 +86,9 @@ xfs_attr_shortform_list(
>  	     (dp->i_af.if_bytes + sf->hdr.count * 16) < context->bufsize)) {
>  		for (i = 0, sfe = &sf->list[0]; i < sf->hdr.count; i++) {
>  			if (XFS_IS_CORRUPT(context->dp->i_mount,
> -					   !xfs_attr_namecheck(sfe->nameval,
> -							       sfe->namelen)))
> +					   !xfs_attr_namecheck(mp, sfe->nameval,
> +							       sfe->namelen,
> +							       sfe->flags)))
>  				return -EFSCORRUPTED;
>  			context->put_listent(context,
>  					     sfe->flags,
> @@ -174,8 +179,9 @@ xfs_attr_shortform_list(
>  			cursor->offset = 0;
>  		}
>  		if (XFS_IS_CORRUPT(context->dp->i_mount,
> -				   !xfs_attr_namecheck(sbp->name,
> -						       sbp->namelen))) {
> +				   !xfs_attr_namecheck(mp, sbp->name,
> +						       sbp->namelen,
> +						       sbp->flags))) {
>  			error = -EFSCORRUPTED;
>  			goto out;
>  		}
> @@ -465,7 +471,8 @@ xfs_attr3_leaf_list_int(
>  		}
>  
>  		if (XFS_IS_CORRUPT(context->dp->i_mount,
> -				   !xfs_attr_namecheck(name, namelen)))
> +				   !xfs_attr_namecheck(mp, name, namelen,
> +						       entry->flags)))
>  			return -EFSCORRUPTED;
>  		context->put_listent(context, entry->flags,
>  					      name, namelen, valuelen);
> -- 
> 2.40.1
> 

