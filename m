Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E693448D1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2019 20:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbfFQS4Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jun 2019 14:56:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:48972 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725772AbfFQS4Y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:56:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9CAA7AF0C;
        Mon, 17 Jun 2019 18:56:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C8B66DA8D1; Mon, 17 Jun 2019 20:57:09 +0200 (CEST)
Date:   Mon, 17 Jun 2019 20:57:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 02/19] btrfs: Get zone information of zoned block devices
Message-ID: <20190617185708.GH19057@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-3-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607131025.31996-3-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 07, 2019 at 10:10:08PM +0900, Naohiro Aota wrote:
> If a zoned block device is found, get its zone information (number of zones
> and zone size) using the new helper function btrfs_get_dev_zonetypes().  To
> avoid costly run-time zone report commands to test the device zones type
> during block allocation, attach the seqzones bitmap to the device structure
> to indicate if a zone is sequential or accept random writes.
> 
> This patch also introduces the helper function btrfs_dev_is_sequential() to
> test if the zone storing a block is a sequential write required zone.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/volumes.c | 143 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/volumes.h |  33 +++++++++++
>  2 files changed, 176 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 1c2a6e4b39da..b673178718e3 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -786,6 +786,135 @@ static int btrfs_free_stale_devices(const char *path,
>  	return ret;
>  }
>  
> +static int __btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,

Please drop __ from the name, the pattern where this naming makes sense
does not apply here. It's for cases where teh function wihout
underscores does some extra stuff like locking and the underscored does
not and this is used on some context. I haven't found
btrfs_get_dev_zones in this or other patches.

> +				 struct blk_zone **zones,
> +				 unsigned int *nr_zones, gfp_t gfp_mask)
> +{
> +	struct blk_zone *z = *zones;

This may apply to more places, plese don't use single letter for
anything else than 'i' and similar. 'zone' would be suitable.

> +	int ret;
> +
> +	if (!z) {
> +		z = kcalloc(*nr_zones, sizeof(struct blk_zone), GFP_KERNEL);
> +		if (!z)
> +			return -ENOMEM;
> +	}
> +
> +	ret = blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT,
> +				  z, nr_zones, gfp_mask);
> +	if (ret != 0) {
> +		btrfs_err(device->fs_info, "Get zone at %llu failed %d\n",

No capital letter and no "\n" at the end of the message, that's added by
btrfs_er.

> +			  pos, ret);
> +		return ret;
> +	}
> +
> +	*zones = z;
> +
> +	return 0;
> +}
> +
> +static void btrfs_destroy_dev_zonetypes(struct btrfs_device *device)
> +{
> +	kfree(device->seq_zones);
> +	kfree(device->empty_zones);
> +	device->seq_zones = NULL;
> +	device->empty_zones = NULL;
> +	device->nr_zones = 0;
> +	device->zone_size = 0;
> +	device->zone_size_shift = 0;
> +}
> +
> +int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
> +		       struct blk_zone *zone, gfp_t gfp_mask)
> +{
> +	unsigned int nr_zones = 1;
> +	int ret;
> +
> +	ret = __btrfs_get_dev_zones(device, pos, &zone, &nr_zones, gfp_mask);
> +	if (ret != 0 || !nr_zones)
> +		return ret ? ret : -EIO;
> +
> +	return 0;
> +}
> +
> +int btrfs_get_dev_zonetypes(struct btrfs_device *device)
> +{
> +	struct block_device *bdev = device->bdev;
> +	sector_t nr_sectors = bdev->bd_part->nr_sects;
> +	sector_t sector = 0;
> +	struct blk_zone *zones = NULL;
> +	unsigned int i, n = 0, nr_zones;
> +	int ret;
> +
> +	device->zone_size = 0;
> +	device->zone_size_shift = 0;
> +	device->nr_zones = 0;
> +	device->seq_zones = NULL;
> +	device->empty_zones = NULL;
> +
> +	if (!bdev_is_zoned(bdev))
> +		return 0;
> +
> +	device->zone_size = (u64)bdev_zone_sectors(bdev) << SECTOR_SHIFT;
> +	device->zone_size_shift = ilog2(device->zone_size);
> +	device->nr_zones = nr_sectors >> ilog2(bdev_zone_sectors(bdev));
> +	if (nr_sectors & (bdev_zone_sectors(bdev) - 1))
> +		device->nr_zones++;
> +
> +	device->seq_zones = kcalloc(BITS_TO_LONGS(device->nr_zones),
> +				    sizeof(*device->seq_zones), GFP_KERNEL);

What's the expected range for the allocation size? There's one bit per
zone, so one 4KiB page can hold up to 32768 zones, with 1GiB it's 32TiB
of space on the drive. Ok that seems safe for now.

> +	if (!device->seq_zones)
> +		return -ENOMEM;
> +
> +	device->empty_zones = kcalloc(BITS_TO_LONGS(device->nr_zones),
> +				      sizeof(*device->empty_zones), GFP_KERNEL);
> +	if (!device->empty_zones)
> +		return -ENOMEM;

This leaks device->seq_zones from the current context, though thre are
calls to btrfs_destroy_dev_zonetypes that would clean it up eventually.
It'd be better to clean up here instead of relying on the caller.

> +
> +#define BTRFS_REPORT_NR_ZONES   4096

Please move this to the begining of the file if this is just local to
the .c file and put a short comment explaining the meaning.

> +
> +	/* Get zones type */
> +	while (sector < nr_sectors) {
> +		nr_zones = BTRFS_REPORT_NR_ZONES;
> +		ret = __btrfs_get_dev_zones(device, sector << SECTOR_SHIFT,
> +					    &zones, &nr_zones, GFP_KERNEL);
> +		if (ret != 0 || !nr_zones) {
> +			if (!ret)
> +				ret = -EIO;
> +			goto out;
> +		}
> +
> +		for (i = 0; i < nr_zones; i++) {
> +			if (zones[i].type == BLK_ZONE_TYPE_SEQWRITE_REQ)
> +				set_bit(n, device->seq_zones);
> +			if (zones[i].cond == BLK_ZONE_COND_EMPTY)
> +				set_bit(n, device->empty_zones);
> +			sector = zones[i].start + zones[i].len;
> +			n++;
> +		}
> +	}
> +
> +	if (n != device->nr_zones) {
> +		btrfs_err(device->fs_info,
> +			  "Inconsistent number of zones (%u / %u)\n", n,

lowercase and no "\n"

> +			  device->nr_zones);
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	btrfs_info(device->fs_info,
> +		   "host-%s zoned block device, %u zones of %llu sectors\n",
> +		   bdev_zoned_model(bdev) == BLK_ZONED_HM ? "managed" : "aware",
> +		   device->nr_zones, device->zone_size >> SECTOR_SHIFT);
> +
> +out:
> +	kfree(zones);
> +
> +	if (ret)
> +		btrfs_destroy_dev_zonetypes(device);
> +
> +	return ret;
> +}
> +
>  static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  			struct btrfs_device *device, fmode_t flags,
>  			void *holder)
> @@ -842,6 +971,11 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>  	device->mode = flags;
>  
> +	/* Get zone type information of zoned block devices */
> +	ret = btrfs_get_dev_zonetypes(device);
> +	if (ret != 0)
> +		goto error_brelse;
> +
>  	fs_devices->open_devices++;
>  	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
>  	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
> @@ -1243,6 +1377,7 @@ static void btrfs_close_bdev(struct btrfs_device *device)
>  	}
>  
>  	blkdev_put(device->bdev, device->mode);
> +	btrfs_destroy_dev_zonetypes(device);
>  }
>  
>  static void btrfs_close_one_device(struct btrfs_device *device)
> @@ -2664,6 +2799,13 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  	mutex_unlock(&fs_info->chunk_mutex);
>  	mutex_unlock(&fs_devices->device_list_mutex);
>  
> +	/* Get zone type information of zoned block devices */
> +	ret = btrfs_get_dev_zonetypes(device);
> +	if (ret) {
> +		btrfs_abort_transaction(trans, ret);
> +		goto error_sysfs;

Can this be moved before the locked section so that any failure does not
lead to transaction abort?

The function returns ENOMEM that does not necessarily need to kill the
filesystem. And EIO which means that some faulty device is being added
to the filesystem but this again should fail early.

> +	}
> +
>  	if (seeding_dev) {
>  		mutex_lock(&fs_info->chunk_mutex);
>  		ret = init_first_rw_device(trans);
> @@ -2729,6 +2871,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  	return ret;
>  
>  error_sysfs:
> +	btrfs_destroy_dev_zonetypes(device);
>  	btrfs_sysfs_rm_device_link(fs_devices, device);
>  	mutex_lock(&fs_info->fs_devices->device_list_mutex);
>  	mutex_lock(&fs_info->chunk_mutex);
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index b8a0e8d0672d..1599641e216c 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -62,6 +62,16 @@ struct btrfs_device {
>  
>  	struct block_device *bdev;
>  
> +	/*
> +	 * Number of zones, zone size and types of zones if bdev is a
> +	 * zoned block device.
> +	 */
> +	u64 zone_size;
> +	u8  zone_size_shift;

So the zone_size is always power of two? I may be missing something, but
I wonder if the calculations based on shifts are safe.

> +	u32 nr_zones;
> +	unsigned long *seq_zones;
> +	unsigned long *empty_zones;
> +
>  	/* the mode sent to blkdev_get */
>  	fmode_t mode;
>  
> @@ -476,6 +486,28 @@ int btrfs_finish_chunk_alloc(struct btrfs_trans_handle *trans,
>  int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset);
>  struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
>  				       u64 logical, u64 length);
> +int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
> +		       struct blk_zone *zone, gfp_t gfp_mask);
> +
> +static inline int btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
> +{
> +	unsigned int zno = pos >> device->zone_size_shift;

The types don't match here, pos is u64 and I'm not sure if it's
guaranteed that the value after shift will fit ti unsigned int.

> +
> +	if (!device->seq_zones)
> +		return 1;
> +
> +	return test_bit(zno, device->seq_zones);
> +}
> +
> +static inline int btrfs_dev_is_empty_zone(struct btrfs_device *device, u64 pos)
> +{
> +	unsigned int zno = pos >> device->zone_size_shift;

Same.

> +
> +	if (!device->empty_zones)
> +		return 0;
> +
> +	return test_bit(zno, device->empty_zones);
> +}
>  
>  static inline void btrfs_dev_stat_inc(struct btrfs_device *dev,
>  				      int index)
> @@ -568,5 +600,6 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
>  
>  int btrfs_bg_type_to_factor(u64 flags);
>  int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
> +int btrfs_get_dev_zonetypes(struct btrfs_device *device);
>  
>  #endif
> -- 
> 2.21.0
