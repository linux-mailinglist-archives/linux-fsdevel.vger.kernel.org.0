Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD4032146D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 11:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhBVKvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 05:51:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:45744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230270AbhBVKvo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 05:51:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5B719AFE1;
        Mon, 22 Feb 2021 10:51:02 +0000 (UTC)
Date:   Mon, 22 Feb 2021 11:50:56 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <20210222105051.GA23063@linux>
References: <20210219104954.67390-1-songmuchun@bytedance.com>
 <20210219104954.67390-5-songmuchun@bytedance.com>
 <YC/HRTq1MRaDWn7O@dhcp22.suse.cz>
 <CAMZfGtW-j=WizTckEWZNB2OSPkz662Vjr79Fb0he9tMD+bnT3Q@mail.gmail.com>
 <YDN4hhhINcn69CeV@dhcp22.suse.cz>
 <CAMZfGtWt3uYcCv5htRkOncJnh=4eiGXzpKsV7-Gj40m-BXcUrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtWt3uYcCv5htRkOncJnh=4eiGXzpKsV7-Gj40m-BXcUrw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 22, 2021 at 06:31:12PM +0800, Muchun Song wrote:
> On Mon, Feb 22, 2021 at 5:25 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Sat 20-02-21 12:20:36, Muchun Song wrote:
> > > On Fri, Feb 19, 2021 at 10:12 PM Michal Hocko <mhocko@suse.com> wrote:
> > [...]
> > > > What about hugetlb page poisoning on HW failure (resp. soft offlining)?
> > >
> > > If the HW poisoned hugetlb page failed to be dissolved, the page
> > > will go back to the free list with PG_HWPoison set. But the page
> > > will not be used, because we will check whether the page is HW
> > > poisoned when it is dequeued from the free list. If so, we will skip
> > > this page.

Not really. If the huge page is dissolved, we will take the page out of the
the freelist. See take_page_off_buddy in memory_failure_hugetlb.

In an ideal world, we should inspect that page in free_pages_prepare(),
remove the HPWpoisoned page and process the others, without letting that
page hit Buddy.
And not only for hugetlb, but for any higher order page.
See how memory_failure() happily disengage itself when it finds a higher
order page.
It does it because we have the premise that once that page hits Buddy,
it will stay there as the check_new_page guards us.
But this has been proofed to be quite a weak measure, as compaction does
not performs such a check, and so the page can sneak in.

I fixed that for soft-offline, and for memory-failure in some cases, but more
needs to be done and is it in my TODO list.

> > Can this lead to an under provisioned pool then? Or is there a new
> > hugetlb allocated to replace the poisoned one?
> 
> Actually, no page will be allocated. Your concern is right. But without
> this patch, the result does not change. e.g. The HW poisoned page
> can fail to be dissolved when h->free_huge_pages is equal to
> h->resv_huge_pages. But no one seems to have reported this issue so
> far. Maybe this behavior needs improvement in the feature.

Yes, something to improve.
I shall have a look.

-- 
Oscar Salvador
SUSE L3
