Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6FB67D63D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjAZUYi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbjAZUYY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4EB49954;
        Thu, 26 Jan 2023 12:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bUmnptUoiyyV9s9VNe8+i6VzP5JZO1CccQPGrLeqfzk=; b=Or9xS/22gf8YWDIrqz0fC3yypQ
        /cHKtRkxj4qpPiQJd1xbokNjr3oTeMUuhLaXM+KW6Yq2ofUQ14fY+an9D7gRIZ+r/s3Pq1o2YDKBu
        LBmx/FZ7nMmyLg8nlR+sVY4lISirQ1/hO2XEeLW/s4o/p6t2kddlxXwShyemrpJTn+tJbwYknKIWT
        e1bFyvQgLa7HCA18CvVvhTMHaddiQ0B6LrIN4Y4zo+n96ZrhN9kfDL3nNN9yV34l18FVibiR68i1d
        icliu7WbOwpCfbLoAtNHEBxBYWLI20/uXhEITYsnOHDXztfRBkqDn4Yie7btkXUBeoW9lNGsTHYwN
        ri0jxJIw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nE-0073lD-Vu; Thu, 26 Jan 2023 20:24:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 23/31] ext4: Use a folio in ext4_da_write_begin()
Date:   Thu, 26 Jan 2023 20:24:07 +0000
Message-Id: <20230126202415.1682629-24-willy@infradead.org>
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

Remove a few calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e7e8f2946012..8929add6808a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3046,7 +3046,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 			       struct page **pagep, void **fsdata)
 {
 	int ret, retries = 0;
-	struct page *page;
+	struct folio *folio;
 	pgoff_t index;
 	struct inode *inode = mapping->host;
 
@@ -3073,22 +3073,23 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	}
 
 retry:
-	page = grab_cache_page_write_begin(mapping, index);
-	if (!page)
+	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+			mapping_gfp_mask(mapping));
+	if (!folio)
 		return -ENOMEM;
 
-	/* In case writeback began while the page was unlocked */
-	wait_for_stable_page(page);
+	/* In case writeback began while the folio was unlocked */
+	folio_wait_stable(folio);
 
 #ifdef CONFIG_FS_ENCRYPTION
-	ret = ext4_block_write_begin(page, pos, len,
+	ret = ext4_block_write_begin(&folio->page, pos, len,
 				     ext4_da_get_block_prep);
 #else
-	ret = __block_write_begin(page, pos, len, ext4_da_get_block_prep);
+	ret = __block_write_begin(&folio->page, pos, len, ext4_da_get_block_prep);
 #endif
 	if (ret < 0) {
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 		/*
 		 * block_write_begin may have instantiated a few blocks
 		 * outside i_size.  Trim these off again. Don't need
@@ -3103,7 +3104,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 		return ret;
 	}
 
-	*pagep = page;
+	*pagep = &folio->page;
 	return ret;
 }
 
-- 
2.35.1

