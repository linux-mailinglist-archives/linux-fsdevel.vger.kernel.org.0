Return-Path: <linux-fsdevel+bounces-70831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1231CA8756
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 18:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09DB5302EEAE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 17:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74348346FBE;
	Fri,  5 Dec 2025 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="AtmH1GMu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.143.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57B033B6EC;
	Fri,  5 Dec 2025 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.178.143.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764953968; cv=none; b=ayENAE5IZ9P4DenTRO2VlNGFxBxOfINrYfRCIJtUcC6EJiNprMX3KReyPQhLpg7xoWmO7Dg/R9q4ugG8VWPs7wYmaemul3TPn8VXpob4tPDHHpf4YptRQ758D3uBZKLabwIIYetf+WKRLVuYNx8b32bp42PQ/PBG95dS+sNgq4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764953968; c=relaxed/simple;
	bh=uhOnoz0vRA0Mw6TMzG3XyGqNrE21ewYHC3GSSUy61/k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H1g9qrcXctbDHMGCZXmnfcfs+lcC3zBm6i8/Dxgy/MSfeE5z3T2kUHsSlynTvbBuOotE473LVdJz88pU3xZ/VqCdR4oXeyp/Z6A9v7JtViADkVSHPHWeaHWoLSURe3MmCr92R7CWJMDmafW1MQIkThpbdpS5XwYIvYfB83UYhtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=AtmH1GMu; arc=none smtp.client-ip=63.178.143.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1764953949; x=1796489949;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ioJNos7hxVKCZgZqEai7R/nyP1L59yWcXHZaL1WkvB4=;
  b=AtmH1GMu5wunsBUX2Pqtyk37LVPvx21PVDRQsIIstgBvu0R71hMSt2dr
   PVxNRq3tmsZRWGIwf2YeTpaar4iAB490YJJhmVHX7yc6jxsyN0RaFAVKZ
   xwJj9tKtC3HPnljVR1huJA8551VMVcIUaOvJXa2O/AXIH2GlZgyf/zAxa
   Qr0w2X9cZL9BqRAv2ChiYmrwW+QLizSTcfu+E7fhXn380SZOpMGiYvg8n
   3ySvnZiX8KenkHxzQ4iBcLBsyCe2FutFMqLPHPWz3y8wHehIY4dt6B1mE
   s9eDYREc0+SR52xx2WWcAYwuJscKu4tJBv9177sVE92gG0Q2oE4BDhTKJ
   A==;
X-CSE-ConnectionGUID: iB+IdF+LR5aqvP28mlAo6g==
X-CSE-MsgGUID: Oewbkl1pSgGBoL2ZAj/lYw==
X-IronPort-AV: E=Sophos;i="6.20,252,1758585600"; 
   d="scan'208";a="6199842"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 16:58:44 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:25188]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.34.107:2525] with esmtp (Farcaster)
 id 64f2d293-0d8e-44f4-ba51-89912e231554; Fri, 5 Dec 2025 16:58:44 +0000 (UTC)
X-Farcaster-Flow-ID: 64f2d293-0d8e-44f4-ba51-89912e231554
Received: from EX19D005EUB004.ant.amazon.com (10.252.51.126) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 5 Dec 2025 16:58:44 +0000
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19D005EUB004.ant.amazon.com (10.252.51.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 5 Dec 2025 16:58:43 +0000
Received: from EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c]) by
 EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c%3]) with mapi id
 15.02.2562.029; Fri, 5 Dec 2025 16:58:43 +0000
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
Subject: [PATCH v8 05/13] KVM: guest_memfd: Add flag to remove from direct map
Thread-Topic: [PATCH v8 05/13] KVM: guest_memfd: Add flag to remove from
 direct map
Thread-Index: AQHcZghpe03+EzzQP0GBbIS7sNUUeQ==
Date: Fri, 5 Dec 2025 16:58:43 +0000
Message-ID: <20251205165743.9341-6-kalyazin@amazon.com>
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
Add GUEST_MEMFD_FLAG_NO_DIRECT_MAP flag for KVM_CREATE_GUEST_MEMFD()=0A=
ioctl. When set, guest_memfd folios will be removed from the direct map=0A=
after preparation, with direct map entries only restored when the folios=0A=
are freed.=0A=
=0A=
To ensure these folios do not end up in places where the kernel cannot=0A=
deal with them, set AS_NO_DIRECT_MAP on the guest_memfd's struct=0A=
address_space if GUEST_MEMFD_FLAG_NO_DIRECT_MAP is requested.=0A=
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
Signed-off-by: Patrick Roy <patrick.roy@linux.dev>=0A=
Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>=0A=
---=0A=
 Documentation/virt/kvm/api.rst | 22 ++++++++-----=0A=
 include/linux/kvm_host.h       | 12 +++++++=0A=
 include/uapi/linux/kvm.h       |  1 +=0A=
 virt/kvm/guest_memfd.c         | 60 ++++++++++++++++++++++++++++++++++=0A=
 4 files changed, 86 insertions(+), 9 deletions(-)=0A=
=0A=
diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rs=
t=0A=
index 01a3abef8abb..c5f54f1370c8 100644=0A=
--- a/Documentation/virt/kvm/api.rst=0A=
+++ b/Documentation/virt/kvm/api.rst=0A=
@@ -6440,15 +6440,19 @@ a single guest_memfd file, but the bound ranges mus=
t not overlap).=0A=
 The capability KVM_CAP_GUEST_MEMFD_FLAGS enumerates the `flags` that can b=
e=0A=
 specified via KVM_CREATE_GUEST_MEMFD.  Currently defined flags:=0A=
 =0A=
-  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=0A=
-  GUEST_MEMFD_FLAG_MMAP        Enable using mmap() on the guest_memfd file=
=0A=
-                               descriptor.=0A=
-  GUEST_MEMFD_FLAG_INIT_SHARED Make all memory in the file shared during=
=0A=
-                               KVM_CREATE_GUEST_MEMFD (memory files create=
d=0A=
-                               without INIT_SHARED will be marked private)=
.=0A=
-                               Shared memory can be faulted into host user=
space=0A=
-                               page tables. Private memory cannot.=0A=
-  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=0A=
+  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=0A=
+  GUEST_MEMFD_FLAG_MMAP          Enable using mmap() on the guest_memfd fi=
le=0A=
+                                 descriptor.=0A=
+  GUEST_MEMFD_FLAG_INIT_SHARED   Make all memory in the file shared during=
=0A=
+                                 KVM_CREATE_GUEST_MEMFD (memory files crea=
ted=0A=
+                                 without INIT_SHARED will be marked privat=
e).=0A=
+                                 Shared memory can be faulted into host us=
erspace=0A=
+                                 page tables. Private memory cannot.=0A=
+  GUEST_MEMFD_FLAG_NO_DIRECT_MAP The guest_memfd instance will behave simi=
larly=0A=
+                                 to memfd_secret, and unmaps the memory ba=
cking=0A=
+                                 it from the kernel's address space before=
=0A=
+                                 being passed off to userspace or the gues=
t.=0A=
+  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=0A=
 =0A=
 When the KVM MMU performs a PFN lookup to service a guest fault and the ba=
cking=0A=
 guest_memfd has the GUEST_MEMFD_FLAG_MMAP set, then the fault will always =
be=0A=
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h=0A=
index 27796a09d29b..d4d5306075bf 100644=0A=
--- a/include/linux/kvm_host.h=0A=
+++ b/include/linux/kvm_host.h=0A=
@@ -738,10 +738,22 @@ static inline u64 kvm_gmem_get_supported_flags(struct=
 kvm *kvm)=0A=
 	if (!kvm || kvm_arch_supports_gmem_init_shared(kvm))=0A=
 		flags |=3D GUEST_MEMFD_FLAG_INIT_SHARED;=0A=
 =0A=
+	if (kvm_arch_gmem_supports_no_direct_map())=0A=
+		flags |=3D GUEST_MEMFD_FLAG_NO_DIRECT_MAP;=0A=
+=0A=
 	return flags;=0A=
 }=0A=
 #endif=0A=
 =0A=
+#ifdef CONFIG_KVM_GUEST_MEMFD=0A=
+#ifndef kvm_arch_gmem_supports_no_direct_map=0A=
+static inline bool kvm_arch_gmem_supports_no_direct_map(void)=0A=
+{=0A=
+	return false;=0A=
+}=0A=
+#endif=0A=
+#endif /* CONFIG_KVM_GUEST_MEMFD */=0A=
+=0A=
 #ifndef kvm_arch_has_readonly_mem=0A=
 static inline bool kvm_arch_has_readonly_mem(struct kvm *kvm)=0A=
 {=0A=
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h=0A=
index dddb781b0507..60341e1ba1be 100644=0A=
--- a/include/uapi/linux/kvm.h=0A=
+++ b/include/uapi/linux/kvm.h=0A=
@@ -1612,6 +1612,7 @@ struct kvm_memory_attributes {=0A=
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest=
_memfd)=0A=
 #define GUEST_MEMFD_FLAG_MMAP		(1ULL << 0)=0A=
 #define GUEST_MEMFD_FLAG_INIT_SHARED	(1ULL << 1)=0A=
+#define GUEST_MEMFD_FLAG_NO_DIRECT_MAP	(1ULL << 2)=0A=
 =0A=
 struct kvm_create_guest_memfd {=0A=
 	__u64 size;=0A=
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c=0A=
index 92e7f8c1f303..ec4966a47d5e 100644=0A=
--- a/virt/kvm/guest_memfd.c=0A=
+++ b/virt/kvm/guest_memfd.c=0A=
@@ -7,6 +7,9 @@=0A=
 #include <linux/mempolicy.h>=0A=
 #include <linux/pseudo_fs.h>=0A=
 #include <linux/pagemap.h>=0A=
+#include <linux/set_memory.h>=0A=
+=0A=
+#include <asm/tlbflush.h>=0A=
 =0A=
 #include "kvm_mm.h"=0A=
 =0A=
@@ -76,6 +79,49 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, str=
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
+	int r =3D 0;=0A=
+	unsigned long addr =3D (unsigned long) folio_address(folio);=0A=
+	u64 gmem_flags =3D GMEM_I(folio_inode(folio))->flags;=0A=
+=0A=
+	if (kvm_gmem_folio_no_direct_map(folio) || !(gmem_flags & GUEST_MEMFD_FLA=
G_NO_DIRECT_MAP))=0A=
+		goto out;=0A=
+=0A=
+	r =3D set_direct_map_valid_noflush(folio_page(folio, 0), folio_nr_pages(f=
olio),=0A=
+					 false);=0A=
+=0A=
+	if (r)=0A=
+		goto out;=0A=
+=0A=
+	folio->private =3D (void *) KVM_GMEM_FOLIO_NO_DIRECT_MAP;=0A=
+	flush_tlb_kernel_range(addr, addr + folio_size(folio));=0A=
+=0A=
+out:=0A=
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
@@ -398,6 +444,7 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm=
_fault *vmf)=0A=
 	struct inode *inode =3D file_inode(vmf->vma->vm_file);=0A=
 	struct folio *folio;=0A=
 	vm_fault_t ret =3D VM_FAULT_LOCKED;=0A=
+	int err;=0A=
 =0A=
 	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >=3D i_size_read(inode))=0A=
 		return VM_FAULT_SIGBUS;=0A=
@@ -423,6 +470,12 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct v=
m_fault *vmf)=0A=
 		kvm_gmem_mark_prepared(folio);=0A=
 	}=0A=
 =0A=
+	err =3D kvm_gmem_folio_zap_direct_map(folio);=0A=
+	if (err) {=0A=
+		ret =3D vmf_error(err);=0A=
+		goto out_folio;=0A=
+	}=0A=
+=0A=
 	vmf->page =3D folio_file_page(folio, vmf->pgoff);=0A=
 =0A=
 out_folio:=0A=
@@ -533,6 +586,8 @@ static void kvm_gmem_free_folio(struct folio *folio)=0A=
 	kvm_pfn_t pfn =3D page_to_pfn(page);=0A=
 	int order =3D folio_order(folio);=0A=
 =0A=
+	kvm_gmem_folio_restore_direct_map(folio);=0A=
+=0A=
 	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));=0A=
 }=0A=
 =0A=
@@ -596,6 +651,9 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t si=
ze, u64 flags)=0A=
 	/* Unmovable mappings are supposed to be marked unevictable as well. */=
=0A=
 	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));=0A=
 =0A=
+	if (flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP)=0A=
+		mapping_set_no_direct_map(inode->i_mapping);=0A=
+=0A=
 	GMEM_I(inode)->flags =3D flags;=0A=
 =0A=
 	file =3D alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR, &kvm_gmem_f=
ops);=0A=
@@ -807,6 +865,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory=
_slot *slot,=0A=
 	if (!is_prepared)=0A=
 		r =3D kvm_gmem_prepare_folio(kvm, slot, gfn, folio);=0A=
 =0A=
+	kvm_gmem_folio_zap_direct_map(folio);=0A=
+=0A=
 	folio_unlock(folio);=0A=
 =0A=
 	if (!r)=0A=
-- =0A=
2.50.1=0A=
=0A=

