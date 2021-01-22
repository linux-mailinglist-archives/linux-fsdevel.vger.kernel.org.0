Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908163006D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 16:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbhAVPNF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 10:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbhAVPMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:12:37 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41B0C0613D6
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 07:11:56 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id az16so2773397qvb.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 07:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LU9c8QyMvjvLcICnfyOxjTnuoLNhiFoIC1h0Nmesur4=;
        b=kWrXukLQALYQJdnkJTIqqujnUAS/LCItOTCEAUFS5QuwblCOTBAUB2kSXl5ymO1+RE
         js4BfsgAGq8cVSFsxJG1OcrZJBs9MQjrI2uGrnMRg3xuuVxXJeYc08Sj3S2CIwrnX5Th
         5fAaGpWrohiSL2/4eT8FMEbtbjKtcMGsUp5qgvOXb0vWHeMbm5mOk6U304ethZfi/CzK
         9jnkGN+oqkHfAqAqqdU4lZGIlhd1UHQV0wk2AYI5YjPSfzkdtwCC0WoWxuX8HqGojJLK
         DvH+tbRM5xZQQj6GX2FzWGOVP8NFWbDxKf1dC9RHNxkmA0fCDxEWKZkeGQV5EiNZL7eR
         GgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LU9c8QyMvjvLcICnfyOxjTnuoLNhiFoIC1h0Nmesur4=;
        b=L90GTyvbIFzKRgxqIV7BLkxQ7A8gEs1zVj19SCCST6JWvysq6zcewzSJVUCRwAXV0w
         bjwitKQNRJyEjq6QUEewLo6/AvD/eGY4d8DD4Oo/GqFsoE50H6rn+h+beqxaZUovaEAR
         TrL17j0twfO5DFDjQ42S8VaY+zvwl03fY70MgBeYB3YbxzUU0UC36stM2doQw6OnmGiW
         ZZMKYtIZC7udb+llgVLKNg5OORy418P1Vj9yeRIwYG0JsA/ggwcAa5vXbCW/wcCAiiNC
         bcJbq6yJQkUNlACFxvcOuoyVMCrzZyKYQCOTsPv3LA9iPdlolCwf9Jh4D4W2Ba3rF2ZK
         40pw==
X-Gm-Message-State: AOAM531jpwwLqtD//4AO8RmjHekqpNG+/YCuMvqeaRyKQNSIg0tB0wnr
        TqYw5+mQNuSlfpoXndc8DG5firzV3lTUBumn
X-Google-Smtp-Source: ABdhPJw6WmzAjRodLvbmeY8i7Gx8F2xYHR80JO18Ej/w+30GsupmsA1aXiR1BhO64a62Zik9Yxn3Eg==
X-Received: by 2002:a0c:f601:: with SMTP id r1mr4992893qvm.39.1611328315701;
        Fri, 22 Jan 2021 07:11:55 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p128sm6347827qkb.101.2021.01.22.07.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 07:11:54 -0800 (PST)
Subject: Re: [PATCH v13 13/42] btrfs: track unusable bytes for zones
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
 <b949ad399801a5c5c5a07cafcb259b6151e66e48.1611295439.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7f676b7d-ab80-5dc1-6fbf-ed29e4bf4512@toxicpanda.com>
Date:   Fri, 22 Jan 2021 10:11:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <b949ad399801a5c5c5a07cafcb259b6151e66e48.1611295439.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/22/21 1:21 AM, Naohiro Aota wrote:
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
>   fs/btrfs/block-group.c      | 39 ++++++++++++++-------
>   fs/btrfs/block-group.h      |  1 +
>   fs/btrfs/extent-tree.c      | 10 +++++-
>   fs/btrfs/free-space-cache.c | 67 +++++++++++++++++++++++++++++++++++++
>   fs/btrfs/free-space-cache.h |  2 ++
>   fs/btrfs/space-info.c       | 13 ++++---
>   fs/btrfs/space-info.h       |  4 ++-
>   fs/btrfs/sysfs.c            |  2 ++
>   fs/btrfs/zoned.c            | 24 +++++++++++++
>   fs/btrfs/zoned.h            |  3 ++
>   10 files changed, 146 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 7c210aa5f25f..487511e3f000 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1001,12 +1001,17 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
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
> +	block_group->space_info->bytes_zone_unusable -=
> +		block_group->zone_unusable;
>   	block_group->space_info->disk_total -= block_group->length * factor;
>   
>   	spin_unlock(&block_group->space_info->lock);
> @@ -1150,7 +1155,7 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
>   	}
>   
>   	num_bytes = cache->length - cache->reserved - cache->pinned -
> -		    cache->bytes_super - cache->used;
> +		    cache->bytes_super - cache->zone_unusable - cache->used;
>   
>   	/*
>   	 * Data never overcommits, even in mixed mode, so do just the straight
> @@ -1863,12 +1868,20 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>   	}
>   
>   	/*
> -	 * Check for two cases, either we are full, and therefore don't need
> -	 * to bother with the caching work since we won't find any space, or we
> -	 * are empty, and we can just add all the space in and be done with it.
> -	 * This saves us _a_lot_ of time, particularly in the full case.
> +	 * For zoned btrfs, space after the allocation offset is the only
> +	 * free space for a block group. So, we don't need any caching
> +	 * work. btrfs_calc_zone_unusable() will set the amount of free
> +	 * space and zone_unusable space.
> +	 *
> +	 * For regular btrfs, check for two cases, either we are full, and
> +	 * therefore don't need to bother with the caching work since we
> +	 * won't find any space, or we are empty, and we can just add all
> +	 * the space in and be done with it.  This saves us _a_lot_ of
> +	 * time, particularly in the full case.
>   	 */
> -	if (cache->length == cache->used) {
> +	if (btrfs_is_zoned(info)) {
> +		btrfs_calc_zone_unusable(cache);
> +	} else if (cache->length == cache->used) {
>   		cache->last_byte_to_unpin = (u64)-1;
>   		cache->cached = BTRFS_CACHE_FINISHED;
>   		btrfs_free_excluded_extents(cache);
> @@ -1887,7 +1900,8 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>   	}
>   	trace_btrfs_add_block_group(info, cache, 0);
>   	btrfs_update_space_info(info, cache->flags, cache->length,
> -				cache->used, cache->bytes_super, &space_info);
> +				cache->used, cache->bytes_super,
> +				cache->zone_unusable, &space_info);
>   
>   	cache->space_info = space_info;
>   
> @@ -1943,7 +1957,7 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
>   			break;
>   		}
>   		btrfs_update_space_info(fs_info, bg->flags, em->len, em->len,
> -					0, &space_info);
> +					0, 0, &space_info);
>   		bg->space_info = space_info;
>   		link_block_group(bg);
>   
> @@ -2185,7 +2199,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
>   	 */
>   	trace_btrfs_add_block_group(fs_info, cache, 1);
>   	btrfs_update_space_info(fs_info, cache->flags, size, bytes_used,
> -				cache->bytes_super, &cache->space_info);
> +				cache->bytes_super, 0, &cache->space_info);
>   	btrfs_update_global_block_rsv(fs_info);
>   
>   	link_block_group(cache);
> @@ -2293,7 +2307,8 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group *cache)
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
> index 9d026ab1768d..0f3c62c561bc 100644
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
> index 30b1a630dc2f..071a521927e6 100644
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
> @@ -2725,6 +2726,9 @@ fetch_cluster_info(struct btrfs_fs_info *fs_info,
>   {
>   	struct btrfs_free_cluster *ret = NULL;
>   
> +	if (btrfs_is_zoned(fs_info))
> +		return NULL;
> +

This is unrelated to the rest of the changes, seems like something that was just 
missed?  Should probably be in its own patch.

>   	*empty_cluster = 0;
>   	if (btrfs_mixed_space_info(space_info))
>   		return ret;
> @@ -2808,7 +2812,11 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
>   		space_info->max_extent_size = 0;
>   		percpu_counter_add_batch(&space_info->total_bytes_pinned,
>   			    -len, BTRFS_TOTAL_BYTES_PINNED_BATCH);
> -		if (cache->ro) {
> +		if (btrfs_is_zoned(fs_info)) {
> +			/* Need reset before reusing in a zoned block group */
> +			space_info->bytes_zone_unusable += len;
> +			readonly = true;
> +		} else if (cache->ro) {
>   			space_info->bytes_readonly += len;
>   			readonly = true;
>   		}

Is this right?  If we're balancing a block group then it could be marked ro and 
be zoned, so don't we want to account for this in ->bytes_readonly if it's read 
only?  So probably more correct to do

if (cache->ro) {
	/* stuff */
} else if (btrfs_is_zoned(fs_info) {
	/* other stuff */
}

right?  Thanks,

Josef
