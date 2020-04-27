Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205761BA3FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 14:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgD0Mw7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 08:52:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:55812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgD0Mw7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 08:52:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 50BE6AA55;
        Mon, 27 Apr 2020 12:52:56 +0000 (UTC)
Subject: Re: [PATCH v8 06/11] block: Modify revalidate zones
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
 <20200427113153.31246-7-johannes.thumshirn@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <2e01d1e3-6df1-5d45-962f-9ad696930927@suse.de>
Date:   Mon, 27 Apr 2020 14:52:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427113153.31246-7-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/27/20 1:31 PM, Johannes Thumshirn wrote:
> From: Damien Le Moal <damien.lemoal@wdc.com>
> 
> Modify the interface of blk_revalidate_disk_zones() to add an optional
> driver callback function that a driver can use to extend processing
> done during zone revalidation. The callback, if defined, is executed
> with the device request queue frozen, after all zones have been
> inspected.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-zoned.c              | 9 ++++++++-
>   drivers/block/null_blk_zoned.c | 2 +-
>   include/linux/blkdev.h         | 3 ++-
>   3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index c822cfa7a102..23831fa8701d 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -471,14 +471,19 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
>   /**
>    * blk_revalidate_disk_zones - (re)allocate and initialize zone bitmaps
>    * @disk:	Target disk
> + * @update_driver_data:	Callback to update driver data on the frozen disk
>    *
>    * Helper function for low-level device drivers to (re) allocate and initialize
>    * a disk request queue zone bitmaps. This functions should normally be called
>    * within the disk ->revalidate method for blk-mq based drivers.  For BIO based
>    * drivers only q->nr_zones needs to be updated so that the sysfs exposed value
>    * is correct.
> + * If the @update_driver_data callback function is not NULL, the callback is
> + * executed with the device request queue frozen after all zones have been
> + * checked.
>    */
> -int blk_revalidate_disk_zones(struct gendisk *disk)
> +int blk_revalidate_disk_zones(struct gendisk *disk,
> +			      void (*update_driver_data)(struct gendisk *disk))
>   {
>   	struct request_queue *q = disk->queue;
>   	struct blk_revalidate_zone_args args = {
> @@ -512,6 +517,8 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
>   		q->nr_zones = args.nr_zones;
>   		swap(q->seq_zones_wlock, args.seq_zones_wlock);
>   		swap(q->conv_zones_bitmap, args.conv_zones_bitmap);
> +		if (update_driver_data)
> +			update_driver_data(disk);
>   		ret = 0;
>   	} else {
>   		pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
> index 9e4bcdad1a80..46641df2e58e 100644
> --- a/drivers/block/null_blk_zoned.c
> +++ b/drivers/block/null_blk_zoned.c
> @@ -73,7 +73,7 @@ int null_register_zoned_dev(struct nullb *nullb)
>   	struct request_queue *q = nullb->q;
>   
>   	if (queue_is_mq(q))
> -		return blk_revalidate_disk_zones(nullb->disk);
> +		return blk_revalidate_disk_zones(nullb->disk, NULL);
>   
>   	blk_queue_chunk_sectors(q, nullb->dev->zone_size_sects);
>   	q->nr_zones = blkdev_nr_zones(nullb->disk);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index d6e6ce3dc656..fd405dac8eb0 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -357,7 +357,8 @@ unsigned int blkdev_nr_zones(struct gendisk *disk);
>   extern int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
>   			    sector_t sectors, sector_t nr_sectors,
>   			    gfp_t gfp_mask);
> -extern int blk_revalidate_disk_zones(struct gendisk *disk);
> +int blk_revalidate_disk_zones(struct gendisk *disk,
> +			      void (*update_driver_data)(struct gendisk *disk));
>   
>   extern int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
>   				     unsigned int cmd, unsigned long arg);
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
