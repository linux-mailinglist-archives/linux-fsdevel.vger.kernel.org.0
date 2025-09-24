Return-Path: <linux-fsdevel+bounces-62590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2111EB9A953
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 17:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06744A5415
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 15:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D1D311C24;
	Wed, 24 Sep 2025 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="soPxQotH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.74.81.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7C630FC08;
	Wed, 24 Sep 2025 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.74.81.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727373; cv=none; b=vCWxhhaC8c/N0wmCqBswOCdmVXtWbU6U3TI8WwsZBN6GMLE3M0rpKVhLeV26sGXRU4ApjWPU54E/z4D3WJMZ99RZKWm2m3fR83fjbQ2AzZzvVsaYUr/aJa0q9sR/aOoDO7ijueYyvJCasdKIraFEfau+7u1Kjg1Jf44kpGIhvKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727373; c=relaxed/simple;
	bh=5wi6oWJcaZacIdGuqs8+4JnehYv5K/YtCnMQJkPvAy8=;
	h=From:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tKdNFmR7oeMfUGqyE2sPVQcX8nF+ENOAlaW84wIAg8r/m/4gVFwxXGlNUerrDEH10Y8AiZZYC1JFidblHQ+/asg8w/ZR3OlQvb+DzdwtkWVZgb5aac8cylbSo1G97fD2mS8ioUTYr9aNp8WJJ1/ohq0p6W+KmxDsdAFCBGCbx8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=soPxQotH; arc=none smtp.client-ip=3.74.81.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1758727371; x=1790263371;
  h=from:cc:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=pV0ItvY0hWll18OUGTIIe4Ubw7ats5CZ0DOzdEQeTOk=;
  b=soPxQotHll6/PrbrNiNtegXph8nsdkSKFhtd5nI8+LW/vnb1T5qMvuFB
   AlvZBa5yyMyKakYMB8lyallTDxOXhNrvWlzrN9wO5Q3E9nLYr/U4+Qwwi
   0ZqG7iSzyHTw3WqYf5G903snnlAQpF5bDAIQOqUffVof8hwSFJLIs3Yf/
   EGMq91B6B4s837hAEyIDrXnVZ6WatLFDatiN0+6mehUPcu76pC6ym0KiQ
   ZhVQOqqd3dTcx0EwQb4Bf6u3LAFx42aD7aVicw3boCeci+1LQ1F0p8CvY
   mN2Ckinq8DUV/9XAEf7Pbz10hb4bgQriKJpewL8B4ZLQNvT68RvyyGrq9
   Q==;
X-CSE-ConnectionGUID: s3BkeWEkRo2EDpOnnS/WuQ==
X-CSE-MsgGUID: dG6RbGblS/CzWUKebAgDpQ==
X-IronPort-AV: E=Sophos;i="6.18,290,1751241600"; 
   d="scan'208";a="2618267"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 15:22:40 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:15622]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.33.43:2525] with esmtp (Farcaster)
 id a43211cf-8cf7-4647-8a0c-093b80639d44; Wed, 24 Sep 2025 15:22:39 +0000 (UTC)
X-Farcaster-Flow-ID: a43211cf-8cf7-4647-8a0c-093b80639d44
Received: from EX19D015EUB003.ant.amazon.com (10.252.51.113) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 24 Sep 2025 15:22:39 +0000
Received: from EX19D015EUB004.ant.amazon.com (10.252.51.13) by
 EX19D015EUB003.ant.amazon.com (10.252.51.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 24 Sep 2025 15:22:39 +0000
Received: from EX19D015EUB004.ant.amazon.com ([fe80::2dc9:7aa9:9cd3:fc8a]) by
 EX19D015EUB004.ant.amazon.com ([fe80::2dc9:7aa9:9cd3:fc8a%3]) with mapi id
 15.02.2562.020; Wed, 24 Sep 2025 15:22:39 +0000
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
Subject: [PATCH v7 05/12] KVM: guest_memfd: Add flag to remove from direct map
Thread-Topic: [PATCH v7 05/12] KVM: guest_memfd: Add flag to remove from
 direct map
Thread-Index: AQHcLWcQtdvVokkndkuNN5YMX6g9SQ==
Date: Wed, 24 Sep 2025 15:22:39 +0000
Message-ID: <20250924152214.7292-2-roypat@amazon.co.uk>
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

Add GUEST_MEMFD_FLAG_NO_DIRECT_MAP flag for KVM_CREATE_GUEST_MEMFD()=0A=
ioctl. When set, guest_memfd folios will be removed from the direct map=0A=
after preparation, with direct map entries only restored when the folios=0A=
are freed.=0A=
=0A=
To ensure these folios do not end up in places where the kernel cannot=0A=
deal with them, set AS_NO_DIRECT_MAP on the guest_memfd's struct=0A=
address_space if GUEST_MEMFD_FLAG_NO_DIRECT_MAP is requested.=0A=
=0A=
Add KVM_CAP_GUEST_MEMFD_NO_DIRECT_MAP to let userspace discover whether=0A=
guest_memfd supports GUEST_MEMFD_FLAG_NO_DIRECT_MAP. Support depends on=0A=
guest_memfd itself being supported, but also on whether linux supports=0A=
manipulatomg the direct map at page granularity at all (possible most of=0A=
the time, outliers being arm64 where its impossible if the direct map=0A=
has been setup using hugepages, as arm64 cannot break these apart due to=0A=
break-before-make semantics, and powerpc, which does not select=0A=
ARCH_HAS_SET_DIRECT_MAP, though also doesn't support guest_memfd=0A=
anyway).=0A=
=0A=
Note that this flag causes removal of direct map entries for all=0A=
guest_memfd folios independent of whether they are "shared" or "private"=0A=
(although current guest_memfd only supports either all folios in the=0A=
"shared" state, or all folios in the "private" state if=0A=
GUEST_MEMFD_FLAG_MMAP is not set). The usecase for removing direct map=0A=
entries of also the shared parts of guest_memfd are a special type of=0A=
non-CoCo VM where, host userspace is trusted to have access to all of=0A=
guest memory, but where Spectre-style transient execution attacks=0A=
through the host kernel's direct map should still be mitigated.  In this=0A=
setup, KVM retains access to guest memory via userspace mappings of=0A=
guest_memfd, which are reflected back into KVM's memslots via=0A=
userspace_addr. This is needed for things like MMIO emulation on x86_64=0A=
to work.=0A=
=0A=
Direct map entries are zapped right before guest or userspace mappings=0A=
of gmem folios are set up, e.g. in kvm_gmem_fault_user_mapping() or=0A=
kvm_gmem_get_pfn() [called from the KVM MMU code]. The only place where=0A=
a gmem folio can be allocated without being mapped anywhere is=0A=
kvm_gmem_populate(), where handling potential failures of direct map=0A=
removal is not possible (by the time direct map removal is attempted,=0A=
the folio is already marked as prepared, meaning attempting to re-try=0A=
kvm_gmem_populate() would just result in -EEXIST without fixing up the=0A=
direct map state). These folios are then removed form the direct map=0A=
upon kvm_gmem_get_pfn(), e.g. when they are mapped into the guest later.=0A=
=0A=
Signed-off-by: Patrick Roy <roypat@amazon.co.uk>=0A=
---=0A=
 Documentation/virt/kvm/api.rst    |  5 +++=0A=
 arch/arm64/include/asm/kvm_host.h | 12 ++++++=0A=
 include/linux/kvm_host.h          |  6 +++=0A=
 include/uapi/linux/kvm.h          |  2 +=0A=
 virt/kvm/guest_memfd.c            | 61 ++++++++++++++++++++++++++++++-=0A=
 virt/kvm/kvm_main.c               |  5 +++=0A=
 6 files changed, 90 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rs=
t=0A=
index c17a87a0a5ac..b52c14d58798 100644=0A=
--- a/Documentation/virt/kvm/api.rst=0A=
+++ b/Documentation/virt/kvm/api.rst=0A=
@@ -6418,6 +6418,11 @@ When the capability KVM_CAP_GUEST_MEMFD_MMAP is supp=
orted, the 'flags' field=0A=
 supports GUEST_MEMFD_FLAG_MMAP.  Setting this flag on guest_memfd creation=
=0A=
 enables mmap() and faulting of guest_memfd memory to host userspace.=0A=
 =0A=
+When the capability KVM_CAP_GMEM_NO_DIRECT_MAP is supported, the 'flags' f=
ield=0A=
+supports GUEST_MEMFG_FLAG_NO_DIRECT_MAP. Setting this flag makes the guest=
_memfd=0A=
+instance behave similarly to memfd_secret, and unmaps the memory backing i=
t from=0A=
+the kernel's address space after allocation.=0A=
+=0A=
 When the KVM MMU performs a PFN lookup to service a guest fault and the ba=
cking=0A=
 guest_memfd has the GUEST_MEMFD_FLAG_MMAP set, then the fault will always =
be=0A=
 consumed from guest_memfd, regardless of whether it is a shared or a priva=
te=0A=
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm=
_host.h=0A=
index 2f2394cce24e..0bfd8e5fd9de 100644=0A=
--- a/arch/arm64/include/asm/kvm_host.h=0A=
+++ b/arch/arm64/include/asm/kvm_host.h=0A=
@@ -19,6 +19,7 @@=0A=
 #include <linux/maple_tree.h>=0A=
 #include <linux/percpu.h>=0A=
 #include <linux/psci.h>=0A=
+#include <linux/set_memory.h>=0A=
 #include <asm/arch_gicv3.h>=0A=
 #include <asm/barrier.h>=0A=
 #include <asm/cpufeature.h>=0A=
@@ -1706,5 +1707,16 @@ void compute_fgu(struct kvm *kvm, enum fgt_group_id =
fgt);=0A=
 void get_reg_fixed_bits(struct kvm *kvm, enum vcpu_sysreg reg, u64 *res0, =
u64 *res1);=0A=
 void check_feature_map(void);=0A=
 =0A=
+#ifdef CONFIG_KVM_GUEST_MEMFD=0A=
+static inline bool kvm_arch_gmem_supports_no_direct_map(void)=0A=
+{=0A=
+	/*=0A=
+	 * Without FWB, direct map access is needed in kvm_pgtable_stage2_map(),=
=0A=
+	 * as it calls dcache_clean_inval_poc().=0A=
+	 */=0A=
+	return can_set_direct_map() && cpus_have_final_cap(ARM64_HAS_STAGE2_FWB);=
=0A=
+}=0A=
+#define kvm_arch_gmem_supports_no_direct_map kvm_arch_gmem_supports_no_dir=
ect_map=0A=
+#endif /* CONFIG_KVM_GUEST_MEMFD */=0A=
 =0A=
 #endif /* __ARM64_KVM_HOST_H__ */=0A=
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h=0A=
index 1d0585616aa3..73a15cade54a 100644=0A=
--- a/include/linux/kvm_host.h=0A=
+++ b/include/linux/kvm_host.h=0A=
@@ -731,6 +731,12 @@ static inline bool kvm_arch_has_private_mem(struct kvm=
 *kvm)=0A=
 bool kvm_arch_supports_gmem_mmap(struct kvm *kvm);=0A=
 #endif=0A=
 =0A=
+#ifdef CONFIG_KVM_GUEST_MEMFD=0A=
+#ifndef kvm_arch_gmem_supports_no_direct_map=0A=
+#define kvm_arch_gmem_supports_no_direct_map can_set_direct_map=0A=
+#endif=0A=
+#endif /* CONFIG_KVM_GUEST_MEMFD */=0A=
+=0A=
 #ifndef kvm_arch_has_readonly_mem=0A=
 static inline bool kvm_arch_has_readonly_mem(struct kvm *kvm)=0A=
 {=0A=
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h=0A=
index 6efa98a57ec1..33c8e8946019 100644=0A=
--- a/include/uapi/linux/kvm.h=0A=
+++ b/include/uapi/linux/kvm.h=0A=
@@ -963,6 +963,7 @@ struct kvm_enable_cap {=0A=
 #define KVM_CAP_RISCV_MP_STATE_RESET 242=0A=
 #define KVM_CAP_ARM_CACHEABLE_PFNMAP_SUPPORTED 243=0A=
 #define KVM_CAP_GUEST_MEMFD_MMAP 244=0A=
+#define KVM_CAP_GUEST_MEMFD_NO_DIRECT_MAP 245=0A=
 =0A=
 struct kvm_irq_routing_irqchip {=0A=
 	__u32 irqchip;=0A=
@@ -1600,6 +1601,7 @@ struct kvm_memory_attributes {=0A=
 =0A=
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest=
_memfd)=0A=
 #define GUEST_MEMFD_FLAG_MMAP	(1ULL << 0)=0A=
+#define GUEST_MEMFD_FLAG_NO_DIRECT_MAP (1ULL << 1)=0A=
 =0A=
 struct kvm_create_guest_memfd {=0A=
 	__u64 size;=0A=
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c=0A=
index 55b8d739779f..b7129c4868c5 100644=0A=
--- a/virt/kvm/guest_memfd.c=0A=
+++ b/virt/kvm/guest_memfd.c=0A=
@@ -4,6 +4,9 @@=0A=
 #include <linux/kvm_host.h>=0A=
 #include <linux/pagemap.h>=0A=
 #include <linux/anon_inodes.h>=0A=
+#include <linux/set_memory.h>=0A=
+=0A=
+#include <asm/tlbflush.h>=0A=
 =0A=
 #include "kvm_mm.h"=0A=
 =0A=
@@ -42,6 +45,44 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, str=
uct kvm_memory_slot *slo=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+#define KVM_GMEM_FOLIO_NO_DIRECT_MAP BIT(0)=0A=
+=0A=
+static bool kvm_gmem_folio_no_direct_map(struct folio *folio)=0A=
+{=0A=
+	return ((u64) folio->private) & KVM_GMEM_FOLIO_NO_DIRECT_MAP;=0A=
+}=0A=
+=0A=
+static int kvm_gmem_folio_zap_direct_map(struct folio *folio)=0A=
+{=0A=
+	if (kvm_gmem_folio_no_direct_map(folio))=0A=
+		return 0;=0A=
+=0A=
+	int r =3D set_direct_map_valid_noflush(folio_page(folio, 0), folio_nr_pag=
es(folio),=0A=
+					 false);=0A=
+=0A=
+	if (!r) {=0A=
+		unsigned long addr =3D (unsigned long) folio_address(folio);=0A=
+		folio->private =3D (void *) ((u64) folio->private & KVM_GMEM_FOLIO_NO_DI=
RECT_MAP);=0A=
+		flush_tlb_kernel_range(addr, addr + folio_size(folio));=0A=
+	}=0A=
+=0A=
+	return r;=0A=
+}=0A=
+=0A=
+static void kvm_gmem_folio_restore_direct_map(struct folio *folio)=0A=
+{=0A=
+	/*=0A=
+	 * Direct map restoration cannot fail, as the only error condition=0A=
+	 * for direct map manipulation is failure to allocate page tables=0A=
+	 * when splitting huge pages, but this split would have already=0A=
+	 * happened in set_direct_map_invalid_noflush() in kvm_gmem_folio_zap_dir=
ect_map().=0A=
+	 * Thus set_direct_map_valid_noflush() here only updates prot bits.=0A=
+	 */=0A=
+	if (kvm_gmem_folio_no_direct_map(folio))=0A=
+		set_direct_map_valid_noflush(folio_page(folio, 0), folio_nr_pages(folio)=
,=0A=
+					 true);=0A=
+}=0A=
+=0A=
 static inline void kvm_gmem_mark_prepared(struct folio *folio)=0A=
 {=0A=
 	folio_mark_uptodate(folio);=0A=
@@ -324,13 +365,14 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct =
vm_fault *vmf)=0A=
 	struct inode *inode =3D file_inode(vmf->vma->vm_file);=0A=
 	struct folio *folio;=0A=
 	vm_fault_t ret =3D VM_FAULT_LOCKED;=0A=
+	int err;=0A=
 =0A=
 	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >=3D i_size_read(inode))=0A=
 		return VM_FAULT_SIGBUS;=0A=
 =0A=
 	folio =3D kvm_gmem_get_folio(inode, vmf->pgoff);=0A=
 	if (IS_ERR(folio)) {=0A=
-		int err =3D PTR_ERR(folio);=0A=
+		err =3D PTR_ERR(folio);=0A=
 =0A=
 		if (err =3D=3D -EAGAIN)=0A=
 			return VM_FAULT_RETRY;=0A=
@@ -348,6 +390,13 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct v=
m_fault *vmf)=0A=
 		kvm_gmem_mark_prepared(folio);=0A=
 	}=0A=
 =0A=
+	err =3D kvm_gmem_folio_zap_direct_map(folio);=0A=
+=0A=
+	if (err) {=0A=
+		ret =3D vmf_error(err);=0A=
+		goto out_folio;=0A=
+	}=0A=
+=0A=
 	vmf->page =3D folio_file_page(folio, vmf->pgoff);=0A=
 =0A=
 out_folio:=0A=
@@ -435,6 +484,8 @@ static void kvm_gmem_free_folio(struct folio *folio)=0A=
 	kvm_pfn_t pfn =3D page_to_pfn(page);=0A=
 	int order =3D folio_order(folio);=0A=
 =0A=
+	kvm_gmem_folio_restore_direct_map(folio);=0A=
+=0A=
 	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));=0A=
 }=0A=
 =0A=
@@ -499,6 +550,9 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t si=
ze, u64 flags)=0A=
 	/* Unmovable mappings are supposed to be marked unevictable as well. */=
=0A=
 	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));=0A=
 =0A=
+	if (flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP)=0A=
+		mapping_set_no_direct_map(inode->i_mapping);=0A=
+=0A=
 	kvm_get_kvm(kvm);=0A=
 	gmem->kvm =3D kvm;=0A=
 	xa_init(&gmem->bindings);=0A=
@@ -523,6 +577,9 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_=
guest_memfd *args)=0A=
 	if (kvm_arch_supports_gmem_mmap(kvm))=0A=
 		valid_flags |=3D GUEST_MEMFD_FLAG_MMAP;=0A=
 =0A=
+	if (kvm_arch_gmem_supports_no_direct_map())=0A=
+		valid_flags |=3D GUEST_MEMFD_FLAG_NO_DIRECT_MAP;=0A=
+=0A=
 	if (flags & ~valid_flags)=0A=
 		return -EINVAL;=0A=
 =0A=
@@ -687,6 +744,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory=
_slot *slot,=0A=
 	if (!is_prepared)=0A=
 		r =3D kvm_gmem_prepare_folio(kvm, slot, gfn, folio);=0A=
 =0A=
+	kvm_gmem_folio_zap_direct_map(folio);=0A=
+=0A=
 	folio_unlock(folio);=0A=
 =0A=
 	if (!r)=0A=
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c=0A=
index 18f29ef93543..b5e702d95230 100644=0A=
--- a/virt/kvm/kvm_main.c=0A=
+++ b/virt/kvm/kvm_main.c=0A=
@@ -65,6 +65,7 @@=0A=
 #include <trace/events/kvm.h>=0A=
 =0A=
 #include <linux/kvm_dirty_ring.h>=0A=
+#include <linux/set_memory.h>=0A=
 =0A=
 =0A=
 /* Worst case buffer size needed for holding an integer. */=0A=
@@ -4916,6 +4917,10 @@ static int kvm_vm_ioctl_check_extension_generic(stru=
ct kvm *kvm, long arg)=0A=
 		return kvm_supported_mem_attributes(kvm);=0A=
 #endif=0A=
 #ifdef CONFIG_KVM_GUEST_MEMFD=0A=
+	case KVM_CAP_GUEST_MEMFD_NO_DIRECT_MAP:=0A=
+		if (!kvm_arch_gmem_supports_no_direct_map())=0A=
+			return 0;=0A=
+		fallthrough;=0A=
 	case KVM_CAP_GUEST_MEMFD:=0A=
 		return 1;=0A=
 	case KVM_CAP_GUEST_MEMFD_MMAP:=0A=
-- =0A=
2.51.0=0A=
=0A=

