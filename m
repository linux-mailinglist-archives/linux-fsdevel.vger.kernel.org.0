Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8256C2C5B07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 18:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404544AbgKZRr5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 12:47:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:53716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404191AbgKZRr5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:47:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 14588ACA9;
        Thu, 26 Nov 2020 17:47:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AC5821E10D0; Thu, 26 Nov 2020 18:47:54 +0100 (CET)
Date:   Thu, 26 Nov 2020 18:47:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 39/44] block: pass a block_device to blk_alloc_devt
Message-ID: <20201126174754.GY422@quack2.suse.cz>
References: <20201126130422.92945-1-hch@lst.de>
 <20201126130422.92945-40-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126130422.92945-40-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 26-11-20 14:04:17, Christoph Hellwig wrote:
> Pass the block_device actually needed instead of the hd_struct.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/blk.h             |  2 +-
>  block/genhd.c           | 14 +++++++-------
>  block/partitions/core.c |  2 +-
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk.h b/block/blk.h
> index d5bf8f3a078186..9657c6da7c770c 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -350,7 +350,7 @@ static inline void blk_queue_free_zone_bitmaps(struct request_queue *q) {}
>  
>  struct block_device *disk_map_sector_rcu(struct gendisk *disk, sector_t sector);
>  
> -int blk_alloc_devt(struct hd_struct *part, dev_t *devt);
> +int blk_alloc_devt(struct block_device *part, dev_t *devt);
>  void blk_free_devt(dev_t devt);
>  char *disk_name(struct gendisk *hd, int partno, char *buf);
>  #define ADDPART_FLAG_NONE	0
> diff --git a/block/genhd.c b/block/genhd.c
> index a85ffd7385718d..89cd0ba8e3b84a 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -559,8 +559,8 @@ static int blk_mangle_minor(int minor)
>  }
>  
>  /**
> - * blk_alloc_devt - allocate a dev_t for a partition
> - * @part: partition to allocate dev_t for
> + * blk_alloc_devt - allocate a dev_t for a block device
> + * @bdev: block device to allocate dev_t for
>   * @devt: out parameter for resulting dev_t
>   *
>   * Allocate a dev_t for block device.
> @@ -572,14 +572,14 @@ static int blk_mangle_minor(int minor)
>   * CONTEXT:
>   * Might sleep.
>   */
> -int blk_alloc_devt(struct hd_struct *part, dev_t *devt)
> +int blk_alloc_devt(struct block_device *bdev, dev_t *devt)
>  {
> -	struct gendisk *disk = part_to_disk(part);
> +	struct gendisk *disk = bdev->bd_disk;
>  	int idx;
>  
>  	/* in consecutive minor range? */
> -	if (part->bdev->bd_partno < disk->minors) {
> -		*devt = MKDEV(disk->major, disk->first_minor + part->bdev->bd_partno);
> +	if (bdev->bd_partno < disk->minors) {
> +		*devt = MKDEV(disk->major, disk->first_minor + bdev->bd_partno);
>  		return 0;
>  	}
>  
> @@ -735,7 +735,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
>  
>  	disk->flags |= GENHD_FL_UP;
>  
> -	retval = blk_alloc_devt(disk->part0->bd_part, &devt);
> +	retval = blk_alloc_devt(disk->part0, &devt);
>  	if (retval) {
>  		WARN_ON(1);
>  		return;
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index ecc3228a086956..4f823c4c733518 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -392,7 +392,7 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
>  	pdev->type = &part_type;
>  	pdev->parent = ddev;
>  
> -	err = blk_alloc_devt(p, &devt);
> +	err = blk_alloc_devt(bdev, &devt);
>  	if (err)
>  		goto out_bdput;
>  	pdev->devt = devt;
> -- 
> 2.29.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
