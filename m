Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE846C8430
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjCXSCc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjCXSCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836AC1ADF4;
        Fri, 24 Mar 2023 11:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qX773DXHpngVi8ieIBjRiMv4TcGKt612phEcB/GXHSc=; b=qtWbQ+fO2KVezdGN4e0kVk4lm3
        kgI2bTS/pP+OcQ+cpXcUUwWkOgiu1wvu0Cj5GrlSskIuOGo7fMUkhwykvBRkq9PvB18zRvqKgeqr4
        W/2KedWHgOJhRvDdht00WnlEFrZy6knK1FegvDjJ5/WWxUeA1ztyzNkjPz32rrzKleMOLWh9MFt7b
        rnFY2C8i6OxgJ3YLD4ssfAy6TLO+b89CFn8whlxWDx2TPjSq7Vdu+tMGvhUuosXyZkXHNhHHBdrVx
        WfVFkZDWLcI4tkGz2OUCJAfyOLyXQd9ZSNnbyQVTxtwZ9HE0zhWHA8gP1rQlTyIf4Rbdy+fTDjq/V
        AKB8CEHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljL-0057ZG-Lw; Fri, 24 Mar 2023 18:01:35 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 08/29] ext4: Convert ext4_bio_write_page() to ext4_bio_write_folio()
Date:   Fri, 24 Mar 2023 18:01:08 +0000
Message-Id: <20230324180129.1220691-9-willy@infradead.org>
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

The only caller now has a folio so pass it in directly and avoid the call
to page_folio() at the beginning.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ext4.h    |  5 ++---
 fs/ext4/inode.c   |  6 +++---
 fs/ext4/page-io.c | 10 ++++------
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9b2cfc32cf78..bee344ebd385 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3757,9 +3757,8 @@ extern void ext4_io_submit_init(struct ext4_io_submit *io,
 				struct writeback_control *wbc);
 extern void ext4_end_io_rsv_work(struct work_struct *work);
 extern void ext4_io_submit(struct ext4_io_submit *io);
-extern int ext4_bio_write_page(struct ext4_io_submit *io,
-			       struct page *page,
-			       int len);
+int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *page,
+		size_t len);
 extern struct ext4_io_end_vec *ext4_alloc_io_end_vec(ext4_io_end_t *io_end);
 extern struct ext4_io_end_vec *ext4_last_io_end_vec(ext4_io_end_t *io_end);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 801fdeffe2f9..4119c63c1215 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1885,8 +1885,8 @@ static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
 	 * write-protects our page in page tables and the page cannot get
 	 * written to again until we release folio lock. So only after
 	 * folio_clear_dirty_for_io() we are safe to sample i_size for
-	 * ext4_bio_write_page() to zero-out tail of the written page. We rely
-	 * on the barrier provided by TestClearPageDirty in
+	 * ext4_bio_write_folio() to zero-out tail of the written page. We rely
+	 * on the barrier provided by folio_test_clear_dirty() in
 	 * folio_clear_dirty_for_io() to make sure i_size is really sampled only
 	 * after page tables are updated.
 	 */
@@ -1895,7 +1895,7 @@ static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
 	if (folio_pos(folio) + len > size &&
 	    !ext4_verity_in_progress(mpd->inode))
 		len = size & ~PAGE_MASK;
-	err = ext4_bio_write_page(&mpd->io_submit, &folio->page, len);
+	err = ext4_bio_write_folio(&mpd->io_submit, folio, len);
 	if (!err)
 		mpd->wbc->nr_to_write--;
 
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index f0144ef39bb1..8fe1875b0a42 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -426,11 +426,9 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
 	io->io_next_block++;
 }
 
-int ext4_bio_write_page(struct ext4_io_submit *io,
-			struct page *page,
-			int len)
+int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *folio,
+		size_t len)
 {
-	struct folio *folio = page_folio(page);
 	struct folio *io_folio = folio;
 	struct inode *inode = folio->mapping->host;
 	unsigned block_start;
@@ -523,8 +521,8 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 		if (io->io_bio)
 			gfp_flags = GFP_NOWAIT | __GFP_NOWARN;
 	retry_encrypt:
-		bounce_page = fscrypt_encrypt_pagecache_blocks(page, enc_bytes,
-							       0, gfp_flags);
+		bounce_page = fscrypt_encrypt_pagecache_blocks(&folio->page,
+					enc_bytes, 0, gfp_flags);
 		if (IS_ERR(bounce_page)) {
 			ret = PTR_ERR(bounce_page);
 			if (ret == -ENOMEM &&
-- 
2.39.2

