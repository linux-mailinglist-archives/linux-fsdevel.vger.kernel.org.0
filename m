Return-Path: <linux-fsdevel+bounces-46678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99B7A93A44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 18:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1883B1D4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 16:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239EB2147F7;
	Fri, 18 Apr 2025 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxsndsK7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A36F13FD86;
	Fri, 18 Apr 2025 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992155; cv=none; b=PFyP0AB7OZW2NpPEszq9St2kfRnWMvsLRDtfMGtegzM9M0KnF2RGYJeDwlbUIqieJb7S07XJ8ZW4M27vVZaCTfQSdcQEfaRTyq2oI+yq088Za9tUDKNHyiKlaiqjyXjAcSHsfi4isB0F54RtuzuH1V49Y88/nr9+xDY/+jN0KAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992155; c=relaxed/simple;
	bh=rKsF9PWrs8dZSiA87OFZvZCoTwD5UL7VWhc3BJxoJvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0wKOoSOPDPsjW0z+2OfTek76i8ny65F+iFxHqyX3bVWz4Mwtj8WkGNMv4JId/QEWsnMzI4RrT7eWOrb4CHrUTifNc5CDeDgaOrzAkt6gkqww/jnJFqoRM7XsNpYz7AxVigZCeI00r5QRCr8U5qMfuIBSK6iZmuMoZPCYMXQAmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxsndsK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4883C4CEE2;
	Fri, 18 Apr 2025 16:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744992155;
	bh=rKsF9PWrs8dZSiA87OFZvZCoTwD5UL7VWhc3BJxoJvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fxsndsK7R+LXbvT4VVl9fkCTCAbQ5G/Xcn5NsGLk7QjL/Bx7MiixnBeD5ozrXR5hQ
	 ceXuT/2ns4og7e1MwTlUdFOndkHpuOfS1LFscm6wO6AJb9ITRhAZl5fE1T7K9qTbjZ
	 s1JdIT44rzN/Mq97CAlBfaqtKWNuEsEMd+eTFA6vuhisFqG4lVTxoUfo0rGU6ZmnON
	 dZuh1nMXIV+tSlK2AykjjBeEpzSp+KCA0+zvZN4r2PrArEZOCl0Oq26MuPQWZ7BxIC
	 8Xagch7IU4BkRLviUkxsD82xW2i32kufSBeU9HhtpZD5gFw8JPUdRaL3agZ5P75KzW
	 3zIZi5aM91zmg==
Date: Fri, 18 Apr 2025 09:02:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-block <linux-block@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] block: fix race between set_blocksize and read paths
Message-ID: <20250418160234.GT25675@frogsfrogsfrogs>
References: <20250418155458.GR25675@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418155458.GR25675@frogsfrogsfrogs>

On Fri, Apr 18, 2025 at 08:54:58AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> With the new large sector size support, it's now the case that
> set_blocksize can change i_blksize and the folio order in a manner that
> conflicts with a concurrent reader and causes a kernel crash.
> 
> Specifically, let's say that udev-worker calls libblkid to detect the
> labels on a block device.  The read call can create an order-0 folio to
> read the first 4096 bytes from the disk.  But then udev is preempted.
> 
> Next, someone tries to mount an 8k-sectorsize filesystem from the same
> block device.  The filesystem calls set_blksize, which sets i_blksize to
> 8192 and the minimum folio order to 1.
> 
> Now udev resumes, still holding the order-0 folio it allocated.  It then
> tries to schedule a read bio and do_mpage_readahead tries to create
> bufferheads for the folio.  Unfortunately, blocks_per_folio == 0 because
> the page size is 4096 but the blocksize is 8192 so no bufferheads are
> attached and the bh walk never sets bdev.  We then submit the bio with a
> NULL block device and crash.
> 
> Therefore, truncate the page cache after flushing but before updating
> i_blksize.  However, that's not enough -- we also need to lock out file
> IO and page faults during the update.  Take both the i_rwsem and the
> invalidate_lock in exclusive mode for invalidations, and in shared mode
> for read/write operations.
> 
> I don't know if this is the correct fix, but xfs/259 found it.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

I think this could also have the tag:
Fixes: 3c20917120ce61 ("block/bdev: enable large folio support for large logical block sizes")

Not sure anyone cares about that for a fix for 6.15-rc1 though.

--D

> ---
>  block/bdev.c      |   17 +++++++++++++++++
>  block/blk-zoned.c |    5 ++++-
>  block/fops.c      |   16 ++++++++++++++++
>  block/ioctl.c     |    6 ++++++
>  4 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 7b4e35a661b0c9..1313ad256593c5 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -169,11 +169,28 @@ int set_blocksize(struct file *file, int size)
>  
>  	/* Don't change the size if it is same as current */
>  	if (inode->i_blkbits != blksize_bits(size)) {
> +		/*
> +		 * Flush and truncate the pagecache before we reconfigure the
> +		 * mapping geometry because folio sizes are variable now.  If a
> +		 * reader has already allocated a folio whose size is smaller
> +		 * than the new min_order but invokes readahead after the new
> +		 * min_order becomes visible, readahead will think there are
> +		 * "zero" blocks per folio and crash.  Take the inode and
> +		 * invalidation locks to avoid racing with
> +		 * read/write/fallocate.
> +		 */
> +		inode_lock(inode);
> +		filemap_invalidate_lock(inode->i_mapping);
> +
>  		sync_blockdev(bdev);
> +		kill_bdev(bdev);
> +
>  		inode->i_blkbits = blksize_bits(size);
>  		mapping_set_folio_order_range(inode->i_mapping,
>  				get_order(size), get_order(size));
>  		kill_bdev(bdev);
> +		filemap_invalidate_unlock(inode->i_mapping);
> +		inode_unlock(inode);
>  	}
>  	return 0;
>  }
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 0c77244a35c92e..8f15d1aa6eb89a 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -343,6 +343,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
>  		op = REQ_OP_ZONE_RESET;
>  
>  		/* Invalidate the page cache, including dirty pages. */
> +		inode_lock(bdev->bd_mapping->host);
>  		filemap_invalidate_lock(bdev->bd_mapping);
>  		ret = blkdev_truncate_zone_range(bdev, mode, &zrange);
>  		if (ret)
> @@ -364,8 +365,10 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
>  	ret = blkdev_zone_mgmt(bdev, op, zrange.sector, zrange.nr_sectors);
>  
>  fail:
> -	if (cmd == BLKRESETZONE)
> +	if (cmd == BLKRESETZONE) {
>  		filemap_invalidate_unlock(bdev->bd_mapping);
> +		inode_unlock(bdev->bd_mapping->host);
> +	}
>  
>  	return ret;
>  }
> diff --git a/block/fops.c b/block/fops.c
> index be9f1dbea9ce0a..e221fdcaa8aaf8 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -746,7 +746,14 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  			ret = direct_write_fallback(iocb, from, ret,
>  					blkdev_buffered_write(iocb, from));
>  	} else {
> +		/*
> +		 * Take i_rwsem and invalidate_lock to avoid racing with
> +		 * set_blocksize changing i_blkbits/folio order and punching
> +		 * out the pagecache.
> +		 */
> +		inode_lock_shared(bd_inode);
>  		ret = blkdev_buffered_write(iocb, from);
> +		inode_unlock_shared(bd_inode);
>  	}
>  
>  	if (ret > 0)
> @@ -757,6 +764,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  
>  static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
> +	struct inode *bd_inode = bdev_file_inode(iocb->ki_filp);
>  	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
>  	loff_t size = bdev_nr_bytes(bdev);
>  	loff_t pos = iocb->ki_pos;
> @@ -793,7 +801,13 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  			goto reexpand;
>  	}
>  
> +	/*
> +	 * Take i_rwsem and invalidate_lock to avoid racing with set_blocksize
> +	 * changing i_blkbits/folio order and punching out the pagecache.
> +	 */
> +	inode_lock_shared(bd_inode);
>  	ret = filemap_read(iocb, to, ret);
> +	inode_unlock_shared(bd_inode);
>  
>  reexpand:
>  	if (unlikely(shorted))
> @@ -836,6 +850,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  	if ((start | len) & (bdev_logical_block_size(bdev) - 1))
>  		return -EINVAL;
>  
> +	inode_lock(inode);
>  	filemap_invalidate_lock(inode->i_mapping);
>  
>  	/*
> @@ -868,6 +883,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  
>   fail:
>  	filemap_invalidate_unlock(inode->i_mapping);
> +	inode_unlock(inode);
>  	return error;
>  }
>  
> diff --git a/block/ioctl.c b/block/ioctl.c
> index faa40f383e2736..e472cc1030c60c 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -142,6 +142,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
>  	if (err)
>  		return err;
>  
> +	inode_lock(bdev->bd_mapping->host);
>  	filemap_invalidate_lock(bdev->bd_mapping);
>  	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
>  	if (err)
> @@ -174,6 +175,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
>  	blk_finish_plug(&plug);
>  fail:
>  	filemap_invalidate_unlock(bdev->bd_mapping);
> +	inode_unlock(bdev->bd_mapping->host);
>  	return err;
>  }
>  
> @@ -199,12 +201,14 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
>  	    end > bdev_nr_bytes(bdev))
>  		return -EINVAL;
>  
> +	inode_lock(bdev->bd_mapping->host);
>  	filemap_invalidate_lock(bdev->bd_mapping);
>  	err = truncate_bdev_range(bdev, mode, start, end - 1);
>  	if (!err)
>  		err = blkdev_issue_secure_erase(bdev, start >> 9, len >> 9,
>  						GFP_KERNEL);
>  	filemap_invalidate_unlock(bdev->bd_mapping);
> +	inode_unlock(bdev->bd_mapping->host);
>  	return err;
>  }
>  
> @@ -236,6 +240,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
>  		return -EINVAL;
>  
>  	/* Invalidate the page cache, including dirty pages */
> +	inode_lock(bdev->bd_mapping->host);
>  	filemap_invalidate_lock(bdev->bd_mapping);
>  	err = truncate_bdev_range(bdev, mode, start, end);
>  	if (err)
> @@ -246,6 +251,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
>  
>  fail:
>  	filemap_invalidate_unlock(bdev->bd_mapping);
> +	inode_unlock(bdev->bd_mapping->host);
>  	return err;
>  }
>  
> 

