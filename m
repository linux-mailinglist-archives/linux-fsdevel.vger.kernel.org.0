Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDEE2A44F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 13:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgKCMSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 07:18:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:52148 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728982AbgKCMSI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:18:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 081E6ABF4;
        Tue,  3 Nov 2020 12:18:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 67DC9DA7D2; Tue,  3 Nov 2020 13:16:29 +0100 (CET)
Date:   Tue, 3 Nov 2020 13:16:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 06/41] btrfs: introduce max_zone_append_size
Message-ID: <20201103121629.GQ6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
References: <cover.1604065156.git.naohiro.aota@wdc.com>
 <066af35477cd9dd3a096128df4aef3b583e93f52.1604065695.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <066af35477cd9dd3a096128df4aef3b583e93f52.1604065695.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 30, 2020 at 10:51:13PM +0900, Naohiro Aota wrote:
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -953,6 +953,8 @@ struct btrfs_fs_info {
>  		u64 zone_size;
>  		u64 zoned;
>  	};
> +	/* max size to emit ZONE_APPEND write command */

	/* Max size ... */

> +	u64 max_zone_append_size;
>  
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>  	spinlock_t ref_verify_lock;
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index e1cdff5af3a3..1b42e13b8227 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -47,6 +47,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
>  {
>  	struct btrfs_zoned_device_info *zone_info = NULL;
>  	struct block_device *bdev = device->bdev;
> +	struct request_queue *q = bdev_get_queue(bdev);

No single letter variables (exception is 'i' for indexing)

>  	sector_t nr_sectors = bdev->bd_part->nr_sects;
>  	sector_t sector = 0;
>  	struct blk_zone *zones = NULL;
> @@ -70,6 +71,8 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
>  	ASSERT(is_power_of_2(zone_sectors));
>  	zone_info->zone_size = (u64)zone_sectors << SECTOR_SHIFT;
>  	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
> +	zone_info->max_zone_append_size =
> +		(u64)queue_max_zone_append_sectors(q) << SECTOR_SHIFT;
>  	zone_info->nr_zones = nr_sectors >> ilog2(bdev_zone_sectors(bdev));
>  	if (!IS_ALIGNED(nr_sectors, zone_sectors))
>  		zone_info->nr_zones++;
> @@ -182,7 +185,8 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>  	u64 hmzoned_devices = 0;
>  	u64 nr_devices = 0;
>  	u64 zone_size = 0;
> -	int incompat_zoned = btrfs_is_zoned(fs_info);
> +	u64 max_zone_append_size = 0;
> +	bool incompat_zoned = btrfs_is_zoned(fs_info);

	const bool

>  	int ret = 0;
>  
>  	/* Count zoned devices */
> @@ -195,15 +199,23 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>  		model = bdev_zoned_model(device->bdev);
>  		if (model == BLK_ZONED_HM ||
>  		    (model == BLK_ZONED_HA && incompat_zoned)) {
> +			struct btrfs_zoned_device_info *zone_info =
> +				device->zone_info;
> +
>  			hmzoned_devices++;

I must have missed in some previous patch, 'hmzoned' should be zoned?

>  			if (!zone_size) {
> -				zone_size = device->zone_info->zone_size;
> -			} else if (device->zone_info->zone_size != zone_size) {
> +				zone_size = zone_info->zone_size;
> +			} else if (zone_info->zone_size != zone_size) {
>  				btrfs_err(fs_info,
>  					  "Zoned block devices must have equal zone sizes");

				"zoned: devices must have equal zone sizes, have %u found %u"

>  				ret = -EINVAL;
>  				goto out;
>  			}
> +			if (!max_zone_append_size ||
> +			    (zone_info->max_zone_append_size &&
> +			     zone_info->max_zone_append_size < max_zone_append_size))
> +				max_zone_append_size =
> +					zone_info->max_zone_append_size;
>  		}
>  		nr_devices++;
>  	}
