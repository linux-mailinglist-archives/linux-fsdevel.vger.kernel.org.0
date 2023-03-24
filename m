Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA206C8444
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjCXSDJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjCXSCT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BE11E1E1;
        Fri, 24 Mar 2023 11:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=P9ibJkeUthI44ZenmUELPb5YMrgRPR94Wi1/9fwNzOc=; b=fTj6ebnk0HDRI1qiZAciucu1kq
        49kKAhUn3ZaBiO8KnlMrrwOXAgaYzmgCNz+zW7XWj7sdJdUbmDRxYvIIaDwuP2oFwRxGsTvsWVIca
        ShZMO4ibYDJ6YH7iVq9uXHqVZN6S/VX9lnu8N44VfwoJbcdPLU1npUBfsDUt7LAgqofZZ3bLQJ+LB
        MhVwPiSJny1LJIghebFj8rWNzgrLVJEcp6SzaEumpLr2FRoQLpER27v48B0ieVZ5xDRAYMxjd3W5S
        TrGY9MknZ796fBDKmVZ7LSZj3fzaoqosbvp3OqFex6E4wuhMNGZvuH9vZpWKE9VXn6ay8CHZPDE3f
        5dpOXA7A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljL-0057ZY-U8; Fri, 24 Mar 2023 18:01:35 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 10/29] ext4: Convert ext4_convert_inline_data_to_extent() to use a folio
Date:   Fri, 24 Mar 2023 18:01:10 +0000
Message-Id: <20230324180129.1220691-11-willy@infradead.org>
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

Saves a number of calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inline.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index e9bae3002319..f339340ba66c 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -534,8 +534,7 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 	int ret, needed_blocks, no_expand;
 	handle_t *handle = NULL;
 	int retries = 0, sem_held = 0;
-	struct page *page = NULL;
-	unsigned int flags;
+	struct folio *folio = NULL;
 	unsigned from, to;
 	struct ext4_iloc iloc;
 
@@ -564,10 +563,9 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 
 	/* We cannot recurse into the filesystem as the transaction is already
 	 * started */
-	flags = memalloc_nofs_save();
-	page = grab_cache_page_write_begin(mapping, 0);
-	memalloc_nofs_restore(flags);
-	if (!page) {
+	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
+			mapping_gfp_mask(mapping));
+	if (!folio) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -582,8 +580,8 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 
 	from = 0;
 	to = ext4_get_inline_size(inode);
-	if (!PageUptodate(page)) {
-		ret = ext4_read_inline_page(inode, page);
+	if (!folio_test_uptodate(folio)) {
+		ret = ext4_read_inline_page(inode, &folio->page);
 		if (ret < 0)
 			goto out;
 	}
@@ -593,21 +591,21 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 		goto out;
 
 	if (ext4_should_dioread_nolock(inode)) {
-		ret = __block_write_begin(page, from, to,
+		ret = __block_write_begin(&folio->page, from, to,
 					  ext4_get_block_unwritten);
 	} else
-		ret = __block_write_begin(page, from, to, ext4_get_block);
+		ret = __block_write_begin(&folio->page, from, to, ext4_get_block);
 
 	if (!ret && ext4_should_journal_data(inode)) {
-		ret = ext4_walk_page_buffers(handle, inode, page_buffers(page),
-					     from, to, NULL,
-					     do_journal_get_write_access);
+		ret = ext4_walk_page_buffers(handle, inode,
+					     folio_buffers(folio), from, to,
+					     NULL, do_journal_get_write_access);
 	}
 
 	if (ret) {
-		unlock_page(page);
-		put_page(page);
-		page = NULL;
+		folio_unlock(folio);
+		folio_put(folio);
+		folio = NULL;
 		ext4_orphan_add(handle, inode);
 		ext4_write_unlock_xattr(inode, &no_expand);
 		sem_held = 0;
@@ -627,12 +625,12 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
 		goto retry;
 
-	if (page)
-		block_commit_write(page, from, to);
+	if (folio)
+		block_commit_write(&folio->page, from, to);
 out:
-	if (page) {
-		unlock_page(page);
-		put_page(page);
+	if (folio) {
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 	if (sem_held)
 		ext4_write_unlock_xattr(inode, &no_expand);
-- 
2.39.2

