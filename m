Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A9251A945
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 19:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbiEDRRV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 13:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358585AbiEDRQG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 13:16:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F075710A;
        Wed,  4 May 2022 09:59:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 05D4C1F38D;
        Wed,  4 May 2022 16:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651683564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M1ynRfy64oEaE99W0U91GV/hoBams4/1nT+NWTxLCsQ=;
        b=VZGykHrH9PSSMgqK3hTmF/6zr3BJ3r3B/lG2XoRcFarNlsb/YW5bqy8ilEs97wwjL1s/by
        uQWFvneQbmtBuHorjcpfFghMBC+GVahCikUCeLwl0TDEWnUgTGGGbzLXWJfq6GdAZHyoAa
        +0itVKDGQrfcvFgmZECSat5xUndy+s4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651683564;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M1ynRfy64oEaE99W0U91GV/hoBams4/1nT+NWTxLCsQ=;
        b=elgT1gUr+0HktGbv9ZyMUBY/unTN/FjM/WgdHkUif2R6BqksXsKIK/Md76HAEnamyrrTjH
        k6sfByfmM6Ww0uAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6239E131BD;
        Wed,  4 May 2022 16:59:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jR9TC+awcmJ8VgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 04 May 2022 16:59:18 +0000
Message-ID: <c76334a9-3d10-ed3c-f4d1-d856f67928e6@suse.de>
Date:   Wed, 4 May 2022 09:59:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 04/16] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Content-Language: en-US
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160300eucas1p1470fe30535849de6204bb78d7083cb3a@eucas1p1.samsung.com>
 <20220427160255.300418-5-p.raghav@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
To:     undisclosed-recipients:;
In-Reply-To: <20220427160255.300418-5-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/27/22 09:02, Pankaj Raghav wrote:
> Convert the calculations on zone size to be generic instead of relying on
> power_of_2 based logic in the block layer using the helpers wherever
> possible.
> 
> The only hot path affected by this change for power_of_2 zoned devices
> is in blk_check_zone_append() but the effects should be negligible as the
> helper blk_queue_zone_aligned() optimizes the calculation for those
> devices. Note that the append path cannot be accessed by direct raw access
> to the block device but only through a filesystem abstraction.
> 
> Finally, remove the check for power_of_2 zone size requirement in
> blk-zoned.c
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   block/blk-core.c  |  3 +--
>   block/blk-zoned.c | 12 ++++++------
>   2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 937bb6b86331..850caf311064 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -634,8 +634,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>   		return BLK_STS_NOTSUPP;
>   
>   	/* The bio sector must point to the start of a sequential zone */
> -	if (pos & (blk_queue_zone_sectors(q) - 1) ||
> -	    !blk_queue_zone_is_seq(q, pos))
> +	if (!blk_queue_zone_aligned(q, pos) || !blk_queue_zone_is_seq(q, pos))
>   		return BLK_STS_IOERR;
>   
>   	/*
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 1dff4a8bd51d..f7c7c3bd148d 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -288,10 +288,10 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
>   		return -EINVAL;
>   
>   	/* Check alignment (handle eventual smaller last zone) */
> -	if (sector & (zone_sectors - 1))
> +	if (!blk_queue_zone_aligned(q, sector))
>   		return -EINVAL;
>   
> -	if ((nr_sectors & (zone_sectors - 1)) && end_sector != capacity)
> +	if (!blk_queue_zone_aligned(q, nr_sectors) && end_sector != capacity)
>   		return -EINVAL;
>   
>   	/*
> @@ -489,14 +489,14 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
>   	 * smaller last zone.
>   	 */
>   	if (zone->start == 0) {
> -		if (zone->len == 0 || !is_power_of_2(zone->len)) {
> -			pr_warn("%s: Invalid zoned device with non power of two zone size (%llu)\n",
> -				disk->disk_name, zone->len);
> +		if (zone->len == 0) {
> +			pr_warn("%s: Invalid zoned device size",
> +				disk->disk_name);
>   			return -ENODEV;
>   		}
>   
>   		args->zone_sectors = zone->len;
> -		args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
> +		args->nr_zones = div64_u64(capacity + zone->len - 1, zone->len);

This is a different calculation than the one you're using in the first 
patch. Can you please add a helper such that both are using the same 
calculation?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
