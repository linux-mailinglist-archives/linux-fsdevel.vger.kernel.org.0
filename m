Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBA979ED01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 17:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjIMPa1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 11:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjIMPaM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:30:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A25F2685;
        Wed, 13 Sep 2023 08:29:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3072C433C8;
        Wed, 13 Sep 2023 15:29:27 +0000 (UTC)
Date:   Wed, 13 Sep 2023 16:29:25 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        oliver.upton@linux.dev, maz@kernel.org, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com, arnd@arndb.de,
        akpm@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
        pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, eugenis@google.com, kcc@google.com,
        hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 00/37] Add support for arm64 MTE dynamic tag storage
 reuse
Message-ID: <ZQHVVdlN9QQztc7Q@arm.com>
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
 <33def4fe-fdb8-6388-1151-fabd2adc8220@redhat.com>
 <ZOc0fehF02MohuWr@arm.com>
 <ebd3f142-43cc-dc92-7512-8f1c99073fce@redhat.com>
 <0b9c122a-c05a-b3df-c69f-85f520294adc@redhat.com>
 <ZOd2LvUKMguWdlgq@arm.com>
 <ZPhfNVWXhabqnknK@monolith>
 <ZP7/e8YFiosElvTm@arm.com>
 <0cc8a118-2522-f666-5bcc-af06263fd352@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cc8a118-2522-f666-5bcc-af06263fd352@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 11, 2023 at 02:29:03PM +0200, David Hildenbrand wrote:
> On 11.09.23 13:52, Catalin Marinas wrote:
> > On Wed, Sep 06, 2023 at 12:23:21PM +0100, Alexandru Elisei wrote:
> > > On Thu, Aug 24, 2023 at 04:24:30PM +0100, Catalin Marinas wrote:
> > > > On Thu, Aug 24, 2023 at 01:25:41PM +0200, David Hildenbrand wrote:
> > > > > On 24.08.23 13:06, David Hildenbrand wrote:
> > > > > > Regarding one complication: "The kernel needs to know where to allocate
> > > > > > a PROT_MTE page from or migrate a current page if it becomes PROT_MTE
> > > > > > (mprotect()) and the range it is in does not support tagging.",
> > > > > > simplified handling would be if it's in a MIGRATE_CMA pageblock, it
> > > > > > doesn't support tagging. You have to migrate to a !CMA page (for
> > > > > > example, not specifying GFP_MOVABLE as a quick way to achieve that).
> > > > > 
> > > > > Okay, I now realize that this patch set effectively duplicates some CMA
> > > > > behavior using a new migrate-type.
> > [...]
> > > I considered mixing the tag storage memory memory with normal memory and
> > > adding it to MIGRATE_CMA. But since tag storage memory cannot be tagged,
> > > this means that it's not enough anymore to have a __GFP_MOVABLE allocation
> > > request to use MIGRATE_CMA.
> > > 
> > > I considered two solutions to this problem:
> > > 
> > > 1. Only allocate from MIGRATE_CMA is the requested memory is not tagged =>
> > > this effectively means transforming all memory from MIGRATE_CMA into the
> > > MIGRATE_METADATA migratetype that the series introduces. Not very
> > > appealing, because that means treating normal memory that is also on the
> > > MIGRATE_CMA lists as tagged memory.
> > 
> > That's indeed not ideal. We could try this if it makes the patches
> > significantly simpler, though I'm not so sure.
> > 
> > Allocating metadata is the easier part as we know the correspondence
> > from the tagged pages (32 PROT_MTE page) to the metadata page (1 tag
> > storage page), so alloc_contig_range() does this for us. Just adding it
> > to the CMA range is sufficient.
> > 
> > However, making sure that we don't allocate PROT_MTE pages from the
> > metadata range is what led us to another migrate type. I guess we could
> > achieve something similar with a new zone or a CPU-less NUMA node,
> 
> Ideally, no significant core-mm changes to optimize for an architecture
> oddity. That implies, no new zones and no new migratetypes -- unless it is
> unavoidable and you are confident that you can convince core-MM people that
> the use case (giving back 3% of system RAM at max in some setups) is worth
> the trouble.

If I was an mm maintainer, I'd also question this ;). But vendors seem
pretty picky about the amount of RAM reserved for MTE (e.g. 0.5G for a
16G platform does look somewhat big). As more and more apps adopt MTE,
the wastage would be smaller but the first step is getting vendors to
enable it.

> I also had CPU-less NUMA nodes in mind when thinking about that, but not
> sure how easy it would be to integrate it. If the tag memory has actually
> different performance characteristics as well, a NUMA node would be the
> right choice.

In general I'd expect the same characteristics. However, changing the
memory designation from tag to data (and vice-versa) requires some cache
maintenance. The allocation cost is slightly higher (not the runtime
one), so it would help if the page allocator does not favour this range.
Anyway, that's an optimisation to worry about later.

> If we could find some way to easily support this either via CMA or CPU-less
> NUMA nodes, that would be much preferable; even if we cannot cover each and
> every future use case right now. I expect some issues with CXL+MTE either
> way , but are happy to be taught otherwise :)

I think CXL+MTE is rather theoretical at the moment. Given that PCIe
doesn't have any notion of MTE, more likely there would be some piece of
interconnect that generates two memory accesses: one for data and the
other for tags at a configurable offset (which may or may not be in the
same CXL range).

> Another thought I had was adding something like CMA memory characteristics.
> Like, asking if a given CMA area/page supports tagging (i.e., flag for the
> CMA area set?)?

I don't think adding CMA memory characteristics helps much. The metadata
allocation wouldn't go through cma_alloc() but rather
alloc_contig_range() directly for a specific pfn corresponding to the
data pages with PROT_MTE. The core mm code doesn't need to know about
the tag storage layout.

It's also unlikely for cma_alloc() memory to be mapped as PROT_MTE.
That's typically coming from device drivers (DMA API) with their own
mmap() implementation that doesn't normally set VM_MTE_ALLOWED (and
therefore PROT_MTE is rejected).

What we need though is to prevent vma_alloc_folio() from allocating from
a MIGRATE_CMA list if PROT_MTE (VM_MTE). I guess that's basically
removing __GFP_MOVABLE in those cases. As long as we don't have large
ZONE_MOVABLE areas, it shouldn't be an issue.

> When you need memory that supports tagging and have a page that does not
> support tagging (CMA && taggable), simply migrate to !MOVABLE memory
> (eventually we could also try adding !CMA).
> 
> Was that discussed and what would be the challenges with that? Page
> migration due to compaction comes to mind, but it might also be easy to
> handle if we can just avoid CMA memory for that.

IIRC that was because PROT_MTE pages would have to come only from
!MOVABLE ranges. Maybe that's not such big deal.

We'll give this a go and hopefully it simplifies the patches a bit (it
will take a while as Alex keeps going on holiday ;)). In the meantime,
I'm talking to the hardware people to see whether we can have MTE pages
in the tag storage/metadata range. We'd still need to reserve about 0.1%
of the RAM for the metadata corresponding to the tag storage range when
used as data but that's negligible (1/32 of 1/32). So if some future
hardware allows this, we can drop the page allocation restriction from
the CMA range.

> > though the latter is not guaranteed not to allocate memory from the
> > range, only make it less likely. Both these options are less flexible in
> > terms of size/alignment/placement.
> > 
> > Maybe as a quick hack - only allow PROT_MTE from ZONE_NORMAL and
> > configure the metadata range in ZONE_MOVABLE but at some point I'd
> > expect some CXL-attached memory to support MTE with additional carveout
> > reserved.
> 
> I have no idea how we could possibly cleanly support memory hotplug in
> virtual environments (virtual DIMMs, virtio-mem) with MTE. In contrast to
> s390x storage keys, the approach that arm64 with MTE took here (exposing tag
> memory to the VM) makes it rather hard and complicated.

The current thinking is that the VM is not aware of the tag storage,
that's entirely managed by the host. The host would treat the guest
memory similarly to the PROT_MTE user allocations, reserve metadata etc.

Thanks for the feedback so far, very useful.

-- 
Catalin
