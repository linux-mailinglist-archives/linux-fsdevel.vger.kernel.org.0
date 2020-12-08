Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560912D33A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 21:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgLHUWt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 15:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbgLHUWs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:22:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487E2C0611CF;
        Tue,  8 Dec 2020 12:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GXe88oFVuW5E50eWvehgyMPXo+ZSI7ysxpRbYPxEyKw=; b=L1OAotuFTl9MqvWQhrRpWjeJg7
        +NIHpnE87lRzWc6LFtgOO507tVsQcSG8RjCTgQb1Y+pwZEjOfkRrNZAkeN+6Tf00VPF7V6wHDYXsc
        z0DaFe7sTFsHdOSAuqm5IXnFATDBFn+NTCo7w7V/8mbGo8/zkecQr78Vns995egjAMN2UFVwj0WtO
        LBv0s1Jinda1fnTss8fp25rI+mjD0vvoHj4DsPc2aE/0PDlS/gRWtNqOJ51JN7E457oqgBG5h9V2n
        PGfXHzIi+0Q1uca8c1BAjYhlG68a16ShaOeZG2+gOUnoTc7l6o6q1SwXfLvQALum4+a/nRTBBvOfK
        flYx11kw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmiwr-00050B-Lk; Tue, 08 Dec 2020 19:46:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 01/11] mm: Introduce struct folio
Date:   Tue,  8 Dec 2020 19:46:43 +0000
Message-Id: <20201208194653.19180-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201208194653.19180-1-willy@infradead.org>
References: <20201208194653.19180-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have trouble keeping track of whether we've already called
compound_head() to ensure we're not operating on a tail page.  Further,
it's never clear whether we intend a struct page to refer to PAGE_SIZE
bytes or page_size(compound_head(page)).

Introduce a new type 'struct folio' that always refers to an entire
(possibly compound) page, and points to the head page (or base page).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h       |  5 +++++
 include/linux/mm_types.h | 17 +++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d1f64744ace2..7db9a10f084b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -916,6 +916,11 @@ static inline unsigned int compound_order(struct page *page)
 	return page[1].compound_order;
 }
 
+static inline unsigned int folio_order(struct folio *folio)
+{
+	return compound_order(&folio->page);
+}
+
 static inline bool hpage_pincount_available(struct page *page)
 {
 	/*
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 65df8abd90bd..d7e487d9998f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -223,6 +223,23 @@ struct page {
 #endif
 } _struct_page_alignment;
 
+/*
+ * A struct folio is either a base (order-0) page or the head page of
+ * a compound page.
+ */
+struct folio {
+	struct page page;
+};
+
+static inline struct folio *page_folio(struct page *page)
+{
+	unsigned long head = READ_ONCE(page->compound_head);
+
+	if (unlikely(head & 1))
+		return (struct folio *)(head - 1);
+	return (struct folio *)page;
+}
+
 static inline atomic_t *compound_mapcount_ptr(struct page *page)
 {
 	return &page[1].compound_mapcount;
-- 
2.29.2

