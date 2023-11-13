Return-Path: <linux-fsdevel+bounces-2784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 535847E9595
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 04:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9B06B20A27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 03:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72154BE7C;
	Mon, 13 Nov 2023 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i+0oSnA5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457BF8BF6;
	Mon, 13 Nov 2023 03:37:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC97D1;
	Sun, 12 Nov 2023 19:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699846642; x=1731382642;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y+d5ffj+cXty8WEYU0vUgR9r7fyajtAWyyGi3xYe0Go=;
  b=i+0oSnA5dFJENImLX9uLJ2SfhDUw/gT6wgwzhWtGJSyOjQYnywGugUM5
   uBqZW1F9FZoVGQOZDJCGJRbyyFVvvHeeE33GJT4yAiJbBAN73szADqJ0y
   M/aM8xovSE5mFsDHpUD2EwaN6DQHeymBmeamBryZHHmfTOQRGqYsho2at
   d3uKSkNriRFq26n2wHvXu1J6PXhUK2aoqPgD3bZ2EMPwq3w+RQEiQ5d4k
   SElmB0ZDxskPmaybFsS3+wzAraq8EPXai2H6ovDNg2SZIQv5h7aeQacJ8
   yr/e2nnuP2Rczxn1fDKpmb8/fPSiXKloHaSfr/UaF21/+x0LtjMNt0GPW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="421469892"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="421469892"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 19:37:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="764228152"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="764228152"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.6.77]) ([10.93.6.77])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 19:37:09 -0800
Message-ID: <b897d2ac-8a07-40a7-af59-dd746c56081e@intel.com>
Date: Mon, 13 Nov 2023 11:37:05 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/34] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Huacai Chen <chenhuacai@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Anish Moorthy <amoorthy@google.com>,
 David Matlack <dmatlack@google.com>, Yu Zhang <yu.c.zhang@linux.intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?=
 =?UTF-8?Q?n?= <mic@digikod.net>, Vlastimil Babka <vbabka@suse.cz>,
 Vishal Annapurve <vannapurve@google.com>,
 Ackerley Tng <ackerleytng@google.com>,
 Maciej Szmigiero <mail@maciej.szmigiero.name>,
 David Hildenbrand <david@redhat.com>, Quentin Perret <qperret@google.com>,
 Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>,
 Liam Merwick <liam.merwick@oracle.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20231105163040.14904-1-pbonzini@redhat.com>
 <20231105163040.14904-16-pbonzini@redhat.com>
 <956d8ee3-8b63-4a2d-b0c4-c0d3d74a0f6f@intel.com>
 <ZU51A3U6E3aZXayC@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZU51A3U6E3aZXayC@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/2023 2:22 AM, Sean Christopherson wrote:
> On Fri, Nov 10, 2023, Xiaoyao Li wrote:
>> On 11/6/2023 12:30 AM, Paolo Bonzini wrote:
>>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>>> index 68a144cb7dbc..a6de526c0426 100644
>>> --- a/include/linux/kvm_host.h
>>> +++ b/include/linux/kvm_host.h
>>> @@ -589,8 +589,20 @@ struct kvm_memory_slot {
>>>    	u32 flags;
>>>    	short id;
>>>    	u16 as_id;
>>> +
>>> +#ifdef CONFIG_KVM_PRIVATE_MEM
>>> +	struct {
>>> +		struct file __rcu *file;
>>> +		pgoff_t pgoff;
>>> +	} gmem;
>>> +#endif
>>>    };
>>> +static inline bool kvm_slot_can_be_private(const struct kvm_memory_slot *slot)
>>> +{
>>> +	return slot && (slot->flags & KVM_MEM_GUEST_MEMFD);
>>> +}
>>> +
>>
>> maybe we can move this block and ...
>>
>> <snip>
>>
>>> @@ -2355,6 +2379,30 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
>>>    					struct kvm_gfn_range *range);
>>>    bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
>>>    					 struct kvm_gfn_range *range);
>>> +
>>> +static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>>> +{
>>> +	return IS_ENABLED(CONFIG_KVM_PRIVATE_MEM) &&
>>> +	       kvm_get_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
>>> +}
>>> +#else
>>> +static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>>> +{
>>> +	return false;
>>> +}
>>>    #endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
>>
>> this block to Patch 18?
> 
> It would work, but my vote is to keep them here to minimize the changes to common
> KVM code in the x86 enabling.  It's not a strong preference though.  Of course,
> at this point, fiddling with this sort of thing is probably a bad idea in terms
> of landing guest_memfd.

Indeed. It's OK then.

>>> @@ -4844,6 +4875,10 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>>>    #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
>>>    	case KVM_CAP_MEMORY_ATTRIBUTES:
>>>    		return kvm_supported_mem_attributes(kvm);
>>> +#endif
>>> +#ifdef CONFIG_KVM_PRIVATE_MEM
>>> +	case KVM_CAP_GUEST_MEMFD:
>>> +		return !kvm || kvm_arch_has_private_mem(kvm);
>>>    #endif
>>>    	default:
>>>    		break;
>>> @@ -5277,6 +5312,18 @@ static long kvm_vm_ioctl(struct file *filp,
>>>    	case KVM_GET_STATS_FD:
>>>    		r = kvm_vm_ioctl_get_stats_fd(kvm);
>>>    		break;
>>> +#ifdef CONFIG_KVM_PRIVATE_MEM
>>> +	case KVM_CREATE_GUEST_MEMFD: {
>>> +		struct kvm_create_guest_memfd guest_memfd;
>>
>> Do we need a guard of below?
>>
>> 		r = -EINVAL;
>> 		if (!kvm_arch_has_private_mem(kvm))
>> 			goto out;
> 
> Argh, yeah, that's weird since KVM_CAP_GUEST_MEMFD says "not supported" if the
> VM doesn't support private memory.
> 
> Enforcing that would break guest_memfd_test.c though.  And having to create a
> "special" VM just to test basic guest_memfd functionality would be quite
> annoying.
> 
> So my vote is to do:
> 
> 	case KVM_CAP_GUEST_MEMFD:
> 		return IS_ENABLED(CONFIG_KVM_PRIVATE_MEM);

I'm fine with it.

> There's no harm to KVM if userspace creates a file it can't use, and at some
> point KVM will hopefully support guest_memfd irrespective of private memory.


