Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04306C8442
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjCXSDI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjCXSCT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C4B1DBB4;
        Fri, 24 Mar 2023 11:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XZo0De81T2dQE7D9eCZ6Mf4v87jwXmqiYDQUera2jp4=; b=Sl6xbNEIouzza83Z7mJLCHqpk7
        yOoN1klYcpLdoHb2cgT9EBfxF8b8rNWThh5GewByd0LGTQog7v46ez+fB9GmEmHueIUW1ysmfzHTO
        04tpGIQkpmenrwGmD0dXfaW+5pNvuYGnkhJDYVJ2NS7hupLUFvXFeV5bG0gwH5HQLNZYk3HRXW9R/
        76uchhzCvl491K5UHkMNTbf3AW0eU+2kE7n4607eWSqLbBNGda7JO70Ajh8OXgteIudH2ro9LnHD6
        b3wGTncBEHe20WWfSCXYm8Rz0MQ1+sLHxXjZf22JjaArB3t6QYvBxdq9RAA4wvEj9EQhjdVOcI3hM
        b03B1WiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljL-0057Yv-5A; Fri, 24 Mar 2023 18:01:35 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v2 04/29] ext4: Convert ext4_finish_bio() to use folios
Date:   Fri, 24 Mar 2023 18:01:04 +0000
Message-Id: <20230324180129.1220691-5-willy@infradead.org>
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

Prepare ext4 to support large folios in the page writeback path.
Also set the actual error in the mapping, not just -EIO.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/page-io.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 7850d2cb2e08..f0144ef39bb1 100644
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
2.39.2

