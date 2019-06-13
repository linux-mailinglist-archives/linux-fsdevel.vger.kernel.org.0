Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00D614388C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733147AbfFMPGp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:06:45 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38607 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732407AbfFMOH1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:07:27 -0400
Received: by mail-qk1-f196.google.com with SMTP id a27so12806385qkk.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2019 07:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1JTlMYgvT4QuxbCoT2xGrlApwTDIEUg6ByrOkZbmTDc=;
        b=GxJ61buDBilabtezp+lw4wj5o5mRSxxwQKZUzt84vLW/+xebqxeJZBps3bvO/PH/wC
         KA/HT+QTkbNMB8fpaZ3xGcC8UN++TpjE8MuXmFrRt37IUBsCHBa94chKUOKqOS2vxpgS
         cCPf0WeGf34D2dUrl5F2as/UPI+96hzIYZf/0/xhm/OZ9zR5Ay3UXGIzG554YMCz2j92
         fTTRH9tk3sbBcfHTmmtWFKDI0F/QKUMCDKhjL7iGthx0z8NhmkwkZ3zGNMD3iy4CVH2U
         bh0vOcGIQMt9vvKMam+Ke36P7mygaJidXkDeAb7SLpTMHfcSUjWbjPBRG715JNNicREZ
         nfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1JTlMYgvT4QuxbCoT2xGrlApwTDIEUg6ByrOkZbmTDc=;
        b=RETealCIgnn374wPsSVkdyi/vBU40rBbyhqV84VfPAG10bw0wgWENfxPDyjphh0UBF
         Njo2ba5ouwSymXkBQpMON8UgVwtKINuiYZ12s1nTodOYI43VDjMaCVn6M+DdvOH+ZEJL
         PnO4/CFI893suuZ01L6zsOxBlzGUIX7Ayt5w/Cpp2wMGxkujeNPG3OpqZROYHu0Cl7FZ
         taqw2QTMGSub41I2aj6DfqyqVuBrH1g0Futtsb1DS/rxkKaHPMIZhGnlbU5LEA1rcKxa
         fvRw7l0/uRdfM5WFwZUTLorYIpzbaErQROPEVzF0DeylTdz6E2xa3ngTHkFx+DhvVz/V
         NmwA==
X-Gm-Message-State: APjAAAWGkQhLMnCvr6usNB2Dqh7Pqe6SrK94ofY+x7baFllIWWFy/IYq
        UkojvGKAFqfMRMJOewdpamyovkzkaLtkge9S
X-Google-Smtp-Source: APXvYqyzjcSyj9Ct20/RHKPK+7M0oVXwO86XQ3gQVWHOnTGcjCluWWyE4STlbIHvU3yjOcju6/3fUA==
X-Received: by 2002:a05:620a:124f:: with SMTP id a15mr71586177qkl.173.1560434846173;
        Thu, 13 Jun 2019 07:07:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::9d6b])
        by smtp.gmail.com with ESMTPSA id 34sm1804199qtq.59.2019.06.13.07.07.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 07:07:25 -0700 (PDT)
Date:   Thu, 13 Jun 2019 10:07:24 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 07/19] btrfs: do sequential extent allocation in HMZONED
 mode
Message-ID: <20190613140722.lt6mvxnddnjg5lvx@MacBook-Pro-91.local>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-8-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607131025.31996-8-naohiro.aota@wdc.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 07, 2019 at 10:10:13PM +0900, Naohiro Aota wrote:
> On HMZONED drives, writes must always be sequential and directed at a block
> group zone write pointer position. Thus, block allocation in a block group
> must also be done sequentially using an allocation pointer equal to the
> block group zone write pointer plus the number of blocks allocated but not
> yet written.
> 
> Sequential allocation function find_free_extent_seq() bypass the checks in
> find_free_extent() and increase the reserved byte counter by itself. It is
> impossible to revert once allocated region in the sequential allocation,
> since it might race with other allocations and leave an allocation hole,
> which breaks the sequential write rule.
> 
> Furthermore, this commit introduce two new variable to struct
> btrfs_block_group_cache. "wp_broken" indicate that write pointer is broken
> (e.g. not synced on a RAID1 block group) and mark that block group read
> only. "unusable" keeps track of the size of once allocated then freed
> region. Such region is never usable until resetting underlying zones.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/ctree.h            |  24 +++
>  fs/btrfs/extent-tree.c      | 378 ++++++++++++++++++++++++++++++++++--
>  fs/btrfs/free-space-cache.c |  33 ++++
>  fs/btrfs/free-space-cache.h |   5 +
>  4 files changed, 426 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 6c00101407e4..f4bcd2a6ec12 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -582,6 +582,20 @@ struct btrfs_full_stripe_locks_tree {
>  	struct mutex lock;
>  };
>  
> +/* Block group allocation types */
> +enum btrfs_alloc_type {
> +
> +	/* Regular first fit allocation */
> +	BTRFS_ALLOC_FIT		= 0,
> +
> +	/*
> +	 * Sequential allocation: this is for HMZONED mode and
> +	 * will result in ignoring free space before a block
> +	 * group allocation offset.
> +	 */
> +	BTRFS_ALLOC_SEQ		= 1,
> +};
> +
>  struct btrfs_block_group_cache {
>  	struct btrfs_key key;
>  	struct btrfs_block_group_item item;
> @@ -592,6 +606,7 @@ struct btrfs_block_group_cache {
>  	u64 reserved;
>  	u64 delalloc_bytes;
>  	u64 bytes_super;
> +	u64 unusable;
>  	u64 flags;
>  	u64 cache_generation;
>  
> @@ -621,6 +636,7 @@ struct btrfs_block_group_cache {
>  	unsigned int iref:1;
>  	unsigned int has_caching_ctl:1;
>  	unsigned int removed:1;
> +	unsigned int wp_broken:1;
>  
>  	int disk_cache_state;
>  
> @@ -694,6 +710,14 @@ struct btrfs_block_group_cache {
>  
>  	/* Record locked full stripes for RAID5/6 block group */
>  	struct btrfs_full_stripe_locks_tree full_stripe_locks_root;
> +
> +	/*
> +	 * Allocation offset for the block group to implement sequential
> +	 * allocation. This is used only with HMZONED mode enabled and if
> +	 * the block group resides on a sequential zone.
> +	 */
> +	enum btrfs_alloc_type alloc_type;
> +	u64 alloc_offset;
>  };
>  
>  /* delayed seq elem */
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 363db58f56b8..ebd0d6eae038 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -28,6 +28,7 @@
>  #include "sysfs.h"
>  #include "qgroup.h"
>  #include "ref-verify.h"
> +#include "rcu-string.h"
>  
>  #undef SCRAMBLE_DELAYED_REFS
>  
> @@ -590,6 +591,8 @@ static int cache_block_group(struct btrfs_block_group_cache *cache,
>  	struct btrfs_caching_control *caching_ctl;
>  	int ret = 0;
>  
> +	WARN_ON(cache->alloc_type == BTRFS_ALLOC_SEQ);
> +
>  	caching_ctl = kzalloc(sizeof(*caching_ctl), GFP_NOFS);
>  	if (!caching_ctl)
>  		return -ENOMEM;
> @@ -6555,6 +6558,19 @@ void btrfs_wait_block_group_reservations(struct btrfs_block_group_cache *bg)
>  	wait_var_event(&bg->reservations, !atomic_read(&bg->reservations));
>  }
>  
> +static void __btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
> +				       u64 ram_bytes, u64 num_bytes,
> +				       int delalloc)
> +{
> +	struct btrfs_space_info *space_info = cache->space_info;
> +
> +	cache->reserved += num_bytes;
> +	space_info->bytes_reserved += num_bytes;
> +	update_bytes_may_use(space_info, -ram_bytes);
> +	if (delalloc)
> +		cache->delalloc_bytes += num_bytes;
> +}
> +
>  /**
>   * btrfs_add_reserved_bytes - update the block_group and space info counters
>   * @cache:	The cache we are manipulating
> @@ -6573,17 +6589,16 @@ static int btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
>  	struct btrfs_space_info *space_info = cache->space_info;
>  	int ret = 0;
>  
> +	/* should handled by find_free_extent_seq */
> +	WARN_ON(cache->alloc_type == BTRFS_ALLOC_SEQ);
> +
>  	spin_lock(&space_info->lock);
>  	spin_lock(&cache->lock);
> -	if (cache->ro) {
> +	if (cache->ro)
>  		ret = -EAGAIN;
> -	} else {
> -		cache->reserved += num_bytes;
> -		space_info->bytes_reserved += num_bytes;
> -		update_bytes_may_use(space_info, -ram_bytes);
> -		if (delalloc)
> -			cache->delalloc_bytes += num_bytes;
> -	}
> +	else
> +		__btrfs_add_reserved_bytes(cache, ram_bytes, num_bytes,
> +					   delalloc);
>  	spin_unlock(&cache->lock);
>  	spin_unlock(&space_info->lock);
>  	return ret;
> @@ -6701,9 +6716,13 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
>  			cache = btrfs_lookup_block_group(fs_info, start);
>  			BUG_ON(!cache); /* Logic error */
>  
> -			cluster = fetch_cluster_info(fs_info,
> -						     cache->space_info,
> -						     &empty_cluster);
> +			if (cache->alloc_type == BTRFS_ALLOC_FIT)
> +				cluster = fetch_cluster_info(fs_info,
> +							     cache->space_info,
> +							     &empty_cluster);
> +			else
> +				cluster = NULL;
> +
>  			empty_cluster <<= 1;
>  		}
>  
> @@ -6743,7 +6762,8 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
>  		space_info->max_extent_size = 0;
>  		percpu_counter_add_batch(&space_info->total_bytes_pinned,
>  			    -len, BTRFS_TOTAL_BYTES_PINNED_BATCH);
> -		if (cache->ro) {
> +		if (cache->ro || cache->alloc_type == BTRFS_ALLOC_SEQ) {
> +			/* need reset before reusing in ALLOC_SEQ BG */
>  			space_info->bytes_readonly += len;
>  			readonly = true;
>  		}
> @@ -7588,6 +7608,60 @@ static int find_free_extent_unclustered(struct btrfs_block_group_cache *bg,
>  	return 0;
>  }
>  
> +/*
> + * Simple allocator for sequential only block group. It only allows
> + * sequential allocation. No need to play with trees. This function
> + * also reserve the bytes as in btrfs_add_reserved_bytes.
> + */
> +
> +static int find_free_extent_seq(struct btrfs_block_group_cache *cache,
> +				struct find_free_extent_ctl *ffe_ctl)
> +{
> +	struct btrfs_space_info *space_info = cache->space_info;
> +	struct btrfs_free_space_ctl *ctl = cache->free_space_ctl;
> +	u64 start = cache->key.objectid;
> +	u64 num_bytes = ffe_ctl->num_bytes;
> +	u64 avail;
> +	int ret = 0;
> +
> +	/* Sanity check */
> +	if (cache->alloc_type != BTRFS_ALLOC_SEQ)
> +		return 1;
> +
> +	spin_lock(&space_info->lock);
> +	spin_lock(&cache->lock);
> +
> +	if (cache->ro) {
> +		ret = -EAGAIN;
> +		goto out;
> +	}
> +
> +	spin_lock(&ctl->tree_lock);
> +	avail = cache->key.offset - cache->alloc_offset;
> +	if (avail < num_bytes) {
> +		ffe_ctl->max_extent_size = avail;
> +		spin_unlock(&ctl->tree_lock);
> +		ret = 1;
> +		goto out;
> +	}
> +
> +	ffe_ctl->found_offset = start + cache->alloc_offset;
> +	cache->alloc_offset += num_bytes;
> +	ctl->free_space -= num_bytes;
> +	spin_unlock(&ctl->tree_lock);
> +
> +	BUG_ON(!IS_ALIGNED(ffe_ctl->found_offset,
> +			   cache->fs_info->stripesize));
> +	ffe_ctl->search_start = ffe_ctl->found_offset;
> +	__btrfs_add_reserved_bytes(cache, ffe_ctl->ram_bytes, num_bytes,
> +				   ffe_ctl->delalloc);
> +
> +out:
> +	spin_unlock(&cache->lock);
> +	spin_unlock(&space_info->lock);
> +	return ret;
> +}
> +
>  /*
>   * Return >0 means caller needs to re-search for free extent
>   * Return 0 means we have the needed free extent.
> @@ -7889,6 +7963,16 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
>  		if (unlikely(block_group->cached == BTRFS_CACHE_ERROR))
>  			goto loop;
>  
> +		if (block_group->alloc_type == BTRFS_ALLOC_SEQ) {
> +			ret = find_free_extent_seq(block_group, &ffe_ctl);
> +			if (ret)
> +				goto loop;
> +			/* btrfs_find_space_for_alloc_seq should ensure
> +			 * that everything is OK and reserve the extent.
> +			 */
> +			goto nocheck;
> +		}
> +
>  		/*
>  		 * Ok we want to try and use the cluster allocator, so
>  		 * lets look there
> @@ -7944,6 +8028,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
>  					     num_bytes);
>  			goto loop;
>  		}
> +nocheck:
>  		btrfs_inc_block_group_reservations(block_group);
>  
>  		/* we are all good, lets return */
> @@ -9616,7 +9701,8 @@ static int inc_block_group_ro(struct btrfs_block_group_cache *cache, int force)
>  	}
>  
>  	num_bytes = cache->key.offset - cache->reserved - cache->pinned -
> -		    cache->bytes_super - btrfs_block_group_used(&cache->item);
> +		    cache->bytes_super - cache->unusable -
> +		    btrfs_block_group_used(&cache->item);
>  	sinfo_used = btrfs_space_info_used(sinfo, true);
>  
>  	if (sinfo_used + num_bytes + min_allocable_bytes <=
> @@ -9766,6 +9852,7 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache)
>  	if (!--cache->ro) {
>  		num_bytes = cache->key.offset - cache->reserved -
>  			    cache->pinned - cache->bytes_super -
> +			    cache->unusable -
>  			    btrfs_block_group_used(&cache->item);

You've done this in a few places, but not all the places, most notably
btrfs_space_info_used() which is used in the space reservation code a lot.

>  		sinfo->bytes_readonly -= num_bytes;
>  		list_del_init(&cache->ro_list);
> @@ -10200,11 +10287,240 @@ static void link_block_group(struct btrfs_block_group_cache *cache)
>  	}
>  }
>  
> +static int
> +btrfs_get_block_group_alloc_offset(struct btrfs_block_group_cache *cache)
> +{
> +	struct btrfs_fs_info *fs_info = cache->fs_info;
> +	struct extent_map_tree *em_tree = &fs_info->mapping_tree.map_tree;
> +	struct extent_map *em;
> +	struct map_lookup *map;
> +	struct btrfs_device *device;
> +	u64 logical = cache->key.objectid;
> +	u64 length = cache->key.offset;
> +	u64 physical = 0;
> +	int ret, alloc_type;
> +	int i, j;
> +	u64 *alloc_offsets = NULL;
> +
> +#define WP_MISSING_DEV ((u64)-1)
> +
> +	/* Sanity check */
> +	if (!IS_ALIGNED(length, fs_info->zone_size)) {
> +		btrfs_err(fs_info, "unaligned block group at %llu + %llu",
> +			  logical, length);
> +		return -EIO;
> +	}
> +
> +	/* Get the chunk mapping */
> +	em_tree = &fs_info->mapping_tree.map_tree;
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
> +	alloc_type = -1;
> +	alloc_offsets = kcalloc(map->num_stripes, sizeof(*alloc_offsets),
> +				GFP_NOFS);
> +	if (!alloc_offsets) {
> +		free_extent_map(em);
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < map->num_stripes; i++) {
> +		int is_sequential;
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
> +		if (alloc_type == -1)
> +			alloc_type = is_sequential ?
> +					BTRFS_ALLOC_SEQ : BTRFS_ALLOC_FIT;
> +
> +		if ((is_sequential && alloc_type != BTRFS_ALLOC_SEQ) ||
> +		    (!is_sequential && alloc_type == BTRFS_ALLOC_SEQ)) {
> +			btrfs_err(fs_info, "found block group of mixed zone types");
> +			ret = -EIO;
> +			goto out;
> +		}
> +
> +		if (!is_sequential)
> +			continue;
> +
> +		/* this zone will be used for allocation, so mark this
> +		 * zone non-empty
> +		 */
> +		clear_bit(physical >> device->zone_size_shift,
> +			  device->empty_zones);
> +
> +		/*
> +		 * The group is mapped to a sequential zone. Get the zone write
> +		 * pointer to determine the allocation offset within the zone.
> +		 */
> +		WARN_ON(!IS_ALIGNED(physical, fs_info->zone_size));
> +		ret = btrfs_get_dev_zone(device, physical, &zone, GFP_NOFS);
> +		if (ret == -EIO || ret == -EOPNOTSUPP) {
> +			ret = 0;
> +			alloc_offsets[i] = WP_MISSING_DEV;
> +			continue;
> +		} else if (ret) {
> +			goto out;
> +		}
> +
> +
> +		switch (zone.cond) {
> +		case BLK_ZONE_COND_OFFLINE:
> +		case BLK_ZONE_COND_READONLY:
> +			btrfs_err(fs_info, "Offline/readonly zone %llu",
> +				  physical >> device->zone_size_shift);
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
> +	if (alloc_type == BTRFS_ALLOC_FIT)
> +		goto out;
> +
> +	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
> +	case 0: /* single */
> +	case BTRFS_BLOCK_GROUP_DUP:
> +	case BTRFS_BLOCK_GROUP_RAID1:
> +		cache->alloc_offset = WP_MISSING_DEV;
> +		for (i = 0; i < map->num_stripes; i++) {
> +			if (alloc_offsets[i] == WP_MISSING_DEV)
> +				continue;
> +			if (cache->alloc_offset == WP_MISSING_DEV)
> +				cache->alloc_offset = alloc_offsets[i];
> +			if (alloc_offsets[i] == cache->alloc_offset)
> +				continue;
> +
> +			btrfs_err(fs_info,
> +				  "write pointer mismatch: block group %llu",
> +				  logical);
> +			cache->wp_broken = 1;
> +		}
> +		break;
> +	case BTRFS_BLOCK_GROUP_RAID0:
> +		cache->alloc_offset = 0;
> +		for (i = 0; i < map->num_stripes; i++) {
> +			if (alloc_offsets[i] == WP_MISSING_DEV) {
> +				btrfs_err(fs_info,
> +					  "cannot recover write pointer: block group %llu",
> +					  logical);
> +				cache->wp_broken = 1;
> +				continue;
> +			}
> +
> +			if (alloc_offsets[0] < alloc_offsets[i]) {
> +				btrfs_err(fs_info,
> +					  "write pointer mismatch: block group %llu",
> +					  logical);
> +				cache->wp_broken = 1;
> +				continue;
> +			}
> +
> +			cache->alloc_offset += alloc_offsets[i];
> +		}
> +		break;
> +	case BTRFS_BLOCK_GROUP_RAID10:
> +		/*
> +		 * Pass1: check write pointer of RAID1 level: each pointer
> +		 * should be equal.
> +		 */
> +		for (i = 0; i < map->num_stripes / map->sub_stripes; i++) {
> +			int base = i*map->sub_stripes;
> +			u64 offset = WP_MISSING_DEV;
> +
> +			for (j = 0; j < map->sub_stripes; j++) {
> +				if (alloc_offsets[base+j] == WP_MISSING_DEV)
> +					continue;
> +				if (offset == WP_MISSING_DEV)
> +					offset = alloc_offsets[base+j];
> +				if (alloc_offsets[base+j] == offset)
> +					continue;
> +
> +				btrfs_err(fs_info,
> +					  "write pointer mismatch: block group %llu",
> +					  logical);
> +				cache->wp_broken = 1;
> +			}
> +			for (j = 0; j < map->sub_stripes; j++)
> +				alloc_offsets[base+j] = offset;
> +		}
> +
> +		/* Pass2: check write pointer of RAID1 level */
> +		cache->alloc_offset = 0;
> +		for (i = 0; i < map->num_stripes / map->sub_stripes; i++) {
> +			int base = i*map->sub_stripes;
> +
> +			if (alloc_offsets[base] == WP_MISSING_DEV) {
> +				btrfs_err(fs_info,
> +					  "cannot recover write pointer: block group %llu",
> +					  logical);
> +				cache->wp_broken = 1;
> +				continue;
> +			}
> +
> +			if (alloc_offsets[0] < alloc_offsets[base]) {
> +				btrfs_err(fs_info,
> +					  "write pointer mismatch: block group %llu",
> +					  logical);
> +				cache->wp_broken = 1;
> +				continue;
> +			}
> +
> +			cache->alloc_offset += alloc_offsets[base];
> +		}
> +		break;
> +	case BTRFS_BLOCK_GROUP_RAID5:
> +	case BTRFS_BLOCK_GROUP_RAID6:
> +		/* RAID5/6 is not supported yet */
> +	default:
> +		btrfs_err(fs_info, "Unsupported profile on HMZONED %llu",
> +			map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +out:
> +	cache->alloc_type = alloc_type;
> +	kfree(alloc_offsets);
> +	free_extent_map(em);
> +
> +	return ret;
> +}
> +

Move this to the zoned device file that you create.

>  static struct btrfs_block_group_cache *
>  btrfs_create_block_group_cache(struct btrfs_fs_info *fs_info,
>  			       u64 start, u64 size)
>  {
>  	struct btrfs_block_group_cache *cache;
> +	int ret;
>  
>  	cache = kzalloc(sizeof(*cache), GFP_NOFS);
>  	if (!cache)
> @@ -10238,6 +10554,16 @@ btrfs_create_block_group_cache(struct btrfs_fs_info *fs_info,
>  	atomic_set(&cache->trimming, 0);
>  	mutex_init(&cache->free_space_lock);
>  	btrfs_init_full_stripe_locks_tree(&cache->full_stripe_locks_root);
> +	cache->alloc_type = BTRFS_ALLOC_FIT;
> +	cache->alloc_offset = 0;
> +
> +	if (btrfs_fs_incompat(fs_info, HMZONED)) {
> +		ret = btrfs_get_block_group_alloc_offset(cache);
> +		if (ret) {
> +			kfree(cache);
> +			return NULL;
> +		}
> +	}
>  
>  	return cache;
>  }
> @@ -10310,6 +10636,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
>  	int need_clear = 0;
>  	u64 cache_gen;
>  	u64 feature;
> +	u64 unusable;
>  	int mixed;
>  
>  	feature = btrfs_super_incompat_flags(info->super_copy);
> @@ -10415,6 +10742,26 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
>  			free_excluded_extents(cache);
>  		}
>  
> +		switch (cache->alloc_type) {
> +		case BTRFS_ALLOC_FIT:
> +			unusable = cache->bytes_super;
> +			break;
> +		case BTRFS_ALLOC_SEQ:
> +			WARN_ON(cache->bytes_super != 0);
> +			unusable = cache->alloc_offset -
> +				btrfs_block_group_used(&cache->item);
> +			/* we only need ->free_space in ALLOC_SEQ BGs */
> +			cache->last_byte_to_unpin = (u64)-1;
> +			cache->cached = BTRFS_CACHE_FINISHED;
> +			cache->free_space_ctl->free_space =
> +				cache->key.offset - cache->alloc_offset;
> +			cache->unusable = unusable;
> +			free_excluded_extents(cache);
> +			break;
> +		default:
> +			BUG();
> +		}
> +
>  		ret = btrfs_add_block_group_cache(info, cache);
>  		if (ret) {
>  			btrfs_remove_free_space_cache(cache);
> @@ -10425,7 +10772,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
>  		trace_btrfs_add_block_group(info, cache, 0);
>  		update_space_info(info, cache->flags, found_key.offset,
>  				  btrfs_block_group_used(&cache->item),
> -				  cache->bytes_super, &space_info);
> +				  unusable, &space_info);
>  
>  		cache->space_info = space_info;
>  
> @@ -10438,6 +10785,9 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
>  			ASSERT(list_empty(&cache->bg_list));
>  			btrfs_mark_bg_unused(cache);
>  		}
> +
> +		if (cache->wp_broken)
> +			inc_block_group_ro(cache, 1);
>  	}
>  
>  	list_for_each_entry_rcu(space_info, &info->space_info, list) {
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index f74dc259307b..cc69dc71f4c1 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -2326,8 +2326,11 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
>  			   u64 offset, u64 bytes)
>  {
>  	struct btrfs_free_space *info;
> +	struct btrfs_block_group_cache *block_group = ctl->private;
>  	int ret = 0;
>  
> +	WARN_ON(block_group && block_group->alloc_type == BTRFS_ALLOC_SEQ);
> +
>  	info = kmem_cache_zalloc(btrfs_free_space_cachep, GFP_NOFS);
>  	if (!info)
>  		return -ENOMEM;
> @@ -2376,6 +2379,28 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
>  	return ret;
>  }
>  
> +int __btrfs_add_free_space_seq(struct btrfs_block_group_cache *block_group,
> +			       u64 bytenr, u64 size)
> +{
> +	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
> +	u64 offset = bytenr - block_group->key.objectid;
> +	u64 to_free, to_unusable;
> +
> +	spin_lock(&ctl->tree_lock);
> +	if (offset >= block_group->alloc_offset)
> +		to_free = size;
> +	else if (offset + size <= block_group->alloc_offset)
> +		to_free = 0;
> +	else
> +		to_free = offset + size - block_group->alloc_offset;
> +	to_unusable = size - to_free;
> +	ctl->free_space += to_free;
> +	block_group->unusable += to_unusable;
> +	spin_unlock(&ctl->tree_lock);
> +	return 0;
> +
> +}
> +
>  int btrfs_remove_free_space(struct btrfs_block_group_cache *block_group,
>  			    u64 offset, u64 bytes)
>  {
> @@ -2384,6 +2409,8 @@ int btrfs_remove_free_space(struct btrfs_block_group_cache *block_group,
>  	int ret;
>  	bool re_search = false;
>  
> +	WARN_ON(block_group->alloc_type == BTRFS_ALLOC_SEQ);
> +

These should probably be ASSERT() right?  Want to make sure the developers
really notice a problem when testing.  Thanks,

Josef
