Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3254951AAE3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 19:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245582AbiEDRgJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 13:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359048AbiEDRfk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 13:35:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2BE5BE71;
        Wed,  4 May 2022 10:04:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 54385210E6;
        Wed,  4 May 2022 17:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651683831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r48NN8K17+Vaycp2fcoUaY8PZRHqW5yBueK7iYcVfJY=;
        b=u0Oe4gfc1OhFZsT1UUyMuMt08draDSwEqD3AdD9jt9/qwYg9acWkqsrrpzW0WvJ4UDM6lE
        fFO3SASX2LtgEe4r0IVMUg78LBBRhVHEBvaFggznA1XDSGAr3gl99IR6AeUBYaOZFdVTnh
        MsqkFs2WaX9f9VkewxprCasGCDulyqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651683831;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r48NN8K17+Vaycp2fcoUaY8PZRHqW5yBueK7iYcVfJY=;
        b=WL7Mwjzvc7qZd7CxcdYyzSZtHL135g1bMXjbrTJTi51amF5aezAaa5HJ0UGqmtv/m5zq6L
        MC+BAh7W/YAJU5Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A3897131BD;
        Wed,  4 May 2022 17:03:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ob9+GvGxcmJMWAAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 04 May 2022 17:03:45 +0000
Message-ID: <6a1c06e8-bedd-47b0-2a3f-9c51468fc029@suse.de>
Date:   Wed, 4 May 2022 10:03:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 05/16] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Content-Language: en-US
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160301eucas1p147d0dced70946e20dd2dd046b94b8224@eucas1p1.samsung.com>
 <20220427160255.300418-6-p.raghav@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
To:     undisclosed-recipients:;
In-Reply-To: <20220427160255.300418-6-p.raghav@samsung.com>
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
> Remove the condition which disallows non-power_of_2 zone size ZNS drive
> to be updated and use generic method to calculate number of zones
> instead of relying on log and shift based calculation on zone size.
> 
> The power_of_2 calculation has been replaced directly with generic
> calculation without special handling. Both modified functions are not
> used in hot paths, they are only used during initialization &
> revalidation of the ZNS device.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   drivers/nvme/host/zns.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 9f81beb4df4e..2087de0768ee 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -101,13 +101,6 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>   	}
>   
>   	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
> -	if (!is_power_of_2(ns->zsze)) {
> -		dev_warn(ns->ctrl->device,
> -			"invalid zone size:%llu for namespace:%u\n",
> -			ns->zsze, ns->head->ns_id);
> -		status = -ENODEV;
> -		goto free_data;
> -	}
>   
>   	blk_queue_set_zoned(ns->disk, BLK_ZONED_HM);
>   	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
> @@ -129,7 +122,7 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
>   				   sizeof(struct nvme_zone_descriptor);
>   
>   	nr_zones = min_t(unsigned int, nr_zones,
> -			 get_capacity(ns->disk) >> ilog2(ns->zsze));
> +			 div64_u64(get_capacity(ns->disk), ns->zsze));
>   
Same here; please add a helper calculating the number of zones for a 
given disk.

>   	bufsize = sizeof(struct nvme_zone_report) +
>   		nr_zones * sizeof(struct nvme_zone_descriptor);
> @@ -197,7 +190,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>   	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
>   	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
>   
> -	sector &= ~(ns->zsze - 1);
> +	sector = rounddown(sector, ns->zsze);
>   	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
>   		memset(report, 0, buflen);
>   
Please be a bit more consistent. In the previous patches you always had 
a condition to check if it's a power_of_2 zone size, but here you are 
using the same calculation for each disk.
So please use the check in all locations, or add a comment why the 
generic calculation is okay to use here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
