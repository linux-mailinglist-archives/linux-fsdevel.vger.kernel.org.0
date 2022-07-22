Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AFB57E95F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 23:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbiGVV5m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 17:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbiGVV5h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:57:37 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD672228D;
        Fri, 22 Jul 2022 14:57:36 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id c3so5486706pfb.13;
        Fri, 22 Jul 2022 14:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qXu4wByl3BNt6KU2i2QS6R/HX8NK9Bf8G0fHZSeWoO0=;
        b=OsmxG0MkbqjAOnD8pIgAqfklkpl/mExxo/1bKWUKqT6C3f501YkLTUrmiY/rgFOd9s
         HF3e2Z7NLiSKTBdjx1dW6bwBfQgn6evE8t3kcJE4x8Vxhk8T5mixfhWVb7pgqRo5ucDy
         9o6JgbTtcQ4z2oKch+L5DFa90pHqfyU1CzcPktf1zoqRKkmvR8y5c7xFJd4XG2BgSXH+
         ANhODcRk7TfgZi2Oyv31EiB3nXGGduGYDIUgg6y4kSaENiUJYqrlDGxcaBfVS4x0Q7JL
         WbXpehCXXpzyWjyLWwnpsAuN3j6RD8yhhikMkWTUh1J+Br1ZL06oOMBXwfwQETHLkB7p
         BMPQ==
X-Gm-Message-State: AJIora8yGZauHq/Su7ZiVHv7d8ZjiQV52CmB9fGae+SNj1il8QbGwC+4
        uW0LoYPzIitfHcjCmMzoqd4=
X-Google-Smtp-Source: AGRyM1ukyOum94MdofNYY6U4MtoZeA7vHPBGYc6T0YvwjrcvsfjN3FvwwgI+gwOhsG6F1VtI15Nquw==
X-Received: by 2002:aa7:8c55:0:b0:52b:7233:f7b1 with SMTP id e21-20020aa78c55000000b0052b7233f7b1mr1813672pfd.33.1658527056052;
        Fri, 22 Jul 2022 14:57:36 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:805b:3c64:6a1f:424c? ([2620:15c:211:201:805b:3c64:6a1f:424c])
        by smtp.gmail.com with ESMTPSA id 6-20020a620606000000b005255489187fsm4431978pfg.135.2022.07.22.14.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 14:57:35 -0700 (PDT)
Message-ID: <ed4e63b3-3fd3-ba78-ebd0-69034f703032@acm.org>
Date:   Fri, 22 Jul 2022 14:57:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv6 06/11] block/merge: count bytes instead of sectors
Content-Language: en-US
To:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        damien.lemoal@opensource.wdc.com, ebiggers@kernel.org,
        pankydev8@gmail.com, Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
 <20220610195830.3574005-7-kbusch@fb.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220610195830.3574005-7-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/10/22 12:58, Keith Busch wrote:
> @@ -269,8 +269,8 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>   {
>   	struct bio_vec bv, bvprv, *bvprvp = NULL;
>   	struct bvec_iter iter;
> -	unsigned nsegs = 0, sectors = 0;
> -	const unsigned max_sectors = get_max_io_size(q, bio);
> +	unsigned nsegs = 0, bytes = 0;
> +	const unsigned max_bytes = get_max_io_size(q, bio) << 9;

How about using SECTOR_SHIFT instead of 9?

Thanks,

Bart.
