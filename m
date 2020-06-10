Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95801F5CE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgFJURo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730520AbgFJUNs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0EEC08C5C3;
        Wed, 10 Jun 2020 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rN/mlFQb7HaxIMdRoCBWWTWQlk5OHj7v1RP+jX7Yp4Y=; b=eQkWOqFzpT9FwkkpBW+oRka0dP
        MuhOIi4m2vJrWWRLdz1++H4mVbdMhV527yj1MrHCeXjSD+s10sC1Hx8RzZEgfAZ3K4ezxW6zsDPNz
        PUp7ckg/fBq13+BALbTfR87DIzU3yGwHp/59R30N6jpiQsKBWWRIQ2NNbtxF2X3L0FH4bJwA1UYnu
        GiXKKAI6+15lvMolQwyh7uP6GmN3ts6bwQbHVdpiA1yqE/AfC1l4Iw0jySUprEsHSpgKoVbAqUfuF
        LO1ynifb8BGqeso/F5sa35PicEPeraxP+ToPUlr5sE67ev85/ncOJuO6fLYmz3Vb1Y/RT9uthemeE
        OHuocJ2Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76Z-0003Tf-I1; Wed, 10 Jun 2020 20:13:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 08/51] mm: Add thp_order
Date:   Wed, 10 Jun 2020 13:13:02 -0700
Message-Id: <20200610201345.13273-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This function returns the order of a transparent huge page.  It
compiles to 0 if CONFIG_TRANSPARENT_HUGEPAGE is disabled.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/huge_mm.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 71f20776b06c..dd19720a8bc2 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -265,6 +265,19 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 	else
 		return NULL;
 }
+
+/**
+ * thp_order - Order of a transparent huge page.
+ * @page: Head page of a transparent huge page.
+ */
+static inline unsigned int thp_order(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(PageTail(page), page);
+	if (PageHead(page))
+		return HPAGE_PMD_ORDER;
+	return 0;
+}
+
 static inline int hpage_nr_pages(struct page *page)
 {
 	if (unlikely(PageTransHuge(page)))
@@ -324,6 +337,12 @@ static inline struct list_head *page_deferred_list(struct page *page)
 #define HPAGE_PUD_MASK ({ BUILD_BUG(); 0; })
 #define HPAGE_PUD_SIZE ({ BUILD_BUG(); 0; })
 
+static inline unsigned int thp_order(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(PageTail(page), page);
+	return 0;
+}
+
 static inline int hpage_nr_pages(struct page *page)
 {
 	VM_BUG_ON_PAGE(PageTail(page), page);
-- 
2.26.2

