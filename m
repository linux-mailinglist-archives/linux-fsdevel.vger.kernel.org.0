Return-Path: <linux-fsdevel+bounces-4200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881DF7FD995
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 15:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412AF282665
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBA83218B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C262BB2;
	Wed, 29 Nov 2023 05:41:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EDEE2F4;
	Wed, 29 Nov 2023 05:42:27 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CA6E3F5A1;
	Wed, 29 Nov 2023 05:41:35 -0800 (PST)
Date: Wed, 29 Nov 2023 13:41:32 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: David Hildenbrand <david@redhat.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, pcc@google.com,
	steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, eugenis@google.com, kcc@google.com,
	hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 18/27] arm64: mte: Reserve tag block for the zero
 page
Message-ID: <ZWc_jCy7B6jdc5rP@raptor>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <20231119165721.9849-19-alexandru.elisei@arm.com>
 <c027ea00-a955-4c3c-b1ea-2c3f6906790d@redhat.com>
 <ZWcgzPcld1YksCtZ@raptor>
 <930b6fba-43bf-4784-9bc9-1c83c1adc30c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <930b6fba-43bf-4784-9bc9-1c83c1adc30c@redhat.com>

Hi,

On Wed, Nov 29, 2023 at 02:13:50PM +0100, David Hildenbrand wrote:
> On 29.11.23 12:30, Alexandru Elisei wrote:
> > On Tue, Nov 28, 2023 at 06:06:54PM +0100, David Hildenbrand wrote:
> > > On 19.11.23 17:57, Alexandru Elisei wrote:
> > > > On arm64, the zero page receives special treatment by having the tagged
> > > > flag set on MTE initialization, not when the page is mapped in a process
> > > > address space. Reserve the corresponding tag block when tag storage
> > > > management is being activated.
> > > 
> > > Out of curiosity: why does the shared zeropage require tagged storage? What
> > > about the huge zeropage?
> > 
> > There are two different tags that are used for tag checking: the logical
> > tag, the tag embedded in bits 59:56 of an address, and the physical tag
> > corresponding to the address. This tag is stored in a separate memory
> > location, called tag storage. When an access is performed, hardware
> > compares the logical tag (from the address) with the physical tag (from the
> > tag storage). If they match, the access is permitted.
> 
> Ack, matches my understanding.
> 
> > 
> > The physical tag is set with special instructions.
> > 
> > Userspace pointers have bits 59:56 zero. If the pointer is in a VMA with
> > MTE enabled, then for userspace to be able to access this address, the
> > physical tag must also be 0b0000.
> > 
> > To make it easier on userspace, when a page is first mapped as tagged, its
> > tags are cleared by the kernel; this way, userspace can access the address
> > immediately, without clearing the physical tags beforehand. Another reason
> > for clearing the physical tags when a page is mapped as tagged would be to
> > avoid leaking uninitialized tags to userspace.
> 
> Make sense. Zero it just like we zero page content.
> 
> > 
> > The zero page is special, because the physical tags are not zeroed every
> > time the page is mapped in a process; instead, the zero page is marked as
> > tagged (by setting a page flag) and the physical tags are zeroed only once,
> > when MTE is enabled at boot.
> 
> Makes sense.
> 
> > 
> > All of this means that when tag storage is enabled, which happens after MTE
> > is enabled, the tag storage corresponding to the zero page is already in
> > use and must be rezerved, and it can never be used for data allocations.
> > 
> > I hope all of the above makes sense. I can also put it in the commit
> > message :)
> 
> Yes, makes sense!
> 
> > 
> > As for the zero huge page, the MTE code in the kernel treats it like a
> > regular page, and it zeroes the tags when it is mapped as tagged in a
> > process. I agree that this might not be the best solution from a
> > performance perspective, but it has worked so far.
> 
> What if user space were to change the tag of that shared resource?
> 
> Having a tag != 0 doesn't make sense for such a shared resource, so I
> suspect modifying the tag is like a write event: trigger write-fault -> COW.

Yes, modifying the tag is a write event.

> 
> > 
> > With tag storage management enabled, set_pte_at()->mte_sync_tags() will
> > discover that the huge zero page doesn't have tag storage reserved, the
> > table entry will be mapped as invalid to use the page fault-on-access
> > mechanism that I introduce later in the series [1] to reserve tag storage,
> 
> I assume (without looking at the code) that you took proper care of possible
> races.
> 
> Thanks for goind into detail!

No problem.

Alex

> 
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

