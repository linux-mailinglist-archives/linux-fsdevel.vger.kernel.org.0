Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BA2457007
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 14:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbhKSNxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 08:53:07 -0500
Received: from mga07.intel.com ([134.134.136.100]:42156 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235583AbhKSNxH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 08:53:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="297831233"
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="297831233"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 05:50:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="507905181"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 19 Nov 2021 05:49:57 -0800
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
Subject: [RFC v2 PATCH 11/13] KVM: Add kvm_map_gfn_range
Date:   Fri, 19 Nov 2021 21:47:37 +0800
Message-Id: <20211119134739.20218-12-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This may be used in the fallocate callback for memfd based memory
to setup the mapping for KVM second MMU when the pages are allocated
in the memory backing store.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 arch/x86/kvm/mmu/mmu.c   | 47 ++++++++++++++++++++++++++++++++++++++++
 include/linux/kvm_host.h |  2 ++
 virt/kvm/kvm_main.c      |  5 +++++
 3 files changed, 54 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index cd5d1f923694..5c475a161a3c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1951,6 +1951,53 @@ static __always_inline bool kvm_handle_gfn_range(struct kvm *kvm,
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
index f0fd32f6eab3..d841ed877b4b 100644
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
index 65055ac460eb..492c1a99ec63 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -471,6 +471,11 @@ static void kvm_mmu_notifier_invalidate_range(struct mmu_notifier *mn,
 	srcu_read_unlock(&kvm->srcu, idx);
 }
 
+bool __weak kvm_map_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	return false;
+}
+
 typedef bool (*gfn_handler_t)(struct kvm *kvm, struct kvm_gfn_range *range);
 
 typedef void (*on_lock_fn_t)(struct kvm *kvm, unsigned long start,
-- 
2.17.1

