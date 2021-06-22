Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430DB3B045E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhFVMbB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbhFVMbA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:31:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BBAC061574;
        Tue, 22 Jun 2021 05:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=LE1s1f8C2h8T4UyScp99hxGO6Hckcptj65nY+NL6uuE=; b=cfbW3Zw0GintsetvHWD3aJjhjB
        ZUF9vXySeo2gIzkgzdVe4C7Ao7VOlM1uR2Klnc6g3Sb9z2FT6ntx1T4eu+CQG1gOzhLfvssTiBheG
        6VaI5lpFq5xDePZBe8GfFIdMyLgqC0Cn4lT/ZcZZvUzAV030M1tlMGAoQ+qiimZkqHyQkM/XSzQz/
        41AdUgzALUd+4KAdi+ui/91zB6nq+YUJRN8uk7m9NYycWkW39kUWlZWh9rCAWaL1c1mfwkZto6zN+
        AC6rTOLvqv1a6XwQJtrWSByWYnAhZhESrIJobCz1IuXjxqf4iiPbxIZJg74Vhr+qIohDcfZo7I1CM
        PuSgTWmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfUw-00EH3D-AC; Tue, 22 Jun 2021 12:27:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/46] mm/memcg: Add folio_uncharge_cgroup()
Date:   Tue, 22 Jun 2021 13:15:20 +0100
Message-Id: <20210622121551.3398730-16-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reimplement mem_cgroup_uncharge() as a wrapper around
folio_uncharge_cgroup().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/memcontrol.h |  5 +++++
 mm/folio-compat.c          |  5 +++++
 mm/memcontrol.c            | 14 +++++++-------
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a50e5cee6d2c..d4b2bc939eee 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -705,6 +705,7 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 }
 
 int folio_charge_cgroup(struct folio *, struct mm_struct *, gfp_t);
+void folio_uncharge_cgroup(struct folio *);
 
 int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
 int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
@@ -1224,6 +1225,10 @@ static inline int folio_charge_cgroup(struct folio *folio,
 	return 0;
 }
 
+static inline void folio_uncharge_cgroup(struct folio *folio)
+{
+}
+
 static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
 				    gfp_t gfp_mask)
 {
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 1d71b8b587f8..d229b979b00d 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -54,4 +54,9 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp)
 {
 	return folio_charge_cgroup(page_folio(page), mm, gfp);
 }
+
+void mem_cgroup_uncharge(struct page *page)
+{
+	folio_uncharge_cgroup(page_folio(page));
+}
 #endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 69638f84d11b..a6befc0843e7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6717,24 +6717,24 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 }
 
 /**
- * mem_cgroup_uncharge - uncharge a page
- * @page: page to uncharge
+ * folio_uncharge_cgroup - Uncharge a folio.
+ * @folio: Folio to uncharge.
  *
- * Uncharge a page previously charged with mem_cgroup_charge().
+ * Uncharge a folio previously charged with folio_charge_cgroup().
  */
-void mem_cgroup_uncharge(struct page *page)
+void folio_uncharge_cgroup(struct folio *folio)
 {
 	struct uncharge_gather ug;
 
 	if (mem_cgroup_disabled())
 		return;
 
-	/* Don't touch page->lru of any random page, pre-check: */
-	if (!page_memcg(page))
+	/* Don't touch folio->lru of any random page, pre-check: */
+	if (!folio_memcg(folio))
 		return;
 
 	uncharge_gather_clear(&ug);
-	uncharge_page(page, &ug);
+	uncharge_page(&folio->page, &ug);
 	uncharge_batch(&ug);
 }
 
-- 
2.30.2

