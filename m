Return-Path: <linux-fsdevel+bounces-2021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 904C67E1524
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 17:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50B91C20BBB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 16:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC707241F4;
	Sun,  5 Nov 2023 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcL95IVR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23E418AE4
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 16:35:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ED0212F
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 08:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699202079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=741ezfuARFZZBBse4N/gb7fQBfP2u1p2fIgMKDOm8yo=;
	b=VcL95IVRFzzZK+qZHkChgWeeCiPylMH0dUNIEC1MWhy6L06B7qT2ooagizSqrcS3Cg28SR
	WUg6wu3uPzPF2nzvj9Di2VBGOiZ73fEPe1CfTkRQNqKNP5jINIdwvw+SJhlDSkcXOp8Mcq
	pE0RwA4sPxM5Tb6es/ByMS6Aqc0V7P8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-J7hh8KLvPtGtV94HTumzMg-1; Sun,
 05 Nov 2023 11:34:35 -0500
X-MC-Unique: J7hh8KLvPtGtV94HTumzMg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8645929ABA1A;
	Sun,  5 Nov 2023 16:34:33 +0000 (UTC)
Received: from avogadro.redhat.com (unknown [10.39.192.93])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9AB292166B26;
	Sun,  5 Nov 2023 16:34:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Chao Peng <chao.p.peng@linux.intel.com>,
	Fuad Tabba <tabba@google.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Anish Moorthy <amoorthy@google.com>,
	David Matlack <dmatlack@google.com>,
	Yu Zhang <yu.c.zhang@linux.intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Vlastimil Babka <vbabka@suse.cz>,
	Vishal Annapurve <vannapurve@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Maciej Szmigiero <mail@maciej.szmigiero.name>,
	David Hildenbrand <david@redhat.com>,
	Quentin Perret <qperret@google.com>,
	Michael Roth <michael.roth@amd.com>,
	Wang <wei.w.wang@intel.com>,
	Liam Merwick <liam.merwick@oracle.com>,
	Isaku Yamahata <isaku.yamahata@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 29/34] KVM: selftests: Add x86-only selftest for private memory conversions
Date: Sun,  5 Nov 2023 17:30:32 +0100
Message-ID: <20231105163040.14904-30-pbonzini@redhat.com>
In-Reply-To: <20231105163040.14904-1-pbonzini@redhat.com>
References: <20231105163040.14904-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

From: Vishal Annapurve <vannapurve@google.com>

Add a selftest to exercise implicit/explicit conversion functionality
within KVM and verify:

 - Shared memory is visible to host userspace
 - Private memory is not visible to host userspace
 - Host userspace and guest can communicate over shared memory
 - Data in shared backing is preserved across conversions (test's
   host userspace doesn't free the data)
 - Private memory is bound to the lifetime of the VM

Ideally, KVM's selftests infrastructure would be reworked to allow backing
a single region of guest memory with multiple memslots for _all_ backing
types and shapes, i.e. ideally the code for using a single backing fd
across multiple memslots would work for "regular" memory as well.  But
sadly, support for KVM_CREATE_GUEST_MEMFD has languished for far too long,
and overhauling selftests' memslots infrastructure would likely open a can
of worms, i.e. delay things even further.

In addition to the more obvious tests, verify that PUNCH_HOLE actually
frees memory.  Directly verifying that KVM frees memory is impractical, if
it's even possible, so instead indirectly verify memory is freed by
asserting that the guest reads zeroes after a PUNCH_HOLE.  E.g. if KVM
zaps SPTEs but doesn't actually punch a hole in the inode, the subsequent
read will still see the previous value.  And obviously punching a hole
shouldn't cause explosions.

Let the user specify the number of memslots in the private mem conversion
test, i.e. don't require the number of memslots to be '1' or "nr_vcpus".
Creating more memslots than vCPUs is particularly interesting, e.g. it can
result in a single KVM_SET_MEMORY_ATTRIBUTES spanning multiple memslots.
To keep the math reasonable, align each vCPU's chunk to at least 2MiB (the
size is 2MiB+4KiB), and require the total size to be cleanly divisible by
the number of memslots.  The goal is to be able to validate that KVM plays
nice with multiple memslots, being able to create a truly arbitrary number
of memslots doesn't add meaningful value, i.e. isn't worth the cost.

Intentionally don't take a requirement on KVM_CAP_GUEST_MEMFD,
KVM_CAP_MEMORY_FAULT_INFO, KVM_MEMORY_ATTRIBUTE_PRIVATE, etc., as it's a
KVM bug to advertise KVM_X86_SW_PROTECTED_VM without its prerequisites.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20231027182217.3615211-32-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../kvm/x86_64/private_mem_conversions_test.c | 482 ++++++++++++++++++
 2 files changed, 483 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index a5963ab9215b..ecdea5e7afa8 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -91,6 +91,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/monitor_mwait_test
 TEST_GEN_PROGS_x86_64 += x86_64/nested_exceptions_test
 TEST_GEN_PROGS_x86_64 += x86_64/platform_info_test
 TEST_GEN_PROGS_x86_64 += x86_64/pmu_event_filter_test
+TEST_GEN_PROGS_x86_64 += x86_64/private_mem_conversions_test
 TEST_GEN_PROGS_x86_64 += x86_64/set_boot_cpu_id
 TEST_GEN_PROGS_x86_64 += x86_64/set_sregs_test
 TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
new file mode 100644
index 000000000000..4d6a37a5d896
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
@@ -0,0 +1,482 @@
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
+#define memcmp_g(gpa, pattern,  size)								\
+do {												\
+	uint8_t *mem = (uint8_t *)gpa;								\
+	size_t i;										\
+												\
+	for (i = 0; i < size; i++)								\
+		__GUEST_ASSERT(mem[i] == pattern,						\
+			       "Guest expected 0x%x at offset %lu (gpa 0x%llx), got 0x%x",	\
+			       pattern, i, gpa + i, mem[i]);					\
+} while (0)
+
+static void memcmp_h(uint8_t *mem, uint64_t gpa, uint8_t pattern, size_t size)
+{
+	size_t i;
+
+	for (i = 0; i < size; i++)
+		TEST_ASSERT(mem[i] == pattern,
+			    "Host expected 0x%x at gpa 0x%lx, got 0x%x",
+			    pattern, gpa + i, mem[i]);
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
+#define MAP_GPA_SET_ATTRIBUTES	BIT(0)
+#define MAP_GPA_SHARED		BIT(1)
+#define MAP_GPA_DO_FALLOCATE	BIT(2)
+
+static void guest_map_mem(uint64_t gpa, uint64_t size, bool map_shared,
+			  bool do_fallocate)
+{
+	uint64_t flags = MAP_GPA_SET_ATTRIBUTES;
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
+struct {
+	uint64_t offset;
+	uint64_t size;
+} static const test_ranges[] = {
+	GUEST_STAGE(0, PAGE_SIZE),
+	GUEST_STAGE(0, SZ_2M),
+	GUEST_STAGE(PAGE_SIZE, PAGE_SIZE),
+	GUEST_STAGE(PAGE_SIZE, SZ_2M),
+	GUEST_STAGE(SZ_2M, PAGE_SIZE),
+};
+
+static void guest_test_explicit_conversion(uint64_t base_gpa, bool do_fallocate)
+{
+	const uint8_t def_p = 0xaa;
+	const uint8_t init_p = 0xcc;
+	uint64_t j;
+	int i;
+
+	/* Memory should be shared by default. */
+	memset((void *)base_gpa, def_p, PER_CPU_DATA_SIZE);
+	memcmp_g(base_gpa, def_p, PER_CPU_DATA_SIZE);
+	guest_sync_shared(base_gpa, PER_CPU_DATA_SIZE, def_p, init_p);
+
+	memcmp_g(base_gpa, init_p, PER_CPU_DATA_SIZE);
+
+	for (i = 0; i < ARRAY_SIZE(test_ranges); i++) {
+		uint64_t gpa = base_gpa + test_ranges[i].offset;
+		uint64_t size = test_ranges[i].size;
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
+static void guest_punch_hole(uint64_t gpa, uint64_t size)
+{
+	/* "Mapping" memory shared via fallocate() is done via PUNCH_HOLE. */
+	uint64_t flags = MAP_GPA_SHARED | MAP_GPA_DO_FALLOCATE;
+
+	kvm_hypercall_map_gpa_range(gpa, size, flags);
+}
+
+/*
+ * Test that PUNCH_HOLE actually frees memory by punching holes without doing a
+ * proper conversion.  Freeing (PUNCH_HOLE) should zap SPTEs, and reallocating
+ * (subsequent fault) should zero memory.
+ */
+static void guest_test_punch_hole(uint64_t base_gpa, bool precise)
+{
+	const uint8_t init_p = 0xcc;
+	int i;
+
+	/*
+	 * Convert the entire range to private, this testcase is all about
+	 * punching holes in guest_memfd, i.e. shared mappings aren't needed.
+	 */
+	guest_map_private(base_gpa, PER_CPU_DATA_SIZE, false);
+
+	for (i = 0; i < ARRAY_SIZE(test_ranges); i++) {
+		uint64_t gpa = base_gpa + test_ranges[i].offset;
+		uint64_t size = test_ranges[i].size;
+
+		/*
+		 * Free all memory before each iteration, even for the !precise
+		 * case where the memory will be faulted back in.  Freeing and
+		 * reallocating should obviously work, and freeing all memory
+		 * minimizes the probability of cross-testcase influence.
+		 */
+		guest_punch_hole(base_gpa, PER_CPU_DATA_SIZE);
+
+		/* Fault-in and initialize memory, and verify the pattern. */
+		if (precise) {
+			memset((void *)gpa, init_p, size);
+			memcmp_g(gpa, init_p, size);
+		} else {
+			memset((void *)base_gpa, init_p, PER_CPU_DATA_SIZE);
+			memcmp_g(base_gpa, init_p, PER_CPU_DATA_SIZE);
+		}
+
+		/*
+		 * Punch a hole at the target range and verify that reads from
+		 * the guest succeed and return zeroes.
+		 */
+		guest_punch_hole(gpa, size);
+		memcmp_g(gpa, 0, size);
+	}
+}
+
+static void guest_code(uint64_t base_gpa)
+{
+	/*
+	 * Run the conversion test twice, with and without doing fallocate() on
+	 * the guest_memfd backing when converting between shared and private.
+	 */
+	guest_test_explicit_conversion(base_gpa, false);
+	guest_test_explicit_conversion(base_gpa, true);
+
+	/*
+	 * Run the PUNCH_HOLE test twice too, once with the entire guest_memfd
+	 * faulted in, once with only the target range faulted in.
+	 */
+	guest_test_punch_hole(base_gpa, false);
+	guest_test_punch_hole(base_gpa, true);
+	GUEST_DONE();
+}
+
+static void handle_exit_hypercall(struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *run = vcpu->run;
+	uint64_t gpa = run->hypercall.args[0];
+	uint64_t size = run->hypercall.args[1] * PAGE_SIZE;
+	bool set_attributes = run->hypercall.args[2] & MAP_GPA_SET_ATTRIBUTES;
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
+	if (set_attributes)
+		vm_set_memory_attributes(vm, gpa, size,
+					 map_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE);
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
+			REPORT_GUEST_ASSERT(uc);
+		case UCALL_SYNC: {
+			uint64_t gpa  = uc.args[1];
+			size_t size = uc.args[2];
+			size_t i;
+
+			TEST_ASSERT(uc.args[0] == SYNC_SHARED ||
+				    uc.args[0] == SYNC_PRIVATE,
+				    "Unknown sync command '%ld'", uc.args[0]);
+
+			for (i = 0; i < size; i += vm->page_size) {
+				size_t nr_bytes = min_t(size_t, vm->page_size, size - i);
+				uint8_t *hva = addr_gpa2hva(vm, gpa + i);
+
+				/* In all cases, the host should observe the shared data. */
+				memcmp_h(hva, gpa + i, uc.args[3], nr_bytes);
+
+				/* For shared, write the new pattern to guest memory. */
+				if (uc.args[0] == SYNC_SHARED)
+					memset(hva, uc.args[4], nr_bytes);
+			}
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
+	const size_t alignment = max_t(size_t, SZ_2M, get_backing_src_pagesz(src_type));
+	const size_t per_cpu_size = align_up(PER_CPU_DATA_SIZE, alignment);
+	const size_t memfd_size = per_cpu_size * nr_vcpus;
+	const size_t slot_size = memfd_size / nr_memslots;
+	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
+	pthread_t threads[KVM_MAX_VCPUS];
+	struct kvm_vm *vm;
+	int memfd, i, r;
+
+	const struct vm_shape shape = {
+		.mode = VM_MODE_DEFAULT,
+		.type = KVM_X86_SW_PROTECTED_VM,
+	};
+
+	TEST_ASSERT(slot_size * nr_memslots == memfd_size,
+		    "The memfd size (0x%lx) needs to be cleanly divisible by the number of memslots (%u)",
+		    memfd_size, nr_memslots);
+	vm = __vm_create_with_vcpus(shape, nr_vcpus, 0, guest_code, vcpus);
+
+	vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, (1 << KVM_HC_MAP_GPA_RANGE));
+
+	memfd = vm_create_guest_memfd(vm, memfd_size, 0);
+
+	for (i = 0; i < nr_memslots; i++)
+		vm_mem_add(vm, src_type, BASE_DATA_GPA + slot_size * i,
+			   BASE_DATA_SLOT + i, slot_size / vm->page_size,
+			   KVM_MEM_GUEST_MEMFD, memfd, slot_size * i);
+
+	for (i = 0; i < nr_vcpus; i++) {
+		uint64_t gpa =  BASE_DATA_GPA + i * per_cpu_size;
+
+		vcpu_args_set(vcpus[i], 1, gpa);
+
+		/*
+		 * Map only what is needed so that an out-of-bounds access
+		 * results #PF => SHUTDOWN instead of data corruption.
+		 */
+		virt_map(vm, gpa, gpa, PER_CPU_DATA_SIZE / vm->page_size);
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
+	printf("usage: %s [-h] [-m nr_memslots] [-s mem_type] [-n nr_vcpus]\n", cmd);
+	puts("");
+	backing_src_help("-s");
+	puts("");
+	puts(" -n: specify the number of vcpus (default: 1)");
+	puts("");
+	puts(" -m: specify the number of memslots (default: 1)");
+	puts("");
+}
+
+int main(int argc, char *argv[])
+{
+	enum vm_mem_backing_src_type src_type = DEFAULT_VM_MEM_SRC;
+	uint32_t nr_memslots = 1;
+	uint32_t nr_vcpus = 1;
+	int opt;
+
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
+
+	while ((opt = getopt(argc, argv, "hm:s:n:")) != -1) {
+		switch (opt) {
+		case 's':
+			src_type = parse_backing_src_type(optarg);
+			break;
+		case 'n':
+			nr_vcpus = atoi_positive("nr_vcpus", optarg);
+			break;
+		case 'm':
+			nr_memslots = atoi_positive("nr_memslots", optarg);
+			break;
+		case 'h':
+		default:
+			usage(argv[0]);
+			exit(0);
+		}
+	}
+
+	test_mem_conversions(src_type, nr_vcpus, nr_memslots);
+
+	return 0;
+}
-- 
2.39.1



