Return-Path: <linux-fsdevel+bounces-42500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2190A42DF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C52189A16C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 20:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED98F245017;
	Mon, 24 Feb 2025 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fq1VY3Jj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4847B53BE;
	Mon, 24 Feb 2025 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429280; cv=none; b=BUGGOpVN9KCpBMIGREzB1gzTDfBi2wT11PVxmEbuyi4lKjRuZGmaEVLuzdG3njlNelf+J3zWYd3iGYBKCeSsIYYLC41evqJYKSkISNI4nQQgkijcdEfLv78+4I+3qkMH3D63YfJbMyj8/a0wPA45sNiVU1Hpa9CWFeOvz+34dBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429280; c=relaxed/simple;
	bh=OkOIAmiNS5JkHWp5A+/lqYYPSgryUahmnDVidue35Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLDbb2UYFAgu5DLW/NyMEwz3Tl+wO0ObUVVz+NJ+tfbFW6yqk2CsTA0t22xYrlsd2S56bE682eK4ETO10vig/tfT0TNV6LUcYetC2S7A/A8vXfN28Sz3fxxAEqi1rZ0G+Wf61rNIV4tsRxMQplg5HUvB5bE7kBTzPTSl8PjhqkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fq1VY3Jj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA94C4CED6;
	Mon, 24 Feb 2025 20:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740429279;
	bh=OkOIAmiNS5JkHWp5A+/lqYYPSgryUahmnDVidue35Os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fq1VY3JjsuyteXGzn/gcCxuJyRatKKHsnCTiFek1U+e8tZOk7fWPCNR+thyAVbp5Y
	 alXzPwLiUv6Sx5e5yP3GrLLB38AFNv43YOOqpcvx4nzBbS+HeSIbk/1NgHK6jO/NJk
	 ScqB3JbwnYAq8NZET0VbWH/sZAtf9IYH0qnOdRB+yZjnZc3cs5FxlWLqvedoEHXCnK
	 Z0L64EB06Gsvbft4drJzFiV2hB9MVKu9pEwLS5BEhN8qDwCGCNGEx5OZsyN/nnKKkJ
	 W/GUs9RJd1CBjixuuW4xv2mzyrQipA+yG5Arjxi9J25vwdptqI24ezpqqfEiWKOoAX
	 26pS/qAmOOPwA==
Date: Mon, 24 Feb 2025 12:34:39 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 10/11] xfs: Update atomic write max size
Message-ID: <20250224203439.GK21808@frogsfrogsfrogs>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-11-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213135619.1148432-11-john.g.garry@oracle.com>

On Thu, Feb 13, 2025 at 01:56:18PM +0000, John Garry wrote:
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
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_iops.c  | 13 ++++++++++++-
>  fs/xfs/xfs_iops.h  |  1 -
>  fs/xfs/xfs_mount.c | 28 ++++++++++++++++++++++++++++
>  fs/xfs/xfs_mount.h |  1 +
>  4 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index ea79fb246e33..d0a537696514 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -606,12 +606,23 @@ xfs_get_atomic_write_attr(
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
> +		*unit_max =  min_t(unsigned int, XFS_FSB_TO_B(mp, mp->awu_max),
> +					target->bt_bdev_awu_max);
> +	}
>  }
>  
>  static void
> diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
> index ce7bdeb9a79c..d95a543f3ab0 100644
> --- a/fs/xfs/xfs_iops.h
> +++ b/fs/xfs/xfs_iops.h
> @@ -22,5 +22,4 @@ extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
>  void xfs_get_atomic_write_attr(struct xfs_inode *ip,
>  		unsigned int *unit_min, unsigned int *unit_max);
>  
> -

No need to remove a blank line.

>  #endif /* __XFS_IOPS_H__ */
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index 477c5262cf91..af3ed135be4d 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -651,6 +651,32 @@ xfs_agbtree_compute_maxlevels(
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
> +}
>  
>  /* Compute maximum possible height for realtime btree types for this fs. */
>  static inline void
> @@ -736,6 +762,8 @@ xfs_mountfs(
>  	xfs_agbtree_compute_maxlevels(mp);
>  	xfs_rtbtree_compute_maxlevels(mp);
>  
> +	xfs_compute_awu_max(mp);
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

Might want to clarify that this is for the *data* device.

	/* max atomic write to datadev */

With those two things fixed,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  
>  	/*
>  	 * Bitsets of per-fs metadata that have been checked and/or are sick.
> -- 
> 2.31.1
> 
> 

