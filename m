Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638965322E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 08:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiEXGMv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 02:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiEXGMt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 02:12:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA666B031;
        Mon, 23 May 2022 23:12:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 245E968AFE; Tue, 24 May 2022 08:12:45 +0200 (CEST)
Date:   Tue, 24 May 2022 08:12:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 6/6] block: relax direct io memory alignment
Message-ID: <20220524061244.GF24737@lst.de>
References: <20220523210119.2500150-1-kbusch@fb.com> <20220523210119.2500150-7-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523210119.2500150-7-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 23, 2022 at 02:01:19PM -0700, Keith Busch wrote:
>   Removed iomap support for now

Do you plan to add a separate patch for it?  It would be a shame to
miss it especially as you said you already tested xfs.

> +	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
>  	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
>  	struct page **pages = (struct page **)bv;
>  	ssize_t size, left;
> @@ -1219,7 +1220,19 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
>  	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
>  
> +	/*
> +	 * Each segment in the iov is required to be a block size multiple.
> +	 * However, we may not be able to get the entire segment if it spans
> +	 * more pages than bi_max_vecs allows, so we have to ALIGN_DOWN the
> +	 * result to ensure the bio's total size is correct. The remainder of
> +	 * the iov data will be picked up in the next bio iteration.
> +	 *
> +	 * If the result is ever 0, that indicates the iov fails the segment
> +	 * size requirement and is an error.
> +	 */
>  	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> +	if (size > 0)
> +		size = ALIGN_DOWN(size, queue_logical_block_size(q));

I think we can simply use bdev_logical_block_size here and remove the need
for the q local variable.

Given that bio_iov_iter_get_pages is used by more than the block device
direct I/O code maybe split this up further?

> @@ -42,6 +42,16 @@ static unsigned int dio_bio_write_op(struct kiocb *iocb)
>  	return op;
>  }
>  
> +static int blkdev_dio_aligned(struct block_device *bdev, loff_t pos,
> +			      struct iov_iter *iter)
> +{
> +	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
> +		return -EINVAL;
> +	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
> +		return -EINVAL;
> +	return 0;
> +}

I'd also split adding this helper into another prep patch to see
the actual change in behavior more easily.
