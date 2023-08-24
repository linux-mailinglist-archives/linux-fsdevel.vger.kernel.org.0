Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CB8786D0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 12:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbjHXKpq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 06:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240848AbjHXKph (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:45:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61390D3;
        Thu, 24 Aug 2023 03:44:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC1126699F;
        Thu, 24 Aug 2023 10:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34910C433C8;
        Thu, 24 Aug 2023 10:44:17 +0000 (UTC)
Date:   Thu, 24 Aug 2023 11:44:13 +0100
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
Message-ID: <ZOc0fehF02MohuWr@arm.com>
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
 <33def4fe-fdb8-6388-1151-fabd2adc8220@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33def4fe-fdb8-6388-1151-fabd2adc8220@redhat.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 24, 2023 at 09:50:32AM +0200, David Hildenbrand wrote:
> after re-reading it 2 times, I still have no clue what your patch set is
> actually trying to achieve. Probably there is a way to describe how user
> space intents to interact with this feature, so to see which value this
> actually has for user space -- and if we are using the right APIs and
> allocators.

I'll try with an alternative summary, hopefully it becomes clearer (I
think Alex is away until the end of the week, may not reply
immediately). If this still doesn't work, maybe we should try a
different implementation ;).

The way MTE is implemented currently is to have a static carve-out of
the DRAM to store the allocation tags (a.k.a. memory colour). This is
what we call the tag storage. Each 16 bytes have 4 bits of tags, so this
means 1/32 of the DRAM, roughly 3% used for the tag storage. This is
done transparently by the hardware/interconnect (with firmware setup)
and normally hidden from the OS. So a checked memory access to location
X generates a tag fetch from location Y in the carve-out and this tag is
compared with the bits 59:56 in the pointer. The correspondence from X
to Y is linear (subject to a minimum block size to deal with some
address interleaving). The software doesn't need to know about this
correspondence as we have specific instructions like STG/LDG to location
X that lead to a tag store/load to Y.

Now, not all memory used by applications is tagged (mmap(PROT_MTE)).
For example, some large allocations may not use PROT_MTE at all or only
for the first and last page since initialising the tags takes time. The
side-effect is that of these 3% DRAM, only part, say 1% is effectively
used. Some people want the unused tag storage to be released for normal
data usage (i.e. give it to the kernel page allocator).

So the first complication is that a PROT_MTE page allocation at address
X will need to reserve the tag storage at location Y (and migrate any
data in that page if it is in use).

To make things worse, pages in the tag storage/carve-out range cannot
use PROT_MTE themselves on current hardware, so this adds the second
complication - a heterogeneous memory layout. The kernel needs to know
where to allocate a PROT_MTE page from or migrate a current page if it
becomes PROT_MTE (mprotect()) and the range it is in does not support
tagging.

Some other complications are arm64-specific like cache coherency between
tags and data accesses. There is a draft architecture spec which will be
released soon, detailing how the hardware behaves.

To your question about user APIs/ABIs, that's entirely transparent. As
with the current kernel (without this dynamic tag storage), a user only
needs to ask for PROT_MTE mappings to get tagged pages.

> So some dummy questions / statements
> 
> 1) Is this about re-propusing the memory used to hold tags for different
> purpose?

Yes. To allow part of this 3% to be used for data. It could even be the
whole 3% if no application is enabling MTE.

> Or what exactly is user space going to do with the PROT_MTE memory?
> The whole mprotect(PROT_MTE) approach might not eb the right thing to do.

As I mentioned above, there's no difference to the user ABI. PROT_MTE
works as before with the kernel moving pages around as needed.

> 2) Why do we even have to involve the page allocator if this is some
> special-purpose memory? Re-porpusing the buddy when later using
> alloc_contig_range() either way feels wrong.

The aim here is to rebrand this special-purpose memory as a nearly
general-purpose one (bar the PROT_MTE restriction).

> The core-mm changes don't look particularly appealing :)

OTOH, it's a fun project to learn about the mm ;).

Our aim for now is to get some feedback from the mm community on whether
this special -> nearly general rebranding is acceptable together with
the introduction of a heterogeneous memory concept for the general
purpose page allocator.

There are some alternatives we looked at with a smaller mm impact but we
haven't prototyped them yet: (a) use the available tag storage as a
frontswap accelerator or (b) use it as a (compressed) ramdisk that can
be mounted as swap. The latter has the advantage of showing up in the
available total memory, keeps customers happy ;). Both options would
need some mm hooks when a PROT_MTE page gets allocated to release the
corresponding page in the tag storage range.

-- 
Catalin
