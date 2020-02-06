Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6F2615495A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 17:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgBFQiT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 11:38:19 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34458 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbgBFQiT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:38:19 -0500
Received: by mail-qk1-f193.google.com with SMTP id n184so1358826qkn.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2020 08:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JwbNSDXLFkV23H3mnDJ/2zWJ/rMSlb7SLMBnqprGayk=;
        b=qtfutCMGSQ3v7L/BuKdQ/R8xGtuMK/r7lbIhduTLvUeH/aiDtvrWVzUEr6HPrZ1IFa
         oAXqLpXH1PchmGGcS8tRyltbJF7EYB/hqXKYn6YHjkMoW1aRlE56wIPySEMLIxn3NR58
         DffSwWetNxRVhVSeGsOBOFsWp8iYEAhUzH8TI6QOF6WOv4no48vCDaGi9qlffrSE4Xuy
         C5lmFw32CPACt9eqQkawe/hMxmkStFed8cvrP4V9kLKgMH26/PzlJ4ZsptViKx4RI/Xm
         jqdro873zoMnyRtqIrxrHtXQlXmxAUqWEVc44Tv+rcdC+1h/xKQsscWwzeKJph419xHF
         czBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JwbNSDXLFkV23H3mnDJ/2zWJ/rMSlb7SLMBnqprGayk=;
        b=KwuKpQDrKz+jOHpWENNSHrCcDVbC9Us43qK28ILsVmj6RCB7FO0LQLEoM4Rw2muLT8
         tXD0WEw/RlJPh0zoQtFyM013vqHYsAOLBsDt4qadwhayjuTlD4jJZmQ/NAbYjrGGRUVM
         k+GIhDcVaeRdtmC3UGeQ5OmmnQkci+cek08Rp0+VxcmMRfwVf5uiuVc5HMJk7lndp2He
         S2NHcC6/qTYDJG9rHDLr+Knirx5uT1o8SUORW7h1s4bud0iR5SKw6OphQ0b0A+HLusrO
         b8f7Geikgt6WggOzDGx4C5DLXfoj4ESA8hKLT7+AW9vRWshy0D9TTiMyISha/fgaS2PV
         C0tQ==
X-Gm-Message-State: APjAAAXT86kMhla5O8hAG+CdY0mOY7gLharQduWaGX6p1yf+QDFChTFc
        wxjS1CUQwHFCcOGj3ltgA4KYHHnVMu4=
X-Google-Smtp-Source: APXvYqz07Z8rAqUoX2S4huJOtnIIlNrgHCJnPUCEiLFTgHXKB4tij98aSsiCm3/5+qitWt+/NJ6SdA==
X-Received: by 2002:a05:620a:1654:: with SMTP id c20mr3222237qko.116.1581007095950;
        Thu, 06 Feb 2020 08:38:15 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z11sm1605400qkj.91.2020.02.06.08.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 08:38:15 -0800 (PST)
Subject: Re: [PATCH 04/20] btrfs: introduce alloc_chunk_ctl
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-5-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <bcccefe4-8cff-d50d-ddd1-784e3d194607@toxicpanda.com>
Date:   Thu, 6 Feb 2020 11:38:14 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206104214.400857-5-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/6/20 5:41 AM, Naohiro Aota wrote:
> Introduce "struct alloc_chunk_ctl" to wrap needed parameters for the chunk
> allocation.  This will be used to split __btrfs_alloc_chunk() into smaller
> functions.
> 
> This commit folds a number of local variables in __btrfs_alloc_chunk() into
> one "struct alloc_chunk_ctl ctl". There is no functional change.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/volumes.c | 143 +++++++++++++++++++++++++--------------------
>   1 file changed, 81 insertions(+), 62 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 9bb673df777a..cfde302bf297 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4818,6 +4818,29 @@ static void check_raid1c34_incompat_flag(struct btrfs_fs_info *info, u64 type)
>   	btrfs_set_fs_incompat(info, RAID1C34);
>   }
>   
> +/*
> + * Structure used internally for __btrfs_alloc_chunk() function.
> + * Wraps needed parameters.
> + */
> +struct alloc_chunk_ctl {
> +	u64 start;
> +	u64 type;
> +	int num_stripes;	/* total number of stripes to allocate */
> +	int sub_stripes;	/* sub_stripes info for map */
> +	int dev_stripes;	/* stripes per dev */
> +	int devs_max;		/* max devs to use */
> +	int devs_min;		/* min devs needed */
> +	int devs_increment;	/* ndevs has to be a multiple of this */
> +	int ncopies;		/* how many copies to data has */
> +	int nparity;		/* number of stripes worth of bytes to
> +				   store parity information */
> +	u64 max_stripe_size;
> +	u64 max_chunk_size;
> +	u64 stripe_size;
> +	u64 chunk_size;
> +	int ndevs;
> +};
> +
>   static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>   			       u64 start, u64 type)
>   {
> @@ -4828,23 +4851,11 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>   	struct extent_map_tree *em_tree;
>   	struct extent_map *em;
>   	struct btrfs_device_info *devices_info = NULL;
> +	struct alloc_chunk_ctl ctl;
>   	u64 total_avail;
> -	int num_stripes;	/* total number of stripes to allocate */
>   	int data_stripes;	/* number of stripes that count for
>   				   block group size */
> -	int sub_stripes;	/* sub_stripes info for map */
> -	int dev_stripes;	/* stripes per dev */
> -	int devs_max;		/* max devs to use */
> -	int devs_min;		/* min devs needed */
> -	int devs_increment;	/* ndevs has to be a multiple of this */
> -	int ncopies;		/* how many copies to data has */
> -	int nparity;		/* number of stripes worth of bytes to
> -				   store parity information */
>   	int ret;
> -	u64 max_stripe_size;
> -	u64 max_chunk_size;
> -	u64 stripe_size;
> -	u64 chunk_size;
>   	int ndevs;
>   	int i;
>   	int j;
> @@ -4858,32 +4869,36 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>   		return -ENOSPC;
>   	}
>   
> +	ctl.start = start;
> +	ctl.type = type;
> +
>   	index = btrfs_bg_flags_to_raid_index(type);
>   
> -	sub_stripes = btrfs_raid_array[index].sub_stripes;
> -	dev_stripes = btrfs_raid_array[index].dev_stripes;
> -	devs_max = btrfs_raid_array[index].devs_max;
> -	if (!devs_max)
> -		devs_max = BTRFS_MAX_DEVS(info);
> -	devs_min = btrfs_raid_array[index].devs_min;
> -	devs_increment = btrfs_raid_array[index].devs_increment;
> -	ncopies = btrfs_raid_array[index].ncopies;
> -	nparity = btrfs_raid_array[index].nparity;
> +	ctl.sub_stripes = btrfs_raid_array[index].sub_stripes;
> +	ctl.dev_stripes = btrfs_raid_array[index].dev_stripes;
> +	ctl.devs_max = btrfs_raid_array[index].devs_max;
> +	if (!ctl.devs_max)
> +		ctl.devs_max = BTRFS_MAX_DEVS(info);
> +	ctl.devs_min = btrfs_raid_array[index].devs_min;
> +	ctl.devs_increment = btrfs_raid_array[index].devs_increment;
> +	ctl.ncopies = btrfs_raid_array[index].ncopies;
> +	ctl.nparity = btrfs_raid_array[index].nparity;
>   
>   	if (type & BTRFS_BLOCK_GROUP_DATA) {
> -		max_stripe_size = SZ_1G;
> -		max_chunk_size = BTRFS_MAX_DATA_CHUNK_SIZE;
> +		ctl.max_stripe_size = SZ_1G;
> +		ctl.max_chunk_size = BTRFS_MAX_DATA_CHUNK_SIZE;
>   	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
>   		/* for larger filesystems, use larger metadata chunks */
>   		if (fs_devices->total_rw_bytes > 50ULL * SZ_1G)
> -			max_stripe_size = SZ_1G;
> +			ctl.max_stripe_size = SZ_1G;
>   		else
> -			max_stripe_size = SZ_256M;
> -		max_chunk_size = max_stripe_size;
> +			ctl.max_stripe_size = SZ_256M;
> +		ctl.max_chunk_size = ctl.max_stripe_size;
>   	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
> -		max_stripe_size = SZ_32M;
> -		max_chunk_size = 2 * max_stripe_size;
> -		devs_max = min_t(int, devs_max, BTRFS_MAX_DEVS_SYS_CHUNK);
> +		ctl.max_stripe_size = SZ_32M;
> +		ctl.max_chunk_size = 2 * ctl.max_stripe_size;
> +		ctl.devs_max = min_t(int, ctl.devs_max,
> +				      BTRFS_MAX_DEVS_SYS_CHUNK);
>   	} else {
>   		btrfs_err(info, "invalid chunk type 0x%llx requested",
>   		       type);
> @@ -4891,8 +4906,8 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>   	}
>   
>   	/* We don't want a chunk larger than 10% of writable space */
> -	max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
> -			     max_chunk_size);
> +	ctl.max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
> +				  ctl.max_chunk_size);
>   
>   	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
>   			       GFP_NOFS);
> @@ -4929,20 +4944,20 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>   			continue;
>   
>   		ret = find_free_dev_extent(device,
> -					   max_stripe_size * dev_stripes,
> +				ctl.max_stripe_size * ctl.dev_stripes,
>   					   &dev_offset, &max_avail);

If you are going to adjust the indentation of arguments, you need to adjust them 
all.

>   		if (ret && ret != -ENOSPC)
>   			goto error;
>   
>   		if (ret == 0)
> -			max_avail = max_stripe_size * dev_stripes;
> +			max_avail = ctl.max_stripe_size * ctl.dev_stripes;
>   
> -		if (max_avail < BTRFS_STRIPE_LEN * dev_stripes) {
> +		if (max_avail < BTRFS_STRIPE_LEN * ctl.dev_stripes) {
>   			if (btrfs_test_opt(info, ENOSPC_DEBUG))
>   				btrfs_debug(info,
>   			"%s: devid %llu has no free space, have=%llu want=%u",
>   					    __func__, device->devid, max_avail,
> -					    BTRFS_STRIPE_LEN * dev_stripes);
> +				BTRFS_STRIPE_LEN * ctl.dev_stripes);

Same here.

>   			continue;
>   		}
>   
> @@ -4957,30 +4972,31 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>   		devices_info[ndevs].dev = device;
>   		++ndevs;
>   	}
> +	ctl.ndevs = ndevs;
>   
>   	/*
>   	 * now sort the devices by hole size / available space
>   	 */
> -	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
> +	sort(devices_info, ctl.ndevs, sizeof(struct btrfs_device_info),
>   	     btrfs_cmp_device_info, NULL);
>   
>   	/*
>   	 * Round down to number of usable stripes, devs_increment can be any
>   	 * number so we can't use round_down()
>   	 */
> -	ndevs -= ndevs % devs_increment;
> +	ctl.ndevs -= ctl.ndevs % ctl.devs_increment;
>   
> -	if (ndevs < devs_min) {
> +	if (ctl.ndevs < ctl.devs_min) {
>   		ret = -ENOSPC;
>   		if (btrfs_test_opt(info, ENOSPC_DEBUG)) {
>   			btrfs_debug(info,
>   	"%s: not enough devices with free space: have=%d minimum required=%d",
> -				    __func__, ndevs, devs_min);
> +				    __func__, ctl.ndevs, ctl.devs_min);
>   		}
>   		goto error;
>   	}
>   
> -	ndevs = min(ndevs, devs_max);
> +	ctl.ndevs = min(ctl.ndevs, ctl.devs_max);
>   
>   	/*
>   	 * The primary goal is to maximize the number of stripes, so use as
> @@ -4989,14 +5005,15 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>   	 * The DUP profile stores more than one stripe per device, the
>   	 * max_avail is the total size so we have to adjust.
>   	 */
> -	stripe_size = div_u64(devices_info[ndevs - 1].max_avail, dev_stripes);
> -	num_stripes = ndevs * dev_stripes;
> +	ctl.stripe_size = div_u64(devices_info[ctl.ndevs - 1].max_avail,
> +				   ctl.dev_stripes);
> +	ctl.num_stripes = ctl.ndevs * ctl.dev_stripes;
>   
>   	/*
>   	 * this will have to be fixed for RAID1 and RAID10 over
>   	 * more drives
>   	 */
> -	data_stripes = (num_stripes - nparity) / ncopies;
> +	data_stripes = (ctl.num_stripes - ctl.nparity) / ctl.ncopies;
>   
>   	/*
>   	 * Use the number of data stripes to figure out how big this chunk
> @@ -5004,44 +5021,44 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>   	 * and compare that answer with the max chunk size. If it's higher,
>   	 * we try to reduce stripe_size.
>   	 */
> -	if (stripe_size * data_stripes > max_chunk_size) {
> +	if (ctl.stripe_size * data_stripes > ctl.max_chunk_size) {
>   		/*
>   		 * Reduce stripe_size, round it up to a 16MB boundary again and
>   		 * then use it, unless it ends up being even bigger than the
>   		 * previous value we had already.
>   		 */
> -		stripe_size = min(round_up(div_u64(max_chunk_size,
> +		ctl.stripe_size = min(round_up(div_u64(ctl.max_chunk_size,
>   						   data_stripes), SZ_16M),
> -				  stripe_size);
> +				       ctl.stripe_size);

And here.  Thanks,

Josef
