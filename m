Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7774479D3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 06:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbhKHFNO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Nov 2021 00:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhKHFNO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Nov 2021 00:13:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41408C061570;
        Sun,  7 Nov 2021 21:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7XKLruoz0217yaASgnev6mQxYy91tCfaWYKYnfl/XXc=; b=K9JgAVRZMrX3qswTs8tZAvFa5s
        A61kU2ILIzKrLQOkUwa1M0WBUnJ/ferEnfwxdtTYMbU1iXK24HK8m6hWMKGbhVpJFe9fu+L6I1568
        uq5hkEaIk0t7f+8oG7dLZxM18Uq04uWVVurUPYCPz8J+G0MF7qkrrADtB9p0kiRaTR85L7ITTKYJ4
        jG5v31CtgCp+9sDqTThy6zmyr2GDwfFbVzhhwvKHnayIbgpaI5PpBoV9EMuuBslGeyjTG4DHlQeAj
        4BO50uVN1EzbUr673TXUViecqzkahTfDu+56elWi3xEzk6FZUei0ya/WpazVBcPgCXsDopfCoUugC
        dLaLuIWw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjwsC-008Avl-B4; Mon, 08 Nov 2021 05:07:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 27/28] iomap: Support multi-page folios in invalidatepage
Date:   Mon,  8 Nov 2021 04:05:50 +0000
Message-Id: <20211108040551.1942823-28-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108040551.1942823-1-willy@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we're punching a hole in a multi-page folio, we need to remove the
per-folio iomap data as the folio is about to be split and each page will
need its own.  If a dirty folio is only partially-uptodate, the iomap
data contains the information about which blocks cannot be written back,
so assert that a dirty folio is fully uptodate.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6830e4c15c61..265c7f8e7134 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -470,13 +470,18 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 	trace_iomap_invalidatepage(folio->mapping->host, offset, len);
 
 	/*
-	 * If we're invalidating the entire page, clear the dirty state from it
-	 * and release it to avoid unnecessary buildup of the LRU.
+	 * If we're invalidating the entire folio, clear the dirty state
+	 * from it and release it to avoid unnecessary buildup of the LRU.
 	 */
 	if (offset == 0 && len == folio_size(folio)) {
 		WARN_ON_ONCE(folio_test_writeback(folio));
 		folio_cancel_dirty(folio);
 		iomap_page_release(folio);
+	} else if (folio_test_multi(folio)) {
+		/* Must release the iop so the page can be split */
+		WARN_ON_ONCE(!folio_test_uptodate(folio) &&
+			     folio_test_dirty(folio));
+		iomap_page_release(folio);
 	}
 }
 EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
-- 
2.33.0

