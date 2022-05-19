Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09A752D59D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 16:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbiESOJA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 10:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiESOIz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 10:08:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B70060DBA;
        Thu, 19 May 2022 07:08:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 389A5617A0;
        Thu, 19 May 2022 14:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F99C385AA;
        Thu, 19 May 2022 14:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652969333;
        bh=cIz9ylPMqTUiF2eYj7i2itqIUYlRxKNFo38o35wZA34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tsOTJYWH/y6RjHoqDXpS0TGVB/PM4LRNHjQi/urdfTJ7MI1S16GcB2Njao+htcL5y
         QCUTFJg6pNsSucBSn3RIyv/fV4F03rKaM1lFyDjFuFLeG18JqU40/Q7Ia7VFBftK0s
         Rt1PGIHgTnmsg1TmSoSQE79EK1UAzdKTcR6Eq01LLOSpCmYewmzwWXQrdO+I9poVLM
         7dbRjgfV+fGDKxRUdhyjiKFWNOZRpZmJnnOk++vQtcHT2GlfEVOn+roLtrkhfcp3EJ
         8F4fiJ+cNFpYij6+BVXUT69oPd0ZhVqjD32bx3hcpR/yqg6WD1+7JgfYX/gpiK8Op9
         vfRv+aEhDr9AQ==
Date:   Thu, 19 May 2022 08:08:50 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, bvanassche@acm.org,
        damien.lemoal@opensource.wdc.com
Subject: Re: [PATCHv2 3/3] block: relax direct io memory alignment
Message-ID: <YoZPcqDpwSTn/csn@kbusch-mbp>
References: <20220518171131.3525293-1-kbusch@fb.com>
 <20220518171131.3525293-4-kbusch@fb.com>
 <20220519073811.GE22301@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519073811.GE22301@lst.de>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 09:38:11AM +0200, Christoph Hellwig wrote:
> > @@ -1207,6 +1207,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> >  {
> >  	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
> >  	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
> > +	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
> >  	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
> >  	struct page **pages = (struct page **)bv;
> >  	bool same_page = false;
> > @@ -1223,6 +1224,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> >  	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
> >  
> >  	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> > +	if (size > 0)
> > +		size = ALIGN_DOWN(size, queue_logical_block_size(q));
> 
> So if we do get a size that is not logical block size alignment here,
> we reduce it to the block size aligned one below.  Why do we do that?

There are two possibilities:

In the first case, the number of pages in this iteration exceeds bi_max_vecs.
Rounding down completes the bio with a block aligned size, and the remainder
will be picked up for the next bio, or possibly even the current bio if the
pages are sufficiently physically contiguous.

The other case is a bad iov. If we're doing __blkdev_direct_IO(), it will error
out immediately if the rounded size is 0, or the next iteration when the next
size is rounded to 0. If we're doing the __blkdev_direct_IO_simple(), it will
error out when it sees the iov hasn't advanced to the end.

And ... I just noticed I missed the size check __blkdev_direct_IO_async().
 
> > +	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
> > +		return -EINVAL;
> > +	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
> >  		return -EINVAL;
> 
> Can we have a little inline helper for these checks instead of
> duplicating them three times?

Absolutely.

> > diff --git a/fs/direct-io.c b/fs/direct-io.c
> > index 840752006f60..64cc176be60c 100644
> > --- a/fs/direct-io.c
> > +++ b/fs/direct-io.c
> > @@ -1131,7 +1131,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
> >  	struct dio_submit sdio = { 0, };
> >  	struct buffer_head map_bh = { 0, };
> >  	struct blk_plug plug;
> > -	unsigned long align = offset | iov_iter_alignment(iter);
> > +	unsigned long align = iov_iter_alignment(iter);
> 
> I'd much prefer to not just relax this for random file systems,
> and especially not the legacy direct I/O code.  I think we can eventually
> do iomap, but only after an audit and test of each file system, which
> might require a new IOMAP_DIO_* flag at least initially.

I did some testing with xfs, but I can certainly run more a lot more tests. I
do think filesystem support for this capability is important, so I hope we
eventually get there.
