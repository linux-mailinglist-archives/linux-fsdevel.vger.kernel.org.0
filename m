Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71BC2A34EE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 21:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgKBUKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 15:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgKBUKD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:10:03 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F608C061A04
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 12:10:01 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id p3so12650129qkk.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 12:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=azwsIqjDyKsdKWJiEFW44oNxyCcrXTQzLW05xfFdK0Q=;
        b=0AAQRTzjVpErkcTinWh0ArUS/tpCHXiLx9PmEbLnLHxSP77pK/68tg0hH15mO+7kML
         K9/mcgTfUTmYuz9Rjyvd9064wDVIOoaQaYVmtS8s2TnKYOMdq6kkWtcng106IK9ypqba
         dPYER6P2zhXm485uCih9eTpTp0UG4mjKEm8cxRgttCbko6Z1yD4Q0WmYQ54DD0Aqsc8j
         njcVHgShTRjx2bz7jxoVGXhNyDzyd7LVtYFFCRIUMSZmBFzL9JOC4H7E0VQ2OziUsY77
         wBJNk4p2Wvaj1rnYH5hAqxavzmHNqmqAF88hM72WLwFFgVyh62zW9za2zdLKvUAPeTD+
         kdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=azwsIqjDyKsdKWJiEFW44oNxyCcrXTQzLW05xfFdK0Q=;
        b=rZNgbizFJooF/6tIdegpB2gxob7M4qkOB2N+DRla60BHUB87RlnAk8J1RQ9u6cKmZb
         D1aFWTsJl2qXZMhLgN8dAqtPLNB11B/kqMvLY1lpVpso2KPIUA+p0FmNQEDK62bmVin5
         D8t48BNNW2e8GppgwzN3PhURG7w4hZ28GN/rk9ze8BOSTCiixtx0JXXcQfQx8p83afZF
         GprFXLqw4LEt7bjMocjIKVvxLPZvcJn4w18d4cbjZqji0ayjwMJSvThUzvWXXSetW8F9
         bpkSWdIcq1J/2Yagu8/WjhrYdkfnfCSe/xuE/Qsm75Y6d+/pJbuMW/diXlIiyam069Uq
         6CyQ==
X-Gm-Message-State: AOAM532V3bIEnqqN6GHYSVXRfLVD5BoBjlfHCAKp1TXEigWuEu3iOETr
        JtUbLvqCnnb/f3C9Af/+AiIHUEXyrrugo98m
X-Google-Smtp-Source: ABdhPJyAfHjIlNvhMcU1uIBKNVqDRVD+E7vorIA+SUg8tiELrFm0d1PwrQ29Tq9UbCAF2ReOpP4L1g==
X-Received: by 2002:a37:7e42:: with SMTP id z63mr17171440qkc.307.1604347800082;
        Mon, 02 Nov 2020 12:10:00 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d184sm8932600qkf.136.2020.11.02.12.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 12:09:59 -0800 (PST)
Subject: Re: [PATCH v9 12/41] btrfs: implement zoned chunk allocator
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <5b9798f6e4c317e6a2c433ef88ffeabe00b93bb3.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <54c78c27-37ad-7b42-7d0a-2b1b46c69dac@toxicpanda.com>
Date:   Mon, 2 Nov 2020 15:09:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <5b9798f6e4c317e6a2c433ef88ffeabe00b93bb3.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
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
>   fs/btrfs/volumes.c | 131 +++++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/volumes.h |   1 +
>   fs/btrfs/zoned.c   | 126 +++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/zoned.h   |  30 +++++++++++
>   4 files changed, 288 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index db884b96a5ea..78c62ef02e6f 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1416,6 +1416,14 @@ static bool contains_pending_extent(struct btrfs_device *device, u64 *start,
>   	return false;
>   }
>   
> +static inline u64 dev_extent_search_start_zoned(struct btrfs_device *device,
> +						u64 start)
> +{
> +	start = max_t(u64, start,
> +		      max_t(u64, device->zone_info->zone_size, SZ_1M));
> +	return btrfs_zone_align(device, start);
> +}
> +
>   static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
>   {
>   	switch (device->fs_devices->chunk_alloc_policy) {
> @@ -1426,11 +1434,57 @@ static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
>   		 * make sure to start at an offset of at least 1MB.
>   		 */
>   		return max_t(u64, start, SZ_1M);
> +	case BTRFS_CHUNK_ALLOC_ZONED:
> +		return dev_extent_search_start_zoned(device, start);
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
> +		/* range is ensured to be empty */
> +		if (!ret)
> +			return changed;
> +
> +		/* given hole range was invalid (outside of device) */
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
> @@ -1463,6 +1517,10 @@ static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
>   	case BTRFS_CHUNK_ALLOC_REGULAR:
>   		/* No extra check */
>   		break;
> +	case BTRFS_CHUNK_ALLOC_ZONED:
> +		changed |= dev_extent_hole_check_zoned(device, hole_start,
> +						       hole_size, num_bytes);
I'm confused here, we check to make sure the pending stuff doesn't overlap with 
non-empty zones.  However we don't ever actually mark zones as non-empty except 
on mount.  I realize that if we allocate this zone then it appears pending and 
thus we won't allocate with this zone again while the fs is mounted, but it took 
me a while to realize this.  Is there a reason to not mark a zone as non-empty 
when we allocate from it?


> +		break;
>   	default:
>   		BUG();
>   	}
> @@ -1517,6 +1575,9 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
>   
>   	search_start = dev_extent_search_start(device, search_start);
>   
> +	WARN_ON(device->zone_info &&
> +		!IS_ALIGNED(num_bytes, device->zone_info->zone_size));
> +
>   	path = btrfs_alloc_path();
>   	if (!path)
>   		return -ENOMEM;
> @@ -4907,6 +4968,37 @@ static void init_alloc_chunk_ctl_policy_regular(
>   	ctl->dev_extent_min = BTRFS_STRIPE_LEN * ctl->dev_stripes;
>   }
>   
> +static void
> +init_alloc_chunk_ctl_policy_zoned(struct btrfs_fs_devices *fs_devices,
> +				  struct alloc_chunk_ctl *ctl)
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
> @@ -4927,6 +5019,9 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
>   	case BTRFS_CHUNK_ALLOC_REGULAR:
>   		init_alloc_chunk_ctl_policy_regular(fs_devices, ctl);
>   		break;
> +	case BTRFS_CHUNK_ALLOC_ZONED:
> +		init_alloc_chunk_ctl_policy_zoned(fs_devices, ctl);
> +		break;
>   	default:
>   		BUG();
>   	}
> @@ -5053,6 +5148,40 @@ static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl,
>   	return 0;
>   }
>   
> +static int decide_stripe_size_zoned(struct alloc_chunk_ctl *ctl,
> +				    struct btrfs_device_info *devices_info)
> +{
> +	u64 zone_size = devices_info[0].dev->zone_info->zone_size;
> +	/* number of stripes that count for block group size */
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
>   static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
>   			      struct alloc_chunk_ctl *ctl,
>   			      struct btrfs_device_info *devices_info)
> @@ -5080,6 +5209,8 @@ static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
>   	switch (fs_devices->chunk_alloc_policy) {
>   	case BTRFS_CHUNK_ALLOC_REGULAR:
>   		return decide_stripe_size_regular(ctl, devices_info);
> +	case BTRFS_CHUNK_ALLOC_ZONED:
> +		return decide_stripe_size_zoned(ctl, devices_info);
>   	default:
>   		BUG();
>   	}
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 9c07b97a2260..0249aca668fb 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -213,6 +213,7 @@ BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
>   
>   enum btrfs_chunk_allocation_policy {
>   	BTRFS_CHUNK_ALLOC_REGULAR,
> +	BTRFS_CHUNK_ALLOC_ZONED,
>   };
>   
>   struct btrfs_fs_devices {
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index d5487cba203b..4411d786597a 100644
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
> @@ -328,6 +330,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>   
>   	fs_info->zone_size = zone_size;
>   	fs_info->max_zone_append_size = max_zone_append_size;
> +	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
>   
>   	btrfs_info(fs_info, "ZONED mode enabled, zone size %llu B",
>   		   fs_info->zone_size);
> @@ -607,3 +610,126 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
>   				sb_zone << zone_sectors_shift, zone_sectors * 2,
>   				GFP_NOFS);
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
> +	if (find_next_bit(zinfo->seq_zones, begin, end) == end)
> +		return 0;
> +

This check is duplicated below.

> +	/* all the zones are sequential and empty */
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
> +		btrfs_warn_in_rcu(
> +			device->fs_info,
> +			"resetting device %s zone %llu for allocation",
> +			rcu_str_deref(device->name), pos >> shift);
> +		WARN_ON_ONCE(1);
> +
> +		ret = btrfs_reset_device_zone(device, pos, zinfo->zone_size,
> +					      &reset_bytes);
> +		if (ret)
> +			return ret;

This seems bad, as we could just have corruption right?  So we're resetting the 
zone which could lose us data right?  Shouldn't we just bail here?  Thanks,

Josef
