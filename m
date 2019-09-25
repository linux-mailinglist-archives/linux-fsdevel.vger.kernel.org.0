Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0D13BD5E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 02:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393217AbfIYAwT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 20:52:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56872 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391492AbfIYAwS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 20:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Msuh+GIy2CoxvHIBREeyTvGqw5Zy0zVyz1WZpxkYJLU=; b=jjPM6AOeJ3T4p2ns/p0veL1StU
        pLb7u0VfrTxsOUToXx7EuihWY+hieN/+gonGpGZk5xIgcajiTU07YfgpU7SniFynUrx/HPqxTaRUm
        Ihws+qwkWEE31PJqfwGAPKoeUfcdgeMokv7q5r/KmJqy5HTxDT/KE2kkAlrETXwgffWVYNjtL4w+z
        D9um7Zm3lZUQAKnd9d107iYu2CRCTMUu+67AvtxPaVePxDduc1NP3g6AR6TduLZAHkbodQyEpFP1T
        blk6GxeW0vnCyT2uojZJ8pBHjWpYSHujrsm2YeSnAuOPf6nFMzMMhMXlYo5d+5vUElPptm/ox1UdQ
        plHWZMAg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCvXV-00076O-AM; Wed, 25 Sep 2019 00:52:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 03/15] mm: Add file_offset_of_ helpers
Date:   Tue, 24 Sep 2019 17:52:02 -0700
Message-Id: <20190925005214.27240-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925005214.27240-1-willy@infradead.org>
References: <20190925005214.27240-1-willy@infradead.org>
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
 drivers/net/ethernet/ibm/ibmveth.c |  2 --
 include/linux/pagemap.h            | 25 ++++++++++++++++++++++---
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index c5be4ebd8437..bf98aeaf9a45 100644
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
index 750770a2c685..103205494ea0 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -428,14 +428,33 @@ static inline pgoff_t page_to_pgoff(struct page *page)
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
2.23.0

