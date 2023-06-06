Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C3B724FFF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 00:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240018AbjFFWg0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 18:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240025AbjFFWgE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:36:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAF3173C
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 15:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pg+rhpkHNgoijTQD2IVKfY4395e4SgDddWk+y+YVsIM=; b=nMDkUstMY71/y7iQjD6FAYAE23
        GwuICTcpQAqRN2T+2PeqbfsrBOoONNnfn0SZz+9q38AcOBujBDVSfLY52U7fiDQ+aM8tdFm0hAg5a
        RFCZOl7BHWvQDZ1oSuyb3nIqvQ+0HN9P4DsznHZvrOF+D5zPKt9lhqra4TgPVTM8KahtzeiDCyV6a
        eLQH+/osb/eqB/Wf9IFumBrYYxeKg3+TUXba4ncMO3JyTLComZOFfk9pFdclz8EC1U5c9v+Jc2JPS
        pULChVnBuTumVSSgYYfciY1c8xZzkzDWMkhaV7NH6dsVUirS3dm7JtuvFm0uB/QLiJ7fFfPvhAOhl
        gQDM98jQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6fFV-00DbEp-3S; Tue, 06 Jun 2023 22:33:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Subject: [PATCH v2 06/14] buffer: Make block_write_full_page() handle large folios correctly
Date:   Tue,  6 Jun 2023 23:33:38 +0100
Message-Id: <20230606223346.3241328-7-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230606223346.3241328-1-willy@infradead.org>
References: <20230606223346.3241328-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Keep the interface as struct page, but work entirely on the folio
internally.  Removes several PAGE_SIZE assumptions and removes
some references to page->index and page->mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: Bob Peterson <rpeterso@redhat.com>
Reviewed-by: Bob Peterson <rpeterso@redhat.com>
---
 fs/buffer.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 4d518df50fab..d8c2c000676b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2678,33 +2678,31 @@ int block_write_full_page(struct page *page, get_block_t *get_block,
 			struct writeback_control *wbc)
 {
 	struct folio *folio = page_folio(page);
-	struct inode * const inode = page->mapping->host;
+	struct inode * const inode = folio->mapping->host;
 	loff_t i_size = i_size_read(inode);
-	const pgoff_t end_index = i_size >> PAGE_SHIFT;
-	unsigned offset;
 
-	/* Is the page fully inside i_size? */
-	if (page->index < end_index)
+	/* Is the folio fully inside i_size? */
+	if (folio_pos(folio) + folio_size(folio) <= i_size)
 		return __block_write_full_folio(inode, folio, get_block, wbc,
 					       end_buffer_async_write);
 
-	/* Is the page fully outside i_size? (truncate in progress) */
-	offset = i_size & (PAGE_SIZE-1);
-	if (page->index >= end_index+1 || !offset) {
+	/* Is the folio fully outside i_size? (truncate in progress) */
+	if (folio_pos(folio) > i_size) {
 		folio_unlock(folio);
 		return 0; /* don't care */
 	}
 
 	/*
-	 * The page straddles i_size.  It must be zeroed out on each and every
+	 * The folio straddles i_size.  It must be zeroed out on each and every
 	 * writepage invocation because it may be mmapped.  "A file is mapped
 	 * in multiples of the page size.  For a file that is not a multiple of
-	 * the  page size, the remaining memory is zeroed when mapped, and
+	 * the page size, the remaining memory is zeroed when mapped, and
 	 * writes to that region are not written out to the file."
 	 */
-	zero_user_segment(page, offset, PAGE_SIZE);
+	folio_zero_segment(folio, offset_in_folio(folio, i_size),
+			folio_size(folio));
 	return __block_write_full_folio(inode, folio, get_block, wbc,
-							end_buffer_async_write);
+			end_buffer_async_write);
 }
 EXPORT_SYMBOL(block_write_full_page);
 
-- 
2.39.2

