Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7DB03C9A4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 10:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240544AbhGOIQ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 04:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbhGOIQz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:16:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD5CC06175F;
        Thu, 15 Jul 2021 01:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=suXzxO6cbX7CcFdZPt4RSKyhqXWPJr81ArSQXJuj/SY=; b=GC/E/mRaZ2IYVBq+VNCLaV2D8+
        DKD8FgsKIo11d1Y9LpNlIpg8Ueu4MpUJPCC9QWtAARMkAE19OUfI4V+xvoVfRZ6nIRPX3/HQEcZlP
        J0Vjr7sX0QGukXbm2Wi9GPD5iLzQJlXHIXbyjPQm4pErNXmTBUuMKKJYRcO/sV2W8a8J+dgFRyW/G
        XE5/6EFyg85yv99/a81aQ6NZYXDd6fjT+MKyNKClbHiYly7LZDMTztzJOOuvai4ITNMGp9boAMYpH
        tdaoEyvXjau3Ha8WKZveGDvYbNyVYwPQzjMQYcAIHGRQrObTm9n3APNKigC6RGtcj+QfoM261WLFm
        YKdb7o9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3wVB-0006AS-Lv; Thu, 15 Jul 2021 08:13:49 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D31DA9867B3; Thu, 15 Jul 2021 10:13:48 +0200 (CEST)
Date:   Thu, 15 Jul 2021 10:13:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Hou Tao <houtao1@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        yukuai3@huawei.com, paulmck@kernel.org, will@kernel.org
Subject: Re: [PATCH] block: ensure the memory order between bi_private and
 bi_status
Message-ID: <20210715081348.GG2725@worktop.programming.kicks-ass.net>
References: <20210701113537.582120-1-houtao1@huawei.com>
 <20210715070148.GA8088@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715070148.GA8088@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 09:01:48AM +0200, Christoph Hellwig wrote:
> On Thu, Jul 01, 2021 at 07:35:37PM +0800, Hou Tao wrote:
> > When running stress test on null_blk under linux-4.19.y, the following
> > warning is reported:
> > 
> >   percpu_ref_switch_to_atomic_rcu: percpu ref (css_release) <= 0 (-3) after switching to atomic
> > 
> > The cause is that css_put() is invoked twice on the same bio as shown below:
> > 
> > CPU 1:                         CPU 2:
> > 
> > // IO completion kworker       // IO submit thread
> >                                __blkdev_direct_IO_simple
> >                                  submit_bio
> > 
> > bio_endio
> >   bio_uninit(bio)
> >     css_put(bi_css)
> >     bi_css = NULL
> >                                set_current_state(TASK_UNINTERRUPTIBLE)
> >   bio->bi_end_io
> >     blkdev_bio_end_io_simple
> >       bio->bi_private = NULL
> >                                // bi_private is NULL
> >                                READ_ONCE(bio->bi_private)
> >         wake_up_process
> >           smp_mb__after_spinlock
> > 
> >                                bio_unint(bio)
> >                                  // read bi_css as no-NULL
> >                                  // so call css_put() again
> >                                  css_put(bi_css)
> > 
> > Because there is no memory barriers between the reading and the writing of
> > bi_private and bi_css, so reading bi_private as NULL can not guarantee
> > bi_css will also be NULL on weak-memory model host (e.g, ARM64).
> > 
> > For the latest kernel source, css_put() has been removed from bio_unint(),
> > but the memory-order problem still exists, because the order between
> > bio->bi_private and {bi_status|bi_blkg} is also assumed in
> > __blkdev_direct_IO_simple(). It is reproducible that
> > __blkdev_direct_IO_simple() may read bi_status as 0 event if
> > bi_status is set as an errno in req_bio_endio().
> > 
> > In __blkdev_direct_IO(), the memory order between dio->waiter and
> > dio->bio.bi_status is not guaranteed neither. Until now it is unable to
> > reproduce it, maybe because dio->waiter and dio->bio.bi_status are
> > in the same cache-line. But it is better to add guarantee for memory
> > order.

Cachelines don't guarantee anything, you can get partial forwards.

> > Fixing it by using smp_load_acquire() & smp_store_release() to guarantee
> > the order between {bio->bi_private|dio->waiter} and {bi_status|bi_blkg}.
> > 
> > Fixes: 189ce2b9dcc3 ("block: fast-path for small and simple direct I/O requests")
> 
> This obviously does not look broken, but smp_load_acquire /
> smp_store_release is way beyond my paygrade.  Adding some CCs.

This block stuff is a bit beyond me, lets see if we can make sense of
it.

> > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > ---
> >  fs/block_dev.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/block_dev.c b/fs/block_dev.c
> > index eb34f5c357cf..a602c6315b0b 100644
> > --- a/fs/block_dev.c
> > +++ b/fs/block_dev.c
> > @@ -224,7 +224,11 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
> >  {
> >  	struct task_struct *waiter = bio->bi_private;
> >  
> > -	WRITE_ONCE(bio->bi_private, NULL);
> > +	/*
> > +	 * Paired with smp_load_acquire in __blkdev_direct_IO_simple()
> > +	 * to ensure the order between bi_private and bi_xxx
> > +	 */

This comment doesn't help me; where are the other stores? Presumably
somewhere before this is called, but how does one go about finding them?

The Changelog seems to suggest you only care about bi_css, not bi_xxx in
general. In specific you can only care about stores that happen before
this; is all of bi_xxx written before here? If not, you have to be more
specific.

Also, this being a clear, this very much isn't the typical publish
pattern.

On top of all that, smp_wmb() would be sufficient here and would be
cheaper on some platforms (ARM comes to mind).

> > +	smp_store_release(&bio->bi_private, NULL);
> >  	blk_wake_io_task(waiter);
> >  }
> >  
> > @@ -283,7 +287,8 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
> >  	qc = submit_bio(&bio);
> >  	for (;;) {
> >  		set_current_state(TASK_UNINTERRUPTIBLE);
> > -		if (!READ_ONCE(bio.bi_private))
> > +		/* Refer to comments in blkdev_bio_end_io_simple() */
> > +		if (!smp_load_acquire(&bio.bi_private))
> >  			break;
> >  		if (!(iocb->ki_flags & IOCB_HIPRI) ||
> >  		    !blk_poll(bdev_get_queue(bdev), qc, true))

That comment there doesn't help me find any relevant later loads and is
thus again inadequate.

Here the purpose seems to be to ensure the bi_css load happens after the
bi_private load, and this again is cheaper done using smp_rmb().

Also, the implication seems to be -- but is not spelled out anywhere --
that if bi_private is !NULL, it is stable.

> > @@ -353,7 +358,12 @@ static void blkdev_bio_end_io(struct bio *bio)
> >  		} else {
> >  			struct task_struct *waiter = dio->waiter;
> >  
> > -			WRITE_ONCE(dio->waiter, NULL);
> > +			/*
> > +			 * Paired with smp_load_acquire() in
> > +			 * __blkdev_direct_IO() to ensure the order between
> > +			 * dio->waiter and bio->bi_xxx
> > +			 */
> > +			smp_store_release(&dio->waiter, NULL);
> >  			blk_wake_io_task(waiter);
> >  		}
> >  	}
> > @@ -478,7 +488,8 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
> >  
> >  	for (;;) {
> >  		set_current_state(TASK_UNINTERRUPTIBLE);
> > -		if (!READ_ONCE(dio->waiter))
> > +		/* Refer to comments in blkdev_bio_end_io */
> > +		if (!smp_load_acquire(&dio->waiter))
> >  			break;
> >  
> >  		if (!(iocb->ki_flags & IOCB_HIPRI) ||

Idem for these...
