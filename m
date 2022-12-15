Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CF864E371
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 22:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiLOVoW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 16:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiLOVoE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:44:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2314A5C76A
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 13:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VpMOH9i1GJ3y+J8KYvAq+MfLKoGEueDMKAxxqvP3xO0=; b=jjk01CIdcLM+3Ex+uHmCyJB2Zh
        NVWAL7xHdU3C234UKwjnP7tO4OfPasmTpCFyK7z9ScUWvSQpvhPUtQMYrHGaSiLGsW/V+gYvKlyJ7
        QR3qQDJTKsqEipqrhSjKmvX/hkQuXY//Jt6JU7ebuKaexerp1SA6+G7ZsoqQFE8+VTujtfpMdMYaz
        MCD5YvL47a0LfOOz3NNRp+h6a0riEn32NV4ZwRTJ5EeBHnDGVSnHPUh5Za7RuPKFirTKTvQFFqvce
        K/3byhXk72EWN6Hf7/7o14mSnkNIGgsKTXV3LC+vwi59g3mBOvqusDgsIyQ/6019X5YxlKSSWc+p9
        MY0fEfHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5w1P-00EmM4-Gk; Thu, 15 Dec 2022 21:44:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/12] jbd2: Replace obvious uses of b_page with b_folio
Date:   Thu, 15 Dec 2022 21:43:59 +0000
Message-Id: <20221215214402.3522366-10-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221215214402.3522366-1-willy@infradead.org>
References: <20221215214402.3522366-1-willy@infradead.org>
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

These places just use b_page to get to the buffer's address_space
or have already been converted to folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jbd2/commit.c  | 8 ++------
 fs/jbd2/journal.c | 2 +-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 4810438b7856..96a1ebc6342d 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -63,16 +63,12 @@ static void journal_end_buffer_io_sync(struct buffer_head *bh, int uptodate)
 static void release_buffer_page(struct buffer_head *bh)
 {
 	struct folio *folio;
-	struct page *page;
 
 	if (buffer_dirty(bh))
 		goto nope;
 	if (atomic_read(&bh->b_count) != 1)
 		goto nope;
-	page = bh->b_page;
-	if (!page)
-		goto nope;
-	folio = page_folio(page);
+	folio = bh->b_folio;
 	if (folio->mapping)
 		goto nope;
 
@@ -1040,7 +1036,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 			 * already detached from the mapping and buffers cannot
 			 * get reused.
 			 */
-			mapping = READ_ONCE(bh->b_page->mapping);
+			mapping = READ_ONCE(bh->b_folio->mapping);
 			if (mapping && !sb_is_blkdev_sb(mapping->host->i_sb)) {
 				clear_buffer_mapped(bh);
 				clear_buffer_new(bh);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 2696f43e7239..4095fe91457f 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2938,7 +2938,7 @@ struct journal_head *jbd2_journal_add_journal_head(struct buffer_head *bh)
 	} else {
 		J_ASSERT_BH(bh,
 			(atomic_read(&bh->b_count) > 0) ||
-			(bh->b_page && bh->b_page->mapping));
+			(bh->b_folio && bh->b_folio->mapping));
 
 		if (!new_jh) {
 			jbd_unlock_bh_journal_head(bh);
-- 
2.35.1

