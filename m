Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D4715A005
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 05:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgBLET6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 23:19:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbgBLESr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=A6iWVb3zlDQS/VntSVu1LOGr/OubbxQggSx3CMqmkcA=; b=p3kVKCqFG4KTxDyrYl8WC4YcFv
        qK5fjiTePUliVUHjNkZH53pxDwgPYIqz+I3SCVqRs+iHUjDDCy5aZlZKdDEDkxkSWDO4TlqW02/7X
        csIWdkr/o/VRP7po+sjfQtIF6xCGwmVc8RNJY04BFKvpDlICjbC8KVYCOkimMuQczJ4Ka/Ne04an0
        GnL++QUEk+Rg8WeH0MA8DAWFLWUf0NuH53Mo0tt0CSs1iLkGSvmfuEktXIBvDI2/XzIOV29ElsvO4
        sQXtBNBiDLPz8AhTCmIQwT/RufUke68Wgmk9qmJRxgpIufXKO8XuN7BWSbz62ZtSBXbqiTyf6o2Tq
        k1G+cqEQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1jU6-0006mv-NF; Wed, 12 Feb 2020 04:18:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/25] mm: Allow hpages to be arbitrary order
Date:   Tue, 11 Feb 2020 20:18:26 -0800
Message-Id: <20200212041845.25879-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212041845.25879-1-willy@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Remove the assumption in hpage_nr_pages() that compound pages are
necessarily PMD sized.  The return type needs to be signed as we need
to use the negative value, eg when calling update_lru_size().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/huge_mm.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 5aca3d1bdb32..16367e2f771e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -230,12 +230,8 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 	else
 		return NULL;
 }
-static inline int hpage_nr_pages(struct page *page)
-{
-	if (unlikely(PageTransHuge(page)))
-		return HPAGE_PMD_NR;
-	return 1;
-}
+
+#define hpage_nr_pages(page)	(long)compound_nr(page)
 
 struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 		pmd_t *pmd, int flags, struct dev_pagemap **pgmap);
@@ -289,7 +285,7 @@ static inline struct list_head *page_deferred_list(struct page *page)
 #define HPAGE_PUD_MASK ({ BUILD_BUG(); 0; })
 #define HPAGE_PUD_SIZE ({ BUILD_BUG(); 0; })
 
-#define hpage_nr_pages(x) 1
+#define hpage_nr_pages(x) 1L
 
 static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 {
-- 
2.25.0

