Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB092F21C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 22:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbhAKVZW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 16:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbhAKVZV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:25:21 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201D4C061794
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 13:24:41 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id b9so333256qtr.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 13:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4T+K5UpI7h8e60O6SxSJZbs2CEk5XPra4sYje8ET1VM=;
        b=DMHrlff4RAnLrxAYgm5KaUNzUfpzY0rRa5bdcrqu3l2mh8ii5A1NcTy52mBG41e2U8
         ztVTpV7zi/nCiolL6mc+VrwrM6p1H/scIBMChNUWGb25iTMFkyHmJ8NRsk2wRyjNq0Zg
         kM+leMh/3/4GebYnqXK3hteq1uxfw6tgH7yAb8je09TcEGfJo3872DgE8Q4GZeLYgzlB
         dubW+ZFuX9ZWuoYZgkZ/1ks+TI5fHt+3ITfXc9fdwV0uk/4q5EqNHcT4npvSMEYeMfMR
         cV3pu4Fw9Y0wsgdQ1NcfnIBArwnIb7i7pTLiAlU8WBhxPhCSllJY+w5Qdx52uiyXMMAi
         Yo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4T+K5UpI7h8e60O6SxSJZbs2CEk5XPra4sYje8ET1VM=;
        b=Q2fNbBdx1yW/T7CcPxw0WBwtHaADrzRXk8zueyLdcLJagLar0NIKpF04HPJflHSye7
         /MKRyK6A+UXWbce9e/8nyDMcON4NIeeBoZss1Wk4N3hX83tDUN9/KW+zcNz5CJk5Qc78
         VAEVNqcB5wdzHqOPa0fwYrnez5LFooDMQ7gj53vw/ut0fe6MH4WR8ZGNJyEGVpao8mii
         SAPKy1NvYWVhKv28TqN1TUb8DWEW7dNSjhYgFuNvqV7B41VJ1shXWcgLSWmhcazTRtTs
         Lu182o+VYGyFV+jBSoh+U+wSYb1yyXBNzHlRXgrI48tud/oUmuRBAV2USko3ZDVN9pSA
         CEXA==
X-Gm-Message-State: AOAM533g5KI8fggXlGzuz492Ldacij4JiYfJJubj6CfFepJlQeEPOqqQ
        h8FgFXFyNcjagmxgbOm3CxBgxw==
X-Google-Smtp-Source: ABdhPJwfDGZfymcWueQdyO0KsVYCtAnzLckTGtbkTpPoaGlS07SdBtWbgBMkGY4RfPO2mkfuKAyKDw==
X-Received: by 2002:ac8:220a:: with SMTP id o10mr1565682qto.280.1610400280213;
        Mon, 11 Jan 2021 13:24:40 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d14sm375264qtg.97.2021.01.11.13.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 13:24:39 -0800 (PST)
Subject: Re: [PATCH v11 09/40] btrfs: implement zoned chunk allocator
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <6c977b7099812637cff36d09ac1a8e6ea2e00519.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e85bee22-a100-f9b3-8c03-ac216ad97a85@toxicpanda.com>
Date:   Mon, 11 Jan 2021 16:24:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <6c977b7099812637cff36d09ac1a8e6ea2e00519.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/21/20 10:49 PM, Naohiro Aota wrote:
> This commit implements a zoned chunk/dev_extent allocator. The zoned
> allocator aligns the device extents to zone boundaries, so that a zone
> reset affects only the device extent and does not change the state of
> blocks in the neighbor device extents.
> 
> Also, it checks that a region allocation is not overlapping any of the
> super block zones, and ensures the region is empty.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/volumes.c | 169 ++++++++++++++++++++++++++++++++++++++++-----
>   fs/btrfs/volumes.h |   1 +
>   fs/btrfs/zoned.c   | 144 ++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/zoned.h   |  25 +++++++
>   4 files changed, 323 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 2cdb5fe3e423..19c76cf9d2d2 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1424,11 +1424,62 @@ static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
>   		 * make sure to start at an offset of at least 1MB.
>   		 */
>   		return max_t(u64, start, SZ_1M);
> +	case BTRFS_CHUNK_ALLOC_ZONED:
> +		/*
> +		 * We don't care about the starting region like regular
> +		 * allocator, because we anyway use/reserve the first two
> +		 * zones for superblock logging.
> +		 */
> +		return ALIGN(start, device->zone_info->zone_size);
>   	default:
>   		BUG();
>   	}
>   }
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
> +		/* Range is ensured to be empty */
> +		if (!ret)
> +			return changed;
> +
> +		/* Given hole range was invalid (outside of device) */
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
>   /**
>    * dev_extent_hole_check - check if specified hole is suitable for allocation
>    * @device:	the device which we have the hole
> @@ -1445,24 +1496,39 @@ static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
>   	bool changed = false;
>   	u64 hole_end = *hole_start + *hole_size;
>   
> -	/*
> -	 * Check before we set max_hole_start, otherwise we could end up
> -	 * sending back this offset anyway.
> -	 */
> -	if (contains_pending_extent(device, hole_start, *hole_size)) {
> -		if (hole_end >= *hole_start)
> -			*hole_size = hole_end - *hole_start;
> -		else
> -			*hole_size = 0;
> -		changed = true;
> -	}
> +	for (;;) {
> +		/*
> +		 * Check before we set max_hole_start, otherwise we could end up
> +		 * sending back this offset anyway.
> +		 */
> +		if (contains_pending_extent(device, hole_start, *hole_size)) {
> +			if (hole_end >= *hole_start)
> +				*hole_size = hole_end - *hole_start;
> +			else
> +				*hole_size = 0;
> +			changed = true;
> +		}
> +
> +		switch (device->fs_devices->chunk_alloc_policy) {
> +		case BTRFS_CHUNK_ALLOC_REGULAR:
> +			/* No extra check */
> +			break;
> +		case BTRFS_CHUNK_ALLOC_ZONED:
> +			if (dev_extent_hole_check_zoned(device, hole_start,
> +							hole_size, num_bytes)) {
> +				changed = true;
> +				/*
> +				 * The changed hole can contain pending
> +				 * extent. Loop again to check that.
> +				 */
> +				continue;
> +			}
> +			break;
> +		default:
> +			BUG();
> +		}
>   
> -	switch (device->fs_devices->chunk_alloc_policy) {
> -	case BTRFS_CHUNK_ALLOC_REGULAR:
> -		/* No extra check */
>   		break;
> -	default:
> -		BUG();
>   	}
>   
>   	return changed;
> @@ -1515,6 +1581,9 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
>   
>   	search_start = dev_extent_search_start(device, search_start);
>   
> +	WARN_ON(device->zone_info &&
> +		!IS_ALIGNED(num_bytes, device->zone_info->zone_size));
> +
>   	path = btrfs_alloc_path();
>   	if (!path)
>   		return -ENOMEM;
> @@ -4913,6 +4982,37 @@ static void init_alloc_chunk_ctl_policy_regular(
>   	ctl->dev_extent_min = BTRFS_STRIPE_LEN * ctl->dev_stripes;
>   }
>   
> +static void init_alloc_chunk_ctl_policy_zoned(
> +				      struct btrfs_fs_devices *fs_devices,
> +				      struct alloc_chunk_ctl *ctl)
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
>   static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
>   				 struct alloc_chunk_ctl *ctl)
>   {
> @@ -4933,6 +5033,9 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
>   	case BTRFS_CHUNK_ALLOC_REGULAR:
>   		init_alloc_chunk_ctl_policy_regular(fs_devices, ctl);
>   		break;
> +	case BTRFS_CHUNK_ALLOC_ZONED:
> +		init_alloc_chunk_ctl_policy_zoned(fs_devices, ctl);
> +		break;
>   	default:
>   		BUG();
>   	}
> @@ -5059,6 +5162,38 @@ static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl,
>   	return 0;
>   }
>   
> +static int decide_stripe_size_zoned(struct alloc_chunk_ctl *ctl,
> +				    struct btrfs_device_info *devices_info)
> +{
> +	u64 zone_size = devices_info[0].dev->zone_info->zone_size;
> +	/* Number of stripes that count for block group size */
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
> +	/* stripe_size is fixed in ZONED. Reduce ndevs instead. */
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
>   static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
>   			      struct alloc_chunk_ctl *ctl,
>   			      struct btrfs_device_info *devices_info)
> @@ -5086,6 +5221,8 @@ static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
>   	switch (fs_devices->chunk_alloc_policy) {
>   	case BTRFS_CHUNK_ALLOC_REGULAR:
>   		return decide_stripe_size_regular(ctl, devices_info);
> +	case BTRFS_CHUNK_ALLOC_ZONED:
> +		return decide_stripe_size_zoned(ctl, devices_info);
>   	default:
>   		BUG();
>   	}
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 59d9d47f173d..c8841b714f2e 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -216,6 +216,7 @@ BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
>   
>   enum btrfs_chunk_allocation_policy {
>   	BTRFS_CHUNK_ALLOC_REGULAR,
> +	BTRFS_CHUNK_ALLOC_ZONED,
>   };
>   
>   /*
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index fc43a650cd79..b1ece6b978dd 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1,11 +1,13 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
> +#include <linux/bitops.h>
>   #include <linux/slab.h>
>   #include <linux/blkdev.h>
>   #include "ctree.h"
>   #include "volumes.h"
>   #include "zoned.h"
>   #include "rcu-string.h"
> +#include "disk-io.h"
>   
>   /* Maximum number of zones to report per blkdev_report_zones() call */
>   #define BTRFS_REPORT_NR_ZONES   4096
> @@ -529,6 +531,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>   
>   	fs_info->zone_size = zone_size;
>   	fs_info->max_zone_append_size = max_zone_append_size;
> +	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
>   
>   	/*
>   	 * Check mount options here, because we might change fs_info->zoned
> @@ -746,3 +749,144 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
>   				sb_zone << zone_sectors_shift,
>   				zone_sectors * BTRFS_NR_SB_LOG_ZONES, GFP_NOFS);
>   }
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
> +		/* Check if zones in the region are all empty */
> +		if (btrfs_dev_is_sequential(device, pos) &&
> +		    find_next_zero_bit(zinfo->empty_zones, end, begin) != end) {
> +			pos += zinfo->zone_size;
> +			continue;
> +		}
> +
> +		have_sb = false;
> +		for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
> +			u32 sb_zone;
> +			u64 sb_pos;
> +
> +			sb_zone = sb_zone_number(shift, i);
> +			if (!(end <= sb_zone ||
> +			      sb_zone + BTRFS_NR_SB_LOG_ZONES <= begin)) {
> +				have_sb = true;
> +				pos = ((u64)sb_zone + BTRFS_NR_SB_LOG_ZONES) << shift;
> +				break;
> +			}
> +
> +			/*
> +			 * We also need to exclude regular superblock
> +			 * positions
> +			 */
> +			sb_pos = btrfs_sb_offset(i);
> +			if (!(pos + num_bytes <= sb_pos ||
> +			      sb_pos + BTRFS_SUPER_INFO_SIZE <= pos)) {
> +				have_sb = true;
> +				pos = ALIGN(sb_pos + BTRFS_SUPER_INFO_SIZE,
> +					    zinfo->zone_size);
> +				break;
> +			}
> +		}
> +		if (!have_sb)
> +			break;
> +

Extra newline here, other than that you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
