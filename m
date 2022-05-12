Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E1652537E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 19:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356997AbiELRWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 13:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356992AbiELRW2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 13:22:28 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB5A66AF6;
        Thu, 12 May 2022 10:22:26 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso8459933pjb.1;
        Thu, 12 May 2022 10:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5EH2eizEJHj786C4i7iVooWJ/uE/QSj7BBR5bCHBing=;
        b=1PFeuc56IeMf5lH0ePlwRZL1gyOO8WGy7nV7hybICwqSHHF/zBtu3v8EhKou9vg4AP
         RikhnfvnWIdVt6FFjmv1eXUqKnqnDNnnPBX092IPR1gDYjhjNVUzNl8YEIcCRyBInV3S
         Tsx/q44i884cS688y9kyeNsx5dke+1TN7wW3OG9tJQn2cHxCUkdxnN7YUakfUYd1wdXX
         6dX8m9/1lajNdjXmNukJYwzfohhg/HiQycIGfP3bj5B7J/5LHzRfg9G000T5VnMNzzBG
         4fUQRuhTMbKaJkZ+EBRkpGVrVptiiBmRsOeKw/MnwcwtiAm0jQvME0wRzfaZvJzPLtTr
         mxTg==
X-Gm-Message-State: AOAM5338mmL6w4SAZr9uS5gE0OY/dSmwQSKdkvqxMMi0eGp/jpiRKFAp
        H4b94YE471/2PET1es/GYDQ=
X-Google-Smtp-Source: ABdhPJygkMTlAbNp9soO/418oUT6tIypetUTVmiczgfvtfjDYTiV1B21f/kf4VZ7nutFi/2LHDujOg==
X-Received: by 2002:a17:903:230e:b0:15e:ce57:d66f with SMTP id d14-20020a170903230e00b0015ece57d66fmr874623plh.35.1652376146314;
        Thu, 12 May 2022 10:22:26 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:78c5:5d65:4254:a5e? ([2620:15c:211:201:78c5:5d65:4254:a5e])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902cec200b0015e8d4eb2ddsm121808plg.295.2022.05.12.10.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 10:22:25 -0700 (PDT)
Message-ID: <b14775a9-da39-f26a-fa46-b0b1b789c30e@acm.org>
Date:   Thu, 12 May 2022 10:22:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 10/11] null_blk: allow non power of 2 zoned devices
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        jaegeuk@kernel.org, hare@suse.de, dsterba@suse.com,
        axboe@kernel.dk, hch@lst.de, snitzer@kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
        Jens Axboe <axboe@fb.com>, gost.dev@samsung.com,
        jonathan.derrick@linux.dev, jiangbo.365@bytedance.com,
        linux-nvme@lists.infradead.org, dm-devel@redhat.com,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alasdair Kergon <agk@redhat.com>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch <kbusch@kernel.org>, linux-btrfs@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220506081105.29134-1-p.raghav@samsung.com>
 <CGME20220506081116eucas1p2cce67bbf30f4c9c4e6854965be41b098@eucas1p2.samsung.com>
 <20220506081105.29134-11-p.raghav@samsung.com>
 <39a80347-af70-8af0-024a-52f92e27a14a@opensource.wdc.com>
 <aef68bcf-4924-8004-3320-325e05ca9b20@samsung.com>
 <9eb00b42-ca5b-c94e-319d-a0e102b99f02@opensource.wdc.com>
 <9f1385a3-b471-fcd9-2c0c-61f544fbc855@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <9f1385a3-b471-fcd9-2c0c-61f544fbc855@samsung.com>
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

On 5/9/22 04:56, Pankaj Raghav wrote:
> Even though I am not sure if this optimization will directly add value
> looking at my experiments with the current change, I can fold this in
> with a comment on top of zone_size_sect_shifts variable stating that
> size can be npo2 and this variable is only meaningful for the po2 size
> scenario.

Have these experiments perhaps been run on an x86_64 CPU? These CPUs 
only need a single instruction to calculate ilog2(). No equivalent of 
that instruction is available on ARM CPUs as far as I know. I think the 
optimization Damien proposed will help on ARM CPUs.

Thanks,

Bart.
