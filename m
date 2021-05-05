Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD7E373FD2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbhEEQbO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhEEQbN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:31:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5D3C061574;
        Wed,  5 May 2021 09:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fGXeriWRXwI62lv9/5xrWlA4+z2PdEHPI8DQFPyC/rE=; b=TxhRkg6/+CDRx8eN3rN5YCwWZg
        pkXnkMv2kM75tLEDJMqB6BEtrGbprvaIKZjwdYp6KpRpTdeCAPV3eElE8ooNSI40s/Z/rawXyDx11
        bBquTlgB6Zv/KHd6GX0Fle74yyLnCbzF5XRAuIMREhxbmbvU6D75/HlN4o6eSNcNtyfqrSVIcrBkl
        us4RyF+4PU9Ld5j9sajim1ZeIi8ZQ3G3zuznfnPEg8cvZeeH3kjHc4G6G9yH78HKjgl0zR/GJV9eT
        Iaq0P9IIezOx3knq7MzGFzBL0wJl/LRy53ZL8SJUrwFrL+BMYl9OosEZFltPRtPPdZL2QuKNZr4qJ
        tpwS69Vw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leKLi-000aTt-2B; Wed, 05 May 2021 16:26:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 68/96] mm/filemap: Add i_blocks_per_folio
Date:   Wed,  5 May 2021 16:06:00 +0100
Message-Id: <20210505150628.111735-69-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reimplement i_blocks_per_page() as a wrapper around i_blocks_per_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index fa24217e305d..2f896574aad7 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1224,19 +1224,25 @@ static inline int page_mkwrite_check_truncate(struct page *page,
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

