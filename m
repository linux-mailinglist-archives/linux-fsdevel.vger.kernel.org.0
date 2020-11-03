Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AB42A48BF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 15:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgKCO41 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 09:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbgKCOzw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:55:52 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539BDC0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 06:55:52 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id r7so14886228qkf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 06:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8VPRX7j7phOFHA/HGSPnfhf8wZ3YY5gqt01OiEVW1GA=;
        b=jDQUxxXrnXwWUXV3zxriJ0Ymv/r2J+gqeMcPf46pOBSxTATI7cs7BAOjGhSqigKfnh
         JodhK13sjp2X5xp3J9PjRrOIe1Yuunkg9wytJllRLNErmY8CkVSX40SAKo92SopgFHGb
         S8fWSQiQH7AvkV+tXZkOVOTvZRAPjxiWPhZero9JP8KbHd/cAOBT7JArd3Ux5iD3ppKn
         QfJqhE+GUawRk19E87HunQLPcBDNiAeXi9sN4OqXdYMYNqr0Qa91iKIlrwLlv85neiT9
         BfpNky0v0+nfWf9m/FmBe/T8UwuwyThtDtZZp81nRsswqYVtw4AwmwFvhgyiiYHZNZVh
         YlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8VPRX7j7phOFHA/HGSPnfhf8wZ3YY5gqt01OiEVW1GA=;
        b=aWPBuk5AMFy20qGHFDAXxeChkpXrZuWBq3LTdUNVBV3Fyny5jvR5aa7sS433pl4Olo
         QrxKHtCLyjRHIeFugTAyksvDuFog2yhEQt8IZ8ZYGkfN+QrSw68Lti941axx7wSXRk21
         V5X0+oyf2ZzdqlWtp6pBWZunoYqgLlrSZmyIEEUkZYEgbVr3NhUjM/RQrl2D4F+qS5FC
         lGoGquqWlwrkoDPdN76baXlC3PPiZ9E1za7fwiR1dw73JB8cUomHFumSBZkBpuGD4h9t
         wLTsE1ej80gwdcTLg+VvWoNHHgnVHWJUzwG7mFKvGREG9P9V+qsO1mHBjR2EvV76m+GB
         U7Iw==
X-Gm-Message-State: AOAM532ED75DbprYkdVA6XnKHHEJnMWur+ZhPrMq++UV7bDtwYDHxaW1
        dgdzmFGR6oR/vokwopWjjlthF8zq0j6JXJmX
X-Google-Smtp-Source: ABdhPJw1xRJzmSgYNMFYTp9TNZ1bu95oZJjxUhxz/bPThaDRYMZptVwhtkBRzlcFeruwj7HptOsUrg==
X-Received: by 2002:a05:620a:697:: with SMTP id f23mr18718130qkh.374.1604415351117;
        Tue, 03 Nov 2020 06:55:51 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o63sm5783972qkd.96.2020.11.03.06.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 06:55:50 -0800 (PST)
Subject: Re: [PATCH v9 21/41] btrfs: use bio_add_zone_append_page for zoned
 btrfs
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <ad4c16f2fff58ea4c6bd034e782b1c354521d696.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0883ec98-4b59-5e74-ba81-d477ca4e185f@toxicpanda.com>
Date:   Tue, 3 Nov 2020 09:55:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <ad4c16f2fff58ea4c6bd034e782b1c354521d696.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> Zoned device has its own hardware restrictions e.g. max_zone_append_size
> when using REQ_OP_ZONE_APPEND. To follow the restrictions, use
> bio_add_zone_append_page() instead of bio_add_page(). We need target device
> to use bio_add_zone_append_page(), so this commit reads the chunk
> information to memoize the target device to btrfs_io_bio(bio)->device.
> 
> Currently, zoned btrfs only supports SINGLE profile. In the feature,
> btrfs_io_bio can hold extent_map and check the restrictions for all the
> devices the bio will be mapped.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/extent_io.c | 37 ++++++++++++++++++++++++++++++++++---
>   1 file changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 17285048fb5a..764257eb658f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3032,6 +3032,7 @@ bool btrfs_bio_add_page(struct bio *bio, struct page *page, u64 logical,
>   {
>   	sector_t sector = logical >> SECTOR_SHIFT;
>   	bool contig;
> +	int ret;
>   
>   	if (prev_bio_flags != bio_flags)
>   		return false;
> @@ -3046,7 +3047,19 @@ bool btrfs_bio_add_page(struct bio *bio, struct page *page, u64 logical,
>   	if (btrfs_bio_fits_in_stripe(page, size, bio, bio_flags))
>   		return false;
>   
> -	return bio_add_page(bio, page, size, pg_offset) == size;
> +	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> +		struct bio orig_bio;
> +
> +		memset(&orig_bio, 0, sizeof(orig_bio));
> +		bio_copy_dev(&orig_bio, bio);
> +		bio_set_dev(bio, btrfs_io_bio(bio)->device->bdev);
> +		ret = bio_add_zone_append_page(bio, page, size, pg_offset);
> +		bio_copy_dev(bio, &orig_bio);

Why do we need this in the first place, since we're only supporting single right 
now?  latest_bdev should be the same, so this serves no purpose, right?

And if it does, we need to figure out another solution, because right now this 
leaks references to the bio->bi_blkg, each copy inc's the refcount on the blkg 
for that bio so we're going to leak blkg's like crazy here.  Thanks,

Josef
