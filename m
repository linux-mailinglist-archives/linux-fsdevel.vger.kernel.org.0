Return-Path: <linux-fsdevel+bounces-14315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEBB87AFAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914FD1C26026
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CB97995B;
	Wed, 13 Mar 2024 17:11:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D0E612FC;
	Wed, 13 Mar 2024 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349898; cv=none; b=GjnuHwPOr7MEl7t35TTIVWt5x0DHjznT1VPmNfDCVclpTBdiSR/NryZNm8AB0gkc9Zbk2F8TNotFXHNICJ9iyEya2qEHHtW8gi2PG+XawSMShskAEvxi9iAk5J8MrLiYgqUwbSyI4QxzYAXjkSz1X1aBjs4ThLhFEFoMLJjxNB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349898; c=relaxed/simple;
	bh=o3yUCeYnmGTYvzE+DYAY+ANpaPKcBEzwnq4w44cGrVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LqwTZydkwXDx+cKMD+QOopTzqTeIOXxs2TDbGTJ8UkZwZQrctTfJbFeO7gr1Wk1y8jFvRq/HPHGLZ39L1PXJha3GKXPalTo1GKtHyTbAaJJmWnS3alfmauyX+PVPnGKn8iJ6rtmrImfG5oNmPFrFIUbcfJLudAWtqsWcjCiAPyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C30631007;
	Wed, 13 Mar 2024 10:12:11 -0700 (PDT)
Received: from [10.57.15.67] (unknown [10.57.15.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA6BE3F73F;
	Wed, 13 Mar 2024 10:11:31 -0700 (PDT)
Message-ID: <c21e247f-3140-4812-9516-f8b9d0ceea2d@arm.com>
Date: Wed, 13 Mar 2024 17:11:29 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC gmem v1 4/8] KVM: x86: Add gmem hook for invalidating
 memory
To: Sean Christopherson <seanjc@google.com>,
 Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
 "tabba@google.com" <tabba@google.com>, linux-coco@lists.linux.dev,
 linux-mm@kvack.org, linux-crypto@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 pbonzini@redhat.com, isaku.yamahata@intel.com, ackerleytng@google.com,
 vbabka@suse.cz, ashish.kalra@amd.com, nikunj.dadhania@amd.com,
 jroedel@suse.de, pankaj.gupta@amd.com
References: <20231016115028.996656-1-michael.roth@amd.com>
 <20231016115028.996656-5-michael.roth@amd.com>
 <e7125fcb-52b1-4942-9ae7-c85049e92e5c@arm.com> <ZcY2VRsRd03UQdF7@google.com>
 <84d62953-527d-4837-acf8-315391f4b225@arm.com> <ZcZBCdTA2kBoSeL8@google.com>
 <20240311172431.zqymfqd4xlpd3pft@amd.com> <ZfC6gnqVhZQJnB_3@google.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <ZfC6gnqVhZQJnB_3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/03/2024 20:26, Sean Christopherson wrote:
> On Mon, Mar 11, 2024, Michael Roth wrote:
>> On Fri, Feb 09, 2024 at 07:13:13AM -0800, Sean Christopherson wrote:
>>> On Fri, Feb 09, 2024, Steven Price wrote:
>>>>>> One option that I've considered is to implement a seperate CCA ioctl to
>>>>>> notify KVM whether the memory should be mapped protected.
>>>>>
>>>>> That's what KVM_SET_MEMORY_ATTRIBUTES+KVM_MEMORY_ATTRIBUTE_PRIVATE is for, no?
>>>>
>>>> Sorry, I really didn't explain that well. Yes effectively this is the
>>>> attribute flag, but there's corner cases for destruction of the VM. My
>>>> thought was that if the VMM wanted to tear down part of the protected
>>>> range (without making it shared) then a separate ioctl would be needed
>>>> to notify KVM of the unmap.
>>>
>>> No new uAPI should be needed, because the only scenario time a benign VMM should
>>> do this is if the guest also knows the memory is being removed, in which case
>>> PUNCH_HOLE will suffice.
>>>
>>>>>> This 'solves' the problem nicely except for the case where the VMM
>>>>>> deliberately punches holes in memory which the guest is using.
>>>>>
>>>>> I don't see what problem there is to solve in this case.  PUNCH_HOLE is destructive,
>>>>> so don't do that.
>>>>
>>>> A well behaving VMM wouldn't PUNCH_HOLE when the guest is using it, but
>>>> my concern here is a VMM which is trying to break the host. In this case
>>>> either the PUNCH_HOLE needs to fail, or we actually need to recover the
>>>> memory from the guest (effectively killing the guest in the process).
>>>
>>> The latter.  IIRC, we talked about this exact case somewhere in the hour-long
>>> rambling discussion on guest_memfd at PUCK[1].  And we've definitely discussed
>>> this multiple times on-list, though I don't know that there is a single thread
>>> that captures the entire plan.
>>>
>>> The TL;DR is that gmem will invoke an arch hook for every "struct kvm_gmem"
>>> instance that's attached to a given guest_memfd inode when a page is being fully
>>> removed, i.e. when a page is being freed back to the normal memory pool.  Something
>>> like this proposed SNP patch[2].
>>>
>>> Mike, do have WIP patches you can share?
>>
>> Sorry, I missed this query earlier. I'm a bit confused though, I thought
>> the kvm_arch_gmem_invalidate() hook provided in this patch was what we
>> ended up agreeing on during the PUCK call in question.
> 
> Heh, I trust your memory of things far more than I trust mine.  I'm just proving
> Cunningham's Law.  :-)
> 
>> There was an open question about what to do if a use-case came along
>> where we needed to pass additional parameters to
>> kvm_arch_gmem_invalidate() other than just the start/end PFN range for
>> the pages being freed, but we'd determined that SNP and TDX did not
>> currently need this, so I didn't have any changes planned in this
>> regard.
>>
>> If we now have such a need, what we had proposed was to modify
>> __filemap_remove_folio()/page_cache_delete() to defer setting
>> folio->mapping to NULL so that we could still access it in
>> kvm_gmem_free_folio() so that we can still access mapping->i_private_list
>> to get the list of gmem/KVM instances and pass them on via
>> kvm_arch_gmem_invalidate().
> 
> Yeah, this is what I was remembering.  I obviously forgot that we didn't have a
> need to iterate over all bindings at this time.
> 
>> So that's doable, but it's not clear from this discussion that that's
>> needed.
> 
> Same here.  And even if it is needed, it's not your problem to solve.  The above
> blurb about needing to preserve folio->mapping being free_folio() is sufficient
> to get the ARM code moving in the right direction.
> 
> Thanks!
> 
>> If the idea to block/kill the guest if VMM tries to hole-punch,
>> and ARM CCA already has plans to wire up the shared/private flags in
>> kvm_unmap_gfn_range(), wouldn't that have all the information needed to
>> kill that guest? At that point, kvm_gmem_free_folio() can handle
>> additional per-page cleanup (with additional gmem/KVM info plumbed in
>> if necessary).

Yes, the missing piece of the puzzle was provided by "KVM: Prepare for
handling only shared mappings in mmu_notifier events"[1] - namely the
"only_shared" flag. We don't need to actually block/kill the guest until
it attempts access to the memory which has been removed from the guest -
at that point the guest cannot continue because the security properties
have been violated (the protected memory contents have been lost) so
attempts to continue the guest will fail.

You can ignore most of my other ramblings - as long as everyone is happy
with that flag then Arm CCA should be fine. I was just looking at other
options.

Thanks,

Steve

[1]
https://lore.kernel.org/lkml/20231027182217.3615211-13-seanjc@google.com/

