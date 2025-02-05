Return-Path: <linux-fsdevel+bounces-40973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEECA29A4E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 20:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223313A4F89
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 19:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B71520CCE6;
	Wed,  5 Feb 2025 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihLYjEE4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B051FF1B3;
	Wed,  5 Feb 2025 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738784476; cv=none; b=oIkR14Q0rB29tzDD6lmMbZa0zZIagVoi/g1MI2GnqPr4JS6mk4aOl/u/Wld+x2MeO19q9PnIG7Dw8UYBIXfIL03ZIxk5CZ0j1fkNOh4DNQvYxkaNGiFNEq5uz3eIWFm2aHy1IVnHS/Hnswu5SelhxWgCMQj17bkVNP1u8DP6sio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738784476; c=relaxed/simple;
	bh=tcEf6pqZXHe0649V64+se/suLl6l3L1c0i+UHic/c6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqHmW5n4X1A8cJXfKm+K4GTiOozF9+7NO0Ev3liJB/jLaPqs00KLtW5sEGMRhBICCtc/i5shIQC7QpAZ1APKX/OCo4OLy1LCFuVsXDq85tkdvG9rkNbSdy7DjbhskUekIBsHWcxPHEROhVz/F8aSRbdjMHrpAWOO5L+QPr9+Rvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihLYjEE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10307C4CED1;
	Wed,  5 Feb 2025 19:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738784476;
	bh=tcEf6pqZXHe0649V64+se/suLl6l3L1c0i+UHic/c6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ihLYjEE4cmMwggMUtdjZbED4XDjgEagBYqamcx6RwwTSlgSMkflxeww6LkGrVCJQJ
	 9BJ5uM7dzJNr831EC6SNR0HtFc3zzX9/axxByrH80SkdNP6rdVuJ7qQ9fGTyd7P4Vl
	 cbSmq0gN0zVKpk9+2D3fhCLi4/efabOINoYDkZp+uSRo0fImOM5+5gIn03Ne94RgIo
	 ZZ34V3ui+U5WMD0SEFBwYkwAHySijqKqU4DyteAyjJFxB4D/y4E79m4Q4QZq+OVvPH
	 3ytc8wK+aGCsdczEpYdDs0/hGhw3fP9U6AXTZTfGFSgJsuqqDSL+Hbb4gIkjPKRpyV
	 E5AuKSBHNe3wg==
Date: Wed, 5 Feb 2025 11:41:15 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com
Subject: Re: [PATCH RFC 09/10] xfs: Update atomic write max size
Message-ID: <20250205194115.GV21808@frogsfrogsfrogs>
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
 <20250204120127.2396727-10-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204120127.2396727-10-john.g.garry@oracle.com>

On Tue, Feb 04, 2025 at 12:01:26PM +0000, John Garry wrote:
> Now that CoW-based atomic writes are supported, update the max size of an
> atomic write.
> 
> For simplicity, limit at the max of what the mounted bdev can support in
> terms of atomic write limits. Maybe in future we will have a better way
> to advertise this optimised limit.
> 
> In addition, the max atomic write size needs to be aligned to the agsize.
> Currently when attempting to use HW offload, we  just check that the
> mapping startblock is aligned. However, that is just the startblock within
> the AG, and the AG may not be properly aligned to the underlying block
> device atomic write limits.
> 
> As such, limit atomic writes to the greatest power-of-2 which fits in an
> AG, so that aligning to the startblock will be mean that we are also
> aligned to the disk block.

I don't understand this sentence -- what are we "aligning to the
startblock"?  I think you're saying that you want to limit the size of
untorn writes to the greatest power-of-two factor of the agsize so that
allocations for an untorn write will always be aligned compatibly with
the alignment requirements of the storage for an untorn write?

> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_iops.c  |  7 ++++++-
>  fs/xfs/xfs_mount.c | 28 ++++++++++++++++++++++++++++
>  fs/xfs/xfs_mount.h |  1 +
>  3 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index ea79fb246e33..95681d6c2bcd 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -606,12 +606,17 @@ xfs_get_atomic_write_attr(
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
> +	*unit_max =  min_t(unsigned int, XFS_FSB_TO_B(mp, mp->awu_max),
> +					target->bt_bdev_awu_max);
>  }
>  
>  static void
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index 477c5262cf91..4e60347f6b7e 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -651,6 +651,32 @@ xfs_agbtree_compute_maxlevels(
>  	levels = max(levels, mp->m_rmap_maxlevels);
>  	mp->m_agbtree_maxlevels = max(levels, mp->m_refc_maxlevels);
>  }
> +static inline void
> +xfs_mp_compute_awu_max(

xfs_compute_awu_max() ?

> +	struct xfs_mount	*mp)
> +{
> +	xfs_agblock_t		agsize = mp->m_sb.sb_agblocks;
> +	xfs_agblock_t		awu_max;
> +
> +	if (!xfs_has_reflink(mp)) {
> +		mp->awu_max = 1;
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
> +	mp->awu_max = awu_max;

I think you need two awu_maxes here -- one for the data device, and
another for the realtime device.  The rt computation is probably more
complex since I think it's the greatest power of two that fits in the rt
extent size if it isn't a power of two; or the greatest power of two
that fits in the rtgroup if rtgroups are enabled; or probably just no
limit otherwise.

--D

> +}
>  
>  /* Compute maximum possible height for realtime btree types for this fs. */
>  static inline void
> @@ -736,6 +762,8 @@ xfs_mountfs(
>  	xfs_agbtree_compute_maxlevels(mp);
>  	xfs_rtbtree_compute_maxlevels(mp);
>  
> +	xfs_mp_compute_awu_max(mp);
> +
>  	/*
>  	 * Check if sb_agblocks is aligned at stripe boundary.  If sb_agblocks
>  	 * is NOT aligned turn off m_dalign since allocator alignment is within
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index fbed172d6770..34286c87ac4a 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -198,6 +198,7 @@ typedef struct xfs_mount {
>  	bool			m_fail_unmount;
>  	bool			m_finobt_nores; /* no per-AG finobt resv. */
>  	bool			m_update_sb;	/* sb needs update in mount */
> +	xfs_extlen_t		awu_max;	/* max atomic write */
>  
>  	/*
>  	 * Bitsets of per-fs metadata that have been checked and/or are sick.
> -- 
> 2.31.1
> 
> 

