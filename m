Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947202615DD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 18:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbgIHQ5g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 12:57:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731847AbgIHQUW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:20:22 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9CE821D93;
        Tue,  8 Sep 2020 12:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599568323;
        bh=E4o1TDNMgXR3ltqTwm9aXT1R3QWQWrh1SreqKE+iRdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SyEwTcWeWaj5fnJOWcZkA4g1K/6G3dZ9eGWpWoOs8wFLveiNeFY/HN9Ys3hddw4Ix
         Hda12jT7gq0vHLbLYRlYfMUWaeSI3gTzRMim2LXupXZs1Vve7Fui8jwLq6j5cAimFf
         5f9ZDd5aFctsg+vQXtTjJfOj10UunsKMmHI5oNQc=
Date:   Tue, 8 Sep 2020 15:31:50 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v4 6/6] mm: secretmem: add ability to reserve memory at
 boot
Message-ID: <20200908123150.GF1976319@kernel.org>
References: <20200818141554.13945-1-rppt@kernel.org>
 <20200818141554.13945-7-rppt@kernel.org>
 <03ec586d-c00c-c57e-3118-7186acb7b823@redhat.com>
 <20200819115335.GU752365@kernel.org>
 <10bf57a9-c3c2-e13c-ca50-e872b7a2db0c@redhat.com>
 <20200819173347.GW752365@kernel.org>
 <6c8b30fb-1b6c-d446-0b09-255b79468f7c@redhat.com>
 <20200820155228.GZ752365@kernel.org>
 <fdda6ba7-9418-2b52-eee8-ce5e9bfdb6ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdda6ba7-9418-2b52-eee8-ce5e9bfdb6ad@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On Tue, Sep 08, 2020 at 11:09:19AM +0200, David Hildenbrand wrote:
> On 20.08.20 17:52, Mike Rapoport wrote:
> > On Wed, Aug 19, 2020 at 07:45:29PM +0200, David Hildenbrand wrote:
> >> On 19.08.20 19:33, Mike Rapoport wrote:
> >>> On Wed, Aug 19, 2020 at 02:10:43PM +0200, David Hildenbrand wrote:
> >>>> On 19.08.20 13:53, Mike Rapoport wrote:
> >>>>> On Wed, Aug 19, 2020 at 12:49:05PM +0200, David Hildenbrand wrote:
> >>>>>> On 18.08.20 16:15, Mike Rapoport wrote:
> >>>>>>> From: Mike Rapoport <rppt@linux.ibm.com>
> >>>>>>>
> >>>>>>> Taking pages out from the direct map and bringing them back may create
> >>>>>>> undesired fragmentation and usage of the smaller pages in the direct
> >>>>>>> mapping of the physical memory.
> >>>>>>>
> >>>>>>> This can be avoided if a significantly large area of the physical memory
> >>>>>>> would be reserved for secretmem purposes at boot time.
> >>>>>>>
> >>>>>>> Add ability to reserve physical memory for secretmem at boot time using
> >>>>>>> "secretmem" kernel parameter and then use that reserved memory as a global
> >>>>>>> pool for secret memory needs.
> >>>>>>
> >>>>>> Wouldn't something like CMA be the better fit? Just wondering. Then, the
> >>>>>> memory can actually be reused for something else while not needed.
> >>>>>
> >>>>> The memory allocated as secret is removed from the direct map and the
> >>>>> boot time reservation is intended to reduce direct map fragmentatioan
> >>>>> and to avoid splitting 1G pages there. So with CMA I'd still need to
> >>>>> allocate 1G chunks for this and once 1G page is dropped from the direct
> >>>>> map it still cannot be reused for anything else until it is freed.
> >>>>>
> >>>>> I could use CMA to do the boot time reservation, but doing the
> >>>>> reservesion directly seemed simpler and more explicit to me.
> >>>>
> >>>> Well, using CMA would give you the possibility to let the memory be used
> >>>> for other purposes until you decide it's the right time to take it +
> >>>> remove the direct mapping etc.
> >>>
> >>> I still can't say I follow you here. If I reseve a CMA area as a pool
> >>> for secret memory 1G pages, it is still reserved and it still cannot be
> >>> used for other purposes, right?
> >>
> >> So, AFAIK, if you create a CMA pool it can be used for any MOVABLE
> >> allocations (similar to ZONE_MOVABLE) until you actually allocate CMA
> >> memory from that region. Other allocations on that are will then be
> >> migrated away (using alloc_contig_range()).
> >>
> >> For example, if you have a 1~GiB CMA area, you could allocate 4~MB pages
> >> from that CMA area on demand (removing the direct mapping, etc ..), and
> >> free when no longer needed (instantiating the direct mapping). The free
> >> memory in that area could used for MOVABLE allocations.
> > 
> > The boot time resrvation is intended to avoid splitting 1G pages in the
> > direct map. Without the boot time reservation, we maintain a pool of 2M
> > pages so the 1G pages are split and 2M pages remain unsplit.
> > 
> > If I scale your example to match the requirement to avoid splitting 1G
> > pages in the direct map, that would mean creating a CMA area of several
> > tens of gigabytes and then doing cma_alloc() of 1G each time we need to
> > refill the secretmem pool. 
> > 
> > It is quite probable that we won't be able to get 1G from CMA after the
> > system worked for some time.
> 
> Why? It should only contain movable pages, and if that is not the case,
> it's a bug we have to fix. It should behave just as ZONE_MOVABLE.
> (although I agree that in corner cases, alloc_contig_pages() might
> temporarily fail on some chunks - e.g., with long/short-term page
> pinnings - in contrast to memory offlining, it won't retry forever)
 
The use-case I had in mind for the boot time reservation in secretmem is
a machine that runs VMs and there is a desire to have the VM memory
protected from the host. In a way this should be similar to booting a
host with mem=X where most of the machine memory never gets to be used
by the host kernel.

For such use case, boot time reservation controlled by the command
line parameter seems to me simpler than using CMA. I agree that there is
no way to use the reserved memory for other purpose, but then we won't
need to create physically contiguous chunk of several gigs every time a
VM is created.

> > With boot time reservation we won't need physcally contiguous 1G to
> > satisfy smaller allocation requests for secretmem because we don't need
> > to maintain 1G mappings in the secretmem pool.
> 
> You can allocate within your CMA area however you want - doesn't need to
> be whole gigabytes in case there is no need for it.

The whole point of boot time reservation is to prevent splitting 1G
pages in the direct map. Allocating smaller chunks will still cause
fragmentation of the direct map.

> Again, the big benefit of CMA is that the reserved memory can be reused
> for other purpose while nobody is actually making use of it.

Right, but I think if a user explicitly asked to use X gigabytes for the
secretmem we can allow that.

> > 
> > That said, I believe the addition of the boot time reservation, either
> > direct or with CMA, can be added as an incrememntal patch after the
> > "core" functionality is merged.
> 
> I am not convinced that we want to let random processes to do
> alloc_pages() in the range of tens of gigabytes. It's not just mlocked
> memory. I prefer either using CMA or relying on the boot time
> reservations. But let's see if there are other opinions and people just
> don't care.
> 
> Having that said, I have no further comments.
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
