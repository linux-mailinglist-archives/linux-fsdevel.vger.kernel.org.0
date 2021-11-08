Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD6244799F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 05:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhKHFCT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Nov 2021 00:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhKHFCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Nov 2021 00:02:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10D4C061570;
        Sun,  7 Nov 2021 20:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rVWwnvlYtMYK/tsNbIb68fg87VwCrXsoAMMv96ZQhKM=; b=aGBJf1jW6NXDQe+fAPDx5v4/NL
        uacbQJoEXKgX801UW3cAQKryLqp/9XuGA3KvhNAbF+fRHjdvV2WcmhxvxUoM50tS+bYmJeCbRVnMa
        DV93AMcpkWMKmvfmniINCWbPMnZKPw0PoFC8VflW5kqN4BTCHJxHRpYqz86YN1Es2uIf8I9B5Q9xn
        4LhNGnDFO4MvobKI6EXyyXE102YRoZuYuVYrV+OQ+yHBsfTEAncf5KBpu6jNIrDfvHcIeYHbbEbEZ
        2svGprAh1YHsw2fMexOoOC2OP39hN3o6OompfDzsVqq9U+tRCpejdf1+qy6K89Rh9YmVZ48SL0Gaw
        HKx3RuAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjwfu-008AaQ-A4; Mon, 08 Nov 2021 04:55:33 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 21/28] iomap: Convert iomap_write_end_inline to take a folio
Date:   Mon,  8 Nov 2021 04:05:44 +0000
Message-Id: <20211108040551.1942823-22-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108040551.1942823-1-willy@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This conversion is only safe because iomap only supports writes to inline
data which starts at the beginning of the file.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f4ae200adc4c..6b73d070e3a1 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -672,16 +672,16 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 }
 
 static size_t iomap_write_end_inline(const struct iomap_iter *iter,
-		struct page *page, loff_t pos, size_t copied)
+		struct folio *folio, loff_t pos, size_t copied)
 {
 	const struct iomap *iomap = &iter->iomap;
 	void *addr;
 
-	WARN_ON_ONCE(!PageUptodate(page));
+	WARN_ON_ONCE(!folio_test_uptodate(folio));
 	BUG_ON(!iomap_inline_data_valid(iomap));
 
-	flush_dcache_page(page);
-	addr = kmap_local_page(page) + pos;
+	flush_dcache_folio(folio);
+	addr = kmap_local_folio(folio, pos);
 	memcpy(iomap_inline_data(iomap, pos), addr, copied);
 	kunmap_local(addr);
 
@@ -699,7 +699,7 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 	size_t ret;
 
 	if (srcmap->type == IOMAP_INLINE) {
-		ret = iomap_write_end_inline(iter, page, pos, copied);
+		ret = iomap_write_end_inline(iter, folio, pos, copied);
 	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
 		ret = block_write_end(NULL, iter->inode->i_mapping, pos, len,
 				copied, &folio->page, NULL);
-- 
2.33.0

