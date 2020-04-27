Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5647F1BA3E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 14:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgD0MwH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 08:52:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:55214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbgD0MwF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 08:52:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 19DBAAB89;
        Mon, 27 Apr 2020 12:52:03 +0000 (UTC)
Subject: Re: [PATCH v8 05/11] block: introduce blk_req_zone_write_trylock
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20200427113153.31246-1-johannes.thumshirn@wdc.com>
 <20200427113153.31246-6-johannes.thumshirn@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <889a6ff2-7c43-52b9-1e69-a20ee6c8227b@suse.de>
Date:   Mon, 27 Apr 2020 14:52:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427113153.31246-6-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/27/20 1:31 PM, Johannes Thumshirn wrote:
> Introduce blk_req_zone_write_trylock(), which either grabs the write-lock
> for a sequential zone or returns false, if the zone is already locked.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-zoned.c      | 14 ++++++++++++++
>   include/linux/blkdev.h |  1 +
>   2 files changed, 15 insertions(+)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index f87956e0dcaf..c822cfa7a102 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -82,6 +82,20 @@ bool blk_req_needs_zone_write_lock(struct request *rq)
>   }
>   EXPORT_SYMBOL_GPL(blk_req_needs_zone_write_lock);
>   
> +bool blk_req_zone_write_trylock(struct request *rq)
> +{
> +	unsigned int zno = blk_rq_zone_no(rq);
> +
> +	if (test_and_set_bit(zno, rq->q->seq_zones_wlock))
> +		return false;
> +
> +	WARN_ON_ONCE(rq->rq_flags & RQF_ZONE_WRITE_LOCKED);
> +	rq->rq_flags |= RQF_ZONE_WRITE_LOCKED;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(blk_req_zone_write_trylock);
> +
>   void __blk_req_zone_write_lock(struct request *rq)
>   {
>   	if (WARN_ON_ONCE(test_and_set_bit(blk_rq_zone_no(rq),
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 158641fbc7cd..d6e6ce3dc656 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1737,6 +1737,7 @@ extern int bdev_write_page(struct block_device *, sector_t, struct page *,
>   
>   #ifdef CONFIG_BLK_DEV_ZONED
>   bool blk_req_needs_zone_write_lock(struct request *r
> +bool blk_req_zone_write_trylock(struct request *rq);
>   void __blk_req_zone_write_lock(struct request *rq);
>   void __blk_req_zone_write_unlock(struct request *rq);
>   
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
