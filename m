Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C318338722
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 09:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhCLIPr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 03:15:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:48622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229756AbhCLIP1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:15:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615536923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZzkqciGY0ObbXmg3Dxl/xC6fEfWQ950vVkoLugQdVgs=;
        b=WNssLyZ0aREa14/sC5vSfBl0P0aiGhfhOzOFpbJD9zpTQUIy583CCfNQqWtCvfSi6gLNwk
        qSLw/QpZsdUkzu9W00pQYdGdWTXx2H1l+WHvLKdUfLDWsPTMfzEeK6sMRjSPK+0EqFnMn5
        msL1yI+czcv5FG3xdJKvLPT3GlzmCiY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 91FB0AF38;
        Fri, 12 Mar 2021 08:15:23 +0000 (UTC)
Date:   Fri, 12 Mar 2021 09:15:21 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Subject: Re: [PATCH v18 4/9] mm: hugetlb: alloc the vmemmap pages associated
 with each HugeTLB page
Message-ID: <YEsjGbKtyrpfas4C@dhcp22.suse.cz>
References: <YEjji9oAwHuZaZEt@dhcp22.suse.cz>
 <f9f19d38-f1a7-ac8c-6ba8-3ce0bcc1e6a0@oracle.com>
 <YEk1+mDZ4u85RKL3@dhcp22.suse.cz>
 <20210310214909.GY2696@paulmck-ThinkPad-P72>
 <68bc8cc9-a15b-2e97-9a2a-282fe6e9bd3f@oracle.com>
 <20210310232851.GZ2696@paulmck-ThinkPad-P72>
 <YEnXllhPEQhT0CRt@dhcp22.suse.cz>
 <YEoKa5oSm/hdgt5V@dhcp22.suse.cz>
 <45f434da-b55b-da61-be36-c248a301f688@oracle.com>
 <4d4851fd-f0fd-9bfe-d271-b53891fdab6f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d4851fd-f0fd-9bfe-d271-b53891fdab6f@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 11-03-21 14:53:08, Mike Kravetz wrote:
> On 3/11/21 9:59 AM, Mike Kravetz wrote:
> > On 3/11/21 4:17 AM, Michal Hocko wrote:
> >>> Yeah per cpu preempt counting shouldn't be noticeable but I have to
> >>> confess I haven't benchmarked it.
> >>
> >> But all this seems moot now http://lkml.kernel.org/r/YEoA08n60+jzsnAl@hirez.programming.kicks-ass.net
> >>
> > 
> > The proper fix for free_huge_page independent of this series would
> > involve:
> > 
> > - Make hugetlb_lock and subpool lock irq safe
> > - Hand off freeing to a workque if the freeing could sleep
> > 
> > Today, the only time we can sleep in free_huge_page is for gigantic
> > pages allocated via cma.  I 'think' the concern about undesirable
> > user visible side effects in this case is minimal as freeing/allocating
> > 1G pages is not something that is going to happen at a high frequency.
> > My thinking could be wrong?
> > 
> > Of more concern, is the introduction of this series.  If this feature
> > is enabled, then ALL free_huge_page requests must be sent to a workqueue.
> > Any ideas on how to address this?
> > 
> 
> Thinking about this more ...
> 
> A call to free_huge_page has two distinct outcomes
> 1) Page is freed back to the original allocator: buddy or cma
> 2) Page is put on hugetlb free list
> 
> We can only possibly sleep in the first case 1.  In addition, freeing a
> page back to the original allocator involves these steps:
> 1) Removing page from hugetlb lists
> 2) Updating hugetlb counts: nr_hugepages, surplus
> 3) Updating page fields
> 4) Allocate vmemmap pages if needed as in this series
> 5) Calling free routine of original allocator
> 
> If hugetlb_lock is irq safe, we can perform the first 3 steps under that
> lock without issue.  We would then use a workqueue to perform the last
> two steps.  Since we are updating hugetlb user visible data under the
> lock, there should be no delays.  Of course, giving those pages back to
> the original allocator could still be delayed, and a user may notice
> that.  Not sure if that would be acceptable?

Well, having many in-flight huge pages can certainly be visible. Say you
are freeing hundreds of huge pages and your echo n > nr_hugepages will
return just for you to find out that the memory hasn't been freed and
therefore cannot be reused for another use - recently there was somebody
mentioning their usecase to free up huge pages to prevent OOM for
example. I do expect more people doing something like that.

Now, nr_hugepages can be handled by blocking on the same WQ until all
pre-existing items are processed. Maybe we will need to have a more
generic API to achieve the same for in kernel users but let's wait for
those requests.

> I think Muchun had a
> similar setup just for vmemmmap allocation in an early version of this
> series.
> 
> This would also require changes to where accounting is done in
> dissolve_free_huge_page and update_and_free_page as mentioned elsewhere.

Normalizing dissolve_free_huge_page is definitely a good idea. It is
really tricky how it sticks out and does half of the job of
update_and_free_page.

That being said, if it is possible to have a fully consistent h state
before handing over to WQ for sleeping operation then we should be all
fine. I am slightly worried about potential tricky situations where the
sleeping operation fails because that would require that page to be
added back to the pool again. As said above we would need some sort of
sync with in-flight operations before returning to the userspace.

-- 
Michal Hocko
SUSE Labs
