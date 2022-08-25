Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655865A0992
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 09:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbiHYHJ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 03:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237100AbiHYHJ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:09:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BFE11455;
        Thu, 25 Aug 2022 00:09:53 -0700 (PDT)
Received: from lenovo.Home (unknown [39.53.61.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 17DA06601E9A;
        Thu, 25 Aug 2022 08:09:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661411392;
        bh=BJ+PAJ4nk2Sl0y5d43VYaapFmr5r01iee9mww5IRQaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SuXLZgWmDePMqY0JETNTzWqQIZMdAhRAw8tbx6Ng4QluyYiEZNX8mrPiheQBdjBrN
         wMRuHOBS8PDuwhzxLdBolrcyEOfeQ3EVaL0/c0/cGcsbo441fZ+bSjlpKlJF4F8Q86
         +Z6sW7mgo1PyVX5osBxkT59TDbhVMtAadsE8J89i8Mgby/U3aAIU0CEWv7OvT0jaD6
         z6Po0oPmHZ73Gick5G4E+8Y7BPTy7SayZ1yEGkK4DUQTcDQC20xEoko1QPRsZgc+dR
         IFb67JEp1/fstH2LNyhitgSzqRYD6frSx31dEmeTmOLt1WzN6mk4MwPMHc/7WtZITW
         JFULgp5xhhyMA==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        linux-fsdevel@vger.kernel.org (open list:PROC FILESYSTEM),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 1/4] fs/proc/task_mmu: update functions to clear the soft-dirty bit
Date:   Thu, 25 Aug 2022 12:09:23 +0500
Message-Id: <20220825070926.2922471-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220825070926.2922471-1-usama.anjum@collabora.com>
References: <20220825070926.2922471-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index 8b4f3073f8f5..f66674033207 100644
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

