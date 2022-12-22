Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5238653C11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 07:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbiLVGNz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 01:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLVGNx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 01:13:53 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D251A3AE
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 22:13:52 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3dddef6adb6so11488277b3.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 22:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8Le8KFegdWN7VOvwiSTZxOW/cPswDLVsipipyKMUN9w=;
        b=UQLFFeIhjIWZyOHbh766YF4zaDiPwecxKodmacSEW6SoeKvWLAANA2ORk1zDqAa79K
         Ok9LBmyTbEXE89i418xyguLDYYkncT2f1wwWoKV05PoWdQvwUndD2wK0uBTWZvEh9sd8
         hhlv/sEDoaPC+62NuD7RQrTeX4CLZK2HmOj8gMHuxv+xJ6QVeB1N44ASzA3X41gRYTRL
         rmuP/84EeO4O+fMrTDRuoAVtmIGeakbi3lgMAltJm6UG9D9g+DIaR+vDiu1sHOTzSWjA
         PNhnrcqO0uf2vF2QnfpLWbv+eDs+363X/LJXaw5sYSbeRwxqQkFX2V4ToaOqWsajBynx
         ncHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Le8KFegdWN7VOvwiSTZxOW/cPswDLVsipipyKMUN9w=;
        b=ktd7weQOFqwo9zoy2Z36LifAcBtGRzkG3IlrUnWHDKzRyNMA25plg5aEh1fE/LpjJ8
         n4L4AS7gLXU6C5YfLT+zKHytReIiYj1xYBqcKYghwUzhGApOMG7uV4A+EX9OZVhmpkQS
         hxjNx+D+iTg9tipUwAilMQYs524uQHDlf9i0KRTwQ0aZ/QyuzuYcDdvqqvMwjXKALxVZ
         moLEgVv39g7jITu4AsHMBvrpbv47VoDiWD5dkDmY4woeImX90WlwujLj/Zj2sbJ1rMwS
         z4flfDTCATjNdk3+mNGNsSU1mVtdtiME1+9M8sVP+gcLeFqQMrIoMtnOeXUvkHa8GyKP
         m0Yg==
X-Gm-Message-State: AFqh2kriKZBlMA2lnjJ3oElaL9sQxz1Yrvd447dk5uqhq/wtdqK40faC
        XhonAYkIbjLklqX9PAtojgu0Av/030bp
X-Google-Smtp-Source: AMrXdXvo10X0PFc2i3O8+Mk/Q8RYfTFg9phEaoUQQml0p7MG1zUyhZMLdGFJTtVyrfp5cgswcUNMDQJhNvUX
X-Received: from yuanchu.svl.corp.google.com ([2620:15c:2d4:203:bd6e:5c67:5831:adad])
 (user=yuanchu job=sendgmr) by 2002:a25:5144:0:b0:753:4db:6fcc with SMTP id
 f65-20020a255144000000b0075304db6fccmr471923ybb.1.1671689631358; Wed, 21 Dec
 2022 22:13:51 -0800 (PST)
Date:   Wed, 21 Dec 2022 22:13:40 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221222061341.381903-1-yuanchu@google.com>
Subject: [PATCH 1/2] mm: add vma_has_locality()
From:   Yuanchu Xie <yuanchu@google.com>
To:     Ivan Babrou <ivan@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yu Zhao <yuzhao@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Barrett <steven@liquorix.net>,
        Brian Geffon <bgeffon@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Xu <peterx@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Yuanchu Xie <yuanchu@google.com>
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

From: Yu Zhao <yuzhao@google.com>

Currently in vm_flags in vm_area_struct, both VM_SEQ_READ and
VM_RAND_READ indicate a lack of locality in accesses to the vma. Some
places that check for locality are missing one of them. We add
vma_has_locality to replace the existing locality checks for clarity.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 include/linux/mm_inline.h |  8 ++++++++
 mm/memory.c               |  7 +++----
 mm/rmap.c                 | 42 +++++++++++++++++----------------------
 mm/vmscan.c               |  5 ++++-
 4 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index e8ed225d8f7c..80c0f6901ead 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -578,4 +578,12 @@ pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
 #endif
 }
 
+static inline bool vma_has_locality(struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))
+		return false;
+
+	return true;
+}
+
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index 4000e9f017e0..a3f60e53f348 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1402,8 +1402,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 						force_flush = 1;
 					}
 				}
-				if (pte_young(ptent) &&
-				    likely(!(vma->vm_flags & VM_SEQ_READ)))
+				if (pte_young(ptent) && likely(vma_has_locality(vma)))
 					mark_page_accessed(page);
 			}
 			rss[mm_counter(page)]--;
@@ -5148,8 +5147,8 @@ static inline void mm_account_fault(struct pt_regs *regs,
 #ifdef CONFIG_LRU_GEN
 static void lru_gen_enter_fault(struct vm_area_struct *vma)
 {
-	/* the LRU algorithm doesn't apply to sequential or random reads */
-	current->in_lru_fault = !(vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ));
+	/* the LRU algorithm only applies to accesses with locality */
+	current->in_lru_fault = vma_has_locality(vma);
 }
 
 static void lru_gen_exit_fault(void)
diff --git a/mm/rmap.c b/mm/rmap.c
index 32e48b1c5847..a2e83fea6fed 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -823,25 +823,14 @@ static bool folio_referenced_one(struct folio *folio,
 		}
 
 		if (pvmw.pte) {
-			if (lru_gen_enabled() && pte_young(*pvmw.pte) &&
-			    !(vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))) {
+			if (lru_gen_enabled() && pte_young(*pvmw.pte)) {
 				lru_gen_look_around(&pvmw);
 				referenced++;
 			}
 
 			if (ptep_clear_flush_young_notify(vma, address,
-						pvmw.pte)) {
-				/*
-				 * Don't treat a reference through
-				 * a sequentially read mapping as such.
-				 * If the folio has been used in another mapping,
-				 * we will catch it; if this other mapping is
-				 * already gone, the unmap path will have set
-				 * the referenced flag or activated the folio.
-				 */
-				if (likely(!(vma->vm_flags & VM_SEQ_READ)))
-					referenced++;
-			}
+						pvmw.pte))
+				referenced++;
 		} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
 			if (pmdp_clear_flush_young_notify(vma, address,
 						pvmw.pmd))
@@ -875,7 +864,20 @@ static bool invalid_folio_referenced_vma(struct vm_area_struct *vma, void *arg)
 	struct folio_referenced_arg *pra = arg;
 	struct mem_cgroup *memcg = pra->memcg;
 
-	if (!mm_match_cgroup(vma->vm_mm, memcg))
+	/*
+	 * Ignore references from this mapping if it has no locality. If the
+	 * folio has been used in another mapping, we will catch it; if this
+	 * other mapping is already gone, the unmap path will have set the
+	 * referenced flag or activated the folio in zap_pte_range().
+	 */
+	if (!vma_has_locality(vma))
+		return true;
+
+	/*
+	 * If we are reclaiming on behalf of a cgroup, skip counting on behalf
+	 * of references from different cgroups
+	 */
+	if (memcg && !mm_match_cgroup(vma->vm_mm, memcg))
 		return true;
 
 	return false;
@@ -906,6 +908,7 @@ int folio_referenced(struct folio *folio, int is_locked,
 		.arg = (void *)&pra,
 		.anon_lock = folio_lock_anon_vma_read,
 		.try_lock = true,
+		.invalid_vma = invalid_folio_referenced_vma,
 	};
 
 	*vm_flags = 0;
@@ -921,15 +924,6 @@ int folio_referenced(struct folio *folio, int is_locked,
 			return 1;
 	}
 
-	/*
-	 * If we are reclaiming on behalf of a cgroup, skip
-	 * counting on behalf of references from different
-	 * cgroups
-	 */
-	if (memcg) {
-		rwc.invalid_vma = invalid_folio_referenced_vma;
-	}
-
 	rmap_walk(folio, &rwc);
 	*vm_flags = pra.vm_flags;
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index e83d2a74e942..5cf39f314876 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3782,7 +3782,10 @@ static int should_skip_vma(unsigned long start, unsigned long end, struct mm_wal
 	if (is_vm_hugetlb_page(vma))
 		return true;
 
-	if (vma->vm_flags & (VM_LOCKED | VM_SPECIAL | VM_SEQ_READ | VM_RAND_READ))
+	if (!vma_has_locality(vma))
+		return true;
+
+	if (vma->vm_flags & (VM_LOCKED | VM_SPECIAL))
 		return true;
 
 	if (vma == get_gate_vma(vma->vm_mm))
-- 
2.39.0.314.g84b9a713c41-goog

