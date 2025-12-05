Return-Path: <linux-fsdevel+bounces-70835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1392DCA88C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 18:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E56F31A10BF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 17:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7303734846E;
	Fri,  5 Dec 2025 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="rO75HUE1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.75.33.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B1A13A258;
	Fri,  5 Dec 2025 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.75.33.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764953989; cv=none; b=LRM/Q5R4AkKuuVT3ZLuFTgjx9Y/cZllhuR3o6nmg9tXqESGWmuYspxtxYoVLQDEbN+V97l1YM3JHB2WzvXFp+nSIzXxXV22KWFNnfEVea4ogVrh7f9V4jVPJtLdZdwhZlNj6xb2pdQ1MqefiRZnsoyKQtZgQu5ESIYQKQi/RdfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764953989; c=relaxed/simple;
	bh=dn3h+9x0Guls9b+4MTJSqmKY7y8139bpAHZnXTB1xhQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t4eJyzy1OmZsZ2gSEG7SDxTj0hm/7p+REHrudM7UQ8uJI66l9yeWMnSiq/K6qAHPeJKAnOM2VAto90ivOf80RJYahCZ+A9/lV+e0YVOrBGpJbIypSeskupdOuYFLAKF/6vsdrgXzbWwxB8z5Fn0bvZx2XBEGRoTKjPL0jU3ALpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=rO75HUE1; arc=none smtp.client-ip=3.75.33.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1764953985; x=1796489985;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DAa+s0ltL2AWBGJLNkppOiWQM65ZNjJ1swchhaZKNTI=;
  b=rO75HUE1uvjdWcLqeVGeaDlu7Tp4gPVGLvCoHmzmey8vsX2xoNGTb8jF
   WwZeuu6mvS5Opb3BzxS9wHc4xqal6O8INo5/lwHNc+s+LIOT33Mwes6QW
   kV/Hng6Sxb698OLB9jFiOjZ/0sIoHZFsDpI+E7g+R6h/mX6VPstWSIpBQ
   hWUpPxxHxKspJwAvdIvAxKLaI0K3jO8H4jXFmpBpzYSZ5b71TCxM1QQuf
   QogXPLLWp7G9/bhKej2fuzzSSUyJJXEEkhr05RufX/e3mraPNbWCBjdqK
   V9/VIDh+2UdT4DgBJE65A0K7JzlozYiHxK5TmjInkAkHIqIcwcq1/LFL9
   g==;
X-CSE-ConnectionGUID: q0GqOJJ7TEuIVrXmD2UySw==
X-CSE-MsgGUID: W7Hjf9rtRji/ZjNjf2UQHw==
X-IronPort-AV: E=Sophos;i="6.20,252,1758585600"; 
   d="scan'208";a="6301667"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 16:58:09 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:3739]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.37.108:2525] with esmtp (Farcaster)
 id 30a38f77-2a8d-47e1-ad78-b78782ea5839; Fri, 5 Dec 2025 16:58:09 +0000 (UTC)
X-Farcaster-Flow-ID: 30a38f77-2a8d-47e1-ad78-b78782ea5839
Received: from EX19D005EUB004.ant.amazon.com (10.252.51.126) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 5 Dec 2025 16:58:09 +0000
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19D005EUB004.ant.amazon.com (10.252.51.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 5 Dec 2025 16:58:08 +0000
Received: from EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c]) by
 EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c%3]) with mapi id
 15.02.2562.029; Fri, 5 Dec 2025 16:58:08 +0000
From: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
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
	"riel@surriel.com" <riel@surriel.com>, "baohua@kernel.org"
	<baohua@kernel.org>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"jgross@suse.com" <jgross@suse.com>, "yu-cheng.yu@intel.com"
	<yu-cheng.yu@intel.com>, "kas@kernel.org" <kas@kernel.org>, "coxu@redhat.com"
	<coxu@redhat.com>, "kevin.brodsky@arm.com" <kevin.brodsky@arm.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "maobibo@loongson.cn"
	<maobibo@loongson.cn>, "prsampat@amd.com" <prsampat@amd.com>,
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, "isaku.yamahata@intel.com"
	<isaku.yamahata@intel.com>, "jmattson@google.com" <jmattson@google.com>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "vannapurve@google.com"
	<vannapurve@google.com>, "jackmanb@google.com" <jackmanb@google.com>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, "patrick.roy@linux.dev"
	<patrick.roy@linux.dev>, "Thomson, Jack" <jackabt@amazon.co.uk>, "Itazuri,
 Takahiro" <itazur@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>,
	"Cali, Marco" <xmarcalx@amazon.co.uk>, "Kalyazin, Nikita"
	<kalyazin@amazon.co.uk>
Subject: [PATCH v8 02/13] x86/tlb: export flush_tlb_kernel_range to KVM module
Thread-Topic: [PATCH v8 02/13] x86/tlb: export flush_tlb_kernel_range to KVM
 module
Thread-Index: AQHcZghUt46N9MNDx0Sv0bdQIhD0sg==
Date: Fri, 5 Dec 2025 16:58:08 +0000
Message-ID: <20251205165743.9341-3-kalyazin@amazon.com>
References: <20251205165743.9341-1-kalyazin@amazon.com>
In-Reply-To: <20251205165743.9341-1-kalyazin@amazon.com>
Accept-Language: en-GB, en-US
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

From: Patrick Roy <patrick.roy@linux.dev>=0A=
=0A=
After direct map removal, a TLB flush must be done to ensure that the=0A=
just-unmapped memory cannot be accessed through stale TLB entries.=0A=
=0A=
This export is only needed on x86, as arm64 (the only other architecture=0A=
supporting guest_memfd currently) does not allow building KVM as a=0A=
module.=0A=
=0A=
Cc: Thomas Gleixner <tglx@linutronix.de>=0A=
Signed-off-by: Patrick Roy <patrick.roy@linux.dev>=0A=
Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>=0A=
---=0A=
 arch/x86/include/asm/tlbflush.h | 3 ++-=0A=
 arch/x86/mm/tlb.c               | 1 +=0A=
 2 files changed, 3 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflus=
h.h=0A=
index 00daedfefc1b..6f57f7eb621b 100644=0A=
--- a/arch/x86/include/asm/tlbflush.h=0A=
+++ b/arch/x86/include/asm/tlbflush.h=0A=
@@ -317,7 +317,6 @@ extern void flush_tlb_all(void);=0A=
 extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,=
=0A=
 				unsigned long end, unsigned int stride_shift,=0A=
 				bool freed_tables);=0A=
-extern void flush_tlb_kernel_range(unsigned long start, unsigned long end)=
;=0A=
 =0A=
 static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned lon=
g a)=0A=
 {=0A=
@@ -483,6 +482,8 @@ static inline void cpu_tlbstate_update_lam(unsigned lon=
g lam, u64 untag_mask)=0A=
 #endif=0A=
 #endif /* !MODULE */=0A=
 =0A=
+extern void flush_tlb_kernel_range(unsigned long start, unsigned long end)=
;=0A=
+=0A=
 static inline void __native_tlb_flush_global(unsigned long cr4)=0A=
 {=0A=
 	native_write_cr4(cr4 ^ X86_CR4_PGE);=0A=
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c=0A=
index 5d221709353e..cce591d26e4c 100644=0A=
--- a/arch/x86/mm/tlb.c=0A=
+++ b/arch/x86/mm/tlb.c=0A=
@@ -1561,6 +1561,7 @@ void flush_tlb_kernel_range(unsigned long start, unsi=
gned long end)=0A=
 =0A=
 	put_flush_tlb_info();=0A=
 }=0A=
+EXPORT_SYMBOL_FOR_MODULES(flush_tlb_kernel_range, "kvm");=0A=
 =0A=
 /*=0A=
  * This can be used from process context to figure out what the value of=
=0A=
-- =0A=
2.50.1=0A=
=0A=

