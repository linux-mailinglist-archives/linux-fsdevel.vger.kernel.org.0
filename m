Return-Path: <linux-fsdevel+bounces-49942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D80C3AC5FEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 05:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BEFB3A9E5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 03:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2010B1E25ED;
	Wed, 28 May 2025 03:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTt291Fe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925001FB3;
	Wed, 28 May 2025 03:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748402199; cv=none; b=dAykcCJpO95fW6P5rtRJ9yjga0dk7hy9kkCZ3TVPGXzegWS8Ci4bGNgqWKiONGQawXu9D/bupXuThw7qtAxfAuA++SuONIlpLyIsC2h1qfD9WAExrk+jeSXFAVqzQ2vDH/mYBx1Sq0PiYL0hzjywW5iWjA48AmQadNdGIBIIuRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748402199; c=relaxed/simple;
	bh=ol3hrreomk92oy/dMrcK8dYkcWIBmCK1VoFKv2uei8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ph8d0TDQRMQDLVSHOVu5WY5QOpLVJREhhBrcd+EVY4+4R/wgMJhTguy4gCAASukDHYB8odkvfX+jpAQ6pAkFJlL/EMmQAjO8J876f3F9zEvbBtpeuHxFL2cAk/iczVNRxiInQI3cmLoyrjMF+bDMgbAYLe/BGOsCwkaUUpBRjfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTt291Fe; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748402198; x=1779938198;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ol3hrreomk92oy/dMrcK8dYkcWIBmCK1VoFKv2uei8c=;
  b=HTt291Fe+YtU65/udhiMWmevCn2SeppDnx/gfX1r4c2l0T/iKJdth7tw
   LMgwWoqkWtdwBy2ICnxPkdN5kKgB1bzoYTAcSmVeLaTGcAzZgrDPzh9FE
   bBmhqreblzNKBq55S2Berw7IedPJfQumUFPlbSBenrmgvEPnEKeX2bnoa
   +pBSldhxdSIU50k4MjueCGHaHJpsLB706rnZdtcVPb/hLKYZgbL8k6oTc
   bCbxf+NZyoQcs/sHHnopFWkjMWRPWI5syWJg1VOBVs+G/eyH3tebSstoT
   4qPvG9RDRPuoJ4Uu6U73i02BbuyqdfOAjwCzoxgeBv/6KCCl5Wr2MMBVx
   Q==;
X-CSE-ConnectionGUID: cy9YoWHmRVqK8ypMiw/ceA==
X-CSE-MsgGUID: W/2exfmVSw2NsCHMJg9D/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="75803180"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="75803180"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 20:16:36 -0700
X-CSE-ConnectionGUID: qT1plBtYR2uKqedJ4Wk7ng==
X-CSE-MsgGUID: o4JH+FVTTm+OuGV88pruRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="146961192"
Received: from unknown (HELO [10.238.3.95]) ([10.238.3.95])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 20:16:18 -0700
Message-ID: <b66c38ba-ca16-44c5-b498-7c8eb533d805@linux.intel.com>
Date: Wed, 28 May 2025 11:16:15 +0800
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
 tabba@google.com, thomas.lendacky@amd.com, usama.arif@bytedance.com,
 vannapurve@google.com, vbabka@suse.cz, viro@zeniv.linux.org.uk,
 vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org,
 willy@infradead.org, xiaoyao.li@intel.com, yan.y.zhao@intel.com,
 yilun.xu@intel.com, yuzenghui@huawei.com, zhiquan1.li@intel.com
References: <cover.1747264138.git.ackerleytng@google.com>
 <d3832fd95a03aad562705872cbda5b3d248ca321.1747264138.git.ackerleytng@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <d3832fd95a03aad562705872cbda5b3d248ca321.1747264138.git.ackerleytng@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/15/2025 7:41 AM, Ackerley Tng wrote:

[...]
> +
> +static int kvm_gmem_convert_range(struct file *file, pgoff_t start,
> +				  size_t nr_pages, bool shared,
> +				  pgoff_t *error_index)
> +{
> +	struct conversion_work *work, *tmp, *rollback_stop_item;
> +	LIST_HEAD(work_list);
> +	struct inode *inode;
> +	enum shareability m;
> +	int ret;
> +
> +	inode = file_inode(file);
> +
> +	filemap_invalidate_lock(inode->i_mapping);
> +
> +	m = shared ? SHAREABILITY_ALL : SHAREABILITY_GUEST;
> +	ret = kvm_gmem_convert_compute_work(inode, start, nr_pages, m, &work_list);
> +	if (ret || list_empty(&work_list))
> +		goto out;
> +
> +	list_for_each_entry(work, &work_list, list)
> +		kvm_gmem_convert_invalidate_begin(inode, work);
> +
> +	list_for_each_entry(work, &work_list, list) {
> +		ret = kvm_gmem_convert_should_proceed(inode, work, shared,
> +						      error_index);

Since kvm_gmem_invalidate_begin() begins to handle shared memory,
kvm_gmem_convert_invalidate_begin() will zap the table.
The shared mapping could be zapped in kvm_gmem_convert_invalidate_begin() even
when kvm_gmem_convert_should_proceed() returns error.
The sequence is a bit confusing to me, at least in this patch so far.

> +		if (ret)
> +			goto invalidate_end;
> +	}
> +
> +	list_for_each_entry(work, &work_list, list) {
> +		rollback_stop_item = work;
> +		ret = kvm_gmem_shareability_apply(inode, work, m);
> +		if (ret)
> +			break;
> +	}
> +
> +	if (ret) {
> +		m = shared ? SHAREABILITY_GUEST : SHAREABILITY_ALL;
> +		list_for_each_entry(work, &work_list, list) {
> +			if (work == rollback_stop_item)
> +				break;
> +
> +			WARN_ON(kvm_gmem_shareability_apply(inode, work, m));
> +		}
> +	}
> +
> +invalidate_end:
> +	list_for_each_entry(work, &work_list, list)
> +		kvm_gmem_convert_invalidate_end(inode, work);
> +out:
> +	filemap_invalidate_unlock(inode->i_mapping);
> +
> +	list_for_each_entry_safe(work, tmp, &work_list, list) {
> +		list_del(&work->list);
> +		kfree(work);
> +	}
> +
> +	return ret;
> +}
> +
[...]
> @@ -186,15 +490,26 @@ static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
>   	unsigned long index;
>   
>   	xa_for_each_range(&gmem->bindings, index, slot, start, end - 1) {
> +		enum kvm_gfn_range_filter filter;
>   		pgoff_t pgoff = slot->gmem.pgoff;
>   
> +		filter = KVM_FILTER_PRIVATE;
> +		if (kvm_gmem_memslot_supports_shared(slot)) {
> +			/*
> +			 * Unmapping would also cause invalidation, but cannot
> +			 * rely on mmu_notifiers to do invalidation via
> +			 * unmapping, since memory may not be mapped to
> +			 * userspace.
> +			 */
> +			filter |= KVM_FILTER_SHARED;
> +		}
> +
>   		struct kvm_gfn_range gfn_range = {
>   			.start = slot->base_gfn + max(pgoff, start) - pgoff,
>   			.end = slot->base_gfn + min(pgoff + slot->npages, end) - pgoff,
>   			.slot = slot,
>   			.may_block = true,
> -			/* guest memfd is relevant to only private mappings. */
> -			.attr_filter = KVM_FILTER_PRIVATE,
> +			.attr_filter = filter,
>   		};
>   
>   		if (!found_memslot) {
> @@ -484,11 +799,49 @@ EXPORT_SYMBOL_GPL(kvm_gmem_memslot_supports_shared);
>   #define kvm_gmem_mmap NULL
>   #endif /* CONFIG_KVM_GMEM_SHARED_MEM */
>   
[...]

