Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA364B5BE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 22:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiBNUxn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 15:53:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiBNUxZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:53:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AAFBCB9
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 12:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WiTgwCpZh0ndnEs8kOFecZ3IKCNlndjktFda8Uy2FQ4=; b=cgLtrHe6t3lzJEhQu6o8tGcEWn
        MGNgWNkU+hwutl44v8OGi/mQoehoPKDWAQsrAeDG9UuR7Bafa+8zsicuevAs8upv4tw4ndYWb9l7v
        HOrJ30mlA77DQj5AvuDr4mOGsrne7OVwYRRkJdLPv4qe8G/7rvVk8OaLPQjJEBLnzrTRSnMAtmyN0
        cImgIIw8dxzaFvn5k9TRZK6GkXnkaYkp62l07acmiyHjki2bxbPDbmeamzyEQE6inmahlnyBqoPjo
        UcGXpcsNInljX7wI8q3ExPjIoCT1z/MEcgXVk4FIAcKTz74Pq5xaBPG0XfUmLiIhsRSJ+7dP4updb
        8+yjxVLA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJhWF-00DDdU-C0; Mon, 14 Feb 2022 20:00:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 01/10] splice: Use a folio in page_cache_pipe_buf_try_steal()
Date:   Mon, 14 Feb 2022 20:00:08 +0000
Message-Id: <20220214200017.3150590-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220214200017.3150590-1-willy@infradead.org>
References: <20220214200017.3150590-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This saves a lot of calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/splice.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 5dbce4dcc1a7..23ff9c303abc 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -47,26 +47,27 @@ static bool page_cache_pipe_buf_try_steal(struct pipe_inode_info *pipe,
 		struct pipe_buffer *buf)
 {
 	struct page *page = buf->page;
+	struct folio *folio = page_folio(page);
 	struct address_space *mapping;
 
-	lock_page(page);
+	folio_lock(folio);
 
-	mapping = page_mapping(page);
+	mapping = folio_mapping(folio);
 	if (mapping) {
-		WARN_ON(!PageUptodate(page));
+		WARN_ON(!folio_test_uptodate(folio));
 
 		/*
 		 * At least for ext2 with nobh option, we need to wait on
-		 * writeback completing on this page, since we'll remove it
+		 * writeback completing on this folio, since we'll remove it
 		 * from the pagecache.  Otherwise truncate wont wait on the
-		 * page, allowing the disk blocks to be reused by someone else
+		 * folio, allowing the disk blocks to be reused by someone else
 		 * before we actually wrote our data to them. fs corruption
 		 * ensues.
 		 */
-		wait_on_page_writeback(page);
+		folio_wait_writeback(folio);
 
-		if (page_has_private(page) &&
-		    !try_to_release_page(page, GFP_KERNEL))
+		if (folio_has_private(folio) &&
+		    !filemap_release_folio(folio, GFP_KERNEL))
 			goto out_unlock;
 
 		/*
@@ -80,11 +81,11 @@ static bool page_cache_pipe_buf_try_steal(struct pipe_inode_info *pipe,
 	}
 
 	/*
-	 * Raced with truncate or failed to remove page from current
+	 * Raced with truncate or failed to remove folio from current
 	 * address space, unlock and return failure.
 	 */
 out_unlock:
-	unlock_page(page);
+	folio_unlock(folio);
 	return false;
 }
 
-- 
2.34.1

