Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD79443D92
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 08:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhKCHOH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 03:14:07 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:14705 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhKCHOG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 03:14:06 -0400
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HkdDd2flkzZcSr;
        Wed,  3 Nov 2021 15:09:21 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by dggeme756-chm.china.huawei.com
 (10.3.19.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Wed, 3
 Nov 2021 15:11:25 +0800
Subject: Re: [PATCH 14/16] block: switch polling to be bio based
To:     Christoph Hellwig <hch@lst.de>
References: <20211012111226.760968-1-hch@lst.de>
 <20211012111226.760968-15-hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <beb633f4-4508-ea53-4a34-adf0f20cda85@hisilicon.com>
Date:   Wed, 3 Nov 2021 15:11:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20211012111226.760968-15-hch@lst.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,


ÔÚ 2021/10/12 19:12, Christoph Hellwig Ð´µÀ:
> Replace the blk_poll interface that requires the caller to keep a queue
> and cookie from the submissions with polling based on the bio.
>
> Polling for the bio itself leads to a few advantages:
>
>   - the cookie construction can made entirely private in blk-mq.c
>   - the caller does not need to remember the request_queue and cookie
>     separately and thus sidesteps their lifetime issues
>   - keeping the device and the cookie inside the bio allows to trivially
>     support polling BIOs remapping by stacking drivers
>   - a lot of code to propagate the cookie back up the submission path can
>     be removed entirely.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
> ---
......
>   /**
>    * blk_cloned_rq_check_limits - Helper function to check a cloned request
>    *                              for the new queue limits
> diff --git a/block/blk-exec.c b/block/blk-exec.c
> index 1fa7f25e57262..55f0cd34b37b9 100644
> --- a/block/blk-exec.c
> +++ b/block/blk-exec.c
> @@ -65,13 +65,19 @@ EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
>   
>   static bool blk_rq_is_poll(struct request *rq)
>   {
> -	return rq->mq_hctx && rq->mq_hctx->type == HCTX_TYPE_POLL;
> +	if (!rq->mq_hctx)
> +		return false;
> +	if (rq->mq_hctx->type != HCTX_TYPE_POLL)
> +		return false;
> +	if (WARN_ON_ONCE(!rq->bio))
> +		return false;
> +	return true;
>   }
>   
>   static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
>   {
>   	do {
> -		blk_poll(rq->q, request_to_qc_t(rq->mq_hctx, rq), 0);
> +		bio_poll(rq->bio, 0);
>   		cond_resched();
>   	} while (!completion_done(wait));
>   }

For some scsi command sent by function __scsi_execute() without data, it 
has request but no bio (bufflen = 0),
then how to use bio_poll() for them ?

Best Regards,
Xiang Chen

