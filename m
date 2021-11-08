Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C994479CE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 06:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbhKHFLV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Nov 2021 00:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhKHFLU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Nov 2021 00:11:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E597C061570;
        Sun,  7 Nov 2021 21:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wRvLnGx2ea/332rHz/tY/wsbBDAO1GNqTpTBxT5LYMg=; b=ly9K6nDhscWCDxpeWoIJXZ8Suw
        YXo19E24kKuQpHcyh+BnBAXJnvzBR4V+LRSusQ5+HZOAcjqGBN0H57ReWGn2FSAd0kNoFcwSD1yYN
        NwAjjUYZkOfGQNfFHI/c3GH4r9e2YEi/djH6iiAuuFG/T3FURmjh9JO4LnTUFCl+2vv71jI8g+H4F
        CAgItCixbD0KytosPGxp+wmHxcGz89Js4Zp3yJ51ZIS9onPWrD1d55YCnMPbZPE+RfyUIMG+wgAzS
        eeQN+c8cteOQWqbO/QUs+bZ8Snlf5/19tv8bOtGMnzmMteQZRz17YWMkdkNQoJvqCjT5+/bjKk5jb
        AmZusLhw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjwqc-008Asi-R6; Mon, 08 Nov 2021 05:06:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 26/28] iomap: Convert iomap_migrate_page() to use folios
Date:   Mon,  8 Nov 2021 04:05:49 +0000
Message-Id: <20211108040551.1942823-27-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108040551.1942823-1-willy@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The arguments are still pages for now, but we can use folios internally
and cut out a lot of calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 90f9f33ffe41..6830e4c15c61 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -493,19 +493,21 @@ int
 iomap_migrate_page(struct address_space *mapping, struct page *newpage,
 		struct page *page, enum migrate_mode mode)
 {
+	struct folio *folio = page_folio(page);
+	struct folio *newfolio = page_folio(newpage);
 	int ret;
 
-	ret = migrate_page_move_mapping(mapping, newpage, page, 0);
+	ret = folio_migrate_mapping(mapping, newfolio, folio, 0);
 	if (ret != MIGRATEPAGE_SUCCESS)
 		return ret;
 
-	if (page_has_private(page))
-		attach_page_private(newpage, detach_page_private(page));
+	if (folio_test_private(folio))
+		folio_attach_private(newfolio, folio_detach_private(folio));
 
 	if (mode != MIGRATE_SYNC_NO_COPY)
-		migrate_page_copy(newpage, page);
+		folio_migrate_copy(newfolio, folio);
 	else
-		migrate_page_states(newpage, page);
+		folio_migrate_flags(newfolio, folio);
 	return MIGRATEPAGE_SUCCESS;
 }
 EXPORT_SYMBOL_GPL(iomap_migrate_page);
-- 
2.33.0

