Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63706314C40
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 10:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhBIJ4o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 04:56:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:54506 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230302AbhBIJyf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:54:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612864426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ys4lZa12PW2rFBR9uYb+XrRjecZKizZLu20iG5KOoeU=;
        b=qMkZ7XbqI1d8hRSD4sQuj8GloCeGKTkheB3rXPURIdHzln4FFQIx0n7YjCba0Bw7Yo+suG
        YVH6OFVka1kiTncyA9TPZgvqak3KFQTe+UD6eD7U0V5Q5FCqYqLZFu60NAxFSbvHXVFlM8
        PKcchFgHt4dmUy7k0ra5KqJyGsnIQ0A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4727BAC43;
        Tue,  9 Feb 2021 09:53:46 +0000 (UTC)
Date:   Tue, 9 Feb 2021 10:53:29 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
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
        x86@kernel.org
Subject: Re: [PATCH v17 00/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <YCJbmR11ikrWKaU8@dhcp22.suse.cz>
References: <20210208211326.GV242749@kernel.org>
 <1F6A73CF-158A-4261-AA6C-1F5C77F4F326@redhat.com>
 <YCJO8zLq8YkXGy8B@dhcp22.suse.cz>
 <662b5871-b461-0896-697f-5e903c23d7b9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <662b5871-b461-0896-697f-5e903c23d7b9@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 09-02-21 10:15:17, David Hildenbrand wrote:
> On 09.02.21 09:59, Michal Hocko wrote:
> > On Mon 08-02-21 22:38:03, David Hildenbrand wrote:
> > > 
> > > > Am 08.02.2021 um 22:13 schrieb Mike Rapoport <rppt@kernel.org>:
> > > > 
> > > > ﻿On Mon, Feb 08, 2021 at 10:27:18AM +0100, David Hildenbrand wrote:
> > > > > On 08.02.21 09:49, Mike Rapoport wrote:
> > > > > 
> > > > > Some questions (and request to document the answers) as we now allow to have
> > > > > unmovable allocations all over the place and I don't see a single comment
> > > > > regarding that in the cover letter:
> > > > > 
> > > > > 1. How will the issue of plenty of unmovable allocations for user space be
> > > > > tackled in the future?
> > > > > 
> > > > > 2. How has this issue been documented? E.g., interaction with ZONE_MOVABLE
> > > > > and CMA, alloc_conig_range()/alloc_contig_pages?.
> > > > 
> > > > Secretmem sets the mappings gfp mask to GFP_HIGHUSER, so it does not
> > > > allocate movable pages at the first place.
> > > 
> > > That is not the point. Secretmem cannot go on CMA / ZONE_MOVABLE
> > > memory and behaves like long-term pinnings in that sense. This is a
> > > real issue when using a lot of sectremem.
> > 
> > A lot of unevictable memory is a concern regardless of CMA/ZONE_MOVABLE.
> > As I've said it is quite easy to land at the similar situation even with
> > tmpfs/MAP_ANON|MAP_SHARED on swapless system. Neither of the two is
> > really uncommon. It would be even worse that those would be allowed to
> > consume both CMA/ZONE_MOVABLE.
> 
> IIRC, tmpfs/MAP_ANON|MAP_SHARED memory
> a) Is movable, can land in ZONE_MOVABLE/CMA
> b) Can be limited by sizing tmpfs appropriately
> 
> AFAIK, what you describe is a problem with memory overcommit, not with zone
> imbalances (below). Or what am I missing?

It can be problem for both. If you have just too much of shm (do not
forget about MAP_SHARED|MAP_ANON which is much harder to size from an
admin POV) then migrateability doesn't really help because you need a
free memory to migrate. Without reclaimability this can easily become a
problem. That is why I am saying this is not really a new problem.
Swapless systems are not all that uncommon.
 
> > One has to be very careful when relying on CMA or movable zones. This is
> > definitely worth a comment in the kernel command line parameter
> > documentation. But this is not a new problem.
> 
> I see the following thing worth documenting:
> 
> Assume you have a system with 2GB of ZONE_NORMAL/ZONE_DMA and 4GB of
> ZONE_MOVABLE/CMA.
> 
> Assume you make use of 1.5GB of secretmem. Your system might run into OOM
> any time although you still have plenty of memory on ZONE_MOVAVLE (and even
> swap!), simply because you are making excessive use of unmovable allocations
> (for user space!) in an environment where you should not make excessive use
> of unmovable allocations (e.g., where should page tables go?).

yes, you are right of course and I am not really disputing this. But I
would argue that 2:1 Movable/Normal is something to expect problems
already. "Lowmem" allocations can easily trigger OOM even without secret
mem in the picture. It all just takes to allocate a lot of GFP_KERNEL or
even GFP_{HIGH}USER. Really, it is CMA/MOVABLE that are elephant in the
room and one has to be really careful when relying on them.
 
> The existing controls (mlock limit) don't really match the current semantics
> of that memory. I repeat it once again: secretmem *currently* resembles
> long-term pinned memory, not mlocked memory.

Well, if we had a proper user space pinning accounting then I would
agree that there is a better model to use. But we don't. And previous
attempts to achieve that have failed. So I am afraid that we do not have
much choice left than using mlock as a model.

> Things will change when
> implementing migration support for secretmem pages. Until then, the
> semantics are different and this should be spelled out.
> 
> For long-term pinnings this is kind of obvious, still we're now documenting
> it because it's dangerous to not be aware of. Secretmem behaves exactly the
> same and I think this is worth spelling out: secretmem has the potential of
> being used much more often than fairly special vfio/rdma/ ...

yeah I do agree that pinning is a problem for movable/CMA but most
people simply do not care about those. Movable is the thing for hoptlug
and a really weird fragmentation avoidance IIRC and CMA is mostly to
handle crap HW. If those are to be used along with secret mem or
longterm GUP then they will constantly bump into corner cases. Do not
take me wrong, we should be looking at those problems, we should even
document them but I do not see this as anything new. We should probably
have a central place in Documentation explaining all those problems. I
would be even happy to see an explicit note in the tunables - e.g.
configuring movable/normal in 2:1 will get you back to 32b times wrt.
low mem problems.
-- 
Michal Hocko
SUSE Labs
