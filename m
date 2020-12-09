Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8672D452C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 16:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgLIPOX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 10:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgLIPOX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:14:23 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EC0C0613D6
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Dec 2020 07:13:42 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id bj5so1087700plb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 07:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MH2oBtgG7SM/WEjQVktVm6vzkLZc11BiXccpenn6u5w=;
        b=veTVgAoUehNGrKZIOLlBn2vp5nNt2WZg/o23lwAg/fsGibfKfMJcJw3iWo+tUytQzS
         Q4IKHPYhpizNVCD+7+LDs72sFFQSnpYnN33k3SGvTMThqaycRloc+azGCc4UyljH+T8r
         Lg8DJ+rmLIYj1t4VvDnE9WiGPAYNBrOS1EJEtwPaVe6dIXfaq/fettA58rI8RN7EkBUN
         //DVuFJbb92zLltzHOC7cZlRv7a6Gbm3vuhDYlcp+W8gNyPb3fEAqNtyHwcxQ1Jp3cLT
         g0hiyRFhL6I4ib0Ov1mP/mQNVH3ImSWHVnYAt/LYj94DdLGjf0C/E9rzx3kdj1EvzFM5
         c9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MH2oBtgG7SM/WEjQVktVm6vzkLZc11BiXccpenn6u5w=;
        b=UYRQCbpy7JG6JQXWRF3nQxpjD9UXXNEIkxnnLC9tvZ1UN9M0FqEkmjnmuFF41TTRoN
         wPH/bENGBzS+B5KeQ+IRcJjN2O4GBX5E+0pI/qOiroHsP/vU54Hn7zMkL32wU9KT6Ti9
         VnK7f45ukY+BKzw55I+BU8GV1eDqbo+UuIN6vnlCZ7vcZbPsbtOxOGqtMFAFBtIeXodY
         XbRIXRRisEpk75cXaRJf19SS6Mhvh9U2lJIhkelQHs4U7yzLMwAQ0mb+mUvTeY5fPg2J
         f9RfhSflvEZVRLq6VzD6d1BcBWOIo4TcdDJ+qKlBgBlJ6pGb41fDrKnxgPxCK84dDmgL
         5IrQ==
X-Gm-Message-State: AOAM531YPEdDVtP4JvKBnUB3TaA50TeKKPWo0d1w8P+mIPVL7IeLlrQB
        M5eW7eEEsGMooQgqqLRum3sMlQVm92o5fRFi93CzkA==
X-Google-Smtp-Source: ABdhPJzy9V7tyAUDxcV027ueD0F0tNTha+NK7Tvb0IvWRd4/heU72ewIi40CX5slgfRaL4RB5vtjw1qzSz/Nznch+dw=
X-Received: by 2002:a17:902:bb92:b029:d9:e9bf:b775 with SMTP id
 m18-20020a170902bb92b02900d9e9bfb775mr2657733pls.24.1607526822541; Wed, 09
 Dec 2020 07:13:42 -0800 (PST)
MIME-Version: 1.0
References: <20201130151838.11208-1-songmuchun@bytedance.com>
 <20201130151838.11208-7-songmuchun@bytedance.com> <ba57ea7d-709b-bf36-d48a-cc72a26012cc@redhat.com>
 <CAMZfGtV5200NZXH9Z_Z9qXo5FCd9E6JOTXjQtzcF0xGi-gCuPg@mail.gmail.com>
 <4b8a9389-1704-4d8c-ec58-abd753814dd9@redhat.com> <a6d11bc6-033d-3a0b-94ce-cbd556120b6d@redhat.com>
In-Reply-To: <a6d11bc6-033d-3a0b-94ce-cbd556120b6d@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 9 Dec 2020 23:13:06 +0800
Message-ID: <CAMZfGtWfz8DcwKBLdf3j0x9Dt6ZvOd+MvjX6yXrAoKDeXxW95w@mail.gmail.com>
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

I want to define a macro which indicates the size of the
struct page. There is place (kernel/bounds.c) where can
do similar things. When I added the following code in
that file.

        DEFINE(STRUCT_PAGE_SIZE, sizeof(struct page));

Then the compiler will output a message like:

       make[2]: Circular kernel/bounds.s <- include/generated/bounds.h
dependency dropped.

Then I realise that the size of the struct page also depends
on include/generated/bounds.h. But this file is not generated.

Hi David,

Do you have some idea about this?

>
> --
> Thanks,
>
> David / dhildenb
>


-- 
Yours,
Muchun
