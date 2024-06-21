Return-Path: <linux-fsdevel+bounces-22147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5B2912DB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 21:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5581C21CFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 19:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D3817B4EB;
	Fri, 21 Jun 2024 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcKCvJrv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF13B67D;
	Fri, 21 Jun 2024 19:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718997168; cv=none; b=hbt8j3jJ62FbYMhEgSJ+NpSzjn2uskVWLzUrQQt6rDNKQYX1UZM7zWmOElYBl+AOUb1ug3z5fEo0vm0FkemZ/Ii0fwKjgcrSX75AFgNEYyVYrSuQfeuwQDNH9egw2BAwF5s3f7M6HeyrErPIN20whj2p5T3ETx8pB7hpfYUw5i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718997168; c=relaxed/simple;
	bh=f+QuD2y+6K/IT2/O6QZD0H+WxyVcFzzZSAuacaACgIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/9ma/VV1XJ9VpQ1nGar2tnw8GssBRTFx2tMNlTprW7sLYPq2/Ao4CteDyDFyeIu6qypVFUl8oAhhiTocwM2uRgEEGSjEALfCKHbGOWAukg22CmnUzMCb+GYolL3oiXB8qiz/2Odho34SjVVN8z4rYyE3tUHjXo8hfEi1yHuaBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcKCvJrv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC63C2BBFC;
	Fri, 21 Jun 2024 19:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718997167;
	bh=f+QuD2y+6K/IT2/O6QZD0H+WxyVcFzzZSAuacaACgIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PcKCvJrvweslkf++VAUfj5e0rjNKOxXMHabPpCx8qXHdsrLYbULsCgw2uwssI6oLH
	 V7/rNYr1cE4phkb4lTIufP/h4lRA+1fYKsZu5rXEUuL2eQArvzbl0i4urvIsqxlZMM
	 SDVCvifBI0lUk5OgUM9myO2V1wzDa9MIcyzKWVsUYUro/an3HYDCFHz9tTCAl3lxK7
	 F8A/wnWck+HF4RM6lvB16Vn9Ust8ILwhMDlpoO0o2+xydYHg6t5aM6o1+DNTY0tHNU
	 1apAsE96v4qL3Sh8j1q0PqoxWIE84u8g5TgOeGHNFZZ3HzwKf9vnhXt2qPWX04/nWu
	 PKWFblTrIp14Q==
Date: Fri, 21 Jun 2024 12:12:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH 10/13] xfs: Unmap blocks according to forcealign
Message-ID: <20240621191247.GO3058325@frogsfrogsfrogs>
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
 <20240621100540.2976618-11-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621100540.2976618-11-john.g.garry@oracle.com>

On Fri, Jun 21, 2024 at 10:05:37AM +0000, John Garry wrote:
> For when forcealign is enabled, blocks in an inode need to be unmapped
> according to extent alignment, like what is already done for rtvol.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_bmap.c | 38 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index c9cf138e13c4..ebeb2969b289 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -5380,6 +5380,25 @@ xfs_bmap_del_extent_real(
>  	return 0;
>  }
>  
> +static xfs_extlen_t
> +xfs_bunmapi_align(
> +	struct xfs_inode	*ip,
> +	xfs_fsblock_t		bno)
> +{
> +	struct xfs_mount	*mp = ip->i_mount;
> +	xfs_agblock_t		agbno;
> +
> +	if (xfs_inode_has_forcealign(ip)) {
> +		if (is_power_of_2(ip->i_extsize))
> +			return bno & (ip->i_extsize - 1);
> +
> +		agbno = XFS_FSB_TO_AGBNO(mp, bno);
> +		return do_div(agbno, ip->i_extsize);

Huh.  The inode verifier allows realtime forcealign files, but this code
will not handle that properly.  Either don't allow realtime files, or
make this handle them correctly:

	if (XFS_IS_REALTIME_INODE(ip)) {
		if (xfs_inode_has_forcealign(ip))
			return offset_in_block(bno, ip->i_extsize);
		return xfs_rtb_to_rtxoff(ip->i_mount, bno);
	} else if (xfs_inode_has_forcealign(ip)) {
		xfs_agblock_t	agbno = XFS_FSB_TO_AGBNO(mp, bno);

		return offset_in_block(agbno, ip->i_extsize);
	}

	return 1; /* or assert, or whatever */

> +	}
> +	ASSERT(XFS_IS_REALTIME_INODE(ip));
> +	return xfs_rtb_to_rtxoff(ip->i_mount, bno);
> +}
> +
>  /*
>   * Unmap (remove) blocks from a file.
>   * If nexts is nonzero then the number of extents to remove is limited to
> @@ -5402,6 +5421,7 @@ __xfs_bunmapi(
>  	struct xfs_bmbt_irec	got;		/* current extent record */
>  	struct xfs_ifork	*ifp;		/* inode fork pointer */
>  	int			isrt;		/* freeing in rt area */
> +	int			isforcealign;	/* freeing for inode with forcealign */
>  	int			logflags;	/* transaction logging flags */
>  	xfs_extlen_t		mod;		/* rt extent offset */
>  	struct xfs_mount	*mp = ip->i_mount;
> @@ -5439,6 +5459,8 @@ __xfs_bunmapi(
>  	}
>  	XFS_STATS_INC(mp, xs_blk_unmap);
>  	isrt = xfs_ifork_is_realtime(ip, whichfork);
> +	isforcealign = (whichfork != XFS_ATTR_FORK) &&
> +			xfs_inode_has_forcealign(ip);
>  	end = start + len;
>  
>  	if (!xfs_iext_lookup_extent_before(ip, ifp, &end, &icur, &got)) {
> @@ -5490,11 +5512,10 @@ __xfs_bunmapi(
>  		if (del.br_startoff + del.br_blockcount > end + 1)
>  			del.br_blockcount = end + 1 - del.br_startoff;
>  
> -		if (!isrt || (flags & XFS_BMAPI_REMAP))
> +		if ((!isrt && !isforcealign) || (flags & XFS_BMAPI_REMAP))
>  			goto delete;
>  
> -		mod = xfs_rtb_to_rtxoff(mp,
> -				del.br_startblock + del.br_blockcount);
> +		mod = xfs_bunmapi_align(ip, del.br_startblock + del.br_blockcount);
>  		if (mod) {
>  			/*
>  			 * Realtime extent not lined up at the end.

"Not aligned to allocation unit on the end." ?

> @@ -5542,9 +5563,16 @@ __xfs_bunmapi(
>  			goto nodelete;
>  		}
>  
> -		mod = xfs_rtb_to_rtxoff(mp, del.br_startblock);
> +		mod = xfs_bunmapi_align(ip, del.br_startblock);
>  		if (mod) {
> -			xfs_extlen_t off = mp->m_sb.sb_rextsize - mod;
> +			xfs_extlen_t off;
> +
> +			if (isforcealign) {
> +				off = ip->i_extsize - mod;
> +			} else {
> +				ASSERT(isrt);
> +				off = mp->m_sb.sb_rextsize - mod;
> +			}
>  
>  			/*
>  			 * Realtime extent is lined up at the end but not

Same here -- now this code is handling more than just rt extents.

--D

> -- 
> 2.31.1
> 
> 

