Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2362B9551
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 15:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgKSOnX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 09:43:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:45138 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbgKSOnV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:43:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 59A0CAC41;
        Thu, 19 Nov 2020 14:43:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 260F01E130B; Thu, 19 Nov 2020 15:43:16 +0100 (CET)
Date:   Thu, 19 Nov 2020 15:43:16 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 16/20] block: stop using bdget_disk for partition 0
Message-ID: <20201119144316.GY1981@quack2.suse.cz>
References: <20201118084800.2339180-1-hch@lst.de>
 <20201118084800.2339180-17-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118084800.2339180-17-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 18-11-20 09:47:56, Christoph Hellwig wrote:
> We can just dereference the point in struct gendisk instead.  Also
> remove the now unused export.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/genhd.c                   |  1 -
>  drivers/block/nbd.c             |  4 +---
>  drivers/block/xen-blkfront.c    | 20 +++++---------------
>  drivers/block/zram/zram_drv.c   | 18 +++---------------
>  drivers/md/dm.c                 |  8 +-------
>  drivers/s390/block/dasd_ioctl.c |  5 ++---
>  6 files changed, 12 insertions(+), 44 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index a14e2408e3d4e8..ec41d0f18f5ce1 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -907,7 +907,6 @@ struct block_device *bdget_disk(struct gendisk *disk, int partno)
>  
>  	return bdev;
>  }
> -EXPORT_SYMBOL(bdget_disk);
>  
>  /*
>   * print a full list of all partitions - intended for places where the root
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 014683968ce174..92f84ed0ba9eb6 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1488,12 +1488,10 @@ static int nbd_open(struct block_device *bdev, fmode_t mode)
>  static void nbd_release(struct gendisk *disk, fmode_t mode)
>  {
>  	struct nbd_device *nbd = disk->private_data;
> -	struct block_device *bdev = bdget_disk(disk, 0);
>  
>  	if (test_bit(NBD_RT_DISCONNECT_ON_CLOSE, &nbd->config->runtime_flags) &&
> -			bdev->bd_openers == 0)
> +			disk->part0->bd_openers == 0)
>  		nbd_disconnect_and_put(nbd);
> -	bdput(bdev);
>  
>  	nbd_config_put(nbd);
>  	nbd_put(nbd);
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index 79521e33d30ed5..188e0b47534bcf 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -2153,7 +2153,7 @@ static void blkfront_closing(struct blkfront_info *info)
>  	}
>  
>  	if (info->gd)
> -		bdev = bdget_disk(info->gd, 0);
> +		bdev = bdgrab(info->gd->part0);
>  
>  	mutex_unlock(&info->mutex);
>  
> @@ -2518,7 +2518,7 @@ static int blkfront_remove(struct xenbus_device *xbdev)
>  
>  	disk = info->gd;
>  	if (disk)
> -		bdev = bdget_disk(disk, 0);
> +		bdev = bdgrab(disk->part0);
>  
>  	info->xbdev = NULL;
>  	mutex_unlock(&info->mutex);
> @@ -2595,19 +2595,11 @@ static int blkif_open(struct block_device *bdev, fmode_t mode)
>  static void blkif_release(struct gendisk *disk, fmode_t mode)
>  {
>  	struct blkfront_info *info = disk->private_data;
> -	struct block_device *bdev;
>  	struct xenbus_device *xbdev;
>  
>  	mutex_lock(&blkfront_mutex);
> -
> -	bdev = bdget_disk(disk, 0);
> -
> -	if (!bdev) {
> -		WARN(1, "Block device %s yanked out from us!\n", disk->disk_name);
> +	if (disk->part0->bd_openers)
>  		goto out_mutex;
> -	}
> -	if (bdev->bd_openers)
> -		goto out;
>  
>  	/*
>  	 * Check if we have been instructed to close. We will have
> @@ -2619,7 +2611,7 @@ static void blkif_release(struct gendisk *disk, fmode_t mode)
>  
>  	if (xbdev && xbdev->state == XenbusStateClosing) {
>  		/* pending switch to state closed */
> -		dev_info(disk_to_dev(bdev->bd_disk), "releasing disk\n");
> +		dev_info(disk_to_dev(disk), "releasing disk\n");
>  		xlvbd_release_gendisk(info);
>  		xenbus_frontend_closed(info->xbdev);
>   	}
> @@ -2628,14 +2620,12 @@ static void blkif_release(struct gendisk *disk, fmode_t mode)
>  
>  	if (!xbdev) {
>  		/* sudden device removal */
> -		dev_info(disk_to_dev(bdev->bd_disk), "releasing disk\n");
> +		dev_info(disk_to_dev(disk), "releasing disk\n");
>  		xlvbd_release_gendisk(info);
>  		disk->private_data = NULL;
>  		free_info(info);
>  	}
>  
> -out:
> -	bdput(bdev);
>  out_mutex:
>  	mutex_unlock(&blkfront_mutex);
>  }
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 01757f9578dcb8..56024905bd242c 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1748,7 +1748,7 @@ static ssize_t reset_store(struct device *dev,
>  		struct device_attribute *attr, const char *buf, size_t len)
>  {
>  	struct zram *zram = dev_to_zram(dev);
> -	struct block_device *bdev;
> +	struct block_device *bdev = zram->disk->part0;
>  	unsigned short do_reset;
>  	int ret = 0;
>  
> @@ -1758,17 +1758,12 @@ static ssize_t reset_store(struct device *dev,
>  	if (!do_reset)
>  		return -EINVAL;
>  
> -	bdev = bdget_disk(zram->disk, 0);
> -	if (!bdev)
> -		return -ENOMEM;
> -
>  	mutex_lock(&bdev->bd_mutex);
>  	if (bdev->bd_openers)
>  		ret = -EBUSY;
>  	else
>  		zram_reset_device(zram);
>  	mutex_unlock(&bdev->bd_mutex);
> -	bdput(bdev);
>  
>  	return ret ? ret : len;
>  }
> @@ -1933,15 +1928,8 @@ static int zram_add(void)
>  
>  static int zram_remove(struct zram *zram)
>  {
> -	struct block_device *bdev = bdget_disk(zram->disk, 0);
> -
> -	if (bdev) {
> -		if (bdev->bd_openers) {
> -			bdput(bdev);
> -			return -EBUSY;
> -		}
> -		bdput(bdev);
> -	}
> +	if (zram->disk->part0->bd_openers)
> +		return -EBUSY;
>  
>  	del_gendisk(zram->disk);
>  	zram_debugfs_unregister(zram);
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index c9438feefe55a3..ec48ccae50dd53 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -2375,17 +2375,12 @@ struct dm_table *dm_swap_table(struct mapped_device *md, struct dm_table *table)
>   */
>  static int lock_fs(struct mapped_device *md)
>  {
> -	struct block_device *bdev;
>  	int r;
>  
>  	WARN_ON(md->frozen_sb);
>  
> -	bdev = bdget_disk(md->disk, 0);
> -	if (!bdev)
> -		return -ENOMEM;
> -	md->frozen_sb = freeze_bdev(bdev);
> +	md->frozen_sb = freeze_bdev(md->disk->part0);
>  	if (IS_ERR(md->frozen_sb)) {
> -		bdput(bdev);
>  		r = PTR_ERR(md->frozen_sb);
>  		md->frozen_sb = NULL;
>  		return r;
> @@ -2402,7 +2397,6 @@ static void unlock_fs(struct mapped_device *md)
>  		return;
>  
>  	thaw_bdev(md->frozen_sb->s_bdev, md->frozen_sb);
> -	bdput(md->frozen_sb->s_bdev);
>  	md->frozen_sb = NULL;
>  	clear_bit(DMF_FROZEN, &md->flags);
>  }
> diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
> index 304eba1acf163c..9f642440894655 100644
> --- a/drivers/s390/block/dasd_ioctl.c
> +++ b/drivers/s390/block/dasd_ioctl.c
> @@ -220,9 +220,8 @@ dasd_format(struct dasd_block *block, struct format_data_t *fdata)
>  	 * enabling the device later.
>  	 */
>  	if (fdata->start_unit == 0) {
> -		struct block_device *bdev = bdget_disk(block->gdp, 0);
> -		bdev->bd_inode->i_blkbits = blksize_bits(fdata->blksize);
> -		bdput(bdev);
> +		block->gdp->part0->bd_inode->i_blkbits =
> +			blksize_bits(fdata->blksize);
>  	}
>  
>  	rc = base->discipline->format_device(base, fdata, 1);
> -- 
> 2.29.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
