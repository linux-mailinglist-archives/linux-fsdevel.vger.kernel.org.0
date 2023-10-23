Return-Path: <linux-fsdevel+bounces-911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B54277D3066
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 12:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2AA6B20E1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 10:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC0D13AC8;
	Mon, 23 Oct 2023 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBA512B90;
	Mon, 23 Oct 2023 10:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CFEC433C8;
	Mon, 23 Oct 2023 10:50:21 +0000 (UTC)
Date: Mon, 23 Oct 2023 11:50:19 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Hyesoo Yu <hyesoo.yu@samsung.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
	oliver.upton@linux.dev, maz@kernel.org, james.morse@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com, arnd@arndb.de,
	akpm@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
	pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
	kcc@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH RFC 06/37] mm: page_alloc: Allocate from movable pcp
 lists only if ALLOC_FROM_METADATA
Message-ID: <ZTZP66CA1r35yTmp@arm.com>
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
 <20230823131350.114942-7-alexandru.elisei@arm.com>
 <CGME20231012013524epcas2p4b50f306e3e4d0b937b31f978022844e5@epcas2p4.samsung.com>
 <20231010074823.GA2536665@tiffany>
 <ZS0va9nICZo8bF03@monolith>
 <ZS5hXFHs08zQOboi@arm.com>
 <20231023071656.GA344850@tiffany>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023071656.GA344850@tiffany>

On Mon, Oct 23, 2023 at 04:16:56PM +0900, Hyesoo Yu wrote:
> On Tue, Oct 17, 2023 at 11:26:36AM +0100, Catalin Marinas wrote:
> > BTW, I suggest for the next iteration we drop MIGRATE_METADATA, only use
> > CMA and assume that the tag storage itself supports tagging. Hopefully
> > it makes the patches a bit simpler.
> 
> I am curious about the plan for the next iteration.

Alex is working on it.

> Does tag storage itself supports tagging? Will the following version be unusable
> if the hardware does not support it? The document of google said that 
> "If this memory is itself mapped as Tagged Normal (which should not happen!)
> then tag updates on it either raise a fault or do nothing, but never change the
> contents of any other page."
> (https://github.com/google/sanitizers/blob/master/mte-dynamic-carveout/spec.md)
> 
> The support of H/W is very welcome because it is good to make the patches simpler.
> But if H/W doesn't support it, Can't the new solution be used?

AFAIK on the current interconnects this is supported but the offsets
will need to be configured by firmware in such a way that a tag access
to the tag carve-out range still points to physical RAM, otherwise, as
per Google's doc, you can get some unexpected behaviour.

Let's take a simplified example, we have:

  phys_addr - physical address, linearised, starting from 0
  ram_size - the size of RAM (also corresponds to the end of PA+1)

A typical configuration is to designate the top 1/32 of RAM for tags:

  tag_offset = ram_size - ram_size / 32
  tag_carveout_start = tag_offset

The tag address for a given phys_addr is calculated as:

  tag_addr = phys_addr / 32 + tag_offset

To keep things simple, we reserve the top 1/(32*32) of the RAM as tag
storage for the main/reusable tag carveout.

  tag_carveout2_start = tag_carveout_start / 32 + tag_offset

This gives us the end of the first reusable carveout:

  tag_carveout_end = tag_carveout2_start - 1

and this way in Linux we can have (inclusive ranges):

  0..(tag_carveout_start-1): normal memory, data only
  tag_carveout_start..tag_carveout_end: CMA, reused as tags or data
  tag_carveout2_start..(ram_size-1): reserved for tags (not touched by the OS)

For this to work, we need the last page in the first carveout to have
a tag storage within RAM. And, of course, all of the above need to be at
least 4K aligned.

The simple configuration of 1/(32*32) of RAM for the second carveout is
sufficient but not fully utilised. We could be a bit more efficient to
gain a few more pages. Apart from the page alignment requirements, the
only strict requirement we need is:

  tag_carverout2_end < ram_size

where tag_carveout2_end is the tag storage corresponding to the end of
the main/reusable carveout, just before tag_carveout2_start:

  tag_carveout2_end = tag_carveout_end / 32 + tag_offset

Assuming that my on-paper substitutions are correct, the inequality
above becomes:

  tag_offset < (1024 * ram_size + 32) / 1057

and tag_offset is a multiple of PAGE_SIZE * 32 (so that the
tag_carveout2_start is a multiple of PAGE_SIZE).

As a concrete example, for 16GB of RAM starting from 0:

  tag_offset = 0x3e0060000
  tag_carverout2_start = 0x3ff063000

Without the optimal placement, the default tag_offset of top 1/32 of RAM
would have been:

  tag_offset = 0x3e0000000
  tag_carveou2_start = 0x3ff000000

so an extra 396KB gained with optimal placement (out of 16G, not sure
it's worth).

One can put the calculations in some python script to get the optimal
tag offset in case I got something wrong on paper.

-- 
Catalin

