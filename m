Return-Path: <linux-fsdevel+bounces-32137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B13CA9A12FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 21:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405691F26105
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 19:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF772215F5F;
	Wed, 16 Oct 2024 19:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOAotM9k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C87720605A;
	Wed, 16 Oct 2024 19:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729108626; cv=none; b=dZu7C1UY85xLMJWAyOdWzAbpVHk7NhQiG3hg0NAlrmkfL15Zh8TZwseoPlrmuDRFjKgNHAWzGo2GoyZZZr0G9xNrOUkK/iPG/OVFC0Y2RIz/EqisSFOGXRh0fRoVyFZdJihR8utFTz7iUpT10X3zD1jyd4EFJ8jq/NnRdBik4Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729108626; c=relaxed/simple;
	bh=XK0vsHUoYE5TeMTdnMkvGDa3GmUtnqn/BbD5ef1Q8W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNcpYUtIQXrqmCgV3GhFZRxrDwh46NQVgc00u2roQYXfsHPRT22LHxZr9urSGRsFsB1wO++FvF5prPcpiNooseDzvX8TaBi1PP4Zf5c3kCsL3VSHcIAaAE3PQcz//VzulKRDMVCesoyq/nu2B5iPnv+1Obn9qdyRNwsXJnr2dFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOAotM9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EEBC4CEC5;
	Wed, 16 Oct 2024 19:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729108625;
	bh=XK0vsHUoYE5TeMTdnMkvGDa3GmUtnqn/BbD5ef1Q8W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gOAotM9kVMO0qxulzQX32MRw4u7Qkvyke2ydb3RqqR7793BGtG6Kqkk+iVbwdKhJz
	 y37f3HZGuk2iFKjFePm5+cZkcvDAit0hTAfmObxjtxmnnDMp1AqAwCnt5lOxeeqwwD
	 OP3QXqLSdDD/Fcb90re8jfm/9ZTMKZ8UxjnzahR90C+cCQOJ6FHbqIPjSwwxfAk6Kw
	 aBlIC1kx8zmt4L7PXYUOb9mWRl4CLQxxpQXuJHSPYxWhHXKvY8jbacFxyNjjb2zvdj
	 uWZUM4UWqxb8B12YsfXjsvdHuoZs8AGq4CNEK74lqhvL17RNEIqMbMksNkzNuxWAAF
	 kBMyRbcHGFK1Q==
Date: Wed, 16 Oct 2024 12:57:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, dchinner@redhat.com, hch@lst.de, cem@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	hare@suse.de, martin.petersen@oracle.com,
	catherine.hoang@oracle.com, mcgrof@kernel.org,
	ritesh.list@gmail.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH v9 2/8] fs/block: Check for IOCB_DIRECT in
 generic_atomic_write_valid()
Message-ID: <20241016195705.GN21853@frogsfrogsfrogs>
References: <20241016100325.3534494-1-john.g.garry@oracle.com>
 <20241016100325.3534494-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016100325.3534494-3-john.g.garry@oracle.com>

On Wed, Oct 16, 2024 at 10:03:19AM +0000, John Garry wrote:
> Currently FMODE_CAN_ATOMIC_WRITE is set if the bdev can atomic write and
> the file is open for direct IO. This does not work if the file is not
> opened for direct IO, yet fcntl(O_DIRECT) is used on the fd later.
> 
> Change to check for direct IO on a per-IO basis in
> generic_atomic_write_valid(). Since we want to report -EOPNOTSUPP for
> non-direct IO for an atomic write, change to return an error code.
> 
> Relocate the block fops atomic write checks to the common write path, as to
> catch non-direct IO.
> 
> Fixes: c34fc6f26ab8 ("fs: Initial atomic write support")
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks good to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  block/fops.c       | 18 ++++++++++--------
>  fs/read_write.c    | 13 ++++++++-----
>  include/linux/fs.h |  2 +-
>  3 files changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 968b47b615c4..2d01c9007681 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -36,11 +36,8 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
>  }
>  
>  static bool blkdev_dio_invalid(struct block_device *bdev, struct kiocb *iocb,
> -				struct iov_iter *iter, bool is_atomic)
> +				struct iov_iter *iter)
>  {
> -	if (is_atomic && !generic_atomic_write_valid(iocb, iter))
> -		return true;
> -
>  	return iocb->ki_pos & (bdev_logical_block_size(bdev) - 1) ||
>  		!bdev_iter_is_aligned(bdev, iter);
>  }
> @@ -368,13 +365,12 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
>  static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  {
>  	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
> -	bool is_atomic = iocb->ki_flags & IOCB_ATOMIC;
>  	unsigned int nr_pages;
>  
>  	if (!iov_iter_count(iter))
>  		return 0;
>  
> -	if (blkdev_dio_invalid(bdev, iocb, iter, is_atomic))
> +	if (blkdev_dio_invalid(bdev, iocb, iter))
>  		return -EINVAL;
>  
>  	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
> @@ -383,7 +379,7 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  			return __blkdev_direct_IO_simple(iocb, iter, bdev,
>  							nr_pages);
>  		return __blkdev_direct_IO_async(iocb, iter, bdev, nr_pages);
> -	} else if (is_atomic) {
> +	} else if (iocb->ki_flags & IOCB_ATOMIC) {
>  		return -EINVAL;
>  	}
>  	return __blkdev_direct_IO(iocb, iter, bdev, bio_max_segs(nr_pages));
> @@ -625,7 +621,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
>  	if (!bdev)
>  		return -ENXIO;
>  
> -	if (bdev_can_atomic_write(bdev) && filp->f_flags & O_DIRECT)
> +	if (bdev_can_atomic_write(bdev))
>  		filp->f_mode |= FMODE_CAN_ATOMIC_WRITE;
>  
>  	ret = bdev_open(bdev, mode, filp->private_data, NULL, filp);
> @@ -700,6 +696,12 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	if ((iocb->ki_flags & (IOCB_NOWAIT | IOCB_DIRECT)) == IOCB_NOWAIT)
>  		return -EOPNOTSUPP;
>  
> +	if (iocb->ki_flags & IOCB_ATOMIC) {
> +		ret = generic_atomic_write_valid(iocb, from);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	size -= iocb->ki_pos;
>  	if (iov_iter_count(from) > size) {
>  		shorted = iov_iter_count(from) - size;
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 2c3263530828..befec0b5c537 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1830,18 +1830,21 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
>  	return 0;
>  }
>  
> -bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
> +int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
>  {
>  	size_t len = iov_iter_count(iter);
>  
>  	if (!iter_is_ubuf(iter))
> -		return false;
> +		return -EINVAL;
>  
>  	if (!is_power_of_2(len))
> -		return false;
> +		return -EINVAL;
>  
>  	if (!IS_ALIGNED(iocb->ki_pos, len))
> -		return false;
> +		return -EINVAL;
>  
> -	return true;
> +	if (!(iocb->ki_flags & IOCB_DIRECT))
> +		return -EOPNOTSUPP;
> +
> +	return 0;
>  }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index fbfa032d1d90..ba47fb283730 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3721,6 +3721,6 @@ static inline bool vfs_empty_path(int dfd, const char __user *path)
>  	return !c;
>  }
>  
> -bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
> +int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
>  
>  #endif /* _LINUX_FS_H */
> -- 
> 2.31.1
> 
> 

