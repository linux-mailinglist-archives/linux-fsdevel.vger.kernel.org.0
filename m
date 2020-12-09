Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030F32D3C6C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 08:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgLIHiB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 02:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgLIHiB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 02:38:01 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79CBC061794
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Dec 2020 23:37:20 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id f9so449828pfc.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Dec 2020 23:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2cICHu+sOCwXeW6iw0ut0I4jknhG6qKw77uMPa9BrME=;
        b=udn54ZQaXLxWJyckaeNBxPfVo2UljovZBUS+oRSUFvvUCAyH5HEeIGMwu2NU/lb6Vh
         Q6TJj/Jr5mEPR/YkLf6/wG9KF1iuHRXQrZdHvAAugCwhnRDuOxCEvuLBxcRO3/KUwwOp
         cvt33y8UczhgGRSTsjlH00EixjOW+95c8TRRRxqb0iHaW4IE/6s7Ubc3HSYXINQjDBd8
         kEZE+uzp0wZoJHSd1eMKCSee7hBjQBjgWS8Q7X316n1wFK0m3VZUOdukYZbTusjQ8klh
         1G+GmJynHKliOdBwA5VmiiGU/U7aJrCES/GeQzSvaDuZthhr2djQxFTylGUdDkqzBeM5
         Pt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2cICHu+sOCwXeW6iw0ut0I4jknhG6qKw77uMPa9BrME=;
        b=cxigPZnePz7HhqjY3S3aafCwEMmgiRF1GcKY/86FhIU1xrAUri4QocUk1cZQsYlg7O
         L5hloyUJB7SGCJccwePrXdJY8Da7BZR2QTjGOcXLdxwpon+MvDADiDDhYAZWJXwRPV0Y
         X/Wva944h1hgBEhLfbLOTeWYnWS543a6+OncayOgjg8xLZpM/eGohLK/dULC010hDIit
         bai+nnnCQ7qWdfAmLwffIdxX34dPma5dX9vAkHCyuGCe8+lacI9sM0dQNYNxeJbfXXWD
         amFlwYm82dC8pR/srtFRgOv++MubDhTM3Tq/kkB84X0C7XJ72NagwkdAd4DSOm3S2NV3
         hOmw==
X-Gm-Message-State: AOAM533J31j9RTaS+X9lYFTab1JProArZODcwAsLCagVHiG8ASd63dV5
        0oH3GD2aISp3GKl7cyEwqbvK9bIub0Q+yU02LxNZ+A==
X-Google-Smtp-Source: ABdhPJzwSm5U2W6VXMUOuUhmk30S9OwGGrhk3XSnR2IzvfloRQjzF8Ftb/J3yX+TKovQ3AU0/xle8qW2iaWTuakvWzw=
X-Received: by 2002:a62:3103:0:b029:19b:d4e8:853c with SMTP id
 x3-20020a6231030000b029019bd4e8853cmr1181160pfx.59.1607499440381; Tue, 08 Dec
 2020 23:37:20 -0800 (PST)
MIME-Version: 1.0
References: <20201130151838.11208-1-songmuchun@bytedance.com>
 <20201130151838.11208-6-songmuchun@bytedance.com> <17abb7bb-de39-7580-b020-faec58032de9@redhat.com>
In-Reply-To: <17abb7bb-de39-7580-b020-faec58032de9@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 9 Dec 2020 15:36:41 +0800
Message-ID: <CAMZfGtWepk0EXc_fCtS83gvhfKpMrXxP8k3oWwfhWKmPJ3jjwA@mail.gmail.com>
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

On Mon, Dec 7, 2020 at 8:39 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 30.11.20 16:18, Muchun Song wrote:
> > In the later patch, we can use the free_vmemmap_page() to free the
> > unused vmemmap pages and initialize a page for vmemmap page using
> > via prepare_vmemmap_page().
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/bootmem_info.h | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
> > index 4ed6dee1adc9..239e3cc8f86c 100644
> > --- a/include/linux/bootmem_info.h
> > +++ b/include/linux/bootmem_info.h
> > @@ -3,6 +3,7 @@
> >  #define __LINUX_BOOTMEM_INFO_H
> >
> >  #include <linux/mmzone.h>
> > +#include <linux/mm.h>
> >
> >  /*
> >   * Types for free bootmem stored in page->lru.next. These have to be in
> > @@ -22,6 +23,29 @@ void __init register_page_bootmem_info_node(struct pglist_data *pgdat);
> >  void get_page_bootmem(unsigned long info, struct page *page,
> >                     unsigned long type);
> >  void put_page_bootmem(struct page *page);
> > +
> > +static inline void free_vmemmap_page(struct page *page)
> > +{
> > +     VM_WARN_ON(!PageReserved(page) || page_ref_count(page) != 2);
> > +
> > +     /* bootmem page has reserved flag in the reserve_bootmem_region */
> > +     if (PageReserved(page)) {
> > +             unsigned long magic = (unsigned long)page->freelist;
> > +
> > +             if (magic == SECTION_INFO || magic == MIX_SECTION_INFO)
> > +                     put_page_bootmem(page);
> > +             else
> > +                     WARN_ON(1);
> > +     }
> > +}
> > +
> > +static inline void prepare_vmemmap_page(struct page *page)
> > +{
> > +     unsigned long section_nr = pfn_to_section_nr(page_to_pfn(page));
> > +
> > +     get_page_bootmem(section_nr, page, SECTION_INFO);
> > +     mark_page_reserved(page);
> > +}
>
> Can you clarify in the description when exactly these functions are
> called and on which type of pages?
>
> Would indicating "bootmem" in the function names make it clearer what we
> are dealing with?
>
> E.g., any memory allocated via the memblock allocator and not via the
> buddy will be makred reserved already in the memmap. It's unclear to me
> why we need the mark_page_reserved() here - can you enlighten me? :)

Sorry for ignoring this question. Because the vmemmap pages are allocated
from the bootmem allocator which is marked as PG_reserved. For those bootmem
pages, we should call put_page_bootmem for free. You can see that we
clear the PG_reserved in the put_page_bootmem. In order to be consistent,
the prepare_vmemmap_page also marks the page as PG_reserved.

Thanks.

>
> --
> Thanks,
>
> David / dhildenb
>


-- 
Yours,
Muchun
