Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC18067D62B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjAZUY3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjAZUYY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F724B19E;
        Thu, 26 Jan 2023 12:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=QEa1GRU5rQ0cClZFzZmq/IyyK2MNca1Te7OmO60R5o0=; b=jC/vEvNN4HP6Uz5Q4GcthvG8jm
        voc3/dWff+or/c9BtIAX/vV7Tzue8PPz00VevT6rITLlkFmk1h1v1Rv2yRj6vMnN9wBW3IOW6oevf
        OLqinqfbgF0ShTd0/fYeMQo02jndn+bYiCpMZSn41a5MC5MeHzabKJyXWnb26gxw+DjqkB2iFLY4Y
        tjxOPai2sCA20syQy3W7CaTpaCHT5iGpExpmYLYIyW9PzyZEXQMyttfi0vvD3GV1gO+dI/V7Liwb+
        f9tYp0ZVs+k+BMS7OYKrP8XZU7AKkVoIRPb2+1JWNhCEm9IQqYYbleUq+FFjB6PlsveKlBZn/qOp2
        BMANa1Hw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nD-0073kB-Rn; Thu, 26 Jan 2023 20:24:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/31] ext4: Convert ext4_read_inline_page() to ext4_read_inline_folio()
Date:   Thu, 26 Jan 2023 20:23:58 +0000
Message-Id: <20230126202415.1682629-15-willy@infradead.org>
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

All callers now have a folio, so pass it and use it.  The folio may
be large, although I doubt we'll want to use a large folio for an
inline file.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inline.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index b8e22348dad2..29294caa20a1 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -468,16 +468,16 @@ static int ext4_destroy_inline_data_nolock(handle_t *handle,
 	return error;
 }
 
-static int ext4_read_inline_page(struct inode *inode, struct page *page)
+static int ext4_read_inline_folio(struct inode *inode, struct folio *folio)
 {
 	void *kaddr;
 	int ret = 0;
 	size_t len;
 	struct ext4_iloc iloc;
 
-	BUG_ON(!PageLocked(page));
+	BUG_ON(!folio_test_locked(folio));
 	BUG_ON(!ext4_has_inline_data(inode));
-	BUG_ON(page->index);
+	BUG_ON(folio->index);
 
 	if (!EXT4_I(inode)->i_inline_off) {
 		ext4_warning(inode->i_sb, "inode %lu doesn't have inline data.",
@@ -490,12 +490,13 @@ static int ext4_read_inline_page(struct inode *inode, struct page *page)
 		goto out;
 
 	len = min_t(size_t, ext4_get_inline_size(inode), i_size_read(inode));
-	kaddr = kmap_atomic(page);
+	BUG_ON(len > PAGE_SIZE);
+	kaddr = kmap_local_folio(folio, 0);
 	ret = ext4_read_inline_data(inode, kaddr, len, &iloc);
-	flush_dcache_page(page);
-	kunmap_atomic(kaddr);
-	zero_user_segment(page, len, PAGE_SIZE);
-	SetPageUptodate(page);
+	flush_dcache_folio(folio);
+	kunmap_local(kaddr);
+	folio_zero_segment(folio, len, folio_size(folio));
+	folio_mark_uptodate(folio);
 	brelse(iloc.bh);
 
 out:
@@ -517,7 +518,7 @@ int ext4_readpage_inline(struct inode *inode, struct folio *folio)
 	 * So for all the other pages, just set them uptodate.
 	 */
 	if (!folio->index)
-		ret = ext4_read_inline_page(inode, &folio->page);
+		ret = ext4_read_inline_folio(inode, folio);
 	else if (!folio_test_uptodate(folio)) {
 		folio_zero_segment(folio, 0, PAGE_SIZE);
 		folio_mark_uptodate(folio);
@@ -582,7 +583,7 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 	from = 0;
 	to = ext4_get_inline_size(inode);
 	if (!folio_test_uptodate(folio)) {
-		ret = ext4_read_inline_page(inode, &folio->page);
+		ret = ext4_read_inline_folio(inode, folio);
 		if (ret < 0)
 			goto out;
 	}
@@ -708,7 +709,7 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 	}
 
 	if (!folio_test_uptodate(folio)) {
-		ret = ext4_read_inline_page(inode, &folio->page);
+		ret = ext4_read_inline_folio(inode, folio);
 		if (ret < 0) {
 			folio_unlock(folio);
 			folio_put(folio);
@@ -865,7 +866,7 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 	inline_size = ext4_get_inline_size(inode);
 
 	if (!folio_test_uptodate(folio)) {
-		ret = ext4_read_inline_page(inode, &folio->page);
+		ret = ext4_read_inline_folio(inode, folio);
 		if (ret < 0)
 			goto out;
 	}
@@ -958,7 +959,7 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 	}
 
 	if (!folio_test_uptodate(folio)) {
-		ret = ext4_read_inline_page(inode, &folio->page);
+		ret = ext4_read_inline_folio(inode, folio);
 		if (ret < 0)
 			goto out_release_page;
 	}
-- 
2.35.1

