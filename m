Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9197BBE0B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 19:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjJFRwt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 13:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjJFRws (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:52:48 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0343FB6;
        Fri,  6 Oct 2023 10:52:45 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1c752caeaa6so19049565ad.1;
        Fri, 06 Oct 2023 10:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696614765; x=1697219565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BnL6IcDEF/I+SFfFl9VQ/bBGtLZVeE0oEvuHjO2kHpI=;
        b=AoPtlGZMx0z5olEMW9ujTHkr/9PQzqgPrwA/0vpMmgACxEGdQhZdVOkJt9JfqPpQbn
         VVKvBbIm/PIGlPmzNzYwx+siT1EPtqK3OBos+OWyHTS3rMFFKj8uxa4ftrVRBR9p+Yix
         22D1uxE2NpHo7Vs8MHJqxntsaDO0hrvAylcJoI4YXHhZKHwkDbFSOEf/qEWPRazQZRtS
         O/xcrH0tLhkzU5a2NtkTGHpX25BnM6QMP4nvZLtizh23xd7yVHAZsQmKm2HmoSf5zSp2
         0d04liI0G43zppEBMgtlK5g4UvGQ1gcdL8Gkie6XyXGkynxTGZJlRDU1I9FYpVNhPxsT
         PJBg==
X-Gm-Message-State: AOJu0YwtMWLr+2u51rpooQuPXk5ZsvdfR19KrD/tLZYdXb3JHle+P+EQ
        5Xl8TngqD8C5d7c0y9aScTY=
X-Google-Smtp-Source: AGHT+IFEfu6krZRMMNdIjI9SRnksIybRzXbtBBjNfKK1W53oKfdtvx2+WeKkXpi7mnUPNlqRrPCVhw==
X-Received: by 2002:a17:90b:4a12:b0:274:6503:26d with SMTP id kk18-20020a17090b4a1200b002746503026dmr8363179pjb.33.1696614765149;
        Fri, 06 Oct 2023 10:52:45 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ebdb:ae30:148c:2f33? ([2620:15c:211:201:ebdb:ae30:148c:2f33])
        by smtp.gmail.com with ESMTPSA id v5-20020a17090a0c8500b00256b67208b1sm6168825pja.56.2023.10.06.10.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 10:52:43 -0700 (PDT)
Message-ID: <a7a24914-4940-4a23-b439-bc8f0ad99212@acm.org>
Date:   Fri, 6 Oct 2023 10:52:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/21] scsi: sd: Support reading atomic properties from
 block limits VPD
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-19-john.g.garry@oracle.com>
 <2e5af8a4-f2e1-4c2e-bd0b-14cc9894b48e@acm.org>
 <53bfe07e-e125-7a69-4f89-481c10e0959e@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <53bfe07e-e125-7a69-4f89-481c10e0959e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/2/23 04:27, John Garry wrote:
> On 29/09/2023 18:54, Bart Van Assche wrote:
>> On 9/29/23 03:27, John Garry wrote:
>>> +static void sd_config_atomic(struct scsi_disk *sdkp)
>>> +{
>>> +    unsigned int logical_block_size = sdkp->device->sector_size;
>>> +    struct request_queue *q = sdkp->disk->queue;
>>> +
>>> +    if (sdkp->max_atomic) {
>>
>> Please use the "return early" style here to keep the indentation
>> level in this function low.
> 
> ok, fine.
> 
>>
>>> +        unsigned int max_atomic = max_t(unsigned int,
>>> +            rounddown_pow_of_two(sdkp->max_atomic),
>>> +            rounddown_pow_of_two(sdkp->max_atomic_with_boundary));
>>> +        unsigned int unit_min = sdkp->atomic_granularity ?
>>> +            rounddown_pow_of_two(sdkp->atomic_granularity) :
>>> +            physical_block_size_sectors;
>>> +        unsigned int unit_max = max_atomic;
>>> +
>>> +        if (sdkp->max_atomic_boundary)
>>> +            unit_max = min_t(unsigned int, unit_max,
>>> +                rounddown_pow_of_two(sdkp->max_atomic_boundary));
>>
>> Why does "rounddown_pow_of_two()" occur in the above code?
> 
> I assume that you are talking about all the code above to calculate 
> atomic write values for the device.
> 
> The reason is that atomic write unit min and max are always a power-of-2 
> - see rules described earlier - as so that we why we rounddown to a 
> power-of-2.

 From SBC-5: "The ATOMIC ALIGNMENT field indicates the required alignment
of the starting LBA in an atomic write command. If the ATOMIC ALIGNMENT
field is set to 0000_0000h, then there is no alignment requirement for
atomic write commands.

The ATOMIC TRANSFER LENGTH GRANULARITY field indicates the minimum
transfer length for an atomic write command. Atomic write operations are
required to have a transfer length that is a multiple of the atomic
transfer length granularity. An ATOMIC TRANSFER LENGTH GRANULARITY field
set to 0000_0000h indicates that there is no atomic transfer length
granularity requirement."

I think the above means that it is wrong to round down the ATOMIC
TRANSFER LENGTH GRANULARITY or the ATOMIC BOUNDARY values.

Thanks,

Bart.

