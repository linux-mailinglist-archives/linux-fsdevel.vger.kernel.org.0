Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C933CEF3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 00:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389547AbhGSVgB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 17:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383866AbhGSSOc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:14:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D0EC061574;
        Mon, 19 Jul 2021 11:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3YXV7bsz65ycT7LtiOSUerTEWLmLCqMdPeOobe2FK+Y=; b=UeKoKZpAdOt2FXA5UVmWeuV+JS
        E5+Nzf8tps7DVB9p5CzJ9m5OGEWskLgO7tHg2xhOIZn/YV7sHZ0gxi1LfFbPtnIV2blAfPPT71NyX
        2sWzY7tqXADZrbsaNFe9BIXFTUE71I7ZPamuwrvi6fLupXw1ed+J5kzEddwIL0EAzMnC2Pbhm3nGA
        WklbdYhVnXiVG06pku0fzaPOu9RkUi3rVZJYmFWWBYaqio6IX6LEraTmEZgiogx9Yk/fVbdGIoxKe
        GDApKtwyUS2G8TGjGfEhC9AVpw6Ruqzvy4UB1zrxyN81qdRGgDft07zKziKhxEki3UOh/W/9ucFQ6
        8BuAskNA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5YO5-007MNU-AT; Mon, 19 Jul 2021 18:53:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v15 15/17] iomap: Convert iomap_write_end_inline to take a folio
Date:   Mon, 19 Jul 2021 19:39:59 +0100
Message-Id: <20210719184001.1750630-16-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210719184001.1750630-1-willy@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Inline data only occupies a single page, but using a folio means that
we don't need to call compound_head() in PageUptodate().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 23ee86aba9d6..f8ca307270e7 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -664,18 +664,18 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	return copied;
 }
 
-static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
+static size_t iomap_write_end_inline(struct inode *inode, struct folio *folio,
 		struct iomap *iomap, loff_t pos, size_t copied)
 {
 	void *addr;
 
-	WARN_ON_ONCE(!PageUptodate(page));
+	WARN_ON_ONCE(!folio_test_uptodate(folio));
 	BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
-	flush_dcache_page(page);
-	addr = kmap_atomic(page);
+	flush_dcache_folio(folio);
+	addr = kmap_local_folio(folio, 0);
 	memcpy(iomap->inline_data + pos, addr + pos, copied);
-	kunmap_atomic(addr);
+	kunmap_local(addr);
 
 	mark_inode_dirty(inode);
 	return copied;
@@ -692,7 +692,7 @@ static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	size_t ret;
 
 	if (srcmap->type == IOMAP_INLINE) {
-		ret = iomap_write_end_inline(inode, page, iomap, pos, copied);
+		ret = iomap_write_end_inline(inode, folio, iomap, pos, copied);
 	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
 		ret = block_write_end(NULL, inode->i_mapping, pos, len, copied,
 				page, NULL);
-- 
2.30.2

