Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC39D477E3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 22:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241734AbhLPVHp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 16:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241580AbhLPVHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:07:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82E7C061748;
        Thu, 16 Dec 2021 13:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=suVGpwgyQ1ocQfAS3H1Y5bDjLvNL3Ps59REde6+5QbA=; b=JGtk7dRY0siCX8diQFLzaNRyt3
        8x5OxXQCyfabtXcdFE1jejVKK/jUDhgm+6ixG39EywZjvqGoJpefHuHYFOMKGDKivI3zoM0aICBf4
        Wz3ogFTJOCMNpKjd1vWm6sju1LoLlcbbwvx9WYXbHtgcTnKvdhbdbd304CvhH1lJ62yXZeWmXvvjT
        9Zq9DFDd4bKgKHHtgR0Y5O3xRi5LjGBLhd2685M+VNJ9rlAJYu7RXwEH4n7OPWy/pFBNVnziW0k4L
        gLUcij3F2ku9kl6LRHg4m8wVkJAQ3wScbDap4gPotJioScqfOrcv8KD4E0n9jxSJqpS/48zaudryu
        HNTTMZ4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxxyD-00Fx5Z-QA; Thu, 16 Dec 2021 21:07:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 24/25] iomap: Support large folios in invalidatepage
Date:   Thu, 16 Dec 2021 21:07:14 +0000
Message-Id: <20211216210715.3801857-25-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216210715.3801857-1-willy@infradead.org>
References: <20211216210715.3801857-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we're punching a hole in a large folio, we need to remove the
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
index b2f6e5991eb0..36ccb903db92 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -481,13 +481,18 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
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
+	} else if (folio_test_large(folio)) {
+		/* Must release the iop so the page can be split */
+		WARN_ON_ONCE(!folio_test_uptodate(folio) &&
+			     folio_test_dirty(folio));
+		iomap_page_release(folio);
 	}
 }
 EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
-- 
2.33.0

