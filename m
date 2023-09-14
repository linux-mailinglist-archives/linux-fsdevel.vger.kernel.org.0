Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA95D79F70F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 03:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbjINB7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 21:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbjINB6Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:58:25 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ED530D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:56:11 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58c8b2d6784so6312167b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694656570; x=1695261370; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hXg+c13z5FpxpMh0dTDS8MDb5ldwgANdA63niVsOR7o=;
        b=XOgQ+BIUQpyRBoHtPwDbpt+SW3P3ARosHcjB/Uf7RYA4VZHM+RzCwKxT2vYV27Z4Jo
         MQ9NhTtoICBZEYgD/4fubr4T30I2Lqdo/yFMs8lwnE176lr9A8qeJfhZtaU5iqbkbO5h
         Qi3sz0TXlrW2FWaXreLY7hCqo53IJEw2A9NP0kxN0CyJjnklz2HyQFwxYIx4oStn4g5Z
         NtUcu307kp88lC39Ay0K/vIUI0N5mx2U62HoLkzZmdN3s0N2QhvETyo/XicjCjtbC9Y1
         sWvToehki8bz9wUptri/uj7XVYcsbkNm+8Uvv/3gSHiARrUYIxz7TaMouYHH/T5MBHc1
         AH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694656570; x=1695261370;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXg+c13z5FpxpMh0dTDS8MDb5ldwgANdA63niVsOR7o=;
        b=sWYvZxq9Jqp/lxfA/JHdndo4EauglHp5iir0a/gFDbsyc4ZJ718XAL2DdyVCkiNbUD
         LPwAH4ov337YS1S9kYO6ejCy4tPVdPoGNpkef2XH5AoCU48imHxniVeo9CVTmAI0TtWA
         kEyi+wYvCN7Fm9KWQ0i0mCmbhJYQUvP4z0DFBI7JCR770qR58V/23/ChG3242MWqg5/Q
         nqf+8D9DeNmG4FYT1hCIN3j2C1SzhATCaEnPHz6+BgKYV3HnRYhTWx79s6kOyq4uGXc1
         6qjrnKRSzPDhP9wlye7xQDyScGdZUzRywYknCE6s8FekyYlaaYXklkDqL9ryKKZ/ygIc
         Ek2A==
X-Gm-Message-State: AOJu0YynaN+h1Re2rCKm8pOg57rZNmNg+salTSEzTu7HWUD76igVhcut
        ey/DznvMzxridDMw24TZlV0+RncF0lA=
X-Google-Smtp-Source: AGHT+IHPiLkfoLFlIeGbzzjp2cxBfgGGv6hvIzEJvebBRPzJegHp6YgbGy/UCdWVr8MsxooaabenVz16PQA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:72a:b0:59b:b8bf:5973 with SMTP id
 bt10-20020a05690c072a00b0059bb8bf5973mr115588ywb.0.1694656569799; Wed, 13 Sep
 2023 18:56:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Sep 2023 18:55:15 -0700
In-Reply-To: <20230914015531.1419405-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914015531.1419405-18-seanjc@google.com>
Subject: [RFC PATCH v12 17/33] KVM: x86: Disallow hugepages when memory
 attributes are mixed
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
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chao Peng <chao.p.peng@linux.intel.com>

Disallow creating hugepages with mixed memory attributes, e.g. shared
versus private, as mapping a hugepage in this case would allow the guest
to access memory with the wrong attributes, e.g. overlaying private memory
with a shared hugepage.

Tracking whether or not attributes are mixed via the existing
disallow_lpage field, but use the most significant bit in 'disallow_lpage'
to indicate a hugepage has mixed attributes instead using the normal
refcounting.  Whether or not attributes are mixed is binary; either they
are or they aren't.  Attempting to squeeze that info into the refcount is
unnecessarily complex as it would require knowing the previous state of
the mixed count when updating attributes.  Using a flag means KVM just
needs to ensure the current status is reflected in the memslots.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |   3 +
 arch/x86/kvm/mmu/mmu.c          | 152 +++++++++++++++++++++++++++++++-
 arch/x86/kvm/x86.c              |   4 +
 3 files changed, 157 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3a2b53483524..91a28ddf7cfd 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1838,6 +1838,9 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu);
 int kvm_mmu_init_vm(struct kvm *kvm);
 void kvm_mmu_uninit_vm(struct kvm *kvm);
 
+void kvm_mmu_init_memslot_memory_attributes(struct kvm *kvm,
+					    struct kvm_memory_slot *slot);
+
 void kvm_mmu_after_set_cpuid(struct kvm_vcpu *vcpu);
 void kvm_mmu_reset_context(struct kvm_vcpu *vcpu);
 void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 0f0231d2b74f..a079f36a8bf5 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -795,16 +795,26 @@ static struct kvm_lpage_info *lpage_info_slot(gfn_t gfn,
 	return &slot->arch.lpage_info[level - 2][idx];
 }
 
+/*
+ * The most significant bit in disallow_lpage tracks whether or not memory
+ * attributes are mixed, i.e. not identical for all gfns at the current level.
+ * The lower order bits are used to refcount other cases where a hugepage is
+ * disallowed, e.g. if KVM has shadow a page table at the gfn.
+ */
+#define KVM_LPAGE_MIXED_FLAG	BIT(31)
+
 static void update_gfn_disallow_lpage_count(const struct kvm_memory_slot *slot,
 					    gfn_t gfn, int count)
 {
 	struct kvm_lpage_info *linfo;
-	int i;
+	int old, i;
 
 	for (i = PG_LEVEL_2M; i <= KVM_MAX_HUGEPAGE_LEVEL; ++i) {
 		linfo = lpage_info_slot(gfn, slot, i);
+
+		old = linfo->disallow_lpage;
 		linfo->disallow_lpage += count;
-		WARN_ON_ONCE(linfo->disallow_lpage < 0);
+		WARN_ON_ONCE((old ^ linfo->disallow_lpage) & KVM_LPAGE_MIXED_FLAG);
 	}
 }
 
@@ -7172,3 +7182,141 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
 	if (kvm->arch.nx_huge_page_recovery_thread)
 		kthread_stop(kvm->arch.nx_huge_page_recovery_thread);
 }
+
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+static bool hugepage_test_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
+				int level)
+{
+	return lpage_info_slot(gfn, slot, level)->disallow_lpage & KVM_LPAGE_MIXED_FLAG;
+}
+
+static void hugepage_clear_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
+				 int level)
+{
+	lpage_info_slot(gfn, slot, level)->disallow_lpage &= ~KVM_LPAGE_MIXED_FLAG;
+}
+
+static void hugepage_set_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
+			       int level)
+{
+	lpage_info_slot(gfn, slot, level)->disallow_lpage |= KVM_LPAGE_MIXED_FLAG;
+}
+
+static bool hugepage_has_attrs(struct kvm *kvm, struct kvm_memory_slot *slot,
+			       gfn_t gfn, int level, unsigned long attrs)
+{
+	const unsigned long start = gfn;
+	const unsigned long end = start + KVM_PAGES_PER_HPAGE(level);
+
+	if (level == PG_LEVEL_2M)
+		return kvm_range_has_memory_attributes(kvm, start, end, attrs);
+
+	for (gfn = start; gfn < end; gfn += KVM_PAGES_PER_HPAGE(level - 1)) {
+		if (hugepage_test_mixed(slot, gfn, level - 1) ||
+		    attrs != kvm_get_memory_attributes(kvm, gfn))
+			return false;
+	}
+	return true;
+}
+
+bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
+					 struct kvm_gfn_range *range)
+{
+	unsigned long attrs = range->arg.attributes;
+	struct kvm_memory_slot *slot = range->slot;
+	int level;
+
+	lockdep_assert_held_write(&kvm->mmu_lock);
+	lockdep_assert_held(&kvm->slots_lock);
+
+	/*
+	 * KVM x86 currently only supports KVM_MEMORY_ATTRIBUTE_PRIVATE, skip
+	 * the slot if the slot will never consume the PRIVATE attribute.
+	 */
+	if (!kvm_slot_can_be_private(slot))
+		return false;
+
+	/*
+	 * The sequence matters here: upper levels consume the result of lower
+	 * level's scanning.
+	 */
+	for (level = PG_LEVEL_2M; level <= KVM_MAX_HUGEPAGE_LEVEL; level++) {
+		gfn_t nr_pages = KVM_PAGES_PER_HPAGE(level);
+		gfn_t gfn = gfn_round_for_level(range->start, level);
+
+		/* Process the head page if it straddles the range. */
+		if (gfn != range->start || gfn + nr_pages > range->end) {
+			/*
+			 * Skip mixed tracking if the aligned gfn isn't covered
+			 * by the memslot, KVM can't use a hugepage due to the
+			 * misaligned address regardless of memory attributes.
+			 */
+			if (gfn >= slot->base_gfn) {
+				if (hugepage_has_attrs(kvm, slot, gfn, level, attrs))
+					hugepage_clear_mixed(slot, gfn, level);
+				else
+					hugepage_set_mixed(slot, gfn, level);
+			}
+			gfn += nr_pages;
+		}
+
+		/*
+		 * Pages entirely covered by the range are guaranteed to have
+		 * only the attributes which were just set.
+		 */
+		for ( ; gfn + nr_pages <= range->end; gfn += nr_pages)
+			hugepage_clear_mixed(slot, gfn, level);
+
+		/*
+		 * Process the last tail page if it straddles the range and is
+		 * contained by the memslot.  Like the head page, KVM can't
+		 * create a hugepage if the slot size is misaligned.
+		 */
+		if (gfn < range->end &&
+		    (gfn + nr_pages) <= (slot->base_gfn + slot->npages)) {
+			if (hugepage_has_attrs(kvm, slot, gfn, level, attrs))
+				hugepage_clear_mixed(slot, gfn, level);
+			else
+				hugepage_set_mixed(slot, gfn, level);
+		}
+	}
+	return false;
+}
+
+void kvm_mmu_init_memslot_memory_attributes(struct kvm *kvm,
+					    struct kvm_memory_slot *slot)
+{
+	int level;
+
+	if (!kvm_slot_can_be_private(slot))
+		return;
+
+	for (level = PG_LEVEL_2M; level <= KVM_MAX_HUGEPAGE_LEVEL; level++) {
+		/*
+		 * Don't bother tracking mixed attributes for pages that can't
+		 * be huge due to alignment, i.e. process only pages that are
+		 * entirely contained by the memslot.
+		 */
+		gfn_t end = gfn_round_for_level(slot->base_gfn + slot->npages, level);
+		gfn_t start = gfn_round_for_level(slot->base_gfn, level);
+		gfn_t nr_pages = KVM_PAGES_PER_HPAGE(level);
+		gfn_t gfn;
+
+		if (start < slot->base_gfn)
+			start += nr_pages;
+
+		/*
+		 * Unlike setting attributes, every potential hugepage needs to
+		 * be manually checked as the attributes may already be mixed.
+		 */
+		for (gfn = start; gfn < end; gfn += nr_pages) {
+			unsigned long attrs = kvm_get_memory_attributes(kvm, gfn);
+
+			if (hugepage_has_attrs(kvm, slot, gfn, level, attrs))
+				hugepage_clear_mixed(slot, gfn, level);
+			else
+				hugepage_set_mixed(slot, gfn, level);
+		}
+	}
+}
+#endif
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8d21b7b09bb5..ac36a5b7b5a3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12598,6 +12598,10 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
 		}
 	}
 
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+	kvm_mmu_init_memslot_memory_attributes(kvm, slot);
+#endif
+
 	if (kvm_page_track_create_memslot(kvm, slot, npages))
 		goto out_free;
 
-- 
2.42.0.283.g2d96d420d3-goog

