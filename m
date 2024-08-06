Return-Path: <linux-fsdevel+bounces-25159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A6C9497DD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 20:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3A01F2480B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4591B7E575;
	Tue,  6 Aug 2024 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqFqbAUH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFC28F77;
	Tue,  6 Aug 2024 18:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722970685; cv=none; b=bAPsK1ebbe9gnTN51xmfHJHedKqK41qD/eMTSabnvY7EB1mAWUwF/gEVOSe5HRb2s1+kqOGz8qHh01YLlHzo3rQd4yEOnN/FJbRUBAFuICYm20cboHWpoYLxRKHNTzEEENIQxEz+8lWV43E1uAmEvKgzUIDUYUmsvcLux+uFs14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722970685; c=relaxed/simple;
	bh=XimH0OuNIUTLC54WyHG6saQ35XMNvhja1+IPfPU9k/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkIpqnCkEut9Tr2G3n91VEK3MqYWln3u3DOJy6EJAWwLBzIMKodetaSWGY9BwEZtzZs+PzhvAbQ696V8JVEhCZ6MNFxsmT9czB4DRnihAlN7TCBsCPWZ03jHgwO3Uos0mYBNUcgEiC1UrczqPI1WZeSvCWAsMD81+KwGG4EuP2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqFqbAUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64701C32786;
	Tue,  6 Aug 2024 18:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722970685;
	bh=XimH0OuNIUTLC54WyHG6saQ35XMNvhja1+IPfPU9k/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cqFqbAUHYuQbPVnvuqQAElWSBkp5YetK7859aYaQEkMbl+2Vf0wG/H0Tig9nROcxl
	 0eNIKbTWbW6lO59nmX2mqZN0c9g0mu4G33RDSk3mn0OT6wOo43kpuKyaTVnn06imQh
	 8kfpnb+gq/qcKVC2tFbhssZffzdhhzZ6b1SliAqoHMydU33AMIU1mRxyd0dVflQn1e
	 kBeF49GFrBu/rWu7CAhaNcVv7y5bqOkvIUPD4uP2+3TRUiN9AssUnJqhxxh4O7Xs8X
	 Xl+ks2brMkNyjnP1ggJSrUm7EoboYIjYRAeacaNcq+ptpGGkvOX/ztTaeAOJtWBRKw
	 /b7cwAp0AisNg==
Date: Tue, 6 Aug 2024 11:58:04 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v2 04/13] xfs: make EOF allocation simpler
Message-ID: <20240806185804.GH623936@frogsfrogsfrogs>
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
 <20240705162450.3481169-5-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705162450.3481169-5-john.g.garry@oracle.com>

On Fri, Jul 05, 2024 at 04:24:41PM +0000, John Garry wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Currently the allocation at EOF is broken into two cases - when the
> offset is zero and when the offset is non-zero. When the offset is
> non-zero, we try to do exact block allocation for contiguous
> extent allocation. When the offset is zero, the allocation is simply
> an aligned allocation.
> 
> We want aligned allocation as the fallback when exact block
> allocation fails, but that complicates the EOF allocation in that it
> now has to handle two different allocation cases. The
> caller also has to handle allocation when not at EOF, and for the
> upcoming forced alignment changes we need that to also be aligned
> allocation.
> 
> To simplify all this, pull the aligned allocation cases back into
> the callers and leave the EOF allocation path for exact block
> allocation only. This means that the EOF exact block allocation
> fallback path is the normal aligned allocation path and that ends up
> making things a lot simpler when forced alignment is introduced.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_bmap.c   | 129 +++++++++++++++----------------------
>  fs/xfs/libxfs/xfs_ialloc.c |   2 +-
>  2 files changed, 54 insertions(+), 77 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index b5156bafb7be..4122a2da06ec 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -3309,12 +3309,12 @@ xfs_bmap_select_minlen(
>  static int
>  xfs_bmap_btalloc_select_lengths(
>  	struct xfs_bmalloca	*ap,
> -	struct xfs_alloc_arg	*args,
> -	xfs_extlen_t		*blen)
> +	struct xfs_alloc_arg	*args)
>  {
>  	struct xfs_mount	*mp = args->mp;
>  	struct xfs_perag	*pag;
>  	xfs_agnumber_t		agno, startag;
> +	xfs_extlen_t		blen = 0;
>  	int			error = 0;
>  
>  	if (ap->tp->t_flags & XFS_TRANS_LOWMODE) {
> @@ -3328,19 +3328,18 @@ xfs_bmap_btalloc_select_lengths(
>  	if (startag == NULLAGNUMBER)
>  		startag = 0;
>  
> -	*blen = 0;
>  	for_each_perag_wrap(mp, startag, agno, pag) {
> -		error = xfs_bmap_longest_free_extent(pag, args->tp, blen);
> +		error = xfs_bmap_longest_free_extent(pag, args->tp, &blen);
>  		if (error && error != -EAGAIN)
>  			break;
>  		error = 0;
> -		if (*blen >= args->maxlen)
> +		if (blen >= args->maxlen)
>  			break;
>  	}
>  	if (pag)
>  		xfs_perag_rele(pag);
>  
> -	args->minlen = xfs_bmap_select_minlen(ap, args, *blen);
> +	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
>  	return error;
>  }
>  
> @@ -3550,78 +3549,40 @@ xfs_bmap_exact_minlen_extent_alloc(
>   * If we are not low on available data blocks and we are allocating at
>   * EOF, optimise allocation for contiguous file extension and/or stripe
>   * alignment of the new extent.
> - *
> - * NOTE: ap->aeof is only set if the allocation length is >= the
> - * stripe unit and the allocation offset is at the end of file.
>   */
>  static int
>  xfs_bmap_btalloc_at_eof(
>  	struct xfs_bmalloca	*ap,
> -	struct xfs_alloc_arg	*args,
> -	xfs_extlen_t		blen,
> -	bool			ag_only)
> +	struct xfs_alloc_arg	*args)
>  {
>  	struct xfs_mount	*mp = args->mp;
>  	struct xfs_perag	*caller_pag = args->pag;
> +	xfs_extlen_t		alignment = args->alignment;
>  	int			error;
>  
> +	ASSERT(ap->aeof && ap->offset);
> +	ASSERT(args->alignment >= 1);
> +
>  	/*
> -	 * If there are already extents in the file, try an exact EOF block
> -	 * allocation to extend the file as a contiguous extent. If that fails,
> -	 * or it's the first allocation in a file, just try for a stripe aligned
> -	 * allocation.
> +	 * Compute the alignment slop for the fallback path so we ensure
> +	 * we account for the potential alignemnt space required by the
> +	 * fallback paths before we modify the AGF and AGFL here.
>  	 */
> -	if (ap->offset) {
> -		xfs_extlen_t	alignment = args->alignment;
> -
> -		/*
> -		 * Compute the alignment slop for the fallback path so we ensure
> -		 * we account for the potential alignment space required by the
> -		 * fallback paths before we modify the AGF and AGFL here.
> -		 */
> -		args->alignment = 1;
> -		args->alignslop = alignment - args->alignment;
> -
> -		if (!caller_pag)
> -			args->pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, ap->blkno));
> -		error = xfs_alloc_vextent_exact_bno(args, ap->blkno);
> -		if (!caller_pag) {
> -			xfs_perag_put(args->pag);
> -			args->pag = NULL;
> -		}
> -		if (error)
> -			return error;
> -
> -		if (args->fsbno != NULLFSBLOCK)
> -			return 0;
> -		/*
> -		 * Exact allocation failed. Reset to try an aligned allocation
> -		 * according to the original allocation specification.
> -		 */
> -		args->alignment = alignment;
> -		args->alignslop = 0;
> -	}
> +	args->alignment = 1;
> +	args->alignslop = alignment - args->alignment;
>  
> -	if (ag_only) {
> -		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
> -	} else {
> +	if (!caller_pag)
> +		args->pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, ap->blkno));
> +	error = xfs_alloc_vextent_exact_bno(args, ap->blkno);
> +	if (!caller_pag) {
> +		xfs_perag_put(args->pag);
>  		args->pag = NULL;
> -		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
> -		ASSERT(args->pag == NULL);
> -		args->pag = caller_pag;
>  	}
> -	if (error)
> -		return error;
>  
> -	if (args->fsbno != NULLFSBLOCK)
> -		return 0;
> -
> -	/*
> -	 * Aligned allocation failed, so all fallback paths from here drop the
> -	 * start alignment requirement as we know it will not succeed.
> -	 */
> -	args->alignment = 1;
> -	return 0;
> +	/* Reset alignment to original specifications.  */
> +	args->alignment = alignment;
> +	args->alignslop = 0;
> +	return error;
>  }
>  
>  /*
> @@ -3687,12 +3648,19 @@ xfs_bmap_btalloc_filestreams(
>  	}
>  
>  	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
> -	if (ap->aeof)
> -		error = xfs_bmap_btalloc_at_eof(ap, args, blen, true);
> +	if (ap->aeof && ap->offset)
> +		error = xfs_bmap_btalloc_at_eof(ap, args);
>  
> +	/* This may be an aligned allocation attempt. */
>  	if (!error && args->fsbno == NULLFSBLOCK)
>  		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
>  
> +	/* Attempt non-aligned allocation if we haven't already. */
> +	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
> +		args->alignment = 1;
> +		error = xfs_alloc_vextent_near_bno(args, ap->blkno);

and again going back a couple of submissions, do we have to zero
alignslop here?

https://lore.kernel.org/linux-xfs/20240621203556.GU3058325@frogsfrogsfrogs/

--D

> +	}
> +
>  out_low_space:
>  	/*
>  	 * We are now done with the perag reference for the filestreams
> @@ -3714,7 +3682,6 @@ xfs_bmap_btalloc_best_length(
>  	struct xfs_bmalloca	*ap,
>  	struct xfs_alloc_arg	*args)
>  {
> -	xfs_extlen_t		blen = 0;
>  	int			error;
>  
>  	ap->blkno = XFS_INO_TO_FSB(args->mp, ap->ip->i_ino);
> @@ -3725,23 +3692,33 @@ xfs_bmap_btalloc_best_length(
>  	 * the request.  If one isn't found, then adjust the minimum allocation
>  	 * size to the largest space found.
>  	 */
> -	error = xfs_bmap_btalloc_select_lengths(ap, args, &blen);
> +	error = xfs_bmap_btalloc_select_lengths(ap, args);
>  	if (error)
>  		return error;
>  
>  	/*
> -	 * Don't attempt optimal EOF allocation if previous allocations barely
> -	 * succeeded due to being near ENOSPC. It is highly unlikely we'll get
> -	 * optimal or even aligned allocations in this case, so don't waste time
> -	 * trying.
> +	 * If we are in low space mode, then optimal allocation will fail so
> +	 * prepare for minimal allocation and run the low space algorithm
> +	 * immediately.
>  	 */
> -	if (ap->aeof && !(ap->tp->t_flags & XFS_TRANS_LOWMODE)) {
> -		error = xfs_bmap_btalloc_at_eof(ap, args, blen, false);
> -		if (error || args->fsbno != NULLFSBLOCK)
> -			return error;
> +	if (ap->tp->t_flags & XFS_TRANS_LOWMODE) {
> +		ASSERT(args->fsbno == NULLFSBLOCK);
> +		return xfs_bmap_btalloc_low_space(ap, args);
> +	}
> +
> +	if (ap->aeof && ap->offset)
> +		error = xfs_bmap_btalloc_at_eof(ap, args);
> +
> +	/* This may be an aligned allocation attempt. */
> +	if (!error && args->fsbno == NULLFSBLOCK)
> +		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
> +
> +	/* Attempt non-aligned allocation if we haven't already. */
> +	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
> +		args->alignment = 1;
> +		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
>  	}
>  
> -	error = xfs_alloc_vextent_start_ag(args, ap->blkno);
>  	if (error || args->fsbno != NULLFSBLOCK)
>  		return error;
>  
> diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
> index 9f71a9a3a65e..40a2daeea712 100644
> --- a/fs/xfs/libxfs/xfs_ialloc.c
> +++ b/fs/xfs/libxfs/xfs_ialloc.c
> @@ -780,7 +780,7 @@ xfs_ialloc_ag_alloc(
>  		 * the exact agbno requirement and increase the alignment
>  		 * instead. It is critical that the total size of the request
>  		 * (len + alignment + slop) does not increase from this point
> -		 * on, so reset minalignslop to ensure it is not included in
> +		 * on, so reset alignslop to ensure it is not included in
>  		 * subsequent requests.
>  		 */
>  		args.alignslop = 0;
> -- 
> 2.31.1
> 
> 

