Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1B8336B02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 05:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhCKEOy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 23:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhCKEOg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 23:14:36 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4571FC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 20:14:36 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id s21so2807657pjq.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 20:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QEFc+5uxcw01if19rtXMDW1S4shWkY5w/azslxmxuJ8=;
        b=kBi8IOydn8mz/RQqllLx8Yn7CDOHYvKk/1hUB1Gs9l62c+HqvXZTjnenXvnm7BO2m9
         mB7QxGuGYX2DgSomKvXpf2sIu1nMMuTsvdxViLIojTZALlC5jh/eO7VLJ6YybqcPiapf
         3ghp/3bWgQhWqLl4k97+fgfFHSkSL4dEThDWe+B0eL19Omf7EQwWhwsrlcb11g5+NKOL
         /scIDvJLBSgpVre0BWH0WkGPEhsSraKlfozW63e3GabkIFX0h8y3Kxs859KXXYtdztl6
         fHfwhiLDdKtntLdKvoctwlhk3ODs03ad+DWB0XEwvWqcU/G9Tz40uZDu/WCjZ9YL8o1e
         +cjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QEFc+5uxcw01if19rtXMDW1S4shWkY5w/azslxmxuJ8=;
        b=JgbIpSPrN4paZ7VOMMA0PAduRKQi+vPUAmxJo0j1lpUV9PxbmD5OtDY2qF9VcVMbkA
         GojUWY0tbp0epEm/vSS8blVHAt9Vn9stZzVMbX8duLX4o2HjgMdlCDDcrTWIMJzK1m6e
         pyh0CXb+nia9XsTbIdLGspn821Y6VyfbL11CnkZ0xYRWMtxxLCLh9+6uOULEwPlCEgYM
         pMPRoCk5uTvgs7m3TESM47sxRDcUKtDrg5xiAknMrmh9bofeyoAYkDfp+TfZ8eg02qg+
         sqa7AfZUaJ4GLM/nIAY/ob5R6CT6Uq8eiP8QUQ27DblN8nXWYdbKhbMIFKEIID7Pei8U
         NBCQ==
X-Gm-Message-State: AOAM533IJBKtFYWJhveyjwpOTMkRp41UagAqBWq/T2p2ocqHBRdLs37S
        Q1VmfwzET2SDqjVpg4kMNlNG5aNFgbUNPbJ57FJfxw==
X-Google-Smtp-Source: ABdhPJx6NBHnxHdYb1A3eokq/gkhYfBt/LcvxHmuP92XpmYAwqdG0AurD8XdLRIdgW4SJlTNYwu+dP1ExB5GY7MnRl8=
X-Received: by 2002:a17:902:d4cb:b029:e5:f608:6d5e with SMTP id
 o11-20020a170902d4cbb02900e5f6086d5emr6034382plg.20.1615436075626; Wed, 10
 Mar 2021 20:14:35 -0800 (PST)
MIME-Version: 1.0
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-5-songmuchun@bytedance.com> <20210310142057.GA12777@linux>
In-Reply-To: <20210310142057.GA12777@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 11 Mar 2021 12:13:58 +0800
Message-ID: <CAMZfGtVxiqwoxpYapVOK7GeyjZLzFY8EtD3h+4f1E-b6NwnNfA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v18 4/9] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 10, 2021 at 10:21 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Mon, Mar 08, 2021 at 06:28:02PM +0800, Muchun Song wrote:
> > When we free a HugeTLB page to the buddy allocator, we need to allocate
> > the vmemmap pages associated with it. However, we may not be able to
> > allocate the vmemmap pages when the system is under memory pressure. In
> > this case, we just refuse to free the HugeTLB page. This changes behavior
> > in some corner cases as listed below:
> >
> >  1) Failing to free a huge page triggered by the user (decrease nr_pages).
> >
> >     User needs to try again later.
> >
> >  2) Failing to free a surplus huge page when freed by the application.
> >
> >     Try again later when freeing a huge page next time.
> >
> >  3) Failing to dissolve a free huge page on ZONE_MOVABLE via
> >     offline_pages().
> >
> >     This can happen when we have plenty of ZONE_MOVABLE memory, but
> >     not enough kernel memory to allocate vmemmmap pages.  We may even
> >     be able to migrate huge page contents, but will not be able to
> >     dissolve the source huge page.  This will prevent an offline
> >     operation and is unfortunate as memory offlining is expected to
> >     succeed on movable zones.  Users that depend on memory hotplug
> >     to succeed for movable zones should carefully consider whether the
> >     memory savings gained from this feature are worth the risk of
> >     possibly not being able to offline memory in certain situations.
>
> This is nice to have it here, but a normal user won't dig in the kernel to
> figure this out, so my question is: Do we have this documented somewhere under
> Documentation/?
> If not, could we document it there? It is nice to warn about this things were
> sysadmins can find them.

Make sense. I will do this.

>
> >  4) Failing to dissolve a huge page on CMA/ZONE_MOVABLE via
> >     alloc_contig_range() - once we have that handling in place. Mainly
> >     affects CMA and virtio-mem.
> >
> >     Similar to 3). virito-mem will handle migration errors gracefully.
> >     CMA might be able to fallback on other free areas within the CMA
> >     region.
> >
> > Vmemmap pages are allocated from the page freeing context. In order for
> > those allocations to be not disruptive (e.g. trigger oom killer)
> > __GFP_NORETRY is used. hugetlb_lock is dropped for the allocation
> > because a non sleeping allocation would be too fragile and it could fail
> > too easily under memory pressure. GFP_ATOMIC or other modes to access
> > memory reserves is not used because we want to prevent consuming
> > reserves under heavy hugetlb freeing.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Tested-by: Chen Huang <chenhuang5@huawei.com>
> > Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
>
> Sorry for jumping in late.
> It looks good to me:
>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks.

>
> Minor request above and below:
>
> > ---
> >  Documentation/admin-guide/mm/hugetlbpage.rst |  8 +++
> >  include/linux/mm.h                           |  2 +
> >  mm/hugetlb.c                                 | 92 +++++++++++++++++++++-------
> >  mm/hugetlb_vmemmap.c                         | 32 ++++++----
> >  mm/hugetlb_vmemmap.h                         | 23 +++++++
> >  mm/sparse-vmemmap.c                          | 75 ++++++++++++++++++++++-
> >  6 files changed, 197 insertions(+), 35 deletions(-)
>
> [...]
>
>
>
> Could we place a brief comment about what we expect to return here?

OK. Will do.

>
> > -static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
> > +int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
> >  {
> > -     return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
> > +     unsigned long vmemmap_addr = (unsigned long)head;
> > +     unsigned long vmemmap_end, vmemmap_reuse;
> > +
> > +     if (!free_vmemmap_pages_per_hpage(h))
> > +             return 0;
> > +
> > +     vmemmap_addr += RESERVE_VMEMMAP_SIZE;
> > +     vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
> > +     vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
> > +     /*
> > +      * The pages which the vmemmap virtual address range [@vmemmap_addr,
> > +      * @vmemmap_end) are mapped to are freed to the buddy allocator, and
> > +      * the range is mapped to the page which @vmemmap_reuse is mapped to.
> > +      * When a HugeTLB page is freed to the buddy allocator, previously
> > +      * discarded vmemmap pages must be allocated and remapping.
> > +      */
> > +     return vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
> > +                                GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
> >  }
>
> --
> Oscar Salvador
> SUSE L3
