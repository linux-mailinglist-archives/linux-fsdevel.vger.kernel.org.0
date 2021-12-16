Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0391B477E63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 22:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242039AbhLPVIW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 16:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241550AbhLPVHV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:07:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5768FC06173F;
        Thu, 16 Dec 2021 13:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=19L35JVLRTrAp5NKOV2Bx+UpgN8Jr6QXV+BBWJ4TIk8=; b=Sf8pSMfs8U7OMZoqcbrgs8SS/3
        r6WbdCSnY9eAAsb7URV2bsHQpfA5pw+fk+PYDON0KNZpQRbZjynvC7JQ6/iEP8no4yPR5Zb9f2Q6X
        ttraZOUOflo0v3yI5RyXMHIF/GVXfl1V9FjJmyW5qMpFemkHdGHHS2/Phaf15y2ayc+dn4OMd3bFD
        oCdwHwQ33WSsRTkye1yDD/DTEiIIKabmBCKPG0wKMt3q48kqxrqAKCb1v3nn9UViSOYkRhSIPbEFh
        8Miof6DKPP+WC7R0BKDYdr6bxUgIvPpfzn8mNRNh6WJO6OvHQnQoptswa7mjBTTi9uwM5zu3epH+x
        I6OrOopA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxxyB-00Fx3a-Jr; Thu, 16 Dec 2021 21:07:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 07/25] iomap: Convert iomap_releasepage to use a folio
Date:   Thu, 16 Dec 2021 21:06:57 +0000
Message-Id: <20211216210715.3801857-8-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216210715.3801857-1-willy@infradead.org>
References: <20211216210715.3801857-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an address_space operation, so its argument must remain as a
struct page, but we can use a folio internally.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 16604f605357..b0192b148c9f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -464,15 +464,15 @@ iomap_releasepage(struct page *page, gfp_t gfp_mask)
 {
 	struct folio *folio = page_folio(page);
 
-	trace_iomap_releasepage(page->mapping->host, page_offset(page),
-			PAGE_SIZE);
+	trace_iomap_releasepage(folio->mapping->host, folio_pos(folio),
+			folio_size(folio));
 
 	/*
 	 * mm accommodates an old ext3 case where clean pages might not have had
 	 * the dirty bit cleared. Thus, it can send actual dirty pages to
 	 * ->releasepage() via shrink_active_list(); skip those here.
 	 */
-	if (PageDirty(page) || PageWriteback(page))
+	if (folio_test_dirty(folio) || folio_test_writeback(folio))
 		return 0;
 	iomap_page_release(folio);
 	return 1;
-- 
2.33.0

