Return-Path: <linux-fsdevel+bounces-30389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E34298A9F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 18:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF435B24781
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 16:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0AC194083;
	Mon, 30 Sep 2024 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mM03pF5d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE8B19259E;
	Mon, 30 Sep 2024 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714237; cv=none; b=VOqkTWlQkAmBJCEWwKf9ezbe3U+bEitqVj5udKBEb9D8HHZfyRl+9oMuVIPrktu3Ea9rjYlbZQCR8GNt3FGzti2+4i9Qt5udpRpbWX0fFxwjgBInH9TCkwLS/xtzKZVL1T8fQbjOS0iwvFnXk6FtPSKKf87yfqyu8zytuUUXXnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714237; c=relaxed/simple;
	bh=cESMlB8bOxP6YQYQz9ns2JoLflIzTsoMs8uEgevMpBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gxb2M7VutGXMTPk+xq3J0nt7k2Vwo4RpspJyKuTyVylHtXey6mLjO/7OnDEReBKjX2xXR8MFz2kymKbUFr/WUgGoKIFvly/1zAiEaGKp9mWLZhI6+LRO+MU6hV/Cu+pJhmGg8VHn+E6f4ez5E3axv1XK8+YGybUNvX5LwzmA378=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mM03pF5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD05C4CEC7;
	Mon, 30 Sep 2024 16:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727714237;
	bh=cESMlB8bOxP6YQYQz9ns2JoLflIzTsoMs8uEgevMpBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mM03pF5dG9w9tHcqo+AJy7fNqcVXhfpS0NNAln5JGRS6navKUUxazwzrSoNCFV6Sc
	 k94u9pSu2T8AbIzIYXU/JYfxt187WD3RRKv1dv030+NJF8/exswraUKwuKozTqai4L
	 /tCLcqeOww3DtutSHeGJJtku9UGPrxUaBonXycR1k+5I3oSOOXrAX4PAy2Tz3tBjUm
	 F3Epv83anSimmijrpJVbm9yKX9BdiqqNNkUg5Vbhkl0guvOrrA9a3mkkO95jIORvLd
	 x1Q4aTbtbkxPFs6hPhLkc4QFSSwWJakina9UdA6Nbza8Oz294Ifz4TV3jTdN2twuMC
	 u0rlF4wehsh2w==
Date: Mon, 30 Sep 2024 09:37:16 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, dchinner@redhat.com, hch@lst.de, cem@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	hare@suse.de, martin.petersen@oracle.com,
	catherine.hoang@oracle.com, mcgrof@kernel.org,
	ritesh.list@gmail.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH v6 5/7] xfs: Support atomic write for statx
Message-ID: <20240930163716.GO21853@frogsfrogsfrogs>
References: <20240930125438.2501050-1-john.g.garry@oracle.com>
 <20240930125438.2501050-6-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930125438.2501050-6-john.g.garry@oracle.com>

On Mon, Sep 30, 2024 at 12:54:36PM +0000, John Garry wrote:
> Support providing info on atomic write unit min and max for an inode.
> 
> For simplicity, currently we limit the min at the FS block size. As for
> max, we limit also at FS block size, as there is no current method to
> guarantee extent alignment or granularity for regular files.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_inode.h | 17 +++++++++++++++++
>  fs/xfs/xfs_iops.c  | 24 ++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index 1c62ee294a5a..1ea73402d592 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -332,6 +332,23 @@ static inline bool xfs_inode_has_atomicwrites(struct xfs_inode *ip)
>  	return ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES;
>  }
>  
> +static inline bool
> +xfs_inode_can_atomicwrite(
> +	struct xfs_inode	*ip)
> +{
> +	struct xfs_mount	*mp = ip->i_mount;
> +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> +
> +	if (!xfs_inode_has_atomicwrites(ip))
> +		return false;
> +	if (mp->m_sb.sb_blocksize < target->bt_bdev_awu_min)
> +		return false;
> +	if (mp->m_sb.sb_blocksize > target->bt_bdev_awu_max)
> +		return false;
> +
> +	return true;
> +}
> +
>  /*
>   * In-core inode flags.
>   */
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index ee79cf161312..915d057db9bb 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -570,6 +570,23 @@ xfs_stat_blksize(
>  	return max_t(uint32_t, PAGE_SIZE, mp->m_sb.sb_blocksize);
>  }
>  
> +static void
> +xfs_get_atomic_write_attr(
> +	struct xfs_inode	*ip,
> +	unsigned int		*unit_min,
> +	unsigned int		*unit_max)
> +{
> +	struct xfs_mount	*mp = ip->i_mount;
> +	struct xfs_sb		*sbp = &mp->m_sb;
> +
> +	if (!xfs_inode_can_atomicwrite(ip)) {
> +		*unit_min = *unit_max = 0;
> +		return;
> +	}
> +
> +	*unit_min = *unit_max = sbp->sb_blocksize;

Ok, so we're only supporting untorn writes if they're exactly the fs
blocksize, and 1 fsblock is between awu_min/max.  That simplifies a lot
of things. :)

Not supporting sub-fsblock atomic writes means that we'll never hit the
directio COW fallback code, which uses the pagecache.

Not supporting multi-fsblock atomic writes means that you don't have to
figure out how to ensure that we always do cow on forcealign
granularity.  Though as I pointed out elsewhere in this thread, that's a
forcealign problem.

Yay! ;)

> +}
> +
>  STATIC int
>  xfs_vn_getattr(
>  	struct mnt_idmap	*idmap,
> @@ -643,6 +660,13 @@ xfs_vn_getattr(
>  			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
>  			stat->dio_offset_align = bdev_logical_block_size(bdev);
>  		}
> +		if (request_mask & STATX_WRITE_ATOMIC) {
> +			unsigned int unit_min, unit_max;
> +
> +			xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
> +			generic_fill_statx_atomic_writes(stat,
> +				unit_min, unit_max);

Consistent indenting and wrapping, please:

			xfs_get_atomic_write_attr(ip, &unit_min,
					&unit_max);
			generic_fill_statx_atomic_writes(stat,
					unit_min, unit_max);


With that fixed,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> +		}
>  		fallthrough;
>  	default:
>  		stat->blksize = xfs_stat_blksize(ip);
> -- 
> 2.31.1
> 
> 

