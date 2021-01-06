Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F097E2EC1E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 18:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbhAFRPM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 12:15:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:54610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727525AbhAFRPL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:15:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05EF5ACAF;
        Wed,  6 Jan 2021 17:14:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A0C771E0816; Wed,  6 Jan 2021 18:14:29 +0100 (CET)
Date:   Wed, 6 Jan 2021 18:14:29 +0100
From:   Jan Kara <jack@suse.cz>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de,
        qi.fuli@fujitsu.com, y-goto@fujitsu.com
Subject: Re: [PATCH 08/10] md: Implement ->corrupted_range()
Message-ID: <20210106171429.GE29271@quack2.suse.cz>
References: <20201230165601.845024-1-ruansy.fnst@cn.fujitsu.com>
 <20201230165601.845024-9-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230165601.845024-9-ruansy.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 31-12-20 00:55:59, Shiyang Ruan wrote:
> With the support of ->rmap(), it is possible to obtain the superblock on
> a mapped device.
> 
> If a pmem device is used as one target of mapped device, we cannot
> obtain its superblock directly.  With the help of SYSFS, the mapped
> device can be found on the target devices.  So, we iterate the
> bdev->bd_holder_disks to obtain its mapped device.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>

Thanks for the patch. Two comments below.

> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 4688bff19c20..9f9a2f3bf73b 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -256,21 +256,16 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
>  static int pmem_corrupted_range(struct gendisk *disk, struct block_device *bdev,
>  				loff_t disk_offset, size_t len, void *data)
>  {
> -	struct super_block *sb;
>  	loff_t bdev_offset;
>  	sector_t disk_sector = disk_offset >> SECTOR_SHIFT;
> -	int rc = 0;
> +	int rc = -ENODEV;
>  
>  	bdev = bdget_disk_sector(disk, disk_sector);
>  	if (!bdev)
> -		return -ENODEV;
> +		return rc;
>  
>  	bdev_offset = (disk_sector - get_start_sect(bdev)) << SECTOR_SHIFT;
> -	sb = get_super(bdev);
> -	if (sb && sb->s_op->corrupted_range) {
> -		rc = sb->s_op->corrupted_range(sb, bdev, bdev_offset, len, data);
> -		drop_super(sb);
> -	}
> +	rc = bd_corrupted_range(bdev, bdev_offset, bdev_offset, len, data);
>  
>  	bdput(bdev);
>  	return rc;

This (and the fs/block_dev.c change below) is just refining the function
you've implemented in the patch 6. I think it's confusing to split changes
like this - why not implement things correctly from the start in patch 6?

> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 9e84b1928b94..0e50f0e8e8af 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1171,6 +1171,27 @@ struct bd_holder_disk {
>  	int			refcnt;
>  };
>  
> +static int bd_disk_holder_corrupted_range(struct block_device *bdev, loff_t off,
> +					  size_t len, void *data)
> +{
> +	struct bd_holder_disk *holder;
> +	struct gendisk *disk;
> +	int rc = 0;
> +
> +	if (list_empty(&(bdev->bd_holder_disks)))
> +		return -ENODEV;

This will not compile for !CONFIG_SYSFS kernels. Not that it would be
common but still. Also I'm not sure whether using bd_holder_disks like this
is really the right thing to do (when it seems to be only a sysfs thing),
although admittedly I'm not aware of a better way of getting this
information.

								Honza

> +
> +	list_for_each_entry(holder, &bdev->bd_holder_disks, list) {
> +		disk = holder->disk;
> +		if (disk->fops->corrupted_range) {
> +			rc = disk->fops->corrupted_range(disk, bdev, off, len, data);
> +			if (rc != -ENODEV)
> +				break;
> +		}
> +	}
> +	return rc;
> +}
> +
>  static struct bd_holder_disk *bd_find_holder_disk(struct block_device *bdev,
>  						  struct gendisk *disk)
>  {
> @@ -1378,6 +1399,22 @@ void bd_set_nr_sectors(struct block_device *bdev, sector_t sectors)
>  }
>  EXPORT_SYMBOL(bd_set_nr_sectors);
>  
> +int bd_corrupted_range(struct block_device *bdev, loff_t disk_off, loff_t bdev_off, size_t len, void *data)
> +{
> +	struct super_block *sb = get_super(bdev);
> +	int rc = 0;
> +
> +	if (!sb) {
> +		rc = bd_disk_holder_corrupted_range(bdev, disk_off, len, data);
> +		return rc;
> +	} else if (sb->s_op->corrupted_range)
> +		rc = sb->s_op->corrupted_range(sb, bdev, bdev_off, len, data);
> +	drop_super(sb);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL(bd_corrupted_range);
> +
>  static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
>  
>  int bdev_disk_changed(struct block_device *bdev, bool invalidate)
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index ed06209008b8..42290470810d 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -376,6 +376,8 @@ void revalidate_disk_size(struct gendisk *disk, bool verbose);
>  bool bdev_check_media_change(struct block_device *bdev);
>  int __invalidate_device(struct block_device *bdev, bool kill_dirty);
>  void bd_set_nr_sectors(struct block_device *bdev, sector_t sectors);
> +int bd_corrupted_range(struct block_device *bdev, loff_t disk_off,
> +		       loff_t bdev_off, size_t len, void *data);
>  
>  /* for drivers/char/raw.c: */
>  int blkdev_ioctl(struct block_device *, fmode_t, unsigned, unsigned long);
> -- 
> 2.29.2
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
