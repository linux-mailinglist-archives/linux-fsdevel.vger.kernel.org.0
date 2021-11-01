Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E23E4422A2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 22:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhKAVaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 17:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhKAVaO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:30:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5036AC061714;
        Mon,  1 Nov 2021 14:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6bZSgxt9Vp8PHp96upv0Lfo1DUhNLAJZ3JuUI0Qxfxo=; b=hK/GGzM8a2KnqEDDtlTUuEfr5u
        qyHTA0l/i5fFHQp+PEMkcjEk1YCHVCmV1SaOCg9QvWubnapxnM3ul26wpQS4M/CaayV9gsjjZs6kH
        pSWmi+7BHVJvVxpmF2W1KSP2cjwMHZEBJYTGpetljNTEjlFOgXfb3UW0Zc6z3rD7hq5CjfCeI1i13
        HP71+CGRPiQd6zfUV/wPgWF6gWjAlntTHRRMC3+CMVuWMeSqR95em/UvLXbvFV0UIENTfx1UVVQFR
        1keGIJLkl71RiNAQFtvutnxEatc8PzN4rqiLrvSDTw0ZXHgwedvFua5NRUDMJNkWGz6hV89ekvC9/
        /+OmTTFg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhebO-00422D-4I; Mon, 01 Nov 2021 21:12:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 20/21] iomap: Support multi-page folios in invalidatepage
Date:   Mon,  1 Nov 2021 20:39:28 +0000
Message-Id: <20211101203929.954622-21-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211101203929.954622-1-willy@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
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
---
 fs/iomap/buffered-io.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3b93fdfedb72..9d7c91f9ec1d 100644
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

