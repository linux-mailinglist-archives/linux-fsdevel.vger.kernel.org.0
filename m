Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6444151F18B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiEHUhv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbiEHUhE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:37:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3659E11C3B
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=e7caWPCCYvvl/M31IWhJn+FN6kXXIF79gpn2aS5zJ9o=; b=GJabYiybI+A78YrP2wQmVJgyUb
        ipeuLEbceqoVLTAXm5eKeihHPJLZr9CuV0ZSb2qUb6c13tGND7xcZInAHuLK5hXPRIgc+RTkX7RNc
        uwuV8+klJqpYuqQlwWGq8pti6BSloCY0GPXlmJPEotKGrMZkGA09CcTL8RjQEvTA5PSsi7K7jCk2k
        cpRux+NW4+EZPmgApcAD+M28Otp9jS7wdbYQwVfUnnOcJfHZJX7gBDeD2NYeUQ0DW9MyiPbR+QBlG
        3cScSO6lvTbn8acYpKifgymfbFB/2TPoJlvyErXN4I9EFZqKXpyZk9CdUclwq+el6UIx4PPT9qBYp
        eh3MeMDw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaF-002o2w-Rd; Sun, 08 May 2022 20:32:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 23/26] jbd2: Convert jbd2_journal_try_to_free_buffers to take a folio
Date:   Sun,  8 May 2022 21:32:44 +0100
Message-Id: <20220508203247.668791-24-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203247.668791-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203247.668791-1-willy@infradead.org>
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

Also convert it to return a bool since it's called from release_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c       |  2 +-
 fs/jbd2/transaction.c | 12 ++++++------
 include/linux/jbd2.h  |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 52c46ac5bc8a..943937cb5302 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3253,7 +3253,7 @@ static bool ext4_release_folio(struct folio *folio, gfp_t wait)
 	if (folio_test_checked(folio))
 		return false;
 	if (journal)
-		return jbd2_journal_try_to_free_buffers(journal, &folio->page);
+		return jbd2_journal_try_to_free_buffers(journal, folio);
 	else
 		return try_to_free_buffers(&folio->page);
 }
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index fcb9175016a5..ee33d277d51e 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2143,17 +2143,17 @@ __journal_try_to_free_buffer(journal_t *journal, struct buffer_head *bh)
  * cannot happen because we never reallocate freed data as metadata
  * while the data is part of a transaction.  Yes?
  *
- * Return 0 on failure, 1 on success
+ * Return false on failure, true on success
  */
-int jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page)
+bool jbd2_journal_try_to_free_buffers(journal_t *journal, struct folio *folio)
 {
 	struct buffer_head *head;
 	struct buffer_head *bh;
-	int ret = 0;
+	bool ret = false;
 
-	J_ASSERT(PageLocked(page));
+	J_ASSERT(folio_test_locked(folio));
 
-	head = page_buffers(page);
+	head = folio_buffers(folio);
 	bh = head;
 	do {
 		struct journal_head *jh;
@@ -2175,7 +2175,7 @@ int jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page)
 			goto busy;
 	} while ((bh = bh->b_this_page) != head);
 
-	ret = try_to_free_buffers(page);
+	ret = try_to_free_buffers(&folio->page);
 busy:
 	return ret;
 }
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index de9536680b2b..e79d6e0b14e8 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1529,7 +1529,7 @@ extern int	 jbd2_journal_dirty_metadata (handle_t *, struct buffer_head *);
 extern int	 jbd2_journal_forget (handle_t *, struct buffer_head *);
 int jbd2_journal_invalidate_folio(journal_t *, struct folio *,
 					size_t offset, size_t length);
-extern int	 jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page);
+bool jbd2_journal_try_to_free_buffers(journal_t *journal, struct folio *folio);
 extern int	 jbd2_journal_stop(handle_t *);
 extern int	 jbd2_journal_flush(journal_t *journal, unsigned int flags);
 extern void	 jbd2_journal_lock_updates (journal_t *);
-- 
2.34.1

