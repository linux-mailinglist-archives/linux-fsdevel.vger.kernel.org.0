Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDE13C423C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhGLDvk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhGLDvk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:51:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311D0C0613DD;
        Sun, 11 Jul 2021 20:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hQ7ZByTxmNtS3sqYd75NdkrokfnpDQsA8FwO56p/1X8=; b=fCVCuVzR1KPHv5DrJZ3UNvAb3Z
        oSUmkH9aMAK/xc0hpoa6iZClEvmswYjLNKXT/D6OXs3u2u2h8Y2k7BTpE+vRa88eq9IK8T7SXf/TJ
        q4OTYG4cVvdRCuORRDqIj4KoqL0a4K/AbNV1jy3CZ9Nakx9fRlHHhYb5fRHgBkcabR+nwP7SMBcVv
        BChPE/0LC45sqq78D6kFA77Eoedrja70DsHeytYTmSbMXvJ0NzxVxu8v+PgDDiEJ2od+A1jG8bAqw
        Xr6NRsOQysqI60hJ97HzSW9qQ0ipii8Iog4iNxZ+dZ8DLMcUu+reDdfsRqIIw9T3/AiaU97IjlLoT
        iq1l+C4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mvJ-00GpfU-IE; Mon, 12 Jul 2021 03:48:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 076/137] mm/filemap: Add i_blocks_per_folio()
Date:   Mon, 12 Jul 2021 04:06:00 +0100
Message-Id: <20210712030701.4000097-77-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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
index c0454714f0c0..319e2b486c0d 100644
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

