Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F235F2D3FC7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 11:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgLIKR5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 05:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbgLIKR5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:17:57 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D340AC061794
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Dec 2020 02:17:16 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id p6so686491plo.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 02:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i6nki0stxvDLMDU16G+h85cVFW5HA5XUXV7cTIWJJr0=;
        b=pvUndUzCm8phQVX+DQW2QbqJ6hP9Mo1rCH6uiOZCqqpSNGU9AL8BzqhYf42rozN7IS
         l5Yzs+0CjrRX0Z6S4G66CTxWCnl793hSRan0/U/azt8MSlaLczL2lfXWVh/tF4TE0cMK
         k/Y4ljOcfwGflRPHG/C7BHPw2td3XFUEFUYEVDupOvEb9FhIMV6eI7ZvF1G+BaqnuiWu
         6FfASOuRfrMdUUyOTrK5OtqN11+ZF/sWPIl22uwKKkTupgFH6BAdoV04vtfaqR8FdjQ7
         xlcPF0pW0V6Plql9HIJolEdv59J2SxcKJwjFLEr7gDNWWqzwQYvgLmZCtR9Xld+G24IZ
         6cpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i6nki0stxvDLMDU16G+h85cVFW5HA5XUXV7cTIWJJr0=;
        b=AqtN/oag0df+9VKDYEkT//e6zFuMiKfD6YWzs+jfq80YKAFrsUx77UxS6ivaHaOdJP
         Qd6exlWXJ8qblTr+4Qka7eSDW+id6jV4IpeVQA0+0EW+4Y/ZYv0azfJxfhKsaQokPKqg
         g5XeggH9sOL+OPa6SLr2COMig57thb9rP3KXCdx+09qxXk/p9caiDU4YgvSdpz5PRM27
         hn39RDDBVJRWHeNFLQhqP5qB9afHBYHN6hvrs7xRuLyCWuHvkG+oXT6oNi0ABCwhruKe
         v9SL4OgLv5jhAtQBXxyx4VsZSfp+4Yk+S3+dPJHwu2S32Hykuu4oTIygJmkpSESIbLf9
         /Fbw==
X-Gm-Message-State: AOAM533ZYj4qneF0bNqnY/h5Ta0PGuG34T1+mAdhUPiihw3PmxW7NBDy
        2pKRsEQ2TjvUZLVCEuq1ZVxxV0dH8CjfmzZ5l8QjEw==
X-Google-Smtp-Source: ABdhPJwl0QKoTLMWry62ykQQQg/oA1aCc3XrZuGoJQcckNVK8qnVxEk3a+7jD8/okgrNoYprcRELUScKGF6oOLWx0fQ=
X-Received: by 2002:a17:902:ed0d:b029:da:c83b:5f40 with SMTP id
 b13-20020a170902ed0db02900dac83b5f40mr1585560pld.20.1607509036409; Wed, 09
 Dec 2020 02:17:16 -0800 (PST)
MIME-Version: 1.0
References: <20201130151838.11208-1-songmuchun@bytedance.com>
 <20201130151838.11208-7-songmuchun@bytedance.com> <ba57ea7d-709b-bf36-d48a-cc72a26012cc@redhat.com>
 <CAMZfGtV5200NZXH9Z_Z9qXo5FCd9E6JOTXjQtzcF0xGi-gCuPg@mail.gmail.com>
 <4b8a9389-1704-4d8c-ec58-abd753814dd9@redhat.com> <a6d11bc6-033d-3a0b-94ce-cbd556120b6d@redhat.com>
In-Reply-To: <a6d11bc6-033d-3a0b-94ce-cbd556120b6d@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 9 Dec 2020 18:16:40 +0800
Message-ID: <CAMZfGtV9YnrLTosxz+wj_KEc+17iPWhfKmUB+P4CrKqcN_63dA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v7 06/15] mm/hugetlb: Disable freeing
 vmemmap if struct page size is not power of two
To:     David Hildenbrand <david@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 9, 2020 at 6:10 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 09.12.20 11:06, David Hildenbrand wrote:
> > On 09.12.20 11:03, Muchun Song wrote:
> >> On Wed, Dec 9, 2020 at 5:57 PM David Hildenbrand <david@redhat.com> wrote:
> >>>
> >>> On 30.11.20 16:18, Muchun Song wrote:
> >>>> We only can free the tail vmemmap pages of HugeTLB to the buddy allocator
> >>>> when the size of struct page is a power of two.
> >>>>
> >>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >>>> ---
> >>>>  mm/hugetlb_vmemmap.c | 5 +++++
> >>>>  1 file changed, 5 insertions(+)
> >>>>
> >>>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> >>>> index 51152e258f39..ad8fc61ea273 100644
> >>>> --- a/mm/hugetlb_vmemmap.c
> >>>> +++ b/mm/hugetlb_vmemmap.c
> >>>> @@ -111,6 +111,11 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
> >>>>       unsigned int nr_pages = pages_per_huge_page(h);
> >>>>       unsigned int vmemmap_pages;
> >>>>
> >>>> +     if (!is_power_of_2(sizeof(struct page))) {
> >>>> +             pr_info("disable freeing vmemmap pages for %s\n", h->name);
> >>>
> >>> I'd just drop that pr_info(). Users are able to observe that it's
> >>> working (below), so they are able to identify that it's not working as well.
> >>
> >> The below is just a pr_debug. Do you suggest converting it to pr_info?
> >
> > Good question. I wonder if users really have to know in most cases.
> > Maybe pr_debug() is good enough in environments where we want to debug
> > why stuff is not working as expected.
> >
>
> Oh, another thought, can we glue availability of
> HUGETLB_PAGE_FREE_VMEMMAP (or a new define based on the config and the
> size of a stuct page) to the size of struct page somehow?
>
> I mean, it's known at compile time that this will never work.

Good question. I also thought about this question. Just like the
macro SPINLOCK_SIZE does, we also can generate a new macro
to indicate the size of the struct page. :)

>
> --
> Thanks,
>
> David / dhildenb
>


-- 
Yours,
Muchun
