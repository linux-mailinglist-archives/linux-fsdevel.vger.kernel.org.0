Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA482D11D5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 14:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgLGNYp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 08:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgLGNYp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:24:45 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C941C0613D2
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Dec 2020 05:23:59 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id l23so7440128pjg.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Dec 2020 05:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ky+I9YkVzigjjr6stcndvMLpkjlk5/E6enUFznI0xXk=;
        b=P34K7+7gmugd3RCndoxHSZmBwWjqQv3lr+RU3A27tiFeJKxAykWlrOPr07RB7o66zG
         cYb/c/eE0KLWrs5GrSbXMMSKbdtAjZ2MRRWh5ndWSP1P4aLF8PBT9NgdHEjJqadOtjbH
         eZaRFlCVVSeQZzDFFqim+bari+CRXDx07Hq3qbkzX5FakwrG/XFfrEgPyYJOjLU3rZ3m
         HsvwSYCxIEIIWdbe3toyI98SqwSN5s57GVIcD29eU1kjLpNE92MUOgdQepdm9qph2i8X
         9OstqP7zx0smn0/yY8wSD+6jUjWZFMJBR41NjBx9xvrjjLCOroYV+60llyFZxW8t7xuB
         nPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ky+I9YkVzigjjr6stcndvMLpkjlk5/E6enUFznI0xXk=;
        b=j/8X2G2ksSzwdfXcD1Mh/s2xudyyYuqHeeD2pKnpNUGjnXqcxinpeWl9nys6E9EcNt
         FJrmTFJxrNbmYxomTtZc2AYVtXvsrm1w5W8U+LZZeRD2LY+FH89EdsD/7ai4SDdVUr6a
         3x5KO4yHNYXWaI++KK6Mjaxf4sn65xRloX6Poz09fQIqwUKK3sieDKhZ9VHAZ/BCK7G+
         h38iRPEPNv8u38DhqZn0cFt9p7Dr9F6Ma+OCp7l50L1D/IDqQjlyQr82AWTP+NjZU9Kd
         5ZkzXdXOQW+hS171qUKhUr7G2GtvjbsqC7N8HclkV6P/hyPKxFNzCA4diAW6S8RvoVv5
         gw9A==
X-Gm-Message-State: AOAM53356XckWs/IotK1LtEd5Btms9w6+vkVHJx8RFLe0huztZ2gWzA7
        zr9FTuSjsEaMlRK3+N2u8LSlV1c1+tIsH3QO5aAaiQ==
X-Google-Smtp-Source: ABdhPJwusQET8H/ZtzbMlFRmNDIDtUwVD9D8y47cTahBIlck/QWVBQr9rJ+XFSKkdsByhbn0oiK+TQ4qvTtVAjvkk2k=
X-Received: by 2002:a17:90a:c588:: with SMTP id l8mr16181556pjt.147.1607347438932;
 Mon, 07 Dec 2020 05:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20201130151838.11208-1-songmuchun@bytedance.com>
 <20201130151838.11208-6-songmuchun@bytedance.com> <17abb7bb-de39-7580-b020-faec58032de9@redhat.com>
In-Reply-To: <17abb7bb-de39-7580-b020-faec58032de9@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 7 Dec 2020 21:23:22 +0800
Message-ID: <CAMZfGtUBe32=wYfR9Nqnq5_Xvb8hHO5j14eyFkRwx5uaS0n=1Q@mail.gmail.com>
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

Will do.

>
> Would indicating "bootmem" in the function names make it clearer what we
> are dealing with?
>
> E.g., any memory allocated via the memblock allocator and not via the
> buddy will be makred reserved already in the memmap. It's unclear to me
> why we need the mark_page_reserved() here - can you enlighten me? :)

Very thanks for your suggestions.

>
> --
> Thanks,
>
> David / dhildenb
>


-- 
Yours,
Muchun
