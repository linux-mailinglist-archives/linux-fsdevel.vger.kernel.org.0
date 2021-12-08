Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E9246CC55
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240045AbhLHE0n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbhLHE0m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C0FC061756
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XdgFvvcU0VY2BBoR+sckcbNFdIGXaT2EcoM1SoJJkrY=; b=XUM0qSdXd+arG+Gbf5tXz5RcLI
        uTsXxfSG0ZXk3kWT0GKNdL6llEhBpsiirmxwqZYaB9NjH0yzaLxegDy0DjjBKL9nbDGKV7muJ4fMq
        VD735KMHN+1bNXdxntF+LkWEBtCxI/lnVX78sp+1b4/8ZF20ajf66yMrjsokMgIThxgL8ZkXdm6RV
        BYKDBDGraSbUO2YVz0f3nCatfiRMj4T1h0mJ0ttsw/inYwtpHNhmw2HMCapihtuqRQHfPOqai0CCo
        tMKljSFTdQ0TjngQrc39JrlrNtaQ8x5zTh2hLrWZj6DLpBd4bnSmpfS96cl1+tmcT8yVrEvSkA23N
        Sh8voY+A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU1-0084Wt-UN; Wed, 08 Dec 2021 04:23:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 05/48] pagevec: Add folio_batch
Date:   Wed,  8 Dec 2021 04:22:13 +0000
Message-Id: <20211208042256.1923824-6-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The folio_batch is the same as the pagevec, except that it is typed
to contain folios and not pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagevec.h | 63 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 7f3f19065a9f..4483e6ad7607 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -15,6 +15,7 @@
 #define PAGEVEC_SIZE	15
 
 struct page;
+struct folio;
 struct address_space;
 
 struct pagevec {
@@ -81,4 +82,66 @@ static inline void pagevec_release(struct pagevec *pvec)
 		__pagevec_release(pvec);
 }
 
+/**
+ * struct folio_batch - A collection of folios.
+ *
+ * The folio_batch is used to amortise the cost of retrieving and
+ * operating on a set of folios.  The order of folios in the batch is
+ * not considered important.  Some users of the folio_batch store
+ * "exceptional" entries in it which can be removed by calling
+ * folio_batch_remove_exceptionals().
+ */
+struct folio_batch {
+	unsigned char nr;
+	unsigned char aux[3];
+	struct folio *folios[PAGEVEC_SIZE];
+};
+
+/**
+ * folio_batch_init() - Initialise a batch of folios
+ * @fbatch: The folio batch.
+ *
+ * A freshly initialised folio_batch contains zero folios.
+ */
+static inline void folio_batch_init(struct folio_batch *fbatch)
+{
+	fbatch->nr = 0;
+}
+
+static inline unsigned int folio_batch_count(struct folio_batch *fbatch)
+{
+	return fbatch->nr;
+}
+
+static inline unsigned int fbatch_space(struct folio_batch *fbatch)
+{
+	return PAGEVEC_SIZE - fbatch->nr;
+}
+
+/**
+ * folio_batch_add() - Add a folio to a batch.
+ * @fbatch: The folio batch.
+ * @folio: The folio to add.
+ *
+ * The folio is added to the end of the batch.
+ * The batch must have previously been initialised using folio_batch_init().
+ *
+ * Return: The number of slots still available.
+ */
+static inline unsigned folio_batch_add(struct folio_batch *fbatch,
+		struct folio *folio)
+{
+	fbatch->folios[fbatch->nr++] = folio;
+	return fbatch_space(fbatch);
+}
+
+static inline void folio_batch_release(struct folio_batch *fbatch)
+{
+	pagevec_release((struct pagevec *)fbatch);
+}
+
+static inline void folio_batch_remove_exceptionals(struct folio_batch *fbatch)
+{
+	pagevec_remove_exceptionals((struct pagevec *)fbatch);
+}
 #endif /* _LINUX_PAGEVEC_H */
-- 
2.33.0

