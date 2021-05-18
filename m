Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D908F3876A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 12:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348555AbhERKhB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 06:37:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348547AbhERKg7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 06:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621334141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4vp8lNy9snZR0aaM1NkHvO7WK4qnZ3T1+NZIbLJBP3o=;
        b=IqXaHFo9zpj78XNPpcpDfJf4LPFKu0hP1fZbJXefD6Lnr/sM3c/nnVQOTnNm1kCoWUOQOB
        +5Ik0wgU6Og+rTEa0X9VRjxXLQn01jeSWAfSkO/bws4qSBV2t2cd9FimKdhL3dECNr7eZC
        SlU522kqhceEUPsWUrGp7VFVsxoVuOQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-Qts21CFCPLCwXl4nZ11fNA-1; Tue, 18 May 2021 06:35:40 -0400
X-MC-Unique: Qts21CFCPLCwXl4nZ11fNA-1
Received: by mail-wm1-f70.google.com with SMTP id k188-20020a1c24c50000b0290174eacd2b39so788390wmk.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 May 2021 03:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4vp8lNy9snZR0aaM1NkHvO7WK4qnZ3T1+NZIbLJBP3o=;
        b=Cg6m+dhrd2JaKGmhhDVMnzUM3j/nnCKtgk1rOUQk45qTIQHAD/LckdQPZGaq7IizRK
         V4nyh2+t8YnYIbM9yGceArm8bwV1SLb5vgfgGflZ1iE+IPmgshfpSj9fcS0uJStGm1bz
         RjbdX9mhd/VDID+77Peh4ZD17RNsrx5LGJ8E/FML7GYO83blaMQHrKrFlSU1h8tcQcoy
         jEMBM+Mj9UObjtE+qckKxaaP9xbQJkFYdLsrY3kWP0YzAa47Nu2q8K3YLFAk0892wQ3B
         q2A/jlJzFxlSKwuWce/SzTpnwBpD6PzziKU5jciPL6JEvJy/YHZc2m2ihO5ne27EAc8a
         I2Ug==
X-Gm-Message-State: AOAM532MZHpGkrv7ZlUIkNsJXCz5LfjKcQkawKAQZ1pArZa+z/Ckj12h
        7NSm1vKlJQmnyV2802JM0udr4YO7XbxphSb7JsrEW7Fji9z7NeRuWQBD3ymp3cnXYFcLICyHSe5
        oFAq67P8BWZpxVm0j5H+0JGbVhw==
X-Received: by 2002:a5d:4c91:: with SMTP id z17mr6097363wrs.349.1621334139164;
        Tue, 18 May 2021 03:35:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwivDOaaOEtmmfekeSrzIxF+whFkS4KLINBSXbPJdxKCFo9r8ATuUwdqMoXxsMMTM3AMH6k8g==
X-Received: by 2002:a5d:4c91:: with SMTP id z17mr6097320wrs.349.1621334138962;
        Tue, 18 May 2021 03:35:38 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64fd.dip0.t-ipconnect.de. [91.12.100.253])
        by smtp.gmail.com with ESMTPSA id s15sm1725827wrt.54.2021.05.18.03.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 03:35:38 -0700 (PDT)
Subject: Re: [PATCH v19 5/8] mm: introduce memfd_secret system call to create
 "secret" memory areas
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-6-rppt@kernel.org>
 <b625c5d7-bfcc-9e95-1f79-fc8b61498049@redhat.com>
 <YKDJ1L7XpJRQgSch@kernel.org> <YKOP5x8PPbqzcsdK@dhcp22.suse.cz>
 <8e114f09-60e4-2343-1c42-1beaf540c150@redhat.com>
 <YKOXbNWvUsqM4uxb@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <00644dd8-edac-d3fd-a080-0a175fa9bf13@redhat.com>
Date:   Tue, 18 May 2021 12:35:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKOXbNWvUsqM4uxb@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18.05.21 12:31, Michal Hocko wrote:
> On Tue 18-05-21 12:06:42, David Hildenbrand wrote:
>> On 18.05.21 11:59, Michal Hocko wrote:
>>> On Sun 16-05-21 10:29:24, Mike Rapoport wrote:
>>>> On Fri, May 14, 2021 at 11:25:43AM +0200, David Hildenbrand wrote:
>>> [...]
>>>>>> +		if (!page)
>>>>>> +			return VM_FAULT_OOM;
>>>>>> +
>>>>>> +		err = set_direct_map_invalid_noflush(page, 1);
>>>>>> +		if (err) {
>>>>>> +			put_page(page);
>>>>>> +			return vmf_error(err);
>>>>>
>>>>> Would we want to translate that to a proper VM_FAULT_..., which would most
>>>>> probably be VM_FAULT_OOM when we fail to allocate a pagetable?
>>>>
>>>> That's what vmf_error does, it translates -ESOMETHING to VM_FAULT_XYZ.
>>>
>>> I haven't read through the rest but this has just caught my attention.
>>> Is it really reasonable to trigger the oom killer when you cannot
>>> invalidate the direct mapping. From a quick look at the code it is quite
>>> unlikely to se ENOMEM from that path (it allocates small pages) but this
>>> can become quite sublte over time. Shouldn't this simply SIGBUS if it
>>> cannot manipulate the direct mapping regardless of the underlying reason
>>> for that?
>>>
>>
>> OTOH, it means our kernel zones are depleted, so we'd better reclaim somehow
>> ...
> 
> Killing a userspace seems to be just a bad way around that.
> 
> Although I have to say openly that I am not a great fan of VM_FAULT_OOM
> in general. It is usually a a wrong way to tell the handle the failure
> because it happens outside of the allocation context so you lose all the
> details (e.g. allocation constrains, numa policy etc.). Also whenever
> there is ENOMEM then the allocation itself has already made sure that
> all the reclaim attempts have been already depleted. Just consider an
> allocation with GFP_NOWAIT/NO_RETRY or similar to fail and propagate
> ENOMEM up the call stack. Turning that into the OOM killer sounds like a
> bad idea to me.  But that is a more general topic. I have tried to bring
> this up in the past but there was not much of an interest to fix it as
> it was not a pressing problem...
> 

I'm certainly interested; it would mean that we actually want to try 
recovering from VM_FAULT_OOM in various cases, and as you state, we 
might have to supply more information to make that work reliably.

Having that said, I guess what we have here is just the same as when our 
process fails to allocate a generic page table in __handle_mm_fault(), 
when we fail p4d_alloc() and friends ...

-- 
Thanks,

David / dhildenb

