Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1C747E36F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 13:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348408AbhLWMcS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 07:32:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:56991 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348411AbhLWMcR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640262737; x=1671798737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=4zBy2wqGUUHRa+bg8KFrUxUekBSmOOoI4eennjfoLXQ=;
  b=I9UsUNKoqYJWpUHAm/OqCdNPYfHIFbkwPHdL5+EXKIe5T4b4Cs8i4uqI
   izXCECctpB44wkkeCVg19fdvDcXt8l5kiYKhaSe9sB2j+4iaO9y8WyuTJ
   1qnr1ewgr75X0bA6C7ySo+Ag8ii45QZSlrMV7LXWQwrDG/WzQZS/7U2j+
   SUb/HnV07ZxngQmt63nWn+ijT+H9xZ73gWQQlZbyLrrbenzzBS9nUIVaz
   X225qFLhg4SVK/o2p4xC3MBONYSVSw+E8RKGEW5BkJmx4boiqIfgWTa/E
   42g4OcLvQ2vHVKOaRpcerBz7GcU3GLfFBzdKtrGhbbc8JS8PnoNNxbMIZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="241040454"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="241040454"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 04:32:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="522078930"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 23 Dec 2021 04:32:09 -0800
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
Subject: [PATCH v3 kvm/queue 10/16] KVM: Implement fd-based memory invalidation
Date:   Thu, 23 Dec 2021 20:30:05 +0800
Message-Id: <20211223123011.41044-11-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

KVM gets notified when userspace punches a hole in a fd which is used
for guest memory. KVM should invalidate the mapping in the secondary
MMU page tables. This is the same logic as MMU notifier invalidation
except the fd related information is carried around to indicate the
memory range. KVM hence can reuse most of existing MMU notifier
invalidation code including looping through the memslots and then
calling into kvm_unmap_gfn_range() which should do whatever needed for
fd-based memory unmapping (e.g. for private memory managed by TDX it
may need call into SEAM-MODULE).

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/linux/kvm_host.h |  8 ++++-
 virt/kvm/kvm_main.c      | 69 +++++++++++++++++++++++++++++++---------
 virt/kvm/memfd.c         |  2 ++
 3 files changed, 63 insertions(+), 16 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 07863ff855cd..be567925831b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -233,7 +233,7 @@ bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
 #endif
 
-#ifdef KVM_ARCH_WANT_MMU_NOTIFIER
+#if defined(KVM_ARCH_WANT_MMU_NOTIFIER) || defined(CONFIG_MEMFD_OPS)
 struct kvm_gfn_range {
 	struct kvm_memory_slot *slot;
 	gfn_t start;
@@ -2012,4 +2012,10 @@ static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
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
index 7b7530b1ea1e..f495c1a313bd 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -468,7 +468,8 @@ void kvm_destroy_vcpus(struct kvm *kvm)
 }
 EXPORT_SYMBOL_GPL(kvm_destroy_vcpus);
 
-#if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
+#if defined(CONFIG_MEMFD_OPS) ||\
+	(defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER))
 
 typedef bool (*gfn_handler_t)(struct kvm *kvm, struct kvm_gfn_range *range);
 
@@ -595,6 +596,30 @@ static __always_inline int __kvm_handle_useraddr_range(struct kvm *kvm,
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
@@ -732,9 +757,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 	 *
 	 * Pairs with the decrement in range_end().
 	 */
-	spin_lock(&kvm->mn_invalidate_lock);
-	kvm->mn_active_invalidate_count++;
-	spin_unlock(&kvm->mn_invalidate_lock);
+	mn_active_invalidate_count_inc(kvm);
 
 	__kvm_handle_useraddr_range(kvm, &useraddr_range);
 
@@ -773,21 +796,11 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
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
@@ -872,6 +885,32 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
 
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
index 662393a76782..547f65f5a187 100644
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

