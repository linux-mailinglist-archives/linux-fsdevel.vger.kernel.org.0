Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F05C2F2DF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 12:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbhALLe6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 06:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbhALLe5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:34:57 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BD5C061575
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 03:34:17 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u4so1472472pjn.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 03:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x4fbLWMy7tyZTn+4QhCx/eBNGb6COT/VlIQAs5b2FxE=;
        b=Q1oD52jI+aIUjL3KnRIVupMshuaeY6O8X/28pjs+B+/kBY7wiMWUtc3S9jlQLJk1f+
         sGCb/NU0LXotWlRqajiD9ffQbrmsyRBE4iHewv0m/snjcHhFUdgpVT+vHqfBCt19vIYx
         DmvqVTwcDuXSSI3xpV1LDw4kvZJBFjaR3nFJfKBFSNKnhk3IpaO8psrhfQik56VPPFlS
         loxHeAK59IhbNGLuEUYl4MIuJVZuVqaQNp06xI32ZHaTmsXdBe34YVqw9ZDVw6zLiztG
         iUrSn8I7mOuLNx5d2ZL4r1zlkHK0t+rxCvwkagsFhRGbIGl1c7zRA9nB0Ez5/4yBnvpx
         y57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x4fbLWMy7tyZTn+4QhCx/eBNGb6COT/VlIQAs5b2FxE=;
        b=RRrPNs3EsjbZwXMZGFX+Ufua4sQIp4FOkMrCthVNwJE24yCSDnEWysY8uCtTS0R+SA
         2SJTx5NbekB+1gqcboujvBcTC4P36L0lOFe8FwRIoKPvZr/0Rq3uX8WcFk2aYVTveYzk
         UZNOToWQs11gotsdDZVcotCuNjF9WNakYs7t2eTQrwlrc6oQILnIVGHhpp3oVbcYrdaY
         B4Uz4vk45abCvVF3rNoH4a0RCaBpdK+pOILUKj+UI/lCe+9Xq8hLYbZ2KPZkq9JTrH7z
         +PH6ra5Ccy1gZcuZq4L9AEbjvbKGiLEkmnPTT6nsBKpcw/zvqjD2q8pOIqTW3NJvUmg0
         ys1A==
X-Gm-Message-State: AOAM531Igo01BRoWZ1/v5Z+NgT2uTqQWLTG5j7pg5pqJt/MLKZQE50j5
        +sETaG4LUEVXjYrneqD5lYG14eu0FylU/lP0ELsklQ==
X-Google-Smtp-Source: ABdhPJyVdXNDm11fdbJsCJ5DrnV2EarI5jkwSk+Egq8s0ShDsjrDdPaqcCK37QtLNK4gxDR3vY8z6XMXc+kvJVUHyzE=
X-Received: by 2002:a17:90a:5405:: with SMTP id z5mr4284976pjh.13.1610451256706;
 Tue, 12 Jan 2021 03:34:16 -0800 (PST)
MIME-Version: 1.0
References: <20210106141931.73931-1-songmuchun@bytedance.com>
 <20210106141931.73931-5-songmuchun@bytedance.com> <20210112080453.GA10895@linux>
In-Reply-To: <20210112080453.GA10895@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 12 Jan 2021 19:33:33 +0800
Message-ID: <CAMZfGtUqN2BZH28i9VJhRJ3VH3OGKBQ7hDUuX1-F5LcwbKk+4A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v12 04/13] mm/hugetlb: Free the vmemmap
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

On Tue, Jan 12, 2021 at 4:05 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Wed, Jan 06, 2021 at 10:19:22PM +0800, Muchun Song wrote:
> > Every HugeTLB has more than one struct page structure. We __know__ that
> > we only use the first 4(HUGETLB_CGROUP_MIN_ORDER) struct page structures
> > to store metadata associated with each HugeTLB.
> >
> > There are a lot of struct page structures associated with each HugeTLB
> > page. For tail pages, the value of compound_head is the same. So we can
> > reuse first page of tail page structures. We map the virtual addresses
> > of the remaining pages of tail page structures to the first tail page
> > struct, and then free these page frames. Therefore, we need to reserve
> > two pages as vmemmap areas.
> >
> > When we allocate a HugeTLB page from the buddy, we can free some vmemmap
> > pages associated with each HugeTLB page. It is more appropriate to do it
> > in the prep_new_huge_page().
> >
> > The free_vmemmap_pages_per_hpage(), which indicates how many vmemmap
> > pages associated with a HugeTLB page can be freed, returns zero for
> > now, which means the feature is disabled. We will enable it once all
> > the infrastructure is there.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> My memory may betray me after vacation, so bear with me.

Welcome back. :)

>
> > +/*
> > + * Any memory allocated via the memblock allocator and not via the
> > + * buddy will be marked reserved already in the memmap. For those
> > + * pages, we can call this function to free it to buddy allocator.
> > + */
> > +static inline void free_bootmem_page(struct page *page)
> > +{
> > +     unsigned long magic = (unsigned long)page->freelist;
> > +
> > +     /*
> > +      * The reserve_bootmem_region sets the reserved flag on bootmem
> > +      * pages.
> > +      */
> > +     VM_WARN_ON_PAGE(page_ref_count(page) != 2, page);
>
> I have been thinking about this some more.
> And while I think that this macro might have its room somewhere, I do not
> think this is the case.
>
> Here, if we see that page's refcount differs from 2 it means that we had an
> earlier corruption.
> Now, as a person that has dealt with debugging memory corruptions, I think it
> is of no use to proceed further if such corruption happened, as this can lead
> to problems somewhere else that can manifest in funny ways, and you will find
> yourself scratching your head and trying to work out what happened.
>
> I am aware that this is not the root of the problem here, as someone might have
> had to decrease the refcount, but I would definitely change this to its
> VM_BUG_ON_* variant.

OK. I will change this to VM_BUG_ON_PAGE.

>
> > --- /dev/null
> > +++ b/mm/hugetlb_vmemmap.c
>
> [...]
>
> > diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> > new file mode 100644
> > index 000000000000..6923f03534d5
> > --- /dev/null
> > +++ b/mm/hugetlb_vmemmap.h
>
> [...]
>
> > +/**
> > + * vmemmap_remap_free - remap the vmemmap virtual address range [@start, @end)
> > + *                   to the page which @reuse is mapped, then free vmemmap
> > + *                   pages.
> > + * @start:   start address of the vmemmap virtual address range.
> > + * @end:     end address of the vmemmap virtual address range.
> > + * @reuse:   reuse address.
> > + */
> > +void vmemmap_remap_free(unsigned long start, unsigned long end,
> > +                     unsigned long reuse)
> > +{
> > +     LIST_HEAD(vmemmap_pages);
> > +     struct vmemmap_remap_walk walk = {
> > +             .remap_pte      = vmemmap_remap_pte,
> > +             .reuse_addr     = reuse,
> > +             .vmemmap_pages  = &vmemmap_pages,
> > +     };
> > +
> > +     BUG_ON(start != reuse + PAGE_SIZE);
>
> It seems a bit odd to only pass "start" for the BUG_ON.
> Also, I kind of dislike the "addr += PAGE_SIZE" in vmemmap_pte_range.
>
> I wonder if adding a ".remap_start_addr" would make more sense.
> And adding it here with the vmemmap_remap_walk init.

How about introducing a new function which aims to get the reuse
page? In this case, we can drop the BUG_ON() and "addr += PAGE_SIZE"
which is in vmemmap_pte_range. The vmemmap_remap_range only
does the remapping.

>
>
> --
> Oscar Salvador
> SUSE L3
