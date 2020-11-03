Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552832A44BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 13:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgKCMDr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 07:03:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:39054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbgKCMDr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:03:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1223FABF4;
        Tue,  3 Nov 2020 12:03:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3C9B2DA7D2; Tue,  3 Nov 2020 13:02:07 +0100 (CET)
Date:   Tue, 3 Nov 2020 13:02:07 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v9 04/41] btrfs: Get zone information of zoned block
 devices
Message-ID: <20201103120207.GO6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1604065156.git.naohiro.aota@wdc.com>
 <feca5ea7b6dc1a62eddbc00e01452b92523c8f36.1604065694.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feca5ea7b6dc1a62eddbc00e01452b92523c8f36.1604065694.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 30, 2020 at 10:51:11PM +0900, Naohiro Aota wrote:
> +static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
> +			       struct blk_zone *zones, unsigned int *nr_zones)
> +{
> +	int ret;
> +
> +	if (!*nr_zones)
> +		return 0;
> +
> +	ret = blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT, *nr_zones,
> +				  copy_zone_info_cb, zones);
> +	if (ret < 0) {
> +		btrfs_err_in_rcu(device->fs_info,
> +				 "get zone at %llu on %s failed %d", pos,

		"zoned: failed to read zone %llu on %s (devid %llu)"

> +				 rcu_str_deref(device->name), ret);
> +		return ret;
> +	}
> +	*nr_zones = ret;
> +	if (!ret)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +int btrfs_get_dev_zone_info(struct btrfs_device *device)
> +{
> +	struct btrfs_zoned_device_info *zone_info = NULL;
> +	struct block_device *bdev = device->bdev;
> +	sector_t nr_sectors = bdev->bd_part->nr_sects;
> +	sector_t sector = 0;
> +	struct blk_zone *zones = NULL;
> +	unsigned int i, nreported = 0, nr_zones;
> +	unsigned int zone_sectors;
> +	int ret;
> +	char devstr[sizeof(device->fs_info->sb->s_id) +
> +		    sizeof(" (device )") - 1];

Can you avoid the local variable and print the contents conditionally?

> +	kfree(zones);
> +
> +	device->zone_info = zone_info;
> +
> +	devstr[0] = 0;
> +	if (device->fs_info)
> +		snprintf(devstr, sizeof(devstr), " (device %s)",
> +			 device->fs_info->sb->s_id);
> +
> +	rcu_read_lock();
> +	pr_info(
> +"BTRFS info%s: host-%s zoned block device %s, %u zones of %llu sectors",

I think zone size in bytes is more natural, is there a reason to print
that in sectors?

> +		devstr,
> +		bdev_zoned_model(bdev) == BLK_ZONED_HM ? "managed" : "aware",
> +		rcu_str_deref(device->name), zone_info->nr_zones,
> +		zone_info->zone_size >> SECTOR_SHIFT);
> +	rcu_read_unlock();
> +
> +	return 0;
> +
> +out:
> +	kfree(zones);
> +	bitmap_free(zone_info->empty_zones);
> +	bitmap_free(zone_info->seq_zones);
> +	kfree(zone_info);
> +
> +	return ret;
> +}

> --- /dev/null
> +++ b/fs/btrfs/zoned.h
> @@ -0,0 +1,86 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef BTRFS_ZONED_H
> +#define BTRFS_ZONED_H

This should at least include types.h as it's using u64
> +
> +struct btrfs_zoned_device_info {
> +	/*
> +	 * Number of zones, zone size and types of zones if bdev is a
> +	 * zoned block device.
> +	 */
> +	u64 zone_size;
> +	u8  zone_size_shift;
> +	u32 nr_zones;
> +	unsigned long *seq_zones;
> +	unsigned long *empty_zones;
> +};
> +
> +#ifdef CONFIG_BLK_DEV_ZONED
> +int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
> +		       struct blk_zone *zone);
> +int btrfs_get_dev_zone_info(struct btrfs_device *device);
> +void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
> +#else /* CONFIG_BLK_DEV_ZONED */
> +static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
> +				     struct blk_zone *zone)
> +{
> +	return 0;
> +}

newline

> +static inline int btrfs_get_dev_zone_info(struct btrfs_device *device)
> +{
> +	return 0;
> +}

newline

> +static inline void btrfs_destroy_dev_zone_info(struct btrfs_device *device) { }
> +#endif
