Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B343575896D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 01:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjGRXvd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 19:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjGRXu4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 19:50:56 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBCF2713
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 16:49:22 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b8a7735231so33088905ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 16:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689724139; x=1692316139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yr5kPp//ycHeBe41TiVxkGxE+I0FtPuZavos26l+cCE=;
        b=E5XUQ5BOUPih8BJs1OU21KMtQ0H2gaSku+U7buhnuKlRnySGwZ68OBKlxRT9sWT5mJ
         f8n+BR26cm0lRm1JXX78qwSra7nbrQ6sXHvLQZaZDcIFccPOjvvZmZeAzcuh7O2Q/Qjq
         eAJ0ZmDH3NG1CIo5jmkXJBD/J0qhHBq3KrWoOEZ65tybA//6e/m3I0cImw/wdA9FJDS3
         AlGOTWITqYnobVa5ljRgBqTN9AP0pMpMc6YQF9quW057Wh43QQOVDM46RFAPH9PRZwwq
         CZoc5KVa79eYnqhOrpC35DVzpFIb/w5YuQeYDKyW3j9UeKVBLo58qtN5wBD28kBBLbq2
         wpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689724139; x=1692316139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yr5kPp//ycHeBe41TiVxkGxE+I0FtPuZavos26l+cCE=;
        b=hm4h2HgyG+IoX5bKnsN0rF3Gz20qOeAl9drXR4pkWe4sB+GgQuxYX8m9MG65nW6IMY
         0QBJBFYCJ50uU5hR1aSSDuVA3pHGZ2IgP2GJIAxPmVmrZP4MNe82A0jbE1le2+p5AuRn
         1Vj6DUQg2/dBUuTpFdOidlizgb9biLfjHczGAI/pvSoDC7bYkCqCARATWk3BP/JRpK23
         gjUkpiRzFR0KzuAGC/Fxe4+FCQEEEjxlixAI/N+Tvo2i9Epq3JgCNM4INtdOlbXQhYEA
         nQBldWvyjX0JT1rvNK/x3c67j/UiDuNU/PAZNpRILKu5mj4Kd38HjQYSZvmcoWy3DjTD
         g6Vw==
X-Gm-Message-State: ABy/qLahI1N6o/Cqlf3I+WwAwOu+bKlZzkUsS+QSgUiWM9P3rUalQ9ck
        gOaEbcDLrC/E5DP2QOtNlTpyz8L2h3c=
X-Google-Smtp-Source: APBJJlEVWl5JDRlnPOqWQbyjGWHyKDzKVGtobf5+lC7u6yLDp0aN/2aXMEnW9jTxfL1DAcNC6lZfVqqUTaM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ea01:b0:1b8:a56e:1dcc with SMTP id
 s1-20020a170902ea0100b001b8a56e1dccmr7653plg.13.1689724138849; Tue, 18 Jul
 2023 16:48:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 18 Jul 2023 16:44:57 -0700
In-Reply-To: <20230718234512.1690985-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230718234512.1690985-15-seanjc@google.com>
Subject: [RFC PATCH v11 14/29] KVM: x86/mmu: Handle page fault for private memory
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

From: Chao Peng <chao.p.peng@linux.intel.com>

A KVM_MEM_PRIVATE memslot can include both fd-based private memory and
hva-based shared memory. Architecture code (like TDX code) can tell
whether the on-going fault is private or not. This patch adds a
'is_private' field to kvm_page_fault to indicate this and architecture
code is expected to set it.

To handle page fault for such memslot, the handling logic is different
depending on whether the fault is private or shared. KVM checks if
'is_private' matches the host's view of the page (maintained in
mem_attr_array).
  - For a successful match, private pfn is obtained with
    restrictedmem_get_page() and shared pfn is obtained with existing
    get_user_pages().
  - For a failed match, KVM causes a KVM_EXIT_MEMORY_FAULT exit to
    userspace. Userspace then can convert memory between private/shared
    in host's view and retry the fault.

Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c          | 82 +++++++++++++++++++++++++++++++--
 arch/x86/kvm/mmu/mmu_internal.h |  3 ++
 arch/x86/kvm/mmu/mmutrace.h     |  1 +
 3 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index aefe67185637..4cf73a579ee1 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3179,9 +3179,9 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
 	return level;
 }
 
-int kvm_mmu_max_mapping_level(struct kvm *kvm,
-			      const struct kvm_memory_slot *slot, gfn_t gfn,
-			      int max_level)
+static int __kvm_mmu_max_mapping_level(struct kvm *kvm,
+				       const struct kvm_memory_slot *slot,
+				       gfn_t gfn, int max_level, bool is_private)
 {
 	struct kvm_lpage_info *linfo;
 	int host_level;
@@ -3193,6 +3193,9 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm,
 			break;
 	}
 
+	if (is_private)
+		return max_level;
+
 	if (max_level == PG_LEVEL_4K)
 		return PG_LEVEL_4K;
 
@@ -3200,6 +3203,16 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm,
 	return min(host_level, max_level);
 }
 
+int kvm_mmu_max_mapping_level(struct kvm *kvm,
+			      const struct kvm_memory_slot *slot, gfn_t gfn,
+			      int max_level)
+{
+	bool is_private = kvm_slot_can_be_private(slot) &&
+			  kvm_mem_is_private(kvm, gfn);
+
+	return __kvm_mmu_max_mapping_level(kvm, slot, gfn, max_level, is_private);
+}
+
 void kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
 	struct kvm_memory_slot *slot = fault->slot;
@@ -3220,8 +3233,9 @@ void kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	 * Enforce the iTLB multihit workaround after capturing the requested
 	 * level, which will be used to do precise, accurate accounting.
 	 */
-	fault->req_level = kvm_mmu_max_mapping_level(vcpu->kvm, slot,
-						     fault->gfn, fault->max_level);
+	fault->req_level = __kvm_mmu_max_mapping_level(vcpu->kvm, slot,
+						       fault->gfn, fault->max_level,
+						       fault->is_private);
 	if (fault->req_level == PG_LEVEL_4K || fault->huge_page_disallowed)
 		return;
 
@@ -4304,6 +4318,55 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 	kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, 0, true, NULL);
 }
 
+static inline u8 kvm_max_level_for_order(int order)
+{
+	BUILD_BUG_ON(KVM_MAX_HUGEPAGE_LEVEL > PG_LEVEL_1G);
+
+	MMU_WARN_ON(order != KVM_HPAGE_GFN_SHIFT(PG_LEVEL_1G) &&
+		    order != KVM_HPAGE_GFN_SHIFT(PG_LEVEL_2M) &&
+		    order != KVM_HPAGE_GFN_SHIFT(PG_LEVEL_4K));
+
+	if (order >= KVM_HPAGE_GFN_SHIFT(PG_LEVEL_1G))
+		return PG_LEVEL_1G;
+
+	if (order >= KVM_HPAGE_GFN_SHIFT(PG_LEVEL_2M))
+		return PG_LEVEL_2M;
+
+	return PG_LEVEL_4K;
+}
+
+static int kvm_do_memory_fault_exit(struct kvm_vcpu *vcpu,
+				    struct kvm_page_fault *fault)
+{
+	vcpu->run->exit_reason = KVM_EXIT_MEMORY_FAULT;
+	if (fault->is_private)
+		vcpu->run->memory.flags = KVM_MEMORY_EXIT_FLAG_PRIVATE;
+	else
+		vcpu->run->memory.flags = 0;
+	vcpu->run->memory.gpa = fault->gfn << PAGE_SHIFT;
+	vcpu->run->memory.size = PAGE_SIZE;
+	return RET_PF_USER;
+}
+
+static int kvm_faultin_pfn_private(struct kvm_vcpu *vcpu,
+				   struct kvm_page_fault *fault)
+{
+	int max_order, r;
+
+	if (!kvm_slot_can_be_private(fault->slot))
+		return kvm_do_memory_fault_exit(vcpu, fault);
+
+	r = kvm_gmem_get_pfn(vcpu->kvm, fault->slot, fault->gfn, &fault->pfn,
+			     &max_order);
+	if (r)
+		return r;
+
+	fault->max_level = min(kvm_max_level_for_order(max_order),
+			       fault->max_level);
+	fault->map_writable = !(fault->slot->flags & KVM_MEM_READONLY);
+	return RET_PF_CONTINUE;
+}
+
 static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
 	struct kvm_memory_slot *slot = fault->slot;
@@ -4336,6 +4399,12 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 			return RET_PF_EMULATE;
 	}
 
+	if (fault->is_private != kvm_mem_is_private(vcpu->kvm, fault->gfn))
+		return kvm_do_memory_fault_exit(vcpu, fault);
+
+	if (fault->is_private)
+		return kvm_faultin_pfn_private(vcpu, fault);
+
 	async = false;
 	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, false, &async,
 					  fault->write, &fault->map_writable,
@@ -5771,6 +5840,9 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 			return -EIO;
 	}
 
+	if (r == RET_PF_USER)
+		return 0;
+
 	if (r < 0)
 		return r;
 	if (r != RET_PF_EMULATE)
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index d39af5639ce9..268b517e88cb 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -203,6 +203,7 @@ struct kvm_page_fault {
 
 	/* Derived from mmu and global state.  */
 	const bool is_tdp;
+	const bool is_private;
 	const bool nx_huge_page_workaround_enabled;
 
 	/*
@@ -259,6 +260,7 @@ int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
  * RET_PF_RETRY: let CPU fault again on the address.
  * RET_PF_EMULATE: mmio page fault, emulate the instruction directly.
  * RET_PF_INVALID: the spte is invalid, let the real page fault path update it.
+ * RET_PF_USER: need to exit to userspace to handle this fault.
  * RET_PF_FIXED: The faulting entry has been fixed.
  * RET_PF_SPURIOUS: The faulting entry was already fixed, e.g. by another vCPU.
  *
@@ -275,6 +277,7 @@ enum {
 	RET_PF_RETRY,
 	RET_PF_EMULATE,
 	RET_PF_INVALID,
+	RET_PF_USER,
 	RET_PF_FIXED,
 	RET_PF_SPURIOUS,
 };
diff --git a/arch/x86/kvm/mmu/mmutrace.h b/arch/x86/kvm/mmu/mmutrace.h
index ae86820cef69..2d7555381955 100644
--- a/arch/x86/kvm/mmu/mmutrace.h
+++ b/arch/x86/kvm/mmu/mmutrace.h
@@ -58,6 +58,7 @@ TRACE_DEFINE_ENUM(RET_PF_CONTINUE);
 TRACE_DEFINE_ENUM(RET_PF_RETRY);
 TRACE_DEFINE_ENUM(RET_PF_EMULATE);
 TRACE_DEFINE_ENUM(RET_PF_INVALID);
+TRACE_DEFINE_ENUM(RET_PF_USER);
 TRACE_DEFINE_ENUM(RET_PF_FIXED);
 TRACE_DEFINE_ENUM(RET_PF_SPURIOUS);
 
-- 
2.41.0.255.g8b1d071c50-goog

