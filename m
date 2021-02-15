Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D206D31BA36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 14:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhBONUV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 08:20:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:59264 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhBONUT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 08:20:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613395171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VrYszXWufgZ7DXzjszArcCUC2Xn5qCIgATXFqiBe/qM=;
        b=rnIuwIPk7q2Bv3pei4lS7wnFxeqEn+3SK8mEAj+fsiO1AP9Z5a6ALd35VcWzcRQvWRHFO3
        kR1XO6uKNw3JHPOayE4rlauc3Y/EViD4aEodLjdLjhK4MBg6ZLfaaiglYNUiruETpQ7JB+
        hcqOd2U9Ti1TAmDtHq+QgD1dxwPgQ3Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F3691AC32;
        Mon, 15 Feb 2021 13:19:30 +0000 (UTC)
Date:   Mon, 15 Feb 2021 14:19:28 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
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
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v15 4/8] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
Message-ID: <YCp04NVBZpZZ5k7G@dhcp22.suse.cz>
References: <20210208085013.89436-1-songmuchun@bytedance.com>
 <20210208085013.89436-5-songmuchun@bytedance.com>
 <YCafit5ruRJ+SL8I@dhcp22.suse.cz>
 <CAMZfGtXgVUvCejpxu1o5WDvmQ7S88rWqGi3DAGM6j5NHJgtdcg@mail.gmail.com>
 <YCpN38i75olgispI@dhcp22.suse.cz>
 <CAMZfGtUXJTaMo36aB4nTFuYFy3qfWW69o=4uUo-FjocO8obDgw@mail.gmail.com>
 <CAMZfGtWT8CJ-QpVofB2X-+R7GE7sMa40eiAJm6PyD0ji=FzBYQ@mail.gmail.com>
 <YCpmlGuoTakPJs1u@dhcp22.suse.cz>
 <CAMZfGtWd_ZaXtiEdMKhpnAHDw5CTm-CSPSXW+GfKhyX5qQK=Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtWd_ZaXtiEdMKhpnAHDw5CTm-CSPSXW+GfKhyX5qQK=Og@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 15-02-21 20:44:57, Muchun Song wrote:
> On Mon, Feb 15, 2021 at 8:18 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 15-02-21 20:00:07, Muchun Song wrote:
> > > On Mon, Feb 15, 2021 at 7:51 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > > >
> > > > On Mon, Feb 15, 2021 at 6:33 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Mon 15-02-21 18:05:06, Muchun Song wrote:
> > > > > > On Fri, Feb 12, 2021 at 11:32 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > > [...]
> > > > > > > > +int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
> > > > > > > > +{
> > > > > > > > +     int ret;
> > > > > > > > +     unsigned long vmemmap_addr = (unsigned long)head;
> > > > > > > > +     unsigned long vmemmap_end, vmemmap_reuse;
> > > > > > > > +
> > > > > > > > +     if (!free_vmemmap_pages_per_hpage(h))
> > > > > > > > +             return 0;
> > > > > > > > +
> > > > > > > > +     vmemmap_addr += RESERVE_VMEMMAP_SIZE;
> > > > > > > > +     vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
> > > > > > > > +     vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
> > > > > > > > +
> > > > > > > > +     /*
> > > > > > > > +      * The pages which the vmemmap virtual address range [@vmemmap_addr,
> > > > > > > > +      * @vmemmap_end) are mapped to are freed to the buddy allocator, and
> > > > > > > > +      * the range is mapped to the page which @vmemmap_reuse is mapped to.
> > > > > > > > +      * When a HugeTLB page is freed to the buddy allocator, previously
> > > > > > > > +      * discarded vmemmap pages must be allocated and remapping.
> > > > > > > > +      */
> > > > > > > > +     ret = vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
> > > > > > > > +                               GFP_ATOMIC | __GFP_NOWARN | __GFP_THISNODE);
> > > > > > >
> > > > > > > I do not think that this is a good allocation mode. GFP_ATOMIC is a non
> > > > > > > sleeping allocation and a medium memory pressure might cause it to
> > > > > > > fail prematurely. I do not think this is really an atomic context which
> > > > > > > couldn't afford memory reclaim. I also do not think we want to grant
> > > > > >
> > > > > > Because alloc_huge_page_vmemmap is called under hugetlb_lock
> > > > > > now. So using GFP_ATOMIC indeed makes the code more simpler.
> > > > >
> > > > > You can have a preallocated list of pages prior taking the lock.
> > > >
> > > > A discussion about this can refer to here:
> > > >
> > > > https://patchwork.kernel.org/project/linux-mm/patch/20210117151053.24600-5-songmuchun@bytedance.com/
> > > >
> > > > > Moreover do we want to manipulate vmemmaps from under spinlock in
> > > > > general. I have to say I have missed that detail when reviewing. Need to
> > > > > think more.
> > > > >
> > > > > > From the document of the kernel, I learned that __GFP_NOMEMALLOC
> > > > > > can be used to explicitly forbid access to emergency reserves. So if
> > > > > > we do not want to use the reserve memory. How about replacing it to
> > > > > >
> > > > > > GFP_ATOMIC | __GFP_NOMEMALLOC | __GFP_NOWARN | __GFP_THISNODE
> > > > >
> > > > > The whole point of GFP_ATOMIC is to grant access to memory reserves so
> > > > > the above is quite dubious. If you do not want access to memory reserves
> > > >
> > > > Look at the code of gfp_to_alloc_flags().
> > > >
> > > > static inline unsigned int gfp_to_alloc_flags(gfp_t gfp_mask)
> > > > {
> > > >         [...]
> > > >         if (gfp_mask & __GFP_ATOMIC) {
> > > >         /*
> > > >          * Not worth trying to allocate harder for __GFP_NOMEMALLOC even
> > > >          * if it can't schedule.
> > > >          */
> > > >         if (!(gfp_mask & __GFP_NOMEMALLOC))
> > > >                 alloc_flags |= ALLOC_HARDER;
> > > >        [...]
> > > > }
> > > >
> > > > Seems to allow this operation (GFP_ATOMIC | __GFP_NOMEMALLOC).
> >
> > Please read my response again more carefully. I am not claiming that
> > combination is not allowed. I have said it doesn't make any sense in
> > this context.
> 
> I see you are worried that using GFP_ATOMIC will use reverse memory
> unlimited. So I think that __GFP_NOMEMALLOC may be suitable for us.
> Sorry, I may not understand the point you said. What I missed?

OK, let me try to explain again. GFP_ATOMIC is not only a non-sleeping
allocation request. It also grants access to memory reserves. The later
is a bit more involved because there are more layers of memory reserves
to access but that is not really important. Non-sleeping semantic can be
achieved by GFP_NOWAIT which will not grant access to reserves unless
explicitly stated - e.g. by __GFP_HIGH or __GFP_ATOMIC.
Is that more clear?

Now again why I do not think access to memory reserves is suitable.
Hugetlb pages can be released in a large batches and that might cause a
peak depletion of memory reserves which are normally used by other
consumers as well. Other GFP_ATOMIC users might see allocation failures.
Those shouldn't be really fatal as nobody should be relying on those and
a failure usually mean a hand over to a different, less constrained,
context. So this concern is more about a more well behaved behavior from
the hugetlb side than a correctness.
Is that more clear?

There shouldn't be any real reason why the memory allocation for
vmemmaps, or handling vmemmap in general, has to be done from within the
hugetlb lock and therefore requiring a non-sleeping semantic. All that
can be deferred to a more relaxed context. If you want to make a
GFP_NOWAIT optimistic attempt in the direct free path then no problem
but you have to expect failures under memory pressure. If you want to
have a more robust allocation request then you have to go outside of the
spin lock and use GFP_KERNEL | __GFP_NORETRY or GFP_KERNEL |
__GFP_RETRY_MAYFAIL depending on how hard you want to try.
__GFP_THISNODE makes a slight difference here but something that I would
recommend not depending on.
Is that more clear?
-- 
Michal Hocko
SUSE Labs
