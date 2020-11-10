Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A432AD80A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 14:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbgKJNwW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 08:52:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:42498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730059AbgKJNwW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:52:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2A0BDABD6;
        Tue, 10 Nov 2020 13:52:20 +0000 (UTC)
Date:   Tue, 10 Nov 2020 14:52:15 +0100
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
Message-ID: <20201110135210.GA29463@linux>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-10-songmuchun@bytedance.com>
 <20201109185138.GD17356@linux>
 <CAMZfGtXpXoQ+zVi2Us__7ghSu_3U7+T3tx-EL+zfa=1Obn=55g@mail.gmail.com>
 <20201110094830.GA25373@linux>
 <CAMZfGtW0nwhdgwUwwq5SXgEAk3+6cyDfM5n28UerVuAxatwj4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtW0nwhdgwUwwq5SXgEAk3+6cyDfM5n28UerVuAxatwj4g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 06:47:08PM +0800, Muchun Song wrote:
> > That only refers to gigantic pages, right?
> 
> Yeah, now it only refers to gigantic pages. Originally, I also wanted to merge
> vmemmap PTE to PMD for normal 2MB HugeTLB pages. So I introduced
> those macros(e.g. freed_vmemmap_hpage). For 2MB HugeTLB pages, I
> haven't found an elegant solution. Hopefully, when you or someone have
> read all of the patch series, we can come up with an elegant solution to
> merge PTE.

Well, it is quite a lot of "tricky" code, so it takes some time.

> > > > > +static void free_huge_page_vmemmap(struct hstate *h, struct page *head)
> > > > > +{
> > > > > +     pmd_t *pmd;
> > > > > +     spinlock_t *ptl;
> > > > > +     LIST_HEAD(free_pages);
> > > > > +
> > > > > +     if (!free_vmemmap_pages_per_hpage(h))
> > > > > +             return;
> > > > > +
> > > > > +     pmd = vmemmap_to_pmd(head);
> > > > > +     ptl = vmemmap_pmd_lock(pmd);

I forgot about this one.
You might want to check whether vmemmap_to_pmd returns NULL or not.
If it does means that something went wrong anyways, but still we should handle
such case (and print a fat warning or something like that).


-- 
Oscar Salvador
SUSE L3
