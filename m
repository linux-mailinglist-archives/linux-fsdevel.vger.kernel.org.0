Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B54793AF6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 13:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbjIFLXa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 07:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238387AbjIFLX3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:23:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B52B1730;
        Wed,  6 Sep 2023 04:23:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40E8F1063;
        Wed,  6 Sep 2023 04:24:01 -0700 (PDT)
Received: from monolith (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E44573F7C5;
        Wed,  6 Sep 2023 04:23:13 -0700 (PDT)
Date:   Wed, 6 Sep 2023 12:23:21 +0100
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     David Hildenbrand <david@redhat.com>, will@kernel.org,
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
Message-ID: <ZPhfNVWXhabqnknK@monolith>
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
 <33def4fe-fdb8-6388-1151-fabd2adc8220@redhat.com>
 <ZOc0fehF02MohuWr@arm.com>
 <ebd3f142-43cc-dc92-7512-8f1c99073fce@redhat.com>
 <0b9c122a-c05a-b3df-c69f-85f520294adc@redhat.com>
 <ZOd2LvUKMguWdlgq@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOd2LvUKMguWdlgq@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Thank you for the feedback!

Catalin did a great job explaining what this patch series does, I'll add my
own comments on top of his.

On Thu, Aug 24, 2023 at 04:24:30PM +0100, Catalin Marinas wrote:
> On Thu, Aug 24, 2023 at 01:25:41PM +0200, David Hildenbrand wrote:
> > On 24.08.23 13:06, David Hildenbrand wrote:
> > > On 24.08.23 12:44, Catalin Marinas wrote:
> > > > The way MTE is implemented currently is to have a static carve-out of
> > > > the DRAM to store the allocation tags (a.k.a. memory colour). This is
> > > > what we call the tag storage. Each 16 bytes have 4 bits of tags, so this
> > > > means 1/32 of the DRAM, roughly 3% used for the tag storage. This is
> > > > done transparently by the hardware/interconnect (with firmware setup)
> > > > and normally hidden from the OS. So a checked memory access to location
> > > > X generates a tag fetch from location Y in the carve-out and this tag is
> > > > compared with the bits 59:56 in the pointer. The correspondence from X
> > > > to Y is linear (subject to a minimum block size to deal with some
> > > > address interleaving). The software doesn't need to know about this
> > > > correspondence as we have specific instructions like STG/LDG to location
> > > > X that lead to a tag store/load to Y.
> > > > 
> > > > Now, not all memory used by applications is tagged (mmap(PROT_MTE)).
> > > > For example, some large allocations may not use PROT_MTE at all or only
> > > > for the first and last page since initialising the tags takes time. The
> > > > side-effect is that of these 3% DRAM, only part, say 1% is effectively
> > > > used. Some people want the unused tag storage to be released for normal
> > > > data usage (i.e. give it to the kernel page allocator).
> [...]
> > > So it sounds like you might want to provide that tag memory using CMA.
> > > 
> > > That way, only movable allocations can end up on that CMA memory area,
> > > and you can allocate selected tag pages on demand (similar to the
> > > alloc_contig_range() use case).
> > > 
> > > That also solves the issue that such tag memory must not be longterm-pinned.
> > > 
> > > Regarding one complication: "The kernel needs to know where to allocate
> > > a PROT_MTE page from or migrate a current page if it becomes PROT_MTE
> > > (mprotect()) and the range it is in does not support tagging.",
> > > simplified handling would be if it's in a MIGRATE_CMA pageblock, it
> > > doesn't support tagging. You have to migrate to a !CMA page (for
> > > example, not specifying GFP_MOVABLE as a quick way to achieve that).
> > 
> > Okay, I now realize that this patch set effectively duplicates some CMA
> > behavior using a new migrate-type.
> 
> Yes, pretty much, with some additional hooks to trigger migration. The
> CMA mechanism was a great source of inspiration.
> 
> In addition, there are some races that are addressed mostly around page
> migration/copying: the source page is untagged, the destination
> allocated as untagged but before the copy an mprotect() makes the source
> tagged (PG_mte_tagged set) and the copy_highpage() mechanism not having
> anywhere to store the tags.
> 
> > Yeah, that's probably not what we want just to identify if memory is
> > taggable or not.
> > 
> > Maybe there is a way to just keep reusing most of CMA instead.
> 
> A potential issue is that devices (mobile phones) may need a different
> CMA range as well for DMA (and not necessarily in ZONE_DMA). Can
> free_area[MIGRATE_CMA] handle multiple disjoint ranges? I don't see why
> not as it's just a list.

I don't think that's a problem either, today the user can specify multiple
CMA ranges on the kernel command line (via "cma", "hugetlb_cma", etc). CMA
already has the mechanism to keep track of multiple regions - it stores in
the cma_areas array.

> 
> We (Google and Arm) went through a few rounds of discussions and
> prototyping trying to find the best approach: (1) a separate free_area[]
> array in each zone (early proof of concept from Peter C and Evgenii S,
> https://github.com/google/sanitizers/tree/master/mte-dynamic-carveout),
> (2) a new ZONE_METADATA, (3) a separate CPU-less NUMA node just for the
> tag storage, (4) a new MIGRATE_METADATA type.
> 
> We settled on the latter as it closely resembles CMA without interfering
> with it. I don't remember why we did not just go for MIGRATE_CMA, it may
> have been the heterogeneous memory aspect and the fact that we don't
> want PROT_MTE (VM_MTE) allocations from this range. If the hardware
> allowed this, I think the patches would have been a bit simpler.

You are correct, we settled on a new migrate type because the tag storage
memory is fundamentally a different memory type with different properties
than the rest of the memory in the system: tag storage memory cannot be
tagged, MIGRATE_CMA memory can be tagged.

> 
> Alex can comment more next week on how we ended up with this choice but
> if we find a way to avoid VM_MTE allocations from certain areas, I think
> we can reuse the CMA infrastructure. A bigger hammer would be no VM_MTE
> allocations from any CMA range but it seems too restrictive.

I considered mixing the tag storage memory memory with normal memory and
adding it to MIGRATE_CMA. But since tag storage memory cannot be tagged,
this means that it's not enough anymore to have a __GFP_MOVABLE allocation
request to use MIGRATE_CMA.

I considered two solutions to this problem:

1. Only allocate from MIGRATE_CMA is the requested memory is not tagged =>
this effectively means transforming all memory from MIGRATE_CMA into the
MIGRATE_METADATA migratetype that the series introduces. Not very
appealing, because that means treating normal memory that is also on the
MIGRATE_CMA lists as tagged memory.

2. Keep track of which pages are tag storage at page granularity (either by
a page flag, or by checking that the pfn falls in one of the tag storage
region, or by some other mechanism). When the page allocator takes free
pages from the MIGRATE_METADATA list to satisfy an allocation, compare the
gfp mask with the page type, and if the allocation is tagged and the page
is a tag storage page, put it back at the tail of the free list and choose
the next page. Repeat until the page allocator finds a normal memory page
that can be tagged (some refinements obviously needed to need to avoid
infinite loops).

I considered solution 2 to be more complicated than keeping track of tag
storage page at the migratetype level. Conceptually, keeping two distinct
memory type on separate migrate types looked to me like the cleaner and
simpler solution.

Maybe I missed something, I'm definitely open to suggestions regarding
putting the tag storage pages on MIGRATE_CMA (or another migratetype) if
that's a better approach.

Might be worth pointing out that putting the tag storage memory on the
MIGRATE_CMA migratetype only changes how the page allocator allocates
pages; all the other changes to migration/compaction/mprotect/etc will
still be there, because they are needed not because of how the tag storage
memory is represented by the page allocator, but because tag storage memory
cannot be tagged, and regular memory can.

Thanks,
Alex

> 
> > Another simpler idea to get started would be to just intercept the first
> > PROT_MTE, and allocate all CMA memory. In that case, systems that don't ever
> > use PROT_MTE can have that additional 3% of memory.
> 
> We had this on the table as well but the most likely deployment, at
> least initially, is only some secure services enabling MTE with various
> apps gradually moving towards this in time. So that's why the main
> pushback from vendors is having this 3% reserved permanently. Even if
> all apps use MTE, only the anonymous mappings are PROT_MTE, so still not
> fully using the tag storage.
> 
> -- 
> Catalin
> 
