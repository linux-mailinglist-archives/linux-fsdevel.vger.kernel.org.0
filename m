Return-Path: <linux-fsdevel+bounces-47009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4C3A97BB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 02:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56BF0189FC6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 00:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769FA256C62;
	Wed, 23 Apr 2025 00:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ow7v5UA3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B156F2701BA;
	Wed, 23 Apr 2025 00:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745368704; cv=none; b=sDgo8ueWUHMGF05ilo+kegph2aiISCfgO3Wqgptz3tH8xuHH73BjtFp6Rif2W9LYAI3Bx8BcHYhwQjn/2JGrhrP0Tl0MYTy5gRB5VDb7as/9WCKF3Hfa0PnQXahHKAlPG6HJWjS514XyYDBKRkMkSje3ffjuBNqnDj9WTZOFPPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745368704; c=relaxed/simple;
	bh=GAvP7ZgHqWRFZdNovhTeJsx4VHpa/TNAyoNDl8z69bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6k9ahBsbU+YoMIUMmHSlUTPDjCd4V2TnrukU8Yz5p4A8UgSwWQCgVd48F2f39dASqF26f0qiRGvIhEaumsQjFjfWP8ZbBF6lg+csBwJ4IR3eb0ybvTGcGigpabmSiwNC0Ru1r/yWVBvC4Jlicg5aLa53WYmiJ8Dzn+fqeQ9HKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ow7v5UA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210A5C4CEE9;
	Wed, 23 Apr 2025 00:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745368704;
	bh=GAvP7ZgHqWRFZdNovhTeJsx4VHpa/TNAyoNDl8z69bY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ow7v5UA32dQxWVjm8s1HDy+NOhwB12mK76gAc/NBmLzaPgNNqVxlW7V9npGNd80Jh
	 Ub1BRz7qZrCQ69OaWvxFQZTfEbZeXkJCqnabaX4O4FZkjBCiEpROLz+UVjQBNMNLmn
	 Cxk3qB2+r1+61pzdS58nnK9SLnHMIky0+Jv8a+pMPT3Bot/zkox5cY4IzkE2i1ijNM
	 xdW6O7kPlh8oHzFtwXm4tQso295AVSLjnRlO3dS1PEzc6ECQCalU/akFfbFv63/jtI
	 hMZdUCHmsREdurfTkl9/CPA955b2v5r8iPvtWXJ9oZthMCDCcNhHaoEkcsUwNYk1nz
	 T41AYHcO1nFEA==
Date: Tue, 22 Apr 2025 17:38:23 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v8 05/15] xfs: ignore HW which cannot atomic write a
 single block
Message-ID: <20250423003823.GW25675@frogsfrogsfrogs>
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
 <20250422122739.2230121-6-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422122739.2230121-6-john.g.garry@oracle.com>

On Tue, Apr 22, 2025 at 12:27:29PM +0000, John Garry wrote:
> Currently only HW which can write at least 1x block is supported.
> 
> For supporting atomic writes > 1x block, a CoW-based method will also be
> used and this will not be resticted to using HW which can write >= 1x
> block.
> 
> However for deciding if HW-based atomic writes can be used, we need to
> start adding checks for write length < HW min, which complicates the code.
> Indeed, a statx field similar to unit_max_opt should also be added for this
> minimum, which is undesirable.
> 
> HW which can only write > 1x blocks would be uncommon and quite weird, so
> let's just not support it.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_inode.h | 17 ++++++++---------
>  fs/xfs/xfs_mount.c | 14 ++++++++++++++
>  fs/xfs/xfs_mount.h |  4 ++++
>  3 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index cff643cd03fc..725cd7c16a6e 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -355,20 +355,19 @@ static inline bool xfs_inode_has_bigrtalloc(const struct xfs_inode *ip)
>  #define xfs_inode_buftarg(ip) \
>  	(XFS_IS_REALTIME_INODE(ip) ? \
>  		(ip)->i_mount->m_rtdev_targp : (ip)->i_mount->m_ddev_targp)
> +/*
> + * Return max atomic write unit for a given inode.
> + */
> +#define xfs_inode_hw_atomicwrite_max(ip) \
> +	(XFS_IS_REALTIME_INODE(ip) ? \
> +		(ip)->i_mount->m_rt_awu_hw_max : \
> +		(ip)->i_mount->m_dd_awu_hw_max)
>  
>  static inline bool
>  xfs_inode_can_hw_atomicwrite(
>  	struct xfs_inode	*ip)
>  {
> -	struct xfs_mount	*mp = ip->i_mount;
> -	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> -
> -	if (mp->m_sb.sb_blocksize < target->bt_bdev_awu_min)
> -		return false;
> -	if (mp->m_sb.sb_blocksize > target->bt_bdev_awu_max)
> -		return false;
> -
> -	return true;
> +	return xfs_inode_hw_atomicwrite_max(ip);
>  }
>  
>  /*
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index 00b53f479ece..ee68c026e6cd 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -1082,6 +1082,20 @@ xfs_mountfs(
>  		xfs_zone_gc_start(mp);
>  	}
>  
> +	/*
> +	 * Set atomic write unit max for mp. Ignore devices which cannot atomic
> +	 * a single block, as they would be uncommon and more difficult to
> +	 * support.
> +	 */
> +	if (mp->m_ddev_targp->bt_bdev_awu_min <= mp->m_sb.sb_blocksize &&
> +	    mp->m_ddev_targp->bt_bdev_awu_max >= mp->m_sb.sb_blocksize)
> +		mp->m_dd_awu_hw_max = mp->m_ddev_targp->bt_bdev_awu_max;

If we don't want to use the device's atomic write capabilities due to
fsblock alignment problems, why not just zero out bt_bdev_awu_min/max?
That would cut down on the number of "awu" variables around the
codebase.

/*
 * Ignore hardware atomic writes if the device can't handle a single
 * fsblock for us.  Most devices set the min_awu to the LBA size, but
 * the spec allows for a functionality gap.
 */
static void
xfs_buftarg_reconcile_awu(
	struct xfs_buftarg	*btp)
{
	struct xfs_mount	*mp = btp->bt_mount;

	if (btp->bt_bdev_awu_min > mp->m_sb.sb_blocksize ||
	    btp->bt_bdev_awu_max < mp->m_sb.sb_blocksize) {
		btp->bt_bdev_awu_min = 0;
		btp->bt_bdev_awu_max = 0;
	}
}

	xfs_buftarg_reconcile_awu(mp->m_ddev_targp);
	if (mp->m_rtdev_targp)
		xfs_buftarg_reconcile_awu(mp->m_rtdev_targp);

Hrm?

--D

> +
> +	if (mp->m_rtdev_targp &&
> +	    mp->m_rtdev_targp->bt_bdev_awu_min <= mp->m_sb.sb_blocksize &&
> +	    mp->m_rtdev_targp->bt_bdev_awu_max >= mp->m_sb.sb_blocksize)
> +		mp->m_rt_awu_hw_max = mp->m_rtdev_targp->bt_bdev_awu_max;
> +
>  	return 0;
>  
>   out_agresv:
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index e5192c12e7ac..2819e160f0e9 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -231,6 +231,10 @@ typedef struct xfs_mount {
>  	unsigned int		m_max_open_zones;
>  	unsigned int		m_zonegc_low_space;
>  
> +	/* ddev and rtdev HW max atomic write size */
> +	unsigned int		m_dd_awu_hw_max;
> +	unsigned int		m_rt_awu_hw_max;
> +
>  	/*
>  	 * Bitsets of per-fs metadata that have been checked and/or are sick.
>  	 * Callers must hold m_sb_lock to access these two fields.
> -- 
> 2.31.1
> 
> 

