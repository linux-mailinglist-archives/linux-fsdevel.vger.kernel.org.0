Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A952E35F565
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 15:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351679AbhDNNrs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 09:47:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351664AbhDNNri (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618408035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vly4fVsN/ApQHSxB7cavfNOOII6EXPsT0w7OXdtQmRs=;
        b=JTD/wNrCI4823aI3T44c99cMTjxdLgn8JFFaouWxsQChoMa5TrKdYKBexqAcDz88OfGPL4
        +bx85b4LwPskdFNoFQKR8eJDzl/2W8NATTkIZDkxXVI2eiUN2wEOQTIEStOMtpUOluBq3q
        4emTBdFqq0KKUgpBsIkTyLpn9d96nYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-AQy3CV6uPM6qH0uR93a6Yg-1; Wed, 14 Apr 2021 09:47:13 -0400
X-MC-Unique: AQy3CV6uPM6qH0uR93a6Yg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 359CF8030BB;
        Wed, 14 Apr 2021 13:47:12 +0000 (UTC)
Received: from ws.net.home (ovpn-115-34.ams2.redhat.com [10.36.115.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE1D55C1B4;
        Wed, 14 Apr 2021 13:47:10 +0000 (UTC)
Date:   Wed, 14 Apr 2021 15:47:08 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     util-linux@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 2/3] blkid: add magic and probing for zoned btrfs
Message-ID: <20210414134708.t475gnqa7bor7bc6@ws.net.home>
References: <20210414013339.2936229-1-naohiro.aota@wdc.com>
 <20210414013339.2936229-3-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414013339.2936229-3-naohiro.aota@wdc.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 14, 2021 at 10:33:38AM +0900, Naohiro Aota wrote:
> +#define ASSERT(x) assert(x)

Really? ;-)

> +typedef uint64_t u64;
> +typedef uint64_t sector_t;
> +typedef uint8_t u8;

I do not see a reason for u64 and u8 here.

> +
> +#ifdef HAVE_LINUX_BLKZONED_H
> +static int sb_write_pointer(int fd, struct blk_zone *zones, u64 *wp_ret)
> +{
> +	bool empty[BTRFS_NR_SB_LOG_ZONES];
> +	bool full[BTRFS_NR_SB_LOG_ZONES];
> +	sector_t sector;
> +
> +	ASSERT(zones[0].type != BLK_ZONE_TYPE_CONVENTIONAL &&
> +	       zones[1].type != BLK_ZONE_TYPE_CONVENTIONAL);

assert()

 ...
> +		for (i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
> +			u64 bytenr;
> +
> +			bytenr = ((zones[i].start + zones[i].len)
> +				   << SECTOR_SHIFT) - BTRFS_SUPER_INFO_SIZE;
> +
> +			ret = pread64(fd, buf[i], BTRFS_SUPER_INFO_SIZE,
> +				      bytenr);

 please, use  

     ptr = blkid_probe_get_buffer(pr, BTRFS_SUPER_INFO_SIZE, bytenr);

 the library will care about the buffer and reuse it. It's also
 important to keep blkid_do_wipe() usable.

> +			if (ret != BTRFS_SUPER_INFO_SIZE)
> +				return -EIO;
> +			super[i] = (struct btrfs_super_block *)&buf[i];

  super[i] = (struct btrfs_super_block *) ptr;

> +		}
> +
> +		if (super[0]->generation > super[1]->generation)
> +			sector = zones[1].start;
> +		else
> +			sector = zones[0].start;
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
> +static int sb_log_offset(blkid_probe pr, uint64_t *bytenr_ret)
> +{
> +	uint32_t zone_num = 0;
> +	uint32_t zone_size_sector;
> +	struct blk_zone_report *rep;
> +	struct blk_zone *zones;
> +	size_t rep_size;
> +	int ret;
> +	uint64_t wp;
> +
> +	zone_size_sector = pr->zone_size >> SECTOR_SHIFT;
> +
> +	rep_size = sizeof(struct blk_zone_report) + sizeof(struct blk_zone) * 2;
> +	rep = malloc(rep_size);
> +	if (!rep)
> +		return -errno;
> +
> +	memset(rep, 0, rep_size);
> +	rep->sector = zone_num * zone_size_sector;
> +	rep->nr_zones = 2;

what about to add to lib/blkdev.c a new function:

   struct blk_zone_report *blkdev_get_zonereport(int fd, uint64 sector, int nzones);

and call this function from your sb_log_offset() as well as from blkid_do_wipe()?

Anyway, calloc() is better than malloc()+memset().

> +	if (zones[0].type == BLK_ZONE_TYPE_CONVENTIONAL) {
> +		*bytenr_ret = zones[0].start << SECTOR_SHIFT;
> +		ret = 0;
> +		goto out;
> +	} else if (zones[1].type == BLK_ZONE_TYPE_CONVENTIONAL) {
> +		*bytenr_ret = zones[1].start << SECTOR_SHIFT;
> +		ret = 0;
> +		goto out;
> +	}

what about:

 for (i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
   if (zones[i].type == BLK_ZONE_TYPE_CONVENTIONAL) {
      *bytenr_ret = zones[i].start << SECTOR_SHIFT;
      ret = 0;
      goto out;
   }
 }




 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

