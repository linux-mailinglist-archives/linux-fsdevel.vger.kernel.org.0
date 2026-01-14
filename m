Return-Path: <linux-fsdevel+bounces-73724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F71AD1F3F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EF2A30DF3C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FF22848A0;
	Wed, 14 Jan 2026 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="TMJx7gbO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.28.197.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48876276046;
	Wed, 14 Jan 2026 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.28.197.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768398975; cv=none; b=LPU5+Wf+jrB5DyEnGe0UX/ZiERDk7qpPXHZhjj/tPgfIyQkbqHqGpgMhTN0IXK20gRzD4QuQpeh+rVzKkjgOhIJCeAR3yDF4iLy+l9CFZG2Lu0/lDh8cwYHyLh3gXNtXjSuvG7F5ihKNPbIV3u12dv5HV/9D63rvqbue7b3AKnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768398975; c=relaxed/simple;
	bh=0bavQZSe/jMw07nYS7kOgTE4RJlM3SaeJ3dm9j9QGnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jQdm6BEutA7c30oPU+KrB+T/nTq9YGNpVgsDG3PDrzm1spQ4oalvJMKtaJJ7lKW6tliGehmHSX3iarpXlz4FIj+4q8xr48A1ITOseG/+XPtmmDmiRn+YE9fFM4nHkARMOD+2ikUh6825ku7kzKGM/h61uZlB0UJ7EJ5wrfGqnng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=TMJx7gbO; arc=none smtp.client-ip=52.28.197.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1768398973; x=1799934973;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=Sv4MlCPNVERmcNp9kqSjh82IbrnYTRQgNTSc/lKG79A=;
  b=TMJx7gbOwUuGYT8J45Wf4BEDg+Kj4aw1agPkhrZ9O+HosJT7JUuIfqMi
   qAOPlfT2tm2zso7wn2m3vxNyIpmqyUwGThVjrkhzKfKoMH9/+Q8p9Z+rH
   FzJ8QObSlXBPB57tbhhlzrjtSesfn78UCD4LeVmKLtwfVEXr8DHubU/Ru
   lT+bBRsU01TN/XA7nZd+QUelcqFivm+NRA2gryVFeMYtzFENyYUPBqCe7
   ZO+Iy9uLlGwwy/b/6fQiqYFmDr0/+9OEv912dYKOVVKb9gcKKZsaLDtFQ
   vBKVzWy4HqW5QxduBom4L94Dqjkp3DCkPCR4qkcYRc0H8oH20lsxZkAtu
   Q==;
X-CSE-ConnectionGUID: cW2/bP43S+W7GDw53OvOsA==
X-CSE-MsgGUID: D23VOrnzTJOU3brwm1eZ2w==
X-IronPort-AV: E=Sophos;i="6.21,225,1763424000"; 
   d="scan'208";a="7791279"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:55:52 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:11343]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.30.60:2525] with esmtp (Farcaster)
 id 8a859852-980a-4ccf-94d2-9c29b54debef; Wed, 14 Jan 2026 13:55:52 +0000 (UTC)
X-Farcaster-Flow-ID: 8a859852-980a-4ccf-94d2-9c29b54debef
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 14 Jan 2026 13:55:51 +0000
Received: from [192.168.15.25] (10.106.82.12) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Wed, 14 Jan 2026
 13:55:48 +0000
Message-ID: <d204f259-c965-466f-bd75-bb0f767ed8f1@amazon.com>
Date: Wed, 14 Jan 2026 13:55:43 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v8 05/13] KVM: guest_memfd: Add flag to remove from direct
 map
To: Vlastimil Babka <vbabka@suse.cz>, "Kalyazin, Nikita"
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
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "rppt@kernel.org"
	<rppt@kernel.org>, "surenb@google.com" <surenb@google.com>, "mhocko@suse.com"
	<mhocko@suse.com>, "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "eddyz87@gmail.com"
	<eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "jhubbard@nvidia.com"
	<jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jannh@google.com" <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>,
	"shuah@kernel.org" <shuah@kernel.org>, "riel@surriel.com" <riel@surriel.com>,
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
 <20251205165743.9341-6-kalyazin@amazon.com>
 <c68efe59-5405-4be5-a768-f27ce27d59d7@suse.cz>
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
In-Reply-To: <c68efe59-5405-4be5-a768-f27ce27d59d7@suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D010EUC001.ant.amazon.com (10.252.51.232) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)



On 08/12/2025 08:43, Vlastimil Babka wrote:
> On 12/5/25 17:58, Kalyazin, Nikita wrote:
>> +static int kvm_gmem_folio_zap_direct_map(struct folio *folio)
>> +{
>> +     int r = 0;
>> +     unsigned long addr = (unsigned long) folio_address(folio);
>> +     u64 gmem_flags = GMEM_I(folio_inode(folio))->flags;
>> +
>> +     if (kvm_gmem_folio_no_direct_map(folio) || !(gmem_flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP))
>> +             goto out;
>> +
>> +     r = set_direct_map_valid_noflush(folio_page(folio, 0), folio_nr_pages(folio),
>> +                                      false);
>> +
>> +     if (r)
>> +             goto out;
>> +
>> +     folio->private = (void *) KVM_GMEM_FOLIO_NO_DIRECT_MAP;
> 
> With Dave's suggestion on patch 1/13 to have folio_zap_direct_map(), setting
> this folio->private flag wouldn't be possible between the zap and tlb flush,
> but it's not an issue to set it before the zap, right?

I can't see an issue with that.  Did it in the v9.

> 
>> +     flush_tlb_kernel_range(addr, addr + folio_size(folio));
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
>> +      * happened in set_direct_map_invalid_noflush() in kvm_gmem_folio_zap_direct_map().
>> +      * Thus set_direct_map_valid_noflush() here only updates prot bits.
>> +      */
>> +     if (kvm_gmem_folio_no_direct_map(folio))
>> +             set_direct_map_valid_noflush(folio_page(folio, 0), folio_nr_pages(folio),
>> +                                      true);
> 
> I think you're missing here clearing KVM_GMEM_FOLIO_NO_DIRECT_MAP from
> folio->private, which means if there's another
> kvm_gmem_folio_zap_direct_map() call on it in the future, it will do nothing?

You're very right, thanks.  Fixed in the v9.

> 
>> +}
>> +
>>   static inline void kvm_gmem_mark_prepared(struct folio *folio)
>>   {
>>        folio_mark_uptodate(folio);
>> @@ -398,6 +444,7 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>>        struct inode *inode = file_inode(vmf->vma->vm_file);
>>        struct folio *folio;
>>        vm_fault_t ret = VM_FAULT_LOCKED;
>> +     int err;
>>
>>        if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
>>                return VM_FAULT_SIGBUS;
>> @@ -423,6 +470,12 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>>                kvm_gmem_mark_prepared(folio);
>>        }
>>
>> +     err = kvm_gmem_folio_zap_direct_map(folio);
>> +     if (err) {
>> +             ret = vmf_error(err);
>> +             goto out_folio;
>> +     }
>> +
>>        vmf->page = folio_file_page(folio, vmf->pgoff);
>>
>>   out_folio:
>> @@ -533,6 +586,8 @@ static void kvm_gmem_free_folio(struct folio *folio)
>>        kvm_pfn_t pfn = page_to_pfn(page);
>>        int order = folio_order(folio);
>>
>> +     kvm_gmem_folio_restore_direct_map(folio);
>> +
>>        kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
>>   }
>>
>> @@ -596,6 +651,9 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>>        /* Unmovable mappings are supposed to be marked unevictable as well. */
>>        WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>>
>> +     if (flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP)
>> +             mapping_set_no_direct_map(inode->i_mapping);
>> +
>>        GMEM_I(inode)->flags = flags;
>>
>>        file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR, &kvm_gmem_fops);
>> @@ -807,6 +865,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>>        if (!is_prepared)
>>                r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
>>
>> +     kvm_gmem_folio_zap_direct_map(folio);
>> +
>>        folio_unlock(folio);
>>
>>        if (!r)
> 


