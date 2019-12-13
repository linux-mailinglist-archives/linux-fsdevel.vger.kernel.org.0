Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9213911E824
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 17:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfLMQYO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 11:24:14 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34674 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbfLMQYO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:24:14 -0500
Received: by mail-qv1-f67.google.com with SMTP id o18so1054253qvf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 08:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gwNrqcH2iXjjugqcdEhUnXeFcUQ5l3oSXvNYGYKfiuE=;
        b=vMYpBjRSWM101VNmixY/ioqV+d9m13Pa/5Sv8B1FTqCAzjOk4qJBKzcRm9uDOYeQnj
         8+0BbzhgI+uXoNOkhFsg4AGYSddvMPTsXLl0aND677v0PXGI2CepO13zklYltp+WvmUt
         Kf+WpFgHv8vgf3o67tCIVYWtn3ObYnFnf3CR3pnBy7EZEAsTC2ELHoO+qqs0RX97i++U
         SFH69Xlo/i9+kW8f5zeppFYD0eXuG3d+kLMAFbXvx1j2Q9UTDZaZxwbLyx9x+KA7bMjp
         nc7a6hITJB3LQ90keE3YMawnrE19nCFZBjqr64i5WuquEwYxUPHonVgwgQvtywM0pbkt
         eXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gwNrqcH2iXjjugqcdEhUnXeFcUQ5l3oSXvNYGYKfiuE=;
        b=UTIY8U9lOwFNLD3mEQwME3bnu8tOHTf0SCZCSB2GAkA/WeGwXrZrX58l+/9M+XxU8N
         x3sFCYs1DE1vF5rIJTS4n67zRC+UmDK+uA0Iva5OKQrBJX0ag48XiLUsfkVt9b5yUC7q
         peKMz6If3oR8MtISGn5rboQA6/TRp8ywNmkuW/Tz3Tf+tFALJNN96kk+ZHxR23SX6rx0
         e/p1Q3npk8RU/Y94MKb7AnzAUx9UC7IA/eNlzyP/WREzZD7OxS8uUV25pcm/xLE1xSSj
         B435V1GCvfbWLVFob+2AZgaEVcBO8hu7jt11i3LXYKUh3JVqLpiu9azVNnMsjra61gUr
         BFnQ==
X-Gm-Message-State: APjAAAX4UI4WOD1IDnQrhHZJoyAmu76B3HGFQyWNPKTLGZIYWl/iPkmL
        9iX0WN5vttJPfVdp7UJrHwjdDoVBTS7XtA==
X-Google-Smtp-Source: APXvYqxih23rM328l+bBlKuJXMmz33ytnc6swt7PCaLbY2VxwCn2qmi/oGUTX1lEb5Qs3I1HNZXxBg==
X-Received: by 2002:a0c:e8cd:: with SMTP id m13mr14447158qvo.102.1576254252396;
        Fri, 13 Dec 2019 08:24:12 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4e65])
        by smtp.gmail.com with ESMTPSA id 3sm3476096qte.59.2019.12.13.08.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 08:24:11 -0800 (PST)
Subject: Re: [PATCH v6 05/28] btrfs: disallow space_cache in HMZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-6-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <eac611c8-54d7-cd91-af86-1bc5b0944bde@toxicpanda.com>
Date:   Fri, 13 Dec 2019 11:24:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213040915.3502922-6-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 11:08 PM, Naohiro Aota wrote:
> As updates to the space cache v1 are in-place, the space cache cannot be
> located over sequential zones and there is no guarantees that the device
> will have enough conventional zones to store this cache. Resolve this
> problem by disabling completely the space cache v1.  This does not
> introduces any problems with sequential block groups: all the free space is
> located after the allocation pointer and no free space before the pointer.
> There is no need to have such cache.
> 
> Note: we can technically use free-space-tree (space cache v2) on HMZONED
> mode. But, since HMZONED mode now always allocate extents in a block group
> sequentially regardless of underlying device zone type, it's no use to
> enable and maintain the tree.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/hmzoned.c | 18 ++++++++++++++++++
>   fs/btrfs/hmzoned.h |  5 +++++
>   fs/btrfs/super.c   | 11 +++++++++--
>   3 files changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
> index 1b24facd46b8..d62f11652973 100644
> --- a/fs/btrfs/hmzoned.c
> +++ b/fs/btrfs/hmzoned.c
> @@ -250,3 +250,21 @@ int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
>   out:
>   	return ret;
>   }
> +
> +int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info)
> +{
> +	if (!btrfs_fs_incompat(info, HMZONED))
> +		return 0;
> +
> +	/*
> +	 * SPACE CACHE writing is not CoWed. Disable that to avoid write
> +	 * errors in sequential zones.
> +	 */
> +	if (btrfs_test_opt(info, SPACE_CACHE)) {
> +		btrfs_err(info,
> +			  "space cache v1 not supportted in HMZONED mode");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
> index 8e17f64ff986..d9ebe11afdf5 100644
> --- a/fs/btrfs/hmzoned.h
> +++ b/fs/btrfs/hmzoned.h
> @@ -29,6 +29,7 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>   int btrfs_get_dev_zone_info(struct btrfs_device *device);
>   void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
>   int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info);
> +int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info);
>   #else /* CONFIG_BLK_DEV_ZONED */
>   static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>   				     struct blk_zone *zone)
> @@ -48,6 +49,10 @@ static inline int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
>   	btrfs_err(fs_info, "Zoned block devices support is not enabled");
>   	return -EOPNOTSUPP;
>   }
> +static inline int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info)
> +{
> +	return 0;
> +}
>   #endif
>   
>   static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 616f5abec267..1424c3c6e3cf 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -442,8 +442,13 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>   	cache_gen = btrfs_super_cache_generation(info->super_copy);
>   	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
>   		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
> -	else if (cache_gen)
> -		btrfs_set_opt(info->mount_opt, SPACE_CACHE);
> +	else if (cache_gen) {
> +		if (btrfs_fs_incompat(info, HMZONED))
> +			btrfs_info(info,
> +			"ignoring existing space cache in HMZONED mode");

It would be good to clear the cache gen in this case.  I assume this can happen 
if we add a hmzoned device to an existing fs with space cache already?  I'd hate 
for weird corner cases to pop up if we removed it later and still had a valid 
cache gen in place.  Thanks,

Josef
