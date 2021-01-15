Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E168E2F885F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 23:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbhAOWXO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 17:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbhAOWXO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:23:14 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C392AC0613D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jan 2021 14:22:33 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id d14so13236258qkc.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jan 2021 14:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3Lvp9bchHhPxaAaxFjeKy7okyrb9PuNFIE8ULqNKwqo=;
        b=g/7GwXopYmvdAh1P8pu3nXSw346E9keP1tBfGNlTzSizPiBdoBDmsi7pWx8Mx5B16n
         NDVE+iSaDG82HXvR5aT96+J6PZ2MHjDO+hSWZWVSnwHLNr5bMZQ3iuHs9WPJPbr7UlEK
         utHsuD68psPUdJhow1MxdKLWqYwt3LMFz5G9imsYvG60PihNE0RDYZdx1gLYWkzw9j7q
         9mcuPGUewDtw4sM8aMBsXTKpe+PunGm5AtaeOppVfAZRUKlIlVJ/grurBrU0Wv3l+fg+
         RU2PiSWJ1oceMryknYQUsjDaDP9U67X/3lD9DE9wwAipfCt0xsruRFEmFalk7/x1oJUP
         1B3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Lvp9bchHhPxaAaxFjeKy7okyrb9PuNFIE8ULqNKwqo=;
        b=ANNV6+wMOxeVeCp0BrunjqZzfeWZ43YhleqhjB/LrQ23lOV6Zb/L4ndkmnWw+SKl4j
         fHU0IEZB8RQAFAsnvo8jURvPxZ6ANMNr71EiysOJgj/x9jwCsBGROVRSzubTW11T28BO
         gIp16LAhV+NnkZDmWFyGit+JAJ9XGptKsCm4eVR88B7cNT0nFAiuDWX6QbKjpzfmC+Rw
         TP0taC89do0FlsXeaN+Uptcz412TRDiUHOE/I1FHffB3uDHQU/xRxsoO82nT70zvBuSO
         rWFtVbjFSazh71Kiu0xP3D6qNG935txvpr6ifeX51gsOR77tGdwG8GQC7mbVj6m14sl+
         v5Lg==
X-Gm-Message-State: AOAM53042gDvi87or7EajxV7MXpuHlWS19XIUlm0XxXPJDieZIr9dYkx
        JxaO0q6M2QyH3NTI7EHEFPMBEQ==
X-Google-Smtp-Source: ABdhPJz7CtudPc04p2uBP97bnr6IrHmEFt/mrn3XeydFewhQ/oWYGQ8xo65yKaUIhTRQ4kB8+w6h9w==
X-Received: by 2002:ae9:e00f:: with SMTP id m15mr14304920qkk.293.1610749352982;
        Fri, 15 Jan 2021 14:22:32 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11e1::105d? ([2620:10d:c091:480::1:cc17])
        by smtp.gmail.com with ESMTPSA id x20sm6033819qkj.18.2021.01.15.14.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 14:22:32 -0800 (PST)
Subject: Re: [PATCH v12 05/41] btrfs: release path before calling into
 btrfs_load_block_group_zone_info
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
 <0786a9782ec6306cddb0a2808116c3f95a88849b.1610693037.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8f7434ae-fdb8-32be-f781-a47f32ace949@toxicpanda.com>
Date:   Fri, 15 Jan 2021 17:22:31 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <0786a9782ec6306cddb0a2808116c3f95a88849b.1610693037.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/15/21 1:53 AM, Naohiro Aota wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Since we have no write pointer in conventional zones, we cannot determine
> the allocation offset from it. Instead, we set the allocation offset after
> the highest addressed extent. This is done by reading the extent tree in
> btrfs_load_block_group_zone_info().
> 
> However, this function is called from btrfs_read_block_groups(), so the
> read lock for the tree node can recursively taken.
> 
> To avoid this unsafe locking scenario, release the path before reading the
> extent tree to get the allocation offset.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/block-group.c | 39 ++++++++++++++++++---------------------
>   1 file changed, 18 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index b8bbdd95743e..ff13f7554ee5 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1806,24 +1806,8 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
>   	return ret;
>   }
>   
> -static void read_block_group_item(struct btrfs_block_group *cache,
> -				 struct btrfs_path *path,
> -				 const struct btrfs_key *key)
> -{
> -	struct extent_buffer *leaf = path->nodes[0];
> -	struct btrfs_block_group_item bgi;
> -	int slot = path->slots[0];
> -
> -	cache->length = key->offset;
> -
> -	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
> -			   sizeof(bgi));
> -	cache->used = btrfs_stack_block_group_used(&bgi);
> -	cache->flags = btrfs_stack_block_group_flags(&bgi);
> -}
> -
>   static int read_one_block_group(struct btrfs_fs_info *info,
> -				struct btrfs_path *path,
> +				struct btrfs_block_group_item *bgi,
>   				const struct btrfs_key *key,
>   				int need_clear)
>   {
> @@ -1838,7 +1822,9 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>   	if (!cache)
>   		return -ENOMEM;
>   
> -	read_block_group_item(cache, path, key);
> +	cache->length = key->offset;
> +	cache->used = btrfs_stack_block_group_used(bgi);
> +	cache->flags = btrfs_stack_block_group_flags(bgi);
>   
>   	set_free_space_tree_thresholds(cache);
>   
> @@ -1997,19 +1983,30 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
>   		need_clear = 1;
>   
>   	while (1) {
> +		struct btrfs_block_group_item bgi;
> +		struct extent_buffer *leaf;
> +		int slot;
> +
>   		ret = find_first_block_group(info, path, &key);
>   		if (ret > 0)
>   			break;
>   		if (ret != 0)
>   			goto error;
>   
> -		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> -		ret = read_one_block_group(info, path, &key, need_clear);
> +		leaf = path->nodes[0];
> +		slot = path->slots[0];
> +		btrfs_release_path(path);

You're releasing the path and then reading from it, a potential UAF.  Thanks,

Josef
