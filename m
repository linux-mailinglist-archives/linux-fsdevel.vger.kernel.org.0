Return-Path: <linux-fsdevel+bounces-42262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A925A3FAC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 17:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357B1189EECA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 16:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDBA210190;
	Fri, 21 Feb 2025 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="rCb+sl59"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BA620FAB7;
	Fri, 21 Feb 2025 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154225; cv=none; b=PC05c113JGyn6d54vySTyO+CKJ2cr4FJrYVYZNaHFZiVU8zrT17amq3wLAcp+5oZxJWQ1NQ5sK29L2IJF+qIqY7Lf9v/yWS/TUarjOrL53UQJdjhq2gqMYZxGkZgjtFvo8Ru3WyF5z7O1o8psLeWnxc2uH2t8aZTfB1rWr/aq48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154225; c=relaxed/simple;
	bh=pgtBpu5UrQJXfKgE2HtqeyL2jdK0lWVfWOBeyUWTPPo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1KNkU0CxGrk1S9IwUT2fXJTVB/E0Qkw6F77GVqni84kRFxOaQ+dFAF5/34Gj8/4ZKZ6kW2hsDThDyNzFzH89RVzKZHEXj96NikF5gWegcPc77vvs7OO+9l1NDTOnq1Tk2LbVdKeBIveXaLszjolqYcL1uexJBiob7GZswQ9hqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=rCb+sl59; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1740154223; x=1771690223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3r9gSHkXzH1oVByFnRKt2AIla6FqFTK9LPPa6WWUwJA=;
  b=rCb+sl59wf3Q/vIUxDMGomUL5N10ZINoICQ6X7hfw93s0V/GLr79epEm
   CUBzUpAbGIPa9V+V4ZRLHSGN0VmQ9MnK5IM17ZILc9RkfTNCHUdRi3MXB
   r0JC2R+eB5LyC5V1PsUx99FulA4A8qfIanPmUaZWFs6XppHQvc8R2BAZk
   U=;
X-IronPort-AV: E=Sophos;i="6.13,305,1732579200"; 
   d="scan'208";a="174721555"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 16:10:23 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:7610]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.70:2525] with esmtp (Farcaster)
 id 8e51e2fa-4e3e-47fa-ae1a-9f5d1237fa92; Fri, 21 Feb 2025 16:10:23 +0000 (UTC)
X-Farcaster-Flow-ID: 8e51e2fa-4e3e-47fa-ae1a-9f5d1237fa92
Received: from EX19D003UWB003.ant.amazon.com (10.13.138.116) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 16:10:08 +0000
Received: from EX19MTAUWB002.ant.amazon.com (10.250.64.231) by
 EX19D003UWB003.ant.amazon.com (10.13.138.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 16:10:08 +0000
Received: from email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Fri, 21 Feb 2025 16:10:08 +0000
Received: from ua2d7e1a6107c5b.ant.amazon.com (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com (Postfix) with ESMTPS id 6AC21404C9;
	Fri, 21 Feb 2025 16:10:00 +0000 (UTC)
From: Patrick Roy <roypat@amazon.co.uk>
To: <rppt@kernel.org>, <david@redhat.com>, <seanjc@google.com>
CC: Patrick Roy <roypat@amazon.co.uk>, <pbonzini@redhat.com>,
	<corbet@lwn.net>, <willy@infradead.org>, <akpm@linux-foundation.org>,
	<song@kernel.org>, <jolsa@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<eddyz87@gmail.com>, <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
	<kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
	<Liam.Howlett@oracle.com>, <lorenzo.stoakes@oracle.com>, <vbabka@suse.cz>,
	<jannh@google.com>, <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>, <bpf@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <tabba@google.com>, <jgowans@amazon.com>,
	<graf@amazon.com>, <kalyazin@amazon.com>, <xmarcalx@amazon.com>,
	<derekmn@amazon.com>, <jthoughton@google.com>
Subject: [PATCH v4 08/12] KVM: selftests: Add guest_memfd based vm_mem_backing_src_types
Date: Fri, 21 Feb 2025 16:07:21 +0000
Message-ID: <20250221160728.1584559-9-roypat@amazon.co.uk>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221160728.1584559-1-roypat@amazon.co.uk>
References: <20250221160728.1584559-1-roypat@amazon.co.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Allow selftests to configure their memslots such that userspace_addr is
set to a MAP_SHARED mapping of the guest_memfd that's associated with
the memslot. This setup is the configuration for non-CoCo VMs, where all
guest memory is backed by a guest_memfd whose folios are all marked
shared, but KVM is still able to access guest memory to provide
functionality such as MMIO emulation on x86.

Add backing types for normal guest_memfd, as well as direct map removed
guest_memfd.

If KVM_CAP_MEMORY_ATTRIBUTES is available, explicitly set gmem-enabled
memslots to private, as otherwise guest page faults will be resolved by
GUP-ing the guest_memfd VMA (instead of using the special VMA-less
guest_memfd fault code in the KVM MMU), but this is not always supported
(e.g. if direct map entries are not available).

Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
---
 .../testing/selftests/kvm/include/kvm_util.h  | 10 +++
 .../testing/selftests/kvm/include/test_util.h |  7 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 67 ++++++++++---------
 tools/testing/selftests/kvm/lib/test_util.c   |  8 +++
 4 files changed, 62 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 4c4e5a847f67..baeddec7c264 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -544,6 +544,16 @@ static inline uint64_t vm_get_stat(struct kvm_vm *vm, const char *stat_name)
 
 void vm_create_irqchip(struct kvm_vm *vm);
 
+static inline bool backing_src_guest_memfd_flags(enum vm_mem_backing_src_type t)
+{
+	switch (t) {
+	case VM_MEM_SRC_GUEST_MEMFD_NO_DIRECT_MAP:
+		return KVM_GMEM_NO_DIRECT_MAP;
+	default:
+		return 0;
+	}
+}
+
 static inline int __vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size,
 					uint64_t flags)
 {
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 51f34c34b5a2..2469df886d7a 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -133,6 +133,8 @@ enum vm_mem_backing_src_type {
 	VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB,
 	VM_MEM_SRC_SHMEM,
 	VM_MEM_SRC_SHARED_HUGETLB,
+	VM_MEM_SRC_GUEST_MEMFD,
+	VM_MEM_SRC_GUEST_MEMFD_NO_DIRECT_MAP,
 	NUM_SRC_TYPES,
 };
 
@@ -164,6 +166,11 @@ static inline bool backing_src_is_shared(enum vm_mem_backing_src_type t)
 	return vm_mem_backing_src_alias(t)->flag & MAP_SHARED;
 }
 
+static inline bool backing_src_is_guest_memfd(enum vm_mem_backing_src_type t)
+{
+	return t == VM_MEM_SRC_GUEST_MEMFD || t == VM_MEM_SRC_GUEST_MEMFD_NO_DIRECT_MAP;
+}
+
 static inline bool backing_src_can_be_huge(enum vm_mem_backing_src_type t)
 {
 	return t != VM_MEM_SRC_ANONYMOUS && t != VM_MEM_SRC_SHMEM;
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index ebdf38e2983b..0900809bf6ac 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -970,6 +970,34 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 	alignment = 1;
 #endif
 
+	if (guest_memfd < 0) {
+		if ((flags & KVM_MEM_GUEST_MEMFD) || backing_src_is_guest_memfd(src_type)) {
+			uint32_t guest_memfd_flags = backing_src_guest_memfd_flags(src_type);
+
+			TEST_ASSERT(!guest_memfd_offset,
+				    "Offset must be zero when creating new guest_memfd");
+			guest_memfd = vm_create_guest_memfd(vm, mem_size, guest_memfd_flags);
+		}
+	} else {
+		/*
+		 * Install a unique fd for each memslot so that the fd
+		 * can be closed when the region is deleted without
+		 * needing to track if the fd is owned by the framework
+		 * or by the caller.
+		 */
+		guest_memfd = dup(guest_memfd);
+		TEST_ASSERT(guest_memfd >= 0, __KVM_SYSCALL_ERROR("dup()", guest_memfd));
+	}
+
+	if (guest_memfd > 0) {
+		flags |= KVM_MEM_GUEST_MEMFD;
+
+		region->region.guest_memfd = guest_memfd;
+		region->region.guest_memfd_offset = guest_memfd_offset;
+	} else {
+		region->region.guest_memfd = -1;
+	}
+
 	/*
 	 * When using THP mmap is not guaranteed to returned a hugepage aligned
 	 * address so we have to pad the mmap. Padding is not needed for HugeTLB
@@ -985,10 +1013,13 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 	if (alignment > 1)
 		region->mmap_size += alignment;
 
-	region->fd = -1;
-	if (backing_src_is_shared(src_type))
+	if (backing_src_is_guest_memfd(src_type))
+		region->fd = guest_memfd;
+	else if (backing_src_is_guest_memfd(src_type))
 		region->fd = kvm_memfd_alloc(region->mmap_size,
 					     src_type == VM_MEM_SRC_SHARED_HUGETLB);
+	else
+		region->fd = -1;
 
 	region->mmap_start = mmap(NULL, region->mmap_size,
 				  PROT_READ | PROT_WRITE,
@@ -1016,34 +1047,6 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 	}
 
 	region->backing_src_type = src_type;
-
-	if (guest_memfd < 0) {
-		if (flags & KVM_MEM_GUEST_MEMFD) {
-			uint32_t guest_memfd_flags = 0;
-			TEST_ASSERT(!guest_memfd_offset,
-				    "Offset must be zero when creating new guest_memfd");
-			guest_memfd = vm_create_guest_memfd(vm, mem_size, guest_memfd_flags);
-		}
-	} else {
-		/*
-		 * Install a unique fd for each memslot so that the fd
-		 * can be closed when the region is deleted without
-		 * needing to track if the fd is owned by the framework
-		 * or by the caller.
-		 */
-		guest_memfd = dup(guest_memfd);
-		TEST_ASSERT(guest_memfd >= 0, __KVM_SYSCALL_ERROR("dup()", guest_memfd));
-	}
-
-	if (guest_memfd > 0) {
-		flags |= KVM_MEM_GUEST_MEMFD;
-
-		region->region.guest_memfd = guest_memfd;
-		region->region.guest_memfd_offset = guest_memfd_offset;
-	} else {
-		region->region.guest_memfd = -1;
-	}
-
 	region->unused_phy_pages = sparsebit_alloc();
 	if (vm_arch_has_protected_memory(vm))
 		region->protected_phy_pages = sparsebit_alloc();
@@ -1063,6 +1066,10 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		guest_paddr, (uint64_t) region->region.memory_size,
 		region->region.guest_memfd);
 
+	if (region->region.guest_memfd != -1 && kvm_has_cap(KVM_CAP_MEMORY_ATTRIBUTES))
+		vm_set_memory_attributes(vm, region->region.guest_phys_addr,
+					 region->region.memory_size, KVM_MEMORY_ATTRIBUTE_PRIVATE);
+
 	/* Add to quick lookup data structures */
 	vm_userspace_mem_region_gpa_insert(&vm->regions.gpa_tree, region);
 	vm_userspace_mem_region_hva_insert(&vm->regions.hva_tree, region);
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 8ed0b74ae837..1a5b0d5d5f91 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -279,6 +279,14 @@ const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
 			 */
 			.flag = MAP_SHARED,
 		},
+		[VM_MEM_SRC_GUEST_MEMFD] = {
+			.name = "guest_memfd",
+			.flag = MAP_SHARED,
+		},
+		[VM_MEM_SRC_GUEST_MEMFD_NO_DIRECT_MAP] = {
+			.name = "guest_memfd_no_direct_map",
+			.flag = MAP_SHARED,
+		}
 	};
 	_Static_assert(ARRAY_SIZE(aliases) == NUM_SRC_TYPES,
 		       "Missing new backing src types?");
-- 
2.48.1


