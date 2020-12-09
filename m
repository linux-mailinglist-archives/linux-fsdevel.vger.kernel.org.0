Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1770C2D3F0E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 10:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgLIJpO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 04:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbgLIJpO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:45:14 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CCFC0613D6
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Dec 2020 01:44:34 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 131so652119pfb.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 01:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfvm5fXTz5ubcwIn8BzSkwLy3ZTr87nHqelVwd15V9g=;
        b=MnwiYzHgJ5r0N7rGYnF+LzMQf8/k2y4A4sCmBj7aCWy1sofWibzNsQKk+Vy9z6ZKM9
         Pzg04aU0YadFRpXEGjHD/fHQ1c15Z850iXrYYH7ayPNustv2vJR8ekws98hkt51WM/mL
         cEJB7Vc5LYhB1LS+I77IqqRxhWusDLKzCMp+eGKCeF8rSvdFBlsRjLHPlwlkcsWsPks6
         VTmGfr5cFIWytsrrz3eSyRqlgYKRwE7HtzOJlbaIkGHGRXQryOzfncnyExBMCOxP8jmx
         EKnllaEYSStd11vmyDYuJ5TnE+0Lx7uzn7voJshRSfmrGPIwP5inT9PwctxMyc9Bg02q
         sZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfvm5fXTz5ubcwIn8BzSkwLy3ZTr87nHqelVwd15V9g=;
        b=U+3CnNWDlBHWC094wVjEbsGWhGC4mJwQOyYwkp0iiu3+4Phl19l/f0Po+u2T6YZZ/p
         ++ykfxrwi74xwANfF37QO/prypI1FE7NyMwZqlEo0i6LRsdw2gdw2gWkN3Hl57Ys7rf5
         mrT0r2IYEMJ/NA8q0iMFZvjOvEL4HC5kQClHaWWHpQHO3wrWcO5J1XrYjzm09THLfrTm
         yglB2gPaagWQpNTjhU0fUBUS8OhLdDmHusxT/yYiL8BesgzaB958SCg8Veuip4mVqxle
         sc/iwSmLkK9/mTAvmcv9I5oEbCZwvWgTCd4JbNfBlo9nlb2bglPbSFLqu8l/zKaPIcmI
         RL7w==
X-Gm-Message-State: AOAM530Gvyrlwt0bxqRY2fkbDtbvoYisQ3zLCC2KyRbVLKL0jW/cyn3v
        obZwlTqWYE0TgfDigT3zeO/FfUwAB3W0fRh/yxLfvg==
X-Google-Smtp-Source: ABdhPJzcJdhojJpXVfSNU4qNhSr+vBOR6o0JD9ATM/ZWrBV4K8Ymc7R7qMxPWpVfMqyY9XB8ySzlfXfQ+IW1rSVwFzc=
X-Received: by 2002:a63:c15:: with SMTP id b21mr1190022pgl.341.1607507073559;
 Wed, 09 Dec 2020 01:44:33 -0800 (PST)
MIME-Version: 1.0
References: <20201130151838.11208-1-songmuchun@bytedance.com>
 <20201130151838.11208-6-songmuchun@bytedance.com> <17abb7bb-de39-7580-b020-faec58032de9@redhat.com>
 <CAMZfGtWepk0EXc_fCtS83gvhfKpMrXxP8k3oWwfhWKmPJ3jjwA@mail.gmail.com>
 <096ee806-b371-c22b-9066-8891935fbd5e@redhat.com> <CAMZfGtU-zpPRkSikcYZUhKvWhpwZ+cspXNhoaok9e6MCE2pk-g@mail.gmail.com>
 <73832edd-13ec-8032-d8d6-4afc53297fdb@redhat.com>
In-Reply-To: <73832edd-13ec-8032-d8d6-4afc53297fdb@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 9 Dec 2020 17:43:56 +0800
Message-ID: <CAMZfGtU_hCVfdfWZ3yZuMC5_MH4O=Hx_RXuxb9YaypL6-pvZ1Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v7 05/15] mm/bootmem_info: Introduce {free,prepare}_vmemmap_page()
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

On Wed, Dec 9, 2020 at 5:33 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 09.12.20 10:25, Muchun Song wrote:
> > On Wed, Dec 9, 2020 at 4:50 PM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 09.12.20 08:36, Muchun Song wrote:
> >>> On Mon, Dec 7, 2020 at 8:39 PM David Hildenbrand <david@redhat.com> wrote:
> >>>>
> >>>> On 30.11.20 16:18, Muchun Song wrote:
> >>>>> In the later patch, we can use the free_vmemmap_page() to free the
> >>>>> unused vmemmap pages and initialize a page for vmemmap page using
> >>>>> via prepare_vmemmap_page().
> >>>>>
> >>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >>>>> ---
> >>>>>  include/linux/bootmem_info.h | 24 ++++++++++++++++++++++++
> >>>>>  1 file changed, 24 insertions(+)
> >>>>>
> >>>>> diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
> >>>>> index 4ed6dee1adc9..239e3cc8f86c 100644
> >>>>> --- a/include/linux/bootmem_info.h
> >>>>> +++ b/include/linux/bootmem_info.h
> >>>>> @@ -3,6 +3,7 @@
> >>>>>  #define __LINUX_BOOTMEM_INFO_H
> >>>>>
> >>>>>  #include <linux/mmzone.h>
> >>>>> +#include <linux/mm.h>
> >>>>>
> >>>>>  /*
> >>>>>   * Types for free bootmem stored in page->lru.next. These have to be in
> >>>>> @@ -22,6 +23,29 @@ void __init register_page_bootmem_info_node(struct pglist_data *pgdat);
> >>>>>  void get_page_bootmem(unsigned long info, struct page *page,
> >>>>>                     unsigned long type);
> >>>>>  void put_page_bootmem(struct page *page);
> >>>>> +
> >>>>> +static inline void free_vmemmap_page(struct page *page)
> >>>>> +{
> >>>>> +     VM_WARN_ON(!PageReserved(page) || page_ref_count(page) != 2);
> >>>>> +
> >>>>> +     /* bootmem page has reserved flag in the reserve_bootmem_region */
> >>>>> +     if (PageReserved(page)) {
> >>>>> +             unsigned long magic = (unsigned long)page->freelist;
> >>>>> +
> >>>>> +             if (magic == SECTION_INFO || magic == MIX_SECTION_INFO)
> >>>>> +                     put_page_bootmem(page);
> >>>>> +             else
> >>>>> +                     WARN_ON(1);
> >>>>> +     }
> >>>>> +}
> >>>>> +
> >>>>> +static inline void prepare_vmemmap_page(struct page *page)
> >>>>> +{
> >>>>> +     unsigned long section_nr = pfn_to_section_nr(page_to_pfn(page));
> >>>>> +
> >>>>> +     get_page_bootmem(section_nr, page, SECTION_INFO);
> >>>>> +     mark_page_reserved(page);
> >>>>> +}
> >>>>
> >>>> Can you clarify in the description when exactly these functions are
> >>>> called and on which type of pages?
> >>>>
> >>>> Would indicating "bootmem" in the function names make it clearer what we
> >>>> are dealing with?
> >>>>
> >>>> E.g., any memory allocated via the memblock allocator and not via the
> >>>> buddy will be makred reserved already in the memmap. It's unclear to me
> >>>> why we need the mark_page_reserved() here - can you enlighten me? :)
> >>>
> >>> Sorry for ignoring this question. Because the vmemmap pages are allocated
> >>> from the bootmem allocator which is marked as PG_reserved. For those bootmem
> >>> pages, we should call put_page_bootmem for free. You can see that we
> >>> clear the PG_reserved in the put_page_bootmem. In order to be consistent,
> >>> the prepare_vmemmap_page also marks the page as PG_reserved.
> >>
> >> I don't think that really makes sense.
> >>
> >> After put_page_bootmem() put the last reference, it clears PG_reserved
> >> and hands the page over to the buddy via free_reserved_page(). From that
> >> point on, further get_page_bootmem() would be completely wrong and
> >> dangerous.
> >>
> >> Both, put_page_bootmem() and get_page_bootmem() rely on the fact that
> >> they are dealing with memblock allcoations - marked via PG_reserved. If
> >> prepare_vmemmap_page() would be called on something that's *not* coming
> >> from the memblock allocator, it would be completely broken - or am I
> >> missing something?
> >>
> >> AFAIKT, there should rather be a BUG_ON(!PageReserved(page)) in
> >> prepare_vmemmap_page() - or proper handling to deal with !memblock
> >> allocations.
> >>
> >
> > I want to allocate some pages as the vmemmap when
> > we free a HugeTLB page to the buddy allocator. So I use
> > the prepare_vmemmap_page() to initialize the page (which
> > allocated from buddy allocator) and make it as the vmemmap
> > of the freed HugeTLB page.
> >
> > Any suggestions to deal with this case?
>
> If you obtained pages via the buddy, there shouldn't be anything special
> to handle, no? What speaks against
>
>
> prepare_vmemmap_page():
> if (!PageReserved(page))
>         return;
>
>
> put_page_bootmem():
> if (!PageReserved(page))
>         __free_page();
>

Thanks.

>
> Or if we care about multiple references, get_page() and put_page().
>
> >
> > I have a solution to address this. When the pages allocated
> > from the buddy as vmemmap pages,  we do not call
> > prepare_vmemmap_page().
> >
> > When we free some vmemmap pages of a HugeTLB
> > page, if the PG_reserved of the vmemmap page is set,
> > we call free_vmemmap_page() to free it to buddy,
> > otherwise call free_page(). What is your opinion?
>
> That would also work. Then, please include "bootmem" as part of the
> function name. If you plan on using my suggestion, you can drop
> "bootmem" from the name as it works for both types of pages.
>

Agree. Thanks.

>
> --
> Thanks,
>
> David / dhildenb
>


-- 
Yours,
Muchun
