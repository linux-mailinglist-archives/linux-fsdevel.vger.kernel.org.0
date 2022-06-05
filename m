Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4816D53DDF9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 21:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347218AbiFETjJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 15:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347115AbiFETjG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 15:39:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3C21181A;
        Sun,  5 Jun 2022 12:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6g09y1A9jVwuZlJR1irGeBqDpd31Ui3pSGWrlaz4nb0=; b=pg4gnoTyTVQMZkuLsLjufELZOm
        zdlkyM6Epz9Y5ls6kjBxq58ihNIUrb2VqIKn1nUlONRVxbp4g7dlQzMHo9JPUvh1cyx4cdcigWDI1
        slwAgDoI7SkWyyzH+j97LCItJ0qSvavcuPnYPdS5zdoFT4aZpCiGwaGGj7aUofkedaHvtjKzyVrNI
        42u9ldindn05Wm1yrBmLckPHwYi8R4I2j0QnGjrpg23633uwpEOoaC3S55ItOiGyvCgkUjK/1UElz
        ks1lQWAPi22UiL9YIdwqGaBwOialRfaScxUmJwyto5dh3WMxU2Ag123Wygqx+r/Kt4P8V7BgYZyFl
        43sDr6cA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nxw5Q-009wsP-JZ; Sun, 05 Jun 2022 19:38:56 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-nilfs@vger.kernel.org
Subject: [PATCH 01/10] filemap: Add filemap_get_folios()
Date:   Sun,  5 Jun 2022 20:38:45 +0100
Message-Id: <20220605193854.2371230-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220605193854.2371230-1-willy@infradead.org>
References: <20220605193854.2371230-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the equivalent of find_get_pages() but fills a folio_batch
instead of an array of pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 55 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 5555689ea809..50e57b2d845f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -718,6 +718,8 @@ static inline struct page *find_subpage(struct page *head, pgoff_t index)
 	return head + (index & (thp_nr_pages(head) - 1));
 }
 
+unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
+		pgoff_t end, struct folio_batch *fbatch);
 unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 			pgoff_t end, unsigned int nr_pages,
 			struct page **pages);
diff --git a/mm/filemap.c b/mm/filemap.c
index 1e66eea98a7e..ea4145b7a84c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2127,6 +2127,61 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
 	return folio_batch_count(fbatch);
 }
 
+/**
+ * filemap_get_folios - Get a batch of folios
+ * @mapping:	The address_space to search
+ * @start:	The starting page index
+ * @end:	The final page index (inclusive)
+ * @fbatch:	The batch to fill.
+ *
+ * Search for and return a batch of folios in the mapping starting at
+ * index @start and up to index @end (inclusive).  The folios are returned
+ * in @fbatch with an elevated reference count.
+ *
+ * The first folio may start before @start; if it does, it will contain
+ * @start.  The final folio may extend beyond @end; if it does, it will
+ * contain @end.  The folios have ascending indices.  There may be gaps
+ * between the folios if there are indices which have no folio in the
+ * page cache.  If folios are added to or removed from the page cache
+ * while this is running, they may or may not be found by this call.
+ *
+ * Return: The number of folios which were found.
+ * We also update @start to index the next folio for the traversal.
+ */
+unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
+		pgoff_t end, struct folio_batch *fbatch)
+{
+	XA_STATE(xas, &mapping->i_pages, *start);
+	struct folio *folio;
+
+	rcu_read_lock();
+	while ((folio = find_get_entry(&xas, end, XA_PRESENT)) != NULL) {
+		/* Skip over shadow, swap and DAX entries */
+		if (xa_is_value(folio))
+			continue;
+		if (!folio_batch_add(fbatch, folio)) {
+			*start = folio->index + folio_nr_pages(folio);
+			goto out;
+		}
+	}
+
+	/*
+	 * We come here when there is no page beyond @end. We take care to not
+	 * overflow the index @start as it confuses some of the callers. This
+	 * breaks the iteration when there is a page at index -1 but that is
+	 * already broken anyway.
+	 */
+	if (end == (pgoff_t)-1)
+		*start = (pgoff_t)-1;
+	else
+		*start = end + 1;
+out:
+	rcu_read_unlock();
+
+	return folio_batch_count(fbatch);
+}
+EXPORT_SYMBOL(filemap_get_folios);
+
 static inline
 bool folio_more_pages(struct folio *folio, pgoff_t index, pgoff_t max)
 {
-- 
2.35.1

