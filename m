Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363D72A351C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 21:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgKBU3m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 15:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgKBU3l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:29:41 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014BDC061A04
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 12:29:40 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id r8so10120562qtp.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 12:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zM6uAqBl6rw0Q3KJqZDAFM+07Vrc87xlPfLVq8qQCBw=;
        b=lh4avQu0va8TJFOYq2/w/MfEYv3k2VVUd/45sXA4QfQ6QX0jCQQOPbCvnA3ft9M7BQ
         CYxjJH1cBbFDdSWUdJtG4ObI6DRJ1jyR35Rs1ouPwL821O3EYLaQZKBLjP2eveWzKXru
         Ym3I34+WK5WNRtUddOVttp+Iga9GUCdrUFGK04CWitPEqbCz41hQjwTN8nJFCY0KZz0S
         Si3bF8HTNjxBxZ299DiWFUjhviLCHp+5DsRmon0Vc+Km7cRf6rsMpVN3yop57yGX/4ou
         mnJLX3x/Sgl/luWFyN9FF+mgi5GcviqI8tzwFp0W9XVtaGcfYHcvkEseR+aA2Gb9T2G0
         qxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zM6uAqBl6rw0Q3KJqZDAFM+07Vrc87xlPfLVq8qQCBw=;
        b=fNxbKUX7JYJ1CgnlHthTIgOd0JwGHUq8hCxj2H5rSK7lfwcDL923JuEAMVHKsaPVrw
         dT0LnAXZCfgUXIuz0z2ae5t33IyDy7h1MZELq75vGoaacSS27bcZqCTuwJ9mp5jD2yGy
         8kYHhUZWedgps3vXmuUIwqrYHvMjD5/RgRdaUMTUy7pCe9OSgXgLbA072v+DIuz+UVT5
         SS5ZUbbP/Yxnh9ae8ZWqqvRwwCRS9kl4K9aCmqS6nRdtu+FLrYgLzPkwb8FNl35pYuCT
         GtBERa6HWl5Adp0TdUKE73AuTmQo2OjY2UmIcAtinYqKVonIO21qCtkLmBj/FIxux1wi
         8D+A==
X-Gm-Message-State: AOAM5331qahCa8GHI1QAdxXl3LcUfhEUm07YI8tuVkXB8L6qhDgA8YC0
        HTiMY+xp84nwX2p1OVcniSZ/uj9tDOIIQznr
X-Google-Smtp-Source: ABdhPJxSqWGzL+QHWlqAiSPu1PZRwJhWzY6ZuRT7/NYy5tOWYXUcD8iGgenDD5HB5Pw3oOhcCR5r+g==
X-Received: by 2002:aed:3b7b:: with SMTP id q56mr1009879qte.377.1604348978379;
        Mon, 02 Nov 2020 12:29:38 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f5sm2989015qtp.47.2020.11.02.12.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 12:29:37 -0800 (PST)
Subject: Re: [PATCH v9 14/41] btrfs: load zone's alloction offset
From:   Josef Bacik <josef@toxicpanda.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <1bbbf9d4ade0c5aeeaebd0772c90f360ceafa9b3.1604065695.git.naohiro.aota@wdc.com>
 <1730f278-39d5-cd82-7cd5-a48d826df2ef@toxicpanda.com>
Message-ID: <2201bd4a-03ee-b68b-683b-0ba079b071dc@toxicpanda.com>
Date:   Mon, 2 Nov 2020 15:29:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1730f278-39d5-cd82-7cd5-a48d826df2ef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/2/20 3:25 PM, Josef Bacik wrote:
> On 10/30/20 9:51 AM, Naohiro Aota wrote:
>> Zoned btrfs must allocate blocks at the zones' write pointer. The device's
>> write pointer position can be mapped to a logical address within a block
>> group. This commit adds "alloc_offset" to track the logical address.
>>
>> This logical address is populated in btrfs_load_block-group_zone_info()
> 
> btrfs_load_block_group_zone_info()
> 
>> from write pointers of corresponding zones.
>>
>> For now, zoned btrfs only support the SINGLE profile. Supporting non-SINGLE
>> profile with zone append writing is not trivial. For example, in the DUP
>> profile, we send a zone append writing IO to two zones on a device. The
>> device reply with written LBAs for the IOs. If the offsets of the returned
>> addresses from the beginning of the zone are different, then it results in
>> different logical addresses.
>>
>> We need fine-grained logical to physical mapping to support such separated
>> physical address issue. Since it should require additional metadata type,
>> disable non-SINGLE profiles for now.
>>
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>> ---
>>   fs/btrfs/block-group.c |  15 ++++
>>   fs/btrfs/block-group.h |   6 ++
>>   fs/btrfs/zoned.c       | 153 +++++++++++++++++++++++++++++++++++++++++
>>   fs/btrfs/zoned.h       |   6 ++
>>   4 files changed, 180 insertions(+)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index e989c66aa764..920b2708c7f2 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -15,6 +15,7 @@
>>   #include "delalloc-space.h"
>>   #include "discard.h"
>>   #include "raid56.h"
>> +#include "zoned.h"
>>   /*
>>    * Return target flags in extended format or 0 if restripe for this chunk_type
>> @@ -1935,6 +1936,13 @@ static int read_one_block_group(struct btrfs_fs_info 
>> *info,
>>               goto error;
>>       }
>> +    ret = btrfs_load_block_group_zone_info(cache);
>> +    if (ret) {
>> +        btrfs_err(info, "failed to load zone info of bg %llu",
>> +              cache->start);
>> +        goto error;
>> +    }
>> +
>>       /*
>>        * We need to exclude the super stripes now so that the space info has
>>        * super bytes accounted for, otherwise we'll think we have more space
>> @@ -2161,6 +2169,13 @@ int btrfs_make_block_group(struct btrfs_trans_handle 
>> *trans, u64 bytes_used,
>>       cache->last_byte_to_unpin = (u64)-1;
>>       cache->cached = BTRFS_CACHE_FINISHED;
>>       cache->needs_free_space = 1;
>> +
>> +    ret = btrfs_load_block_group_zone_info(cache);
>> +    if (ret) {
>> +        btrfs_put_block_group(cache);
>> +        return ret;
>> +    }
>> +
>>       ret = exclude_super_stripes(cache);
>>       if (ret) {
>>           /* We may have excluded something, so call this just in case */
>> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
>> index adfd7583a17b..14e3043c9ce7 100644
>> --- a/fs/btrfs/block-group.h
>> +++ b/fs/btrfs/block-group.h
>> @@ -183,6 +183,12 @@ struct btrfs_block_group {
>>       /* Record locked full stripes for RAID5/6 block group */
>>       struct btrfs_full_stripe_locks_tree full_stripe_locks_root;
>> +
>> +    /*
>> +     * Allocation offset for the block group to implement sequential
>> +     * allocation. This is used only with ZONED mode enabled.
>> +     */
>> +    u64 alloc_offset;
>>   };
>>   static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>> index 4411d786597a..0aa821893a51 100644
>> --- a/fs/btrfs/zoned.c
>> +++ b/fs/btrfs/zoned.c
>> @@ -3,14 +3,20 @@
>>   #include <linux/bitops.h>
>>   #include <linux/slab.h>
>>   #include <linux/blkdev.h>
>> +#include <linux/sched/mm.h>
>>   #include "ctree.h"
>>   #include "volumes.h"
>>   #include "zoned.h"
>>   #include "rcu-string.h"
>>   #include "disk-io.h"
>> +#include "block-group.h"
>>   /* Maximum number of zones to report per blkdev_report_zones() call */
>>   #define BTRFS_REPORT_NR_ZONES   4096
>> +/* Invalid allocation pointer value for missing devices */
>> +#define WP_MISSING_DEV ((u64)-1)
>> +/* Pseudo write pointer value for conventional zone */
>> +#define WP_CONVENTIONAL ((u64)-2)
>>   static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx,
>>                    void *data)
>> @@ -733,3 +739,150 @@ int btrfs_ensure_empty_zones(struct btrfs_device 
>> *device, u64 start, u64 size)
>>       return 0;
>>   }
>> +
>> +int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
>> +{
>> +    struct btrfs_fs_info *fs_info = cache->fs_info;
>> +    struct extent_map_tree *em_tree = &fs_info->mapping_tree;
>> +    struct extent_map *em;
>> +    struct map_lookup *map;
>> +    struct btrfs_device *device;
>> +    u64 logical = cache->start;
>> +    u64 length = cache->length;
>> +    u64 physical = 0;
>> +    int ret;
>> +    int i;
>> +    unsigned int nofs_flag;
>> +    u64 *alloc_offsets = NULL;
>> +    u32 num_sequential = 0, num_conventional = 0;
>> +
>> +    if (!btrfs_is_zoned(fs_info))
>> +        return 0;
>> +
>> +    /* Sanity check */
>> +    if (!IS_ALIGNED(length, fs_info->zone_size)) {
>> +        btrfs_err(fs_info, "unaligned block group at %llu + %llu",
>> +              logical, length);
>> +        return -EIO;
>> +    }
>> +
>> +    /* Get the chunk mapping */
>> +    read_lock(&em_tree->lock);
>> +    em = lookup_extent_mapping(em_tree, logical, length);
>> +    read_unlock(&em_tree->lock);
>> +
>> +    if (!em)
>> +        return -EINVAL;
>> +
>> +    map = em->map_lookup;
>> +
>> +    /*
>> +     * Get the zone type: if the group is mapped to a non-sequential zone,
>> +     * there is no need for the allocation offset (fit allocation is OK).
>> +     */
>> +    alloc_offsets = kcalloc(map->num_stripes, sizeof(*alloc_offsets),
>> +                GFP_NOFS);
>> +    if (!alloc_offsets) {
>> +        free_extent_map(em);
>> +        return -ENOMEM;
>> +    }
>> +
>> +    for (i = 0; i < map->num_stripes; i++) {
>> +        bool is_sequential;
>> +        struct blk_zone zone;
>> +
>> +        device = map->stripes[i].dev;
>> +        physical = map->stripes[i].physical;
>> +
>> +        if (device->bdev == NULL) {
>> +            alloc_offsets[i] = WP_MISSING_DEV;
>> +            continue;
>> +        }
>> +
>> +        is_sequential = btrfs_dev_is_sequential(device, physical);
>> +        if (is_sequential)
>> +            num_sequential++;
>> +        else
>> +            num_conventional++;
>> +
>> +        if (!is_sequential) {
>> +            alloc_offsets[i] = WP_CONVENTIONAL;
>> +            continue;
>> +        }
>> +
>> +        /*
>> +         * This zone will be used for allocation, so mark this
>> +         * zone non-empty.
>> +         */
>> +        btrfs_dev_clear_zone_empty(device, physical);
>> +
>> +        /*
>> +         * The group is mapped to a sequential zone. Get the zone write
>> +         * pointer to determine the allocation offset within the zone.
>> +         */
>> +        WARN_ON(!IS_ALIGNED(physical, fs_info->zone_size));
>> +        nofs_flag = memalloc_nofs_save();
>> +        ret = btrfs_get_dev_zone(device, physical, &zone);
>> +        memalloc_nofs_restore(nofs_flag);
>> +        if (ret == -EIO || ret == -EOPNOTSUPP) {
>> +            ret = 0;
>> +            alloc_offsets[i] = WP_MISSING_DEV;
>> +            continue;
>> +        } else if (ret) {
>> +            goto out;
>> +        }
>> +
>> +        switch (zone.cond) {
>> +        case BLK_ZONE_COND_OFFLINE:
>> +        case BLK_ZONE_COND_READONLY:
>> +            btrfs_err(fs_info, "Offline/readonly zone %llu",
>> +                  physical >> device->zone_info->zone_size_shift);
>> +            alloc_offsets[i] = WP_MISSING_DEV;
>> +            break;
>> +        case BLK_ZONE_COND_EMPTY:
>> +            alloc_offsets[i] = 0;
>> +            break;
>> +        case BLK_ZONE_COND_FULL:
>> +            alloc_offsets[i] = fs_info->zone_size;
>> +            break;
>> +        default:
>> +            /* Partially used zone */
>> +            alloc_offsets[i] =
>> +                ((zone.wp - zone.start) << SECTOR_SHIFT);
>> +            break;
>> +        }
>> +    }
>> +
>> +    if (num_conventional > 0) {
>> +        /*
>> +         * Since conventional zones does not have write pointer, we
>> +         * cannot determine alloc_offset from the pointer
>> +         */
>> +        ret = -EINVAL;
>> +        goto out;
>> +    }
> 
> Does this mean we can't have zoned with a device that has conventional and 
> sequential zones?  I thought such things existed currently?  Thanks,

I see this changes in a follow up patch, ignore me, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
