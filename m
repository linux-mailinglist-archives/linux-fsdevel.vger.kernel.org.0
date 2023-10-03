Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F537B6F22
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 18:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240541AbjJCQ6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 12:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240447AbjJCQ6g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:58:36 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0010EAF;
        Tue,  3 Oct 2023 09:58:31 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-279150bad13so846456a91.3;
        Tue, 03 Oct 2023 09:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696352311; x=1696957111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ph4ZyrbtQrh7wyzDZ9eyeUo8WfNuy38zu7LMXqicMgg=;
        b=g5MPi96d9Fhn/MZJuI3TeeXuwwBzvcaiF3z4jsroC5q10Kudb78d91oTgi/d/IbsEp
         V/hFFIxcWEh9R1eRUJEPrkm9/dxLC/lmX8ciLQbLH7TpasyOkIpGtogLRw7JrqKVE5zh
         G4za5TBCssIfjr7zGVQucYRhqKtCdfRBSg57Jo0yi7jVjKc0oRtRWcydJI4UegaqOk4K
         vHNBy0xNrjIOOh0pXQpt4Ghoy2hpPrI1Kp8Cay5cpdZ0SIKz7/Adx9Gu4F9bnImawKQT
         mYqX4vyVskcc5YWvoxOW5L/sbN6EdLv68wYJYkYkHa4sZgZfLQ5u3fg/nRcGbPNM0/nl
         n82A==
X-Gm-Message-State: AOJu0YzlFCnvDbbjsegtBm82BGApiOa1wEXMpaz3HfV0Q0RK0Ca0zMSb
        EkTxac0/RDk94YdvKtE3PGU=
X-Google-Smtp-Source: AGHT+IGQBlXYDBY7Pq4Ub5S8toLsTFGmr7CtYVutmPFo9OW0ks0zwF/l0SLYp82viXZAK3r8SsjQpA==
X-Received: by 2002:a17:90b:1186:b0:279:2dac:80b3 with SMTP id gk6-20020a17090b118600b002792dac80b3mr11928768pjb.44.1696352311335;
        Tue, 03 Oct 2023 09:58:31 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:fc96:5ba7:a6f5:b187? ([2620:15c:211:201:fc96:5ba7:a6f5:b187])
        by smtp.gmail.com with ESMTPSA id g6-20020a17090a300600b0027768125e24sm8260191pjb.39.2023.10.03.09.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 09:58:30 -0700 (PDT)
Message-ID: <c3130686-3e28-4ff0-af0d-560b0f4e7227@acm.org>
Date:   Tue, 3 Oct 2023 09:58:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] sd: Translate data lifetime information
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <20230920191442.3701673-8-bvanassche@acm.org>
 <DM6PR04MB6575B74B6F5526C9860A56F1FCC5A@DM6PR04MB6575.namprd04.prod.outlook.com>
 <1b89c38e-55dc-484a-9bf3-b9d69d960ebe@acm.org>
 <DM6PR04MB657537626F4D0BFB869E82D1FCC4A@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <DM6PR04MB657537626F4D0BFB869E82D1FCC4A@DM6PR04MB6575.namprd04.prod.outlook.com>
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

On 10/2/23 22:48, Avri Altman wrote:
>> On 10/2/23 06:11, Avri Altman wrote:
>>>> sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>>>>                   ret = sd_setup_rw16_cmnd(cmd, write, lba, nr_blocks,
>>>>                                            protect | fua, dld);
>>>>           } else if ((nr_blocks > 0xff) || (lba > 0x1fffff) ||
>>>> -                  sdp->use_10_for_rw || protect) {
>>>> +                  sdp->use_10_for_rw || protect ||
>>>> +                  rq->write_hint != WRITE_LIFE_NOT_SET) {
>>>
>>> Is this a typo?
>>
>> I don't see a typo? Am I perhaps overlooking something?
 >
> Forcing READ(6) into READ(10) because that req carries a write-hint,
> Deserves an extra line in the commit log IMO.

Right, I should explain that the READ(6) command does not support write 
hints and hence that READ(10) is selected if a write hint is present.

Thanks,

Bart.

