Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3291C2DFB7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Dec 2020 12:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgLUL0f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 06:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgLUL0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 06:26:34 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09E5C0613D6
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Dec 2020 03:25:53 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b5so6296462pjl.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Dec 2020 03:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lbzKnUaIGMNM9PDUS9zdXlvtDHAvnDHBTqQ8/7RZubg=;
        b=pZ/y59K3oN1NXzG/P06iSVsj+BwRKPDHbMs/PUQEZcwadZ0cQNDmjdg1mLHIny6Lsy
         mbiYNg3xGMVJ5unMDeeuKP3H0TR7TZF/d7lllD4ACOb4WZU6SMrS0tLbCL0fygOYAbc8
         FXPWzhmnibLpbAgS+fQmxPFiFiemvqdGtxlPE5jCpwhKYRIuTTj3LR2Nfv9ckVhx56yS
         6mzFP6+AEtppG2oYC+xlBibgEAArFMYhKGxjhAmUzlWfFB72KNUp4cafhJ6Je+QGsp7i
         q2gCyiqyDEUsIzB5e8YjSYcGGtGA0DSEqF4Cgzzq1NQj/uV3kOvC7oGNXvksFdPDKOf5
         53wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lbzKnUaIGMNM9PDUS9zdXlvtDHAvnDHBTqQ8/7RZubg=;
        b=Be6C9yTr8Tew+JHZOeSw4J9+dY6zWD+FD0XZklWoN1flBq74QwDL4wYSekbqntHoC5
         +E+LO6/9Yhkglxd8vbVClY66M6LnMILmOmPub1IukVnutZPyIwek4GrnoWtsbotxJe8b
         a7pwM56tk1IElead1ZbanbZjIrAhwuRnMderrNkdyD5rTcGkJtsGmXd2KW+KIX7kb/U+
         MAUE/CepbKnL/Km9PpCO59/NAUa3H3ciJJSrNB+nxAoBhpoaG5XkbmiKINGyVnwJyqmh
         A4GwYviWnhPf1oWebomZFBIIvifDR3QUVc2A/BJ6dWxK7RBOu+PPLOw+1JQVPT8BukF6
         Ek1g==
X-Gm-Message-State: AOAM531qCQ0I8T+h8iE+qNDE3MaI+lNAc13l+cvfomfZeSwQE/PdWuVc
        hRhlKWvCvFhnKjZqV2kWtSOaeK/wpgAQPwrBIrCL7Q==
X-Google-Smtp-Source: ABdhPJxUkJ3MkjyAcOPDYMEhdg7jCDt8LqpLLULIkmvHFjK+/A/pKNvisfJZ3Q96e/qo+1ycnjuS6SDCd+U7Q45wbWU=
X-Received: by 2002:a17:90a:5405:: with SMTP id z5mr17321305pjh.13.1608549953093;
 Mon, 21 Dec 2020 03:25:53 -0800 (PST)
MIME-Version: 1.0
References: <20201217121303.13386-1-songmuchun@bytedance.com>
 <20201217121303.13386-4-songmuchun@bytedance.com> <20201221091123.GB14343@linux>
In-Reply-To: <20201221091123.GB14343@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 21 Dec 2020 19:25:15 +0800
Message-ID: <CAMZfGtVnS=_m4fpGBfDpOpdgzP02QCteUQn-gGiLADWfGiVJ=A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v10 03/11] mm/hugetlb: Free the vmemmap
 pages associated with each HugeTLB page
To:     Oscar Salvador <osalvador@suse.de>
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
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>, naoya.horiguchi@nec.com,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 21, 2020 at 5:11 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Thu, Dec 17, 2020 at 08:12:55PM +0800, Muchun Song wrote:
> > +static inline void free_bootmem_page(struct page *page)
> > +{
> > +     unsigned long magic = (unsigned long)page->freelist;
> > +
> > +     /*
> > +      * The reserve_bootmem_region sets the reserved flag on bootmem
> > +      * pages.
> > +      */
> > +     VM_WARN_ON(page_ref_count(page) != 2);
> > +
> > +     if (magic == SECTION_INFO || magic == MIX_SECTION_INFO)
> > +             put_page_bootmem(page);
> > +     else
> > +             VM_WARN_ON(1);
>
> Ideally, I think we want to see what how the page looks since its state
> is not what we expected, so maybe join both conditions and use dump_page().

Agree. Will do. Thanks.

>
> > + * By removing redundant page structs for HugeTLB pages, memory can returned to
>                                                                      ^^ be

Thanks.

> > + * the buddy allocator for other uses.
>
> [...]
>
> > +void free_huge_page_vmemmap(struct hstate *h, struct page *head)
> > +{
> > +     unsigned long vmemmap_addr = (unsigned long)head;
> > +
> > +     if (!free_vmemmap_pages_per_hpage(h))
> > +             return;
> > +
> > +     vmemmap_remap_free(vmemmap_addr + RESERVE_VMEMMAP_SIZE,
> > +                        free_vmemmap_pages_size_per_hpage(h));
>
> I am not sure what others think, but I would like to see vmemmap_remap_free taking
> three arguments: start, end, and reuse addr, e.g:
>
>  void free_huge_page_vmemmap(struct hstate *h, struct page *head)
>  {
>       unsigned long vmemmap_addr = (unsigned long)head;
>       unsigned long vmemmap_end, vmemmap_reuse;
>
>       if (!free_vmemmap_pages_per_hpage(h))
>               return;
>
>       vmemmap_addr += RESERVE_MEMMAP_SIZE;
>       vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
>       vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
>
>       vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse);
>  }
>
> The reason for me to do this is to let the callers of vmemmap_remap_free decide
> __what__ they want to remap.
>
> More on this below.
>
>
> > +static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
> > +                           unsigned long end,
> > +                           struct vmemmap_remap_walk *walk)
> > +{
> > +     pte_t *pte;
> > +
> > +     pte = pte_offset_kernel(pmd, addr);
> > +
> > +     if (walk->reuse_addr == addr) {
> > +             BUG_ON(pte_none(*pte));
> > +             walk->reuse_page = pte_page(*pte++);
> > +             addr += PAGE_SIZE;
> > +     }
>
> Although it is quite obvious, a brief comment here pointing out what are we
> doing and that this is meant to be set only once would be nice.

OK. Will do.

>
>
> > +static void vmemmap_remap_range(unsigned long start, unsigned long end,
> > +                             struct vmemmap_remap_walk *walk)
> > +{
> > +     unsigned long addr = start - PAGE_SIZE;
> > +     unsigned long next;
> > +     pgd_t *pgd;
> > +
> > +     VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
> > +     VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
> > +
> > +     walk->reuse_page = NULL;
> > +     walk->reuse_addr = addr;
>
> With the change I suggested above, struct vmemmap_remap_walk should be
> initialitzed at once in vmemmap_remap_free, so this should not longer be needed.

You are right.

> (And btw, you do not need to set reuse_page to NULL, the way you init the struct
> in vmemmap_remap_free makes sure to null any field you do not explicitly set).
>
>
> > +static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
> > +                           struct vmemmap_remap_walk *walk)
> > +{
> > +     /*
> > +      * Make the tail pages are mapped with read-only to catch
> > +      * illegal write operation to the tail pages.
>         "Remap the tail pages as read-only to ..."

Thanks.

>
> > +      */
> > +     pgprot_t pgprot = PAGE_KERNEL_RO;
> > +     pte_t entry = mk_pte(walk->reuse_page, pgprot);
> > +     struct page *page;
> > +
> > +     page = pte_page(*pte);
>
>  struct page *page = pte_page(*pte);
>
> since you did the same for the other two.

Yeah. Will change to this.

>
> > +     list_add(&page->lru, walk->vmemmap_pages);
> > +
> > +     set_pte_at(&init_mm, addr, pte, entry);
> > +}
> > +
> > +/**
> > + * vmemmap_remap_free - remap the vmemmap virtual address range
> > + *                      [start, start + size) to the page which
> > + *                      [start - PAGE_SIZE, start) is mapped,
> > + *                      then free vmemmap pages.
> > + * @start:   start address of the vmemmap virtual address range
> > + * @size:    size of the vmemmap virtual address range
> > + */
> > +void vmemmap_remap_free(unsigned long start, unsigned long size)
> > +{
> > +     unsigned long end = start + size;
> > +     LIST_HEAD(vmemmap_pages);
> > +
> > +     struct vmemmap_remap_walk walk = {
> > +             .remap_pte      = vmemmap_remap_pte,
> > +             .vmemmap_pages  = &vmemmap_pages,
> > +     };
>
> As stated above, this would become:
>
>  void vmemmap_remap_free(unsigned long start, unsigned long end,
>                          usigned long reuse)
>  {
>        LIST_HEAD(vmemmap_pages);
>        struct vmemmap_remap_walk walk = {
>                .reuse_addr = reuse,
>                .remap_pte = vmemmap_remap_pte,
>                .vmemmap_pages = &vmemmap_pages,
>        };
>
>   You might have had your reasons to do this way, but this looks more natural
>   to me, with the plus that callers of vmemmap_remap_free can specify
>   what they want to remap.

Should we add a BUG_ON in vmemmap_remap_free() for now?

        BUG_ON(reuse != start + PAGE_SIZE);

>
>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
