Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6940B724FF9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 00:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239943AbjFFWf3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 18:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239965AbjFFWe5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:34:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CC61BFB
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 15:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=QVNnWFXK6jFzHkA+IkFF3lxJNeiQVfoJXZ8J7ElSc1A=; b=wGC60CxHXSn668dtOsefi4Jajt
        YAlzoplUXT4Ye0bT42zrxUODhZiWn3Mpk0h1LIX7dSEnZzgxTrlrh92dgl8ySsoeEKpU1L3NpEDX9
        /UywJ0ce+un+4rcw7DH0VY0+hlhn+bDTEE/rl4cCrvTih89Mn3T04TbRVfW1kkrUVOZfXGZUXEjVS
        k0FzLVe29dP7/lP/F1juNdDoiKV/7BdmrsZkjeAoShfaUVqbMafZvh/LxKxrzedM8qr3FGX8vuT52
        vGD0jNC4yDvl6kEV7q0ltVODH09F976USwl7moWO1zGN5wNaoVipFf36JowR3gLpPEERN8LJT9DvB
        JHNSrydQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6fFU-00DbEd-QK; Tue, 06 Jun 2023 22:33:56 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Subject: [PATCH v2 03/14] gfs2: Convert gfs2_write_jdata_page() to gfs2_write_jdata_folio()
Date:   Tue,  6 Jun 2023 23:33:35 +0100
Message-Id: <20230606223346.3241328-4-willy@infradead.org>
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

Add support for large folios and remove some accesses to page->mapping
and page->index.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: Bob Peterson <rpeterso@redhat.com>
Reviewed-by: Bob Peterson <rpeterso@redhat.com>
---
 fs/gfs2/aops.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 749135252d52..ec5b5c1ea634 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -82,33 +82,33 @@ static int gfs2_get_block_noalloc(struct inode *inode, sector_t lblock,
 }
 
 /**
- * gfs2_write_jdata_page - gfs2 jdata-specific version of block_write_full_page
- * @page: The page to write
+ * gfs2_write_jdata_folio - gfs2 jdata-specific version of block_write_full_page
+ * @folio: The folio to write
  * @wbc: The writeback control
  *
  * This is the same as calling block_write_full_page, but it also
  * writes pages outside of i_size
  */
-static int gfs2_write_jdata_page(struct page *page,
+static int gfs2_write_jdata_folio(struct folio *folio,
 				 struct writeback_control *wbc)
 {
-	struct inode * const inode = page->mapping->host;
+	struct inode * const inode = folio->mapping->host;
 	loff_t i_size = i_size_read(inode);
-	const pgoff_t end_index = i_size >> PAGE_SHIFT;
-	unsigned offset;
 
 	/*
-	 * The page straddles i_size.  It must be zeroed out on each and every
+	 * The folio straddles i_size.  It must be zeroed out on each and every
 	 * writepage invocation because it may be mmapped.  "A file is mapped
 	 * in multiples of the page size.  For a file that is not a multiple of
-	 * the  page size, the remaining memory is zeroed when mapped, and
+	 * the page size, the remaining memory is zeroed when mapped, and
 	 * writes to that region are not written out to the file."
 	 */
-	offset = i_size & (PAGE_SIZE - 1);
-	if (page->index == end_index && offset)
-		zero_user_segment(page, offset, PAGE_SIZE);
+	if (folio_pos(folio) < i_size &&
+	    i_size < folio_pos(folio) + folio_size(folio))
+		folio_zero_segment(folio, offset_in_folio(folio, i_size),
+				folio_size(folio));
 
-	return __block_write_full_page(inode, page, gfs2_get_block_noalloc, wbc,
+	return __block_write_full_page(inode, &folio->page,
+				       gfs2_get_block_noalloc, wbc,
 				       end_buffer_async_write);
 }
 
@@ -137,7 +137,7 @@ static int __gfs2_jdata_write_folio(struct folio *folio,
 		}
 		gfs2_trans_add_databufs(ip, folio, 0, folio_size(folio));
 	}
-	return gfs2_write_jdata_page(&folio->page, wbc);
+	return gfs2_write_jdata_folio(folio, wbc);
 }
 
 /**
-- 
2.39.2

