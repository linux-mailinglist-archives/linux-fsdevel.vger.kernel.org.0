Return-Path: <linux-fsdevel+bounces-62209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FF8B8867B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 10:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355011C85DB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 08:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874392FD7A4;
	Fri, 19 Sep 2025 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="rY5hIkwm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.143.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E18C2E7162;
	Fri, 19 Sep 2025 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.178.143.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270351; cv=none; b=pzNCbm45+PrHHvXdCFLLFnGPBS+qiBHUKcDOEQNuJnhlke3Qr1m6yeDcHBp9xHWTBls9+7bQ/uIrRVmycRhlhzGG6rKI673ooJaeBxTy9l3ZSM0cpBP60cTmu2sTRkidQVWxqOg4SG8PeDg5TNpobns4eBLY7heLNMXDrBe5Ywg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270351; c=relaxed/simple;
	bh=BA/sRPI6jXhN56RrqZT1cQZlEyECp3Dmd4VItUSB6n0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YlXmsKi2K8wMgEtKqjoYjuwlSGCJhc/mShEkmF5a6OSYblZkECYpJXr9YgI8egJAnesCcrdNDA58cJ+Uy7zxHXeZLPQOjIDgGmS6+McQJQk1brOAPsFsk+Y1subXYk96ufxlldfhCQxiZ2dUHgx+V6pIiIrJu21i1r25vaafxj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=rY5hIkwm; arc=none smtp.client-ip=63.178.143.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1758270349; x=1789806349;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GFL7BzHqZtJ+hf0GoLUZhF6DxwKb7xJe9EgTIEodTbE=;
  b=rY5hIkwmnf28yDoZF+O4efBCPae4e34Ds0qa2E7C+9AHflfREUlaSuCa
   yQKaIGSUHPCrR9hYqSnr6CsUAwNmZ+UUn3lRZoSu54dSrsdd6/kOOz7FZ
   t3t12Xo7lKTDBPokRitIYYcXcmO8Uc8mrEc3W25R1sOYe8jKft1rU8+3b
   lwVPA0KDgXIDrPkUzId2mju68+9mYOwJ8OYoFZfwIQQmP5ZFMbqQoVa5X
   um/wc1fkX87nnCrX/Pw3S8u280AjfXxFq5uoHJayqfzsdgaKNiJI6jkRa
   qc3KSAIK4rGTNU+MGS/pUrG7T2tylJZUlHGPGn2b5CvwYVMMx92Zs3yuv
   w==;
X-CSE-ConnectionGUID: IsZxf8f8SjWiNUjgDVp6Og==
X-CSE-MsgGUID: xwNyaF2SS7eyXLTiQsdIFQ==
X-IronPort-AV: E=Sophos;i="6.18,277,1751241600"; 
   d="scan'208";a="2255186"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 08:25:37 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:22673]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.0.240:2525] with esmtp (Farcaster)
 id 99b608d7-c465-47ba-b3fb-c53cc7a3b236; Fri, 19 Sep 2025 08:25:37 +0000 (UTC)
X-Farcaster-Flow-ID: 99b608d7-c465-47ba-b3fb-c53cc7a3b236
Received: from EX19D015EUB003.ant.amazon.com (10.252.51.113) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 19 Sep 2025 08:25:36 +0000
Received: from EX19D015EUB004.ant.amazon.com (10.252.51.13) by
 EX19D015EUB003.ant.amazon.com (10.252.51.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 19 Sep 2025 08:25:36 +0000
Received: from EX19D015EUB004.ant.amazon.com ([fe80::2dc9:7aa9:9cd3:fc8a]) by
 EX19D015EUB004.ant.amazon.com ([fe80::2dc9:7aa9:9cd3:fc8a%3]) with mapi id
 15.02.2562.020; Fri, 19 Sep 2025 08:25:36 +0000
From: "Roy, Patrick" <roypat@amazon.co.uk>
To: "rppt@kernel.org" <rppt@kernel.org>
CC: "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "alex@ghiti.fr"
	<alex@ghiti.fr>, "andrii@kernel.org" <andrii@kernel.org>, "anna@kernel.org"
	<anna@kernel.org>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"ast@kernel.org" <ast@kernel.org>, "axelrasmussen@google.com"
	<axelrasmussen@google.com>, "borntraeger@linux.ibm.com"
	<borntraeger@linux.ibm.com>, "bp@alien8.de" <bp@alien8.de>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "brauner@kernel.org"
	<brauner@kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"david@redhat.com" <david@redhat.com>, "derekmn@amazon.co.uk"
	<derekmn@amazon.co.uk>, "devel@lists.orangefs.org"
	<devel@lists.orangefs.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
	"gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
	"gor@linux.ibm.com" <gor@linux.ibm.com>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "haoluo@google.com" <haoluo@google.com>,
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"hubcap@omnibond.com" <hubcap@omnibond.com>, "jack@suse.cz" <jack@suse.cz>,
	"Thomson, Jack" <jackabt@amazon.co.uk>, "jannh@google.com"
	<jannh@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "jhubbard@nvidia.com"
	<jhubbard@nvidia.com>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
	"kernel@xen0n.name" <kernel@xen0n.name>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "luto@kernel.org"
	<luto@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
	"martin@omnibond.com" <martin@omnibond.com>, "maz@kernel.org"
	<maz@kernel.org>, "mhocko@suse.com" <mhocko@suse.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"peterx@redhat.com" <peterx@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "pfalcato@suse.de" <pfalcato@suse.de>, "Roy, Patrick"
	<roypat@amazon.co.uk>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"seanjc@google.com" <seanjc@google.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "shuah@kernel.org" <shuah@kernel.org>,
	"song@kernel.org" <song@kernel.org>, "surenb@google.com" <surenb@google.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "svens@linux.ibm.com"
	<svens@linux.ibm.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"trondmy@kernel.org" <trondmy@kernel.org>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "weixugc@google.com"
	<weixugc@google.com>, "will@kernel.org" <will@kernel.org>,
	"willy@infradead.org" <willy@infradead.org>, "x86@kernel.org"
	<x86@kernel.org>, "Cali, Marco" <xmarcalx@amazon.co.uk>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, "yuanchu@google.com"
	<yuanchu@google.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v6 05/11] KVM: guest_memfd: Add flag to remove from direct
 map
Thread-Topic: [PATCH v6 05/11] KVM: guest_memfd: Add flag to remove from
 direct map
Thread-Index: AQHcKT757eD2hLtXdESX+jHFR62e2Q==
Date: Fri, 19 Sep 2025 08:25:36 +0000
Message-ID: <20250919082534.17376-1-roypat@amazon.co.uk>
References: <aMZyacbUEM7HErM1@kernel.org>
In-Reply-To: <aMZyacbUEM7HErM1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Mike,=0A=
=0A=
...=0A=
=0A=
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/=
kvm_host.h=0A=
>> index 2f2394cce24e..0bfd8e5fd9de 100644=0A=
>> --- a/arch/arm64/include/asm/kvm_host.h=0A=
>> +++ b/arch/arm64/include/asm/kvm_host.h=0A=
>> @@ -19,6 +19,7 @@=0A=
>>  #include <linux/maple_tree.h>=0A=
>>  #include <linux/percpu.h>=0A=
>>  #include <linux/psci.h>=0A=
>> +#include <linux/set_memory.h>=0A=
>>  #include <asm/arch_gicv3.h>=0A=
>>  #include <asm/barrier.h>=0A=
>>  #include <asm/cpufeature.h>=0A=
>> @@ -1706,5 +1707,16 @@ void compute_fgu(struct kvm *kvm, enum fgt_group_=
id fgt);=0A=
>>  void get_reg_fixed_bits(struct kvm *kvm, enum vcpu_sysreg reg, u64 *res=
0, u64 *res1);=0A=
>>  void check_feature_map(void);=0A=
>>=0A=
>> +#ifdef CONFIG_KVM_GUEST_MEMFD=0A=
>> +static inline bool kvm_arch_gmem_supports_no_direct_map(void)=0A=
>> +{=0A=
>> +     /*=0A=
>> +      * Without FWB, direct map access is needed in kvm_pgtable_stage2_=
map(),=0A=
>> +      * as it calls dcache_clean_inval_poc().=0A=
>> +      */=0A=
>> +     return can_set_direct_map() && cpus_have_final_cap(ARM64_HAS_STAGE=
2_FWB);=0A=
>> +}=0A=
>> +#define kvm_arch_gmem_supports_no_direct_map kvm_arch_gmem_supports_no_=
direct_map=0A=
>> +#endif /* CONFIG_KVM_GUEST_MEMFD */=0A=
>>=0A=
>>  #endif /* __ARM64_KVM_HOST_H__ */=0A=
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h=0A=
>> index 1d0585616aa3..a9468bce55f2 100644=0A=
>> --- a/include/linux/kvm_host.h=0A=
>> +++ b/include/linux/kvm_host.h=0A=
>> @@ -36,6 +36,7 @@=0A=
>>  #include <linux/rbtree.h>=0A=
>>  #include <linux/xarray.h>=0A=
>>  #include <asm/signal.h>=0A=
>> +#include <linux/set_memory.h>=0A=
> =0A=
> The set_memory APIs are not used in the header, no need to include it her=
e.=0A=
> =0A=
=0A=
Ack!=0A=
=0A=
>>  #include <linux/kvm.h>=0A=
>>  #include <linux/kvm_para.h>=0A=
>> @@ -731,6 +732,12 @@ static inline bool kvm_arch_has_private_mem(struct =
kvm *kvm)=0A=
>>  bool kvm_arch_supports_gmem_mmap(struct kvm *kvm);=0A=
>>  #endif=0A=
>>=0A=
>> +#ifdef CONFIG_KVM_GUEST_MEMFD=0A=
>> +#ifndef kvm_arch_gmem_supports_no_direct_map=0A=
>> +#define kvm_arch_gmem_supports_no_direct_map can_set_direct_map=0A=
>> +#endif=0A=
>> +#endif /* CONFIG_KVM_GUEST_MEMFD */=0A=
>> +=0A=
>>  #ifndef kvm_arch_has_readonly_mem=0A=
>>  static inline bool kvm_arch_has_readonly_mem(struct kvm *kvm)=0A=
>>  {=0A=
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h=0A=
>> index 6efa98a57ec1..33c8e8946019 100644=0A=
>> --- a/include/uapi/linux/kvm.h=0A=
>> +++ b/include/uapi/linux/kvm.h=0A=
>> @@ -963,6 +963,7 @@ struct kvm_enable_cap {=0A=
>>  #define KVM_CAP_RISCV_MP_STATE_RESET 242=0A=
>>  #define KVM_CAP_ARM_CACHEABLE_PFNMAP_SUPPORTED 243=0A=
>>  #define KVM_CAP_GUEST_MEMFD_MMAP 244=0A=
>> +#define KVM_CAP_GUEST_MEMFD_NO_DIRECT_MAP 245=0A=
>>=0A=
>>  struct kvm_irq_routing_irqchip {=0A=
>>       __u32 irqchip;=0A=
>> @@ -1600,6 +1601,7 @@ struct kvm_memory_attributes {=0A=
>>=0A=
>>  #define KVM_CREATE_GUEST_MEMFD       _IOWR(KVMIO,  0xd4, struct kvm_cre=
ate_guest_memfd)=0A=
>>  #define GUEST_MEMFD_FLAG_MMAP        (1ULL << 0)=0A=
>> +#define GUEST_MEMFD_FLAG_NO_DIRECT_MAP (1ULL << 1)=0A=
>>=0A=
>>  struct kvm_create_guest_memfd {=0A=
>>       __u64 size;=0A=
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c=0A=
>> index 81028984ff89..3c64099fc98a 100644=0A=
>> --- a/virt/kvm/guest_memfd.c=0A=
>> +++ b/virt/kvm/guest_memfd.c=0A=
>> @@ -4,6 +4,7 @@=0A=
>>  #include <linux/kvm_host.h>=0A=
>>  #include <linux/pagemap.h>=0A=
>>  #include <linux/anon_inodes.h>=0A=
>> +#include <linux/set_memory.h>=0A=
>>=0A=
>>  #include "kvm_mm.h"=0A=
>>=0A=
>> @@ -42,9 +43,24 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, =
struct kvm_memory_slot *slo=0A=
>>       return 0;=0A=
>>  }=0A=
>>=0A=
>> -static inline void kvm_gmem_mark_prepared(struct folio *folio)=0A=
>> +static bool kvm_gmem_test_no_direct_map(struct inode *inode)=0A=
>>  {=0A=
>> -     folio_mark_uptodate(folio);=0A=
>> +     return ((unsigned long) inode->i_private) & GUEST_MEMFD_FLAG_NO_DI=
RECT_MAP;=0A=
>> +}=0A=
>> +=0A=
>> +static inline int kvm_gmem_mark_prepared(struct folio *folio)=0A=
>> +{=0A=
>> +     struct inode *inode =3D folio_inode(folio);=0A=
>> +     int r =3D 0;=0A=
>> +=0A=
>> +     if (kvm_gmem_test_no_direct_map(inode))=0A=
>> +             r =3D set_direct_map_valid_noflush(folio_page(folio, 0), f=
olio_nr_pages(folio),=0A=
>> +                                              false);=0A=
>> +=0A=
>> +     if (!r)=0A=
>> +             folio_mark_uptodate(folio);=0A=
>> +=0A=
>> +     return r;=0A=
>>  }=0A=
>>=0A=
>>  /*=0A=
>> @@ -82,7 +98,7 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, str=
uct kvm_memory_slot *slot,=0A=
>>       index =3D ALIGN_DOWN(index, 1 << folio_order(folio));=0A=
>>       r =3D __kvm_gmem_prepare_folio(kvm, slot, index, folio);=0A=
>>       if (!r)=0A=
>> -             kvm_gmem_mark_prepared(folio);=0A=
>> +             r =3D kvm_gmem_mark_prepared(folio);=0A=
> =0A=
> If this fails, shouldn't we undo __kvm_gmem_prepare_folio()?=0A=
>=0A=
=0A=
Yes, good point. I'm not sure if we can undo preparation (its only used=0A=
by AMD-SEV right now, for passing off the page to the CoCo context). But=0A=
not undoing it means that guest_memfd will consider the page unprepared,=0A=
and zero it again the next time it's accesses, which will cause a=0A=
machine check because the page has already been passed off to the=0A=
confidential world.=0A=
=0A=
We talked about this in the guest_memfd upstream call yesterday, and=0A=
decided that in addition to this problem, we want to separate=0A=
preparedness tracking from direct map removal state tracking anyway (and=0A=
move preparedness tracking outside of guest_memfd into the arch specific=0A=
code). And if direct map state and preparedness are separate bits, then=0A=
we can accurately record the state of "preparation worked but direct map=0A=
removal failed".=0A=
=0A=
>>=0A=
>>       return r;=0A=
>>  }=0A=
>> @@ -344,8 +360,15 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struc=
t vm_fault *vmf)=0A=
>>       }=0A=
>>=0A=
>>       if (!folio_test_uptodate(folio)) {=0A=
>> +             int err =3D 0;=0A=
>> +=0A=
>>               clear_highpage(folio_page(folio, 0));=0A=
>> -             kvm_gmem_mark_prepared(folio);=0A=
>> +             err =3D kvm_gmem_mark_prepared(folio);=0A=
>> +=0A=
>> +             if (err) {=0A=
>> +                     ret =3D vmf_error(err);=0A=
>> +                     goto out_folio;=0A=
>> +             }=0A=
>>       }=0A=
>>=0A=
>>       vmf->page =3D folio_file_page(folio, vmf->pgoff);=0A=
>> @@ -436,6 +459,16 @@ static void kvm_gmem_free_folio(struct address_spac=
e *mapping,=0A=
>>       kvm_pfn_t pfn =3D page_to_pfn(page);=0A=
>>       int order =3D folio_order(folio);=0A=
>>=0A=
>> +     /*=0A=
>> +      * Direct map restoration cannot fail, as the only error condition=
=0A=
>> +      * for direct map manipulation is failure to allocate page tables=
=0A=
>> +      * when splitting huge pages, but this split would have already=0A=
>> +      * happened in set_direct_map_invalid_noflush() in kvm_gmem_mark_p=
repared().=0A=
>> +      * Thus set_direct_map_valid_noflush() here only updates prot bits=
.=0A=
>> +      */=0A=
>> +     if (kvm_gmem_test_no_direct_map(mapping->host))=0A=
>> +             set_direct_map_valid_noflush(page, folio_nr_pages(folio), =
true);=0A=
>> +=0A=
>>       kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));=0A=
>>  }=0A=
>>=0A=
>> @@ -500,6 +533,9 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t=
 size, u64 flags)=0A=
>>       /* Unmovable mappings are supposed to be marked unevictable as wel=
l. */=0A=
>>       WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));=0A=
>>=0A=
>> +     if (flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP)=0A=
>> +             mapping_set_no_direct_map(inode->i_mapping);=0A=
>> +=0A=
>>       kvm_get_kvm(kvm);=0A=
>>       gmem->kvm =3D kvm;=0A=
>>       xa_init(&gmem->bindings);=0A=
>> @@ -524,6 +560,9 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_crea=
te_guest_memfd *args)=0A=
>>       if (kvm_arch_supports_gmem_mmap(kvm))=0A=
>>               valid_flags |=3D GUEST_MEMFD_FLAG_MMAP;=0A=
>>=0A=
>> +     if (kvm_arch_gmem_supports_no_direct_map())=0A=
>> +             valid_flags |=3D GUEST_MEMFD_FLAG_NO_DIRECT_MAP;=0A=
>> +=0A=
>>       if (flags & ~valid_flags)=0A=
>>               return -EINVAL;=0A=
>>=0A=
>> @@ -768,7 +807,7 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_=
gfn, void __user *src, long=0A=
>>               p =3D src ? src + i * PAGE_SIZE : NULL;=0A=
>>               ret =3D post_populate(kvm, gfn, pfn, p, max_order, opaque)=
;=0A=
>>               if (!ret)=0A=
>> -                     kvm_gmem_mark_prepared(folio);=0A=
>> +                     ret =3D kvm_gmem_mark_prepared(folio);=0A=
>>=0A=
>>  put_folio_and_exit:=0A=
>>               folio_put(folio);=0A=
...=0A=
=0A=
>=0A=
> Sincerely yours,=0A=
> Mike.=0A=
Best, =0A=
Patrick=0A=
=0A=

