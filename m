Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602A7758976
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 01:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjGRXvi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 19:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjGRXvR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 19:51:17 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16FD2D40
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 16:49:31 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b8b30f781cso32251695ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 16:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689724142; x=1692316142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=neVr8HNAj5IZlomMCHXqP3DOL+mw9u7akoKbe+0W+rs=;
        b=iplLwDRhYiuDejVY+08ejh96XGxClqhf/in2ogT0fbgAloHb2a3YzbomXz7tWXoF8L
         Ffk8qzrdCtXAJDPhTVgkwQ027wWBLOBth01UwTc0bSYy6b47Y+5brK3/ycVczHgwamJF
         +VPSc7B7BrhlmcGsrMiT+/zGRYuzD1o+I/0ETsdNvYG4HBGsmU65+h30UEFYY9mQhgY/
         J9K5Gijw+RpECuVc2e7MMg9bUi07bdgESIAZZ0GwAnn4USQD/g5xo5NtlPHD8+VmV3Tn
         r0FCz6tXdLbVbB/QXvbLpf0oQy4Fwv9SNHugjkeZbyKs+flNZ6+npi1g2MpXZDrCWHu7
         luXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689724142; x=1692316142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=neVr8HNAj5IZlomMCHXqP3DOL+mw9u7akoKbe+0W+rs=;
        b=YVRmhDH1QpmxhiTRE0tuJySuXn+fYnYQLFONdNpXAxwRJE5iTAeh86tSBa7aBlh+7k
         qqkL2Zbm2nTaAdc+gSz2Vazv8ojQgeTZPx28C53PFa9zlQ397beWRR4SeZY3FyGyODVL
         KfkbiWxUzt3z1FLUwIgaN9Y+2LeBJm22jw/RWifsz6vJW9u1UJ7E9nb83PEr0nYQFP9I
         RHHcSiu2oxn2wmJXb1TKpQhBUqUyinW/IHZq/K5NG7sZvNoZwhomd+QZnYEhTzD+bsCk
         iJAj5A9mFarTBcb9ewxaFIOdSN8XdMLN4tZGUYeM0ZZIdET7/GLmp7YeAzhb8Nkn7YeD
         BF+g==
X-Gm-Message-State: ABy/qLadZBlv+teITQuGmYUnDxgzVHd1yx1DuIR9cuZW79/8efP8w//I
        3wu6JiYEscf+3Gxl3yMLQFwpVJx+F7w=
X-Google-Smtp-Source: APBJJlE3zaeAmxr8KyqMkhbPu2G6jl64rE93BW/Stx8IIOAZXeXONcird8rqTaf51JHndI+NustNvDl1deI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2349:b0:1b9:de12:475 with SMTP id
 c9-20020a170903234900b001b9de120475mr8795plh.6.1689724142365; Tue, 18 Jul
 2023 16:49:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 18 Jul 2023 16:44:59 -0700
In-Reply-To: <20230718234512.1690985-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230718234512.1690985-17-seanjc@google.com>
Subject: [RFC PATCH v11 16/29] KVM: Allow arch code to track number of memslot
 address spaces per VM
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sean Christopherson <seanjc@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/kvm/book3s_hv.c    |  2 +-
 arch/x86/include/asm/kvm_host.h |  8 +++++++-
 arch/x86/kvm/debugfs.c          |  2 +-
 arch/x86/kvm/mmu/mmu.c          |  8 ++++----
 arch/x86/kvm/mmu/tdp_mmu.c      |  2 +-
 arch/x86/kvm/x86.c              |  2 +-
 include/linux/kvm_host.h        | 17 +++++++++++------
 virt/kvm/dirty_ring.c           |  2 +-
 virt/kvm/kvm_main.c             | 24 ++++++++++++------------
 9 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 130bafdb1430..9b0eaa17275a 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6084,7 +6084,7 @@ static int kvmhv_svm_off(struct kvm *kvm)
 	}
 
 	srcu_idx = srcu_read_lock(&kvm->srcu);
-	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
+	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		struct kvm_memory_slot *memslot;
 		struct kvm_memslots *slots = __kvm_memslots(kvm, i);
 		int bkt;
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7a905e033932..08b44544a330 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2105,9 +2105,15 @@ enum {
 #define HF_SMM_MASK		(1 << 1)
 #define HF_SMM_INSIDE_NMI_MASK	(1 << 2)
 
-# define KVM_ADDRESS_SPACE_NUM 2
+# define KVM_MAX_NR_ADDRESS_SPACES	2
 # define kvm_arch_vcpu_memslots_id(vcpu) ((vcpu)->arch.hflags & HF_SMM_MASK ? 1 : 0)
 # define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, (role).smm)
+
+static inline int kvm_arch_nr_memslot_as_ids(struct kvm *kvm)
+{
+	return KVM_MAX_NR_ADDRESS_SPACES;
+}
+
 #else
 # define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, 0)
 #endif
diff --git a/arch/x86/kvm/debugfs.c b/arch/x86/kvm/debugfs.c
index ee8c4c3496ed..42026b3f3ff3 100644
--- a/arch/x86/kvm/debugfs.c
+++ b/arch/x86/kvm/debugfs.c
@@ -111,7 +111,7 @@ static int kvm_mmu_rmaps_stat_show(struct seq_file *m, void *v)
 	mutex_lock(&kvm->slots_lock);
 	write_lock(&kvm->mmu_lock);
 
-	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
+	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		int bkt;
 
 		slots = __kvm_memslots(kvm, i);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 4cf73a579ee1..05943ccb55a4 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3801,7 +3801,7 @@ static int mmu_first_shadow_root_alloc(struct kvm *kvm)
 	    kvm_page_track_write_tracking_enabled(kvm))
 		goto out_success;
 
-	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
+	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		slots = __kvm_memslots(kvm, i);
 		kvm_for_each_memslot(slot, bkt, slots) {
 			/*
@@ -6351,7 +6351,7 @@ static bool kvm_rmap_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_e
 	if (!kvm_memslots_have_rmaps(kvm))
 		return flush;
 
-	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
+	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		slots = __kvm_memslots(kvm, i);
 
 		kvm_for_each_memslot_in_gfn_range(&iter, slots, gfn_start, gfn_end) {
@@ -6391,7 +6391,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 	flush = kvm_rmap_zap_gfn_range(kvm, gfn_start, gfn_end);
 
 	if (tdp_mmu_enabled) {
-		for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++)
+		for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++)
 			flush = kvm_tdp_mmu_zap_leafs(kvm, i, gfn_start,
 						      gfn_end, true, flush);
 	}
@@ -6855,7 +6855,7 @@ void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen)
 	 * modifier prior to checking for a wrap of the MMIO generation so
 	 * that a wrap in any address space is detected.
 	 */
-	gen &= ~((u64)KVM_ADDRESS_SPACE_NUM - 1);
+	gen &= ~((u64)kvm_arch_nr_memslot_as_ids(kvm) - 1);
 
 	/*
 	 * The very rare case: if the MMIO generation number has wrapped,
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 6250bd3d20c1..70052f59cfdf 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -905,7 +905,7 @@ void kvm_tdp_mmu_zap_all(struct kvm *kvm)
 	 * is being destroyed or the userspace VMM has exited.  In both cases,
 	 * KVM_RUN is unreachable, i.e. no vCPUs will ever service the request.
 	 */
-	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
+	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		for_each_tdp_mmu_root_yield_safe(kvm, root, i)
 			tdp_mmu_zap_root(kvm, root, false);
 	}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index dd7cefe78815..463ecf70cec0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12419,7 +12419,7 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 		hva = slot->userspace_addr;
 	}
 
-	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
+	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		struct kvm_userspace_memory_region2 m;
 
 		m.slot = id | (i << 16);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5839ef44e145..091bc89ae805 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -80,8 +80,8 @@
 /* Two fragments for cross MMIO pages. */
 #define KVM_MAX_MMIO_FRAGMENTS	2
 
-#ifndef KVM_ADDRESS_SPACE_NUM
-#define KVM_ADDRESS_SPACE_NUM	1
+#ifndef KVM_MAX_NR_ADDRESS_SPACES
+#define KVM_MAX_NR_ADDRESS_SPACES	1
 #endif
 
 /*
@@ -693,7 +693,12 @@ bool kvm_arch_irqchip_in_kernel(struct kvm *kvm);
 #define KVM_MEM_SLOTS_NUM SHRT_MAX
 #define KVM_USER_MEM_SLOTS (KVM_MEM_SLOTS_NUM - KVM_INTERNAL_MEM_SLOTS)
 
-#if KVM_ADDRESS_SPACE_NUM == 1
+#if KVM_MAX_NR_ADDRESS_SPACES == 1
+static inline int kvm_arch_nr_memslot_as_ids(struct kvm *kvm)
+{
+	return KVM_MAX_NR_ADDRESS_SPACES;
+}
+
 static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
 {
 	return 0;
@@ -748,9 +753,9 @@ struct kvm {
 	struct mm_struct *mm; /* userspace tied to this vm */
 	unsigned long nr_memslot_pages;
 	/* The two memslot sets - active and inactive (per address space) */
-	struct kvm_memslots __memslots[KVM_ADDRESS_SPACE_NUM][2];
+	struct kvm_memslots __memslots[KVM_MAX_NR_ADDRESS_SPACES][2];
 	/* The current active memslot set for each address space */
-	struct kvm_memslots __rcu *memslots[KVM_ADDRESS_SPACE_NUM];
+	struct kvm_memslots __rcu *memslots[KVM_MAX_NR_ADDRESS_SPACES];
 	struct xarray vcpu_array;
 	/*
 	 * Protected by slots_lock, but can be read outside if an
@@ -1000,7 +1005,7 @@ void kvm_put_kvm_no_destroy(struct kvm *kvm);
 
 static inline struct kvm_memslots *__kvm_memslots(struct kvm *kvm, int as_id)
 {
-	as_id = array_index_nospec(as_id, KVM_ADDRESS_SPACE_NUM);
+	as_id = array_index_nospec(as_id, KVM_MAX_NR_ADDRESS_SPACES);
 	return srcu_dereference_check(kvm->memslots[as_id], &kvm->srcu,
 			lockdep_is_held(&kvm->slots_lock) ||
 			!refcount_read(&kvm->users_count));
diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
index c1cd7dfe4a90..86d267db87bb 100644
--- a/virt/kvm/dirty_ring.c
+++ b/virt/kvm/dirty_ring.c
@@ -58,7 +58,7 @@ static void kvm_reset_dirty_gfn(struct kvm *kvm, u32 slot, u64 offset, u64 mask)
 	as_id = slot >> 16;
 	id = (u16)slot;
 
-	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
+	if (as_id >= kvm_arch_nr_memslot_as_ids(kvm) || id >= KVM_USER_MEM_SLOTS)
 		return;
 
 	memslot = id_to_memslot(__kvm_memslots(kvm, as_id), id);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index a8686e8473a4..ee331cf8ba54 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -582,7 +582,7 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
 
 	idx = srcu_read_lock(&kvm->srcu);
 
-	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
+	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		struct interval_tree_node *node;
 
 		slots = __kvm_memslots(kvm, i);
@@ -1206,7 +1206,7 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 		goto out_err_no_irq_srcu;
 
 	refcount_set(&kvm->users_count, 1);
-	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
+	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		for (j = 0; j < 2; j++) {
 			slots = &kvm->__memslots[i][j];
 
@@ -1349,7 +1349,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
 #endif
 	kvm_arch_destroy_vm(kvm);
 	kvm_destroy_devices(kvm);
-	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
+	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
 		kvm_free_memslots(kvm, &kvm->__memslots[i][1]);
 	}
@@ -1632,7 +1632,7 @@ static void kvm_swap_active_memslots(struct kvm *kvm, int as_id)
 	 * space 0 will use generations 0, 2, 4, ... while address space 1 will
 	 * use generations 1, 3, 5, ...
 	 */
-	gen += KVM_ADDRESS_SPACE_NUM;
+	gen += kvm_arch_nr_memslot_as_ids(kvm);
 
 	kvm_arch_memslots_updated(kvm, gen);
 
@@ -2002,7 +2002,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	    (mem->gmem_offset & (PAGE_SIZE - 1) ||
 	     mem->gmem_offset + mem->memory_size < mem->gmem_offset))
 		return -EINVAL;
-	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_MEM_SLOTS_NUM)
+	if (as_id >= kvm_arch_nr_memslot_as_ids(kvm) || id >= KVM_MEM_SLOTS_NUM)
 		return -EINVAL;
 	if (mem->guest_phys_addr + mem->memory_size < mem->guest_phys_addr)
 		return -EINVAL;
@@ -2138,7 +2138,7 @@ int kvm_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log,
 
 	as_id = log->slot >> 16;
 	id = (u16)log->slot;
-	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
+	if (as_id >= kvm_arch_nr_memslot_as_ids(kvm) || id >= KVM_USER_MEM_SLOTS)
 		return -EINVAL;
 
 	slots = __kvm_memslots(kvm, as_id);
@@ -2200,7 +2200,7 @@ static int kvm_get_dirty_log_protect(struct kvm *kvm, struct kvm_dirty_log *log)
 
 	as_id = log->slot >> 16;
 	id = (u16)log->slot;
-	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
+	if (as_id >= kvm_arch_nr_memslot_as_ids(kvm) || id >= KVM_USER_MEM_SLOTS)
 		return -EINVAL;
 
 	slots = __kvm_memslots(kvm, as_id);
@@ -2312,7 +2312,7 @@ static int kvm_clear_dirty_log_protect(struct kvm *kvm,
 
 	as_id = log->slot >> 16;
 	id = (u16)log->slot;
-	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
+	if (as_id >= kvm_arch_nr_memslot_as_ids(kvm) || id >= KVM_USER_MEM_SLOTS)
 		return -EINVAL;
 
 	if (log->first_page & 63)
@@ -2406,7 +2406,7 @@ static __always_inline void kvm_handle_gfn_range(struct kvm *kvm,
 	gfn_range.arg.raw = range->arg.raw;
 	gfn_range.may_block = range->may_block;
 
-	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
+	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		slots = __kvm_memslots(kvm, i);
 
 		kvm_for_each_memslot_in_gfn_range(&iter, slots, range->start, range->end) {
@@ -4725,9 +4725,9 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 	case KVM_CAP_IRQ_ROUTING:
 		return KVM_MAX_IRQ_ROUTES;
 #endif
-#if KVM_ADDRESS_SPACE_NUM > 1
+#if KVM_MAX_NR_ADDRESS_SPACES > 1
 	case KVM_CAP_MULTI_ADDRESS_SPACE:
-		return KVM_ADDRESS_SPACE_NUM;
+		return KVM_MAX_NR_ADDRESS_SPACES;
 #endif
 	case KVM_CAP_NR_MEMSLOTS:
 		return KVM_USER_MEM_SLOTS;
@@ -4827,7 +4827,7 @@ bool kvm_are_all_memslots_empty(struct kvm *kvm)
 
 	lockdep_assert_held(&kvm->slots_lock);
 
-	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
+	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		if (!kvm_memslots_empty(__kvm_memslots(kvm, i)))
 			return false;
 	}
-- 
2.41.0.255.g8b1d071c50-goog

