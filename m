Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1AA2A44DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 13:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgKCMPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 07:15:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:48608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728889AbgKCMPZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:15:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 49699ABF4;
        Tue,  3 Nov 2020 12:15:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 76A4ADA7D2; Tue,  3 Nov 2020 13:13:45 +0100 (CET)
Date:   Tue, 3 Nov 2020 13:13:45 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v9 05/41] btrfs: Check and enable ZONED mode
Message-ID: <20201103121345.GP6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1604065156.git.naohiro.aota@wdc.com>
 <599d306d41880e3e3242120a40a78b81f6ed0473.1604065695.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <599d306d41880e3e3242120a40a78b81f6ed0473.1604065695.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Below are suggested message updates, common prefix "zoned:" in case it
happens inside the zone mode implementation. Some of them sound strange
when repeating 'zoned', but for clarity I think it should stay, unless
somebody has a better suggestion.

On Fri, Oct 30, 2020 at 10:51:12PM +0900, Naohiro Aota wrote:
> index aac3d6f4e35b..25fd4e97dd2a 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3595,4 +3601,8 @@ static inline int btrfs_is_testing(struct btrfs_fs_info *fs_info)
>  }
>  #endif
>  
> +static inline bool btrfs_is_zoned(struct btrfs_fs_info *fs_info)
> +{
> +	return fs_info->zoned != 0;
> +}

newline

>  #endif

> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 6f6d77224c2b..5e3554482af1 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -238,6 +238,13 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>  		return PTR_ERR(bdev);
>  	}
>  
> +	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
> +		btrfs_err(fs_info,
> +			  "zone type of target device mismatch with the filesystem!");

		"dev-replace: zoned type of target device mismatch with filesystem"

> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
>  	sync_blockdev(bdev);
>  
>  	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 764001609a15..9bc51cff48b8 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3130,7 +3133,15 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  
>  	btrfs_free_extra_devids(fs_devices, 1);
>  
> +	ret = btrfs_check_zoned_mode(fs_info);
> +	if (ret) {
> +		btrfs_err(fs_info, "failed to init ZONED mode: %d",

		"failed to inititialize zoned mode: %d"

> +				ret);
> +		goto fail_block_groups;
> +	}
> +
>  	ret = btrfs_sysfs_add_fsid(fs_devices);
> +
>  	if (ret) {
>  		btrfs_err(fs_info, "failed to init sysfs fsid interface: %d",
>  				ret);
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> +	u64 nr_devices = 0;
> +	u64 zone_size = 0;
> +	int incompat_zoned = btrfs_is_zoned(fs_info);

	const bool

> +	int ret = 0;
> +
> +	/* Count zoned devices */
> +	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +		enum blk_zoned_model model;
> +
> +		if (!device->bdev)
> +			continue;
> +
> +		model = bdev_zoned_model(device->bdev);
> +		if (model == BLK_ZONED_HM ||
> +		    (model == BLK_ZONED_HA && incompat_zoned)) {
> +			hmzoned_devices++;
> +			if (!zone_size) {
> +				zone_size = device->zone_info->zone_size;
> +			} else if (device->zone_info->zone_size != zone_size) {
> +				btrfs_err(fs_info,
> +					  "Zoned block devices must have equal zone sizes");

				"zoned: unequal block device zone sizes: have %u found %u"

> +				ret = -EINVAL;
> +				goto out;
> +			}
> +		}
> +		nr_devices++;
> +	}
> +
> +	if (!hmzoned_devices && !incompat_zoned)
> +		goto out;
> +
> +	if (!hmzoned_devices && incompat_zoned) {
> +		/* No zoned block device found on ZONED FS */
> +		btrfs_err(fs_info,
> +			  "ZONED enabled file system should have zoned devices");

		"zoned: no zoned devices found on a zoned filesystem"

> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (hmzoned_devices && !incompat_zoned) {
> +		btrfs_err(fs_info,
> +			  "Enable ZONED mode to mount HMZONED device");

Is HMZONED reference leftover from previous iterations?

		"zoned: mode not enabled but zoned device found"

> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (hmzoned_devices != nr_devices) {
> +		btrfs_err(fs_info,
> +			  "zoned devices cannot be mixed with regular devices");

		"zoned: cannot mix zoned and regular devices"

> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/*
> +	 * stripe_size is always aligned to BTRFS_STRIPE_LEN in
> +	 * __btrfs_alloc_chunk(). Since we want stripe_len == zone_size,
> +	 * check the alignment here.
> +	 */
> +	if (!IS_ALIGNED(zone_size, BTRFS_STRIPE_LEN)) {
> +		btrfs_err(fs_info,
> +			  "zone size is not aligned to BTRFS_STRIPE_LEN");

		"zoned: zone size not aligned to stripe %u"

> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	fs_info->zone_size = zone_size;
> +
> +	btrfs_info(fs_info, "ZONED mode enabled, zone size %llu B",
> +		   fs_info->zone_size);

	"zoned mode enabled with zone %llu"

> +out:
> +	return ret;
> +}

> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -31,6 +34,14 @@ static inline int btrfs_get_dev_zone_info(struct btrfs_device *device)
>  	return 0;
>  }
>  static inline void btrfs_destroy_dev_zone_info(struct btrfs_device *device) { }

newline

> +static inline int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
> +{
> +	if (!btrfs_is_zoned(fs_info))
> +		return 0;
> +
> +	btrfs_err(fs_info, "Zoned block devices support is not enabled");
> +	return -EOPNOTSUPP;
> +}

newline

>  #endif
>  
>  static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
