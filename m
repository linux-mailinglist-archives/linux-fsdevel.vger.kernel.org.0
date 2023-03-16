Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA926BC2D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 01:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjCPAdV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 20:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjCPAcG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:32:06 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1521A64BF
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 17:31:37 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id l19-20020a056a0016d300b006257255adb4so172144pfc.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 17:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678926692;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YxU1hhaZ4SyfL9lxoIcMNBPPAq0yfPS0xuipesTDclo=;
        b=W0G3AmVBhmaEPW1mzeOzfktEstHk/ayT4Fca4WpYB+uqnQXqFONecZpHfNEM3EVkI8
         dMoU+aBolGRnKrvqkSWbCeJFkilUlbcTqWcVH0y2O7kmHEk9EOK0BEV0KFKuPFrnCkbs
         QOotzJYDWHJggJes5/KIvM96osSnaCvae3qKB3LUHRBB+uNwEOmmHmd8zvTbRGoEVjUL
         rVFdyBsTEprlo4ciiWa3+M8yKhD16Tn+oY0bqfI0h7Rz5RgpgT08FQynab2lujb51lp7
         x7X7TlFctPEGFqxyshGyufJ1XL1Zen+FPj5jvwOG/5BAnYWpY1i72h9z5SjlNs7jYsNa
         hwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678926692;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YxU1hhaZ4SyfL9lxoIcMNBPPAq0yfPS0xuipesTDclo=;
        b=E33zGxMvH+Kh+YBqVvZiDAzxZB6+9BmOi4xVKHuYUQsp44rPeBrw+CxK9LHVGb3JOn
         F1o8LF3ww0MsHtKWr+F60C57CDu/FtMyDJ3Wx4eo2DfqOh5C9Gqmcx70crPrb8o9VgnD
         AmtMxzcbfyxgiDZF5ulhxi72A9WguGBQ3EedEXXOacgtpKSyOlTw9zPjnTB0ERr9gCNb
         uzp+iFfuAbCcvRWo9dUIgYwLdlgDEtxzWZWXaZHmYQ+Jo5SAnwH42tww8Y1eKIg4g+/x
         KnSMHpONytN95ouMQ1yFvpDGY0XUsIyc1/j1AZaNRKCVx+i8cY4UkBqkkvhod2hekCJ6
         0U5A==
X-Gm-Message-State: AO0yUKUWtxnOHMgDufHU0oHhJ/0WK5l+SP3psHj25HPzGvhGomf9qbao
        QJPm6UAmpihzf7gkbOsuH2b3PhuwFVCJPNogrQ==
X-Google-Smtp-Source: AK7set/r1L80ZGqvN1Jqjj7ZwUbt+f+1AOqGwiuE9AJvattpTxM2ZIa1Wyqx7LP6pavKwLlYqhK3jR4rdgiNHjRokg==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a65:530d:0:b0:502:fd12:83ce with SMTP
 id m13-20020a65530d000000b00502fd1283cemr347381pgq.5.1678926691968; Wed, 15
 Mar 2023 17:31:31 -0700 (PDT)
Date:   Thu, 16 Mar 2023 00:31:03 +0000
In-Reply-To: <cover.1678926164.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1678926164.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <90aaa4ab85fa5e3d5641793e2a4873282eb16556.1678926164.git.ackerleytng@google.com>
Subject: [RFC PATCH 10/10] KVM: selftests: Test KVM exit behavior for private memory/access
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

"Testing private access when memslot gets deleted" tests the behavior
of KVM when a private memslot gets deleted while the VM is using the
private memslot. When KVM looks up the deleted (slot = NULL) memslot,
KVM should exit to userspace with KVM_EXIT_MEMORY_FAULT.

In the second test, upon a private access to non-private memslot, KVM
should also exit to userspace with KVM_EXIT_MEMORY_FAULT.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../kvm/x86_64/private_mem_kvm_exits_test.c   | 124 ++++++++++++++++++
 2 files changed, 125 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/private_mem_kvm_exits_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index bafee3c43b2e..0ad588852a1d 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -80,6 +80,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/nested_exceptions_test
 TEST_GEN_PROGS_x86_64 += x86_64/platform_info_test
 TEST_GEN_PROGS_x86_64 += x86_64/pmu_event_filter_test
 TEST_GEN_PROGS_x86_64 += x86_64/private_mem_conversions_test
+TEST_GEN_PROGS_x86_64 += x86_64/private_mem_kvm_exits_test
 TEST_GEN_PROGS_x86_64 += x86_64/set_boot_cpu_id
 TEST_GEN_PROGS_x86_64 += x86_64/set_sregs_test
 TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_kvm_exits_test.c b/tools/testing/selftests/kvm/x86_64/private_mem_kvm_exits_test.c
new file mode 100644
index 000000000000..c8667dfbbf0a
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/private_mem_kvm_exits_test.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022, Google LLC.
+ */
+#include "kvm_util_base.h"
+#include <linux/kvm.h>
+#include <pthread.h>
+#include <stdint.h>
+#include "kvm_util.h"
+#include "processor.h"
+#include "test_util.h"
+
+/* Arbitrarily selected to avoid overlaps with anything else */
+#define EXITS_TEST_GVA 0xc0000000
+#define EXITS_TEST_GPA EXITS_TEST_GVA
+#define EXITS_TEST_NPAGES 1
+#define EXITS_TEST_SIZE (EXITS_TEST_NPAGES * PAGE_SIZE)
+#define EXITS_TEST_SLOT 10
+
+static uint64_t guest_repeatedly_read(void)
+{
+	volatile uint64_t value;
+
+	while (true)
+		value = *((uint64_t *) EXITS_TEST_GVA);
+
+	return value;
+}
+
+static uint32_t run_vcpu_get_exit_reason(struct kvm_vcpu *vcpu)
+{
+	vcpu_run(vcpu);
+
+	return vcpu->run->exit_reason;
+}
+
+const struct vm_shape protected_vm_shape = {
+	.mode = VM_MODE_DEFAULT,
+	.type = KVM_X86_PROTECTED_VM,
+};
+
+static void test_private_access_memslot_deleted(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	pthread_t vm_thread;
+	void *thread_return;
+	uint32_t exit_reason;
+
+	vm = vm_create_shape_with_one_vcpu(protected_vm_shape, &vcpu,
+					   guest_repeatedly_read);
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    EXITS_TEST_GPA, EXITS_TEST_SLOT,
+				    EXITS_TEST_NPAGES,
+				    KVM_MEM_PRIVATE);
+
+	virt_map(vm, EXITS_TEST_GVA, EXITS_TEST_GPA, EXITS_TEST_NPAGES);
+
+	/* Request to access page privately */
+	vm_mem_map_shared_or_private(vm, EXITS_TEST_GPA, EXITS_TEST_SIZE, false);
+
+	pr_info("Testing private access when memslot gets deleted\n");
+
+	pthread_create(&vm_thread, NULL,
+		       (void *(*)(void *))run_vcpu_get_exit_reason,
+		       (void *)vcpu);
+
+	vm_mem_region_delete(vm, EXITS_TEST_SLOT);
+
+	pthread_join(vm_thread, &thread_return);
+	exit_reason = (uint32_t)(uint64_t)thread_return;
+
+	ASSERT_EQ(exit_reason, KVM_EXIT_MEMORY_FAULT);
+	ASSERT_EQ(vcpu->run->memory.flags, KVM_MEMORY_EXIT_FLAG_PRIVATE);
+	ASSERT_EQ(vcpu->run->memory.gpa, EXITS_TEST_GPA);
+	ASSERT_EQ(vcpu->run->memory.size, EXITS_TEST_SIZE);
+
+	pr_info("\t ... PASSED\n");
+
+	kvm_vm_free(vm);
+}
+
+static void test_private_access_memslot_not_private(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	uint32_t exit_reason;
+
+	vm = vm_create_shape_with_one_vcpu(protected_vm_shape, &vcpu,
+					   guest_repeatedly_read);
+
+	/* Add a non-private memslot (flags = 0) */
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    EXITS_TEST_GPA, EXITS_TEST_SLOT,
+				    EXITS_TEST_NPAGES, 0);
+
+	virt_map(vm, EXITS_TEST_GVA, EXITS_TEST_GPA, EXITS_TEST_NPAGES);
+
+	/* Request to access page privately */
+	vm_set_memory_attributes(vm, EXITS_TEST_GPA, EXITS_TEST_SIZE,
+				 KVM_MEMORY_ATTRIBUTE_PRIVATE);
+
+	pr_info("Testing private access to non-private memslot\n");
+
+	exit_reason = run_vcpu_get_exit_reason(vcpu);
+
+	ASSERT_EQ(exit_reason, KVM_EXIT_MEMORY_FAULT);
+	ASSERT_EQ(vcpu->run->memory.flags, KVM_MEMORY_EXIT_FLAG_PRIVATE);
+	ASSERT_EQ(vcpu->run->memory.gpa, EXITS_TEST_GPA);
+	ASSERT_EQ(vcpu->run->memory.size, EXITS_TEST_SIZE);
+
+	pr_info("\t ... PASSED\n");
+
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_PROTECTED_VM));
+
+	test_private_access_memslot_deleted();
+	test_private_access_memslot_not_private();
+}
-- 
2.40.0.rc2.332.ga46443480c-goog

