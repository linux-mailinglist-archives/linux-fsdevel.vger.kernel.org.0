Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2CF415C82E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 17:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgBMQZB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 11:25:01 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43925 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgBMQZB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:25:01 -0500
Received: by mail-qt1-f194.google.com with SMTP id d18so4796772qtj.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 08:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y8p88yV680pKaoaK46Qo7ZNh/nUaPETOlWizr2fUr3k=;
        b=gVGmQW8H9n/GbY+5jLQQAbEnMfnh1xTEREgHeFwOnxSkXzdg4yJ4WBw8TkHSenuigp
         9d3qo7k6nUxRLkJ/1giCnqPJHAG1GZQjufwcG06Zir7wQp99VrQECL5eN3ZN6UhQawj1
         K/mq49jTBtzUqg2cU777yeS3BAm1d7y1Ans/FEF/DKlCekgyg5D+i/g5q79twEP7luKw
         es7zq4GKYUv8EmgmYEiZoeoZuHSiipBEWlzo7eKpFj6yvGbHB5vEUdXoPHYzYZH4tH3h
         9B8cpFQa42R0Rt8kdUh9Jt+BmYpci+j5UzbW4IY8hXR8tBIUb/nr8x/zfyPQCd1/xrSi
         Zk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y8p88yV680pKaoaK46Qo7ZNh/nUaPETOlWizr2fUr3k=;
        b=fDZbAtlS+kmC7+gnM3jtMhrJ4MNEQEGWlSZoMiclg5CLTdISB+dTKvt6cxyypNP0+8
         Banz4ORDo9OCAvA+9uM1aapUT6k+SSZnNajtp4hU0ZplBAHcpuiyJKO4qlS1GU/ZKBOP
         5pRHDP5apDpXxuLVHhFT7Z3H2Qf1egV0mdhQ7tS8RiORDH2M7rP+Qo4I8eWKO6aK5QCv
         viwkxituka/uQehi/x87g32aDsS+6BZKAKRHUQsLOpc4aTzlV9zdAOl8bHW8ZgSii23I
         0jNuLuE+aWeEoornzqlQp+1ZJFS9wN3i4DoI3q0hOoVW+65E2CIv81kGdw3Sp5DGklaF
         ThHQ==
X-Gm-Message-State: APjAAAVe7HGl4VrH48DJsZGiMk6RVsrY3/xZErMoH3lwKLhyW3+6ljYa
        KSFx1zO/XQjadxJnjbJUbe9GpSrA7Rg=
X-Google-Smtp-Source: APXvYqy5XqLQV5mvRT8J7Uyodfdgqbecv4Go6aHqAkOzuiAGEn3bgEl6yIBa77hHxW1sq6BndZgHEw==
X-Received: by 2002:ac8:7352:: with SMTP id q18mr12225355qtp.125.1581611099087;
        Thu, 13 Feb 2020 08:24:59 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::edcc])
        by smtp.gmail.com with ESMTPSA id p13sm1511619qke.131.2020.02.13.08.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 08:24:58 -0800 (PST)
Subject: Re: [PATCH v2 09/21] btrfs: factor out create_chunk()
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-10-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7514070d-b7a8-be1c-c23a-f01b9ee3c7ce@toxicpanda.com>
Date:   Thu, 13 Feb 2020 11:24:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212072048.629856-10-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/12/20 2:20 AM, Naohiro Aota wrote:
> Factor out create_chunk() from __btrfs_alloc_chunk(). This function finally
> creates a chunk. There is no functional changes.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/volumes.c | 130 ++++++++++++++++++++++++---------------------
>   1 file changed, 70 insertions(+), 60 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 00085943e4dd..3e2e3896d72a 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5052,90 +5052,53 @@ static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
>   	}
>   }
>   
> -static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
> -			       u64 start, u64 type)
> +static int create_chunk(struct btrfs_trans_handle *trans,
> +			struct alloc_chunk_ctl *ctl,
> +			struct btrfs_device_info *devices_info)
>   {
>   	struct btrfs_fs_info *info = trans->fs_info;
> -	struct btrfs_fs_devices *fs_devices = info->fs_devices;
>   	struct map_lookup *map = NULL;
>   	struct extent_map_tree *em_tree;
>   	struct extent_map *em;
> -	struct btrfs_device_info *devices_info = NULL;
> -	struct alloc_chunk_ctl ctl;
> +	u64 start = ctl->start;
> +	u64 type = ctl->type;
>   	int ret;
>   	int i;
>   	int j;
>   
> -	if (!alloc_profile_is_valid(type, 0)) {
> -		ASSERT(0);
> -		return -EINVAL;
> -	}
> -
> -	if (list_empty(&fs_devices->alloc_list)) {
> -		if (btrfs_test_opt(info, ENOSPC_DEBUG))
> -			btrfs_debug(info, "%s: no writable device", __func__);
> -		return -ENOSPC;
> -	}
> -
> -	if (!(type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
> -		btrfs_err(info, "invalid chunk type 0x%llx requested", type);
> -		BUG();
> -	}
> -
> -	ctl.start = start;
> -	ctl.type = type;
> -	init_alloc_chunk_ctl(fs_devices, &ctl);
> -
> -	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
> -			       GFP_NOFS);
> -	if (!devices_info)
> +	map = kmalloc(map_lookup_size(ctl->num_stripes), GFP_NOFS);
> +	if (!map)
>   		return -ENOMEM;
> +	map->num_stripes = ctl->num_stripes;
>   
> -	ret = gather_device_info(fs_devices, &ctl, devices_info);
> -	if (ret < 0)
> -		goto error;
> -
> -	ret = decide_stripe_size(fs_devices, &ctl, devices_info);
> -	if (ret < 0)
> -		goto error;
> -
> -	map = kmalloc(map_lookup_size(ctl.num_stripes), GFP_NOFS);
> -	if (!map) {
> -		ret = -ENOMEM;
> -		goto error;
> -	}
> -
> -	map->num_stripes = ctl.num_stripes;
> -
> -	for (i = 0; i < ctl.ndevs; ++i) {
> -		for (j = 0; j < ctl.dev_stripes; ++j) {
> -			int s = i * ctl.dev_stripes + j;
> +	for (i = 0; i < ctl->ndevs; ++i) {
> +		for (j = 0; j < ctl->dev_stripes; ++j) {
> +			int s = i * ctl->dev_stripes + j;
>   			map->stripes[s].dev = devices_info[i].dev;
>   			map->stripes[s].physical = devices_info[i].dev_offset +
> -						   j * ctl.stripe_size;
> +						   j * ctl->stripe_size;
>   		}
>   	}
>   	map->stripe_len = BTRFS_STRIPE_LEN;
>   	map->io_align = BTRFS_STRIPE_LEN;
>   	map->io_width = BTRFS_STRIPE_LEN;
>   	map->type = type;
> -	map->sub_stripes = ctl.sub_stripes;
> +	map->sub_stripes = ctl->sub_stripes;
>   
> -	trace_btrfs_chunk_alloc(info, map, start, ctl.chunk_size);
> +	trace_btrfs_chunk_alloc(info, map, start, ctl->chunk_size);
>   
>   	em = alloc_extent_map();
>   	if (!em) {
>   		kfree(map);
> -		ret = -ENOMEM;
> -		goto error;
> +		return -ENOMEM;
>   	}
>   	set_bit(EXTENT_FLAG_FS_MAPPING, &em->flags);
>   	em->map_lookup = map;
>   	em->start = start;
> -	em->len = ctl.chunk_size;
> +	em->len = ctl->chunk_size;
>   	em->block_start = 0;
>   	em->block_len = em->len;
> -	em->orig_block_len = ctl.stripe_size;
> +	em->orig_block_len = ctl->stripe_size;
>   
>   	em_tree = &info->mapping_tree;
>   	write_lock(&em_tree->lock);
> @@ -5143,11 +5106,11 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>   	if (ret) {
>   		write_unlock(&em_tree->lock);
>   		free_extent_map(em);
> -		goto error;
> +		return ret;
>   	}
>   	write_unlock(&em_tree->lock);
>   
> -	ret = btrfs_make_block_group(trans, 0, type, start, ctl.chunk_size);
> +	ret = btrfs_make_block_group(trans, 0, type, start, ctl->chunk_size);
>   	if (ret)
>   		goto error_del_extent;
>   
> @@ -5155,20 +5118,19 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>   		struct btrfs_device *dev = map->stripes[i].dev;
>   
>   		btrfs_device_set_bytes_used(dev,
> -					    dev->bytes_used + ctl.stripe_size);
> +					    dev->bytes_used + ctl->stripe_size);
>   		if (list_empty(&dev->post_commit_list))
>   			list_add_tail(&dev->post_commit_list,
>   				      &trans->transaction->dev_update_list);
>   	}
>   
> -	atomic64_sub(ctl.stripe_size * map->num_stripes,
> +	atomic64_sub(ctl->stripe_size * map->num_stripes,
>   		     &info->free_chunk_space);
>   
>   	free_extent_map(em);
>   	check_raid56_incompat_flag(info, type);
>   	check_raid1c34_incompat_flag(info, type);
>   
> -	kfree(devices_info);
>   	return 0;
>   
>   error_del_extent:
> @@ -5180,7 +5142,55 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>   	free_extent_map(em);
>   	/* One for the tree reference */
>   	free_extent_map(em);
> -error:
> +
> +	return ret;
> +}
> +
> +static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
> +			       u64 start, u64 type)
> +{
> +	struct btrfs_fs_info *info = trans->fs_info;
> +	struct btrfs_fs_devices *fs_devices = info->fs_devices;
> +	struct btrfs_device_info *devices_info = NULL;
> +	struct alloc_chunk_ctl ctl;
> +	int ret;
> +
> +	if (!alloc_profile_is_valid(type, 0)) {
> +		ASSERT(0);
> +		return -EINVAL;
> +	}
> +
> +	if (list_empty(&fs_devices->alloc_list)) {
> +		if (btrfs_test_opt(info, ENOSPC_DEBUG))
> +			btrfs_debug(info, "%s: no writable device", __func__);
> +		return -ENOSPC;
> +	}
> +
> +	if (!(type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
> +		btrfs_err(info, "invalid chunk type 0x%llx requested", type);
> +		BUG();
> +	}

This is superfluous, alloc_profile_is_valid() handles this check.  Thanks,

Josef
