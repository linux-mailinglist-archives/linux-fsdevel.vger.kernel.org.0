Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA593CEF3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 00:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389616AbhGSVgO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 17:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383933AbhGSSP5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:15:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FEDC061574;
        Mon, 19 Jul 2021 11:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=W8PwHzjpB4aVlX4Erzmy7nPi4Frr4taQ2kuLjYKQ+Hk=; b=rKTaja6pHvmYOl5n8sOPFHzRC/
        mi6IAdriTI87FrWSST2pBxQCtStzPYvLClvHi/3oJQNAKoJ6pZ86ZscLj/ZbqIJB50AoJIqMIh4Jn
        Y7lzbUGA4HhWc+G6U3Ga8+3/X7J55S4mmqwc2T0z357P9SzwA/OONbgA8MzP7SFGMbT9OCIwB+gx3
        DYKbcjxDUrGTQpeeI4XGowBLaRhNGdcHAZZ4tvFtsntkWn9gO0jOrTB+jwv9efO42+7xn4gFHqDF5
        IDYI9DLU6unnCdo0ZWPhXJbjjtZtAmWSbhKt4iNdxdfGcLdqBw63N9xHXkGpy20eAdqbs3RgwFO9G
        5gkMbwKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5YQ2-007MUk-0O; Mon, 19 Jul 2021 18:55:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: [PATCH v15 17/17] iomap: Convert iomap_migrate_page to use folios
Date:   Mon, 19 Jul 2021 19:40:01 +0100
Message-Id: <20210719184001.1750630-18-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210719184001.1750630-1-willy@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The arguments are still pages for now, but we can use folios internally
and cut out a lot of calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 60d3b7af61d1..cf56b19fb101 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -492,19 +492,21 @@ int
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
2.30.2

