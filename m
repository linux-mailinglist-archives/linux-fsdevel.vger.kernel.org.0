Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5435F3B051D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhFVMt2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhFVMt1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:49:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E966CC061574;
        Tue, 22 Jun 2021 05:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OErh3gKYsYMjzjPs6dWHQ6cFpEyB5M4X8HjILMkmo30=; b=R2/its3k8z9Ci3uo8JpahmsbIb
        /Jc7pJwp7NXKwXI/HWecJBmovI5lmvCvBgBNFc+AYnidBFj1OQPRG0IidjnNozblu0Y5MZmQBShx7
        kZkdvPtgP3TET5s2YhhDo9yMYt00JUiQ/+H+HYytM2Ok+RAvIZvVR6LS7NcMwU4Yo7eOYlfm9Ug58
        zSJJuaWNRcGG/VWyABjKvuJU4hVO9GAkaFObbE9JvHSzXVaJE4doZ/LWwnp9nK0BJKSrhKCqZZwpH
        FOGrJFM4xDfsbJnxz2T9+6gihCi8Y5OLHodBHICiws0Dwex7RXJ5miwvF+sZ5i6ZZp5uW8KpSlk7J
        ynHrtAzA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfmZ-00EIOL-NN; Tue, 22 Jun 2021 12:45:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 34/46] mm/filemap: Add i_blocks_per_folio()
Date:   Tue, 22 Jun 2021 13:15:39 +0100
Message-Id: <20210622121551.3398730-35-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
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
index 31edfa891987..c30db827b65d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1149,19 +1149,25 @@ static inline int page_mkwrite_check_truncate(struct page *page,
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

