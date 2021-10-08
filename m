Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478E5426554
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Oct 2021 09:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhJHHqC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Oct 2021 03:46:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54014 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229693AbhJHHqA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Oct 2021 03:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633679045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u7mEpKXIXki4+AfZLhYahWvke1tUWfWxeSdFeF0Y8RQ=;
        b=EjIuBF/m7p67TShfNm1PpNZaPF1rPelqQjlOWQuOYx1LfGozDxPt8wVED9DbwLanwo7DR1
        roY4DN3dm5tqALmuwhfEULceDM5SMoNT8yaUTPLi0D9+4FxD9HDhw0ZRUYb0XiLASv2AMz
        YlbsyQO5V+JiGC04o5AhaWh0A1Z0kv0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-mOhb1t9bP3yg3efuh8hhjA-1; Fri, 08 Oct 2021 03:44:04 -0400
X-MC-Unique: mOhb1t9bP3yg3efuh8hhjA-1
Received: by mail-wr1-f70.google.com with SMTP id r16-20020adfbb10000000b00160958ed8acso6607627wrg.16
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Oct 2021 00:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=u7mEpKXIXki4+AfZLhYahWvke1tUWfWxeSdFeF0Y8RQ=;
        b=iBzAzWeID6KIRTpJJYIg06MbkqEBYNM8a39HHc8IGB7e4NadtCxmcBEE9lFeg0wYyl
         OnDq2s6EH42uxAOSkIRwd8Ed+QZwFUUvHk8CRAlzo8/340x8FJCryDjk9dQ2WzdV+qEh
         X734ob1vYsPFXOK9a8L/NQQ/HB8a4wKLCXFFmINL+xzuPDj7OYblQTmew3//txwzuwLP
         2TWxEhzC2gpz7pCUMkjp1fOSO9h7zzncs9uFFsUJMQJQyMBRNTWiuFG8xrtRn4OCQU2d
         JJRoY4p+J0I8ZbtcxROOgpJMdGgQUo0d4AWEuM93InkM2rv1KENGwe4pjaZCwxQeulFN
         x3Hw==
X-Gm-Message-State: AOAM531YrbLg4OKR1d65wORef+wAMqbqlqZjUamrtmSR1BO89eorm+lB
        cELqlZcxB4Sb5/8K01byFSvMjMvtmohMKrxJ/zGTI1nnY9Me6CjqvC0OqwbgsKMKIMAT9I0xBKB
        z7qvbdVHxQjTl/1TBfj1G1UuBwg==
X-Received: by 2002:a1c:22d7:: with SMTP id i206mr1764276wmi.122.1633679042850;
        Fri, 08 Oct 2021 00:44:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFPZDiPSVeT3d38H8Z/bNS65Xx9+eqy3hlmwhiYjlLCPHXHl/2fm5Cekwbs4vZT55wYV26kg==
X-Received: by 2002:a1c:22d7:: with SMTP id i206mr1764260wmi.122.1633679042645;
        Fri, 08 Oct 2021 00:44:02 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c676e.dip0.t-ipconnect.de. [91.12.103.110])
        by smtp.gmail.com with ESMTPSA id u5sm1676921wrg.57.2021.10.08.00.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 00:44:01 -0700 (PDT)
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        John Hubbard <jhubbard@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Michal Hocko <mhocko@suse.com>, Pavel Machek <pavel@ucw.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
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
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
References: <20211006175821.GA1941@duo.ucw.cz>
 <CAJuCfpGuuXOpdYbt3AsNn+WNbavwuEsDfRMYunh+gajp6hOMAg@mail.gmail.com>
 <YV6rksRHr2iSWR3S@dhcp22.suse.cz>
 <92cbfe3b-f3d1-a8e1-7eb9-bab735e782f6@rasmusvillemoes.dk>
 <20211007101527.GA26288@duo.ucw.cz>
 <CAJuCfpGp0D9p3KhOWhcxMO1wEbo-J_b2Anc-oNwdycx4NTRqoA@mail.gmail.com>
 <YV8jB+kwU95hLqTq@dhcp22.suse.cz>
 <CAJuCfpG-Nza3YnpzvHaS_i1mHds3nJ+PV22xTAfgwvj+42WQNA@mail.gmail.com>
 <YV8u4B8Y9AP9xZIJ@dhcp22.suse.cz>
 <CAJuCfpHAG_C5vE-Xkkrm2kynTFF-Jd06tQoCWehHATL0W2mY_g@mail.gmail.com>
 <202110071111.DF87B4EE3@keescook>
 <CAJuCfpFT7qcLM0ygjbzgCj1ScPDkZvv0hcvHkc40s9wgoTov7A@mail.gmail.com>
 <caa830de-ea66-267d-bafa-369a6175251e@nvidia.com>
 <b606021e-0afa-a509-84c4-2988d77f68bc@rasmusvillemoes.dk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
Message-ID: <eb9fd99e-177e-efe6-667c-f5ff99ad518b@redhat.com>
Date:   Fri, 8 Oct 2021 09:43:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b606021e-0afa-a509-84c4-2988d77f68bc@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08.10.21 09:25, Rasmus Villemoes wrote:
> On 07/10/2021 21.02, John Hubbard wrote:
>> On 10/7/21 11:50, Suren Baghdasaryan wrote:
>> ...
> 
>>>>> The desire is for one of these two parties to be a human who can get
>>>>> the data and use it as is without additional conversions.
>>>>> /proc/$pid/maps could report FD numbers instead of pathnames, which
>>>>> could be converted to pathnames in userspace. However we do not do
>>>>> that because pathnames are more convenient for humans to identify a
>>>>> specific resource. Same logic applies here IMHO.
>>>>
>>>> Yes, please. It really seems like the folks that are interested in this
>>>> feature want strings. (I certainly do.) For those not interested in the
>>>> feature, it sounds like a CONFIG to keep it away would be sufficient.
>>>> Can we just move forward with that?
>>>
>>> Would love to if others are ok with this.
>>>
>>
>> If this doesn't get accepted, then another way forward would to continue
>> the ideas above to their logical conclusion, and create a new file system:
>> vma-fs.
> 
> Or: Why can't the library/application that wants a VMA backed by memory
> to have some associated name not just
> 
>    fd = open("/run/named-vmas/foobar#24", O_CLOEXEC|O_RDWR|O_EXCL|O_CREAT);
>    unlink("/run/named-vmas/foobar#24");
>    ftruncate(fd, ...);
>    mmap(fd);
> 
> where /run/named-vmas is a tmpfs (probably with some per-user/per-app
> subdirs). That requires no changes in the kernel at all. Yes, it lacks
> the automatic cleanup of using real anon mmap in case there's a crash
> between open and unlink, but in an environment like Android that should
> be solvable.

I'm going to point out that we already do have names for memfds.

"The name supplied in name is used as a filename and will be displayed 
as  the  target  of  the corresponding  symbolic  link  in  the 
directory /proc/self/fd/." It's also displayed in /proc/self/maps.

So theoretically, without any kernel changes one might be able to 
achieve something as proposed in this patch via memfd_create().

There is one issue to be fixed:

MAP_PRIVATE on memfd results in a double memory consumption on any 
access via the mapping last time I checked (one page for pagecache, one 
page for private mapping).


-- 
Thanks,

David / dhildenb

