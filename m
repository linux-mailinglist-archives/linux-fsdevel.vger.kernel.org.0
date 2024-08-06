Return-Path: <linux-fsdevel+bounces-25178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525769498DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 22:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6D5FB23F91
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 20:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4CD155307;
	Tue,  6 Aug 2024 20:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtI6vIiz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD8A129A7E;
	Tue,  6 Aug 2024 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722975279; cv=none; b=YwHPsrJzp8TUvX0nYcXEVxYhombaLodnq9Z1TZgHyRTAyecs92pNIrPJtTcxvNnkyCNAHlWPrERSV/XA5tvm5TW68mhRm24hS9BQwqHwCuyaW0SUBBqwg+7+DE+dJLmFJHs1Mr8RkzlvR4OA3I2333gWX0E18XN6KhKSjuVZqbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722975279; c=relaxed/simple;
	bh=cYwuBVW7WPFKRnEpy+IFFl54ag6Ze/dkRiRVedUF4IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8b0mG4Qsus90kogZK3g8mU1EFKoVm7bOpEYVbIDcI7aLuMLbgsS4DzTbaJ1d6DWqRmJPVkifK/RmuMAbqIUzAWPdku+gFKcoUEv0+yQzC/g4BwhYwlgTEyz97aFlGQW6zwfsNNnKQ/e4vJ1IIjVY5or1vTwhn/rcCChbPMWKEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtI6vIiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCBAC32786;
	Tue,  6 Aug 2024 20:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722975278;
	bh=cYwuBVW7WPFKRnEpy+IFFl54ag6Ze/dkRiRVedUF4IM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TtI6vIizcTct3JI8798A4w91z293kJbkj58Der6gwHzpG1MZkXP2JAjRrQqmsed85
	 jcHiCGUcFTiLuSbKDTNgmOaS6vR+bAPlPLa6G76w4NzzIdLQZk+nCxUWIS6fuWHfQp
	 USlysRcxK/97bW0zDrHmnFEC+Jsa3EsdUrxPGcNoTMW5ED8SeeZqsDhf/rYVl1P02A
	 6+S4m6EjNuUWrb42pNb1bDLw2kACCQZJOC5PDa4ajPSUcdDJ2B/+u9qCwxWgzDk6hl
	 RQ0f60FkvtMho1RdrmupFPNpMVVXKMjDdezooq/gHTpu49l2TE58rfmxH0BKndk4XJ
	 wg3D/qqzABOog==
Date: Tue, 6 Aug 2024 13:14:38 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v3 12/14] xfs: Unmap blocks according to forcealign
Message-ID: <20240806201438.GP623936@frogsfrogsfrogs>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
 <20240801163057.3981192-13-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801163057.3981192-13-john.g.garry@oracle.com>

On Thu, Aug 01, 2024 at 04:30:55PM +0000, John Garry wrote:
> For when forcealign is enabled, blocks in an inode need to be unmapped
> according to extent alignment, like what is already done for rtvol.
> 
> Change variable isrt in __xfs_bunmapi() to a bool, as that is really what
> it is.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_bmap.c | 48 +++++++++++++++++++++++++++++-----------
>  fs/xfs/xfs_inode.c       | 16 ++++++++++++++
>  fs/xfs/xfs_inode.h       |  2 ++
>  3 files changed, 53 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 0c3df8c71c6d..d6ae344a17fc 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -5409,6 +5409,25 @@ xfs_bmap_del_extent_real(
>  	return 0;
>  }
>  
> +static xfs_extlen_t
> +xfs_bunmapi_align(
> +	struct xfs_inode	*ip,
> +	xfs_fsblock_t		fsbno,
> +	xfs_extlen_t *off)
> +{
> +	struct xfs_mount	*mp = ip->i_mount;
> +
> +	if (XFS_IS_REALTIME_INODE(ip))
> +		return xfs_inode_alloc_fsbsize_align(ip, fsbno, off);
> +	/*
> +	 * The agbno for the fsbno is aligned to extsize, but the fsbno itself
> +	 * is not necessarily aligned (to extsize), so use agbno to determine
> +	 * mod+offset to the alloc unit boundary.
> +	 */
> +	return xfs_inode_alloc_fsbsize_align(ip, XFS_FSB_TO_AGBNO(mp, fsbno),
> +					off);
> +}
> +
>  /*
>   * Unmap (remove) blocks from a file.
>   * If nexts is nonzero then the number of extents to remove is limited to
> @@ -5430,7 +5449,8 @@ __xfs_bunmapi(
>  	xfs_extnum_t		extno;		/* extent number in list */
>  	struct xfs_bmbt_irec	got;		/* current extent record */
>  	struct xfs_ifork	*ifp;		/* inode fork pointer */
> -	int			isrt;		/* freeing in rt area */
> +	bool			isrt;		/* freeing in rt area */
> +	bool			isforcealign;	/* forcealign inode */
>  	int			logflags;	/* transaction logging flags */
>  	xfs_extlen_t		mod;		/* rt extent offset */
>  	struct xfs_mount	*mp = ip->i_mount;
> @@ -5468,6 +5488,8 @@ __xfs_bunmapi(
>  	}
>  	XFS_STATS_INC(mp, xs_blk_unmap);
>  	isrt = xfs_ifork_is_realtime(ip, whichfork);
> +	isforcealign = (whichfork != XFS_ATTR_FORK) &&
> +			xfs_inode_has_forcealign(ip);
>  	end = start + len;
>  
>  	if (!xfs_iext_lookup_extent_before(ip, ifp, &end, &icur, &got)) {
> @@ -5486,6 +5508,8 @@ __xfs_bunmapi(
>  	extno = 0;
>  	while (end != (xfs_fileoff_t)-1 && end >= start &&
>  	       (nexts == 0 || extno < nexts)) {
> +		xfs_extlen_t off;

I got really confused because I thought this was a file block offset and
only after more digging realized that this is a sometimes dummy
adjustment variable.

> +
>  		/*
>  		 * Is the found extent after a hole in which end lives?
>  		 * Just back up to the previous extent, if so.
> @@ -5519,18 +5543,18 @@ __xfs_bunmapi(
>  		if (del.br_startoff + del.br_blockcount > end + 1)
>  			del.br_blockcount = end + 1 - del.br_startoff;
>  
> -		if (!isrt || (flags & XFS_BMAPI_REMAP))
> +		if ((!isrt && !isforcealign) || (flags & XFS_BMAPI_REMAP))
>  			goto delete;
>  
> -		mod = xfs_rtb_to_rtxoff(mp,
> -				del.br_startblock + del.br_blockcount);
> +		mod = xfs_bunmapi_align(ip,
> +				del.br_startblock + del.br_blockcount, &off);
>  		if (mod) {

Oof.  I don't like how this loop body has the rtx adjustment code
inlined into it.  We only use the isrt flag for the one test above.
I tried hoisting this into something less gross involving separate
adjustment functions but then you have to pass in so many outer
variables that it becomes a mess.

The best I can come up with for now is:

	unsigned int		alloc_fsb = xfs_inode_alloc_fsbsize(ip);
	/* no more isrt/isforcealign bools */

...

		if (alloc_fsb == 1 || (flags & XFS_BMAPI_REMAP))
			goto delete;

		mod = do_div(del.br_startblock + del.br_blockcount,
				alloc_fsb);
		if (mod) {

>  			/*
> -			 * Realtime extent not lined up at the end.
> +			 * Not aligned to allocation unit on the end.
>  			 * The extent could have been split into written
>  			 * and unwritten pieces, or we could just be
>  			 * unmapping part of it.  But we can't really
> -			 * get rid of part of a realtime extent.
> +			 * get rid of part of an extent.
>  			 */
>  			if (del.br_state == XFS_EXT_UNWRITTEN) {
>  				/*
> @@ -5554,7 +5578,7 @@ __xfs_bunmapi(
>  			ASSERT(del.br_state == XFS_EXT_NORM);
>  			ASSERT(tp->t_blk_res > 0);
>  			/*
> -			 * If this spans a realtime extent boundary,
> +			 * If this spans an extent boundary,
>  			 * chop it back to the start of the one we end at.
>  			 */
>  			if (del.br_blockcount > mod) {
> @@ -5571,14 +5595,12 @@ __xfs_bunmapi(
>  			goto nodelete;
>  		}
>  
> -		mod = xfs_rtb_to_rtxoff(mp, del.br_startblock);
> +		mod = xfs_bunmapi_align(ip, del.br_startblock, &off);
>  		if (mod) {
> -			xfs_extlen_t off = mp->m_sb.sb_rextsize - mod;

		mod = do_div(del.br_startblock, alloc_fsb);
		if (mod) {
			xfs_extlen_t off = alloc_fsb - mod;

At least then you don't need this weird xfs_inode_alloc_fsbsize_align
that passes back two xfs_extlen_t arguments.

--D

> -
>  			/*
> -			 * Realtime extent is lined up at the end but not
> -			 * at the front.  We'll get rid of full extents if
> -			 * we can.
> +			 * Extent is lined up to the allocation unit at the
> +			 * end but not at the front.  We'll get rid of full
> +			 * extents if we can.
>  			 */
>  			if (del.br_blockcount > off) {
>  				del.br_blockcount -= off;
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index e7fa155fcbde..bb8abf990186 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -3164,3 +3164,19 @@ xfs_is_always_cow_inode(
>  {
>  	return ip->i_mount->m_always_cow && xfs_has_reflink(ip->i_mount);
>  }
> +
> +/* Return mod+offset for a blkno to an extent boundary */
> +xfs_extlen_t
> +xfs_inode_alloc_fsbsize_align(
> +	struct xfs_inode	*ip,
> +	xfs_fileoff_t		blkno,
> +	xfs_extlen_t		*off)
> +{
> +	xfs_fileoff_t		blkno_start = blkno;
> +	xfs_fileoff_t		blkno_end = blkno;
> +
> +	xfs_roundout_to_alloc_fsbsize(ip, &blkno_start, &blkno_end);
> +
> +	*off = blkno_end - blkno;
> +	return blkno - blkno_start;
> +}
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index 6dd8055c98b3..7b77797c3943 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -647,6 +647,8 @@ void xfs_roundout_to_alloc_fsbsize(struct xfs_inode *ip,
>  		xfs_fileoff_t *start, xfs_fileoff_t *end);
>  void xfs_roundin_to_alloc_fsbsize(struct xfs_inode *ip,
>  		xfs_fileoff_t *start, xfs_fileoff_t *end);
> +xfs_extlen_t xfs_inode_alloc_fsbsize_align(struct xfs_inode *ip,
> +		xfs_fileoff_t blkno, xfs_extlen_t *off);
>  
>  int xfs_icreate_dqalloc(const struct xfs_icreate_args *args,
>  		struct xfs_dquot **udqpp, struct xfs_dquot **gdqpp,
> -- 
> 2.31.1
> 
> 

