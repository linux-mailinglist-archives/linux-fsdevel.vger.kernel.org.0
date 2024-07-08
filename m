Return-Path: <linux-fsdevel+bounces-23313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 808B092A885
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 19:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38A41C2123F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 17:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60CC149C4A;
	Mon,  8 Jul 2024 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJv9ohke"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099E3145B06;
	Mon,  8 Jul 2024 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461393; cv=none; b=aPdJjiOPMVjnyuYdkmcyPH4WOwBRR6Tll4x1Q7o0UU28HZtfCtOghTXV+q2EVicWQ4XEcp0BjKdCQdVhTbyJ6VjNdN+7r1jtHrf4NvdXfTgzKxvzF6CDCOTJmEVTteQbMdZzDHmuDadEnpPT2X/PRp6vo3uhJgTjV2yGlwry8rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461393; c=relaxed/simple;
	bh=ldSMonw09uowixZAG1w7HeV2XNqsw5Kv87tLzoOwdXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaCPu8VkHqSyiPKxyu29MVvXH3Ppdwxs0Jaaq5m5Y6aOi6laJDExQLXvoXQyMLvJqNeSa4APmek6FXqZHrkQzq4+iBXMkMJp8vHWYhsGOnDbw+58nCQbt/cF949Mi4E8z4/CgYe1GqwGg09acY7BlQY8iL7Gg/c1FCGTXrm3JLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJv9ohke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB550C116B1;
	Mon,  8 Jul 2024 17:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720461392;
	bh=ldSMonw09uowixZAG1w7HeV2XNqsw5Kv87tLzoOwdXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gJv9ohketiz/NpEQGPeC5qk/25+t69iW3iLJwpGL/37k69xJDPLpEfAxXmEzGHnzU
	 woca85oEUKtEpgCWuQmK6nVraDF+biAkOBoQxcS525F5qJJhtFBtXWN83HgtxkSymP
	 AU5BJlEdrXd8mSSE9sLbg/y9OVSbUy97jZVHMHmGXVKqdw+Q10uz916PoiaRDQrF3n
	 l4BBY1rU2u+JBGW7bT6a5IsmgQauUGSH/g6KsAnskUGQEBtlGJ/GCieaiJPSG1idlf
	 WIKkZob0AkBEIkWwMj4SNbk4ULHYUVMolsas5qwUyuNgUr5hhnh13pZiAnO7IY1gJs
	 5ml8sQtFz2/qQ==
Date: Mon, 8 Jul 2024 10:56:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, willy@infradead.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org,
	yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v9 06/10] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <20240708175632.GN612460@frogsfrogsfrogs>
References: <20240704112320.82104-1-kernel@pankajraghav.com>
 <20240704112320.82104-7-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704112320.82104-7-kernel@pankajraghav.com>

On Thu, Jul 04, 2024 at 11:23:16AM +0000, Pankaj Raghav (Samsung) wrote:
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
> ---
>  fs/iomap/buffered-io.c |  4 ++--
>  fs/iomap/direct-io.c   | 45 ++++++++++++++++++++++++++++++++++++------
>  2 files changed, 41 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f420c53d86acc..d745f718bcde8 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -2007,10 +2007,10 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
>  }
>  EXPORT_SYMBOL_GPL(iomap_writepages);
>  
> -static int __init iomap_init(void)
> +static int __init iomap_buffered_init(void)
>  {
>  	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
>  			   offsetof(struct iomap_ioend, io_bio),
>  			   BIOSET_NEED_BVECS);
>  }
> -fs_initcall(iomap_init);
> +fs_initcall(iomap_buffered_init);
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index f3b43d223a46e..c02b266bba525 100644
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
> +#define IOMAP_ZERO_PAGE_SIZE (SZ_64K)
> +#define IOMAP_ZERO_PAGE_ORDER (get_order(IOMAP_ZERO_PAGE_SIZE))
> +static struct page *zero_page;
> +
>  struct iomap_dio {
>  	struct kiocb		*iocb;
>  	const struct iomap_dio_ops *dops;
> @@ -232,13 +240,20 @@ void iomap_dio_bio_end_io(struct bio *bio)
>  }
>  EXPORT_SYMBOL_GPL(iomap_dio_bio_end_io);
>  
> -static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
> +static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>  		loff_t pos, unsigned len)
>  {
>  	struct inode *inode = file_inode(dio->iocb->ki_filp);
> -	struct page *page = ZERO_PAGE(0);
>  	struct bio *bio;
>  
> +	if (!len)
> +		return 0;
> +	/*
> +	 * Max block size supported is 64k
> +	 */
> +	if (WARN_ON_ONCE(len > IOMAP_ZERO_PAGE_SIZE))
> +		return -EINVAL;
> +
>  	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
>  	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
>  				  GFP_KERNEL);
> @@ -246,8 +261,9 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>  	bio->bi_private = dio;
>  	bio->bi_end_io = iomap_dio_bio_end_io;
>  
> -	__bio_add_page(bio, page, len, 0);
> +	__bio_add_page(bio, zero_page, len, 0);
>  	iomap_dio_submit_bio(iter, dio, bio, pos);
> +	return 0;
>  }
>  
>  /*
> @@ -356,8 +372,10 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	if (need_zeroout) {
>  		/* zero out from the start of the block to the write offset */
>  		pad = pos & (fs_block_size - 1);
> -		if (pad)
> -			iomap_dio_zero(iter, dio, pos - pad, pad);
> +
> +		ret = iomap_dio_zero(iter, dio, pos - pad, pad);
> +		if (ret)
> +			goto out;
>  	}
>  
>  	/*
> @@ -431,7 +449,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  		/* zero out from the end of the write to the end of the block */
>  		pad = pos & (fs_block_size - 1);
>  		if (pad)
> -			iomap_dio_zero(iter, dio, pos, fs_block_size - pad);
> +			ret = iomap_dio_zero(iter, dio, pos,
> +					     fs_block_size - pad);
>  	}
>  out:
>  	/* Undo iter limitation to current extent */
> @@ -753,3 +772,17 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	return iomap_dio_complete(dio);
>  }
>  EXPORT_SYMBOL_GPL(iomap_dio_rw);
> +
> +static int __init iomap_dio_init(void)
> +{
> +	zero_page = alloc_pages(GFP_KERNEL | __GFP_ZERO,
> +				IOMAP_ZERO_PAGE_ORDER);
> +
> +	if (!zero_page)
> +		return -ENOMEM;
> +
> +	set_memory_ro((unsigned long)page_address(zero_page),
> +		      1U << IOMAP_ZERO_PAGE_ORDER);
> +	return 0;
> +}
> +fs_initcall(iomap_dio_init);

This ^^^ could be refactored into a zeropage.ko module some day as a
separate patch to amortize the cost of the 64k buffer that never goes
away.

This patch looks ok though, so:
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> -- 
> 2.44.1
> 
> 

