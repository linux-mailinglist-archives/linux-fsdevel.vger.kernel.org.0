Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3456D5AE9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 10:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjDDI21 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 04:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbjDDI2N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:28:13 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF3C2D44;
        Tue,  4 Apr 2023 01:27:41 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id r29so31836849wra.13;
        Tue, 04 Apr 2023 01:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680596793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+IA0sfS8Hko6hpK1HZztJ6kiawc/hgiN78OoxbJlkE=;
        b=qPbXFAu3NFSUuePdXIGCFg7snbxm8fYqQcWtbEZPAtTwXRFsHR5/nTt+RGkYWnX7KI
         oexHfndDEqnQKxbeSDpaq4leGLariWGtraVXa13jQD4G/d8uyO6JX09NJ4B9SevsFoub
         NPTALWgkbG0Rx1jI0JZaLHT440ZD3sK/i2fDCwJDXAQo+xJYzXSZcmUK52nMxOZOk4aV
         5cX+ROXbMfTrFWytmTcVMOZ1K1fZYy9yIcrVJDEj0F3hFX0qhwAoR5qy2J8f44bSBbZW
         SGUhaENXwL02Y2bMsBBOeVU0eM+Ty94kSLr14hNrkJMD01GRBnppAnI4sc2xVElAy4AW
         d2HQ==
X-Gm-Message-State: AAQBX9cnktGdSw29EYqJZAvJFG//Bzppu87rjW/goEp3puGTrpPgjGQX
        BWxRFkQSQdkrmklGnithvv4=
X-Google-Smtp-Source: AKy350YRAl3M0jE5+UynIwckjiW+CsHm28SGM1LHNiMQ7J8tXe8xmw1F2qmXD/R4sfgmgOX6wBeBhg==
X-Received: by 2002:adf:e0c3:0:b0:2cf:e747:b0d4 with SMTP id m3-20020adfe0c3000000b002cfe747b0d4mr940685wri.40.1680596793398;
        Tue, 04 Apr 2023 01:26:33 -0700 (PDT)
Received: from [192.168.32.129] (aftr-82-135-86-174.dynamic.mnet-online.de. [82.135.86.174])
        by smtp.gmail.com with ESMTPSA id t6-20020a7bc3c6000000b003ee1b2ab9a0sm14294575wmj.11.2023.04.04.01.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 01:26:32 -0700 (PDT)
Message-ID: <bbc98aa3-24f0-8ee6-9d74-483564a14f0f@kernel.org>
Date:   Tue, 4 Apr 2023 10:26:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 17/19] md: raid1: check if adding pages to resync bio
 fails
To:     Song Liu <song@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <cover.1680172791.git.johannes.thumshirn@wdc.com>
 <8b8a3bb2db8c5183ef36c1810f2ac776ac526327.1680172791.git.johannes.thumshirn@wdc.com>
 <CAPhsuW7a+mpn+VprfA2mC5Fc+M9BFq8i6d-y+-o5G1u5dOsk2Q@mail.gmail.com>
Content-Language: en-US
From:   Johannes Thumshirn <jth@kernel.org>
In-Reply-To: <CAPhsuW7a+mpn+VprfA2mC5Fc+M9BFq8i6d-y+-o5G1u5dOsk2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 31/03/2023 20:13, Song Liu wrote:
> On Thu, Mar 30, 2023 at 3:44 AM Johannes Thumshirn
> <johannes.thumshirn@wdc.com> wrote:
>>
>> Check if adding pages to resync bio fails and if bail out.
>>
>> As the comment above suggests this cannot happen, WARN if it actually
>> happens.
>>
>> This way we can mark bio_add_pages as __must_check.
>>
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>   drivers/md/raid1-10.c |  7 ++++++-
>>   drivers/md/raid10.c   | 12 ++++++++++--
>>   2 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
>> index e61f6cad4e08..c21b6c168751 100644
>> --- a/drivers/md/raid1-10.c
>> +++ b/drivers/md/raid1-10.c
>> @@ -105,7 +105,12 @@ static void md_bio_reset_resync_pages(struct bio *bio, struct resync_pages *rp,
>>                   * won't fail because the vec table is big
>>                   * enough to hold all these pages
>>                   */
> 
> We know these won't fail. Shall we just use __bio_add_page?

We could yes, but I kind of like the assert() style warning.
But of cause ultimately your call.

Byte,
	Johannes
