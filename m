Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA852D283E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 10:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgLHJ4J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 04:56:09 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58130 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgLHJ4J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:56:09 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B89rrT4125984;
        Tue, 8 Dec 2020 09:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=rRVHm4jxOlkTJ+oPuyKoL7DOZjVJZtDHqWNF06T4kbU=;
 b=Jc1eF3/CEhO4oPcAPoZMLV2X7n9ys+FgP+4+LIZ/xnzuh3VvPYgY9k0YxBNRE9eguiQv
 F+qODd1t2ab9LA5ndQtl3zk41FzzLMMpscIvrfiKeJvxPGipJn6ivLB12JBy1s2wqS18
 Vv46xsxNTEaS4mPI5KGFqmK2ufE858/B6MtTMsdpXYmDsZe9k08ZGCkb2IlVse4z3kGm
 3Z9IKGAinhXOyVRv3a/17D8Ygi8iQqsqi0yaR/RyPNWWrT4Y4TXZwDF879AUHbFyS18Q
 3smSeoU2yBCjBeW+SZG3d2OIBCPhX1F51uawoLoBs1GU3AAYZffiwuW20nLPxkp3Nts5 oA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3581mqsuuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 08 Dec 2020 09:55:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B89iShV190032;
        Tue, 8 Dec 2020 09:55:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 358m3xgttw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Dec 2020 09:55:08 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B89t4US014273;
        Tue, 8 Dec 2020 09:55:04 GMT
Received: from [192.168.10.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Dec 2020 01:55:03 -0800
Subject: Re: [PATCH v10 14/41] btrfs: load zone's alloction offset
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <e05710f61375174d7a64e2c14575555c0b89a431.1605007036.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <de8efe1e-859e-07b7-9128-1749725ce0e7@oracle.com>
Date:   Tue, 8 Dec 2020 17:54:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <e05710f61375174d7a64e2c14575555c0b89a431.1605007036.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=2 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080060
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxlogscore=999
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080061
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/11/20 7:26 pm, Naohiro Aota wrote:
> Zoned btrfs must allocate blocks at the zones' write pointer. The device's
> write pointer position can be mapped to a logical address within a block
> group. This commit adds "alloc_offset" to track the logical address.
> 
> This logical address is populated in btrfs_load_block_group_zone_info()
> from write pointers of corresponding zones.
> 
> For now, zoned btrfs only support the SINGLE profile. Supporting non-SINGLE
> profile with zone append writing is not trivial. For example, in the DUP
> profile, we send a zone append writing IO to two zones on a device. The
> device reply with written LBAs for the IOs. If the offsets of the returned
> addresses from the beginning of the zone are different, then it results in
> different logical addresses.
> 
> We need fine-grained logical to physical mapping to support such separated
> physical address issue. Since it should require additional metadata type,
> disable non-SINGLE profiles for now.
> 
> This commit supports the case all the zones in a block group are
> sequential. The next patch will handle the case having a conventional zone.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/block-group.c |  15 ++++
>   fs/btrfs/block-group.h |   6 ++
>   fs/btrfs/zoned.c       | 154 +++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/zoned.h       |   7 ++
>   4 files changed, 182 insertions(+)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 6b4831824f51..ffc64dfbe09e 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -15,6 +15,7 @@
>   #include "delalloc-space.h"
>   #include "discard.h"
>   #include "raid56.h"
> +#include "zoned.h"
>   
>   /*
>    * Return target flags in extended format or 0 if restripe for this chunk_type
> @@ -1935,6 +1936,13 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>   			goto error;
>   	}
>   
> +	ret = btrfs_load_block_group_zone_info(cache);
> +	if (ret) {
> +		btrfs_err(info, "zoned: failed to load zone info of bg %llu",
> +			  cache->start);
> +		goto error;
> +	}
> +
>   	/*
>   	 * We need to exclude the super stripes now so that the space info has
>   	 * super bytes accounted for, otherwise we'll think we have more space
> @@ -2161,6 +2169,13 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
>   	cache->last_byte_to_unpin = (u64)-1;
>   	cache->cached = BTRFS_CACHE_FINISHED;
>   	cache->needs_free_space = 1;
> +
> +	ret = btrfs_load_block_group_zone_info(cache);
> +	if (ret) {
> +		btrfs_put_block_group(cache);
> +		return ret;
> +	}
> +
>   	ret = exclude_super_stripes(cache);
>   	if (ret) {
>   		/* We may have excluded something, so call this just in case */
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index adfd7583a17b..14e3043c9ce7 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -183,6 +183,12 @@ struct btrfs_block_group {
>   
>   	/* Record locked full stripes for RAID5/6 block group */
>   	struct btrfs_full_stripe_locks_tree full_stripe_locks_root;
> +
> +	/*
> +	 * Allocation offset for the block group to implement sequential
> +	 * allocation. This is used only with ZONED mode enabled.
> +	 */
> +	u64 alloc_offset;
>   };
>   
>   static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index ed5de1c138d7..69d3412c4fef 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -3,14 +3,20 @@
>   #include <linux/bitops.h>
>   #include <linux/slab.h>
>   #include <linux/blkdev.h>
> +#include <linux/sched/mm.h>
>   #include "ctree.h"
>   #include "volumes.h"
>   #include "zoned.h"
>   #include "rcu-string.h"
>   #include "disk-io.h"
> +#include "block-group.h"
>   
>   /* Maximum number of zones to report per blkdev_report_zones() call */
>   #define BTRFS_REPORT_NR_ZONES   4096
> +/* Invalid allocation pointer value for missing devices */
> +#define WP_MISSING_DEV ((u64)-1)
> +/* Pseudo write pointer value for conventional zone */
> +#define WP_CONVENTIONAL ((u64)-2)
>   
>   /* Number of superblock log zones */
>   #define BTRFS_NR_SB_LOG_ZONES 2
> @@ -777,3 +783,151 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
>   
>   	return 0;
>   }
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
> +		btrfs_err(fs_info, "zoned: block group %llu len %llu unaligned to zone size %llu",
> +			  logical, length, fs_info->zone_size);
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
> +			btrfs_err(fs_info, "zoned: offline/readonly zone %llu on device %s (devid %llu)",
> +				  physical >> device->zone_info->zone_size_shift,
> +				  rcu_str_deref(device->name), device->devid);
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
> +		 * Since conventional zones do not have a write pointer, we
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
> +		btrfs_err(fs_info, "zoned: profile %s not supported",
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
> index ec2391c52d8b..e3338a2f1be9 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -40,6 +40,7 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
>   int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
>   			    u64 length, u64 *bytes);
>   int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size);
> +int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache);
>   #else /* CONFIG_BLK_DEV_ZONED */
>   static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>   				     struct blk_zone *zone)
> @@ -112,6 +113,12 @@ static inline int btrfs_ensure_empty_zones(struct btrfs_device *device,
>   	return 0;
>   }
>   
> +static inline int btrfs_load_block_group_zone_info(
> +	struct btrfs_block_group *cache)
> +{
> +	return 0;
> +}
> +
>   #endif
>   
>   static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
> 


looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


