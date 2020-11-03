Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C729A2A4670
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 14:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgKCNaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 08:30:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:42506 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729233AbgKCNaW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:30:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7A345AB0E;
        Tue,  3 Nov 2020 13:30:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CB5F9DA7D2; Tue,  3 Nov 2020 14:28:42 +0100 (CET)
Date:   Tue, 3 Nov 2020 14:28:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 14/41] btrfs: load zone's alloction offset
Message-ID: <20201103132842.GX6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
References: <cover.1604065156.git.naohiro.aota@wdc.com>
 <1bbbf9d4ade0c5aeeaebd0772c90f360ceafa9b3.1604065695.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bbbf9d4ade0c5aeeaebd0772c90f360ceafa9b3.1604065695.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 30, 2020 at 10:51:21PM +0900, Naohiro Aota wrote:
> @@ -733,3 +739,150 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
>  
>  	return 0;
>  }
> +
> +int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
> +{
> +	struct btrfs_fs_info *fs_info = cache->fs_info;
> +	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
> +	struct extent_map *em;
> +	struct map_lookup *map;
> +	struct btrfs_device *device;
> +	u64 logical = cache->start;
> +	u64 length = cache->length;
> +	u64 physical = 0;
> +	int ret;
> +	int i;
> +	unsigned int nofs_flag;
> +	u64 *alloc_offsets = NULL;
> +	u32 num_sequential = 0, num_conventional = 0;
> +
> +	if (!btrfs_is_zoned(fs_info))
> +		return 0;
> +
> +	/* Sanity check */
> +	if (!IS_ALIGNED(length, fs_info->zone_size)) {
> +		btrfs_err(fs_info, "unaligned block group at %llu + %llu",

		"zoned: block group %llu len %llu unaligned to zone size %u"

> +			  logical, length);
> +		return -EIO;
> +	}
> +
> +	/* Get the chunk mapping */
> +	read_lock(&em_tree->lock);
> +	em = lookup_extent_mapping(em_tree, logical, length);
> +	read_unlock(&em_tree->lock);
> +
> +	if (!em)
> +		return -EINVAL;
> +
> +	map = em->map_lookup;
> +
> +	/*
> +	 * Get the zone type: if the group is mapped to a non-sequential zone,
> +	 * there is no need for the allocation offset (fit allocation is OK).
> +	 */
> +	alloc_offsets = kcalloc(map->num_stripes, sizeof(*alloc_offsets),
> +				GFP_NOFS);
> +	if (!alloc_offsets) {
> +		free_extent_map(em);
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < map->num_stripes; i++) {
> +		bool is_sequential;
> +		struct blk_zone zone;
> +
> +		device = map->stripes[i].dev;
> +		physical = map->stripes[i].physical;
> +
> +		if (device->bdev == NULL) {
> +			alloc_offsets[i] = WP_MISSING_DEV;
> +			continue;
> +		}
> +
> +		is_sequential = btrfs_dev_is_sequential(device, physical);
> +		if (is_sequential)
> +			num_sequential++;
> +		else
> +			num_conventional++;
> +
> +		if (!is_sequential) {
> +			alloc_offsets[i] = WP_CONVENTIONAL;
> +			continue;
> +		}
> +
> +		/*
> +		 * This zone will be used for allocation, so mark this
> +		 * zone non-empty.
> +		 */
> +		btrfs_dev_clear_zone_empty(device, physical);
> +
> +		/*
> +		 * The group is mapped to a sequential zone. Get the zone write
> +		 * pointer to determine the allocation offset within the zone.
> +		 */
> +		WARN_ON(!IS_ALIGNED(physical, fs_info->zone_size));
> +		nofs_flag = memalloc_nofs_save();
> +		ret = btrfs_get_dev_zone(device, physical, &zone);
> +		memalloc_nofs_restore(nofs_flag);
> +		if (ret == -EIO || ret == -EOPNOTSUPP) {
> +			ret = 0;
> +			alloc_offsets[i] = WP_MISSING_DEV;
> +			continue;
> +		} else if (ret) {
> +			goto out;
> +		}
> +
> +		switch (zone.cond) {
> +		case BLK_ZONE_COND_OFFLINE:
> +		case BLK_ZONE_COND_READONLY:
> +			btrfs_err(fs_info, "Offline/readonly zone %llu",

			"zoned: offline/readonly zone %llu on device %s (devid %llu)"

> +				  physical >> device->zone_info->zone_size_shift);
> +			alloc_offsets[i] = WP_MISSING_DEV;
> +			break;
> +		case BLK_ZONE_COND_EMPTY:
> +			alloc_offsets[i] = 0;
> +			break;
> +		case BLK_ZONE_COND_FULL:
> +			alloc_offsets[i] = fs_info->zone_size;
> +			break;
> +		default:
> +			/* Partially used zone */
> +			alloc_offsets[i] =
> +				((zone.wp - zone.start) << SECTOR_SHIFT);
> +			break;
> +		}
> +	}
> +
> +	if (num_conventional > 0) {
> +		/*
> +		 * Since conventional zones does not have write pointer, we

				  ... zones do not ...

> +		 * cannot determine alloc_offset from the pointer
> +		 */
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
> +	case 0: /* single */
> +		cache->alloc_offset = alloc_offsets[0];
> +		break;
> +	case BTRFS_BLOCK_GROUP_DUP:
> +	case BTRFS_BLOCK_GROUP_RAID1:
> +	case BTRFS_BLOCK_GROUP_RAID0:
> +	case BTRFS_BLOCK_GROUP_RAID10:
> +	case BTRFS_BLOCK_GROUP_RAID5:
> +	case BTRFS_BLOCK_GROUP_RAID6:
> +		/* non-SINGLE profiles are not supported yet */
> +	default:
> +		btrfs_err(fs_info, "Unsupported profile on ZONED %s",

		"zoned: profile %s not supported"

> +			  btrfs_bg_type_to_raid_name(map->type));
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +out:
> +	kfree(alloc_offsets);
> +	free_extent_map(em);
> +
> +	return ret;
> +}
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index 24dd0c9561f9..90ed43a25595 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -39,6 +39,7 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
>  int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
>  			    u64 length, u64 *bytes);
>  int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size);
> +int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache);
>  #else /* CONFIG_BLK_DEV_ZONED */
>  static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>  				     struct blk_zone *zone)
> @@ -99,6 +100,11 @@ static inline int btrfs_ensure_empty_zones(struct btrfs_device *device,
>  {
>  	return 0;
>  }

newline

> +static inline int btrfs_load_block_group_zone_info(
> +	struct btrfs_block_group *cache)
> +{
> +	return 0;
> +}

newline

>  #endif
>  
>  static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
> -- 
> 2.27.0
