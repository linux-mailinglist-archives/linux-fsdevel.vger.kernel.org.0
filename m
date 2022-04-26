Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA70C50F044
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 07:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244704AbiDZFmz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 01:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243553AbiDZFmv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 01:42:51 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FD1326FD
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 22:39:22 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id mm2-20020a17090b358200b001bf529127dfso650667pjb.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 22:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hEHBnHYwkzv2bOtPfk7H6AvzPnNcWPKpvOGkhdPVPjo=;
        b=DLc3lupOo8rx1wWbuV0lLgrWbKtbqj3WcXXLDzE4k2Y8czyusZqACX6ZnOE6B8ztaC
         am7MpQeXB4aItWkOAQ2oHlKhWHUdect3mQCIVLzhsaMmYiLv4m8FDjT5rGgSMVj6xFYe
         n/2zHp73ToEvYp7vTtGZ/ZOGc9fhJjKlDa7mNMowqbkak7jlAdBqGFu6TyUdSzX7j+tW
         1GvB7gFqlyLilqCV94FzR63CxUYfiYooVrXSE9xnDdRgW//UD6tV4gP3rptKWSzN29Uy
         sjZA6fTvWQAJfVcB244P9F1XJ1tGayKZbE7/uQxhcWiS26Y/VIBnPxv5p5L8sde0AXSC
         zWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hEHBnHYwkzv2bOtPfk7H6AvzPnNcWPKpvOGkhdPVPjo=;
        b=dd1i+GNwL/Y/ca6TzagiBDbunZILMKaZ0Ka4k4H18vMkEvMer4p577lrYbMcqCt9PH
         5UCMZCP8J3wD071xup3YEkJLHr1+mzHyPIRHGF7m42BmnuN/Mi8Yii9HxjdetSow0Rwe
         /xo7Aglq0af6qQjpnE5J7iAsTSi7Tyq2DJtwPTGdyiHnthEBwDQK+KXUlv4Z13oQkj4N
         uXQb/2t+XM3nYGpdMTI+mrnV6pnUu9Sex1sihX8XaWzJJXJNXCNnZEcaPniu2OwocotU
         KOqD8mdsCyn5XCNPI5C09pFhdfEZjO5E4Lfl0RtEg2kwT3/9sKjArjyC4mfvX9TLRcIQ
         FYxQ==
X-Gm-Message-State: AOAM530Xba1ZnCiPmA1vaMDS1Lb+mXB7Ship3xwVylIceGAD/wmXs4FJ
        GSmwmFK8P1agMRqVQs53TCBG/NAi7JK99w1a
X-Google-Smtp-Source: ABdhPJw1/Xuct4B2pJQt4L0Xw8CSz2dpJiVWmWgaHUUCpj09w2ZMYvrNGeSsqW4nHEy3AMUsWi84mvmV71p47dv/
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:1955:b0:505:7902:36d3 with
 SMTP id s21-20020a056a00195500b00505790236d3mr22411201pfk.77.1650951562123;
 Mon, 25 Apr 2022 22:39:22 -0700 (PDT)
Date:   Tue, 26 Apr 2022 05:39:01 +0000
In-Reply-To: <20220426053904.3684293-1-yosryahmed@google.com>
Message-Id: <20220426053904.3684293-4-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220426053904.3684293-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 3/6] KVM: x86/mmu: count KVM page table pages in pagetable stats
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Count the pages used by KVM in x86 for page tables in pagetable stats.

For legacy code, accounting pagetable stats is combined KVM's
existing for mmu pages in newly introduced kvm_[un]account_mmu_page()
helpers.

For tdp mmu, introduce new tdp_[un]account_mmu_page() helpers. That
combines accounting pagetable stats with the tdp_mmu_pages counter
accounting.

tdp_mmu_pages counter introduced in this series [1]. This patch was
rebased on top of the first two patches in that series.

[1]https://lore.kernel.org/lkml/20220401063636.2414200-1-mizhang@google.com/

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/x86/kvm/mmu/mmu.c     | 16 ++++++++++++++--
 arch/x86/kvm/mmu/tdp_mmu.c | 16 ++++++++++++++--
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 78d8e1d8fb99..e5b0e826445d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1679,6 +1679,18 @@ static inline void kvm_mod_used_mmu_pages(struct kvm *kvm, long nr)
 	percpu_counter_add(&kvm_total_used_mmu_pages, nr);
 }
 
+static void kvm_account_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
+{
+	kvm_mod_used_mmu_pages(kvm, +1);
+	kvm_account_pgtable_pages((void *)sp->spt, +1);
+}
+
+static void kvm_unaccount_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
+{
+	kvm_mod_used_mmu_pages(kvm, -1);
+	kvm_account_pgtable_pages((void *)sp->spt, -1);
+}
+
 static void kvm_mmu_free_page(struct kvm_mmu_page *sp)
 {
 	MMU_WARN_ON(!is_empty_shadow_page(sp->spt));
@@ -1734,7 +1746,7 @@ static struct kvm_mmu_page *kvm_mmu_alloc_page(struct kvm_vcpu *vcpu, int direct
 	 */
 	sp->mmu_valid_gen = vcpu->kvm->arch.mmu_valid_gen;
 	list_add(&sp->link, &vcpu->kvm->arch.active_mmu_pages);
-	kvm_mod_used_mmu_pages(vcpu->kvm, +1);
+	kvm_account_mmu_page(vcpu->kvm, sp);
 	return sp;
 }
 
@@ -2363,7 +2375,7 @@ static bool __kvm_mmu_prepare_zap_page(struct kvm *kvm,
 			list_add(&sp->link, invalid_list);
 		else
 			list_move(&sp->link, invalid_list);
-		kvm_mod_used_mmu_pages(kvm, -1);
+		kvm_unaccount_mmu_page(kvm, sp);
 	} else {
 		/*
 		 * Remove the active root from the active page list, the root
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 3456277ade18..6295c4da5dee 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -371,6 +371,18 @@ static void handle_changed_spte_dirty_log(struct kvm *kvm, int as_id, gfn_t gfn,
 	}
 }
 
+static void tdp_account_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
+{
+	atomic64_inc(&kvm->arch.tdp_mmu_pages);
+	kvm_account_pgtable_pages((void *)sp->spt, +1);
+}
+
+static void tdp_unaccount_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
+{
+	atomic64_dec(&kvm->arch.tdp_mmu_pages);
+	kvm_account_pgtable_pages((void *)sp->spt, -1);
+}
+
 /**
  * tdp_mmu_unlink_sp() - Remove a shadow page from the list of used pages
  *
@@ -383,7 +395,7 @@ static void handle_changed_spte_dirty_log(struct kvm *kvm, int as_id, gfn_t gfn,
 static void tdp_mmu_unlink_sp(struct kvm *kvm, struct kvm_mmu_page *sp,
 			      bool shared)
 {
-	atomic64_dec(&kvm->arch.tdp_mmu_pages);
+	tdp_unaccount_mmu_page(kvm, sp);
 
 	if (!sp->lpage_disallowed)
 		return;
@@ -1121,7 +1133,7 @@ static int tdp_mmu_link_sp(struct kvm *kvm, struct tdp_iter *iter,
 		tdp_mmu_set_spte(kvm, iter, spte);
 	}
 
-	atomic64_inc(&kvm->arch.tdp_mmu_pages);
+	tdp_account_mmu_page(kvm, sp);
 
 	return 0;
 }
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

