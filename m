Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E0B6C8873
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 23:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjCXWfw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 18:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCXWfu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691811F93F
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 15:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679697197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M2Gd048jUU5nxLZZ0U+ngFbATTz0dYwE/LMy6TKJlvM=;
        b=dltJEG/F6ymubQIHl5SCjffNpGH0FcvUAgWsnVa0yTdAmKGygAR2i5uaJE8rTBdClR2cq4
        RQ48YJ/yrSIfANHHxM2z6uSatBZXPbZAH/XWAtcgSEHzLLvkzMlFD7xXlg06lBogjEUKxf
        EFVN8NAQ6akmZgZl+Bi+Y0CnkoydaVY=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-MSRthOt7PMWtOxUPOxaDsg-1; Fri, 24 Mar 2023 18:33:15 -0400
X-MC-Unique: MSRthOt7PMWtOxUPOxaDsg-1
Received: by mail-yb1-f199.google.com with SMTP id i11-20020a256d0b000000b0086349255277so3115756ybc.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 15:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679697195;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M2Gd048jUU5nxLZZ0U+ngFbATTz0dYwE/LMy6TKJlvM=;
        b=DNyJsbomrulC3rZfv3AtMJt/16XuWRamJJQNwc6q82aw4/McdMZW08gnEthJ+0hmnb
         0/q4fSljmDgLJgPdKAQW915sDMIgJb341xoDkt+OYd9fsiiV+bhRPYngHAMYQCFMKVW4
         yzZI0WYSpC0daCGVW9Oe6ZaZhCFNellnljAuXW8CIiCHVP2N4Fdy3stfcYOKZlHak6Sw
         /e8bebLaFyDudlrnDTOl3vyr7/PGExcCnlK5HmMI8r5jkqLfq2IGGQhjVhgoiG4eWQRK
         6m8DUhyh8prbihpdGsemnEXgepHoJmkDIbp/gVDNe+f+Esu9OxA3V2F4Hzbb4WTLoMNb
         T9fg==
X-Gm-Message-State: AAQBX9cS8UquSDXnc5EykTx3+rsErQdsJYajkLj+Zh/5EL5coAE7QiOL
        AZjfUpTLVThCHAIcfHlPQhjRwpwixA1b7I7VsZCjcWOh83JdtVyV6F3kLEIOG+CwHXksInOyfo6
        6uz4Tnk/t9lgweNlsMzUlgeyEoQ==
X-Received: by 2002:a81:6ac5:0:b0:541:894d:9360 with SMTP id f188-20020a816ac5000000b00541894d9360mr3452805ywc.21.1679697194984;
        Fri, 24 Mar 2023 15:33:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZxDFkfYE1yVhUtHbiwatfrVOh987ysutLClRdPWjsYtqHOWAfDK8VXxXnoVK8wOnV2R2YvYw==
X-Received: by 2002:a81:6ac5:0:b0:541:894d:9360 with SMTP id f188-20020a816ac5000000b00541894d9360mr3452775ywc.21.1679697194417;
        Fri, 24 Mar 2023 15:33:14 -0700 (PDT)
Received: from [100.69.142.128] ([206.173.106.22])
        by smtp.gmail.com with ESMTPSA id t4-20020a81b504000000b00545a0818493sm664253ywh.35.2023.03.24.15.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 15:33:14 -0700 (PDT)
Message-ID: <7c7933df-43da-24e3-2144-0551cde05dcd@redhat.com>
Date:   Fri, 24 Mar 2023 23:33:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Content-Language: en-US
To:     =?UTF-8?Q?J=c3=b8rgen_Hansen?= <Jorgen.Hansen@wdc.com>,
        Kyungsan Kim <ks0204.kim@samsung.com>
Cc:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
References: <91d02705-1c3f-5f55-158a-1a68120df2f4@redhat.com>
 <CGME20230324095031epcas2p284095ae90b25a47360b5098478dffdaa@epcas2p2.samsung.com>
 <20230324095031.148164-1-ks0204.kim@samsung.com>
 <E224146D-058D-48B3-8788-A6BC3370044F@wdc.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <E224146D-058D-48B3-8788-A6BC3370044F@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 24.03.23 14:08, Jørgen Hansen wrote:
> 
>> On 24 Mar 2023, at 10.50, Kyungsan Kim <ks0204.kim@samsung.com> wrote:
>>
>>> On 24.03.23 10:27, Kyungsan Kim wrote:
>>>>> On 24.03.23 10:09, Kyungsan Kim wrote:
>>>>>> Thank you David Hinderbrand for your interest on this topic.
>>>>>>
>>>>>>>>
>>>>>>>>> Kyungsan Kim wrote:
>>>>>>>>> [..]
>>>>>>>>>>> In addition to CXL memory, we may have other kind of memory in the
>>>>>>>>>>> system, for example, HBM (High Bandwidth Memory), memory in FPGA card,
>>>>>>>>>>> memory in GPU card, etc.  I guess that we need to consider them
>>>>>>>>>>> together.  Do we need to add one zone type for each kind of memory?
>>>>>>>>>>
>>>>>>>>>> We also don't think a new zone is needed for every single memory
>>>>>>>>>> device.  Our viewpoint is the sole ZONE_NORMAL becomes not enough to
>>>>>>>>>> manage multiple volatile memory devices due to the increased device
>>>>>>>>>> types.  Including CXL DRAM, we think the ZONE_EXMEM can be used to
>>>>>>>>>> represent extended volatile memories that have different HW
>>>>>>>>>> characteristics.
>>>>>>>>>
>>>>>>>>> Some advice for the LSF/MM discussion, the rationale will need to be
>>>>>>>>> more than "we think the ZONE_EXMEM can be used to represent extended
>>>>>>>>> volatile memories that have different HW characteristics". It needs to
>>>>>>>>> be along the lines of "yes, to date Linux has been able to describe DDR
>>>>>>>>> with NUMA effects, PMEM with high write overhead, and HBM with improved
>>>>>>>>> bandwidth not necessarily latency, all without adding a new ZONE, but a
>>>>>>>>> new ZONE is absolutely required now to enable use case FOO, or address
>>>>>>>>> unfixable NUMA problem BAR." Without FOO and BAR to discuss the code
>>>>>>>>> maintainability concern of "fewer degress of freedom in the ZONE
>>>>>>>>> dimension" starts to dominate.
>>>>>>>>
>>>>>>>> One problem we experienced was occured in the combination of hot-remove and kerelspace allocation usecases.
>>>>>>>> ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
>>>>>>>> ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
>>>>>>>> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.
>>>>>>
>>>>>>> That sounds like a bad hack :) .
>>>>>> I consent you.
>>>>>>
>>>>>>>> In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
>>>>>>>> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
>>>>>>
>>>>>>> I once raised the idea of a ZONE_PREFER_MOVABLE [1], maybe that's
>>>>>>> similar to what you have in mind here. In general, adding new zones is
>>>>>>> frowned upon.
>>>>>>
>>>>>> Actually, we have already studied your idea and thought it is similar with us in 2 aspects.
>>>>>> 1. ZONE_PREFER_MOVABLE allows a kernelspace allocation using a new zone
>>>>>> 2. ZONE_PREFER_MOVABLE helps less fragmentation by splitting zones, and ordering allocation requests from the zones.
>>>>>>
>>>>>> We think ZONE_EXMEM also helps less fragmentation.
>>>>>> Because it is a separated zone and handles a page allocation as movable by default.
>>>>>
>>>>> So how is it different that it would justify a different (more confusing
>>>>> IMHO) name? :) Of course, names don't matter that much, but I'd be
>>>>> interested in which other aspect that zone would be "special".
>>>>
>>>> FYI for the first time I named it as ZONE_CXLMEM, but we thought it would be needed to cover other extended memory types as well.
>>>> So I changed it as ZONE_EXMEM.
>>>> We also would like to point out a "special" zone aspeact, which is different from ZONE_NORMAL for tranditional DDR DRAM.
>>>> Of course, a symbol naming is important more or less to represent it very nicely, though.
>>>> Do you prefer ZONE_SPECIAL? :)
>>>
>>> I called it ZONE_PREFER_MOVABLE. If you studied that approach there must
>>> be a good reason to name it differently?
>>>
>>
>> The intention of ZONE_EXMEM is a separated logical management dimension originated from the HW diffrences of extended memory devices.
>> Althought the ZONE_EXMEM considers the movable and frementation aspect, it is not all what ZONE_EXMEM considers.
>> So it is named as it.
> 
> Given that CXL memory devices can potentially cover a wide range of technologies with quite different latency and bandwidth metrics, will one zone serve as the management vehicle that you seek? If a system contains both CXL attached DRAM and, let say, a byte-addressable CXL SSD - both used as (different) byte addressable tiers in a tiered memory hierarchy, allocating memory from the ZONE_EXMEM doesn’t really tell you much about what you get. So the client would still need an orthogonal method to characterize the desired performance characteristics. This method could be combined with a fabric independent zone such as ZONE_PREFER_MOVABLE to address the kernel allocation issue. At the same time, this new zone could also be useful in other cases, such as virtio-mem.

Yes. I still did not get a satisfying answer to my original question: 
what would be the differences between both zones from a MM point of 
view? We can discuss that in the session, of course.

Regarding performance differences, I thought the idea was to go with 
different nodes to express (and model) such.

-- 
Thanks,

David / dhildenb

