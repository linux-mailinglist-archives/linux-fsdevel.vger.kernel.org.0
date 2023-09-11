Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07E279AEF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 01:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240758AbjIKU4h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237027AbjIKLwm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:52:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA349E40;
        Mon, 11 Sep 2023 04:52:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C558C433C7;
        Mon, 11 Sep 2023 11:52:30 +0000 (UTC)
Date:   Mon, 11 Sep 2023 12:52:27 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Alexandru Elisei <alexandru.elisei@arm.com>
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
Message-ID: <ZP7/e8YFiosElvTm@arm.com>
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
 <33def4fe-fdb8-6388-1151-fabd2adc8220@redhat.com>
 <ZOc0fehF02MohuWr@arm.com>
 <ebd3f142-43cc-dc92-7512-8f1c99073fce@redhat.com>
 <0b9c122a-c05a-b3df-c69f-85f520294adc@redhat.com>
 <ZOd2LvUKMguWdlgq@arm.com>
 <ZPhfNVWXhabqnknK@monolith>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPhfNVWXhabqnknK@monolith>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 12:23:21PM +0100, Alexandru Elisei wrote:
> On Thu, Aug 24, 2023 at 04:24:30PM +0100, Catalin Marinas wrote:
> > On Thu, Aug 24, 2023 at 01:25:41PM +0200, David Hildenbrand wrote:
> > > On 24.08.23 13:06, David Hildenbrand wrote:
> > > > Regarding one complication: "The kernel needs to know where to allocate
> > > > a PROT_MTE page from or migrate a current page if it becomes PROT_MTE
> > > > (mprotect()) and the range it is in does not support tagging.",
> > > > simplified handling would be if it's in a MIGRATE_CMA pageblock, it
> > > > doesn't support tagging. You have to migrate to a !CMA page (for
> > > > example, not specifying GFP_MOVABLE as a quick way to achieve that).
> > > 
> > > Okay, I now realize that this patch set effectively duplicates some CMA
> > > behavior using a new migrate-type.
[...]
> I considered mixing the tag storage memory memory with normal memory and
> adding it to MIGRATE_CMA. But since tag storage memory cannot be tagged,
> this means that it's not enough anymore to have a __GFP_MOVABLE allocation
> request to use MIGRATE_CMA.
> 
> I considered two solutions to this problem:
> 
> 1. Only allocate from MIGRATE_CMA is the requested memory is not tagged =>
> this effectively means transforming all memory from MIGRATE_CMA into the
> MIGRATE_METADATA migratetype that the series introduces. Not very
> appealing, because that means treating normal memory that is also on the
> MIGRATE_CMA lists as tagged memory.

That's indeed not ideal. We could try this if it makes the patches
significantly simpler, though I'm not so sure.

Allocating metadata is the easier part as we know the correspondence
from the tagged pages (32 PROT_MTE page) to the metadata page (1 tag
storage page), so alloc_contig_range() does this for us. Just adding it
to the CMA range is sufficient.

However, making sure that we don't allocate PROT_MTE pages from the
metadata range is what led us to another migrate type. I guess we could
achieve something similar with a new zone or a CPU-less NUMA node,
though the latter is not guaranteed not to allocate memory from the
range, only make it less likely. Both these options are less flexible in
terms of size/alignment/placement.

Maybe as a quick hack - only allow PROT_MTE from ZONE_NORMAL and
configure the metadata range in ZONE_MOVABLE but at some point I'd
expect some CXL-attached memory to support MTE with additional carveout
reserved.

To recap, in this series, a PROT_MTE page allocation starts with a
typical allocation from anywhere other than MIGRATE_METADATA followed by
the hooks to reserve the corresponding metadata range at (pfn * 128 +
offset) for a 4K page. The whole metadata page is reserved, so the
adjacent 31 pages around the original allocation can also be mapped as
PROT_MTE.

(Peter and Evgenii @ Google had a slightly different approach in their
prototype: separate free_area[] array for PROT_MTE pages; while it has
some advantages, I found it more intrusive since the same page can be on
a free_area/free_list or another)

> 2. Keep track of which pages are tag storage at page granularity (either by
> a page flag, or by checking that the pfn falls in one of the tag storage
> region, or by some other mechanism). When the page allocator takes free
> pages from the MIGRATE_METADATA list to satisfy an allocation, compare the
> gfp mask with the page type, and if the allocation is tagged and the page
> is a tag storage page, put it back at the tail of the free list and choose
> the next page. Repeat until the page allocator finds a normal memory page
> that can be tagged (some refinements obviously needed to need to avoid
> infinite loops).

With large enough CMA areas, there's a real risk of latency spikes, RCU
stalls etc. Not really keen on such heuristics.

-- 
Catalin
