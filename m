Return-Path: <linux-fsdevel+bounces-65125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F9BBFCD75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 17:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE69250039F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 15:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D69134B681;
	Wed, 22 Oct 2025 15:22:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F8F309F1E;
	Wed, 22 Oct 2025 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146525; cv=none; b=sdtKywCdL0WGdIzjC7zGuZGHd1Udtg++sr2PFaIsvDaeEkhDG+PlvfKLgtnQ18B6xYWCuGKZnUcR3RWewMu0BAuqUgxZsa1QXkcOv9Tese7nJUBHaiaCjWObNKVZ8+eTUCjU9b929rC0V788TI0ArM/DO+xRATg6npcxz4k1k1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146525; c=relaxed/simple;
	bh=SHH0MKNc1HKkLyjtbC1hAyqEI4+sWFaedr6WKmlv1kQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLxodu2AHlu6Hkn1n0RdJ416l4IAEF8iynMxtZYTWlKit0MkQbohbG9+lrsESWClav/4ZkSzruN7oxrbdUv01zOui0fUZGqh4M3Tw1jSrm/j3SkIFVTe5UXUFhC54MMr5QAy2Nj26EbTItk/uj/2tTW8tHEFbH3LduPKDtLOuhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE29E1063;
	Wed, 22 Oct 2025 08:21:49 -0700 (PDT)
Received: from [10.57.33.187] (unknown [10.57.33.187])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C94A13F63F;
	Wed, 22 Oct 2025 08:21:37 -0700 (PDT)
Message-ID: <2457cb3b-5dde-4ca1-b75d-174b5daee28a@arm.com>
Date: Wed, 22 Oct 2025 16:21:34 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 07/37] KVM: Introduce KVM_SET_MEMORY_ATTRIBUTES2
To: Ackerley Tng <ackerleytng@google.com>, cgroups@vger.kernel.org,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: akpm@linux-foundation.org, binbin.wu@linux.intel.com, bp@alien8.de,
 brauner@kernel.org, chao.p.peng@intel.com, chenhuacai@kernel.org,
 corbet@lwn.net, dave.hansen@intel.com, dave.hansen@linux.intel.com,
 david@redhat.com, dmatlack@google.com, erdemaktas@google.com,
 fan.du@intel.com, fvdl@google.com, haibo1.xu@intel.com, hannes@cmpxchg.org,
 hch@infradead.org, hpa@zytor.com, hughd@google.com, ira.weiny@intel.com,
 isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com,
 jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com,
 jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com,
 kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev,
 liam.merwick@oracle.com, maciej.wieczor-retman@intel.com,
 mail@maciej.szmigiero.name, maobibo@loongson.cn,
 mathieu.desnoyers@efficios.com, maz@kernel.org, mhiramat@kernel.org,
 mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, mingo@redhat.com,
 mlevitsk@redhat.com, mpe@ellerman.id.au, muchun.song@linux.dev,
 nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev,
 palmer@dabbelt.com, pankaj.gupta@amd.com, paul.walmsley@sifive.com,
 pbonzini@redhat.com, peterx@redhat.com, pgonda@google.com, prsampat@amd.com,
 pvorel@suse.cz, qperret@google.com, richard.weiyang@gmail.com,
 rick.p.edgecombe@intel.com, rientjes@google.com, rostedt@goodmis.org,
 roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com,
 shakeel.butt@linux.dev, shuah@kernel.org, steven.sistare@oracle.com,
 suzuki.poulose@arm.com, tabba@google.com, tglx@linutronix.de,
 thomas.lendacky@amd.com, vannapurve@google.com, vbabka@suse.cz,
 viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com,
 will@kernel.org, willy@infradead.org, wyihan@google.com,
 xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com,
 yuzenghui@huawei.com, zhiquan1.li@intel.com
References: <cover.1760731772.git.ackerleytng@google.com>
 <8ee16fbf254115b0fd72cc2b5c06d2ccef66eca9.1760731772.git.ackerleytng@google.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <8ee16fbf254115b0fd72cc2b5c06d2ccef66eca9.1760731772.git.ackerleytng@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/10/2025 21:11, Ackerley Tng wrote:
> Introduce a "version 2" of KVM_SET_MEMORY_ATTRIBUTES to support returning
> information back to userspace.
> 
> This new ioctl and structure will, in a later patch, be shared as a
> guest_memfd ioctl, where the padding in the new kvm_memory_attributes2
> structure will be for writing the response from the guest_memfd ioctl to
> userspace.
> 
> A new ioctl is necessary for these reasons:
> 
> 1. KVM_SET_MEMORY_ATTRIBUTES is currently a write-only ioctl and does not
>    allow userspace to read fields. There's nothing in code (yet?) that
>    validates this, but using _IOWR for consistency would be prudent.
> 
> 2. KVM_SET_MEMORY_ATTRIBUTES, when used as a guest_memfd ioctl, will need
>    an additional field to provide userspace with more error details.
> 
> Alternatively, a completely new ioctl could be defined, unrelated to
> KVM_SET_MEMORY_ATTRIBUTES, but using the same ioctl number and struct for
> the vm and guest_memfd ioctls streamlines the interface for userspace. In
> addition, any memory attributes, implemented on the vm or guest_memfd
> ioctl, can be easily shared with the other.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  Documentation/virt/kvm/api.rst | 32 +++++++++++++++++++++++++++++++
>  include/uapi/linux/kvm.h       | 12 ++++++++++++
>  virt/kvm/kvm_main.c            | 35 +++++++++++++++++++++++++++++++---
>  3 files changed, 76 insertions(+), 3 deletions(-)
> 
[...]
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 52f6000ab0208..c300e38c7c9cd 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
[...]
> @@ -5366,15 +5375,35 @@ static long kvm_vm_ioctl(struct file *filp,
>  	}
>  #endif /* CONFIG_HAVE_KVM_IRQ_ROUTING */
>  #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> +	case KVM_SET_MEMORY_ATTRIBUTES2:
>  	case KVM_SET_MEMORY_ATTRIBUTES: {
> -		struct kvm_memory_attributes attrs;
> +		struct kvm_memory_attributes2 attrs;
> +		unsigned long size;
> +
> +		if (ioctl == KVM_SET_MEMORY_ATTRIBUTES) {
> +			/*
> +			 * Fields beyond struct kvm_userspace_memory_region shouldn't be
> +			 * accessed, but avoid leaking kernel memory in case of a bug.
> +			 */
> +			memset(&mem, 0, sizeof(mem));

s/mem/attrs/g

> +			size = sizeof(struct kvm_set_memory_attributes);
> +		} else {
> +			size = sizeof(struct kvm_set_memory_attributes2);

s/kvm_set_memory_attributes/kvm_memory_attributes/ (on both sizeof lines
above and in the SANITY_CHECK_MEMORY_ATTRIBUTES_FIELD macro).

> +		}
> +
> +		/* Ensure the common parts of the two structs are identical. */
> +		SANITY_CHECK_MEMORY_ATTRIBUTES_FIELD(slot);
> +		SANITY_CHECK_MEMORY_ATTRIBUTES_FIELD(flags);
> +		SANITY_CHECK_MEMORY_ATTRIBUTES_FIELD(guest_phys_addr);
> +		SANITY_CHECK_MEMORY_ATTRIBUTES_FIELD(memory_size);
> +		SANITY_CHECK_MEMORY_ATTRIBUTES_FIELD(userspace_addr);

The fields are:
  * address
  * size
  * attributes
  * flags

The list you've got appears to match struct kvm_userspace_memory_region
- copy/paste error?

Thanks,
Steve

>  
>  		r = -ENOTTY;
>  		if (!vm_memory_attributes)
>  			goto out;
>  
>  		r = -EFAULT;
> -		if (copy_from_user(&attrs, argp, sizeof(attrs)))
> +		if (copy_from_user(&attrs, argp, size))
>  			goto out;
>  
>  		r = kvm_vm_ioctl_set_mem_attributes(kvm, &attrs);


