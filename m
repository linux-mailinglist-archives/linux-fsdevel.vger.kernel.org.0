Return-Path: <linux-fsdevel+bounces-25158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1706A9497D4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 20:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393771C227AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C12A82498;
	Tue,  6 Aug 2024 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9259O1/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63937174F;
	Tue,  6 Aug 2024 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722970614; cv=none; b=Qadf50ZIvVvRKEkKBWe9D2XVLftqAut6Pm2WK3cAQQyow35NWWgXarInXnYSf5udoQf9IwYXPdLzXkAlJ0L9Kzj3MablGnVRK3QaWm73zF1zYHl3j/6fqaMEcRPMv7rUZduGTkAXVY09s3wkjufMIPUMWWBcf8rH/EHgTFu8nqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722970614; c=relaxed/simple;
	bh=0UC+Qudesw2i6gCGgGPfWFEUN+gP6GfTVco0cE92juo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBaATLdU3g3UaBEhi89AS2K6FiSEvpwpa9KVppuWmlit9ZfEA3LFwIYpPd7Vml3VoSOKwr0bBgPv2no1qu1n0nQVQ+eDsMuOvIiAld3/xmTEzCJOyuYtvOZCPkNdt3JNssc3hYTHOkJPh11ClEH7kp66Z4zKyxWSp086AUR0h5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9259O1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EF8C4AF0C;
	Tue,  6 Aug 2024 18:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722970613;
	bh=0UC+Qudesw2i6gCGgGPfWFEUN+gP6GfTVco0cE92juo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a9259O1/cOPEO+Qfo1yxYCsaIiPmd/0Hu611qbRh6JgF7wTZ2cSA1y3HxGylZkyYh
	 5wET2AplmFbnXzdQQ7zTfCqvdubUtnRWh/6pHtVnysM9RGdV3zTaX3Y64rR+LNuHq/
	 GYZNYO6fD+rehgeyZ3tizd3myxS1RatCag5VGF4q36Mo/M5+kCUuLOmnCxDOE4VVJJ
	 l3C+Vg0/6+UAr8+7NmOyflBRWAK+w11oVhmSvJE8aMV/oVEjgVqRKk1qC3kN81HmtO
	 kCwCElMa7wr8mb/z7PuKC5pVrI0OPInG5MpHSmOCHo8M5S/8vbCaDcG1RU4qQqp/p6
	 voRZmjZK8WauA==
Date: Tue, 6 Aug 2024 11:56:51 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v3 03/14] xfs: simplify extent allocation alignment
Message-ID: <20240806185651.GG623936@frogsfrogsfrogs>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
 <20240801163057.3981192-4-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801163057.3981192-4-john.g.garry@oracle.com>

On Thu, Aug 01, 2024 at 04:30:46PM +0000, John Garry wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> We currently align extent allocation to stripe unit or stripe width.
> That is specified by an external parameter to the allocation code,
> which then manipulates the xfs_alloc_args alignment configuration in
> interesting ways.
> 
> The args->alignment field specifies extent start alignment, but
> because we may be attempting non-aligned allocation first there are
> also slop variables that allow for those allocation attempts to
> account for aligned allocation if they fail.
> 
> This gets much more complex as we introduce forced allocation
> alignment, where extent size hints are used to generate the extent
> start alignment. extent size hints currently only affect extent
> lengths (via args->prod and args->mod) and so with this change we
> will have two different start alignment conditions.
> 
> Avoid this complexity by always using args->alignment to indicate
> extent start alignment, and always using args->prod/mod to indicate
> extent length adjustment.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> [jpg: fixup alignslop references in xfs_trace.h and xfs_ialloc.c]
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Going back to the 6/21 posting[1], what were the answers to the
questions I posted?  Did I correctly figure out what alignslop refers
to?  AFAICT this is the same patch though at least it has the nits
fixed.

[1] https://lore.kernel.org/linux-xfs/20240621202914.GT3058325@frogsfrogsfrogs/

--D

> ---
>  fs/xfs/libxfs/xfs_alloc.c  |  4 +-
>  fs/xfs/libxfs/xfs_alloc.h  |  2 +-
>  fs/xfs/libxfs/xfs_bmap.c   | 95 ++++++++++++++++----------------------
>  fs/xfs/libxfs/xfs_ialloc.c | 10 ++--
>  fs/xfs/xfs_trace.h         |  8 ++--
>  5 files changed, 53 insertions(+), 66 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
> index bf08b9e9d9ac..a9ab7d71c558 100644
> --- a/fs/xfs/libxfs/xfs_alloc.c
> +++ b/fs/xfs/libxfs/xfs_alloc.c
> @@ -2506,7 +2506,7 @@ xfs_alloc_space_available(
>  	reservation = xfs_ag_resv_needed(pag, args->resv);
>  
>  	/* do we have enough contiguous free space for the allocation? */
> -	alloc_len = args->minlen + (args->alignment - 1) + args->minalignslop;
> +	alloc_len = args->minlen + (args->alignment - 1) + args->alignslop;
>  	longest = xfs_alloc_longest_free_extent(pag, min_free, reservation);
>  	if (longest < alloc_len)
>  		return false;
> @@ -2535,7 +2535,7 @@ xfs_alloc_space_available(
>  	 * allocation as we know that will definitely succeed and match the
>  	 * callers alignment constraints.
>  	 */
> -	alloc_len = args->maxlen + (args->alignment - 1) + args->minalignslop;
> +	alloc_len = args->maxlen + (args->alignment - 1) + args->alignslop;
>  	if (longest < alloc_len) {
>  		args->maxlen = args->minlen;
>  		ASSERT(args->maxlen > 0);
> diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
> index fae170825be0..473822a5d4e9 100644
> --- a/fs/xfs/libxfs/xfs_alloc.h
> +++ b/fs/xfs/libxfs/xfs_alloc.h
> @@ -46,7 +46,7 @@ typedef struct xfs_alloc_arg {
>  	xfs_extlen_t	minleft;	/* min blocks must be left after us */
>  	xfs_extlen_t	total;		/* total blocks needed in xaction */
>  	xfs_extlen_t	alignment;	/* align answer to multiple of this */
> -	xfs_extlen_t	minalignslop;	/* slop for minlen+alignment calcs */
> +	xfs_extlen_t	alignslop;	/* slop for alignment calcs */
>  	xfs_agblock_t	min_agbno;	/* set an agbno range for NEAR allocs */
>  	xfs_agblock_t	max_agbno;	/* ... */
>  	xfs_extlen_t	len;		/* output: actual size of extent */
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 7df74c35d9f9..25a87e1154bb 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -3286,6 +3286,10 @@ xfs_bmap_select_minlen(
>  	xfs_extlen_t		blen)
>  {
>  
> +	/* Adjust best length for extent start alignment. */
> +	if (blen > args->alignment)
> +		blen -= args->alignment;
> +
>  	/*
>  	 * Since we used XFS_ALLOC_FLAG_TRYLOCK in _longest_free_extent(), it is
>  	 * possible that there is enough contiguous free space for this request.
> @@ -3394,35 +3398,43 @@ xfs_bmap_alloc_account(
>  	xfs_trans_mod_dquot_byino(ap->tp, ap->ip, fld, ap->length);
>  }
>  
> -static int
> +/*
> + * Calculate the extent start alignment and the extent length adjustments that
> + * constrain this allocation.
> + *
> + * Extent start alignment is currently determined by stripe configuration and is
> + * carried in args->alignment, whilst extent length adjustment is determined by
> + * extent size hints and is carried by args->prod and args->mod.
> + *
> + * Low level allocation code is free to either ignore or override these values
> + * as required.
> + */
> +static void
>  xfs_bmap_compute_alignments(
>  	struct xfs_bmalloca	*ap,
>  	struct xfs_alloc_arg	*args)
>  {
>  	struct xfs_mount	*mp = args->mp;
>  	xfs_extlen_t		align = 0; /* minimum allocation alignment */
> -	int			stripe_align = 0;
>  
>  	/* stripe alignment for allocation is determined by mount parameters */
>  	if (mp->m_swidth && xfs_has_swalloc(mp))
> -		stripe_align = mp->m_swidth;
> +		args->alignment = mp->m_swidth;
>  	else if (mp->m_dalign)
> -		stripe_align = mp->m_dalign;
> +		args->alignment = mp->m_dalign;
>  
>  	if (ap->flags & XFS_BMAPI_COWFORK)
>  		align = xfs_get_cowextsz_hint(ap->ip);
>  	else if (ap->datatype & XFS_ALLOC_USERDATA)
>  		align = xfs_get_extsz_hint(ap->ip);
> +
>  	if (align) {
>  		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
>  					ap->eof, 0, ap->conv, &ap->offset,
>  					&ap->length))
>  			ASSERT(0);
>  		ASSERT(ap->length);
> -	}
>  
> -	/* apply extent size hints if obtained earlier */
> -	if (align) {
>  		args->prod = align;
>  		div_u64_rem(ap->offset, args->prod, &args->mod);
>  		if (args->mod)
> @@ -3437,7 +3449,6 @@ xfs_bmap_compute_alignments(
>  			args->mod = args->prod - args->mod;
>  	}
>  
> -	return stripe_align;
>  }
>  
>  static void
> @@ -3509,7 +3520,7 @@ xfs_bmap_exact_minlen_extent_alloc(
>  	args.total = ap->total;
>  
>  	args.alignment = 1;
> -	args.minalignslop = 0;
> +	args.alignslop = 0;
>  
>  	args.minleft = ap->minleft;
>  	args.wasdel = ap->wasdel;
> @@ -3549,7 +3560,6 @@ xfs_bmap_btalloc_at_eof(
>  	struct xfs_bmalloca	*ap,
>  	struct xfs_alloc_arg	*args,
>  	xfs_extlen_t		blen,
> -	int			stripe_align,
>  	bool			ag_only)
>  {
>  	struct xfs_mount	*mp = args->mp;
> @@ -3563,23 +3573,15 @@ xfs_bmap_btalloc_at_eof(
>  	 * allocation.
>  	 */
>  	if (ap->offset) {
> -		xfs_extlen_t	nextminlen = 0;
> +		xfs_extlen_t	alignment = args->alignment;
>  
>  		/*
> -		 * Compute the minlen+alignment for the next case.  Set slop so
> -		 * that the value of minlen+alignment+slop doesn't go up between
> -		 * the calls.
> +		 * Compute the alignment slop for the fallback path so we ensure
> +		 * we account for the potential alignment space required by the
> +		 * fallback paths before we modify the AGF and AGFL here.
>  		 */
>  		args->alignment = 1;
> -		if (blen > stripe_align && blen <= args->maxlen)
> -			nextminlen = blen - stripe_align;
> -		else
> -			nextminlen = args->minlen;
> -		if (nextminlen + stripe_align > args->minlen + 1)
> -			args->minalignslop = nextminlen + stripe_align -
> -					args->minlen - 1;
> -		else
> -			args->minalignslop = 0;
> +		args->alignslop = alignment - args->alignment;
>  
>  		if (!caller_pag)
>  			args->pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, ap->blkno));
> @@ -3597,19 +3599,8 @@ xfs_bmap_btalloc_at_eof(
>  		 * Exact allocation failed. Reset to try an aligned allocation
>  		 * according to the original allocation specification.
>  		 */
> -		args->alignment = stripe_align;
> -		args->minlen = nextminlen;
> -		args->minalignslop = 0;
> -	} else {
> -		/*
> -		 * Adjust minlen to try and preserve alignment if we
> -		 * can't guarantee an aligned maxlen extent.
> -		 */
> -		args->alignment = stripe_align;
> -		if (blen > args->alignment &&
> -		    blen <= args->maxlen + args->alignment)
> -			args->minlen = blen - args->alignment;
> -		args->minalignslop = 0;
> +		args->alignment = alignment;
> +		args->alignslop = 0;
>  	}
>  
>  	if (ag_only) {
> @@ -3627,9 +3618,8 @@ xfs_bmap_btalloc_at_eof(
>  		return 0;
>  
>  	/*
> -	 * Allocation failed, so turn return the allocation args to their
> -	 * original non-aligned state so the caller can proceed on allocation
> -	 * failure as if this function was never called.
> +	 * Aligned allocation failed, so all fallback paths from here drop the
> +	 * start alignment requirement as we know it will not succeed.
>  	 */
>  	args->alignment = 1;
>  	return 0;
> @@ -3637,7 +3627,9 @@ xfs_bmap_btalloc_at_eof(
>  
>  /*
>   * We have failed multiple allocation attempts so now are in a low space
> - * allocation situation. Try a locality first full filesystem minimum length
> + * allocation situation. We give up on any attempt at aligned allocation here.
> + *
> + * Try a locality first full filesystem minimum length
>   * allocation whilst still maintaining necessary total block reservation
>   * requirements.
>   *
> @@ -3654,6 +3646,7 @@ xfs_bmap_btalloc_low_space(
>  {
>  	int			error;
>  
> +	args->alignment = 1;
>  	if (args->minlen > ap->minlen) {
>  		args->minlen = ap->minlen;
>  		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
> @@ -3673,13 +3666,11 @@ xfs_bmap_btalloc_low_space(
>  static int
>  xfs_bmap_btalloc_filestreams(
>  	struct xfs_bmalloca	*ap,
> -	struct xfs_alloc_arg	*args,
> -	int			stripe_align)
> +	struct xfs_alloc_arg	*args)
>  {
>  	xfs_extlen_t		blen = 0;
>  	int			error = 0;
>  
> -
>  	error = xfs_filestream_select_ag(ap, args, &blen);
>  	if (error)
>  		return error;
> @@ -3698,8 +3689,7 @@ xfs_bmap_btalloc_filestreams(
>  
>  	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
>  	if (ap->aeof)
> -		error = xfs_bmap_btalloc_at_eof(ap, args, blen, stripe_align,
> -				true);
> +		error = xfs_bmap_btalloc_at_eof(ap, args, blen, true);
>  
>  	if (!error && args->fsbno == NULLFSBLOCK)
>  		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
> @@ -3723,8 +3713,7 @@ xfs_bmap_btalloc_filestreams(
>  static int
>  xfs_bmap_btalloc_best_length(
>  	struct xfs_bmalloca	*ap,
> -	struct xfs_alloc_arg	*args,
> -	int			stripe_align)
> +	struct xfs_alloc_arg	*args)
>  {
>  	xfs_extlen_t		blen = 0;
>  	int			error;
> @@ -3748,8 +3737,7 @@ xfs_bmap_btalloc_best_length(
>  	 * trying.
>  	 */
>  	if (ap->aeof && !(ap->tp->t_flags & XFS_TRANS_LOWMODE)) {
> -		error = xfs_bmap_btalloc_at_eof(ap, args, blen, stripe_align,
> -				false);
> +		error = xfs_bmap_btalloc_at_eof(ap, args, blen, false);
>  		if (error || args->fsbno != NULLFSBLOCK)
>  			return error;
>  	}
> @@ -3776,27 +3764,26 @@ xfs_bmap_btalloc(
>  		.resv		= XFS_AG_RESV_NONE,
>  		.datatype	= ap->datatype,
>  		.alignment	= 1,
> -		.minalignslop	= 0,
> +		.alignslop	= 0,
>  	};
>  	xfs_fileoff_t		orig_offset;
>  	xfs_extlen_t		orig_length;
>  	int			error;
> -	int			stripe_align;
>  
>  	ASSERT(ap->length);
>  	orig_offset = ap->offset;
>  	orig_length = ap->length;
>  
> -	stripe_align = xfs_bmap_compute_alignments(ap, &args);
> +	xfs_bmap_compute_alignments(ap, &args);
>  
>  	/* Trim the allocation back to the maximum an AG can fit. */
>  	args.maxlen = min(ap->length, mp->m_ag_max_usable);
>  
>  	if ((ap->datatype & XFS_ALLOC_USERDATA) &&
>  	    xfs_inode_is_filestream(ap->ip))
> -		error = xfs_bmap_btalloc_filestreams(ap, &args, stripe_align);
> +		error = xfs_bmap_btalloc_filestreams(ap, &args);
>  	else
> -		error = xfs_bmap_btalloc_best_length(ap, &args, stripe_align);
> +		error = xfs_bmap_btalloc_best_length(ap, &args);
>  	if (error)
>  		return error;
>  
> diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
> index 0af5b7a33d05..2fa29d2f004e 100644
> --- a/fs/xfs/libxfs/xfs_ialloc.c
> +++ b/fs/xfs/libxfs/xfs_ialloc.c
> @@ -758,12 +758,12 @@ xfs_ialloc_ag_alloc(
>  		 *
>  		 * For an exact allocation, alignment must be 1,
>  		 * however we need to take cluster alignment into account when
> -		 * fixing up the freelist. Use the minalignslop field to
> -		 * indicate that extra blocks might be required for alignment,
> -		 * but not to use them in the actual exact allocation.
> +		 * fixing up the freelist. Use the alignslop field to indicate
> +		 * that extra blocks might be required for alignment, but not
> +		 * to use them in the actual exact allocation.
>  		 */
>  		args.alignment = 1;
> -		args.minalignslop = igeo->cluster_align - 1;
> +		args.alignslop = igeo->cluster_align - 1;
>  
>  		/* Allow space for the inode btree to split. */
>  		args.minleft = igeo->inobt_maxlevels;
> @@ -783,7 +783,7 @@ xfs_ialloc_ag_alloc(
>  		 * on, so reset minalignslop to ensure it is not included in
>  		 * subsequent requests.
>  		 */
> -		args.minalignslop = 0;
> +		args.alignslop = 0;
>  	}
>  
>  	if (unlikely(args.fsbno == NULLFSBLOCK)) {
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index 5646d300b286..fb0c46d9a6d9 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -1811,7 +1811,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
>  		__field(xfs_extlen_t, minleft)
>  		__field(xfs_extlen_t, total)
>  		__field(xfs_extlen_t, alignment)
> -		__field(xfs_extlen_t, minalignslop)
> +		__field(xfs_extlen_t, alignslop)
>  		__field(xfs_extlen_t, len)
>  		__field(char, wasdel)
>  		__field(char, wasfromfl)
> @@ -1830,7 +1830,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
>  		__entry->minleft = args->minleft;
>  		__entry->total = args->total;
>  		__entry->alignment = args->alignment;
> -		__entry->minalignslop = args->minalignslop;
> +		__entry->alignslop = args->alignslop;
>  		__entry->len = args->len;
>  		__entry->wasdel = args->wasdel;
>  		__entry->wasfromfl = args->wasfromfl;
> @@ -1839,7 +1839,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
>  		__entry->highest_agno = args->tp->t_highest_agno;
>  	),
>  	TP_printk("dev %d:%d agno 0x%x agbno 0x%x minlen %u maxlen %u mod %u "
> -		  "prod %u minleft %u total %u alignment %u minalignslop %u "
> +		  "prod %u minleft %u total %u alignment %u alignslop %u "
>  		  "len %u wasdel %d wasfromfl %d resv %d "
>  		  "datatype 0x%x highest_agno 0x%x",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
> @@ -1852,7 +1852,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
>  		  __entry->minleft,
>  		  __entry->total,
>  		  __entry->alignment,
> -		  __entry->minalignslop,
> +		  __entry->alignslop,
>  		  __entry->len,
>  		  __entry->wasdel,
>  		  __entry->wasfromfl,
> -- 
> 2.31.1
> 
> 

