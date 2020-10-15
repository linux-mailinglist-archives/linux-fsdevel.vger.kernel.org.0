Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72C928EEBD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 10:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388347AbgJOIr4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 04:47:56 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:48659 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388337AbgJOIr4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:47:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UC5WSMd_1602751672;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UC5WSMd_1602751672)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Oct 2020 16:47:52 +0800
Subject: Re: [v2 2/2] block,iomap: disable iopoll when split needed
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com, joseph.qi@linux.alibaba.com,
        xiaoguang.wang@linux.alibaba.com
References: <20201015074031.91380-1-jefflexu@linux.alibaba.com>
 <20201015074031.91380-3-jefflexu@linux.alibaba.com>
 <20201015075907.GB30117@infradead.org>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <8369fd5e-0675-c710-55f1-12c1f07f9aa4@linux.alibaba.com>
Date:   Thu, 15 Oct 2020 16:47:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201015075907.GB30117@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 10/15/20 3:59 PM, Christoph Hellwig wrote:
> On Thu, Oct 15, 2020 at 03:40:31PM +0800, Jeffle Xu wrote:
>> Both blkdev fs and iomap-based fs (ext4, xfs, etc.) currently support
>> sync iopoll. One single bio can contain at most BIO_MAX_PAGES, i.e. 256
>> bio_vec. If the input iov_iter contains more than 256 segments, then
>> the IO request described by this iov_iter will be split into multiple
>> bios, which may cause potential deadlock for sync iopoll.
>>
>> When it comes to sync iopoll, the bio is submitted without REQ_NOWAIT
>> flag set and the process may hang in blk_mq_get_tag() if the input
>> iov_iter has to be split into multiple bios and thus rapidly exhausts
>> the queue depth. The process has to wait for the completion of the
>> previously allocated requests, which should be done by the following
>> sync polling, and thus causing a deadlock.
>>
>> Actually there's subtle difference between the behaviour of handling
>> HIPRI IO of blkdev and iomap, when the input iov_iter need to split
>> into multiple bios. blkdev will set REQ_HIPRI for only the last split
>> bio, leaving the previous bio queued into normal hardware queues, which
>> will not cause the trouble described above though. iomap will set
>> REQ_HIPRI for all bios split from one iov_iter, and thus may cause the
>> potential deadlock decribed above.
>>
>> Disable iopoll when one request need to be split into multiple bios.
>> Though blkdev may not suffer the problem, still it may not make much
>> sense to iopoll for big IO, since iopoll is initially for small size,
>> latency sensitive IO.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> ---
>>   fs/block_dev.c       | 7 +++++++
>>   fs/iomap/direct-io.c | 9 ++++++++-
>>   2 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index 9e84b1928b94..a8a52cab15ab 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -491,6 +491,13 @@ blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>>   	if (is_sync_kiocb(iocb) && nr_pages <= BIO_MAX_PAGES)
>>   		return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
>>   
>> +	/*
>> +	 * IOpoll is initially for small size, latency sensitive IO.
>> +	 * Disable iopoll if split needed.
>> +	 */
>> +	if (nr_pages > BIO_MAX_PAGES)
>> +		iocb->ki_flags &= ~IOCB_HIPRI;
> more pages than BIO_MAX_PAGES don't imply a split because we can
> physically merge pages into a single vector (yes, BIO_MAX_PAGES is
> utterly misnamed now).
Sorry I missed it, though the flow may be sometimes misleading -.-||
