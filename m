Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979A22A4AB8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 17:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgKCQEm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 11:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgKCQEl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 11:04:41 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F754C0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 08:04:40 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id t5so3373403qtp.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 08:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+8c/7MWJ1/1ydorj82YmUDLF+xLcZaJ0p+mtwbUVJL4=;
        b=XluJx3AuL7HKe2iLQAuXA5FZQcnA8v6SKHNX3aKD+PdUBSXnYoPtczizV1TSDD2Exk
         7up5n2T4bwAdDO8LFqM0j/tYyLzSTiATpIDhx+Kn8EkG/WmoBcFCq71k3EG/GAdlWiT3
         1R9KdB/pCFmfkVZQD2tYmaKl3B0QADl5ikJ6dFBKjQlywt5TjeF1HPQfeWSa4f+GO4EQ
         UyKzKdLbSzp7UygwbKoFHaFOwXxpwaGE5oT1dEfFcpjyKvblmv0oHcLdxxoQyHX1gwP0
         cxUmNc1DeCxJ5R/qFDq77Gl3p+vXcpOt8Ff1UtvggjN5xo+OAukJLg440L5gMonZvSXo
         3K9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+8c/7MWJ1/1ydorj82YmUDLF+xLcZaJ0p+mtwbUVJL4=;
        b=ULpaKoHWih5Yw4dKcquMwr85dSJUpdtuvgCsbeSStyrqL7+uyg7MHv6SeP5tiSxL4U
         8dKmvlrBAXNlQOsGLwVzueEmPMT8KLGNvUVKqNZxeQ974AdLPyY2GJm1fUg9JNqk6Ic/
         dZfRR+8DxgoLpxDC39aW4aw2Vt79KjPKV8Dbg79McroyPAn8aSem9kRz74YWGF3CiUp3
         lEVQkslE8rfaMuWE/yJpB2ZCVg0DwW5HnJwokGmJ9bZKfkQmWNzjAo24ZL0pz4BhqgUd
         Xo3PtyqA9ydp05DCeNChR9KqAfUsxJrIgi2L4EWBy8vsRx69hUUTPUOSUS3ONAUIHKXQ
         LLeA==
X-Gm-Message-State: AOAM533AayAP4FWfgGR/r5sEMw8fVqCXBT5C6XKnXtjLgeL23fQxPn47
        GBI57G4ZKhRcznTkYZm486WzWk0JZEjBFN05
X-Google-Smtp-Source: ABdhPJyXMCh9ZBXzscP8jpmY4t+YjYLMuhVYnHKq2+lx9mL09K5BwNUinxmuAqzEqMczVRvoNklGjg==
X-Received: by 2002:ac8:540e:: with SMTP id b14mr20033831qtq.136.1604419479417;
        Tue, 03 Nov 2020 08:04:39 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w9sm10596364qkw.103.2020.11.03.08.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 08:04:38 -0800 (PST)
Subject: Re: [PATCH v9 28/41] btrfs: serialize meta IOs on ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <61771fe28bda89abcdb55b2a00be05eb82d2216e.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e3107657-aa88-7682-cece-83fac2b93d16@toxicpanda.com>
Date:   Tue, 3 Nov 2020 11:04:37 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <61771fe28bda89abcdb55b2a00be05eb82d2216e.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> We cannot use zone append for writing metadata, because the B-tree nodes
> have references to each other using the logical address. Without knowing
> the address in advance, we cannot construct the tree in the first place.
> So we need to serialize write IOs for metadata.
> 
> We cannot add a mutex around allocation and submission because metadata
> blocks are allocated in an earlier stage to build up B-trees.
> 
> Add a zoned_meta_io_lock and hold it during metadata IO submission in
> btree_write_cache_pages() to serialize IOs. Furthermore, this add a
> per-block group metadata IO submission pointer "meta_write_pointer" to
> ensure sequential writing, which can be caused when writing back blocks in
> an unfinished transaction.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/block-group.h |  1 +
>   fs/btrfs/ctree.h       |  1 +
>   fs/btrfs/disk-io.c     |  1 +
>   fs/btrfs/extent_io.c   | 27 ++++++++++++++++++++++-
>   fs/btrfs/zoned.c       | 50 ++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/zoned.h       | 31 ++++++++++++++++++++++++++
>   6 files changed, 110 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 401e9bcefaec..b2a8a3beceac 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -190,6 +190,7 @@ struct btrfs_block_group {
>   	 */
>   	u64 alloc_offset;
>   	u64 zone_unusable;
> +	u64 meta_write_pointer;
>   };
>   
>   static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 383c83a1f5b5..736f679f1310 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -955,6 +955,7 @@ struct btrfs_fs_info {
>   	};
>   	/* max size to emit ZONE_APPEND write command */
>   	u64 max_zone_append_size;
> +	struct mutex zoned_meta_io_lock;
>   
>   #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>   	spinlock_t ref_verify_lock;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 778716e223ff..f02b121d8213 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2652,6 +2652,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>   	mutex_init(&fs_info->delete_unused_bgs_mutex);
>   	mutex_init(&fs_info->reloc_mutex);
>   	mutex_init(&fs_info->delalloc_root_mutex);
> +	mutex_init(&fs_info->zoned_meta_io_lock);
>   	seqlock_init(&fs_info->profiles_lock);
>   
>   	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 3f49febafc69..3cce444d5dbb 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -25,6 +25,7 @@
>   #include "backref.h"
>   #include "disk-io.h"
>   #include "zoned.h"
> +#include "block-group.h"
>   
>   static struct kmem_cache *extent_state_cache;
>   static struct kmem_cache *extent_buffer_cache;
> @@ -4001,6 +4002,7 @@ int btree_write_cache_pages(struct address_space *mapping,
>   				   struct writeback_control *wbc)
>   {
>   	struct extent_buffer *eb, *prev_eb = NULL;
> +	struct btrfs_block_group *cache = NULL;
>   	struct extent_page_data epd = {
>   		.bio = NULL,
>   		.extent_locked = 0,
> @@ -4035,6 +4037,7 @@ int btree_write_cache_pages(struct address_space *mapping,
>   		tag = PAGECACHE_TAG_TOWRITE;
>   	else
>   		tag = PAGECACHE_TAG_DIRTY;
> +	btrfs_zoned_meta_io_lock(fs_info);
>   retry:
>   	if (wbc->sync_mode == WB_SYNC_ALL)
>   		tag_pages_for_writeback(mapping, index, end);
> @@ -4077,12 +4080,30 @@ int btree_write_cache_pages(struct address_space *mapping,
>   			if (!ret)
>   				continue;
>   
> +			if (!btrfs_check_meta_write_pointer(fs_info, eb,
> +							    &cache)) {
> +				/*
> +				 * If for_sync, this hole will be filled with
> +				 * trasnsaction commit.
> +				 */
> +				if (wbc->sync_mode == WB_SYNC_ALL &&
> +				    !wbc->for_sync)
> +					ret = -EAGAIN;
> +				else
> +					ret = 0;
> +				done = 1;
> +				free_extent_buffer(eb);
> +				break;
> +			}
> +
>   			prev_eb = eb;
>   			ret = lock_extent_buffer_for_io(eb, &epd);
>   			if (!ret) {
> +				btrfs_revert_meta_write_pointer(cache, eb);
>   				free_extent_buffer(eb);
>   				continue;
>   			} else if (ret < 0) {
> +				btrfs_revert_meta_write_pointer(cache, eb);
>   				done = 1;
>   				free_extent_buffer(eb);
>   				break;
> @@ -4115,10 +4136,12 @@ int btree_write_cache_pages(struct address_space *mapping,
>   		index = 0;
>   		goto retry;
>   	}
> +	if (cache)
> +		btrfs_put_block_group(cache);
>   	ASSERT(ret <= 0);
>   	if (ret < 0) {
>   		end_write_bio(&epd, ret);
> -		return ret;
> +		goto out;
>   	}
>   	/*
>   	 * If something went wrong, don't allow any metadata write bio to be
> @@ -4153,6 +4176,8 @@ int btree_write_cache_pages(struct address_space *mapping,
>   		ret = -EROFS;
>   		end_write_bio(&epd, ret);
>   	}
> +out:
> +	btrfs_zoned_meta_io_unlock(fs_info);
>   	return ret;
>   }
>   
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 50393d560c9a..15bc7d451348 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -989,6 +989,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
>   		ret = -EIO;
>   	}
>   
> +	if (!ret)
> +		cache->meta_write_pointer = cache->alloc_offset + cache->start;
> +
>   	kfree(alloc_offsets);
>   	free_extent_map(em);
>   
> @@ -1120,3 +1123,50 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
>   	kfree(logical);
>   	bdput(bdev);
>   }
> +
> +bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
> +				    struct extent_buffer *eb,
> +				    struct btrfs_block_group **cache_ret)
> +{
> +	struct btrfs_block_group *cache;
> +
> +	if (!btrfs_is_zoned(fs_info))
> +		return true;
> +
> +	cache = *cache_ret;
> +
> +	if (cache && (eb->start < cache->start ||
> +		      cache->start + cache->length <= eb->start)) {
> +		btrfs_put_block_group(cache);
> +		cache = NULL;
> +		*cache_ret = NULL;
> +	}
> +
> +	if (!cache)
> +		cache = btrfs_lookup_block_group(fs_info, eb->start);
> +
> +	if (cache) {
> +		*cache_ret = cache;

Don't set this here, set it after the if statement.

> +
> +		if (cache->meta_write_pointer != eb->start) {
> +			btrfs_put_block_group(cache);
> +			cache = NULL;
> +			*cache_ret = NULL;

And delete these two lines.  Then you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
