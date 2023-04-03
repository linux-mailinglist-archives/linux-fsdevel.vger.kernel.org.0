Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9781D6D3EF6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 10:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjDCI3n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 04:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjDCI3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:29:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E5549C2
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 01:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680510541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zHlXHCbBRbgkqEnJ1s42nDOWMLzWIlrNrLvgAIWCdKY=;
        b=c/4Da9oui4XB4JrxX8ttEEGfmIffTfrgQN96NLJBBDhafrBEsDmP2+uUcHWuolfsG68PiF
        zOrdF1Jx2e58jCnPiJfYfJ/RaVz+s33U43oLHruRlm0r33w6op38+9abbGduA0oVFU9WwK
        01KA0eX62MLOKF2xu0s8GWJkzm8eFXw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-oSBH0P19PCOAvZ8KgCqI5g-1; Mon, 03 Apr 2023 04:29:00 -0400
X-MC-Unique: oSBH0P19PCOAvZ8KgCqI5g-1
Received: by mail-wm1-f69.google.com with SMTP id j22-20020a05600c1c1600b003ef95cef641so7749635wms.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Apr 2023 01:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680510539;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHlXHCbBRbgkqEnJ1s42nDOWMLzWIlrNrLvgAIWCdKY=;
        b=mc4muFsGEhqlT1qOx6KueOyYOE0nIcRzRh/SW/kkMzsvUcGSSkygKrT+WE2GkwcTq3
         sS9Fm85Q6pjDFH7xoHGXXEnY2/AzOl1FoMDy9mX+0IrxN/bP5jMSuT2pul1qfN+I+Zzw
         jismnFsc1mPyoTDiqW3bSznggdCltIsyDLShUpXQw4zyifObZCUvpS5VMLm3nbVOwhqm
         2neV0n2ktNQjnlT98vy+tmHewDkgEn1pE2x0b7ZZ9UQgeaOU658/C0BQWKJsiAb+8HRJ
         GOf44HRP/WSb//XGeEzhzhpOQ+b47YS7En4cMs3E01VzT3lfPQ9Gn38juQViPGwelKcu
         glqw==
X-Gm-Message-State: AAQBX9eJfxJR7/u3/BZq5jsvKoKWB3Mb/7ivrLFVzo8/a9lmKckhR85E
        CwH7RRtwGvA16oZ9GIKFpCc/MCL7RfVLlWcjva3aj0a87eGEBtjiSUZHo6YXFMdUxtXc6WZUKNZ
        C5flWn0ZBBRZ2PHOmH5Lhjm5bTg==
X-Received: by 2002:adf:ea10:0:b0:2da:e8ac:6986 with SMTP id q16-20020adfea10000000b002dae8ac6986mr28538458wrm.10.1680510539189;
        Mon, 03 Apr 2023 01:28:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350YKzTc97TMUJzf2ne0eFFWJjDRCW/J/AYuOPLkH9UWzYlAp+oF5yMyLv5Ql9F1GAlj7Dh0U6g==
X-Received: by 2002:adf:ea10:0:b0:2da:e8ac:6986 with SMTP id q16-20020adfea10000000b002dae8ac6986mr28538444wrm.10.1680510538856;
        Mon, 03 Apr 2023 01:28:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5e00:8e78:71f3:6243:77f0? (p200300cbc7025e008e7871f3624377f0.dip0.t-ipconnect.de. [2003:cb:c702:5e00:8e78:71f3:6243:77f0])
        by smtp.gmail.com with ESMTPSA id f14-20020adff58e000000b002e52dfb9256sm9137370wro.41.2023.04.03.01.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 01:28:58 -0700 (PDT)
Message-ID: <25451d4f-978e-8106-3ee6-e9b382bb87a3@redhat.com>
Date:   Mon, 3 Apr 2023 10:28:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Content-Language: en-US
To:     Kyungsan Kim <ks0204.kim@samsung.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
References: <7c7933df-43da-24e3-2144-0551cde05dcd@redhat.com>
 <CGME20230331114220epcas2p2d5734efcbdd8956f861f8e7178cd5288@epcas2p2.samsung.com>
 <20230331114220.400297-1-ks0204.kim@samsung.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230331114220.400297-1-ks0204.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 31.03.23 13:42, Kyungsan Kim wrote:
>> On 24.03.23 14:08, Jørgen Hansen wrote:
>>>
>>>> On 24 Mar 2023, at 10.50, Kyungsan Kim <ks0204.kim@samsung.com> wrote:
>>>>
>>>>> On 24.03.23 10:27, Kyungsan Kim wrote:
>>>>>>> On 24.03.23 10:09, Kyungsan Kim wrote:
>>>>>>>> Thank you David Hinderbrand for your interest on this topic.
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> Kyungsan Kim wrote:
>>>>>>>>>>> [..]
>>>>>>>>>>>>> In addition to CXL memory, we may have other kind of memory in the
>>>>>>>>>>>>> system, for example, HBM (High Bandwidth Memory), memory in FPGA card,
>>>>>>>>>>>>> memory in GPU card, etc.  I guess that we need to consider them
>>>>>>>>>>>>> together.  Do we need to add one zone type for each kind of memory?
>>>>>>>>>>>>
>>>>>>>>>>>> We also don't think a new zone is needed for every single memory
>>>>>>>>>>>> device.  Our viewpoint is the sole ZONE_NORMAL becomes not enough to
>>>>>>>>>>>> manage multiple volatile memory devices due to the increased device
>>>>>>>>>>>> types.  Including CXL DRAM, we think the ZONE_EXMEM can be used to
>>>>>>>>>>>> represent extended volatile memories that have different HW
>>>>>>>>>>>> characteristics.
>>>>>>>>>>>
>>>>>>>>>>> Some advice for the LSF/MM discussion, the rationale will need to be
>>>>>>>>>>> more than "we think the ZONE_EXMEM can be used to represent extended
>>>>>>>>>>> volatile memories that have different HW characteristics". It needs to
>>>>>>>>>>> be along the lines of "yes, to date Linux has been able to describe DDR
>>>>>>>>>>> with NUMA effects, PMEM with high write overhead, and HBM with improved
>>>>>>>>>>> bandwidth not necessarily latency, all without adding a new ZONE, but a
>>>>>>>>>>> new ZONE is absolutely required now to enable use case FOO, or address
>>>>>>>>>>> unfixable NUMA problem BAR." Without FOO and BAR to discuss the code
>>>>>>>>>>> maintainability concern of "fewer degress of freedom in the ZONE
>>>>>>>>>>> dimension" starts to dominate.
>>>>>>>>>>
>>>>>>>>>> One problem we experienced was occured in the combination of hot-remove and kerelspace allocation usecases.
>>>>>>>>>> ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
>>>>>>>>>> ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
>>>>>>>>>> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.
>>>>>>>>
>>>>>>>>> That sounds like a bad hack :) .
>>>>>>>> I consent you.
>>>>>>>>
>>>>>>>>>> In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
>>>>>>>>>> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
>>>>>>>>
>>>>>>>>> I once raised the idea of a ZONE_PREFER_MOVABLE [1], maybe that's
>>>>>>>>> similar to what you have in mind here. In general, adding new zones is
>>>>>>>>> frowned upon.
>>>>>>>>
>>>>>>>> Actually, we have already studied your idea and thought it is similar with us in 2 aspects.
>>>>>>>> 1. ZONE_PREFER_MOVABLE allows a kernelspace allocation using a new zone
>>>>>>>> 2. ZONE_PREFER_MOVABLE helps less fragmentation by splitting zones, and ordering allocation requests from the zones.
>>>>>>>>
>>>>>>>> We think ZONE_EXMEM also helps less fragmentation.
>>>>>>>> Because it is a separated zone and handles a page allocation as movable by default.
>>>>>>>
>>>>>>> So how is it different that it would justify a different (more confusing
>>>>>>> IMHO) name? :) Of course, names don't matter that much, but I'd be
>>>>>>> interested in which other aspect that zone would be "special".
>>>>>>
>>>>>> FYI for the first time I named it as ZONE_CXLMEM, but we thought it would be needed to cover other extended memory types as well.
>>>>>> So I changed it as ZONE_EXMEM.
>>>>>> We also would like to point out a "special" zone aspeact, which is different from ZONE_NORMAL for tranditional DDR DRAM.
>>>>>> Of course, a symbol naming is important more or less to represent it very nicely, though.
>>>>>> Do you prefer ZONE_SPECIAL? :)
>>>>>
>>>>> I called it ZONE_PREFER_MOVABLE. If you studied that approach there must
>>>>> be a good reason to name it differently?
>>>>>
>>>>
>>>> The intention of ZONE_EXMEM is a separated logical management dimension originated from the HW diffrences of extended memory devices.
>>>> Althought the ZONE_EXMEM considers the movable and frementation aspect, it is not all what ZONE_EXMEM considers.
>>>> So it is named as it.
>>>
>>> Given that CXL memory devices can potentially cover a wide range of technologies with quite different latency and bandwidth metrics, will one zone serve as the management vehicle that you seek? If a system contains both CXL attached DRAM and, let say, a byte-addressable CXL SSD - both used as (different) byte addressable tiers in a tiered memory hierarchy, allocating memory from the ZONE_EXMEM doesn’t really tell you much about what you get. So the client would still need an orthogonal method to characterize the desired performance characteristics. This method could be combined with a fabric independent zone such as ZONE_PREFER_MOVABLE to address the kernel allocation issue. At the same time, this new zone could also be useful in other cases, such as virtio-mem.
>>
>> Yes. I still did not get a satisfying answer to my original question:
>> what would be the differences between both zones from a MM point of
>> view? We can discuss that in the session, of course.
>>
>> Regarding performance differences, I thought the idea was to go with
>> different nodes to express (and model) such.
>>
> 
>  From a MM point of view on the movability aspect, a kernel context is not allocated from ZONE_EXMEM without using GFP_EXMEM explicitly.
> In contrast, if we understand the design of ZONE_PREFER_MOVABLE correctly, a kernel context can be allocated from ZONE_PREFER_MOVABLE implicitly as the fallback of ZONE_NORMAL allocation.
> However, the movable attribute is not all we are concerning.
> In addition, we experienced page allocation and migration issue on the heterogeneous memories.
> 
> Given our experiences/design and industry's viewpoints/inquiries,
> I will prepare a few slides in the session to explain
>    1. Usecase - user/kernespace memory tiering for near/far placement, memory virtualization between hypervisor/baremetal OS
>    2. Issue - movability(movable/unmovable), allocation(explicit/implicit), migration(intented/unintended)
>    3. HW - topology(direct, switch, fabric), feature(pluggability,error-handling,etc)

Yes, especially a motivation for GFP_EXMEM and ZONE_EXMEM would be 
great. New GFP flags and zone are very likely a lot of upstream 
pushback. So we need a clear motivation and discussion of alternatives 
(and why this memory has to be treated so special but still wants to be 
managed by the buddy).

Willy raises some very good points.

-- 
Thanks,

David / dhildenb

