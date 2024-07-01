Return-Path: <linux-fsdevel+bounces-22902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1166491EB64
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 01:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF9328230E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 23:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E51E172BC8;
	Mon,  1 Jul 2024 23:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdC8+mIJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945932F29;
	Mon,  1 Jul 2024 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877201; cv=none; b=j+ayWlZEuuH3RT0T0tEby3uhqgIVxfUhZ2ZqOLzavJhgiE93+hPbWEvanNRWD388wtAg0SRn4dTiPhrDrcpejHRDJNt7M8emEi7Z/hzmCJAd6zP3UNajGmrOifq7pDZa22ez9FtrtpI3wi9TUHLUqrrRwEydvGC2a0UxZtuRNfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877201; c=relaxed/simple;
	bh=DJGmP0BciHPC13P5upcN22pnyEHNrIh51O+wiRxUohA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kshTJNEvMJf2TR2qBGspNHKQEv4Egqg7eXs4NUtmHGtZFqy+FTa9hGNc/Tn5mBkmzUAHzmkCnT+mb94rMZ880igBSeVYq3irZzD/NR5DjXZk4ERvlX+PTNa5070QGGTbcGYMWZDthlwWiueVJ9zJ54CoyH16xXhS+R2JPw9yDjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdC8+mIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218A0C116B1;
	Mon,  1 Jul 2024 23:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719877201;
	bh=DJGmP0BciHPC13P5upcN22pnyEHNrIh51O+wiRxUohA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NdC8+mIJt7i0z7gm3/JuQGXIhy0tuZxP/LtRnNCXV95Uft45WQR4yjbKPZL3r8z+I
	 8pu71TSyHLkGSyZU90MvaHWL4IAwmhG8CRQ3wjEAvx9z4k4md4JCQUgpjUWLDK7uPL
	 znIZsnYybBFQeG27brhe10v3sGu0budiVQbRH7NpVoUFLpKDCKJbcvy3kY9b4dy7CP
	 Wp/4CX3Ox0dKBVn7OhkX3uZspklBZRu+InmZ1SMMZ+nvbtbZ4OjDGuIJSiv79FzqiW
	 qHolxm4QffMJ8gMC0wjnPNfs5ZlfUy/WfEEW0SeO0ruAdyatlu7mTevvdNh16bhzZi
	 F9ErAozJfncxg==
Date: Mon, 1 Jul 2024 16:40:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, willy@infradead.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 06/10] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <20240701234000.GH612460@frogsfrogsfrogs>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-7-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625114420.719014-7-kernel@pankajraghav.com>

On Tue, Jun 25, 2024 at 11:44:16AM +0000, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
> < fs block size. iomap_dio_zero() has an implicit assumption that fs block
> size < page_size. This is true for most filesystems at the moment.
> 
> If the block size > page size, this will send the contents of the page
> next to zero page(as len > PAGE_SIZE) to the underlying block device,
> causing FS corruption.
> 
> iomap is a generic infrastructure and it should not make any assumptions
> about the fs block size and the page size of the system.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Looks good to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c |  4 ++--
>  fs/iomap/direct-io.c   | 30 ++++++++++++++++++++++++++++--
>  2 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f420c53d86ac..9a9e94c7ed1d 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -2007,10 +2007,10 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
>  }
>  EXPORT_SYMBOL_GPL(iomap_writepages);
>  
> -static int __init iomap_init(void)
> +static int __init iomap_pagecache_init(void)
>  {
>  	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
>  			   offsetof(struct iomap_ioend, io_bio),
>  			   BIOSET_NEED_BVECS);
>  }
> -fs_initcall(iomap_init);
> +fs_initcall(iomap_pagecache_init);
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index f3b43d223a46..61d09d2364f7 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -11,6 +11,7 @@
>  #include <linux/iomap.h>
>  #include <linux/backing-dev.h>
>  #include <linux/uio.h>
> +#include <linux/set_memory.h>
>  #include <linux/task_io_accounting_ops.h>
>  #include "trace.h"
>  
> @@ -27,6 +28,13 @@
>  #define IOMAP_DIO_WRITE		(1U << 30)
>  #define IOMAP_DIO_DIRTY		(1U << 31)
>  
> +/*
> + * Used for sub block zeroing in iomap_dio_zero()
> + */
> +#define ZERO_PAGE_64K_SIZE (65536)
> +#define ZERO_PAGE_64K_ORDER (get_order(ZERO_PAGE_64K_SIZE))
> +static struct page *zero_page_64k;
> +
>  struct iomap_dio {
>  	struct kiocb		*iocb;
>  	const struct iomap_dio_ops *dops;
> @@ -236,9 +244,13 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>  		loff_t pos, unsigned len)
>  {
>  	struct inode *inode = file_inode(dio->iocb->ki_filp);
> -	struct page *page = ZERO_PAGE(0);
>  	struct bio *bio;
>  
> +	/*
> +	 * Max block size supported is 64k
> +	 */
> +	WARN_ON_ONCE(len > ZERO_PAGE_64K_SIZE);
> +
>  	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
>  	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
>  				  GFP_KERNEL);
> @@ -246,7 +258,7 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>  	bio->bi_private = dio;
>  	bio->bi_end_io = iomap_dio_bio_end_io;
>  
> -	__bio_add_page(bio, page, len, 0);
> +	__bio_add_page(bio, zero_page_64k, len, 0);
>  	iomap_dio_submit_bio(iter, dio, bio, pos);
>  }
>  
> @@ -753,3 +765,17 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	return iomap_dio_complete(dio);
>  }
>  EXPORT_SYMBOL_GPL(iomap_dio_rw);
> +
> +static int __init iomap_dio_init(void)
> +{
> +	zero_page_64k = alloc_pages(GFP_KERNEL | __GFP_ZERO,
> +				    ZERO_PAGE_64K_ORDER);
> +
> +	if (!zero_page_64k)
> +		return -ENOMEM;
> +
> +	set_memory_ro((unsigned long)page_address(zero_page_64k),
> +		      1U << ZERO_PAGE_64K_ORDER);
> +	return 0;
> +}
> +fs_initcall(iomap_dio_init);
> -- 
> 2.44.1
> 
> 

