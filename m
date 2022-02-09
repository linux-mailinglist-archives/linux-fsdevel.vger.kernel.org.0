Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1541E4AFE5E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiBIUXl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiBIUWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8028DE040DF6
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Pp1CvkihuRv3N5PqqV7vrAQRTFq1HPLPHbulkJQQeYc=; b=lKhEWDNomUPOzL2tzC3TuZ9sW+
        RRj7ZM2c3SrV+uqzm4tPv1+QnjdPcE7X9m9FB2yrdjY/Zd5Ki+TdP8iaQEpD12FDY+zZFjGGHSspU
        fWieyFgRsBJYYTY6gdUDuzzj5jwEqURj/ZFHZF6lYijNDq/9iDfDCEw9Hmd7S4QOnH8BOAIiUrFgJ
        IBcwp2xtjipddC9RVRatglU+4rWgLVlQg9nhazkJTx0DmL0QscHu3jPtPg0gL+Lgh95CzuqZLFgTJ
        /c7jGtcJ45LBVGAisvjQ8eFKgWHGwNLCPFWqnAQelNhGd6X5N4k8YNPgylU15C3no/rz12DGwGTKF
        +Nrdc+lQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTx-008cu1-OG; Wed, 09 Feb 2022 20:22:29 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 56/56] fs: Remove aops ->set_page_dirty
Date:   Wed,  9 Feb 2022 20:22:15 +0000
Message-Id: <20220209202215.2055748-57-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
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

With all implementations converted to ->dirty_folio, we can stop calling
this fallback method and remove it entirely.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ecryptfs/mmap.c  |  2 +-
 include/linux/fs.h  |  3 +--
 mm/page-writeback.c | 11 +++--------
 mm/page_io.c        |  4 +---
 4 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 9aabcb2f52e9..9ad61b582f07 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -540,7 +540,7 @@ const struct address_space_operations ecryptfs_aops = {
 	 * XXX: This is pretty broken for multiple reasons: ecryptfs does not
 	 * actually use buffer_heads, and ecryptfs will crash without
 	 * CONFIG_BLOCK.  But it matches the behavior before the default for
-	 * address_space_operations without the ->set_page_dirty method was
+	 * address_space_operations without the ->dirty_folio method was
 	 * cleaned up, so this is the best we can do without maintainer
 	 * feedback.
 	 */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c3d5db8851ae..b472d78f00b0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -367,8 +367,7 @@ struct address_space_operations {
 	/* Write back some dirty pages from this mapping. */
 	int (*writepages)(struct address_space *, struct writeback_control *);
 
-	/* Set a page dirty.  Return true if this dirtied it */
-	int (*set_page_dirty)(struct page *page);
+	/* Mark a folio dirty.  Return true if this dirtied it */
 	bool (*dirty_folio)(struct address_space *, struct folio *);
 
 	/*
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 4557a8d3dfea..0997738545dd 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2641,15 +2641,10 @@ bool folio_mark_dirty(struct folio *folio)
 		 */
 		if (folio_test_reclaim(folio))
 			folio_clear_reclaim(folio);
-		if (mapping->a_ops->dirty_folio)
-			return mapping->a_ops->dirty_folio(mapping, folio);
-		return mapping->a_ops->set_page_dirty(&folio->page);
+		return mapping->a_ops->dirty_folio(mapping, folio);
 	}
-	if (!folio_test_dirty(folio)) {
-		if (!folio_test_set_dirty(folio))
-			return true;
-	}
-	return false;
+
+	return noop_dirty_folio(mapping, folio);
 }
 EXPORT_SYMBOL(folio_mark_dirty);
 
diff --git a/mm/page_io.c b/mm/page_io.c
index e3333973335e..6bde053b9d9d 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -449,9 +449,7 @@ bool swap_dirty_folio(struct address_space *mapping, struct folio *folio)
 		aops = mapping->a_ops;
 
 		VM_BUG_ON_FOLIO(!folio_test_swapcache(folio), folio);
-		if (aops->dirty_folio)
-			return aops->dirty_folio(mapping, folio);
-		return aops->set_page_dirty(&folio->page);
+		return aops->dirty_folio(mapping, folio);
 	} else {
 		return noop_dirty_folio(mapping, folio);
 	}
-- 
2.34.1

