Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E8E6C8445
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjCXSDK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjCXSCU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03D41E286;
        Fri, 24 Mar 2023 11:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7jz40SKRFjsowi6aqXryqxBjjtztSPeKPFj+lCS8n/8=; b=b/ewGee1brjn2GIOJqmYLF6X7U
        8iyRZggHM2u9r7oaw3WBrbUYF7PKiKT7A2A+zW2Gdb4B8GM25RHKQylBgv2DfNcQoLgyvTX33CjUk
        s3O6GlRYeDANpIwxyplJtBbjB66ZQ5k1l/IQnAsQ/UmU8G70HiJwWxMJbSpgg17Lfk8e+b9N58MER
        5SegDu6jQBx/y0zdqaLXwBi3YP6/sOCDKj1R5gD6T3YeHEGbImBD4xVuvYPTMgNWGwZTX4XyyH2nI
        s+8a/dYRhxalmT9AYLLVFsceKQ/yMYgmDuRqKtHLQTht/GW2H0j5ZVGSWxraTbOafJ9GpngxwjcUz
        C5KU9Q8w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljL-0057Z1-DF; Fri, 24 Mar 2023 18:01:35 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 06/29] ext4: Convert mpage_submit_page() to mpage_submit_folio()
Date:   Fri, 24 Mar 2023 18:01:06 +0000
Message-Id: <20230324180129.1220691-7-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230324180129.1220691-1-willy@infradead.org>
References: <20230324180129.1220691-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All callers now have a folio so we can pass one in and use the folio
APIs to support large folios as well as save instructions by eliminating
calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inode.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f8c02e55fbe3..8f482032d501 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1869,34 +1869,33 @@ static void mpage_page_done(struct mpage_da_data *mpd, struct page *page)
 	unlock_page(page);
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
 
@@ -2009,7 +2008,7 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
 	} while (lblk++, (bh = bh->b_this_page) != head);
 	/* So far everything mapped? Submit the page for IO. */
 	if (mpd->map.m_len == 0) {
-		err = mpage_submit_page(mpd, head->b_page);
+		err = mpage_submit_folio(mpd, head->b_folio);
 		if (err < 0)
 			return err;
 		mpage_page_done(mpd, head->b_page);
@@ -2142,7 +2141,7 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 			if (err < 0 || map_bh)
 				goto out;
 			/* Page fully mapped - let IO run! */
-			err = mpage_submit_page(mpd, &folio->page);
+			err = mpage_submit_folio(mpd, folio);
 			if (err < 0)
 				goto out;
 			mpage_page_done(mpd, &folio->page);
@@ -2532,12 +2531,12 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 				if (ext4_page_nomap_can_writeout(&folio->page)) {
 					WARN_ON_ONCE(sb->s_writers.frozen ==
 						     SB_FREEZE_COMPLETE);
-					err = mpage_submit_page(mpd, &folio->page);
+					err = mpage_submit_folio(mpd, folio);
 					if (err < 0)
 						goto out;
 				}
 				/* Pending dirtying of journalled data? */
-				if (PageChecked(&folio->page)) {
+				if (folio_test_checked(folio)) {
 					WARN_ON_ONCE(sb->s_writers.frozen >=
 						     SB_FREEZE_FS);
 					err = mpage_journal_page_buffers(handle,
-- 
2.39.2

