Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12B52BA715
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 11:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgKTKJb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 05:09:31 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:38480 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726334AbgKTKJa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:09:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0UFzUuLV_1605866968;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UFzUuLV_1605866968)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 20 Nov 2020 18:09:28 +0800
Subject: Fwd: Re: [PATCH v4 2/2] block,iomap: disable iopoll when split needed
References: <ed355fc8-6fc8-5ffd-f1e9-6ba19f761a09@linux.alibaba.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org
From:   JeffleXu <jefflexu@linux.alibaba.com>
X-Forwarded-Message-Id: <ed355fc8-6fc8-5ffd-f1e9-6ba19f761a09@linux.alibaba.com>
Message-ID: <7f78d262-81ef-a3ac-2076-1001f7c855a2@linux.alibaba.com>
Date:   Fri, 20 Nov 2020 18:09:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <ed355fc8-6fc8-5ffd-f1e9-6ba19f761a09@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org




-------- Forwarded Message --------
Subject: 	Re: [PATCH v4 2/2] block,iomap: disable iopoll when split needed
Date: 	Fri, 20 Nov 2020 18:06:54 +0800
From: 	JeffleXu <jefflexu@linux.alibaba.com>
To: 	Christoph Hellwig <hch@infradead.org>
CC: 	axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org, 
io-uring@vger.kernel.org, joseph.qi@linux.alibaba.com




On 11/20/20 1:55 AM, Christoph Hellwig wrote:
>> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>> index 933f234d5bec..396ac0f91a43 100644
>> --- a/fs/iomap/direct-io.c
>> +++ b/fs/iomap/direct-io.c
>> @@ -309,6 +309,16 @@ iomap_dio_bio_actor(struct inode *inode, loff_t 
>> pos, loff_t length,
>> copied += n;
>> nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
>> + /*
>> + * The current dio needs to be split into multiple bios here.
>> + * iopoll for split bio will cause subtle trouble such as
>> + * hang when doing sync polling, while iopoll is initially
>> + * for small size, latency sensitive IO. Thus disable iopoll
>> + * if split needed.
>> + */
>> + if (nr_pages)
>> + dio->iocb->ki_flags &= ~IOCB_HIPRI;
> I think this is confusing two things.

Indeed there's two level of split concerning this issue when doing sync 
iopoll.


The first is that one bio got split in block-core, and patch 1 of this 
patch set just fixes this.


Second is that one dio got split into multiple bios in fs layer, and 
patch 2 fixes this.


> One is that we don't handle
> polling well when there are multiple bios. For this I think we should
> only call bio_set_polled when we know there is a single bio.


How about the following patch:


--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -60,12 +60,12 @@ int iomap_dio_iopoll(struct kiocb *kiocb, bool spin)
  EXPORT_SYMBOL_GPL(iomap_dio_iopoll);

  static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap 
*iomap,
-               struct bio *bio, loff_t pos)
+               struct bio *bio, loff_t pos, bool split)
  {
         atomic_inc(&dio->ref);

         if (dio->iocb->ki_flags & IOCB_HIPRI)
-               bio_set_polled(bio, dio->iocb);
+               bio_set_polled(bio, dio->iocb, split);

         dio->submit.last_queue = bdev_get_queue(iomap->bdev);
         if (dio->dops && dio->dops->submit_io)
@@ -214,6 +214,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, 
loff_t length,
         int nr_pages, ret = 0;
         size_t copied = 0;
         size_t orig_count;
+       bool split = false;

         if ((pos | length | align) & ((1 << blkbits) - 1))
                 return -EINVAL;
@@ -309,7 +310,17 @@ iomap_dio_bio_actor(struct inode *inode, loff_t 
pos, loff_t length,
                 copied += n;

                 nr_pages = iov_iter_npages(dio->submit.iter, 
BIO_MAX_PAGES);
-               iomap_dio_submit_bio(dio, iomap, bio, pos);
+               /*
+                * The current dio needs to be split into multiple bios 
here.
+                * iopoll for split bio will cause subtle trouble such as
+                * hang when doing sync polling, while iopoll is initially
+                * for small size, latency sensitive IO. Thus disable iopoll
+                * if split needed.
+                */
+               if (nr_pages)
+                       split = true;
+
+               iomap_dio_submit_bio(dio, iomap, bio, pos, split);
                 pos += n;
         } while (nr_pages);

diff --git a/include/linux/bio.h b/include/linux/bio.h
index c6d765382926..21f772f98878 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -806,9 +806,11 @@ static inline int bio_integrity_add_page(struct bio 
*bio, struct page *page,
   * must be found by the caller. This is different than IRQ driven IO, 
where
   * it's safe to wait for IO to complete.
   */
-static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
+static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb, 
bool split)
  {
-       bio->bi_opf |= REQ_HIPRI;
+       if (!split)
+               bio->bi_opf |= REQ_HIPRI;
+
         if (!is_sync_kiocb(kiocb))
                 bio->bi_opf |= REQ_NOWAIT;
  }


After this patch, bio will be polled only one dio maps to one single bio.

Noted that this change applies to both sync and async IO, though async 
routine doesn't

suffer the hang described in this patch set. Since the performance gain 
of iopoll may be

trivial when one dio got split, also disable iopoll for async routine.


We need keep REQ_NOWAIT for async routine even when the dio split happened,

because io_uring doesn't expect blocking. Though the original REQ_NOWAIT

should gets from iocb->ki_flags & IOCB_NOWAIT. Currently iomap doesn't 
inherit

bio->bi_opf's REQ_NOWAIT from iocb->ki_flags's IOCB_NOWAI. This bug should

be fixed by 
https://lore.kernel.org/linux-fsdevel/1605685931-207023-1-git-send-email-haoxu@linux.alibaba.com/T/#t


Maybe we could include this fix (of missing inheritance of IOCB_NOWAI) 
into this patch

set and then refactor the fix I mentioned in this patch?


>   But it
> has nothing to do with a bio being split, as we can't know that at this
> level.


-- 
Thanks,
Jeffle

