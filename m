Return-Path: <linux-fsdevel+bounces-62211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D9023B8875B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 10:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BED4C4E2AD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 08:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5956B306D50;
	Fri, 19 Sep 2025 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="F6UzpxkY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.74.81.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ECE2F360B;
	Fri, 19 Sep 2025 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.74.81.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758271484; cv=none; b=mjimR8IzZ9pU1KrLZJJQYHdjeYIp+dj16UOBCQP5iQto1iqFZPstBozEEpD3PsyN+oxhQIfDVk7DqoIftAaGD8yiX26vz2uuhQcSN549RXx461YfTsB/f2U9iAQGF3NtmttpfmpND+dLExB71As1wTK25Ib4vbckTOGXErXieqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758271484; c=relaxed/simple;
	bh=CzNa5ax+6SWZph/acveGblbyXULOKX6jSGgNsw+V/Ms=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kspkxfmq4QreMWvQh84XqpzcaYh7kyh/iCQjpC4QW9oKkH/lCiUHAM6k3ih6z83m0ii+nNnwm2beClu/HkpPbJcmawFmHzg3Yrf8vG/Sev6xcViL02qnLf1cG2L/1PFeLiY8MCTdAwKJgaqzhZ6bja9WMl2d61uRGQYcifKs77k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=F6UzpxkY; arc=none smtp.client-ip=3.74.81.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1758271482; x=1789807482;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FDaXBfPtB1+IZ028q3Oc9ecT9TZeV+KPQRYxRClbnDE=;
  b=F6UzpxkYmkafc6vytc4qUnhMio6/9aip4r6FbDznCQ3X5z3GL+s8AH16
   xz0x7DgzBllz6HG0D6WFj8wwbybIHzgbjlFkoDcO6vDx5Ne+xiv+TUp/b
   blsQfm+5xjgqNRY1QPL5hPt5gtD2vdWMfjAP8l2a2dVPavoy0mRA6KQBV
   MzexNU1oOPuL57R/LRCKSWWpgbGtUoC0IkOLmo5E/RVXGxu2Gsmuq2FMf
   RmRIeSBGGlYRu5Pr0gL8XMgLaBp+YHopKbtZC7tdjIzgfFDPuLmpB1dLB
   CJcuSTpKn4oD7TzhT3oiNAmzEmliG3WcpAtjf4uwSCAQyv0A64H6i8k2C
   Q==;
X-CSE-ConnectionGUID: mbWG6VQ7RoqqzIWbzp0AjA==
X-CSE-MsgGUID: vpo8mYMDQZK9UPEfdukZNw==
X-IronPort-AV: E=Sophos;i="6.18,277,1751241600"; 
   d="scan'208";a="2360353"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 08:44:31 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.234:18849]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.1.3:2525] with esmtp (Farcaster)
 id 2446a584-4a1c-4985-9be9-b5a1e9401e86; Fri, 19 Sep 2025 08:44:30 +0000 (UTC)
X-Farcaster-Flow-ID: 2446a584-4a1c-4985-9be9-b5a1e9401e86
Received: from EX19D015EUB002.ant.amazon.com (10.252.51.123) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 19 Sep 2025 08:44:27 +0000
Received: from EX19D015EUB004.ant.amazon.com (10.252.51.13) by
 EX19D015EUB002.ant.amazon.com (10.252.51.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 19 Sep 2025 08:44:27 +0000
Received: from EX19D015EUB004.ant.amazon.com ([fe80::2dc9:7aa9:9cd3:fc8a]) by
 EX19D015EUB004.ant.amazon.com ([fe80::2dc9:7aa9:9cd3:fc8a%3]) with mapi id
 15.02.2562.020; Fri, 19 Sep 2025 08:44:27 +0000
From: "Roy, Patrick" <roypat@amazon.co.uk>
To: "will@kernel.org" <will@kernel.org>
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
	<roypat@amazon.co.uk>, "rppt@kernel.org" <rppt@kernel.org>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "seanjc@google.com" <seanjc@google.com>,
	"shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, "shuah@kernel.org"
	<shuah@kernel.org>, "song@kernel.org" <song@kernel.org>, "surenb@google.com"
	<surenb@google.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"svens@linux.ibm.com" <svens@linux.ibm.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "trondmy@kernel.org" <trondmy@kernel.org>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "weixugc@google.com" <weixugc@google.com>,
	"willy@infradead.org" <willy@infradead.org>, "x86@kernel.org"
	<x86@kernel.org>, "Cali, Marco" <xmarcalx@amazon.co.uk>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, "yuanchu@google.com"
	<yuanchu@google.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v6 05/11] KVM: guest_memfd: Add flag to remove from direct
 map
Thread-Topic: [PATCH v6 05/11] KVM: guest_memfd: Add flag to remove from
 direct map
Thread-Index: AQHcKUGbESLQYfpS9EGxnIIHED72/Q==
Date: Fri, 19 Sep 2025 08:44:27 +0000
Message-ID: <20250919084425.30632-1-roypat@amazon.co.uk>
References: <aMxpvI6Aj8mDsRNm@willie-the-truck>
In-Reply-To: <aMxpvI6Aj8mDsRNm@willie-the-truck>
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

Hi Will,=0A=
=0A=
On Thu, 2025-09-18 at 21:21 +0100, Will Deacon wrote:=0A=
> Hi Patrick,=0A=
> We chatted briefly at KVM Forum, so I wanted to chime in here too from=0A=
> the arm64 side.=0A=
> =0A=
> On Fri, Sep 12, 2025 at 09:17:37AM +0000, Roy, Patrick wrote:=0A=
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
>> ARCH_HAS_SET_DIRECT_MAP, which also doesn't support guest_memfd anyway=
=0A=
>> though).=0A=
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
>> Do not perform TLB flushes after direct map manipulations. This is=0A=
>> because TLB flushes resulted in a up to 40x elongation of page faults in=
=0A=
>> guest_memfd (scaling with the number of CPU cores), or a 5x elongation=
=0A=
>> of memory population. TLB flushes are not needed for functional=0A=
>> correctness (the virt->phys mapping technically stays "correct",  the=0A=
>> kernel should simply not use it for a while). On the other hand, it mean=
s=0A=
>> that the desired protection from Spectre-style attacks is not perfect,=
=0A=
>> as an attacker could try to prevent a stale TLB entry from getting=0A=
>> evicted, keeping it alive until the page it refers to is used by the=0A=
>> guest for some sensitive data, and then targeting it using a=0A=
>> spectre-gadget.=0A=
> =0A=
> I'm really not keen on this last part (at least, for arm64).=0A=
> =0A=
> If you're not going to bother invalidating the TLB after unmapping from=
=0A=
> the direct map because of performance reasons, you're better off just=0A=
> leaving the direct map intact and getting even better performance. On=0A=
> arm64, that would mean you could use block mappings too.=0A=
=0A=
Not until we have hardware with the newest BBM goodies I thought. When I=0A=
checked earlier this year, a defconfig has the direct map setup at 4k=0A=
granularity.=0A=
=0A=
> On the other hand, if you actually care about the security properties=0A=
> from the unmap then you need the invalidation so that the mapping=0A=
> doesn't linger around. With "modern" CPU features such as pte=0A=
> aggregation and shared TLB walk caches it's not unlikely that these=0A=
> entries will persist a lot longer than you think and it makes the=0A=
> security benefits of this series impossible to reason about.=0A=
=0A=
I agree it's not 100% protection, but it is still better than the status qu=
o. I=0A=
would also love to have the TLB flushes, but sadly the performance impact o=
f=0A=
them would make this completely unusable for Amazon :/=0A=
=0A=
Mh, thinking about it now though, iirc the performance problems were mostly=
=0A=
because all CPUs needed to acknowledge the flush before the issuing CPU cou=
ld=0A=
continue. Is there a way to have "fire and forget" flushes, where we don't =
wait=0A=
for acknowledgements?=0A=
=0A=
> As a compromise, could we make the TLB invalidation an architecture=0A=
> opt-in so that we can have it enabled on arm64, please?=0A=
=0A=
How about instead of an architecture opt-in, we have some sort of opt-out f=
lag=0A=
userspace can set? Similar to the PFNMAP stuff KVM already has.=0A=
=0A=
> Will=0A=
=0A=
Best,=0A=
Patrick=0A=

