Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398B537479F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 20:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbhEESBT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 14:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbhEESBM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 14:01:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAC8C04BE49;
        Wed,  5 May 2021 10:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0S+7FEjVvntTL1vffa/0jRKMkjceec+f6dKhCF9ShT4=; b=v29TkdSPMuV9kQlPERtYfujxZ9
        DsCk3zXokdt1RZx0MdchHl+IIY3OOpH0h5UuUX5JofljtM16zy7AWS2d3wocQ2gkrrPXm5bx73p0v
        kgycikB+Ho/bWI0Xaj3jFgsENnwI+GucIRg7W/L1xOZJL3yfFJ/iZMjrk9nuoRd3DDupwvGNe09vl
        fpr3VrPdQeOEGy63h91PJsrgtx0nAS0sUzN0yg+lRPUgAwywjE2C/06qP0cxDoxyTAol/pQsxnABM
        gez1GryaDIGLmBJjvF/a9r5nxelNw96jw5lt8XvPaTOfLqCyCcFu1rJUWdzs0I3zzJZ4Pntbsk6jH
        17SLDipg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leLMO-000eeJ-OY; Wed, 05 May 2021 17:31:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 94/96] iomap: Convert iomap_write_end_inline to take a folio
Date:   Wed,  5 May 2021 16:06:26 +0100
Message-Id: <20210505150628.111735-95-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Inline data only occupies a single page, but using a folio means that
we don't need to call compound_head() in PageUptodate().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 72fe6741a36c..40934c624f11 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -662,18 +662,18 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	return copied;
 }
 
-static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
+static size_t iomap_write_end_inline(struct inode *inode, struct folio *folio,
 		struct iomap *iomap, loff_t pos, size_t copied)
 {
 	void *addr;
 
-	WARN_ON_ONCE(!PageUptodate(page));
+	WARN_ON_ONCE(!folio_uptodate(folio));
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
@@ -690,7 +690,7 @@ static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	size_t ret;
 
 	if (srcmap->type == IOMAP_INLINE) {
-		ret = iomap_write_end_inline(inode, page, iomap, pos, copied);
+		ret = iomap_write_end_inline(inode, folio, iomap, pos, copied);
 	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
 		ret = block_write_end(NULL, inode->i_mapping, pos, len, copied,
 				page, NULL);
-- 
2.30.2

