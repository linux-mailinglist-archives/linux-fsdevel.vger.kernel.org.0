Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFFD302259
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 08:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbhAYHMh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 02:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbhAYGlp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 01:41:45 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C9AC06174A
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Jan 2021 22:41:04 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id h15so4491393pli.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Jan 2021 22:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NewSY01qkIGM9FMVRaVXfK28tOMEomXG8TL6xj/6ExU=;
        b=dqz4SrJI2EpyL5zBD3Ud75KgTfBUcXl9CpiGOJPIxKjyVX/iYdSQdfe1ePcFBhZw7b
         HYIhTcNlR8rvxCOXr+82MSI/2qu96+I5tHYDRCPV9hOM6sLvKudctE9rkAnTTCA1RQmE
         jCPswFUCuBmin5UAqlev59PlZTvBSdMSyQXAVcig6fVCUeLUCjkYB4iyIUDOJeeZCkHB
         KDQroHze9xd2oxp1s/erz77PxkrYSSwhCs9QzMqfsf74CGGMre5Jrx8LVzcKXTEpzkoY
         KKlCLBUoGVVc3PSi3/vFNNnWsqF2XM6XiscKNyZcCoG6+cLAFdRxTdW7MkUMLy/8uHcy
         VljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NewSY01qkIGM9FMVRaVXfK28tOMEomXG8TL6xj/6ExU=;
        b=GuTy07Hmmu3p0e+dqITSy9/39bBUp4BuWUNBOgPTvmHfx/8Ub2pemHMd1uDtSIs0La
         i1cfH8T6AoXDn8+8EUtvL/nhyKEKKclxZvQS9KVdpmrFRtLRnBZ9m3TaluBYAQZ/biFo
         vOkj0bY42QB4vBAsNxE9cl6NbCOYrpd2pm1v1QjLiK4fHxCu++ZRYitmPK2pkoxtrHly
         TIck4xehOvVW/uslpKbge6Hp2YhAR5UehYDY8HrtywgmmJgXQkCKKv7yQjkdG/IOUcl5
         hc+cFyYT9mI/jVDmx9GAwE8Ju6ZotbRlz0ycQYc86N/ELgaYMI+px7uSjCA7g4oSaATV
         g6VA==
X-Gm-Message-State: AOAM5335256Xcc38frMJFnxoelyRrF/qarDp6WI+tZcTxwEjDoTnW7pP
        GEShsvmforoxmNS0eJUFjniI0fCi15frcLE1QSM0sA==
X-Google-Smtp-Source: ABdhPJyXPfNI8fF7mOPctMLEwfthvf6F4onGDO1Vun00hENf1CWfX3J5+p8iE/SBk36EheIPeyMlR1HL/lUpJRFfe30=
X-Received: by 2002:a17:90a:808a:: with SMTP id c10mr6198232pjn.229.1611556864233;
 Sun, 24 Jan 2021 22:41:04 -0800 (PST)
MIME-Version: 1.0
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-6-songmuchun@bytedance.com> <6a68fde-583d-b8bb-a2c8-fbe32e03b@google.com>
In-Reply-To: <6a68fde-583d-b8bb-a2c8-fbe32e03b@google.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 25 Jan 2021 14:40:27 +0800
Message-ID: <CAMZfGtXpg30RhrPm836S6Tr09ynKRPG=_DXtXt9sVTTponnC-g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v13 05/12] mm: hugetlb: allocate the
 vmemmap pages associated with each HugeTLB page
To:     David Rientjes <rientjes@google.com>
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
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 8:05 AM David Rientjes <rientjes@google.com> wrote:
>
>
> On Sun, 17 Jan 2021, Muchun Song wrote:
>
> > diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> > index ce4be1fa93c2..3b146d5949f3 100644
> > --- a/mm/sparse-vmemmap.c
> > +++ b/mm/sparse-vmemmap.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/pgtable.h>
> >  #include <linux/bootmem_info.h>
> > +#include <linux/delay.h>
> >
> >  #include <asm/dma.h>
> >  #include <asm/pgalloc.h>
> > @@ -40,7 +41,8 @@
> >   * @remap_pte:               called for each non-empty PTE (lowest-level) entry.
> >   * @reuse_page:              the page which is reused for the tail vmemmap pages.
> >   * @reuse_addr:              the virtual address of the @reuse_page page.
> > - * @vmemmap_pages:   the list head of the vmemmap pages that can be freed.
> > + * @vmemmap_pages:   the list head of the vmemmap pages that can be freed
> > + *                   or is mapped from.
> >   */
> >  struct vmemmap_remap_walk {
> >       void (*remap_pte)(pte_t *pte, unsigned long addr,
> > @@ -50,6 +52,10 @@ struct vmemmap_remap_walk {
> >       struct list_head *vmemmap_pages;
> >  };
> >
> > +/* The gfp mask of allocating vmemmap page */
> > +#define GFP_VMEMMAP_PAGE             \
> > +     (GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN | __GFP_THISNODE)
> > +
>
> This is unnecessary, just use the gfp mask directly in allocator.

Will do. Thanks.

>
> >  static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
> >                             unsigned long end,
> >                             struct vmemmap_remap_walk *walk)
> > @@ -228,6 +234,75 @@ void vmemmap_remap_free(unsigned long start, unsigned long end,
> >       free_vmemmap_page_list(&vmemmap_pages);
> >  }
> >
> > +static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
> > +                             struct vmemmap_remap_walk *walk)
> > +{
> > +     pgprot_t pgprot = PAGE_KERNEL;
> > +     struct page *page;
> > +     void *to;
> > +
> > +     BUG_ON(pte_page(*pte) != walk->reuse_page);
> > +
> > +     page = list_first_entry(walk->vmemmap_pages, struct page, lru);
> > +     list_del(&page->lru);
> > +     to = page_to_virt(page);
> > +     copy_page(to, (void *)walk->reuse_addr);
> > +
> > +     set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
> > +}
> > +
> > +static void alloc_vmemmap_page_list(struct list_head *list,
> > +                                 unsigned long start, unsigned long end)
> > +{
> > +     unsigned long addr;
> > +
> > +     for (addr = start; addr < end; addr += PAGE_SIZE) {
> > +             struct page *page;
> > +             int nid = page_to_nid((const void *)addr);
> > +
> > +retry:
> > +             page = alloc_pages_node(nid, GFP_VMEMMAP_PAGE, 0);
> > +             if (unlikely(!page)) {
> > +                     msleep(100);
> > +                     /*
> > +                      * We should retry infinitely, because we cannot
> > +                      * handle allocation failures. Once we allocate
> > +                      * vmemmap pages successfully, then we can free
> > +                      * a HugeTLB page.
> > +                      */
> > +                     goto retry;
>
> Ugh, I don't think this will work, there's no guarantee that we'll ever
> succeed and now we can't free a 2MB hugepage because we cannot allocate a
> 4KB page.  We absolutely have to ensure we make forward progress here.

This can trigger a OOM when there is no memory and kill someone to release
some memory. Right?

>
> We're going to be freeing the hugetlb page after this succeeeds, can we
> not use part of the hugetlb page that we're freeing for this memory
> instead?

It seems a good idea. We can try to allocate memory firstly, if successful,
just use the new page to remap (it can reduce memory fragmentation).
If not, we can use part of the hugetlb page to remap. What's your opinion
about this?

>
> > +             }
> > +             list_add_tail(&page->lru, list);
> > +     }
> > +}
> > +
> > +/**
> > + * vmemmap_remap_alloc - remap the vmemmap virtual address range [@start, end)
> > + *                    to the page which is from the @vmemmap_pages
> > + *                    respectively.
> > + * @start:   start address of the vmemmap virtual address range.
> > + * @end:     end address of the vmemmap virtual address range.
> > + * @reuse:   reuse address.
> > + */
> > +void vmemmap_remap_alloc(unsigned long start, unsigned long end,
> > +                      unsigned long reuse)
> > +{
> > +     LIST_HEAD(vmemmap_pages);
> > +     struct vmemmap_remap_walk walk = {
> > +             .remap_pte      = vmemmap_restore_pte,
> > +             .reuse_addr     = reuse,
> > +             .vmemmap_pages  = &vmemmap_pages,
> > +     };
> > +
> > +     might_sleep();
> > +
> > +     /* See the comment in the vmemmap_remap_free(). */
> > +     BUG_ON(start - reuse != PAGE_SIZE);
> > +
> > +     alloc_vmemmap_page_list(&vmemmap_pages, start, end);
> > +     vmemmap_remap_range(reuse, end, &walk);
> > +}
> > +
> >  /*
> >   * Allocate a block of memory to be used to back the virtual memory map
> >   * or to back the page tables that are used to create the mapping.
> > --
> > 2.11.0
> >
> >
