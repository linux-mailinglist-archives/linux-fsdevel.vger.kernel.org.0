Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEBB581738
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 18:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239335AbiGZQVC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 12:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237717AbiGZQU4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:20:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153F4255A5;
        Tue, 26 Jul 2022 09:20:55 -0700 (PDT)
Received: from localhost.localdomain (unknown [203.135.47.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2411966015A9;
        Tue, 26 Jul 2022 17:20:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658852453;
        bh=2XJezlM2O6mq/j4/cdoFLK6TcWCjkGUL5ahOSzikQrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DD6J0sFg1PTj3EJZLhlR7/+xNSPOMV69E8RiZxrn74CZeVGkI1SS9LFPtILfRDyrk
         11uiDC8ef3j1vxs48UbEniz5rg2s16ZSakUvXHCwQPj6PHAIqXq1JPuW3w4eTQNj38
         t5UULnJkkP+JggGTRXQocJv0Io551fmgt8od018KD4nwFm9HaJKsH/uwQ1wFtppoJT
         3aJL7gEcWUzBy8OF5PtHKMP4/UMaxaeLhaiCbyqUYPPGtVHIhbUiYoBlYHjyVXTw8b
         8+nmpQNtCRINSJ/4NuPtr/XvaeR54EonTNG/2iAYqMhj+oYJePSZH0GEbs/cNAACym
         IBWWCckKRLDLw==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        linux-fsdevel@vger.kernel.org (open list:PROC FILESYSTEM),
        linux-api@vger.kernel.org (open list:ABI/API),
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS
        SUBSYSTEM),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        krisman@collabora.com
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 1/5] fs/proc/task_mmu: make functions global to be used in other files
Date:   Tue, 26 Jul 2022 21:18:50 +0500
Message-Id: <20220726161854.276359-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220726161854.276359-1-usama.anjum@collabora.com>
References: <20220726161854.276359-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update the clear_soft_dirty() and clear_soft_dirty_pmd() to optionally
clear and return the status if page is dirty.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 fs/proc/task_mmu.c        | 84 +--------------------------------
 include/linux/mm_inline.h | 99 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 82 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f8cd58846a28..94d5761cc369 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1076,86 +1076,6 @@ struct clear_refs_private {
 	enum clear_refs_types type;
 };
 
-#ifdef CONFIG_MEM_SOFT_DIRTY
-
-static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
-{
-	struct page *page;
-
-	if (!pte_write(pte))
-		return false;
-	if (!is_cow_mapping(vma->vm_flags))
-		return false;
-	if (likely(!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags)))
-		return false;
-	page = vm_normal_page(vma, addr, pte);
-	if (!page)
-		return false;
-	return page_maybe_dma_pinned(page);
-}
-
-static inline void clear_soft_dirty(struct vm_area_struct *vma,
-		unsigned long addr, pte_t *pte)
-{
-	/*
-	 * The soft-dirty tracker uses #PF-s to catch writes
-	 * to pages, so write-protect the pte as well. See the
-	 * Documentation/admin-guide/mm/soft-dirty.rst for full description
-	 * of how soft-dirty works.
-	 */
-	pte_t ptent = *pte;
-
-	if (pte_present(ptent)) {
-		pte_t old_pte;
-
-		if (pte_is_pinned(vma, addr, ptent))
-			return;
-		old_pte = ptep_modify_prot_start(vma, addr, pte);
-		ptent = pte_wrprotect(old_pte);
-		ptent = pte_clear_soft_dirty(ptent);
-		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
-	} else if (is_swap_pte(ptent)) {
-		ptent = pte_swp_clear_soft_dirty(ptent);
-		set_pte_at(vma->vm_mm, addr, pte, ptent);
-	}
-}
-#else
-static inline void clear_soft_dirty(struct vm_area_struct *vma,
-		unsigned long addr, pte_t *pte)
-{
-}
-#endif
-
-#if defined(CONFIG_MEM_SOFT_DIRTY) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
-static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
-		unsigned long addr, pmd_t *pmdp)
-{
-	pmd_t old, pmd = *pmdp;
-
-	if (pmd_present(pmd)) {
-		/* See comment in change_huge_pmd() */
-		old = pmdp_invalidate(vma, addr, pmdp);
-		if (pmd_dirty(old))
-			pmd = pmd_mkdirty(pmd);
-		if (pmd_young(old))
-			pmd = pmd_mkyoung(pmd);
-
-		pmd = pmd_wrprotect(pmd);
-		pmd = pmd_clear_soft_dirty(pmd);
-
-		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
-	} else if (is_migration_entry(pmd_to_swp_entry(pmd))) {
-		pmd = pmd_swp_clear_soft_dirty(pmd);
-		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
-	}
-}
-#else
-static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
-		unsigned long addr, pmd_t *pmdp)
-{
-}
-#endif
-
 static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 				unsigned long end, struct mm_walk *walk)
 {
@@ -1168,7 +1088,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
 		if (cp->type == CLEAR_REFS_SOFT_DIRTY) {
-			clear_soft_dirty_pmd(vma, addr, pmd);
+			check_soft_dirty_pmd(vma, addr, pmd, true);
 			goto out;
 		}
 
@@ -1194,7 +1114,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		ptent = *pte;
 
 		if (cp->type == CLEAR_REFS_SOFT_DIRTY) {
-			clear_soft_dirty(vma, addr, pte);
+			check_soft_dirty(vma, addr, pte, true);
 			continue;
 		}
 
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 7b25b53c474a..65014c347a94 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -360,4 +360,103 @@ pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
 #endif
 }
 
+#ifdef CONFIG_MEM_SOFT_DIRTY
+static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
+{
+	struct page *page;
+
+	if (!pte_write(pte))
+		return false;
+	if (!is_cow_mapping(vma->vm_flags))
+		return false;
+	if (likely(!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags)))
+		return false;
+	page = vm_normal_page(vma, addr, pte);
+	if (!page)
+		return false;
+	return page_maybe_dma_pinned(page);
+}
+
+static inline bool check_soft_dirty(struct vm_area_struct *vma,
+				    unsigned long addr, pte_t *pte, bool clear)
+{
+	/*
+	 * The soft-dirty tracker uses #PF-s to catch writes
+	 * to pages, so write-protect the pte as well. See the
+	 * Documentation/admin-guide/mm/soft-dirty.rst for full description
+	 * of how soft-dirty works.
+	 */
+	pte_t ptent = *pte;
+	int dirty = 0;
+
+	if (pte_present(ptent)) {
+		pte_t old_pte;
+
+		dirty = pte_soft_dirty(ptent);
+
+		if (dirty && clear && !pte_is_pinned(vma, addr, ptent)) {
+			old_pte = ptep_modify_prot_start(vma, addr, pte);
+			ptent = pte_wrprotect(old_pte);
+			ptent = pte_clear_soft_dirty(ptent);
+			ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
+		}
+	} else if (is_swap_pte(ptent)) {
+		dirty = pte_swp_soft_dirty(ptent);
+
+		if (dirty && clear) {
+			ptent = pte_swp_clear_soft_dirty(ptent);
+			set_pte_at(vma->vm_mm, addr, pte, ptent);
+		}
+	}
+
+	return !!dirty;
+}
+#else
+static inline bool check_soft_dirty(struct vm_area_struct *vma,
+				    unsigned long addr, pte_t *pte, bool clear)
+{
+	return false;
+}
+#endif
+
+#if defined(CONFIG_MEM_SOFT_DIRTY) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
+static inline bool check_soft_dirty_pmd(struct vm_area_struct *vma,
+					unsigned long addr, pmd_t *pmdp, bool clear)
+{
+	pmd_t old, pmd = *pmdp;
+	int dirty = 0;
+
+	if (pmd_present(pmd)) {
+		dirty = pmd_soft_dirty(pmd);
+		if (dirty && clear) {
+			/* See comment in change_huge_pmd() */
+			old = pmdp_invalidate(vma, addr, pmdp);
+			if (pmd_dirty(old))
+				pmd = pmd_mkdirty(pmd);
+			if (pmd_young(old))
+				pmd = pmd_mkyoung(pmd);
+
+			pmd = pmd_wrprotect(pmd);
+			pmd = pmd_clear_soft_dirty(pmd);
+
+			set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
+		}
+	} else if (is_migration_entry(pmd_to_swp_entry(pmd))) {
+		dirty = pmd_swp_soft_dirty(pmd);
+
+		if (dirty && clear) {
+			pmd = pmd_swp_clear_soft_dirty(pmd);
+			set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
+		}
+	}
+	return !!dirty;
+}
+#else
+static inline bool check_soft_dirty_pmd(struct vm_area_struct *vma,
+					unsigned long addr, pmd_t *pmdp, bool clear)
+{
+	return false;
+}
+#endif
+
 #endif
-- 
2.30.2

