Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B748659C8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 22:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbiL3VxN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 16:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbiL3VxD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 16:53:03 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B661CFE5
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Dec 2022 13:52:59 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-47ede4426e1so124363217b3.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Dec 2022 13:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8TFtch4afv11+liPGrcYUQIUPF8E0jytiv2ZtV4VP60=;
        b=asPESHfjUZVqU8QJN1ZRjtdLbyZ3asXwvb7J7xZeFOEkZdLReFK5zvD6iEweEPLRNO
         uMNcn1qJJP1VCQjdCQWbtIgvNNGCbyKbKLAKi5actBzYN3l6drHtqt2ovdoS2SOwaASF
         NdVzXqbMnDicqkUCQSYzivZA5q90Qqk77ytGWSmT0yBS/Of60q41AJzk4B1uRTM68dOZ
         YrElqL40Nhf8OrFL1PCZfvDG9Jd5EOj2KQnz9vcwJ1pmGwDSvlEQCjJsfN7Nsot/OKAJ
         3q3d2pFsTNsrAkhElMMca0lXrTpYZJCkp6JSjcheVNR3Sn91EDanrNymPKWy77Rd+67c
         wbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8TFtch4afv11+liPGrcYUQIUPF8E0jytiv2ZtV4VP60=;
        b=FbG+8dGtRAXMRhmaDTizRLHBnHMi87f/GALLCMbx2lanIg06HRA/4gJ3HtOe8wudxy
         dvnvq2PTcqxsxbKJdJu0sO0VOP76alvYlmnsr6KCowoCK+l1tqC7VuCTy/8p0Qn+u29J
         dePcUsL3/cI69Pc6NI6KjDPR67TBgXuEFdpMngK/6ErpQeQMu7DI8dCfzbSqXP/lF6hO
         cEpk6thTax+xpDmpZ4eaftrFGDBtBB/UNkWyBznxvHs7fyVayZYDrA3KftTTZmQBqyK9
         XEsVBc5G6p4wz2dDvil0NnZvTlK6n8BInVdr8yzLqeYavpxtIC52DqfEcyUZhnWo4Nsc
         fnVQ==
X-Gm-Message-State: AFqh2kqQM75Q180G6fmSgwFmLQk1tv2FrQ7lLdHtjog9DOIvSi99qDWi
        N/tieJF91Waj/BgRRAQmZRycg2m1XDo=
X-Google-Smtp-Source: AMrXdXtb9FEN+IrQw0fMFoCYU37iBqM6LqwOvQ0wWXeG+vFQ3r+4lVRzKnphHsXxu7vtPxqZ4AKu3MbENKY=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:81fe:2008:27c1:d0cb])
 (user=yuzhao job=sendgmr) by 2002:a05:690c:830:b0:483:a506:cb0e with SMTP id
 by16-20020a05690c083000b00483a506cb0emr2053093ywb.123.1672437179072; Fri, 30
 Dec 2022 13:52:59 -0800 (PST)
Date:   Fri, 30 Dec 2022 14:52:51 -0700
Message-Id: <20221230215252.2628425-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH mm-unstable v2 1/2] mm: add vma_has_recency()
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Righi <andrea.righi@canonical.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michael Larabel <michael@michaellarabel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@google.com,
        Yu Zhao <yuzhao@google.com>
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

This patch adds vma_has_recency() to indicate whether a VMA may
exhibit temporal locality that the LRU algorithm relies on.

This function returns false for VMAs marked by VM_SEQ_READ or
VM_RAND_READ. While the former flag indicates linear access, i.e., a
special case of spatial locality, both flags indicate a lack of
temporal locality, i.e., the reuse of an area within a relatively
small duration.

"Recency" is chosen over "locality" to avoid confusion between
temporal and spatial localities.

Before this patch, the active/inactive LRU only ignored the accessed
bit from VMAs marked by VM_SEQ_READ. After this patch, the
active/inactive LRU and MGLRU share the same logic: they both ignore
the accessed bit if vma_has_recency() returns false.

For the active/inactive LRU, the following fio test showed a [6, 8]%
increase in IOPS when randomly accessing mapped files under memory
pressure.

  kb=$(awk '/MemTotal/ { print $2 }' /proc/meminfo)
  kb=$((kb - 8*1024*1024))

  modprobe brd rd_nr=1 rd_size=$kb
  dd if=/dev/zero of=/dev/ram0 bs=1M

  mkfs.ext4 /dev/ram0
  mount /dev/ram0 /mnt/
  swapoff -a

  fio --name=test --directory=/mnt/ --ioengine=mmap --numjobs=8 \
      --size=8G --rw=randrw --time_based --runtime=10m \
      --group_reporting

The discussion that led to this patch is here [1]. Additional test
results are available in that thread.

[1] https://lore.kernel.org/r/Y31s%2FK8T85jh05wH@google.com/

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mm_inline.h |  8 ++++++++
 mm/memory.c               |  7 +++----
 mm/rmap.c                 | 42 +++++++++++++++++----------------------
 mm/vmscan.c               |  5 ++++-
 4 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index d1c1f211a86f..fe5b8449e14a 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -595,4 +595,12 @@ pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
 #endif
 }
 
+static inline bool vma_has_recency(struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))
+		return false;
+
+	return true;
+}
+
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index 4000e9f017e0..ee72badad847 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1402,8 +1402,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 						force_flush = 1;
 					}
 				}
-				if (pte_young(ptent) &&
-				    likely(!(vma->vm_flags & VM_SEQ_READ)))
+				if (pte_young(ptent) && likely(vma_has_recency(vma)))
 					mark_page_accessed(page);
 			}
 			rss[mm_counter(page)]--;
@@ -5148,8 +5147,8 @@ static inline void mm_account_fault(struct pt_regs *regs,
 #ifdef CONFIG_LRU_GEN
 static void lru_gen_enter_fault(struct vm_area_struct *vma)
 {
-	/* the LRU algorithm doesn't apply to sequential or random reads */
-	current->in_lru_fault = !(vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ));
+	/* the LRU algorithm only applies to accesses with recency */
+	current->in_lru_fault = vma_has_recency(vma);
 }
 
 static void lru_gen_exit_fault(void)
diff --git a/mm/rmap.c b/mm/rmap.c
index 8a24b90d9531..9abffdd63a6a 100644
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
+	 * Ignore references from this mapping if it has no recency. If the
+	 * folio has been used in another mapping, we will catch it; if this
+	 * other mapping is already gone, the unmap path will have set the
+	 * referenced flag or activated the folio in zap_pte_range().
+	 */
+	if (!vma_has_recency(vma))
+		return true;
+
+	/*
+	 * If we are reclaiming on behalf of a cgroup, skip counting on behalf
+	 * of references from different cgroups.
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
index 6929402db149..cdf96aec39dc 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3794,7 +3794,10 @@ static int should_skip_vma(unsigned long start, unsigned long end, struct mm_wal
 	if (is_vm_hugetlb_page(vma))
 		return true;
 
-	if (vma->vm_flags & (VM_LOCKED | VM_SPECIAL | VM_SEQ_READ | VM_RAND_READ))
+	if (!vma_has_recency(vma))
+		return true;
+
+	if (vma->vm_flags & (VM_LOCKED | VM_SPECIAL))
 		return true;
 
 	if (vma == get_gate_vma(vma->vm_mm))
-- 
2.39.0.314.g84b9a713c41-goog

