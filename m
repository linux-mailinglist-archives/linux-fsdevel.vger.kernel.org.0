Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0D353DE17
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 21:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239254AbiFETjy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 15:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351659AbiFETjo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 15:39:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967844DF47;
        Sun,  5 Jun 2022 12:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4+VTXobun92H06BwkM9sboSswxKOXWma+MeYkEepBgA=; b=RQCVcbFFYG/IwPkZ92IOtlvbMm
        az7RIzZuEXd7sNL2U7G8LPCRngD4SynAZcKmm6Z95io0HrbGL0vnB7fjGo7Cxu4ZBw1ODBrU0UG2e
        HxKcshRvctwxq6I6s6/MK32FsYRAC2G0u/Hip2HcdGDzdI618anISANI/MA2khqP9eLitiytzdMDB
        ct6KPLFs4aDjPFKc8Pkgohr+9RyESHl2CJp7vIumKABXwMvMmL913gy1dYEy+Y+5rn3L6A6SydWN3
        3u72ARdSAix5xot7Gj5q+zC981acWBZoknB7PiY9jRjVbOJiq7giOgLEaPV78mOWST9iLtfFjKdrU
        TBXjCXKw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nxw5Q-009wsX-Tg; Sun, 05 Jun 2022 19:38:56 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-nilfs@vger.kernel.org
Subject: [PATCH 05/10] f2fs: Convert f2fs_invalidate_compress_pages() to use filemap_get_folios()
Date:   Sun,  5 Jun 2022 20:38:49 +0100
Message-Id: <20220605193854.2371230-6-willy@infradead.org>
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

Convert this function to use folios throughout.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/compress.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 24824cd96f36..009e6c519e98 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1832,45 +1832,40 @@ bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
 void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi, nid_t ino)
 {
 	struct address_space *mapping = sbi->compress_inode->i_mapping;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	pgoff_t index = 0;
 	pgoff_t end = MAX_BLKADDR(sbi);
 
 	if (!mapping->nrpages)
 		return;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 
 	do {
-		unsigned int nr_pages;
-		int i;
+		unsigned int nr, i;
 
-		nr_pages = pagevec_lookup_range(&pvec, mapping,
-						&index, end - 1);
-		if (!nr_pages)
+		nr = filemap_get_folios(mapping, &index, end - 1, &fbatch);
+		if (!nr)
 			break;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
-
-			if (page->index > end)
-				break;
+		for (i = 0; i < nr; i++) {
+			struct folio *folio = fbatch.folios[i];
 
-			lock_page(page);
-			if (page->mapping != mapping) {
-				unlock_page(page);
+			folio_lock(folio);
+			if (folio->mapping != mapping) {
+				folio_unlock(folio);
 				continue;
 			}
 
-			if (ino != get_page_private_data(page)) {
-				unlock_page(page);
+			if (ino != get_page_private_data(&folio->page)) {
+				folio_unlock(folio);
 				continue;
 			}
 
-			generic_error_remove_page(mapping, page);
-			unlock_page(page);
+			generic_error_remove_page(mapping, &folio->page);
+			folio_unlock(folio);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	} while (index < end);
 }
-- 
2.35.1

