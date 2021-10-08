Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1FA426531
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Oct 2021 09:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhJHH1N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Oct 2021 03:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbhJHH1L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Oct 2021 03:27:11 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F250C061755
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Oct 2021 00:25:15 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j21so17505377lfe.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Oct 2021 00:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EaBStkQbJ/56vDWRGxe1cWvLB2apSJpVfbn9rFFy6VQ=;
        b=PJCmaxvVuKBNAN4Njn5KUcl6g383j4Vb5tnx0nJDv7g7SIS1wkwDlY3kI9KLUtYBGH
         El6Xpm2x6d5DGTbE+erN2bbm2OaVIeIMjX/QNQC9hjV0HRf8ITLHg98hNuiinUeNzZN4
         mmP61pgb8No6pnjZtSHAjQdlM19ljPWW9RzTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EaBStkQbJ/56vDWRGxe1cWvLB2apSJpVfbn9rFFy6VQ=;
        b=XDv7qQtwkDJMCM1xQz+Wxf1Uvpv7JHlmXZ992lagyHuoZ7DNZtcdt8/XbUzEmxnbbK
         qKyHMbtjpU/zPLG/MGS+GJwB/W//tf33HgcVKn2YvBRqfa/KBtLFlILyBFgDcKrGdXX2
         41ID7qk6sT7VHC7L3OyRrWdgVYTSOmmT5uNHSBwBni7ewYfjAChks/58025k0mT2fPoS
         H3QhnqB68uiRnBRMQbBAg5f6LSQZ/SaLElVmd3jRHZWfeIa8ofQ2a+Ak55NRSh3uCJ1D
         UF/kZgc3NQwk1crbuWeudIzDotQLcaBmT2t8v0lz74Mi4MXw8GQhaALwd79qxYf5en+g
         9Ylg==
X-Gm-Message-State: AOAM532RilbMTMTeIUG0cVkb8kQrd6WiPjlDI0KjbH/QY/shSXP3S5hH
        XXI0ucGQ+oXd5OQBg2Jbiz3UyA==
X-Google-Smtp-Source: ABdhPJyws/BVjzbw9wNLNS1RMYaM2JlFjun6Yxax+9odWgUt7MAIeetzTEZOk8KQrENUxaeIcUJSfw==
X-Received: by 2002:a05:6512:ace:: with SMTP id n14mr8818303lfu.460.1633677913738;
        Fri, 08 Oct 2021 00:25:13 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id i12sm168955lfb.234.2021.10.08.00.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 00:25:12 -0700 (PDT)
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
To:     John Hubbard <jhubbard@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Michal Hocko <mhocko@suse.com>, Pavel Machek <pavel@ucw.cz>,
        David Hildenbrand <david@redhat.com>,
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
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <b606021e-0afa-a509-84c4-2988d77f68bc@rasmusvillemoes.dk>
Date:   Fri, 8 Oct 2021 09:25:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <caa830de-ea66-267d-bafa-369a6175251e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/10/2021 21.02, John Hubbard wrote:
> On 10/7/21 11:50, Suren Baghdasaryan wrote:
> ...

>>>> The desire is for one of these two parties to be a human who can get
>>>> the data and use it as is without additional conversions.
>>>> /proc/$pid/maps could report FD numbers instead of pathnames, which
>>>> could be converted to pathnames in userspace. However we do not do
>>>> that because pathnames are more convenient for humans to identify a
>>>> specific resource. Same logic applies here IMHO.
>>>
>>> Yes, please. It really seems like the folks that are interested in this
>>> feature want strings. (I certainly do.) For those not interested in the
>>> feature, it sounds like a CONFIG to keep it away would be sufficient.
>>> Can we just move forward with that?
>>
>> Would love to if others are ok with this.
>>
> 
> If this doesn't get accepted, then another way forward would to continue
> the ideas above to their logical conclusion, and create a new file system:
> vma-fs. 

Or: Why can't the library/application that wants a VMA backed by memory
to have some associated name not just

  fd = open("/run/named-vmas/foobar#24", O_CLOEXEC|O_RDWR|O_EXCL|O_CREAT);
  unlink("/run/named-vmas/foobar#24");
  ftruncate(fd, ...);
  mmap(fd);

where /run/named-vmas is a tmpfs (probably with some per-user/per-app
subdirs). That requires no changes in the kernel at all. Yes, it lacks
the automatic cleanup of using real anon mmap in case there's a crash
between open and unlink, but in an environment like Android that should
be solvable.

Rasmus
