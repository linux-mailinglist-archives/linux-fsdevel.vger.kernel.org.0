Return-Path: <linux-fsdevel+bounces-21566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 857BC905CEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 22:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300BC1F22064
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 20:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D9F84DFE;
	Wed, 12 Jun 2024 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWWFMwJk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031F784D29;
	Wed, 12 Jun 2024 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718224827; cv=none; b=ooCQhX6ntPoBK2IjECfpjYchVPcUwrC1qr1v+M8pmW8LCuvOhLvrr5o4+sKU241E2u/SL48GH/HZoJ7qW9VYe8Q2hUtwJk6qGCJp8nN7N29x93zTGN6XxRpeH7nocnSuufe4/hGQlftK8awyJo8oGqG1ja1HIFfDnfkur57RDJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718224827; c=relaxed/simple;
	bh=SZUB4FY1/4Uc5DKQFanz8Q8mDAcnM64BMP2Z067yeq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3ikOxxHrPsoeDm33fsKeosPB3eCe3ZfUTEBe0hshBurFJTHu8jOU6ohl4jeqg4UQL2yY19gcxKe2LDI5f7q3tYdXMvBJjYnZ6R2jEgg9wlMHeHlUpDYNQBGEgRiiARid5mc5Js131w6gCOOENB4BermmKvq3NPDkwftMRGwwYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWWFMwJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924EAC116B1;
	Wed, 12 Jun 2024 20:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718224826;
	bh=SZUB4FY1/4Uc5DKQFanz8Q8mDAcnM64BMP2Z067yeq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oWWFMwJk0F9C3vPy/4z2yYg/eBLF+FDqdqcufPDLGeU8cFFPlTKiAs2n6JlGmxRD2
	 6oTW1oVv0iBpWPUT6/LJhqVwVwqtG3i9Vqa43TQ5Rj7n4LD9HHG0DYwUwJM471gczc
	 gnhRVFJ/gGVIrjBH8mzkO02ZGbaendNNx8ww597L6QIKrXVEjchj4S3icJ74AIHUSy
	 YaIkyj2jvGICtBcPxklwL4AVOJ+3aBNCwgqSFdv2mKNyfMxEQyIqLeNbZeB0riMtA8
	 zcj1Fm9Tc4/uBw2kZbker/r8V1tydETAnhQOKiLYmXyVOTpeFFUWiwEIRoq/8ObKCb
	 cK5S5yPFwZEwQ==
Date: Wed, 12 Jun 2024 13:40:25 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, chandan.babu@oracle.com, brauner@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org,
	linux-mm@kvack.org, hare@suse.de, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, Zi Yan <zi.yan@sent.com>,
	linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org, hch@lst.de, gost.dev@samsung.com,
	cl@os.amperecomputing.com, john.g.garry@oracle.com
Subject: Re: [PATCH v7 07/11] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <20240612204025.GI2764752@frogsfrogsfrogs>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-8-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607145902.1137853-8-kernel@pankajraghav.com>

On Fri, Jun 07, 2024 at 02:58:58PM +0000, Pankaj Raghav (Samsung) wrote:
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
> ---
>  fs/internal.h          |  5 +++++
>  fs/iomap/buffered-io.c |  6 ++++++
>  fs/iomap/direct-io.c   | 26 ++++++++++++++++++++++++--
>  3 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/internal.h b/fs/internal.h
> index 84f371193f74..30217f0ff4c6 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -35,6 +35,11 @@ static inline void bdev_cache_init(void)
>  int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
>  		get_block_t *get_block, const struct iomap *iomap);
>  
> +/*
> + * iomap/direct-io.c
> + */
> +int iomap_dio_init(void);
> +
>  /*
>   * char_dev.c
>   */
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 49938419fcc7..9f791db473e4 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1990,6 +1990,12 @@ EXPORT_SYMBOL_GPL(iomap_writepages);
>  
>  static int __init iomap_init(void)
>  {
> +	int ret;
> +
> +	ret = iomap_dio_init();
> +	if (ret)
> +		return ret;
> +
>  	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
>  			   offsetof(struct iomap_ioend, io_bio),
>  			   BIOSET_NEED_BVECS);
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index f3b43d223a46..b95600b254a3 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -27,6 +27,13 @@
>  #define IOMAP_DIO_WRITE		(1U << 30)
>  #define IOMAP_DIO_DIRTY		(1U << 31)
>  
> +/*
> + * Used for sub block zeroing in iomap_dio_zero()
> + */
> +#define ZERO_FSB_SIZE (65536)
> +#define ZERO_FSB_ORDER (get_order(ZERO_FSB_SIZE))
> +static struct page *zero_fs_block;

Er... zero_page_64k ?

Since it's a permanent allocation, can we also mark the memory ro?

> +
>  struct iomap_dio {
>  	struct kiocb		*iocb;
>  	const struct iomap_dio_ops *dops;
> @@ -52,6 +59,16 @@ struct iomap_dio {
>  	};
>  };
>  
> +int iomap_dio_init(void)
> +{
> +	zero_fs_block = alloc_pages(GFP_KERNEL | __GFP_ZERO, ZERO_FSB_ORDER);
> +
> +	if (!zero_fs_block)
> +		return -ENOMEM;
> +
> +	return 0;
> +}

Can't we just turn this into another fs_initcall() instead of exporting
it just so we can call it from iomap_init?  And maybe rename the
existing iomap_init to iomap_pagecache_init or something, for clarity's
sake?

--D

> +
>  static struct bio *iomap_dio_alloc_bio(const struct iomap_iter *iter,
>  		struct iomap_dio *dio, unsigned short nr_vecs, blk_opf_t opf)
>  {
> @@ -236,17 +253,22 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>  		loff_t pos, unsigned len)
>  {
>  	struct inode *inode = file_inode(dio->iocb->ki_filp);
> -	struct page *page = ZERO_PAGE(0);
>  	struct bio *bio;
>  
> +	/*
> +	 * Max block size supported is 64k
> +	 */
> +	WARN_ON_ONCE(len > ZERO_FSB_SIZE);
> +
>  	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
>  	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
>  				  GFP_KERNEL);
> +
>  	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
>  	bio->bi_private = dio;
>  	bio->bi_end_io = iomap_dio_bio_end_io;
>  
> -	__bio_add_page(bio, page, len, 0);
> +	__bio_add_page(bio, zero_fs_block, len, 0);
>  	iomap_dio_submit_bio(iter, dio, bio, pos);
>  }
>  
> -- 
> 2.44.1
> 
> 

