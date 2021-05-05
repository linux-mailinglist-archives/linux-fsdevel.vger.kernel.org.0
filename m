Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9EE374726
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 19:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbhEERrU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 13:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbhEERqE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 13:46:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E631C0611E9;
        Wed,  5 May 2021 10:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VnQaZ4JyzCyPpeLASDTFIqFnABRCf5mFlOCoGVl78Yo=; b=Ff+FgfIr0DKfHS9dBAkanfDDsg
        XjUYKLyWlCEd0EhYjd2e73/d3HYouOUBGKr+HQ26dYvp06uKgvaYXbYpw6r/GvwRetE03BkPAN2Ti
        6Hv+Fg9acw0iN81Eeoavw6tE6NuRZLi+MiOGEtrfO5br1vCICGJXFD7hE7bQzMyLHFSRd35w35PoQ
        p2XbXHamPOLfSONw0kLLOUEA04gTcC6Fca+QB5LFCrQBzSNm3yRLNgaAjNkcOEAq579pXK5ZrAU8j
        nQeLXgIlAdAvEorskcOB9AWnaQZh2Gs329q//N2THUZGEswcJal90D81QVlMct4yg3U9F32MUkhBn
        jWvRC1IA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leL9M-000dTK-Vi; Wed, 05 May 2021 17:18:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 86/96] iomap: Convert iomap_invalidatepage to use a folio
Date:   Wed,  5 May 2021 16:06:18 +0100
Message-Id: <20210505150628.111735-87-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an address_space operation, so its argument must remain as a
struct page, but we can use a folio internally.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 33226a32e5c5..c36e16b87c45 100644
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
 	if (offset == 0 && len == PAGE_SIZE) {
-		WARN_ON_ONCE(PageWriteback(page));
-		cancel_dirty_page(page);
+		WARN_ON_ONCE(folio_writeback(folio));
+		folio_cancel_dirty(folio);
 		iomap_page_release(folio);
 	}
 }
-- 
2.30.2

