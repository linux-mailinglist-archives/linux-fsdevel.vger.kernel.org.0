Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506463E4885
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 17:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhHIPR6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 11:17:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51370 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbhHIPRy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:17:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9D3F221EB9;
        Mon,  9 Aug 2021 15:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628522252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7zL5iFOCNlqpnOgojUr8MEx35+sJRZ9IY3kqNUTz69w=;
        b=kw6i16i0g37hIjasF/QFKC3nj8G4OWm1HFOmAIhTsp7EZd8DrvVvlZOy4pmVV4AulCs0Mt
        C3tHpa3x0X66+DFrn1Fzm9rP0Bbs61uRuwtkFQCXRwIFnTYUJ81aQfqHeF2ExDf9sFbDKi
        BWoJa2WNGL5MlW8Dt9JdV+/8IbW8GGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628522252;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7zL5iFOCNlqpnOgojUr8MEx35+sJRZ9IY3kqNUTz69w=;
        b=YfrR8LOFEkRRgYmUiGBh97iwJZJeZqfYXF1sBmdDibxeuFR3Suk4zhAEY4FYbIU46mR12+
        xaH9eaKX6DoIYPBA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 8078AA3B81;
        Mon,  9 Aug 2021 15:17:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 40BEE1E3BFC; Mon,  9 Aug 2021 17:17:32 +0200 (CEST)
Date:   Mon, 9 Aug 2021 17:17:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/5] block: pass a gendisk to blk_queue_update_readahead
Message-ID: <20210809151732.GF30319@quack2.suse.cz>
References: <20210809141744.1203023-1-hch@lst.de>
 <20210809141744.1203023-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809141744.1203023-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 09-08-21 16:17:41, Christoph Hellwig wrote:
> .. and rename the function to disk_update_readahead.  This is in
> preparation for moving the BDI from the request_queue to the gendisk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/blk-settings.c         | 8 +++++---
>  block/blk-sysfs.c            | 2 +-
>  drivers/block/drbd/drbd_nl.c | 2 +-
>  drivers/md/dm-table.c        | 2 +-
>  drivers/nvme/host/core.c     | 2 +-
>  include/linux/blkdev.h       | 2 +-
>  6 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 109012719aa0..44aaef9bf736 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -380,8 +380,10 @@ void blk_queue_alignment_offset(struct request_queue *q, unsigned int offset)
>  }
>  EXPORT_SYMBOL(blk_queue_alignment_offset);
>  
> -void blk_queue_update_readahead(struct request_queue *q)
> +void disk_update_readahead(struct gendisk *disk)
>  {
> +	struct request_queue *q = disk->queue;
> +
>  	/*
>  	 * For read-ahead of large files to be effective, we need to read ahead
>  	 * at least twice the optimal I/O size.
> @@ -391,7 +393,7 @@ void blk_queue_update_readahead(struct request_queue *q)
>  	q->backing_dev_info->io_pages =
>  		queue_max_sectors(q) >> (PAGE_SHIFT - 9);
>  }
> -EXPORT_SYMBOL_GPL(blk_queue_update_readahead);
> +EXPORT_SYMBOL_GPL(disk_update_readahead);
>  
>  /**
>   * blk_limits_io_min - set minimum request size for a device
> @@ -665,7 +667,7 @@ void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
>  		pr_notice("%s: Warning: Device %pg is misaligned\n",
>  			disk->disk_name, bdev);
>  
> -	blk_queue_update_readahead(disk->queue);
> +	disk_update_readahead(disk);
>  }
>  EXPORT_SYMBOL(disk_stack_limits);
>  
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 370d83c18057..3af2ab7d5086 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -866,7 +866,7 @@ int blk_register_queue(struct gendisk *disk)
>  		  "%s is registering an already registered queue\n",
>  		  kobject_name(&dev->kobj));
>  
> -	blk_queue_update_readahead(q);
> +	disk_update_readahead(disk);
>  
>  	ret = blk_trace_init_sysfs(dev);
>  	if (ret)
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index e7d0e637e632..44ccf8b4f4b2 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -1364,7 +1364,7 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
>  
>  	if (b) {
>  		blk_stack_limits(&q->limits, &b->limits, 0);
> -		blk_queue_update_readahead(q);
> +		disk_update_readahead(device->vdisk);
>  	}
>  	fixup_discard_if_not_supported(q);
>  	fixup_write_zeroes(device, q);
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 0543cdf89e92..b03eabc1ed7c 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -2076,7 +2076,7 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
>  	}
>  
>  	dm_update_keyslot_manager(q, t);
> -	blk_queue_update_readahead(q);
> +	disk_update_readahead(t->md->disk);
>  
>  	return 0;
>  }
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dfd9dec0c1f6..f6c0a59c4b53 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1890,7 +1890,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>  		nvme_update_disk_info(ns->head->disk, ns, id);
>  		blk_stack_limits(&ns->head->disk->queue->limits,
>  				 &ns->queue->limits, 0);
> -		blk_queue_update_readahead(ns->head->disk->queue);
> +		disk_update_readahead(ns->head->disk);
>  		blk_mq_unfreeze_queue(ns->head->disk->queue);
>  	}
>  	return 0;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index b5c033cf5f26..ac3642c88a4d 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1139,7 +1139,7 @@ void blk_queue_zone_write_granularity(struct request_queue *q,
>  				      unsigned int size);
>  extern void blk_queue_alignment_offset(struct request_queue *q,
>  				       unsigned int alignment);
> -void blk_queue_update_readahead(struct request_queue *q);
> +void disk_update_readahead(struct gendisk *disk);
>  extern void blk_limits_io_min(struct queue_limits *limits, unsigned int min);
>  extern void blk_queue_io_min(struct request_queue *q, unsigned int min);
>  extern void blk_limits_io_opt(struct queue_limits *limits, unsigned int opt);
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
