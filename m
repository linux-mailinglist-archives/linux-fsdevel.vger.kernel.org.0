Return-Path: <linux-fsdevel+bounces-74152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A67D3304E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE9543050285
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 14:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A560C397ABF;
	Fri, 16 Jan 2026 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="J7Av3Jbg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.199.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDAE2FFDF8;
	Fri, 16 Jan 2026 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.199.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575436; cv=none; b=Lj5Qq0jYxTksCPjPhYK9pkR8iDQo48dYgKdz/LYQ4JVl7ztDWesyhzmOsiIrhdjbj/qeC7Eb7rkHpV7scyBrX6hCNHFJu9JhWsWv+A8bYtbMUkPnbhPbWj9Ozgn7xgMXeWNWmmlkzh1optpOZE320/UuXeiYezWVfDfVhtYFP9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575436; c=relaxed/simple;
	bh=HqLuYnV5tuZ3t6R3gm9zbHuzUCEolVTdsZodN2etShg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g23iqQKyYS7fFcpJ0d4Sv3EJm5mOBvIlslOFKuiijkpO8/XHaA49UYKWyIuikVpR8HMS8b7aECqIoX/Nz5AnIYx2j5Sb/BxAieFZHA4nrxZPHEOi/Bd/pcWJBLdmnEM5YzACsl9rN+kGGyxqfhdLTdaAr1RzvQ3VbeYHkUcKeTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=J7Av3Jbg; arc=none smtp.client-ip=18.199.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1768575434; x=1800111434;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=MR+rnXxwxn/7x1Gj4j0jxSdDeJDLel3jNY29213m130=;
  b=J7Av3JbgmOW5Zw36TtyJiyqO5DK3zoHRj4hX6c0TpAbU8JNXbS6GTNHS
   kGZfR9zLBNaIcEf2GeqYZ5d9Xwi92eJ3cJCfR0Dn8vAsSGcdoT6Oule+v
   bfsmIVC2kxprMJKfrBCbgn+5zKOV80f84iCVUS3BE8O1bOrEz4I72Y/q6
   zIVN84HKjGqvxx0UOOUJfrwsSRJYf3hqh2HDScRMNUFKseCpKThrM1X9B
   WCDBs3nEJjlgJyqX4KrzKrgsSRAnIFgpaKvLsswdwj56NZDIJ1xgS3VtX
   sToCkkVPbFeWIay0+W1VkQjbbfPHUJa4UPxRkjw6TxoKWSPF/RU5krcZ7
   w==;
X-CSE-ConnectionGUID: vQMfjCS2RPe/+ynLfnaVwA==
X-CSE-MsgGUID: CK/cr+tHSwmdmlTSKnHeWA==
X-IronPort-AV: E=Sophos;i="6.21,231,1763424000"; 
   d="scan'208";a="7920258"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 14:56:55 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:20480]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.28.56:2525] with esmtp (Farcaster)
 id fa6b071b-8258-4488-b17f-3ae252f37550; Fri, 16 Jan 2026 14:56:55 +0000 (UTC)
X-Farcaster-Flow-ID: fa6b071b-8258-4488-b17f-3ae252f37550
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 16 Jan 2026 14:56:52 +0000
Received: from [192.168.12.13] (10.106.82.9) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Fri, 16 Jan 2026
 14:56:48 +0000
Message-ID: <a2b79af7-e5d1-4668-bff3-606f57d32dfc@amazon.com>
Date: Fri, 16 Jan 2026 14:56:46 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from direct
 map
To: Ackerley Tng <ackerleytng@google.com>, "Kalyazin, Nikita"
	<kalyazin@amazon.co.uk>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kernel@xen0n.name" <kernel@xen0n.name>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "maz@kernel.org" <maz@kernel.org>, "oupton@kernel.org"
	<oupton@kernel.org>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "yuzenghui@huawei.com"
	<yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org"
	<luto@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"willy@infradead.org" <willy@infradead.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com"
	<surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
	"song@kernel.org" <song@kernel.org>, "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jannh@google.com" <jannh@google.com>,
	"pfalcato@suse.de" <pfalcato@suse.de>, "shuah@kernel.org" <shuah@kernel.org>,
	"riel@surriel.com" <riel@surriel.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "jgross@suse.com" <jgross@suse.com>,
	"yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "coxu@redhat.com" <coxu@redhat.com>,
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, "maobibo@loongson.cn"
	<maobibo@loongson.cn>, "prsampat@amd.com" <prsampat@amd.com>,
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jmattson@google.com"
	<jmattson@google.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "alex@ghiti.fr"
	<alex@ghiti.fr>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "dev.jain@arm.com"
	<dev.jain@arm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>,
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"pjw@kernel.org" <pjw@kernel.org>, "shijie@os.amperecomputing.com"
	<shijie@os.amperecomputing.com>, "svens@linux.ibm.com" <svens@linux.ibm.com>,
	"thuth@redhat.com" <thuth@redhat.com>, "wyihan@google.com"
	<wyihan@google.com>, "yang@os.amperecomputing.com"
	<yang@os.amperecomputing.com>, "vannapurve@google.com"
	<vannapurve@google.com>, "jackmanb@google.com" <jackmanb@google.com>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, "patrick.roy@linux.dev"
	<patrick.roy@linux.dev>, "Thomson, Jack" <jackabt@amazon.co.uk>, "Itazuri,
 Takahiro" <itazur@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>,
	"Cali, Marco" <xmarcalx@amazon.co.uk>
References: <20260114134510.1835-1-kalyazin@amazon.com>
 <20260114134510.1835-8-kalyazin@amazon.com>
 <CAEvNRgEzVhEzr-3GWTsE7GSBsPdvVLq7WFEeLHzcmMe=R9S51w@mail.gmail.com>
Content-Language: en-US
From: Nikita Kalyazin <kalyazin@amazon.com>
Autocrypt: addr=kalyazin@amazon.com; keydata=
 xjMEY+ZIvRYJKwYBBAHaRw8BAQdA9FwYskD/5BFmiiTgktstviS9svHeszG2JfIkUqjxf+/N
 JU5pa2l0YSBLYWx5YXppbiA8a2FseWF6aW5AYW1hem9uLmNvbT7CjwQTFggANxYhBGhhGDEy
 BjLQwD9FsK+SyiCpmmTzBQJnrNfABQkFps9DAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQr5LK
 IKmaZPOpfgD/exazh4C2Z8fNEz54YLJ6tuFEgQrVQPX6nQ/PfQi2+dwBAMGTpZcj9Z9NvSe1
 CmmKYnYjhzGxzjBs8itSUvWIcMsFzjgEY+ZIvRIKKwYBBAGXVQEFAQEHQCqd7/nb2tb36vZt
 ubg1iBLCSDctMlKHsQTp7wCnEc4RAwEIB8J+BBgWCAAmFiEEaGEYMTIGMtDAP0Wwr5LKIKma
 ZPMFAmes18AFCQWmz0MCGwwACgkQr5LKIKmaZPNTlQEA+q+rGFn7273rOAg+rxPty0M8lJbT
 i2kGo8RmPPLu650A/1kWgz1AnenQUYzTAFnZrKSsXAw5WoHaDLBz9kiO5pAK
In-Reply-To: <CAEvNRgEzVhEzr-3GWTsE7GSBsPdvVLq7WFEeLHzcmMe=R9S51w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D008EUC003.ant.amazon.com (10.252.51.205) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)



On 15/01/2026 20:00, Ackerley Tng wrote:
> "Kalyazin, Nikita" <kalyazin@amazon.co.uk> writes:
> 
>> From: Patrick Roy <patrick.roy@linux.dev>
>>
>> Add GUEST_MEMFD_FLAG_NO_DIRECT_MAP flag for KVM_CREATE_GUEST_MEMFD()
>> ioctl. When set, guest_memfd folios will be removed from the direct map
>> after preparation, with direct map entries only restored when the folios
>> are freed.
>>
>> To ensure these folios do not end up in places where the kernel cannot
>> deal with them, set AS_NO_DIRECT_MAP on the guest_memfd's struct
>> address_space if GUEST_MEMFD_FLAG_NO_DIRECT_MAP is requested.
>>
>> Note that this flag causes removal of direct map entries for all
>> guest_memfd folios independent of whether they are "shared" or "private"
>> (although current guest_memfd only supports either all folios in the
>> "shared" state, or all folios in the "private" state if
>> GUEST_MEMFD_FLAG_MMAP is not set). The usecase for removing direct map
>> entries of also the shared parts of guest_memfd are a special type of
>> non-CoCo VM where, host userspace is trusted to have access to all of
>> guest memory, but where Spectre-style transient execution attacks
>> through the host kernel's direct map should still be mitigated.  In this
>> setup, KVM retains access to guest memory via userspace mappings of
>> guest_memfd, which are reflected back into KVM's memslots via
>> userspace_addr. This is needed for things like MMIO emulation on x86_64
>> to work.
>>
>> Direct map entries are zapped right before guest or userspace mappings
>> of gmem folios are set up, e.g. in kvm_gmem_fault_user_mapping() or
>> kvm_gmem_get_pfn() [called from the KVM MMU code]. The only place where
>> a gmem folio can be allocated without being mapped anywhere is
>> kvm_gmem_populate(), where handling potential failures of direct map
>> removal is not possible (by the time direct map removal is attempted,
>> the folio is already marked as prepared, meaning attempting to re-try
>> kvm_gmem_populate() would just result in -EEXIST without fixing up the
>> direct map state). These folios are then removed form the direct map
>> upon kvm_gmem_get_pfn(), e.g. when they are mapped into the guest later.
>>
>> Signed-off-by: Patrick Roy <patrick.roy@linux.dev>
>> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
>> ---
>>   Documentation/virt/kvm/api.rst | 22 ++++++++------
>>   include/linux/kvm_host.h       | 12 ++++++++
>>   include/uapi/linux/kvm.h       |  1 +
>>   virt/kvm/guest_memfd.c         | 54 ++++++++++++++++++++++++++++++++++
>>   4 files changed, 80 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>> index 01a3abef8abb..c5f54f1370c8 100644
>> --- a/Documentation/virt/kvm/api.rst
>> +++ b/Documentation/virt/kvm/api.rst
>> @@ -6440,15 +6440,19 @@ a single guest_memfd file, but the bound ranges must not overlap).
>>   The capability KVM_CAP_GUEST_MEMFD_FLAGS enumerates the `flags` that can be
>>   specified via KVM_CREATE_GUEST_MEMFD.  Currently defined flags:
>>
>> -  ============================ ================================================
>> -  GUEST_MEMFD_FLAG_MMAP        Enable using mmap() on the guest_memfd file
>> -                               descriptor.
>> -  GUEST_MEMFD_FLAG_INIT_SHARED Make all memory in the file shared during
>> -                               KVM_CREATE_GUEST_MEMFD (memory files created
>> -                               without INIT_SHARED will be marked private).
>> -                               Shared memory can be faulted into host userspace
>> -                               page tables. Private memory cannot.
>> -  ============================ ================================================
>> +  ============================== ================================================
>> +  GUEST_MEMFD_FLAG_MMAP          Enable using mmap() on the guest_memfd file
>> +                                 descriptor.
>> +  GUEST_MEMFD_FLAG_INIT_SHARED   Make all memory in the file shared during
>> +                                 KVM_CREATE_GUEST_MEMFD (memory files created
>> +                                 without INIT_SHARED will be marked private).
>> +                                 Shared memory can be faulted into host userspace
>> +                                 page tables. Private memory cannot.
>> +  GUEST_MEMFD_FLAG_NO_DIRECT_MAP The guest_memfd instance will behave similarly
>> +                                 to memfd_secret, and unmaps the memory backing
> 
> Perhaps the reference to memfd_secret can be dropped to avoid anyone
> assuming further similarities between guest_memfd and memfd_secret. This
> could just say that "The guest_memfd instance will unmap the memory
> backing it from the kernel's address space...".

Agree, it may lead to a confusion down the line, thanks.

> 
>> +                                 it from the kernel's address space before
>> +                                 being passed off to userspace or the guest.
>> +  ============================== ================================================
>>
>>   When the KVM MMU performs a PFN lookup to service a guest fault and the backing
>>   guest_memfd has the GUEST_MEMFD_FLAG_MMAP set, then the fault will always be
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> index 27796a09d29b..d4d5306075bf 100644
>> --- a/include/linux/kvm_host.h
>> +++ b/include/linux/kvm_host.h
>> @@ -738,10 +738,22 @@ static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
>>        if (!kvm || kvm_arch_supports_gmem_init_shared(kvm))
>>                flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
>>
>> +     if (kvm_arch_gmem_supports_no_direct_map())
>> +             flags |= GUEST_MEMFD_FLAG_NO_DIRECT_MAP;
>> +
>>        return flags;
>>   }
>>   #endif
>>
>> +#ifdef CONFIG_KVM_GUEST_MEMFD
>> +#ifndef kvm_arch_gmem_supports_no_direct_map
>> +static inline bool kvm_arch_gmem_supports_no_direct_map(void)
>> +{
>> +     return false;
>> +}
>> +#endif
>> +#endif /* CONFIG_KVM_GUEST_MEMFD */
>> +
>>   #ifndef kvm_arch_has_readonly_mem
>>   static inline bool kvm_arch_has_readonly_mem(struct kvm *kvm)
>>   {
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index dddb781b0507..60341e1ba1be 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -1612,6 +1612,7 @@ struct kvm_memory_attributes {
>>   #define KVM_CREATE_GUEST_MEMFD       _IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
>>   #define GUEST_MEMFD_FLAG_MMAP                (1ULL << 0)
>>   #define GUEST_MEMFD_FLAG_INIT_SHARED (1ULL << 1)
>> +#define GUEST_MEMFD_FLAG_NO_DIRECT_MAP       (1ULL << 2)
>>
>>   struct kvm_create_guest_memfd {
>>        __u64 size;
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index 92e7f8c1f303..43f64c11467a 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -7,6 +7,9 @@
>>   #include <linux/mempolicy.h>
>>   #include <linux/pseudo_fs.h>
>>   #include <linux/pagemap.h>
>> +#include <linux/set_memory.h>
>> +
>> +#include <asm/tlbflush.h>
>>
>>   #include "kvm_mm.h"
>>
>> @@ -76,6 +79,43 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slo
>>        return 0;
>>   }
>>
>> +#define KVM_GMEM_FOLIO_NO_DIRECT_MAP BIT(0)
>> +
>> +static bool kvm_gmem_folio_no_direct_map(struct folio *folio)
>> +{
>> +     return ((u64) folio->private) & KVM_GMEM_FOLIO_NO_DIRECT_MAP;
> 
> Nit: I think there shouldn't be a space between (u64) and what's being casted.

True, will remove.

> 
>> +}
>> +
>> +static int kvm_gmem_folio_zap_direct_map(struct folio *folio)
>> +{
>> +     u64 gmem_flags = GMEM_I(folio_inode(folio))->flags;
>> +     int r = 0;
>> +
>> +     if (kvm_gmem_folio_no_direct_map(folio) || !(gmem_flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP))
>> +             goto out;
>> +
>> +     folio->private = (void *)((u64)folio->private | KVM_GMEM_FOLIO_NO_DIRECT_MAP);
>> +     r = folio_zap_direct_map(folio);
>> +
>> +out:
>> +     return r;
>> +}
>> +
>> +static void kvm_gmem_folio_restore_direct_map(struct folio *folio)
>> +{
>> +     /*
>> +      * Direct map restoration cannot fail, as the only error condition
>> +      * for direct map manipulation is failure to allocate page tables
>> +      * when splitting huge pages, but this split would have already
>> +      * happened in folio_zap_direct_map() in kvm_gmem_folio_zap_direct_map().
>> +      * Thus folio_restore_direct_map() here only updates prot bits.
>> +      */
> 
> Thanks for this comment :)

Thanks to Patrick :)

> 
>> +     if (kvm_gmem_folio_no_direct_map(folio)) {
>> +             WARN_ON_ONCE(folio_restore_direct_map(folio));
>> +             folio->private = (void *)((u64)folio->private & ~KVM_GMEM_FOLIO_NO_DIRECT_MAP);
>> +     }
>> +}
>> +
>>   static inline void kvm_gmem_mark_prepared(struct folio *folio)
>>   {
>>        folio_mark_uptodate(folio);
>> @@ -398,6 +438,7 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>>        struct inode *inode = file_inode(vmf->vma->vm_file);
>>        struct folio *folio;
>>        vm_fault_t ret = VM_FAULT_LOCKED;
>> +     int err;
>>
>>        if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
>>                return VM_FAULT_SIGBUS;
>> @@ -423,6 +464,12 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>>                kvm_gmem_mark_prepared(folio);
>>        }
>>
>> +     err = kvm_gmem_folio_zap_direct_map(folio);
> 
> Perhaps the check for gmem_flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP should
> be done here before making the call to kvm_gmem_folio_zap_direct_map()
> to make it more obvious that zapping is conditional.

Makes sense to me.

> 
> Perhaps also add a check for kvm_arch_gmem_supports_no_direct_map() so
> this call can be completely removed by the compiler if it wasn't
> compiled in.

But if it is compiled in, we will be paying the cost of the call on 
every page fault?  Eg on arm64, it will call the following:

bool can_set_direct_map(void)
{

...

	return rodata_full || debug_pagealloc_enabled() ||
		arm64_kfence_can_set_direct_map() || is_realm_world();
}

> 
> The kvm_gmem_folio_no_direct_map() check should probably remain in
> kvm_gmem_folio_zap_direct_map() since that's a "if already zapped, don't
> zap again" check.
> 
>> +     if (err) {
>> +             ret = vmf_error(err);
>> +             goto out_folio;
>> +     }
>> +
>>        vmf->page = folio_file_page(folio, vmf->pgoff);
>>
>>   out_folio:
>> @@ -533,6 +580,8 @@ static void kvm_gmem_free_folio(struct folio *folio)
>>        kvm_pfn_t pfn = page_to_pfn(page);
>>        int order = folio_order(folio);
>>
>> +     kvm_gmem_folio_restore_direct_map(folio);
>> +
> 
> I can't decide if the kvm_gmem_folio_no_direct_map(folio) should be in
> the caller or within kvm_gmem_folio_restore_direct_map(), since this
> time it's a folio-specific property being checked.

I'm tempted to keep it similar to the kvm_gmem_folio_zap_direct_map() 
case.  How does the fact it's a folio-speicific property change your 
reasoning?

> 
> Perhaps also add a check for kvm_arch_gmem_supports_no_direct_map() so
> this call can be completely removed by the compiler if it wasn't
> compiled in. IIUC whether the check is added in the caller or within
> kvm_gmem_folio_restore_direct_map() the call can still be elided.

Same concern as the above about kvm_gmem_folio_zap_direct_map(), ie the 
performance of the case where kvm_arch_gmem_supports_no_direct_map() exists.

> 
>>        kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
>>   }
>>
>> @@ -596,6 +645,9 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>>        /* Unmovable mappings are supposed to be marked unevictable as well. */
>>        WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>>
>> +     if (flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP)
>> +             mapping_set_no_direct_map(inode->i_mapping);
>> +
>>        GMEM_I(inode)->flags = flags;
>>
>>        file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR, &kvm_gmem_fops);
>> @@ -807,6 +859,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>>        if (!is_prepared)
>>                r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
>>
>> +     kvm_gmem_folio_zap_direct_map(folio);
>> +
> 
> Is there a reason why errors are not handled when faulting private memory?

No, I can't see a reason.  Will add a check, thanks.

> 
>>        folio_unlock(folio);
>>
>>        if (!r)
>> --
>> 2.50.1


