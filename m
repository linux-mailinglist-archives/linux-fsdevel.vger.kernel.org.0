Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B551A46CC71
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244249AbhLHE1r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244192AbhLHE0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C93C0698D6
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9FuAZvEtMvxjRhXYotUloBtGh5RYj0EuwlnJq5DbYZk=; b=j2TCVe3IdQvXco4UDlUZ2iSgHT
        4O297skJBjiAOe+4WDlIKE0KCtnBUq6n+lTXiBEFHMefV0+VNh+v1N5m++HP73uVEaoXQV9+y7r/A
        Lsoa6HtmItRUBT2DKF5G+0HFXPyiQEGG4mSD1/bfh251eIqsFnR8DoYdzw9ia0BydIEHVIMiqFU+C
        g5NE88smItA4IfPeVRpJay9O136IWdnTaeTB1oWbKC1h/TmvjwkRA+7aXAPaQfaAlZ5r4NXeNx3Fw
        RDFemEoyv5yBiC23mORAbKAo+Ch1wccxs3U9ee7TbKo7NZ6b67as5jQdBa2PRZjeTkFgqqlmb4p6a
        CtlQI7iw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU8-0084dz-3h; Wed, 08 Dec 2021 04:23:16 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 45/48] truncate: Convert invalidate_inode_pages2_range to folios
Date:   Wed,  8 Dec 2021 04:22:53 +0000
Message-Id: <20211208042256.1923824-46-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we're going to unmap a folio, we have to be sure to unmap the entire
folio, not just the part of it which lies after the search index.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/truncate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index a1113b0abb30..2d1dae085acb 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -599,13 +599,13 @@ static int invalidate_complete_folio2(struct address_space *mapping,
 	return 0;
 }
 
-static int do_launder_page(struct address_space *mapping, struct page *page)
+static int do_launder_folio(struct address_space *mapping, struct folio *folio)
 {
-	if (!PageDirty(page))
+	if (!folio_test_dirty(folio))
 		return 0;
-	if (page->mapping != mapping || mapping->a_ops->launder_page == NULL)
+	if (folio->mapping != mapping || mapping->a_ops->launder_page == NULL)
 		return 0;
-	return mapping->a_ops->launder_page(page);
+	return mapping->a_ops->launder_page(&folio->page);
 }
 
 /**
@@ -671,7 +671,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 				unmap_mapping_folio(folio);
 			BUG_ON(folio_mapped(folio));
 
-			ret2 = do_launder_page(mapping, &folio->page);
+			ret2 = do_launder_folio(mapping, folio);
 			if (ret2 == 0) {
 				if (!invalidate_complete_folio2(mapping, folio))
 					ret2 = -EBUSY;
-- 
2.33.0

