Return-Path: <linux-fsdevel+bounces-942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44797D3D12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 19:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA3D28145F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 17:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73991DA23;
	Mon, 23 Oct 2023 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D5D1B28C;
	Mon, 23 Oct 2023 17:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBAEC433C8;
	Mon, 23 Oct 2023 17:08:24 +0000 (UTC)
Date: Mon, 23 Oct 2023 18:08:21 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Hyesoo Yu <hyesoo.yu@samsung.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
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
	linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC 06/37] mm: page_alloc: Allocate from movable pcp
 lists only if ALLOC_FROM_METADATA
Message-ID: <ZTaohewXhtkqoLZD@arm.com>
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
 <20230823131350.114942-7-alexandru.elisei@arm.com>
 <CGME20231012013524epcas2p4b50f306e3e4d0b937b31f978022844e5@epcas2p4.samsung.com>
 <20231010074823.GA2536665@tiffany>
 <ZS0va9nICZo8bF03@monolith>
 <ZS5hXFHs08zQOboi@arm.com>
 <20231023071656.GA344850@tiffany>
 <ZTZP66CA1r35yTmp@arm.com>
 <25fad62e-b1d9-4d63-9d95-08c010756231@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25fad62e-b1d9-4d63-9d95-08c010756231@redhat.com>

On Mon, Oct 23, 2023 at 01:55:12PM +0200, David Hildenbrand wrote:
> On 23.10.23 12:50, Catalin Marinas wrote:
> > On Mon, Oct 23, 2023 at 04:16:56PM +0900, Hyesoo Yu wrote:
> > > Does tag storage itself supports tagging? Will the following version be unusable
> > > if the hardware does not support it? The document of google said that
> > > "If this memory is itself mapped as Tagged Normal (which should not happen!)
> > > then tag updates on it either raise a fault or do nothing, but never change the
> > > contents of any other page."
> > > (https://github.com/google/sanitizers/blob/master/mte-dynamic-carveout/spec.md)
> > > 
> > > The support of H/W is very welcome because it is good to make the patches simpler.
> > > But if H/W doesn't support it, Can't the new solution be used?
> > 
> > AFAIK on the current interconnects this is supported but the offsets
> > will need to be configured by firmware in such a way that a tag access
> > to the tag carve-out range still points to physical RAM, otherwise, as
> > per Google's doc, you can get some unexpected behaviour.
[...]
> I followed what you are saying, but I didn't quite read the following
> clearly stated in your calculations: Using this model, how much memory would
> you be able to reuse, and how much not?
> 
> I suspect you would *not* be able to reuse "1/(32*32)" [second carve-out]
> but be able to reuse "1/32 - 1/(32*32)" [first carve-out] or am I completely
> off?

That's correct. In theory, from the hardware perspective, we could even
go recursively to the third/fourth etc. carveout until the last one is a
single page but I'd rather not complicate things further.

> Further, (just thinking about it) I assume you've taken care of the
> condition that memory cannot self-host it's own tag memory. So that cannot
> happen in the model proposed here, right?

I don't fully understand what you mean. The tags for the first data
range (0 .. ram_size * 31/32) are stored in the first tag carveout.
That's where we'll need CMA. For the tag carveout, when hosting data
pages as tagged, the tags go in the second carveout which is fully
reserved (still TBD but possibly the firmware won't even tell the kernel
about it).

-- 
Catalin

