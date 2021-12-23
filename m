Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9841647E363
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 13:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348372AbhLWMcC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 07:32:02 -0500
Received: from mga09.intel.com ([134.134.136.24]:61032 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236120AbhLWMb7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640262719; x=1671798719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=jFXnBQCQUYkIJxpEwP0R21h1nTh23vZQC9pPmI8hXVw=;
  b=S5Q+wsSqSalLcaXnq5syMWS/Pg2uOXLukoQajZpnRbffNncJ6wSRgMxS
   RrMBmgaAjxeO3VopyG+mAksCEpzFEnRMzZ+dPaDy9vtRgoMT2m3sd9YP9
   yySLpuW+sMM8RyNC548oVdaxQpR2wu4jKaVevAM5yX/72HbBlt34gL6F4
   lp5/rfSyOtTJSvl2PtLGPQgxtHRPQYWIQYOC/fRGhYUIuqoCgQJe8emIP
   xN2LpjUXDI47Oq5ZZwrldwuoy2ji8ARI/SaFpN/b/Z8cLeU6fHYyhTvP+
   8TrbxOIU84gBCAjert8SU/eLf0LLjSLdt9MNFnOLxaM+17u2Y3HRZc5Mb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="240619765"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="240619765"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 04:31:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="522078821"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 23 Dec 2021 04:31:50 -0800
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
Subject: [PATCH v3 kvm/queue 08/16] KVM: Special handling for fd-based memory invalidation
Date:   Thu, 23 Dec 2021 20:30:03 +0800
Message-Id: <20211223123011.41044-9-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For fd-based guest memory, the memory backend (e.g. the fd provider)
should notify KVM to unmap/invalidate the privated memory from KVM
secondary MMU when userspace punches hole on the fd (e.g. when
userspace converts private memory to shared memory).

To support fd-based memory invalidation, existing hva-based memory
invalidation needs to be extended. A new 'inode' for the fd is passed in
from memfd_falloc_notifier and the 'start/end' will represent start/end
offset in the fd instead of hva range. During the invalidation KVM needs
to check this inode against that in the memslot. Only when the 'inode' in
memslot equals to the passed-in 'inode' we should invalidate the mapping
in KVM.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 virt/kvm/kvm_main.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b7a1c4d7eaaa..19736a0013a0 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -494,6 +494,7 @@ typedef void (*on_lock_fn_t)(struct kvm *kvm, unsigned long start,
 struct kvm_useraddr_range {
 	unsigned long start;
 	unsigned long end;
+	struct inode *inode;
 	pte_t pte;
 	gfn_handler_t handler;
 	on_lock_fn_t on_lock;
@@ -544,14 +545,27 @@ static __always_inline int __kvm_handle_useraddr_range(struct kvm *kvm,
 		struct interval_tree_node *node;
 
 		slots = __kvm_memslots(kvm, i);
-		useraddr_tree = &slots->hva_tree;
+		useraddr_tree = range->inode ? &slots->ofs_tree : &slots->hva_tree;
 		kvm_for_each_memslot_in_useraddr_range(node, useraddr_tree,
 						  range->start, range->end - 1) {
 			unsigned long useraddr_start, useraddr_end;
+			unsigned long useraddr_base;
+
+			if (range->inode) {
+				slot = container_of(node, struct kvm_memory_slot,
+						    ofs_node[slots->node_idx]);
+				if (!slot->file ||
+				    slot->file->f_inode != range->inode)
+					continue;
+				useraddr_base = slot->ofs;
+			} else {
+				slot = container_of(node, struct kvm_memory_slot,
+						    hva_node[slots->node_idx]);
+				useraddr_base = slot->userspace_addr;
+			}
 
-			slot = container_of(node, struct kvm_memory_slot, hva_node[slots->node_idx]);
-			useraddr_start = max(range->start, slot->userspace_addr);
-			useraddr_end = min(range->end, slot->userspace_addr +
+			useraddr_start = max(range->start, useraddr_base);
+			useraddr_end = min(range->end, useraddr_base +
 						       (slot->npages << PAGE_SHIFT));
 
 			/*
@@ -568,10 +582,10 @@ static __always_inline int __kvm_handle_useraddr_range(struct kvm *kvm,
 			 * {gfn_start, gfn_start+1, ..., gfn_end-1}.
 			 */
 			gfn_range.start = useraddr_to_gfn_memslot(useraddr_start,
-								  slot, true);
+							slot, !range->inode);
 			gfn_range.end = useraddr_to_gfn_memslot(
 						useraddr_end + PAGE_SIZE - 1,
-						slot, true);
+						slot, !range->inode);
 			gfn_range.slot = slot;
 
 			if (!locked) {
@@ -613,6 +627,7 @@ static __always_inline int kvm_handle_hva_range(struct mmu_notifier *mn,
 		.on_lock	= (void *)kvm_null_fn,
 		.flush_on_ret	= true,
 		.may_block	= false,
+		.inode		= NULL,
 	};
 
 	return __kvm_handle_useraddr_range(kvm, &range);
@@ -632,6 +647,7 @@ static __always_inline int kvm_handle_hva_range_no_flush(struct mmu_notifier *mn
 		.on_lock	= (void *)kvm_null_fn,
 		.flush_on_ret	= false,
 		.may_block	= false,
+		.inode		= NULL,
 	};
 
 	return __kvm_handle_useraddr_range(kvm, &range);
@@ -700,6 +716,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 		.on_lock	= kvm_inc_notifier_count,
 		.flush_on_ret	= true,
 		.may_block	= mmu_notifier_range_blockable(range),
+		.inode		= NULL,
 	};
 
 	trace_kvm_unmap_hva_range(range->start, range->end);
@@ -751,6 +768,7 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 		.on_lock	= kvm_dec_notifier_count,
 		.flush_on_ret	= false,
 		.may_block	= mmu_notifier_range_blockable(range),
+		.inode		= NULL,
 	};
 	bool wake;
 
-- 
2.17.1

