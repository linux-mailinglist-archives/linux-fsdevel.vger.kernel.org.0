Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227363006B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 16:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbhAVPIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 10:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbhAVPIN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:08:13 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F1DC06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 07:07:22 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id t17so4307277qtq.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 07:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h7y5VP0K5MP87hjBGawgiY2aXlKSQ1GPscxCxR0xq8k=;
        b=E7RGSxzKjmDNyuwC1qULuWKGDFIrR3CBgCmRIGdLi2xXdAtcvq+TeTDgjbxE6Dm1zS
         sQen7ZLxlK8eyvgXx33snPV3YgoKEOJRyhtDSIQ8m+egv+WjbeMQdJuNEEjqYszt7vgy
         /Si6pogrmy9ZCo1iltNKKkXI3iLZTGZSKEU3Jhs8FMw+Xv6Iquff8C1h6sSv+MHFqKh7
         eCcMTSe1V8Pfk4LA8MmtfLd1JYx7UzGWB6fAVWPXzqPMXqaEEU9XZbTFyS+LHmg6s+Fp
         2QM0HYeWaZ3zA5O7GRvgX+k5PS0MNGKTYZY268TrSS/F9meOyBmGO/jv6w+nZfGNL1n0
         JXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h7y5VP0K5MP87hjBGawgiY2aXlKSQ1GPscxCxR0xq8k=;
        b=jZzOSkhjbhjILZ4i9xtYUqGpBR7Ri8DjaIGjObUzQaG9RnVW2Zw0AtQBG5vucsURTj
         zG1EeFJ21mkztMiske7ZgogNKHDQsUN1cQZa8COBm6i2I7SyTAHK37U9b8+ZUmnvjHTO
         qeIIYmDGHhAB412vMvPYYYmroUGnpRnyAX/x7/5bbxSyOu3j4RRskqgU2qLI5itPjQnY
         1ew0zfVqiozv3IYnCyKtW/Dlv0o6X0vpkIP7XCz4/voyvBB0MVSFFjOLjZ5A9UiQz95i
         +3hrwmUEmYnY2gQiZ3CKwW8P5ZdRzl+aqeBZze2fsScpHqmk9IbYUd5EMv+WQdaEQQjS
         xsBQ==
X-Gm-Message-State: AOAM531lpZrj9wu5OKKFWaRocYjpIshXO7TKYBHTwxpPWJqR3HRiuzgU
        3IlL5M5+X8nKOm2cziw63UsZyQ==
X-Google-Smtp-Source: ABdhPJz0J+RRFF75WbKsaQzbGU9WhpHqTk9CXrZkY3DuR7pS5GSgxU5ycV0tEhiEpI4/yeQOnjy9vw==
X-Received: by 2002:ac8:c8c:: with SMTP id n12mr395137qti.339.1611328041245;
        Fri, 22 Jan 2021 07:07:21 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u63sm6330756qkc.115.2021.01.22.07.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 07:07:20 -0800 (PST)
Subject: Re: [PATCH v13 12/42] btrfs: calculate allocation offset for
 conventional zones
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
 <617bb7d3a62aa5702bbf31f47ec67fbc56576b30.1611295439.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8f7fbbfa-e100-14a4-fe56-ad2b017ba9d3@toxicpanda.com>
Date:   Fri, 22 Jan 2021 10:07:19 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <617bb7d3a62aa5702bbf31f47ec67fbc56576b30.1611295439.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/22/21 1:21 AM, Naohiro Aota wrote:
> Conventional zones do not have a write pointer, so we cannot use it to
> determine the allocation offset if a block group contains a conventional
> zone.
> 
> But instead, we can consider the end of the last allocated extent in the
> block group as an allocation offset.
> 
> For new block group, we cannot calculate the allocation offset by
> consulting the extent tree, because it can cause deadlock by taking extent
> buffer lock after chunk mutex (which is already taken in
> btrfs_make_block_group()). Since it is a new block group, we can simply set
> the allocation offset to 0, anyway.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/block-group.c |  4 +-
>   fs/btrfs/zoned.c       | 99 +++++++++++++++++++++++++++++++++++++++---
>   fs/btrfs/zoned.h       |  4 +-
>   3 files changed, 98 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 1c5ed46d376c..7c210aa5f25f 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1843,7 +1843,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>   			goto error;
>   	}
>   
> -	ret = btrfs_load_block_group_zone_info(cache);
> +	ret = btrfs_load_block_group_zone_info(cache, false);
>   	if (ret) {
>   		btrfs_err(info, "zoned: failed to load zone info of bg %llu",
>   			  cache->start);
> @@ -2138,7 +2138,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
>   	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
>   		cache->needs_free_space = 1;
>   
> -	ret = btrfs_load_block_group_zone_info(cache);
> +	ret = btrfs_load_block_group_zone_info(cache, true);
>   	if (ret) {
>   		btrfs_put_block_group(cache);
>   		return ret;
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 22c0665ee816..1b85a18d8573 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -930,7 +930,68 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
>   	return 0;
>   }
>   
> -int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
> +/*
> + * Calculate an allocation pointer from the extent allocation information
> + * for a block group consist of conventional zones. It is pointed to the
> + * end of the last allocated extent in the block group as an allocation
> + * offset.
> + */
> +static int calculate_alloc_pointer(struct btrfs_block_group *cache,
> +				   u64 *offset_ret)
> +{
> +	struct btrfs_fs_info *fs_info = cache->fs_info;
> +	struct btrfs_root *root = fs_info->extent_root;
> +	struct btrfs_path *path;
> +	struct btrfs_key key;
> +	struct btrfs_key found_key;
> +	int ret;
> +	u64 length;
> +
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	key.objectid = cache->start + cache->length;
> +	key.type = 0;
> +	key.offset = 0;
> +
> +	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> +	/* We should not find the exact match */
> +	if (!ret)
> +		ret = -EUCLEAN;
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = btrfs_previous_extent_item(root, path, cache->start);
> +	if (ret) {
> +		if (ret == 1) {
> +			ret = 0;
> +			*offset_ret = 0;
> +		}
> +		goto out;
> +	}
> +
> +	btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->slots[0]);
> +
> +	if (found_key.type == BTRFS_EXTENT_ITEM_KEY)
> +		length = found_key.offset;
> +	else
> +		length = fs_info->nodesize;
> +
> +	if (!(found_key.objectid >= cache->start &&
> +	       found_key.objectid + length <= cache->start + cache->length)) {
> +		ret = -EUCLEAN;
> +		goto out;
> +	}
> +	*offset_ret = found_key.objectid + length - cache->start;
> +	ret = 0;
> +
> +out:
> +	btrfs_free_path(path);
> +	return ret;
> +}
> +
> +int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
>   {
>   	struct btrfs_fs_info *fs_info = cache->fs_info;
>   	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
> @@ -944,6 +1005,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
>   	int i;
>   	unsigned int nofs_flag;
>   	u64 *alloc_offsets = NULL;
> +	u64 last_alloc = 0;
>   	u32 num_sequential = 0, num_conventional = 0;
>   
>   	if (!btrfs_is_zoned(fs_info))
> @@ -1042,11 +1104,30 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
>   
>   	if (num_conventional > 0) {
>   		/*
> -		 * Since conventional zones do not have a write pointer, we
> -		 * cannot determine alloc_offset from the pointer
> +		 * Avoid calling calculate_alloc_pointer() for new BG. It
> +		 * is no use for new BG. It must be always 0.
> +		 *
> +		 * Also, we have a lock chain of extent buffer lock ->
> +		 * chunk mutex.  For new BG, this function is called from
> +		 * btrfs_make_block_group() which is already taking the
> +		 * chunk mutex. Thus, we cannot call
> +		 * calculate_alloc_pointer() which takes extent buffer
> +		 * locks to avoid deadlock.
>   		 */
> -		ret = -EINVAL;
> -		goto out;
> +		if (new) {
> +			cache->alloc_offset = 0;
> +			goto out;
> +		}
> +		ret = calculate_alloc_pointer(cache, &last_alloc);
> +		if (ret || map->num_stripes == num_conventional) {
> +			if (!ret)
> +				cache->alloc_offset = last_alloc;
> +			else
> +				btrfs_err(fs_info,
> +			"zoned: failed to determine allocation offset of bg %llu",
> +					  cache->start);
> +			goto out;
> +		}
>   	}
>   
>   	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
> @@ -1068,6 +1149,14 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
>   	}
>   
>   out:
> +	/* An extent is allocated after the write pointer */
> +	if (num_conventional && last_alloc > cache->alloc_offset) {
> +		btrfs_err(fs_info,
> +			  "zoned: got wrong write pointer in BG %llu: %llu > %llu",
> +			  logical, last_alloc, cache->alloc_offset);
> +		ret = -EIO;
> +	}
> +

Sorry I didn't notice this on the last go around, but you could conceivably eat 
the ret value here, this should probably be

if (!ret && num_conventional && last_alloc > cache->alloc_offset) {
}

Thanks,

Josef
