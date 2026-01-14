Return-Path: <linux-fsdevel+bounces-73726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ECFD1F40B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A12C730768CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC70A283FD4;
	Wed, 14 Jan 2026 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="WgTjpt2p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.72.182.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231CF2773CC;
	Wed, 14 Jan 2026 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.72.182.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768399013; cv=none; b=dsK+IxztjSKC/IKLQxe7+8hzP7WqXHHEHVBM4liHPVKiE2+BAFYcBZmzkfOQ1KzhWTMcYM6N34w/cmXJt8Aksq0YOeaUmtAAiwLqpj49rmH58tkh+F5rHfYd2TE9/3+XDg6M3IS8Jt8fF8OmUzGZwtLvkbEGNFN7Gtl+k4/p3Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768399013; c=relaxed/simple;
	bh=j/i1H0Snz4HoYnyRenhKpviOyYlAm/rE1Kjh+9oC6PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lw0KUdDvTUCX+wuqUrzopM7dE27ZvfXcx5ZX/cld9Cv3zqZLkDyDVCwbVLApzfeOZlo826Vz8qbbaj7FkDUbH0oyKfet/d31WQ5RizUlCjYZN192thP9TMN/EG25A73oWyN7Jevrc1Fr2ITm8EtoFJ35VuN77zr0tkF9x8O7410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=WgTjpt2p; arc=none smtp.client-ip=3.72.182.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1768399010; x=1799935010;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=idLtVV8iy0KzVVRp8IacUx7ghewbMrInHn0M3IANrbY=;
  b=WgTjpt2posNaO/m3jo/a8qR3iT9Js27imbeWwwAevP5nCHm3uPWj4nTr
   Ndh3+7sPrN7KLziQHtLfwpkwouBbZk9Ek5yDyzS7QlG3OLGKBW+5mm+jl
   l7hLOU2+dTLu7yNdNJkV+jKBduADRhpbjdzHgs36wrJ2YytYEyIgE7FBs
   LUHZDjDzLljGkMRYnABC2nyj4rT4fyRDZd/l7VZYBI/Oxql+uEA4vv9Us
   OR9PDYY8iQNCOcRI4LGOiGRi4uaoorEpkN0GgrOOUfMhiNG17XiJX4W0g
   1R5K+ztkQZXG4YGW/D5Brm9DbVDHyI6+361w0MR+CCICuhbkzAFGU+nIc
   w==;
X-CSE-ConnectionGUID: 9aZ9R8udQ/2i303O9ipEIg==
X-CSE-MsgGUID: 6VfIL1u5SAiI9T3UiqieXQ==
X-IronPort-AV: E=Sophos;i="6.21,225,1763424000"; 
   d="scan'208";a="7899890"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:56:46 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:20413]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.37.91:2525] with esmtp (Farcaster)
 id cbd269cf-6013-4e8f-bd8d-f5a3163094bc; Wed, 14 Jan 2026 13:56:46 +0000 (UTC)
X-Farcaster-Flow-ID: cbd269cf-6013-4e8f-bd8d-f5a3163094bc
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 14 Jan 2026 13:56:46 +0000
Received: from [192.168.15.25] (10.106.82.12) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Wed, 14 Jan 2026
 13:56:43 +0000
Message-ID: <7dab9550-96b5-4844-85a8-2eec2363deb9@amazon.com>
Date: Wed, 14 Jan 2026 13:56:42 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v8 03/13] mm: introduce AS_NO_DIRECT_MAP
To: John Hubbard <jhubbard@nvidia.com>, "Kalyazin, Nikita"
	<kalyazin@amazon.co.uk>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
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
	"peterx@redhat.com" <peterx@redhat.com>, "jannh@google.com"
	<jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>, "shuah@kernel.org"
	<shuah@kernel.org>, "riel@surriel.com" <riel@surriel.com>,
	"baohua@kernel.org" <baohua@kernel.org>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "jgross@suse.com" <jgross@suse.com>,
	"yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "coxu@redhat.com" <coxu@redhat.com>,
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
	"prsampat@amd.com" <prsampat@amd.com>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
	"jmattson@google.com" <jmattson@google.com>, "jthoughton@google.com"
	<jthoughton@google.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "vannapurve@google.com"
	<vannapurve@google.com>, "jackmanb@google.com" <jackmanb@google.com>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, "patrick.roy@linux.dev"
	<patrick.roy@linux.dev>, "Thomson, Jack" <jackabt@amazon.co.uk>, "Itazuri,
 Takahiro" <itazur@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>,
	"Cali, Marco" <xmarcalx@amazon.co.uk>
References: <20251205165743.9341-1-kalyazin@amazon.com>
 <20251205165743.9341-4-kalyazin@amazon.com>
 <3d26bfb2-2c82-4625-a371-96879ff43c3d@nvidia.com>
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
In-Reply-To: <3d26bfb2-2c82-4625-a371-96879ff43c3d@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D005EUA001.ant.amazon.com (10.252.50.159) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)



On 05/12/2025 18:35, John Hubbard wrote:
> On 12/5/25 8:58 AM, Kalyazin, Nikita wrote:
>> From: Patrick Roy <patrick.roy@linux.dev>
>>
>> Add AS_NO_DIRECT_MAP for mappings where direct map entries of folios are
>> set to not present. Currently, mappings that match this description are
>> secretmem mappings (memfd_secret()). Later, some guest_memfd
>> configurations will also fall into this category.
>>
>> Reject this new type of mappings in all locations that currently reject
>> secretmem mappings, on the assumption that if secretmem mappings are
>> rejected somewhere, it is precisely because of an inability to deal with
>> folios without direct map entries, and then make memfd_secret() use
>> AS_NO_DIRECT_MAP on its address_space to drop its special
>> vma_is_secretmem()/secretmem_mapping() checks.
>>
>> This drops a optimization in gup_fast_folio_allowed() where
>> secretmem_mapping() was only called if CONFIG_SECRETMEM=y. secretmem is
>> enabled by default since commit b758fe6df50d ("mm/secretmem: make it on
>> by default"), so the secretmem check did not actually end up elided in
>> most cases anymore anyway.
> 
> The above paragraph can be part (most) of a commit description for
> a separate patch for the gup aspects. Let's split it out that way,
> because it is a distinct change, and the diffs can stand alone
> from this patch here.

Split the patches in the v9, thanks.

> 
> thanks,
> -- 
> John Hubbard
> 
>>
>> Use a new flag instead of overloading AS_INACCESSIBLE (which is already
>> set by guest_memfd) because not all guest_memfd mappings will end up
>> being direct map removed (e.g. in pKVM setups, parts of guest_memfd that
>> can be mapped to userspace should also be GUP-able, and generally not
>> have restrictions on who can access it).
>>
>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> Acked-by: David Hildenbrand (Red Hat)" <david@kernel.org>
>> Signed-off-by: Patrick Roy <patrick.roy@linux.dev>
>> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
>> ---
>>   include/linux/pagemap.h   | 16 ++++++++++++++++
>>   include/linux/secretmem.h | 18 ------------------
>>   lib/buildid.c             |  4 ++--
>>   mm/gup.c                  | 19 +++++--------------
>>   mm/mlock.c                |  2 +-
>>   mm/secretmem.c            |  8 ++------
>>   6 files changed, 26 insertions(+), 41 deletions(-)
>>
>> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
>> index a17fabbc0269..d51e0c0404e2 100644
>> --- a/include/linux/pagemap.h
>> +++ b/include/linux/pagemap.h
>> @@ -213,6 +213,7 @@ enum mapping_flags {
>>       AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
>>       AS_KERNEL_FILE = 10,    /* mapping for a fake kernel file that 
>> shouldn't
>>                                  account usage to user cgroups */
>> +     AS_NO_DIRECT_MAP = 11,  /* Folios in the mapping are not in the 
>> direct map */
>>       /* Bits 16-25 are used for FOLIO_ORDER */
>>       AS_FOLIO_ORDER_BITS = 5,
>>       AS_FOLIO_ORDER_MIN = 16,
>> @@ -348,6 +349,21 @@ static inline bool 
>> mapping_writeback_may_deadlock_on_reclaim(const struct addres
>>       return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping- 
>> >flags);
>>   }
>>
>> +static inline void mapping_set_no_direct_map(struct address_space 
>> *mapping)
>> +{
>> +     set_bit(AS_NO_DIRECT_MAP, &mapping->flags);
>> +}
>> +
>> +static inline bool mapping_no_direct_map(const struct address_space 
>> *mapping)
>> +{
>> +     return test_bit(AS_NO_DIRECT_MAP, &mapping->flags);
>> +}
>> +
>> +static inline bool vma_has_no_direct_map(const struct vm_area_struct 
>> *vma)
>> +{
>> +     return vma->vm_file && mapping_no_direct_map(vma->vm_file- 
>> >f_mapping);
>> +}
>> +
>>   static inline gfp_t mapping_gfp_mask(const struct address_space 
>> *mapping)
>>   {
>>       return mapping->gfp_mask;
>> diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
>> index e918f96881f5..0ae1fb057b3d 100644
>> --- a/include/linux/secretmem.h
>> +++ b/include/linux/secretmem.h
>> @@ -4,28 +4,10 @@
>>
>>   #ifdef CONFIG_SECRETMEM
>>
>> -extern const struct address_space_operations secretmem_aops;
>> -
>> -static inline bool secretmem_mapping(struct address_space *mapping)
>> -{
>> -     return mapping->a_ops == &secretmem_aops;
>> -}
>> -
>> -bool vma_is_secretmem(struct vm_area_struct *vma);
>>   bool secretmem_active(void);
>>
>>   #else
>>
>> -static inline bool vma_is_secretmem(struct vm_area_struct *vma)
>> -{
>> -     return false;
>> -}
>> -
>> -static inline bool secretmem_mapping(struct address_space *mapping)
>> -{
>> -     return false;
>> -}
>> -
>>   static inline bool secretmem_active(void)
>>   {
>>       return false;
>> diff --git a/lib/buildid.c b/lib/buildid.c
>> index c4b0f376fb34..89e567954284 100644
>> --- a/lib/buildid.c
>> +++ b/lib/buildid.c
>> @@ -65,8 +65,8 @@ static int freader_get_folio(struct freader *r, 
>> loff_t file_off)
>>
>>       freader_put_folio(r);
>>
>> -     /* reject secretmem folios created with memfd_secret() */
>> -     if (secretmem_mapping(r->file->f_mapping))
>> +     /* reject folios without direct map entries (e.g. from 
>> memfd_secret() or guest_memfd()) */
>> +     if (mapping_no_direct_map(r->file->f_mapping))
>>               return -EFAULT;
>>
>>       r->folio = filemap_get_folio(r->file->f_mapping, file_off >> 
>> PAGE_SHIFT);
>> diff --git a/mm/gup.c b/mm/gup.c
>> index a8ba5112e4d0..719e4dbecc09 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -11,7 +11,6 @@
>>   #include <linux/rmap.h>
>>   #include <linux/swap.h>
>>   #include <linux/swapops.h>
>> -#include <linux/secretmem.h>
>>
>>   #include <linux/sched/signal.h>
>>   #include <linux/rwsem.h>
>> @@ -1216,7 +1215,7 @@ static int check_vma_flags(struct vm_area_struct 
>> *vma, unsigned long gup_flags)
>>       if ((gup_flags & FOLL_SPLIT_PMD) && is_vm_hugetlb_page(vma))
>>               return -EOPNOTSUPP;
>>
>> -     if (vma_is_secretmem(vma))
>> +     if (vma_has_no_direct_map(vma))
>>               return -EFAULT;
>>
>>       if (write) {
>> @@ -2724,7 +2723,7 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
>>    * This call assumes the caller has pinned the folio, that the 
>> lowest page table
>>    * level still points to this folio, and that interrupts have been 
>> disabled.
>>    *
>> - * GUP-fast must reject all secretmem folios.
>> + * GUP-fast must reject all folios without direct map entries (such 
>> as secretmem).
>>    *
>>    * Writing to pinned file-backed dirty tracked folios is inherently 
>> problematic
>>    * (see comment describing the writable_file_mapping_allowed() 
>> function). We
>> @@ -2739,7 +2738,6 @@ static bool gup_fast_folio_allowed(struct folio 
>> *folio, unsigned int flags)
>>   {
>>       bool reject_file_backed = false;
>>       struct address_space *mapping;
>> -     bool check_secretmem = false;
>>       unsigned long mapping_flags;
>>
>>       /*
>> @@ -2751,18 +2749,10 @@ static bool gup_fast_folio_allowed(struct 
>> folio *folio, unsigned int flags)
>>               reject_file_backed = true;
>>
>>       /* We hold a folio reference, so we can safely access folio 
>> fields. */
>> -
>> -     /* secretmem folios are always order-0 folios. */
>> -     if (IS_ENABLED(CONFIG_SECRETMEM) && !folio_test_large(folio))
>> -             check_secretmem = true;
>> -
>> -     if (!reject_file_backed && !check_secretmem)
>> -             return true;
>> -
>>       if (WARN_ON_ONCE(folio_test_slab(folio)))
>>               return false;
>>
>> -     /* hugetlb neither requires dirty-tracking nor can be secretmem. */
>> +     /* hugetlb neither requires dirty-tracking nor can be without 
>> direct map. */
>>       if (folio_test_hugetlb(folio))
>>               return true;
>>
>> @@ -2800,8 +2790,9 @@ static bool gup_fast_folio_allowed(struct folio 
>> *folio, unsigned int flags)
>>        * At this point, we know the mapping is non-null and points to an
>>        * address_space object.
>>        */
>> -     if (check_secretmem && secretmem_mapping(mapping))
>> +     if (mapping_no_direct_map(mapping))
>>               return false;
>> +
>>       /* The only remaining allowed file system is shmem. */
>>       return !reject_file_backed || shmem_mapping(mapping);
>>   }
>> diff --git a/mm/mlock.c b/mm/mlock.c
>> index bb0776f5ef7c..506452ee8cad 100644
>> --- a/mm/mlock.c
>> +++ b/mm/mlock.c
>> @@ -474,7 +474,7 @@ static int mlock_fixup(struct vma_iterator *vmi, 
>> struct vm_area_struct *vma,
>>
>>       if (newflags == oldflags || (oldflags & VM_SPECIAL) ||
>>           is_vm_hugetlb_page(vma) || vma == get_gate_vma(current->mm) ||
>> -         vma_is_dax(vma) || vma_is_secretmem(vma) || (oldflags & 
>> VM_DROPPABLE))
>> +         vma_is_dax(vma) || vma_has_no_direct_map(vma) || (oldflags & 
>> VM_DROPPABLE))
>>               /* don't set VM_LOCKED or VM_LOCKONFAULT and don't count */
>>               goto out;
>>
>> diff --git a/mm/secretmem.c b/mm/secretmem.c
>> index b59350daffe3..c1eafe29c3e8 100644
>> --- a/mm/secretmem.c
>> +++ b/mm/secretmem.c
>> @@ -134,11 +134,6 @@ static int secretmem_mmap_prepare(struct 
>> vm_area_desc *desc)
>>       return 0;
>>   }
>>
>> -bool vma_is_secretmem(struct vm_area_struct *vma)
>> -{
>> -     return vma->vm_ops == &secretmem_vm_ops;
>> -}
>> -
>>   static const struct file_operations secretmem_fops = {
>>       .release        = secretmem_release,
>>       .mmap_prepare   = secretmem_mmap_prepare,
>> @@ -156,7 +151,7 @@ static void secretmem_free_folio(struct folio *folio)
>>       folio_zero_segment(folio, 0, folio_size(folio));
>>   }
>>
>> -const struct address_space_operations secretmem_aops = {
>> +static const struct address_space_operations secretmem_aops = {
>>       .dirty_folio    = noop_dirty_folio,
>>       .free_folio     = secretmem_free_folio,
>>       .migrate_folio  = secretmem_migrate_folio,
>> @@ -205,6 +200,7 @@ static struct file *secretmem_file_create(unsigned 
>> long flags)
>>
>>       mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
>>       mapping_set_unevictable(inode->i_mapping);
>> +     mapping_set_no_direct_map(inode->i_mapping);
>>
>>       inode->i_op = &secretmem_iops;
>>       inode->i_mapping->a_ops = &secretmem_aops;
> 
> 


