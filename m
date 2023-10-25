Return-Path: <linux-fsdevel+bounces-1136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D62B7D65A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 10:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D273B21165
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 08:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75231D557;
	Wed, 25 Oct 2023 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCE41CF8F;
	Wed, 25 Oct 2023 08:47:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC9C31BEE;
	Wed, 25 Oct 2023 01:47:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C9BD2F4;
	Wed, 25 Oct 2023 01:47:45 -0700 (PDT)
Received: from monolith (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F06E3F64C;
	Wed, 25 Oct 2023 01:46:58 -0700 (PDT)
Date: Wed, 25 Oct 2023 09:47:36 +0100
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Hyesoo Yu <hyesoo.yu@samsung.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>, will@kernel.org,
	oliver.upton@linux.dev, maz@kernel.org, james.morse@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com, arnd@arndb.de,
	akpm@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
	pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, eugenis@google.com, kcc@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 00/37] Add support for arm64 MTE dynamic tag storage
 reuse
Message-ID: <ZTjWKJ0K78jeCJr-@monolith>
References: <ZOc0fehF02MohuWr@arm.com>
 <ebd3f142-43cc-dc92-7512-8f1c99073fce@redhat.com>
 <0b9c122a-c05a-b3df-c69f-85f520294adc@redhat.com>
 <ZOd2LvUKMguWdlgq@arm.com>
 <ZPhfNVWXhabqnknK@monolith>
 <ZP7/e8YFiosElvTm@arm.com>
 <0cc8a118-2522-f666-5bcc-af06263fd352@redhat.com>
 <ZQHVVdlN9QQztc7Q@arm.com>
 <CGME20231025031004epcas2p485a0b7a9247bc61d54064d7f7bdd1e89@epcas2p4.samsung.com>
 <20231025025932.GA3953138@tiffany>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025025932.GA3953138@tiffany>

Hi,

On Wed, Oct 25, 2023 at 11:59:32AM +0900, Hyesoo Yu wrote:
> On Wed, Sep 13, 2023 at 04:29:25PM +0100, Catalin Marinas wrote:
> > On Mon, Sep 11, 2023 at 02:29:03PM +0200, David Hildenbrand wrote:
> > > On 11.09.23 13:52, Catalin Marinas wrote:
> > > > On Wed, Sep 06, 2023 at 12:23:21PM +0100, Alexandru Elisei wrote:
> > > > > On Thu, Aug 24, 2023 at 04:24:30PM +0100, Catalin Marinas wrote:
> > > > > > On Thu, Aug 24, 2023 at 01:25:41PM +0200, David Hildenbrand wrote:
> > > > > > > On 24.08.23 13:06, David Hildenbrand wrote:
> > > > > > > > Regarding one complication: "The kernel needs to know where to allocate
> > > > > > > > a PROT_MTE page from or migrate a current page if it becomes PROT_MTE
> > > > > > > > (mprotect()) and the range it is in does not support tagging.",
> > > > > > > > simplified handling would be if it's in a MIGRATE_CMA pageblock, it
> > > > > > > > doesn't support tagging. You have to migrate to a !CMA page (for
> > > > > > > > example, not specifying GFP_MOVABLE as a quick way to achieve that).
> > > > > > > 
> > > > > > > Okay, I now realize that this patch set effectively duplicates some CMA
> > > > > > > behavior using a new migrate-type.
> > > > [...]
> > > > > I considered mixing the tag storage memory memory with normal memory and
> > > > > adding it to MIGRATE_CMA. But since tag storage memory cannot be tagged,
> > > > > this means that it's not enough anymore to have a __GFP_MOVABLE allocation
> > > > > request to use MIGRATE_CMA.
> > > > > 
> > > > > I considered two solutions to this problem:
> > > > > 
> > > > > 1. Only allocate from MIGRATE_CMA is the requested memory is not tagged =>
> > > > > this effectively means transforming all memory from MIGRATE_CMA into the
> > > > > MIGRATE_METADATA migratetype that the series introduces. Not very
> > > > > appealing, because that means treating normal memory that is also on the
> > > > > MIGRATE_CMA lists as tagged memory.
> > > > 
> > > > That's indeed not ideal. We could try this if it makes the patches
> > > > significantly simpler, though I'm not so sure.
> > > > 
> > > > Allocating metadata is the easier part as we know the correspondence
> > > > from the tagged pages (32 PROT_MTE page) to the metadata page (1 tag
> > > > storage page), so alloc_contig_range() does this for us. Just adding it
> > > > to the CMA range is sufficient.
> > > > 
> > > > However, making sure that we don't allocate PROT_MTE pages from the
> > > > metadata range is what led us to another migrate type. I guess we could
> > > > achieve something similar with a new zone or a CPU-less NUMA node,
> > > 
> > > Ideally, no significant core-mm changes to optimize for an architecture
> > > oddity. That implies, no new zones and no new migratetypes -- unless it is
> > > unavoidable and you are confident that you can convince core-MM people that
> > > the use case (giving back 3% of system RAM at max in some setups) is worth
> > > the trouble.
> > 
> > If I was an mm maintainer, I'd also question this ;). But vendors seem
> > pretty picky about the amount of RAM reserved for MTE (e.g. 0.5G for a
> > 16G platform does look somewhat big). As more and more apps adopt MTE,
> > the wastage would be smaller but the first step is getting vendors to
> > enable it.
> > 
> > > I also had CPU-less NUMA nodes in mind when thinking about that, but not
> > > sure how easy it would be to integrate it. If the tag memory has actually
> > > different performance characteristics as well, a NUMA node would be the
> > > right choice.
> > 
> > In general I'd expect the same characteristics. However, changing the
> > memory designation from tag to data (and vice-versa) requires some cache
> > maintenance. The allocation cost is slightly higher (not the runtime
> > one), so it would help if the page allocator does not favour this range.
> > Anyway, that's an optimisation to worry about later.
> > 
> > > If we could find some way to easily support this either via CMA or CPU-less
> > > NUMA nodes, that would be much preferable; even if we cannot cover each and
> > > every future use case right now. I expect some issues with CXL+MTE either
> > > way , but are happy to be taught otherwise :)
> > 
> > I think CXL+MTE is rather theoretical at the moment. Given that PCIe
> > doesn't have any notion of MTE, more likely there would be some piece of
> > interconnect that generates two memory accesses: one for data and the
> > other for tags at a configurable offset (which may or may not be in the
> > same CXL range).
> > 
> > > Another thought I had was adding something like CMA memory characteristics.
> > > Like, asking if a given CMA area/page supports tagging (i.e., flag for the
> > > CMA area set?)?
> > 
> > I don't think adding CMA memory characteristics helps much. The metadata
> > allocation wouldn't go through cma_alloc() but rather
> > alloc_contig_range() directly for a specific pfn corresponding to the
> > data pages with PROT_MTE. The core mm code doesn't need to know about
> > the tag storage layout.
> > 
> > It's also unlikely for cma_alloc() memory to be mapped as PROT_MTE.
> > That's typically coming from device drivers (DMA API) with their own
> > mmap() implementation that doesn't normally set VM_MTE_ALLOWED (and
> > therefore PROT_MTE is rejected).
> > 
> > What we need though is to prevent vma_alloc_folio() from allocating from
> > a MIGRATE_CMA list if PROT_MTE (VM_MTE). I guess that's basically
> > removing __GFP_MOVABLE in those cases. As long as we don't have large
> > ZONE_MOVABLE areas, it shouldn't be an issue.
> > 
> 
> How about unsetting ALLOC_CMA if GFP_TAGGED ?
> Removing __GFP_MOVABLE may cause movable pages to be allocated in un
> unmovable migratetype, which may not be desirable for page fragmentation.

Yes, not setting ALLOC_CMA in alloc_flags if __GFP_TAGGED is what I am
intending to do.

> 
> > > When you need memory that supports tagging and have a page that does not
> > > support tagging (CMA && taggable), simply migrate to !MOVABLE memory
> > > (eventually we could also try adding !CMA).
> > > 
> > > Was that discussed and what would be the challenges with that? Page
> > > migration due to compaction comes to mind, but it might also be easy to
> > > handle if we can just avoid CMA memory for that.
> > 
> > IIRC that was because PROT_MTE pages would have to come only from
> > !MOVABLE ranges. Maybe that's not such big deal.
> > 
> 
> Could you explain what it means that PROT_MTE have to come only from
> !MOVABLE range ? I don't understand this part very well.

I believe that was with the old approach, where tag storage cannot be tagged.

I'm guessing that the idea was that during migration of a tagged page, to make
sure that the destination page is not a tag storage page (which cannot be
tagged), the gfp flags used for allocating the destination page would be set
without __GFP_MOVABLE, which ensures that the destination page is not
allocated from MIGRATE_CMA. But that is not needed anymore, if we don't set
ALLOC_CMA if __GFP_TAGGED.

Thanks,
Alex

> 
> Thanks,
> Hyesoo.
> 
> > We'll give this a go and hopefully it simplifies the patches a bit (it
> > will take a while as Alex keeps going on holiday ;)). In the meantime,
> > I'm talking to the hardware people to see whether we can have MTE pages
> > in the tag storage/metadata range. We'd still need to reserve about 0.1%
> > of the RAM for the metadata corresponding to the tag storage range when
> > used as data but that's negligible (1/32 of 1/32). So if some future
> > hardware allows this, we can drop the page allocation restriction from
> > the CMA range.
> > 
> > > > though the latter is not guaranteed not to allocate memory from the
> > > > range, only make it less likely. Both these options are less flexible in
> > > > terms of size/alignment/placement.
> > > > 
> > > > Maybe as a quick hack - only allow PROT_MTE from ZONE_NORMAL and
> > > > configure the metadata range in ZONE_MOVABLE but at some point I'd
> > > > expect some CXL-attached memory to support MTE with additional carveout
> > > > reserved.
> > > 
> > > I have no idea how we could possibly cleanly support memory hotplug in
> > > virtual environments (virtual DIMMs, virtio-mem) with MTE. In contrast to
> > > s390x storage keys, the approach that arm64 with MTE took here (exposing tag
> > > memory to the VM) makes it rather hard and complicated.
> > 
> > The current thinking is that the VM is not aware of the tag storage,
> > that's entirely managed by the host. The host would treat the guest
> > memory similarly to the PROT_MTE user allocations, reserve metadata etc.
> > 
> > Thanks for the feedback so far, very useful.
> > 
> > -- 
> > Catalin
> > 



