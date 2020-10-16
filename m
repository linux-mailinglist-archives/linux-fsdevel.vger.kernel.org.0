Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0A22903B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 13:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395562AbgJPLCr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 07:02:47 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:58108 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395545AbgJPLCr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 07:02:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UCC3oqc_1602846164;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UCC3oqc_1602846164)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Oct 2020 19:02:45 +0800
Subject: Re: [PATCH v3 2/2] block,iomap: disable iopoll when split needed
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, hch@infradead.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        joseph.qi@linux.alibaba.com, xiaoguang.wang@linux.alibaba.com
References: <20201016091851.93728-1-jefflexu@linux.alibaba.com>
 <20201016091851.93728-3-jefflexu@linux.alibaba.com>
 <20201016102625.GA1218835@T590>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <d6d6b80b-6b16-637a-fac3-7f5a161b8f51@linux.alibaba.com>
Date:   Fri, 16 Oct 2020 19:02:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201016102625.GA1218835@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 10/16/20 6:26 PM, Ming Lei wrote:
> On Fri, Oct 16, 2020 at 05:18:51PM +0800, Jeffle Xu wrote:
>> Both blkdev fs and iomap-based fs (ext4, xfs, etc.) currently support
>> sync iopoll. One single bio can contain at most BIO_MAX_PAGES, i.e. 256
>> bio_vec. If the input iov_iter contains more than 256 segments, then
>> one dio will be split into multiple bios, which may cause potential
>> deadlock for sync iopoll.
>>
>> When it comes to sync iopoll, the bio is submitted without REQ_NOWAIT
>> flag set and the process may hang in blk_mq_get_tag() if the dio needs
>> to be split into multiple bios and thus can rapidly exhausts the queue
>> depth. The process has to wait for the completion of the previously
>> allocated requests, which should be reaped by the following sync
>> polling, and thus causing a deadlock.
>>
>> In fact there's a subtle difference of handling of HIPRI IO between
>> blkdev fs and iomap-based fs, when dio need to be split into multiple
>> bios. blkdev fs will set REQ_HIPRI for only the last split bio, leaving
>> the previous bios queued into normal hardware queues, and not causing
>> the trouble described above. iomap-based fs will set REQ_HIPRI for all
>> split bios, and thus may cause the potential deadlock decribed above.
>>
>> Thus disable iopoll when one dio need to be split into multiple bios.
>> Though blkdev fs may not suffer this issue, still it may not make much
>> sense to iopoll for big IO, since iopoll is initially for small size,
>> latency sensitive IO.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> ---
>>   fs/block_dev.c       | 7 +++++++
>>   fs/iomap/direct-io.c | 8 ++++++++
>>   2 files changed, 15 insertions(+)
>>
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index 9e84b1928b94..1b56b39e35b5 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -436,6 +436,13 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>>   			break;
>>   		}
>>   
>> +		/*
>> +		 * The current dio need to be split into multiple bios here.
>> +		 * iopoll is initially for small size, latency sensitive IO,
>> +		 * and thus disable iopoll if split needed.
>> +		 */
>> +		iocb->ki_flags &= ~IOCB_HIPRI;
>> +
> Not sure if it is good to clear IOCB_HIPRI of iocb, since it is usually
> maintained by upper layer code(io_uring, aio, ...) and we shouldn't
> touch this flag here.

If we queue bios into the DEFAULT hardware queue, but leaving the 
corresponding kiocb->ki_flags's

IOCB_HIPRI set (exactly what the first patch does), is this another
inconsistency?

Please consider the following code snippet from __blkdev_direct_IO()

```
	for (;;) {
		set_current_state(TASK_UNINTERRUPTIBLE);
		if (!READ_ONCE(dio->waiter))
			break;

		if (!(iocb->ki_flags & IOCB_HIPRI) ||
		    !blk_poll(bdev_get_queue(bdev), qc, true))
			blk_io_schedule();
	}
```

The IOCB_HIPRI flag is still set in iocb->ki_flags, but the corresponding
bios are queued into DEFAULT hardware queue since the first patch.
blk_poll() is still called in this case.


>
>>   		if (!dio->multi_bio) {
>>   			/*
>>   			 * AIO needs an extra reference to ensure the dio
>> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>> index c1aafb2ab990..46668cceefd2 100644
>> --- a/fs/iomap/direct-io.c
>> +++ b/fs/iomap/direct-io.c
>> @@ -308,6 +308,14 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>>   		copied += n;
>>   
>>   		nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
>> +		/*
>> +		 * The current dio need to be split into multiple bios here.
>> +		 * iopoll is initially for small size, latency sensitive IO,
>> +		 * and thus disable iopoll if split needed.
>> +		 */
>> +		if (nr_pages)
>> +			dio->iocb->ki_flags &= ~IOCB_HIPRI;
> Same concern as above.
>
> Thanks,
> Ming
