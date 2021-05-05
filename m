Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DCA373F48
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbhEEQMo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbhEEQMo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:12:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7097CC061574;
        Wed,  5 May 2021 09:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YA16rYXgNHk/bXHFiUuX44+hgN+DphbQUHkP829RZBM=; b=E6Lt0KYvbuAKp4RbCiJAxXOAqr
        Qfn6fHeYo0EkWDT4a33wgDNp4fMAsPRFlr9BNkawClL1g5INpVYmfhJvTsDFs5AQ+6F0kWURPbORh
        Od8fcoko12B/O/WuX9cxNpoB8IPw+mAII/WoHVo5NrM/W3ILSwK3FSXFeuUh4JE4Hp+J0UHzn4hfl
        A5oKYEO2lyVQZ/FD28CDSrjNfVYUgyXjfN2N4Nt3y7HqlcdFX5W4gwvag0m7dQVURN6rtYuLe2deL
        i7xXE8NeySis8aNl2Vk2IVSV7fRAJ6tTVLAMTDDH1KcfZ7b500RackauyUpWTQpFeM1ECJRsZtDR2
        CK6KEphQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leK5b-000ZGV-SJ; Wed, 05 May 2021 16:09:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 52/96] mm/memcg: Add folio_uncharge_cgroup
Date:   Wed,  5 May 2021 16:05:44 +0100
Message-Id: <20210505150628.111735-53-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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
index d0798d54f637..2e68c9848432 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -700,6 +700,7 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 }
 
 int folio_charge_cgroup(struct folio *, struct mm_struct *, gfp_t);
+void folio_uncharge_cgroup(struct folio *);
 
 int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
 int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
@@ -1209,6 +1210,10 @@ static inline int folio_charge_cgroup(struct folio *folio,
 	return 0;
 }
 
+static inline void folio_uncharge_cgroup(struct folio *)
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
index 529b10e72d5a..4ca2661cf891 100644
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

