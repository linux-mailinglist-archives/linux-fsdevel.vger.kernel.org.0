Return-Path: <linux-fsdevel+bounces-50400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA71ACBE02
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 02:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71FA16FF51
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 00:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403F878F26;
	Tue,  3 Jun 2025 00:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FsQDUsaT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC664372;
	Tue,  3 Jun 2025 00:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748912075; cv=none; b=gcCfKICEnkO4Z0Kpya4rp4/+OdPAbMc6r88uC/nUZnG6ySRHHdv2Ay3aL5X2Gi3rR9cfyieRoS8uBMDYgu8sjrzde2ugGZEovb9v+SE5X+bY7OmeeeRvcMHblO9KJ7mgU5CmdfKA4buou1Egp31dDPFcEX0GVA4IhK4pszKUx+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748912075; c=relaxed/simple;
	bh=7+gygiq5R8sUDs1GPqrVEdunqF5B0n8zpsyKw46Jr7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFqJMLyICRphiHQC5F6RHL0Ow/VVCjMG8nATMdVa7BmSbukC79pRcEDxpnpoabJFPcLy9cFNtOvF4X1UsWL4xjjO/0nqCtUn8RQioxmEtS2KohwW4StPi+sweGEvjvrFi+5xZlNmp589bjNNmqd+T7/+F8XD4ZIj9CxKia9Rq7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FsQDUsaT; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748912073; x=1780448073;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7+gygiq5R8sUDs1GPqrVEdunqF5B0n8zpsyKw46Jr7A=;
  b=FsQDUsaT88c4dI22KkQt9r1j6YPTOoVvEgOhye2zNcgfR7vHJL6wc7vj
   FhAjLNCfcO3n6svlrTGzkigEE3Vl67UIQ2+XhUVYplE6U4l7xXHxoKwDM
   E5qNz8e77uJ77TH6Y8aslgFMtZw07EPqzgTJamBh6gwplasA4/vCfdv9D
   Q0GKEkALIOZeocsKsj550Zr5/UPUpYBl07m/GPiPFl9A9xRU0eGHNoPt+
   bOuUFfHeWXM4E4YHTZuFy3kickzvlNv1oL2JjnUi21tc9M5k+QIXPJQru
   VQCjgziFoJqqP6E3TGf+AUqKyj7YrmS1HlX2RC11Om/F3gmB1Df2m9rrC
   Q==;
X-CSE-ConnectionGUID: avbSuSSMTkeoAftThURGoQ==
X-CSE-MsgGUID: VxlXLfF7QTWafoOWiZOIcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="50631035"
X-IronPort-AV: E=Sophos;i="6.16,204,1744095600"; 
   d="scan'208";a="50631035"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 17:54:32 -0700
X-CSE-ConnectionGUID: /oRaHirXSbWuZ1E+mJ7q3w==
X-CSE-MsgGUID: 0kNnjuy9RZyvuctCxrOqng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,204,1744095600"; 
   d="scan'208";a="175649909"
Received: from unknown (HELO [10.238.0.239]) ([10.238.0.239])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 17:54:10 -0700
Message-ID: <923d57f1-55f1-411f-b659-9fe4fafa734a@linux.intel.com>
Date: Tue, 3 Jun 2025 08:54:07 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
To: Ackerley Tng <ackerleytng@google.com>
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
 tabba@google.com, thomas.lendacky@amd.com, vannapurve@google.com,
 vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com,
 wei.w.wang@intel.com, will@kernel.org, willy@infradead.org,
 xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com,
 yuzenghui@huawei.com, zhiquan1.li@intel.com
References: <cover.1747264138.git.ackerleytng@google.com>
 <d3832fd95a03aad562705872cbda5b3d248ca321.1747264138.git.ackerleytng@google.com>
 <b66c38ba-ca16-44c5-b498-7c8eb533d805@linux.intel.com>
 <diqzsekl6esc.fsf@ackerleytng-ctop.c.googlers.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <diqzsekl6esc.fsf@ackerleytng-ctop.c.googlers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/31/2025 4:10 AM, Ackerley Tng wrote:
> Binbin Wu <binbin.wu@linux.intel.com> writes:
>
>> On 5/15/2025 7:41 AM, Ackerley Tng wrote:
>>
>> [...]
>>> +
>>> +static int kvm_gmem_convert_range(struct file *file, pgoff_t start,
>>> +				  size_t nr_pages, bool shared,
>>> +				  pgoff_t *error_index)
>>> +{
>>> +	struct conversion_work *work, *tmp, *rollback_stop_item;
>>> +	LIST_HEAD(work_list);
>>> +	struct inode *inode;
>>> +	enum shareability m;
>>> +	int ret;
>>> +
>>> +	inode = file_inode(file);
>>> +
>>> +	filemap_invalidate_lock(inode->i_mapping);
>>> +
>>> +	m = shared ? SHAREABILITY_ALL : SHAREABILITY_GUEST;
>>> +	ret = kvm_gmem_convert_compute_work(inode, start, nr_pages, m, &work_list);
>>> +	if (ret || list_empty(&work_list))
>>> +		goto out;
>>> +
>>> +	list_for_each_entry(work, &work_list, list)
>>> +		kvm_gmem_convert_invalidate_begin(inode, work);
>>> +
>>> +	list_for_each_entry(work, &work_list, list) {
>>> +		ret = kvm_gmem_convert_should_proceed(inode, work, shared,
>>> +						      error_index);
>> Since kvm_gmem_invalidate_begin() begins to handle shared memory,
>> kvm_gmem_convert_invalidate_begin() will zap the table.
>> The shared mapping could be zapped in kvm_gmem_convert_invalidate_begin() even
>> when kvm_gmem_convert_should_proceed() returns error.
>> The sequence is a bit confusing to me, at least in this patch so far.
>>
> It is true that zapping of pages from the guest page table will happen
> before we figure out whether conversion is allowed.
>
> For a shared-to-private conversion, we will definitely unmap from the
> host before checking if conversion is allowed, and there's no choice
> there since conversion is allowed if there are no unexpected refcounts,
> and the way to eliminate expected refcounts is to unmap from the host.
>
> Since we're unmapping before checking if conversion is allowed, I
> thought it would be fine to also zap from guest page tables before
> checking if conversion is allowed.
>
> Conversion is not meant to happen very regularly, and even if it is
> unmapped or zapped, the next access will fault in the page anyway, so
> there is a performance but not a functionality impact.
Yes, it's OK for shared mapping.

>
> Hope that helps.

It helped, thanks!

> Is it still odd to zap before checking if conversion
> should proceed?
>
>>> +		if (ret)
>>> +			goto invalidate_end;
>>> +	}
>>> +
>>> +	list_for_each_entry(work, &work_list, list) {
>>> +		rollback_stop_item = work;
>>> +		ret = kvm_gmem_shareability_apply(inode, work, m);
>>> +		if (ret)
>>> +			break;
>>> +	}
>>> +
>>> +	if (ret) {
>>> +		m = shared ? SHAREABILITY_GUEST : SHAREABILITY_ALL;
>>> +		list_for_each_entry(work, &work_list, list) {
>>> +			if (work == rollback_stop_item)
>>> +				break;
>>> +
>>> +			WARN_ON(kvm_gmem_shareability_apply(inode, work, m));
>>> +		}
>>> +	}
>>> +
>>> +invalidate_end:
>>> +	list_for_each_entry(work, &work_list, list)
>>> +		kvm_gmem_convert_invalidate_end(inode, work);
>>> +out:
>>> +	filemap_invalidate_unlock(inode->i_mapping);
>>> +
>>> +	list_for_each_entry_safe(work, tmp, &work_list, list) {
>>> +		list_del(&work->list);
>>> +		kfree(work);
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +
>> [...]
>>> @@ -186,15 +490,26 @@ static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
>>>    	unsigned long index;
>>>    
>>>    	xa_for_each_range(&gmem->bindings, index, slot, start, end - 1) {
>>> +		enum kvm_gfn_range_filter filter;
>>>    		pgoff_t pgoff = slot->gmem.pgoff;
>>>    
>>> +		filter = KVM_FILTER_PRIVATE;
>>> +		if (kvm_gmem_memslot_supports_shared(slot)) {
>>> +			/*
>>> +			 * Unmapping would also cause invalidation, but cannot
>>> +			 * rely on mmu_notifiers to do invalidation via
>>> +			 * unmapping, since memory may not be mapped to
>>> +			 * userspace.
>>> +			 */
>>> +			filter |= KVM_FILTER_SHARED;
>>> +		}
>>> +
>>>    		struct kvm_gfn_range gfn_range = {
>>>    			.start = slot->base_gfn + max(pgoff, start) - pgoff,
>>>    			.end = slot->base_gfn + min(pgoff + slot->npages, end) - pgoff,
>>>    			.slot = slot,
>>>    			.may_block = true,
>>> -			/* guest memfd is relevant to only private mappings. */
>>> -			.attr_filter = KVM_FILTER_PRIVATE,
>>> +			.attr_filter = filter,
>>>    		};
>>>    
>>>    		if (!found_memslot) {
>>> @@ -484,11 +799,49 @@ EXPORT_SYMBOL_GPL(kvm_gmem_memslot_supports_shared);
>>>    #define kvm_gmem_mmap NULL
>>>    #endif /* CONFIG_KVM_GMEM_SHARED_MEM */
>>>    
>> [...]


