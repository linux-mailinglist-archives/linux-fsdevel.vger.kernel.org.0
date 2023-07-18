Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE3675899B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 01:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjGRXw7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 19:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjGRXvu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 19:51:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E2A30E5
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 16:50:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c926075a50cso382196276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 16:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689724159; x=1692316159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8jGloLcQRqDJd4bG/+docoOJ7NtGfJVSr5WkEp3/r5Q=;
        b=KtJGydbuprz9TEKiXSzt30hwmcKkKrIoU0Ew7nvPQobIitdGdQc5qUhte8t9pH6LKq
         WPPHL2Qh1OXRBnqeOG+rJ3daiTeYWOELS6cuYJG0cpGNJeL/0mvgeC8vHDO/DuKKuXNC
         624jU9Q47swBkGhrHJimYDGHFYM+CFq8Kt8QbiKvScWeCy8vAUcgG0qXT355OkzndjaN
         9SvgnAnvGsqMRPUIVcOti+3E2CHotBVVLWk5EkXXei+c8TutgR7NvwCGuLtGE1QG//sw
         fprKupkumGv9tX7leRApqzZUcstS20HEyz+eA9Onk1X9pIP7R+COEO7F9NsUW++2G9tB
         qBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689724159; x=1692316159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jGloLcQRqDJd4bG/+docoOJ7NtGfJVSr5WkEp3/r5Q=;
        b=Kq/DCN95C0l7ALG1edr8mpHC0EFfyocPjtHrOcLQ3irXXf+yRy7iCkzt2nrfurTsCC
         dSN2lupMiM44XptDO1di2iuZxq5zNA/miJic+g205sDrXfB9bwmuhE175HXoAxn4oS63
         VGcNiJVl4FY4JXorEq72TmsaTYSolBEw5dtiBQir8v8i9mqOkOwCq1gKgPwMlecuQTlT
         M5SG/zpV4E4mtztsLUPY8Q5O+ZI/iEwqAEOUDodmy47zeNMqXpDc2AdM3S5dnXeHoHCg
         D5msIwGN1haO8ffGK4YqhGXN9Jhr7ZYFXL+ZHtZnChlB27aly18jJFq62ji1FgnVsnMx
         U9qw==
X-Gm-Message-State: ABy/qLYJFpkl5BKF4NlMP+TL2ceC5rGtkvAciecRHOa66szFyb/rE5Ib
        EnZI7H8ZVfRaUJ3tvJ+Wc2cXgqBNSco=
X-Google-Smtp-Source: APBJJlHGitz6Wd7KiMp3rjwiDgkH0uvETgsTRqYunJjHL/RNuzVeMP0RmTCJO7TCo/NiSJBWRd5P7qkTVXM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:7687:0:b0:cb3:865d:f403 with SMTP id
 r129-20020a257687000000b00cb3865df403mr13870ybc.1.1689724159714; Tue, 18 Jul
 2023 16:49:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 18 Jul 2023 16:45:08 -0700
In-Reply-To: <20230718234512.1690985-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230718234512.1690985-26-seanjc@google.com>
Subject: [RFC PATCH v11 25/29] KVM: selftests: Add x86-only selftest for
 private memory conversions
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sean Christopherson <seanjc@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Vishal Annapurve <vannapurve@google.com>

Add a selftest to exercise implicit/explicit conversion functionality
within KVM and verify:

 - Shared memory is visible to host userspace
 - Private memory is not visible to host userspace
 - Host userspace and guest can communicate over shared memory
 - Data in shared backing is preserved across conversions (test's
   host userspace doesn't free the data)
 - Private memory is bound to the lifetime of the VM

TODO: rewrite this to allow backing a single region of guest memory with
multiple memslots for _all_ backing types and shapes, i.e. make the code
for using a single backing fd across multiple memslots apply to regular
memory as well.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../kvm/x86_64/private_mem_conversions_test.c | 408 ++++++++++++++++++
 2 files changed, 409 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index c692cc86e7da..fdc7dff8d6ae 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -80,6 +80,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/monitor_mwait_test
 TEST_GEN_PROGS_x86_64 += x86_64/nested_exceptions_test
 TEST_GEN_PROGS_x86_64 += x86_64/platform_info_test
 TEST_GEN_PROGS_x86_64 += x86_64/pmu_event_filter_test
+TEST_GEN_PROGS_x86_64 += x86_64/private_mem_conversions_test
 TEST_GEN_PROGS_x86_64 += x86_64/set_boot_cpu_id
 TEST_GEN_PROGS_x86_64 += x86_64/set_sregs_test
 TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
new file mode 100644
index 000000000000..40ec5f9cc256
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
@@ -0,0 +1,408 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022, Google LLC.
+ */
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <fcntl.h>
+#include <limits.h>
+#include <pthread.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/kvm_para.h>
+#include <linux/memfd.h>
+#include <linux/sizes.h>
+
+#include <test_util.h>
+#include <kvm_util.h>
+#include <processor.h>
+
+#define BASE_DATA_SLOT		10
+#define BASE_DATA_GPA		((uint64_t)(1ull << 32))
+#define PER_CPU_DATA_SIZE	((uint64_t)(SZ_2M + PAGE_SIZE))
+
+/* Horrific macro so that the line info is captured accurately :-( */
+#define memcmp_g(gpa, pattern,  size)				\
+do {								\
+	uint8_t *mem = (uint8_t *)gpa;				\
+	size_t i;						\
+								\
+	for (i = 0; i < size; i++)				\
+		GUEST_ASSERT_4(mem[i] == pattern,		\
+			       gpa, i, mem[i], pattern);	\
+} while (0)
+
+static void memcmp_h(uint8_t *mem, uint8_t pattern, size_t size)
+{
+	size_t i;
+
+	for (i = 0; i < size; i++)
+		TEST_ASSERT(mem[i] == pattern,
+			    "Expected 0x%x at offset %lu, got 0x%x",
+			    pattern, i, mem[i]);
+}
+
+/*
+ * Run memory conversion tests with explicit conversion:
+ * Execute KVM hypercall to map/unmap gpa range which will cause userspace exit
+ * to back/unback private memory. Subsequent accesses by guest to the gpa range
+ * will not cause exit to userspace.
+ *
+ * Test memory conversion scenarios with following steps:
+ * 1) Access private memory using private access and verify that memory contents
+ *   are not visible to userspace.
+ * 2) Convert memory to shared using explicit conversions and ensure that
+ *   userspace is able to access the shared regions.
+ * 3) Convert memory back to private using explicit conversions and ensure that
+ *   userspace is again not able to access converted private regions.
+ */
+
+#define GUEST_STAGE(o, s) { .offset = o, .size = s }
+
+enum ucall_syncs {
+	SYNC_SHARED,
+	SYNC_PRIVATE,
+};
+
+static void guest_sync_shared(uint64_t gpa, uint64_t size,
+			      uint8_t current_pattern, uint8_t new_pattern)
+{
+	GUEST_SYNC5(SYNC_SHARED, gpa, size, current_pattern, new_pattern);
+}
+
+static void guest_sync_private(uint64_t gpa, uint64_t size, uint8_t pattern)
+{
+	GUEST_SYNC4(SYNC_PRIVATE, gpa, size, pattern);
+}
+
+/* Arbitrary values, KVM doesn't care about the attribute flags. */
+#define MAP_GPA_SHARED		BIT(0)
+#define MAP_GPA_DO_FALLOCATE	BIT(1)
+
+static void guest_map_mem(uint64_t gpa, uint64_t size, bool map_shared,
+			  bool do_fallocate)
+{
+	uint64_t flags = 0;
+
+	if (map_shared)
+		flags |= MAP_GPA_SHARED;
+	if (do_fallocate)
+		flags |= MAP_GPA_DO_FALLOCATE;
+	kvm_hypercall_map_gpa_range(gpa, size, flags);
+}
+
+static void guest_map_shared(uint64_t gpa, uint64_t size, bool do_fallocate)
+{
+	guest_map_mem(gpa, size, true, do_fallocate);
+}
+
+static void guest_map_private(uint64_t gpa, uint64_t size, bool do_fallocate)
+{
+	guest_map_mem(gpa, size, false, do_fallocate);
+}
+
+static void guest_run_test(uint64_t base_gpa, bool do_fallocate)
+{
+	struct {
+		uint64_t offset;
+		uint64_t size;
+		uint8_t pattern;
+	} stages[] = {
+		GUEST_STAGE(0, PAGE_SIZE),
+		GUEST_STAGE(0, SZ_2M),
+		GUEST_STAGE(PAGE_SIZE, PAGE_SIZE),
+		GUEST_STAGE(PAGE_SIZE, SZ_2M),
+		GUEST_STAGE(SZ_2M, PAGE_SIZE),
+	};
+	const uint8_t init_p = 0xcc;
+	uint64_t j;
+	int i;
+
+	/* Memory should be shared by default. */
+	memset((void *)base_gpa, ~init_p, PER_CPU_DATA_SIZE);
+	guest_sync_shared(base_gpa, PER_CPU_DATA_SIZE, (uint8_t)~init_p, init_p);
+	memcmp_g(base_gpa, init_p, PER_CPU_DATA_SIZE);
+
+	for (i = 0; i < ARRAY_SIZE(stages); i++) {
+		uint64_t gpa = base_gpa + stages[i].offset;
+		uint64_t size = stages[i].size;
+		uint8_t p1 = 0x11;
+		uint8_t p2 = 0x22;
+		uint8_t p3 = 0x33;
+		uint8_t p4 = 0x44;
+
+		/*
+		 * Set the test region to pattern one to differentiate it from
+		 * the data range as a whole (contains the initial pattern).
+		 */
+		memset((void *)gpa, p1, size);
+
+		/*
+		 * Convert to private, set and verify the private data, and
+		 * then verify that the rest of the data (map shared) still
+		 * holds the initial pattern, and that the host always sees the
+		 * shared memory (initial pattern).  Unlike shared memory,
+		 * punching a hole in private memory is destructive, i.e.
+		 * previous values aren't guaranteed to be preserved.
+		 */
+		guest_map_private(gpa, size, do_fallocate);
+
+		if (size > PAGE_SIZE) {
+			memset((void *)gpa, p2, PAGE_SIZE);
+			goto skip;
+		}
+
+		memset((void *)gpa, p2, size);
+		guest_sync_private(gpa, size, p1);
+
+		/*
+		 * Verify that the private memory was set to pattern two, and
+		 * that shared memory still holds the initial pattern.
+		 */
+		memcmp_g(gpa, p2, size);
+		if (gpa > base_gpa)
+			memcmp_g(base_gpa, init_p, gpa - base_gpa);
+		if (gpa + size < base_gpa + PER_CPU_DATA_SIZE)
+			memcmp_g(gpa + size, init_p,
+				 (base_gpa + PER_CPU_DATA_SIZE) - (gpa + size));
+
+		/*
+		 * Convert odd-number page frames back to shared to verify KVM
+		 * also correctly handles holes in private ranges.
+		 */
+		for (j = 0; j < size; j += PAGE_SIZE) {
+			if ((j >> PAGE_SHIFT) & 1) {
+				guest_map_shared(gpa + j, PAGE_SIZE, do_fallocate);
+				guest_sync_shared(gpa + j, PAGE_SIZE, p1, p3);
+
+				memcmp_g(gpa + j, p3, PAGE_SIZE);
+			} else {
+				guest_sync_private(gpa + j, PAGE_SIZE, p1);
+			}
+		}
+
+skip:
+		/*
+		 * Convert the entire region back to shared, explicitly write
+		 * pattern three to fill in the even-number frames before
+		 * asking the host to verify (and write pattern four).
+		 */
+		guest_map_shared(gpa, size, do_fallocate);
+		memset((void *)gpa, p3, size);
+		guest_sync_shared(gpa, size, p3, p4);
+		memcmp_g(gpa, p4, size);
+
+		/* Reset the shared memory back to the initial pattern. */
+		memset((void *)gpa, init_p, size);
+
+		/*
+		 * Free (via PUNCH_HOLE) *all* private memory so that the next
+		 * iteration starts from a clean slate, e.g. with respect to
+		 * whether or not there are pages/folios in guest_mem.
+		 */
+		guest_map_shared(base_gpa, PER_CPU_DATA_SIZE, true);
+	}
+}
+
+static void guest_code(uint64_t base_gpa)
+{
+	/*
+	 * Run everything twice, with and without doing fallocate() on the
+	 * guest_memfd backing when converting between shared and private.
+	 */
+	guest_run_test(base_gpa, false);
+	guest_run_test(base_gpa, true);
+	GUEST_DONE();
+}
+
+static void handle_exit_hypercall(struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *run = vcpu->run;
+	uint64_t gpa = run->hypercall.args[0];
+	uint64_t size = run->hypercall.args[1] * PAGE_SIZE;
+	bool map_shared = run->hypercall.args[2] & MAP_GPA_SHARED;
+	bool do_fallocate = run->hypercall.args[2] & MAP_GPA_DO_FALLOCATE;
+	struct kvm_vm *vm = vcpu->vm;
+
+	TEST_ASSERT(run->hypercall.nr == KVM_HC_MAP_GPA_RANGE,
+		    "Wanted MAP_GPA_RANGE (%u), got '%llu'",
+		    KVM_HC_MAP_GPA_RANGE, run->hypercall.nr);
+
+	if (do_fallocate)
+		vm_guest_mem_fallocate(vm, gpa, size, map_shared);
+
+	vm_set_memory_attributes(vm, gpa, size,
+				 map_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE);
+	run->hypercall.ret = 0;
+}
+
+static bool run_vcpus;
+
+static void *__test_mem_conversions(void *__vcpu)
+{
+	struct kvm_vcpu *vcpu = __vcpu;
+	struct kvm_run *run = vcpu->run;
+	struct kvm_vm *vm = vcpu->vm;
+	struct ucall uc;
+
+	while (!READ_ONCE(run_vcpus))
+		;
+
+	for ( ;; ) {
+		vcpu_run(vcpu);
+
+		if (run->exit_reason == KVM_EXIT_HYPERCALL) {
+			handle_exit_hypercall(vcpu);
+			continue;
+		}
+
+		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
+			    "Wanted KVM_EXIT_IO, got exit reason: %u (%s)",
+			    run->exit_reason, exit_reason_str(run->exit_reason));
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT_4(uc, "%lx %lx %lx %lx");
+		case UCALL_SYNC: {
+			uint8_t *hva = addr_gpa2hva(vm, uc.args[1]);
+			uint64_t size = uc.args[2];
+
+			TEST_ASSERT(uc.args[0] == SYNC_SHARED ||
+				    uc.args[0] == SYNC_PRIVATE,
+				    "Unknown sync command '%ld'", uc.args[0]);
+
+			/* In all cases, the host should observe the shared data. */
+			memcmp_h(hva, uc.args[3], size);
+
+			/* For shared, write the new pattern to guest memory. */
+			if (uc.args[0] == SYNC_SHARED)
+				memset(hva, uc.args[4], size);
+			break;
+		}
+		case UCALL_DONE:
+			return NULL;
+		default:
+			TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
+		}
+	}
+}
+
+static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t nr_vcpus,
+				 uint32_t nr_memslots)
+{
+	/*
+	 * Allocate enough memory so that each vCPU's chunk of memory can be
+	 * naturally aligned with respect to the size of the backing store.
+	 */
+	const size_t size = align_up(PER_CPU_DATA_SIZE, get_backing_src_pagesz(src_type));
+	const size_t memfd_size = size * nr_vcpus;
+	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
+	pthread_t threads[KVM_MAX_VCPUS];
+	uint64_t gmem_flags;
+	struct kvm_vm *vm;
+	int memfd, i, r;
+
+	const struct vm_shape shape = {
+		.mode = VM_MODE_DEFAULT,
+		.type = KVM_X86_SW_PROTECTED_VM,
+	};
+
+	vm = __vm_create_with_vcpus(shape, nr_vcpus, 0, guest_code, vcpus);
+
+	vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, (1 << KVM_HC_MAP_GPA_RANGE));
+
+	if (backing_src_can_be_huge(src_type))
+		gmem_flags = KVM_GUEST_MEMFD_ALLOW_HUGEPAGE;
+	else
+		gmem_flags = 0;
+	memfd = vm_create_guest_memfd(vm, memfd_size, gmem_flags);
+
+	for (i = 0; i < nr_memslots; i++)
+		vm_mem_add(vm, src_type, BASE_DATA_GPA + size * i,
+			   BASE_DATA_SLOT + i, size / vm->page_size,
+			   KVM_MEM_PRIVATE, memfd, size * i);
+
+	for (i = 0; i < nr_vcpus; i++) {
+		uint64_t gpa =  BASE_DATA_GPA + i * size;
+
+		vcpu_args_set(vcpus[i], 1, gpa);
+
+		virt_map(vm, gpa, gpa, size / vm->page_size);
+
+		pthread_create(&threads[i], NULL, __test_mem_conversions, vcpus[i]);
+	}
+
+	WRITE_ONCE(run_vcpus, true);
+
+	for (i = 0; i < nr_vcpus; i++)
+		pthread_join(threads[i], NULL);
+
+	kvm_vm_free(vm);
+
+	/*
+	 * Allocate and free memory from the guest_memfd after closing the VM
+	 * fd.  The guest_memfd is gifted a reference to its owning VM, i.e.
+	 * should prevent the VM from being fully destroyed until the last
+	 * reference to the guest_memfd is also put.
+	 */
+	r = fallocate(memfd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0, memfd_size);
+	TEST_ASSERT(!r, __KVM_SYSCALL_ERROR("fallocate()", r));
+
+	r = fallocate(memfd, FALLOC_FL_KEEP_SIZE, 0, memfd_size);
+	TEST_ASSERT(!r, __KVM_SYSCALL_ERROR("fallocate()", r));
+}
+
+static void usage(const char *cmd)
+{
+	puts("");
+	printf("usage: %s [-h] [-m] [-s mem_type] [-n nr_vcpus]\n", cmd);
+	puts("");
+	backing_src_help("-s");
+	puts("");
+	puts(" -n: specify the number of vcpus (default: 1)");
+	puts("");
+	puts(" -m: use multiple memslots (default: 1)");
+	puts("");
+}
+
+int main(int argc, char *argv[])
+{
+	enum vm_mem_backing_src_type src_type = DEFAULT_VM_MEM_SRC;
+	bool use_multiple_memslots = false;
+	uint32_t nr_vcpus = 1;
+	uint32_t nr_memslots;
+	int opt;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_EXIT_HYPERCALL));
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
+
+	while ((opt = getopt(argc, argv, "hms:n:")) != -1) {
+		switch (opt) {
+		case 's':
+			src_type = parse_backing_src_type(optarg);
+			break;
+		case 'n':
+			nr_vcpus = atoi_positive("nr_vcpus", optarg);
+			break;
+		case 'm':
+			use_multiple_memslots = true;
+			break;
+		case 'h':
+		default:
+			usage(argv[0]);
+			exit(0);
+		}
+	}
+
+	nr_memslots = use_multiple_memslots ? nr_vcpus : 1;
+
+	test_mem_conversions(src_type, nr_vcpus, nr_memslots);
+
+	return 0;
+}
-- 
2.41.0.255.g8b1d071c50-goog

