Return-Path: <linux-fsdevel+bounces-29723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D2D97CD4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 19:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACBA0B22806
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 17:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8A31A2C0E;
	Thu, 19 Sep 2024 17:49:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F6A1A00D6;
	Thu, 19 Sep 2024 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726768163; cv=none; b=AoHTwasalOxjfqy99Hd338/1hd0ttlM/tl98iGnp0BWuZvgYv2gN4ODDOfG529bFtF8rvekSw/8J8ZmGktnopj8Oa+lViNa7jKlnsaey/9DilaPA0tvXJePJX7WmMgdZ5oMQM17FK8odvoHx0xvRiesTRptNWseC/UgTyjly4HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726768163; c=relaxed/simple;
	bh=Xzcxh0emf1BR3pfAuhfeoZgf9JYWV+PUBPOkNS+SmKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YcGpU96KRSopHhXBuYBX52S+H0FKGeBolPp1tEA1GAskQPsXp1va7xPnVunAAGYQqynmJinV6SUuw9qBUCSx0SvKv3lYZIwzPLAXDnUeQZffB6Hf1VChHkLUkQMENpDoNOqNF6wAJ5+/wnxhoZIf5uBSZP8zKKtxgKim/O+5wPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10F3A1007;
	Thu, 19 Sep 2024 10:49:50 -0700 (PDT)
Received: from [10.57.82.79] (unknown [10.57.82.79])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 973013F64C;
	Thu, 19 Sep 2024 10:49:12 -0700 (PDT)
Message-ID: <5bd51798-cb47-4a7b-be40-554b5a821fe7@arm.com>
Date: Thu, 19 Sep 2024 19:49:09 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 7/7] mm: Use pgdp_get() for accessing PGD entries
Content-Language: en-GB
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 kernel test robot <lkp@intel.com>, linux-mm@kvack.org, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-fsdevel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dimitri Sivanich
 <dimitri.sivanich@hpe.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Muchun Song <muchun.song@linux.dev>, Andrey Ryabinin
 <ryabinin.a.a@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>
References: <20240917073117.1531207-8-anshuman.khandual@arm.com>
 <202409190310.ViHBRe12-lkp@intel.com>
 <8f43251a-5418-4c54-a9b0-29a6e9edd879@arm.com>
 <ZuvqpvJ6ht4LCuB+@shell.armlinux.org.uk>
 <82fa108e-5b15-435a-8b61-6253766c7d88@arm.com>
 <ZuxZ/QeSdqTHtfmw@shell.armlinux.org.uk>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZuxZ/QeSdqTHtfmw@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/09/2024 18:06, Russell King (Oracle) wrote:
> On Thu, Sep 19, 2024 at 05:48:58PM +0200, Ryan Roberts wrote:
>>> 32-bit arm uses, in some circumstances, an array because each level 1
>>> page table entry is actually two descriptors. It needs to be this way
>>> because each level 2 table pointed to by each level 1 entry has 256
>>> entries, meaning it only occupies 1024 bytes in a 4096 byte page.
>>>
>>> In order to cut down on the wastage, treat the level 1 page table as
>>> groups of two entries, which point to two consecutive 1024 byte tables
>>> in the level 2 page.
>>>
>>> The level 2 entry isn't suitable for the kernel's use cases (there are
>>> no bits to represent accessed/dirty and other important stuff that the
>>> Linux MM wants) so we maintain the hardware page tables and a separate
>>> set that Linux uses in the same page. Again, the software tables are
>>> consecutive, so from Linux's perspective, the level 2 page tables
>>> have 512 entries in them and occupy one full page.
>>>
>>> This is documented in arch/arm/include/asm/pgtable-2level.h
>>>
>>> However, what this means is that from the software perspective, the
>>> level 1 page table descriptors are an array of two entries, both of
>>> which need to be setup when creating a level 2 page table, but only
>>> the first one should ever be dereferenced when walking the tables,
>>> otherwise the code that walks the second level of page table entries
>>> will walk off the end of the software table into the actual hardware
>>> descriptors.
>>>
>>> I've no idea what the idea is behind introducing pgd_get() and what
>>> it's semantics are, so I can't comment further.
>>
>> The helper is intended to read the value of the entry pointed to by the passed
>> in pointer. And it shoiuld be read in a "single copy atomic" manner, meaning no
>> tearing. Further, the PTL is expected to be held when calling the getter. If the
>> HW can write to the entry such that its racing with the lock holder (i.e. HW
>> update of access/dirty) then READ_ONCE() should be suitable for most
>> architectures. If there is no possibility of racing (because HW doesn't write to
>> the entry), then a simple dereference would be sufficient, I think (which is
>> what the core code was already doing in most cases).
> 
> The core code should be making no access to the PGD entries on 32-bit
> ARM since the PGD level does not exist. Writes are done at PMD level
> in arch code. Reads are done by core code at PMD level.
> 
> It feels to me like pgd_get() just doesn't fit the model to which 32-bit
> ARM was designed to use decades ago, so I want full details about what
> pgd_get() is going to be used for and how it is going to be used,
> because I feel completely in the dark over this new development. I fear
> that someone hasn't understood the Linux page table model if they're
> wanting to access stuff at levels that effectively "aren't implemented"
> in the architecture specific kernel model of the page tables.

This change isn't as big and scary as I think you fear. The core-mm today
dereferences pgd pointers (and p4d, pud, pmd pointers) directly in its code. See
follow_pfnmap_start(), gup_fast_pgd_leaf(), and many other sites. These changes
aim to abstract those dereferences into an inline function that the architecture
can override and implement if it so wishes.

The core-mm implements default versions of these helper functions which do
READ_ONCE(), but does not currently use them consistently.

From Anshuman's comments earlier in this thread, it looked to me like the arm
pgd_t type is too big to read with READ_ONCE() - it can't be atomically read on
that arch. So my proposal was to implement the override for arm to do exactly
what the core-mm used to do, which is a pointer dereference. So that would
result in exact same behaviour for the arm arch.

> 
> Essentially, on 32-bit 2-level ARM, the PGD is merely indexed by the
> virtual address. As far as the kernel is concerned, each entry is
> 64-bit, and the generic kernel code has no business accessing that
> through the pgd pointer.
> 
> The pgd pointer is passed through the PUD and PMD levels, where it is
> typecast down through the kernel layers to a pmd_t pointer, where it
> becomes a 32-bit quantity. This results in only the _first_ level 1
> pointer being dereferenced by kernel code to a 32-bit pmd_t quantity.
> pmd_page_vaddr() converts this pmd_t quantity to a pte pointer (which
> points at the software level 2 page tables, not the hardware page
> tables.)

As an aside, my understanding of Linux's pgtable model differs from what you
describe. As I understand it, Linux's logical page table model has 5 levels
(pgd, p4d, pud, pmd, pte). If an arch doesn't support all 5 levels, then the
middle levels can be folded away (p4d first, then pud, then pmd). But the
core-mm still logically walks all 5 levels. So if the HW supports 2 levels,
those levels are (pgd, pte). But you are suggesting that arm exposes pmd and
pte, which is not what Linux expects? (Perhaps you call it the pmd in the arch,
but that is being folded and accessed through the pgd helpers in core code, I
believe?

> 
> So, as I'm now being told that the kernel wants to dereference the
> pgd level despite the model I describe above, alarm bells are ringing.
> I want full information please.
> 

This is not new; the kernel already dereferences the pgd pointers.

Thanks,
Ryan


