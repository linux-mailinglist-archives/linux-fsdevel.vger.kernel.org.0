Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCCB3CEF30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 00:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387998AbhGSVcp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 17:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381440AbhGSSHQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:07:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A43C061793;
        Mon, 19 Jul 2021 11:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IcqJM902sWDHlXXt8KHS5wivXFgGLpkF/GJJNHr6Ztg=; b=YfcIIN675oN36zD8aZlB85W3OM
        B00FvdJea0x80Vd9OzW1h4EaeRnH1eeQ50ZgdbuAt+jU5ORHWYK3xIc9Fxd6lPtgrSFBhJ8jb3vbX
        X8HJ1URooNyjHvlx/5F0maLeMyd/ZARrDJCQMX1eDaxK6umdwoAbtyBbZtVc8cSCgZo8zWF/R7BfB
        MFAjxYPGsjBd2+7NjiIudxpWwcN8p1OHPagMdg7kRS4SmUiOylH2i/RGCSoPjirirILPfVn6w3ygz
        H5cI3ebTi+a35NDWbeFbrT8CY/Fb5aTPJvEg8vxFsT8sl2r/u0g0VpOhkmTT7Y1UAqNzF3DCKbWKX
        qI5Hl0Cg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5YEq-007LaI-FS; Mon, 19 Jul 2021 18:43:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: [PATCH v15 06/17] iomap: Convert iomap_releasepage to use a folio
Date:   Mon, 19 Jul 2021 19:39:50 +0100
Message-Id: <20210719184001.1750630-7-willy@infradead.org>
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
 fs/iomap/buffered-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 83eb5fdcbe05..715b25a1c1e6 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -460,15 +460,15 @@ iomap_releasepage(struct page *page, gfp_t gfp_mask)
 {
 	struct folio *folio = page_folio(page);
 
-	trace_iomap_releasepage(page->mapping->host, page_offset(page),
-			PAGE_SIZE);
+	trace_iomap_releasepage(folio->mapping->host, folio_pos(folio),
+			folio_size(folio));
 
 	/*
 	 * mm accommodates an old ext3 case where clean pages might not have had
 	 * the dirty bit cleared. Thus, it can send actual dirty pages to
 	 * ->releasepage() via shrink_active_list(), skip those here.
 	 */
-	if (PageDirty(page) || PageWriteback(page))
+	if (folio_test_dirty(folio) || folio_test_writeback(folio))
 		return 0;
 	iomap_page_release(folio);
 	return 1;
-- 
2.30.2

