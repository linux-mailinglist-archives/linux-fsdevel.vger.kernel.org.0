Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D343627745D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 16:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgIXOxw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 10:53:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:45024 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgIXOxw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:53:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1FAE0ACCF;
        Thu, 24 Sep 2020 14:53:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 992521E12DD; Thu, 24 Sep 2020 16:53:46 +0200 (CEST)
Date:   Thu, 24 Sep 2020 16:53:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Coly Li <colyli@suse.de>, Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Justin Sanders <justin@coraid.com>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 07/13] block: lift setting the readahead size into the
 block layer
Message-ID: <20200924145346.GA3361@quack2.suse.cz>
References: <20200924065140.726436-1-hch@lst.de>
 <20200924065140.726436-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924065140.726436-8-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 24-09-20 08:51:34, Christoph Hellwig wrote:
> Drivers shouldn't really mess with the readahead size, as that is a VM
> concept.  Instead set it based on the optimal I/O size by lifting the
> algorithm from the md driver when registering the disk.  Also set
> bdi->io_pages there as well by applying the same scheme based on
> max_sectors.  To ensure the limits work well for stacking drivers a
> new helper is added to update the readahead limits from the block
> limits, which is also called from disk_stack_limits.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Coly Li <colyli@suse.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

The patch looks good to me now. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/blk-settings.c         | 18 ++++++++++++++++--
>  block/blk-sysfs.c            |  2 ++
>  drivers/block/aoe/aoeblk.c   |  1 -
>  drivers/block/drbd/drbd_nl.c | 10 +---------
>  drivers/md/bcache/super.c    |  3 ---
>  drivers/md/dm-table.c        |  3 +--
>  drivers/md/raid0.c           | 16 ----------------
>  drivers/md/raid10.c          | 24 +-----------------------
>  drivers/md/raid5.c           | 13 +------------
>  drivers/nvme/host/core.c     |  1 +
>  include/linux/blkdev.h       |  1 +
>  11 files changed, 24 insertions(+), 68 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 5ea3de48afba22..4f6eb4bb17236a 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -372,6 +372,19 @@ void blk_queue_alignment_offset(struct request_queue *q, unsigned int offset)
>  }
>  EXPORT_SYMBOL(blk_queue_alignment_offset);
>  
> +void blk_queue_update_readahead(struct request_queue *q)
> +{
> +	/*
> +	 * For read-ahead of large files to be effective, we need to read ahead
> +	 * at least twice the optimal I/O size.
> +	 */
> +	q->backing_dev_info->ra_pages =
> +		max(queue_io_opt(q) * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);
> +	q->backing_dev_info->io_pages =
> +		queue_max_sectors(q) >> (PAGE_SHIFT - 9);
> +}
> +EXPORT_SYMBOL_GPL(blk_queue_update_readahead);
> +
>  /**
>   * blk_limits_io_min - set minimum request size for a device
>   * @limits: the queue limits
> @@ -450,6 +463,8 @@ EXPORT_SYMBOL(blk_limits_io_opt);
>  void blk_queue_io_opt(struct request_queue *q, unsigned int opt)
>  {
>  	blk_limits_io_opt(&q->limits, opt);
> +	q->backing_dev_info->ra_pages =
> +		max(queue_io_opt(q) * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);
>  }
>  EXPORT_SYMBOL(blk_queue_io_opt);
>  
> @@ -631,8 +646,7 @@ void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
>  		       top, bottom);
>  	}
>  
> -	t->backing_dev_info->io_pages =
> -		t->limits.max_sectors >> (PAGE_SHIFT - 9);
> +	blk_queue_update_readahead(disk->queue);
>  }
>  EXPORT_SYMBOL(disk_stack_limits);
>  
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 81722cdcf0cb21..869ed21a9edcab 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -854,6 +854,8 @@ int blk_register_queue(struct gendisk *disk)
>  		percpu_ref_switch_to_percpu(&q->q_usage_counter);
>  	}
>  
> +	blk_queue_update_readahead(q);
> +
>  	ret = blk_trace_init_sysfs(dev);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
> index d8cfc233e64b93..c34e71b0c4a98c 100644
> --- a/drivers/block/aoe/aoeblk.c
> +++ b/drivers/block/aoe/aoeblk.c
> @@ -406,7 +406,6 @@ aoeblk_gdalloc(void *vp)
>  	WARN_ON(d->gd);
>  	WARN_ON(d->flags & DEVFL_UP);
>  	blk_queue_max_hw_sectors(q, BLK_DEF_MAX_SECTORS);
> -	q->backing_dev_info->ra_pages = SZ_2M / PAGE_SIZE;
>  	blk_queue_io_opt(q, SZ_2M);
>  	d->bufpool = mp;
>  	d->blkq = gd->queue = q;
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index aaff5bde391506..54a4930c04fe07 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -1362,15 +1362,7 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
>  
>  	if (b) {
>  		blk_stack_limits(&q->limits, &b->limits, 0);
> -
> -		if (q->backing_dev_info->ra_pages !=
> -		    b->backing_dev_info->ra_pages) {
> -			drbd_info(device, "Adjusting my ra_pages to backing device's (%lu -> %lu)\n",
> -				 q->backing_dev_info->ra_pages,
> -				 b->backing_dev_info->ra_pages);
> -			q->backing_dev_info->ra_pages =
> -						b->backing_dev_info->ra_pages;
> -		}
> +		blk_queue_update_readahead(q);
>  	}
>  	fixup_discard_if_not_supported(q);
>  	fixup_write_zeroes(device, q);
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 48113005ed86ad..6bfa771673623e 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -1427,9 +1427,6 @@ static int cached_dev_init(struct cached_dev *dc, unsigned int block_size)
>  	if (ret)
>  		return ret;
>  
> -	dc->disk.disk->queue->backing_dev_info->ra_pages =
> -		max(dc->disk.disk->queue->backing_dev_info->ra_pages,
> -		    q->backing_dev_info->ra_pages);
>  	blk_queue_io_opt(dc->disk.disk->queue,
>  		max(queue_io_opt(dc->disk.disk->queue), queue_io_opt(q)));
>  
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 5edc3079e7c199..ef2757012f59d5 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1925,8 +1925,7 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
>  	}
>  #endif
>  
> -	/* Allow reads to exceed readahead limits */
> -	q->backing_dev_info->io_pages = limits->max_sectors >> (PAGE_SHIFT - 9);
> +	blk_queue_update_readahead(q);
>  }
>  
>  unsigned int dm_table_get_num_targets(struct dm_table *t)
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index f54a449f97aa79..aa2d7279176880 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -410,22 +410,6 @@ static int raid0_run(struct mddev *mddev)
>  		 mdname(mddev),
>  		 (unsigned long long)mddev->array_sectors);
>  
> -	if (mddev->queue) {
> -		/* calculate the max read-ahead size.
> -		 * For read-ahead of large files to be effective, we need to
> -		 * readahead at least twice a whole stripe. i.e. number of devices
> -		 * multiplied by chunk size times 2.
> -		 * If an individual device has an ra_pages greater than the
> -		 * chunk size, then we will not drive that device as hard as it
> -		 * wants.  We consider this a configuration error: a larger
> -		 * chunksize should be used in that case.
> -		 */
> -		int stripe = mddev->raid_disks *
> -			(mddev->chunk_sectors << 9) / PAGE_SIZE;
> -		if (mddev->queue->backing_dev_info->ra_pages < 2* stripe)
> -			mddev->queue->backing_dev_info->ra_pages = 2* stripe;
> -	}
> -
>  	dump_zones(mddev);
>  
>  	ret = md_integrity_register(mddev);
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 9956a04ac13bd6..5d1bdee313ec33 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -3873,19 +3873,6 @@ static int raid10_run(struct mddev *mddev)
>  	mddev->resync_max_sectors = size;
>  	set_bit(MD_FAILFAST_SUPPORTED, &mddev->flags);
>  
> -	if (mddev->queue) {
> -		int stripe = conf->geo.raid_disks *
> -			((mddev->chunk_sectors << 9) / PAGE_SIZE);
> -
> -		/* Calculate max read-ahead size.
> -		 * We need to readahead at least twice a whole stripe....
> -		 * maybe...
> -		 */
> -		stripe /= conf->geo.near_copies;
> -		if (mddev->queue->backing_dev_info->ra_pages < 2 * stripe)
> -			mddev->queue->backing_dev_info->ra_pages = 2 * stripe;
> -	}
> -
>  	if (md_integrity_register(mddev))
>  		goto out_free_conf;
>  
> @@ -4723,17 +4710,8 @@ static void end_reshape(struct r10conf *conf)
>  	conf->reshape_safe = MaxSector;
>  	spin_unlock_irq(&conf->device_lock);
>  
> -	/* read-ahead size must cover two whole stripes, which is
> -	 * 2 * (datadisks) * chunksize where 'n' is the number of raid devices
> -	 */
> -	if (conf->mddev->queue) {
> -		int stripe = conf->geo.raid_disks *
> -			((conf->mddev->chunk_sectors << 9) / PAGE_SIZE);
> -		stripe /= conf->geo.near_copies;
> -		if (conf->mddev->queue->backing_dev_info->ra_pages < 2 * stripe)
> -			conf->mddev->queue->backing_dev_info->ra_pages = 2 * stripe;
> +	if (conf->mddev->queue)
>  		raid10_set_io_opt(conf);
> -	}
>  	conf->fullsync = 0;
>  }
>  
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 9a7d1250894ef1..7ace1f76b14736 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -7522,8 +7522,6 @@ static int raid5_run(struct mddev *mddev)
>  		int data_disks = conf->previous_raid_disks - conf->max_degraded;
>  		int stripe = data_disks *
>  			((mddev->chunk_sectors << 9) / PAGE_SIZE);
> -		if (mddev->queue->backing_dev_info->ra_pages < 2 * stripe)
> -			mddev->queue->backing_dev_info->ra_pages = 2 * stripe;
>  
>  		chunk_size = mddev->chunk_sectors << 9;
>  		blk_queue_io_min(mddev->queue, chunk_size);
> @@ -8111,17 +8109,8 @@ static void end_reshape(struct r5conf *conf)
>  		spin_unlock_irq(&conf->device_lock);
>  		wake_up(&conf->wait_for_overlap);
>  
> -		/* read-ahead size must cover two whole stripes, which is
> -		 * 2 * (datadisks) * chunksize where 'n' is the number of raid devices
> -		 */
> -		if (conf->mddev->queue) {
> -			int data_disks = conf->raid_disks - conf->max_degraded;
> -			int stripe = data_disks * ((conf->chunk_sectors << 9)
> -						   / PAGE_SIZE);
> -			if (conf->mddev->queue->backing_dev_info->ra_pages < 2 * stripe)
> -				conf->mddev->queue->backing_dev_info->ra_pages = 2 * stripe;
> +		if (conf->mddev->queue)
>  			raid5_set_io_opt(conf);
> -		}
>  	}
>  }
>  
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ea1fa41fbba8df..741c9bfa8e14c7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2147,6 +2147,7 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>  		nvme_update_disk_info(ns->head->disk, ns, id);
>  		blk_stack_limits(&ns->head->disk->queue->limits,
>  				 &ns->queue->limits, 0);
> +		blk_queue_update_readahead(ns->head->disk->queue);
>  		nvme_update_bdev_size(ns->head->disk);
>  	}
>  #endif
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index be5ef6f4ba1905..282f5ca424f14a 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1140,6 +1140,7 @@ extern void blk_queue_max_zone_append_sectors(struct request_queue *q,
>  extern void blk_queue_physical_block_size(struct request_queue *, unsigned int);
>  extern void blk_queue_alignment_offset(struct request_queue *q,
>  				       unsigned int alignment);
> +void blk_queue_update_readahead(struct request_queue *q);
>  extern void blk_limits_io_min(struct queue_limits *limits, unsigned int min);
>  extern void blk_queue_io_min(struct request_queue *q, unsigned int min);
>  extern void blk_limits_io_opt(struct queue_limits *limits, unsigned int opt);
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
