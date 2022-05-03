Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89648518AA5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 19:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240002AbiECRFX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 13:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbiECRFW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 13:05:22 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B712628;
        Tue,  3 May 2022 10:01:50 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id q8so18372494oif.13;
        Tue, 03 May 2022 10:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DRk7BATbee0He7UZ5VJP77cBX11TJXZ34BYAwZ+8AgM=;
        b=xhLa9QqEPnziJXmsQV5gNVVce3r4YwzVcLNtv7st/OVFj/svHhnWqVllllhAoLtxiJ
         w8cxZvVQh/RWTGE+pJqX6+IoUUdQQpk0IkT0RD85+RMG0tfFPFs0srokLEBWG8iFY93p
         ANA5hDAIrqZAjcG/Cm3owfUXUJIqcC+u2ifdwdEOuMV1dImS1UGjSbjMcYyU70ACPW2d
         ysPQVO+zv7WLk72XU3AJXX4nJIyLDurS2vGFEEEVkQhp/hwFQYzZ2/r34im4gpumeBNy
         z9bNK0aJNAuI1pV7D0A5bA8eTUaAabqXPqYIvLLG08ydsNbiy+bnCOeQHxFvVR3WQ9w+
         WtKw==
X-Gm-Message-State: AOAM5336ea5EtQg0xXs9foz3ff+lIVipPp6z19JyqfTwbmmdKnopw6/k
        XPdSVipkF7xdVGAok2wkcNk=
X-Google-Smtp-Source: ABdhPJzQ7nN1tdLufKhuqG6pqOb+aTzQGH1sI9Wd1lN/gZWKJGxCZu7MZvXiQsv6VotmI9tLD36qJQ==
X-Received: by 2002:a05:6808:1b10:b0:326:40f5:930c with SMTP id bx16-20020a0568081b1000b0032640f5930cmr840804oib.281.1651597309459;
        Tue, 03 May 2022 10:01:49 -0700 (PDT)
Received: from [10.10.69.251] ([8.34.116.185])
        by smtp.gmail.com with ESMTPSA id a8-20020a4ad5c8000000b0035eb4e5a6c6sm5071917oot.28.2022.05.03.10.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 10:01:48 -0700 (PDT)
Message-ID: <1b7f3aac-0941-2554-d966-01a6bf76cc58@acm.org>
Date:   Tue, 3 May 2022 10:01:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 13/16] null_blk: allow non power of 2 zoned devices
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
 <CGME20220427160310eucas1p28cd3c5ff4fb7a04bc77c4c0b9d96bb74@eucas1p2.samsung.com>
 <20220427160255.300418-14-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220427160255.300418-14-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/27/22 09:02, Pankaj Raghav wrote:
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index c441a4972064..82a62b543782 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1931,8 +1931,8 @@ static int null_validate_conf(struct nullb_device *dev)
>   		dev->mbps = 0;
>   
>   	if (dev->zoned &&
> -	    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {
> -		pr_err("zone_size must be power-of-two\n");
> +	    (!dev->zone_size)) {
> +		pr_err("zone_size must not be zero\n");
>   		return -EINVAL;
>   	}

Please combine "if (dev->zoned &&" and "(!dev->zone_size)) {" into a 
single line and leave out the parentheses that became superfluous.

Thanks,

Bart.
