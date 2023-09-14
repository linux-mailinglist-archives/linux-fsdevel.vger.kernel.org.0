Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191C279F7B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 04:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjINCLx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 22:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbjINCAY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:00:24 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42613C23
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:56:38 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-594e5e2e608so6338307b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694656598; x=1695261398; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mhn7+u5bXSh3DxSOzG9/ewBd6nzzrjcseQEqhhMfZJw=;
        b=pXCQZOdQ0AvIcFrYCCczuYmLySIQ3bWrZwL560rqrT4E5eG7S/5uMl3nJPzs6YW6KP
         Pf3dDip0nsGBBNXLblA+jzkdJPZ3ax73/C+7NHAaQs/BezWMdx17bOta6jTi4jG7RjxH
         zvjLBXkFfaPcb8IC+ehkZz/3PYFsY+GdWcO427VEyTUNCObjV/di6jefuko9kq8+BueZ
         TnzH10zIqqs0djJUI6QkKdfnh+Xo1JrJIaTwVmUqkxE4aELwEKjF92egvtSj71c4OIl6
         zUJvc9/gWwggZ3Oy5kLa5vzo6U18Tms7FkqeuFrJAKH/s7J/ikIINQukrdXJDpV5UE0I
         S6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694656598; x=1695261398;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhn7+u5bXSh3DxSOzG9/ewBd6nzzrjcseQEqhhMfZJw=;
        b=AoaiHzXFQW49oJ71abqQbl784eL02XRhZzwCPCrKx9nZvlUWGKIdrhfJES8d7Ix3bD
         EyvJa5hzAZtZoTPhrpmP3IjYKzZlqFac3fFizdJudJqPXWxBTvuHHSeXrYF98sR61fUQ
         nctyvOvX5fBgh+gNjqSf5vFaoHJPJGMU9v9ReiZtXq28n/7pncU3x4q/bmZr0vElxdHb
         HCjMHdGAK+nA2Uv65LDsbkwFogbRJJYPClAPLXspzVKGbn34PO+isf43RL8qBb7OSPI1
         2f8JUtnIezuXecj4TirJ9nRHSmvB+mHq4OSWlwOkRLFI3FGFDm8aQgYJVnuxF1BPLXEN
         PgBA==
X-Gm-Message-State: AOJu0YyLND25LqYBDi7v+hJuuEpablgNbQVkPhpX9tVLHW2Otz9mSP3l
        Jqro0I9iZYdckhJLWO/O6Z86p85ha6Q=
X-Google-Smtp-Source: AGHT+IECmRUJsED8Us3qWlJnugvslNzA7dXsGOQfEOYZbUPHi7DQFFf33qpMB4ILXjFkyWuOYhA2SvRB6XQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:e809:0:b0:59b:ebe0:9fcd with SMTP id
 a9-20020a81e809000000b0059bebe09fcdmr13568ywm.7.1694656597965; Wed, 13 Sep
 2023 18:56:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Sep 2023 18:55:29 -0700
In-Reply-To: <20230914015531.1419405-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914015531.1419405-32-seanjc@google.com>
Subject: [RFC PATCH v12 31/33] KVM: selftests: Expand set_memory_region_test
 to validate guest_memfd()
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
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chao Peng <chao.p.peng@linux.intel.com>

Expand set_memory_region_test to exercise various positive and negative
testcases for private memory.

 - Non-guest_memfd() file descriptor for private memory
 - guest_memfd() from different VM
 - Overlapping bindings
 - Unaligned bindings

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
[sean: trim the testcases to remove duplicate coverage]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  10 ++
 .../selftests/kvm/set_memory_region_test.c    | 100 ++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index edc0f380acc0..ac9356108df6 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -819,6 +819,16 @@ static inline struct kvm_vm *vm_create_barebones(void)
 	return ____vm_create(VM_SHAPE_DEFAULT);
 }
 
+static inline struct kvm_vm *vm_create_barebones_protected_vm(void)
+{
+	const struct vm_shape shape = {
+		.mode = VM_MODE_DEFAULT,
+		.type = KVM_X86_SW_PROTECTED_VM,
+	};
+
+	return ____vm_create(shape);
+}
+
 static inline struct kvm_vm *vm_create(uint32_t nr_runnable_vcpus)
 {
 	return __vm_create(VM_SHAPE_DEFAULT, nr_runnable_vcpus, 0);
diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index b32960189f5f..ca83e3307a98 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -385,6 +385,98 @@ static void test_add_max_memory_regions(void)
 	kvm_vm_free(vm);
 }
 
+
+static void test_invalid_guest_memfd(struct kvm_vm *vm, int memfd,
+				     size_t offset, const char *msg)
+{
+	int r = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_PRIVATE,
+					     MEM_REGION_GPA, MEM_REGION_SIZE,
+					     0, memfd, offset);
+	TEST_ASSERT(r == -1 && errno == EINVAL, "%s", msg);
+}
+
+static void test_add_private_memory_region(void)
+{
+	struct kvm_vm *vm, *vm2;
+	int memfd, i;
+
+	pr_info("Testing ADD of KVM_MEM_PRIVATE memory regions\n");
+
+	vm = vm_create_barebones_protected_vm();
+
+	test_invalid_guest_memfd(vm, vm->kvm_fd, 0, "KVM fd should fail");
+	test_invalid_guest_memfd(vm, vm->fd, 0, "VM's fd should fail");
+
+	memfd = kvm_memfd_alloc(MEM_REGION_SIZE, false);
+	test_invalid_guest_memfd(vm, memfd, 0, "Regular memfd() should fail");
+	close(memfd);
+
+	vm2 = vm_create_barebones_protected_vm();
+	memfd = vm_create_guest_memfd(vm2, MEM_REGION_SIZE, 0);
+	test_invalid_guest_memfd(vm, memfd, 0, "Other VM's guest_memfd() should fail");
+
+	vm_set_user_memory_region2(vm2, MEM_REGION_SLOT, KVM_MEM_PRIVATE,
+				   MEM_REGION_GPA, MEM_REGION_SIZE, 0, memfd, 0);
+	close(memfd);
+	kvm_vm_free(vm2);
+
+	memfd = vm_create_guest_memfd(vm, MEM_REGION_SIZE, 0);
+	for (i = 1; i < PAGE_SIZE; i++)
+		test_invalid_guest_memfd(vm, memfd, i, "Unaligned offset should fail");
+
+	vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_PRIVATE,
+				   MEM_REGION_GPA, MEM_REGION_SIZE, 0, memfd, 0);
+	close(memfd);
+
+	kvm_vm_free(vm);
+}
+
+static void test_add_overlapping_private_memory_regions(void)
+{
+	struct kvm_vm *vm;
+	int memfd;
+	int r;
+
+	pr_info("Testing ADD of overlapping KVM_MEM_PRIVATE memory regions\n");
+
+	vm = vm_create_barebones_protected_vm();
+
+	memfd = vm_create_guest_memfd(vm, MEM_REGION_SIZE * 4, 0);
+
+	vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_PRIVATE,
+				   MEM_REGION_GPA, MEM_REGION_SIZE * 2, 0, memfd, 0);
+
+	vm_set_user_memory_region2(vm, MEM_REGION_SLOT + 1, KVM_MEM_PRIVATE,
+				   MEM_REGION_GPA * 2, MEM_REGION_SIZE * 2,
+				   0, memfd, MEM_REGION_SIZE * 2);
+
+	/*
+	 * Delete the first memslot, and then attempt to recreate it except
+	 * with a "bad" offset that results in overlap in the guest_memfd().
+	 */
+	vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_PRIVATE,
+				   MEM_REGION_GPA, 0, NULL, -1, 0);
+
+	/* Overlap the front half of the other slot. */
+	r = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_PRIVATE,
+					 MEM_REGION_GPA * 2 - MEM_REGION_SIZE,
+					 MEM_REGION_SIZE * 2,
+					 0, memfd, 0);
+	TEST_ASSERT(r == -1 && errno == EEXIST, "%s",
+		    "Overlapping guest_memfd() bindings should fail with EEXIST");
+
+	/* And now the back half of the other slot. */
+	r = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_PRIVATE,
+					 MEM_REGION_GPA * 2 + MEM_REGION_SIZE,
+					 MEM_REGION_SIZE * 2,
+					 0, memfd, 0);
+	TEST_ASSERT(r == -1 && errno == EEXIST, "%s",
+		    "Overlapping guest_memfd() bindings should fail with EEXIST");
+
+	close(memfd);
+	kvm_vm_free(vm);
+}
+
 int main(int argc, char *argv[])
 {
 #ifdef __x86_64__
@@ -401,6 +493,14 @@ int main(int argc, char *argv[])
 
 	test_add_max_memory_regions();
 
+	if (kvm_has_cap(KVM_CAP_GUEST_MEMFD) &&
+	    (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM))) {
+		test_add_private_memory_region();
+		test_add_overlapping_private_memory_regions();
+	} else {
+		pr_info("Skipping tests for KVM_MEM_PRIVATE memory regions\n");
+	}
+
 #ifdef __x86_64__
 	if (argc > 1)
 		loops = atoi_positive("Number of iterations", argv[1]);
-- 
2.42.0.283.g2d96d420d3-goog

