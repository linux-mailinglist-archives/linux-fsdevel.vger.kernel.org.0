Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F92C336E3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 09:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhCKIuv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 03:50:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:35998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231757AbhCKIu3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 03:50:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615452628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RS6cifVwljfUL1yL0Nv+yv77FmIDhgMaVYQo3KVZdus=;
        b=F3hhneljDTvJKrt0QbK7pY8ctwitEc/6a9igJJkMYOrDmU1vpjL3JouXQ3oC7euzYAziYF
        99p6iaQRqrBkw6qufEy72UIQbWYoP/WHk0/5jXowdxIZiej77vP3rv+j0Q2pm9EQObHfTL
        6BZXhWnGJPPXx3CKD8FERYkK+VLwI9g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C6AE5AD73;
        Thu, 11 Mar 2021 08:50:27 +0000 (UTC)
Date:   Thu, 11 Mar 2021 09:50:26 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Subject: Re: [External] Re: [PATCH v18 5/9] mm: hugetlb: set the PageHWPoison
 to the raw error page
Message-ID: <YEnZ0lR/sycBrRIn@dhcp22.suse.cz>
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-6-songmuchun@bytedance.com>
 <YEjlf/yV+hz+NksO@dhcp22.suse.cz>
 <CAMZfGtX28p-42bMCuddsYfE0AWpDbWUoLY32+4vn8L5nptNxqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtX28p-42bMCuddsYfE0AWpDbWUoLY32+4vn8L5nptNxqw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 11-03-21 14:34:04, Muchun Song wrote:
> On Wed, Mar 10, 2021 at 11:28 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 08-03-21 18:28:03, Muchun Song wrote:
> > > Because we reuse the first tail vmemmap page frame and remap it
> > > with read-only, we cannot set the PageHWPosion on some tail pages.
> > > So we can use the head[4].private (There are at least 128 struct
> > > page structures associated with the optimized HugeTLB page, so
> > > using head[4].private is safe) to record the real error page index
> > > and set the raw error page PageHWPoison later.
> >
> > Can we have more poisoned tail pages? Also who does consume that index
> > and set the HWPoison on the proper tail page?
> 
> Good point. I look at the routine of memory failure closely.
> If we do not clear the HWPoison of the head page, we cannot
> poison another tail page.
> 
> So we should not set the destructor of the huge page from
> HUGETLB_PAGE_DTOR to NULL_COMPOUND_DTOR
> before calling alloc_huge_page_vmemmap(). In this case,
> the below check of PageHuge() always returns true.
> 
> I need to fix this in the previous patch.
> 
> memory_failure()
>     if (PageHuge(page))
>         memory_failure_hugetlb()
>             head = compound_head(page)
>             if (TestSetPageHWPoison(head))
>                 return

I have to say that I am not fully familiar with hwpoisoning code
(especially after recent changes) but IIRC it does rely on hugetlb page
dissolving. With the new code this operation can fail which is a new
situation. Unless I am misunderstanding this can lead to a lost memory
failure operation on other tail pages.

Anyway the above answers the question why a single slot is sufficient so
it would be great to mention that in a changelog along with the caveat
that some pages might miss their poisoning.
-- 
Michal Hocko
SUSE Labs
