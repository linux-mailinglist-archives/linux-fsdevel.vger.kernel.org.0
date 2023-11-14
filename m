Return-Path: <linux-fsdevel+bounces-2841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E727EB425
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE92C281261
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 15:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FBF41776;
	Tue, 14 Nov 2023 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E3C41765
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 15:50:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A636182
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:49:58 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39FD91FB;
	Tue, 14 Nov 2023 07:50:43 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 491403F641;
	Tue, 14 Nov 2023 07:49:57 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1] mm: More ptep_get() conversion
Date: Tue, 14 Nov 2023 15:49:45 +0000
Message-Id: <20231114154945.490401-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c33c794828f2 ("mm: ptep_get() conversion") converted all
(non-arch) call sites to use ptep_get() instead of doing a direct
dereference of the pte. Full rationale can be found in that commit's
log.

Since then, three new call sites have snuck in, which directly
dereference the pte, so let's fix those up.

Unfortunately there is no reliable automated mechanism to catch these;
I'm relying on a combination of Coccinelle (which throws up a lot of
false positives) and some compiler magic to force a compiler error on
dereference (While this approach finds dereferences, it also yields a
non-booting kernel so can't be committed).

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/filemap.c     | 2 +-
 mm/ksm.c         | 2 +-
 mm/userfaultfd.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9710f43a89ac..32eedf3afd45 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3443,7 +3443,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 		 * handled in the specific fault path, and it'll prohibit the
 		 * fault-around logic.
 		 */
-		if (!pte_none(vmf->pte[count]))
+		if (!pte_none(ptep_get(&vmf->pte[count])))
 			goto skip;

 		count++;
diff --git a/mm/ksm.c b/mm/ksm.c
index 7efcc68ccc6e..6a831009b4cb 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -468,7 +468,7 @@ static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long nex
 			page = pfn_swap_entry_to_page(entry);
 	}
 	/* return 1 if the page is an normal ksm page or KSM-placed zero page */
-	ret = (page && PageKsm(page)) || is_ksm_zero_pte(*pte);
+	ret = (page && PageKsm(page)) || is_ksm_zero_pte(ptent);
 	pte_unmap_unlock(pte, ptl);
 	return ret;
 }
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 96d9eae5c7cc..0b6ca553bebe 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -312,7 +312,7 @@ static int mfill_atomic_pte_poison(pmd_t *dst_pmd,

 	ret = -EEXIST;
 	/* Refuse to overwrite any PTE, even a PTE marker (e.g. UFFD WP). */
-	if (!pte_none(*dst_pte))
+	if (!pte_none(ptep_get(dst_pte)))
 		goto out_unlock;

 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
--
2.25.1


