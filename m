Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8073D112E9E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 16:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfLDPhm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 10:37:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:59098 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728353AbfLDPhl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:37:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84F7BAF81;
        Wed,  4 Dec 2019 15:37:39 +0000 (UTC)
Date:   Wed, 4 Dec 2019 16:37:32 +0100
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 02/28] btrfs: Get zone information of zoned block
 devices
Message-ID: <20191204153732.GA2083@Johanness-MacBook-Pro.local>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
 <20191204081735.852438-3-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204081735.852438-3-naohiro.aota@wdc.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 04, 2019 at 05:17:09PM +0900, Naohiro Aota wrote:
[..]

> +#define LEN (sizeof(device->fs_info->sb->s_id) + sizeof("(device )") - 1)
> +	char devstr[LEN];
> +	const int len = LEN;
> +#undef LEN

Why not:
	const int len = sizeof(device->fs_info->sb->s_id)
					+ sizeof("(device )") - 1;
	char devstr[len];

But that's bikeshedding territory I admit.

> +
> +	if (!bdev_is_zoned(bdev))
> +		return 0;
> +
> +	zone_info = kzalloc(sizeof(*zone_info), GFP_KERNEL);
> +	if (!zone_info)
> +		return -ENOMEM;
> +
> +	zone_sectors = bdev_zone_sectors(bdev);
> +	ASSERT(is_power_of_2(zone_sectors));
> +	zone_info->zone_size = (u64)zone_sectors << SECTOR_SHIFT;
> +	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
> +	zone_info->nr_zones = nr_sectors >> ilog2(bdev_zone_sectors(bdev));
> +	if (nr_sectors & (bdev_zone_sectors(bdev) - 1))
> +		zone_info->nr_zones++;

You've already cached the return of bdev_zone_sectors(bdev) in
zone_sectors at the beginning of this block and if (x & (y-1)) is the
IS_ALIGNED() macro so the above should really be:
	if (!IS_ALIGNED(nr_sectors, zone_sectors))
		zone_info->nr_zones++;


> +
> +	zone_info->seq_zones = kcalloc(BITS_TO_LONGS(zone_info->nr_zones),
> +				       sizeof(*zone_info->seq_zones),
> +				       GFP_KERNEL);

	zone_info->seq_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);

> +	if (!zone_info->seq_zones) {
> +		ret = -ENOMEM;
> +		goto free_zone_info;
> +	}
> +
> +	zone_info->empty_zones = kcalloc(BITS_TO_LONGS(zone_info->nr_zones),
> +					 sizeof(*zone_info->empty_zones),
> +					 GFP_KERNEL);
	
	zone_info->empty_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);

> +	if (!zone_info->empty_zones) {
> +		ret = -ENOMEM;
> +		goto free_seq_zones;
> +	}
> +
> +	zones = kcalloc(BTRFS_REPORT_NR_ZONES,
> +			sizeof(struct blk_zone), GFP_KERNEL);
> +	if (!zones) {
> +		ret = -ENOMEM;
> +		goto free_empty_zones;
> +	}
> +

I personally would set nreported = 0 here instead in the declaration block. I
had to scroll up to see what's the initial value, so I think it makes more
sense to initialize it to 0 here.

> +	/* Get zones type */
> +	while (sector < nr_sectors) {
> +		nr_zones = BTRFS_REPORT_NR_ZONES;
> +		ret = btrfs_get_dev_zones(device, sector << SECTOR_SHIFT, zones,
> +					  &nr_zones);
> +		if (ret)
> +			goto free_zones;
> +
> +		for (i = 0; i < nr_zones; i++) {
> +			if (zones[i].type == BLK_ZONE_TYPE_SEQWRITE_REQ)
> +				set_bit(nreported, zone_info->seq_zones);
> +			if (zones[i].cond == BLK_ZONE_COND_EMPTY)
> +				set_bit(nreported, zone_info->empty_zones);
> +			nreported++;
> +		}
> +		sector = zones[nr_zones - 1].start + zones[nr_zones - 1].len;
> +	}
> +
> +	if (nreported != zone_info->nr_zones) {
> +		btrfs_err_in_rcu(device->fs_info,
> +				 "inconsistent number of zones on %s (%u / %u)",
> +				 rcu_str_deref(device->name), nreported,
> +				 zone_info->nr_zones);
> +		ret = -EIO;
> +		goto free_zones;
> +	}
> +
> +	kfree(zones);
> +
> +	device->zone_info = zone_info;
> +
> +	devstr[0] = 0;
> +	if (device->fs_info)
> +		snprintf(devstr, len, " (device %s)",
> +			 device->fs_info->sb->s_id);
> +
> +	rcu_read_lock();
> +	pr_info(
> +"BTRFS info%s: host-%s zoned block device %s, %u zones of %llu sectors",
> +		devstr,
> +		bdev_zoned_model(bdev) == BLK_ZONED_HM ? "managed" : "aware",
> +		rcu_str_deref(device->name), zone_info->nr_zones,
> +		zone_info->zone_size >> SECTOR_SHIFT);
> +	rcu_read_unlock();

btrfs_info_in_rcu()?

> +
> +	return 0;
> +
> +free_zones:
> +	kfree(zones);
> +free_empty_zones:
> +	kfree(zone_info->empty_zones);
	
	bitmap_free(zone_info->empty_zones);

> +free_seq_zones:
> +	kfree(zone_info->seq_zones);
 	
	bitmap_free(zone_info->seq_zones);

> +free_zone_info:
> +	kfree(zone_info);
> +
> +	return ret;
> +}
> +
> +void btrfs_destroy_dev_zone_info(struct btrfs_device *device)
> +{
> +	struct btrfs_zoned_device_info *zone_info = device->zone_info;
> +
> +	if (!zone_info)
> +		return;
> +
> +	kfree(zone_info->seq_zones);
> +	kfree(zone_info->empty_zones);

	bitmap_free(zone_info->seq_zones);
	bitmap_free(zone_info->empty_zones);

Thanks,
	Johannes
