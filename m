Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFBF64E369
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 22:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiLOVoJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 16:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiLOVoD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:44:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222845C766
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 13:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OuWSqYcbZjkcwq3U2LAw3KmB8IBcZ9iMYpK/n9em/18=; b=f8LDvWdU6VVqRLVOgAsl4tEhEv
        9ADVgpogoFhGhwhgbmlYhGjgQN5CP9zvUHDxxEcVk/u5azfzTt5XjfAZmTN6l/Yg58ZY5Pfkw94vU
        WT6IMQWF/tKdfgOs2oSdsI2w0/p/xh4h6E1efhnMZ1U6VNkSNLsgQj1D9+CBzwW2xdfsVXO4f4j5e
        cHd8Ie/AekfXDdhTfxsfpLbTuZBQOuO9UNjzBShC8icGfSYEoOu5rsVWYo+lwxOUsiRbau2AAg1g8
        ap3rz5UkNF3lovw8n5Emhi4x11pZdE0Avi6Ao1Pjspu1ru1BrO/kPdsCSUpDWgbuJAs8OTDCrWKIs
        IWHW4w4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5w1P-00EmMG-PR; Thu, 15 Dec 2022 21:44:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/12] reiserfs: Replace obvious uses of b_page with b_folio
Date:   Thu, 15 Dec 2022 21:44:01 +0000
Message-Id: <20221215214402.3522366-12-willy@infradead.org>
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
or call page_folio() on b_page to get a folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/reiserfs/journal.c         | 4 ++--
 fs/reiserfs/tail_conversion.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 9f62da7471c9..9ce4ec296b74 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -601,7 +601,7 @@ static int journal_list_still_alive(struct super_block *s,
  */
 static void release_buffer_page(struct buffer_head *bh)
 {
-	struct folio *folio = page_folio(bh->b_page);
+	struct folio *folio = bh->b_folio;
 	if (!folio->mapping && folio_trylock(folio)) {
 		folio_get(folio);
 		put_bh(bh);
@@ -866,7 +866,7 @@ static int write_ordered_buffers(spinlock_t * lock,
 		 * will ever write the buffer. We're safe if we write the
 		 * page one last time after freeing the journal header.
 		 */
-		if (buffer_dirty(bh) && unlikely(bh->b_page->mapping == NULL)) {
+		if (buffer_dirty(bh) && unlikely(bh->b_folio->mapping == NULL)) {
 			spin_unlock(lock);
 			write_dirty_buffer(bh, 0);
 			spin_lock(lock);
diff --git a/fs/reiserfs/tail_conversion.c b/fs/reiserfs/tail_conversion.c
index b0ae088dffc7..2cec61af2a9e 100644
--- a/fs/reiserfs/tail_conversion.c
+++ b/fs/reiserfs/tail_conversion.c
@@ -177,7 +177,7 @@ void reiserfs_unmap_buffer(struct buffer_head *bh)
 	 * BUG() on attempt to write not mapped buffer
 	 */
 	if ((!list_empty(&bh->b_assoc_buffers) || bh->b_private) && bh->b_page) {
-		struct inode *inode = bh->b_page->mapping->host;
+		struct inode *inode = bh->b_folio->mapping->host;
 		struct reiserfs_journal *j = SB_JOURNAL(inode->i_sb);
 		spin_lock(&j->j_dirty_buffers_lock);
 		list_del_init(&bh->b_assoc_buffers);
-- 
2.35.1

