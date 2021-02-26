Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D275B326748
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 20:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhBZTOH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 14:14:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:41756 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhBZTOG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 14:14:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 89140AC6E;
        Fri, 26 Feb 2021 19:13:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 25D07DA7FF; Fri, 26 Feb 2021 20:11:30 +0100 (CET)
Date:   Fri, 26 Feb 2021 20:11:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: zoned: move superblock logging zone location
Message-ID: <20210226191130.GR7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
References: <cover.1614331998.git.naohiro.aota@wdc.com>
 <7d02b9117f15101e70d2cd37da05ca93c2fd624d.1614331998.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d02b9117f15101e70d2cd37da05ca93c2fd624d.1614331998.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 26, 2021 at 06:34:36PM +0900, Naohiro Aota wrote:
> This commit moves the location of superblock logging zones basing on the
> static address instead of the static zone number.
> 
> The following zones are reserved as the circular buffer on zoned btrfs.
>   - The primary superblock: zone at LBA 0 and the next zone
>   - The first copy: zone at LBA 16G and the next zone
>   - The second copy: zone at LBA 256G and the next zone

This contains all the important information but somehow feels too short
given how many mails we've exchanged and all the reasoning why we do
that

> 
> We disallow zone size larger than 8GB not to overlap the superblock log
> zones.
> 
> Since the superblock zones overlap, we disallow zone size larger than 8GB.

or why we chose 8G to be the reasonable upper limit for the zone size.

> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/zoned.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 9a5cf153da89..40cb99854844 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -112,10 +112,9 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
>  
>  /*
>   * The following zones are reserved as the circular buffer on ZONED btrfs.
> - *  - The primary superblock: zones 0 and 1
> - *  - The first copy: zones 16 and 17
> - *  - The second copy: zones 1024 or zone at 256GB which is minimum, and
> - *                     the following one
> + *  - The primary superblock: zone at LBA 0 and the next zone
> + *  - The first copy: zone at LBA 16G and the next zone
> + *  - The second copy: zone at LBA 256G and the next zone
>   */
>  static inline u32 sb_zone_number(int shift, int mirror)
>  {
> @@ -123,8 +122,8 @@ static inline u32 sb_zone_number(int shift, int mirror)
>  
>  	switch (mirror) {
>  	case 0: return 0;
> -	case 1: return 16;
> -	case 2: return min_t(u64, btrfs_sb_offset(mirror) >> shift, 1024);
> +	case 1: return 1 << (const_ilog2(SZ_16G) - shift);
> +	case 2: return 1 << (const_ilog2(SZ_1G) + 8 - shift);

This ilog(SZ_1G) + 8 is confusing, it should have been 256G for clarity,
as it's a constant it'll get expanded at compile time.

>  	}
>  
>  	return 0;
> @@ -300,6 +299,16 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
>  		zone_sectors = bdev_zone_sectors(bdev);
>  	}
>  
> +	/* We don't support zone size > 8G that SB log zones overlap. */
> +	if (zone_sectors > (SZ_8G >> SECTOR_SHIFT)) {
> +		btrfs_err_in_rcu(fs_info,
> +				 "zoned: %s: zone size %llu is too large",
> +				 rcu_str_deref(device->name),
> +				 (u64)zone_sectors << SECTOR_SHIFT);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
>  	nr_sectors = bdev_nr_sectors(bdev);
>  	/* Check if it's power of 2 (see is_power_of_2) */
>  	ASSERT(zone_sectors != 0 && (zone_sectors & (zone_sectors - 1)) == 0);
> -- 
> 2.30.1
