Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8897B6F2B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 19:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240523AbjJCRAE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 13:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjJCRAD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:00:03 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E239B;
        Tue,  3 Oct 2023 10:00:00 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3ae2896974bso668321b6e.0;
        Tue, 03 Oct 2023 10:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696352399; x=1696957199;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MIq/p5A3JjbKHPYkXXq3MLFnIf7hkB5Y59MCBnaPJFY=;
        b=ZVQrKlfVFMINlv5M/v1yVpXtipoqlPj+l+xA7lUjiwOY3RKD/fxeGnpjvWHbDCeHom
         Xiug+ZeyN2r6dgEPpKG4fmaG8odSvbl1EUWlJIHWmDGO17VhodBS42w9VC3f6H9wS2lj
         RLexrVNJzRNpXsOpHdlql2F2u7I0yuVZoR9S/48Ozb8FHyUUkem3rkCWk5qpHkJkYeMs
         f6rMkyGSxiVERLpWh2bQMiQCREtfYt6otiMyfknpScVR/otv4IM5EM5+ZNB5IwbazwnW
         bUCV0MRotnxJLI9lJ79ED54Wfd3jQXJ3ZgqGeO/E/0xYvRE2Jz2hbUc/VEeDyU1eiCZA
         8VeA==
X-Gm-Message-State: AOJu0YzK3EubXoJoxMLBjWeOAWbxnRZzIKc243CYvAtT97SuEahNKREE
        Wwe9ABh2n8iiGC+hhiAJWJk=
X-Google-Smtp-Source: AGHT+IEffoO2DsWstPvJ7q1LjMxdRFHl/Eg5NV5HnNiOMsU8dNldC5O4zhRuZ0vIocYsE3g8pk/8Dg==
X-Received: by 2002:a05:6808:1a88:b0:3a9:c647:c9ca with SMTP id bm8-20020a0568081a8800b003a9c647c9camr157563oib.5.1696352399287;
        Tue, 03 Oct 2023 09:59:59 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:fc96:5ba7:a6f5:b187? ([2620:15c:211:201:fc96:5ba7:a6f5:b187])
        by smtp.gmail.com with ESMTPSA id g6-20020a17090a300600b0027768125e24sm8260191pjb.39.2023.10.03.09.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 09:59:58 -0700 (PDT)
Message-ID: <cbe0be7f-2709-4a94-a92d-3bb2dc59966d@acm.org>
Date:   Tue, 3 Oct 2023 09:59:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] sd: Translate data lifetime information
Content-Language: en-US
From:   Bart Van Assche <bvanassche@acm.org>
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
 <c3130686-3e28-4ff0-af0d-560b0f4e7227@acm.org>
In-Reply-To: <c3130686-3e28-4ff0-af0d-560b0f4e7227@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/3/23 09:58, Bart Van Assche wrote:
> On 10/2/23 22:48, Avri Altman wrote:
>>> On 10/2/23 06:11, Avri Altman wrote:
>>>>> sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>>>>>                   ret = sd_setup_rw16_cmnd(cmd, write, lba, nr_blocks,
>>>>>                                            protect | fua, dld);
>>>>>           } else if ((nr_blocks > 0xff) || (lba > 0x1fffff) ||
>>>>> -                  sdp->use_10_for_rw || protect) {
>>>>> +                  sdp->use_10_for_rw || protect ||
>>>>> +                  rq->write_hint != WRITE_LIFE_NOT_SET) {
>>>>
>>>> Is this a typo?
>>>
>>> I don't see a typo? Am I perhaps overlooking something?
>  >
>> Forcing READ(6) into READ(10) because that req carries a write-hint,
>> Deserves an extra line in the commit log IMO.
> 
> Right, I should explain that the READ(6) command does not support write 
> hints and hence that READ(10) is selected if a write hint is present.

(replying to my own email)

In my answer READ should be changed into WRITE.

Bart.

