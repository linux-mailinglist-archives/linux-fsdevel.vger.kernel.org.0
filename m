Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2837432290C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 11:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhBWKvG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 05:51:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:54528 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232033AbhBWKuw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 05:50:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A75CCAC69;
        Tue, 23 Feb 2021 10:50:10 +0000 (UTC)
Date:   Tue, 23 Feb 2021 11:50:05 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v16 4/9] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
Message-ID: <20210223104957.GA3844@linux>
References: <20210219104954.67390-1-songmuchun@bytedance.com>
 <20210219104954.67390-5-songmuchun@bytedance.com>
 <13a5363c-6af4-1e1f-9a18-972ca18278b5@oracle.com>
 <20210223092740.GA1998@linux>
 <CAMZfGtVRSBkKe=tKAKLY8dp_hywotq3xL+EJZNjXuSKt3HK3bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtVRSBkKe=tKAKLY8dp_hywotq3xL+EJZNjXuSKt3HK3bQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 23, 2021 at 06:27:07PM +0800, Muchun Song wrote:
> > > > +
> > > > +   if (alloc_huge_page_vmemmap(h, page)) {
> > > > +           int zeroed;
> > > > +
> > > > +           spin_lock(&hugetlb_lock);
> > > > +           INIT_LIST_HEAD(&page->lru);
> > > > +           set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
> > > > +           h->nr_huge_pages++;
> > > > +           h->nr_huge_pages_node[nid]++;
> >
> > I think prep_new_huge_page() does this for us?
> 
> Actually, there are some differences. e.g. prep_new_huge_page()
> will reset hugetlb cgroup and ClearHPageFreed, but we do not need
> them here. And prep_new_huge_page will acquire and release
> the hugetlb_lock. But here we also need hold the lock to update
> the surplus counter and enqueue the page to the free list.
> So I do not think reuse prep_new_huge_page is a good idea.

I see, I missed that.

> > Can this actually happen? AFAIK, page landed in update_and_free_page should be
> > zero refcounted, then we increase the reference, and I cannot see how the
> > reference might have changed in the meantime.
> 
> I am not sure whether other modules get the page and then put the
> page. I see gather_surplus_pages does the same thing. So I copied
> from there. I try to look at the memory_failure routine.
> 
> 
> CPU0:                           CPU1:
>                                 set_compound_page_dtor(HUGETLB_PAGE_DTOR);
> memory_failure_hugetlb
>   get_hwpoison_page
>     __get_hwpoison_page
>       get_page_unless_zero
>                                 put_page_testzero()
> 
> Maybe this can happen. But it is a very corner case. If we want to
> deal with this. We can put_page_testzero() first and then
> set_compound_page_dtor(HUGETLB_PAGE_DTOR).

I have to check further, but it looks like this could actually happen.
Handling this with VM_BUG_ON is wrong, because memory_failure/soft_offline are
entitled to increase the refcount of the page.

AFAICS,

 CPU0:                                    CPU1:
                                          set_compound_page_dtor(HUGETLB_PAGE_DTOR);
 memory_failure_hugetlb
   get_hwpoison_page
     __get_hwpoison_page
       get_page_unless_zero
                                          put_page_testzero()
        identify_page_state
         me_huge_page

I think we can reach me_huge_page with either refcount = 1 or refcount =2,
depending whether put_page_testzero has been issued.

For now, I would not re-enqueue the page if put_page_testzero == false.
I have to see how this can be handled gracefully.



-- 
Oscar Salvador
SUSE L3
