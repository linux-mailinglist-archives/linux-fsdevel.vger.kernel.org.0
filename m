Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3582136608E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 22:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhDTUDT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 16:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbhDTUDT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 16:03:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B163EC06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 13:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=rdPBPDmnWrV0hMY67fFbVX3E0JejY+SHse6Ze/egKAY=; b=j3Q4OMNPNHyEuBsN+Uljs2aFWm
        vOY8tBmy5JtD5diQENAliNBKAvvbvaAdoELjtbUUhJiUYefugc/UzT9NAHZj+XejxY9HhQeqX8Nqv
        mStzsk7dotxrKhSzBNfWXhQiMn0zYJ94t2mvg9bQqyNnDs0DMJl4h/IauucbL4rcbXsQbq6ux6m9T
        iRILXTBh8uades1GRPAmG5NrgwFp7A7zFPXEGwkyVA+4Ug9vuDg/mrlnl1W8DA6h+W18RNBVNnIRG
        vTkZEM9kzpT0y7KmpGYavUQcDe87jKpZB4TANxDdEM+SdDneobkyiwrD3g64AYMZ3Ym78Y3fFm7gv
        ETlOs6Tw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYwYf-00Fag5-Cp; Tue, 20 Apr 2021 20:01:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] mm/readahead: Handle ractl nr_pages being modified
Date:   Tue, 20 Apr 2021 21:01:15 +0100
Message-Id: <20210420200116.3715790-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The BUG_ON that checks whether the ractl is still in sync with the
local variables can trigger under some fairly unusual circumstances.
Remove the BUG_ON and resync the loop counter after every call to
read_pages().

One way I've seen to trigger it is:

 - Start out with a partially populated range in the page cache
 - Allocate some pages and run into an existing page
 - Send the read request off to the filesystem
 - The page we ran into is removed from the page cache
 - readahead_expand() succeeds in expanding upwards
 - Return to page_cache_ra_unbounded() and we hit the BUG_ON, as nr_pages
   has been adjusted upwards.

Reported-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index f02dbebf1cef..989a8e710100 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -198,8 +198,6 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	for (i = 0; i < nr_to_read; i++) {
 		struct page *page = xa_load(&mapping->i_pages, index + i);
 
-		BUG_ON(index + i != ractl->_index + ractl->_nr_pages);
-
 		if (page && !xa_is_value(page)) {
 			/*
 			 * Page already present?  Kick off the current batch
@@ -210,6 +208,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			 * not worth getting one just for that.
 			 */
 			read_pages(ractl, &page_pool, true);
+			i = ractl->_index + ractl->_nr_pages - index;
 			continue;
 		}
 
@@ -223,6 +222,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 					gfp_mask) < 0) {
 			put_page(page);
 			read_pages(ractl, &page_pool, true);
+			i = ractl->_index + ractl->_nr_pages - index;
 			continue;
 		}
 		if (i == nr_to_read - lookahead_size)
-- 
2.30.2

