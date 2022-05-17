Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A7852A1E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 14:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346373AbiEQMrU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 08:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346352AbiEQMrT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 08:47:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A813C707;
        Tue, 17 May 2022 05:47:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 441B71F8B9;
        Tue, 17 May 2022 12:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652791636;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0W2aB+gcSjG4kNtv/FxRZAREXphQHFMH1ilNeTwZmUA=;
        b=k2psAUXokp98i31xB04jcbNRqFQR14AQgy9tjflO6J9LysSMujnjCejo/Fa4zbTev0ooEg
        2CQo/BW+ZU4ZxpUSPql0p60m5wulSKEgwd8XwK7XH+s52P8eXn7I41Pn2OYcJUUrWI0U7c
        fs2AfbH+hzjOovyl3SuUEr76V/g/Ov8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652791636;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0W2aB+gcSjG4kNtv/FxRZAREXphQHFMH1ilNeTwZmUA=;
        b=fRTsocok6zVIpkBsGGHYSn41srt0D7U7KTJM2r3q1Rhulmrl8S1WyQKNhUEKW3h/Rnw2yw
        P1TzucC02HahBQCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D82C413305;
        Tue, 17 May 2022 12:47:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x6q+M1OZg2KuHgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 17 May 2022 12:47:15 +0000
Date:   Tue, 17 May 2022 14:42:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, dsterba@suse.com, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH v4 08/13] btrfs:zoned: make sb for npo2 zone devices
 align with sb log offsets
Message-ID: <20220517124257.GD18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Pankaj Raghav <p.raghav@samsung.com>,
        axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, dsterba@suse.com, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20220516165416.171196-1-p.raghav@samsung.com>
 <CGME20220516165429eucas1p272c8b4325a488675f08f2d7016aa6230@eucas1p2.samsung.com>
 <20220516165416.171196-9-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516165416.171196-9-p.raghav@samsung.com>
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

On Mon, May 16, 2022 at 06:54:11PM +0200, Pankaj Raghav wrote:
> Superblocks for zoned devices are fixed as 2 zones at 0, 512GB and 4TB.
> These are fixed at these locations so that recovery tools can reliably
> retrieve the superblocks even if one of the mirror gets corrupted.
> 
> power of 2 zone sizes align at these offsets irrespective of their
> value but non power of 2 zone sizes will not align.
> 
> To make sure the first zone at mirror 1 and mirror 2 align, write zero
> operation is performed to move the write pointer of the first zone to
> the expected offset. This operation is performed only after a zone reset
> of the first zone, i.e., when the second zone that contains the sb is FULL.

Is it a good idea to do the "write zeros", instead of a plain "set write
pointer"? I assume setting write pointer is instant, while writing
potentially hundreds of megabytes may take significiant time. As the
functions may be called from random contexts, the increased time may
become a problem.

> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/btrfs/zoned.c | 68 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 63 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 3023c871e..805aeaa76 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -760,11 +760,44 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
>  	return 0;
>  }
>  
> +static int fill_sb_wp_offset(struct block_device *bdev, struct blk_zone *zone,
> +			     int mirror, u64 *wp_ret)
> +{
> +	u64 offset = 0;
> +	int ret = 0;
> +
> +	ASSERT(!is_power_of_two_u64(zone->len));
> +	ASSERT(zone->wp == zone->start);
> +	ASSERT(mirror != 0);

This could simply accept 0 as the mirror offset too, the calculation is
trivial.

> +
> +	switch (mirror) {
> +	case 1:
> +		div64_u64_rem(BTRFS_SB_LOG_FIRST_OFFSET >> SECTOR_SHIFT,
> +			      zone->len, &offset);
> +		break;
> +	case 2:
> +		div64_u64_rem(BTRFS_SB_LOG_SECOND_OFFSET >> SECTOR_SHIFT,
> +			      zone->len, &offset);
> +		break;
> +	}
> +
> +	ret =  blkdev_issue_zeroout(bdev, zone->start, offset, GFP_NOFS, 0);
> +	if (ret)
> +		return ret;
> +
> +	zone->wp += offset;
> +	zone->cond = BLK_ZONE_COND_IMP_OPEN;
> +	*wp_ret = zone->wp << SECTOR_SHIFT;
> +
> +	return 0;
> +}
> +
>  static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
> -			   int rw, u64 *bytenr_ret)
> +			   int rw, int mirror, u64 *bytenr_ret)
>  {
>  	u64 wp;
>  	int ret;
> +	bool zones_empty = false;
>  
>  	if (zones[0].type == BLK_ZONE_TYPE_CONVENTIONAL) {
>  		*bytenr_ret = zones[0].start << SECTOR_SHIFT;
> @@ -775,13 +808,31 @@ static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
>  	if (ret != -ENOENT && ret < 0)
>  		return ret;
>  
> +	if (ret == -ENOENT)
> +		zones_empty = true;
> +
>  	if (rw == WRITE) {
>  		struct blk_zone *reset = NULL;
> +		bool is_sb_offset_write_req = false;
> +		u32 reset_zone_nr = -1;
>  
> -		if (wp == zones[0].start << SECTOR_SHIFT)
> +		if (wp == zones[0].start << SECTOR_SHIFT) {
>  			reset = &zones[0];
> -		else if (wp == zones[1].start << SECTOR_SHIFT)
> +			reset_zone_nr = 0;
> +		} else if (wp == zones[1].start << SECTOR_SHIFT) {
>  			reset = &zones[1];
> +			reset_zone_nr = 1;
> +		}
> +
> +		/*
> +		 * Non po2 zone sizes will not align naturally at
> +		 * mirror 1 (512GB) and mirror 2 (4TB). The wp of the
> +		 * 1st zone in those superblock mirrors need to be
> +		 * moved to align at those offsets.
> +		 */

Please move this comment to the helper fill_sb_wp_offset itself, there
it's more discoverable.

> +		is_sb_offset_write_req =
> +			(zones_empty || (reset_zone_nr == 0)) && mirror &&
> +			!is_power_of_2(zones[0].len);

Accepting 0 as the mirror number would also get rid of this wild
expression substituting and 'if'.

>  
>  		if (reset && reset->cond != BLK_ZONE_COND_EMPTY) {
>  			ASSERT(sb_zone_is_full(reset));
> @@ -795,6 +846,13 @@ static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
>  			reset->cond = BLK_ZONE_COND_EMPTY;
>  			reset->wp = reset->start;
>  		}
> +
> +		if (is_sb_offset_write_req) {

And get rid of the conditional. The point of supporting both po2 and
nonpo2 is to hide any implementation details to wrappers as much as
possible.

> +			ret = fill_sb_wp_offset(bdev, &zones[0], mirror, &wp);
> +			if (ret)
> +				return ret;
> +		}
> +
>  	} else if (ret != -ENOENT) {
>  		/*
>  		 * For READ, we want the previous one. Move write pointer to
