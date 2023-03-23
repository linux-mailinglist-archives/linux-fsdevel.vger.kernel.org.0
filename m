Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8B26C6846
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 13:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjCWM1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 08:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjCWM1K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:27:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AAD26C21
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 05:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679574351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j84pqX9AA+7rapMB0nYjO2DDYRDtYXRYeAkzhS0IY0M=;
        b=d6Cqk7YzJsJT4qddrPOvmwfaiLO95fr9dm0P8u45ATRfA9xYNvs8Vzb79PaNDcGPkm/tWq
        WkKB8S7zBBLuZhey8mG+cpS5BQV9zZU4iz+sKL9zacsocLMEJBJQkq2fxSfEa3WfXadVMc
        3TMA70T1q6loqmCyqWzxlKety8VjAQI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-fN9oETEbPCCSYhyYasiaAQ-1; Thu, 23 Mar 2023 08:25:50 -0400
X-MC-Unique: fN9oETEbPCCSYhyYasiaAQ-1
Received: by mail-wm1-f71.google.com with SMTP id bi5-20020a05600c3d8500b003edda1368d7so853923wmb.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 05:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679574349;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j84pqX9AA+7rapMB0nYjO2DDYRDtYXRYeAkzhS0IY0M=;
        b=quL4okqpmk9E/zJYnP2K4P88eDU/ZO0BXcBepgQd8+8T6BuWFA1LvHCHAXhmhGMomr
         urrX9/kikHmj8/DpG+jSKa85HO6PoCZt8o1LxOus2/KTpG6SF468D6UCRUAaT4em6ucw
         Nka6spnMer4z1P2hvBYPwgbaLX2h5qOhehkvUmHZjhjpKXtYrtGAp8XjRr3eOqCvXw0l
         Kl5wXXxXqBgOAQJKmZBdx4Xt7m3bb7ywlGIuYeaN+nYTp/UeS98Q23ALWOLFzg60ITy4
         2c3tOg/TThKL5L+2Sb4PZWUFexhnZjXFv6MWqcJ1qNvUlgIbU5hNBiK+UsHKTx14XKbr
         vzSw==
X-Gm-Message-State: AO0yUKUfXyJsdJduV986Z3SX3T0+9mIpVnnKIcjZ/U2jqyiVubUfZlMI
        9h4oO3D4VGhYcZk82NpsFsvQY1fFxVUZj+N3ot2u5JHrvM1+xJl3w2OhzLQRAJWlFbTzUMmDhcZ
        8/e/REdOt4asP3znzQdzesGsTrg==
X-Received: by 2002:a05:600c:b46:b0:3eb:29fe:f922 with SMTP id k6-20020a05600c0b4600b003eb29fef922mr2053543wmr.29.1679574349477;
        Thu, 23 Mar 2023 05:25:49 -0700 (PDT)
X-Google-Smtp-Source: AK7set+dhEun5J5hTK3lDPuI/2GQ0/eWFSI8uUOix985BymBdH1ITnxsGKbjpel8RqRCJITPzEHuOQ==
X-Received: by 2002:a05:600c:b46:b0:3eb:29fe:f922 with SMTP id k6-20020a05600c0b4600b003eb29fef922mr2053532wmr.29.1679574349167;
        Thu, 23 Mar 2023 05:25:49 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c22cc00b003ee697ecefdsm1700871wmg.45.2023.03.23.05.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 05:25:48 -0700 (PDT)
Message-ID: <31395703-5f0e-651e-1e3d-226751a22d1b@redhat.com>
Date:   Thu, 23 Mar 2023 13:25:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Content-Language: en-US
To:     Kyungsan Kim <ks0204.kim@samsung.com>, dan.j.williams@intel.com
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        ying.huang@intel.com
References: <641b7b2117d02_1b98bb294cb@dwillia2-xfh.jf.intel.com.notmuch>
 <CGME20230323105106epcas2p39ea8de619622376a4698db425c6a6fb3@epcas2p3.samsung.com>
 <20230323105105.145783-1-ks0204.kim@samsung.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230323105105.145783-1-ks0204.kim@samsung.com>
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

On 23.03.23 11:51, Kyungsan Kim wrote:
> I appreciate dan for the careful advice.
> 
>> Kyungsan Kim wrote:
>> [..]
>>>> In addition to CXL memory, we may have other kind of memory in the
>>>> system, for example, HBM (High Bandwidth Memory), memory in FPGA card,
>>>> memory in GPU card, etc.  I guess that we need to consider them
>>>> together.  Do we need to add one zone type for each kind of memory?
>>>
>>> We also don't think a new zone is needed for every single memory
>>> device.  Our viewpoint is the sole ZONE_NORMAL becomes not enough to
>>> manage multiple volatile memory devices due to the increased device
>>> types.  Including CXL DRAM, we think the ZONE_EXMEM can be used to
>>> represent extended volatile memories that have different HW
>>> characteristics.
>>
>> Some advice for the LSF/MM discussion, the rationale will need to be
>> more than "we think the ZONE_EXMEM can be used to represent extended
>> volatile memories that have different HW characteristics". It needs to
>> be along the lines of "yes, to date Linux has been able to describe DDR
>> with NUMA effects, PMEM with high write overhead, and HBM with improved
>> bandwidth not necessarily latency, all without adding a new ZONE, but a
>> new ZONE is absolutely required now to enable use case FOO, or address
>> unfixable NUMA problem BAR." Without FOO and BAR to discuss the code
>> maintainability concern of "fewer degress of freedom in the ZONE
>> dimension" starts to dominate.
> 
> One problem we experienced was occured in the combination of hot-remove and kerelspace allocation usecases.
> ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
> ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.

That sounds like a bad hack :) .

> In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.

I once raised the idea of a ZONE_PREFER_MOVABLE [1], maybe that's 
similar to what you have in mind here. In general, adding new zones is 
frowned upon.

> As you well know, among heterogeneous DRAM devices, CXL DRAM is the first PCIe basis device, which allows hot-pluggability, different RAS, and extended connectivity.
> So, we thought it could be a graceful approach adding a new zone and separately manage the new features.
> 
> Kindly let me know any advice or comment on our thoughts.

[1] https://www.lkml.org/lkml/2020/9/9/667

-- 
Thanks,

David / dhildenb

