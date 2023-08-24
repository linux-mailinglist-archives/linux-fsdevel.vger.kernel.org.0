Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57337787408
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 17:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241587AbjHXPZD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 11:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjHXPYx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:24:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE2219B0;
        Thu, 24 Aug 2023 08:24:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF97667272;
        Thu, 24 Aug 2023 15:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E56EC433C8;
        Thu, 24 Aug 2023 15:24:34 +0000 (UTC)
Date:   Thu, 24 Aug 2023 16:24:30 +0100
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
Message-ID: <ZOd2LvUKMguWdlgq@arm.com>
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
 <33def4fe-fdb8-6388-1151-fabd2adc8220@redhat.com>
 <ZOc0fehF02MohuWr@arm.com>
 <ebd3f142-43cc-dc92-7512-8f1c99073fce@redhat.com>
 <0b9c122a-c05a-b3df-c69f-85f520294adc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b9c122a-c05a-b3df-c69f-85f520294adc@redhat.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 24, 2023 at 01:25:41PM +0200, David Hildenbrand wrote:
> On 24.08.23 13:06, David Hildenbrand wrote:
> > On 24.08.23 12:44, Catalin Marinas wrote:
> > > The way MTE is implemented currently is to have a static carve-out of
> > > the DRAM to store the allocation tags (a.k.a. memory colour). This is
> > > what we call the tag storage. Each 16 bytes have 4 bits of tags, so this
> > > means 1/32 of the DRAM, roughly 3% used for the tag storage. This is
> > > done transparently by the hardware/interconnect (with firmware setup)
> > > and normally hidden from the OS. So a checked memory access to location
> > > X generates a tag fetch from location Y in the carve-out and this tag is
> > > compared with the bits 59:56 in the pointer. The correspondence from X
> > > to Y is linear (subject to a minimum block size to deal with some
> > > address interleaving). The software doesn't need to know about this
> > > correspondence as we have specific instructions like STG/LDG to location
> > > X that lead to a tag store/load to Y.
> > > 
> > > Now, not all memory used by applications is tagged (mmap(PROT_MTE)).
> > > For example, some large allocations may not use PROT_MTE at all or only
> > > for the first and last page since initialising the tags takes time. The
> > > side-effect is that of these 3% DRAM, only part, say 1% is effectively
> > > used. Some people want the unused tag storage to be released for normal
> > > data usage (i.e. give it to the kernel page allocator).
[...]
> > So it sounds like you might want to provide that tag memory using CMA.
> > 
> > That way, only movable allocations can end up on that CMA memory area,
> > and you can allocate selected tag pages on demand (similar to the
> > alloc_contig_range() use case).
> > 
> > That also solves the issue that such tag memory must not be longterm-pinned.
> > 
> > Regarding one complication: "The kernel needs to know where to allocate
> > a PROT_MTE page from or migrate a current page if it becomes PROT_MTE
> > (mprotect()) and the range it is in does not support tagging.",
> > simplified handling would be if it's in a MIGRATE_CMA pageblock, it
> > doesn't support tagging. You have to migrate to a !CMA page (for
> > example, not specifying GFP_MOVABLE as a quick way to achieve that).
> 
> Okay, I now realize that this patch set effectively duplicates some CMA
> behavior using a new migrate-type.

Yes, pretty much, with some additional hooks to trigger migration. The
CMA mechanism was a great source of inspiration.

In addition, there are some races that are addressed mostly around page
migration/copying: the source page is untagged, the destination
allocated as untagged but before the copy an mprotect() makes the source
tagged (PG_mte_tagged set) and the copy_highpage() mechanism not having
anywhere to store the tags.

> Yeah, that's probably not what we want just to identify if memory is
> taggable or not.
> 
> Maybe there is a way to just keep reusing most of CMA instead.

A potential issue is that devices (mobile phones) may need a different
CMA range as well for DMA (and not necessarily in ZONE_DMA). Can
free_area[MIGRATE_CMA] handle multiple disjoint ranges? I don't see why
not as it's just a list.

We (Google and Arm) went through a few rounds of discussions and
prototyping trying to find the best approach: (1) a separate free_area[]
array in each zone (early proof of concept from Peter C and Evgenii S,
https://github.com/google/sanitizers/tree/master/mte-dynamic-carveout),
(2) a new ZONE_METADATA, (3) a separate CPU-less NUMA node just for the
tag storage, (4) a new MIGRATE_METADATA type.

We settled on the latter as it closely resembles CMA without interfering
with it. I don't remember why we did not just go for MIGRATE_CMA, it may
have been the heterogeneous memory aspect and the fact that we don't
want PROT_MTE (VM_MTE) allocations from this range. If the hardware
allowed this, I think the patches would have been a bit simpler.

Alex can comment more next week on how we ended up with this choice but
if we find a way to avoid VM_MTE allocations from certain areas, I think
we can reuse the CMA infrastructure. A bigger hammer would be no VM_MTE
allocations from any CMA range but it seems too restrictive.

> Another simpler idea to get started would be to just intercept the first
> PROT_MTE, and allocate all CMA memory. In that case, systems that don't ever
> use PROT_MTE can have that additional 3% of memory.

We had this on the table as well but the most likely deployment, at
least initially, is only some secure services enabling MTE with various
apps gradually moving towards this in time. So that's why the main
pushback from vendors is having this 3% reserved permanently. Even if
all apps use MTE, only the anonymous mappings are PROT_MTE, so still not
fully using the tag storage.

-- 
Catalin
