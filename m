Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986B47B5841
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 18:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238233AbjJBQd2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 12:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238242AbjJBQd2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:33:28 -0400
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CCDD7;
        Mon,  2 Oct 2023 09:33:25 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-584bfb14c59so6275440a12.0;
        Mon, 02 Oct 2023 09:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696264405; x=1696869205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLWLooNshpGbrVL5K+U2B+EPEwmTq++KRvDLzKnG2vI=;
        b=WlQJYGvIRGSuPd/oVEklV3jzPVUrJdGagRtAQnXwqUaEEyKp9xVsKwXHqx/YzuJX9e
         10rvMBaCKoGyjqvF9Lp0fJhD7a//aWETS8jli8eeThDMQ4emXUbu9Nc2oCkmPCTABEMi
         q5Z8a6PEUOJQ1OXUD84SG8ZKEr+zAZkNDUfYrAqrpWumHJRx6tzyPN6qzpRNU9vg+dKN
         bPIXgv98Oyp+c6EwyVFUJeiEQHGAq4J5clzp/zJOSMxbWuSWgVsVcRSl2xay81yugwPu
         Li7aTdbqik9SQPBXzZcHUzl+4ABJK+ZDNzvO43kgK7I65sfmT3QMx5Hxv+hsbGpzSxlW
         cDTQ==
X-Gm-Message-State: AOJu0Ywj09u3bnvP/s4VTCuVQWa2gwiCw+C26cwSIwAse+SXveONiGwU
        JL2seRycVYkvyua1dLxRncwQxgGrZ/o=
X-Google-Smtp-Source: AGHT+IFCvtQNbCCH6oliov0izo80b9lr4Qjw1SlfnknH4k/FId2sP98AlUjwv4aKBzJgtsRuOjziLw==
X-Received: by 2002:a17:90a:fa49:b0:276:caee:db4d with SMTP id dt9-20020a17090afa4900b00276caeedb4dmr9148397pjb.10.1696264404877;
        Mon, 02 Oct 2023 09:33:24 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6ad7:f663:5f97:db57? ([2620:15c:211:201:6ad7:f663:5f97:db57])
        by smtp.gmail.com with ESMTPSA id g6-20020a17090a67c600b0026b3f76a063sm6310398pjm.44.2023.10.02.09.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 09:33:24 -0700 (PDT)
Message-ID: <2fb20f41-ff84-4622-9d7c-7e88ff296509@acm.org>
Date:   Mon, 2 Oct 2023 09:33:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] Pass data temperature information to zoned UFS
 devices
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <yq1o7hnzbsy.fsf@ca-mkp.ca.oracle.com> <ZRqrl7+oopXnn8r5@x1-carbon>
 <ZRqvJsF6s5OrFlC4@x1-carbon>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZRqvJsF6s5OrFlC4@x1-carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/2/23 04:53, Niklas Cassel wrote:
> On Mon, Oct 02, 2023 at 01:37:59PM +0200, Niklas Cassel wrote:
>> I don't know which user facing API Martin's I/O hinting series is intending
>> to use.
>>
>> However, while discussing this series at ALPSS, we did ask ourselves why this
>> series is not reusing the already existing block layer API for providing I/O
>> hints:
>> https://github.com/torvalds/linux/blob/v6.6-rc4/include/uapi/linux/ioprio.h#L83-L103
>>
>> We can have 1023 possible I/O hints, and so far we are only using 7, which
>> means that there are 1016 possible hints left.
>> This also enables you to define more than the 4 previous temperature hints
>> (extreme, long, medium, short), if so desired.
>>
>> There is also support in fio for these I/O hints:
>> https://github.com/axboe/fio/blob/master/HOWTO.rst?plain=1#L2294-L2302
>>
>> When this new I/O hint API has added, there was no other I/O hint API
>> in the kernel (since the old fcntl() F_GET_FILE_RW_HINT / F_SET_FILE_RW_HINT
>> API had already been removed when this new API was added).
>>
>> So there should probably be a good argument why we would want to introduce
>> yet another API for providing I/O hints, instead of extending the I/O hint
>> API that we already have in the kernel right now.
>> (Especially since it seems fairly easy to modify your patches to reuse the
>> existing API.)
> 
> One argument might be that the current I/O hints API does not allow hints to
> be stacked. So one would not e.g. be able to combine a command duration limit
> with a temperature hint...

Hi Niklas,

Is your feedback about the user space API only or also about the
mechanism that is used internally in the kernel?

Restoring the ability to pass data temperature information from a
filesystem to a block device is much more important to me than
restoring the ability to pass data temperature information from user
space to a filesystem. Would it be sufficient to address your concern
if patch 2/13 would be dropped from this series?

Thanks,

Bart.

