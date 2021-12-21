Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BEA47C273
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 16:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239138AbhLUPNT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 10:13:19 -0500
Received: from mga09.intel.com ([134.134.136.24]:55988 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239092AbhLUPNT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:13:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640099599; x=1671635599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=fdSTZmNU5WiLyWiykXl851QB1KBby9LMRNODzJD3mcE=;
  b=AfBy0Po48GjAbWZS1riIomnCboTiPlfCM5CsUnrJX0i/v1/jeO/UdYwA
   f2Q7r0T0oIcE+ojLG8bZsvMqTGoIjJxV/4m5HcPsV36qcPv6fjVLo+PhR
   o1b5NXoBnArv7+xD5JzqjhmKlRw+23zf8IUmejuM9/p60P6mQKZEGrwZa
   /LzKVELdjAE+NHEzHxWlSDDg5mvsZZchMO/rpOR7Mx6WNNXlhB/vUALEJ
   csSgRrUIegrgq8BoCusbh7LVZi8QVQUdiVbjQM5GZucOE+O23WakQDZHr
   hev9uWX+cmm+DK1tWlCCXL8n15g86z1RmXjr1CwNnId73qtiy88T4UmUd
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="240216686"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="240216686"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 07:13:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="684688531"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2021 07:13:10 -0800
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
Subject: [PATCH v3 09/15] KVM: Implement fd-based memory invalidation
Date:   Tue, 21 Dec 2021 23:11:19 +0800
Message-Id: <20211221151125.19446-10-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
References: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

KVM gets notified when userspace punches a hole in a fd which is used
for guest memory. KVM should invalidate the mapping in the second MMU
page tables. This is the same logic as MMU notifier invalidation except
the fd related information is carried around to indicate the memory
range. KVM hence can reuse most of existing MMU notifier invalidation
code including looping through the memslots and then calling into
kvm_unmap_gfn_range() which should do whatever needed for fd-based
memory unmapping (e.g. for private memory managed by TDX it may need
call into SEAM-MODULE).

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/linux/kvm_host.h |  8 ++++-
 virt/kvm/kvm_main.c      | 69 +++++++++++++++++++++++++++++++---------
 virt/kvm/memfd.c         |  2 ++
 3 files changed, 63 insertions(+), 16 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 7279f46f35d3..d9573305e273 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -229,7 +229,7 @@ bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
 #endif
 
-#ifdef KVM_ARCH_WANT_MMU_NOTIFIER
+#if defined(KVM_ARCH_WANT_MMU_NOTIFIER) || defined(CONFIG_MEMFD_OPS)
 struct kvm_gfn_range {
 	struct kvm_memory_slot *slot;
 	gfn_t start;
@@ -1874,4 +1874,10 @@ static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
 /* Max number of entries allowed for each kvm dirty ring */
 #define  KVM_DIRTY_RING_MAX_ENTRIES  65536
 
+#ifdef CONFIG_MEMFD_OPS
+int kvm_memfd_invalidate_range(struct kvm *kvm, struct inode *inode,
+			       unsigned long start, unsigned long end);
+#endif /* CONFIG_MEMFD_OPS */
+
+
 #endif
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 59f01e68337b..d84cb867b686 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -453,7 +453,8 @@ void kvm_vcpu_destroy(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_destroy);
 
-#if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
+#if defined(CONFIG_MEMFD_OPS) ||\
+	(defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER))
 
 typedef bool (*gfn_handler_t)(struct kvm *kvm, struct kvm_gfn_range *range);
 
@@ -564,6 +565,30 @@ static __always_inline int __kvm_handle_useraddr_range(struct kvm *kvm,
 	/* The notifiers are averse to booleans. :-( */
 	return (int)ret;
 }
+
+static void mn_active_invalidate_count_inc(struct kvm *kvm)
+{
+	spin_lock(&kvm->mn_invalidate_lock);
+	kvm->mn_active_invalidate_count++;
+	spin_unlock(&kvm->mn_invalidate_lock);
+
+}
+
+static void mn_active_invalidate_count_dec(struct kvm *kvm)
+{
+	bool wake;
+
+	spin_lock(&kvm->mn_invalidate_lock);
+	wake = (--kvm->mn_active_invalidate_count == 0);
+	spin_unlock(&kvm->mn_invalidate_lock);
+
+	/*
+	 * There can only be one waiter, since the wait happens under
+	 * slots_lock.
+	 */
+	if (wake)
+		rcuwait_wake_up(&kvm->mn_memslots_update_rcuwait);
+}
 #endif
 
 #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
@@ -701,9 +726,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 	 *
 	 * Pairs with the decrement in range_end().
 	 */
-	spin_lock(&kvm->mn_invalidate_lock);
-	kvm->mn_active_invalidate_count++;
-	spin_unlock(&kvm->mn_invalidate_lock);
+	mn_active_invalidate_count_inc(kvm);
 
 	__kvm_handle_useraddr_range(kvm, &useraddr_range);
 
@@ -742,21 +765,11 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 		.may_block	= mmu_notifier_range_blockable(range),
 		.inode		= NULL,
 	};
-	bool wake;
 
 	__kvm_handle_useraddr_range(kvm, &useraddr_range);
 
 	/* Pairs with the increment in range_start(). */
-	spin_lock(&kvm->mn_invalidate_lock);
-	wake = (--kvm->mn_active_invalidate_count == 0);
-	spin_unlock(&kvm->mn_invalidate_lock);
-
-	/*
-	 * There can only be one waiter, since the wait happens under
-	 * slots_lock.
-	 */
-	if (wake)
-		rcuwait_wake_up(&kvm->mn_memslots_update_rcuwait);
+	mn_active_invalidate_count_dec(kvm);
 
 	BUG_ON(kvm->mmu_notifier_count < 0);
 }
@@ -841,6 +854,32 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
 
 #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
 
+#ifdef CONFIG_MEMFD_OPS
+int kvm_memfd_invalidate_range(struct kvm *kvm, struct inode *inode,
+			       unsigned long start, unsigned long end)
+{
+	int ret;
+	const struct kvm_useraddr_range useraddr_range = {
+		.start		= start,
+		.end		= end,
+		.pte		= __pte(0),
+		.handler	= kvm_unmap_gfn_range,
+		.on_lock	= (void *)kvm_null_fn,
+		.flush_on_ret	= true,
+		.may_block	= false,
+		.inode		= inode,
+	};
+
+
+	/* Prevent memslot modification */
+	mn_active_invalidate_count_inc(kvm);
+	ret = __kvm_handle_useraddr_range(kvm, &useraddr_range);
+	mn_active_invalidate_count_dec(kvm);
+
+	return ret;
+}
+#endif /* CONFIG_MEMFD_OPS */
+
 #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
 static int kvm_pm_notifier_call(struct notifier_block *bl,
 				unsigned long state,
diff --git a/virt/kvm/memfd.c b/virt/kvm/memfd.c
index 96a1a5bee0f7..d092a9b6f496 100644
--- a/virt/kvm/memfd.c
+++ b/virt/kvm/memfd.c
@@ -16,6 +16,8 @@ static const struct memfd_pfn_ops *memfd_ops;
 static void memfd_invalidate_page_range(struct inode *inode, void *owner,
 					pgoff_t start, pgoff_t end)
 {
+	kvm_memfd_invalidate_range(owner, inode, start >> PAGE_SHIFT,
+						 end >> PAGE_SHIFT);
 }
 
 static void memfd_fallocate(struct inode *inode, void *owner,
-- 
2.17.1

