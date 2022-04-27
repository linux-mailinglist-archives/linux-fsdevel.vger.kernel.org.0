Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4696B5127D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 01:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiD0X5U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 19:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiD0X5M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 19:57:12 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EBC264D;
        Wed, 27 Apr 2022 16:54:00 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id o69so1417073pjo.3;
        Wed, 27 Apr 2022 16:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t4qis+J9QIOKnM3fbYktt9NFhZKrRI7DhwX8G2bL9zc=;
        b=On2H6CsuJv+tmIz+9ADRj2NccrHplcElyL0ao8xw5b14OeACByx6gI5SmyLkcsqaP5
         YKC+WJf4QLbHLbjCj1BrrvpH4a6h9Il8AYLNHX9DcUrnV0+PB5Z1kjhkaFr3RyQ9cuda
         LuyJL2BZEiM73nQO0vhov+/DIdUQUDvr+Md9uuQdJHtTh+h1PJIMeU2F4LiSC0SzVRiF
         9ZmZ8bc3wZGEMRN2VVvRqZv3egZH/ogTi0q5bGbnmEGJeCGzKOXYicWJe/Xq5JKRBxSr
         OVD8ZbWk26CGnI3i9+ggLlgwJxPl0/2kybItNT2/6IdqOtsxqAH5FWeNujSCofpHzEuD
         A1OA==
X-Gm-Message-State: AOAM530sAwTpnEaRgeRDC+/2oh1WoTDJlBN+dr/Ezr0CPDNv0LqGC5xz
        bSkuXlF1Y2ZRbyYHgx+0zqE=
X-Google-Smtp-Source: ABdhPJzohQgvyNpdAnb7nqeKJuNjp6awQ1YNHqFULIu63hwwYMU72SrE0583NaL55rzyxWBEIH5+Qg==
X-Received: by 2002:a17:902:cf0b:b0:151:9d28:f46f with SMTP id i11-20020a170902cf0b00b001519d28f46fmr30536375plg.53.1651103639942;
        Wed, 27 Apr 2022 16:53:59 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6cbb:d78e:9b3:bb62? ([2620:15c:211:201:6cbb:d78e:9b3:bb62])
        by smtp.gmail.com with ESMTPSA id p125-20020a62d083000000b0050d475ed4d2sm10860790pfg.197.2022.04.27.16.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 16:53:59 -0700 (PDT)
Message-ID: <bc18532b-a98f-26f2-4dd1-d189c0415820@acm.org>
Date:   Wed, 27 Apr 2022 16:53:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 03/16] block: add bdev_zone_no helper
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
 <CGME20220427160259eucas1p25aab0637fec229cd1140e6aa08678f38@eucas1p2.samsung.com>
 <20220427160255.300418-4-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220427160255.300418-4-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/27/22 09:02, Pankaj Raghav wrote:
> +static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
> +{
> +	struct request_queue *q = bdev_get_queue(bdev);
> +
> +	if (q)
> +		return blk_queue_zone_no(q, sec);
> +	return 0;
> +}

This patch series has been split incorrectly: the same patch that 
introduces a new function should also introduce a caller to that function.

Thanks,

Bart.
