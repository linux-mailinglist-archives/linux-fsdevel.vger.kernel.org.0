Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D826D3F14
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 10:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjDCIfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 04:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjDCIfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:35:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0D446B6
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 01:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680510864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FcZLYmIqRCN99tYF4yEMgjqA6ESHr46ONZQ166uj3mY=;
        b=Hwy189fPBWJflspemBwCbOPoSdsrQLgbl6OhqIVP/7LP4slrmC4hg+B+AMFtT6pFnRfYxv
        wd95xlKpLC8LCCOkeODq00EcKnHSow2x2mX3YBQ+IQV7hE+/TiDD1D5lNumMkrd7cyVR1j
        Qms/M55u41Dz1sjIaiwsRmi7FYnXyvw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-Ta1h2eugOAuvswnSuDGPTw-1; Mon, 03 Apr 2023 04:34:23 -0400
X-MC-Unique: Ta1h2eugOAuvswnSuDGPTw-1
Received: by mail-wm1-f71.google.com with SMTP id d11-20020a05600c34cb00b003ee89ce8cc3so14172726wmq.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Apr 2023 01:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680510862;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FcZLYmIqRCN99tYF4yEMgjqA6ESHr46ONZQ166uj3mY=;
        b=OHmaJ/rMnjrA2fxtTozTbG6drpGmSvPbXJwnqhJKG61/jpcYBiArCCZzif1KS89K6R
         sZvJtxfFAE7BCfj8cIVAOKR6yNWtltgDeK8/UcOrGrfFkaHIRRvKI2v+RklQ7qZOO/Ke
         YwbfNMtTS8PACqt+3wtWWGF8KBxpSv9v1ywMAHZQYhn5ujOMRU0/bDT15+BkboNPka6V
         tFjcx6ky4gM2SX8xzdKbkNnkRgUVTeqCOKyGPh0qmzLYC68ukpEISoBivGVKy4lK2scG
         p0huPlpuw3T5a3lDlgtgnwzXnoh4ohjUb3coL5l4tG8TPRwJeOgfmZh5ud14ydFTpctC
         T81Q==
X-Gm-Message-State: AAQBX9fNHr+nmVLX+8Y07A5ezvHcY9CcFBOL/g6Quk72KpUPZF6MDLk8
        IpsAb8fKUrTg2xnXro40zRhNhPs/1fTp955TZprlm5UxS/Xn8p87EkBo+QlQqnerNydnjMoii//
        JDBHcfipcVT/XlcrZEXkXZqHMVQ==
X-Received: by 2002:adf:f8c2:0:b0:2c3:e7d8:245c with SMTP id f2-20020adff8c2000000b002c3e7d8245cmr25962112wrq.13.1680510861945;
        Mon, 03 Apr 2023 01:34:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350buGrvo6nZ4OBkdPpnnJzG9dcpRSvtFybHJQ8Jw4OJPMiVMYDLKKgmCWXOMOoPKkQciPT5ozA==
X-Received: by 2002:adf:f8c2:0:b0:2c3:e7d8:245c with SMTP id f2-20020adff8c2000000b002c3e7d8245cmr25962099wrq.13.1680510861580;
        Mon, 03 Apr 2023 01:34:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5e00:8e78:71f3:6243:77f0? (p200300cbc7025e008e7871f3624377f0.dip0.t-ipconnect.de. [2003:cb:c702:5e00:8e78:71f3:6243:77f0])
        by smtp.gmail.com with ESMTPSA id d16-20020a5d4f90000000b002d51d10a3fasm9159738wru.55.2023.04.03.01.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 01:34:21 -0700 (PDT)
Message-ID: <5d6a35c8-94cd-5968-3110-7ea4737e728b@redhat.com>
Date:   Mon, 3 Apr 2023 10:34:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Content-Language: en-US
To:     Frank van der Linden <fvdl@google.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Kyungsan Kim <ks0204.kim@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
References: <7c7933df-43da-24e3-2144-0551cde05dcd@redhat.com>
 <CGME20230331114220epcas2p2d5734efcbdd8956f861f8e7178cd5288@epcas2p2.samsung.com>
 <20230331114220.400297-1-ks0204.kim@samsung.com>
 <ZCbjRsmoy1acVN0Z@casper.infradead.org>
 <CAPTztWYGdkcdq+yO4aG2C8YYZ0SokxhHQxQK7JmRxXLAuwV00Q@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAPTztWYGdkcdq+yO4aG2C8YYZ0SokxhHQxQK7JmRxXLAuwV00Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 31.03.23 17:56, Frank van der Linden wrote:
> On Fri, Mar 31, 2023 at 6:42 AM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Fri, Mar 31, 2023 at 08:42:20PM +0900, Kyungsan Kim wrote:
>>> Given our experiences/design and industry's viewpoints/inquiries,
>>> I will prepare a few slides in the session to explain
>>>    1. Usecase - user/kernespace memory tiering for near/far placement, memory virtualization between hypervisor/baremetal OS
>>>    2. Issue - movability(movable/unmovable), allocation(explicit/implicit), migration(intented/unintended)
>>>    3. HW - topology(direct, switch, fabric), feature(pluggability,error-handling,etc)
>>
>> I think you'll find everybody else in the room understands these issues
>> rather better than you do.  This is hardly the first time that we've
>> talked about CXL, and CXL is not the first time that people have
>> proposed disaggregated memory, nor heterogenous latency/bandwidth
>> systems.  All the previous attempts have failed, and I expect this
>> one to fail too.  Maybe there's something novel that means this time
>> it really will work, so any slides you do should focus on that.
>>
>> A more profitable discussion might be:
>>
>> 1. Should we have the page allocator return pages from CXL or should
>>     CXL memory be allocated another way?
>> 2. Should there be a way for userspace to indicate that it prefers CXL
>>     memory when it calls mmap(), or should it always be at the discretion
>>     of the kernel?
>> 3. Do we continue with the current ZONE_DEVICE model, or do we come up
>>     with something new?
>>
>>
> 
> Point 2 is what I proposed talking about here:
> https://lore.kernel.org/linux-mm/a80a4d4b-25aa-a38a-884f-9f119c03a1da@google.com/T/
> 
> With the current cxl-as-numa-node model, an application can express a
> preference through mbind(). But that also means that mempolicy and
> madvise (e.g. MADV_COLD) are starting to overlap if the intention is
> to use cxl as a second tier for colder memory.  Are these the right
> abstractions? Might it be more flexible to attach properties to memory
> ranges, and have applications hint which properties they prefer?

I think history told us that the discussions always go like "but user 
space wants more control, let's give user space all the power", and a 
couple of months later we get "but we cannot possibly enlighten all 
applications, and user space does not have sufficient information: we 
need the kernel to handle this transparently."

It seems to be a steady back and forth. Most probably we want something 
in between: cxl-as-numa-node model is already a pretty good and 
simplistic abstractions. Avoid too many new special user-space knobs is 
most probably the way to go.

Interesting discussion, I agree. And we had plenty of similar ones 
already with PMEM and NUMA in general.

-- 
Thanks,

David / dhildenb

