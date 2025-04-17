Return-Path: <linux-fsdevel+bounces-46632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23335A9228E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 18:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41EAC3AF655
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 16:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D23F25486F;
	Thu, 17 Apr 2025 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAv2Hcch"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE6E111A8;
	Thu, 17 Apr 2025 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744906830; cv=none; b=czBgtHno9Uwu+2CL+EPZ+uT/MogkyfWS//zR0BynMGFPZMAAw0AA+A8c4C9er3lbdySjFgMAcZivxICpT7G8+sTZCaIJPPah7fWhCPrJE5aM61n5pZx9Mg0aQ3DJ2W1E6HNGs97JK5FyJHGTRRzOctzW4gAh5h8prty89/a1GGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744906830; c=relaxed/simple;
	bh=kGndQ9NUqxvyRKeTtx7cf9T0tiiJ9o7q56mTnhwuY38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhNNrgA7CL0eQ4NiLaZXCGeZd0syhPj0eh2sDJ8v6aBOzuur9bs6m18p8Y6q4RMQx0NaEoDFERMxaoNMN2Ooi32g6Yhg7xjMw9wqJhDl28wabKuBm/VL+Gir3s7pSDpCCBKjXyketmBk8o3FGo40+v87uTslGkyrlx3GxDIlvQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAv2Hcch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF2BC4CEE4;
	Thu, 17 Apr 2025 16:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744906829;
	bh=kGndQ9NUqxvyRKeTtx7cf9T0tiiJ9o7q56mTnhwuY38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AAv2Hcch0w/nkdmVgq0WW7ED4hnPbw4zpThyNyUX9AnQ7t6Nk5mDnrm/BrbYeN5T5
	 ZlQDsNAsIlkD0LbOw8kJYiLPRTbGsGB8xNku1hAX7e/ptqudBlEZTW5r69eOvy7wpY
	 4N4TMdvVXgizbbnC3IkS0Dacxojc8TQAmukcztSQX4uBsJR6ztBgw19ryVhDJXHPcv
	 vjBnuAVmPWUI+/RLk15do932ejyxYdesTZ4zDa9K/IIbOBFh3vu7TV5VwohSuaA6xg
	 fTBgD5BAt2pbexf6l2GTz1CJGwPAChJBRbnOee8hn8cMAheaBS2pUtMujLdKIEaOf8
	 Vl2OZixdk5r/Q==
Date: Thu, 17 Apr 2025 09:20:29 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
	ebiggers@google.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] fs: move the bdex_statx call to vfs_getattr_nosec
Message-ID: <20250417162029.GH25659@frogsfrogsfrogs>
References: <20250417064042.712140-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250417064042.712140-1-hch@lst.de>

On Thu, Apr 17, 2025 at 08:40:42AM +0200, Christoph Hellwig wrote:
> Currently bdex_statx is only called from the very high-level
> vfs_statx_path function, and thus bypassing it for in-kernel calls
> to vfs_getattr or vfs_getattr_nosec.
> 
> This breaks querying the block ѕize of the underlying device in the
> loop driver and also is a pitfall for any other new kernel caller.
> 
> Move the call into the lowest level helper to ensure all callers get
> the right results.
> 
> Fixes: 2d985f8c6b91 ("vfs: support STATX_DIOALIGN on block devices")
> Fixes: f4774e92aab8 ("loop: take the file system minimum dio alignment into account")
> Reported-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This appears to solve the problem as well.

Tested-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  block/bdev.c           |  3 +--
>  fs/stat.c              | 32 ++++++++++++++++++--------------
>  include/linux/blkdev.h |  6 +++---
>  3 files changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 4844d1e27b6f..6a34179192c9 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -1272,8 +1272,7 @@ void sync_bdevs(bool wait)
>  /*
>   * Handle STATX_{DIOALIGN, WRITE_ATOMIC} for block devices.
>   */
> -void bdev_statx(struct path *path, struct kstat *stat,
> -		u32 request_mask)
> +void bdev_statx(const struct path *path, struct kstat *stat, u32 request_mask)
>  {
>  	struct inode *backing_inode;
>  	struct block_device *bdev;
> diff --git a/fs/stat.c b/fs/stat.c
> index f13308bfdc98..3d9222807214 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -204,12 +204,25 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
>  				  STATX_ATTR_DAX);
>  
>  	idmap = mnt_idmap(path->mnt);
> -	if (inode->i_op->getattr)
> -		return inode->i_op->getattr(idmap, path, stat,
> -					    request_mask,
> -					    query_flags);
> +	if (inode->i_op->getattr) {
> +		int ret;
> +
> +		ret = inode->i_op->getattr(idmap, path, stat, request_mask,
> +				query_flags);
> +		if (ret)
> +			return ret;
> +	} else {
> +		generic_fillattr(idmap, request_mask, inode, stat);
> +	}
> +
> +	/*
> +	 * If this is a block device inode, override the filesystem attributes
> +	 * with the block device specific parameters that need to be obtained
> +	 * from the bdev backing inode.
> +	 */
> +	if (S_ISBLK(stat->mode))
> +		bdev_statx(path, stat, request_mask);
>  
> -	generic_fillattr(idmap, request_mask, inode, stat);
>  	return 0;
>  }
>  EXPORT_SYMBOL(vfs_getattr_nosec);
> @@ -295,15 +308,6 @@ static int vfs_statx_path(struct path *path, int flags, struct kstat *stat,
>  	if (path_mounted(path))
>  		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
>  	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
> -
> -	/*
> -	 * If this is a block device inode, override the filesystem
> -	 * attributes with the block device specific parameters that need to be
> -	 * obtained from the bdev backing inode.
> -	 */
> -	if (S_ISBLK(stat->mode))
> -		bdev_statx(path, stat, request_mask);
> -
>  	return 0;
>  }
>  
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index e39c45bc0a97..678dc38442bf 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1685,7 +1685,7 @@ int sync_blockdev(struct block_device *bdev);
>  int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
>  int sync_blockdev_nowait(struct block_device *bdev);
>  void sync_bdevs(bool wait);
> -void bdev_statx(struct path *, struct kstat *, u32);
> +void bdev_statx(const struct path *path, struct kstat *stat, u32 request_mask);
>  void printk_all_partitions(void);
>  int __init early_lookup_bdev(const char *pathname, dev_t *dev);
>  #else
> @@ -1703,8 +1703,8 @@ static inline int sync_blockdev_nowait(struct block_device *bdev)
>  static inline void sync_bdevs(bool wait)
>  {
>  }
> -static inline void bdev_statx(struct path *path, struct kstat *stat,
> -				u32 request_mask)
> +static inline void bdev_statx(const struct path *path, struct kstat *stat,
> +		u32 request_mask)
>  {
>  }
>  static inline void printk_all_partitions(void)
> -- 
> 2.47.2
> 
> 

