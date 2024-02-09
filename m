Return-Path: <linux-fsdevel+bounces-10973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B097684F812
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 16:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BACF289584
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 15:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76DE6E2A2;
	Fri,  9 Feb 2024 15:02:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B197374CC;
	Fri,  9 Feb 2024 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707490942; cv=none; b=OYBGm56o2ytI/N9ILP38XFt1xNJmGPUMgWo3EXbzbYvPM2ieUxXYSoWafImO2osFcVQpaeAHkTnwPX0sPU5aO+6zDcCXSXFokUgF2f2QlI7v84KAisNJZ4AL62N0P1PwgBr32qWsvN3P1WD67lZWr+UlQy49rPOLTyYhaoLsnAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707490942; c=relaxed/simple;
	bh=6c6FsiiVr0PuNSdmXweLRVsrzA57UqZQa1FvKG4eRjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GUgkvcUN2+JuJEN/u+5f1S7ZcPLQmP3pf5Pxe2JP4ZO0iIEwfalQ3vU3JNFKmjsfOx73jxWJujFl0qKll+cFir4cWrQHXT4raWjlznXF9Vq3kICiSV3Nw8UcmCrberdrwAcEY4ME13C3lKzjhBMY06neAVIiRBEwFYUQBg/uISg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D85B8DA7;
	Fri,  9 Feb 2024 07:03:01 -0800 (PST)
Received: from [10.1.37.16] (e122027.cambridge.arm.com [10.1.37.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8EC23F762;
	Fri,  9 Feb 2024 07:02:16 -0800 (PST)
Message-ID: <84d62953-527d-4837-acf8-315391f4b225@arm.com>
Date: Fri, 9 Feb 2024 15:02:14 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC gmem v1 4/8] KVM: x86: Add gmem hook for invalidating
 memory
Content-Language: en-GB
To: Sean Christopherson <seanjc@google.com>
Cc: Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 "tabba@google.com" <tabba@google.com>, linux-coco@lists.linux.dev,
 linux-mm@kvack.org, linux-crypto@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 pbonzini@redhat.com, isaku.yamahata@intel.com, ackerleytng@google.com,
 vbabka@suse.cz, ashish.kalra@amd.com, nikunj.dadhania@amd.com,
 jroedel@suse.de, pankaj.gupta@amd.com
References: <20231016115028.996656-1-michael.roth@amd.com>
 <20231016115028.996656-5-michael.roth@amd.com>
 <e7125fcb-52b1-4942-9ae7-c85049e92e5c@arm.com> <ZcY2VRsRd03UQdF7@google.com>
From: Steven Price <steven.price@arm.com>
In-Reply-To: <ZcY2VRsRd03UQdF7@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sean,

Thanks for the reply.

On 09/02/2024 14:28, Sean Christopherson wrote:
> On Fri, Feb 09, 2024, Steven Price wrote:
>> On 16/10/2023 12:50, Michael Roth wrote:
>>> In some cases, like with SEV-SNP, guest memory needs to be updated in a
>>> platform-specific manner before it can be safely freed back to the host.
>>> Wire up arch-defined hooks to the .free_folio kvm_gmem_aops callback to
>>> allow for special handling of this sort when freeing memory in response
>>> to FALLOC_FL_PUNCH_HOLE operations and when releasing the inode, and go
>>> ahead and define an arch-specific hook for x86 since it will be needed
>>> for handling memory used for SEV-SNP guests.
>>
>> Hi all,
>>
>> Arm CCA has a similar need to prepare/unprepare memory (granule
>> delegate/undelegate using our terminology) before it is used for
>> protected memory.
>>
>> However I see a problem with the current gmem implementation that the
>> "invalidations" are not precise enough for our RMI API. When punching a
>> hole in the memfd the code currently hits the same path (ending in
>> kvm_unmap_gfn_range()) as if a VMA is modified in the same range (for
>> the shared version).
>>
>> The Arm CCA architecture doesn't allow the protected memory to be removed and
>> refaulted without the permission of the guest (the memory contents would be
>> wiped in this case).
> 
> TDX behaves almost exactly like CCA.  Well, that's not technically true, strictly
> speaking, as there are TDX APIs that do allow for *temporarily* marking mappings
> !PRESENT, but those aren't in play for invalidation events like this.

Ok, great I was under the impression they were similar.

> SNP does allow zapping page table mappings, but fully removing a page, as PUNCH_HOLE
> would do, is destructive, so SNP also behaves the same way for all intents and
> purposes.

Zapping page table mappings is what the invalidate calls imply. This is
something CCA can't do. Obviously fully removing the page would be
destructive.

>> One option that I've considered is to implement a seperate CCA ioctl to
>> notify KVM whether the memory should be mapped protected.
> 
> That's what KVM_SET_MEMORY_ATTRIBUTES+KVM_MEMORY_ATTRIBUTE_PRIVATE is for, no?

Sorry, I really didn't explain that well. Yes effectively this is the
attribute flag, but there's corner cases for destruction of the VM. My
thought was that if the VMM wanted to tear down part of the protected
range (without making it shared) then a separate ioctl would be needed
to notify KVM of the unmap.

>> The invalidations would then be ignored on ranges that are currently
>> protected for this guest.
> 
> That's backwards.  Invalidations on a guest_memfd should affect only *protected*
> mappings.  And for that, the plan/proposal is to plumb only_{shared,private} flags
> into "struct kvm_gfn_range"[1] so that guest_memfd invalidations don't zap shared
> mappings, and mmu_notifier invalidation don't zap private mappings.  Sample usage
> in the TDX context[2] (disclaimer, I'm pretty sure I didn't write most of that
> patch despite, I only provided a rough sketch).

Aha, this sounds much like my option 3 below - a way to tell if the
invalidate comes from guest_memfd as opposed to VMA changes.

> [1] https://lore.kernel.org/all/20231027182217.3615211-13-seanjc@google.com
> [2] https://lore.kernel.org/all/0b308fb6dd52bafe7153086c7f54bfad03da74b1.1705965635.git.isaku.yamahata@intel.com
> 
>> This 'solves' the problem nicely except for the case where the VMM
>> deliberately punches holes in memory which the guest is using.
> 
> I don't see what problem there is to solve in this case.  PUNCH_HOLE is destructive,
> so don't do that.

A well behaving VMM wouldn't PUNCH_HOLE when the guest is using it, but
my concern here is a VMM which is trying to break the host. In this case
either the PUNCH_HOLE needs to fail, or we actually need to recover the
memory from the guest (effectively killing the guest in the process).

>> The issue in this case is that there's no way of failing the punch hole
>> operation - we can detect that the memory is in use and shouldn't be
>> freed, but this callback doesn't give the opportunity to actually block
>> the freeing of the memory.
> 
> Why is this KVM's problem?  E.g. the same exact thing happens without guest_memfd
> if userspace munmap()s memory the guest is using.

Indeed. The difference here is that for a normal non-realm guest the
pages can be removed from the page-table and refaulted on a later
access. Indeed there's nothing stopping the VMM from using freeing the
pages and reallocating them later.

For a realm guest if the memory is pulled from the guest then the guest
is effectively dead (at least until migration is implemented but even
then there's going to be a specific controlled mechanism).

>> Sadly there's no easy way to map from a physical page in a gmem back to
>> which VM (and where in the VM) the page is mapped. So actually ripping
>> the page out of the appropriate VM isn't really possible in this case.
> 
> I don't follow.  guest_memfd has a 1:1 binding with a VM *and* a gfn, how can you
> not know what exactly needs to be invalidated?

At the point that gmem calls kvm_mmu_unmap_gfn_range() the fact that the
range is a gmem is lost.

>> How is this situation handled on x86? Is it possible to invalidate and
>> then refault a protected page without affecting the memory contents? My
>> guess is yes and that is a CCA specific problem - is my understanding
>> correct?
>>
>> My current thoughts for CCA are one of three options:
>>
>> 1. Represent shared and protected memory as two separate memslots. This
>> matches the underlying architecture more closely (the top address bit is
>> repurposed as a 'shared' flag), but I don't like it because it's a
>> deviation from other CoCo architectures (notably pKVM).
>>
>> 2. Allow punch-hole to fail on CCA if the memory is mapped into the
>> guest's protected space. Again, this is CCA being different and also
>> creates nasty corner cases where the gmem descriptor could have to
>> outlive the VMM - so looks like a potential source of memory leaks.
>>
>> 3. 'Fix' the invalidation to provide more precise semantics. I haven't
>> yet prototyped it but it might be possible to simply provide a flag from
>> kvm_gmem_invalidate_begin specifying that the invalidation is for the
>> protected memory. KVM would then only unmap the protected memory when
>> this flag is set (avoiding issues with VMA updates causing spurious unmaps).
>>
>> Fairly obviously (3) is my preferred option, but it relies on the
>> guarantees that the "invalidation" is actually a precise set of
>> addresses where the memory is actually being freed.
> 
> #3 is what we are planning for x86, and except for the only_{shared,private} flags,
> the requisite functionality should already be in Linus' tree, though it does need
> to be wired up for ARM.

Thanks, looks like the only_{shared,private} flags should do it. My only
worry about that solution was that it implicitly changes the
"invalidation" when only_private==1 to a precise list of pages that are
to be unmapped. Whereas for a normal guest it's only a performance issue
if a larger region is invalidated, for a CoCo guest it would be fatal to
the guest.

I'll cherry-pick the "KVM: Add new members to struct kvm_gfn_range to
operate on" patch from the TDX tree as I think this should do the trick.
I have hacked up something similar and it looks like it should work.

Thanks,

Steve


