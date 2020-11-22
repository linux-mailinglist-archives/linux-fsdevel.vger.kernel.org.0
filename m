Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9862BC5B6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Nov 2020 13:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgKVMs5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Nov 2020 07:48:57 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:56211 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727646AbgKVMs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Nov 2020 07:48:56 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UG8TG-P_1606049331;
Received: from B-25KNML85-0107.local(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UG8TG-P_1606049331)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 22 Nov 2020 20:48:51 +0800
Subject: Re: [RFC v2] iomap: set REQ_NOWAIT according to IOCB_NOWAIT in Direct
 IO
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org,
        Joseph Qi <joseph.qi@linux.alibaba.com>
References: <1605697916-47833-1-git-send-email-haoxu@linux.alibaba.com>
 <1605700276-113264-1-git-send-email-haoxu@linux.alibaba.com>
Message-ID: <3ddd2592-4487-59ff-f44f-682929e1464e@linux.alibaba.com>
Date:   Sun, 22 Nov 2020 20:48:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1605700276-113264-1-git-send-email-haoxu@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ÔÚ 2020/11/18 ÏÂÎç7:51, Hao Xu Ð´µÀ:
> Currently, IOCB_NOWAIT is ignored in Direct IO, REQ_NOWAIT is only set
> when IOCB_HIPRI is set. But REQ_NOWAIT should be set as well when
> IOCB_NOWAIT is set.
> 
> Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
> ---
> 
> Hi all,
> I tested fio io_uring direct read for a file on ext4 filesystem on a
> nvme ssd. I found that IOCB_NOWAIT is ignored in iomap layer, which
> means REQ_NOWAIT is not set in bio->bi_opf. This makes nowait IO a
> normal IO. Since I'm new to iomap and block layer, I sincerely ask
> yours opinions in case I misunderstand the code which is very likely
> to happen.:)
> 
> v1->v2:
> * add same logic in __blkdev_direct_IO_simple()
> 
>   fs/block_dev.c       | 7 +++++++
>   fs/iomap/direct-io.c | 3 +++
>   2 files changed, 10 insertions(+)
> 
ping...
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 9e84b1928b94..f3e9e13a9a9f 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -263,6 +263,10 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
>   	 	bio.bi_opf = dio_bio_write_op(iocb);
>   		task_io_account_write(ret);
>   	}
> +
> +	if (iocb->ki_flags & IOCB_NOWAIT)
> +		bio.bi_opf |= REQ_NOWAIT;
> +
>   	if (iocb->ki_flags & IOCB_HIPRI)
>   		bio_set_polled(&bio, iocb);
>   
> @@ -424,6 +428,9 @@ static void blkdev_bio_end_io(struct bio *bio)
>   		if (!nr_pages) {
>   			bool polled = false;
>   
> +			if (iocb->ki_flags & IOCB_NOWAIT)
> +				bio->bi_opf |= REQ_NOWAIT;
> +
>   			if (iocb->ki_flags & IOCB_HIPRI) {
>   				bio_set_polled(bio, iocb);
>   				polled = true;
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 933f234d5bec..2e897688ed6d 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -64,6 +64,9 @@ static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
>   {
>   	atomic_inc(&dio->ref);
>   
> +	if (dio->iocb->ki_flags & IOCB_NOWAIT)
> +		bio->bi_opf |= REQ_NOWAIT;
> +
>   	if (dio->iocb->ki_flags & IOCB_HIPRI)
>   		bio_set_polled(bio, dio->iocb);
>   
> 
