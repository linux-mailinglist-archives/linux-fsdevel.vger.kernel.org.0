Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAAA6BC2A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 01:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjCPAcJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 20:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjCPAbq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:31:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAB5A4014
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 17:31:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t25-20020a252d19000000b00b341ad1b626so86349ybt.19
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 17:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678926683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QTeAQsqCeHYohT1+z6QROKS290DmjN4VP9f8cpdpaL8=;
        b=auUqsxufnhZazK80BuGYrUuT5xQy0nKByTHsDVa5nQ8ggWedTTVRL+DG5jMn5NcxdQ
         9zKUsKBxbo+88C8lp499Nf5DzFL8iXzFzdAJ86nKvZqnnh/lTpcH6nmuB0r+XxVUCw1B
         tWxQxyfQ1qbw8+rrtFLmZAs8p0Ck8ha4gQgZVZNu5KU3Thh3AQojPLOynQtyjzv1FzSr
         Kq4i+5eQv1x3JKSEQwwxH3yKT9WUMAu3uj+orG9AOM7aiFj0W9PrTlTTkoUWU15/M43G
         MNpDDQxOGa8+IAVafp0LeD+kSvzDoyTC20PrCP7Ia85PDwUpeCiqEyENM1ZDwu+6T7Px
         76MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678926683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QTeAQsqCeHYohT1+z6QROKS290DmjN4VP9f8cpdpaL8=;
        b=czxXogU4vg+qzm7tq/35wEiGSSUG+WudeFyjqd4sLo5mGhM6N3BPvCLBH4cWly2SLE
         m01L0v/MiXJ+d5SXcF7ywsnvYiRvcnMLLr9oUgvmjbwiX9nOukjLXIvjSPPwaUCxOkCi
         bwsKUCKpKco+R+xIcrUB0JKallNF6ZU2NNpMOF5emb5E9Qet8TYudEEFiPxmF6ba1Jd1
         tM+5+8daF9VIiO/FPmfr1x8PGX5uEtTl9v0gZIkNEW4mciQwuemEnEuK5NSlFOVHWeSl
         W3Txn1NStmlH52ssCyUYU41k4t4TU47uk6riWNsa2UErHPK2SDHx/32UoQ9OfIVcbQO8
         vtlg==
X-Gm-Message-State: AO0yUKXgKVa+0PgIZgV5DJS4O2h9lSOg07/6bStyvlMy16voOwfLbGeV
        5616eAbS8HO/g8hieFXUyjmOV3fFzUm0yvnOdw==
X-Google-Smtp-Source: AK7set9qSNzfiSuUSuac6czSQv9JIGaIPRBH/C++HGZYNA2V+6Yj/KtOeknnwR+NdK2YlHb02GTz9vZIhxkpteuF/Q==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a81:e803:0:b0:541:7f49:adac with SMTP
 id a3-20020a81e803000000b005417f49adacmr1106841ywm.8.1678926683452; Wed, 15
 Mar 2023 17:31:23 -0700 (PDT)
Date:   Thu, 16 Mar 2023 00:30:58 +0000
In-Reply-To: <cover.1678926164.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1678926164.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <53c62631b481f5811340ef4fcbef511abd2171d7.1678926164.git.ackerleytng@google.com>
Subject: [RFC PATCH 05/10] KVM: selftests: Generalize private_mem_conversions_test
 for parallel execution
From:   Ackerley Tng <ackerleytng@google.com>
To:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org
Cc:     aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        arnd@arndb.de, bfields@fieldses.org, bp@alien8.de,
        chao.p.peng@linux.intel.com, corbet@lwn.net, dave.hansen@intel.com,
        david@redhat.com, ddutile@redhat.com, dhildenb@redhat.com,
        hpa@zytor.com, hughd@google.com, jlayton@kernel.org,
        jmattson@google.com, joro@8bytes.org, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        luto@kernel.org, mail@maciej.szmigiero.name, mhocko@suse.com,
        michael.roth@amd.com, mingo@redhat.com, naoya.horiguchi@nec.com,
        pbonzini@redhat.com, qperret@google.com, rppt@kernel.org,
        seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
        tabba@google.com, tglx@linutronix.de, vannapurve@google.com,
        vbabka@suse.cz, vkuznets@redhat.com, wanpengli@tencent.com,
        wei.w.wang@intel.com, x86@kernel.org, yu.c.zhang@linux.intel.com,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

By running the private/shared memory conversion tests on multiple
vCPUs in parallel, we stress-test the restrictedmem subsystem to
test conversion of non-overlapping GPA ranges in multiple memslots.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../kvm/x86_64/private_mem_conversions_test.c | 203 +++++++++++++-----
 1 file changed, 150 insertions(+), 53 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
index 7741916818db..14aa90e9a89b 100644
--- a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
@@ -5,6 +5,7 @@
 #define _GNU_SOURCE /* for program_invocation_short_name */
 #include <fcntl.h>
 #include <limits.h>
+#include <pthread.h>
 #include <sched.h>
 #include <signal.h>
 #include <stdio.h>
@@ -22,9 +23,10 @@
 #include <kvm_util.h>
 #include <processor.h>
 
-#define DATA_SLOT	10
-#define DATA_GPA	((uint64_t)(1ull << 32))
-#define DATA_SIZE	((uint64_t)(SZ_2M + PAGE_SIZE))
+#define DATA_SLOT_BASE   10
+#define DATA_GPA_BASE    ((uint64_t)(1ull << 32))
+#define DATA_SIZE        ((uint64_t)(SZ_2M + PAGE_SIZE))
+#define DATA_GPA_SPACING DATA_SIZE
 
 /* Horrific macro so that the line info is captured accurately :-( */
 #define memcmp_g(gpa, pattern,  size)				\
@@ -83,7 +85,9 @@ static void memcmp_ne_h(uint8_t *mem, uint8_t pattern, size_t size)
 #define REQUEST_HOST_R_PRIVATE(gpa, size, expected_pattern) \
 	ucall(UCALL_R_PRIVATE, 3, gpa, size, expected_pattern)
 
-static void guest_code(void)
+const uint8_t init_p = 0xcc;
+
+static void guest_test_conversions(uint64_t gpa_base)
 {
 	struct {
 		uint64_t offset;
@@ -96,17 +100,11 @@ static void guest_code(void)
 		GUEST_STAGE(PAGE_SIZE, SZ_2M),
 		GUEST_STAGE(SZ_2M, PAGE_SIZE),
 	};
-	const uint8_t init_p = 0xcc;
 	uint64_t j;
 	int i;
 
-	/* Memory should be shared by default. */
-	memset((void *)DATA_GPA, ~init_p, DATA_SIZE);
-	REQUEST_HOST_RW_SHARED(DATA_GPA, DATA_SIZE, ~init_p, init_p);
-	memcmp_g(DATA_GPA, init_p, DATA_SIZE);
-
 	for (i = 0; i < ARRAY_SIZE(stages); i++) {
-		uint64_t gpa = DATA_GPA + stages[i].offset;
+		uint64_t gpa = gpa_base + stages[i].offset;
 		uint64_t size = stages[i].size;
 		uint8_t p1 = 0x11;
 		uint8_t p2 = 0x22;
@@ -140,11 +138,11 @@ static void guest_code(void)
 		 * that shared memory still holds the initial pattern.
 		 */
 		memcmp_g(gpa, p2, size);
-		if (gpa > DATA_GPA)
-			memcmp_g(DATA_GPA, init_p, gpa - DATA_GPA);
-		if (gpa + size < DATA_GPA + DATA_SIZE)
+		if (gpa > gpa_base)
+			memcmp_g(gpa_base, init_p, gpa - gpa_base);
+		if (gpa + size < gpa_base + DATA_SIZE)
 			memcmp_g(gpa + size, init_p,
-				 (DATA_GPA + DATA_SIZE) - (gpa + size));
+				 (gpa_base + DATA_SIZE) - (gpa + size));
 
 		/*
 		 * Convert odd-number page frames back to shared to verify KVM
@@ -182,6 +180,19 @@ static void guest_code(void)
 		/* Reset the shared memory back to the initial pattern. */
 		memset((void *)gpa, init_p, size);
 	}
+}
+
+static void guest_code(uint64_t gpa_base, uint32_t iterations)
+{
+	int i;
+
+	/* Memory should be shared by default. */
+	memset((void *)gpa_base, ~init_p, DATA_SIZE);
+	REQUEST_HOST_RW_SHARED(gpa_base, DATA_SIZE, ~init_p, init_p);
+	memcmp_g(gpa_base, init_p, DATA_SIZE);
+
+	for (i = 0; i < iterations; i++)
+		guest_test_conversions(gpa_base);
 
 	GUEST_DONE();
 }
@@ -203,15 +214,27 @@ static void handle_exit_hypercall(struct kvm_vcpu *vcpu)
 	run->hypercall.ret = 0;
 }
 
-static void test_invalidation_code_unbound(struct kvm_vm *vm)
+static uint64_t data_gpa_base_for_vcpu_id(uint8_t n)
+{
+	return DATA_GPA_BASE + n * DATA_GPA_SPACING;
+}
+
+static void test_invalidation_code_unbound(struct kvm_vm *vm, uint8_t nr_memslots,
+					   off_t data_size)
 {
-	uint32_t fd;
-	uint64_t offset;
-	struct userspace_mem_region *region;
+	struct {
+		uint32_t fd;
+		uint64_t offset;
+	} params[KVM_MAX_VCPUS];
+	int i;
+
+	for (i = 0; i < nr_memslots; i++) {
+		struct userspace_mem_region *region;
 
-	region = memslot2region(vm, DATA_SLOT);
-	fd = region->region.restrictedmem_fd;
-	offset = region->region.restrictedmem_offset;
+		region = memslot2region(vm, DATA_SLOT_BASE + i);
+		params[i].fd = region->region.restrictedmem_fd;
+		params[i].offset = region->region.restrictedmem_offset;
+	}
 
 	kvm_vm_free(vm);
 
@@ -220,33 +243,24 @@ static void test_invalidation_code_unbound(struct kvm_vm *vm)
 	 * the vm. We do allocation and truncation to exercise the restrictedmem
 	 * code. There should be no issues after the unbinding happens.
 	 */
-	if (fallocate(fd, 0, offset, DATA_SIZE))
-		TEST_FAIL("Unexpected error in fallocate");
-	if (fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-		      offset, DATA_SIZE))
-		TEST_FAIL("Unexpected error in fallocate");
+	for (i = 0; i < nr_memslots; i++) {
+		if (fallocate(params[i].fd, 0, params[i].offset, data_size))
+			TEST_FAIL("Unexpected error in fallocate");
+		if (fallocate(params[i].fd,
+			      FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+			      params[i].offset, data_size))
+			TEST_FAIL("Unexpected error in fallocate");
+	}
+
 }
 
-static void test_mem_conversions(enum vm_mem_backing_src_type src_type)
+static void test_mem_conversions_for_vcpu(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
+					  uint32_t iterations)
 {
-	struct kvm_vcpu *vcpu;
 	struct kvm_run *run;
-	struct kvm_vm *vm;
 	struct ucall uc;
 
-	const struct vm_shape shape = {
-		.mode = VM_MODE_DEFAULT,
-		.type = KVM_X86_PROTECTED_VM,
-	};
-
-	vm = vm_create_shape_with_one_vcpu(shape, &vcpu, guest_code);
-
-	vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, (1 << KVM_HC_MAP_GPA_RANGE));
-
-	vm_userspace_mem_region_add(vm, src_type, DATA_GPA, DATA_SLOT,
-				    DATA_SIZE / vm->page_size, KVM_MEM_PRIVATE);
-
-	virt_map(vm, DATA_GPA, DATA_GPA, DATA_SIZE / vm->page_size);
+	vcpu_args_set(vcpu, 2, data_gpa_base_for_vcpu_id(vcpu->id), iterations);
 
 	run = vcpu->run;
 	for ( ;; ) {
@@ -287,40 +301,123 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type)
 			break;
 		}
 		case UCALL_DONE:
-			goto done;
+			return;
 		default:
 			TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
 		}
 	}
+}
+
+struct thread_args {
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	uint32_t iterations;
+};
+
+void *thread_function(void *input)
+{
+	struct thread_args *args = (struct thread_args *)input;
+
+	test_mem_conversions_for_vcpu(args->vm, args->vcpu, args->iterations);
+
+	return NULL;
+}
+
+static void add_memslot_for_vcpu(
+	struct kvm_vm *vm, enum vm_mem_backing_src_type src_type, uint8_t vcpu_id)
+{
+	uint64_t gpa = data_gpa_base_for_vcpu_id(vcpu_id);
+	uint32_t slot = DATA_SLOT_BASE + vcpu_id;
+	uint64_t npages = DATA_SIZE / vm->page_size;
+
+	vm_userspace_mem_region_add(vm, src_type, gpa, slot, npages,
+				    KVM_MEM_PRIVATE);
+}
+
+static void test_mem_conversions(enum vm_mem_backing_src_type src_type,
+				 uint8_t nr_vcpus, uint32_t iterations)
+{
+	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
+	pthread_t threads[KVM_MAX_VCPUS];
+	struct thread_args args[KVM_MAX_VCPUS];
+	struct kvm_vm *vm;
+
+	int i;
+	int npages_for_all_vcpus;
+
+	const struct vm_shape shape = {
+		.mode = VM_MODE_DEFAULT,
+		.type = KVM_X86_PROTECTED_VM,
+	};
+
+	vm = __vm_create_with_vcpus(shape, nr_vcpus, 0, guest_code, vcpus);
+
+	vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, (1 << KVM_HC_MAP_GPA_RANGE));
+
+	npages_for_all_vcpus = DATA_SIZE / vm->page_size * nr_vcpus;
+	virt_map(vm, DATA_GPA_BASE, DATA_GPA_BASE, npages_for_all_vcpus);
+
+	for (i = 0; i < nr_vcpus; i++)
+		add_memslot_for_vcpu(vm, src_type, i);
+
+	for (i = 0; i < nr_vcpus; i++) {
+		args[i].vm = vm;
+		args[i].vcpu = vcpus[i];
+		args[i].iterations = iterations;
+
+		pthread_create(&threads[i], NULL, thread_function, &args[i]);
+	}
+
+	for (i = 0; i < nr_vcpus; i++)
+		pthread_join(threads[i], NULL);
+
+	test_invalidation_code_unbound(vm, nr_vcpus, DATA_SIZE);
+}
 
-done:
-	test_invalidation_code_unbound(vm);
+static void usage(const char *command)
+{
+	puts("");
+	printf("usage: %s [-h] [-s mem-type] [-n number-of-vcpus] [-i number-of-iterations]\n",
+	       command);
+	puts("");
+	backing_src_help("-s");
+	puts("");
+	puts(" -n: specify the number of vcpus to run memory conversion");
+	puts("     tests in parallel on. (default: 2)");
+	puts("");
+	puts(" -i: specify the number iterations of memory conversion");
+	puts("     tests to run. (default: 10)");
+	puts("");
 }
 
 int main(int argc, char *argv[])
 {
 	enum vm_mem_backing_src_type src_type = DEFAULT_VM_MEM_SRC;
+	uint8_t nr_vcpus = 2;
+	uint32_t iterations = 10;
 	int opt;
 
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_EXIT_HYPERCALL));
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_PROTECTED_VM));
 
-	while ((opt = getopt(argc, argv, "hs:")) != -1) {
+	while ((opt = getopt(argc, argv, "hs:n:i:")) != -1) {
 		switch (opt) {
+		case 'n':
+			nr_vcpus = atoi_positive("nr_vcpus", optarg);
+			break;
+		case 'i':
+			iterations = atoi_positive("iterations", optarg);
+			break;
 		case 's':
 			src_type = parse_backing_src_type(optarg);
 			break;
 		case 'h':
 		default:
-			puts("");
-			printf("usage: %s [-h] [-s mem-type]\n", argv[0]);
-			puts("");
-			backing_src_help("-s");
-			puts("");
+			usage(argv[0]);
 			exit(0);
 		}
 	}
 
-	test_mem_conversions(src_type);
+	test_mem_conversions(src_type, nr_vcpus, iterations);
 	return 0;
 }
-- 
2.40.0.rc2.332.ga46443480c-goog

