Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E864A47E364
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 13:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348381AbhLWMcC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 07:32:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:22770 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348368AbhLWMb7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640262719; x=1671798719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=aIJ/jdrIZIbqeWf2gsio5EQmDbnrSHD8LOLFRVTJ4eg=;
  b=LsT8mQj1Uoq4pQfwaCdvYtwoWKJW+SHwG3NAcTvJXdNksSc0OZgr0WjD
   qxpao3jpuznf5QAc2cz4se2yajYxewUzu8brt0Sfj4wG7vb0oZ+8DHbK8
   7AMANfmGKztoFNXL2B4CVavjQZVzdcEe+imKzubwdlieglSexgvT81n8H
   iIYMT4Ubzhm7GAABcv5cVn1rOJ2UUNLR92Ll18zJTEoHzwUGciDlNAJDN
   zPLA8SE8si5ky8hfQDitIQ3IrWF8KaY2HjEMTUYUVqsA77erZ/BGaIX+j
   aBx3x5nFO6ssxYxmjknvhX7M/KAXUgQ63gJeAeKXPlVFmabetQBtJFmzA
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="304187863"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="304187863"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 04:31:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="522078687"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 23 Dec 2021 04:31:27 -0800
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
Subject: [PATCH v3 kvm/queue 05/16] KVM: Maintain ofs_tree for fast memslot lookup by file offset
Date:   Thu, 23 Dec 2021 20:30:00 +0800
Message-Id: <20211223123011.41044-6-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Similar to hva_tree for hva range, maintain interval tree ofs_tree for
offset range of a fd-based memslot so the lookup by offset range can be
faster when memslot count is high.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/linux/kvm_host.h |  2 ++
 virt/kvm/kvm_main.c      | 17 +++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 2cd35560c44b..3bd875f9669f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -451,6 +451,7 @@ static inline int kvm_vcpu_exiting_guest_mode(struct kvm_vcpu *vcpu)
 struct kvm_memory_slot {
 	struct hlist_node id_node[2];
 	struct interval_tree_node hva_node[2];
+	struct interval_tree_node ofs_node[2];
 	struct rb_node gfn_node[2];
 	gfn_t base_gfn;
 	unsigned long npages;
@@ -560,6 +561,7 @@ struct kvm_memslots {
 	u64 generation;
 	atomic_long_t last_used_slot;
 	struct rb_root_cached hva_tree;
+	struct rb_root_cached ofs_tree;
 	struct rb_root gfn_tree;
 	/*
 	 * The mapping table from slot id to memslot.
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b0f7e6eb00ff..47e96d1eb233 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1087,6 +1087,7 @@ static struct kvm *kvm_create_vm(unsigned long type)
 
 			atomic_long_set(&slots->last_used_slot, (unsigned long)NULL);
 			slots->hva_tree = RB_ROOT_CACHED;
+			slots->ofs_tree = RB_ROOT_CACHED;
 			slots->gfn_tree = RB_ROOT;
 			hash_init(slots->id_hash);
 			slots->node_idx = j;
@@ -1363,7 +1364,7 @@ static void kvm_replace_gfn_node(struct kvm_memslots *slots,
  * With NULL @old this simply adds @new.
  * With NULL @new this simply removes @old.
  *
- * If @new is non-NULL its hva_node[slots_idx] range has to be set
+ * If @new is non-NULL its hva/ofs_node[slots_idx] range has to be set
  * appropriately.
  */
 static void kvm_replace_memslot(struct kvm *kvm,
@@ -1377,6 +1378,7 @@ static void kvm_replace_memslot(struct kvm *kvm,
 	if (old) {
 		hash_del(&old->id_node[idx]);
 		interval_tree_remove(&old->hva_node[idx], &slots->hva_tree);
+		interval_tree_remove(&old->ofs_node[idx], &slots->ofs_tree);
 
 		if ((long)old == atomic_long_read(&slots->last_used_slot))
 			atomic_long_set(&slots->last_used_slot, (long)new);
@@ -1388,20 +1390,27 @@ static void kvm_replace_memslot(struct kvm *kvm,
 	}
 
 	/*
-	 * Initialize @new's hva range.  Do this even when replacing an @old
+	 * Initialize @new's hva/ofs range.  Do this even when replacing an @old
 	 * slot, kvm_copy_memslot() deliberately does not touch node data.
 	 */
 	new->hva_node[idx].start = new->userspace_addr;
 	new->hva_node[idx].last = new->userspace_addr +
 				  (new->npages << PAGE_SHIFT) - 1;
+	if (kvm_slot_is_private(new)) {
+		new->ofs_node[idx].start = new->ofs;
+		new->ofs_node[idx].last = new->ofs +
+					  (new->npages << PAGE_SHIFT) - 1;
+	}
 
 	/*
 	 * (Re)Add the new memslot.  There is no O(1) interval_tree_replace(),
-	 * hva_node needs to be swapped with remove+insert even though hva can't
-	 * change when replacing an existing slot.
+	 * hva_node/ofs_node needs to be swapped with remove+insert even though
+	 * hva/ofs can't change when replacing an existing slot.
 	 */
 	hash_add(slots->id_hash, &new->id_node[idx], new->id);
 	interval_tree_insert(&new->hva_node[idx], &slots->hva_tree);
+	if (kvm_slot_is_private(new))
+		interval_tree_insert(&new->ofs_node[idx], &slots->ofs_tree);
 
 	/*
 	 * If the memslot gfn is unchanged, rb_replace_node() can be used to
-- 
2.17.1

