Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209E920E33B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 00:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390363AbgF2VMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 17:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730141AbgF2S5o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:44 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3719C03078F
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 08:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=C1KD+M2SIQlHhURUdqj/8dc80Kw5CSfLAy8ZHYMHt/A=; b=fnydOLav01bryu6idYY18Yn9Mc
        DvTgO5l4RBFRsvYfJiefCUc0N+0LPUAYK1UfqBIlio71YhjUquj2kLlMjLxTR/iGIZl0WglbJ719E
        AV/Oh5sqg4RIicuACr7Tn7Vfmmnuwkrvs8E+vr8PWL53Y3Pq2cRhpJ7s7ik9NNzDGpLYmy6rocMar
        wWTLwk6qhEl4x1tnkl3PvyxhyBF3SSQM5evxVQIY4EX2zNm4+dUAwQ0M4hAwEaJFAmkqj2A2YJahh
        obY6eR++aoXAiMSyPEFfCcEJyZslt8OmjlJQRbSq0zLWjY1wT+tmyrvemJC878PNSmHUef54p7K47
        d0gBKmOg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpvZp-0004Ca-VN; Mon, 29 Jun 2020 15:20:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 6/7] mm: Add thp_head
Date:   Mon, 29 Jun 2020 16:19:58 +0100
Message-Id: <20200629151959.15779-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200629151959.15779-1-willy@infradead.org>
References: <20200629151959.15779-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is like compound_head() but compiles away when
CONFIG_TRANSPARENT_HUGEPAGE is not enabled.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/huge_mm.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index dcdfd21763a3..bd13e9ac3437 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -266,6 +266,15 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 		return NULL;
 }
 
+/**
+ * thp_head - Head page of a transparent huge page.
+ * @page: Any page (tail, head or regular) found in the page cache.
+ */
+static inline struct page *thp_head(struct page *page)
+{
+	return compound_head(page);
+}
+
 /**
  * thp_order - Order of a transparent huge page.
  * @page: Head page of a transparent huge page.
@@ -342,6 +351,12 @@ static inline struct list_head *page_deferred_list(struct page *page)
 #define HPAGE_PUD_MASK ({ BUILD_BUG(); 0; })
 #define HPAGE_PUD_SIZE ({ BUILD_BUG(); 0; })
 
+static inline struct page *thp_head(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(PageTail(page), page);
+	return page;
+}
+
 static inline unsigned int thp_order(struct page *page)
 {
 	VM_BUG_ON_PGFLAGS(PageTail(page), page);
-- 
2.27.0

