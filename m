Return-Path: <linux-fsdevel+bounces-26943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE91295D397
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8339E1F22DF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 16:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF3E18BC0F;
	Fri, 23 Aug 2024 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EseA2AGf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FF2188A1A;
	Fri, 23 Aug 2024 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430902; cv=none; b=CG8TBWTKjxZSfuZBYT6h2Wa/v1lsQ3SolaHtPcJQUUl7vih8dNFvbri1Voh2wKsnYaT/ywsuhG4wn+oVa1Wu0/cknehOZgAn92wP9UzAhgBnG42IFxibsZMiJXWttaT2JhoaZG2+Q8YYK/zne6k/AGYKW7OiqXMFFG+H7zf4H6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430902; c=relaxed/simple;
	bh=U9X5a5rGX2lKZTnV7WShDNM8IpNHEe/HA7qYkCTylAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CttFw9CawZjnDHWN6aR0iQUFCJl41hRlh9W35MIgtuRvGbgDVDjfXPBlmTxoqeEwRk2OTDcR6yYp+9nGVvZbLbza+SUzChnCLYaIwDaFXf7zAhueKWqlaUmtdHpwgdWXcsJRmh6VozvGPin5ofvZNnF6EBT810g0+AnO6/KxK0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EseA2AGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93501C32786;
	Fri, 23 Aug 2024 16:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724430901;
	bh=U9X5a5rGX2lKZTnV7WShDNM8IpNHEe/HA7qYkCTylAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EseA2AGfjjhJCvVsPP2TaDLSNTRN52Ja0Eg5yyOzpmqC44PvXrcLDGC6ZADiD2KM1
	 zc/78A5uO1/wiiCoL8XM8VmsYd8hkxJJjIwAkZtAZXVjgRICpbPrL5TPBhv+tSrTzH
	 BzQq9/1x0zs27HyaMAbZStngmb/G2HrnjlQOiml6hwCqs95a1Nk+KpPbggzmndEplw
	 rX32e5fBHBO8q75J6B4Mcdg+x4otGNFxWTqwaiqXrC3UzR7zosqPG3FJMxs+/KCHyA
	 zXimFetcel9AmdOquC4HP3+heKUyL6aBLu2tvb83tc4ClsNr9L+LN0pdrfQR/FVEnP
	 gAeeHL3RMnl6Q==
Date: Fri, 23 Aug 2024 09:35:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v4 12/14] xfs: Unmap blocks according to forcealign
Message-ID: <20240823163501.GD865349@frogsfrogsfrogs>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
 <20240813163638.3751939-13-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813163638.3751939-13-john.g.garry@oracle.com>

On Tue, Aug 13, 2024 at 04:36:36PM +0000, John Garry wrote:
> For when forcealign is enabled, blocks in an inode need to be unmapped
> according to extent alignment, like what is already done for rtvol.
> 
> Generalize the code by replacing variable isrt with a value to hold the
> FSB alloc size for the inode, which works for forcealign.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks good to me now,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/libxfs/xfs_bmap.c | 46 ++++++++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 0c3df8c71c6d..3ab2cecf09d2 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -5409,6 +5409,25 @@ xfs_bmap_del_extent_real(
>  	return 0;
>  }
>  
> +static xfs_extlen_t
> +xfs_bmap_alloc_unit_offset(
> +	struct xfs_inode	*ip,
> +	unsigned int		alloc_fsb,
> +	xfs_fsblock_t		fsbno)
> +{
> +	xfs_agblock_t		agbno;
> +
> +	if (XFS_IS_REALTIME_INODE(ip))
> +		return do_div(fsbno, alloc_fsb);
> +	/*
> +	 * The agbno for the fsbno is aligned to extsize, but the fsbno itself
> +	 * is not necessarily aligned (to extsize), so use agbno to determine
> +	 * mod to the alloc unit boundary.
> +	 */
> +	agbno = XFS_FSB_TO_AGBNO(ip->i_mount, fsbno);
> +	return agbno % alloc_fsb;
> +}
> +
>  /*
>   * Unmap (remove) blocks from a file.
>   * If nexts is nonzero then the number of extents to remove is limited to
> @@ -5430,7 +5449,6 @@ __xfs_bunmapi(
>  	xfs_extnum_t		extno;		/* extent number in list */
>  	struct xfs_bmbt_irec	got;		/* current extent record */
>  	struct xfs_ifork	*ifp;		/* inode fork pointer */
> -	int			isrt;		/* freeing in rt area */
>  	int			logflags;	/* transaction logging flags */
>  	xfs_extlen_t		mod;		/* rt extent offset */
>  	struct xfs_mount	*mp = ip->i_mount;
> @@ -5441,6 +5459,7 @@ __xfs_bunmapi(
>  	xfs_fileoff_t		end;
>  	struct xfs_iext_cursor	icur;
>  	bool			done = false;
> +	unsigned int		alloc_fsb = xfs_inode_alloc_fsbsize(ip);
>  
>  	trace_xfs_bunmap(ip, start, len, flags, _RET_IP_);
>  
> @@ -5467,7 +5486,6 @@ __xfs_bunmapi(
>  		return 0;
>  	}
>  	XFS_STATS_INC(mp, xs_blk_unmap);
> -	isrt = xfs_ifork_is_realtime(ip, whichfork);
>  	end = start + len;
>  
>  	if (!xfs_iext_lookup_extent_before(ip, ifp, &end, &icur, &got)) {
> @@ -5519,18 +5537,18 @@ __xfs_bunmapi(
>  		if (del.br_startoff + del.br_blockcount > end + 1)
>  			del.br_blockcount = end + 1 - del.br_startoff;
>  
> -		if (!isrt || (flags & XFS_BMAPI_REMAP))
> +		if (alloc_fsb == 1 || (flags & XFS_BMAPI_REMAP))
>  			goto delete;
>  
> -		mod = xfs_rtb_to_rtxoff(mp,
> +		mod = xfs_bmap_alloc_unit_offset(ip, alloc_fsb,
>  				del.br_startblock + del.br_blockcount);
>  		if (mod) {
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
> @@ -5554,8 +5572,8 @@ __xfs_bunmapi(
>  			ASSERT(del.br_state == XFS_EXT_NORM);
>  			ASSERT(tp->t_blk_res > 0);
>  			/*
> -			 * If this spans a realtime extent boundary,
> -			 * chop it back to the start of the one we end at.
> +			 * If this spans an extent boundary, chop it back to
> +			 * the start of the one we end at.
>  			 */
>  			if (del.br_blockcount > mod) {
>  				del.br_startoff += del.br_blockcount - mod;
> @@ -5571,14 +5589,14 @@ __xfs_bunmapi(
>  			goto nodelete;
>  		}
>  
> -		mod = xfs_rtb_to_rtxoff(mp, del.br_startblock);
> +		mod = xfs_bmap_alloc_unit_offset(ip, alloc_fsb,
> +					del.br_startblock);
>  		if (mod) {
> -			xfs_extlen_t off = mp->m_sb.sb_rextsize - mod;
> -
> +			xfs_extlen_t off = alloc_fsb - mod;
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
> -- 
> 2.31.1
> 
> 

