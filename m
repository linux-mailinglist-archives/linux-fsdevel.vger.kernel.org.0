Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC8E3C97CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbhGOE5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhGOE5T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:57:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C94C06175F;
        Wed, 14 Jul 2021 21:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FfJ6ZNoiX29Han3ne7JZIAhgvMC58bjKSAKjKwLA6t8=; b=Et6pXsXerxU9QQvmuJhKjEA5+9
        giU78V/mLazdex17mOh8Ya0X7dyndJ/IPtbjGpSLI7o0DRTt+UnMDPg9m02dG1XArhrGk2h9iCGQ5
        nyEV93UF6KdFBKoBdQPaYwxhjiTrfSsaRi1htmnxrHrDRJGOBsejeUyMAMH2T6hLCokob+55dqmmr
        oUst8CaK7+deb3G8OyQOTikXz1R1Bp4dh+Zi8BWy9kLw8ObLwBSd68AD5FlgOXF7LqGNbH3Jx+gvw
        15GIELsfQBboDpdvweojqr92KTJ2IzYPnB9o+HMdBJxFS4dV7A4T+Ic2aLpxEpsSszm6KpYSiJY7U
        T7qxNOGg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tMV-002yzZ-Ee; Thu, 15 Jul 2021 04:52:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 096/138] iomap: Convert iomap_invalidatepage to use a folio
Date:   Thu, 15 Jul 2021 04:36:22 +0100
Message-Id: <20210715033704.692967-97-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
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
index abb065b50e38..6b41019a51a3 100644
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
+		WARN_ON_ONCE(folio_test_writeback(folio));
+		folio_cancel_dirty(folio);
 		iomap_page_release(folio);
 	}
 }
-- 
2.30.2

