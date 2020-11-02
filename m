Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E06D2A3366
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 19:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgKBSyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 13:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgKBSyS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:54:18 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7F4C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 10:54:18 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id r8so9903373qtp.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 10:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0qf/0pppkiqSMNBRb7wN9+1MMe/YWDNnrPbNfhwKg0Y=;
        b=i5FlBipJtwa9XEzp794j/1vXx1iqSrBIaeEyvzG2xLRu1mRu46tE1Qhs54jNZCNk3U
         O5wHTUMy5J8AmlkXEzer05sXwzdgzeqDzFb2+rAEvF4qeI7jBqXYWlYXWhl1ieAsbzxg
         iHAiHwAI5/hCCWG+YgLdVOqAOhanb165oxNdNfH8stOZv/4Av8HkWj+kTa/Mn413jwms
         FAKlzhRdN5BTmL4ZEcw6A2IDPWIO61Y9DBbdLQaYqqiyLGn6tSr0kEYrF8qbxQgK0u5z
         Pb+18ukmmFxlBdzC4WsU+a95RNwbkHmdIEfa73q/WfhboqS4tl4sEmpadirgfcb/MQlP
         TViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0qf/0pppkiqSMNBRb7wN9+1MMe/YWDNnrPbNfhwKg0Y=;
        b=a38bW6YlXot56AhFToyPZ3Fi0UDT6N+funQ3ePHr2UUHkQGmzV3kjz1sPvzplBihlu
         sOmRpO9x5vacAhwINuP6VfKz0FNZyeBduly3MbcUx33kWFZway491jG0SE3IbYlBHzyf
         wF57wzPE5mht2t53EN/NfAiMBM0jthZZgofDB6R+G4qXnn9xGfTs2TvWsTpwCRx6ruoh
         8Gs0Oumfr2599JvDP3cPzt7wCx0Qq7ftl92N9TiKZOXEf9vwISYozp3mkp+cIZLPu9wN
         NMyS1SLTNVxRETLz1TmwhP2n12rsG2CIdtoHyYPIePt0zEK4mo0Fr2g2HLRveO5aVwf/
         3Gag==
X-Gm-Message-State: AOAM531hcpOkmUI5Kz1f4fzUhpetdK2MTPHo7M5TJFQOyjiCq21XOG5D
        XJ/kJw3tPmyitTxFZ+mei458k3/ZSnkit0AM
X-Google-Smtp-Source: ABdhPJzPNVKv3AiQOfCAE4OkE8DMHtw6KIB8BfG94xlo/E93b7+eIXORokFIMg9pqRIBVUBCNCeUnw==
X-Received: by 2002:ac8:5215:: with SMTP id r21mr15890723qtn.291.1604343256572;
        Mon, 02 Nov 2020 10:54:16 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n201sm8676395qka.32.2020.11.02.10.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 10:54:15 -0800 (PST)
Subject: Re: [PATCH v9 11/41] btrfs: implement log-structured superblock for
 ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <eca26372a84d8b8ec2b59d3390f172810ed6f3e4.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b3447a50-0178-6779-060d-655d596d27a0@toxicpanda.com>
Date:   Mon, 2 Nov 2020 13:54:14 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <eca26372a84d8b8ec2b59d3390f172810ed6f3e4.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> Superblock (and its copies) is the only data structure in btrfs which has a
> fixed location on a device. Since we cannot overwrite in a sequential write
> required zone, we cannot place superblock in the zone. One easy solution is
> limiting superblock and copies to be placed only in conventional zones.
> However, this method has two downsides: one is reduced number of superblock
> copies. The location of the second copy of superblock is 256GB, which is in
> a sequential write required zone on typical devices in the market today.
> So, the number of superblock and copies is limited to be two.  Second
> downside is that we cannot support devices which have no conventional zones
> at all.
> 
> To solve these two problems, we employ superblock log writing. It uses two
> zones as a circular buffer to write updated superblocks. Once the first
> zone is filled up, start writing into the second buffer. Then, when the
> both zones are filled up and before start writing to the first zone again,
> it reset the first zone.
> 
> We can determine the position of the latest superblock by reading write
> pointer information from a device. One corner case is when the both zones
> are full. For this situation, we read out the last superblock of each
> zone, and compare them to determine which zone is older.
> 
> The following zones are reserved as the circular buffer on ZONED btrfs.
> 
> - The primary superblock: zones 0 and 1
> - The first copy: zones 16 and 17
> - The second copy: zones 1024 or zone at 256GB which is minimum, and next
>    to it
> 
> If these reserved zones are conventional, superblock is written fixed at
> the start of the zone without logging.
> 

<snip>

>   
>   /*
>    * This is only the first step towards a full-features scrub. It reads all
> @@ -3704,6 +3705,8 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>   		if (bytenr + BTRFS_SUPER_INFO_SIZE >
>   		    scrub_dev->commit_total_bytes)
>   			break;
> +		if (!btrfs_check_super_location(scrub_dev, bytenr))
> +			continue;

Any reason in particular we're skipping scrubbing supers here?  Can't we just 
lookup the bytenr and do the right thing here?

>   
>   		ret = scrub_pages(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, bytenr,
>   				  scrub_dev, BTRFS_EXTENT_FLAG_SUPER, gen, i,
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 10827892c086..db884b96a5ea 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1282,7 +1282,8 @@ void btrfs_release_disk_super(struct btrfs_super_block *super)
>   }
>   
>   static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
> -						       u64 bytenr)
> +						       u64 bytenr,
> +						       u64 bytenr_orig)
>   {
>   	struct btrfs_super_block *disk_super;
>   	struct page *page;
> @@ -1313,7 +1314,7 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
>   	/* align our pointer to the offset of the super block */
>   	disk_super = p + offset_in_page(bytenr);
>   
> -	if (btrfs_super_bytenr(disk_super) != bytenr ||
> +	if (btrfs_super_bytenr(disk_super) != bytenr_orig ||
>   	    btrfs_super_magic(disk_super) != BTRFS_MAGIC) {
>   		btrfs_release_disk_super(p);
>   		return ERR_PTR(-EINVAL);
> @@ -1348,7 +1349,8 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
>   	bool new_device_added = false;
>   	struct btrfs_device *device = NULL;
>   	struct block_device *bdev;
> -	u64 bytenr;
> +	u64 bytenr, bytenr_orig;
> +	int ret;
>   
>   	lockdep_assert_held(&uuid_mutex);
>   
> @@ -1358,14 +1360,18 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
>   	 * So, we need to add a special mount option to scan for
>   	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
>   	 */
> -	bytenr = btrfs_sb_offset(0);
>   	flags |= FMODE_EXCL;
>   
>   	bdev = blkdev_get_by_path(path, flags, holder);
>   	if (IS_ERR(bdev))
>   		return ERR_CAST(bdev);
>   
> -	disk_super = btrfs_read_disk_super(bdev, bytenr);
> +	bytenr_orig = btrfs_sb_offset(0);
> +	ret = btrfs_sb_log_location_bdev(bdev, 0, READ, &bytenr);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	disk_super = btrfs_read_disk_super(bdev, bytenr, bytenr_orig);
>   	if (IS_ERR(disk_super)) {
>   		device = ERR_CAST(disk_super);
>   		goto error_bdev_put;
> @@ -2029,6 +2035,11 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
>   		if (IS_ERR(disk_super))
>   			continue;
>   
> +		if (bdev_is_zoned(bdev)) {
> +			btrfs_reset_sb_log_zones(bdev, copy_num);
> +			continue;
> +		}
> +
>   		memset(&disk_super->magic, 0, sizeof(disk_super->magic));
>   
>   		page = virt_to_page(disk_super);
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index ae509699da14..d5487cba203b 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -20,6 +20,25 @@ static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx,
>   	return 0;
>   }
>   
> +static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zone,
> +			    u64 *wp_ret);
> +
> +static inline u32 sb_zone_number(u8 shift, int mirror)
> +{
> +	ASSERT(mirror < BTRFS_SUPER_MIRROR_MAX);
> +
> +	switch (mirror) {
> +	case 0:
> +		return 0;
> +	case 1:
> +		return 16;
> +	case 2:
> +		return min(btrfs_sb_offset(mirror) >> shift, 1024ULL);
> +	}
> +

Can we get a comment here explaining the zone numbers?

> +	return 0;
> +}
> +
>   static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
>   			       struct blk_zone *zones, unsigned int *nr_zones)
>   {
> @@ -123,6 +142,49 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
>   		goto out;
>   	}
>   
> +	/* validate superblock log */
> +	nr_zones = 2;
> +	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
> +		u32 sb_zone = sb_zone_number(zone_info->zone_size_shift, i);
> +		u64 sb_wp;
> +

I'd rather see

#define BTRFS_NR_ZONED_SB_ZONES 2

or something equally poorly named and use that instead of our magic 2 everywhere.

Then you can just do

int index = i * BTRFS_NR_ZONED_SB_ZONES;
&zone_info->sb_zones[index];

<snip>

> +static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
> +			   int rw, u64 *bytenr_ret)
> +{
> +	u64 wp;
> +	int ret;
> +
> +	if (zones[0].type == BLK_ZONE_TYPE_CONVENTIONAL) {
> +		*bytenr_ret = zones[0].start << SECTOR_SHIFT;
> +		return 0;
> +	}
> +
> +	ret = sb_write_pointer(bdev, zones, &wp);
> +	if (ret != -ENOENT && ret < 0)
> +		return ret;
> +
> +	if (rw == WRITE) {
> +		struct blk_zone *reset = NULL;
> +
> +		if (wp == zones[0].start << SECTOR_SHIFT)
> +			reset = &zones[0];
> +		else if (wp == zones[1].start << SECTOR_SHIFT)
> +			reset = &zones[1];
> +
> +		if (reset && reset->cond != BLK_ZONE_COND_EMPTY) {
> +			ASSERT(reset->cond == BLK_ZONE_COND_FULL);
> +
> +			ret = blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
> +					       reset->start, reset->len,
> +					       GFP_NOFS);

What happens if we crash right after this?  Is the WP set to the start of the 
zone here?  Does this mean we'll simply miss the super block?  I understand 
we're resetting one zone here, but we're doing this in order, so we'll reset one 
and write one, then reset the other and write the next.  We don't wait until 
we've issued the writes for everything, so it appears to me that there's a gap 
where we could have the WP pointed at the start of the zone, which we view as an 
invalid state and thus won't be able to mount the file system.  Or am I missing 
something?  Thanks,

Josef
