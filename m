Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF8E2A480C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 15:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgKCO0M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 09:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729459AbgKCOZ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:25:27 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B02C0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 06:25:26 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id d1so7184643qvl.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 06:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MeFmUOSwfCwUcdYudsvDExs+SiwwrL3LBSFAUDMhq/E=;
        b=Qh3A8SJgo/3EpRRqHk5X92Ohk7zm1YrGqq5BVEQeVhHrjwFg4a4V3aRijPZzWCvdLY
         SNQI+f2Kc8XquEfs/b7TPMUVG9c/Fm7JmWWK8XpXVq59ywYCS2xKFtlx4LKshsJ0raAP
         IXr7tQRz9BWuXOD7GCaZkidMSwj2OdO6217qcdnUYQuLX1k8NJ7NHWircgAv/Bmfc3Wp
         9dq5e8ZjZ5xB5PP7XUCWTLTTtF1UGgkUEXStNb2WpImwQ5ib7tEhg9/G/rdbr42WEZsy
         TYhCRqbdHTMxVU2nZQWDCms7/NK2OURZa5ttELKejXFdShkTh5dHOpm9/N9kvzNgMGrt
         g5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MeFmUOSwfCwUcdYudsvDExs+SiwwrL3LBSFAUDMhq/E=;
        b=TutuffXz/BOFpwcaPIPBJoOSVLgHNPMGjylVzUsCodP9tesPrSjRBhF88pCEv3AEi5
         edKZDT43IeJgG0qDdsCvEXP0hl/xr/sRGC49TX/2DLlTR13eY2TYo+0I03H2JrBNgyTm
         QsW5xpaq7eSex/8kOSYJka89J3PMm5/kw4mlwx3GHgGROsxPR/aroqIvFZNZZmuWy1KR
         GobcvkJUU5r4hlslTVMdlyYI/y5tb9H1hw6Od9tK33vLK9gB23Ks1tYsPrFh8xvS/QN9
         pO+waLlhlXgn8nlVkkDogmVpTekr1PzjVeWe1CADzPkI96tQXoWgmY10ZDHkZRi1bT2+
         7ICg==
X-Gm-Message-State: AOAM533ohYKkRelbdTHCDruvqlX8Iye7awdqhKqYd0GUGB8QFIwcDDZJ
        bvqNJiVSnM4rjvtOOjS/1WjyTCy/FkPu8Z2+
X-Google-Smtp-Source: ABdhPJwPDVmLBawjYICoxvMzYzQzyDmvO/ajonODVXhVnx352kYMjDkzMV4JiwLmKc/cGZnJPZF2RA==
X-Received: by 2002:a0c:9e6b:: with SMTP id z43mr26796808qve.51.1604413525188;
        Tue, 03 Nov 2020 06:25:25 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 198sm10552234qki.117.2020.11.03.06.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 06:25:24 -0800 (PST)
Subject: Re: [PATCH v9 16/41] btrfs: track unusable bytes for zones
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <cd87f173cb6f2a4b17ed2a849a4a73dbd856df31.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8933dbec-c506-12be-cb87-aa7ef6cd099f@toxicpanda.com>
Date:   Tue, 3 Nov 2020 09:25:23 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <cd87f173cb6f2a4b17ed2a849a4a73dbd856df31.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> In zoned btrfs a region that was once written then freed is not usable
> until we reset the underlying zone. So we need to distinguish such
> unusable space from usable free space.
> 
> Therefore we need to introduce the "zone_unusable" field  to the block
> group structure, and "bytes_zone_unusable" to the space_info structure to
> track the unusable space.
> 
> Pinned bytes are always reclaimed to the unusable space. But, when an
> allocated region is returned before using e.g., the block group becomes
> read-only between allocation time and reservation time, we can safely
> return the region to the block group. For the situation, this commit
> introduces "btrfs_add_free_space_unused". This behaves the same as
> btrfs_add_free_space() on regular btrfs. On zoned btrfs, it rewinds the
> allocation offset.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/block-group.c      | 19 +++++++++-----
>   fs/btrfs/block-group.h      |  1 +
>   fs/btrfs/extent-tree.c      | 15 ++++++++---
>   fs/btrfs/free-space-cache.c | 52 +++++++++++++++++++++++++++++++++++++
>   fs/btrfs/free-space-cache.h |  4 +++
>   fs/btrfs/space-info.c       | 13 ++++++----
>   fs/btrfs/space-info.h       |  4 ++-
>   fs/btrfs/sysfs.c            |  2 ++
>   fs/btrfs/zoned.c            | 22 ++++++++++++++++
>   fs/btrfs/zoned.h            |  2 ++
>   10 files changed, 118 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 920b2708c7f2..c34bd2dbdf82 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1080,12 +1080,15 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>   		WARN_ON(block_group->space_info->total_bytes
>   			< block_group->length);
>   		WARN_ON(block_group->space_info->bytes_readonly
> -			< block_group->length);
> +			< block_group->length - block_group->zone_unusable);
> +		WARN_ON(block_group->space_info->bytes_zone_unusable
> +			< block_group->zone_unusable);
>   		WARN_ON(block_group->space_info->disk_total
>   			< block_group->length * factor);
>   	}
>   	block_group->space_info->total_bytes -= block_group->length;
> -	block_group->space_info->bytes_readonly -= block_group->length;
> +	block_group->space_info->bytes_readonly -=
> +		(block_group->length - block_group->zone_unusable);
>   	block_group->space_info->disk_total -= block_group->length * factor;
>   
>   	spin_unlock(&block_group->space_info->lock);
> @@ -1229,7 +1232,7 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
>   	}
>   
>   	num_bytes = cache->length - cache->reserved - cache->pinned -
> -		    cache->bytes_super - cache->used;
> +		    cache->bytes_super - cache->zone_unusable - cache->used;
>   
>   	/*
>   	 * Data never overcommits, even in mixed mode, so do just the straight
> @@ -1973,6 +1976,8 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>   		btrfs_free_excluded_extents(cache);
>   	}
>   
> +	btrfs_calc_zone_unusable(cache);
> +
>   	ret = btrfs_add_block_group_cache(info, cache);
>   	if (ret) {
>   		btrfs_remove_free_space_cache(cache);
> @@ -1980,7 +1985,8 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>   	}
>   	trace_btrfs_add_block_group(info, cache, 0);
>   	btrfs_update_space_info(info, cache->flags, cache->length,
> -				cache->used, cache->bytes_super, &space_info);
> +				cache->used, cache->bytes_super,
> +				cache->zone_unusable, &space_info);
>   
>   	cache->space_info = space_info;
>   
> @@ -2217,7 +2223,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
>   	 */
>   	trace_btrfs_add_block_group(fs_info, cache, 1);
>   	btrfs_update_space_info(fs_info, cache->flags, size, bytes_used,
> -				cache->bytes_super, &cache->space_info);
> +				cache->bytes_super, 0, &cache->space_info);
>   	btrfs_update_global_block_rsv(fs_info);
>   
>   	link_block_group(cache);
> @@ -2325,7 +2331,8 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group *cache)
>   	spin_lock(&cache->lock);
>   	if (!--cache->ro) {
>   		num_bytes = cache->length - cache->reserved -
> -			    cache->pinned - cache->bytes_super - cache->used;
> +			    cache->pinned - cache->bytes_super -
> +			    cache->zone_unusable - cache->used;
>   		sinfo->bytes_readonly -= num_bytes;
>   		list_del_init(&cache->ro_list);
>   	}
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 14e3043c9ce7..5be47f4bfea7 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -189,6 +189,7 @@ struct btrfs_block_group {
>   	 * allocation. This is used only with ZONED mode enabled.
>   	 */
>   	u64 alloc_offset;
> +	u64 zone_unusable;
>   };
>   
>   static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 3b21fee13e77..fad53c702d8a 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -34,6 +34,7 @@
>   #include "block-group.h"
>   #include "discard.h"
>   #include "rcu-string.h"
> +#include "zoned.h"
>   
>   #undef SCRAMBLE_DELAYED_REFS
>   
> @@ -2807,9 +2808,11 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
>   			cache = btrfs_lookup_block_group(fs_info, start);
>   			BUG_ON(!cache); /* Logic error */
>   
> -			cluster = fetch_cluster_info(fs_info,
> -						     cache->space_info,
> -						     &empty_cluster);
> +			if (!btrfs_is_zoned(fs_info))
> +				cluster = fetch_cluster_info(fs_info,
> +							     cache->space_info,
> +							     &empty_cluster);

Move the !btrfs_is_zoned() check into fetch_cluster_info so we don't have to 
indent even more.

> +
>   			empty_cluster <<= 1;
>   		}
>   
> @@ -2846,7 +2849,11 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
>   		space_info->max_extent_size = 0;
>   		percpu_counter_add_batch(&space_info->total_bytes_pinned,
>   			    -len, BTRFS_TOTAL_BYTES_PINNED_BATCH);
> -		if (cache->ro) {
> +		if (btrfs_is_zoned(fs_info)) {
> +			/* need reset before reusing in zoned Block Group */
> +			space_info->bytes_zone_unusable += len;
> +			readonly = true;
> +		} else if (cache->ro) {
>   			space_info->bytes_readonly += len;
>   			readonly = true;
>   		}
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index af0013d3df63..cfa466319166 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -2467,6 +2467,8 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
>   	int ret = 0;
>   	u64 filter_bytes = bytes;
>   
> +	ASSERT(!btrfs_is_zoned(fs_info));
> +
>   	info = kmem_cache_zalloc(btrfs_free_space_cachep, GFP_NOFS);
>   	if (!info)
>   		return -ENOMEM;
> @@ -2524,11 +2526,44 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
>   	return ret;
>   }
>   
> +int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
> +				 u64 bytenr, u64 size, bool used)
> +{

This is only used in free-space-cache.c, it can be made static.

> +	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
> +	u64 offset = bytenr - block_group->start;
> +	u64 to_free, to_unusable;
> +
> +	spin_lock(&ctl->tree_lock);
> +	if (!used)
> +		to_free = size;
> +	else if (offset >= block_group->alloc_offset)
> +		to_free = size;
> +	else if (offset + size <= block_group->alloc_offset)
> +		to_free = 0;
> +	else
> +		to_free = offset + size - block_group->alloc_offset;
> +	to_unusable = size - to_free;
> +
> +	ctl->free_space += to_free;
> +	block_group->zone_unusable += to_unusable;
> +	spin_unlock(&ctl->tree_lock);
> +	if (!used) {
> +		spin_lock(&block_group->lock);
> +		block_group->alloc_offset -= size;
> +		spin_unlock(&block_group->lock);
> +	}
> +	return 0;
> +}
> +
>   int btrfs_add_free_space(struct btrfs_block_group *block_group,
>   			 u64 bytenr, u64 size)
>   {
>   	enum btrfs_trim_state trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
>   
> +	if (btrfs_is_zoned(block_group->fs_info))
> +		return __btrfs_add_free_space_zoned(block_group, bytenr, size,
> +						    true);
> +
>   	if (btrfs_test_opt(block_group->fs_info, DISCARD_SYNC))
>   		trim_state = BTRFS_TRIM_STATE_TRIMMED;
>   
> @@ -2537,6 +2572,16 @@ int btrfs_add_free_space(struct btrfs_block_group *block_group,
>   				      bytenr, size, trim_state);
>   }
>   
> +int btrfs_add_free_space_unused(struct btrfs_block_group *block_group,
> +				u64 bytenr, u64 size)
> +{
> +	if (btrfs_is_zoned(block_group->fs_info))
> +		return __btrfs_add_free_space_zoned(block_group, bytenr, size,
> +						    false);
> +
> +	return btrfs_add_free_space(block_group, bytenr, size);
> +}
> +
>   /*
>    * This is a subtle distinction because when adding free space back in general,
>    * we want it to be added as untrimmed for async. But in the case where we add
> @@ -2547,6 +2592,10 @@ int btrfs_add_free_space_async_trimmed(struct btrfs_block_group *block_group,
>   {
>   	enum btrfs_trim_state trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
>   
> +	if (btrfs_is_zoned(block_group->fs_info))
> +		return __btrfs_add_free_space_zoned(block_group, bytenr, size,
> +						    true);
> +
>   	if (btrfs_test_opt(block_group->fs_info, DISCARD_SYNC) ||
>   	    btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
>   		trim_state = BTRFS_TRIM_STATE_TRIMMED;
> @@ -2564,6 +2613,9 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
>   	int ret;
>   	bool re_search = false;
>   
> +	if (btrfs_is_zoned(block_group->fs_info))
> +		return 0;
> +
>   	spin_lock(&ctl->tree_lock);
>   
>   again:
> diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
> index e3d5e0ad8f8e..7081216257a8 100644
> --- a/fs/btrfs/free-space-cache.h
> +++ b/fs/btrfs/free-space-cache.h
> @@ -114,8 +114,12 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
>   			   struct btrfs_free_space_ctl *ctl,
>   			   u64 bytenr, u64 size,
>   			   enum btrfs_trim_state trim_state);
> +int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
> +				 u64 bytenr, u64 size, bool used);
>   int btrfs_add_free_space(struct btrfs_block_group *block_group,
>   			 u64 bytenr, u64 size);
> +int btrfs_add_free_space_unused(struct btrfs_block_group *block_group,
> +				u64 bytenr, u64 size);
>   int btrfs_add_free_space_async_trimmed(struct btrfs_block_group *block_group,
>   				       u64 bytenr, u64 size);
>   int btrfs_remove_free_space(struct btrfs_block_group *block_group,
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 64099565ab8f..bbbf3c1412a4 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -163,6 +163,7 @@ u64 __pure btrfs_space_info_used(struct btrfs_space_info *s_info,
>   	ASSERT(s_info);
>   	return s_info->bytes_used + s_info->bytes_reserved +
>   		s_info->bytes_pinned + s_info->bytes_readonly +
> +		s_info->bytes_zone_unusable +
>   		(may_use_included ? s_info->bytes_may_use : 0);
>   }
>   
> @@ -257,7 +258,7 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
>   
>   void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
>   			     u64 total_bytes, u64 bytes_used,
> -			     u64 bytes_readonly,
> +			     u64 bytes_readonly, u64 bytes_zone_unusable,
>   			     struct btrfs_space_info **space_info)
>   {
>   	struct btrfs_space_info *found;
> @@ -273,6 +274,7 @@ void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
>   	found->bytes_used += bytes_used;
>   	found->disk_used += bytes_used * factor;
>   	found->bytes_readonly += bytes_readonly;
> +	found->bytes_zone_unusable += bytes_zone_unusable;
>   	if (total_bytes > 0)
>   		found->full = 0;
>   	btrfs_try_granting_tickets(info, found);
> @@ -422,10 +424,10 @@ static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
>   		   info->total_bytes - btrfs_space_info_used(info, true),
>   		   info->full ? "" : "not ");
>   	btrfs_info(fs_info,
> -		"space_info total=%llu, used=%llu, pinned=%llu, reserved=%llu, may_use=%llu, readonly=%llu",
> +		"space_info total=%llu, used=%llu, pinned=%llu, reserved=%llu, may_use=%llu, readonly=%llu zone_unusable=%llu",
>   		info->total_bytes, info->bytes_used, info->bytes_pinned,
>   		info->bytes_reserved, info->bytes_may_use,
> -		info->bytes_readonly);
> +		info->bytes_readonly, info->bytes_zone_unusable);
>   
>   	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
>   	DUMP_BLOCK_RSV(fs_info, trans_block_rsv);
> @@ -454,9 +456,10 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
>   	list_for_each_entry(cache, &info->block_groups[index], list) {
>   		spin_lock(&cache->lock);
>   		btrfs_info(fs_info,
> -			"block group %llu has %llu bytes, %llu used %llu pinned %llu reserved %s",
> +			"block group %llu has %llu bytes, %llu used %llu pinned %llu reserved %llu zone_unusable %s",
>   			cache->start, cache->length, cache->used, cache->pinned,
> -			cache->reserved, cache->ro ? "[readonly]" : "");
> +			cache->reserved, cache->zone_unusable,
> +			cache->ro ? "[readonly]" : "");
>   		spin_unlock(&cache->lock);
>   		btrfs_dump_free_space(cache, bytes);
>   	}
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index 5646393b928c..ee003ffba956 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -17,6 +17,8 @@ struct btrfs_space_info {
>   	u64 bytes_may_use;	/* number of bytes that may be used for
>   				   delalloc/allocations */
>   	u64 bytes_readonly;	/* total bytes that are read only */
> +	u64 bytes_zone_unusable;	/* total bytes that are unusable until
> +					   resetting the device zone */
>   
>   	u64 max_extent_size;	/* This will hold the maximum extent size of
>   				   the space info if we had an ENOSPC in the
> @@ -119,7 +121,7 @@ DECLARE_SPACE_INFO_UPDATE(bytes_pinned, "pinned");
>   int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
>   void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
>   			     u64 total_bytes, u64 bytes_used,
> -			     u64 bytes_readonly,
> +			     u64 bytes_readonly, u64 bytes_zone_unusable,
>   			     struct btrfs_space_info **space_info);
>   struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
>   					       u64 flags);
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 828006020bbd..ea679803da9b 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -635,6 +635,7 @@ SPACE_INFO_ATTR(bytes_pinned);
>   SPACE_INFO_ATTR(bytes_reserved);
>   SPACE_INFO_ATTR(bytes_may_use);
>   SPACE_INFO_ATTR(bytes_readonly);
> +SPACE_INFO_ATTR(bytes_zone_unusable);
>   SPACE_INFO_ATTR(disk_used);
>   SPACE_INFO_ATTR(disk_total);
>   BTRFS_ATTR(space_info, total_bytes_pinned,
> @@ -648,6 +649,7 @@ static struct attribute *space_info_attrs[] = {
>   	BTRFS_ATTR_PTR(space_info, bytes_reserved),
>   	BTRFS_ATTR_PTR(space_info, bytes_may_use),
>   	BTRFS_ATTR_PTR(space_info, bytes_readonly),
> +	BTRFS_ATTR_PTR(space_info, bytes_zone_unusable),
>   	BTRFS_ATTR_PTR(space_info, disk_used),
>   	BTRFS_ATTR_PTR(space_info, disk_total),
>   	BTRFS_ATTR_PTR(space_info, total_bytes_pinned),
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 8f58d0853cc3..d94a2c363a47 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -993,3 +993,25 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
>   
>   	return ret;
>   }
> +
> +void btrfs_calc_zone_unusable(struct btrfs_block_group *cache)
> +{
> +	u64 unusable, free;
> +
> +	if (!btrfs_is_zoned(cache->fs_info))
> +		return;
> +
> +	WARN_ON(cache->bytes_super != 0);
> +	unusable = cache->alloc_offset - cache->used;
> +	free = cache->length - cache->alloc_offset;

newline.

> +	/* we only need ->free_space in ALLOC_SEQ BGs */
> +	cache->last_byte_to_unpin = (u64)-1;
> +	cache->cached = BTRFS_CACHE_FINISHED;
> +	cache->free_space_ctl->free_space = free;
> +	cache->zone_unusable = unusable;

newline.

> +	/*
> +	 * Should not have any excluded extents. Just
> +	 * in case, though.
> +	 */
> +	btrfs_free_excluded_extents(cache);
> +}

Thanks,

Josef
