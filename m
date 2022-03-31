Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8452D4ED9B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 14:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbiCaMhL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 08:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiCaMhK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:37:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADCD4E38F
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Mar 2022 05:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l5JgJ8jICMqLDofPSCCFDuiKUOklwo3t2QlVD191FLM=; b=h0gSBINcg5KJmJjNTFmgvrVpwM
        VB/U0N2VxgHXf/cpIkPjEWEWQrQj74m5tQRB8h/VDZn4QMxf5UMyHtnVEpYWUJyUtijg/HSMT1RX9
        QgRPaFPjR3XuDAK6Wj7t+0bALNUdSjvipkIEc0vyPrV4Gqx4Cy1GmYJevwLy3XV5j/yyV4KqFeQk+
        8DcFQrENsWOVqn8eQqGLPaQOZ3zaNtkoufntFJItEzjOJL3mawrxE9peYhWM6DWetHPFLzE7qTvCi
        lr2k2/qYCkjeIELANU/Ip/+HYSrtWR3ufQPGgLNLp06DjFC30TT2kqEAsmHvvrbxukhvu9aiQqJ1C
        RiQSq79w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZu1L-002FXH-Gd; Thu, 31 Mar 2022 12:35:23 +0000
Date:   Thu, 31 Mar 2022 05:35:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/12] mm: remove the pages argument to read_pages
Message-ID: <YkWgC4l5wQFsZD5D@infradead.org>
References: <20220330144930.315951-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330144930.315951-1-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

This is always an empty list or NULL with the removal of the ->readahead
support, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/readahead.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 297bd0719cda9..05207a663801f 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -142,8 +142,7 @@ file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
 }
 EXPORT_SYMBOL_GPL(file_ra_state_init);
 
-static void read_pages(struct readahead_control *rac, struct list_head *pages,
-		bool skip_page)
+static void read_pages(struct readahead_control *rac, bool skip_page)
 {
 	const struct address_space_operations *aops = rac->mapping->a_ops;
 	struct page *page;
@@ -179,7 +178,6 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
 
 	blk_finish_plug(&plug);
 
-	BUG_ON(pages && !list_empty(pages));
 	BUG_ON(readahead_count(rac));
 
 out:
@@ -206,7 +204,6 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 {
 	struct address_space *mapping = ractl->mapping;
 	unsigned long index = readahead_index(ractl);
-	LIST_HEAD(page_pool);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
 	unsigned long i;
 
@@ -238,7 +235,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			 * have a stable reference to this page, and it's
 			 * not worth getting one just for that.
 			 */
-			read_pages(ractl, &page_pool, true);
+			read_pages(ractl, true);
 			i = ractl->_index + ractl->_nr_pages - index - 1;
 			continue;
 		}
@@ -249,7 +246,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 		if (filemap_add_folio(mapping, folio, index + i,
 					gfp_mask) < 0) {
 			folio_put(folio);
-			read_pages(ractl, &page_pool, true);
+			read_pages(ractl, true);
 			i = ractl->_index + ractl->_nr_pages - index - 1;
 			continue;
 		}
@@ -263,7 +260,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	 * uptodate then the caller will launch readpage again, and
 	 * will then handle the error.
 	 */
-	read_pages(ractl, &page_pool, false);
+	read_pages(ractl, false);
 	filemap_invalidate_unlock_shared(mapping);
 	memalloc_nofs_restore(nofs);
 }
@@ -537,7 +534,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		ra->async_size += index - limit - 1;
 	}
 
-	read_pages(ractl, NULL, false);
+	read_pages(ractl, false);
 
 	/*
 	 * If there were already pages in the page cache, then we may have
-- 
2.30.2

