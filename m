Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D4572D163
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 23:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjFLVFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 17:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238616AbjFLVEn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:04:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFB8DF
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 14:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=QVNnWFXK6jFzHkA+IkFF3lxJNeiQVfoJXZ8J7ElSc1A=; b=eV66Z9yiJ6X1EuiRwsby/gllHM
        cO4PnbLzsJJOh1v6aiAnOEvNOstnKK/UrNrJZeaGqrS2qXj4AMwtxYaNBqjPS33tVaiUn4fizY/L2
        C5oQLpbGAvf2MbGAI3spwI2Egx30E8JA/3gTO7AfDcrVTuCLO8iFKlgjgChd0SQxLPxjIzzbnUhmK
        CTw2vPbzsr7jP2neZf7BGvky4cwxJP255YyjKjIk9flfYt0E4tKnVpHMz1hqP6FrG+pRSNPFwtxKM
        i1XngszlkONGaCm0xGjo879nOjzjzzKSVfDohS4C9FjDJHQl5b0EIhVKx1BGNCmQW/zatL/stQ4Bu
        p08YrgrA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8ofX-0033wi-3h; Mon, 12 Jun 2023 21:01:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Subject: [PATCH v3 03/14] gfs2: Convert gfs2_write_jdata_page() to gfs2_write_jdata_folio()
Date:   Mon, 12 Jun 2023 22:01:30 +0100
Message-Id: <20230612210141.730128-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230612210141.730128-1-willy@infradead.org>
References: <20230612210141.730128-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

