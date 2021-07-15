Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38E13C994F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 09:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbhGOHEo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 03:04:44 -0400
Received: from verein.lst.de ([213.95.11.211]:37518 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230310AbhGOHEo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 03:04:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6FD336736F; Thu, 15 Jul 2021 09:01:48 +0200 (CEST)
Date:   Thu, 15 Jul 2021 09:01:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        yukuai3@huawei.com, paulmck@kernel.org, will@kernel.org,
        peterz@infradead.org
Subject: Re: [PATCH] block: ensure the memory order between bi_private and
 bi_status
Message-ID: <20210715070148.GA8088@lst.de>
References: <20210701113537.582120-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701113537.582120-1-houtao1@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 01, 2021 at 07:35:37PM +0800, Hou Tao wrote:
> When running stress test on null_blk under linux-4.19.y, the following
> warning is reported:
> 
>   percpu_ref_switch_to_atomic_rcu: percpu ref (css_release) <= 0 (-3) after switching to atomic
> 
> The cause is that css_put() is invoked twice on the same bio as shown below:
> 
> CPU 1:                         CPU 2:
> 
> // IO completion kworker       // IO submit thread
>                                __blkdev_direct_IO_simple
>                                  submit_bio
> 
> bio_endio
>   bio_uninit(bio)
>     css_put(bi_css)
>     bi_css = NULL
>                                set_current_state(TASK_UNINTERRUPTIBLE)
>   bio->bi_end_io
>     blkdev_bio_end_io_simple
>       bio->bi_private = NULL
>                                // bi_private is NULL
>                                READ_ONCE(bio->bi_private)
>         wake_up_process
>           smp_mb__after_spinlock
> 
>                                bio_unint(bio)
>                                  // read bi_css as no-NULL
>                                  // so call css_put() again
>                                  css_put(bi_css)
> 
> Because there is no memory barriers between the reading and the writing of
> bi_private and bi_css, so reading bi_private as NULL can not guarantee
> bi_css will also be NULL on weak-memory model host (e.g, ARM64).
> 
> For the latest kernel source, css_put() has been removed from bio_unint(),
> but the memory-order problem still exists, because the order between
> bio->bi_private and {bi_status|bi_blkg} is also assumed in
> __blkdev_direct_IO_simple(). It is reproducible that
> __blkdev_direct_IO_simple() may read bi_status as 0 event if
> bi_status is set as an errno in req_bio_endio().
> 
> In __blkdev_direct_IO(), the memory order between dio->waiter and
> dio->bio.bi_status is not guaranteed neither. Until now it is unable to
> reproduce it, maybe because dio->waiter and dio->bio.bi_status are
> in the same cache-line. But it is better to add guarantee for memory
> order.
> 
> Fixing it by using smp_load_acquire() & smp_store_release() to guarantee
> the order between {bio->bi_private|dio->waiter} and {bi_status|bi_blkg}.
> 
> Fixes: 189ce2b9dcc3 ("block: fast-path for small and simple direct I/O requests")

This obviously does not look broken, but smp_load_acquire /
smp_store_release is way beyond my paygrade.  Adding some CCs.

> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  fs/block_dev.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index eb34f5c357cf..a602c6315b0b 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -224,7 +224,11 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
>  {
>  	struct task_struct *waiter = bio->bi_private;
>  
> -	WRITE_ONCE(bio->bi_private, NULL);
> +	/*
> +	 * Paired with smp_load_acquire in __blkdev_direct_IO_simple()
> +	 * to ensure the order between bi_private and bi_xxx
> +	 */
> +	smp_store_release(&bio->bi_private, NULL);
>  	blk_wake_io_task(waiter);
>  }
>  
> @@ -283,7 +287,8 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
>  	qc = submit_bio(&bio);
>  	for (;;) {
>  		set_current_state(TASK_UNINTERRUPTIBLE);
> -		if (!READ_ONCE(bio.bi_private))
> +		/* Refer to comments in blkdev_bio_end_io_simple() */
> +		if (!smp_load_acquire(&bio.bi_private))
>  			break;
>  		if (!(iocb->ki_flags & IOCB_HIPRI) ||
>  		    !blk_poll(bdev_get_queue(bdev), qc, true))
> @@ -353,7 +358,12 @@ static void blkdev_bio_end_io(struct bio *bio)
>  		} else {
>  			struct task_struct *waiter = dio->waiter;
>  
> -			WRITE_ONCE(dio->waiter, NULL);
> +			/*
> +			 * Paired with smp_load_acquire() in
> +			 * __blkdev_direct_IO() to ensure the order between
> +			 * dio->waiter and bio->bi_xxx
> +			 */
> +			smp_store_release(&dio->waiter, NULL);
>  			blk_wake_io_task(waiter);
>  		}
>  	}
> @@ -478,7 +488,8 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>  
>  	for (;;) {
>  		set_current_state(TASK_UNINTERRUPTIBLE);
> -		if (!READ_ONCE(dio->waiter))
> +		/* Refer to comments in blkdev_bio_end_io */
> +		if (!smp_load_acquire(&dio->waiter))
>  			break;
>  
>  		if (!(iocb->ki_flags & IOCB_HIPRI) ||
> -- 
> 2.29.2
---end quoted text---
