Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B90B47C266
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 16:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbhLUPM7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 10:12:59 -0500
Received: from mga05.intel.com ([192.55.52.43]:21317 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239088AbhLUPM4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:12:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640099576; x=1671635576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=4BfQuzincLOVrXQzV2p7CB14wEIknv0E51W7rzSAi78=;
  b=S3RWjVRxk2sO6a1D0RpHIvfnGtfDjmgwVN6N1gAZGL9sHHOrJ0PCwrcv
   Vs4fBB7ZAUbxRI7qOMRX1vS+ApaOiK8imtVMKQhJA8Z1/eK67Q2a5py6E
   lYYgxOXK6PHdFXQ6K5GK8pP3bNZavSy+rAak4zZuSE6S2cOvugDRLzDtb
   1BWrXJF+G1YQyYQJOFjguuwVceALPMRodJQgxeUtxxYHFVHrR/lifxyxF
   UNiuvtf3HCbT+bKFMjN6he/CSJmCN9PyCWDBwaMeEhKG4lmf3MF6MGYS4
   maDl7IkPwNEFU8gFyUpBW4k40y4D7ljZoiQ9ZGmGi/jOCfAwcgset++k2
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="326709785"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="326709785"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 07:12:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="684688446"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2021 07:12:48 -0800
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
Subject: [PATCH v3 06/15] KVM: Refactor hva based memory invalidation code
Date:   Tue, 21 Dec 2021 23:11:16 +0800
Message-Id: <20211221151125.19446-7-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
References: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The purpose of this patch is for fd-based memslot to reuse the same
mmu_notifier based guest memory invalidation code for private pages.

No functional changes except renaming 'hva' to more neutral 'useraddr'
so that it can also cover 'offset' in a fd that private pages live in.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/linux/kvm_host.h |  8 +++++--
 virt/kvm/kvm_main.c      | 47 +++++++++++++++++++++-------------------
 2 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index b0b63c9a160f..7279f46f35d3 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1327,9 +1327,13 @@ static inline int memslot_id(struct kvm *kvm, gfn_t gfn)
 }
 
 static inline gfn_t
-hva_to_gfn_memslot(unsigned long hva, struct kvm_memory_slot *slot)
+useraddr_to_gfn_memslot(unsigned long useraddr, struct kvm_memory_slot *slot,
+			bool addr_is_hva)
 {
-	gfn_t gfn_offset = (hva - slot->userspace_addr) >> PAGE_SHIFT;
+	unsigned long useraddr_base = addr_is_hva ? slot->userspace_addr
+						  : slot->file_ofs;
+
+	gfn_t gfn_offset = (useraddr - useraddr_base) >> PAGE_SHIFT;
 
 	return slot->base_gfn + gfn_offset;
 }
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 68018ee7f0cd..856f89ed8ab5 100644
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
@@ -536,11 +536,14 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
 			gfn_range.may_block = range->may_block;
 
 			/*
-			 * {gfn(page) | page intersects with [hva_start, hva_end)} =
+			 * {gfn(page) | page intersects with [useraddr_start, useraddr_end)} =
 			 * {gfn_start, gfn_start+1, ..., gfn_end-1}.
 			 */
-			gfn_range.start = hva_to_gfn_memslot(hva_start, slot);
-			gfn_range.end = hva_to_gfn_memslot(hva_end + PAGE_SIZE - 1, slot);
+			gfn_range.start = useraddr_to_gfn_memslot(useraddr_start,
+								  slot, true);
+			gfn_range.end = useraddr_to_gfn_memslot(
+						useraddr_end + PAGE_SIZE - 1,
+						slot, true);
 			gfn_range.slot = slot;
 
 			if (!locked) {
@@ -571,10 +574,10 @@ static __always_inline int kvm_handle_hva_range(struct mmu_notifier *mn,
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
@@ -584,16 +587,16 @@ static __always_inline int kvm_handle_hva_range(struct mmu_notifier *mn,
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
@@ -603,7 +606,7 @@ static __always_inline int kvm_handle_hva_range_no_flush(struct mmu_notifier *mn
 		.may_block	= false,
 	};
 
-	return __kvm_handle_hva_range(kvm, &range);
+	return __kvm_handle_useraddr_range(kvm, &range);
 }
 static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
 					struct mm_struct *mm,
@@ -661,7 +664,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 					const struct mmu_notifier_range *range)
 {
 	struct kvm *kvm = mmu_notifier_to_kvm(mn);
-	const struct kvm_hva_range hva_range = {
+	const struct kvm_useraddr_range useraddr_range = {
 		.start		= range->start,
 		.end		= range->end,
 		.pte		= __pte(0),
@@ -685,7 +688,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 	kvm->mn_active_invalidate_count++;
 	spin_unlock(&kvm->mn_invalidate_lock);
 
-	__kvm_handle_hva_range(kvm, &hva_range);
+	__kvm_handle_useraddr_range(kvm, &useraddr_range);
 
 	return 0;
 }
@@ -712,7 +715,7 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 					const struct mmu_notifier_range *range)
 {
 	struct kvm *kvm = mmu_notifier_to_kvm(mn);
-	const struct kvm_hva_range hva_range = {
+	const struct kvm_useraddr_range useraddr_range = {
 		.start		= range->start,
 		.end		= range->end,
 		.pte		= __pte(0),
@@ -723,7 +726,7 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 	};
 	bool wake;
 
-	__kvm_handle_hva_range(kvm, &hva_range);
+	__kvm_handle_useraddr_range(kvm, &useraddr_range);
 
 	/* Pairs with the increment in range_start(). */
 	spin_lock(&kvm->mn_invalidate_lock);
-- 
2.17.1

