Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382E37BBEAC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 20:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjJFSZ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 14:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbjJFSZ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:25:57 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8491C5;
        Fri,  6 Oct 2023 11:25:55 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-694ed847889so2152347b3a.2;
        Fri, 06 Oct 2023 11:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696616755; x=1697221555;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iv3KgntYn9lggjFQKUzveA+jkjlQSG9mEuEU5yiHVZk=;
        b=HsNDXRcpK1Ff8DP+3eZLu7+3M9dWU5Fn9FnlOlsYkrnQ/pZCtla7dqxYQX4IICCOgR
         trhngSv93jGOG5QIIhVtTIlGZ5CoJRyO7XJUl+UenGbtVhYRQOeeTRHkgm+GYn6CK6E2
         ED0xp9pGV7vMUfCcnXcbewMe0beg6unrgu2g/cT0QAsdzWqrpFJGMXHjSNiXjOLzd5cq
         bkcA67DjHsG9p1NB0KAsrt0JWpRqEO0s8ONisHFivavu72Up7DM2GgrOAbiCMivvWRiU
         MsPvmKZsVHL7b1Gw3D1LcYnSWl+5bnWLYoTD5RSWZReugdUnfRHzHxNwlxPzdoBnMV5M
         hYbQ==
X-Gm-Message-State: AOJu0YyHs0XZEQAWerUB56T9C8wFme6huRoRqIWbax1gsOYXsvswmQk2
        eEHf6PpFTFrdoQkAh9poigw=
X-Google-Smtp-Source: AGHT+IGz7uVIHdR69jfIbpWHn2kf+m6v43EfPuPpW2crv1gCimrngYwG/vXSNrG0HAmrBdlRJ56rrA==
X-Received: by 2002:a05:6a21:778c:b0:16c:bb6b:3303 with SMTP id bd12-20020a056a21778c00b0016cbb6b3303mr634102pzc.7.1696616755058;
        Fri, 06 Oct 2023 11:25:55 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ebdb:ae30:148c:2f33? ([2620:15c:211:201:ebdb:ae30:148c:2f33])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902bcc100b001bf8779e051sm4180692pls.289.2023.10.06.11.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 11:25:54 -0700 (PDT)
Message-ID: <94c35731-3d6f-4e50-80c2-e8a3a1ab02a1@acm.org>
Date:   Fri, 6 Oct 2023 11:25:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] blk-ioprio: Modify fewer bio->bi_ioprio bits
Content-Language: en-US
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Bean Huo <huobean@gmail.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Damien Le Moal <dlemoal@kernel.org>
References: <20231005194129.1882245-1-bvanassche@acm.org>
 <CGME20231005194154epcas5p2060a3b8cc46eee71e6dd73f1a8b20ab4@epcas5p2.samsung.com>
 <20231005194129.1882245-3-bvanassche@acm.org>
 <20231006063640.GB3862@green245>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231006063640.GB3862@green245>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/5/23 23:36, Kanchan Joshi wrote:
> On Thu, Oct 05, 2023 at 12:40:48PM -0700, Bart Van Assche wrote:
>> A later patch will store the data lifetime in the bio->bi_ioprio member
>> before the blk-ioprio policy is applied. Make sure that this policy 
>> doesn't
>> clear more bits than necessary.
>>
>> Cc: Damien Le Moal <dlemoal@kernel.org>
>> Cc: Niklas Cassel <niklas.cassel@wdc.com>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>> block/blk-ioprio.c | 9 +++++----
>> 1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
>> index 4051fada01f1..2db86f153b6d 100644
>> --- a/block/blk-ioprio.c
>> +++ b/block/blk-ioprio.c
>> @@ -202,7 +202,8 @@ void blkcg_set_ioprio(struct bio *bio)
>>          * to achieve this.
>>          */
>>         if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) != IOPRIO_CLASS_RT)
>> -            bio->bi_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_RT, 4);
>> +            ioprio_set_class_and_level(&bio->bi_ioprio,
>> +                    IOPRIO_PRIO_VALUE(IOPRIO_CLASS_RT, 4));
>>         return;
>>     }
>>
>> @@ -213,10 +214,10 @@ void blkcg_set_ioprio(struct bio *bio)
>>      * If the bio I/O priority equals IOPRIO_CLASS_NONE, the cgroup I/O
>>      * priority is assigned to the bio.
>>      */
>> -    prio = max_t(u16, bio->bi_ioprio,
>> +    prio = max_t(u16, bio->bi_ioprio & IOPRIO_CLASS_LEVEL_MASK,
>>             IOPRIO_PRIO_VALUE(blkcg->prio_policy, 0));
> 
> All 9 bits (including CDL) are not taking part in this decision making
> now. Maybe you want to exclude only lifetime bits.
> 
>> -    if (prio > bio->bi_ioprio)
>> -        bio->bi_ioprio = prio;
>> +    if (prio > (bio->bi_ioprio & IOPRIO_CLASS_LEVEL_MASK))
>> +        ioprio_set_class_and_level(&bio->bi_ioprio, prio);
> 
> Same as above.

Hi Kanchan,

It is intentional that the CDL bits are left out from these decisions.
I think the decisions made in this policy should be based on the I/O
priority class and level only and not on the CDL value.

Thanks,

Bart.
