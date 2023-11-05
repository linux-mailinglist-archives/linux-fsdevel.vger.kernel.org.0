Return-Path: <linux-fsdevel+bounces-1995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FB07E149C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 17:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FF6281388
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 16:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF202168BB;
	Sun,  5 Nov 2023 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNqvOs5H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5C8168B2
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 16:31:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF18FA
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 08:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699201877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcbVlPGoVN1tieqQFDiHA7p56vgclhhC5xHYSATntqA=;
	b=GNqvOs5HWz52Qlmbwk+vXCZvmVqrookDk0EWCQOdAXq/YzPX1zDeRuvmKQ7uY909mdnbGr
	+PE1IRPUjwkrQhT+uy2OtZniE4yDTbfyja8A+J5N3PpVyKL54z5HvbVhdGGTKm2XZICXnZ
	zK5HVvB+zIm3s04m4+lppSby4vjiYNY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-P9hDXXa4MYiP3I9YMdK2Gg-1; Sun, 05 Nov 2023 11:31:14 -0500
X-MC-Unique: P9hDXXa4MYiP3I9YMdK2Gg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21A6680B63E;
	Sun,  5 Nov 2023 16:31:12 +0000 (UTC)
Received: from avogadro.redhat.com (unknown [10.39.192.93])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F217A2166B26;
	Sun,  5 Nov 2023 16:31:04 +0000 (UTC)
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
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH 03/34] KVM: Use gfn instead of hva for mmu_notifier_retry
Date: Sun,  5 Nov 2023 17:30:06 +0100
Message-ID: <20231105163040.14904-4-pbonzini@redhat.com>
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

From: Chao Peng <chao.p.peng@linux.intel.com>

Currently in mmu_notifier invalidate path, hva range is recorded and then
checked against by mmu_invalidate_retry_hva() in the page fault handling
path. However, for the soon-to-be-introduced private memory, a page fault
may not have a hva associated, checking gfn(gpa) makes more sense.

For existing hva based shared memory, gfn is expected to also work. The
only downside is when aliasing multiple gfns to a single hva, the
current algorithm of checking multiple ranges could result in a much
larger range being rejected. Such aliasing should be uncommon, so the
impact is expected small.

Suggested-by: Sean Christopherson <seanjc@google.com>
Cc: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
[sean: convert vmx_set_apic_access_page_addr() to gfn-based API]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
Message-Id: <20231027182217.3615211-4-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c   | 10 ++++++----
 arch/x86/kvm/vmx/vmx.c   | 11 +++++-----
 include/linux/kvm_host.h | 33 +++++++++++++++++++-----------
 virt/kvm/kvm_main.c      | 43 +++++++++++++++++++++++++++++++---------
 4 files changed, 66 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b0f01d605617..b2d916f786ca 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3056,7 +3056,7 @@ static void direct_pte_prefetch(struct kvm_vcpu *vcpu, u64 *sptep)
  *
  * There are several ways to safely use this helper:
  *
- * - Check mmu_invalidate_retry_hva() after grabbing the mapping level, before
+ * - Check mmu_invalidate_retry_gfn() after grabbing the mapping level, before
  *   consuming it.  In this case, mmu_lock doesn't need to be held during the
  *   lookup, but it does need to be held while checking the MMU notifier.
  *
@@ -4366,7 +4366,7 @@ static bool is_page_fault_stale(struct kvm_vcpu *vcpu,
 		return true;
 
 	return fault->slot &&
-	       mmu_invalidate_retry_hva(vcpu->kvm, fault->mmu_seq, fault->hva);
+	       mmu_invalidate_retry_gfn(vcpu->kvm, fault->mmu_seq, fault->gfn);
 }
 
 static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
@@ -6260,7 +6260,9 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 
 	write_lock(&kvm->mmu_lock);
 
-	kvm_mmu_invalidate_begin(kvm, 0, -1ul);
+	kvm_mmu_invalidate_begin(kvm);
+
+	kvm_mmu_invalidate_range_add(kvm, gfn_start, gfn_end);
 
 	flush = kvm_rmap_zap_gfn_range(kvm, gfn_start, gfn_end);
 
@@ -6270,7 +6272,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 	if (flush)
 		kvm_flush_remote_tlbs_range(kvm, gfn_start, gfn_end - gfn_start);
 
-	kvm_mmu_invalidate_end(kvm, 0, -1ul);
+	kvm_mmu_invalidate_end(kvm);
 
 	write_unlock(&kvm->mmu_lock);
 }
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index be20a60047b1..40e3780d73ae 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6757,10 +6757,10 @@ static void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
 		return;
 
 	/*
-	 * Grab the memslot so that the hva lookup for the mmu_notifier retry
-	 * is guaranteed to use the same memslot as the pfn lookup, i.e. rely
-	 * on the pfn lookup's validation of the memslot to ensure a valid hva
-	 * is used for the retry check.
+	 * Explicitly grab the memslot using KVM's internal slot ID to ensure
+	 * KVM doesn't unintentionally grab a userspace memslot.  It _should_
+	 * be impossible for userspace to create a memslot for the APIC when
+	 * APICv is enabled, but paranoia won't hurt in this case.
 	 */
 	slot = id_to_memslot(slots, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT);
 	if (!slot || slot->flags & KVM_MEMSLOT_INVALID)
@@ -6785,8 +6785,7 @@ static void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
 		return;
 
 	read_lock(&vcpu->kvm->mmu_lock);
-	if (mmu_invalidate_retry_hva(kvm, mmu_seq,
-				     gfn_to_hva_memslot(slot, gfn))) {
+	if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn)) {
 		kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
 		read_unlock(&vcpu->kvm->mmu_lock);
 		goto out;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index fb6c6109fdca..11d091688346 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -787,8 +787,8 @@ struct kvm {
 	struct mmu_notifier mmu_notifier;
 	unsigned long mmu_invalidate_seq;
 	long mmu_invalidate_in_progress;
-	unsigned long mmu_invalidate_range_start;
-	unsigned long mmu_invalidate_range_end;
+	gfn_t mmu_invalidate_range_start;
+	gfn_t mmu_invalidate_range_end;
 #endif
 	struct list_head devices;
 	u64 manual_dirty_log_protect;
@@ -1392,10 +1392,9 @@ void kvm_mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc);
 void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
 #endif
 
-void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
-			      unsigned long end);
-void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,
-			    unsigned long end);
+void kvm_mmu_invalidate_begin(struct kvm *kvm);
+void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t end);
+void kvm_mmu_invalidate_end(struct kvm *kvm);
 
 long kvm_arch_dev_ioctl(struct file *filp,
 			unsigned int ioctl, unsigned long arg);
@@ -1970,9 +1969,9 @@ static inline int mmu_invalidate_retry(struct kvm *kvm, unsigned long mmu_seq)
 	return 0;
 }
 
-static inline int mmu_invalidate_retry_hva(struct kvm *kvm,
+static inline int mmu_invalidate_retry_gfn(struct kvm *kvm,
 					   unsigned long mmu_seq,
-					   unsigned long hva)
+					   gfn_t gfn)
 {
 	lockdep_assert_held(&kvm->mmu_lock);
 	/*
@@ -1981,10 +1980,20 @@ static inline int mmu_invalidate_retry_hva(struct kvm *kvm,
 	 * that might be being invalidated. Note that it may include some false
 	 * positives, due to shortcuts when handing concurrent invalidations.
 	 */
-	if (unlikely(kvm->mmu_invalidate_in_progress) &&
-	    hva >= kvm->mmu_invalidate_range_start &&
-	    hva < kvm->mmu_invalidate_range_end)
-		return 1;
+	if (unlikely(kvm->mmu_invalidate_in_progress)) {
+		/*
+		 * Dropping mmu_lock after bumping mmu_invalidate_in_progress
+		 * but before updating the range is a KVM bug.
+		 */
+		if (WARN_ON_ONCE(kvm->mmu_invalidate_range_start == INVALID_GPA ||
+				 kvm->mmu_invalidate_range_end == INVALID_GPA))
+			return 1;
+
+		if (gfn >= kvm->mmu_invalidate_range_start &&
+		    gfn < kvm->mmu_invalidate_range_end)
+			return 1;
+	}
+
 	if (kvm->mmu_invalidate_seq != mmu_seq)
 		return 1;
 	return 0;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5a97e6c7d9c2..9cc57b23ec81 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -543,9 +543,7 @@ static inline struct kvm *mmu_notifier_to_kvm(struct mmu_notifier *mn)
 
 typedef bool (*gfn_handler_t)(struct kvm *kvm, struct kvm_gfn_range *range);
 
-typedef void (*on_lock_fn_t)(struct kvm *kvm, unsigned long start,
-			     unsigned long end);
-
+typedef void (*on_lock_fn_t)(struct kvm *kvm);
 typedef void (*on_unlock_fn_t)(struct kvm *kvm);
 
 struct kvm_mmu_notifier_range {
@@ -637,7 +635,8 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
 				locked = true;
 				KVM_MMU_LOCK(kvm);
 				if (!IS_KVM_NULL_FN(range->on_lock))
-					range->on_lock(kvm, range->start, range->end);
+					range->on_lock(kvm);
+
 				if (IS_KVM_NULL_FN(range->handler))
 					break;
 			}
@@ -742,16 +741,29 @@ static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
 	kvm_handle_hva_range(mn, address, address + 1, arg, kvm_change_spte_gfn);
 }
 
-void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
-			      unsigned long end)
+void kvm_mmu_invalidate_begin(struct kvm *kvm)
 {
+	lockdep_assert_held_write(&kvm->mmu_lock);
 	/*
 	 * The count increase must become visible at unlock time as no
 	 * spte can be established without taking the mmu_lock and
 	 * count is also read inside the mmu_lock critical section.
 	 */
 	kvm->mmu_invalidate_in_progress++;
+
 	if (likely(kvm->mmu_invalidate_in_progress == 1)) {
+		kvm->mmu_invalidate_range_start = INVALID_GPA;
+		kvm->mmu_invalidate_range_end = INVALID_GPA;
+	}
+}
+
+void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t end)
+{
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
+	WARN_ON_ONCE(!kvm->mmu_invalidate_in_progress);
+
+	if (likely(kvm->mmu_invalidate_range_start == INVALID_GPA)) {
 		kvm->mmu_invalidate_range_start = start;
 		kvm->mmu_invalidate_range_end = end;
 	} else {
@@ -771,6 +783,12 @@ void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
 	}
 }
 
+static bool kvm_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	kvm_mmu_invalidate_range_add(kvm, range->start, range->end);
+	return kvm_unmap_gfn_range(kvm, range);
+}
+
 static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 					const struct mmu_notifier_range *range)
 {
@@ -778,7 +796,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 	const struct kvm_mmu_notifier_range hva_range = {
 		.start		= range->start,
 		.end		= range->end,
-		.handler	= kvm_unmap_gfn_range,
+		.handler	= kvm_mmu_unmap_gfn_range,
 		.on_lock	= kvm_mmu_invalidate_begin,
 		.on_unlock	= kvm_arch_guest_memory_reclaimed,
 		.flush_on_ret	= true,
@@ -817,9 +835,10 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 	return 0;
 }
 
-void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,
-			    unsigned long end)
+void kvm_mmu_invalidate_end(struct kvm *kvm)
 {
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
 	/*
 	 * This sequence increase will notify the kvm page fault that
 	 * the page that is going to be mapped in the spte could have
@@ -834,6 +853,12 @@ void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,
 	 */
 	kvm->mmu_invalidate_in_progress--;
 	KVM_BUG_ON(kvm->mmu_invalidate_in_progress < 0, kvm);
+
+	/*
+	 * Assert that at least one range was added between start() and end().
+	 * Not adding a range isn't fatal, but it is a KVM bug.
+	 */
+	WARN_ON_ONCE(kvm->mmu_invalidate_range_start == INVALID_GPA);
 }
 
 static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
-- 
2.39.1



