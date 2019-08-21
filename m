Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04D3996E61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 02:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfHUAaw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 20:30:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56772 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfHUAav (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 20:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8+LFRgysFm6l7b1EmI740QXkofLUbCuDM+A6qLMp9ww=; b=hfuFvEaEQut5AVQb1YlZ91uQkZ
        cQCCd+XL0ZBjSfW+iVu6x/ii9yjABmkxM578Y1ifxD7MMwjomQLoKGn5k4MLo2FX/86BoXjOGYx+m
        st3+ToZCILpSW/kqCpeT1dtRTADo/0xMsbEK3LKhk9WhVc8eDvpYi0Sg0B/CLMkYomJKnt44gkhFd
        4QqRaGzT/xJhc6sVKdddPDG4H6ktFrxuEeyvAJ1O71FUL4NKpe0v0gJNYXfogtiSI3fi5iLUrGIRa
        8WF1zrkQ0+YMlL9tT+cBEyyUoucubTbfdFEgqghr9OeVk1kAfYxAmOblCehYf/ZXd0//Z8EABbvof
        y4pJ4swA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i0EWQ-0003HW-A3; Wed, 21 Aug 2019 00:30:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 2/5] mm: Add file_offset_of_ helpers
Date:   Tue, 20 Aug 2019 17:30:36 -0700
Message-Id: <20190821003039.12555-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821003039.12555-1-willy@infradead.org>
References: <20190821003039.12555-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The page_offset function is badly named for people reading the functions
which call it.  The natural meaning of a function with this name would
be 'offset within a page', not 'page offset in bytes within a file'.
Dave Chinner suggests file_offset_of_page() as a replacement function
name and I'm also adding file_offset_of_next_page() as a helper for the
large page work.  Also add kernel-doc for these functions so they show
up in the kernel API book.

page_offset() is retained as a compatibility define for now.
---
 include/linux/pagemap.h | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2728f20fbc49..84f341109710 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -436,14 +436,33 @@ static inline pgoff_t page_to_pgoff(struct page *page)
 	return page_to_index(page);
 }
 
-/*
- * Return byte-offset into filesystem object for page.
+/**
+ * file_offset_of_page - File offset of this page.
+ * @page: Page cache page.
+ *
+ * Context: Any context.
+ * Return: The offset of the first byte of this page.
  */
-static inline loff_t page_offset(struct page *page)
+static inline loff_t file_offset_of_page(struct page *page)
 {
 	return ((loff_t)page->index) << PAGE_SHIFT;
 }
 
+/* Legacy; please convert callers */
+#define page_offset(page)	file_offset_of_page(page)
+
+/**
+ * file_offset_of_next_page - File offset of the next page.
+ * @page: Page cache page.
+ *
+ * Context: Any context.
+ * Return: The offset of the first byte after this page.
+ */
+static inline loff_t file_offset_of_next_page(struct page *page)
+{
+	return ((loff_t)page->index + compound_nr(page)) << PAGE_SHIFT;
+}
+
 static inline loff_t page_file_offset(struct page *page)
 {
 	return ((loff_t)page_index(page)) << PAGE_SHIFT;
-- 
2.23.0.rc1

