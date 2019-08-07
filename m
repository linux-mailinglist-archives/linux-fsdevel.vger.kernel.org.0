Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8B74851E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2019 19:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388969AbfHGRQO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 13:16:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40139 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730234AbfHGRQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:16:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so41704727pla.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2019 10:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P5X7WGyKIvWzv40/K4oiDqLDCW/4zY9Hm3MOMY58jQs=;
        b=mD9C8IKc4XKpcbSYfwPnZKRldyQiL1dBx81QYoVmJDdux8Iep7i59/JSHFJYHk+XrJ
         vrMJi8Xp2bdjRbFDtFrhqEh5Yc3Oopi7lxX7lQLO8r3AEgEvgNhzwo8UcjWMEY04/AC8
         JYsHF/E+aVAAZwpyg1/P7F6EoLQTnU39+G9fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P5X7WGyKIvWzv40/K4oiDqLDCW/4zY9Hm3MOMY58jQs=;
        b=MFUwRSsD4EO4dF3dLY5oP/ZY54GVqHU5YTrpS9FdYHG1RzdlSSTCVonkYl9/OGvZDw
         azD/WcRTCIypODfcsbHHIx8J2Gk2WKXvTZyScZYvpxo9m6bDbyo0pcWGHD3HTITouuyv
         DKMiuD7pPeYHdNVBjZ1VEzmYhgN2GGmPgazeB/URl1osaWFWvC+ZMJ5BTIOTBvib021m
         bMW76l6lAxNr4r2DFqMfLWEvYo2Ho/MrEq2Ok472S5uaHaKlX01EseXcl9nbwnCPhlSI
         e2YSAjfXvILRbE1hOCurfgIONsQSXBwsXUGpyMJHdBQ6RiqdWAfYBvPUGMKpwS/bseLm
         k6dA==
X-Gm-Message-State: APjAAAXiGnep1qphOjCOlayRvRb+m3L6fVstjvsFr1FUtYQZzl96Y2n9
        m4IQLzx0oGuktWdCA2StULa76w==
X-Google-Smtp-Source: APXvYqy2HYLAn0m4KciMvOj56Jnl+GhF3rHn4PDJ2pDxkWs47lImKTGAEMqQOwqhhdZJFZxyaLa3aQ==
X-Received: by 2002:a62:1ac9:: with SMTP id a192mr10254306pfa.260.1565198172140;
        Wed, 07 Aug 2019 10:16:12 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a1sm62692130pgh.61.2019.08.07.10.16.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 10:16:11 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Minchan Kim <minchan@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, joelaf@google.com,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, namhyung@google.com,
        paulmck@linux.ibm.com, Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: [PATCH v5 2/6] mm/page_idle: Add support for handling swapped PG_Idle pages
Date:   Wed,  7 Aug 2019 13:15:55 -0400
Message-Id: <20190807171559.182301-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190807171559.182301-1-joel@joelfernandes.org>
References: <20190807171559.182301-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Idle page tracking currently does not work well in the following
scenario:
 1. mark page-A idle which was present at that time.
 2. run workload
 3. page-A is not touched by workload
 4. *sudden* memory pressure happen so finally page A is finally swapped out
 5. now see the page A - it appears as if it was accessed (pte unmapped
    so idle bit not set in output) - but it's incorrect.

To fix this, we store the idle information into a new idle bit of the
swap PTE during swapping of anonymous pages.

Also in the future, madvise extensions will allow a system process
manager (like Android's ActivityManager) to swap pages out of a process
that it knows will be cold. To an external process like a heap profiler
that is doing idle tracking on another process, this procedure will
interfere with the idle page tracking similar to the above steps.

Suggested-by: Minchan Kim <minchan@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 arch/Kconfig                  |  3 +++
 include/asm-generic/pgtable.h |  6 ++++++
 mm/page_idle.c                | 26 ++++++++++++++++++++++++--
 mm/rmap.c                     |  2 ++
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index a7b57dd42c26..3aa121ce824e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -575,6 +575,9 @@ config ARCH_WANT_HUGE_PMD_SHARE
 config HAVE_ARCH_SOFT_DIRTY
 	bool
 
+config HAVE_ARCH_PTE_SWP_PGIDLE
+	bool
+
 config HAVE_MOD_ARCH_SPECIFIC
 	bool
 	help
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 75d9d68a6de7..6d51d0a355a7 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -712,6 +712,12 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
 #define arch_start_context_switch(prev)	do {} while (0)
 #endif
 
+#ifndef CONFIG_HAVE_ARCH_PTE_SWP_PGIDLE
+static inline pte_t pte_swp_mkpage_idle(pte_t pte) { return pte; }
+static inline int pte_swp_page_idle(pte_t pte) { return 0; }
+static inline pte_t pte_swp_clear_mkpage_idle(pte_t pte) { return pte; }
+#endif
+
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 #ifndef CONFIG_ARCH_ENABLE_THP_MIGRATION
 static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
diff --git a/mm/page_idle.c b/mm/page_idle.c
index 9de4f4c67a8c..2766d4ab348c 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -276,7 +276,7 @@ struct page_idle_proc_priv {
 };
 
 /*
- * Add page to list to be set as idle later.
+ * Set a page as idle or add it to a list to be set as idle later.
  */
 static void pte_page_idle_proc_add(struct page *page,
 			       unsigned long addr, struct mm_walk *walk)
@@ -303,6 +303,13 @@ static void pte_page_idle_proc_add(struct page *page,
 		page_get = page_idle_get_page(page);
 		if (!page_get)
 			return;
+	} else {
+		/* For swapped pages, set output bit as idle */
+		frames = (addr - priv->start_addr) >> PAGE_SHIFT;
+		bit = frames % BITMAP_CHUNK_BITS;
+		chunk = &chunk[frames / BITMAP_CHUNK_BITS];
+		*chunk |= (1 << bit);
+		return;
 	}
 
 	/*
@@ -323,6 +330,7 @@ static int pte_page_idle_proc_range(pmd_t *pmd, unsigned long addr,
 	spinlock_t *ptl;
 	struct page *page;
 	struct vm_area_struct *vma = walk->vma;
+	struct page_idle_proc_priv *priv = walk->private;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -341,6 +349,19 @@ static int pte_page_idle_proc_range(pmd_t *pmd, unsigned long addr,
 
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
+		/* For swap_pte handling, we use an idle bit in the swap pte. */
+		if (is_swap_pte(*pte)) {
+			if (priv->write) {
+				set_pte_at(walk->mm, addr, pte,
+					   pte_swp_mkpage_idle(*pte));
+			} else {
+				/* If swap pte has idle bit set, report it as idle */
+				if (pte_swp_page_idle(*pte))
+					pte_page_idle_proc_add(NULL, addr, walk);
+			}
+			continue;
+		}
+
 		if (!pte_present(*pte))
 			continue;
 
@@ -432,7 +453,8 @@ ssize_t page_idle_proc_generic(struct file *file, char __user *ubuff,
 				set_page_idle(page);
 			}
 		} else {
-			if (page_idle_pte_check(page)) {
+			/* If page is NULL, it was swapped out */
+			if (!page || page_idle_pte_check(page)) {
 				off = ((cur->addr) >> PAGE_SHIFT) - start_frame;
 				bit = off % BITMAP_CHUNK_BITS;
 				index = off / BITMAP_CHUNK_BITS;
diff --git a/mm/rmap.c b/mm/rmap.c
index e5dfe2ae6b0d..4bd618aab402 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1629,6 +1629,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 			swp_pte = swp_entry_to_pte(entry);
 			if (pte_soft_dirty(pteval))
 				swp_pte = pte_swp_mksoft_dirty(swp_pte);
+			if (page_is_idle(page))
+				swp_pte = pte_swp_mkpage_idle(swp_pte);
 			set_pte_at(mm, address, pvmw.pte, swp_pte);
 			/* Invalidate as we cleared the pte */
 			mmu_notifier_invalidate_range(mm, address,
-- 
2.22.0.770.g0f2c4a37fd-goog

