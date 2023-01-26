Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C630967D65B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjAZUZa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjAZUYs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9DA61875;
        Thu, 26 Jan 2023 12:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0j9u/ZuPqTgqTR+4p+jCsICMT8bSmT1HNBvq/sPzFs8=; b=YFXGF/UdiPBrSYza7smljAWmsQ
        w1b2lnIV+YKTNXkPc3/D2A6n9qKz3R4pGwHj8p39k/7LTfoPhoGbV7Yb+74tDvwChMl9ILSZ1vly4
        XQj9d5LjxVqT5mkG3w7EidznxhlPk6H/yxd69ins0rqMEXs377qi4M/Fdjn6CE/FWGc+7sbJ90/kr
        dpHiJwhEpFVVPXOjS+dYHPo774KSNBZAKI3m5ekY4qquI62+gHrYXLZzYWDEAV2+meDElTN2Cz8cL
        bcgAhHfK/0EFPF2SdICONp/9Swesk78XON/bOIFSVpdsjVlq/0WHrgaK/cuijTcqn5c0C9naUHFNt
        b2tdeZmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nD-0073jY-2Q; Thu, 26 Jan 2023 20:24:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/31] ext4: Convert mpage_submit_page() to mpage_submit_folio()
Date:   Thu, 26 Jan 2023 20:23:51 +0000
Message-Id: <20230126202415.1682629-8-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230126202415.1682629-1-willy@infradead.org>
References: <20230126202415.1682629-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All callers now have a folio so we can pass one in and use the folio
APIs to support large folios as well as save instructions by eliminating
calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e8f2918fd854..8b91e325492f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2097,34 +2097,33 @@ static int ext4_writepage(struct page *page,
 	return ret;
 }
 
-static int mpage_submit_page(struct mpage_da_data *mpd, struct page *page)
+static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
 {
-	int len;
+	size_t len;
 	loff_t size;
 	int err;
 
-	BUG_ON(page->index != mpd->first_page);
-	clear_page_dirty_for_io(page);
+	BUG_ON(folio->index != mpd->first_page);
+	folio_clear_dirty_for_io(folio);
 	/*
 	 * We have to be very careful here!  Nothing protects writeback path
 	 * against i_size changes and the page can be writeably mapped into
 	 * page tables. So an application can be growing i_size and writing
-	 * data through mmap while writeback runs. clear_page_dirty_for_io()
+	 * data through mmap while writeback runs. folio_clear_dirty_for_io()
 	 * write-protects our page in page tables and the page cannot get
-	 * written to again until we release page lock. So only after
-	 * clear_page_dirty_for_io() we are safe to sample i_size for
+	 * written to again until we release folio lock. So only after
+	 * folio_clear_dirty_for_io() we are safe to sample i_size for
 	 * ext4_bio_write_page() to zero-out tail of the written page. We rely
 	 * on the barrier provided by TestClearPageDirty in
-	 * clear_page_dirty_for_io() to make sure i_size is really sampled only
+	 * folio_clear_dirty_for_io() to make sure i_size is really sampled only
 	 * after page tables are updated.
 	 */
 	size = i_size_read(mpd->inode);
-	if (page->index == size >> PAGE_SHIFT &&
+	len = folio_size(folio);
+	if (folio_pos(folio) + len > size &&
 	    !ext4_verity_in_progress(mpd->inode))
 		len = size & ~PAGE_MASK;
-	else
-		len = PAGE_SIZE;
-	err = ext4_bio_write_page(&mpd->io_submit, page, len);
+	err = ext4_bio_write_page(&mpd->io_submit, &folio->page, len);
 	if (!err)
 		mpd->wbc->nr_to_write--;
 	mpd->first_page++;
@@ -2238,7 +2237,7 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
 	} while (lblk++, (bh = bh->b_this_page) != head);
 	/* So far everything mapped? Submit the page for IO. */
 	if (mpd->map.m_len == 0) {
-		err = mpage_submit_page(mpd, head->b_page);
+		err = mpage_submit_folio(mpd, head->b_folio);
 		if (err < 0)
 			return err;
 	}
@@ -2370,7 +2369,7 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 			if (err < 0 || map_bh)
 				goto out;
 			/* Page fully mapped - let IO run! */
-			err = mpage_submit_page(mpd, &folio->page);
+			err = mpage_submit_folio(mpd, folio);
 			if (err < 0)
 				goto out;
 		}
@@ -2680,7 +2679,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			 */
 			if (!mpd->can_map) {
 				if (ext4_page_nomap_can_writeout(&folio->page)) {
-					err = mpage_submit_page(mpd, &folio->page);
+					err = mpage_submit_folio(mpd, folio);
 					if (err < 0)
 						goto out;
 				} else {
-- 
2.35.1

