Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CE83CEF2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 00:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387464AbhGSVca (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 17:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381720AbhGSSHQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:07:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CC7C0613DF;
        Mon, 19 Jul 2021 11:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bTUmV80VA1p5trYWH6euekPKFgfy6gnhL3vAo4kaEiY=; b=L17h48Aff2X0T5+yXGvQ5EpPfL
        iYq+dwdWkGKu79sCL1s2a5kVYv5y9Jo/xg1JrAWzujTmhHtm3bjfUezXJfsl0qmfejabSzR7KkV6W
        p9zXTfS5TYtDr5K7MUr17qZEMU2mx+k8Z7SKFx3iWMCqt0ueEeDNKf/kiaL+yLM2zdN0QDkMKuZUL
        iZ+kOzaj6ufHI6tIzrxYkjpSxAfvPwSRJL2s1fc88C5ehSCMnYrfvdmusluisG/TfwyhzLz4rTUcQ
        2q4ipDx0blp3Q5m+jmsgbnoTymVJMTzOqYLCh4leCHlgi7ADX0Ci/+XGqgQz/b44mpTLeBaooO2aw
        /S/4nwVA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5YFc-007LeE-Td; Mon, 19 Jul 2021 18:44:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: [PATCH v15 07/17] iomap: Convert iomap_invalidatepage to use a folio
Date:   Mon, 19 Jul 2021 19:39:51 +0100
Message-Id: <20210719184001.1750630-8-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210719184001.1750630-1-willy@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
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
index 715b25a1c1e6..0d7b6ef4c5cc 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -480,15 +480,15 @@ iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
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
+		WARN_ON_ONCE(folio_test_writeback(folio));
+		folio_cancel_dirty(folio);
 		iomap_page_release(folio);
 	}
 }
-- 
2.30.2

