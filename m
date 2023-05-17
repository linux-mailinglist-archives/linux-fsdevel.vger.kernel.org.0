Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51330705E05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 05:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjEQDZF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 23:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjEQDYy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 23:24:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166162133
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 20:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XRat9b9ZC03Dfj6Oxu5nzp71YAcaCoahDzicw+o/Ml0=; b=WEq0+LZxIvPZV03FkCoqg0SxjY
        MTZRpQDs8fsh7aBtpmXH+uiPHdrnspeHn8XFevv3OPCqt/T2klIG2G2TG8vo8vaKJOjrSdfSZC+qx
        Qk9A08tt02x3xQceOfJvpTbNNolXhn2aYMJblz5oHMvPD1Fy8sZVkFQiidLGBE398v+p4IqPu/wZX
        PWhz5ZDvToOg7PhkJnmI760LOjagr3l9sDT5FruEaNj/csAVqieJw6n4ZBRZ+kUYtNyQsLZj29vv5
        jOOsL8SB59nJ2bEmX+FZO8CJ6wf8x2zlQyKi7QAkyHvd7cO3IzaeSaPnb9qxfcOhsa3Daxu4kJ8p8
        8d+Vttfg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pz7mN-004lN8-Rc; Wed, 17 May 2023 03:24:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 3/6] gfs2: Convert gfs2_write_jdata_page() to gfs2_write_jdata_folio()
Date:   Wed, 17 May 2023 04:24:39 +0100
Message-Id: <20230517032442.1135379-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230517032442.1135379-1-willy@infradead.org>
References: <20230517032442.1135379-1-willy@infradead.org>
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

This function now supports large folios, even if nothing around it does.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/aops.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 749135252d52..0f92e3e117da 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -82,33 +82,34 @@ static int gfs2_get_block_noalloc(struct inode *inode, sector_t lblock,
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
 
+	if (folio_pos(folio) >= i_size)
+		return 0;
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
+	if (i_size < folio_pos(folio) + folio_size(folio))
+		folio_zero_segment(folio, offset_in_folio(folio, i_size),
+				folio_size(folio));
 
-	return __block_write_full_page(inode, page, gfs2_get_block_noalloc, wbc,
+	return __block_write_full_page(inode, &folio->page,
+				       gfs2_get_block_noalloc, wbc,
 				       end_buffer_async_write);
 }
 
@@ -137,7 +138,7 @@ static int __gfs2_jdata_write_folio(struct folio *folio,
 		}
 		gfs2_trans_add_databufs(ip, folio, 0, folio_size(folio));
 	}
-	return gfs2_write_jdata_page(&folio->page, wbc);
+	return gfs2_write_jdata_folio(folio, wbc);
 }
 
 /**
-- 
2.39.2

