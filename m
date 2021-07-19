Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5843CEF3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 00:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389540AbhGSVfy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 17:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383840AbhGSSNm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:13:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7432C0613DB;
        Mon, 19 Jul 2021 11:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=w4Z4Q5QrzeK+2DIgyhzgWQKVqxCOm0WVZy+YjyhlB6g=; b=syDtFN8ARUe87gRMQF2TqThld/
        SBeniiT2vzFulHOnN0J71wNsINmJozbZq+hyWB0qw+wGiGgtNplVfPhQWvRhQ+qWH+udhuMAiKzln
        NRU30lnSEmtUcWCAWwnXzndKRVb7FOuLOo7xFmveDoeuvbNR16jRbg7VFBpf/YGxiiMXfljpoJL8a
        vxX5qplGEFHjXY0suAsfOCsgq0+S4JqtfpvwvFfi74WmTwQSQYkzH4X84CSWsZY6iPkxKkapodLXy
        6MQuz7lf3maCoN2PUucgaDdX879wFRPd7CPTOHDi1UyPTQ62PMHrwKM4hSmu5Odgs7jZOJwlrWf1B
        YN28FXNA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5YLk-007MHc-BC; Mon, 19 Jul 2021 18:51:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v15 14/17] iomap: Convert iomap_read_inline_data to take a folio
Date:   Mon, 19 Jul 2021 19:39:58 +0100
Message-Id: <20210719184001.1750630-15-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210719184001.1750630-1-willy@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Inline data is restricted to being less than a page in size, so we
don't need to handle multi-page folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4b02337009bc..23ee86aba9d6 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -194,25 +194,25 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-static void
-iomap_read_inline_data(struct inode *inode, struct page *page,
+static void iomap_read_inline_data(struct inode *inode, struct folio *folio,
 		struct iomap *iomap)
 {
 	size_t size = i_size_read(inode);
 	void *addr;
 
-	if (PageUptodate(page))
+	if (folio_test_uptodate(folio))
 		return;
 
-	BUG_ON(page_has_private(page));
-	BUG_ON(page->index);
+	BUG_ON(folio_test_private(folio));
+	BUG_ON(folio->index);
+	BUG_ON(folio_multi(folio));
 	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
-	addr = kmap_atomic(page);
+	addr = kmap_local_folio(folio, 0);
 	memcpy(addr, iomap->inline_data, size);
 	memset(addr + size, 0, PAGE_SIZE - size);
-	kunmap_atomic(addr);
-	SetPageUptodate(page);
+	kunmap_local(addr);
+	folio_mark_uptodate(folio);
 }
 
 static inline bool iomap_block_needs_zeroing(struct inode *inode,
@@ -237,7 +237,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 	if (iomap->type == IOMAP_INLINE) {
 		WARN_ON_ONCE(pos);
-		iomap_read_inline_data(inode, &folio->page, iomap);
+		iomap_read_inline_data(inode, folio, iomap);
 		return PAGE_SIZE;
 	}
 
@@ -616,7 +616,7 @@ static int iomap_write_begin(struct inode *inode, loff_t pos, size_t len,
 
 	page = folio_file_page(folio, pos >> PAGE_SHIFT);
 	if (srcmap->type == IOMAP_INLINE)
-		iomap_read_inline_data(inode, page, srcmap);
+		iomap_read_inline_data(inode, folio, srcmap);
 	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
 	else
-- 
2.30.2

