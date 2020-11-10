Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B22A2AD2C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 10:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgKJJsj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 04:48:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:45758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgKJJsj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 04:48:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 18320AC1D;
        Tue, 10 Nov 2020 09:48:38 +0000 (UTC)
Date:   Tue, 10 Nov 2020 10:48:34 +0100
From:   Oscar Salvador <osalvador@suse.de>
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
        Michal Hocko <mhocko@suse.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v3 09/21] mm/hugetlb: Free the vmemmap
 pages associated with each hugetlb page
Message-ID: <20201110094830.GA25373@linux>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-10-songmuchun@bytedance.com>
 <20201109185138.GD17356@linux>
 <CAMZfGtXpXoQ+zVi2Us__7ghSu_3U7+T3tx-EL+zfa=1Obn=55g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtXpXoQ+zVi2Us__7ghSu_3U7+T3tx-EL+zfa=1Obn=55g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 02:40:54PM +0800, Muchun Song wrote:
> Only the first HugeTLB page should split the PMD to PTE. The other 63
> HugeTLB pages
> do not need to split. Here I want to make sure we are the first.

I think terminology is loosing me here.

Say you allocate a 2MB HugeTLB page at ffffea0004100000.

The vmemmap range that the represents this is ffffea0004000000 - ffffea0004200000.
That is a 2MB chunk PMD-mapped.
So, in order to free some of those vmemmap pages, we need to break down
that area, remapping it to PTE-based.
I know what you mean, but we are not really splitting hugetlg pages, but
the memmap range they are represented with.

About:

"Only the first HugeTLB page should split the PMD to PTE. The other 63
HugeTLB pages
do not need to split. Here I want to make sure we are the first."

That only refers to gigantic pages, right?

> > > +static void free_huge_page_vmemmap(struct hstate *h, struct page *head)
> > > +{
> > > +     pmd_t *pmd;
> > > +     spinlock_t *ptl;
> > > +     LIST_HEAD(free_pages);
> > > +
> > > +     if (!free_vmemmap_pages_per_hpage(h))
> > > +             return;
> > > +
> > > +     pmd = vmemmap_to_pmd(head);
> > > +     ptl = vmemmap_pmd_lock(pmd);
> > > +     if (vmemmap_pmd_huge(pmd)) {
> > > +             VM_BUG_ON(!pgtable_pages_to_prealloc_per_hpage(h));
> >
> > I think that checking for free_vmemmap_pages_per_hpage is enough.
> > In the end, pgtable_pages_to_prealloc_per_hpage uses free_vmemmap_pages_per_hpage.
> 
> The free_vmemmap_pages_per_hpage is not enough. See the comments above.

My comment was about the VM_BUG_ON.


-- 
Oscar Salvador
SUSE L3
