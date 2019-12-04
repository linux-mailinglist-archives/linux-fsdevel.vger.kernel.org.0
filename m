Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC71112B24
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 13:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfLDMPh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 07:15:37 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39922 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbfLDMPg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:15:36 -0500
Received: by mail-lj1-f195.google.com with SMTP id e10so7834223ljj.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2019 04:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vWnht6CTOsskn3bt1G12tnqOg3gYH7AU+SyNT03jxRE=;
        b=RU9bXTFU9xZckgMse432oK5kwfBw+93B3UyjSYOpj0Izzi8rme1uDXl6PBaZrhBWhG
         Jr4jkvnp1YqxO4Rpbvxyp6bUT2A6uvPOrydGRnWQaIt6z2ApcAk9+8baIJMhgtIs1LV0
         /Kn/0rKgZis12is/xYxLunpG1ga57ahZTDTGR1TS/OiNHJnS0SAIXO4E8Jrhrz3r5wkx
         F36t+4A1r6LJHyXHb1Fgallq6VjaakA1bAoRAzzy1GEzchad9oZnG4Nwrj6puHPktaFN
         PTSIx367Jhrc/L+/h/kdOgf5L5R3la4bi/EB9x+OifWNP5HGqCDM9SIhlu5MAWHr+H0r
         IKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vWnht6CTOsskn3bt1G12tnqOg3gYH7AU+SyNT03jxRE=;
        b=tZHPkfztrezNFC8iP47rFXRBx1x0C/a2Qe76kzXS/XOkAnOdUJfI8HKYYlMO2yZ1IP
         m+1FnFxQmjemfsVlm/rGRO6V7ga+m5MyC6pQ8aMSkalV71RhqRu4+DLDE+bjcvENMAkV
         Ay4HopMgGg4ypfeKbQIK6KC0Aa9uFb9R2dURKkexYBH2GhuxC4WFA2RmQweyWGnHaHLb
         oAlYh6VzbTLEvOrX5FhTM5gNiAuP5VjkWjtDOPVDDJ9EE+uNVKJ2DXfwl5EtIb6mKv3J
         bbVUUjTUYsMGEtlfBngvTAUlgi7C1Ziga7xzH+SpxO42mkd5WrvGUs2N9cwN9uRMyp/w
         hYLQ==
X-Gm-Message-State: APjAAAVhXmxi+YwPDyB7GL7Sw5iGjC9GcoR5nBOYOBiKjLnkEc9bXpdk
        mSmpbQGQaktnmfR6OScoOgG6CQ==
X-Google-Smtp-Source: APXvYqw4ahdS3HQxyxs5HGPSvr3lkLVW9VkMG/JFwPdiWdvIU8pjfSdJDK3dGLzNOnh9lstsrhw/sw==
X-Received: by 2002:a2e:9a51:: with SMTP id k17mr1718757ljj.206.1575461734019;
        Wed, 04 Dec 2019 04:15:34 -0800 (PST)
Received: from msk1wst115n.omp.ru (mail.omprussia.ru. [5.134.221.218])
        by smtp.gmail.com with ESMTPSA id m13sm3207063lfk.94.2019.12.04.04.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Dec 2019 04:15:33 -0800 (PST)
Message-ID: <5eb099b6886358f3a478658e25a26a42ab674e7f.camel@dubeyko.com>
Subject: Re: [PATCH] libblkid: implement zone-aware probing for HMZONED btrfs
From:   Vyacheslav Dubeyko <slava@dubeyko.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Date:   Wed, 04 Dec 2019 15:15:32 +0300
In-Reply-To: <20191204083023.861495-1-naohiro.aota@wdc.com>
References: <20191204082513.857320-1-naohiro.aota@wdc.com>
         <20191204083023.861495-1-naohiro.aota@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2019-12-04 at 17:30 +0900, Naohiro Aota wrote:
> This is a proof-of-concept patch to make libblkid zone-aware. It can
> probe the magic located at some offset from the beginning of some
> specific zone of a device.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  libblkid/src/blkidP.h            |   4 +
>  libblkid/src/probe.c             |  25 +++++-
>  libblkid/src/superblocks/btrfs.c | 132
> ++++++++++++++++++++++++++++++-
>  3 files changed, 157 insertions(+), 4 deletions(-)
> 
> diff --git a/libblkid/src/blkidP.h b/libblkid/src/blkidP.h
> index f9bbe008406f..5bb6771ee9c6 100644
> --- a/libblkid/src/blkidP.h
> +++ b/libblkid/src/blkidP.h
> @@ -148,6 +148,10 @@ struct blkid_idmag
>  
>  	long		kboff;		/* kilobyte offset of
> superblock */
>  	unsigned int	sboff;		/* byte offset within
> superblock */
> +
> +	int		is_zone;
> +	long		zonenum;
> +	long		kboff_inzone;
>  };

Maybe, it makes sense to add the comments for added fields? How do you
feel?

>  
>  /*
> diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
> index f6dd5573d5dd..56e42ac28559 100644
> --- a/libblkid/src/probe.c
> +++ b/libblkid/src/probe.c
> @@ -94,6 +94,7 @@
>  #ifdef HAVE_LINUX_CDROM_H
>  #include <linux/cdrom.h>
>  #endif
> +#include <linux/blkzoned.h>
>  #ifdef HAVE_SYS_STAT_H
>  #include <sys/stat.h>
>  #endif
> @@ -1009,8 +1010,25 @@ int blkid_probe_get_idmag(blkid_probe pr,
> const struct blkid_idinfo *id,
>  	/* try to detect by magic string */
>  	while(mag && mag->magic) {
>  		unsigned char *buf;
> -
> -		off = (mag->kboff + (mag->sboff >> 10)) << 10;
> +		uint64_t kboff;
> +
> +		if (!mag->is_zone)
> +			kboff = mag->kboff;
> +		else {
> +			uint32_t zone_size_sector;
> +			int ret;
> +
> +			ret = ioctl(pr->fd, BLKGETZONESZ,
> &zone_size_sector);
> +			if (ret == EOPNOTSUPP)

-EOPNOTSUPP??? Or this is the libblk peculiarity?

> +				goto next;
> +			if (ret)
> +				return -errno;
> +			if (zone_size_sector == 0)
> +				goto next;
> +			kboff = (mag->zonenum * (zone_size_sector <<
> 9)) >> 10;
> +			kboff += mag->kboff_inzone;
> +		}
> +		off = (kboff + (mag->sboff >> 10)) << 10;
>  		buf = blkid_probe_get_buffer(pr, off, 1024);
>  
>  		if (!buf && errno)
> @@ -1020,13 +1038,14 @@ int blkid_probe_get_idmag(blkid_probe pr,
> const struct blkid_idinfo *id,
>  				buf + (mag->sboff & 0x3ff), mag->len))
> {
>  
>  			DBG(LOWPROBE, ul_debug("\tmagic sboff=%u,
> kboff=%ld",
> -				mag->sboff, mag->kboff));
> +				mag->sboff, kboff));
>  			if (offset)
>  				*offset = off + (mag->sboff & 0x3ff);
>  			if (res)
>  				*res = mag;
>  			return BLKID_PROBE_OK;
>  		}
> +next:
>  		mag++;
>  	}
>  
> diff --git a/libblkid/src/superblocks/btrfs.c
> b/libblkid/src/superblocks/btrfs.c
> index f0fde700d896..4254220ef423 100644
> --- a/libblkid/src/superblocks/btrfs.c
> +++ b/libblkid/src/superblocks/btrfs.c
> @@ -9,6 +9,9 @@
>  #include <unistd.h>
>  #include <string.h>
>  #include <stdint.h>
> +#include <stdbool.h>
> +
> +#include <linux/blkzoned.h>
>  
>  #include "superblocks.h"
>  
> @@ -59,11 +62,131 @@ struct btrfs_super_block {
>  	uint8_t label[256];
>  } __attribute__ ((__packed__));
>  
> +#define BTRFS_SUPER_INFO_SIZE 4096

I believe that 4K is very widely used constant.
Are you sure that it needs to introduce some
additional constant? Especially, it looks slightly
strange to see the BTRFS specialized constant.
Maybe, it needs to generalize the constant? 

> +#define SECTOR_SHIFT 9

Are you sure that libblkid hasn't such constant?

> +
> +#define READ 0
> +#define WRITE 1
> +
> +typedef uint64_t u64;
> +typedef uint64_t sector_t;

I see the point to introduce the sector_t type.
But is it really necessary to introduce the u64 type?

> +
> +static int sb_write_pointer(struct blk_zone *zones, u64 *wp_ret)
> +{
> +	bool empty[2];
> +	bool full[2];
> +	sector_t sector;
> +
> +	if (zones[0].type == BLK_ZONE_TYPE_CONVENTIONAL) {
> +		*wp_ret = zones[0].start << SECTOR_SHIFT;
> +		return -ENOENT;
> +	}
> +
> +	empty[0] = zones[0].cond == BLK_ZONE_COND_EMPTY;
> +	empty[1] = zones[1].cond == BLK_ZONE_COND_EMPTY;
> +	full[0] = zones[0].cond == BLK_ZONE_COND_FULL;
> +	full[1] = zones[1].cond == BLK_ZONE_COND_FULL;
> +
> +	/*
> +	 * Possible state of log buffer zones
> +	 *
> +	 *   E I F
> +	 * E * x 0
> +	 * I 0 x 0
> +	 * F 1 1 x
> +	 *
> +	 * Row: zones[0]
> +	 * Col: zones[1]
> +	 * State:
> +	 *   E: Empty, I: In-Use, F: Full
> +	 * Log position:
> +	 *   *: Special case, no superblock is written
> +	 *   0: Use write pointer of zones[0]
> +	 *   1: Use write pointer of zones[1]
> +	 *   x: Invalid state
> +	 */
> +
> +	if (empty[0] && empty[1]) {
> +		/* special case to distinguish no superblock to read */
> +		*wp_ret = zones[0].start << SECTOR_SHIFT;


So, even if we return the error then somebody will check
the *wp_ret value? Looks slightly unexpected.

> +		return -ENOENT;
> +	} else if (full[0] && full[1]) {
> +		/* cannot determine which zone has the newer superblock
> */
> +		return -EUCLEAN;
> +	} else if (!full[0] && (empty[1] || full[1])) {
> +		sector = zones[0].wp;
> +	} else if (full[0]) {
> +		sector = zones[1].wp;
> +	} else {
> +		return -EUCLEAN;
> +	}
> +	*wp_ret = sector << SECTOR_SHIFT;
> +	return 0;
> +}
> +
> +static int sb_log_offset(uint32_t zone_size_sector, blkid_probe pr,
> +			 uint64_t *offset_ret)
> +{
> +	uint32_t zone_num = 0;
> +	struct blk_zone_report *rep;
> +	struct blk_zone *zones;
> +	size_t rep_size;
> +	int ret;
> +	uint64_t wp;
> +
> +	rep_size = sizeof(struct blk_zone_report) + sizeof(struct
> blk_zone) * 2;
> +	rep = malloc(rep_size);
> +	if (!rep)
> +		return -errno;
> +
> +	memset(rep, 0, rep_size);
> +	rep->sector = zone_num * zone_size_sector;
> +	rep->nr_zones = 2;
> +
> +	ret = ioctl(pr->fd, BLKREPORTZONE, rep);
> +	if (ret)
> +		return -errno;

So, the valid case if ioctl returns 0? Am I correct?


> +	if (rep->nr_zones != 2) {
> +		free(rep);
> +		return 1;
> +	}
> +
> +	zones = (struct blk_zone *)(rep + 1);
> +
> +	ret = sb_write_pointer(zones, &wp);
> +	if (ret != -ENOENT && ret)
> +		return -EIO;


If ret is positive then we could return the error. Am I correct?


> +	if (ret != -ENOENT) {
> +		if (wp == zones[0].start << SECTOR_SHIFT)
> +			wp = (zones[1].start + zones[1].len) <<
> SECTOR_SHIFT;
> +		wp -= BTRFS_SUPER_INFO_SIZE;
> +	}
> +	*offset_ret = wp;
> +
> +	return 0;
> +}
> +
>  static int probe_btrfs(blkid_probe pr, const struct blkid_idmag
> *mag)
>  {
>  	struct btrfs_super_block *bfs;
> +	uint32_t zone_size_sector;
> +	int ret;
> +
> +	ret = ioctl(pr->fd, BLKGETZONESZ, &zone_size_sector);
> +	if (ret)
> +		return errno;

You returned -errno for another ioctls above. Is everything correct
here?

> +	if (zone_size_sector != 0) {
> +		uint64_t offset = 0;
>  
> -	bfs = blkid_probe_get_sb(pr, mag, struct btrfs_super_block);
> +		ret = sb_log_offset(zone_size_sector, pr, &offset);
> +		if (ret)
> +			return ret;

What about a positive value of ret? I suppose it needs to return ret
only if we have an error. Am I correct?

Thanks,
Viacheslav Dubeyko.

> +		bfs = (struct btrfs_super_block*)
> +			blkid_probe_get_buffer(pr, offset,
> +					       sizeof(struct
> btrfs_super_block));
> +	} else {
> +		bfs = blkid_probe_get_sb(pr, mag, struct
> btrfs_super_block);
> +	}
>  	if (!bfs)
>  		return errno ? -errno : 1;
>  
> @@ -88,6 +211,13 @@ const struct blkid_idinfo btrfs_idinfo =
>  	.magics		=
>  	{
>  	  { .magic = "_BHRfS_M", .len = 8, .sboff = 0x40, .kboff = 64
> },
> +	  /* for HMZONED btrfs */
> +	  { .magic = "!BHRfS_M", .len = 8, .sboff = 0x40,
> +	    .is_zone = 1, .zonenum = 0, .kboff_inzone = 0 },
> +	  { .magic = "_BHRfS_M", .len = 8, .sboff = 0x40,
> +	    .is_zone = 1, .zonenum = 0, .kboff_inzone = 0 },
> +	  { .magic = "_BHRfS_M", .len = 8, .sboff = 0x40,
> +	    .is_zone = 1, .zonenum = 1, .kboff_inzone = 0 },
>  	  { NULL }
>  	}
>  };

