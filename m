Return-Path: <linux-fsdevel+bounces-49037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 509B0AB79BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 215497B9C2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3412E23AE66;
	Wed, 14 May 2025 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NUPQqZe2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584802367B4
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266198; cv=none; b=LBM7lICrs0zqpL3hxl0PgOzlJ2f9xpS7bpFsXZUp9tjM+fDXnMVO2LUqHuLO4OkZAU1o9466nPABWO0u5cuAb3WA5w7sfkKc8arBf/XXeWEJ0ENDuXeH5Ky6kFn1VPuUyCE/+VxwvGssnSShj66LcrGfpnVsokvt3uw8X441PHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266198; c=relaxed/simple;
	bh=Lmy/KateIDIbX1Vh/hc3V4OevV55wK08eNct+myEsr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lexl1VdCL4UGUxXjeBxgf0CGi8issCIdo537iXoUuoi6dxYV9o6rgGhLpLm5J43XWfxmRC1dkHhNbTCF/biFc/lXrhFJ8XUYRURxq7gPovD1MiRq0LJSaKKcwf57Cri1pOG8+S5hEyxnDU3j0rRmXqPPfZHpBduCPHVq9uEerHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NUPQqZe2; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30c9b0aa4ccso332441a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266196; x=1747870996; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FoX8u9X05EseKGiP0Nc90upAeUnBU0ZxWjayZNH51Ts=;
        b=NUPQqZe2QGdmJdLKDClCFij2JW9xsxvUzq8rR/66X24mKbn6DJpq59MqlBJd/aKxos
         +oMsjl1s/0AMjOmIdAFaYWTpyIg+ubYXoWsPf48fyVdPohIdzDezyoj0R3OUrkviNKqt
         YKDh4lwzdRj+PdIPJwugBvvntBEueabZeo081B21VkehR5tUsMN/qRVRoo/dBxfwRvmV
         /4Fg3xzFHV4qF1fdS5R9AjJ8NfFZ3JszNoYoz+apVnc++kzrvYscGon7Czmf+fEMjfgw
         NTfeOpHc3WWMOU4/Zdhvc+QEm5HwuYOLwDjmR9+7YH42XPw2Sz/BfL/LVems5D4tt4xL
         9pMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266196; x=1747870996;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FoX8u9X05EseKGiP0Nc90upAeUnBU0ZxWjayZNH51Ts=;
        b=TcRYRTzMGMCH98IA8b2eGA5qODG54uUTuxbIMvy4w1OdBlrRAhsCkXmiGg8N4UMwGm
         2YAGUXt0tZYCgJ0x4cLB5Z+wehIb78i9M+sWHkx393am4/RDWHYtHGky2NEHmXdkGO2a
         4jze2AOh+Osn89ykvKPFexLFI6uKSIDScIhV5mihPNU6YJdW7o24aHmDTxc0TsEnhbHq
         7fwTR1JtrCU214sJ58Ud7PCAB8n8TePdNwEHRrdSIER57jlVfmStmr5MkLvLs8Ui53EY
         oItaYzoqV54sFFtlBMvaSisjcFuAYz1UlaLMOx+rDRRKHfXqMW2KjG7hxMZHRzosXgCp
         TOGA==
X-Forwarded-Encrypted: i=1; AJvYcCXychPTQiDBpFyDIEcq93SwkDKMp5Y7dvcvDqTJBMe7umrRie66tNKefniAgB9FV0gmAlDPFYZfOwpbihZe@vger.kernel.org
X-Gm-Message-State: AOJu0YyEW0Fxgn2V2D9JyCKYv3pP1hWslJBNaulz3R0v6Wc/Cd6+sPNe
	SUbHY2Ml9vwgLUot4sd1W38XrMxyDXxLEur7tygY8FuuMSNybxi8cPnsF1ns12vDJXogcbp+iUJ
	ENkw4+wr1U3ddjVCvULSSUw==
X-Google-Smtp-Source: AGHT+IGaGSkp5qHaaTiIyneH7AsmROzySAlzDj2Uoqwi8z9+GG2j6Ou9TrD4KSKnauVFr0+nXqu29XWOBaPDldfVrA==
X-Received: from pjbpw18.prod.google.com ([2002:a17:90b:2792:b0:2fe:800f:23a])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5305:b0:30e:3834:4be6 with SMTP id 98e67ed59e1d1-30e38344ce3mr5416198a91.3.1747266195801;
 Wed, 14 May 2025 16:43:15 -0700 (PDT)
Date: Wed, 14 May 2025 16:41:51 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <baa8838f623102931e755cf34c86314b305af49c.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 12/51] KVM: selftests: Test conversion flows for guest_memfd
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

Add minimal tests for guest_memfd to test that when memory is marked
shared in a VM, the host can read and write to it via an mmap()ed
address, and the guest can also read and write to it.

Tests added in this patch use refcounts taken via GUP (requiring
CONFIG_GUP_TEST) to simulate unexpected refcounts on guest_memfd
pages.

Test that unexpected refcounts cause conversions to fail.

Change-Id: I4f8c05aa511bcb9a34921a54fc8315ed89629018
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/guest_memfd_conversions_test.c        | 589 ++++++++++++++++++
 .../testing/selftests/kvm/include/kvm_util.h  |  74 +++
 3 files changed, 664 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_conversions_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index ccf95ed037c3..bc22a5a23c4c 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -131,6 +131,7 @@ TEST_GEN_PROGS_x86 += access_tracking_perf_test
 TEST_GEN_PROGS_x86 += coalesced_io_test
 TEST_GEN_PROGS_x86 += dirty_log_perf_test
 TEST_GEN_PROGS_x86 += guest_memfd_test
+TEST_GEN_PROGS_x86 += guest_memfd_conversions_test
 TEST_GEN_PROGS_x86 += hardware_disable_test
 TEST_GEN_PROGS_x86 += memslot_modification_stress_test
 TEST_GEN_PROGS_x86 += memslot_perf_test
diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
new file mode 100644
index 000000000000..34eb6c9a37b1
--- /dev/null
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -0,0 +1,589 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test conversion flows for guest_memfd.
+ *
+ * Copyright (c) 2024, Google LLC.
+ */
+#include <linux/kvm.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "test_util.h"
+#include "ucall_common.h"
+#include "../../../../mm/gup_test.h"
+
+#define GUEST_MEMFD_SHARING_TEST_SLOT 10
+/*
+ * Use high GPA above APIC_DEFAULT_PHYS_BASE to avoid clashing with
+ * APIC_DEFAULT_PHYS_BASE.
+ */
+#define GUEST_MEMFD_SHARING_TEST_GPA 0x100000000ULL
+#define GUEST_MEMFD_SHARING_TEST_GVA 0x90000000ULL
+
+static int gup_test_fd;
+
+static void pin_pages(void *vaddr, uint64_t size)
+{
+	const struct pin_longterm_test args = {
+		.addr = (uint64_t)vaddr,
+		.size = size,
+		.flags = PIN_LONGTERM_TEST_FLAG_USE_WRITE,
+	};
+
+	gup_test_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
+	TEST_REQUIRE(gup_test_fd > 0);
+
+	TEST_ASSERT_EQ(ioctl(gup_test_fd, PIN_LONGTERM_TEST_START, &args), 0);
+}
+
+static void unpin_pages(void)
+{
+	TEST_ASSERT_EQ(ioctl(gup_test_fd, PIN_LONGTERM_TEST_STOP), 0);
+}
+
+static void guest_check_mem(uint64_t gva, char expected_read_value, char write_value)
+{
+	char *mem = (char *)gva;
+
+	if (expected_read_value != 'X')
+		GUEST_ASSERT_EQ(*mem, expected_read_value);
+
+	if (write_value != 'X')
+		*mem = write_value;
+
+	GUEST_DONE();
+}
+
+static int vcpu_run_handle_basic_ucalls(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+	int rc;
+
+keep_going:
+	do {
+		rc = __vcpu_run(vcpu);
+	} while (rc == -1 && errno == EINTR);
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_PRINTF:
+		REPORT_GUEST_PRINTF(uc);
+		goto keep_going;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+	}
+
+	return rc;
+}
+
+/**
+ * guest_use_memory() - Assert that guest can use memory at @gva.
+ *
+ * @vcpu: the vcpu to run this test on.
+ * @gva: the virtual address in the guest to try to use.
+ * @expected_read_value: the value that is expected at @gva. Set this to 'X' to
+ *                       skip checking current value.
+ * @write_value: value to write to @gva. Set to 'X' to skip writing value to
+ *               @address.
+ * @expected_errno: the expected errno if an error is expected while reading or
+ *                  writing @gva. Set to 0 if no exception is expected,
+ *                  otherwise set it to the expected errno. If @expected_errno
+ *                  is set, 'Z' is used instead of @expected_read_value or
+ *                  @write_value.
+ */
+static void guest_use_memory(struct kvm_vcpu *vcpu, uint64_t gva,
+			     char expected_read_value, char write_value,
+			     int expected_errno)
+{
+	struct kvm_regs original_regs;
+	int rc;
+
+	if (expected_errno > 0) {
+		expected_read_value = 'Z';
+		write_value = 'Z';
+	}
+
+	/*
+	 * Backup and vCPU state from first run so that guest_check_mem can be
+	 * run again and again.
+	 */
+	vcpu_regs_get(vcpu, &original_regs);
+
+	vcpu_args_set(vcpu, 3, gva, expected_read_value, write_value);
+	vcpu_arch_set_entry_point(vcpu, guest_check_mem);
+
+	rc = vcpu_run_handle_basic_ucalls(vcpu);
+
+	if (expected_errno) {
+		TEST_ASSERT_EQ(rc, -1);
+		TEST_ASSERT_EQ(errno, expected_errno);
+
+		switch (expected_errno) {
+		case EFAULT:
+			TEST_ASSERT_EQ(vcpu->run->exit_reason, 0);
+			break;
+		case EACCES:
+			TEST_ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_MEMORY_FAULT);
+			break;
+		}
+	} else {
+		struct ucall uc;
+
+		TEST_ASSERT_EQ(rc, 0);
+		TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_DONE);
+
+		/*
+		 * UCALL_DONE() uses up one struct ucall slot. To reuse the slot
+		 * in another run of guest_check_mem, free up that slot.
+		 */
+		ucall_free((struct ucall *)uc.hva);
+	}
+
+	vcpu_regs_set(vcpu, &original_regs);
+}
+
+/**
+ * host_use_memory() - Assert that host can fault and use memory at @address.
+ *
+ * @address: the address to be testing.
+ * @expected_read_value: the value expected to be read from @address. Set to 'X'
+ *                       to skip checking current value at @address.
+ * @write_value: the value to write to @address. Set to 'X' to skip writing
+ *               value to @address.
+ */
+static void host_use_memory(char *address, char expected_read_value,
+			    char write_value)
+{
+	if (expected_read_value != 'X')
+		TEST_ASSERT_EQ(*address, expected_read_value);
+
+	if (write_value != 'X')
+		*address = write_value;
+}
+
+static void assert_host_cannot_fault(char *address)
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
+static void *add_memslot(struct kvm_vm *vm, size_t memslot_size, int guest_memfd)
+{
+	struct userspace_mem_region *region;
+	void *mem;
+
+	TEST_REQUIRE(guest_memfd > 0);
+
+	region = vm_mem_region_alloc(vm);
+
+	guest_memfd = vm_mem_region_install_guest_memfd(region, guest_memfd);
+	mem = vm_mem_region_mmap(region, memslot_size, MAP_SHARED, guest_memfd, 0);
+	vm_mem_region_install_memory(region, memslot_size, PAGE_SIZE);
+
+	region->region.slot = GUEST_MEMFD_SHARING_TEST_SLOT;
+	region->region.flags = KVM_MEM_GUEST_MEMFD;
+	region->region.guest_phys_addr = GUEST_MEMFD_SHARING_TEST_GPA;
+	region->region.guest_memfd_offset = 0;
+
+	vm_mem_region_add(vm, region);
+
+	return mem;
+}
+
+static struct kvm_vm *setup_test(size_t test_page_size, bool init_private,
+				 struct kvm_vcpu **vcpu, int *guest_memfd,
+				 char **mem)
+{
+	const struct vm_shape shape = {
+		.mode = VM_MODE_DEFAULT,
+		.type = KVM_X86_SW_PROTECTED_VM,
+	};
+	size_t test_nr_pages;
+	struct kvm_vm *vm;
+	uint64_t flags;
+
+	test_nr_pages = test_page_size / PAGE_SIZE;
+	vm = __vm_create_shape_with_one_vcpu(shape, vcpu, test_nr_pages, NULL);
+
+	flags = GUEST_MEMFD_FLAG_SUPPORT_SHARED;
+	if (init_private)
+		flags |= GUEST_MEMFD_FLAG_INIT_PRIVATE;
+
+	*guest_memfd = vm_create_guest_memfd(vm, test_page_size, flags);
+	TEST_ASSERT(*guest_memfd > 0, "guest_memfd creation failed");
+
+	*mem = add_memslot(vm, test_page_size, *guest_memfd);
+
+	virt_map(vm, GUEST_MEMFD_SHARING_TEST_GVA, GUEST_MEMFD_SHARING_TEST_GPA,
+		 test_nr_pages);
+
+	return vm;
+}
+
+static void cleanup_test(size_t guest_memfd_size, struct kvm_vm *vm,
+			 int guest_memfd, char *mem)
+{
+	kvm_vm_free(vm);
+	TEST_ASSERT_EQ(munmap(mem, guest_memfd_size), 0);
+
+	if (guest_memfd > -1)
+		TEST_ASSERT_EQ(close(guest_memfd), 0);
+}
+
+static void test_sharing(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int guest_memfd;
+	char *mem;
+
+	vm = setup_test(PAGE_SIZE, /*init_private=*/false, &vcpu, &guest_memfd, &mem);
+
+	host_use_memory(mem, 'X', 'A');
+	guest_use_memory(vcpu, GUEST_MEMFD_SHARING_TEST_GVA, 'A', 'B', 0);
+
+	/* Toggle private flag of memory attributes and run the test again. */
+	guest_memfd_convert_private(guest_memfd, 0, PAGE_SIZE);
+
+	assert_host_cannot_fault(mem);
+	guest_use_memory(vcpu, GUEST_MEMFD_SHARING_TEST_GVA, 'B', 'C', 0);
+
+	guest_memfd_convert_shared(guest_memfd, 0, PAGE_SIZE);
+
+	host_use_memory(mem, 'C', 'D');
+	guest_use_memory(vcpu, GUEST_MEMFD_SHARING_TEST_GVA, 'D', 'E', 0);
+
+	cleanup_test(PAGE_SIZE, vm, guest_memfd, mem);
+}
+
+static void test_init_mappable_false(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int guest_memfd;
+	char *mem;
+
+	vm = setup_test(PAGE_SIZE, /*init_private=*/true, &vcpu, &guest_memfd, &mem);
+
+	assert_host_cannot_fault(mem);
+	guest_use_memory(vcpu, GUEST_MEMFD_SHARING_TEST_GVA, 'X', 'A', 0);
+
+	guest_memfd_convert_shared(guest_memfd, 0, PAGE_SIZE);
+
+	host_use_memory(mem, 'A', 'B');
+	guest_use_memory(vcpu, GUEST_MEMFD_SHARING_TEST_GVA, 'B', 'C', 0);
+
+	cleanup_test(PAGE_SIZE, vm, guest_memfd, mem);
+}
+
+/*
+ * Test that even if there are no folios yet, conversion requests are recorded
+ * in guest_memfd.
+ */
+static void test_conversion_before_allocation(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int guest_memfd;
+	char *mem;
+
+	vm = setup_test(PAGE_SIZE, /*init_private=*/false, &vcpu, &guest_memfd, &mem);
+
+	guest_memfd_convert_private(guest_memfd, 0, PAGE_SIZE);
+
+	assert_host_cannot_fault(mem);
+	guest_use_memory(vcpu, GUEST_MEMFD_SHARING_TEST_GVA, 'X', 'A', 0);
+
+	guest_memfd_convert_shared(guest_memfd, 0, PAGE_SIZE);
+
+	host_use_memory(mem, 'A', 'B');
+	guest_use_memory(vcpu, GUEST_MEMFD_SHARING_TEST_GVA, 'B', 'C', 0);
+
+	cleanup_test(PAGE_SIZE, vm, guest_memfd, mem);
+}
+
+static void __test_conversion_if_not_all_folios_allocated(int total_nr_pages,
+							  int page_to_fault)
+{
+	const int second_page_to_fault = 8;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	size_t total_size;
+	int guest_memfd;
+	char *mem;
+	int i;
+
+	total_size = PAGE_SIZE * total_nr_pages;
+	vm = setup_test(total_size, /*init_private=*/false, &vcpu, &guest_memfd, &mem);
+
+	/*
+	 * Fault 2 of the pages to test filemap range operations except when
+	 * page_to_fault == second_page_to_fault.
+	 */
+	host_use_memory(mem + page_to_fault * PAGE_SIZE, 'X', 'A');
+	host_use_memory(mem + second_page_to_fault * PAGE_SIZE, 'X', 'A');
+
+	guest_memfd_convert_private(guest_memfd, 0, total_size);
+
+	for (i = 0; i < total_nr_pages; ++i) {
+		bool is_faulted;
+		char expected;
+
+		assert_host_cannot_fault(mem + i * PAGE_SIZE);
+
+		is_faulted = i == page_to_fault || i == second_page_to_fault;
+		expected = is_faulted ? 'A' : 'X';
+		guest_use_memory(vcpu,
+				 GUEST_MEMFD_SHARING_TEST_GVA + i * PAGE_SIZE,
+				 expected, 'B', 0);
+	}
+
+	guest_memfd_convert_shared(guest_memfd, 0, total_size);
+
+	for (i = 0; i < total_nr_pages; ++i) {
+		host_use_memory(mem + i * PAGE_SIZE, 'B', 'C');
+		guest_use_memory(vcpu,
+				 GUEST_MEMFD_SHARING_TEST_GVA + i * PAGE_SIZE,
+				 'C', 'D', 0);
+	}
+
+	cleanup_test(total_size, vm, guest_memfd, mem);
+}
+
+static void test_conversion_if_not_all_folios_allocated(void)
+{
+	const int total_nr_pages = 16;
+	int i;
+
+	for (i = 0; i < total_nr_pages; ++i)
+		__test_conversion_if_not_all_folios_allocated(total_nr_pages, i);
+}
+
+static void test_conversions_should_not_affect_surrounding_pages(void)
+{
+	struct kvm_vcpu *vcpu;
+	int page_to_convert;
+	struct kvm_vm *vm;
+	size_t total_size;
+	int guest_memfd;
+	int nr_pages;
+	char *mem;
+	int i;
+
+	page_to_convert = 2;
+	nr_pages = 4;
+	total_size = PAGE_SIZE * nr_pages;
+
+	vm = setup_test(total_size, /*init_private=*/false, &vcpu, &guest_memfd, &mem);
+
+	for (i = 0; i < nr_pages; ++i) {
+		host_use_memory(mem + i * PAGE_SIZE, 'X', 'A');
+		guest_use_memory(vcpu, GUEST_MEMFD_SHARING_TEST_GVA + i * PAGE_SIZE,
+				 'A', 'B', 0);
+	}
+
+	guest_memfd_convert_private(guest_memfd, PAGE_SIZE * page_to_convert, PAGE_SIZE);
+
+
+	for (i = 0; i < nr_pages; ++i) {
+		char to_check;
+
+		if (i == page_to_convert) {
+			assert_host_cannot_fault(mem + i * PAGE_SIZE);
+			to_check = 'B';
+		} else {
+			host_use_memory(mem + i * PAGE_SIZE, 'B', 'C');
+			to_check = 'C';
+		}
+
+		guest_use_memory(vcpu, GUEST_MEMFD_SHARING_TEST_GVA + i * PAGE_SIZE,
+				 to_check, 'D', 0);
+	}
+
+	guest_memfd_convert_shared(guest_memfd, PAGE_SIZE * page_to_convert, PAGE_SIZE);
+
+
+	for (i = 0; i < nr_pages; ++i) {
+		host_use_memory(mem + i * PAGE_SIZE, 'D', 'E');
+		guest_use_memory(vcpu, GUEST_MEMFD_SHARING_TEST_GVA + i * PAGE_SIZE,
+				 'E', 'F', 0);
+	}
+
+	cleanup_test(total_size, vm, guest_memfd, mem);
+}
+
+static void __test_conversions_should_fail_if_memory_has_elevated_refcount(
+	int nr_pages, int page_to_convert)
+{
+	struct kvm_vcpu *vcpu;
+	loff_t error_offset;
+	struct kvm_vm *vm;
+	size_t total_size;
+	int guest_memfd;
+	char *mem;
+	int ret;
+	int i;
+
+	total_size = PAGE_SIZE * nr_pages;
+	vm = setup_test(total_size, /*init_private=*/false, &vcpu, &guest_memfd, &mem);
+
+	pin_pages(mem + page_to_convert * PAGE_SIZE, PAGE_SIZE);
+
+	for (i = 0; i < nr_pages; i++) {
+		host_use_memory(mem + i * PAGE_SIZE, 'X', 'A');
+		guest_use_memory(vcpu, GUEST_MEMFD_SHARING_TEST_GVA + i * PAGE_SIZE,
+				 'A', 'B', 0);
+	}
+
+	error_offset = 0;
+	ret = __guest_memfd_convert_private(guest_memfd, page_to_convert * PAGE_SIZE,
+					    PAGE_SIZE, &error_offset);
+	TEST_ASSERT_EQ(ret, -1);
+	TEST_ASSERT_EQ(errno, EAGAIN);
+	TEST_ASSERT_EQ(error_offset, page_to_convert * PAGE_SIZE);
+
+	unpin_pages();
+
+	guest_memfd_convert_private(guest_memfd, page_to_convert * PAGE_SIZE, PAGE_SIZE);
+
+	for (i = 0; i < nr_pages; i++) {
+		char expected;
+
+		if (i == page_to_convert)
+			assert_host_cannot_fault(mem + i * PAGE_SIZE);
+		else
+			host_use_memory(mem + i * PAGE_SIZE, 'B', 'C');
+
+		expected = i == page_to_convert ? 'X' : 'C';
+		guest_use_memory(vcpu, GUEST_MEMFD_SHARING_TEST_GVA + i * PAGE_SIZE,
+				 expected, 'D', 0);
+	}
+
+	guest_memfd_convert_shared(guest_memfd, page_to_convert * PAGE_SIZE, PAGE_SIZE);
+
+
+	for (i = 0; i < nr_pages; i++) {
+		char expected = i == page_to_convert ? 'X' : 'D';
+
+		host_use_memory(mem + i * PAGE_SIZE, expected, 'E');
+		guest_use_memory(vcpu,
+				 GUEST_MEMFD_SHARING_TEST_GVA + i * PAGE_SIZE,
+				 'E', 'F', 0);
+	}
+
+	cleanup_test(total_size, vm, guest_memfd, mem);
+}
+/*
+ * This test depends on CONFIG_GUP_TEST to provide a kernel module that exposes
+ * pin_user_pages() to userspace.
+ */
+static void test_conversions_should_fail_if_memory_has_elevated_refcount(void)
+{
+	int i;
+
+	for (i = 0; i < 4; i++)
+		__test_conversions_should_fail_if_memory_has_elevated_refcount(4, i);
+}
+
+static void test_truncate_should_not_change_mappability(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int guest_memfd;
+	char *mem;
+	int ret;
+
+	vm = setup_test(PAGE_SIZE, /*init_private=*/false, &vcpu, &guest_memfd, &mem);
+
+	host_use_memory(mem, 'X', 'A');
+
+	ret = fallocate(guest_memfd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
+			0, PAGE_SIZE);
+	TEST_ASSERT(!ret, "truncating the first page should succeed");
+
+	host_use_memory(mem, 'X', 'A');
+
+	guest_memfd_convert_private(guest_memfd, 0, PAGE_SIZE);
+
+	assert_host_cannot_fault(mem);
+	guest_use_memory(vcpu, GUEST_MEMFD_SHARING_TEST_GVA, 'A', 'A', 0);
+
+	ret = fallocate(guest_memfd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
+			0, PAGE_SIZE);
+	TEST_ASSERT(!ret, "truncating the first page should succeed");
+
+	assert_host_cannot_fault(mem);
+	guest_use_memory(vcpu, GUEST_MEMFD_SHARING_TEST_GVA, 'X', 'A', 0);
+
+	cleanup_test(PAGE_SIZE, vm, guest_memfd, mem);
+}
+
+static void test_fault_type_independent_of_mem_attributes(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int guest_memfd;
+	char *mem;
+
+	vm = setup_test(PAGE_SIZE, /*init_private=*/true, &vcpu, &guest_memfd, &mem);
+	vm_mem_set_shared(vm, GUEST_MEMFD_SHARING_TEST_GPA, PAGE_SIZE);
+
+	/*
+	 * kvm->mem_attr_array set to shared, guest_memfd memory initialized as
+	 * private.
+	 */
+
+	/* Host cannot use private memory. */
+	assert_host_cannot_fault(mem);
+
+	/* Guest can fault and use memory. */
+	guest_use_memory(vcpu, GUEST_MEMFD_SHARING_TEST_GVA, 'X', 'A', 0);
+
+	guest_memfd_convert_shared(guest_memfd, 0, PAGE_SIZE);
+	vm_mem_set_private(vm, GUEST_MEMFD_SHARING_TEST_GPA, PAGE_SIZE);
+
+	/* Host can use shared memory. */
+	host_use_memory(mem, 'X', 'A');
+
+	/* Guest can also use shared memory. */
+	guest_use_memory(vcpu, GUEST_MEMFD_SHARING_TEST_GVA, 'X', 'A', 0);
+
+	cleanup_test(PAGE_SIZE, vm, guest_memfd, mem);
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_GMEM_SHARED_MEM));
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_GMEM_CONVERSION));
+
+	test_sharing();
+	test_init_mappable_false();
+	test_conversion_before_allocation();
+	test_conversion_if_not_all_folios_allocated();
+	test_conversions_should_not_affect_surrounding_pages();
+	test_truncate_should_not_change_mappability();
+	test_conversions_should_fail_if_memory_has_elevated_refcount();
+	test_fault_type_independent_of_mem_attributes();
+
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 853ab68cff79..ffe0625f2d71 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -18,11 +18,13 @@
 #include <asm/atomic.h>
 #include <asm/kvm.h>
 
+#include <string.h>
 #include <sys/ioctl.h>
 
 #include "kvm_util_arch.h"
 #include "kvm_util_types.h"
 #include "sparsebit.h"
+#include <sys/types.h>
 
 #define KVM_DEV_PATH "/dev/kvm"
 #define KVM_MAX_VCPUS 512
@@ -426,6 +428,78 @@ static inline void vm_mem_set_shared(struct kvm_vm *vm, uint64_t gpa,
 	vm_set_memory_attributes(vm, gpa, size, 0);
 }
 
+static inline int __guest_memfd_convert_private(int guest_memfd, loff_t offset,
+						size_t size, loff_t *error_offset)
+{
+	int ret;
+
+	struct kvm_gmem_convert param = {
+		.offset = offset,
+		.size = size,
+		.error_offset = 0,
+	};
+
+	ret = ioctl(guest_memfd, KVM_GMEM_CONVERT_PRIVATE, &param);
+	if (ret)
+		*error_offset = param.error_offset;
+
+	return ret;
+}
+
+static inline void guest_memfd_convert_private(int guest_memfd, loff_t offset,
+					       size_t size)
+{
+	loff_t error_offset;
+	int retries;
+	int ret;
+
+	retries = 2;
+	do {
+		error_offset = 0;
+		ret = __guest_memfd_convert_private(guest_memfd, offset, size,
+						    &error_offset);
+	} while (ret == -1 && errno == EAGAIN && --retries > 0);
+
+	TEST_ASSERT(!ret, "Unexpected error %s (%m) at offset 0x%lx",
+		    strerrorname_np(errno), error_offset);
+}
+
+static inline int __guest_memfd_convert_shared(int guest_memfd, loff_t offset,
+					       size_t size, loff_t *error_offset)
+{
+	int ret;
+
+	struct kvm_gmem_convert param = {
+		.offset = offset,
+		.size = size,
+		.error_offset = 0,
+	};
+
+	ret = ioctl(guest_memfd, KVM_GMEM_CONVERT_SHARED, &param);
+	if (ret)
+		*error_offset = param.error_offset;
+
+	return ret;
+}
+
+static inline void guest_memfd_convert_shared(int guest_memfd, loff_t offset,
+					      size_t size)
+{
+	loff_t error_offset;
+	int retries;
+	int ret;
+
+	retries = 2;
+	do {
+		error_offset = 0;
+		ret = __guest_memfd_convert_shared(guest_memfd, offset, size,
+						    &error_offset);
+	} while (ret == -1 && errno == EAGAIN && --retries > 0);
+
+	TEST_ASSERT(!ret, "Unexpected error %s (%m) at offset 0x%lx",
+		    strerrorname_np(errno), error_offset);
+}
+
 void vm_guest_mem_fallocate(struct kvm_vm *vm, uint64_t gpa, uint64_t size,
 			    bool punch_hole);
 
-- 
2.49.0.1045.g170613ef41-goog


