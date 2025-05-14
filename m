Return-Path: <linux-fsdevel+bounces-49039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2938AAB79B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 488A68C7D2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C3D242D6A;
	Wed, 14 May 2025 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qHCUYlR+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED6D23C4F8
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266202; cv=none; b=OxczbkTZzM24QNO/AYpZIGY5oBYbMnmr+4UKXftrLDlLjo26G3LXmsMsnZ7mwbrUb0CdKL8FEsbFpyvMExwbcr454BRPw54jpk3yqrBftLllYZCQ5Mn8brZiVR/q70xM3rpwUK2sbs+/eKjcO96xfsFGMcnUistwtg+jw+RGc3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266202; c=relaxed/simple;
	bh=e91op+UraLyrWNhzcIBqz4xtRXuTML0cF8O8952iihk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YmhjYrGocUmQlCUlSH/OYIVGqvlsqfg+n0bTDUb2fvWOWqHsDPPDQ7KjEjDTwybSRHCzfp2CDlWAZcuGSWCetGyMCQ0VvQ9hsXqMAEp7rmjWR6jimUrzEej7JsToIFBGommsnmTgI3KDztb9YhF9FerqqL8S6aEDILDYQsDldRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qHCUYlR+; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-73dcce02a5cso227830b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266199; x=1747870999; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N9iOM1rSbFI42WS9IxsAoi2d/13fokogLjc+XkopCRc=;
        b=qHCUYlR+cCyepRssCSAW83NvIpUyRouYz6CnTd4XQAURRydKBhtn1dwUYpXQZBytdS
         OyS4Ebg/OyG9pnyGapNeViRLffMmhntJEhWiyf0dKaiRfp05CMtmkqU8xeQGTssnVKSx
         Q49cnzlz3/7Tr3d6VlEkLJY7vlHcc3c6cZFG0MQtEzhqsttmSFfNmh5JRcJZcg5pDhR9
         iOUMEYp7om/ToAlHsZ4S8altQA1LuMTHJtvkZXRl5uelwz96BfdjK+6vAvdKaMF2uss1
         kxNFAsfkQtZT2no+yvdC2Eml8A+Ubv4vr/YtmsSCbsnR17cmTAed81evJl+lvdNGJ++B
         0Vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266199; x=1747870999;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N9iOM1rSbFI42WS9IxsAoi2d/13fokogLjc+XkopCRc=;
        b=uPjPKHxzP5iA+W0lrV7DFl2uSH1eTRcVPrDpid4nqeNbxhBp/RlIyBrsX0w3FHgqGc
         As+c4AlgGoztiZtl9n6E+jb1FI8a5J5NEkH9lhP4VbIgS/lSGPnEjFtkHcLjhJ7asZpv
         /8Hg0ZXp3Ku4rl/XaJ5JVeq80Pi0M+8ayTQCGc7kQDecaAGj3WLYTEfCfA64n7uTD9qZ
         otf/1Z/AH3QtNwOi0jfDZWnhy+vJ4Mb1qAURD9N+ZrOjlrUPQ8+b55XibSzb84VpYHe1
         bXe7GQuguGz1mbhVPzrSZH9VCqnCyB7gygmD7LJmUshd7YgwxlSnhNNqQiZr1mFvNUmr
         fSLA==
X-Forwarded-Encrypted: i=1; AJvYcCUhZDzoZNBP5fY50ik8sfZeW9GkiWnrD7aORkp3BVzAPhUGUmHsE/SDh8VoFX7S0veo2zKhYbCX3lt/+ZNI@vger.kernel.org
X-Gm-Message-State: AOJu0YwwlzGJbk2jWZIwgEKexEN74suwBcYVZ7yplfMMKYifgujFAnJc
	M9Dmh7OUNRdyu5SzJrtOZtgcUuUHnBvlMNKf8kkMe0U+nB16jYqERhCKhN/GxBAg0o0BXUrbtf5
	gq3QVX32UUYGZXOZeEns/Ug==
X-Google-Smtp-Source: AGHT+IESWU6gXthLw+H3adUXZGWsqNOWfunn9I9jbZVcDugt7AmKDl1yijbkySA8Gzvt/3Tb29JluojLVpzGy9Oflg==
X-Received: from pgah3.prod.google.com ([2002:a05:6a02:4e83:b0:b21:868e:36fd])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7a8b:b0:215:d9fc:382e with SMTP id adf61e73a8af0-216115270femr429622637.13.1747266198807;
 Wed, 14 May 2025 16:43:18 -0700 (PDT)
Date: Wed, 14 May 2025 16:41:53 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <45a932753580d21627779ccfc1a2400e17dfdd79.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 14/51] KVM: selftests: Update private_mem_conversions_test
 to mmap guest_memfd
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org
Cc: ackerleytng@google.com, aik@amd.com, ajones@ventanamicro.com, 
	akpm@linux-foundation.org, amoorthy@google.com, anthony.yznaga@oracle.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com, 
	binbin.wu@linux.intel.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

This patch updates private_mem_conversions_test to use guest_memfd for
both private and shared memory. The guest_memfd conversion ioctls are
used to perform conversions.

Specify -g to also back shared memory with memory from guest_memfd.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: Ibc647dc43fbdddac7cc465886bed92c07bbf4f00
---
 .../testing/selftests/kvm/include/kvm_util.h  |   1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  36 ++++
 .../kvm/x86/private_mem_conversions_test.c    | 163 +++++++++++++++---
 3 files changed, 176 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index ffe0625f2d71..ded65a15abea 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -721,6 +721,7 @@ void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa);
 void *addr_gva2hva(struct kvm_vm *vm, vm_vaddr_t gva);
 vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva);
 void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa);
+int addr_gpa2guest_memfd(struct kvm_vm *vm, vm_paddr_t gpa, loff_t *offset);
 
 #ifndef vcpu_arch_put_guest
 #define vcpu_arch_put_guest(mem, val) do { (mem) = (val); } while (0)
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 58a3365f479c..253d0c00e2f0 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1734,6 +1734,42 @@ void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa)
 		+ (gpa - region->region.guest_phys_addr));
 }
 
+/*
+ * Address VM Physical to guest_memfd
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   gpa - VM physical address
+ *
+ * Output Args:
+ *   offset - offset in guest_memfd for gpa
+ *
+ * Return:
+ *   guest_memfd for
+ *
+ * Locates the memory region containing the VM physical address given by gpa,
+ * within the VM given by vm.  When found, the guest_memfd providing the memory
+ * to the vm physical address and the offset in the file corresponding to the
+ * requested gpa is returned.  A TEST_ASSERT failure occurs if no region
+ * containing gpa exists.
+ */
+int addr_gpa2guest_memfd(struct kvm_vm *vm, vm_paddr_t gpa, loff_t *offset)
+{
+	struct userspace_mem_region *region;
+
+	gpa = vm_untag_gpa(vm, gpa);
+
+	region = userspace_mem_region_find(vm, gpa, gpa);
+	if (!region) {
+		TEST_FAIL("No vm physical memory at 0x%lx", gpa);
+		return -1;
+	}
+
+	*offset = region->region.guest_memfd_offset + gpa - region->region.guest_phys_addr;
+
+	return region->region.guest_memfd;
+}
+
 /*
  * Address Host Virtual to VM Physical
  *
diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
index 82a8d88b5338..ec20bb7e95c8 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
@@ -11,6 +11,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/ioctl.h>
+#include <sys/wait.h>
 
 #include <linux/compiler.h>
 #include <linux/kernel.h>
@@ -202,15 +203,19 @@ static void guest_test_explicit_conversion(uint64_t base_gpa, bool do_fallocate)
 		guest_sync_shared(gpa, size, p3, p4);
 		memcmp_g(gpa, p4, size);
 
-		/* Reset the shared memory back to the initial pattern. */
-		memset((void *)gpa, init_p, size);
-
 		/*
 		 * Free (via PUNCH_HOLE) *all* private memory so that the next
 		 * iteration starts from a clean slate, e.g. with respect to
 		 * whether or not there are pages/folios in guest_mem.
 		 */
 		guest_map_shared(base_gpa, PER_CPU_DATA_SIZE, true);
+
+		/*
+		 * Reset the entire block back to the initial pattern. Do this
+		 * after fallocate(PUNCH_HOLE) because hole-punching zeroes
+		 * memory.
+		 */
+		memset((void *)base_gpa, init_p, PER_CPU_DATA_SIZE);
 	}
 }
 
@@ -286,7 +291,8 @@ static void guest_code(uint64_t base_gpa)
 	GUEST_DONE();
 }
 
-static void handle_exit_hypercall(struct kvm_vcpu *vcpu)
+static void handle_exit_hypercall(struct kvm_vcpu *vcpu,
+				  bool back_shared_memory_with_guest_memfd)
 {
 	struct kvm_run *run = vcpu->run;
 	uint64_t gpa = run->hypercall.args[0];
@@ -303,17 +309,81 @@ static void handle_exit_hypercall(struct kvm_vcpu *vcpu)
 	if (do_fallocate)
 		vm_guest_mem_fallocate(vm, gpa, size, map_shared);
 
-	if (set_attributes)
-		vm_set_memory_attributes(vm, gpa, size,
-					 map_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE);
+	if (set_attributes) {
+		if (back_shared_memory_with_guest_memfd) {
+			loff_t offset;
+			int guest_memfd;
+
+			guest_memfd = addr_gpa2guest_memfd(vm, gpa, &offset);
+
+			if (map_shared)
+				guest_memfd_convert_shared(guest_memfd, offset, size);
+			else
+				guest_memfd_convert_private(guest_memfd, offset, size);
+		} else {
+			uint64_t attrs;
+
+			attrs = map_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE;
+			vm_set_memory_attributes(vm, gpa, size, attrs);
+		}
+	}
 	run->hypercall.ret = 0;
 }
 
+static void assert_not_faultable(uint8_t *address)
+{
+	pid_t child_pid;
+
+	child_pid = fork();
+	TEST_ASSERT(child_pid != -1, "fork failed");
+
+	if (child_pid == 0) {
+		*address = 'A';
+		TEST_FAIL("Child should have exited with a signal");
+	} else {
+		int status;
+
+		waitpid(child_pid, &status, 0);
+
+		TEST_ASSERT(WIFSIGNALED(status),
+			    "Child should have exited with a signal");
+		TEST_ASSERT_EQ(WTERMSIG(status), SIGBUS);
+	}
+}
+
+static void add_memslot(struct kvm_vm *vm, uint64_t gpa, uint32_t slot,
+			uint64_t size, int guest_memfd,
+			uint64_t guest_memfd_offset)
+{
+	struct userspace_mem_region *region;
+
+	region = vm_mem_region_alloc(vm);
+
+	guest_memfd = vm_mem_region_install_guest_memfd(region, guest_memfd);
+
+	vm_mem_region_mmap(region, size, MAP_SHARED, guest_memfd, guest_memfd_offset);
+	vm_mem_region_install_memory(region, size, getpagesize());
+
+	region->region.slot = slot;
+	region->region.flags = KVM_MEM_GUEST_MEMFD;
+	region->region.guest_phys_addr = gpa;
+	region->region.guest_memfd_offset = guest_memfd_offset;
+
+	vm_mem_region_add(vm, region);
+}
+
 static bool run_vcpus;
 
-static void *__test_mem_conversions(void *__vcpu)
+struct test_thread_args
 {
-	struct kvm_vcpu *vcpu = __vcpu;
+	struct kvm_vcpu *vcpu;
+	bool back_shared_memory_with_guest_memfd;
+};
+
+static void *__test_mem_conversions(void *params)
+{
+	struct test_thread_args *args = params;
+	struct kvm_vcpu *vcpu = args->vcpu;
 	struct kvm_run *run = vcpu->run;
 	struct kvm_vm *vm = vcpu->vm;
 	struct ucall uc;
@@ -325,7 +395,10 @@ static void *__test_mem_conversions(void *__vcpu)
 		vcpu_run(vcpu);
 
 		if (run->exit_reason == KVM_EXIT_HYPERCALL) {
-			handle_exit_hypercall(vcpu);
+			handle_exit_hypercall(
+				vcpu,
+				args->back_shared_memory_with_guest_memfd);
+
 			continue;
 		}
 
@@ -349,8 +422,18 @@ static void *__test_mem_conversions(void *__vcpu)
 				size_t nr_bytes = min_t(size_t, vm->page_size, size - i);
 				uint8_t *hva = addr_gpa2hva(vm, gpa + i);
 
-				/* In all cases, the host should observe the shared data. */
-				memcmp_h(hva, gpa + i, uc.args[3], nr_bytes);
+				/* Check contents of memory */
+				if (args->back_shared_memory_with_guest_memfd &&
+				    uc.args[0] == SYNC_PRIVATE) {
+					assert_not_faultable(hva);
+				} else {
+					/*
+					 * If shared and private memory use
+					 * separate backing memory, the host
+					 * should always observe shared data.
+					 */
+					memcmp_h(hva, gpa + i, uc.args[3], nr_bytes);
+				}
 
 				/* For shared, write the new pattern to guest memory. */
 				if (uc.args[0] == SYNC_SHARED)
@@ -366,14 +449,16 @@ static void *__test_mem_conversions(void *__vcpu)
 	}
 }
 
-static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t nr_vcpus,
-				 uint32_t nr_memslots)
+static void test_mem_conversions(enum vm_mem_backing_src_type src_type,
+				 uint32_t nr_vcpus, uint32_t nr_memslots,
+				 bool back_shared_memory_with_guest_memfd)
 {
 	/*
 	 * Allocate enough memory so that each vCPU's chunk of memory can be
 	 * naturally aligned with respect to the size of the backing store.
 	 */
 	const size_t alignment = max_t(size_t, SZ_2M, get_backing_src_pagesz(src_type));
+	struct test_thread_args *thread_args[KVM_MAX_VCPUS];
 	const size_t per_cpu_size = align_up(PER_CPU_DATA_SIZE, alignment);
 	const size_t memfd_size = per_cpu_size * nr_vcpus;
 	const size_t slot_size = memfd_size / nr_memslots;
@@ -381,6 +466,7 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t
 	pthread_t threads[KVM_MAX_VCPUS];
 	struct kvm_vm *vm;
 	int memfd, i, r;
+	uint64_t flags;
 
 	const struct vm_shape shape = {
 		.mode = VM_MODE_DEFAULT,
@@ -394,12 +480,23 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t
 
 	vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, (1 << KVM_HC_MAP_GPA_RANGE));
 
-	memfd = vm_create_guest_memfd(vm, memfd_size, 0);
+	flags = back_shared_memory_with_guest_memfd ?
+			GUEST_MEMFD_FLAG_SUPPORT_SHARED :
+			0;
+	memfd = vm_create_guest_memfd(vm, memfd_size, flags);
 
-	for (i = 0; i < nr_memslots; i++)
-		vm_mem_add(vm, src_type, BASE_DATA_GPA + slot_size * i,
-			   BASE_DATA_SLOT + i, slot_size / vm->page_size,
-			   KVM_MEM_GUEST_MEMFD, memfd, slot_size * i);
+	for (i = 0; i < nr_memslots; i++) {
+		if (back_shared_memory_with_guest_memfd) {
+			add_memslot(vm, BASE_DATA_GPA + slot_size * i,
+				    BASE_DATA_SLOT + i, slot_size, memfd,
+				    slot_size * i);
+		} else {
+			vm_mem_add(vm, src_type, BASE_DATA_GPA + slot_size * i,
+				   BASE_DATA_SLOT + i,
+				   slot_size / vm->page_size,
+				   KVM_MEM_GUEST_MEMFD, memfd, slot_size * i);
+		}
+	}
 
 	for (i = 0; i < nr_vcpus; i++) {
 		uint64_t gpa =  BASE_DATA_GPA + i * per_cpu_size;
@@ -412,13 +509,23 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t
 		 */
 		virt_map(vm, gpa, gpa, PER_CPU_DATA_SIZE / vm->page_size);
 
-		pthread_create(&threads[i], NULL, __test_mem_conversions, vcpus[i]);
+		thread_args[i] = malloc(sizeof(struct test_thread_args));
+		TEST_ASSERT(thread_args[i] != NULL,
+			    "Could not allocate memory for thread parameters");
+		thread_args[i]->vcpu = vcpus[i];
+		thread_args[i]->back_shared_memory_with_guest_memfd =
+			back_shared_memory_with_guest_memfd;
+
+		pthread_create(&threads[i], NULL, __test_mem_conversions,
+			       (void *)thread_args[i]);
 	}
 
 	WRITE_ONCE(run_vcpus, true);
 
-	for (i = 0; i < nr_vcpus; i++)
+	for (i = 0; i < nr_vcpus; i++) {
 		pthread_join(threads[i], NULL);
+		free(thread_args[i]);
+	}
 
 	kvm_vm_free(vm);
 
@@ -440,7 +547,7 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t
 static void usage(const char *cmd)
 {
 	puts("");
-	printf("usage: %s [-h] [-m nr_memslots] [-s mem_type] [-n nr_vcpus]\n", cmd);
+	printf("usage: %s [-h] [-g] [-m nr_memslots] [-s mem_type] [-n nr_vcpus]\n", cmd);
 	puts("");
 	backing_src_help("-s");
 	puts("");
@@ -448,18 +555,21 @@ static void usage(const char *cmd)
 	puts("");
 	puts(" -m: specify the number of memslots (default: 1)");
 	puts("");
+	puts(" -g: back shared memory with guest_memfd (default: false)");
+	puts("");
 }
 
 int main(int argc, char *argv[])
 {
 	enum vm_mem_backing_src_type src_type = DEFAULT_VM_MEM_SRC;
+	bool back_shared_memory_with_guest_memfd = false;
 	uint32_t nr_memslots = 1;
 	uint32_t nr_vcpus = 1;
 	int opt;
 
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
 
-	while ((opt = getopt(argc, argv, "hm:s:n:")) != -1) {
+	while ((opt = getopt(argc, argv, "hgm:s:n:")) != -1) {
 		switch (opt) {
 		case 's':
 			src_type = parse_backing_src_type(optarg);
@@ -470,6 +580,9 @@ int main(int argc, char *argv[])
 		case 'm':
 			nr_memslots = atoi_positive("nr_memslots", optarg);
 			break;
+		case 'g':
+			back_shared_memory_with_guest_memfd = true;
+			break;
 		case 'h':
 		default:
 			usage(argv[0]);
@@ -477,7 +590,9 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	test_mem_conversions(src_type, nr_vcpus, nr_memslots);
+	test_mem_conversions(src_type, nr_vcpus, nr_memslots,
+			     back_shared_memory_with_guest_memfd);
+
 
 	return 0;
 }
-- 
2.49.0.1045.g170613ef41-goog


