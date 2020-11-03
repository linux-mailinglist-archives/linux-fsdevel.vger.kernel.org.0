Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED8E2A4642
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 14:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgKCNZg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 08:25:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:36008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729043AbgKCNZg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:25:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF3DAAB0E;
        Tue,  3 Nov 2020 13:25:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E52BFDA7D2; Tue,  3 Nov 2020 14:23:55 +0100 (CET)
Date:   Tue, 3 Nov 2020 14:23:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 12/41] btrfs: implement zoned chunk allocator
Message-ID: <20201103132355.GW6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
References: <cover.1604065156.git.naohiro.aota@wdc.com>
 <5b9798f6e4c317e6a2c433ef88ffeabe00b93bb3.1604065695.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b9798f6e4c317e6a2c433ef88ffeabe00b93bb3.1604065695.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 30, 2020 at 10:51:19PM +0900, Naohiro Aota wrote:
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1416,6 +1416,14 @@ static bool contains_pending_extent(struct btrfs_device *device, u64 *start,
>  	return false;
>  }
>  
> +static inline u64 dev_extent_search_start_zoned(struct btrfs_device *device,
> +						u64 start)
> +{
> +	start = max_t(u64, start,
> +		      max_t(u64, device->zone_info->zone_size, SZ_1M));

Can you rewrite that as ifs?

> +	return btrfs_zone_align(device, start);
> +}
> +
>  static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
>  {
>  	switch (device->fs_devices->chunk_alloc_policy) {
> @@ -1426,11 +1434,57 @@ static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
>  		 * make sure to start at an offset of at least 1MB.
>  		 */
>  		return max_t(u64, start, SZ_1M);
> +	case BTRFS_CHUNK_ALLOC_ZONED:
> +		return dev_extent_search_start_zoned(device, start);
>  	default:
>  		BUG();
>  	}
>  }
>  
> +static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
> +					u64 *hole_start, u64 *hole_size,
> +					u64 num_bytes)
> +{
> +	u64 zone_size = device->zone_info->zone_size;
> +	u64 pos;
> +	int ret;
> +	int changed = 0;
> +
> +	ASSERT(IS_ALIGNED(*hole_start, zone_size));
> +
> +	while (*hole_size > 0) {
> +		pos = btrfs_find_allocatable_zones(device, *hole_start,
> +						   *hole_start + *hole_size,
> +						   num_bytes);
> +		if (pos != *hole_start) {
> +			*hole_size = *hole_start + *hole_size - pos;
> +			*hole_start = pos;
> +			changed = 1;
> +			if (*hole_size < num_bytes)
> +				break;
> +		}
> +
> +		ret = btrfs_ensure_empty_zones(device, pos, num_bytes);
> +
> +		/* range is ensured to be empty */

		/* Range ... */

> +		if (!ret)
> +			return changed;
> +
> +		/* given hole range was invalid (outside of device) */

		/* Given ... */

> +		if (ret == -ERANGE) {
> +			*hole_start += *hole_size;
> +			*hole_size = 0;
> +			return 1;
> +		}
> +
> +		*hole_start += zone_size;
> +		*hole_size -= zone_size;
> +		changed = 1;
> +	}
> +
> +	return changed;
> +}
> +
>  /**
>   * dev_extent_hole_check - check if specified hole is suitable for allocation
>   * @device:	the device which we have the hole
> @@ -1463,6 +1517,10 @@ static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
>  	case BTRFS_CHUNK_ALLOC_REGULAR:
>  		/* No extra check */
>  		break;
> +	case BTRFS_CHUNK_ALLOC_ZONED:
> +		changed |= dev_extent_hole_check_zoned(device, hole_start,
> +						       hole_size, num_bytes);
> +		break;
>  	default:
>  		BUG();
>  	}
> @@ -1517,6 +1575,9 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
>  
>  	search_start = dev_extent_search_start(device, search_start);
>  
> +	WARN_ON(device->zone_info &&
> +		!IS_ALIGNED(num_bytes, device->zone_info->zone_size));
> +
>  	path = btrfs_alloc_path();
>  	if (!path)
>  		return -ENOMEM;
> @@ -4907,6 +4968,37 @@ static void init_alloc_chunk_ctl_policy_regular(
>  	ctl->dev_extent_min = BTRFS_STRIPE_LEN * ctl->dev_stripes;
>  }
>  
> +static void
> +init_alloc_chunk_ctl_policy_zoned(struct btrfs_fs_devices *fs_devices,
> +				  struct alloc_chunk_ctl *ctl)

static void init_alloc_chunk_ctl_policy_zoned(

Ie. type and name on one line

> +{
> +	u64 zone_size = fs_devices->fs_info->zone_size;
> +	u64 limit;
> +	int min_num_stripes = ctl->devs_min * ctl->dev_stripes;
> +	int min_data_stripes = (min_num_stripes - ctl->nparity) / ctl->ncopies;
> +	u64 min_chunk_size = min_data_stripes * zone_size;
> +	u64 type = ctl->type;
> +
> +	ctl->max_stripe_size = zone_size;
> +	if (type & BTRFS_BLOCK_GROUP_DATA) {
> +		ctl->max_chunk_size = round_down(BTRFS_MAX_DATA_CHUNK_SIZE,
> +						 zone_size);
> +	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
> +		ctl->max_chunk_size = ctl->max_stripe_size;
> +	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
> +		ctl->max_chunk_size = 2 * ctl->max_stripe_size;
> +		ctl->devs_max = min_t(int, ctl->devs_max,
> +				      BTRFS_MAX_DEVS_SYS_CHUNK);
> +	}
> +
> +	/* We don't want a chunk larger than 10% of writable space */
> +	limit = max(round_down(div_factor(fs_devices->total_rw_bytes, 1),
> +			       zone_size),
> +		    min_chunk_size);
> +	ctl->max_chunk_size = min(limit, ctl->max_chunk_size);
> +	ctl->dev_extent_min = zone_size * ctl->dev_stripes;
> +}
> +
>  static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
>  				 struct alloc_chunk_ctl *ctl)
>  {
> @@ -4927,6 +5019,9 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
>  	case BTRFS_CHUNK_ALLOC_REGULAR:
>  		init_alloc_chunk_ctl_policy_regular(fs_devices, ctl);
>  		break;
> +	case BTRFS_CHUNK_ALLOC_ZONED:
> +		init_alloc_chunk_ctl_policy_zoned(fs_devices, ctl);
> +		break;
>  	default:
>  		BUG();
>  	}
> @@ -5053,6 +5148,40 @@ static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl,
>  	return 0;
>  }
>  
> +static int decide_stripe_size_zoned(struct alloc_chunk_ctl *ctl,
> +				    struct btrfs_device_info *devices_info)
> +{
> +	u64 zone_size = devices_info[0].dev->zone_info->zone_size;
> +	/* number of stripes that count for block group size */

	/* Number ... */

> +	int data_stripes;
> +
> +	/*
> +	 * It should hold because:
> +	 *    dev_extent_min == dev_extent_want == zone_size * dev_stripes
> +	 */
> +	ASSERT(devices_info[ctl->ndevs - 1].max_avail == ctl->dev_extent_min);
> +
> +	ctl->stripe_size = zone_size;
> +	ctl->num_stripes = ctl->ndevs * ctl->dev_stripes;
> +	data_stripes = (ctl->num_stripes - ctl->nparity) / ctl->ncopies;
> +
> +	/*
> +	 * stripe_size is fixed in ZONED. Reduce ndevs instead.

/* One line comment if it fits to 80 cols */

> +	 */
> +	if (ctl->stripe_size * data_stripes > ctl->max_chunk_size) {
> +		ctl->ndevs = div_u64(div_u64(ctl->max_chunk_size * ctl->ncopies,
> +					     ctl->stripe_size) + ctl->nparity,
> +				     ctl->dev_stripes);
> +		ctl->num_stripes = ctl->ndevs * ctl->dev_stripes;
> +		data_stripes = (ctl->num_stripes - ctl->nparity) / ctl->ncopies;
> +		ASSERT(ctl->stripe_size * data_stripes <= ctl->max_chunk_size);
> +	}
> +
> +	ctl->chunk_size = ctl->stripe_size * data_stripes;
> +
> +	return 0;
> +}
> +
>  static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
>  			      struct alloc_chunk_ctl *ctl,
>  			      struct btrfs_device_info *devices_info)
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -607,3 +610,126 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
>  				sb_zone << zone_sectors_shift, zone_sectors * 2,
>  				GFP_NOFS);
>  }
> +
> +/*
> + * btrfs_check_allocatable_zones - find allocatable zones within give region
> + * @device:	the device to allocate a region
> + * @hole_start: the position of the hole to allocate the region
> + * @num_bytes:	the size of wanted region
> + * @hole_size:	the size of hole
> + *
> + * Allocatable region should not contain any superblock locations.
> + */
> +u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
> +				 u64 hole_end, u64 num_bytes)
> +{
> +	struct btrfs_zoned_device_info *zinfo = device->zone_info;
> +	u8 shift = zinfo->zone_size_shift;
> +	u64 nzones = num_bytes >> shift;
> +	u64 pos = hole_start;
> +	u64 begin, end;
> +	u64 sb_pos;
> +	bool have_sb;
> +	int i;
> +
> +	ASSERT(IS_ALIGNED(hole_start, zinfo->zone_size));
> +	ASSERT(IS_ALIGNED(num_bytes, zinfo->zone_size));
> +
> +	while (pos < hole_end) {
> +		begin = pos >> shift;
> +		end = begin + nzones;
> +
> +		if (end > zinfo->nr_zones)
> +			return hole_end;
> +
> +		/* check if zones in the region are all empty */

		/* Check ... */

> +		if (btrfs_dev_is_sequential(device, pos) &&
> +		    find_next_zero_bit(zinfo->empty_zones, end, begin) != end) {
> +			pos += zinfo->zone_size;
> +			continue;
> +		}
> +
> +		have_sb = false;
> +		for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
> +			sb_pos = sb_zone_number(zinfo->zone_size, i);
> +			if (!(end < sb_pos || sb_pos + 1 < begin)) {
> +				have_sb = true;
> +				pos = (sb_pos + 2) << shift;
> +				break;
> +			}
> +		}
> +		if (!have_sb)
> +			break;
> +	}
> +
> +	return pos;
> +}
> +
> +int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
> +			    u64 length, u64 *bytes)
> +{
> +	int ret;
> +
> +	*bytes = 0;
> +	ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_RESET,
> +			       physical >> SECTOR_SHIFT, length >> SECTOR_SHIFT,
> +			       GFP_NOFS);
> +	if (ret)
> +		return ret;
> +
> +	*bytes = length;
> +	while (length) {
> +		btrfs_dev_set_zone_empty(device, physical);
> +		physical += device->zone_info->zone_size;
> +		length -= device->zone_info->zone_size;
> +	}
> +
> +	return 0;
> +}
> +
> +int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
> +{
> +	struct btrfs_zoned_device_info *zinfo = device->zone_info;
> +	u8 shift = zinfo->zone_size_shift;
> +	unsigned long begin = start >> shift;
> +	unsigned long end = (start + size) >> shift;
> +	u64 pos;
> +	int ret;
> +
> +	ASSERT(IS_ALIGNED(start, zinfo->zone_size));
> +	ASSERT(IS_ALIGNED(size, zinfo->zone_size));
> +
> +	if (end > zinfo->nr_zones)
> +		return -ERANGE;
> +
> +	/* all the zones are conventional */

	/* All ... */

> +	if (find_next_bit(zinfo->seq_zones, begin, end) == end)
> +		return 0;
> +
> +	/* all the zones are sequential and empty */

	/* All ... */

> +	if (find_next_zero_bit(zinfo->seq_zones, begin, end) == end &&
> +	    find_next_zero_bit(zinfo->empty_zones, begin, end) == end)
> +		return 0;
> +
> +	for (pos = start; pos < start + size; pos += zinfo->zone_size) {
> +		u64 reset_bytes;
> +
> +		if (!btrfs_dev_is_sequential(device, pos) ||
> +		    btrfs_dev_is_empty_zone(device, pos))
> +			continue;
> +
> +		/* free regions should be empty */

		/* Free ... */

> +		btrfs_warn_in_rcu(
> +			device->fs_info,
> +			"resetting device %s zone %llu for allocation",

		"zoned: resetting device %s (devid %llu) zone %llu for allocation

> +			rcu_str_deref(device->name), pos >> shift);
> +		WARN_ON_ONCE(1);
> +
> +		ret = btrfs_reset_device_zone(device, pos, zinfo->zone_size,
> +					      &reset_bytes);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index 447c4e5ffcbb..24dd0c9561f9 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -34,6 +34,11 @@ int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
>  			  u64 *bytenr_ret);
>  void btrfs_advance_sb_log(struct btrfs_device *device, int mirror);
>  int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror);
> +u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
> +				 u64 hole_end, u64 num_bytes);
> +int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
> +			    u64 length, u64 *bytes);
> +int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size);
>  #else /* CONFIG_BLK_DEV_ZONED */
>  static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>  				     struct blk_zone *zone)
> @@ -77,6 +82,23 @@ static inline int btrfs_reset_sb_log_zones(struct block_device *bdev,
>  {
>  	return 0;
>  }

newline

> +static inline u64 btrfs_find_allocatable_zones(struct btrfs_device *device,
> +					       u64 hole_start, u64 hole_end,
> +					       u64 num_bytes)
> +{
> +	return hole_start;
> +}

newline

> +static inline int btrfs_reset_device_zone(struct btrfs_device *device,
> +					  u64 physical, u64 length, u64 *bytes)
> +{
> +	*bytes = 0;
> +	return 0;
> +}

newline

> +static inline int btrfs_ensure_empty_zones(struct btrfs_device *device,
> +					   u64 start, u64 size)
> +{
> +	return 0;
> +}

newline

>  #endif
>  
>  static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
> @@ -155,4 +177,12 @@ static inline bool btrfs_check_super_location(struct btrfs_device *device,
>  	       !btrfs_dev_is_sequential(device, pos);
>  }
>  
> +static inline u64 btrfs_zone_align(struct btrfs_device *device, u64 pos)

I can't tell from the name what it does, something like
btrfs_align_offset_to_zone would be more clear.

> +{
> +	if (!device->zone_info)
> +		return pos;
> +
> +	return ALIGN(pos, device->zone_info->zone_size);
> +}
> +
>  #endif
> -- 
> 2.27.0
