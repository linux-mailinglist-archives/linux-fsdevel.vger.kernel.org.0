Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7685518A70
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 18:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239747AbiECQyX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 12:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239924AbiECQyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 12:54:15 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8292A260;
        Tue,  3 May 2022 09:50:42 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id s131so18777979oie.1;
        Tue, 03 May 2022 09:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XGyhawv5lvAz+jR7b+4J1tPg3EThTh3JtzLNgN/2cvM=;
        b=kmchxS1T8EtElDIuBlgG6CRTtdgaC80Ea3sZUIkx0Y9hrvMuae2gTkvupbJf5ed/Vy
         2pmSLvxLXkO1VxSMLsPD+fRPV4YKRX5ggfYrCQObD/yLNh7diR+79l1zPUR8r/oOMqbL
         6TY+TqKqM3gIDg80qJ6Q3EigDCDmj2SCaxWCGHac6uciYaRzo0dmBbMAHUx/bl1Z2FMN
         JNK75FN4FOn/e8ICY0hpIY8M2ry0lrWQVXVYvjXoLQAblErtDBVcntEPAQAy9/y7DqtS
         qkk8LOj8cBKa8XVwFL3s4NgO1gjJ8iMXF1vXhcUC0bkJKKRFxj3zToA9Pcs95gF3TTey
         FGZA==
X-Gm-Message-State: AOAM530t+lbhqj3y8RFKAwBKjgrH/CSmQXIZS1nGCfC/iubfypE/pf/e
        kfkrlmW3L3+U3I7yFhvMzKc=
X-Google-Smtp-Source: ABdhPJy1OCeyAd/qiMByFFTTxHMId2iF4W5yKbLjTMlEc1yur0rFxDRZF7LK/3VXrAqw2kuZPRsPmQ==
X-Received: by 2002:a05:6808:2126:b0:325:c9f5:46e1 with SMTP id r38-20020a056808212600b00325c9f546e1mr2356270oiw.239.1651596641690;
        Tue, 03 May 2022 09:50:41 -0700 (PDT)
Received: from [10.10.69.251] ([8.34.116.185])
        by smtp.gmail.com with ESMTPSA id v15-20020a4ae6cf000000b0035eb4e5a6cdsm5044278oot.35.2022.05.03.09.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 09:50:40 -0700 (PDT)
Message-ID: <1e3afa38-0652-0a6a-045c-79a0b9c19f30@acm.org>
Date:   Tue, 3 May 2022 09:50:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 05/16] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
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
 <CGME20220427160301eucas1p147d0dced70946e20dd2dd046b94b8224@eucas1p1.samsung.com>
 <20220427160255.300418-6-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220427160255.300418-6-p.raghav@samsung.com>
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
> -	sector &= ~(ns->zsze - 1);
> +	sector = rounddown(sector, ns->zsze);

The above change breaks 32-bit builds since ns->zsze is 64 bits wide and 
since rounddown() uses the C division operator instead of div64_u64().

Thanks,

Bart.
