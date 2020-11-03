Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3392A4611
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 14:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgKCNRb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 08:17:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:44086 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgKCNRb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:17:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 59939ABF4;
        Tue,  3 Nov 2020 13:17:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 774D9DA7D2; Tue,  3 Nov 2020 14:15:50 +0100 (CET)
Date:   Tue, 3 Nov 2020 14:15:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 11/41] btrfs: implement log-structured superblock for
 ZONED mode
Message-ID: <20201103131549.GV6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
References: <cover.1604065156.git.naohiro.aota@wdc.com>
 <eca26372a84d8b8ec2b59d3390f172810ed6f3e4.1604065695.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eca26372a84d8b8ec2b59d3390f172810ed6f3e4.1604065695.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 30, 2020 at 10:51:18PM +0900, Naohiro Aota wrote:
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1723,6 +1723,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
>  static int exclude_super_stripes(struct btrfs_block_group *cache)
>  {
>  	struct btrfs_fs_info *fs_info = cache->fs_info;
> +	bool zoned = btrfs_is_zoned(fs_info);

	const bool

>  	u64 bytenr;
>  	u64 *logical;
>  	int stripe_len;
> @@ -1744,6 +1745,14 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
>  		if (ret)
>  			return ret;
>  
> +		/* shouldn't have super stripes in sequential zones */

		/* Shouldn't ... */

> +		if (zoned && nr) {
> +			btrfs_err(fs_info,
> +				  "Zoned btrfs's block group %llu should not have super blocks",

			"zoned: block group %llu must not contain super block"

> +				  cache->start);
> +			return -EUCLEAN;
> +		}
> +
>  		while (nr--) {
>  			u64 len = min_t(u64, stripe_len,
>  				cache->start + cache->length - logical[nr]);
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 9bc51cff48b8..fd8b970ee92c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3423,10 +3423,17 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
>  {
>  	struct btrfs_super_block *super;
>  	struct page *page;
> -	u64 bytenr;
> +	u64 bytenr, bytenr_orig;
>  	struct address_space *mapping = bdev->bd_inode->i_mapping;
> +	int ret;
> +
> +	bytenr_orig = btrfs_sb_offset(copy_num);
> +	ret = btrfs_sb_log_location_bdev(bdev, copy_num, READ, &bytenr);
> +	if (ret == -ENOENT)
> +		return ERR_PTR(-EINVAL);
> +	else if (ret)
> +		return ERR_PTR(ret);
>  
> -	bytenr = btrfs_sb_offset(copy_num);
>  	if (bytenr + BTRFS_SUPER_INFO_SIZE >= i_size_read(bdev->bd_inode))
>  		return ERR_PTR(-EINVAL);
>  
> @@ -3440,7 +3447,7 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
>  		return ERR_PTR(-ENODATA);
>  	}
>  
> -	if (btrfs_super_bytenr(super) != bytenr) {
> +	if (btrfs_super_bytenr(super) != bytenr_orig) {
>  		btrfs_release_disk_super(super);
>  		return ERR_PTR(-EINVAL);
>  	}
> @@ -3495,7 +3502,8 @@ static int write_dev_supers(struct btrfs_device *device,
>  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>  	int i;
>  	int errors = 0;
> -	u64 bytenr;
> +	int ret;
> +	u64 bytenr, bytenr_orig;
>  
>  	if (max_mirrors == 0)
>  		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
> @@ -3507,12 +3515,21 @@ static int write_dev_supers(struct btrfs_device *device,
>  		struct bio *bio;
>  		struct btrfs_super_block *disk_super;
>  
> -		bytenr = btrfs_sb_offset(i);
> +		bytenr_orig = btrfs_sb_offset(i);
> +		ret = btrfs_sb_log_location(device, i, WRITE, &bytenr);
> +		if (ret == -ENOENT)
> +			continue;
> +		else if (ret < 0) {
> +			btrfs_err(device->fs_info, "couldn't get super block location for mirror %d",
> +				  i);
> +			errors++;
> +			continue;
> +		}
>  		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
>  		    device->commit_total_bytes)
>  			break;
>  
> -		btrfs_set_super_bytenr(sb, bytenr);
> +		btrfs_set_super_bytenr(sb, bytenr_orig);
>  
>  		crypto_shash_digest(shash, (const char *)sb + BTRFS_CSUM_SIZE,
>  				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE,
> @@ -3557,6 +3574,7 @@ static int write_dev_supers(struct btrfs_device *device,
>  			bio->bi_opf |= REQ_FUA;
>  
>  		btrfsic_submit_bio(bio);
> +		btrfs_advance_sb_log(device, i);
>  	}
>  	return errors < i ? 0 : -1;
>  }
> @@ -3573,6 +3591,7 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
>  	int i;
>  	int errors = 0;
>  	bool primary_failed = false;
> +	int ret;
>  	u64 bytenr;
>  
>  	if (max_mirrors == 0)
> @@ -3581,7 +3600,15 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
>  	for (i = 0; i < max_mirrors; i++) {
>  		struct page *page;
>  
> -		bytenr = btrfs_sb_offset(i);
> +		ret = btrfs_sb_log_location(device, i, READ, &bytenr);
> +		if (ret == -ENOENT)

		if (...) {

> +			break;

		} else if (...) {

> +		else if (ret < 0) {
> +			errors++;
> +			if (i == 0)
> +				primary_failed = true;
> +			continue;
> +		}
>  		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
>  		    device->commit_total_bytes)
>  			break;
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1282,7 +1282,8 @@ void btrfs_release_disk_super(struct btrfs_super_block *super)
>  }
>  
>  static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
> -						       u64 bytenr)
> +						       u64 bytenr,
> +						       u64 bytenr_orig)
>  {
>  	struct btrfs_super_block *disk_super;
>  	struct page *page;
> @@ -1313,7 +1314,7 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
>  	/* align our pointer to the offset of the super block */
>  	disk_super = p + offset_in_page(bytenr);
>  
> -	if (btrfs_super_bytenr(disk_super) != bytenr ||
> +	if (btrfs_super_bytenr(disk_super) != bytenr_orig ||
>  	    btrfs_super_magic(disk_super) != BTRFS_MAGIC) {
>  		btrfs_release_disk_super(p);
>  		return ERR_PTR(-EINVAL);
> @@ -1348,7 +1349,8 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
>  	bool new_device_added = false;
>  	struct btrfs_device *device = NULL;
>  	struct block_device *bdev;
> -	u64 bytenr;
> +	u64 bytenr, bytenr_orig;
> +	int ret;
>  
>  	lockdep_assert_held(&uuid_mutex);
>  
> @@ -1358,14 +1360,18 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
>  	 * So, we need to add a special mount option to scan for
>  	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
>  	 */
> -	bytenr = btrfs_sb_offset(0);
>  	flags |= FMODE_EXCL;
>  
>  	bdev = blkdev_get_by_path(path, flags, holder);
>  	if (IS_ERR(bdev))
>  		return ERR_CAST(bdev);
>  
> -	disk_super = btrfs_read_disk_super(bdev, bytenr);
> +	bytenr_orig = btrfs_sb_offset(0);
> +	ret = btrfs_sb_log_location_bdev(bdev, 0, READ, &bytenr);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	disk_super = btrfs_read_disk_super(bdev, bytenr, bytenr_orig);
>  	if (IS_ERR(disk_super)) {
>  		device = ERR_CAST(disk_super);
>  		goto error_bdev_put;
> @@ -2029,6 +2035,11 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
>  		if (IS_ERR(disk_super))
>  			continue;
>  
> +		if (bdev_is_zoned(bdev)) {
> +			btrfs_reset_sb_log_zones(bdev, copy_num);
> +			continue;
> +		}
> +
>  		memset(&disk_super->magic, 0, sizeof(disk_super->magic));
>  
>  		page = virt_to_page(disk_super);
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index ae509699da14..d5487cba203b 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -20,6 +20,25 @@ static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx,
>  	return 0;
>  }
>  
> +static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zone,
> +			    u64 *wp_ret);

Please define sb_write_pointer here instead of the prototype for a
static function.

> +
> +static inline u32 sb_zone_number(u8 shift, int mirror)
> +{
> +	ASSERT(mirror < BTRFS_SUPER_MIRROR_MAX);
> +
> +	switch (mirror) {
> +	case 0:
> +		return 0;
> +	case 1:
> +		return 16;
> +	case 2:
> +		return min(btrfs_sb_offset(mirror) >> shift, 1024ULL);
> +	}
> +
> +	return 0;
> +}
> +
>  static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
>  			       struct blk_zone *zones, unsigned int *nr_zones)
>  {
> @@ -123,6 +142,49 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
>  		goto out;
>  	}
>  
> +	/* validate superblock log */

	/* Validate ... */

> +	nr_zones = 2;
> +	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
> +		u32 sb_zone = sb_zone_number(zone_info->zone_size_shift, i);
> +		u64 sb_wp;
> +
> +		if (sb_zone + 1 >= zone_info->nr_zones)
> +			continue;
> +
> +		sector = sb_zone << (zone_info->zone_size_shift - SECTOR_SHIFT);
> +		ret = btrfs_get_dev_zones(device, sector << SECTOR_SHIFT,
> +					  &zone_info->sb_zones[2 * i],
> +					  &nr_zones);
> +		if (ret)
> +			goto out;
> +		if (nr_zones != 2) {
> +			btrfs_err_in_rcu(device->fs_info,
> +			"failed to read SB log zone info at device %s zone %u",
> +					 rcu_str_deref(device->name), sb_zone);

			"zoned: failed to read super block log zone info at devid %llu zone %u"

> +			ret = -EIO;

What are the possible reasons here? EIO would fit reading error but if
the zone is missing it's more like EUCLEAN.

> +			goto out;
> +		}
> +
> +		/*
> +		 * If zones[0] is conventional, always use the beggining of
> +		 * the zone to record superblock. No need to validate in
> +		 * that case.
> +		 */
> +		if (zone_info->sb_zones[2 * i].type == BLK_ZONE_TYPE_CONVENTIONAL)
> +			continue;
> +
> +		ret = sb_write_pointer(device->bdev,
> +				       &zone_info->sb_zones[2 * i], &sb_wp);
> +		if (ret != -ENOENT && ret) {
> +			btrfs_err_in_rcu(device->fs_info,
> +				"SB log zone corrupted: device %s zone %u",
> +					 rcu_str_deref(device->name), sb_zone);

			"zoned: super block log zone corrupted devid %llu zone %u"

The device path would be also good in all the messages, this could be
tweaked later.

> +			ret = -EUCLEAN;
> +			goto out;
> +		}
> +	}
> +
> +
>  	kfree(zones);
>  
>  	device->zone_info = zone_info;
> @@ -296,3 +358,252 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
>  
>  	return 0;
>  }
> +
> +static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
> +			    u64 *wp_ret)
> +{
> +	bool empty[2];
> +	bool full[2];
> +	sector_t sector;
> +
> +	ASSERT(zones[0].type != BLK_ZONE_TYPE_CONVENTIONAL &&
> +	       zones[1].type != BLK_ZONE_TYPE_CONVENTIONAL);
> +
> +	empty[0] = zones[0].cond == BLK_ZONE_COND_EMPTY;

	empty[0] = (zones[0].cond == BLK_ZONE_COND_EMPTY);

> +	empty[1] = zones[1].cond == BLK_ZONE_COND_EMPTY;
> +	full[0] = zones[0].cond == BLK_ZONE_COND_FULL;
> +	full[1] = zones[1].cond == BLK_ZONE_COND_FULL;

Same

> +
> +	/*
> +	 * Possible state of log buffer zones
> +	 *
> +	 *   E I F
> +	 * E * x 0
> +	 * I 0 x 0
> +	 * F 1 1 C
> +	 *
> +	 * Row: zones[0]
> +	 * Col: zones[1]
> +	 * State:
> +	 *   E: Empty, I: In-Use, F: Full
> +	 * Log position:
> +	 *   *: Special case, no superblock is written
> +	 *   0: Use write pointer of zones[0]
> +	 *   1: Use write pointer of zones[1]
> +	 *   C: Compare SBs from zones[0] and zones[1], use the newer one
> +	 *   x: Invalid state
> +	 */
> +
> +	if (empty[0] && empty[1]) {
> +		/* special case to distinguish no superblock to read */

		/* Special ... */

> +		*wp_ret = zones[0].start << SECTOR_SHIFT;
> +		return -ENOENT;
> +	} else if (full[0] && full[1]) {
> +		/* Compare two super blocks */
> +		struct address_space *mapping = bdev->bd_inode->i_mapping;
> +		struct page *page[2];
> +		struct btrfs_super_block *super[2];
> +		int i;
> +
> +		for (i = 0; i < 2; i++) {
> +			u64 bytenr = ((zones[i].start + zones[i].len) << SECTOR_SHIFT) -
> +				BTRFS_SUPER_INFO_SIZE;
> +
> +			page[i] = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
> +			if (IS_ERR(page[i])) {
> +				if (i == 1)
> +					btrfs_release_disk_super(super[0]);
> +				return PTR_ERR(page[i]);
> +			}
> +			super[i] = page_address(page[i]);
> +		}
> +
> +		if (super[0]->generation > super[1]->generation)
> +			sector = zones[1].start;
> +		else
> +			sector = zones[0].start;
> +
> +		for (i = 0; i < 2; i++)
> +			btrfs_release_disk_super(super[i]);
> +	} else if (!full[0] && (empty[1] || full[1])) {
> +		sector = zones[0].wp;
> +	} else if (full[0]) {
> +		sector = zones[1].wp;
> +	} else {
> +		return -EUCLEAN;
> +	}
> +	*wp_ret = sector << SECTOR_SHIFT;
> +	return 0;
> +}
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -4,6 +4,8 @@
>  #define BTRFS_ZONED_H
>  
>  #include <linux/blkdev.h>
> +#include "volumes.h"
> +#include "disk-io.h"
>  
>  struct btrfs_zoned_device_info {
>  	/*
> @@ -16,6 +18,7 @@ struct btrfs_zoned_device_info {
>  	u32 nr_zones;
>  	unsigned long *seq_zones;
>  	unsigned long *empty_zones;
> +	struct blk_zone sb_zones[2 * BTRFS_SUPER_MIRROR_MAX];
>  };
>  
>  #ifdef CONFIG_BLK_DEV_ZONED
> @@ -25,6 +28,12 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device);
>  void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
>  int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
>  int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info);
> +int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
> +			       u64 *bytenr_ret);
> +int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
> +			  u64 *bytenr_ret);
> +void btrfs_advance_sb_log(struct btrfs_device *device, int mirror);
> +int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror);
>  #else /* CONFIG_BLK_DEV_ZONED */
>  static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>  				     struct blk_zone *zone)
> @@ -48,6 +57,26 @@ static inline int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
>  {
>  	return 0;
>  }

newline

> +static inline int btrfs_sb_log_location_bdev(struct block_device *bdev,
> +					     int mirror, int rw,
> +					     u64 *bytenr_ret)
> +{
> +	*bytenr_ret = btrfs_sb_offset(mirror);
> +	return 0;
> +}

newline

> +static inline int btrfs_sb_log_location(struct btrfs_device *device, int mirror,
> +					int rw, u64 *bytenr_ret)
> +{
> +	*bytenr_ret = btrfs_sb_offset(mirror);
> +	return 0;
> +}

newline

> +static inline void btrfs_advance_sb_log(struct btrfs_device *device,
> +					int mirror) { }

newline

> +static inline int btrfs_reset_sb_log_zones(struct block_device *bdev,
> +					   int mirror)
> +{
> +	return 0;
> +}

newline

>  #endif
>  
>  static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
> @@ -115,4 +144,15 @@ static inline bool btrfs_check_device_zone_type(struct btrfs_fs_info *fs_info,
>  	return bdev_zoned_model(bdev) != BLK_ZONED_HM;
>  }
>  
> +static inline bool btrfs_check_super_location(struct btrfs_device *device,
> +					      u64 pos)
> +{
> +	/*
> +	 * On a non-zoned device, any address is OK. On a zoned device,
> +	 * non-SEQUENTIAL WRITE REQUIRED zones are capable.
> +	 */
> +	return device->zone_info == NULL ||
> +	       !btrfs_dev_is_sequential(device, pos);
> +}
> +
>  #endif
> -- 
> 2.27.0
