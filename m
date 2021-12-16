Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1A3477E68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 22:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241592AbhLPVIU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 16:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241597AbhLPVHZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:07:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C24C06175A;
        Thu, 16 Dec 2021 13:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gUQx8mxjdOjMT6SuQ1S8oSD7Fjv7zKbwTGmG07T4Lyc=; b=byOoSLK0T0SKyC4jUYoBvl9WFF
        6nm0LLY1JkSSqWnei29Qq+dqFsYpQZf5tOAiRomtedl4WWMLCURhKzZzGFwVgwZcaiwfEJyuM64rd
        NRecL8ifOTf4Kn+k4mBWf8GUicWGdzDHbZOFkZePofwca8CvuRT1u1biGKGvvsUsGcW8kHB7lk6mw
        daiOMmmJynanfsnXE0yrBUhf595FK4qyDtx72YGYYM2ijEeDqGsNHsYCjIWiye5+i/X08l0pHTb5O
        SBSM9+Cfeztxruyz6WtNWgfjgTawBry7omDTEZGUBSaU46PEXgX8QNF2m79gaC04i6pV5bOvADbvc
        31sapkjA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxxyD-00Fx5N-MO; Thu, 16 Dec 2021 21:07:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 23/25] iomap: Convert iomap_migrate_page() to use folios
Date:   Thu, 16 Dec 2021 21:07:13 +0000
Message-Id: <20211216210715.3801857-24-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216210715.3801857-1-willy@infradead.org>
References: <20211216210715.3801857-1-willy@infradead.org>
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
index a36695db6f9d..b2f6e5991eb0 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -504,19 +504,21 @@ int
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

