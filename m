Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE2053DDE4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 21:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346839AbiFETjD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 15:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiFETjC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 15:39:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACF865F8;
        Sun,  5 Jun 2022 12:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7zHJFf7s+ZSx87nHg6Bs72jjNt/zTHbg4PZc0KhFNBI=; b=EYXV63i9/CEOzD0nHMe1OQHYDc
        mVCuEz0iq05DzWOTfwUUXon7lLclyJcGJZDFVFf36KaefdWNV0pHzAWE/juTBOh3LmOa6/GHAbwsA
        j9SKPw7wOEy++DynzZkxdw6cKJT5aOgxtQMtWaAQNIKZNtcW6JUvraw6AebVxfjYl0uWLN4Tnkrf1
        g5r1qFvxh5lUydZ/EqFXJtmm4X6GU4Pvr6z+zZzlpoy3rKdSu3dVWHKmxHNTzyLs4u7zgx7YRImNZ
        s12tQFfwrO2lznSTczeoD//K1wj12QguV4NYS7DRw7Y1XFPPUFJTnVvqq+s0OPozePCioZdM8Nwv2
        JJEs8DoA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nxw5Q-009wsT-OG; Sun, 05 Jun 2022 19:38:56 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-nilfs@vger.kernel.org
Subject: [PATCH 03/10] ext4: Convert mpage_release_unused_pages() to use filemap_get_folios()
Date:   Sun,  5 Jun 2022 20:38:47 +0100
Message-Id: <20220605193854.2371230-4-willy@infradead.org>
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

If the folio is large, it may overlap the beginning or end of the
unused range.  If it does, we need to avoid invalidating it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3dce7d058985..32a7f5e024d6 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1554,9 +1554,9 @@ struct mpage_da_data {
 static void mpage_release_unused_pages(struct mpage_da_data *mpd,
 				       bool invalidate)
 {
-	int nr_pages, i;
+	unsigned nr, i;
 	pgoff_t index, end;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	struct inode *inode = mpd->inode;
 	struct address_space *mapping = inode->i_mapping;
 
@@ -1574,15 +1574,18 @@ static void mpage_release_unused_pages(struct mpage_da_data *mpd,
 		ext4_es_remove_extent(inode, start, last - start + 1);
 	}
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	while (index <= end) {
-		nr_pages = pagevec_lookup_range(&pvec, mapping, &index, end);
-		if (nr_pages == 0)
+		nr = filemap_get_folios(mapping, &index, end, &fbatch);
+		if (nr == 0)
 			break;
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
-			struct folio *folio = page_folio(page);
+		for (i = 0; i < nr; i++) {
+			struct folio *folio = fbatch.folios[i];
 
+			if (folio->index < mpd->first_page)
+				continue;
+			if (folio->index + folio_nr_pages(folio) - 1 > end)
+				continue;
 			BUG_ON(!folio_test_locked(folio));
 			BUG_ON(folio_test_writeback(folio));
 			if (invalidate) {
@@ -1594,7 +1597,7 @@ static void mpage_release_unused_pages(struct mpage_da_data *mpd,
 			}
 			folio_unlock(folio);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 	}
 }
 
-- 
2.35.1

