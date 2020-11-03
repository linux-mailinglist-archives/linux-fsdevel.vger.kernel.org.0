Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6E32A4C97
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 18:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgKCRTq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 12:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgKCRTq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:19:46 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7621EC0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 09:19:45 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id p3so15398593qkk.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 09:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T0UXXXQ4ZITO2TabwNSEEJbuDfSbF2vJZ1fIs2r09k8=;
        b=s9U2qTTGf/OEcJerOIGW8U79RWnguCtqIvpwggCwvn0c4sP4iyPxsZqAnmhtPhKxUv
         sGSQUQcXhlrwy/KUTtR/QanYjFYFIpgJQHXZ5sz9BXTK8G+KSggEBvByPL4hal8UVthK
         TQ82VWiOTY3KHd4Kxzk08HZ6u16VwS84cBzDg7PSueB7LbSpc9AOm2s/2fD/5dlPK0sT
         OWNFbvqTTImXUEfJGVWD/8jJjeoD4eRlwRxF4qy4xFO2vm6ECuk+RXbp8ka+TW3RGxc6
         ZpC9sF2TqycTHjwR3NvvlDFRu7MX9iDlM3zqr8LnV/aU8nHbxhxVuHlOHBuVPRrVmJLp
         WwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T0UXXXQ4ZITO2TabwNSEEJbuDfSbF2vJZ1fIs2r09k8=;
        b=s0SONv5nZh3Z6faneCjlOOUAvbuRIfg44RtZx7fWtH+gE4CggaK/FfhJfhK/oxaAhL
         kJUNhzZ0g5HlSkt187mX/w5M3o3y/V0Z/ir6IJdACdxAHPjPxBguK9M7u8PW1i4okuwJ
         G0HnUj3VuobJSovlvDwp9G7Fzb7Tx1YcmkUKpdDtzbLFQt5DFD29veBonuL41lNv6PGt
         qi8AyLdnGb++gW8pERBUyTTexGU4ROXRivkz4tmdh/nPhPNLDcA/3ZMY9ZyMDY1BcUvl
         pFSKpADFx1S0rwdNdHMAXFTs+3v1RAZFEOHIsR+VHNAfKrn1YFHJOGA63wdTFxGFK5sH
         ptng==
X-Gm-Message-State: AOAM5339plc9P5+tC6N+895hwhpxyCJJlw52iDTn+lZjYayQfvHVEbD5
        Wb+LevlQ1lgTLR4PuB/EmzUQTUt4CA29gTtG
X-Google-Smtp-Source: ABdhPJyi/RQMk+dXa96JrIoPveYkcqaxCRrIv9qslbm6DjucWuY/NZrJQVB4pshTS0OUl3mv9cI67A==
X-Received: by 2002:a37:be83:: with SMTP id o125mr4780298qkf.2.1604423983110;
        Tue, 03 Nov 2020 09:19:43 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 69sm11017491qko.48.2020.11.03.09.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 09:19:42 -0800 (PST)
Subject: Re: [PATCH v9 33/41] btrfs: implement copying for ZONED
 device-replace
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <2370c99060300c9438ca1727215d398592f52434.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b15a7c94-97e3-e6b3-0f83-c02433992d47@toxicpanda.com>
Date:   Tue, 3 Nov 2020 12:19:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <2370c99060300c9438ca1727215d398592f52434.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> This is 3/4 patch to implement device-replace on ZONED mode.
> 
> This commit implement copying. So, it track the write pointer during device
> replace process. Device-replace's copying is smart to copy only used
> extents on source device, we have to fill the gap to honor the sequential
> write rule in the target device.
> 
> Device-replace process in ZONED mode must copy or clone all the extents in
> the source device exactly once.  So, we need to use to ensure allocations
> started just before the dev-replace process to have their corresponding
> extent information in the B-trees. finish_extent_writes_for_zoned()
> implements that functionality, which basically is the removed code in the
> commit 042528f8d840 ("Btrfs: fix block group remaining RO forever after
> error during device replace").
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/scrub.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/zoned.c | 12 +++++++
>   fs/btrfs/zoned.h |  7 ++++
>   3 files changed, 105 insertions(+)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 371bb6437cab..aaf7882dee06 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -169,6 +169,7 @@ struct scrub_ctx {
>   	int			pages_per_rd_bio;
>   
>   	int			is_dev_replace;
> +	u64			write_pointer;
>   
>   	struct scrub_bio        *wr_curr_bio;
>   	struct mutex            wr_lock;
> @@ -1623,6 +1624,25 @@ static int scrub_write_page_to_dev_replace(struct scrub_block *sblock,
>   	return scrub_add_page_to_wr_bio(sblock->sctx, spage);
>   }
>   
> +static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
> +{
> +	int ret = 0;
> +	u64 length;
> +
> +	if (!btrfs_is_zoned(sctx->fs_info))
> +		return 0;
> +
> +	if (sctx->write_pointer < physical) {
> +		length = physical - sctx->write_pointer;
> +
> +		ret = btrfs_zoned_issue_zeroout(sctx->wr_tgtdev,
> +						sctx->write_pointer, length);
> +		if (!ret)
> +			sctx->write_pointer = physical;
> +	}
> +	return ret;
> +}
> +
>   static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
>   				    struct scrub_page *spage)
>   {
> @@ -1645,6 +1665,13 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
>   	if (sbio->page_count == 0) {
>   		struct bio *bio;
>   
> +		ret = fill_writer_pointer_gap(sctx,
> +					      spage->physical_for_dev_replace);
> +		if (ret) {
> +			mutex_unlock(&sctx->wr_lock);
> +			return ret;
> +		}
> +
>   		sbio->physical = spage->physical_for_dev_replace;
>   		sbio->logical = spage->logical;
>   		sbio->dev = sctx->wr_tgtdev;
> @@ -1706,6 +1733,10 @@ static void scrub_wr_submit(struct scrub_ctx *sctx)
>   	 * doubled the write performance on spinning disks when measured
>   	 * with Linux 3.5 */
>   	btrfsic_submit_bio(sbio->bio);
> +
> +	if (btrfs_is_zoned(sctx->fs_info))
> +		sctx->write_pointer = sbio->physical +
> +			sbio->page_count * PAGE_SIZE;
>   }
>   
>   static void scrub_wr_bio_end_io(struct bio *bio)
> @@ -2973,6 +3004,21 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
>   	return ret < 0 ? ret : 0;
>   }
>   
> +static void sync_replace_for_zoned(struct scrub_ctx *sctx)
> +{
> +	if (!btrfs_is_zoned(sctx->fs_info))
> +		return;
> +
> +	sctx->flush_all_writes = true;
> +	scrub_submit(sctx);
> +	mutex_lock(&sctx->wr_lock);
> +	scrub_wr_submit(sctx);
> +	mutex_unlock(&sctx->wr_lock);
> +
> +	wait_event(sctx->list_wait,
> +		   atomic_read(&sctx->bios_in_flight) == 0);
> +}
> +
>   static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
>   					   struct map_lookup *map,
>   					   struct btrfs_device *scrub_dev,
> @@ -3105,6 +3151,14 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
>   	 */
>   	blk_start_plug(&plug);
>   
> +	if (sctx->is_dev_replace &&
> +	    btrfs_dev_is_sequential(sctx->wr_tgtdev, physical)) {
> +		mutex_lock(&sctx->wr_lock);
> +		sctx->write_pointer = physical;
> +		mutex_unlock(&sctx->wr_lock);
> +		sctx->flush_all_writes = true;
> +	}
> +
>   	/*
>   	 * now find all extents for each stripe and scrub them
>   	 */
> @@ -3292,6 +3346,9 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
>   			if (ret)
>   				goto out;
>   
> +			if (sctx->is_dev_replace)
> +				sync_replace_for_zoned(sctx);
> +
>   			if (extent_logical + extent_len <
>   			    key.objectid + bytes) {
>   				if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
> @@ -3414,6 +3471,25 @@ static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
>   	return ret;
>   }
>   
> +static int finish_extent_writes_for_zoned(struct btrfs_root *root,
> +					  struct btrfs_block_group *cache)
> +{
> +	struct btrfs_fs_info *fs_info = cache->fs_info;
> +	struct btrfs_trans_handle *trans;
> +
> +	if (!btrfs_is_zoned(fs_info))
> +		return 0;
> +
> +	btrfs_wait_block_group_reservations(cache);
> +	btrfs_wait_nocow_writers(cache);
> +	btrfs_wait_ordered_roots(fs_info, U64_MAX, cache->start, cache->length);
> +
> +	trans = btrfs_join_transaction(root);
> +	if (IS_ERR(trans))
> +		return PTR_ERR(trans);
> +	return btrfs_commit_transaction(trans);
> +}
> +
>   static noinline_for_stack
>   int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>   			   struct btrfs_device *scrub_dev, u64 start, u64 end)
> @@ -3569,6 +3645,16 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>   		 * group is not RO.
>   		 */
>   		ret = btrfs_inc_block_group_ro(cache, sctx->is_dev_replace);
> +		if (!ret && sctx->is_dev_replace) {
> +			ret = finish_extent_writes_for_zoned(root, cache);
> +			if (ret) {
> +				btrfs_dec_block_group_ro(cache);
> +				scrub_pause_off(fs_info);
> +				btrfs_put_block_group(cache);
> +				break;
> +			}
> +		}
> +
>   		if (ret == 0) {
>   			ro_set = 1;
>   		} else if (ret == -ENOSPC && !sctx->is_dev_replace) {
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index f672465d1bb1..1b080184440d 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1181,3 +1181,15 @@ void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
>   	ASSERT(cache->meta_write_pointer == eb->start + eb->len);
>   	cache->meta_write_pointer = eb->start;
>   }
> +
> +int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical,
> +			      u64 length)
> +{
> +	if (!btrfs_dev_is_sequential(device, physical))
> +		return -EOPNOTSUPP;
> +

This is going to result in a bunch of scrub errors.  Is this unlikely to happen? 
  And if it isn't, should we do something different?  If it's not sequential 
then we can probably just write to whatever offset we want right?  So do we need 
an error here at all?  Thanks,

Josef
