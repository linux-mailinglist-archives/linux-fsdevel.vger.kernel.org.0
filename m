Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342F947C276
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 16:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbhLUPN1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 10:13:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:45698 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235964AbhLUPN0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640099606; x=1671635606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=UCZ3wCwPhn9VbKdlrvPKEkilFsRm15PDP2AM/u3UGdI=;
  b=PenU/4XRYr0yLcYA8XRCR0hVgYdTsxrYHhvHhHwdjeP/wZNLANrNq8JC
   3hPHQTwMFuAw7k7u9SqK0RwB0VOXIUhYCHA/ebq4qUDjoOVDchJ35S/b5
   lFvhJCV/sPVfL+m70I8cIZeuytLDbWLXlY/Ev7oTe+e93u6pg1QfRnqLB
   f/+dwnvCkvK40FybeveEieRzekkZV+LcVXREHQ1CAAKVP2gu6dDBpzsU7
   wZejemyKh1CVW8zH5gk5ccDsUZ28AIK3Oez9UuplyKm0v2Ekrvvg7ADNb
   H1WiK9mkULODpuMBCnJpuydDaFOzYQbNozm94rsD/EYg6jd3nNPvUCJ73
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="227259520"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="227259520"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 07:13:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="684688544"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2021 07:13:18 -0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: [PATCH v3 10/15] KVM: Add kvm_map_gfn_range
Date:   Tue, 21 Dec 2021 23:11:20 +0800
Message-Id: <20211221151125.19446-11-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
References: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This new function establishes the mapping in KVM page tables for a
given gfn range. It can be used in the memory fallocate callback for
memfd based memory to establish the mapping for KVM secondary MMU when
the pages are allocated in the memory backend.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 arch/x86/kvm/mmu/mmu.c   | 47 ++++++++++++++++++++++++++++++++++++++++
 include/linux/kvm_host.h |  2 ++
 virt/kvm/kvm_main.c      |  5 +++++
 3 files changed, 54 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 2da19356679d..a7006e1ac2d2 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1781,6 +1781,53 @@ static __always_inline bool kvm_handle_gfn_range(struct kvm *kvm,
 	return ret;
 }
 
+bool kvm_map_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	struct kvm_vcpu *vcpu;
+	kvm_pfn_t pfn;
+	gfn_t gfn;
+	int idx;
+	bool ret = true;
+
+	/* Need vcpu context for kvm_mmu_do_page_fault. */
+	vcpu = kvm_get_vcpu(kvm, 0);
+	if (mutex_lock_killable(&vcpu->mutex))
+		return false;
+
+	vcpu_load(vcpu);
+	idx = srcu_read_lock(&kvm->srcu);
+
+	kvm_mmu_reload(vcpu);
+
+	gfn = range->start;
+	while (gfn < range->end) {
+		if (signal_pending(current)) {
+			ret = false;
+			break;
+		}
+
+		if (need_resched())
+			cond_resched();
+
+		pfn = kvm_mmu_do_page_fault(vcpu, gfn << PAGE_SHIFT,
+					PFERR_WRITE_MASK | PFERR_USER_MASK,
+					false);
+		if (is_error_noslot_pfn(pfn) || kvm->vm_bugged) {
+			ret = false;
+			break;
+		}
+
+		gfn++;
+	}
+
+	srcu_read_unlock(&kvm->srcu, idx);
+	vcpu_put(vcpu);
+
+	mutex_unlock(&vcpu->mutex);
+
+	return ret;
+}
+
 bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
 	bool flush = false;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index d9573305e273..9c02fb53b8ab 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -237,6 +237,8 @@ struct kvm_gfn_range {
 	pte_t pte;
 	bool may_block;
 };
+
+bool kvm_map_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range);
 bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range);
 bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
 bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d84cb867b686..b9855b2fdaae 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -456,6 +456,11 @@ EXPORT_SYMBOL_GPL(kvm_vcpu_destroy);
 #if defined(CONFIG_MEMFD_OPS) ||\
 	(defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER))
 
+bool __weak kvm_map_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	return false;
+}
+
 typedef bool (*gfn_handler_t)(struct kvm *kvm, struct kvm_gfn_range *range);
 
 typedef void (*on_lock_fn_t)(struct kvm *kvm, unsigned long start,
-- 
2.17.1

