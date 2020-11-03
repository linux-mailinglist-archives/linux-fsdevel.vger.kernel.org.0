Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69ECA2A4C5A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 18:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgKCRJ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 12:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbgKCRJ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:09:56 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D601CC0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 09:09:55 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id q1so5986912qvn.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 09:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bQz8A85Yyw+vm4KtRt8ZEoqc2bnEJPLOXoi1HomhVfA=;
        b=FEwI9QWPmTYSLL9Gxt5JYOf1+/Rk5yGqJuDEJqyNAqCgRdM3puX81GNP5B2OQxDQye
         JahKP83eONFbsdnHxyk/QscEWG0tbgR/w+cn61sKdx6eCOHE3wna0eIa+GlktFtkxK4C
         lMaUlF6FhUtcV2uUys3Zi8IgZyN8FwjxNnp3Xh+6xdPQvNKMuWgPibp6VSnDizFQWNpA
         No30udmKd3O1fMFjGdla25hMu0/ElBykLoKD+eg+6zIDex3xcWoS9uZ493KnZ7pqzeWJ
         aV14iuHQ/tlAVd16t3GJHRwtjEYabBegBOZAbpYYwiZkNsscVV2lFS6M8QUy/9+8GjP8
         L9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bQz8A85Yyw+vm4KtRt8ZEoqc2bnEJPLOXoi1HomhVfA=;
        b=hoWjt6satk40oVdLXPTA8Y9kHA2ZapN0PRzv5fRTjqD6Bn+3YVM7+eLzLGKTUV4Nmw
         VohQqTUdw67cdtEEipLxZK4r+qsX/xEjlPyN/iQxoeyOR4p8RBP2kzxylOmSzrLgmlxF
         9H2Nr6zf5qwzKVnniSbIqBrji1ovBA05fR+QJZGyzwExPu+1CvpT9ErezEdalPaD/gFN
         VPInQBedbzg4Ab5swxlNW46LhhV373/s3U9IJsDqgbHJYsVKFZ8JgAm5SEWfdzB9Yuax
         Av31CwrKClGz7mNcMkxzLSbaC20mMGFkGQGOveJ10e8vqSr06y6E7tUb1rssSrA85Sxy
         bShQ==
X-Gm-Message-State: AOAM530lJUIxUv2FTZCxKLsHHob6lvfl5Ngjjr78Nqr73AeAAOzirNko
        AFr2vevrIZhnvh0Y6nGts5FXz9UlJkk7xZ+s
X-Google-Smtp-Source: ABdhPJyPIwzUXrnpHCOM6cC+xvJLUUiPE1NWYNh0JpHOds0709Uzrnum9g/blqQ9no5nAbj84SNxGw==
X-Received: by 2002:a0c:b98f:: with SMTP id v15mr26297170qvf.51.1604423394126;
        Tue, 03 Nov 2020 09:09:54 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 71sm11082139qko.55.2020.11.03.09.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 09:09:53 -0800 (PST)
Subject: Re: [PATCH v9 31/41] btrfs: mark block groups to copy for
 device-replace
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <500edb962a76f3b9a6df9a6183efdc814d68d4d6.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f4dbd994-edac-c275-7838-78f3429f35c9@toxicpanda.com>
Date:   Tue, 3 Nov 2020 12:09:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <500edb962a76f3b9a6df9a6183efdc814d68d4d6.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> This is the 1/4 patch to support device-replace in ZONED mode.
> 
> We have two types of I/Os during the device-replace process. One is an I/O
> to "copy" (by the scrub functions) all the device extents on the source
> device to the destination device.  The other one is an I/O to "clone" (by
> handle_ops_on_dev_replace()) new incoming write I/Os from users to the
> source device into the target device.
> 
> Cloning incoming I/Os can break the sequential write rule in the target
> device. When writing is mapped in the middle of a block group, the I/O is
> directed in the middle of a target device zone, which breaks the sequential
> write rule.
> 
> However, the cloning function cannot be merely disabled since incoming I/Os
> targeting already copied device extents must be cloned so that the I/O is
> executed on the target device.
> 
> We cannot use dev_replace->cursor_{left,right} to determine whether bio is
> going to not yet copied region.  Since we have a time gap between finishing
> btrfs_scrub_dev() and rewriting the mapping tree in
> btrfs_dev_replace_finishing(), we can have a newly allocated device extent
> which is never cloned nor copied.
> 
> So the point is to copy only already existing device extents. This patch
> introduces mark_block_group_to_copy() to mark existing block groups as a
> target of copying. Then, handle_ops_on_dev_replace() and dev-replace can
> check the flag to do their job.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/block-group.h |   1 +
>   fs/btrfs/dev-replace.c | 175 +++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/dev-replace.h |   3 +
>   fs/btrfs/scrub.c       |  17 ++++
>   4 files changed, 196 insertions(+)
> 
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index b2a8a3beceac..e91123495d68 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -95,6 +95,7 @@ struct btrfs_block_group {
>   	unsigned int iref:1;
>   	unsigned int has_caching_ctl:1;
>   	unsigned int removed:1;
> +	unsigned int to_copy:1;
>   
>   	int disk_cache_state;
>   
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 5e3554482af1..e86aff38aea4 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -22,6 +22,7 @@
>   #include "dev-replace.h"
>   #include "sysfs.h"
>   #include "zoned.h"
> +#include "block-group.h"
>   
>   /*
>    * Device replace overview
> @@ -437,6 +438,176 @@ static char* btrfs_dev_name(struct btrfs_device *device)
>   		return rcu_str_deref(device->name);
>   }
>   
> +static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
> +				    struct btrfs_device *src_dev)
> +{
> +	struct btrfs_path *path;
> +	struct btrfs_key key;
> +	struct btrfs_key found_key;
> +	struct btrfs_root *root = fs_info->dev_root;
> +	struct btrfs_dev_extent *dev_extent = NULL;
> +	struct btrfs_block_group *cache;
> +	struct extent_buffer *l;
> +	struct btrfs_trans_handle *trans;
> +	int slot;
> +	int ret = 0;
> +	u64 chunk_offset, length;
> +
> +	/* Do not use "to_copy" on non-ZONED for now */
> +	if (!btrfs_fs_incompat(fs_info, ZONED))
> +		return 0;

if (!btrfs_is_zoned())

> +
> +	mutex_lock(&fs_info->chunk_mutex);
> +
> +	/* ensulre we don't have pending new block group */

ensure.

> +	while (fs_info->running_transaction &&
> +	       !list_empty(&fs_info->running_transaction->dev_update_list)) {

This is not safe to check, running_transaction can change without the trans_lock 
held.

> +		mutex_unlock(&fs_info->chunk_mutex);
> +		trans = btrfs_attach_transaction(root);
> +		if (IS_ERR(trans)) {
> +			ret = PTR_ERR(trans);
> +			mutex_lock(&fs_info->chunk_mutex);
> +			if (ret == -ENOENT)
> +				continue;
> +			else
> +				goto out;
> +		}
> +
> +		ret = btrfs_commit_transaction(trans);
> +		mutex_lock(&fs_info->chunk_mutex);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	path = btrfs_alloc_path();
> +	if (!path) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	path->reada = READA_FORWARD;
> +	path->search_commit_root = 1;
> +	path->skip_locking = 1;
> +
> +	key.objectid = src_dev->devid;
> +	key.offset = 0ull;

0 is fine here right?

> +	key.type = BTRFS_DEV_EXTENT_KEY;
> +
> +	while (1) {
> +		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> +		if (ret < 0)
> +			break;
> +		if (ret > 0) {
> +			if (path->slots[0] >=
> +			    btrfs_header_nritems(path->nodes[0])) {
> +				ret = btrfs_next_leaf(root, path);
> +				if (ret < 0)
> +					break;
> +				if (ret > 0) {
> +					ret = 0;
> +					break;
> +				}
> +			} else {
> +				ret = 0;
> +			}
> +		}
> +
> +		l = path->nodes[0];
> +		slot = path->slots[0];
> +
> +		btrfs_item_key_to_cpu(l, &found_key, slot);
> +
> +		if (found_key.objectid != src_dev->devid)
> +			break;
> +
> +		if (found_key.type != BTRFS_DEV_EXTENT_KEY)
> +			break;
> +
> +		if (found_key.offset < key.offset)
> +			break;
> +
> +		dev_extent = btrfs_item_ptr(l, slot, struct btrfs_dev_extent);
> +		length = btrfs_dev_extent_length(l, dev_extent);
> +
> +		chunk_offset = btrfs_dev_extent_chunk_offset(l, dev_extent);
> +
> +		cache = btrfs_lookup_block_group(fs_info, chunk_offset);
> +		if (!cache)
> +			goto skip;
> +
> +		spin_lock(&cache->lock);
> +		cache->to_copy = 1;
> +		spin_unlock(&cache->lock);
> +
> +		btrfs_put_block_group(cache);
> +
> +skip:
> +		key.offset = found_key.offset + length;
> +		btrfs_release_path(path);

Why are you releasing the path here?

This can be re-arranged into a loop that just uses btrfs_next_item().


> +	}
> +
> +	btrfs_free_path(path);
> +out:
> +	mutex_unlock(&fs_info->chunk_mutex);
> +
> +	return ret;
> +}
> +
> +bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
> +				      struct btrfs_block_group *cache,
> +				      u64 physical)
> +{
> +	struct btrfs_fs_info *fs_info = cache->fs_info;
> +	struct extent_map *em;
> +	struct map_lookup *map;
> +	u64 chunk_offset = cache->start;
> +	int num_extents, cur_extent;
> +	int i;
> +
> +	/* Do not use "to_copy" on non-ZONED for now */
> +	if (!btrfs_fs_incompat(fs_info, ZONED))
> +		return true;

btrfs_is_zoned();

> +
> +	spin_lock(&cache->lock);
> +	if (cache->removed) {
> +		spin_unlock(&cache->lock);
> +		return true;
> +	}
> +	spin_unlock(&cache->lock);
> +
> +	em = btrfs_get_chunk_map(fs_info, chunk_offset, 1);
> +	BUG_ON(IS_ERR(em));

ASSERT(!IS_ERR(em));

> +	map = em->map_lookup;
> +
> +	num_extents = cur_extent = 0;
> +	for (i = 0; i < map->num_stripes; i++) {
> +		/* we have more device extent to copy */
> +		if (srcdev != map->stripes[i].dev)
> +			continue;
> +
> +		num_extents++;
> +		if (physical == map->stripes[i].physical)
> +			cur_extent = i;
> +	}
> +
> +	free_extent_map(em);
> +
> +	if (num_extents > 1 && cur_extent < num_extents - 1) {
> +		/*
> +		 * Has more stripes on this device. Keep this BG
> +		 * readonly until we finish all the stripes.
> +		 */
> +		return false;
> +	}
> +
> +	/* last stripe on this device */
> +	spin_lock(&cache->lock);
> +	cache->to_copy = 0;
> +	spin_unlock(&cache->lock);
> +
> +	return true;
> +}
> +
>   static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
>   		const char *tgtdev_name, u64 srcdevid, const char *srcdev_name,
>   		int read_src)
> @@ -478,6 +649,10 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
>   	if (ret)
>   		return ret;
>   
> +	ret = mark_block_group_to_copy(fs_info, src_device);
> +	if (ret)
> +		return ret;
> +
>   	down_write(&dev_replace->rwsem);
>   	switch (dev_replace->replace_state) {
>   	case BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED:
> diff --git a/fs/btrfs/dev-replace.h b/fs/btrfs/dev-replace.h
> index 60b70dacc299..3911049a5f23 100644
> --- a/fs/btrfs/dev-replace.h
> +++ b/fs/btrfs/dev-replace.h
> @@ -18,5 +18,8 @@ int btrfs_dev_replace_cancel(struct btrfs_fs_info *fs_info);
>   void btrfs_dev_replace_suspend_for_unmount(struct btrfs_fs_info *fs_info);
>   int btrfs_resume_dev_replace_async(struct btrfs_fs_info *fs_info);
>   int __pure btrfs_dev_replace_is_ongoing(struct btrfs_dev_replace *dev_replace);
> +bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
> +				      struct btrfs_block_group *cache,
> +				      u64 physical);
>   
>   #endif
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index aa1b36cf5c88..d0d7db3c8b0b 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -3500,6 +3500,17 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>   		if (!cache)
>   			goto skip;
>   
> +
> +		if (sctx->is_dev_replace && btrfs_fs_incompat(fs_info, ZONED)) {

btrfs_is_zoned().  Thanks,

Josef
