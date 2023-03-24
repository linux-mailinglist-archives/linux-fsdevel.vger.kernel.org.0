Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E467D6C7AF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 10:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjCXJOG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 05:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjCXJNg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:13:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBAC22789
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 02:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679649159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yiqRrGCw8GJaBQNoK0W4TjNWeAd0DfxdfliriX6rTOg=;
        b=YdONawQgYwNDP/JZrUMFyYqVnbMqyQi7novogIBjwV4wxFYrruNd4wS22uKuEZCJIBvbuu
        95MlViFqglPec34+M5WEQawp1+1u+1NUXgUBzoBVczibKWqlPDb5e8Q+GW5NNd76skXVAR
        0c+UtjAJZ5WlfjxCSfDeowDCvwmQytI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-hTkXwCn6PPOqMsuO30FRuw-1; Fri, 24 Mar 2023 05:12:37 -0400
X-MC-Unique: hTkXwCn6PPOqMsuO30FRuw-1
Received: by mail-wm1-f70.google.com with SMTP id r11-20020a05600c458b00b003eea8d25f06so540341wmo.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 02:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679649156;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yiqRrGCw8GJaBQNoK0W4TjNWeAd0DfxdfliriX6rTOg=;
        b=uCvO4jw4/sXpnUNI4e5jL/f7RzuEhEqbO/4O09Jvr5Lz4C3djmzWxgb2ReWKjrgZVr
         lz7wgNOmaHQldbVaLxJDhH5dgajKW1jKmMA9bNROWvBUrN7Ysdu60U19uwCzEQVmP+ju
         FF7B0vXFGiR3c4TPkKj4p8MmOb3qDOSc70ifYxKK/0wHqCOUcgz6+wt9TTojIHh9AXwR
         B/WnMT0BuknvdDBvnp0GNjmKbi9CfykXqbgzJBXjKncTfTD64dw/VoUVvZhdVMpDKP2M
         7u2nnpPdvKLmhCKa/lQmtoTRN9N3NTB+dLlttoKIwLL1X1gMXeXqOJqQUK9swI78C34g
         W6/g==
X-Gm-Message-State: AO0yUKUXYRQlCgvyuC6igF0eCFFpDxy4D+lVgZmH9b/dwwImhuHicRLJ
        9ImitAshBo1yE8qaoa+G5kRQNDN0KX96ct9DnApt8ebE/G9pD6uL2JQhaKgLFAkA9e/iUyNfmKz
        h4eLNxKS39wo9F+khFhMWHLAhLA==
X-Received: by 2002:a05:600c:286:b0:3ee:7f0b:387b with SMTP id 6-20020a05600c028600b003ee7f0b387bmr1288491wmk.17.1679649156556;
        Fri, 24 Mar 2023 02:12:36 -0700 (PDT)
X-Google-Smtp-Source: AK7set/eQK72a69vOqXrE2MS7v3RovaIxLMqEWkliJJs8oZ2pzs2KdrM/PF7WWc9myyrZVUuz+GCIA==
X-Received: by 2002:a05:600c:286:b0:3ee:7f0b:387b with SMTP id 6-20020a05600c028600b003ee7f0b387bmr1288474wmk.17.1679649156168;
        Fri, 24 Mar 2023 02:12:36 -0700 (PDT)
Received: from [10.105.158.254] ([88.128.92.189])
        by smtp.gmail.com with ESMTPSA id l18-20020a1ced12000000b003edc11c2ecbsm4341456wmh.4.2023.03.24.02.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 02:12:35 -0700 (PDT)
Message-ID: <5536d792-867d-6390-81e2-b1ef135d347d@redhat.com>
Date:   Fri, 24 Mar 2023 10:12:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Content-Language: en-US
To:     Kyungsan Kim <ks0204.kim@samsung.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com
References: <31395703-5f0e-651e-1e3d-226751a22d1b@redhat.com>
 <CGME20230324090923epcas2p2710ba4dc8157f9141c03104cf66e9d26@epcas2p2.samsung.com>
 <20230324090923.147947-1-ks0204.kim@samsung.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230324090923.147947-1-ks0204.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 24.03.23 10:09, Kyungsan Kim wrote:
> Thank you David Hinderbrand for your interest on this topic.
> 
>>>
>>>> Kyungsan Kim wrote:
>>>> [..]
>>>>>> In addition to CXL memory, we may have other kind of memory in the
>>>>>> system, for example, HBM (High Bandwidth Memory), memory in FPGA card,
>>>>>> memory in GPU card, etc.  I guess that we need to consider them
>>>>>> together.  Do we need to add one zone type for each kind of memory?
>>>>>
>>>>> We also don't think a new zone is needed for every single memory
>>>>> device.  Our viewpoint is the sole ZONE_NORMAL becomes not enough to
>>>>> manage multiple volatile memory devices due to the increased device
>>>>> types.  Including CXL DRAM, we think the ZONE_EXMEM can be used to
>>>>> represent extended volatile memories that have different HW
>>>>> characteristics.
>>>>
>>>> Some advice for the LSF/MM discussion, the rationale will need to be
>>>> more than "we think the ZONE_EXMEM can be used to represent extended
>>>> volatile memories that have different HW characteristics". It needs to
>>>> be along the lines of "yes, to date Linux has been able to describe DDR
>>>> with NUMA effects, PMEM with high write overhead, and HBM with improved
>>>> bandwidth not necessarily latency, all without adding a new ZONE, but a
>>>> new ZONE is absolutely required now to enable use case FOO, or address
>>>> unfixable NUMA problem BAR." Without FOO and BAR to discuss the code
>>>> maintainability concern of "fewer degress of freedom in the ZONE
>>>> dimension" starts to dominate.
>>>
>>> One problem we experienced was occured in the combination of hot-remove and kerelspace allocation usecases.
>>> ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
>>> ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
>>> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.
> 
>> That sounds like a bad hack :) .
> I consent you.
> 
>>> In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
>>> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
> 
>> I once raised the idea of a ZONE_PREFER_MOVABLE [1], maybe that's
>> similar to what you have in mind here. In general, adding new zones is
>> frowned upon.
> 
> Actually, we have already studied your idea and thought it is similar with us in 2 aspects.
> 1. ZONE_PREFER_MOVABLE allows a kernelspace allocation using a new zone
> 2. ZONE_PREFER_MOVABLE helps less fragmentation by splitting zones, and ordering allocation requests from the zones.
> 
> We think ZONE_EXMEM also helps less fragmentation.
> Because it is a separated zone and handles a page allocation as movable by default.

So how is it different that it would justify a different (more confusing 
IMHO) name? :) Of course, names don't matter that much, but I'd be 
interested in which other aspect that zone would be "special".

-- 
Thanks,

David / dhildenb

