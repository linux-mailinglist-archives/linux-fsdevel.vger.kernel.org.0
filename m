Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15719159FF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 05:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgBLETR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 23:19:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53934 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgBLESr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=E2LjqBszgquKpJquZnIE6WmTb8rlYH+KCAsDdBVlwlw=; b=qNLJwgF/rnW8ybxq8FcTESoXmR
        kVdQKbpxEeeKJQu4bjlaz4jNso3rZZfpN+vBHnd47cUEq2I8jusmAt5TLAumk5so/nas2pJ7J/Y5k
        eOf8j1QpTmlsBsAsHjljLv+G6VSZh+CGIlvZHd6hNXqBL2DYe0OdSNGoc0ONtr5emMxK1XPxHeVbf
        0H9JwJFkSY11MVcB+hNkT8blC7dR/PCRxNKR91Qm1BeU3gPD8W7hudcYZZhBMM6Pat4MrZooqucUj
        aH3/mxaJvgYuCgOx6Qd6GMVTUGgF1bxXVUjbyYpknlqN5J4POdJQ+lLl5MPzOry8xFTjX158hclxi
        ZgMszcVA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1jU6-0006ng-V3; Wed, 12 Feb 2020 04:18:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/25] mm: Add file_offset_of_ helpers
Date:   Tue, 11 Feb 2020 20:18:32 -0800
Message-Id: <20200212041845.25879-13-willy@infradead.org>
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

The page_offset function is badly named for people reading the functions
which call it.  The natural meaning of a function with this name would
be 'offset within a page', not 'page offset in bytes within a file'.
Dave Chinner suggests file_offset_of_page() as a replacement function
name and I'm also adding file_offset_of_next_page() as a helper for the
large page work.  Also add kernel-doc for these functions so they show
up in the kernel API book.

page_offset() is retained as a compatibility define for now.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/net/ethernet/ibm/ibmveth.c |  2 --
 include/linux/pagemap.h            | 25 ++++++++++++++++++++++---
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 84121aab7ff1..4cad94ac9bc9 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -978,8 +978,6 @@ static int ibmveth_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 	return -EOPNOTSUPP;
 }
 
-#define page_offset(v) ((unsigned long)(v) & ((1 << 12) - 1))
-
 static int ibmveth_send(struct ibmveth_adapter *adapter,
 			union ibmveth_buf_desc *descs, unsigned long mss)
 {
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2ec33aabdbf6..497197315b73 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -432,14 +432,33 @@ static inline pgoff_t page_to_pgoff(struct page *page)
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
+	return file_offset_of_page(page) + thp_size(page);
+}
+
 static inline loff_t page_file_offset(struct page *page)
 {
 	return ((loff_t)page_index(page)) << PAGE_SHIFT;
-- 
2.25.0

