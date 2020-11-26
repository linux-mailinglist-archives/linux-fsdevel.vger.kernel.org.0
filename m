Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3122C5951
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 17:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391400AbgKZQdo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 11:33:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:44026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730181AbgKZQdo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 11:33:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 40B53ACC4;
        Thu, 26 Nov 2020 16:33:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A9A321E10D0; Thu, 26 Nov 2020 17:33:41 +0100 (CET)
Date:   Thu, 26 Nov 2020 17:33:41 +0100
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
Subject: Re: [PATCH 24/44] block: simplify bdev/disk lookup in blkdev_get
Message-ID: <20201126163341.GL422@quack2.suse.cz>
References: <20201126130422.92945-1-hch@lst.de>
 <20201126130422.92945-25-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126130422.92945-25-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 26-11-20 14:04:02, Christoph Hellwig wrote:
> To simplify block device lookup and a few other upcoming areas, make sure
> that we always have a struct block_device available for each disk and
> each partition, and only find existing block devices in bdget.  The only
> downside of this is that each device and partition uses a little more
> memory.  The upside will be that a lot of code can be simplified.
> 
> With that all we need to look up the block device is to lookup the inode
> and do a few sanity checks on the gendisk, instead of the separate lookup
> for the gendisk.  For blk-cgroup which wants to access a gendisk without
> opening it, a new blkdev_{get,put}_no_open low-level interface is added
> to replace the previous get_gendisk use.
> 
> Note that the change to look up block device directly instead of the two
> step lookup using struct gendisk causes a subtile change in behavior:
> accessing a non-existing partition on an existing block device can now
> cause a call to request_module.  That call is harmless, and in practice
> no recent system will access these nodes as they aren't created by udev
> and static /dev/ setups are unusual.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I still found some smaller issues (see below) but overall this looks sane
and also simpler to review due to patch refactoring so thanks for that!

> @@ -1384,7 +1376,7 @@ static int __blkdev_get(struct block_device *bdev, struct gendisk *disk,
>  			struct block_device *whole = bdget_disk(disk, 0);
>  
>  			mutex_lock_nested(&whole->bd_mutex, 1);
> -			ret = __blkdev_get(whole, disk, 0, mode);
> +			ret = __blkdev_get(whole, mode);
>  			if (ret) {
>  				mutex_unlock(&whole->bd_mutex);
>  				bdput(whole);
> @@ -1394,9 +1386,8 @@ static int __blkdev_get(struct block_device *bdev, struct gendisk *disk,
>  			mutex_unlock(&whole->bd_mutex);
>  
>  			bdev->bd_contains = whole;
> -			bdev->bd_part = disk_get_part(disk, partno);
> -			if (!(disk->flags & GENHD_FL_UP) ||
> -			    !bdev->bd_part || !bdev->bd_part->nr_sects) {
> +			bdev->bd_part = disk_get_part(disk, bdev->bd_partno);
> +			if (!bdev->bd_part || !bdev->bd_part->nr_sects) {

AFAICT it is still possible that we see !(disk->flags & GENHD_FL_UP) here,
isn't it? Is it safe to remove because the nr_sects check is already
equivalent to it? Or something else?

>  				__blkdev_put(whole, mode, 1);
>  				bdput(whole);
>  				ret = -ENXIO;
> @@ -1426,12 +1417,51 @@ static int __blkdev_get(struct block_device *bdev, struct gendisk *disk,
>  
>   out_clear:
>  	disk_put_part(bdev->bd_part);
> -	bdev->bd_disk = NULL;
>  	bdev->bd_part = NULL;
>  	bdev->bd_contains = NULL;
>  	return ret;
>  }
>  
> +struct block_device *blkdev_get_no_open(dev_t dev)
> +{
> +	struct block_device *bdev = bdget(dev);
> +	struct gendisk *disk;

I think bdget() above needs to be already under bdev_lookup_sem. Otherwise
disk_to_dev(bdev->bd_disk)->kobj below is a potential use-after-free.

> +
> +	down_read(&bdev_lookup_sem);
> +	if (!bdev) {
> +		up_read(&bdev_lookup_sem);
> +		blk_request_module(dev);
> +		down_read(&bdev_lookup_sem);
> +
> +		bdev = bdget(dev);
> +		if (!bdev)
> +			return NULL;

Here you return with bdev_lookup_sem held.

> +	}
> +
> +	disk = bdev->bd_disk;
> +	if (!kobject_get_unless_zero(&disk_to_dev(disk)->kobj))
> +		goto bdput;
> +	if ((disk->flags & (GENHD_FL_UP | GENHD_FL_HIDDEN)) != GENHD_FL_UP)
> +		goto bdput;

I think here you need to jump to put_disk.

> +	if (!try_module_get(bdev->bd_disk->fops->owner))
> +		goto put_disk;
> +	up_read(&bdev_lookup_sem);
> +	return bdev;
> +put_disk:
> +	put_disk(disk);
> +bdput:
> +	bdput(bdev);
> +	up_read(&bdev_lookup_sem);
> +	return NULL;
> +}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
