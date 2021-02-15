Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D7031B733
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 11:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhBOKdz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 05:33:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:39334 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhBOKdw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 05:33:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613385185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5VOUPmXPZzeS6nM2Yw1Dqr1Wa/BJdfFT6ZPLkwHsXto=;
        b=BJcggBbOIeuRofSc2tjGIErH5zKllt9x1z9zms4Zs5MQ+OpM+rswGyh4BYXla/4ahQLnh4
        OXg74SFAnOtr3aSdCPBAyuOKLw4kSUKDaPBPZYFbyXBwp0KgV7h6/rMbeS+BvSn2Z0Wdax
        VED9JvEeS6lPuZN2UhkQR5SQjfJCms0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E3421AC32;
        Mon, 15 Feb 2021 10:33:04 +0000 (UTC)
Date:   Mon, 15 Feb 2021 11:33:03 +0100
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
Message-ID: <YCpN38i75olgispI@dhcp22.suse.cz>
References: <20210208085013.89436-1-songmuchun@bytedance.com>
 <20210208085013.89436-5-songmuchun@bytedance.com>
 <YCafit5ruRJ+SL8I@dhcp22.suse.cz>
 <CAMZfGtXgVUvCejpxu1o5WDvmQ7S88rWqGi3DAGM6j5NHJgtdcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtXgVUvCejpxu1o5WDvmQ7S88rWqGi3DAGM6j5NHJgtdcg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 15-02-21 18:05:06, Muchun Song wrote:
> On Fri, Feb 12, 2021 at 11:32 PM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > > +int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
> > > +{
> > > +     int ret;
> > > +     unsigned long vmemmap_addr = (unsigned long)head;
> > > +     unsigned long vmemmap_end, vmemmap_reuse;
> > > +
> > > +     if (!free_vmemmap_pages_per_hpage(h))
> > > +             return 0;
> > > +
> > > +     vmemmap_addr += RESERVE_VMEMMAP_SIZE;
> > > +     vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
> > > +     vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
> > > +
> > > +     /*
> > > +      * The pages which the vmemmap virtual address range [@vmemmap_addr,
> > > +      * @vmemmap_end) are mapped to are freed to the buddy allocator, and
> > > +      * the range is mapped to the page which @vmemmap_reuse is mapped to.
> > > +      * When a HugeTLB page is freed to the buddy allocator, previously
> > > +      * discarded vmemmap pages must be allocated and remapping.
> > > +      */
> > > +     ret = vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
> > > +                               GFP_ATOMIC | __GFP_NOWARN | __GFP_THISNODE);
> >
> > I do not think that this is a good allocation mode. GFP_ATOMIC is a non
> > sleeping allocation and a medium memory pressure might cause it to
> > fail prematurely. I do not think this is really an atomic context which
> > couldn't afford memory reclaim. I also do not think we want to grant
> 
> Because alloc_huge_page_vmemmap is called under hugetlb_lock
> now. So using GFP_ATOMIC indeed makes the code more simpler.

You can have a preallocated list of pages prior taking the lock.
Moreover do we want to manipulate vmemmaps from under spinlock in
general. I have to say I have missed that detail when reviewing. Need to
think more.

> From the document of the kernel, I learned that __GFP_NOMEMALLOC
> can be used to explicitly forbid access to emergency reserves. So if
> we do not want to use the reserve memory. How about replacing it to
> 
> GFP_ATOMIC | __GFP_NOMEMALLOC | __GFP_NOWARN | __GFP_THISNODE

The whole point of GFP_ATOMIC is to grant access to memory reserves so
the above is quite dubious. If you do not want access to memory reserves
then use GFP_NOWAIT instead. But failures are much more easier to happen
then.

NOMEMALLOC is meant to be used from paths which are allowed to consume
memory reserves - e.g. when invoked from the memory reclaim path.
-- 
Michal Hocko
SUSE Labs
