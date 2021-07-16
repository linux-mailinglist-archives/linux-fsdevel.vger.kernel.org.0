Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98533CB4FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 11:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbhGPJFb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 05:05:31 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:11325 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239151AbhGPJFa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 05:05:30 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GR4rq23mXz7tjj;
        Fri, 16 Jul 2021 16:58:03 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 17:02:34 +0800
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 17:02:33 +0800
Subject: Re: [PATCH] block: ensure the memory order between bi_private and
 bi_status
To:     Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <yukuai3@huawei.com>, <paulmck@kernel.org>, <will@kernel.org>
References: <20210701113537.582120-1-houtao1@huawei.com>
 <20210715070148.GA8088@lst.de>
 <20210715081348.GG2725@worktop.programming.kicks-ass.net>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <36a122ea-d18a-9317-aadd-b6b69a6f0283@huawei.com>
Date:   Fri, 16 Jul 2021 17:02:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210715081348.GG2725@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Peter,

On 7/15/2021 4:13 PM, Peter Zijlstra wrote:
> On Thu, Jul 15, 2021 at 09:01:48AM +0200, Christoph Hellwig wrote:
>> On Thu, Jul 01, 2021 at 07:35:37PM +0800, Hou Tao wrote:
>>> When running stress test on null_blk under linux-4.19.y, the following
>>> warning is reported:
>>>
>>>   percpu_ref_switch_to_atomic_rcu: percpu ref (css_release) <= 0 (-3) after switching to atomic
>>>
snip
>>> In __blkdev_direct_IO(), the memory order between dio->waiter and
>>> dio->bio.bi_status is not guaranteed neither. Until now it is unable to
>>> reproduce it, maybe because dio->waiter and dio->bio.bi_status are
>>> in the same cache-line. But it is better to add guarantee for memory
>>> order.
> Cachelines don't guarantee anything, you can get partial forwards.

Could you please point me to any reference ? I can not google

any memory order things by using "partial forwards".

>
>>> Fixing it by using smp_load_acquire() & smp_store_release() to guarantee
>>> the order between {bio->bi_private|dio->waiter} and {bi_status|bi_blkg}.
>>>
>>> Fixes: 189ce2b9dcc3 ("block: fast-path for small and simple direct I/O requests")
>> This obviously does not look broken, but smp_load_acquire /
>> smp_store_release is way beyond my paygrade.  Adding some CCs.
> This block stuff is a bit beyond me, lets see if we can make sense of
> it.
>
>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>> ---
>>>  fs/block_dev.c | 19 +++++++++++++++----
>>>  1 file changed, 15 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>>> index eb34f5c357cf..a602c6315b0b 100644
>>> --- a/fs/block_dev.c
>>> +++ b/fs/block_dev.c
>>> @@ -224,7 +224,11 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
>>>  {
>>>  	struct task_struct *waiter = bio->bi_private;
>>>  
>>> -	WRITE_ONCE(bio->bi_private, NULL);
>>> +	/*
>>> +	 * Paired with smp_load_acquire in __blkdev_direct_IO_simple()
>>> +	 * to ensure the order between bi_private and bi_xxx
>>> +	 */
> This comment doesn't help me; where are the other stores? Presumably
> somewhere before this is called, but how does one go about finding them?

Yes, the change log is vague and it will be corrected. The other stores

happen in req_bio_endio() and its callees when the request completes.

> The Changelog seems to suggest you only care about bi_css, not bi_xxx in
> general. In specific you can only care about stores that happen before
> this; is all of bi_xxx written before here? If not, you have to be more
> specific.

Actually we care about all bi_xxx which are written in req_bio_endio, and all writes

to bi_xxx happen before blkdev_bio_end_io_simple(). Here I just try to

use bi_status as one example.

> Also, this being a clear, this very much isn't the typical publish
> pattern.
>
> On top of all that, smp_wmb() would be sufficient here and would be
> cheaper on some platforms (ARM comes to mind).
Thanks for your knowledge, I will use smp_wmb() instead of smp_store_release().
>
>>> +	smp_store_release(&bio->bi_private, NULL);
>>>  	blk_wake_io_task(waiter);
>>>  }
>>>  
>>> @@ -283,7 +287,8 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
>>>  	qc = submit_bio(&bio);
>>>  	for (;;) {
>>>  		set_current_state(TASK_UNINTERRUPTIBLE);
>>> -		if (!READ_ONCE(bio.bi_private))
>>> +		/* Refer to comments in blkdev_bio_end_io_simple() */
>>> +		if (!smp_load_acquire(&bio.bi_private))
>>>  			break;
>>>  		if (!(iocb->ki_flags & IOCB_HIPRI) ||
>>>  		    !blk_poll(bdev_get_queue(bdev), qc, true))
> That comment there doesn't help me find any relevant later loads and is
> thus again inadequate.
>
> Here the purpose seems to be to ensure the bi_css load happens after the
> bi_private load, and this again is cheaper done using smp_rmb().
Yes and thanks again.
>
> Also, the implication seems to be -- but is not spelled out anywhere --
> that if bi_private is !NULL, it is stable.

What is the meaning of "it is stable" ? Do you mean if bi_private is NULL,

the values of bi_xxx should be ensured ?

>>> @@ -353,7 +358,12 @@ static void blkdev_bio_end_io(struct bio *bio)
>>>  		} else {
>>>  			struct task_struct *waiter = dio->waiter;
>>>  
>>> -			WRITE_ONCE(dio->waiter, NULL);
>>> +			/*
>>> +			 * Paired with smp_load_acquire() in
>>> +			 * __blkdev_direct_IO() to ensure the order between
>>> +			 * dio->waiter and bio->bi_xxx
>>> +			 */
>>> +			smp_store_release(&dio->waiter, NULL);
>>>  			blk_wake_io_task(waiter);
>>>  		}
>>>  	}
>>> @@ -478,7 +488,8 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>>>  
>>>  	for (;;) {
>>>  		set_current_state(TASK_UNINTERRUPTIBLE);
>>> -		if (!READ_ONCE(dio->waiter))
>>> +		/* Refer to comments in blkdev_bio_end_io */
>>> +		if (!smp_load_acquire(&dio->waiter))
>>>  			break;
>>>  
>>>  		if (!(iocb->ki_flags & IOCB_HIPRI) ||
> Idem for these...
> .

Thanks

Regards,

Tao

