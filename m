Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19501BBCAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 13:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgD1LnR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 07:43:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:40304 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgD1LnR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:43:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 81E60AD82;
        Tue, 28 Apr 2020 11:43:14 +0000 (UTC)
Subject: Re: [PATCH v9 09/11] null_blk: Support REQ_OP_ZONE_APPEND
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
References: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
 <20200428104605.8143-10-johannes.thumshirn@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <b7833055-31f1-2c9d-7efc-275559406d21@suse.de>
Date:   Tue, 28 Apr 2020 13:43:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428104605.8143-10-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/28/20 12:46 PM, Johannes Thumshirn wrote:
> From: Damien Le Moal <damien.lemoal@wdc.com>
> 
> Support REQ_OP_ZONE_APPEND requests for null_blk devices with zoned
> mode enabled. Use the internally tracked zone write pointer position
> as the actual write position and return it using the command request
> __sector field in the case of an mq device and using the command BIO
> sector in the case of a BIO device.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   drivers/block/null_blk_zoned.c | 37 ++++++++++++++++++++++++++--------
>   1 file changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
> index 46641df2e58e..9c19f747f394 100644
> --- a/drivers/block/null_blk_zoned.c
> +++ b/drivers/block/null_blk_zoned.c
> @@ -70,13 +70,20 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
>   
>   int null_register_zoned_dev(struct nullb *nullb)
>   {
> +	struct nullb_device *dev = nullb->dev;
>   	struct request_queue *q = nullb->q;
>   
> -	if (queue_is_mq(q))
> -		return blk_revalidate_disk_zones(nullb->disk, NULL);
> +	if (queue_is_mq(q)) {
> +		int ret = blk_revalidate_disk_zones(nullb->disk, NULL);
> +
> +		if (ret)
> +			return ret;
> +	} else {
> +		blk_queue_chunk_sectors(q, dev->zone_size_sects);
> +		q->nr_zones = blkdev_nr_zones(nullb->disk);
> +	}
>   
> -	blk_queue_chunk_sectors(q, nullb->dev->zone_size_sects);
> -	q->nr_zones = blkdev_nr_zones(nullb->disk);
> +	blk_queue_max_zone_append_sectors(q, dev->zone_size_sects);
>   
>   	return 0;
>   }
> @@ -138,7 +145,7 @@ size_t null_zone_valid_read_len(struct nullb *nullb,
>   }
>   
>   static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
> -		     unsigned int nr_sectors)
> +				    unsigned int nr_sectors, bool append)
>   {
>   	struct nullb_device *dev = cmd->nq->dev;
>   	unsigned int zno = null_zone_no(dev, sector);
> @@ -158,9 +165,21 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
>   	case BLK_ZONE_COND_IMP_OPEN:
>   	case BLK_ZONE_COND_EXP_OPEN:
>   	case BLK_ZONE_COND_CLOSED:
> -		/* Writes must be at the write pointer position */
> -		if (sector != zone->wp)
> +		/*
> +		 * Regular writes must be at the write pointer position.
> +		 * Zone append writes are automatically issued at the write
> +		 * pointer and the position returned using the request or BIO
> +		 * sector.
> +		 */
> +		if (append) {
> +			sector = zone->wp;
> +			if (cmd->bio)
> +				cmd->bio->bi_iter.bi_sector = sector;
> +			else
> +				cmd->rq->__sector = sector;
> +		} else if (sector != zone->wp) {
>   			return BLK_STS_IOERR;
> +		}
>   
>   		if (zone->cond != BLK_ZONE_COND_EXP_OPEN)
>   			zone->cond = BLK_ZONE_COND_IMP_OPEN;
> @@ -242,7 +261,9 @@ blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_opf op,
>   {
>   	switch (op) {
>   	case REQ_OP_WRITE:
> -		return null_zone_write(cmd, sector, nr_sectors);
> +		return null_zone_write(cmd, sector, nr_sectors, false);
> +	case REQ_OP_ZONE_APPEND:
> +		return null_zone_write(cmd, sector, nr_sectors, true);
>   	case REQ_OP_ZONE_RESET:
>   	case REQ_OP_ZONE_RESET_ALL:
>   	case REQ_OP_ZONE_OPEN:
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
