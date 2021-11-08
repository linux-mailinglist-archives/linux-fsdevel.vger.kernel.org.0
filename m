Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711DC44796F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 05:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbhKHEk2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 23:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbhKHEk1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 23:40:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03D8C061570;
        Sun,  7 Nov 2021 20:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=yJsoFVUmtD2/zI3FaeMvhqZ6x8CIdtNnY36zhhhPsMM=; b=EbGHHP2ucSrSWNYVqKRitFSc0l
        fRXlNQcQjTc7GehOPiljJvsB4nVCqW7WE3bhPbU+0T+mLE3bLvkQ0077YwDm0VdOg0Cs28ZaVe7+P
        xjblJ2veyZ08JkNTBN3Ad8T5fNQWmQ4EWjh1qjKsdQvDylcqA001gd2vPGbDriNdtdhD6s4pCHUux
        vIBSuWJ9zvjyCGzS9x/trfgaVRb/KIUZ9Y3jaghcd6qdkaUAvdgDZeO8u+orkKkbGaJS4PEW2Bxw0
        TWLkAuYwWErYS21K1JS4suBS+RJbR9mld5T5zfrghdzPsa/AjZJNsfaOecyN4SsWMNQUKXume6iD7
        pyZOmewA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjwLC-008A6j-7A; Mon, 08 Nov 2021 04:34:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 11/28] iomap: Convert iomap_releasepage to use a folio
Date:   Mon,  8 Nov 2021 04:05:34 +0000
Message-Id: <20211108040551.1942823-12-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108040551.1942823-1-willy@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
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
index ad3a16861ddc..49f96fdadcb4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -453,15 +453,15 @@ iomap_releasepage(struct page *page, gfp_t gfp_mask)
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

