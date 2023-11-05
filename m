Return-Path: <linux-fsdevel+bounces-2002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B69D7E14CB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 17:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEAE61F21527
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 16:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC61718B0B;
	Sun,  5 Nov 2023 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHOzwMm9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8F416430
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 16:32:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B37110DD
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 08:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699201931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vgvG8Uc2KDlAAH0vLW3+pD/kofK0dVTCPlvNIQRLPVc=;
	b=IHOzwMm9puMPfyBRNW+HlYVQBx8WB03FRGdULCkwe3+foppSHUjaoRzAlXddE0XlJGZcer
	gl0r3wclzRAEzbhSQRC2EtpTEsFN4I3ZP2wAg+zaUkKC43VDd3mxatDHAKb7qIBBnob5yu
	3cB0vGKlpoaVtkaBgWmRx51fqviTwy4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-EQm-NHwkMKW0c92Xni0QgA-1; Sun,
 05 Nov 2023 11:32:08 -0500
X-MC-Unique: EQm-NHwkMKW0c92Xni0QgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5AA431C0519C;
	Sun,  5 Nov 2023 16:32:06 +0000 (UTC)
Received: from avogadro.redhat.com (unknown [10.39.192.93])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 911C12166B26;
	Sun,  5 Nov 2023 16:31:58 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Chao Peng <chao.p.peng@linux.intel.com>,
	Fuad Tabba <tabba@google.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Anish Moorthy <amoorthy@google.com>,
	David Matlack <dmatlack@google.com>,
	Yu Zhang <yu.c.zhang@linux.intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Vlastimil Babka <vbabka@suse.cz>,
	Vishal Annapurve <vannapurve@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Maciej Szmigiero <mail@maciej.szmigiero.name>,
	David Hildenbrand <david@redhat.com>,
	Quentin Perret <qperret@google.com>,
	Michael Roth <michael.roth@amd.com>,
	Wang <wei.w.wang@intel.com>,
	Liam Merwick <liam.merwick@oracle.com>,
	Isaku Yamahata <isaku.yamahata@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 10/34] KVM: Add a dedicated mmu_notifier flag for reclaiming freed memory
Date: Sun,  5 Nov 2023 17:30:13 +0100
Message-ID: <20231105163040.14904-11-pbonzini@redhat.com>
In-Reply-To: <20231105163040.14904-1-pbonzini@redhat.com>
References: <20231105163040.14904-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

From: Sean Christopherson <seanjc@google.com>

Handle AMD SEV's kvm_arch_guest_memory_reclaimed() hook by having
__kvm_handle_hva_range() return whether or not an overlapping memslot
was found, i.e. mmu_lock was acquired.  Using the .on_unlock() hook
works, but kvm_arch_guest_memory_reclaimed() needs to run after dropping
mmu_lock, which makes .on_lock() and .on_unlock() asymmetrical.

Use a small struct to return the tuple of the notifier-specific return,
plus whether or not overlap was found.  Because the iteration helpers are
__always_inlined, practically speaking, the struct will never actually be
returned from a function call (not to mention the size of the struct will
be two bytes in practice).

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
Message-Id: <20231027182217.3615211-11-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/kvm_main.c | 53 +++++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 756b94ecd511..e18a7f152c0b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -561,6 +561,19 @@ struct kvm_mmu_notifier_range {
 	bool may_block;
 };
 
+/*
+ * The inner-most helper returns a tuple containing the return value from the
+ * arch- and action-specific handler, plus a flag indicating whether or not at
+ * least one memslot was found, i.e. if the handler found guest memory.
+ *
+ * Note, most notifiers are averse to booleans, so even though KVM tracks the
+ * return from arch code as a bool, outer helpers will cast it to an int. :-(
+ */
+typedef struct kvm_mmu_notifier_return {
+	bool ret;
+	bool found_memslot;
+} kvm_mn_ret_t;
+
 /*
  * Use a dedicated stub instead of NULL to indicate that there is no callback
  * function/handler.  The compiler technically can't guarantee that a real
@@ -582,22 +595,25 @@ static const union kvm_mmu_notifier_arg KVM_MMU_NOTIFIER_NO_ARG;
 	     node;							     \
 	     node = interval_tree_iter_next(node, start, last))	     \
 
-static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
-						  const struct kvm_mmu_notifier_range *range)
+static __always_inline kvm_mn_ret_t __kvm_handle_hva_range(struct kvm *kvm,
+							   const struct kvm_mmu_notifier_range *range)
 {
-	bool ret = false, locked = false;
+	struct kvm_mmu_notifier_return r = {
+		.ret = false,
+		.found_memslot = false,
+	};
 	struct kvm_gfn_range gfn_range;
 	struct kvm_memory_slot *slot;
 	struct kvm_memslots *slots;
 	int i, idx;
 
 	if (WARN_ON_ONCE(range->end <= range->start))
-		return 0;
+		return r;
 
 	/* A null handler is allowed if and only if on_lock() is provided. */
 	if (WARN_ON_ONCE(IS_KVM_NULL_FN(range->on_lock) &&
 			 IS_KVM_NULL_FN(range->handler)))
-		return 0;
+		return r;
 
 	idx = srcu_read_lock(&kvm->srcu);
 
@@ -631,8 +647,8 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
 			gfn_range.end = hva_to_gfn_memslot(hva_end + PAGE_SIZE - 1, slot);
 			gfn_range.slot = slot;
 
-			if (!locked) {
-				locked = true;
+			if (!r.found_memslot) {
+				r.found_memslot = true;
 				KVM_MMU_LOCK(kvm);
 				if (!IS_KVM_NULL_FN(range->on_lock))
 					range->on_lock(kvm);
@@ -640,14 +656,14 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
 				if (IS_KVM_NULL_FN(range->handler))
 					break;
 			}
-			ret |= range->handler(kvm, &gfn_range);
+			r.ret |= range->handler(kvm, &gfn_range);
 		}
 	}
 
-	if (range->flush_on_ret && ret)
+	if (range->flush_on_ret && r.ret)
 		kvm_flush_remote_tlbs(kvm);
 
-	if (locked) {
+	if (r.found_memslot) {
 		KVM_MMU_UNLOCK(kvm);
 		if (!IS_KVM_NULL_FN(range->on_unlock))
 			range->on_unlock(kvm);
@@ -655,8 +671,7 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
 
 	srcu_read_unlock(&kvm->srcu, idx);
 
-	/* The notifiers are averse to booleans. :-( */
-	return (int)ret;
+	return r;
 }
 
 static __always_inline int kvm_handle_hva_range(struct mmu_notifier *mn,
@@ -677,7 +692,7 @@ static __always_inline int kvm_handle_hva_range(struct mmu_notifier *mn,
 		.may_block	= false,
 	};
 
-	return __kvm_handle_hva_range(kvm, &range);
+	return __kvm_handle_hva_range(kvm, &range).ret;
 }
 
 static __always_inline int kvm_handle_hva_range_no_flush(struct mmu_notifier *mn,
@@ -696,7 +711,7 @@ static __always_inline int kvm_handle_hva_range_no_flush(struct mmu_notifier *mn
 		.may_block	= false,
 	};
 
-	return __kvm_handle_hva_range(kvm, &range);
+	return __kvm_handle_hva_range(kvm, &range).ret;
 }
 
 static bool kvm_change_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
@@ -798,7 +813,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 		.end		= range->end,
 		.handler	= kvm_mmu_unmap_gfn_range,
 		.on_lock	= kvm_mmu_invalidate_begin,
-		.on_unlock	= kvm_arch_guest_memory_reclaimed,
+		.on_unlock	= (void *)kvm_null_fn,
 		.flush_on_ret	= true,
 		.may_block	= mmu_notifier_range_blockable(range),
 	};
@@ -830,7 +845,13 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 	gfn_to_pfn_cache_invalidate_start(kvm, range->start, range->end,
 					  hva_range.may_block);
 
-	__kvm_handle_hva_range(kvm, &hva_range);
+	/*
+	 * If one or more memslots were found and thus zapped, notify arch code
+	 * that guest memory has been reclaimed.  This needs to be done *after*
+	 * dropping mmu_lock, as x86's reclaim path is slooooow.
+	 */
+	if (__kvm_handle_hva_range(kvm, &hva_range).found_memslot)
+		kvm_arch_guest_memory_reclaimed(kvm);
 
 	return 0;
 }
-- 
2.39.1



