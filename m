Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4C83227D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 10:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhBWJap (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 04:30:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:43614 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231561AbhBWJ2l (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 04:28:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6C54AAC1D;
        Tue, 23 Feb 2021 09:27:59 +0000 (UTC)
Date:   Tue, 23 Feb 2021 10:27:55 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com,
        joao.m.martins@oracle.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v16 4/9] mm: hugetlb: alloc the vmemmap pages associated
 with each HugeTLB page
Message-ID: <20210223092740.GA1998@linux>
References: <20210219104954.67390-1-songmuchun@bytedance.com>
 <20210219104954.67390-5-songmuchun@bytedance.com>
 <13a5363c-6af4-1e1f-9a18-972ca18278b5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13a5363c-6af4-1e1f-9a18-972ca18278b5@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 22, 2021 at 04:00:27PM -0800, Mike Kravetz wrote:
> > -static void update_and_free_page(struct hstate *h, struct page *page)
> > +static int update_and_free_page(struct hstate *h, struct page *page)
> > +	__releases(&hugetlb_lock) __acquires(&hugetlb_lock)
> >  {
> >  	int i;
> > +	int nid = page_to_nid(page);
> >  
> >  	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> > -		return;
> > +		return 0;
> >  
> >  	h->nr_huge_pages--;
> > -	h->nr_huge_pages_node[page_to_nid(page)]--;
> > +	h->nr_huge_pages_node[nid]--;
> > +	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
> > +	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
> > +	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> > +	set_page_refcounted(page);
> 
> I think you added the set_page_refcounted() because the huge page will
> appear as just a compound page without a reference after dropping the
> hugetlb lock?  It might be better to set the reference before modifying
> the destructor.  Otherwise, page scanning code could find the non-hugetlb
> compound page with no reference.  I could not find any code where this
> would be a problem, but I think it would be safer to set the reference
> first.

But we already had set_page_refcounted() before this patchset there.
Are the worries only because we drop the lock? AFAICS, the "page-scanning"
problem could have happened before as well?
Although, what does page scanning mean in this context?

I am not opposed to move it above, but I would like to understand the concern
here.

> 
> > +	spin_unlock(&hugetlb_lock);
> 
> I really like the way this code is structured.  It is much simpler than
> previous versions with retries or workqueue.  There is nothing wrong with
> always dropping the lock here.  However, I wonder if we should think about
> optimizing for the case where this feature is not enabled and we are not
> freeing a 1G huge page.  I suspect this will be the most common case for
> some time, and there is no need to drop the lock in this case.
> 
> Please do not change the code based on my comment.  I just wanted to bring
> this up for thought.
> 
> Is it as simple as checking?
>         if (free_vmemmap_pages_per_hpage(h) || hstate_is_gigantic(h))
>                 spin_unlock(&hugetlb_lock);
> 
>         /* before return */
>         if (free_vmemmap_pages_per_hpage(h) || hstate_is_gigantic(h))
>                 spin_lock(&hugetlb_lock);

AFAIK, we at least need the hstate_is_gigantic? Comment below says that
free_gigantic_page might block, so we need to drop the lock.
And I am fine with the change overall.

Unless I am missing something, we should not need to drop the lock unless
we need to allocate vmemmap pages (apart from gigantic pages).

> 
> > +
> > +	if (alloc_huge_page_vmemmap(h, page)) {
> > +		int zeroed;
> > +
> > +		spin_lock(&hugetlb_lock);
> > +		INIT_LIST_HEAD(&page->lru);
> > +		set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
> > +		h->nr_huge_pages++;
> > +		h->nr_huge_pages_node[nid]++;

I think prep_new_huge_page() does this for us?

> > +
> > +		/*
> > +		 * If we cannot allocate vmemmap pages, just refuse to free the
> > +		 * page and put the page back on the hugetlb free list and treat
> > +		 * as a surplus page.
> > +		 */
> > +		h->surplus_huge_pages++;
> > +		h->surplus_huge_pages_node[nid]++;
> > +
> > +		/*
> > +		 * This page is now managed by the hugetlb allocator and has
> > +		 * no users -- drop the last reference.
> > +		 */
> > +		zeroed = put_page_testzero(page);
> > +		VM_BUG_ON_PAGE(!zeroed, page);

Can this actually happen? AFAIK, page landed in update_and_free_page should be
zero refcounted, then we increase the reference, and I cannot see how the
reference might have changed in the meantime.

I am all for catching corner cases, but not sure how realistic this is.
Moreover, if we __ever__ get there, things can get nasty.

We basically will have an in-use page in the free hugetlb pool, so corruption
will happen. At that point, a plain BUG_ON might be better.

But as I said, I do not think we need that.

I yet need to look further, but what I have seen so far looks good.

-- 
Oscar Salvador
SUSE L3
