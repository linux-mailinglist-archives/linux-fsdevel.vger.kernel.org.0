Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FBA47C26F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 16:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239127AbhLUPNL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 10:13:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:50989 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239092AbhLUPNL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640099591; x=1671635591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=mFDIpY3/LyMlA/FBo77jj+CP6HruamtUy42MpTsU/84=;
  b=AVwry+phgw40FTojjGSPSXlou3Ah2zxcPkeiTCsiA0wmgp+dlKhG8ATV
   p931r/L8hjKta302PqrQVR+XfLtbQO98DbJbMCbdpLy/wbQxoRJsjmpku
   2qh9HfuYJY3oTRT8yFykj6iBW1qbGhHQ4+y8xnwVvlNNs+vgl2LuhOQQ8
   p9eH52RguTr290RlrE7y1ZqoCGccWpyLNXNkgKXQ/jyq+yA5W2BFFrD6d
   tRV1fyCrkzxLbjVRMWU6tddTh4JELHmkeSyzd/iJ9VM5phISFJQHeeKOA
   JfFHAhqihlAvio1isJ23pKky4/EDQhmYc9TSUfh6RW6yOhD5hupvVTr5n
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="264601414"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="264601414"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 07:13:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="684688504"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2021 07:13:03 -0800
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
Subject: [PATCH v3 08/15] KVM: Split out common memory invalidation code
Date:   Tue, 21 Dec 2021 23:11:18 +0800
Message-Id: <20211221151125.19446-9-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
References: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When fd-based memory is enabled, there will be two types of memory
invalidation:
  - memory invalidation from native MMU through mmu_notifier callback
    for hva-based memory, and,
  - memory invalidation from memfd through memfd_notifier callback for
    fd-based memory.

Some code can be shared between these two types of memory invalidation.
This patch moves these shared code into one place so that it can be
used for CONFIG_MMU_NOTIFIER as well as CONFIG_MEMFD_NOTIFIER.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 virt/kvm/kvm_main.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0f2d1002f6a7..59f01e68337b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -454,22 +454,6 @@ void kvm_vcpu_destroy(struct kvm_vcpu *vcpu)
 EXPORT_SYMBOL_GPL(kvm_vcpu_destroy);
 
 #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
-static inline struct kvm *mmu_notifier_to_kvm(struct mmu_notifier *mn)
-{
-	return container_of(mn, struct kvm, mmu_notifier);
-}
-
-static void kvm_mmu_notifier_invalidate_range(struct mmu_notifier *mn,
-					      struct mm_struct *mm,
-					      unsigned long start, unsigned long end)
-{
-	struct kvm *kvm = mmu_notifier_to_kvm(mn);
-	int idx;
-
-	idx = srcu_read_lock(&kvm->srcu);
-	kvm_arch_mmu_notifier_invalidate_range(kvm, start, end);
-	srcu_read_unlock(&kvm->srcu, idx);
-}
 
 typedef bool (*gfn_handler_t)(struct kvm *kvm, struct kvm_gfn_range *range);
 
@@ -580,6 +564,25 @@ static __always_inline int __kvm_handle_useraddr_range(struct kvm *kvm,
 	/* The notifiers are averse to booleans. :-( */
 	return (int)ret;
 }
+#endif
+
+#if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
+static inline struct kvm *mmu_notifier_to_kvm(struct mmu_notifier *mn)
+{
+	return container_of(mn, struct kvm, mmu_notifier);
+}
+
+static void kvm_mmu_notifier_invalidate_range(struct mmu_notifier *mn,
+					      struct mm_struct *mm,
+					      unsigned long start, unsigned long end)
+{
+	struct kvm *kvm = mmu_notifier_to_kvm(mn);
+	int idx;
+
+	idx = srcu_read_lock(&kvm->srcu);
+	kvm_arch_mmu_notifier_invalidate_range(kvm, start, end);
+	srcu_read_unlock(&kvm->srcu, idx);
+}
 
 static __always_inline int kvm_handle_hva_range(struct mmu_notifier *mn,
 						unsigned long start,
-- 
2.17.1

