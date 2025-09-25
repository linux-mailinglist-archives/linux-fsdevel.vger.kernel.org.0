Return-Path: <linux-fsdevel+bounces-62775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC75BA0754
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 17:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB73C1BC7490
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 15:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156693043C8;
	Thu, 25 Sep 2025 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="nMRP0eTn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.57.120.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5263009E7;
	Thu, 25 Sep 2025 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.57.120.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815470; cv=none; b=k3cgL7xICyJ0Fx1koQvUJo69qZQ/e9Ex+3d/zJ8X/NkMwgoMPa6WTQnDPmvGCCk/IB0W/ZusmFt4ImGRE5aySJ5g56Z6gvpPm6PWJAvlIhhM0jDWI9SN1msOIICh9huoh/YD4ipi0ZKblmt2mlYPIazxatzEU+qkREacabTB368=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815470; c=relaxed/simple;
	bh=1zJrM66fVkwnfU3UUcGE70VbzHy7CLNUeSpYY+Xki2w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mrk/gkFTyH8bntvfoEvX1g20sv8dbD1HWURB84mYogFJ7ueBLKk9KOtXGE9A/+hhocfBIRu0uizRKso+fXocAlfNnDVp93Ubh7eEi7Q0QjKjvMDEiD2BBoDmSsxTWdjJJrHWoSXV92bjepb9YviaGEvK7z6WcOXF+qJ5xy4zsBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=nMRP0eTn; arc=none smtp.client-ip=52.57.120.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1758815468; x=1790351468;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WShG4YI0EGKByiTLIIIv3ML54YmgGR7q846KIAo0FmA=;
  b=nMRP0eTn4yjAeULMcJ/LseWpqFTFGyC0dxKGAfigGbkc336t72YRe7YG
   ouYk5hxZ4+AdEK9RmjoqQUp8vcaTokaj5zvpIVklugM2fVlVkowv6YkET
   Ju3JLRTPcQp/g3UOs/TJtv4LvEVY+Kui6/EigqpcCozKmXd1Dk9211LSG
   DyJALc5Rn3nQx/1Cy3k+9KUSV+ojuGz31m1GtsBVxQr3BLgbVyrzhr9w2
   0bf7m/XYtE98SOXAJb7kw3FyywCq1kuWpSztclT5gLwgr3Y+68jlZ/JLz
   4bLYWyfe+YYfGoIzb/PTnTL7qDEvS+YX/5gAFsXca6M3H9OEILbNE5982
   g==;
X-CSE-ConnectionGUID: MbVH1R0YThKQmA86zMa6Xg==
X-CSE-MsgGUID: 2fM976tAQQK5Fw3KY2GCFw==
X-IronPort-AV: E=Sophos;i="6.18,292,1751241600"; 
   d="scan'208";a="2580762"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 15:50:57 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:31648]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.9.61:2525] with esmtp (Farcaster)
 id 1b0aa563-dc9d-47cc-b8c8-5261ca8f0b3b; Thu, 25 Sep 2025 15:50:57 +0000 (UTC)
X-Farcaster-Flow-ID: 1b0aa563-dc9d-47cc-b8c8-5261ca8f0b3b
Received: from EX19D015EUB001.ant.amazon.com (10.252.51.114) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 25 Sep 2025 15:50:54 +0000
Received: from EX19D015EUB004.ant.amazon.com (10.252.51.13) by
 EX19D015EUB001.ant.amazon.com (10.252.51.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 25 Sep 2025 15:50:53 +0000
Received: from EX19D015EUB004.ant.amazon.com ([fe80::2dc9:7aa9:9cd3:fc8a]) by
 EX19D015EUB004.ant.amazon.com ([fe80::2dc9:7aa9:9cd3:fc8a%3]) with mapi id
 15.02.2562.020; Thu, 25 Sep 2025 15:50:53 +0000
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
Subject: Re: [PATCH v7 06/12] KVM: guest_memfd: add module param for disabling
 TLB flushing
Thread-Topic: [PATCH v7 06/12] KVM: guest_memfd: add module param for
 disabling TLB flushing
Thread-Index: AQHcLjQso34Q5KN2CUWRdaSrXlVTqQ==
Date: Thu, 25 Sep 2025 15:50:53 +0000
Message-ID: <20250925155051.2959-1-roypat@amazon.co.uk>
References: <cf57bdec-6a2d-4d6a-b27c-991a7e2833ab@redhat.com>
In-Reply-To: <cf57bdec-6a2d-4d6a-b27c-991a7e2833ab@redhat.com>
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

On Thu, 2025-09-25 at 12:02 +0100, David Hildenbrand wrote:=0A=
> On 24.09.25 17:22, Roy, Patrick wrote:=0A=
>> Add an option to not perform TLB flushes after direct map manipulations.=
=0A=
>> TLB flushes result in a up to 40x elongation of page faults in=0A=
>> guest_memfd (scaling with the number of CPU cores), or a 5x elongation=
=0A=
>> of memory population, which is inacceptable when wanting to use direct=
=0A=
>> map removed guest_memfd as a drop-in replacement for existing workloads.=
=0A=
>>=0A=
>> TLB flushes are not needed for functional correctness (the virt->phys=0A=
>> mapping technically stays "correct", the kernel should simply not use it=
=0A=
>> for a while), so we can skip them to keep performance in-line with=0A=
>> "traditional" VMs.=0A=
>>=0A=
>> Enabling this option means that the desired protection from=0A=
>> Spectre-style attacks is not perfect, as an attacker could try to=0A=
>> prevent a stale TLB entry from getting evicted, keeping it alive until=
=0A=
>> the page it refers to is used by the guest for some sensitive data, and=
=0A=
>> then targeting it using a spectre-gadget.=0A=
>>=0A=
>> Cc: Will Deacon <will@kernel.org>=0A=
>> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>=0A=
>> ---=0A=
>>   include/linux/kvm_host.h | 1 +=0A=
>>   virt/kvm/guest_memfd.c   | 3 ++-=0A=
>>   virt/kvm/kvm_main.c      | 3 +++=0A=
>>   3 files changed, 6 insertions(+), 1 deletion(-)=0A=
>>=0A=
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h=0A=
>> index 73a15cade54a..4d2bc18860fc 100644=0A=
>> --- a/include/linux/kvm_host.h=0A=
>> +++ b/include/linux/kvm_host.h=0A=
>> @@ -2298,6 +2298,7 @@ extern unsigned int halt_poll_ns;=0A=
>>   extern unsigned int halt_poll_ns_grow;=0A=
>>   extern unsigned int halt_poll_ns_grow_start;=0A=
>>   extern unsigned int halt_poll_ns_shrink;=0A=
>> +extern bool guest_memfd_tlb_flush;=0A=
>>=0A=
>>   struct kvm_device {=0A=
>>       const struct kvm_device_ops *ops;=0A=
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c=0A=
>> index b7129c4868c5..d8dd24459f0d 100644=0A=
>> --- a/virt/kvm/guest_memfd.c=0A=
>> +++ b/virt/kvm/guest_memfd.c=0A=
>> @@ -63,7 +63,8 @@ static int kvm_gmem_folio_zap_direct_map(struct folio =
*folio)=0A=
>>       if (!r) {=0A=
>>               unsigned long addr =3D (unsigned long) folio_address(folio=
);=0A=
>>               folio->private =3D (void *) ((u64) folio->private & KVM_GM=
EM_FOLIO_NO_DIRECT_MAP);=0A=
>> -             flush_tlb_kernel_range(addr, addr + folio_size(folio));=0A=
>> +             if (guest_memfd_tlb_flush)=0A=
>> +                     flush_tlb_kernel_range(addr, addr + folio_size(fol=
io));=0A=
>>       }=0A=
>>=0A=
>>       return r;=0A=
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c=0A=
>> index b5e702d95230..753c06ebba7f 100644=0A=
>> --- a/virt/kvm/kvm_main.c=0A=
>> +++ b/virt/kvm/kvm_main.c=0A=
>> @@ -95,6 +95,9 @@ unsigned int halt_poll_ns_shrink =3D 2;=0A=
>>   module_param(halt_poll_ns_shrink, uint, 0644);=0A=
>>   EXPORT_SYMBOL_GPL(halt_poll_ns_shrink);=0A=
>>=0A=
>> +bool guest_memfd_tlb_flush =3D true;=0A=
>> +module_param(guest_memfd_tlb_flush, bool, 0444);=0A=
> =0A=
> The parameter name is a bit too generic. I think you somehow have to=0A=
> incorporate the "direct_map" aspects.=0A=
=0A=
Fair :)=0A=
=0A=
> Also, I wonder if this could be a capability per vm/guest_memfd?=0A=
=0A=
I don't really have any opinions on how to expose this knob, but I=0A=
thought capabilities should be additive? (e.g. we only have=0A=
KVM_ENABLE_EXTENSION(), and then having a capability with a negative=0A=
polarity "enable to _not_ do TLB flushes" is a bit weird in my head).=0A=
Then again, if people are fine having TLB flushes be opt-in instead of=0A=
opt-out (Will's comment on v6 makes me believe that the opt-out itself=0A=
might already be controversial for arm64), a capability would work.=0A=
=0A=
> Then, you could also nicely document the semantics, considerations,=0A=
> impact etc :)=0A=
=0A=
Yup, I got so lost in trying to figure out why flush_kernel_tlb_range()=0A=
didnt refused to let itself be exported that docs slipped my mind haha.=0A=
=0A=
> -- =0A=
> Cheers=0A=
> =0A=
> David / dhildenb=0A=
> =0A=
=0A=
Best,=0A=
Patrick=0A=
=0A=

