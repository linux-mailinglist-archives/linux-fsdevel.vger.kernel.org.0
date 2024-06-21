Return-Path: <linux-fsdevel+bounces-22159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E92912EA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 22:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4791C22E49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 20:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FE217B512;
	Fri, 21 Jun 2024 20:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmcabiAP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD8C17B41F;
	Fri, 21 Jun 2024 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719002224; cv=none; b=gEWZrbXq0xPvsz1hXXyJIu36kt+WENwfC5GIYvSNoiiHR86nXLQ3MpwqzYSUusYQgkSA0eebtM2oUEqvQiyn7jflgvBppHZLxjeGgQwfjlvY/v2m8tubsEOsNNbGpucD8TVZJJXq8kFYpWTsMYOJxstbhXVlnkh0uxmradccXPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719002224; c=relaxed/simple;
	bh=K829tKMdHL12dqTYF+FPBWpnSMhQylZ6lVHoNcmwXF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOU9CBsys785eg8GzJtn0kXSc3gc1O3e418CZ4sHuCs0qceR2hpmhbmwPQR8QE82Ge2xkmQVXM8eisDtnuKed82lCdTaShiJ0wEV9zveaz+YAsDrFXChE/nOraz+9s81+VShVCJSgvDjdlZfi+hM/Vjgn6jbYeFTWoAgxx732c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmcabiAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1E1C2BBFC;
	Fri, 21 Jun 2024 20:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719002223;
	bh=K829tKMdHL12dqTYF+FPBWpnSMhQylZ6lVHoNcmwXF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pmcabiAPpI5lBmVD0cvsvrix1xZ4y2h5SXatM/V7aWvWDktMuCMbm9yN7G1cCyYy1
	 rPtRizvDl1nvP7HWcUdLfaGXHikRr4Xjoxx99RkQm1jBRTwvEmvXKpk0jRvsieqkDP
	 l5C3LVLWCCQCM5b/Zd9ChvFvLH5KFil9e/WfD1TmUYq1a9qyRWIBQXF88P65Fp4ktp
	 i/Gnur4b0kXMXj26nqq3+IegaDvJuHB3tVguoVlfDDcWFQZ8CxCjXfPPMmTwlkGUeq
	 xVKE/nRhDrmveshVR9mGi7mxeeWgXj3LM/ZO+aVFo71ZDPNLrzAPfjZWoYoC3Pythe
	 rwjNGin5Xv4dg==
Date: Fri, 21 Jun 2024 13:37:02 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH 05/13] xfs: introduce forced allocation alignment
Message-ID: <20240621203702.GV3058325@frogsfrogsfrogs>
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
 <20240621100540.2976618-6-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621100540.2976618-6-john.g.garry@oracle.com>

On Fri, Jun 21, 2024 at 10:05:32AM +0000, John Garry wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> When forced allocation alignment is specified, the extent will
> be aligned to the extent size hint size rather than stripe
> alignment. If aligned allocation cannot be done, then the allocation
> is failed rather than attempting non-aligned fallbacks.
> 
> Note: none of the per-inode force align configuration is present
> yet, so this just triggers off an "always false" wrapper function
> for the moment.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Pretty straightfoward!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/libxfs/xfs_alloc.h |  1 +
>  fs/xfs/libxfs/xfs_bmap.c  | 29 +++++++++++++++++++++++------
>  fs/xfs/xfs_inode.h        |  5 +++++
>  3 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
> index aa2c103d98f0..7de2e6f64882 100644
> --- a/fs/xfs/libxfs/xfs_alloc.h
> +++ b/fs/xfs/libxfs/xfs_alloc.h
> @@ -66,6 +66,7 @@ typedef struct xfs_alloc_arg {
>  #define XFS_ALLOC_USERDATA		(1 << 0)/* allocation is for user data*/
>  #define XFS_ALLOC_INITIAL_USER_DATA	(1 << 1)/* special case start of file */
>  #define XFS_ALLOC_NOBUSY		(1 << 2)/* Busy extents not allowed */
> +#define XFS_ALLOC_FORCEALIGN		(1 << 3)/* forced extent alignment */
>  
>  /* freespace limit calculations */
>  unsigned int xfs_alloc_set_aside(struct xfs_mount *mp);
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 528e3cd81ee6..9131ba8113a6 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -3401,9 +3401,10 @@ xfs_bmap_alloc_account(
>   * Calculate the extent start alignment and the extent length adjustments that
>   * constrain this allocation.
>   *
> - * Extent start alignment is currently determined by stripe configuration and is
> - * carried in args->alignment, whilst extent length adjustment is determined by
> - * extent size hints and is carried by args->prod and args->mod.
> + * Extent start alignment is currently determined by forced inode alignment or
> + * stripe configuration and is carried in args->alignment, whilst extent length
> + * adjustment is determined by extent size hints and is carried by args->prod
> + * and args->mod.
>   *
>   * Low level allocation code is free to either ignore or override these values
>   * as required.
> @@ -3416,11 +3417,18 @@ xfs_bmap_compute_alignments(
>  	struct xfs_mount	*mp = args->mp;
>  	xfs_extlen_t		align = 0; /* minimum allocation alignment */
>  
> -	/* stripe alignment for allocation is determined by mount parameters */
> -	if (mp->m_swidth && xfs_has_swalloc(mp))
> +	/*
> +	 * Forced inode alignment takes preference over stripe alignment.
> +	 * Stripe alignment for allocation is determined by mount parameters.
> +	 */
> +	if (xfs_inode_has_forcealign(ap->ip)) {
> +		args->alignment = xfs_get_extsz_hint(ap->ip);
> +		args->datatype |= XFS_ALLOC_FORCEALIGN;
> +	} else if (mp->m_swidth && xfs_has_swalloc(mp)) {
>  		args->alignment = mp->m_swidth;
> -	else if (mp->m_dalign)
> +	} else if (mp->m_dalign) {
>  		args->alignment = mp->m_dalign;
> +	}
>  
>  	if (ap->flags & XFS_BMAPI_COWFORK)
>  		align = xfs_get_cowextsz_hint(ap->ip);
> @@ -3607,6 +3615,11 @@ xfs_bmap_btalloc_low_space(
>  {
>  	int			error;
>  
> +	if (args->alignment > 1 && (args->datatype & XFS_ALLOC_FORCEALIGN)) {
> +		args->fsbno = NULLFSBLOCK;
> +		return 0;
> +	}
> +
>  	args->alignment = 1;
>  	if (args->minlen > ap->minlen) {
>  		args->minlen = ap->minlen;
> @@ -3658,6 +3671,8 @@ xfs_bmap_btalloc_filestreams(
>  
>  	/* Attempt non-aligned allocation if we haven't already. */
>  	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
> +		if (args->datatype & XFS_ALLOC_FORCEALIGN)
> +			return error;
>  		args->alignment = 1;
>  		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
>  	}
> @@ -3716,6 +3731,8 @@ xfs_bmap_btalloc_best_length(
>  
>  	/* Attempt non-aligned allocation if we haven't already. */
>  	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
> +		if (args->datatype & XFS_ALLOC_FORCEALIGN)
> +			return error;
>  		args->alignment = 1;
>  		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
>  	}
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index 292b90b5f2ac..42f999c1106c 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -311,6 +311,11 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
>  	return ip->i_diflags2 & XFS_DIFLAG2_NREXT64;
>  }
>  
> +static inline bool xfs_inode_has_forcealign(struct xfs_inode *ip)
> +{
> +	return false;
> +}
> +
>  /*
>   * Decide if this file is a realtime file whose data allocation unit is larger
>   * than a single filesystem block.
> -- 
> 2.31.1
> 
> 

