Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4D97B0D98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 22:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjI0Uto (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 16:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI0Utn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:49:43 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F28CD6;
        Wed, 27 Sep 2023 13:49:42 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-573912a7b14so6082659eaf.1;
        Wed, 27 Sep 2023 13:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695847781; x=1696452581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmyEGkXri5KPsLJOTpq3bUt+vQ7L9qwnm2OL7z9no/o=;
        b=hsbcXMJs3O+bel0C8TtVsigJ/csYrHcwlyNOI/H94wBJHe3ZsVTiYwnnwZOGkj/qSs
         wVEO15T7wiyNtpwZmw11RqJwDV9jrVbdC12IxtYo/PeLMCmr4AchQI8pYvUDuE4R67PS
         BYmjtkxS8CamxCG4SLBefQ7rQFYj6FPLvx55WUPctsO4tLkjescBk7h5oiYHz+vkWubM
         mztTHoq24wz/MkKRvD3xytTzT0O86u2xA0VBOu/zQqd4si3bGKGEW6MbCF1F0zyerN0u
         nUKgHDbABljPm1D+ZKq4BLLoHNbo/EWISlgGQ4Jb3gsW0E3/gPozFcMWvVu+tpkCZa/R
         JoHg==
X-Gm-Message-State: AOJu0YyXhAba4ZfdqYjtW7EK+jwpbKRXO0mBmEVrH6ri5yWZ7VeVo0O4
        6NrMFkGUfJGaeTtWN8Mnhxw=
X-Google-Smtp-Source: AGHT+IHCwOWWNCAmANznYdzvBGWpetjIhbyOwNgWCWOWXFVixgBXrieU8G1Svoezl04Px/snxncgLQ==
X-Received: by 2002:a05:6358:7e84:b0:135:47e8:76e2 with SMTP id o4-20020a0563587e8400b0013547e876e2mr2957543rwn.4.1695847780999;
        Wed, 27 Sep 2023 13:49:40 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8f39:a76e:2f15:c958? ([2620:15c:211:201:8f39:a76e:2f15:c958])
        by smtp.gmail.com with ESMTPSA id v13-20020a63b64d000000b0057783b0f102sm10285198pgt.40.2023.09.27.13.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 13:49:40 -0700 (PDT)
Message-ID: <be30c422-f84a-43b8-b176-3516ff5180cb@acm.org>
Date:   Wed, 27 Sep 2023 13:49:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] Pass data temperature information to zoned UFS
 devices
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <yq1o7hnzbsy.fsf@ca-mkp.ca.oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <yq1o7hnzbsy.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/27/23 12:14, Martin K. Petersen wrote:
> I don't have any particular problems with your implementation, 
> although I'm still trying to wrap my head around how to make this 
> coexist with my I/O hinting series. But I guess there's probably not
> going to be a big overlap between devices that support both 
> features.

Hi Martin,

This patch series should make it easier to implement I/O hint support
since some of the code added by this patch series is also needed to
implement I/O hint support.

> However, it still pains me greatly to see the SBC proposal being 
> intertwined with the travesty that is streams. Why not define 
> everything in the IO advice hints group descriptor? I/O hints already
> use GROUP NUMBER as an index. Why not just define a few permanent
> hint descriptors? What's the point of the additional level of
> indirection to tie this new feature into streams? RSCS basically says
> "ignore the streams-specific bits and bobs and do this other stuff
> instead". What does the streams infrastructure provide that can't be
> solved trivially in the IO advise mode page alone?

Hmm ... isn't that exactly what T10 did, define everything in the IO
advice hints group descriptor by introducing the new ST_ENBLE bit in
that descriptor?

This patch series relies on the constrained streams mechanism. A
constrained stream is permanently open. The new ST_ENBLE bit in the IO
advice hints group descriptor indicates whether or not an IO advice
hints group represents a permanent stream.

The new ST_ENBLE bit in the IO advice hints group descriptor allows SCSI
devices to interpret the index of the descriptor as a data lifetime.
 From the approved T10 proposal:

Table x1 – RELATIVE LIFETIME field
..............................................
Code        Relative lifetime
..............................................
00h         no relative lifetime is applicable
01h         shortest relative lifetime
02h         second shortest relative lifetime
03h to 3Dh  intermediate relative lifetimes
3Eh         second longest relative lifetime
3Fh         longest relative lifetime
..............................................

> For existing UFS devices which predate RSCS and streams but which 
> support getting data temperature from GROUP NUMBER, what is the 
> mechanism for detecting and enabling the feature?

We plan to ask UFS device vendors to modify the UFS device firmware and
to add support for the VPD and mode pages this patch series relies on.
My understanding is that this can be done easily in UFS device firmware.

Although it is technically possible to update the firmware of UFS
devices in smartphones, most smartphones do not support this because
this is considered risky. Hence, only new smartphones will benefit from
this patch series.

I do not want to add support in the Linux kernel for how conventional
UFS devices use the GROUP NUMBER field today. Conventional UFS devices
interpret the GROUP NUMBER field as a "ContextID". The ContextID
mechanism has a state, just like the SCSI stream mechanism. UFS contexts
need to be opened explicitly and are closed upon reset. From the UFS 4.0
specification: "No ContextID shall be open after power cycle."

Please let me know if you need more information.

Bart.
