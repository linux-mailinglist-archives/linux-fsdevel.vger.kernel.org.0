Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2375424E20
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 09:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbhJGHfK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 03:35:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60228 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232565AbhJGHfK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 03:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633591996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IcGgFJhn+URtM5zX70uUXK5bzpT3Lent47sXcqP2HJM=;
        b=FyCFxfnezggtY0IafaJ94a8W1eIWRINWWJcM+nt/ate+7i22ctDm9ufzfNluR4j+iATvnG
        kMH4otrrnoWb9d+xPaQiTzwNRw52XOXbYoG0c27ybxbzBGIzlifxs4nsKx//BL6uZdAXF0
        RvgudLW3PTDOlNJQ3Meje+LjjgAdSfI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283--RWPK8BXP5CNU_7gFpJvfg-1; Thu, 07 Oct 2021 03:33:15 -0400
X-MC-Unique: -RWPK8BXP5CNU_7gFpJvfg-1
Received: by mail-wr1-f72.google.com with SMTP id l6-20020adfa386000000b00160c4c1866eso3943490wrb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 00:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IcGgFJhn+URtM5zX70uUXK5bzpT3Lent47sXcqP2HJM=;
        b=1XxpAapK379L7F/CCsGBCpfM84v+GlrdQ5lYZyc0brK7vbYvrvABOaZ5XMtjKccZdv
         VvaPF/2Jt/JVlRzF5vPl7dhR0UJcTG3QWDFbC3ahg4BR9w4kirSbUlgdRI2Qa7dsEX4X
         EMlqslYkbY61qdkaCxtYVgLKgxOlvAVF9kG/jIPWVmlZwrwv71i0pbx9tnMFEr/ytS82
         Je/c/u+1ETjMF0WjHzQMg6vvdgkJCJLpfPCKbwuCKDRAACyNs9sKZO1QjSrONto28QoF
         MhW83TkNiTmaUYQhQvTpCWrVpRorVtntbswIsCuVCWq3QEPWAXd/BWIgYtaUEeOhiuxU
         EiyA==
X-Gm-Message-State: AOAM531MG+aXZNZMTfHVttdnqqs04kHU+ffO5XTeVv6HSdpWPyuTiCJK
        R2HXQxzIib2AzfarxEdo3+fOH6dv79qUNGb0ohLn7n6OHZEZpo0+QPhoDdoNf6bJRMR6Cz5ZxnZ
        j0oamk37H+fUkMDNS61ZO4Sphyg==
X-Received: by 2002:a1c:7dc8:: with SMTP id y191mr2863360wmc.181.1633591993764;
        Thu, 07 Oct 2021 00:33:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwE8uu5BiQUJRBqH4gg1xzkNu2l2F2J06nqsFu854Q1VUXlrztTCS9j5p/4FyrKQnwZ7WGKOA==
X-Received: by 2002:a1c:7dc8:: with SMTP id y191mr2863339wmc.181.1633591993537;
        Thu, 07 Oct 2021 00:33:13 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6886.dip0.t-ipconnect.de. [91.12.104.134])
        by smtp.gmail.com with ESMTPSA id l124sm7732468wml.8.2021.10.07.00.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 00:33:13 -0700 (PDT)
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, John Hubbard <jhubbard@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>, rppt@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        chris.hyser@oracle.com, Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
References: <20211001205657.815551-1-surenb@google.com>
 <20211001205657.815551-3-surenb@google.com>
 <20211005184211.GA19804@duo.ucw.cz>
 <CAJuCfpE5JEThTMhwKPUREfSE1GYcTx4YSLoVhAH97fJH_qR0Zg@mail.gmail.com>
 <20211005200411.GB19804@duo.ucw.cz>
 <CAJuCfpFZkz2c0ZWeqzOAx8KFqk1ge3K-SiCMeu3dmi6B7bK-9w@mail.gmail.com>
 <efdffa68-d790-72e4-e6a3-80f2e194d811@nvidia.com>
 <YV1eCu0eZ+gQADNx@dhcp22.suse.cz>
 <6b15c682-72eb-724d-bc43-36ae6b79b91a@redhat.com>
 <CAJuCfpEPBM6ehQXgzp=g4SqtY6iaC8wuZ-CRE81oR1VOq7m4CA@mail.gmail.com>
 <192438ab-a095-d441-6843-432fbbb8e38a@redhat.com>
 <CAJuCfpH4KT=fOAWsYhaAb_LLg-VwPvL4Bmv32NYuUtZ3Ceo+PA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <cb910cf1-1463-8c4f-384e-8b0096a0e01f@redhat.com>
Date:   Thu, 7 Oct 2021 09:33:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJuCfpH4KT=fOAWsYhaAb_LLg-VwPvL4Bmv32NYuUtZ3Ceo+PA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06.10.21 17:20, Suren Baghdasaryan wrote:
> On Wed, Oct 6, 2021 at 8:08 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 06.10.21 17:01, Suren Baghdasaryan wrote:
>>> On Wed, Oct 6, 2021 at 2:27 AM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 06.10.21 10:27, Michal Hocko wrote:
>>>>> On Tue 05-10-21 23:57:36, John Hubbard wrote:
>>>>> [...]
>>>>>> 1) Yes, just leave the strings in the kernel, that's simple and
>>>>>> it works, and the alternatives don't really help your case nearly
>>>>>> enough.
>>>>>
>>>>> I do not have a strong opinion. Strings are easier to use but they
>>>>> are more involved and the necessity of kref approach just underlines
>>>>> that. There are going to be new allocations and that always can lead
>>>>> to surprising side effects.  These are small (80B at maximum) so the
>>>>> overall footpring shouldn't all that large by default but it can grow
>>>>> quite large with a very high max_map_count. There are workloads which
>>>>> really require the default to be set high (e.g. heavy mremap users). So
>>>>> if anything all those should be __GFP_ACCOUNT and memcg accounted.
>>>>>
>>>>> I do agree that numbers are just much more simpler from accounting,
>>>>> performance and implementation POV.
>>>>
>>>> +1
>>>>
>>>> I can understand that having a string can be quite beneficial e.g., when
>>>> dumping mmaps. If only user space knows the id <-> string mapping, that
>>>> can be quite tricky.
>>>>
>>>> However, I also do wonder if there would be a way to standardize/reserve
>>>> ids, such that a given id always corresponds to a specific user. If we
>>>> use an uint64_t for an id, there would be plenty room to reserve ids ...
>>>>
>>>> I'd really prefer if we can avoid using strings and instead using ids.
>>>
>>> I wish it was that simple and for some names like [anon:.bss] or
>>> [anon:dalvik-zygote space] reserving a unique id would work, however
>>> some names like [anon:dalvik-/system/framework/boot-core-icu4j.art]
>>> are generated dynamically at runtime and include package name.
>>
>> Valuable information
> 
> Yeah, I should have described it clearer the first time around.
> 
>>
>>> Packages are constantly evolving, new ones are developed, names can
>>> change, etc. So assigning a unique id for these names is not really
>>> feasible.
>>
>> So, you'd actually want to generate/reserve an id for a given string at
>> runtime, assign that id to the VMA, and have a way to match id <->
>> string somehow?
> 
> If we go with ids then yes, that is what we would have to do.
> 
>> That reservation service could be inside the kernel or even (better?) in
>> user space. The service could for example de-duplicates strings.
> 
> Yes but it would require an IPC call to that service potentially on
> every mmap() when we want to name a mapped vma. This would be
> prohibitive. Even on consumption side, instead of just dumping
> /proc/$pid/maps we would have to parse the file and convert all
> [anon:id] into [anon:name] with each conversion requiring an IPC call
> (assuming no id->name pair caching on the client side).

mmap() and prctl() already do take the mmap sem in write, so they are 
not the "most lightweight" operations so to say.

We already to have two separate operations, first the mmap(), then the 
prctl(). IMHO you could defer the "naming" part to a later point in 
time, without creating too many issues, moving it out of the 
"hot/performance critical phase"

Reading https://lwn.net/Articles/867818/, to me it feels like the use 
case could live with a little larger delay between the mmap popping up 
and a name getting assigned.

-- 
Thanks,

David / dhildenb

