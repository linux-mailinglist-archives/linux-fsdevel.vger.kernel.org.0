Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371F450F059
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 07:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244665AbiDZFnK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 01:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244556AbiDZFmw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 01:42:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CD7326F9
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 22:39:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b12-20020a056902030c00b0061d720e274aso15006433ybs.20
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 22:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rkVIMEOGh9mkvJwwveKReDVW9pdj0MI38yR9aww0L8Y=;
        b=VaxZ9QDojjxQlUm2YdMrIs+Np0z42EAwX+5FwdFsGmfirABaWBLGu4+O/+OnZVMnB2
         yV65SCNvcLlifKvPOwLyoSN2raRpMJixf7XBJbvt2IgBnKAMgmy9EoI2V5qAYUNEpNBj
         0DkcosfssQhmfPgbfFCqPzbvAl505xwfkuwgUY1jUAmgROsb/sCH5Ta6e8jkGULAR2ow
         BeFv0T7Gmt1OSWvZTaVYZh1317pjpDLxCxlGz6k2PjNYyi23rjONu2KGEk+wljw4z3b7
         izkoeFykixRYthOusX49NBX8Jn+iVpAOay4WfgPdTSfqzbBgNYavCJX02+HflylcLe+b
         RI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rkVIMEOGh9mkvJwwveKReDVW9pdj0MI38yR9aww0L8Y=;
        b=jJ7VkEu87o3s+AhpbGWO+WViqbjEqevqbUTTMwswuXkVDhZ3IrHVwKpN9DxTfT5uMK
         Likj1aXuSuhBmr3d3GOhu87sl80Ct2mWtz0085ST4j7wY5jdzTgnn3rELo2xz/tRBIqn
         pTcej2SXmEiSfOy07lphiCMiF8s/rhX4lejNENiIQy6+UOKiKCEVlSx87yo9EHE0HIwY
         Y83dCv3svgR5F/XGvy80a1YnQKr2aGA4NBH2K6rO09maFGU9ljX17bhvE5qepZdUE5K+
         Mkst60KyOyZYZPXTubHMq4OAkNQStEGTNfIM4hI0W17zzfIHAWAnfOyIT2sn6MvKPzB6
         NBjg==
X-Gm-Message-State: AOAM532mqCdZY+596VGg5UD7yDZlx33h1YBDwN0aTQePpXGVMMnchPBp
        Zh13D0Jh6Zs2AKBWey2ZrRpy55tGcM1jhybJ
X-Google-Smtp-Source: ABdhPJxmQBQiztCDbvRqDZKtPeTInmWcTF3Beh6DXCAkOb/yzMJI4LJT6RtDgsJfCqVNqUFCNRVJFLpOB1qAQ38k
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a81:1c0a:0:b0:2f8:70d:ccb6 with SMTP id
 c10-20020a811c0a000000b002f8070dccb6mr4728213ywc.365.1650951563874; Mon, 25
 Apr 2022 22:39:23 -0700 (PDT)
Date:   Tue, 26 Apr 2022 05:39:02 +0000
In-Reply-To: <20220426053904.3684293-1-yosryahmed@google.com>
Message-Id: <20220426053904.3684293-5-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220426053904.3684293-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 4/6] KVM: arm64/mmu: count KVM page table pages in
 pagetable stats
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Count the pages used by KVM in arm64 for page tables in pagetable stats.

Account pages allocated for PTEs in pgtable init functions and
kvm_set_table_pte().

Since most page table pages are freed using put_page(), add a helper
function put_pte_page() that checks if this is the last ref for a pte
page before putting it, and unaccounts stats accordingly.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/arm64/kernel/image-vars.h |  3 ++
 arch/arm64/kvm/hyp/pgtable.c   | 50 +++++++++++++++++++++-------------
 2 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 241c86b67d01..25bf058714f6 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -143,6 +143,9 @@ KVM_NVHE_ALIAS(__hyp_rodata_end);
 /* pKVM static key */
 KVM_NVHE_ALIAS(kvm_protected_mode_initialized);
 
+/* Called by kvm_account_pgtable_pages() to update pagetable stats */
+KVM_NVHE_ALIAS(__mod_lruvec_page_state);
+
 #endif /* CONFIG_KVM */
 
 #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 2cb3867eb7c2..53e13c3313e9 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -152,6 +152,7 @@ static void kvm_set_table_pte(kvm_pte_t *ptep, kvm_pte_t *childp,
 
 	WARN_ON(kvm_pte_valid(old));
 	smp_store_release(ptep, pte);
+	kvm_account_pgtable_pages((void *)childp, +1);
 }
 
 static kvm_pte_t kvm_init_valid_leaf_pte(u64 pa, kvm_pte_t attr, u32 level)
@@ -326,6 +327,14 @@ int kvm_pgtable_get_leaf(struct kvm_pgtable *pgt, u64 addr,
 	return ret;
 }
 
+static void put_pte_page(kvm_pte_t *ptep, struct kvm_pgtable_mm_ops *mm_ops)
+{
+	/* If this is the last page ref, decrement pagetable stats first. */
+	if (!mm_ops->page_count || mm_ops->page_count(ptep) == 1)
+		kvm_account_pgtable_pages((void *)ptep, -1);
+	mm_ops->put_page(ptep);
+}
+
 struct hyp_map_data {
 	u64				phys;
 	kvm_pte_t			attr;
@@ -488,10 +497,10 @@ static int hyp_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 
 	dsb(ish);
 	isb();
-	mm_ops->put_page(ptep);
+	put_pte_page(ptep, mm_ops);
 
 	if (childp)
-		mm_ops->put_page(childp);
+		put_pte_page(childp, mm_ops);
 
 	return 0;
 }
@@ -522,6 +531,7 @@ int kvm_pgtable_hyp_init(struct kvm_pgtable *pgt, u32 va_bits,
 	pgt->pgd = (kvm_pte_t *)mm_ops->zalloc_page(NULL);
 	if (!pgt->pgd)
 		return -ENOMEM;
+	kvm_account_pgtable_pages((void *)pgt->pgd, +1);
 
 	pgt->ia_bits		= va_bits;
 	pgt->start_level	= KVM_PGTABLE_MAX_LEVELS - levels;
@@ -541,10 +551,10 @@ static int hyp_free_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	if (!kvm_pte_valid(pte))
 		return 0;
 
-	mm_ops->put_page(ptep);
+	put_pte_page(ptep, mm_ops);
 
 	if (kvm_pte_table(pte, level))
-		mm_ops->put_page(kvm_pte_follow(pte, mm_ops));
+		put_pte_page(kvm_pte_follow(pte, mm_ops), mm_ops);
 
 	return 0;
 }
@@ -558,7 +568,7 @@ void kvm_pgtable_hyp_destroy(struct kvm_pgtable *pgt)
 	};
 
 	WARN_ON(kvm_pgtable_walk(pgt, 0, BIT(pgt->ia_bits), &walker));
-	pgt->mm_ops->put_page(pgt->pgd);
+	put_pte_page(pgt->pgd, pgt->mm_ops);
 	pgt->pgd = NULL;
 }
 
@@ -694,7 +704,7 @@ static void stage2_put_pte(kvm_pte_t *ptep, struct kvm_s2_mmu *mmu, u64 addr,
 		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, mmu, addr, level);
 	}
 
-	mm_ops->put_page(ptep);
+	put_pte_page(ptep, mm_ops);
 }
 
 static bool stage2_pte_cacheable(struct kvm_pgtable *pgt, kvm_pte_t pte)
@@ -795,7 +805,7 @@ static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 
 	if (data->anchor) {
 		if (stage2_pte_is_counted(pte))
-			mm_ops->put_page(ptep);
+			put_pte_page(ptep, mm_ops);
 
 		return 0;
 	}
@@ -848,8 +858,8 @@ static int stage2_map_walk_table_post(u64 addr, u64 end, u32 level,
 		childp = kvm_pte_follow(*ptep, mm_ops);
 	}
 
-	mm_ops->put_page(childp);
-	mm_ops->put_page(ptep);
+	put_pte_page(childp, mm_ops);
+	put_pte_page(ptep, mm_ops);
 
 	return ret;
 }
@@ -962,7 +972,7 @@ static int stage2_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	if (!kvm_pte_valid(pte)) {
 		if (stage2_pte_is_counted(pte)) {
 			kvm_clear_pte(ptep);
-			mm_ops->put_page(ptep);
+			put_pte_page(ptep, mm_ops);
 		}
 		return 0;
 	}
@@ -988,7 +998,7 @@ static int stage2_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 					       kvm_granule_size(level));
 
 	if (childp)
-		mm_ops->put_page(childp);
+		put_pte_page(childp, mm_ops);
 
 	return 0;
 }
@@ -1177,16 +1187,17 @@ int __kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_s2_mmu *mmu,
 			      enum kvm_pgtable_stage2_flags flags,
 			      kvm_pgtable_force_pte_cb_t force_pte_cb)
 {
-	size_t pgd_sz;
+	u32 pgd_num;
 	u64 vtcr = mmu->arch->vtcr;
 	u32 ia_bits = VTCR_EL2_IPA(vtcr);
 	u32 sl0 = FIELD_GET(VTCR_EL2_SL0_MASK, vtcr);
 	u32 start_level = VTCR_EL2_TGRAN_SL0_BASE - sl0;
 
-	pgd_sz = kvm_pgd_pages(ia_bits, start_level) * PAGE_SIZE;
-	pgt->pgd = mm_ops->zalloc_pages_exact(pgd_sz);
+	pgd_num = kvm_pgd_pages(ia_bits, start_level);
+	pgt->pgd = mm_ops->zalloc_pages_exact(pgd_num * PAGE_SIZE);
 	if (!pgt->pgd)
 		return -ENOMEM;
+	kvm_account_pgtable_pages((void *)pgt->pgd, +pgd_num);
 
 	pgt->ia_bits		= ia_bits;
 	pgt->start_level	= start_level;
@@ -1210,17 +1221,17 @@ static int stage2_free_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	if (!stage2_pte_is_counted(pte))
 		return 0;
 
-	mm_ops->put_page(ptep);
+	put_pte_page(ptep, mm_ops);
 
 	if (kvm_pte_table(pte, level))
-		mm_ops->put_page(kvm_pte_follow(pte, mm_ops));
+		put_pte_page(kvm_pte_follow(pte, mm_ops), mm_ops);
 
 	return 0;
 }
 
 void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt)
 {
-	size_t pgd_sz;
+	u32 pgd_num;
 	struct kvm_pgtable_walker walker = {
 		.cb	= stage2_free_walker,
 		.flags	= KVM_PGTABLE_WALK_LEAF |
@@ -1229,7 +1240,8 @@ void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt)
 	};
 
 	WARN_ON(kvm_pgtable_walk(pgt, 0, BIT(pgt->ia_bits), &walker));
-	pgd_sz = kvm_pgd_pages(pgt->ia_bits, pgt->start_level) * PAGE_SIZE;
-	pgt->mm_ops->free_pages_exact(pgt->pgd, pgd_sz);
+	pgd_num = kvm_pgd_pages(pgt->ia_bits, pgt->start_level);
+	kvm_account_pgtable_pages((void *)pgt->pgd, -pgd_num);
+	pgt->mm_ops->free_pages_exact(pgt->pgd, pgd_num * PAGE_SIZE);
 	pgt->pgd = NULL;
 }
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

