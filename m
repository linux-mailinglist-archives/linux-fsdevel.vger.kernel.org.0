Return-Path: <linux-fsdevel+bounces-25172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162D3949839
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 21:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D6D1C20FD9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 19:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF6513F431;
	Tue,  6 Aug 2024 19:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ebexquxp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7255922066;
	Tue,  6 Aug 2024 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972459; cv=none; b=g6IbmJnUEBQUPhl/0C0cb0aZSa9if4s/8VVuYsmc24Ssq5MCQosdVH/fKshcy7gRqnNvd0y8f5Y9sr/yWC11MJVVFgP/Y0UxJH57InZKlaJHXVTl6OAQc/i4x3bRWN15A8nWv5XAPZYrhidqxAuN71YY+IDaordgJxwdaXLluAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972459; c=relaxed/simple;
	bh=3hpNlNjhj2DylZPPrEI4B+JVlg86yLocSEILEUQI0SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGgtdFYTfEX6UjSnAfFcVhTd60todPvBAEzC3m3Eda3Ob5Nzcrg78hyr3h55bdQDUQo03j/wDqveHq2S6Q4PtQ8jIVE09+eWrBqDImYnMdX744rs8jwtIq4nW+r853txHf3ni2EgLqFGedMn8bM321pp9TAhso38Xh7z3HFC1M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ebexquxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07398C32786;
	Tue,  6 Aug 2024 19:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722972459;
	bh=3hpNlNjhj2DylZPPrEI4B+JVlg86yLocSEILEUQI0SI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ebexquxpj1KIh33hBy4kO9PtzB6rTPmmYU2qxAQBKeYV8iGwx+1ydnpTsgiWLUxzl
	 OZ1EnCpturFXi6NXMUaka+Mkv2SygTKnsJyPMAbc6O6VGmUEreIudkGla3nxM+j0Vy
	 6CS9muF1ajyJjV75T+UZUKwsXm1G2pPkYBkgkOK0AkEn2Px1fB05ai1lHWbKU4W/hI
	 +YKVKoG6Z5DA/bToCf6rEjxKqrViLyQofZTJaJ8QCRdCWzZ781xFE3fb4AdkcXbHJH
	 NZMHIaGddrF0j7qB0r1m8+1nA3zxc/mxD1ipnhZF8uk2S6sL05oe0vkW1gxP3hy3Om
	 KY0EdVQUvDSKQ==
Date: Tue, 6 Aug 2024 12:27:38 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v3 11/14] xfs: Only free full extents for forcealign
Message-ID: <20240806192738.GN623936@frogsfrogsfrogs>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
 <20240801163057.3981192-12-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801163057.3981192-12-john.g.garry@oracle.com>

On Thu, Aug 01, 2024 at 04:30:54PM +0000, John Garry wrote:
> Like we already do for rtvol, only free full extents for forcealign in
> xfs_free_file_space().
> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org> #earlier version
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_bmap_util.c |  7 ++-----
>  fs/xfs/xfs_inode.c     | 14 ++++++++++++++
>  fs/xfs/xfs_inode.h     |  2 ++
>  3 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index 60389ac8bd45..46eebecd7bba 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -854,11 +854,8 @@ xfs_free_file_space(
>  	startoffset_fsb = XFS_B_TO_FSB(mp, offset);
>  	endoffset_fsb = XFS_B_TO_FSBT(mp, offset + len);
>  
> -	/* We can only free complete realtime extents. */
> -	if (xfs_inode_has_bigrtalloc(ip)) {
> -		startoffset_fsb = xfs_rtb_roundup_rtx(mp, startoffset_fsb);
> -		endoffset_fsb = xfs_rtb_rounddown_rtx(mp, endoffset_fsb);
> -	}
> +	/* Free only complete extents. */
> +	xfs_roundin_to_alloc_fsbsize(ip, &startoffset_fsb, &endoffset_fsb);

...and then this becomes:

	/* We can only free complete allocation units. */
	startoffset_fsb = xfs_inode_roundup_alloc_unit(ip, startoffset_fsb);
	endoffset_fsb = xfs_inode_rounddown_alloc_unit(ip, endoffset_fsb);

I guess "roundout" means "extend start and end to fit allocation unit"
whereas "roundin" means "shrink start and end to fit allocation unit"?

--D

>  
>  	/*
>  	 * Need to zero the stuff we're not freeing, on disk.
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index d765dedebc15..e7fa155fcbde 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -3143,6 +3143,20 @@ xfs_roundout_to_alloc_fsbsize(
>  	*end = roundup_64(*end, blocks);
>  }
>  
> +void
> +xfs_roundin_to_alloc_fsbsize(
> +	struct xfs_inode	*ip,
> +	xfs_fileoff_t		*start,
> +	xfs_fileoff_t		*end)
> +{
> +	unsigned int		blocks = xfs_inode_alloc_fsbsize(ip);
> +
> +	if (blocks == 1)
> +		return;
> +	*start = roundup_64(*start, blocks);
> +	*end = rounddown_64(*end, blocks);
> +}
> +
>  /* Should we always be using copy on write for file writes? */
>  bool
>  xfs_is_always_cow_inode(
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index 7f86c4781bd8..6dd8055c98b3 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -645,6 +645,8 @@ unsigned int xfs_inode_alloc_fsbsize(struct xfs_inode *ip);
>  unsigned int xfs_inode_alloc_unitsize(struct xfs_inode *ip);
>  void xfs_roundout_to_alloc_fsbsize(struct xfs_inode *ip,
>  		xfs_fileoff_t *start, xfs_fileoff_t *end);
> +void xfs_roundin_to_alloc_fsbsize(struct xfs_inode *ip,
> +		xfs_fileoff_t *start, xfs_fileoff_t *end);
>  
>  int xfs_icreate_dqalloc(const struct xfs_icreate_args *args,
>  		struct xfs_dquot **udqpp, struct xfs_dquot **gdqpp,
> -- 
> 2.31.1
> 
> 

