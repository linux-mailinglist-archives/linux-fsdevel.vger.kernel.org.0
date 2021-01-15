Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DF52F8840
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 23:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbhAOWRP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 17:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbhAOWRO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:17:14 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E81C061757
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jan 2021 14:16:34 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id f26so13268191qka.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jan 2021 14:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4aN9oA1N7juzXfdXE+PXfSx6s2NsbKqM7ahAHcpgrzM=;
        b=SzfBZf0AC+PW7i5MWAvJTqrtPtGNxCS19lNr2MjhM+wL2sc2K5IcaEx4+O2UJE+U5f
         HbneO4LPScqDQ9lK+zpA4JaZyINu+yEpelAuChu4a55YdFSgXAVNueTdjITqtPDH1vim
         1GPPwKUSwJ07l73whOqHCcrEQRoi27sUhpZT9if6XbTjd4pJOFw3YviAP/jnOfQl1Hu7
         1pxL0zRlqsB/DwsXCvbJLuSGp1yxoqHQSNvX6UM653h8Cd+3DyJwaBUIByISV2258NBW
         84tpxotp1hPuoFG5sVvZGYd2s8glSAe9qKQpjLScbcak+mEW43U/sIQ9kfINImsP4+Gc
         2fdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4aN9oA1N7juzXfdXE+PXfSx6s2NsbKqM7ahAHcpgrzM=;
        b=h45n+vqXu60CProu1xHO72bvfThexzE0T9S0ZJxcgbc3h8ZiVAN1G5uNImG6DCv6JR
         YjlqOlNSX1wbUM/ArjZDjvQM1X7xDQLPPntOPws3jk2ie+yzAouidh0z2kNQie0F+lF5
         Tlf1P46xNhU00OFJDEXWnJyial0jK+IuNOby0hiYE7aJdSuQY7bvEW2drynJ8yElMm7a
         Yxmicm9LcO9d+zPHmiUM8LHxQiKvexJev2XKGTA004HVwG4TcnhZM+n8JUmTiUmndk90
         VMf/34/dPLwaq6Q4pcQzOuUptxWC0mMSUzCxOHq6ECbuQLq78q1Yt2q+qLSbdOAQ4mx5
         3Eqg==
X-Gm-Message-State: AOAM5308WkQZkypsDr1FW5rdlrEY0efHqfpmicBlvhY1Jvv2C0swL3EA
        vmrFYlzP4f5x4PdQjyKfGzGhpA==
X-Google-Smtp-Source: ABdhPJzS1C9/Yn7X7lgtmb2v7YgCiM/Xxlr51Yk9BwS+mLzYlxu2BPmI4HpVBeEJc6kT2Ueban/BcA==
X-Received: by 2002:a05:620a:81b:: with SMTP id s27mr14768315qks.385.1610748993822;
        Fri, 15 Jan 2021 14:16:33 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11e1::105d? ([2620:10d:c091:480::1:cc17])
        by smtp.gmail.com with ESMTPSA id 38sm3448382qtb.67.2021.01.15.14.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 14:16:33 -0800 (PST)
Subject: Re: [PATCH v12 20/41] btrfs: use bio_add_zone_append_page for zoned
 btrfs
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
 <9cb19c5a674bede549a357b676627083bf71345d.1610693037.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0c747633-0f43-63ac-86cf-943c24677cd1@toxicpanda.com>
Date:   Fri, 15 Jan 2021 17:16:31 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <9cb19c5a674bede549a357b676627083bf71345d.1610693037.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/15/21 1:53 AM, Naohiro Aota wrote:
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
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/extent_io.c | 30 +++++++++++++++++++++++++++---
>   1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 96f43b9121d6..41fccfbaee15 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3083,6 +3083,7 @@ static bool btrfs_bio_add_page(struct bio *bio, struct page *page, u64 logical,
>   {
>   	sector_t sector = logical >> SECTOR_SHIFT;
>   	bool contig;
> +	int ret;
>   
>   	if (prev_bio_flags != bio_flags)
>   		return false;
> @@ -3097,7 +3098,12 @@ static bool btrfs_bio_add_page(struct bio *bio, struct page *page, u64 logical,
>   	if (btrfs_bio_fits_in_stripe(page, size, bio, bio_flags))
>   		return false;
>   
> -	return bio_add_page(bio, page, size, pg_offset) == size;
> +	if (bio_op(bio) == REQ_OP_ZONE_APPEND)
> +		ret = bio_add_zone_append_page(bio, page, size, pg_offset);
> +	else
> +		ret = bio_add_page(bio, page, size, pg_offset);
> +
> +	return ret == size;
>   }
>   
>   /*
> @@ -3128,7 +3134,9 @@ static int submit_extent_page(unsigned int opf,
>   	int ret = 0;
>   	struct bio *bio;
>   	size_t io_size = min_t(size_t, size, PAGE_SIZE);
> -	struct extent_io_tree *tree = &BTRFS_I(page->mapping->host)->io_tree;
> +	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
> +	struct extent_io_tree *tree = &inode->io_tree;
> +	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>   
>   	ASSERT(bio_ret);
>   
> @@ -3159,11 +3167,27 @@ static int submit_extent_page(unsigned int opf,
>   	if (wbc) {
>   		struct block_device *bdev;
>   
> -		bdev = BTRFS_I(page->mapping->host)->root->fs_info->fs_devices->latest_bdev;
> +		bdev = fs_info->fs_devices->latest_bdev;
>   		bio_set_dev(bio, bdev);
>   		wbc_init_bio(wbc, bio);
>   		wbc_account_cgroup_owner(wbc, page, io_size);
>   	}
> +	if (btrfs_is_zoned(fs_info) &&
> +	    bio_op(bio) == REQ_OP_ZONE_APPEND) {
> +		struct extent_map *em;
> +		struct map_lookup *map;
> +
> +		em = btrfs_get_chunk_map(fs_info, offset, io_size);

Same goes for this, it fails to compile on misc-next.  Thanks,

Josef
