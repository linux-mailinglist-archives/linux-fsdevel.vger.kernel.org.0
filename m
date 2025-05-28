Return-Path: <linux-fsdevel+bounces-49952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76CCAC63B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 10:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9984A17052B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 08:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCB7246777;
	Wed, 28 May 2025 08:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZK+yr0t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879D919005E;
	Wed, 28 May 2025 08:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419743; cv=none; b=a/BumcTd78Z2UmwCFqDt7ZT4CQUpL2Guemz6g3PoNaAv3lX98VDahYwAvb5GRtHE5P/wZW5YwMgaCr5OZxlBcpOdNQvFvqJMtBiMZHunXKCzhJ3N902POABrT0fZ8GkAV/FgvO3qnMhuyk2Whf4vGk5JI7GvrAmBs77IcN/smDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419743; c=relaxed/simple;
	bh=/3pRLiNTZ5mPQkB1yIvRzuKdK3DiRImq+aSu3O+yq7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONP1WgmDIJxYAp40k2DOoJzPuM7iljT9QtwJEIsn75vn0w3QTfLBkhUBq85oYs6kS68PFn81jiW5KGVGDB6+aoFICFd1Yihx1vHyZLpQaNTHuPW2joA6HQEucQmVtZnXOik0kya//0I3KMU9AUr5ddqJV6AEYFOgya17JEOohtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZK+yr0t; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748419742; x=1779955742;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/3pRLiNTZ5mPQkB1yIvRzuKdK3DiRImq+aSu3O+yq7g=;
  b=fZK+yr0tu8k0JEWIzNUEKwiq9ELlY8eutMpLjIRTa4X7m6VEviXWyWvi
   7m4Xc8wWX244VkhPVwQ+t+meysnUh/8EERGPDEiVcCEBFF2lUqYc0MXLX
   abv9wZthQXEtJjMJT21y9Kel4a76EOarfUXPVWwqmzJKKwgpSnW8AiLG9
   cPIV8G/mwmozbpbFHhN5HFWjH9rtvdkm7hgp9EqwJ5diqgTCLefRlMEDc
   /VDyqeUDGm6rNSllZtZIA7LHYgK+bOjY+Y75M2F+tFgi31pMoCTp3w3f7
   Jn08m6Rr9DUpjDfXzeGuy1yYTEkDJ/6JIxipn6Iea6cEH2deM8MPiBLft
   g==;
X-CSE-ConnectionGUID: ZMdipwDFRDmBArkM6EcIAg==
X-CSE-MsgGUID: EQvzJ0MpRBypQ/VuvxxXxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="61064888"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="61064888"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 01:09:00 -0700
X-CSE-ConnectionGUID: Lr8duTnoQ/2ffFFG/pO8DA==
X-CSE-MsgGUID: tgUyM0yhThyjAoammQSSxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="144141076"
Received: from unknown (HELO [10.238.3.95]) ([10.238.3.95])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 01:08:37 -0700
Message-ID: <e38f0573-520a-4fe8-91fc-797086ab5866@linux.intel.com>
Date: Wed, 28 May 2025 16:08:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 06/51] KVM: Query guest_memfd for private/shared
 status
To: Yan Zhao <yan.y.zhao@intel.com>, Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com,
 ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com,
 anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu,
 bfoster@redhat.com, brauner@kernel.org, catalin.marinas@arm.com,
 chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com,
 david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk,
 erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com,
 haibo1.xu@intel.com, hch@infradead.org, hughd@google.com,
 ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz,
 james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com,
 jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com,
 jun.miao@intel.com, kai.huang@intel.com, keirf@google.com,
 kent.overstreet@linux.dev, kirill.shutemov@intel.com,
 liam.merwick@oracle.com, maciej.wieczor-retman@intel.com,
 mail@maciej.szmigiero.name, maz@kernel.org, mic@digikod.net,
 michael.roth@amd.com, mpe@ellerman.id.au, muchun.song@linux.dev,
 nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev,
 palmer@dabbelt.com, pankaj.gupta@amd.com, paul.walmsley@sifive.com,
 pbonzini@redhat.com, pdurrant@amazon.co.uk, peterx@redhat.com,
 pgonda@google.com, pvorel@suse.cz, qperret@google.com,
 quic_cvanscha@quicinc.com, quic_eberman@quicinc.com,
 quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com,
 quic_pheragu@quicinc.com, quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com,
 richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com,
 roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, shuah@kernel.org,
 steven.price@arm.com, steven.sistare@oracle.com, suzuki.poulose@arm.com,
 tabba@google.com, thomas.lendacky@amd.com, usama.arif@bytedance.com,
 vannapurve@google.com, vbabka@suse.cz, viro@zeniv.linux.org.uk,
 vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org,
 willy@infradead.org, xiaoyao.li@intel.com, yilun.xu@intel.com,
 yuzenghui@huawei.com, zhiquan1.li@intel.com
References: <cover.1747264138.git.ackerleytng@google.com>
 <237590b163506821120734a0c8aad95d9c7ef299.1747264138.git.ackerleytng@google.com>
 <aDU3pN/0FVbowmNH@yzhao56-desk.sh.intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <aDU3pN/0FVbowmNH@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/27/2025 11:55 AM, Yan Zhao wrote:
> On Wed, May 14, 2025 at 04:41:45PM -0700, Ackerley Tng wrote:
>> Query guest_memfd for private/shared status if those guest_memfds
>> track private/shared status.
>>
>> With this patch, Coco VMs can use guest_memfd for both shared and
>> private memory. If Coco VMs choose to use guest_memfd for both
>> shared and private memory, by creating guest_memfd with the
>> GUEST_MEMFD_FLAG_SUPPORT_SHARED flag, guest_memfd will be used to
>> provide the private/shared status of the memory, instead of
>> kvm->mem_attr_array.
>>
>> Change-Id: I8f23d7995c12242aa4e09ccf5ec19360e9c9ed83
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> ---
>>   include/linux/kvm_host.h | 19 ++++++++++++-------
>>   virt/kvm/guest_memfd.c   | 22 ++++++++++++++++++++++
>>   2 files changed, 34 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> index b317392453a5..91279e05e010 100644
>> --- a/include/linux/kvm_host.h
>> +++ b/include/linux/kvm_host.h
>> @@ -2508,12 +2508,22 @@ static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
>>   }
>>   
>>   #ifdef CONFIG_KVM_GMEM_SHARED_MEM
>> +
>>   bool kvm_gmem_memslot_supports_shared(const struct kvm_memory_slot *slot);
>> +bool kvm_gmem_is_private(struct kvm_memory_slot *slot, gfn_t gfn);
>> +
>>   #else
>> +
>>   static inline bool kvm_gmem_memslot_supports_shared(const struct kvm_memory_slot *slot)
>>   {
>>   	return false;
>>   }
>> +
>> +static inline bool kvm_gmem_is_private(struct kvm_memory_slot *slot, gfn_t gfn)
>> +{
>> +	return false;
>> +}
>> +
>>   #endif /* CONFIG_KVM_GMEM_SHARED_MEM */
>>   
>>   #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
>> @@ -2544,13 +2554,8 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>>   		return false;
>>   
>>   	slot = gfn_to_memslot(kvm, gfn);
>> -	if (kvm_slot_has_gmem(slot) && kvm_gmem_memslot_supports_shared(slot)) {
>> -		/*
>> -		 * For now, memslots only support in-place shared memory if the
>> -		 * host is allowed to mmap memory (i.e., non-Coco VMs).
>> -		 */
>> -		return false;
>> -	}
>> +	if (kvm_slot_has_gmem(slot) && kvm_gmem_memslot_supports_shared(slot))
>> +		return kvm_gmem_is_private(slot, gfn);
> When userspace gets an exit reason KVM_EXIT_MEMORY_FAULT, looks it needs to
> update both KVM memory attribute and gmem shareability, via two separate ioctls?
IIUC, when userspace sets flag GUEST_MEMFD_FLAG_SUPPORT_SHARED to create the
guest_memfd, the check for memory attribute will go through the guest_memfd way,
the information in kvm->mem_attr_array will not be used.

So if userspace sets GUEST_MEMFD_FLAG_SUPPORT_SHARED, it uses
KVM_GMEM_CONVERT_SHARED/PRIVATE to update gmem shareability.
If userspace doesn't set GUEST_MEMFD_FLAG_SUPPORT_SHARED, it still uses
KVM_SET_MEMORY_ATTRIBUTES to update KVM memory attribute tracking.


>
>
>>   	return kvm_get_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
>>   }



