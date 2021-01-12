Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669C72F34E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 17:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404136AbhALP7n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 10:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403785AbhALP7n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 10:59:43 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E80C061786
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 07:59:03 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id l14so1099148qvh.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 07:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KUcv6LzMppkGCODVRun0CKNx56RHfzLmoPbk/wo+uV4=;
        b=EhDQxRQ5Stp5bIYIl1OfIyUV8ArmhTwHWVDbtKwZizv43fIYz1YlPxN0T8hy7qhMe3
         +GUrLbLoJ24vuDrMdd3uA7NV6MQkMAGS5kSgwujpz5XyRGAOC1vJHWTTEko/4hetldfu
         HgUc/nchO4GHUZ5uyWpkTgK0QdCY6RcXvYk7NClh8n/hfSoSrG/Oc3ct1CAgWj5cd26U
         GAt9CFLupyBAs4o46zdBEWnrqeSwJ1OhDtZipCuc9zNVL5EGNjFwQAixkOrWiJCskgF7
         zlN4Ro2AHAoT9YTsdhZeyS/ms24UVqZULySwqXcaWHyrEMWDP+0fIzWhg9gZ9zlEBGm2
         Oh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KUcv6LzMppkGCODVRun0CKNx56RHfzLmoPbk/wo+uV4=;
        b=bRoxcuRY5z+ppMSzvGGDIWRbZRXoksMY+x04BzglJOGdMaRrFPqbNis57SFMXSCwWQ
         by/FhbWjF6tTKQ6e4XgKIA/LiUnXIdN8gq+i+rn+7u3Nhk/sPCdCY9u6sd65QDfUcgQH
         hs+/kkZp1ejEYW/ntNRtfFI5NKb1qIcghLmM/Va0IRlAiLyRTHvZKYBIs19UvcR1MpQr
         GTelrL/9/fETRd/MhyerBhn1Vl5jMN5V1CVTt8pjYiv9R1mo26F7pQ3nOkDx5ZPGJTUD
         6ZVDtiuHOONT/7FCJk9F1n7Gc/Eqih0XXbYFU80xFFPcEM17kY0x3gCDDVpWmQfN++DJ
         52jg==
X-Gm-Message-State: AOAM530LgwK2l5cXjj8V9cAt04O7EVPJ5eHK4I+MannxSHzm7H6rboqT
        UaTGXzH2RJcybcXTV57Sogu2Wg==
X-Google-Smtp-Source: ABdhPJxT8YjrOQcqVt8A2wTor3ybPidzwAISlppufLMNFJCFfqPT4qWjE5iBvNVS5wYvTxjM36Cr3w==
X-Received: by 2002:ad4:442a:: with SMTP id e10mr5231323qvt.12.1610467142356;
        Tue, 12 Jan 2021 07:59:02 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n5sm1480952qkh.126.2021.01.12.07.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 07:59:01 -0800 (PST)
Subject: Re: [PATCH v11 22/40] btrfs: split ordered extent when bio is sent
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        kernel test robot <lkp@intel.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <e2332c7ecb8e4b1a98a769db75ceac899ab1c3c0.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1b259084-ec86-d9c3-740b-9463f3d044af@toxicpanda.com>
Date:   Tue, 12 Jan 2021 10:59:00 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <e2332c7ecb8e4b1a98a769db75ceac899ab1c3c0.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/21/20 10:49 PM, Naohiro Aota wrote:
> For a zone append write, the device decides the location the data is
> written to. Therefore we cannot ensure that two bios are written
> consecutively on the device. In order to ensure that a ordered extent maps
> to a contiguous region on disk, we need to maintain a "one bio == one
> ordered extent" rule.
> 
> This commit implements the splitting of an ordered extent and extent map
> on bio submission to adhere to the rule.
> 
> [testbot] made extract_ordered_extent static
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/inode.c        | 89 +++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/ordered-data.c | 76 +++++++++++++++++++++++++++++++++++
>   fs/btrfs/ordered-data.h |  2 +
>   3 files changed, 167 insertions(+)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 37782b4cfd28..15e0c7714c7f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2217,6 +2217,86 @@ static blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
>   	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
>   }
>   
> +static int extract_ordered_extent(struct inode *inode, struct bio *bio,
> +				  loff_t file_offset)
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
> +	/* No need to split */
> +	if (ordered->disk_num_bytes == len)
> +		goto out;
> +
> +	/* We cannot split once end_bio'd ordered extent */
> +	if (WARN_ON_ONCE(ordered->bytes_left != ordered->disk_num_bytes)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* We cannot split a compressed ordered extent */
> +	if (WARN_ON_ONCE(ordered->disk_num_bytes != ordered->num_bytes)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* We cannot split a waited ordered extent */
> +	if (WARN_ON_ONCE(wq_has_sleeper(&ordered->wait))) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ordered_end = ordered->disk_bytenr + ordered->disk_num_bytes;
> +	/* bio must be in one ordered extent */
> +	if (WARN_ON_ONCE(start < ordered->disk_bytenr || end > ordered_end)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* Checksum list should be empty */
> +	if (WARN_ON_ONCE(!list_empty(&ordered->list))) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	pre = start - ordered->disk_bytenr;
> +	post = ordered_end - end;
> +
> +	btrfs_split_ordered_extent(ordered, pre, post);
> +
> +	read_lock(&em_tree->lock);
> +	em = lookup_extent_mapping(em_tree, ordered->file_offset, len);
> +	if (!em) {
> +		read_unlock(&em_tree->lock);
> +		ret = -EIO;
> +		goto out;
> +	}
> +	read_unlock(&em_tree->lock);
> +
> +	ASSERT(!test_bit(EXTENT_FLAG_COMPRESSED, &em->flags));
> +	em_new = create_io_em(BTRFS_I(inode), em->start + pre, len,
> +			      em->start + pre, em->block_start + pre, len,
> +			      len, len, BTRFS_COMPRESS_NONE,
> +			      BTRFS_ORDERED_REGULAR);
> +	free_extent_map(em_new);
> +
> +out:
> +	free_extent_map(em);
> +	btrfs_put_ordered_extent(ordered);
> +
> +	return ret;
> +}
> +
>   /*
>    * extent_io.c submission hook. This does the right thing for csum calculation
>    * on write, or reading the csums from the tree before a read.
> @@ -2252,6 +2332,15 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
>   	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
>   		metadata = BTRFS_WQ_ENDIO_FREE_SPACE;
>   
> +	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> +		struct page *page = bio_first_bvec_all(bio)->bv_page;
> +		loff_t file_offset = page_offset(page);
> +
> +		ret = extract_ordered_extent(inode, bio, file_offset);
> +		if (ret)
> +			goto out;
> +	}
> +
>   	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
>   		ret = btrfs_bio_wq_end_io(fs_info, bio, metadata);
>   		if (ret)
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 79d366a36223..4f8f48e7a482 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -898,6 +898,82 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
>   	}
>   }
>   
> +static void clone_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pos,
> +				 u64 len)
> +{
> +	struct inode *inode = ordered->inode;
> +	u64 file_offset = ordered->file_offset + pos;
> +	u64 disk_bytenr = ordered->disk_bytenr + pos;
> +	u64 num_bytes = len;
> +	u64 disk_num_bytes = len;
> +	int type;
> +	unsigned long flags_masked =
> +		ordered->flags & ~(1 << BTRFS_ORDERED_DIRECT);
> +	int compress_type = ordered->compress_type;
> +	unsigned long weight;
> +
> +	weight = hweight_long(flags_masked);
> +	WARN_ON_ONCE(weight > 1);
> +	if (!weight)
> +		type = 0;
> +	else
> +		type = __ffs(flags_masked);
> +
> +	if (test_bit(BTRFS_ORDERED_COMPRESSED, &ordered->flags)) {
> +		WARN_ON_ONCE(1);
> +		btrfs_add_ordered_extent_compress(BTRFS_I(inode), file_offset,
> +						  disk_bytenr, num_bytes,
> +						  disk_num_bytes, type,
> +						  compress_type);
> +	} else if (test_bit(BTRFS_ORDERED_DIRECT, &ordered->flags)) {
> +		btrfs_add_ordered_extent_dio(BTRFS_I(inode), file_offset,
> +					     disk_bytenr, num_bytes,
> +					     disk_num_bytes, type);
> +	} else {
> +		btrfs_add_ordered_extent(BTRFS_I(inode), file_offset,
> +					 disk_bytenr, num_bytes, disk_num_bytes,
> +					 type);
> +	}
> +}

You're completely ignoring errors here which isn't ok.  Thanks,

Josef
