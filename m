Return-Path: <linux-fsdevel+bounces-26385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A20DD958D54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 19:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0AB286924
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 17:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D2F1C0DFE;
	Tue, 20 Aug 2024 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJlTUlzW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500981B8EAE;
	Tue, 20 Aug 2024 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174920; cv=none; b=tPEXPSvXTFjwZTSJhUNcpqvVo4Xf4GhCprxGHPz7ibC5GCyyWFp2HBv+hteuOLtLIVTW+JyEzNsKFU9xLrnI8dEKUk/1Z0JfCTMm/gOYbv6cc9DXujDSEP2kVCINLWmT5PmteS4hzpReKslHIN2dUS2n+oIZMYnPgWp1kpay360=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174920; c=relaxed/simple;
	bh=F+sx4QoPN53hJ2Psfkq3WkNMf0Xu9WTKhtrgYL8KAxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgxiFVZ+cPqHAU+w5SaBvtz9n1pnXX/UcGZdQqJeYOmp7B/8Eg+TDEBbavbky32jjKsn+O/HAJnvi2/OyBFuTHjNuW/DmHpuNhc3+/VFjxhBQwX6seNk8xXoW9n20MnbRUC7UaD0lwwsBaNAfedykldwSwc3gD99bStgrXC5/dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJlTUlzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3F2C4AF10;
	Tue, 20 Aug 2024 17:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724174919;
	bh=F+sx4QoPN53hJ2Psfkq3WkNMf0Xu9WTKhtrgYL8KAxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rJlTUlzW0vEnOQ6khAOr7j4Ezi8r4BlVc0vqH/Mc3ZQ5TJFMfG177Ikmh0aXMgxmW
	 NyVhy7mBzmtY6vqvtfGbEouwz+1cZlD7LqT978rnML0HoNIES3m+9diaeEKSXsXAuF
	 66uDl2pvtO73RWhYbqJJOrJr9rfRTxfVue0GCULak2H7/vIaemKuFHwD0oiacSFXKU
	 CA3WHSYd6o/fId9pTdzlb3lRxwGHyIIfiVGXSmfXg1N+LghZk53n5hp8vPOuZeOmTa
	 mTX7zxPRZVLkU3eX2xOGUuVgIuEl2PcBxpzpoFqAhk5ERKHU/R6pwrWB0cGwA7he1s
	 Rv+sSqN1Zvxuw==
Date: Tue, 20 Aug 2024 10:28:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, chandan.babu@oracle.com, dchinner@redhat.com,
	hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	martin.petersen@oracle.com, catherine.hoang@oracle.com,
	kbusch@kernel.org
Subject: Re: [PATCH v5 1/7] block/fs: Pass an iocb to
 generic_atomic_write_valid()
Message-ID: <20240820172839.GG6082@frogsfrogsfrogs>
References: <20240817094800.776408-1-john.g.garry@oracle.com>
 <20240817094800.776408-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817094800.776408-2-john.g.garry@oracle.com>

On Sat, Aug 17, 2024 at 09:47:54AM +0000, John Garry wrote:
> Darrick and Hannes thought it better that generic_atomic_write_valid()
> should be passed a struct iocb, and not just the member of that struct
> which is referenced; see [0] and [1].
> 
> I think that makes a more generic and clean API, so make that change.
> 
> [0] https://lore.kernel.org/linux-block/680ce641-729b-4150-b875-531a98657682@suse.de/
> [1] https://lore.kernel.org/linux-xfs/20240620212401.GA3058325@frogsfrogsfrogs/
> 
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Suggested-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Thanks for doing this,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  block/fops.c       | 8 ++++----
>  fs/read_write.c    | 4 ++--
>  include/linux/fs.h | 2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 9825c1713a49..1c0f9d313845 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -34,13 +34,13 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
>  	return opf;
>  }
>  
> -static bool blkdev_dio_invalid(struct block_device *bdev, loff_t pos,
> +static bool blkdev_dio_invalid(struct block_device *bdev, struct kiocb *iocb,
>  				struct iov_iter *iter, bool is_atomic)
>  {
> -	if (is_atomic && !generic_atomic_write_valid(iter, pos))
> +	if (is_atomic && !generic_atomic_write_valid(iocb, iter))
>  		return true;
>  
> -	return pos & (bdev_logical_block_size(bdev) - 1) ||
> +	return iocb->ki_pos & (bdev_logical_block_size(bdev) - 1) ||
>  		!bdev_iter_is_aligned(bdev, iter);
>  }
>  
> @@ -373,7 +373,7 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  	if (!iov_iter_count(iter))
>  		return 0;
>  
> -	if (blkdev_dio_invalid(bdev, iocb->ki_pos, iter, is_atomic))
> +	if (blkdev_dio_invalid(bdev, iocb, iter, is_atomic))
>  		return -EINVAL;
>  
>  	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 90e283b31ca1..d8af6f2f1c9a 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1737,7 +1737,7 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
>  	return 0;
>  }
>  
> -bool generic_atomic_write_valid(struct iov_iter *iter, loff_t pos)
> +bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
>  {
>  	size_t len = iov_iter_count(iter);
>  
> @@ -1747,7 +1747,7 @@ bool generic_atomic_write_valid(struct iov_iter *iter, loff_t pos)
>  	if (!is_power_of_2(len))
>  		return false;
>  
> -	if (!IS_ALIGNED(pos, len))
> +	if (!IS_ALIGNED(iocb->ki_pos, len))
>  		return false;
>  
>  	return true;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index fd34b5755c0b..55d8b6beac7a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3657,6 +3657,6 @@ static inline bool vfs_empty_path(int dfd, const char __user *path)
>  	return !c;
>  }
>  
> -bool generic_atomic_write_valid(struct iov_iter *iter, loff_t pos);
> +bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
>  
>  #endif /* _LINUX_FS_H */
> -- 
> 2.31.1
> 

