Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE4952A19B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 14:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346110AbiEQMec (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 08:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242745AbiEQMea (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 08:34:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D214B876;
        Tue, 17 May 2022 05:34:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4F01221CD1;
        Tue, 17 May 2022 12:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652790867;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HuIMRN14JGi6FVhkYyikXn4jfOnEwx41w5UWTDF8TaI=;
        b=Z8zGI2cKe92t43wF3IU8bzZyLOD1eIzVh+XRmfFfA6iEaBK3UDTIJIKDdQYPthEOG3zt1o
        g2YKAKlDnuaZQmDsxJ5dBK03IpuardW3AsptMLcG2p3bv0Z/s6ifQGoHjb3qEhcPPor/Sg
        aozwRi1f3Fd79OLBoBPL33qpmG9NK9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652790867;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HuIMRN14JGi6FVhkYyikXn4jfOnEwx41w5UWTDF8TaI=;
        b=Iw3UGc1yIjzzyQ8fyKM97yOidrUBmUbrPGDJQSoaNowvHl51NhOMmoquPvOoNgp/eBpYAo
        pjcfAiOlbvzbLCCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E47AA13305;
        Tue, 17 May 2022 12:34:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8iC/NlKWg2KVFwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 17 May 2022 12:34:26 +0000
Date:   Tue, 17 May 2022 14:30:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, dsterba@suse.com, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v4 07/13] btrfs: zoned: use generic btrfs zone helpers to
 support npo2 zoned devices
Message-ID: <20220517123008.GC18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Pankaj Raghav <p.raghav@samsung.com>,
        axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, dsterba@suse.com, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220516165416.171196-1-p.raghav@samsung.com>
 <CGME20220516165428eucas1p1374b5f9592db3ca6a6551aff975537ce@eucas1p1.samsung.com>
 <20220516165416.171196-8-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516165416.171196-8-p.raghav@samsung.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 16, 2022 at 06:54:10PM +0200, Pankaj Raghav wrote:
> Add helpers to calculate alignment, round up and round down
> for zoned devices. These helpers encapsulates the necessary handling for
> power_of_2 and non-power_of_2 zone sizes. Optimized calculations are
> performed for zone sizes that are power_of_2 with log and shifts.
> 
> btrfs_zoned_is_aligned() is added instead of reusing bdev_zone_aligned()
> helper due to some use cases in btrfs where zone alignment is checked
> before having access to the underlying block device such as in this
> function: btrfs_load_block_group_zone_info().
> 
> Use the generic btrfs zone helpers to calculate zone index, check zone
> alignment, round up and round down operations.
> 
> The zone_size_shift field is not needed anymore as generic helpers are
> used for calculation.

Overall this looks reasonable to me.

> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/btrfs/volumes.c | 24 +++++++++-------
>  fs/btrfs/zoned.c   | 72 ++++++++++++++++++++++------------------------
>  fs/btrfs/zoned.h   | 43 +++++++++++++++++++++++----
>  3 files changed, 85 insertions(+), 54 deletions(-)
> 
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1108,14 +1101,14 @@ int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
>  int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
>  {
>  	struct btrfs_zoned_device_info *zinfo = device->zone_info;
> -	const u8 shift = zinfo->zone_size_shift;
> -	unsigned long begin = start >> shift;
> -	unsigned long end = (start + size) >> shift;
> +	unsigned long begin = bdev_zone_no(device->bdev, start >> SECTOR_SHIFT);
> +	unsigned long end =
> +		bdev_zone_no(device->bdev, (start + size) >> SECTOR_SHIFT);

There are unsinged long types here though I'd rather see u64, better for
a separate patch. Fixed width types are cleaner here and in the zoned
code as there's always some conversion to/from sectors.

>  	u64 pos;
>  	int ret;
>  
> -	ASSERT(IS_ALIGNED(start, zinfo->zone_size));
> -	ASSERT(IS_ALIGNED(size, zinfo->zone_size));
> +	ASSERT(btrfs_zoned_is_aligned(start, zinfo->zone_size));
> +	ASSERT(btrfs_zoned_is_aligned(size, zinfo->zone_size));
>  
>  	if (end > zinfo->nr_zones)
>  		return -ERANGE;
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -30,6 +30,36 @@ struct btrfs_zoned_device_info {
>  	u32 sb_zone_location[BTRFS_SUPER_MIRROR_MAX];
>  };
>  
> +static inline bool btrfs_zoned_is_aligned(u64 pos, u64 zone_size)
> +{
> +	u64 remainder = 0;
> +
> +	if (is_power_of_two_u64(zone_size))
> +		return IS_ALIGNED(pos, zone_size);
> +
> +	div64_u64_rem(pos, zone_size, &remainder);
> +	return remainder == 0;
> +}
> +
> +static inline u64 btrfs_zoned_roundup(u64 pos, u64 zone_size)
> +{
> +	if (is_power_of_two_u64(zone_size))
> +		return ALIGN(pos, zone_size);

Please use round_up as the rounddown helper uses round_down

> +
> +	return div64_u64(pos + zone_size - 1, zone_size) * zone_size;
> +}
> +
> +static inline u64 btrfs_zoned_rounddown(u64 pos, u64 zone_size)
> +{
> +	u64 remainder = 0;
> +	if (is_power_of_two_u64(zone_size))
> +		return round_down(pos, zone_size);
> +
> +	div64_u64_rem(pos, zone_size, &remainder);
> +	pos -= remainder;
> +	return pos;
> +}
> +
>  #ifdef CONFIG_BLK_DEV_ZONED
>  int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>  		       struct blk_zone *zone);
