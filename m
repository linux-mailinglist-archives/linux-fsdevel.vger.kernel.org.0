Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46FD617AA2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 11:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiKCKIH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 06:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiKCKH6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:07:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63646394;
        Thu,  3 Nov 2022 03:07:57 -0700 (PDT)
Received: from localhost.localdomain (unknown [39.45.244.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F1B8F6602936;
        Thu,  3 Nov 2022 10:07:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667470076;
        bh=MLOajoALxs2BA+DAlpPUi9P0UdFtJcqV/tFJX2ymRCg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VBORngxRE/I3r1ilvd5xFr6Q8FqWKImM+odODVIEno95GBE3mTV9aUiCL43ohYPa7
         35vsb2hGq3Z91/DOmVmdXUovT0a03NshSCVrEx/GiLxO1IutPLbxABoYSLFcXIPlUh
         DbDcozWzkymFpf2VAOVY1B6dd8PCqseGsRAiWSjzKMkGEIRIS3nT556cEFJ2lWMkYQ
         ApPukZJxB0Upr8sxaybK593LRpVKNjujNtuNbO2zyZeGIpd5oc1E3zgvY2SZ1wk9Ks
         VSMOTpNTemWScPmQ/3FuPOGGyLJcNASO3UiDIKg2jPzFvNZGlmIRkuPUT+pTv6Klaf
         aGXoE5A5hPP+Q==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <emmir@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Zach O'Keefe" <zokeefe@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        "open list : KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list : PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list : MEMORY MANAGEMENT" <linux-mm@kvack.org>
Subject: [PATCH v4 1/3] fs/proc/task_mmu: update functions to clear the soft-dirty PTE bit
Date:   Thu,  3 Nov 2022 15:07:34 +0500
Message-Id: <20221103100736.2356351-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221103100736.2356351-1-usama.anjum@collabora.com>
References: <20221103100736.2356351-1-usama.anjum@collabora.com>
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
Changes in v2:
- Move back the functions back to their original file
---
 fs/proc/task_mmu.c | 82 ++++++++++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 31 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 8a74cdcc9af0..8235c536ac70 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1095,8 +1095,8 @@ static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr,
 	return page_maybe_dma_pinned(page);
 }
 
-static inline void clear_soft_dirty(struct vm_area_struct *vma,
-		unsigned long addr, pte_t *pte)
+static inline bool check_soft_dirty(struct vm_area_struct *vma,
+				    unsigned long addr, pte_t *pte, bool clear)
 {
 	/*
 	 * The soft-dirty tracker uses #PF-s to catch writes
@@ -1105,55 +1105,75 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
 	 * of how soft-dirty works.
 	 */
 	pte_t ptent = *pte;
+	int dirty = 0;
 
 	if (pte_present(ptent)) {
 		pte_t old_pte;
 
-		if (pte_is_pinned(vma, addr, ptent))
-			return;
-		old_pte = ptep_modify_prot_start(vma, addr, pte);
-		ptent = pte_wrprotect(old_pte);
-		ptent = pte_clear_soft_dirty(ptent);
-		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
+		dirty = pte_soft_dirty(ptent);
+
+		if (dirty && clear && !pte_is_pinned(vma, addr, ptent)) {
+			old_pte = ptep_modify_prot_start(vma, addr, pte);
+			ptent = pte_wrprotect(old_pte);
+			ptent = pte_clear_soft_dirty(ptent);
+			ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
+		}
 	} else if (is_swap_pte(ptent)) {
-		ptent = pte_swp_clear_soft_dirty(ptent);
-		set_pte_at(vma->vm_mm, addr, pte, ptent);
+		dirty = pte_swp_soft_dirty(ptent);
+
+		if (dirty && clear) {
+			ptent = pte_swp_clear_soft_dirty(ptent);
+			set_pte_at(vma->vm_mm, addr, pte, ptent);
+		}
 	}
+
+	return !!dirty;
 }
 #else
-static inline void clear_soft_dirty(struct vm_area_struct *vma,
-		unsigned long addr, pte_t *pte)
+static inline bool check_soft_dirty(struct vm_area_struct *vma,
+				    unsigned long addr, pte_t *pte, bool clear)
 {
+	return false;
 }
 #endif
 
 #if defined(CONFIG_MEM_SOFT_DIRTY) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
-static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
-		unsigned long addr, pmd_t *pmdp)
+static inline bool check_soft_dirty_pmd(struct vm_area_struct *vma,
+					unsigned long addr, pmd_t *pmdp, bool clear)
 {
 	pmd_t old, pmd = *pmdp;
+	int dirty = 0;
 
 	if (pmd_present(pmd)) {
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
 	} else if (is_migration_entry(pmd_to_swp_entry(pmd))) {
-		pmd = pmd_swp_clear_soft_dirty(pmd);
-		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
+		dirty = pmd_swp_soft_dirty(pmd);
+
+		if (dirty && clear) {
+			pmd = pmd_swp_clear_soft_dirty(pmd);
+			set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
+		}
 	}
+	return !!dirty;
 }
 #else
-static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
-		unsigned long addr, pmd_t *pmdp)
+static inline bool check_soft_dirty_pmd(struct vm_area_struct *vma,
+					unsigned long addr, pmd_t *pmdp, bool clear)
 {
+	return false;
 }
 #endif
 
@@ -1169,7 +1189,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
 		if (cp->type == CLEAR_REFS_SOFT_DIRTY) {
-			clear_soft_dirty_pmd(vma, addr, pmd);
+			check_soft_dirty_pmd(vma, addr, pmd, true);
 			goto out;
 		}
 
@@ -1195,7 +1215,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		ptent = *pte;
 
 		if (cp->type == CLEAR_REFS_SOFT_DIRTY) {
-			clear_soft_dirty(vma, addr, pte);
+			check_soft_dirty(vma, addr, pte, true);
 			continue;
 		}
 
-- 
2.30.2

