Return-Path: <linux-fsdevel+bounces-62776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ED2BA0763
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 17:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35AA51BC7468
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 15:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A052E303C9D;
	Thu, 25 Sep 2025 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="NMUIlpSl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.199.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE7123AB88;
	Thu, 25 Sep 2025 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.199.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815575; cv=none; b=hlRvdT3e7thIQ8XbIG/Y9CpyGBmir4tAtQvtvRlYdizJoXj4SUal54QcJl9UlpYS+7yUrGIjarkwDp23G0xgXqk7rWeoHhV0kiz6UVQjhN6fz7XHlW6/sbPVS30qOzNEc8faU7W3y8wZl7t2LiArJKlvV3giljK3TyfPMJOM9NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815575; c=relaxed/simple;
	bh=2TAjmZaAIvi9DI3JD03cvuKot3FRH0FCMdbbgOACimM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JqxdYnMhS8w6sjl71arvTwx4QQNgIRTLdU98oILh1wOSgLL4Snt9n6ms4PaTvRAONnhidMOtjlR0UmnDFz4NESkH0W8XGAbdozD1MxEf8JygQeyTR1VZXh8dF0lWioGvy9ERKhs7qXOwXgqz5+c2z/aljPOhb3edFekSq2dH/Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=NMUIlpSl; arc=none smtp.client-ip=18.199.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1758815570; x=1790351570;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kwxqujKfVX1CSobodtD5HVau+5WHKxoOA6khVCxNfp8=;
  b=NMUIlpSl7aBJNBKBlkAAj7D1H+pATVLBv8QkERkZUtFf59RcGAa0T92X
   HPXkEl+GXXhoSUO8lDtlCykloeETTT+mn/bpaSJbI+tOuD/SAtOhNGyhi
   J9Lmh4D2THcL8KWMV2J4Ar37ST6tMxuWhmZzAF64932+lpjpS7nkmjxeS
   NhbV9dTM3TbrRCbnEufe9tALci4BOWepXYlTOtVj9pNyST/u213ynKWqn
   DJJp+sVY5IgnKG/VYPjKOmUOiaXzJMmwZ52xokTVvHQG0p1nGn7CdSIqJ
   tU/XO9zrwUb72ARBCGICaJZkH5WIltT9uDKwQ9k0PGlu3S09H/qLrkc4T
   Q==;
X-CSE-ConnectionGUID: /O8OxHnoQkmuS/AWA1cfuA==
X-CSE-MsgGUID: iu1nvwylR82uSGgARl0ONw==
X-IronPort-AV: E=Sophos;i="6.18,292,1751241600"; 
   d="scan'208";a="2575800"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 15:52:39 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:4142]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.27.71:2525] with esmtp (Farcaster)
 id 6322f349-efea-4d97-832e-47b9c4870506; Thu, 25 Sep 2025 15:52:39 +0000 (UTC)
X-Farcaster-Flow-ID: 6322f349-efea-4d97-832e-47b9c4870506
Received: from EX19D015EUB002.ant.amazon.com (10.252.51.123) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 25 Sep 2025 15:52:39 +0000
Received: from EX19D015EUB004.ant.amazon.com (10.252.51.13) by
 EX19D015EUB002.ant.amazon.com (10.252.51.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 25 Sep 2025 15:52:38 +0000
Received: from EX19D015EUB004.ant.amazon.com ([fe80::2dc9:7aa9:9cd3:fc8a]) by
 EX19D015EUB004.ant.amazon.com ([fe80::2dc9:7aa9:9cd3:fc8a%3]) with mapi id
 15.02.2562.020; Thu, 25 Sep 2025 15:52:38 +0000
From: "Roy, Patrick" <roypat@amazon.co.uk>
To: "david@redhat.com" <david@redhat.com>
CC: "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "andrii@kernel.org"
	<andrii@kernel.org>, "ast@kernel.org" <ast@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"derekmn@amazon.co.uk" <derekmn@amazon.co.uk>, "eddyz87@gmail.com"
	<eddyz87@gmail.com>, "haoluo@google.com" <haoluo@google.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "Thomson, Jack" <jackabt@amazon.co.uk>, "jannh@google.com"
	<jannh@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "jhubbard@nvidia.com"
	<jhubbard@nvidia.com>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "luto@kernel.org"
	<luto@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
	"maz@kernel.org" <maz@kernel.org>, "mhocko@suse.com" <mhocko@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "oliver.upton@linux.dev"
	<oliver.upton@linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"peterx@redhat.com" <peterx@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "pfalcato@suse.de" <pfalcato@suse.de>, "Roy, Patrick"
	<roypat@amazon.co.uk>, "rppt@kernel.org" <rppt@kernel.org>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "seanjc@google.com" <seanjc@google.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "song@kernel.org" <song@kernel.org>,
	"surenb@google.com" <surenb@google.com>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "tabba@google.com" <tabba@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"will@kernel.org" <will@kernel.org>, "willy@infradead.org"
	<willy@infradead.org>, "x86@kernel.org" <x86@kernel.org>, "Cali, Marco"
	<xmarcalx@amazon.co.uk>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>
Subject: Re: [PATCH v7 05/12] KVM: guest_memfd: Add flag to remove from direct
 map
Thread-Topic: [PATCH v7 05/12] KVM: guest_memfd: Add flag to remove from
 direct map
Thread-Index: AQHcLjRqhXkfFn7Ge0Cy7L6etQubDw==
Date: Thu, 25 Sep 2025 15:52:38 +0000
Message-ID: <20250925155237.3928-1-roypat@amazon.co.uk>
References: <a02996f3-fdf4-4b5f-85b6-d79b948b3237@redhat.com>
In-Reply-To: <a02996f3-fdf4-4b5f-85b6-d79b948b3237@redhat.com>
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

On Thu, 2025-09-25 at 12:00 +0100, David Hildenbrand wrote:=0A=
> On 24.09.25 17:22, Roy, Patrick wrote:=0A=
>> Add GUEST_MEMFD_FLAG_NO_DIRECT_MAP flag for KVM_CREATE_GUEST_MEMFD()=0A=
>> ioctl. When set, guest_memfd folios will be removed from the direct map=
=0A=
>> after preparation, with direct map entries only restored when the folios=
=0A=
>> are freed.=0A=
>>=0A=
>> To ensure these folios do not end up in places where the kernel cannot=
=0A=
>> deal with them, set AS_NO_DIRECT_MAP on the guest_memfd's struct=0A=
>> address_space if GUEST_MEMFD_FLAG_NO_DIRECT_MAP is requested.=0A=
>>=0A=
>> Add KVM_CAP_GUEST_MEMFD_NO_DIRECT_MAP to let userspace discover whether=
=0A=
>> guest_memfd supports GUEST_MEMFD_FLAG_NO_DIRECT_MAP. Support depends on=
=0A=
>> guest_memfd itself being supported, but also on whether linux supports=
=0A=
>> manipulatomg the direct map at page granularity at all (possible most of=
=0A=
>> the time, outliers being arm64 where its impossible if the direct map=0A=
>> has been setup using hugepages, as arm64 cannot break these apart due to=
=0A=
>> break-before-make semantics, and powerpc, which does not select=0A=
>> ARCH_HAS_SET_DIRECT_MAP, though also doesn't support guest_memfd=0A=
>> anyway).=0A=
>>=0A=
>> Note that this flag causes removal of direct map entries for all=0A=
>> guest_memfd folios independent of whether they are "shared" or "private"=
=0A=
>> (although current guest_memfd only supports either all folios in the=0A=
>> "shared" state, or all folios in the "private" state if=0A=
>> GUEST_MEMFD_FLAG_MMAP is not set). The usecase for removing direct map=
=0A=
>> entries of also the shared parts of guest_memfd are a special type of=0A=
>> non-CoCo VM where, host userspace is trusted to have access to all of=0A=
>> guest memory, but where Spectre-style transient execution attacks=0A=
>> through the host kernel's direct map should still be mitigated.  In this=
=0A=
>> setup, KVM retains access to guest memory via userspace mappings of=0A=
>> guest_memfd, which are reflected back into KVM's memslots via=0A=
>> userspace_addr. This is needed for things like MMIO emulation on x86_64=
=0A=
>> to work.=0A=
>>=0A=
>> Direct map entries are zapped right before guest or userspace mappings=
=0A=
>> of gmem folios are set up, e.g. in kvm_gmem_fault_user_mapping() or=0A=
>> kvm_gmem_get_pfn() [called from the KVM MMU code]. The only place where=
=0A=
>> a gmem folio can be allocated without being mapped anywhere is=0A=
>> kvm_gmem_populate(), where handling potential failures of direct map=0A=
>> removal is not possible (by the time direct map removal is attempted,=0A=
>> the folio is already marked as prepared, meaning attempting to re-try=0A=
>> kvm_gmem_populate() would just result in -EEXIST without fixing up the=
=0A=
>> direct map state). These folios are then removed form the direct map=0A=
>> upon kvm_gmem_get_pfn(), e.g. when they are mapped into the guest later.=
=0A=
>>=0A=
>> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>=0A=
>> ---=0A=
>>   Documentation/virt/kvm/api.rst    |  5 +++=0A=
>>   arch/arm64/include/asm/kvm_host.h | 12 ++++++=0A=
>>   include/linux/kvm_host.h          |  6 +++=0A=
>>   include/uapi/linux/kvm.h          |  2 +=0A=
>>   virt/kvm/guest_memfd.c            | 61 ++++++++++++++++++++++++++++++-=
=0A=
>>   virt/kvm/kvm_main.c               |  5 +++=0A=
>>   6 files changed, 90 insertions(+), 1 deletion(-)=0A=
>>=0A=
>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api=
.rst=0A=
>> index c17a87a0a5ac..b52c14d58798 100644=0A=
>> --- a/Documentation/virt/kvm/api.rst=0A=
>> +++ b/Documentation/virt/kvm/api.rst=0A=
>> @@ -6418,6 +6418,11 @@ When the capability KVM_CAP_GUEST_MEMFD_MMAP is s=
upported, the 'flags' field=0A=
>>   supports GUEST_MEMFD_FLAG_MMAP.  Setting this flag on guest_memfd crea=
tion=0A=
>>   enables mmap() and faulting of guest_memfd memory to host userspace.=
=0A=
>>=0A=
>> +When the capability KVM_CAP_GMEM_NO_DIRECT_MAP is supported, the 'flags=
' field=0A=
>> +supports GUEST_MEMFG_FLAG_NO_DIRECT_MAP. Setting this flag makes the gu=
est_memfd=0A=
>> +instance behave similarly to memfd_secret, and unmaps the memory backin=
g it from=0A=
>> +the kernel's address space after allocation.=0A=
>> +=0A=
> =0A=
> Do we want to document what the implication of that is? Meaning,=0A=
> limitations etc. I recall that we would need the user mapping for gmem=0A=
> slots to be properly set up.=0A=
> =0A=
> Is that still the case in this patch set?=0A=
=0A=
The ->userspace_addr thing is the general requirement for non-CoCo VMs,=0A=
and not specific for direct map removal (e.g. I expect direct map=0A=
removal to just work out of the box for CoCo setups, where KVM already=0A=
cannot access guest memory, ignoring the question of whether direct map=0A=
removal is even useful for CoCo VMs). So I don't think it should be=0A=
documented as part of=0A=
KVM_CAP_GMEM_NO_DIRECT_MAP/GUEST_MEMFG_FLAG_NO_DIRECT_MAP (heh, there's=0A=
a typo I just noticed. "MEMFG". Also "GMEM" needs to be "GUEST_MEMFD".=0A=
Will fix that), but rather as part of GUEST_MEMFD_FLAG_MMAP. I can add a=0A=
patch it there (or maybe send it separately, since FLAG_MMAP is already=0A=
in -next?).=0A=
=0A=
>>   When the KVM MMU performs a PFN lookup to service a guest fault and th=
e backing=0A=
>>   guest_memfd has the GUEST_MEMFD_FLAG_MMAP set, then the fault will alw=
ays be=0A=
>>   consumed from guest_memfd, regardless of whether it is a shared or a p=
rivate=0A=
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/=
kvm_host.h=0A=
>> index 2f2394cce24e..0bfd8e5fd9de 100644=0A=
>> --- a/arch/arm64/include/asm/kvm_host.h=0A=
>> +++ b/arch/arm64/include/asm/kvm_host.h=0A=
>> @@ -19,6 +19,7 @@=0A=
>>   #include <linux/maple_tree.h>=0A=
>>   #include <linux/percpu.h>=0A=
>>   #include <linux/psci.h>=0A=
>> +#include <linux/set_memory.h>=0A=
>>   #include <asm/arch_gicv3.h>=0A=
>>   #include <asm/barrier.h>=0A=
>>   #include <asm/cpufeature.h>=0A=
>> @@ -1706,5 +1707,16 @@ void compute_fgu(struct kvm *kvm, enum fgt_group_=
id fgt);=0A=
>>   void get_reg_fixed_bits(struct kvm *kvm, enum vcpu_sysreg reg, u64 *re=
s0, u64 *res1);=0A=
>>   void check_feature_map(void);=0A=
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
> =0A=
> I strongly assume that the aarch64 support should be moved to a separate=
=0A=
> patch -- if possible, see below.=0A=
> =0A=
>>   #endif /* __ARM64_KVM_HOST_H__ */=0A=
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h=0A=
>> index 1d0585616aa3..73a15cade54a 100644=0A=
>> --- a/include/linux/kvm_host.h=0A=
>> +++ b/include/linux/kvm_host.h=0A=
>> @@ -731,6 +731,12 @@ static inline bool kvm_arch_has_private_mem(struct =
kvm *kvm)=0A=
>>   bool kvm_arch_supports_gmem_mmap(struct kvm *kvm);=0A=
>>   #endif=0A=
>>=0A=
>> +#ifdef CONFIG_KVM_GUEST_MEMFD=0A=
>> +#ifndef kvm_arch_gmem_supports_no_direct_map=0A=
>> +#define kvm_arch_gmem_supports_no_direct_map can_set_direct_map=0A=
>> +#endif=0A=
> =0A=
> Hm, wouldn't it be better to have an opt-in per arch, and really only=0A=
> unlock the ones we know work (tested etc), explicitly in separate patches=
.=0A=
> =0A=
=0A=
Ack, can definitely do that. Something like =0A=
=0A=
#ifndef kvm_arch_gmem_supports_no_direct_map=0A=
static inline bool kvm_arch_gmem_supports_no_direct_map()=0A=
{=0A=
	return false;=0A=
}=0A=
#endif=0A=
=0A=
and then actual definitions (in separate patches) in the arm64 and x86=0A=
headers?=0A=
=0A=
On a related note, maybe PATCH 2 should only export=0A=
set_direct_map_valid_noflush() for the architectures on which we=0A=
actually need it? Which would only be x86, since arm64 doesnt allow=0A=
building KVM as a module, and nothing else supports guest_memfd right=0A=
now.=0A=
=0A=
> [...]=0A=
> =0A=
>>=0A=
>>   #include "kvm_mm.h"=0A=
>>=0A=
>> @@ -42,6 +45,44 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, =
struct kvm_memory_slot *slo=0A=
>>       return 0;=0A=
>>   }=0A=
>>=0A=
>> +#define KVM_GMEM_FOLIO_NO_DIRECT_MAP BIT(0)=0A=
>> +=0A=
>> +static bool kvm_gmem_folio_no_direct_map(struct folio *folio)=0A=
>> +{=0A=
>> +     return ((u64) folio->private) & KVM_GMEM_FOLIO_NO_DIRECT_MAP;=0A=
>> +}=0A=
>> +=0A=
>> +static int kvm_gmem_folio_zap_direct_map(struct folio *folio)=0A=
>> +{=0A=
>> +     if (kvm_gmem_folio_no_direct_map(folio))=0A=
>> +             return 0;=0A=
>> +=0A=
>> +     int r =3D set_direct_map_valid_noflush(folio_page(folio, 0), folio=
_nr_pages(folio),=0A=
>> +                                      false);=0A=
>> +=0A=
>> +     if (!r) {=0A=
>> +             unsigned long addr =3D (unsigned long) folio_address(folio=
);=0A=
> =0A=
> empty line missing.=0A=
> =0A=
=0A=
Ack=0A=
=0A=
>> +             folio->private =3D (void *) ((u64) folio->private & KVM_GM=
EM_FOLIO_NO_DIRECT_MAP);=0A=
>> +             flush_tlb_kernel_range(addr, addr + folio_size(folio));=0A=
>> +     }=0A=
>> +=0A=
>> +     return r;=0A=
>> +}=0A=
>> +=0A=
>> +static void kvm_gmem_folio_restore_direct_map(struct folio *folio)=0A=
>> +{=0A=
>> +     /*=0A=
>> +      * Direct map restoration cannot fail, as the only error condition=
=0A=
>> +      * for direct map manipulation is failure to allocate page tables=
=0A=
>> +      * when splitting huge pages, but this split would have already=0A=
>> +      * happened in set_direct_map_invalid_noflush() in kvm_gmem_folio_=
zap_direct_map().=0A=
>> +      * Thus set_direct_map_valid_noflush() here only updates prot bits=
.=0A=
>> +      */=0A=
>> +     if (kvm_gmem_folio_no_direct_map(folio))=0A=
>> +             set_direct_map_valid_noflush(folio_page(folio, 0), folio_n=
r_pages(folio),=0A=
>> +                                      true);=0A=
>> +}=0A=
>> +=0A=
>>   static inline void kvm_gmem_mark_prepared(struct folio *folio)=0A=
>>   {=0A=
>>       folio_mark_uptodate(folio);=0A=
>> @@ -324,13 +365,14 @@ static vm_fault_t kvm_gmem_fault_user_mapping(stru=
ct vm_fault *vmf)=0A=
>>       struct inode *inode =3D file_inode(vmf->vma->vm_file);=0A=
>>       struct folio *folio;=0A=
>>       vm_fault_t ret =3D VM_FAULT_LOCKED;=0A=
>> +     int err;=0A=
>>=0A=
>>       if (((loff_t)vmf->pgoff << PAGE_SHIFT) >=3D i_size_read(inode))=0A=
>>               return VM_FAULT_SIGBUS;=0A=
>>=0A=
>>       folio =3D kvm_gmem_get_folio(inode, vmf->pgoff);=0A=
>>       if (IS_ERR(folio)) {=0A=
>> -             int err =3D PTR_ERR(folio);=0A=
>> +             err =3D PTR_ERR(folio);=0A=
>>=0A=
>>               if (err =3D=3D -EAGAIN)=0A=
>>                       return VM_FAULT_RETRY;=0A=
>> @@ -348,6 +390,13 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struc=
t vm_fault *vmf)=0A=
>>               kvm_gmem_mark_prepared(folio);=0A=
>>       }=0A=
>>=0A=
>> +     err =3D kvm_gmem_folio_zap_direct_map(folio);=0A=
>> +=0A=
> =0A=
> I'd drop this empty line here.=0A=
>=0A=
=0A=
Ack=0A=
=0A=
>> +     if (err) {=0A=
>> +             ret =3D vmf_error(err);=0A=
>> +             goto out_folio;=0A=
>> +     }=0A=
>> +=0A=
>>       vmf->page =3D folio_file_page(folio, vmf->pgoff);=0A=
>>=0A=
>>   out_folio:=0A=
>> @@ -435,6 +484,8 @@ static void kvm_gmem_free_folio(struct folio *folio)=
=0A=
>>       kvm_pfn_t pfn =3D page_to_pfn(page);=0A=
>>       int order =3D folio_order(folio);=0A=
>>=0A=
>> +     kvm_gmem_folio_restore_direct_map(folio);=0A=
>> +=0A=
>>       kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));=0A=
>>   }=0A=
>>=0A=
>> @@ -499,6 +550,9 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t=
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
>> @@ -523,6 +577,9 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_crea=
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
>> @@ -687,6 +744,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_mem=
ory_slot *slot,=0A=
>>       if (!is_prepared)=0A=
>>               r =3D kvm_gmem_prepare_folio(kvm, slot, gfn, folio);=0A=
>>=0A=
>> +     kvm_gmem_folio_zap_direct_map(folio);=0A=
>> +=0A=
>>       folio_unlock(folio);=0A=
>>=0A=
>>       if (!r)=0A=
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c=0A=
>> index 18f29ef93543..b5e702d95230 100644=0A=
>> --- a/virt/kvm/kvm_main.c=0A=
>> +++ b/virt/kvm/kvm_main.c=0A=
>> @@ -65,6 +65,7 @@=0A=
>>   #include <trace/events/kvm.h>=0A=
>>=0A=
>>   #include <linux/kvm_dirty_ring.h>=0A=
>> +#include <linux/set_memory.h>=0A=
> =0A=
> Likely not required here.=0A=
> =0A=
=0A=
Seems for now it is because of how=0A=
kvm_arch_gmem_supports_no_direct_map() is defined, but I suspect the=0A=
need will disappear once that is changed as you suggested above :)=0A=
=0A=
> -- =0A=
> Cheers=0A=
> =0A=
> David / dhildenb=0A=
=0A=
Best,=0A=
Patrick=0A=
=0A=
=0A=

