Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0E32B1063
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 22:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgKLV0t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 16:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgKLV0t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:26:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EA4C0613D1;
        Thu, 12 Nov 2020 13:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hHTBK4BYPzK5sxPr2WzuBNxW83FIC+F2fBOyFQf+0ws=; b=NXmVbUS7kRm/236rRSQxvtyc2U
        ZZHRvCkKVgQjP/gVzR/xk/YlN5IHiVxBG0u+WMV5uEX2gjlgQ73lS/hgOm1Ha4Rs/6O+uRjHC+CLq
        fmShrL0C1mKrjpFXW77suorHT+7Kkl9bUcF9BCkdjqUr/ycSP8+qRzJzauuWslNUTX8GZy5VLNPTz
        piHbKC5WBneycVJN40+v62WUOGcRQpiMw1Hm4QK/mFyUHiIer9DD6yFQ4bhzkYe7eopd7TtwLC/Xl
        bzf26tY7NklsxMfzn85KbmdBIIqRMLBdnc7hgs3MojXF5HgJuESEIXUEA/hBj/XGmXroZuuIB8EFO
        Joy1oLtQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdK79-0007G4-NF; Thu, 12 Nov 2020 21:26:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v4 01/16] mm: Make pagecache tagged lookups return only head pages
Date:   Thu, 12 Nov 2020 21:26:26 +0000
Message-Id: <20201112212641.27837-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201112212641.27837-1-willy@infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pagecache tags are used for dirty page writeback.  Since dirtiness is
tracked on a per-THP basis, we only want to return the head page rather
than each subpage of a tagged page.  All the filesystems which use huge
pages today are in-memory, so there are no tagged huge pages today.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/filemap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 249cf489f5df..bb6f2ae5a68c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2066,7 +2066,7 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
 EXPORT_SYMBOL(find_get_pages_contig);
 
 /**
- * find_get_pages_range_tag - find and return pages in given range matching @tag
+ * find_get_pages_range_tag - Find and return head pages matching @tag.
  * @mapping:	the address_space to search
  * @index:	the starting page index
  * @end:	The final page index (inclusive)
@@ -2074,8 +2074,9 @@ EXPORT_SYMBOL(find_get_pages_contig);
  * @nr_pages:	the maximum number of pages
  * @pages:	where the resulting pages are placed
  *
- * Like find_get_pages, except we only return pages which are tagged with
- * @tag.   We update @index to index the next page for the traversal.
+ * Like find_get_pages(), except we only return head pages which are tagged
+ * with @tag.  @index is updated to the index immediately after the last
+ * page we return, ready for the next iteration.
  *
  * Return: the number of pages which were found.
  */
@@ -2109,9 +2110,9 @@ unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
 		if (unlikely(page != xas_reload(&xas)))
 			goto put_page;
 
-		pages[ret] = find_subpage(page, xas.xa_index);
+		pages[ret] = page;
 		if (++ret == nr_pages) {
-			*index = xas.xa_index + 1;
+			*index = page->index + thp_nr_pages(page);
 			goto out;
 		}
 		continue;
-- 
2.28.0

