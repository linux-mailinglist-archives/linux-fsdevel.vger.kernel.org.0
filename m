Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14F13BE32A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 08:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhGGGcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 02:32:10 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6438 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhGGGcK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 02:32:10 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GKTvX24r4z78hl;
        Wed,  7 Jul 2021 14:26:00 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Jul 2021 14:29:27 +0800
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Jul 2021 14:29:27 +0800
Subject: Re: [PATCH] block: ensure the memory order between bi_private and
 bi_status
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>
CC:     <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <yukuai3@huawei.com>
References: <20210701113537.582120-1-houtao1@huawei.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <0fde8c5a-2c1d-4439-7c75-71fa120d3b62@huawei.com>
Date:   Wed, 7 Jul 2021 14:29:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210701113537.582120-1-houtao1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping ?

On 7/1/2021 7:35 PM, Hou Tao wrote:
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
