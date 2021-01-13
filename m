Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24CB2F5197
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 19:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbhAMSBR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 13:01:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:56032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728066AbhAMSBR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 13:01:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5B402ACF4;
        Wed, 13 Jan 2021 18:00:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4A732DA7CF; Wed, 13 Jan 2021 18:58:43 +0100 (CET)
Date:   Wed, 13 Jan 2021 18:58:43 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v11 08/40] btrfs: emulated zoned mode on non-zoned devices
Message-ID: <20210113175843.GV6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1608515994.git.naohiro.aota@wdc.com>
 <e2bcb873196a16b05d5757cd8087900d4f464347.1608608848.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2bcb873196a16b05d5757cd8087900d4f464347.1608608848.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 22, 2020 at 12:49:01PM +0900, Naohiro Aota wrote:
> @@ -296,12 +383,22 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
>  
>  	device->zone_info = zone_info;
>  
> -	/* device->fs_info is not safe to use for printing messages */
> -	btrfs_info_in_rcu(NULL,

NULL instead of fs_info

> -			"host-%s zoned block device %s, %u zones of %llu bytes",
> -			bdev_zoned_model(bdev) == BLK_ZONED_HM ? "managed" : "aware",
> -			rcu_str_deref(device->name), zone_info->nr_zones,
> -			zone_info->zone_size);
> +	if (bdev_zoned_model(bdev) == BLK_ZONED_HM) {
> +		model = "host-managed zoned";
> +		emulated = "";
> +	} else if (bdev_zoned_model(bdev) == BLK_ZONED_HA) {
> +		model = "host-aware zoned";
> +		emulated = "";
> +	} else if (bdev_zoned_model(bdev) == BLK_ZONED_NONE &&
> +		 device->force_zoned) {
> +		model = "regular";
> +		emulated = "emulated ";
> +	}
> +
> +	btrfs_info_in_rcu(device->fs_info,

so what changed that it's fine to use device->fs_info now while it was
not before?

> +		"%s block device %s, %u %szones of %llu bytes",
> +		model, rcu_str_deref(device->name), zone_info->nr_zones,
> +		emulated, zone_info->zone_size);
>  
>  	return 0;
