Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760AC50F04F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 07:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244918AbiDZFm6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 01:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244574AbiDZFmw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 01:42:52 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1E432987
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 22:39:26 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id w24-20020a170902a71800b0015d00267d74so4089701plq.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 22:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=a9VzBJlMLigws4pRoWaDUwEnDDiqJQ0nJjM8cxStkWo=;
        b=p8mJqCwHacTbFhvYHu8ybGXK2P+PghFMqaxHHJuqdpta07t/m8JQTkdFg82eEvuWYd
         OdSYMSKPBvO7ptjR046sAX/bHvFVjhg/pzuwVzXmGfoIsID/2GXXQHWYzh25sp8Zhqzf
         htWeN1iMzxl7/9Pdv1zinxHd6q+dx76sncvVGGjZOTWwwfxxB2qSbB8gn6IY5+O3yc7/
         BeF9G0WjghrY1fZ5jCmiJkVNg5fp3DJ1BPeCzpmLCtKqzsEWqGLssoJmyaPfwKCC+CiD
         5TQ/VweVfCM1sVLfYaViWaZEyQtlCxE0YpkORn8opIIBD11EyDSBFcvRbtm+lxTTiRjt
         7Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a9VzBJlMLigws4pRoWaDUwEnDDiqJQ0nJjM8cxStkWo=;
        b=UNNIGekvms1OdjCE9cDLIpw0hBUqACrSkKkaZtk9n8o4xDW15lfp6PKtSA1CCTRymf
         uK55u2V8SamqNbrzTrfNqz5+oc0MP05NvWmOtEMGhdA9UetnCceKQy8CTNXrpch/XB6f
         xO858i3PX2m7t5SBQQ7QrCANZqSW8vyp5X23lkUE/EU4Sm1m35hqI4A1ylTz/Ch3uaCI
         zxrl1gB8Xl9sKlucQfo5aDeI1P7BtLCsgeRMeoiy1bDl3UUiYm9qu1SL1VFj+Cq731YQ
         OU8/78YmdtjTF8juAC3CdqkPC9RgKNXMJ4+To0oE41t+QKvxl40VaYferUbf1YTRfKKg
         ibWg==
X-Gm-Message-State: AOAM533F8OgUmp195FQHvfYiXAa0WukU1qBo/6zwGu8j9F988ntk+K96
        9YMimUsdcffbCx+9zgzKIr2yZkn489uCoQuh
X-Google-Smtp-Source: ABdhPJxYCaRW6ujjy+jD12c3CK0Xph6XJaTEbXPAfsnpbu06l91YAgqtjLNqwlREDx07xf+SlrnmNlHPGW+NrZOR
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:de12:0:b0:3ab:7c33:2894 with SMTP
 id f18-20020a63de12000000b003ab7c332894mr3565024pgg.187.1650951565540; Mon,
 25 Apr 2022 22:39:25 -0700 (PDT)
Date:   Tue, 26 Apr 2022 05:39:03 +0000
In-Reply-To: <20220426053904.3684293-1-yosryahmed@google.com>
Message-Id: <20220426053904.3684293-6-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220426053904.3684293-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 5/6] KVM: riscv/mmu: count KVM page table pages in
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

Count the pages used by KVM in riscv for page tables in pagetable stats.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/riscv/kvm/mmu.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index f80a34fbf102..fcfb75713750 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -152,6 +152,7 @@ static int stage2_set_pte(struct kvm *kvm, u32 level,
 			next_ptep = kvm_mmu_memory_cache_alloc(pcache);
 			if (!next_ptep)
 				return -ENOMEM;
+			kvm_account_pgtable_pages((void *)next_ptep, +1);
 			*ptep = pfn_pte(PFN_DOWN(__pa(next_ptep)),
 					__pgprot(_PAGE_TABLE));
 		} else {
@@ -229,6 +230,7 @@ static void stage2_op_pte(struct kvm *kvm, gpa_t addr,
 	pte_t *next_ptep;
 	u32 next_ptep_level;
 	unsigned long next_page_size, page_size;
+	struct page *p;
 
 	ret = stage2_level_to_page_size(ptep_level, &page_size);
 	if (ret)
@@ -252,8 +254,13 @@ static void stage2_op_pte(struct kvm *kvm, gpa_t addr,
 		for (i = 0; i < PTRS_PER_PTE; i++)
 			stage2_op_pte(kvm, addr + i * next_page_size,
 					&next_ptep[i], next_ptep_level, op);
-		if (op == STAGE2_OP_CLEAR)
-			put_page(virt_to_page(next_ptep));
+		if (op == STAGE2_OP_CLEAR) {
+			p = virt_to_page(next_ptep);
+			if (page_count(p) == 1)
+				kvm_account_pgtable_pages((void *)next_ptep,
+							  -1);
+			put_page(p);
+		}
 	} else {
 		if (op == STAGE2_OP_CLEAR)
 			set_pte(ptep, __pte(0));
@@ -700,25 +707,27 @@ int kvm_riscv_stage2_map(struct kvm_vcpu *vcpu,
 int kvm_riscv_stage2_alloc_pgd(struct kvm *kvm)
 {
 	struct page *pgd_page;
+	int order;
 
 	if (kvm->arch.pgd != NULL) {
 		kvm_err("kvm_arch already initialized?\n");
 		return -EINVAL;
 	}
 
-	pgd_page = alloc_pages(GFP_KERNEL | __GFP_ZERO,
-				get_order(stage2_pgd_size));
+	order = get_order(stage2_pgd_size);
+	pgd_page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
 	if (!pgd_page)
 		return -ENOMEM;
 	kvm->arch.pgd = page_to_virt(pgd_page);
 	kvm->arch.pgd_phys = page_to_phys(pgd_page);
-
+	kvm_account_pgtable_pages((void *)kvm->arch.pgd, +(1UL << order));
 	return 0;
 }
 
 void kvm_riscv_stage2_free_pgd(struct kvm *kvm)
 {
 	void *pgd = NULL;
+	int order;
 
 	spin_lock(&kvm->mmu_lock);
 	if (kvm->arch.pgd) {
@@ -729,8 +738,11 @@ void kvm_riscv_stage2_free_pgd(struct kvm *kvm)
 	}
 	spin_unlock(&kvm->mmu_lock);
 
-	if (pgd)
-		free_pages((unsigned long)pgd, get_order(stage2_pgd_size));
+	if (pgd) {
+		order = get_order(stage2_pgd_size);
+		kvm_account_pgtable_pages((void *)pgd, -(1UL << order));
+		free_pages((unsigned long)pgd, order);
+	}
 }
 
 void kvm_riscv_stage2_update_hgatp(struct kvm_vcpu *vcpu)
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

