Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786B230865C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 08:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhA2HWb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 02:22:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:40624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhA2HW2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:22:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFF4764DFF;
        Fri, 29 Jan 2021 07:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611904906;
        bh=NGPVE0T2yDfzE3jsleZ51uyBOURj43/DKZo4DEUYgL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a64cCYp6LVDN9rc75p+01u8IW5fw/bN2EdsNx+IABYTwj1i4JOBtzJvRknWyJc/J7
         T52AuZy7pyjPKZ7QZu+wKtBfqCmigfwc/Dvz3QN7mz43ePh5UhCDDbWOD1E5YGhGzV
         wPbtwiDgaLzyUeLcdUi+JOYIp31MvzVMMRWuhINnli/F66n9915eRLn0EOIFyB4ZO8
         wlmLxu9iLOV8KiftxFouX4rgVx232aCXqGGzNxLKwDd9wpXTDoFGFkXI0knbjgu+Ij
         uSrdbgHPpUkaQkJEWC9FddlNhYIa66q3F5imgc1LAIfa+9f41PojeHOXz2yia5DWYQ
         0OIfdJEzC+XGA==
Date:   Fri, 29 Jan 2021 09:21:28 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
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
Message-ID: <20210129072128.GD242749@kernel.org>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-8-rppt@kernel.org>
 <20210126114657.GL827@dhcp22.suse.cz>
 <303f348d-e494-e386-d1f5-14505b5da254@redhat.com>
 <20210126120823.GM827@dhcp22.suse.cz>
 <20210128092259.GB242749@kernel.org>
 <YBK1kqL7JA7NePBQ@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBK1kqL7JA7NePBQ@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 28, 2021 at 02:01:06PM +0100, Michal Hocko wrote:
> On Thu 28-01-21 11:22:59, Mike Rapoport wrote:
> 
> > And hugetlb pools may be also depleted by anybody by calling
> > mmap(MAP_HUGETLB) and there is no any limiting knob for this, while
> > secretmem has RLIMIT_MEMLOCK.
> 
> Yes it can fail. But it would fail at the mmap time when the reservation
> fails. Not during the #PF time which can be at any time.

It may fail at $PF time as well:

hugetlb_fault()
        hugeltb_no_page()
                ...
                alloc_huge_page()
                        alloc_gigantic_page()
                                cma_alloc()
                                        -ENOMEM; 

 
> > That said, simply replacing VM_FAULT_OOM with VM_FAULT_SIGBUS makes
> > secretmem at least as controllable and robust than hugeltbfs even without
> > complex reservation at mmap() time.
> 
> Still sucks huge!
 
Any #PF can get -ENOMEM for whatever reason. Sucks huge indeed.

> > > > > So unless I am really misreading the code
> > > > > Nacked-by: Michal Hocko <mhocko@suse.com>
> > > > > 
> > > > > That doesn't mean I reject the whole idea. There are some details to
> > > > > sort out as mentioned elsewhere but you cannot really depend on
> > > > > pre-allocated pool which can fail at a fault time like that.
> > > > 
> > > > So, to do it similar to hugetlbfs (e.g., with CMA), there would have to be a
> > > > mechanism to actually try pre-reserving (e.g., from the CMA area), at which
> > > > point in time the pages would get moved to the secretmem pool, and a
> > > > mechanism for mmap() etc. to "reserve" from these secretmem pool, such that
> > > > there are guarantees at fault time?
> > > 
> > > yes, reserve at mmap time and use during the fault. But this all sounds
> > > like a self inflicted problem to me. Sure you can have a pre-allocated
> > > or more dynamic pool to reduce the direct mapping fragmentation but you
> > > can always fall back to regular allocatios. In other ways have the pool
> > > as an optimization rather than a hard requirement. With a careful access
> > > control this sounds like a manageable solution to me.
> > 
> > I'd really wish we had this discussion for earlier spins of this series,
> > but since this didn't happen let's refresh the history a bit.
> 
> I am sorry but I am really fighting to find time to watch for all the
> moving targets...
> 
> > One of the major pushbacks on the first RFC [1] of the concept was about
> > the direct map fragmentation. I tried really hard to find data that shows
> > what is the performance difference with different page sizes in the direct
> > map and I didn't find anything.
> > 
> > So presuming that large pages do provide advantage the first implementation
> > of secretmem used PMD_ORDER allocations to amortise the effect of the
> > direct map fragmentation and then handed out 4k pages at each fault. In
> > addition there was an option to reserve a finite pool at boot time and
> > limit secretmem allocations only to that pool.
> > 
> > At some point David suggested to use CMA to improve overall flexibility
> > [3], so I switched secretmem to use CMA.
> > 
> > Now, with the data we have at hand (my benchmarks and Intel's report David
> > mentioned) I'm even not sure this whole pooling even required.
> 
> I would still like to understand whether that data is actually
> representative. With some underlying reasoning rather than I have run
> these XYZ benchmarks and numbers do not look terrible.

I would also very much like to see, for example, reasoning to enabling 1GB
pages in the direct map beyond "because we can" (commits 00d1c5e05736
("x86: add gbpages switches") and ef9257668e31 ("x86: do kernel direct
mapping at boot using GB pages")).

The original Kconfig text for CONFIG_DIRECT_GBPAGES said

          Enable gigabyte pages support (if the CPU supports it). This can
          improve the kernel's performance a tiny bit by reducing TLB
          pressure.

So it is very interesting how tiny that bit was.
 
> > I like the idea to have a pool as an optimization rather than a hard
> > requirement but I don't see why would it need a careful access control. As
> > the direct map fragmentation is not necessarily degrades the performance
> > (and even sometimes it actually improves it) and even then the degradation
> > is small, trying a PMD_ORDER allocation for a pool and then falling back to
> > 4K page may be just fine.
> 
> Well, as soon as this is a scarce resource then an access control seems
> like a first thing to think of. Maybe it is not really necessary but
> then this should be really justified.

And what being a scarce resource here? If we consider lack of the direct
map fragmentation as this resource, there enough measures secretmem
implements to limit user ability to fragment the direct map, as was already
discussed several times. Global limit, memcg and rlimit provide enough
access control already.

-- 
Sincerely yours,
Mike.
