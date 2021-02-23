Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57881322DB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 16:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhBWPmR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 10:42:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:35408 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233101AbhBWPmQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:42:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7C06AF5A;
        Tue, 23 Feb 2021 15:41:32 +0000 (UTC)
Date:   Tue, 23 Feb 2021 16:41:28 +0100
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
Message-ID: <20210223154128.GA21082@localhost.localdomain>
References: <20210219104954.67390-1-songmuchun@bytedance.com>
 <20210219104954.67390-5-songmuchun@bytedance.com>
 <13a5363c-6af4-1e1f-9a18-972ca18278b5@oracle.com>
 <20210223092740.GA1998@linux>
 <CAMZfGtVRSBkKe=tKAKLY8dp_hywotq3xL+EJZNjXuSKt3HK3bQ@mail.gmail.com>
 <20210223104957.GA3844@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223104957.GA3844@linux>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 23, 2021 at 11:50:05AM +0100, Oscar Salvador wrote:
> > CPU0:                           CPU1:
> >                                 set_compound_page_dtor(HUGETLB_PAGE_DTOR);
> > memory_failure_hugetlb
> >   get_hwpoison_page
> >     __get_hwpoison_page
> >       get_page_unless_zero
> >                                 put_page_testzero()
> > 
> > Maybe this can happen. But it is a very corner case. If we want to
> > deal with this. We can put_page_testzero() first and then
> > set_compound_page_dtor(HUGETLB_PAGE_DTOR).
> 
> I have to check further, but it looks like this could actually happen.
> Handling this with VM_BUG_ON is wrong, because memory_failure/soft_offline are
> entitled to increase the refcount of the page.
> 
> AFAICS,
> 
>  CPU0:                                    CPU1:
>                                           set_compound_page_dtor(HUGETLB_PAGE_DTOR);
>  memory_failure_hugetlb
>    get_hwpoison_page
>      __get_hwpoison_page
>        get_page_unless_zero
>                                           put_page_testzero()
>         identify_page_state
>          me_huge_page
> 
> I think we can reach me_huge_page with either refcount = 1 or refcount =2,
> depending whether put_page_testzero has been issued.
> 
> For now, I would not re-enqueue the page if put_page_testzero == false.
> I have to see how this can be handled gracefully.

I took a brief look.
It is not really your patch fault. Hugetlb <-> memory-failure synchronization is
a bit odd, it definitely needs improvment.

The thing is, we can have different scenarios here.
E.g: by the time we return from put_page_testzero, we might have refcount ==
0 and PageHWPoison, or refcount == 1 PageHWPoison.

The former will let a user get a page from the pool and get a sigbus
when it faults in the page, and the latter will be even more odd as we
will have a self-refcounted page in the free pool (and hwpoisoned).

As I said, it is not this patchset fault. I just made me realize this
problem.

I have to think some more about this.

-- 
Oscar Salvador
SUSE L3
