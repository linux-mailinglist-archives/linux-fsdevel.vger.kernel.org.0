Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1452A4853
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 15:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgKCOgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 09:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgKCOeX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:34:23 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E51FC0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 06:34:22 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id t5so3130604qtp.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 06:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=22aa1okkGGeNR5qHFFPrAKCxtCSUJVpZYiTdFVWRmVk=;
        b=IZoVo25vIlDA2mBXZjmD1SypY1c06z35brJjr+8/+Nc28tmVWIJ2OrhCQOzIeYU3ys
         pG+4cL2v2RfHPvtx0Zs/YW+0NX+XABT5u/EHsQCJyGMNJSUIQj08cwJA58DxKA//NiOt
         JfkgyKdXqWdmecM+/D0Jkn5+sXr7S8quNOXttUQ1yXj4lDBIlB5GcZ1Zhy8F0LP5xCvw
         5slIGVCKDZVNgEG8s/7U3AuTVe845/w6qXSLu6T+v+CApVcU5HtKx2OKtEhzSp2ZdclJ
         +Cz5iYwG+1N5WfIpCZObb1ePHdfxdDLkI4KTuBqbA/J37C134lBoDXB2wsxWCywWtOaL
         B8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=22aa1okkGGeNR5qHFFPrAKCxtCSUJVpZYiTdFVWRmVk=;
        b=mmXH2KP1wBDBzxhJ41gtn/sx90UKItQd79aObnYEnDczbq9OrV2CKNO/fiCfbYrEPl
         qoqzwS667rxAd1wT8EPCXLe8+DEZsFoUenL4wTY2eOJBj+qCxYU+b6cjza3eaMkGscDh
         wNg/qIOepcFarKE2238IAmbcQHwEiRZDl72DT3Ot86EBCASQY8VQmb2fro9OaYFTxW0U
         fNvwtC3BAGxmRCydeCBLP+/ZzoMIisjYFXwEZmic9WD12VfDXi3n6X1ykGc31ZuZqTz6
         cXh1ujhWBP8EH5hwtkuEERPecLwEV59wRRdmN9/6fT4yMywqNgN1vNAr2uxlYt9wE4vm
         Cvmw==
X-Gm-Message-State: AOAM533+FGwzIzY4YXzFzWn4u1kBqLEwARnUARPfmJAlguUcc2khPwXV
        axBOv6RrF/BQpwhL8Q0qbJgfPutbq8K4e14q
X-Google-Smtp-Source: ABdhPJyly1kr4qPGTwruPOvh9MX+jzOcPsSFq8O86KmQitSVrW/ZMQNVgRFAos/IjP/Hd3Zp7TmIDg==
X-Received: by 2002:ac8:7b82:: with SMTP id p2mr19833503qtu.48.1604414061158;
        Tue, 03 Nov 2020 06:34:21 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z16sm5776035qka.18.2020.11.03.06.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 06:34:20 -0800 (PST)
Subject: Re: [PATCH v9 18/41] btrfs: reset zones of unused block groups
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <575e495d534c44aded9e6ae042a9d6bda5c84162.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7b48d9f1-53d8-2526-e628-13331e4fe344@toxicpanda.com>
Date:   Tue, 3 Nov 2020 09:34:19 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <575e495d534c44aded9e6ae042a9d6bda5c84162.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> For an ZONED volume, a block group maps to a zone of the device. For
> deleted unused block groups, the zone of the block group can be reset to
> rewind the zone write pointer at the start of the zone.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/block-group.c |  8 ++++++--
>   fs/btrfs/extent-tree.c | 17 ++++++++++++-----
>   fs/btrfs/zoned.h       | 16 ++++++++++++++++
>   3 files changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index d67f9cabe5c1..82d556368c85 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1468,8 +1468,12 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>   		if (!async_trim_enabled && btrfs_test_opt(fs_info, DISCARD_ASYNC))
>   			goto flip_async;
>   
> -		/* DISCARD can flip during remount */
> -		trimming = btrfs_test_opt(fs_info, DISCARD_SYNC);
> +		/*
> +		 * DISCARD can flip during remount. In ZONED mode, we need
> +		 * to reset sequential required zones.
> +		 */
> +		trimming = btrfs_test_opt(fs_info, DISCARD_SYNC) ||
> +				btrfs_is_zoned(fs_info);
>   
>   		/* Implicit trim during transaction commit. */
>   		if (trimming)
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 5e6b4d1712f2..c134746d7417 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1331,6 +1331,9 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
>   
>   		stripe = bbio->stripes;
>   		for (i = 0; i < bbio->num_stripes; i++, stripe++) {
> +			struct btrfs_device *dev = stripe->dev;
> +			u64 physical = stripe->physical;
> +			u64 length = stripe->length;
>   			u64 bytes;
>   			struct request_queue *req_q;
>   
> @@ -1338,14 +1341,18 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
>   				ASSERT(btrfs_test_opt(fs_info, DEGRADED));
>   				continue;
>   			}
> +
>   			req_q = bdev_get_queue(stripe->dev->bdev);
> -			if (!blk_queue_discard(req_q))
> +			/* zone reset in ZONED mode */
> +			if (btrfs_can_zone_reset(dev, physical, length))
> +				ret = btrfs_reset_device_zone(dev, physical,
> +							      length, &bytes);
> +			else if (blk_queue_discard(req_q))
> +				ret = btrfs_issue_discard(dev->bdev, physical,
> +							  length, &bytes);
> +			else
>   				continue;
>   
> -			ret = btrfs_issue_discard(stripe->dev->bdev,
> -						  stripe->physical,
> -						  stripe->length,
> -						  &bytes);

The problem is you have

if (btrfs_test_opt(fs_info, DISCARD_SYNC))
	ret = btrfs_discard_extent(fs_info, start,
				   end + 1 - start, NULL);

in btrfs_finish_extent_commit, so even if you add support here, you aren't 
actually discarding anything because the transaction commit won't call discard 
for this range.

You're going to have to rework this logic to allow for discard to be called 
everywhere it checks DISCARD_SYNC, but then you also need to go and make sure 
you don't actually allow discards to happen at non-bg aligned ranges.  Thanks,

Josef
