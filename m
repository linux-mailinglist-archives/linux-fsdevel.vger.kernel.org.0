Return-Path: <linux-fsdevel+bounces-62591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A52B9A965
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 17:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95584A43A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 15:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88175312812;
	Wed, 24 Sep 2025 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="ZcJb+VMm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.176.194.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B9A31194F;
	Wed, 24 Sep 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.176.194.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727374; cv=none; b=p5RbVec1hESrR/LOk7ELP3Yd907EIpMAq/3vBo5/OFbUMZ+qWeK2Gqqn/KJ2fNgzatpNHdGlClomo2y0IuYNrHp99Z0rYEMbyvvD43c0sc9DqV+asj6ixHkkO+bnoPayuS71+vzCZ6HAASrfzjlEss9cRfQkVZDBR03YKTqJ3uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727374; c=relaxed/simple;
	bh=j22RUUgQ3dehYErKSiF6JM6yJfkDF60o5gLTOIY36tM=;
	h=From:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bkolcSLFONNlJJEptWj/WqTxSPY79c+0XNRamTtZ4g9wFy5wGfdRazrNou23dGml69sGZcAN58NpYHFZbKu7/T/gHxvGe28ZPuVuER80nL6IWJPcmGBxlH2RLqKtJbBReQtSWxnCIPnhbuadEGbANQapYYrq5mRIGsqnmt8PZCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=ZcJb+VMm; arc=none smtp.client-ip=63.176.194.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1758727372; x=1790263372;
  h=from:cc:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=aZ6aEnN0octnczQEslBC0QJ/62FEQzxTaKcHv32i784=;
  b=ZcJb+VMmy9M0y0nPTwQmcgUASC/u2etpP6Wfpk+r16YgGADu7unZt7XA
   yKs8vojoow30QcfbDRydz47CTCxY0H/fNNiMsveWK+FkJYlITdErjWdVv
   8bDithxmp3w2efV++83leNcihrr4yKVq4vf5tDtv7c7ZBatu8BEMbAR+b
   nuHSyz+xZcqMUSO4nFXGu1AWOouTA2RHYeMFiRxTBUHULXQEvf+z6PEGn
   Vnx8GywAPIdrhYuETR+rXS4s2gOtONtTT/kU/kRhPsp4AQM/fg9Gjb1Uu
   PR6tvPa0Ng3N3GrWrPtCSt/2C0pPZF94M96wlgG/XGSuJS1DA1gYV/MU9
   Q==;
X-CSE-ConnectionGUID: pQcceaiESDSH7bC1cpsqVQ==
X-CSE-MsgGUID: hlpCS6KaT2KSYTE87OW0dQ==
X-IronPort-AV: E=Sophos;i="6.18,290,1751241600"; 
   d="scan'208";a="2618190"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 15:22:42 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.226:30326]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.10.226:2525] with esmtp (Farcaster)
 id 81816518-f8e5-42a3-83ec-e3c3c2235bb6; Wed, 24 Sep 2025 15:22:41 +0000 (UTC)
X-Farcaster-Flow-ID: 81816518-f8e5-42a3-83ec-e3c3c2235bb6
Received: from EX19D015EUB001.ant.amazon.com (10.252.51.114) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 24 Sep 2025 15:22:41 +0000
Received: from EX19D015EUB004.ant.amazon.com (10.252.51.13) by
 EX19D015EUB001.ant.amazon.com (10.252.51.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 24 Sep 2025 15:22:40 +0000
Received: from EX19D015EUB004.ant.amazon.com ([fe80::2dc9:7aa9:9cd3:fc8a]) by
 EX19D015EUB004.ant.amazon.com ([fe80::2dc9:7aa9:9cd3:fc8a%3]) with mapi id
 15.02.2562.020; Wed, 24 Sep 2025 15:22:40 +0000
From: "Roy, Patrick" <roypat@amazon.co.uk>
CC: "Roy, Patrick" <roypat@amazon.co.uk>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, "maz@kernel.org"
	<maz@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org"
	<luto@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"willy@infradead.org" <willy@infradead.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "david@redhat.com" <david@redhat.com>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com"
	<surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, "song@kernel.org"
	<song@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"haoluo@google.com" <haoluo@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jannh@google.com" <jannh@google.com>,
	"pfalcato@suse.de" <pfalcato@suse.de>, "shuah@kernel.org" <shuah@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Cali,
 Marco" <xmarcalx@amazon.co.uk>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
	"Thomson, Jack" <jackabt@amazon.co.uk>, "derekmn@amazon.co.uk"
	<derekmn@amazon.co.uk>, "tabba@google.com" <tabba@google.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>
Subject: [PATCH v7 06/12] KVM: guest_memfd: add module param for disabling TLB
 flushing
Thread-Topic: [PATCH v7 06/12] KVM: guest_memfd: add module param for
 disabling TLB flushing
Thread-Index: AQHcLWcRbocNw3xUv0GREpQeD3nXQA==
Date: Wed, 24 Sep 2025 15:22:40 +0000
Message-ID: <20250924152214.7292-3-roypat@amazon.co.uk>
References: <20250924151101.2225820-4-patrick.roy@campus.lmu.de>
 <20250924152214.7292-1-roypat@amazon.co.uk>
In-Reply-To: <20250924152214.7292-1-roypat@amazon.co.uk>
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

Add an option to not perform TLB flushes after direct map manipulations.=0A=
TLB flushes result in a up to 40x elongation of page faults in=0A=
guest_memfd (scaling with the number of CPU cores), or a 5x elongation=0A=
of memory population, which is inacceptable when wanting to use direct=0A=
map removed guest_memfd as a drop-in replacement for existing workloads.=0A=
=0A=
TLB flushes are not needed for functional correctness (the virt->phys=0A=
mapping technically stays "correct", the kernel should simply not use it=0A=
for a while), so we can skip them to keep performance in-line with=0A=
"traditional" VMs.=0A=
=0A=
Enabling this option means that the desired protection from=0A=
Spectre-style attacks is not perfect, as an attacker could try to=0A=
prevent a stale TLB entry from getting evicted, keeping it alive until=0A=
the page it refers to is used by the guest for some sensitive data, and=0A=
then targeting it using a spectre-gadget.=0A=
=0A=
Cc: Will Deacon <will@kernel.org>=0A=
Signed-off-by: Patrick Roy <roypat@amazon.co.uk>=0A=
---=0A=
 include/linux/kvm_host.h | 1 +=0A=
 virt/kvm/guest_memfd.c   | 3 ++-=0A=
 virt/kvm/kvm_main.c      | 3 +++=0A=
 3 files changed, 6 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h=0A=
index 73a15cade54a..4d2bc18860fc 100644=0A=
--- a/include/linux/kvm_host.h=0A=
+++ b/include/linux/kvm_host.h=0A=
@@ -2298,6 +2298,7 @@ extern unsigned int halt_poll_ns;=0A=
 extern unsigned int halt_poll_ns_grow;=0A=
 extern unsigned int halt_poll_ns_grow_start;=0A=
 extern unsigned int halt_poll_ns_shrink;=0A=
+extern bool guest_memfd_tlb_flush;=0A=
 =0A=
 struct kvm_device {=0A=
 	const struct kvm_device_ops *ops;=0A=
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c=0A=
index b7129c4868c5..d8dd24459f0d 100644=0A=
--- a/virt/kvm/guest_memfd.c=0A=
+++ b/virt/kvm/guest_memfd.c=0A=
@@ -63,7 +63,8 @@ static int kvm_gmem_folio_zap_direct_map(struct folio *fo=
lio)=0A=
 	if (!r) {=0A=
 		unsigned long addr =3D (unsigned long) folio_address(folio);=0A=
 		folio->private =3D (void *) ((u64) folio->private & KVM_GMEM_FOLIO_NO_DI=
RECT_MAP);=0A=
-		flush_tlb_kernel_range(addr, addr + folio_size(folio));=0A=
+		if (guest_memfd_tlb_flush)=0A=
+			flush_tlb_kernel_range(addr, addr + folio_size(folio));=0A=
 	}=0A=
 =0A=
 	return r;=0A=
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c=0A=
index b5e702d95230..753c06ebba7f 100644=0A=
--- a/virt/kvm/kvm_main.c=0A=
+++ b/virt/kvm/kvm_main.c=0A=
@@ -95,6 +95,9 @@ unsigned int halt_poll_ns_shrink =3D 2;=0A=
 module_param(halt_poll_ns_shrink, uint, 0644);=0A=
 EXPORT_SYMBOL_GPL(halt_poll_ns_shrink);=0A=
 =0A=
+bool guest_memfd_tlb_flush =3D true;=0A=
+module_param(guest_memfd_tlb_flush, bool, 0444);=0A=
+=0A=
 /*=0A=
  * Allow direct access (from KVM or the CPU) without MMU notifier protecti=
on=0A=
  * to unpinned pages.=0A=
-- =0A=
2.51.0=0A=
=0A=

