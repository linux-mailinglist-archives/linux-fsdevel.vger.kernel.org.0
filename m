Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798D167D62E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjAZUYb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbjAZUYX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6649B4996E;
        Thu, 26 Jan 2023 12:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GVHnYKlWroCQt1vq8X/m3nZwxtJ1hxutRRN2IluE1Lg=; b=mxtrTwwQ5buP+bfuGhkgVjul+B
        /VRyWhbjZHbI4t85AOAoogW01ETn5DdJqSQcsjvMdcnDlT0q2E5zrfeFBgSLrVKORuN6Dhxg/z+PM
        ToCki5mZ8vPVQnzZ281NOi8b4nUpWsIPApVjoHx+UQCBhUPMi2Fx08fEVhAXKQpqPna9deBBvWNK2
        DLM2/rUbD+GWlaZ1vRmptpJs90gOvWduV5aRNg+ht4+DMigp6dIFwxBuCGJbYnN1f5qpsrC4vOgsY
        I/+UW87dI51snV8SZu0EMQUMf0n+Q1/EZMGp9pRV+BlQMZ/B9o0ywe5M4PAwNVsYdSA6dQenYq+Dd
        /7b0+iGg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nD-0073k5-OJ; Thu, 26 Jan 2023 20:24:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/31] ext4: Convert ext4_da_write_inline_data_begin() to use a folio
Date:   Thu, 26 Jan 2023 20:23:57 +0000
Message-Id: <20230126202415.1682629-14-willy@infradead.org>
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

Saves a number of calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inline.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 99c77dd519f0..b8e22348dad2 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -910,10 +910,9 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 {
 	int ret;
 	handle_t *handle;
-	struct page *page;
+	struct folio *folio;
 	struct ext4_iloc iloc;
 	int retries = 0;
-	unsigned int flags;
 
 	ret = ext4_get_inode_loc(inode, &iloc);
 	if (ret)
@@ -945,10 +944,9 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 	 * We cannot recurse into the filesystem as the transaction
 	 * is already started.
 	 */
-	flags = memalloc_nofs_save();
-	page = grab_cache_page_write_begin(mapping, 0);
-	memalloc_nofs_restore(flags);
-	if (!page) {
+	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
+					mapping_gfp_mask(mapping));
+	if (!folio) {
 		ret = -ENOMEM;
 		goto out_journal;
 	}
@@ -959,8 +957,8 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 		goto out_release_page;
 	}
 
-	if (!PageUptodate(page)) {
-		ret = ext4_read_inline_page(inode, page);
+	if (!folio_test_uptodate(folio)) {
+		ret = ext4_read_inline_page(inode, &folio->page);
 		if (ret < 0)
 			goto out_release_page;
 	}
@@ -970,13 +968,13 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 		goto out_release_page;
 
 	up_read(&EXT4_I(inode)->xattr_sem);
-	*pagep = page;
+	*pagep = &folio->page;
 	brelse(iloc.bh);
 	return 1;
 out_release_page:
 	up_read(&EXT4_I(inode)->xattr_sem);
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 out_journal:
 	ext4_journal_stop(handle);
 out:
-- 
2.35.1

