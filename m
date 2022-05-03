Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0888518A84
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 18:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239897AbiECQ5w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 12:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiECQ5u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 12:57:50 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA082C124;
        Tue,  3 May 2022 09:54:18 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-e2442907a1so17750488fac.8;
        Tue, 03 May 2022 09:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1eh4gXcwKDJaVq28NyDGAP5u0RiukLhIIz4+qOM8ls8=;
        b=eBE/MIc/urfwsUyHWM/SS/WAID/KF8tIPcmeNSLdP9Em1tn51M75iLWcUnR/VklFgD
         EEdE1kq4NcFsnG4VBg+UNtLsw8ZnF9ZbiBtwKPf7lmPbPAAmZCYuSjETsKnIfnHIyKbv
         bwaxCyUG1oQGLtdEAN0q7v3KboKfBG9Lw3UqJ+b1gRKwnyVrp5f9oQ2gcbr9Z9JHFIXo
         SsI5IqnnyYO6pcBhtAJOWNtMzNHqFFJ5yZz8XQDW4vJ5k5bDbnMVL8wuS+pZcrMxeMGa
         DNDYkE3AsBp2HZYVxPl7hTu/1OMASOr7x6Ppk1IuTgYbN3GfurEIsO1kYfcoaptG4Ryi
         jGFA==
X-Gm-Message-State: AOAM533CVB8q60npEKO2xcIUl759sCCe822Ffjn0T84q43Xi1oJIw4oL
        4MAwwqhKntVFyq0kktHpKuI=
X-Google-Smtp-Source: ABdhPJwIYsdQ5p1P5Q1mznCaYxjTnd/hJJG6oVZ/Lc+drskzCLzSd9wtxgyiNOjNc1Eeeh2wyOvvEw==
X-Received: by 2002:a05:6870:b693:b0:de:7356:a3a3 with SMTP id cy19-20020a056870b69300b000de7356a3a3mr2077698oab.24.1651596857587;
        Tue, 03 May 2022 09:54:17 -0700 (PDT)
Received: from [10.10.69.251] ([8.34.116.185])
        by smtp.gmail.com with ESMTPSA id v186-20020aca61c3000000b00325cda1ffa1sm3506854oib.32.2022.05.03.09.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 09:54:16 -0700 (PDT)
Message-ID: <78730bd4-a184-e0f0-4634-d09dbaf59958@acm.org>
Date:   Tue, 3 May 2022 09:54:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 06/16] nvmet: use blk_queue_zone_no()
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
 <CGME20220427160302eucas1p1aaba7a309778d3440c3315ad899e4035@eucas1p1.samsung.com>
 <20220427160255.300418-7-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220427160255.300418-7-p.raghav@samsung.com>
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
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Instead of open coding the number of zones given a sector, use the helper
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
I can't parse this. Please rephrase this.

> blk_queue_zone_no(). This let's us make modifications to the math if
> needed in one place and adds now support for npo2 zone devices.

But since the code looks fine:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
