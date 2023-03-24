Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E606C845F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjCXSDo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjCXSCZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A7F2109;
        Fri, 24 Mar 2023 11:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dgTcIWh3YHwS9Zzzpm2IYxG0r+61zgGwRJfw4x1fzp4=; b=dTK6YQ2B4dD6xh5eOHpGbcRnBR
        letDdgDrXeUTDB1zKtaVPAt2nRDa80EaizvuMt416ZPVk7XgQzAvgyuZkrI4fcIVNmhI6dhpOpPp/
        Cv1WslDZ8bRel5cNeoqctldb6SNVOtemTNqn/3pfhMbDJIqrHG2XGJrsOa+DoFOcXrm4NpO10zTVL
        Jh5Kf1F211/WDsPfESmrebEMr46BJcPIwfp6S3bw1iPzyoDLbFtpIuErha0QjzeFIddoDj4JmD7jQ
        KKz8pH/gzFI1E3VP3gsCdTzdUpkr6GZzltbp+yKw+tHJqqQnmqIuQ/QqyNQYPitsmtyHourP+qMe5
        sL76M9fA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljM-0057Zw-Ee; Fri, 24 Mar 2023 18:01:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 14/29] ext4: Convert ext4_read_inline_page() to ext4_read_inline_folio()
Date:   Fri, 24 Mar 2023 18:01:14 +0000
Message-Id: <20230324180129.1220691-15-willy@infradead.org>
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

All callers now have a folio, so pass it and use it.  The folio may
be large, although I doubt we'll want to use a large folio for an
inline file.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inline.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 2fa6c51baef9..4c819b6c70c1 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -467,16 +467,16 @@ static int ext4_destroy_inline_data_nolock(handle_t *handle,
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
@@ -489,12 +489,13 @@ static int ext4_read_inline_page(struct inode *inode, struct page *page)
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
@@ -516,7 +517,7 @@ int ext4_readpage_inline(struct inode *inode, struct folio *folio)
 	 * So for all the other pages, just set them uptodate.
 	 */
 	if (!folio->index)
-		ret = ext4_read_inline_page(inode, &folio->page);
+		ret = ext4_read_inline_folio(inode, folio);
 	else if (!folio_test_uptodate(folio)) {
 		folio_zero_segment(folio, 0, folio_size(folio));
 		folio_mark_uptodate(folio);
@@ -581,7 +582,7 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 	from = 0;
 	to = ext4_get_inline_size(inode);
 	if (!folio_test_uptodate(folio)) {
-		ret = ext4_read_inline_page(inode, &folio->page);
+		ret = ext4_read_inline_folio(inode, folio);
 		if (ret < 0)
 			goto out;
 	}
@@ -707,7 +708,7 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 	}
 
 	if (!folio_test_uptodate(folio)) {
-		ret = ext4_read_inline_page(inode, &folio->page);
+		ret = ext4_read_inline_folio(inode, folio);
 		if (ret < 0) {
 			folio_unlock(folio);
 			folio_put(folio);
@@ -864,7 +865,7 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 	inline_size = ext4_get_inline_size(inode);
 
 	if (!folio_test_uptodate(folio)) {
-		ret = ext4_read_inline_page(inode, &folio->page);
+		ret = ext4_read_inline_folio(inode, folio);
 		if (ret < 0)
 			goto out;
 	}
@@ -957,7 +958,7 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 	}
 
 	if (!folio_test_uptodate(folio)) {
-		ret = ext4_read_inline_page(inode, &folio->page);
+		ret = ext4_read_inline_folio(inode, folio);
 		if (ret < 0)
 			goto out_release_page;
 	}
-- 
2.39.2

