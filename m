Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0897456FFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 14:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbhKSNwn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 08:52:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:10229 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235664AbhKSNwm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 08:52:42 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="234362231"
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="234362231"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 05:49:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="507905069"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 19 Nov 2021 05:49:32 -0800
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
Subject: [RFC v2 PATCH 08/13] KVM: Rename hva memory invalidation code to cover fd-based offset
Date:   Fri, 19 Nov 2021 21:47:34 +0800
Message-Id: <20211119134739.20218-9-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The poupose is for fd-based memslot reusing the same code for memory
invalidation. The code can be reused except changing 'hva' to more
neutral naming 'useraddr'.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/linux/kvm_host.h |  4 ++--
 virt/kvm/kvm_main.c      | 44 ++++++++++++++++++++--------------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e8646103356b..925c4d9f0a31 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1340,9 +1340,9 @@ static inline bool memslot_has_private(const struct kvm_memory_slot *slot)
 }
 
 static inline gfn_t
-hva_to_gfn_memslot(unsigned long hva, struct kvm_memory_slot *slot)
+useraddr_to_gfn_memslot(unsigned long useraddr, struct kvm_memory_slot *slot)
 {
-	gfn_t gfn_offset = (hva - slot->userspace_addr) >> PAGE_SHIFT;
+	gfn_t gfn_offset = (useraddr - slot->userspace_addr) >> PAGE_SHIFT;
 
 	return slot->base_gfn + gfn_offset;
 }
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b8673490d301..d9a6890dd18a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -471,16 +471,16 @@ static void kvm_mmu_notifier_invalidate_range(struct mmu_notifier *mn,
 	srcu_read_unlock(&kvm->srcu, idx);
 }
 
-typedef bool (*hva_handler_t)(struct kvm *kvm, struct kvm_gfn_range *range);
+typedef bool (*gfn_handler_t)(struct kvm *kvm, struct kvm_gfn_range *range);
 
 typedef void (*on_lock_fn_t)(struct kvm *kvm, unsigned long start,
 			     unsigned long end);
 
-struct kvm_hva_range {
+struct kvm_useraddr_range {
 	unsigned long start;
 	unsigned long end;
 	pte_t pte;
-	hva_handler_t handler;
+	gfn_handler_t handler;
 	on_lock_fn_t on_lock;
 	bool flush_on_ret;
 	bool may_block;
@@ -499,8 +499,8 @@ static void kvm_null_fn(void)
 }
 #define IS_KVM_NULL_FN(fn) ((fn) == (void *)kvm_null_fn)
 
-static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
-						  const struct kvm_hva_range *range)
+static __always_inline int __kvm_handle_useraddr_range(struct kvm *kvm,
+					const struct kvm_useraddr_range *range)
 {
 	bool ret = false, locked = false;
 	struct kvm_gfn_range gfn_range;
@@ -518,12 +518,12 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
 	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
 		slots = __kvm_memslots(kvm, i);
 		kvm_for_each_memslot(slot, slots) {
-			unsigned long hva_start, hva_end;
+			unsigned long useraddr_start, useraddr_end;
 
-			hva_start = max(range->start, slot->userspace_addr);
-			hva_end = min(range->end, slot->userspace_addr +
+			useraddr_start = max(range->start, slot->userspace_addr);
+			useraddr_end = min(range->end, slot->userspace_addr +
 						  (slot->npages << PAGE_SHIFT));
-			if (hva_start >= hva_end)
+			if (useraddr_start >= useraddr_end)
 				continue;
 
 			/*
@@ -536,11 +536,11 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
 			gfn_range.may_block = range->may_block;
 
 			/*
-			 * {gfn(page) | page intersects with [hva_start, hva_end)} =
+			 * {gfn(page) | page intersects with [useraddr_start, useraddr_end)} =
 			 * {gfn_start, gfn_start+1, ..., gfn_end-1}.
 			 */
-			gfn_range.start = hva_to_gfn_memslot(hva_start, slot);
-			gfn_range.end = hva_to_gfn_memslot(hva_end + PAGE_SIZE - 1, slot);
+			gfn_range.start = useraddr_to_gfn_memslot(useraddr_start, slot);
+			gfn_range.end = useraddr_to_gfn_memslot(useraddr_end + PAGE_SIZE - 1, slot);
 			gfn_range.slot = slot;
 
 			if (!locked) {
@@ -571,10 +571,10 @@ static __always_inline int kvm_handle_hva_range(struct mmu_notifier *mn,
 						unsigned long start,
 						unsigned long end,
 						pte_t pte,
-						hva_handler_t handler)
+						gfn_handler_t handler)
 {
 	struct kvm *kvm = mmu_notifier_to_kvm(mn);
-	const struct kvm_hva_range range = {
+	const struct kvm_useraddr_range range = {
 		.start		= start,
 		.end		= end,
 		.pte		= pte,
@@ -584,16 +584,16 @@ static __always_inline int kvm_handle_hva_range(struct mmu_notifier *mn,
 		.may_block	= false,
 	};
 
-	return __kvm_handle_hva_range(kvm, &range);
+	return __kvm_handle_useraddr_range(kvm, &range);
 }
 
 static __always_inline int kvm_handle_hva_range_no_flush(struct mmu_notifier *mn,
 							 unsigned long start,
 							 unsigned long end,
-							 hva_handler_t handler)
+							 gfn_handler_t handler)
 {
 	struct kvm *kvm = mmu_notifier_to_kvm(mn);
-	const struct kvm_hva_range range = {
+	const struct kvm_useraddr_range range = {
 		.start		= start,
 		.end		= end,
 		.pte		= __pte(0),
@@ -603,7 +603,7 @@ static __always_inline int kvm_handle_hva_range_no_flush(struct mmu_notifier *mn
 		.may_block	= false,
 	};
 
-	return __kvm_handle_hva_range(kvm, &range);
+	return __kvm_handle_useraddr_range(kvm, &range);
 }
 static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
 					struct mm_struct *mm,
@@ -661,7 +661,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 					const struct mmu_notifier_range *range)
 {
 	struct kvm *kvm = mmu_notifier_to_kvm(mn);
-	const struct kvm_hva_range hva_range = {
+	const struct kvm_useraddr_range useraddr_range = {
 		.start		= range->start,
 		.end		= range->end,
 		.pte		= __pte(0),
@@ -685,7 +685,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 	kvm->mn_active_invalidate_count++;
 	spin_unlock(&kvm->mn_invalidate_lock);
 
-	__kvm_handle_hva_range(kvm, &hva_range);
+	__kvm_handle_useraddr_range(kvm, &useraddr_range);
 
 	return 0;
 }
@@ -712,7 +712,7 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 					const struct mmu_notifier_range *range)
 {
 	struct kvm *kvm = mmu_notifier_to_kvm(mn);
-	const struct kvm_hva_range hva_range = {
+	const struct kvm_useraddr_range useraddr_range = {
 		.start		= range->start,
 		.end		= range->end,
 		.pte		= __pte(0),
@@ -723,7 +723,7 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 	};
 	bool wake;
 
-	__kvm_handle_hva_range(kvm, &hva_range);
+	__kvm_handle_useraddr_range(kvm, &useraddr_range);
 
 	/* Pairs with the increment in range_start(). */
 	spin_lock(&kvm->mn_invalidate_lock);
-- 
2.17.1

