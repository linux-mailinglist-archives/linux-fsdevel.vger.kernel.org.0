Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405874ED9B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 14:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbiCaMho (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 08:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiCaMhn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:37:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FD9105AAD
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Mar 2022 05:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+wfO0fqnfPK8rPEIJXenhtX1pxwCLNeXAUIwTG6Wtng=; b=v/o0pyj2h2zBRBBNiieg/9QuCX
        veodUrWHaWEyc+mgdCk1WtT2vKfT+bVVKJ5peKeyAYEr6lPW6AIJpJm+hC5N6JjwvS2TmJN55KLA0
        PYPwgWbrW0Gur+fe/qiTtNotNe6bu++qv4mAK2BWKef8F3O1dI/YwH1L9tbEzWkT0RJUtk3Ijzw5X
        7GT1SK9dteel2aXuShQmH3g7E85sjm20Jgbe+1Mw+Wy8vtjNXxNifZhmFPFEf23iZAgZ+Y0LjYYkN
        yzL8mpXM9wVja906Y4Ebmjq5NtAIr01/55AoxYA7BZqmYZmXJ3g/O9HT4FiKsc8vCcjfouxkJQ7Ik
        jb4ddg8w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZu1r-002FbN-UL; Thu, 31 Mar 2022 12:35:55 +0000
Date:   Thu, 31 Mar 2022 05:35:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/12] mm: remove the skip_page argument to read_pages
Message-ID: <YkWgK+PJM/6r48Gt@infradead.org>
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

The skip_page argument to read_pages controls if rac->_index is
incremented before returning from the function.  Just open code that in
the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/readahead.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 05207a663801f..2e5c695b303d7 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -142,14 +142,14 @@ file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
 }
 EXPORT_SYMBOL_GPL(file_ra_state_init);
 
-static void read_pages(struct readahead_control *rac, bool skip_page)
+static void read_pages(struct readahead_control *rac)
 {
 	const struct address_space_operations *aops = rac->mapping->a_ops;
 	struct page *page;
 	struct blk_plug plug;
 
 	if (!readahead_count(rac))
-		goto out;
+		return;
 
 	blk_start_plug(&plug);
 
@@ -179,10 +179,6 @@ static void read_pages(struct readahead_control *rac, bool skip_page)
 	blk_finish_plug(&plug);
 
 	BUG_ON(readahead_count(rac));
-
-out:
-	if (skip_page)
-		rac->_index++;
 }
 
 /**
@@ -235,7 +231,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			 * have a stable reference to this page, and it's
 			 * not worth getting one just for that.
 			 */
-			read_pages(ractl, true);
+			read_pages(ractl);
+			ractl->_index++;
 			i = ractl->_index + ractl->_nr_pages - index - 1;
 			continue;
 		}
@@ -246,7 +243,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 		if (filemap_add_folio(mapping, folio, index + i,
 					gfp_mask) < 0) {
 			folio_put(folio);
-			read_pages(ractl, true);
+			read_pages(ractl);
+			ractl->_index++;
 			i = ractl->_index + ractl->_nr_pages - index - 1;
 			continue;
 		}
@@ -260,7 +258,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	 * uptodate then the caller will launch readpage again, and
 	 * will then handle the error.
 	 */
-	read_pages(ractl, false);
+	read_pages(ractl);
 	filemap_invalidate_unlock_shared(mapping);
 	memalloc_nofs_restore(nofs);
 }
@@ -534,7 +532,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		ra->async_size += index - limit - 1;
 	}
 
-	read_pages(ractl, false);
+	read_pages(ractl);
 
 	/*
 	 * If there were already pages in the page cache, then we may have
-- 
2.30.2

