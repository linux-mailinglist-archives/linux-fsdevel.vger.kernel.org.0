Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0817589C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 01:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjGRXyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 19:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjGRXvf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 19:51:35 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FE71FCD
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 16:49:57 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b8a7734734so32266525ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 16:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689724156; x=1692316156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Q98IcrUH3D9bs3/KGOraZ2fk7jlneSyp5eOXwjGSzPo=;
        b=7kCME8pPCngu4gaFGpXg5a7UwFpOLrO0My4DJgf3Tu41/gplqgzLOGhIhYQhJyAw82
         pOUm0o0ToYchYR+sqCJB8nr8JQwkY05K+mmvehoPNKX+xtAJe85ypqZrf7NdEBuc7dVO
         Loia1s+Vi2KmoQuGxm/1vLkByuS5Llxi1PwzbhcxuMWRdPNpQbFdZ1M0EUvFj2O4HykG
         lFhG2TpgpmRIG1QsBv9/L63IGFhxigQF4dGb407i8DsIDC4msrdSTzNotl+OShvkqjOU
         uJoKfxiuAmED0YbOhUTgqzr2Njgz4J6LJbFZG7TW80PXAaqsgV0K7Lq43642a6sItsfg
         Wm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689724156; x=1692316156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q98IcrUH3D9bs3/KGOraZ2fk7jlneSyp5eOXwjGSzPo=;
        b=iFX2inhSBIJvKtdHHKDtqTXvaxMxAxtlz4uyb6O152yR2peVJIBXR2Izqo7UEsRuMH
         wyGouMt04x6ct3DNYaH3W/E4FVyMyEcpbvcEhDdZyh9z6sNFgWxMbgOlAJjG2/exHLsb
         Cf28gy+vg1YUiMfgpRFFBUk85WO5Q3tIJch7jr20kxBc1DgRMHbLvZmHdmqtRnpVVNSN
         dHfarevSKciUKLnKJYV1BG5rRm1imePhdWGG9jrKXPF/3U23/EgU18xTh5NQHA9E1pGZ
         uYjKDVKM2H7t4FzZnWUG7L43imMj6b/UzWcNG9l1ciuBBdN+HiOcBLoI5dSJAfVJglSx
         j60w==
X-Gm-Message-State: ABy/qLaRMh2KVAgFNp8qBzqPE3pm7fMmsSxs734bjZoqOCY3mLeTIi+s
        0dQyKFTSHfUc+sLD60XtLtAcm0CQHFg=
X-Google-Smtp-Source: APBJJlGNaFpMXi9SkErxKUtHkpkIjtXAaXLFttzvWMq3kzuSVkOJWJ0e7R+lluyhOtMVN8C9CK1Syvi8Yw4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:22ce:b0:1b8:80c9:a98e with SMTP id
 y14-20020a17090322ce00b001b880c9a98emr18845plg.13.1689724155930; Tue, 18 Jul
 2023 16:49:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 18 Jul 2023 16:45:06 -0700
In-Reply-To: <20230718234512.1690985-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230718234512.1690985-24-seanjc@google.com>
Subject: [RFC PATCH v11 23/29] KVM: selftests: Introduce VM "shape" to allow
 tests to specify the VM type
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c  |  2 +-
 .../selftests/kvm/include/kvm_util_base.h     | 54 +++++++++++++++----
 .../selftests/kvm/kvm_page_table_test.c       |  2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 43 +++++++--------
 tools/testing/selftests/kvm/lib/memstress.c   |  3 +-
 .../kvm/x86_64/ucna_injection_test.c          |  2 +-
 6 files changed, 72 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 936f3a8d1b83..6cbecf499767 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -699,7 +699,7 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, struct kvm_vcpu **vcpu,
 
 	pr_info("Testing guest mode: %s\n", vm_guest_mode_string(mode));
 
-	vm = __vm_create(mode, 1, extra_mem_pages);
+	vm = __vm_create(VM_SHAPE(mode), 1, extra_mem_pages);
 
 	log_mode_create_vm_done(vm);
 	*vcpu = vm_vcpu_add(vm, 0, guest_code);
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 1819787b773b..856440294013 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -167,6 +167,23 @@ enum vm_guest_mode {
 	NUM_VM_MODES,
 };
 
+struct vm_shape {
+	enum vm_guest_mode mode;
+	unsigned int type;
+};
+
+#define VM_TYPE_DEFAULT			0
+
+#define VM_SHAPE(__mode)			\
+({						\
+	struct vm_shape shape = {		\
+		.mode = (__mode),		\
+		.type = VM_TYPE_DEFAULT		\
+	};					\
+						\
+	shape;					\
+})
+
 #if defined(__aarch64__)
 
 extern enum vm_guest_mode vm_mode_default;
@@ -199,6 +216,8 @@ extern enum vm_guest_mode vm_mode_default;
 
 #endif
 
+#define VM_SHAPE_DEFAULT	VM_SHAPE(VM_MODE_DEFAULT)
+
 #define MIN_PAGE_SIZE		(1U << MIN_PAGE_SHIFT)
 #define PTES_PER_MIN_PAGE	ptes_per_page(MIN_PAGE_SIZE)
 
@@ -754,21 +773,21 @@ vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm);
  * __vm_create() does NOT create vCPUs, @nr_runnable_vcpus is used purely to
  * calculate the amount of memory needed for per-vCPU data, e.g. stacks.
  */
-struct kvm_vm *____vm_create(enum vm_guest_mode mode);
-struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint32_t nr_runnable_vcpus,
+struct kvm_vm *____vm_create(struct vm_shape shape);
+struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
 			   uint64_t nr_extra_pages);
 
 static inline struct kvm_vm *vm_create_barebones(void)
 {
-	return ____vm_create(VM_MODE_DEFAULT);
+	return ____vm_create(VM_SHAPE_DEFAULT);
 }
 
 static inline struct kvm_vm *vm_create(uint32_t nr_runnable_vcpus)
 {
-	return __vm_create(VM_MODE_DEFAULT, nr_runnable_vcpus, 0);
+	return __vm_create(VM_SHAPE_DEFAULT, nr_runnable_vcpus, 0);
 }
 
-struct kvm_vm *__vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
+struct kvm_vm *__vm_create_with_vcpus(struct vm_shape shape, uint32_t nr_vcpus,
 				      uint64_t extra_mem_pages,
 				      void *guest_code, struct kvm_vcpu *vcpus[]);
 
@@ -776,17 +795,27 @@ static inline struct kvm_vm *vm_create_with_vcpus(uint32_t nr_vcpus,
 						  void *guest_code,
 						  struct kvm_vcpu *vcpus[])
 {
-	return __vm_create_with_vcpus(VM_MODE_DEFAULT, nr_vcpus, 0,
+	return __vm_create_with_vcpus(VM_SHAPE_DEFAULT, nr_vcpus, 0,
 				      guest_code, vcpus);
 }
 
+
+struct kvm_vm *__vm_create_shape_with_one_vcpu(struct vm_shape shape,
+					       struct kvm_vcpu **vcpu,
+					       uint64_t extra_mem_pages,
+					       void *guest_code);
+
 /*
  * Create a VM with a single vCPU with reasonable defaults and @extra_mem_pages
  * additional pages of guest memory.  Returns the VM and vCPU (via out param).
  */
-struct kvm_vm *__vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
-					 uint64_t extra_mem_pages,
-					 void *guest_code);
+static inline struct kvm_vm *__vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
+						       uint64_t extra_mem_pages,
+						       void *guest_code)
+{
+	return __vm_create_shape_with_one_vcpu(VM_SHAPE_DEFAULT, vcpu,
+					       extra_mem_pages, guest_code);
+}
 
 static inline struct kvm_vm *vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
 						     void *guest_code)
@@ -794,6 +823,13 @@ static inline struct kvm_vm *vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
 	return __vm_create_with_one_vcpu(vcpu, 0, guest_code);
 }
 
+static inline struct kvm_vm *vm_create_shape_with_one_vcpu(struct vm_shape shape,
+							   struct kvm_vcpu **vcpu,
+							   void *guest_code)
+{
+	return __vm_create_shape_with_one_vcpu(shape, vcpu, 0, guest_code);
+}
+
 struct kvm_vcpu *vm_recreate_with_one_vcpu(struct kvm_vm *vm);
 
 void kvm_pin_this_task_to_pcpu(uint32_t pcpu);
diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
index b3b00be1ef82..e8c2aabbca2b 100644
--- a/tools/testing/selftests/kvm/kvm_page_table_test.c
+++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
@@ -254,7 +254,7 @@ static struct kvm_vm *pre_init_before_test(enum vm_guest_mode mode, void *arg)
 
 	/* Create a VM with enough guest pages */
 	guest_num_pages = test_mem_size / guest_page_size;
-	vm = __vm_create_with_vcpus(mode, nr_vcpus, guest_num_pages,
+	vm = __vm_create_with_vcpus(VM_SHAPE(mode), nr_vcpus, guest_num_pages,
 				    guest_code, test_args.vcpus);
 
 	/* Align down GPA of the testing memslot */
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 1283e24b76f1..64221c320389 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -209,7 +209,7 @@ __weak void vm_vaddr_populate_bitmap(struct kvm_vm *vm)
 		(1ULL << (vm->va_bits - 1)) >> vm->page_shift);
 }
 
-struct kvm_vm *____vm_create(enum vm_guest_mode mode)
+struct kvm_vm *____vm_create(struct vm_shape shape)
 {
 	struct kvm_vm *vm;
 
@@ -221,13 +221,13 @@ struct kvm_vm *____vm_create(enum vm_guest_mode mode)
 	vm->regions.hva_tree = RB_ROOT;
 	hash_init(vm->regions.slot_hash);
 
-	vm->mode = mode;
-	vm->type = 0;
+	vm->mode = shape.mode;
+	vm->type = shape.type;
 
-	vm->pa_bits = vm_guest_mode_params[mode].pa_bits;
-	vm->va_bits = vm_guest_mode_params[mode].va_bits;
-	vm->page_size = vm_guest_mode_params[mode].page_size;
-	vm->page_shift = vm_guest_mode_params[mode].page_shift;
+	vm->pa_bits = vm_guest_mode_params[vm->mode].pa_bits;
+	vm->va_bits = vm_guest_mode_params[vm->mode].va_bits;
+	vm->page_size = vm_guest_mode_params[vm->mode].page_size;
+	vm->page_shift = vm_guest_mode_params[vm->mode].page_shift;
 
 	/* Setup mode specific traits. */
 	switch (vm->mode) {
@@ -265,7 +265,7 @@ struct kvm_vm *____vm_create(enum vm_guest_mode mode)
 		/*
 		 * Ignore KVM support for 5-level paging (vm->va_bits == 57),
 		 * it doesn't take effect unless a CR4.LA57 is set, which it
-		 * isn't for this VM_MODE.
+		 * isn't for this mode (48-bit virtual address space).
 		 */
 		TEST_ASSERT(vm->va_bits == 48 || vm->va_bits == 57,
 			    "Linear address width (%d bits) not supported",
@@ -285,10 +285,11 @@ struct kvm_vm *____vm_create(enum vm_guest_mode mode)
 		vm->pgtable_levels = 5;
 		break;
 	default:
-		TEST_FAIL("Unknown guest mode, mode: 0x%x", mode);
+		TEST_FAIL("Unknown guest mode: 0x%x", vm->mode);
 	}
 
 #ifdef __aarch64__
+	TEST_ASSERT(!vm->type, "ARM doesn't support test-provided types");
 	if (vm->pa_bits != 40)
 		vm->type = KVM_VM_TYPE_ARM_IPA_SIZE(vm->pa_bits);
 #endif
@@ -343,19 +344,19 @@ static uint64_t vm_nr_pages_required(enum vm_guest_mode mode,
 	return vm_adjust_num_guest_pages(mode, nr_pages);
 }
 
-struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint32_t nr_runnable_vcpus,
+struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
 			   uint64_t nr_extra_pages)
 {
-	uint64_t nr_pages = vm_nr_pages_required(mode, nr_runnable_vcpus,
+	uint64_t nr_pages = vm_nr_pages_required(shape.mode, nr_runnable_vcpus,
 						 nr_extra_pages);
 	struct userspace_mem_region *slot0;
 	struct kvm_vm *vm;
 	int i;
 
-	pr_debug("%s: mode='%s' pages='%ld'\n", __func__,
-		 vm_guest_mode_string(mode), nr_pages);
+	pr_debug("%s: mode='%s' type='%d', pages='%ld'\n", __func__,
+		 vm_guest_mode_string(shape.mode), shape.type, nr_pages);
 
-	vm = ____vm_create(mode);
+	vm = ____vm_create(shape);
 
 	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, 0);
 	for (i = 0; i < NR_MEM_REGIONS; i++)
@@ -396,7 +397,7 @@ struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint32_t nr_runnable_vcpus,
  * extra_mem_pages is only used to calculate the maximum page table size,
  * no real memory allocation for non-slot0 memory in this function.
  */
-struct kvm_vm *__vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
+struct kvm_vm *__vm_create_with_vcpus(struct vm_shape shape, uint32_t nr_vcpus,
 				      uint64_t extra_mem_pages,
 				      void *guest_code, struct kvm_vcpu *vcpus[])
 {
@@ -405,7 +406,7 @@ struct kvm_vm *__vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus
 
 	TEST_ASSERT(!nr_vcpus || vcpus, "Must provide vCPU array");
 
-	vm = __vm_create(mode, nr_vcpus, extra_mem_pages);
+	vm = __vm_create(shape, nr_vcpus, extra_mem_pages);
 
 	for (i = 0; i < nr_vcpus; ++i)
 		vcpus[i] = vm_vcpu_add(vm, i, guest_code);
@@ -413,15 +414,15 @@ struct kvm_vm *__vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus
 	return vm;
 }
 
-struct kvm_vm *__vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
-					 uint64_t extra_mem_pages,
-					 void *guest_code)
+struct kvm_vm *__vm_create_shape_with_one_vcpu(struct vm_shape shape,
+					       struct kvm_vcpu **vcpu,
+					       uint64_t extra_mem_pages,
+					       void *guest_code)
 {
 	struct kvm_vcpu *vcpus[1];
 	struct kvm_vm *vm;
 
-	vm = __vm_create_with_vcpus(VM_MODE_DEFAULT, 1, extra_mem_pages,
-				    guest_code, vcpus);
+	vm = __vm_create_with_vcpus(shape, 1, extra_mem_pages, guest_code, vcpus);
 
 	*vcpu = vcpus[0];
 	return vm;
diff --git a/tools/testing/selftests/kvm/lib/memstress.c b/tools/testing/selftests/kvm/lib/memstress.c
index df457452d146..d05487e5a371 100644
--- a/tools/testing/selftests/kvm/lib/memstress.c
+++ b/tools/testing/selftests/kvm/lib/memstress.c
@@ -168,7 +168,8 @@ struct kvm_vm *memstress_create_vm(enum vm_guest_mode mode, int nr_vcpus,
 	 * The memory is also added to memslot 0, but that's a benign side
 	 * effect as KVM allows aliasing HVAs in meslots.
 	 */
-	vm = __vm_create_with_vcpus(mode, nr_vcpus, slot0_pages + guest_num_pages,
+	vm = __vm_create_with_vcpus(VM_SHAPE(mode), nr_vcpus,
+				    slot0_pages + guest_num_pages,
 				    memstress_guest_code, vcpus);
 
 	args->vm = vm;
diff --git a/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c b/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
index 85f34ca7e49e..0ed32ec903d0 100644
--- a/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
+++ b/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
@@ -271,7 +271,7 @@ int main(int argc, char *argv[])
 
 	kvm_check_cap(KVM_CAP_MCE);
 
-	vm = __vm_create(VM_MODE_DEFAULT, 3, 0);
+	vm = __vm_create(VM_SHAPE_DEFAULT, 3, 0);
 
 	kvm_ioctl(vm->kvm_fd, KVM_X86_GET_MCE_CAP_SUPPORTED,
 		  &supported_mcg_caps);
-- 
2.41.0.255.g8b1d071c50-goog

