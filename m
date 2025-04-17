Return-Path: <linux-fsdevel+bounces-46610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 549A4A91608
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 10:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD72B3BEE3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 08:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4936622D4C6;
	Thu, 17 Apr 2025 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOEr/KN/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EFB1B6D06;
	Thu, 17 Apr 2025 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876924; cv=none; b=sXwC5dxY/l+dPfkM8I2353QTOsMkDMYmiJSjAc6xEFjUSOsZa9ee9NMBH59zeMmSGzordR6Z+ZslfmD24SC6Wd8E5HAn99hi02A1/5T5jpUQjKlLC1oqwWOi4Irt1KMlg6qq8xekfCoMfTCQKHcxXuyRKFJtXKzQ7wsJdQ3SqbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876924; c=relaxed/simple;
	bh=ayAN08Bm4g5ox4VNX1e7+KagxJJYNP5njCHHYoS5M6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6R5iRaMmOnRG9NMtfJR//JVZMdLOUWdxhKMnd6ZEyXGyQdjNXy9q2wYg/zJ3Efd0JUXQu6emYpeugpgVIOmh6Quj3ThnRoFO4/RTk5GBP33nGfApAF1Mc6lS95TH3am1pKikGHdjTPpCpsVZa8M4J2Va0yXNLWzGJnc/ecwBaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOEr/KN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12879C4CEE4;
	Thu, 17 Apr 2025 08:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744876924;
	bh=ayAN08Bm4g5ox4VNX1e7+KagxJJYNP5njCHHYoS5M6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LOEr/KN/mKYDydI75nPMQvLCHY1rCw6o/ivR6ZSrGeS67RVhV1NGorDO56bvjxR7d
	 gkic7td6YLCCwopsJnKH8MSH2lAzRGHhWRTgGEVkgi/z0fv+4RLxNMbZXYviVeeNtN
	 oGjdhX53Qfe+8VJuFmpn8jjv0vg6lJcCoPu8BmkExeMZ+fF5FWFDagksGguaJAEvt9
	 zX0fcziKZGjg+u9MKI2OhDqIZdZY57sfLp+sVNAyyKxQ9k8qh/CSFR+cmJEW9/Vo2+
	 vF8uaIGZPEV3OEWyf83ScgpCZAVT5313P4XV/vnbv4/+PoOHGccpDqImpwIwTaLU89
	 yRJhW1OBDhSkg==
Date: Thu, 17 Apr 2025 10:01:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, axboe@kernel.dk, djwong@kernel.org, 
	ebiggers@google.com, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] fs: move the bdex_statx call to vfs_getattr_nosec
Message-ID: <20250417-holzkisten-galopp-1fcd34ad67b5@brauner>
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
> ---

This looks fine but one thing below.

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

bdev_statx()
-> blkdev_get_no_open()
   {
           if (!inode && IS_ENABLED(CONFIG_BLOCK_LEGACY_AUTOLOAD)) {
                blk_request_module(dev);
                inode = ilookup(blockdev_superblock, dev);
                if (inode)
                        pr_warn_ratelimited("block device autoloading is deprecated and will be removed.\n");
        }

   }

So that means any unprivileged Schmock can trigger a module autoload
from statx() if that's enabled? It feels like this should really be
disabled for statx().

