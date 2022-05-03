Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2DA518A20
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 18:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbiECQlg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 12:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiECQlf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 12:41:35 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036F927B1E;
        Tue,  3 May 2022 09:38:03 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id x23so9876327pff.9;
        Tue, 03 May 2022 09:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lyBgny2owanKpSK297XC+SuygGQevv1e+zn1E24si/Y=;
        b=2Ko6L0/mzFJEtxbkBdzRf2vCID52PKDCmVCoHfw6K3sCY9bCL53mEHbmDFqtQdVbdj
         i+H1EVTSfiyHCHIhXWrYuGm6aNKJfkP00t1b0rJROORk8PTONFy2L7KYYI511/n60Wkj
         S4RIbSjREb2OvJcpPL1IDl6p1B/UoXvVySMFjdrE/Vr23Tq0OEzJTGw2y2sBfvV4K0MO
         17AyHYrKQRBCaoqrgP75SbBOrkd3R/1fPWbzo7arqnvuDloyt149j/A32ev5caKZxo5V
         FtGG4WaMTcQxL9A4UCM8eYnRGMAQgamfDu9SgYpFnJBitH6gG4GoS59aq3C59FHJVhlj
         tXTQ==
X-Gm-Message-State: AOAM5318ZFXqsrCb8Qzs4MXkq2Pf939JMMFC/vdz+VcrLfmXZN9DFx1I
        v2Nv3H9SzsH3Rm8IH6reZhU=
X-Google-Smtp-Source: ABdhPJzonovBzoV4fwi9NXoKhV1eYPIxcI7yjfJw6mLDHLxG6LjY81SsAeWrZCq7zhToKZSiSL9kvA==
X-Received: by 2002:a63:5020:0:b0:39e:5d26:4316 with SMTP id e32-20020a635020000000b0039e5d264316mr14532146pgb.294.1651595882292;
        Tue, 03 May 2022 09:38:02 -0700 (PDT)
Received: from [10.10.69.251] ([8.34.116.185])
        by smtp.gmail.com with ESMTPSA id u17-20020a170903125100b0015e8d4eb27bsm6564629plh.197.2022.05.03.09.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 09:38:01 -0700 (PDT)
Message-ID: <3a178153-62c0-e298-ccb0-0edfd41b7ee2@acm.org>
Date:   Tue, 3 May 2022 09:37:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 01/16] block: make blkdev_nr_zones and blk_queue_zone_no
 generic for npo2 zsze
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
        axboe@kernel.dk, snitzer@kernel.org, hch@lst.de, mcgrof@kernel.org,
        naohiro.aota@wdc.com, sagi@grimberg.me,
        damien.lemoal@opensource.wdc.com, dsterba@suse.com,
        johannes.thumshirn@wdc.com
Cc:     linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        clm@fb.com, gost.dev@samsung.com, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, josef@toxicpanda.com,
        jonathan.derrick@linux.dev, agk@redhat.com, kbusch@kernel.org,
        kch@nvidia.com, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, jiangbo.365@bytedance.com,
        linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
        linux-block@vger.kernel.org
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160257eucas1p21fb58d0129376a135fdf0b9c2fe88895@eucas1p2.samsung.com>
 <20220427160255.300418-2-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220427160255.300418-2-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/27/22 09:02, Pankaj Raghav wrote:
> Adapt blkdev_nr_zones and blk_queue_zone_no function so that it can
> also work for non-power-of-2 zone sizes.
> 
> As the existing deployments of zoned devices had power-of-2
> assumption, power-of-2 optimized calculation is kept for those devices.
> 
> There are no direct hot paths modified and the changes just
> introduce one new branch per call.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   block/blk-zoned.c      | 8 +++++++-
>   include/linux/blkdev.h | 8 +++++++-
>   2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 38cd840d8838..1dff4a8bd51d 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -117,10 +117,16 @@ EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
>   unsigned int blkdev_nr_zones(struct gendisk *disk)
>   {
>   	sector_t zone_sectors = blk_queue_zone_sectors(disk->queue);
> +	sector_t capacity = get_capacity(disk);
>   
>   	if (!blk_queue_is_zoned(disk->queue))
>   		return 0;
> -	return (get_capacity(disk) + zone_sectors - 1) >> ilog2(zone_sectors);
> +
> +	if (is_power_of_2(zone_sectors))
> +		return (capacity + zone_sectors - 1) >>
> +		       ilog2(zone_sectors);
> +
> +	return div64_u64(capacity + zone_sectors - 1, zone_sectors);
>   }
>   EXPORT_SYMBOL_GPL(blkdev_nr_zones);

Does anyone need support for more than 4 billion sectors per zone? If 
not, do_div() should be sufficient.

> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 60d016138997..c4e4c7071b7b 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -665,9 +665,15 @@ static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
>   static inline unsigned int blk_queue_zone_no(struct request_queue *q,
>   					     sector_t sector)
>   {
> +	sector_t zone_sectors = blk_queue_zone_sectors(q);
> +
>   	if (!blk_queue_is_zoned(q))
>   		return 0;
> -	return sector >> ilog2(q->limits.chunk_sectors);
> +
> +	if (is_power_of_2(zone_sectors))
> +		return sector >> ilog2(zone_sectors);
> +
> +	return div64_u64(sector, zone_sectors);
>   }

Same comment here.

Thanks,

Bart.
