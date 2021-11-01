Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E5A442270
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 22:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhKAVSB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 17:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhKAVR7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:17:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBE2C061714;
        Mon,  1 Nov 2021 14:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XzK2PYsyWCkmNM3XtXYY+PTMPCbY/9k/CJ1ax9f53AI=; b=CcdjXVH+SoeDoVpuZyw1HqxrfM
        Udx0FtOZui3Klno3q3ftFogTama4MPLQK7Lzb6wqUJm4SaOKX9+iwosJsceDRzZyHONdrIcMVobwc
        SozJdxsOU/eriWSJ5By2UK5R5U34TdGj4N2uOwTETj3wGz/scMVj59BxVRqH5k0gjXETjnpbHMIRE
        3xawIRc4nl2GK5S4utVVM774X5y7SAcLaXXRA7tGaIzcbeCEbTjEJttw2vOib2Br5+4jNjsoY3aQl
        MP9z9KtU+wegOckWNCJOgetOoxNzGcfaTcrtss9zwx6SbZRPKVXR6/loQBAXo1/eUYtmvYZquPdIg
        KKKel/9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mheZp-0041yw-Ei; Mon, 01 Nov 2021 21:11:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 19/21] iomap: Convert iomap_migrate_page to use folios
Date:   Mon,  1 Nov 2021 20:39:27 +0000
Message-Id: <20211101203929.954622-20-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211101203929.954622-1-willy@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
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
index 2436933dfe42..3b93fdfedb72 100644
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

