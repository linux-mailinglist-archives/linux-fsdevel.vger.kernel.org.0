Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E102A49B2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 16:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgKCPaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 10:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbgKCP35 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:29:57 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282DFC061A04
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 07:29:54 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id 12so11079304qkl.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 07:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rDy+4hiGDxtdOSRTNU5o17IXr2TBxPd1FRxO1D+8IuU=;
        b=X1vSy/tY1leHmnR6JJ3E0t3XezmXNznfMNUqZICWe90nnAcauuaOBbwbDiV7y9M0eh
         x2BmsVS70rSOnCRhk9IUrj1rZDHoY1rDNVdsIXNRWEmoCIAlIgD7pj9DfSYQ7nSBci83
         tv4Vg2gwCyE5Mlp5Uof2TJtlpgBDNEauLE3Ds+5+bJybxGVHvFfy75h4ueTqjGxMKOzY
         TQWB3Z9234XgjTYQn0k63Oz+NpS4ZPb5cgddkSnOdSZ1R5FJfpSgAKeUV9JpqIepDoAZ
         fUCsK9e1xHCGxAZQfR3J3Gn86PN35QgJY9P12hdMSflOt1md885NzcSR05hrtIQbzanN
         byKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rDy+4hiGDxtdOSRTNU5o17IXr2TBxPd1FRxO1D+8IuU=;
        b=WycqAH4mS3RqpJkRTgO+dOeMTcJou0DRfBiwmz5OJjEd1T+y4FMN36IxfFlawW8yfl
         vPXR0E043tFqdzfdsdrFM7IijWypAh9mazvx7EwJgZ/Vvwp59d3QFxwQ8TzzjFemFgC0
         gCLHpaQyZtLikKhZmaC6wLe8XpPTbra6qNCYU/wi/30THBKhToG/hcPtl8dlLQ5Tl2rl
         JZ9wXLAkodq4CvLdw0SYVxDiwuHHKsOONu9JjdEJ9g/yeLmIdIUoolBloHudWaxJekOT
         pxy8yLKSs4bTmKUCisbiRkczpCbdEkI5m6Qh8IjBmFcCkU2J6OWzPoeZzuQm5drr57lC
         +7AQ==
X-Gm-Message-State: AOAM5334T2IZ9iQdrlfYuNGm0Q2QuKNwVCV662ZGOHhIIGJbpN5FJ937
        ObJTSYUZKJ0L1K1rBe2RcyYkaZk4necVhZJ5
X-Google-Smtp-Source: ABdhPJzWYYFc7hlhngWETqYzUXx5dOJ/uoWuu20Y+bYhAmpirN17KgEaWBM+tM3wU6gCHzotEjK3pw==
X-Received: by 2002:ae9:ebca:: with SMTP id b193mr8120713qkg.235.1604417393547;
        Tue, 03 Nov 2020 07:29:53 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i20sm10377335qtw.66.2020.11.03.07.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 07:29:52 -0800 (PST)
Subject: Re: [PATCH v9 23/41] btrfs: split ordered extent when bio is sent
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <003ea43d3ee954cdb95efa0638a3fdc289cb34c0.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ca7b858d-0acf-2f2c-a8d2-f18f5d03cfab@toxicpanda.com>
Date:   Tue, 3 Nov 2020 10:29:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <003ea43d3ee954cdb95efa0638a3fdc289cb34c0.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> For a zone append write, the device decides the location the data is
> written to. Therefore we cannot ensure that two bios are written
> consecutively on the device. In order to ensure that a ordered extent maps
> to a contiguous region on disk, we need to maintain a "one bio == one
> ordered extent" rule.
> 
> This commit implements the splitting of an ordered extent and extent map
> on bio submission to adhere to the rule.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/inode.c        | 89 +++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/ordered-data.c | 76 +++++++++++++++++++++++++++++++++++
>   fs/btrfs/ordered-data.h |  2 +
>   3 files changed, 167 insertions(+)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 591ca539e444..6b2569dfc3bd 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2158,6 +2158,86 @@ static blk_status_t btrfs_submit_bio_start(void *private_data, struct bio *bio,
>   	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
>   }
>   
> +int extract_ordered_extent(struct inode *inode, struct bio *bio,
> +			   loff_t file_offset)
> +{
> +	struct btrfs_ordered_extent *ordered;
> +	struct extent_map *em = NULL, *em_new = NULL;
> +	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
> +	u64 start = (u64)bio->bi_iter.bi_sector << SECTOR_SHIFT;
> +	u64 len = bio->bi_iter.bi_size;
> +	u64 end = start + len;
> +	u64 ordered_end;
> +	u64 pre, post;
> +	int ret = 0;
> +
> +	ordered = btrfs_lookup_ordered_extent(BTRFS_I(inode), file_offset);
> +	if (WARN_ON_ONCE(!ordered))
> +		return -EIO;
> +
> +	/* no need to split */
> +	if (ordered->disk_num_bytes == len)
> +		goto out;
> +
> +	/* cannot split once end_bio'd ordered extent */
> +	if (WARN_ON_ONCE(ordered->bytes_left != ordered->disk_num_bytes)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* we cannot split compressed ordered extent */
> +	if (WARN_ON_ONCE(ordered->disk_num_bytes != ordered->num_bytes)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* cannot split waietd ordered extent */
> +	if (WARN_ON_ONCE(wq_has_sleeper(&ordered->wait))) {
> +		ret = -EINVAL;
> +		goto out;
> +	}

This is bad, we could choose any moment to wait on an ordered extent, and then 
this will break.

In fact I'm not a fan of any of this code.  I assume we only know at 
bio_add_zone_append_page time how much we'll be able to shove into a bio?  Then 
I think the best/cleanest approach here is going to be to add something like 
what compressed does, an entire alternate way to allocate and submit extents.

It would look something like

->lock pages
->reserve space

loop until all pages are submitted
	->build bio
	->add ordered extent for the bio

->unlock pages

Then the ordered extents are their correct size and you don't have to worry 
about arbitrary waiters on ordered extents screwing things up, and you don't 
have to split ordered extents after the fact.  Thanks,

Josef
