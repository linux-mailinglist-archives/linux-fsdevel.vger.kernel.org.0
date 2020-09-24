Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12142772C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 15:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgIXNkm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 09:40:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:55300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727898AbgIXNkl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:40:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E5D67B0E6;
        Thu, 24 Sep 2020 13:40:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A00AC1E12F3; Thu, 24 Sep 2020 10:56:33 +0200 (CEST)
Date:   Thu, 24 Sep 2020 10:56:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        linux-ide@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 01/14] block: move the NEED_PART_SCAN flag to struct
 gendisk
Message-ID: <20200924085633.GD27019@quack2.suse.cz>
References: <20200917165720.3285256-1-hch@lst.de>
 <20200917165720.3285256-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917165720.3285256-2-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 17-09-20 18:57:07, Christoph Hellwig wrote:
> We can only scan for partitions on the whole disk, so move the flag
> from struct block_device to struct gendisk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Makes sense. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/genhd.c             | 4 ++--
>  drivers/block/nbd.c       | 8 ++++----
>  drivers/ide/ide-gd.c      | 2 +-
>  fs/block_dev.c            | 7 +++----
>  include/linux/blk_types.h | 4 +---
>  include/linux/genhd.h     | 2 ++
>  6 files changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 9d060e79eb31d8..7b56203c90a303 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -731,7 +731,7 @@ static void register_disk(struct device *parent, struct gendisk *disk,
>  	if (!bdev)
>  		goto exit;
>  
> -	set_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
> +	set_bit(GD_NEED_PART_SCAN, &disk->state);
>  	err = blkdev_get(bdev, FMODE_READ, NULL);
>  	if (err < 0)
>  		goto exit;
> @@ -2112,7 +2112,7 @@ bool bdev_check_media_change(struct block_device *bdev)
>  	if (__invalidate_device(bdev, true))
>  		pr_warn("VFS: busy inodes on changed media %s\n",
>  			bdev->bd_disk->disk_name);
> -	set_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
> +	set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
>  	return true;
>  }
>  EXPORT_SYMBOL(bdev_check_media_change);
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 15eed210feeff4..2dca0aab0a9a25 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -315,7 +315,7 @@ static void nbd_size_update(struct nbd_device *nbd)
>  			bd_set_nr_sectors(bdev, nr_sectors);
>  			set_blocksize(bdev, config->blksize);
>  		} else
> -			set_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
> +			set_bit(GD_NEED_PART_SCAN, &nbd->disk->state);
>  		bdput(bdev);
>  	}
>  	kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
> @@ -1322,7 +1322,7 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
>  		return ret;
>  
>  	if (max_part)
> -		set_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
> +		set_bit(GD_NEED_PART_SCAN, &nbd->disk->state);
>  	mutex_unlock(&nbd->config_lock);
>  	ret = wait_event_interruptible(config->recv_wq,
>  					 atomic_read(&config->recv_threads) == 0);
> @@ -1500,9 +1500,9 @@ static int nbd_open(struct block_device *bdev, fmode_t mode)
>  		refcount_set(&nbd->config_refs, 1);
>  		refcount_inc(&nbd->refs);
>  		mutex_unlock(&nbd->config_lock);
> -		set_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
> +		set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
>  	} else if (nbd_disconnected(nbd->config)) {
> -		set_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
> +		set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
>  	}
>  out:
>  	mutex_unlock(&nbd_index_mutex);
> diff --git a/drivers/ide/ide-gd.c b/drivers/ide/ide-gd.c
> index 661e2aa9c96784..e2b6c82586ce8b 100644
> --- a/drivers/ide/ide-gd.c
> +++ b/drivers/ide/ide-gd.c
> @@ -230,7 +230,7 @@ static int ide_gd_open(struct block_device *bdev, fmode_t mode)
>  				bdev->bd_disk->disk_name);
>  		drive->disk_ops->get_capacity(drive);
>  		set_capacity(disk, ide_gd_capacity(drive));
> -		set_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
> +		set_bit(GD_NEED_PART_SCAN, &disk->state);
>  	} else if (drive->dev_flags & IDE_DFLAG_FORMAT_IN_PROGRESS) {
>  		ret = -EBUSY;
>  		goto out_put_idkp;
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 0b34955b9e360f..1a9325f4315769 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -910,7 +910,6 @@ struct block_device *bdget(dev_t dev)
>  		bdev->bd_super = NULL;
>  		bdev->bd_inode = inode;
>  		bdev->bd_part_count = 0;
> -		bdev->bd_flags = 0;
>  		inode->i_mode = S_IFBLK;
>  		inode->i_rdev = dev;
>  		inode->i_bdev = bdev;
> @@ -1385,7 +1384,7 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
>  
>  	lockdep_assert_held(&bdev->bd_mutex);
>  
> -	clear_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
> +	clear_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
>  
>  rescan:
>  	ret = blk_drop_partitions(bdev);
> @@ -1509,7 +1508,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
>  			 * The latter is necessary to prevent ghost
>  			 * partitions on a removed medium.
>  			 */
> -			if (test_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags) &&
> +			if (test_bit(GD_NEED_PART_SCAN, &disk->state) &&
>  			    (!ret || ret == -ENOMEDIUM))
>  				bdev_disk_changed(bdev, ret == -ENOMEDIUM);
>  
> @@ -1539,7 +1538,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
>  			if (bdev->bd_disk->fops->open)
>  				ret = bdev->bd_disk->fops->open(bdev, mode);
>  			/* the same as first opener case, read comment there */
> -			if (test_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags) &&
> +			if (test_bit(GD_NEED_PART_SCAN, &disk->state) &&
>  			    (!ret || ret == -ENOMEDIUM))
>  				bdev_disk_changed(bdev, ret == -ENOMEDIUM);
>  			if (ret)
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 6ffa783e16335e..eb20e28184ab19 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -19,8 +19,6 @@ struct cgroup_subsys_state;
>  typedef void (bio_end_io_t) (struct bio *);
>  struct bio_crypt_ctx;
>  
> -#define BDEV_NEED_PART_SCAN		0
> -
>  struct block_device {
>  	dev_t			bd_dev;
>  	int			bd_openers;
> @@ -39,7 +37,7 @@ struct block_device {
>  	struct hd_struct *	bd_part;
>  	/* number of times partitions within this device have been opened. */
>  	unsigned		bd_part_count;
> -	unsigned long		bd_flags;
> +
>  	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
>  	struct gendisk *	bd_disk;
>  	struct backing_dev_info *bd_bdi;
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 1c97cf84f011a7..38f23d75701379 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -191,6 +191,8 @@ struct gendisk {
>  	void *private_data;
>  
>  	int flags;
> +	unsigned long state;
> +#define GD_NEED_PART_SCAN		0
>  	struct rw_semaphore lookup_sem;
>  	struct kobject *slave_dir;
>  
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
