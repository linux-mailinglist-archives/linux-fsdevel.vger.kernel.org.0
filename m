Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4314D424E12
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 09:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240248AbhJGHaB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 03:30:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232512AbhJGHaB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 03:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633591687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ry165nxVbeeGg5gTu6DIc5396l+Gq9PRR2heRwKdlqs=;
        b=TzixtcL+urq/sfEt1bTOlHTHTYXv/pNYIvELC8hZiLEeClrHqriaOiXiApwFDcNHV6UOE0
        w96/57n5xJOTwwhjKYXiGDRau92tmG4MXBMtu1jOxpm7mBOa7ijK8zGqIpzOnmqRZ3Zxvn
        zfDCWoPzLiZCuoVQQZjABWuqPec/ykM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-ZRSF9rRKOKKc2fmAJVVOEw-1; Thu, 07 Oct 2021 03:27:43 -0400
X-MC-Unique: ZRSF9rRKOKKc2fmAJVVOEw-1
Received: by mail-wr1-f71.google.com with SMTP id 41-20020adf812c000000b00160dfbfe1a2so264157wrm.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 00:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ry165nxVbeeGg5gTu6DIc5396l+Gq9PRR2heRwKdlqs=;
        b=Edwcr2KqowlhZ/xWs4ICeE1fXAvhcP8W93MK321CDg7A3u1c3UPe2dhfzddgq0LPKw
         doBN2aVPfaOtp88lZ9QE2iJ1ZbL96U9HIz6IC0SvJ/v3INUnGb0xpsLo4PE5hrKZzK94
         utP1KdS951CR461z/Z4z+zS/+70H/SWjgaA/ghygwCyF+9Rrgs61/eg6EgeHNRMISnuk
         rigX5yI/INTUBeI96b6AlexaeCH6/HF9bm37nwLbHkDo4TM73B6Gok/tNV0z3eo/dAKr
         p3nrJwzo8HY9rNCI1uhtEfF2DTS/Za610QG7q9jbDcErwkxjfutCkVYMC84T/31lJSoe
         y9+Q==
X-Gm-Message-State: AOAM533gXJC9Y8f9J0Uhd0iCUyxLNvkW2OVSgbxx31Om7jRT9twXkUL+
        jnJrKFM+LA6bim2LTK15cdLJw/DChYAMQfxhIMECC1EKw/+OINivP+tQ0fIbhxMPgvjYHs25Kz6
        GLNja4pV5CtzF/xd+6SOCqwvY7w==
X-Received: by 2002:a7b:cc88:: with SMTP id p8mr2933859wma.101.1633591662039;
        Thu, 07 Oct 2021 00:27:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfPPQ0UhVVfB2g4Qm80BYGgXuhoWg2b+qdl06xZYcuNFTPFP6YKFU3oUjgAf+DGohOTWKv8Q==
X-Received: by 2002:a7b:cc88:: with SMTP id p8mr2933796wma.101.1633591661824;
        Thu, 07 Oct 2021 00:27:41 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6886.dip0.t-ipconnect.de. [91.12.104.134])
        by smtp.gmail.com with ESMTPSA id s14sm949540wro.76.2021.10.07.00.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 00:27:41 -0700 (PDT)
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
To:     Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, John Hubbard <jhubbard@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Colin Cross <ccross@google.com>,
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
        Chinwen Chang <chinwen.chang@mediatek.com>,
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
        cxfcosmos@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Tim Murray <timmurray@google.com>
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
 <20211006192927.f7a735f1afe4182bf4693838@linux-foundation.org>
 <CAJuCfpGLQK5aVe5zQfdkP=K4NBZXPjtG=ycjk3E4D64CAvVPsg@mail.gmail.com>
 <20211006195342.0503b3a3cbcd2c3c3417df46@linux-foundation.org>
 <CAJuCfpEZzrN+V2g4+RsRs5v3e60RGvXOCk_X9e3wWkeMBZProg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <3645f74d-54b4-9223-1d53-75cade471fad@redhat.com>
Date:   Thu, 7 Oct 2021 09:27:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJuCfpEZzrN+V2g4+RsRs5v3e60RGvXOCk_X9e3wWkeMBZProg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07.10.21 05:01, Suren Baghdasaryan wrote:
> On Wed, Oct 6, 2021 at 7:53 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Wed, 6 Oct 2021 19:46:57 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
>>
>>>>>>> I wish it was that simple and for some names like [anon:.bss] or
>>>>>>> [anon:dalvik-zygote space] reserving a unique id would work, however
>>>>>>> some names like [anon:dalvik-/system/framework/boot-core-icu4j.art]
>>>>>>> are generated dynamically at runtime and include package name.
>>>>>>
>>>>>> Valuable information
>>>>>
>>>>> Yeah, I should have described it clearer the first time around.
>>>>
>>>> If it gets this fancy then the 80 char limit is likely to become a
>>>> significant limitation and the choice should be explained & justified.
>>>>
>>>> Why not 97?  1034?  Why not just strndup_user() and be done with it?
>>>
>>> The original patch from 8 years ago used 256 as the limit but Rasmus
>>> argued that the string content should be human-readable, so 80 chars
>>> seems to be a reasonable limit (see:
>>> https://lore.kernel.org/all/d8619a98-2380-ca96-001e-60fe9c6204a6@rasmusvillemoes.dk),
>>> which makes sense to me. We should be able to handle the 80 char limit
>>> by trimming it before calling prctl().
>>
>> What's the downside to making it unlimited?
> 
> If we ignore the human-readability argument, I guess the possibility
> of abuse and increased memory consumption? I'm guessing parsing such a
> string is also easier if there is a known limit?

64k * 80 bytes already makes me nervous enough :)


-- 
Thanks,

David / dhildenb

