Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E9A30071D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 16:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbhAVPYE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 10:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbhAVPWx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:22:53 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679A5C0613D6
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 07:22:13 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id e17so4337603qto.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 07:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BqhXopyE4rtPd5KrmZg6pH5XHRM2IdVRjQEZffnumWM=;
        b=xBg9h5h1NpzLDN7C3n1pLeOXONFkjo+6CjyfpieNjvdQWTOlMDf57lko3Wcg5OE0K7
         dBSt5237zMctB6QhjldJfqYH7inB51DOMclnA0Ttr6LqC3Gs79hebnkX6StBvGHzjqs1
         v5dF7tApO1wOrfmkyy4Slrq62sekTkHByXpVnm0vtoyu8TFx6qMObJxR46yXAgX6q2d9
         BZyJzG25kdqduUqP8GWIwvVcFgo7BDGQIzAZe+0jWD5YsYTEfq1rfM6CsHjpvxXekWJI
         FljR40KlY4B1n1u1Mv0WVoFruS/vhU13SPmfYU/KF2JVzYhK5VEtW7KsYz5ic2iPi5Rc
         ZeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BqhXopyE4rtPd5KrmZg6pH5XHRM2IdVRjQEZffnumWM=;
        b=rnh5qP7b2u8hGew6K6lFOXSnuELMfXvCTb0fNlZctxyd7oTUbjZqFHUKFNrKGTLtAX
         qjJ0H/cW/ruCV+8xKvG1JKfj2lCbwOWZir42g7B6hDgikmlFVq1oDydzyyEM+hIp5yUJ
         bUFomhFm1sGD/Bh51MRhh3jO9UvRXeGM1Au8gfRwvtbZZOfkZMZhdwkWJAztGl7A17bM
         q1pKdgnPvk0gjupCLtJHAfNKZKHeAupRYi4j7+ffMnVgWKzPPbztyh3mo9T3r0o4XV0y
         4dV0PbsCtLz2rBSZDfKfbL5RhuQ0Essp4fRtKDgCGya+aufxoqyImQG+pWjSdSQZCtdg
         dpgA==
X-Gm-Message-State: AOAM532FgsiZNwYmdgbjH/pHhWvOc2RQdAMtiqkGmUPCkbGkL2FUZCGZ
        2VatQRW2xNFz1a1gEAswPS1C/rQcTVa6C+bP
X-Google-Smtp-Source: ABdhPJxn8gimxcP92BtQu/c4EihPdHQW/NUJY5Oj0tSEnTCDDmGAMuaFmJaaRR21W3LZdz6dFL8NJg==
X-Received: by 2002:ac8:24ee:: with SMTP id t43mr4669999qtt.215.1611328932588;
        Fri, 22 Jan 2021 07:22:12 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o75sm417446qke.77.2021.01.22.07.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 07:22:11 -0800 (PST)
Subject: Re: [PATCH v13 22/42] btrfs: split ordered extent when bio is sent
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        kernel test robot <lkp@intel.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
 <25b86d9571b1af386f1711d0d0ae626ae6a86b35.1611295439.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e265540c-9613-9473-f7e6-0f55d455b18e@toxicpanda.com>
Date:   Fri, 22 Jan 2021 10:22:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <25b86d9571b1af386f1711d0d0ae626ae6a86b35.1611295439.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/22/21 1:21 AM, Naohiro Aota wrote:
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
>   fs/btrfs/inode.c        | 95 +++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/ordered-data.c | 85 ++++++++++++++++++++++++++++++++++++
>   fs/btrfs/ordered-data.h |  2 +
>   3 files changed, 182 insertions(+)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 2e1c1f37b3f6..ab97d4349515 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2217,6 +2217,92 @@ static blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
>   	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
>   }
>   
> +static blk_status_t extract_ordered_extent(struct btrfs_inode *inode,
> +					   struct bio *bio, loff_t file_offset)
> +{
> +	struct btrfs_ordered_extent *ordered;
> +	struct extent_map *em = NULL, *em_new = NULL;
> +	struct extent_map_tree *em_tree = &inode->extent_tree;
> +	u64 start = (u64)bio->bi_iter.bi_sector << SECTOR_SHIFT;
> +	u64 len = bio->bi_iter.bi_size;
> +	u64 end = start + len;
> +	u64 ordered_end;
> +	u64 pre, post;
> +	int ret = 0;
> +
> +	ordered = btrfs_lookup_ordered_extent(inode, file_offset);
> +	if (WARN_ON_ONCE(!ordered))
> +		return BLK_STS_IOERR;
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

How is this not a problem?  We can have any arbitrary waiter on an ordered 
extent at any given time?  Write to an area with memory pressure and then fsync 
immediately so we have to wait on an ordered extent that may need to be split, 
bam you get this warning and fail to write out.  This seems like a bad side effect.

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
> +	ret = btrfs_split_ordered_extent(ordered, pre, post);
> +	if (ret)
> +		goto out;
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
> +	em_new = create_io_em(inode, em->start + pre, len,
> +			      em->start + pre, em->block_start + pre, len,
> +			      len, len, BTRFS_COMPRESS_NONE,
> +			      BTRFS_ORDERED_REGULAR);

This bit confuses me, the io_em is just so we have a mapping to an area that's 
being written to, and this is created at ordered extent time.  I get why we need 
to split up the ordered extent, but the existing io_em should be fine, right? 
Thanks,

Josef
