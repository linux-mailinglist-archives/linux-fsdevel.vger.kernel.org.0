Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FA23088F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 13:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhA2MQ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 07:16:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:58192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232862AbhA2MOY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 07:14:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611910277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oz5cMvs61w9nxAoe4HzR3mysk0/Hr5mRI47kmCm2DS0=;
        b=JlAN3/6ogutWOafvXtaRPUY2CcqVH8YluGJuxVw3j5M8pdVfxjPuXWqJ1TpSUCsjvBL8Jh
        hawPaBwcHUKIexzg5OBrQB9L0nFn7he5WG1sTy30AdaWWlyFyJAU8bOKTbKEvAVjrh2dU9
        LZzhuvObvkNyN52W4YE1B2PWXA7ohhg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C1ABBACB0;
        Fri, 29 Jan 2021 08:51:16 +0000 (UTC)
Date:   Fri, 29 Jan 2021 09:51:15 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH v16 07/11] secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <YBPMg/C5Sb78gFEB@dhcp22.suse.cz>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-8-rppt@kernel.org>
 <20210126114657.GL827@dhcp22.suse.cz>
 <303f348d-e494-e386-d1f5-14505b5da254@redhat.com>
 <20210126120823.GM827@dhcp22.suse.cz>
 <20210128092259.GB242749@kernel.org>
 <YBK1kqL7JA7NePBQ@dhcp22.suse.cz>
 <20210129072128.GD242749@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129072128.GD242749@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 29-01-21 09:21:28, Mike Rapoport wrote:
> On Thu, Jan 28, 2021 at 02:01:06PM +0100, Michal Hocko wrote:
> > On Thu 28-01-21 11:22:59, Mike Rapoport wrote:
> > 
> > > And hugetlb pools may be also depleted by anybody by calling
> > > mmap(MAP_HUGETLB) and there is no any limiting knob for this, while
> > > secretmem has RLIMIT_MEMLOCK.
> > 
> > Yes it can fail. But it would fail at the mmap time when the reservation
> > fails. Not during the #PF time which can be at any time.
> 
> It may fail at $PF time as well:
> 
> hugetlb_fault()
>         hugeltb_no_page()
>                 ...
>                 alloc_huge_page()
>                         alloc_gigantic_page()
>                                 cma_alloc()
>                                         -ENOMEM; 

I would have to double check. From what I remember cma allocator is an
optimization to increase chances to allocate hugetlb pages when
overcommiting because pages should be normally pre-allocated in the pool
and reserved during mmap time. But even if a hugetlb page is not pre
allocated then this will get propagated as SIGBUS unless that has
changed.
  
> > > That said, simply replacing VM_FAULT_OOM with VM_FAULT_SIGBUS makes
> > > secretmem at least as controllable and robust than hugeltbfs even without
> > > complex reservation at mmap() time.
> > 
> > Still sucks huge!
>  
> Any #PF can get -ENOMEM for whatever reason. Sucks huge indeed.

I certainly can. But it doesn't in practice because most allocations
will simply not fail and rather invoke OOM killer directly. Maybe there
are cases which still might fail (higher order, weaker reclaim
capabilities etc) but that would result in a bug in the end because the
#PF handler would trigger the oom killer.

[...]
> > I would still like to understand whether that data is actually
> > representative. With some underlying reasoning rather than I have run
> > these XYZ benchmarks and numbers do not look terrible.
> 
> I would also very much like to see, for example, reasoning to enabling 1GB
> pages in the direct map beyond "because we can" (commits 00d1c5e05736
> ("x86: add gbpages switches") and ef9257668e31 ("x86: do kernel direct
> mapping at boot using GB pages")).
> 
> The original Kconfig text for CONFIG_DIRECT_GBPAGES said
> 
>           Enable gigabyte pages support (if the CPU supports it). This can
>           improve the kernel's performance a tiny bit by reducing TLB
>           pressure.
> 
> So it is very interesting how tiny that bit was.

Yeah and that sucks! Because it is leaving us with speculations now. I
hope you do not want to repeat the same mistake now and leave somebody
in the future in the same situation.

> > > I like the idea to have a pool as an optimization rather than a hard
> > > requirement but I don't see why would it need a careful access control. As
> > > the direct map fragmentation is not necessarily degrades the performance
> > > (and even sometimes it actually improves it) and even then the degradation
> > > is small, trying a PMD_ORDER allocation for a pool and then falling back to
> > > 4K page may be just fine.
> > 
> > Well, as soon as this is a scarce resource then an access control seems
> > like a first thing to think of. Maybe it is not really necessary but
> > then this should be really justified.
> 
> And what being a scarce resource here?

A fixed size pool shared by all users of this feature.

> If we consider lack of the direct
> map fragmentation as this resource, there enough measures secretmem
> implements to limit user ability to fragment the direct map, as was already
> discussed several times. Global limit, memcg and rlimit provide enough
> access control already.

Try to do a simple excercise. You have X amout of secret memory. How do
you distribute that to all interested users (some of them adversaries)
based on the above. Global limit is a DoS vector potentially, memcg is a
mixed bag of all other memory and it would become really tricky to
enforece proportion of the X while having other memory consumed and
rlimit is per process rather than per user.

Look at how hugetlb had to develop its cgroup controler to distribute
the pool among workloads. Then it has turned out that even reservations
have to be per workload. Quite a convoluted stuff evolved around that
feature because it turned out that the initial assumption that only few
users would be using the pool simply didn't pass the reality check.

As I've mentioned in other response to James. If the direct map
manipulation is not as big of a problem as most of us dogmatically
believed then things become much simpler. There is no need for global
pool and you are back to mlock kinda model.
-- 
Michal Hocko
SUSE Labs
