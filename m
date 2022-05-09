Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AC6520818
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 01:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiEIXFF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 19:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiEIXFD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 19:05:03 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC883201B7;
        Mon,  9 May 2022 16:01:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so590318pju.2;
        Mon, 09 May 2022 16:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3wjTsNgGTbqo93VZ7WQqIzRo69K2ztIE7VB0kIveUIY=;
        b=eY+nTpoTAV6KdH3sGRJea6nsfkhY13HP2V4UXtQDdotoGLN5KdBvZahtliZEkzzW1+
         McZAwGMb7ns2pBZEtLMTJvkJ1Q5tQxnFzxv6JxRpiVPMH45QIQc3qEujkqLNQljSxK47
         M5qcukTNsPQR09Ltlk0JwSKgRp3EmDJ0ENOMm6dEPHsDyDSRfvcu8VxXZY/lVHcIrBbI
         oSs07nf7dLuRtr5uogbOTDL8VJEtpvFftwjieqMG82CT9KygoNShDB/8LBtb4Kbe47qe
         CNZOyAk5b76VB8WhgeFZPEwreIjv0c7cdIGWvsELGC/zYfvwOO/HaE9G1MYlVhMhJ0eG
         IIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3wjTsNgGTbqo93VZ7WQqIzRo69K2ztIE7VB0kIveUIY=;
        b=rr+DVyZ6spki+AIAz4NOonnTWd1HDb10I8AlPP8lZbImbd1GjSQg8ZyOuKG40Oj4o0
         Z+zC6PZfeox3bL87fowbLnbSJS6aEgrhozdTmOhCGmCSiaRB022tAPNQ025M39m7Y5X1
         nU3wrfBbLSYktu6wuYzoODkHovEdQo9wC94NrXqsb7zzNXh3lsKMvC3iVQS8y+G8cQ5I
         0KZAKsGayyeKkqY4YZcIP68CyHpOyCEd3yjs9rW8CgmKwTtLLOzNHkDcKEcg0hYQXmQA
         YKpU3o9XGXYCVxn5fi2RtLRZhcEJHtHlBYGUdy98WNW36cO7antLT+Uv097Xg+2mQxs7
         Q/3Q==
X-Gm-Message-State: AOAM532FukVjDhk5L2P675SF87aiThxlV/abRQzMQqVA9iusyHikkYnz
        g3j6q1sfsKHcjuwBwZ4EADJsbkDZfeMiK9NgR56FrqF/
X-Google-Smtp-Source: ABdhPJwIXcYLr+1eT3XpbjjUvzOolBCzj0C2kDIT7os3945SAliOl2gaPLsAZWDMuLENaMYMZSkrmAImliZfTx0UM8E=
X-Received: by 2002:a17:90b:1b52:b0:1dc:54ea:ac00 with SMTP id
 nv18-20020a17090b1b5200b001dc54eaac00mr28624845pjb.99.1652137267310; Mon, 09
 May 2022 16:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220404200250.321455-1-shy828301@gmail.com> <20220404200250.321455-7-shy828301@gmail.com>
 <f304299d-e533-ed18-e247-6dec928ce3b0@suse.cz>
In-Reply-To: <f304299d-e533-ed18-e247-6dec928ce3b0@suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 9 May 2022 16:00:54 -0700
Message-ID: <CAHbLzkrkra4ip2ovJg7YWhKwZJaLNZXH-X2D+20fy_k4c+jWCQ@mail.gmail.com>
Subject: Re: [v3 PATCH 6/8] mm: khugepaged: move some khugepaged_* functions
 to khugepaged.c
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 9, 2022 at 8:31 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 4/4/22 22:02, Yang Shi wrote:
> > To reuse hugepage_vma_check() for khugepaged_enter() so that we could
> > remove some duplicate code.  But moving hugepage_vma_check() to
> > khugepaged.h needs to include huge_mm.h in it, it seems not optimal to
> > bloat khugepaged.h.
> >
> > And the khugepaged_* functions actually are wrappers for some non-inline
> > functions, so it seems the benefits are not too much to keep them inline.
> >
> > So move the khugepaged_* functions to khugepaged.c, any callers just
> > need to include khugepaged.h which is quite small.  For example, the
> > following patches will call khugepaged_enter() in filemap page fault path
> > for regular filesystems to make readonly FS THP collapse more consistent.
> > The  filemap.c just needs to include khugepaged.h.
>
> This last part is inaccurate in v3?

Yeah, thanks for catching this. Since the patch will be reworked, so
the commit log will be reworked as well.

>
> > Acked-by: Song Liu <song@kernel.org>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
>
> I think moving the tiny wrappers is unnecessary.
>
> How about just making hugepage_vma_check() not static and declare it in
> khugepaged.h, then it can be used from khugepaged_enter() in the same file
> and AFAICS no need to include huge_mm.h there?

Sounds good to me, will fix it in v4. Thanks for reviewing and acking
the series.

>
> > ---
> >  include/linux/khugepaged.h | 37 ++++++-------------------------------
> >  mm/khugepaged.c            | 20 ++++++++++++++++++++
> >  2 files changed, 26 insertions(+), 31 deletions(-)
> >
> > diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> > index 0423d3619f26..6acf9701151e 100644
> > --- a/include/linux/khugepaged.h
> > +++ b/include/linux/khugepaged.h
> > @@ -2,10 +2,6 @@
> >  #ifndef _LINUX_KHUGEPAGED_H
> >  #define _LINUX_KHUGEPAGED_H
> >
> > -#include <linux/sched/coredump.h> /* MMF_VM_HUGEPAGE */
> > -#include <linux/shmem_fs.h>
> > -
> > -
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >  extern struct attribute_group khugepaged_attr_group;
> >
> > @@ -16,6 +12,12 @@ extern void __khugepaged_enter(struct mm_struct *mm);
> >  extern void __khugepaged_exit(struct mm_struct *mm);
> >  extern void khugepaged_enter_vma_merge(struct vm_area_struct *vma,
> >                                      unsigned long vm_flags);
> > +extern void khugepaged_fork(struct mm_struct *mm,
> > +                         struct mm_struct *oldmm);
> > +extern void khugepaged_exit(struct mm_struct *mm);
> > +extern void khugepaged_enter(struct vm_area_struct *vma,
> > +                          unsigned long vm_flags);
> > +
> >  extern void khugepaged_min_free_kbytes_update(void);
> >  #ifdef CONFIG_SHMEM
> >  extern void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr);
> > @@ -33,36 +35,9 @@ static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
> >  #define khugepaged_always()                          \
> >       (transparent_hugepage_flags &                   \
> >        (1<<TRANSPARENT_HUGEPAGE_FLAG))
> > -#define khugepaged_req_madv()                                        \
> > -     (transparent_hugepage_flags &                           \
> > -      (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG))
> >  #define khugepaged_defrag()                                  \
> >       (transparent_hugepage_flags &                           \
> >        (1<<TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG))
> > -
> > -static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
> > -{
> > -     if (test_bit(MMF_VM_HUGEPAGE, &oldmm->flags))
> > -             __khugepaged_enter(mm);
> > -}
> > -
> > -static inline void khugepaged_exit(struct mm_struct *mm)
> > -{
> > -     if (test_bit(MMF_VM_HUGEPAGE, &mm->flags))
> > -             __khugepaged_exit(mm);
> > -}
> > -
> > -static inline void khugepaged_enter(struct vm_area_struct *vma,
> > -                                unsigned long vm_flags)
> > -{
> > -     if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags))
> > -             if ((khugepaged_always() ||
> > -                  (shmem_file(vma->vm_file) && shmem_huge_enabled(vma)) ||
> > -                  (khugepaged_req_madv() && (vm_flags & VM_HUGEPAGE))) &&
> > -                 !(vm_flags & VM_NOHUGEPAGE) &&
> > -                 !test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> > -                     __khugepaged_enter(vma->vm_mm);
> > -}
> >  #else /* CONFIG_TRANSPARENT_HUGEPAGE */
> >  static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
> >  {
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index b69eda934d70..ec5b0a691d87 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -556,6 +556,26 @@ void __khugepaged_exit(struct mm_struct *mm)
> >       }
> >  }
> >
> > +void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
> > +{
> > +     if (test_bit(MMF_VM_HUGEPAGE, &oldmm->flags))
> > +             __khugepaged_enter(mm);
> > +}
> > +
> > +void khugepaged_exit(struct mm_struct *mm)
> > +{
> > +     if (test_bit(MMF_VM_HUGEPAGE, &mm->flags))
> > +             __khugepaged_exit(mm);
> > +}
> > +
> > +void khugepaged_enter(struct vm_area_struct *vma, unsigned long vm_flags)
> > +{
> > +     if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
> > +         khugepaged_enabled())
> > +             if (hugepage_vma_check(vma, vm_flags))
> > +                     __khugepaged_enter(vma->vm_mm);
> > +}
> > +
> >  static void release_pte_page(struct page *page)
> >  {
> >       mod_node_page_state(page_pgdat(page),
>
