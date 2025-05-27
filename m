Return-Path: <linux-fsdevel+bounces-49896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891B5AC4A78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 10:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B33D16AF02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 08:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A8824BBEE;
	Tue, 27 May 2025 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhsbScrG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6AA1CEAD6;
	Tue, 27 May 2025 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748335471; cv=none; b=nsz3Fsv2gccKYqpgbu2qNMLKG3pb9qvUeJdkcv9vnyVvjQdWrEzwhNSieYGkgGpjStRqfsVwCTGtucRkY6PotTgtPQBjFTXHU5AgdV6o9dub/sTiDlcWD5n5PHTF8p1l4Vy0j47M87dOcAhJWfWdosAYcXPYWun41+zj2xr2XzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748335471; c=relaxed/simple;
	bh=LDUja/soH89gEGH4sh7r6gwl6Kbwv9oCc2U3NgLy3do=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LV3rxkolS29/EqnY6u6LvET0mCsZ7riTfc+ZF//pJjLpYlVyGcUvhJgt+bcqF1ztepDLdycihi3A0cDmBHaJRK4ygi1BNQcjeNKFxP8/2AsBi4Bz+MUNiDjdFCPpi6u0EBiXnxAyWSSHKVeaVAMXEzdeA28g9tAny3jgSh/jPBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jhsbScrG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748335470; x=1779871470;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=LDUja/soH89gEGH4sh7r6gwl6Kbwv9oCc2U3NgLy3do=;
  b=jhsbScrGTEcoulm7Yi6lwJCuSG1V14hQnwMza4AShf7VBfFiAlSjszLV
   LQ0V2byjq30WEdzSSRe0bW33+GiWCozSTo5oxzN+0A4B4TyjbgA0Tr4Lx
   ES8Hx5ARzpeU9go9lTXmoyk5/8FFAjMGR8f77CzzXUbi4RLzRswkb8zcf
   jxdJFkgZzhpRT+K2HcZglZoY9NmevMYKYUB2RePXGYof39StBsqp+3o8L
   tTNSiLWkhx32Wn0qhQ8mz8Wo6M+eRc0VwRkJJO3JZ3oKuZFycUxafhR1b
   +QNvVDTSHTW1y8obBfF19rHsHl9+jbs25NYIZTIlvNPqv5yLCjWrtIbOw
   A==;
X-CSE-ConnectionGUID: H3JVI5mvReW55Bvhm+yX1g==
X-CSE-MsgGUID: vYRgGU9YRcmdBtFPXvZxbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="67732379"
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="67732379"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 01:44:28 -0700
X-CSE-ConnectionGUID: JMWUB66JSwiPLT/caKW45g==
X-CSE-MsgGUID: 6r760WWXS2u+N35uVyKcmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="173670439"
Received: from unknown (HELO [10.238.11.3]) ([10.238.11.3])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 01:44:01 -0700
Message-ID: <9157f2d4-62f0-41c2-a755-80233b534b42@linux.intel.com>
Date: Tue, 27 May 2025 16:43:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 02/51] KVM: guest_memfd: Introduce and use
 shareability to guard faulting
From: Binbin Wu <binbin.wu@linux.intel.com>
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
 <b784326e9ccae6a08388f1bf39db70a2204bdc51.1747264138.git.ackerleytng@google.com>
 <9483e9e3-9b29-49c6-adcc-04fe45ac28fd@linux.intel.com>
Content-Language: en-US
In-Reply-To: <9483e9e3-9b29-49c6-adcc-04fe45ac28fd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/27/2025 4:25 PM, Binbin Wu wrote:
>
>
> On 5/15/2025 7:41 AM, Ackerley Tng wrote:
>> Track guest_memfd memory's shareability status within the inode as
>> opposed to the file, since it is property of the guest_memfd's memory
>> contents.
>>
>> Shareability is a property of the memory and is indexed using the
>> page's index in the inode. Because shareability is the memory's
>> property, it is stored within guest_memfd instead of within KVM, like
>> in kvm->mem_attr_array.
>>
>> KVM_MEMORY_ATTRIBUTE_PRIVATE in kvm->mem_attr_array must still be
>> retained to allow VMs to only use guest_memfd for private memory and
>> some other memory for shared memory.
>>
>> Not all use cases require guest_memfd() to be shared with the host
>> when first created. Add a new flag, GUEST_MEMFD_FLAG_INIT_PRIVATE,
>> which when set on KVM_CREATE_GUEST_MEMFD, initializes the memory as
>> private to the guest, and therefore not mappable by the
>> host. Otherwise, memory is shared until explicitly converted to
>> private.
>>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
>> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
>> Co-developed-by: Fuad Tabba <tabba@google.com>
>> Signed-off-by: Fuad Tabba <tabba@google.com>
>> Change-Id: If03609cbab3ad1564685c85bdba6dcbb6b240c0f
>> ---
>>   Documentation/virt/kvm/api.rst |   5 ++
>>   include/uapi/linux/kvm.h       |   2 +
>>   virt/kvm/guest_memfd.c         | 124 ++++++++++++++++++++++++++++++++-
>>   3 files changed, 129 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>> index 86f74ce7f12a..f609337ae1c2 100644
>> --- a/Documentation/virt/kvm/api.rst
>> +++ b/Documentation/virt/kvm/api.rst
>> @@ -6408,6 +6408,11 @@ belonging to the slot via its userspace_addr.
>>   The use of GUEST_MEMFD_FLAG_SUPPORT_SHARED will not be allowed for CoCo VMs.
>>   This is validated when the guest_memfd instance is bound to the VM.
>>   +If the capability KVM_CAP_GMEM_CONVERSIONS is supported, then the 'flags' field
>> +supports GUEST_MEMFD_FLAG_INIT_PRIVATE.
>
> It seems that the sentence is stale?
> Didn't find the definition of KVM_CAP_GMEM_CONVERSIONS.
Aha! It's a typo, should be KVM_CAP_GMEM_CONVERSION.



>
>> Setting GUEST_MEMFD_FLAG_INIT_PRIVATE
>> +will initialize the memory for the guest_memfd as guest-only and not faultable
>> +by the host.
>> +
> [...]
>>     static int kvm_gmem_init_fs_context(struct fs_context *fc)
>> @@ -549,12 +645,26 @@ static const struct inode_operations kvm_gmem_iops = {
>>   static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
>>                                 loff_t size, u64 flags)
>>   {
>> +    struct kvm_gmem_inode_private *private;
>>       struct inode *inode;
>> +    int err;
>>         inode = alloc_anon_secure_inode(kvm_gmem_mnt->mnt_sb, name);
>>       if (IS_ERR(inode))
>>           return inode;
>>   +    err = -ENOMEM;
>> +    private = kzalloc(sizeof(*private), GFP_KERNEL);
>> +    if (!private)
>> +        goto out;
>> +
>> +    mt_init(&private->shareability);
>
> shareability is defined only when CONFIG_KVM_GMEM_SHARED_MEM enabled, should be done within CONFIG_KVM_GMEM_SHARED_MEM .
>
>
>> + inode->i_mapping->i_private_data = private;
>> +
>> +    err = kvm_gmem_shareability_setup(private, size, flags);
>> +    if (err)
>> +        goto out;
>> +
>>       inode->i_private = (void *)(unsigned long)flags;
>>       inode->i_op = &kvm_gmem_iops;
>>       inode->i_mapping->a_ops = &kvm_gmem_aops;
>> @@ -566,6 +676,11 @@ static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
>>       WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>>         return inode;
>> +
>> +out:
>> +    iput(inode);
>> +
>> +    return ERR_PTR(err);
>>   }
>>
> [...]
>


