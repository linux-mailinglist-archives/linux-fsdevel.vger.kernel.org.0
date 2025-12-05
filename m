Return-Path: <linux-fsdevel+bounces-70837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEC5CA8816
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 18:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1258D3208680
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 17:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0662C345CDA;
	Fri,  5 Dec 2025 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="LkpHFV9v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.64.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B398C348886;
	Fri,  5 Dec 2025 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.237.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954003; cv=none; b=r5tz+Y4EUZaE7K4py5QlG6VDP40Uzgo3QF7vX6Lrk2xe6xrvlk469xGrbfYYcSqoGZIhmsLHBtBf6Fok64rNpOTKGG+fRZLfhjY9h7meEHuaycsKaVOXvdRJplm8NIa6vjufDEvetHlMaNPyel15b2reZaVcCkKb9EZ54gaB40s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954003; c=relaxed/simple;
	bh=52mHrkP05gYzT147dW4uInww81IpjV4wn8Xsu+UrgMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pK0yIPl0n6vBXYJtMpminM20X9fvcD9efoA54t+0K0uiitcFV4ka8IWit0YMv0fki7mE/CGHTBFaZ3AdFb5bzw4bmfD5gdLA+V5pEXGsPt/jaZOrytx7TPEgLoq371vJXr4I3c5VVWKrL1kxfLEvtC8vyPRqkrCtWDShQ2z3zD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=LkpHFV9v; arc=none smtp.client-ip=3.64.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1764953998; x=1796489998;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OprfmizXxq8RRTSlSSc6Z/sKanOls1Ur59Qhbz1MdVc=;
  b=LkpHFV9v/Yt04CZIHYyAIQPsIUeVyM2p/yJAaaKoQ/VUpgLi7e+xK5zO
   s4DScDKAOMTwVTja5uvmXfdDkI1YH63ghvmQSedRJA/Xg4s94Wp72R7vv
   UyT8D+MEXMZQXizShO9yQ/ZYEYuvEqmkh1nDOFK3tiBmpPv0Sm3ZFJ/4V
   vTKl1zp+NLFpziLiBlLg26DAP84y08sfixeFHRR5tjr5kjCB45kwC0X5S
   iC4XIJwFkBPMHCMd67Xk8clE7GAI0MYBywXQgN198P/mKEc4/WOpFQf0y
   eBt6dq9kHq5m7WcUdpQRL1uI/O/7dSRqfXnfJ9ohdWW5PQDNTIgEZUNGE
   A==;
X-CSE-ConnectionGUID: wdWaJSd5SF6NQona6voUBg==
X-CSE-MsgGUID: mLPb0a/XSKCaS9kn1GTYnw==
X-IronPort-AV: E=Sophos;i="6.20,252,1758585600"; 
   d="scan'208";a="6206137"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 16:59:49 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:11504]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.24.148:2525] with esmtp (Farcaster)
 id 34fe6e69-dd5b-4480-b95e-ddc8757a2feb; Fri, 5 Dec 2025 16:59:49 +0000 (UTC)
X-Farcaster-Flow-ID: 34fe6e69-dd5b-4480-b95e-ddc8757a2feb
Received: from EX19D005EUB002.ant.amazon.com (10.252.51.103) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 5 Dec 2025 16:59:41 +0000
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19D005EUB002.ant.amazon.com (10.252.51.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 5 Dec 2025 16:59:40 +0000
Received: from EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c]) by
 EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c%3]) with mapi id
 15.02.2562.029; Fri, 5 Dec 2025 16:59:40 +0000
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
Subject: [PATCH v8 10/13] KVM: selftests: Add guest_memfd based
 vm_mem_backing_src_types
Thread-Topic: [PATCH v8 10/13] KVM: selftests: Add guest_memfd based
 vm_mem_backing_src_types
Thread-Index: AQHcZgiLyS0oCQO1nUODCs70+4I+GA==
Date: Fri, 5 Dec 2025 16:59:40 +0000
Message-ID: <20251205165743.9341-11-kalyazin@amazon.com>
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
Allow selftests to configure their memslots such that userspace_addr is=0A=
set to a MAP_SHARED mapping of the guest_memfd that's associated with=0A=
the memslot. This setup is the configuration for non-CoCo VMs, where all=0A=
guest memory is backed by a guest_memfd whose folios are all marked=0A=
shared, but KVM is still able to access guest memory to provide=0A=
functionality such as MMIO emulation on x86.=0A=
=0A=
Add backing types for normal guest_memfd, as well as direct map removed=0A=
guest_memfd.=0A=
=0A=
Signed-off-by: Patrick Roy <patrick.roy@linux.dev>=0A=
Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>=0A=
---=0A=
 .../testing/selftests/kvm/include/kvm_util.h  | 18 ++++++=0A=
 .../testing/selftests/kvm/include/test_util.h |  7 +++=0A=
 tools/testing/selftests/kvm/lib/kvm_util.c    | 61 ++++++++++---------=0A=
 tools/testing/selftests/kvm/lib/test_util.c   |  8 +++=0A=
 4 files changed, 65 insertions(+), 29 deletions(-)=0A=
=0A=
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing=
/selftests/kvm/include/kvm_util.h=0A=
index 81f4355ff28a..6689b43810c1 100644=0A=
--- a/tools/testing/selftests/kvm/include/kvm_util.h=0A=
+++ b/tools/testing/selftests/kvm/include/kvm_util.h=0A=
@@ -641,6 +641,24 @@ static inline bool is_smt_on(void)=0A=
 =0A=
 void vm_create_irqchip(struct kvm_vm *vm);=0A=
 =0A=
+static inline uint32_t backing_src_guest_memfd_flags(enum vm_mem_backing_s=
rc_type t)=0A=
+{=0A=
+	uint32_t flags =3D 0;=0A=
+=0A=
+	switch (t) {=0A=
+	case VM_MEM_SRC_GUEST_MEMFD_NO_DIRECT_MAP:=0A=
+		flags |=3D GUEST_MEMFD_FLAG_NO_DIRECT_MAP;=0A=
+		fallthrough;=0A=
+	case VM_MEM_SRC_GUEST_MEMFD:=0A=
+		flags |=3D GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED;=0A=
+		break;=0A=
+	default:=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	return flags;=0A=
+}=0A=
+=0A=
 static inline int __vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size=
,=0A=
 					uint64_t flags)=0A=
 {=0A=
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testin=
g/selftests/kvm/include/test_util.h=0A=
index 8140e59b59e5..ea6de20ce8ef 100644=0A=
--- a/tools/testing/selftests/kvm/include/test_util.h=0A=
+++ b/tools/testing/selftests/kvm/include/test_util.h=0A=
@@ -152,6 +152,8 @@ enum vm_mem_backing_src_type {=0A=
 	VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB,=0A=
 	VM_MEM_SRC_SHMEM,=0A=
 	VM_MEM_SRC_SHARED_HUGETLB,=0A=
+	VM_MEM_SRC_GUEST_MEMFD,=0A=
+	VM_MEM_SRC_GUEST_MEMFD_NO_DIRECT_MAP,=0A=
 	NUM_SRC_TYPES,=0A=
 };=0A=
 =0A=
@@ -184,6 +186,11 @@ static inline bool backing_src_is_shared(enum vm_mem_b=
acking_src_type t)=0A=
 	return vm_mem_backing_src_alias(t)->flag & MAP_SHARED;=0A=
 }=0A=
 =0A=
+static inline bool backing_src_is_guest_memfd(enum vm_mem_backing_src_type=
 t)=0A=
+{=0A=
+	return t =3D=3D VM_MEM_SRC_GUEST_MEMFD || t =3D=3D VM_MEM_SRC_GUEST_MEMFD=
_NO_DIRECT_MAP;=0A=
+}=0A=
+=0A=
 static inline bool backing_src_can_be_huge(enum vm_mem_backing_src_type t)=
=0A=
 {=0A=
 	return t !=3D VM_MEM_SRC_ANONYMOUS && t !=3D VM_MEM_SRC_SHMEM;=0A=
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/sel=
ftests/kvm/lib/kvm_util.c=0A=
index 56ddbca91850..28ee51253909 100644=0A=
--- a/tools/testing/selftests/kvm/lib/kvm_util.c=0A=
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c=0A=
@@ -1013,6 +1013,33 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backi=
ng_src_type src_type,=0A=
 	alignment =3D 1;=0A=
 #endif=0A=
 =0A=
+	if (guest_memfd < 0) {=0A=
+		if ((flags & KVM_MEM_GUEST_MEMFD) || backing_src_is_guest_memfd(src_type=
)) {=0A=
+			uint32_t guest_memfd_flags =3D backing_src_guest_memfd_flags(src_type);=
=0A=
+=0A=
+			TEST_ASSERT(!guest_memfd_offset,=0A=
+				    "Offset must be zero when creating new guest_memfd");=0A=
+			guest_memfd =3D vm_create_guest_memfd(vm, mem_size, guest_memfd_flags);=
=0A=
+		}=0A=
+	} else {=0A=
+		/*=0A=
+		 * Install a unique fd for each memslot so that the fd=0A=
+		 * can be closed when the region is deleted without=0A=
+		 * needing to track if the fd is owned by the framework=0A=
+		 * or by the caller.=0A=
+		 */=0A=
+		guest_memfd =3D kvm_dup(guest_memfd);=0A=
+	}=0A=
+=0A=
+	if (guest_memfd > 0) {=0A=
+		flags |=3D KVM_MEM_GUEST_MEMFD;=0A=
+=0A=
+		region->region.guest_memfd =3D guest_memfd;=0A=
+		region->region.guest_memfd_offset =3D guest_memfd_offset;=0A=
+	} else {=0A=
+		region->region.guest_memfd =3D -1;=0A=
+	}=0A=
+=0A=
 	/*=0A=
 	 * When using THP mmap is not guaranteed to returned a hugepage aligned=
=0A=
 	 * address so we have to pad the mmap. Padding is not needed for HugeTLB=
=0A=
@@ -1028,10 +1055,13 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_back=
ing_src_type src_type,=0A=
 	if (alignment > 1)=0A=
 		region->mmap_size +=3D alignment;=0A=
 =0A=
-	region->fd =3D -1;=0A=
-	if (backing_src_is_shared(src_type))=0A=
+	if (backing_src_is_guest_memfd(src_type))=0A=
+		region->fd =3D guest_memfd;=0A=
+	else if (backing_src_is_shared(src_type))=0A=
 		region->fd =3D kvm_memfd_alloc(region->mmap_size,=0A=
 					     src_type =3D=3D VM_MEM_SRC_SHARED_HUGETLB);=0A=
+	else=0A=
+		region->fd =3D -1;=0A=
 =0A=
 	region->mmap_start =3D kvm_mmap(region->mmap_size, PROT_READ | PROT_WRITE=
,=0A=
 				      vm_mem_backing_src_alias(src_type)->flag,=0A=
@@ -1056,33 +1086,6 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backi=
ng_src_type src_type,=0A=
 	}=0A=
 =0A=
 	region->backing_src_type =3D src_type;=0A=
-=0A=
-	if (guest_memfd < 0) {=0A=
-		if (flags & KVM_MEM_GUEST_MEMFD) {=0A=
-			uint32_t guest_memfd_flags =3D 0;=0A=
-			TEST_ASSERT(!guest_memfd_offset,=0A=
-				    "Offset must be zero when creating new guest_memfd");=0A=
-			guest_memfd =3D vm_create_guest_memfd(vm, mem_size, guest_memfd_flags);=
=0A=
-		}=0A=
-	} else {=0A=
-		/*=0A=
-		 * Install a unique fd for each memslot so that the fd=0A=
-		 * can be closed when the region is deleted without=0A=
-		 * needing to track if the fd is owned by the framework=0A=
-		 * or by the caller.=0A=
-		 */=0A=
-		guest_memfd =3D kvm_dup(guest_memfd);=0A=
-	}=0A=
-=0A=
-	if (guest_memfd > 0) {=0A=
-		flags |=3D KVM_MEM_GUEST_MEMFD;=0A=
-=0A=
-		region->region.guest_memfd =3D guest_memfd;=0A=
-		region->region.guest_memfd_offset =3D guest_memfd_offset;=0A=
-	} else {=0A=
-		region->region.guest_memfd =3D -1;=0A=
-	}=0A=
-=0A=
 	region->unused_phy_pages =3D sparsebit_alloc();=0A=
 	if (vm_arch_has_protected_memory(vm))=0A=
 		region->protected_phy_pages =3D sparsebit_alloc();=0A=
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/se=
lftests/kvm/lib/test_util.c=0A=
index 8a1848586a85..ce9fe0271515 100644=0A=
--- a/tools/testing/selftests/kvm/lib/test_util.c=0A=
+++ b/tools/testing/selftests/kvm/lib/test_util.c=0A=
@@ -306,6 +306,14 @@ const struct vm_mem_backing_src_alias *vm_mem_backing_=
src_alias(uint32_t i)=0A=
 			 */=0A=
 			.flag =3D MAP_SHARED,=0A=
 		},=0A=
+		[VM_MEM_SRC_GUEST_MEMFD] =3D {=0A=
+			.name =3D "guest_memfd",=0A=
+			.flag =3D MAP_SHARED,=0A=
+		},=0A=
+		[VM_MEM_SRC_GUEST_MEMFD_NO_DIRECT_MAP] =3D {=0A=
+			.name =3D "guest_memfd_no_direct_map",=0A=
+			.flag =3D MAP_SHARED,=0A=
+		}=0A=
 	};=0A=
 	_Static_assert(ARRAY_SIZE(aliases) =3D=3D NUM_SRC_TYPES,=0A=
 		       "Missing new backing src types?");=0A=
-- =0A=
2.50.1=0A=
=0A=

