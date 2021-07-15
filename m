Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2E93C9858
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239649AbhGOF04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237563AbhGOF04 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:26:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CA2C06175F;
        Wed, 14 Jul 2021 22:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VtHfn0sslcY9O2vVH0P420AejCUsoqkaY5BNLZez8k8=; b=cbDjLajck0dFxp0HsF6cDTnbFH
        bPgp1bEhoEnt6ZaucvI8tj0gt2Dtn5gVzaJYBqj/CkhPFyZKtbaiLrrYYf+pHN6BN8Xi91drlggG5
        5l8ZHwmveva9ORl4BE3kkqKerSSUT8MHJfSitvGJlWOdKa7vYz++QjYFhXZsnSKsEHECPMoJvnukr
        G/k7xk4lkIT0UqPXWtgvjRAfg2xPBV2rpYVYX3lCvWk4Rxc1WXd1NNfFBMLCfOEt3xVoqrQaP1P53
        SyGMEMVgBePp2HWBtgAN5uPX4Sdw6Md6Fyp1jH7nmg4yIIkf/P0/m3shRTiBn0eM3kBwS9U0Syvqh
        mMklttNg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tpJ-0030xF-0t; Thu, 15 Jul 2021 05:22:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 131/138] mm/truncate: Fix invalidate_complete_page2 for THPs
Date:   Thu, 15 Jul 2021 04:36:57 +0100
Message-Id: <20210715033704.692967-132-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

invalidate_complete_page2() currently open-codes filemap_free_folio(),
except for the part where it handles THP.  Rather than adding that,
call page_cache_free_page() from invalidate_complete_page2().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c  | 3 +--
 mm/internal.h | 1 +
 mm/truncate.c | 5 +----
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 97d17e8c76aa..d5787502c3be 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -228,8 +228,7 @@ void __filemap_remove_folio(struct folio *folio, void *shadow)
 	page_cache_delete(mapping, folio, shadow);
 }
 
-static void filemap_free_folio(struct address_space *mapping,
-				struct folio *folio)
+void filemap_free_folio(struct address_space *mapping, struct folio *folio)
 {
 	void (*freepage)(struct page *);
 
diff --git a/mm/internal.h b/mm/internal.h
index 3e32064df18d..d63ef2595eff 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -73,6 +73,7 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
 		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
 bool truncate_inode_partial_page(struct page *page, loff_t start, loff_t end);
+void filemap_free_folio(struct address_space *mapping, struct folio *folio);
 
 /**
  * folio_evictable - Test whether a folio is evictable.
diff --git a/mm/truncate.c b/mm/truncate.c
index d068f22fe422..e000402e817b 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -619,10 +619,7 @@ static int invalidate_complete_folio2(struct address_space *mapping,
 	__filemap_remove_folio(folio, NULL);
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 
-	if (mapping->a_ops->freepage)
-		mapping->a_ops->freepage(&folio->page);
-
-	folio_ref_sub(folio, folio_nr_pages(folio));	/* pagecache ref */
+	filemap_free_folio(mapping, folio);
 	return 1;
 failed:
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
-- 
2.30.2

