Return-Path: <linux-fsdevel+bounces-43716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 108A1A5C412
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 15:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC1116E625
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 14:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AEB25D204;
	Tue, 11 Mar 2025 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTRouv4T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D8025CC7F;
	Tue, 11 Mar 2025 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704032; cv=none; b=caH/q/zSt97bvidNHLp3+f15JRKPKgLFkPIOJFCsMK5bQ5kFqH3uCfDUUIA+6dfw+SplDu5quHFKR5rI2lAvkkerqk+xKYLHuZtQ1BptpAbieuMfe9C186lHeVVXRrlsA8aVFfr3nV15XCG95qxK+ZpXV1oQnGHahGNVghfUYl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704032; c=relaxed/simple;
	bh=/xp/6HGmVHuJ9t0K5UdunC1SKMJXjXVR53BOxX7lfpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbFb9tYkpC+B2+nCzJHtwzLwah5WOlZeodgrXqRM61Xjt1ZINb/0B/aZll3D5OOVZbfHzAKApHrfeWC/hRiPc5mF9uk/5Viw2+IMu0bD6n1V/o5G3SNtiM7qiBD1Av6nVx3KwslcJm2jd8sLYcvFQL9YbBatDNJVFq5F43Q4kZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTRouv4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848A0C4CEEA;
	Tue, 11 Mar 2025 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741704031;
	bh=/xp/6HGmVHuJ9t0K5UdunC1SKMJXjXVR53BOxX7lfpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nTRouv4TnJNQ+smiVKW04Op9R+uck/TFzOhmfTYyeCEP5qMA6iWmCT6Hg1ID9ZCmR
	 F3b4P1Q+ZerGMUoH7GW1DTiETm+lhrrBmQyWSRFJsvfmnSQBKDdnoaSHAodCFX5VCD
	 PVv4ZpsOzBtvxZ/DKUXfH2hAMNMH97poxMXyTg9yAE8cTPX7ztt9uc72cqX4xaNiTo
	 ZsuJPREXSmL4cz5oYpSqVmOQLB4wYU7fqUqU8RYn1DpV5+0oGXA7P0bbfVOm7gCVwE
	 tEYc/w8vWIdASWcZCttwA7WP4BDdsonWAJzELkhcOffghN6LR4GC19sV27X5zF5BeR
	 luELcfaGLQJVg==
Date: Tue, 11 Mar 2025 15:40:26 +0100
From: Carlos Maiolino <cem@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, 
	ritesh.list@gmail.com, martin.petersen@oracle.com
Subject: Re: [PATCH v5 08/10] xfs: Update atomic write max size
Message-ID: <fzco7qoicujxpar4zw7kgiqtmgsilslyrejle7txtjfuzdrs53@wctetg2lemjk>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <KoecCbd1rVAyb-cHgSE9YBZJyRgJTlxN9I_xPcVGICEEU10pLEu8b75qYwrdS3yUSl6RKCR2K7BEqC7KxCfp4g==@protonmail.internalid>
 <20250310183946.932054-9-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310183946.932054-9-john.g.garry@oracle.com>

Thanks for updating it John.

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

On Mon, Mar 10, 2025 at 06:39:44PM +0000, John Garry wrote:
> Now that CoW-based atomic writes are supported, update the max size of an
> atomic write.
> 
> For simplicity, limit at the max of what the mounted bdev can support in
> terms of atomic write limits. Maybe in future we will have a better way
> to advertise this optimised limit.
> 
> In addition, the max atomic write size needs to be aligned to the agsize.
> Limit the size of atomic writes to the greatest power-of-two factor of the
> agsize so that allocations for an atomic write will always be aligned
> compatibly with the alignment requirements of the storage.
> 
> For RT inode, just limit to 1x block, even though larger can be supported
> in future.
> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_iops.c  | 14 +++++++++++++-
>  fs/xfs/xfs_mount.c | 28 ++++++++++++++++++++++++++++
>  fs/xfs/xfs_mount.h |  1 +
>  3 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index de065cc2e7cf..16a1f9541690 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -607,12 +607,24 @@ xfs_get_atomic_write_attr(
>  	unsigned int		*unit_min,
>  	unsigned int		*unit_max)
>  {
> +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> +	struct xfs_mount	*mp = ip->i_mount;
> +
>  	if (!xfs_inode_can_atomicwrite(ip)) {
>  		*unit_min = *unit_max = 0;
>  		return;
>  	}
> 
> -	*unit_min = *unit_max = ip->i_mount->m_sb.sb_blocksize;
> +	*unit_min = ip->i_mount->m_sb.sb_blocksize;
> +
> +	if (XFS_IS_REALTIME_INODE(ip)) {
> +		/* For now, set limit at 1x block */
> +		*unit_max = ip->i_mount->m_sb.sb_blocksize;
> +	} else {
> +		*unit_max =  min_t(unsigned int,
> +					XFS_FSB_TO_B(mp, mp->m_awu_max),
> +					target->bt_bdev_awu_max);
> +	}
>  }
> 
>  static void
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index e65a659901d5..414adfb944b9 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -665,6 +665,32 @@ xfs_agbtree_compute_maxlevels(
>  	levels = max(levels, mp->m_rmap_maxlevels);
>  	mp->m_agbtree_maxlevels = max(levels, mp->m_refc_maxlevels);
>  }
> +static inline void
> +xfs_compute_awu_max(
> +	struct xfs_mount	*mp)
> +{
> +	xfs_agblock_t		agsize = mp->m_sb.sb_agblocks;
> +	xfs_agblock_t		awu_max;
> +
> +	if (!xfs_has_reflink(mp)) {
> +		mp->m_awu_max = 1;
> +		return;
> +	}
> +
> +	/*
> +	 * Find highest power-of-2 evenly divisible into agsize and which
> +	 * also fits into an unsigned int field.
> +	 */
> +	awu_max = 1;
> +	while (1) {
> +		if (agsize % (awu_max * 2))
> +			break;
> +		if (XFS_FSB_TO_B(mp, awu_max * 2) > UINT_MAX)
> +			break;
> +		awu_max *= 2;
> +	}
> +	mp->m_awu_max = awu_max;
> +}
> 
>  /* Compute maximum possible height for realtime btree types for this fs. */
>  static inline void
> @@ -751,6 +777,8 @@ xfs_mountfs(
>  	xfs_agbtree_compute_maxlevels(mp);
>  	xfs_rtbtree_compute_maxlevels(mp);
> 
> +	xfs_compute_awu_max(mp);
> +
>  	/*
>  	 * Check if sb_agblocks is aligned at stripe boundary.  If sb_agblocks
>  	 * is NOT aligned turn off m_dalign since allocator alignment is within
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index 799b84220ebb..1b0136da2aec 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -229,6 +229,7 @@ typedef struct xfs_mount {
>  	bool			m_finobt_nores; /* no per-AG finobt resv. */
>  	bool			m_update_sb;	/* sb needs update in mount */
>  	unsigned int		m_max_open_zones;
> +	xfs_extlen_t		m_awu_max;	/* data device max atomic write */
> 
>  	/*
>  	 * Bitsets of per-fs metadata that have been checked and/or are sick.
> --
> 2.31.1
> 

