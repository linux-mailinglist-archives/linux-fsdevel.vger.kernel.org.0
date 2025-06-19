Return-Path: <linux-fsdevel+bounces-52186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134CEAE0102
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 11:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 697BC7A64D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 09:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0505C288C03;
	Thu, 19 Jun 2025 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mb2hwxsN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6F827AC2D;
	Thu, 19 Jun 2025 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323589; cv=none; b=isLnRtpH5qshAnXruSuttZTMpLja1g21OPtEGqbCF1kj7AP4wtuBNl09H460MW+lnljtp0z4TqyJXzQZy2LHKmLFhcYPuGmvtafqE3JXip4TJ3sWOm5m5inL/kdTVjWKH3jzLJtVsTVC03aoEuiTdXJ3S96gVFr/+iUh42kT/5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323589; c=relaxed/simple;
	bh=owe3gMkwVpAp73v4z8nNbjH8PCrNzNGNQ+hew74iJyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BfwsYmj1j+n0u2ebjAh4WQSgYK33uNn0nSr13NUOllnUINJZPMFWa1Jzr73BxZt6j8fxm6xLtbwIhBn1FAejHSqKHTO5U/gdfT4J26jt6K922WKXYlhGH38ZTNPpwX4Jy3A6tIBTI4sneg+wC7gnMBIxqLwH9CxjWU53oyfqvxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mb2hwxsN; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750323588; x=1781859588;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=owe3gMkwVpAp73v4z8nNbjH8PCrNzNGNQ+hew74iJyA=;
  b=mb2hwxsNdvtTWIcknsKOzfFVDbkjjm9KEUXYAyXa8VQGaJKlWa9HSv2o
   uOQbexo7Zl1Tp5D6SgNtGw3e9E8BH0xBjeq/PDdj0XXgOnlP4Tr2a8kU3
   OWlkn7aDCqW6I2CQ4YDHqUxsup0MFrD6AreQwpsetDEvRb4eaCypWT17J
   oOFq/sH5axvNPMWPCVif+yohr+GHrTfpGNJavL9WnisvML6eeRn1nK5al
   66e5OI+FlN1/ZdI0hyCHGvvG9tyAHWe+y1tViRzknvOazziTTfsRkEQZQ
   1s0119Xavw3FtKGXLbTsntjCgOpi9ASxVviKCZ8Ytfgo2MFqaVMz7oWqD
   g==;
X-CSE-ConnectionGUID: ZvUnRNk+Sx+NX94A9BQW8Q==
X-CSE-MsgGUID: C+nKsbRVRFq0vVD0M13/vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52714140"
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="52714140"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 01:59:46 -0700
X-CSE-ConnectionGUID: SrKtsgwhSnyhIqix8wJeYQ==
X-CSE-MsgGUID: fD3NT5bGTWueX+jxB4MOdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="181616708"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1]) ([10.124.247.1])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 01:59:17 -0700
Message-ID: <d15bfdc8-e309-4041-b4c7-e8c3cdf78b26@intel.com>
Date: Thu, 19 Jun 2025 16:59:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
To: Yan Zhao <yan.y.zhao@intel.com>, Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com,
 ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com,
 anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu,
 bfoster@redhat.com, binbin.wu@linux.intel.com, brauner@kernel.org,
 catalin.marinas@arm.com, chao.p.peng@intel.com, chenhuacai@kernel.org,
 dave.hansen@intel.com, david@redhat.com, dmatlack@google.com,
 dwmw@amazon.co.uk, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com,
 graf@amazon.com, haibo1.xu@intel.com, hch@infradead.org, hughd@google.com,
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
 willy@infradead.org, yilun.xu@intel.com, yuzenghui@huawei.com,
 zhiquan1.li@intel.com
References: <cover.1747264138.git.ackerleytng@google.com>
 <aFPGlAGEPzxlxM5g@yzhao56-desk.sh.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aFPGlAGEPzxlxM5g@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/2025 4:13 PM, Yan Zhao wrote:
> On Wed, May 14, 2025 at 04:41:39PM -0700, Ackerley Tng wrote:
>> Hello,
>>
>> This patchset builds upon discussion at LPC 2024 and many guest_memfd
>> upstream calls to provide 1G page support for guest_memfd by taking
>> pages from HugeTLB.
>>
>> This patchset is based on Linux v6.15-rc6, and requires the mmap support
>> for guest_memfd patchset (Thanks Fuad!) [1].
>>
>> For ease of testing, this series is also available, stitched together,
>> at https://github.com/googleprodkernel/linux-cc/tree/gmem-1g-page-support-rfc-v2
>   
> Just to record a found issue -- not one that must be fixed.
> 
> In TDX, the initial memory region is added as private memory during TD's build
> time, with its initial content copied from source pages in shared memory.
> The copy operation requires simultaneous access to both shared source memory
> and private target memory.
> 
> Therefore, userspace cannot store the initial content in shared memory at the
> mmap-ed VA of a guest_memfd that performs in-place conversion between shared and
> private memory. This is because the guest_memfd will first unmap a PFN in shared
> page tables and then check for any extra refcount held for the shared PFN before
> converting it to private.

I have an idea.

If I understand correctly, the KVM_GMEM_CONVERT_PRIVATE of in-place 
conversion unmap the PFN in shared page tables while keeping the content 
of the page unchanged, right?

So KVM_GMEM_CONVERT_PRIVATE can be used to initialize the private memory 
actually for non-CoCo case actually, that userspace first mmap() it and 
ensure it's shared and writes the initial content to it, after it 
userspace convert it to private with KVM_GMEM_CONVERT_PRIVATE.

For CoCo case, like TDX, it can hook to KVM_GMEM_CONVERT_PRIVATE if it 
wants the private memory to be initialized with initial content, and 
just do in-place TDH.PAGE.ADD in the hook.

> Currently, we tested the initial memory region using the in-place conversion
> version of guest_memfd as backend by modifying QEMU to add an extra anonymous
> backend to hold the source initial content in shared memory. The extra anonymous
> backend is freed after finishing ading the initial memory region.
> 
> This issue is benign for TDX, as the initial memory region can also utilize the
> traditional guest_memfd, which only allows 4KB mappings. This is acceptable for
> now, as the initial memory region typically involves a small amount of memory,
> and we may not enable huge pages for ranges covered by the initial memory region
> in the near future.


