Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C691782B43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 16:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjHUONe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 10:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbjHUONd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:13:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F2BDB
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 07:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=iDYtXrPZX033/zHSRTP1tUix4LwCTyrp9ah8ubAhoKA=; b=DoXzNDUo4Yp45ozdFtkiFnrKtI
        m2cQqcn+Off6in5ew2GzbwTWDJ7xbdshepzl88uu+SRREf8z92l/0cUpBS1ZP/rvJCyJiwTHh+hur
        pYXlF7fwOImLAy3gyoSWi9aU27F5opGEw/RS5YsPe5eQj2T1xEURp6Bt8BVv80MN/ib7mo8YCKjko
        ZSxiIhfZLaYokt9PiNw35fDmTXzc8XuYdFRaFICuRFvirLF3o7icexSOaDyetygsx143RiFDUDFNf
        Tr0cH5Nlb0Nzd2KtMUjxEFboBNOKFMqcEVZcJ37+BG4u4eqjYk/PFxTuMFiqnbO5U/dw9By74gghl
        dDxN2f7A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qY5er-00Adaj-BO; Mon, 21 Aug 2023 14:13:29 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] libfs: Convert simple_write_begin and simple_write_end to use a folio
Date:   Mon, 21 Aug 2023 15:13:22 +0100
Message-Id: <20230821141322.2535459-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove a number of implicit calls to compound_head() and various calls
to compatibility functions.  This is not sufficient to enable support
for large folios; generic_perform_write() must be converted first.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/libfs.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index dcdcc292bf2b..da78eb64831e 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -815,21 +815,20 @@ int simple_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata)
 {
-	struct page *page;
-	pgoff_t index;
+	struct folio *folio;
 
-	index = pos >> PAGE_SHIFT;
+	folio = __filemap_get_folio(mapping, pos / PAGE_SIZE, FGP_WRITEBEGIN,
+			mapping_gfp_mask(mapping));
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
 
-	page = grab_cache_page_write_begin(mapping, index);
-	if (!page)
-		return -ENOMEM;
-
-	*pagep = page;
+	*pagep = &folio->page;
 
-	if (!PageUptodate(page) && (len != PAGE_SIZE)) {
-		unsigned from = pos & (PAGE_SIZE - 1);
+	if (!folio_test_uptodate(folio) && (len != folio_size(folio))) {
+		size_t from = offset_in_folio(folio, pos);
 
-		zero_user_segments(page, 0, from, from + len, PAGE_SIZE);
+		folio_zero_segments(folio, 0, from,
+				from + len, folio_size(folio));
 	}
 	return 0;
 }
@@ -861,17 +860,18 @@ static int simple_write_end(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
 			struct page *page, void *fsdata)
 {
-	struct inode *inode = page->mapping->host;
+	struct folio *folio = page_folio(page);
+	struct inode *inode = folio->mapping->host;
 	loff_t last_pos = pos + copied;
 
-	/* zero the stale part of the page if we did a short copy */
-	if (!PageUptodate(page)) {
+	/* zero the stale part of the folio if we did a short copy */
+	if (!folio_test_uptodate(folio)) {
 		if (copied < len) {
-			unsigned from = pos & (PAGE_SIZE - 1);
+			size_t from = offset_in_folio(folio, pos);
 
-			zero_user(page, from + copied, len - copied);
+			folio_zero_range(folio, from + copied, len - copied);
 		}
-		SetPageUptodate(page);
+		folio_mark_uptodate(folio);
 	}
 	/*
 	 * No need to use i_size_read() here, the i_size
@@ -880,9 +880,9 @@ static int simple_write_end(struct file *file, struct address_space *mapping,
 	if (last_pos > inode->i_size)
 		i_size_write(inode, last_pos);
 
-	set_page_dirty(page);
-	unlock_page(page);
-	put_page(page);
+	folio_mark_dirty(folio);
+	folio_unlock(folio);
+	folio_put(folio);
 
 	return copied;
 }
-- 
2.40.1

