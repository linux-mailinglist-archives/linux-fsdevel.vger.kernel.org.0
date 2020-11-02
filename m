Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1872A3545
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 21:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgKBUjA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 15:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgKBUhi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:37:38 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30235C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 12:37:38 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id j62so10193862qtd.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 12:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D6/J1WXU+3whBjn1wgKz6HaRQqP/dHDDkAKpZ/g3upA=;
        b=zZomg6qNYCpVK0L2mL9DFxtUD0vE48C22eU7d1RQyYuqfe6Ux+Jlx6zZpqOkM9+E0Y
         kjFjfMHUYkWpJjUueTHfQTVFrjnaj0laDa8/B9z7IQYZJ8LQnIKVQLL8Bd9/K46+a/7d
         TjdRiHjR658YB7J1wh+re4Bx295Clv61lAfkMhw711alavxu3RfsIJyPa6RPjYl1eNNE
         mcYq/0EhFcqLqPd07BFrB7t8rA02v0zHSzI4/uDgfz66hpdmz56osvsP65r8M7QjadY+
         Q/UGldZlxQ/BZDD8BuxpiwDEM4gOfha8tjd4ZVau8qWGxraptXKgQprIZtyKrtZkEvqP
         CWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D6/J1WXU+3whBjn1wgKz6HaRQqP/dHDDkAKpZ/g3upA=;
        b=Gab20XIPhVyP8Xc+nH6VwC0N9XH7EaWlz2JWNQ5d1mv2L8v2qrPUzy+tsytHormYlJ
         TTRDrd4Cr7UctmYYhLKPsZF2zhXn4YwgJ6kNJZG8AV493V3Zv6CzFKRBorSTczYIjl5K
         T47LPzW0v6tLQ4nJmPJDARO4hGfsZvYzodto8NktdezYlQAFClc6tu2BacpkmQQXyDWt
         G0ZKWAAZ+s9Viwi/lryihcsuj7b610QX4SMONt/JvqSntDguBjrkVNOVrGOib+MT92SM
         PpYoo9h97GuTrS2KqMKSU7Ggq9YOLvVejihw9uVM2QdOZmVnYDPSX/aRhRaTHgtmMfvt
         Npfg==
X-Gm-Message-State: AOAM533Ax/j690DxB9QAFE76R6TKyuv3qkwLoSr7MwTMyGCBH7tx25my
        82yJfT56PsBAv11e6qSLNJV6cam0Wby2mxis
X-Google-Smtp-Source: ABdhPJwxYKxoTwYNU33P0wHi2qHo3lXQFLkf8EnVoILGqhKqBIXezvA5dQNUqiUhJOZTuNNXXW4itw==
X-Received: by 2002:aed:32c7:: with SMTP id z65mr7306390qtd.266.1604349456946;
        Mon, 02 Nov 2020 12:37:36 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n199sm9013517qkn.77.2020.11.02.12.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 12:37:36 -0800 (PST)
Subject: Re: [PATCH v9 15/41] btrfs: emulate write pointer for conventional
 zones
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <af1830174f9dd9e2651dab213c0b984d90811138.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a96ef4d1-b020-a467-bd26-863bc7117e64@toxicpanda.com>
Date:   Mon, 2 Nov 2020 15:37:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <af1830174f9dd9e2651dab213c0b984d90811138.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> Conventional zones do not have a write pointer, so we cannot use it to
> determine the allocation offset if a block group contains a conventional
> zone.
> 
> But instead, we can consider the end of the last allocated extent in the
> block group as an allocation offset.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/zoned.c | 119 ++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 113 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 0aa821893a51..8f58d0853cc3 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -740,6 +740,104 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
>   	return 0;
>   }
>   
> +static int emulate_write_pointer(struct btrfs_block_group *cache,
> +				 u64 *offset_ret)
> +{
> +	struct btrfs_fs_info *fs_info = cache->fs_info;
> +	struct btrfs_root *root = fs_info->extent_root;
> +	struct btrfs_path *path;
> +	struct extent_buffer *leaf;
> +	struct btrfs_key search_key;
> +	struct btrfs_key found_key;
> +	int slot;
> +	int ret;
> +	u64 length;
> +
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	search_key.objectid = cache->start + cache->length;
> +	search_key.type = 0;
> +	search_key.offset = 0;
> +

You can just use 'key', don't have to use 'search_key'.

Also you don't check for things like BTRFS_TREE_BLOCK_REF_KEY or whatever in the 
case that we don't have an inline extent ref, so this could error out with a fs 
with lots of snapshots and different references.  What you need is to search 
back until you hit an BTRFS_METADATA_ITEM_KEY or a BTRFS_EXTENT_ITEM_KEY, and 
then check the offset of that thing.  Otherwise this will screw up.  Thanks,

Josef
