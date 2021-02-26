Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AA532675F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 20:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhBZTVg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 14:21:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:44592 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhBZTVd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 14:21:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E12C0AAAE;
        Fri, 26 Feb 2021 19:20:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7CF66DA7FF; Fri, 26 Feb 2021 20:18:58 +0100 (CET)
Date:   Fri, 26 Feb 2021 20:18:58 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: zoned: add missing type conversion
Message-ID: <20210226191858.GS7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
References: <cover.1614331998.git.naohiro.aota@wdc.com>
 <e6519c3681550015fbeeb0565f707d72705a39f1.1614331998.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6519c3681550015fbeeb0565f707d72705a39f1.1614331998.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 26, 2021 at 06:34:37PM +0900, Naohiro Aota wrote:
> We need to cast zone_sectors from u32 to u64 when setting the zone_size, or
> it set the zone size = 0 when the size >= 4G.
> 
> Fixes: 5b316468983d ("btrfs: get zone information of zoned block devices")
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/zoned.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 40cb99854844..4de82da39c10 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -312,7 +312,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
>  	nr_sectors = bdev_nr_sectors(bdev);
>  	/* Check if it's power of 2 (see is_power_of_2) */
>  	ASSERT(zone_sectors != 0 && (zone_sectors & (zone_sectors - 1)) == 0);
> -	zone_info->zone_size = zone_sectors << SECTOR_SHIFT;
> +	zone_info->zone_size = (u64)zone_sectors << SECTOR_SHIFT;

That should be fixed by changing type to sector_t, it's already so in
other functions (btrfs_reset_sb_log_zones, emulate_report_zones).

In btrfs_get_dev_zone_info thers's already a type mismatch near line
300:

	zone_sectors = bdev_zone_sectors(bdev);

linux/blkdev.h:
static inline sector_t bdev_zone_sectors(struct block_device *bdev)

>  	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
>  	zone_info->max_zone_append_size =
>  		(u64)queue_max_zone_append_sectors(queue) << SECTOR_SHIFT;
> -- 
> 2.30.1
