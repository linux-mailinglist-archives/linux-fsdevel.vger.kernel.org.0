Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D1C52CD41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 09:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbiESHiS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 03:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiESHiQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 03:38:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035B25A08B;
        Thu, 19 May 2022 00:38:15 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5860A68AFE; Thu, 19 May 2022 09:38:11 +0200 (CEST)
Date:   Thu, 19 May 2022 09:38:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 3/3] block: relax direct io memory alignment
Message-ID: <20220519073811.GE22301@lst.de>
References: <20220518171131.3525293-1-kbusch@fb.com> <20220518171131.3525293-4-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518171131.3525293-4-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> @@ -1207,6 +1207,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  {
>  	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
>  	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
> +	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
>  	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
>  	struct page **pages = (struct page **)bv;
>  	bool same_page = false;
> @@ -1223,6 +1224,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
>  
>  	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> +	if (size > 0)
> +		size = ALIGN_DOWN(size, queue_logical_block_size(q));

So if we do get a size that is not logical block size alignment here,
we reduce it to the block size aligned one below.  Why do we do that?

> +	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
> +		return -EINVAL;
> +	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
>  		return -EINVAL;

Can we have a little inline helper for these checks instead of
duplicating them three times?

> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 840752006f60..64cc176be60c 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -1131,7 +1131,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  	struct dio_submit sdio = { 0, };
>  	struct buffer_head map_bh = { 0, };
>  	struct blk_plug plug;
> -	unsigned long align = offset | iov_iter_alignment(iter);
> +	unsigned long align = iov_iter_alignment(iter);

I'd much prefer to not just relax this for random file systems,
and especially not the legacy direct I/O code.  I think we can eventually
do iomap, but only after an audit and test of each file system, which
might require a new IOMAP_DIO_* flag at least initially.

> +static inline unsigned int bdev_dma_alignment(struct block_device *bdev)
> +{
> +	return queue_dma_alignment(bdev_get_queue(bdev));
> +}

Plase do this in a separate patch.
