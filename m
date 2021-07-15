Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0AC3C9798
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbhGOEng (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhGOEnf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:43:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AB4C06175F;
        Wed, 14 Jul 2021 21:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MiJJVUeAUUm2avWMl+iruNtjhb6DvEHcG3LyC3D+Sk0=; b=NVyzW/MQ0CjOGOpiSX8Wi7vfed
        ToKC8zpoWsOkjxghObCfKRRFZxQ48dyPYnb1mMAKlA6dLhEejWb3k0zr2/F0zp5XZ3XcDfNmKyRrL
        3atBQ3VS7ZoNS+17NAF+Nuy7uDeZoD/eM0WYeOmqA45oF1X2nZoqhJgWzbTc3v54GgaWFo9UAngsm
        J89yxgFNN/3CloQtWZ7uK7JDtSsJdnkgvrTl/1Jnt0u/cWIItC8lCGuRS7kYSIYkZSurb3Vm/zsIZ
        axUQ50uQSfzod8/8RbWmwrPCW3Hl4Mi0Hq07KJ2tWSI5Xwcw45hnWnk9i1RC1lXSwB5Tvfl7q/cwG
        5X+hnt5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3t8o-002y7f-F1; Thu, 15 Jul 2021 04:38:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 077/138] mm/filemap: Add i_blocks_per_folio()
Date:   Thu, 15 Jul 2021 04:36:03 +0100
Message-Id: <20210715033704.692967-78-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reimplement i_blocks_per_page() as a wrapper around i_blocks_per_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/pagemap.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 006de2d84d06..412db88b8d0c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1150,19 +1150,25 @@ static inline int page_mkwrite_check_truncate(struct page *page,
 }
 
 /**
- * i_blocks_per_page - How many blocks fit in this page.
+ * i_blocks_per_folio - How many blocks fit in this folio.
  * @inode: The inode which contains the blocks.
- * @page: The page (head page if the page is a THP).
+ * @folio: The folio.
  *
- * If the block size is larger than the size of this page, return zero.
+ * If the block size is larger than the size of this folio, return zero.
  *
- * Context: The caller should hold a refcount on the page to prevent it
+ * Context: The caller should hold a refcount on the folio to prevent it
  * from being split.
- * Return: The number of filesystem blocks covered by this page.
+ * Return: The number of filesystem blocks covered by this folio.
  */
+static inline
+unsigned int i_blocks_per_folio(struct inode *inode, struct folio *folio)
+{
+	return folio_size(folio) >> inode->i_blkbits;
+}
+
 static inline
 unsigned int i_blocks_per_page(struct inode *inode, struct page *page)
 {
-	return thp_size(page) >> inode->i_blkbits;
+	return i_blocks_per_folio(inode, page_folio(page));
 }
 #endif /* _LINUX_PAGEMAP_H */
-- 
2.30.2

