Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFDD50F050
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 07:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244983AbiDZFnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 01:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244600AbiDZFmx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 01:42:53 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF094329A2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 22:39:27 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o7-20020a17090a0a0700b001d93c491131so890239pjo.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 22:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UwrHlKcfzo3tcKJryiZhc3lnWD2SSBQRLRI0NxtXWrY=;
        b=lNtBON0+mp7QtqbJUF/yxX4uqPIpQ5Y7hbeXAfVLxM4ZET7uCEK3knJCpkoyZMJa9s
         i7nzVR4VlmZxg+avleS7/Kn/bJZBjnZBXIxlYf/uArgxa5lJaYe/WDTMeZAb28KsbwWU
         ocTkXwvTjA1uESTwFj+I7wr5Rl5sM2mE2cN5TIARIpTfKY2dD2+gpHj1coFpygAy+fc7
         zaCTEQdiWA+0CcKFMaPUEAafXSOqS1yBx10IaODNf6+xQNBSZhNIV/u+JCOUySMFWRfr
         Ms9jv8dEpQuxx8npEiVjqTZIl7JhMtAENDSGpOK7TpWZOGwxxlN4+Ot896M99UFlnkfM
         gIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UwrHlKcfzo3tcKJryiZhc3lnWD2SSBQRLRI0NxtXWrY=;
        b=bYaeZhpyWDNUkXbNGUVYsKX2UVJRKqTZXlykU1PS/c4pa4VgYgzq/6c4EejBBnIK4O
         bi/h3zPuVUJss4SWcJY0DpD1y9ZciCD9UvkTR3uYjpz6NabfcpU3Tv0VogxkxSqmxr3p
         WLXp5hABpf78qetY6WnWBDx5DzRCOBRnHTBfcOzOt+buAY0z8DNnpP80M4LQSmua9L/i
         2vR9zRjtEOcEaGeu1XZ8+IoJ+wJP+drUr+6+0jHXNQU6gq6Fqa2G0d4JYggIhi586208
         J+hzn3LQKIQnTM9FkafJ3bQggXBRCOGuAeH3U8ik+rvapAXzL9md/zsAzrmuQeR71vX4
         mRdw==
X-Gm-Message-State: AOAM533IMLOR/vFYKPqIryohT3FWXJF2X6Q6R2MeyV1X2NkuilIyF7cv
        D/eN9+XvEpb1p5lU8ogTSkioUJxvumle9ufx
X-Google-Smtp-Source: ABdhPJx5ME5q1MQ2ad+XyRFl1/rgChFdKOrjKjC1cyKbrSm7xzgtrgQj+f7lrmteCRcN2yNApoWsTRuKdbMVeiBw
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:1acd:b0:50c:f6ca:6e6f with
 SMTP id f13-20020a056a001acd00b0050cf6ca6e6fmr18897423pfv.75.1650951567275;
 Mon, 25 Apr 2022 22:39:27 -0700 (PDT)
Date:   Tue, 26 Apr 2022 05:39:04 +0000
In-Reply-To: <20220426053904.3684293-1-yosryahmed@google.com>
Message-Id: <20220426053904.3684293-7-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220426053904.3684293-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 6/6] KVM: mips/mmu: count KVM page table pages in pagetable stats
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

Count the pages used by KVM in mips for page tables in pagetable stats.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/mips/kvm/mips.c | 1 +
 arch/mips/kvm/mmu.c  | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index a25e0b73ee70..e60c1920a408 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -175,6 +175,7 @@ static void kvm_mips_free_gpa_pt(struct kvm *kvm)
 {
 	/* It should always be safe to remove after flushing the whole range */
 	WARN_ON(!kvm_mips_flush_gpa_pt(kvm, 0, ~0));
+	kvm_account_pgtable_pages((void *)kvm->arch.gpa_mm.pgd, -1);
 	pgd_free(NULL, kvm->arch.gpa_mm.pgd);
 }
 
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 1bfd1b501d82..18da2ac2ded7 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -81,8 +81,10 @@ pgd_t *kvm_pgd_alloc(void)
 	pgd_t *ret;
 
 	ret = (pgd_t *)__get_free_pages(GFP_KERNEL, PGD_ORDER);
-	if (ret)
+	if (ret) {
 		kvm_pgd_init(ret);
+		kvm_account_pgtable_pages((void *)ret, +1);
+	}
 
 	return ret;
 }
@@ -125,6 +127,7 @@ static pte_t *kvm_mips_walk_pgd(pgd_t *pgd, struct kvm_mmu_memory_cache *cache,
 		pmd_init((unsigned long)new_pmd,
 			 (unsigned long)invalid_pte_table);
 		pud_populate(NULL, pud, new_pmd);
+		kvm_account_pgtable_pages((void *)new_pmd, +1);
 	}
 	pmd = pmd_offset(pud, addr);
 	if (pmd_none(*pmd)) {
@@ -135,6 +138,7 @@ static pte_t *kvm_mips_walk_pgd(pgd_t *pgd, struct kvm_mmu_memory_cache *cache,
 		new_pte = kvm_mmu_memory_cache_alloc(cache);
 		clear_page(new_pte);
 		pmd_populate_kernel(NULL, pmd, new_pte);
+		kvm_account_pgtable_pages((void *)new_pte, +1);
 	}
 	return pte_offset_kernel(pmd, addr);
 }
@@ -189,6 +193,7 @@ static bool kvm_mips_flush_gpa_pmd(pmd_t *pmd, unsigned long start_gpa,
 
 		if (kvm_mips_flush_gpa_pte(pte, start_gpa, end)) {
 			pmd_clear(pmd + i);
+			kvm_account_pgtable_pages((void *)pte, -1);
 			pte_free_kernel(NULL, pte);
 		} else {
 			safe_to_remove = false;
@@ -217,6 +222,7 @@ static bool kvm_mips_flush_gpa_pud(pud_t *pud, unsigned long start_gpa,
 
 		if (kvm_mips_flush_gpa_pmd(pmd, start_gpa, end)) {
 			pud_clear(pud + i);
+			kvm_account_pgtable_pages((void *)pmd, -1);
 			pmd_free(NULL, pmd);
 		} else {
 			safe_to_remove = false;
@@ -247,6 +253,7 @@ static bool kvm_mips_flush_gpa_pgd(pgd_t *pgd, unsigned long start_gpa,
 
 		if (kvm_mips_flush_gpa_pud(pud, start_gpa, end)) {
 			pgd_clear(pgd + i);
+			kvm_account_pgtable_pages((void *)pud, -1);
 			pud_free(NULL, pud);
 		} else {
 			safe_to_remove = false;
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

