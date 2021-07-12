Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166CE3C426F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhGLEBG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhGLEBF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:01:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33135C0613DD;
        Sun, 11 Jul 2021 20:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=whD8BIYkU+G0i4MWw2Fy5QwFbYfuUTYf1Xdd+TaDZ8s=; b=enMm3MwMkxEXr4urJP+HeqQWCf
        UvBVnte1pYgcJUsou6wVCN8vFExRO1jYnNzmTR0WXZvzGaWoundtE99SnrhDiZvhSsPdtaR0BAJXW
        vs2zaQucAlNXPnm6msHuPSLwH9zpsGwPL65NGbxR2c8J9Ka05qqdkLbhzLmYfuc1D5u3ApWmLyE1d
        dvSkECsOuAMw7P7uBhq1qVZIVCDzFVsTOwwEl7BqUdSDLFfpPV20yjaqYETcNiqpykr0aaFQmieEf
        w4HEt9wmNzWEHETgi2dY0L/VI7A10MV/8EgQvAEjnGjOc+4cCzHys5ID27peaxkf6xpxvpfBzLbzc
        6RKZdoDg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2n40-00GqHa-SH; Mon, 12 Jul 2021 03:57:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 095/137] iomap: Convert iomap_invalidatepage to use a folio
Date:   Mon, 12 Jul 2021 04:06:19 +0100
Message-Id: <20210712030701.4000097-96-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an address_space operation, so its argument must remain as a
struct page, but we can use a folio internally.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 33a0bfb6f3db..1ed63e8cc727 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -478,15 +478,15 @@ iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
 {
 	struct folio *folio = page_folio(page);
 
-	trace_iomap_invalidatepage(page->mapping->host, offset, len);
+	trace_iomap_invalidatepage(folio->mapping->host, offset, len);
 
 	/*
 	 * If we are invalidating the entire page, clear the dirty state from it
 	 * and release it to avoid unnecessary buildup of the LRU.
 	 */
-	if (offset == 0 && len == PAGE_SIZE) {
-		WARN_ON_ONCE(PageWriteback(page));
-		cancel_dirty_page(page);
+	if (offset == 0 && len == folio_size(folio)) {
+		WARN_ON_ONCE(folio_writeback(folio));
+		folio_cancel_dirty(folio);
 		iomap_page_release(folio);
 	}
 }
-- 
2.30.2

