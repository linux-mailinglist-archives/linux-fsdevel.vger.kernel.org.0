Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD8A47C26B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 16:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239094AbhLUPNG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 10:13:06 -0500
Received: from mga18.intel.com ([134.134.136.126]:45664 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239092AbhLUPND (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640099583; x=1671635583;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=COdj1UvXQdkAqzxtXCPYFm0EISfGJg8Z8mzxkFecT00=;
  b=beU8rVoQBTWa+Tw16yFjPtrbBml6hlZe6XcOPyOAa01v1mG6kFtUBklJ
   eKkGvn/ip+GCdbXlV5KTvaSgBDIqpaBnZzqKI1lyXYfuHaDy+vIqwpPzL
   YyARbCY7gxLlv/8j+NN9Be2l0q4Efjzn1PL44FF/9KV0gMN76EfTFfcQ0
   qmzzF6l5D5hCYkIHwrhvkxtQwjqN/9/JYT4q6H3NMui80zLeksHnzu0m+
   mJ/z5Cq3M3kFU+wehalIE0PZCetcwUCD2+LWcEnibHYM5BA13DJa89l1M
   UQa9tt4nA2j1I6sPEjYLVzy0dqjsBoLUg0P850tx3FxeBFSBhZq5j41hm
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="227259435"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="227259435"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 07:13:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="684688485"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2021 07:12:55 -0800
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
Subject: [PATCH v3 07/15] KVM: Special handling for fd-based memory invalidation
Date:   Tue, 21 Dec 2021 23:11:17 +0800
Message-Id: <20211221151125.19446-8-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
References: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For fd-based guest memory, the memory backend (e.g. the fd provider)
should notify KVM to unmap/invalidate the privated memory from KVM
second MMU when userspace punches hole on the fd (e.g. when userspace
converts private memory to shared memory).

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
 virt/kvm/kvm_main.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 856f89ed8ab5..0f2d1002f6a7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -479,6 +479,7 @@ typedef void (*on_lock_fn_t)(struct kvm *kvm, unsigned long start,
 struct kvm_useraddr_range {
 	unsigned long start;
 	unsigned long end;
+	struct inode *inode;
 	pte_t pte;
 	gfn_handler_t handler;
 	on_lock_fn_t on_lock;
@@ -519,9 +520,19 @@ static __always_inline int __kvm_handle_useraddr_range(struct kvm *kvm,
 		slots = __kvm_memslots(kvm, i);
 		kvm_for_each_memslot(slot, slots) {
 			unsigned long useraddr_start, useraddr_end;
+			unsigned long useraddr_base;
 
-			useraddr_start = max(range->start, slot->userspace_addr);
-			useraddr_end = min(range->end, slot->userspace_addr +
+			if (range->inode) {
+				if (!slot->file ||
+				    slot->file->f_inode != range->inode)
+					continue;
+				useraddr_base = slot->file_ofs;
+			} else
+				useraddr_base = slot->userspace_addr;
+
+
+			useraddr_start = max(range->start, useraddr_base);
+			useraddr_end = min(range->end, useraddr_base +
 						  (slot->npages << PAGE_SHIFT));
 			if (useraddr_start >= useraddr_end)
 				continue;
@@ -540,10 +551,10 @@ static __always_inline int __kvm_handle_useraddr_range(struct kvm *kvm,
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
@@ -585,6 +596,7 @@ static __always_inline int kvm_handle_hva_range(struct mmu_notifier *mn,
 		.on_lock	= (void *)kvm_null_fn,
 		.flush_on_ret	= true,
 		.may_block	= false,
+		.inode		= NULL,
 	};
 
 	return __kvm_handle_useraddr_range(kvm, &range);
@@ -604,6 +616,7 @@ static __always_inline int kvm_handle_hva_range_no_flush(struct mmu_notifier *mn
 		.on_lock	= (void *)kvm_null_fn,
 		.flush_on_ret	= false,
 		.may_block	= false,
+		.inode		= NULL,
 	};
 
 	return __kvm_handle_useraddr_range(kvm, &range);
@@ -672,6 +685,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 		.on_lock	= kvm_inc_notifier_count,
 		.flush_on_ret	= true,
 		.may_block	= mmu_notifier_range_blockable(range),
+		.inode		= NULL,
 	};
 
 	trace_kvm_unmap_hva_range(range->start, range->end);
@@ -723,6 +737,7 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 		.on_lock	= kvm_dec_notifier_count,
 		.flush_on_ret	= false,
 		.may_block	= mmu_notifier_range_blockable(range),
+		.inode		= NULL,
 	};
 	bool wake;
 
-- 
2.17.1

