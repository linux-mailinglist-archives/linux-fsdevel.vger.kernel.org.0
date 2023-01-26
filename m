Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27C067D659
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjAZUZW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjAZUYs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB91B728FF;
        Thu, 26 Jan 2023 12:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=JdCYJMco6hlB0IW965/2KYMMtiwws4SrqZg6+IdXOU8=; b=HUNjVvUGuJx+0HAEp/2gLDOZxE
        RcmyaRg5NCoRNoGam7b35KkOKvSC5Qdkb72ViFg0SU7jLNu39v6X+HTLsv+yDGk71xOgfI5i92ZEV
        malEiNHT1QgcZTERKPVfyeoLvm3WByKh+iRk4XMv6+J08xNg0EhQv8YcZw8+jBYJB65M9+XARuQJQ
        wxVcMoXRyGs2bFAkTTUmv9WuEyZShRrJ5k0LRoZGGnXLZiCw7j8cnlUr2SI+IrDPMUrTpCPnyHo7o
        QTcTzgcQuMhphMdifrpTxSJmwA+nWAcaZRgWa5nHA5gTz/31B3FcTq7a3n2YySpfF2iahlPKAO+wi
        c/oc2scQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nC-0073jS-Pu; Thu, 26 Jan 2023 20:24:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/31] ext4: Convert ext4_finish_bio() to use folios
Date:   Thu, 26 Jan 2023 20:23:48 +0000
Message-Id: <20230126202415.1682629-5-willy@infradead.org>
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

Prepare ext4 to support large folios in the page writeback path.
Also set the actual error in the mapping, not just -EIO.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/page-io.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 982791050892..fd6c0dca24b9 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -99,30 +99,30 @@ static void buffer_io_error(struct buffer_head *bh)
 
 static void ext4_finish_bio(struct bio *bio)
 {
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
+	struct folio_iter fi;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
-		struct page *bounce_page = NULL;
+	bio_for_each_folio_all(fi, bio) {
+		struct folio *folio = fi.folio;
+		struct folio *io_folio = NULL;
 		struct buffer_head *bh, *head;
-		unsigned bio_start = bvec->bv_offset;
-		unsigned bio_end = bio_start + bvec->bv_len;
+		size_t bio_start = fi.offset;
+		size_t bio_end = bio_start + fi.length;
 		unsigned under_io = 0;
 		unsigned long flags;
 
-		if (fscrypt_is_bounce_page(page)) {
-			bounce_page = page;
-			page = fscrypt_pagecache_page(bounce_page);
+		if (fscrypt_is_bounce_folio(folio)) {
+			io_folio = folio;
+			folio = fscrypt_pagecache_folio(folio);
 		}
 
 		if (bio->bi_status) {
-			SetPageError(page);
-			mapping_set_error(page->mapping, -EIO);
+			int err = blk_status_to_errno(bio->bi_status);
+			folio_set_error(folio);
+			mapping_set_error(folio->mapping, err);
 		}
-		bh = head = page_buffers(page);
+		bh = head = folio_buffers(folio);
 		/*
-		 * We check all buffers in the page under b_uptodate_lock
+		 * We check all buffers in the folio under b_uptodate_lock
 		 * to avoid races with other end io clearing async_write flags
 		 */
 		spin_lock_irqsave(&head->b_uptodate_lock, flags);
@@ -141,8 +141,8 @@ static void ext4_finish_bio(struct bio *bio)
 		} while ((bh = bh->b_this_page) != head);
 		spin_unlock_irqrestore(&head->b_uptodate_lock, flags);
 		if (!under_io) {
-			fscrypt_free_bounce_page(bounce_page);
-			end_page_writeback(page);
+			fscrypt_free_bounce_page(&io_folio->page);
+			folio_end_writeback(folio);
 		}
 	}
 }
-- 
2.35.1

