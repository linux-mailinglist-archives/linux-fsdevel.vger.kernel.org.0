Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281B151F187
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiEHUhk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbiEHUgo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:36:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59AA11C18
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9VlVLCmBplcMyE4emN13jYdGCEQFqzeEgS9z+TalanI=; b=fNwcPwuo+Ug3Z/i/fdKsVGn56z
        zxK2PopxYrvpq3yw6rVJdr0OoaAaOprP+EAAcosbvupXdr8oOoW3l9BwcUzwt6+D+UISKI6sQkvhW
        fgn8z80im35ahjifqf7v8MS4XwZbkkjE0nBTR2fT4bo6EunlChuzHz4+g08KKFVdqQXipSWtSVkxm
        4W/VCL+I6B+O5cOAIKLtobFQPhub8bmLWt/ZNthMbXBw1Zg7whoDA1b3Sw2ojuO9YRtNHeTLhxVwc
        4n/bpVJBH3XwtV6sW1TPzWWi/ZKWRR7XDhdNRxUFY3lq8WtXQcc4W77dIyNSZgU2XHeq9wsIXtJbW
        V8irPEWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaD-002o1Q-TX; Sun, 08 May 2022 20:32:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 09/26] ext4: Convert to release_folio
Date:   Sun,  8 May 2022 21:32:30 +0100
Message-Id: <20220508203247.668791-10-willy@infradead.org>
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

The use of folios should be pushed deeper into ext4 from here.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c6b8cb4949f1..52c46ac5bc8a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3243,19 +3243,19 @@ static void ext4_journalled_invalidate_folio(struct folio *folio,
 	WARN_ON(__ext4_journalled_invalidate_folio(folio, offset, length) < 0);
 }
 
-static int ext4_releasepage(struct page *page, gfp_t wait)
+static bool ext4_release_folio(struct folio *folio, gfp_t wait)
 {
-	journal_t *journal = EXT4_JOURNAL(page->mapping->host);
+	journal_t *journal = EXT4_JOURNAL(folio->mapping->host);
 
-	trace_ext4_releasepage(page);
+	trace_ext4_releasepage(&folio->page);
 
 	/* Page has dirty journalled data -> cannot release */
-	if (PageChecked(page))
-		return 0;
+	if (folio_test_checked(folio))
+		return false;
 	if (journal)
-		return jbd2_journal_try_to_free_buffers(journal, page);
+		return jbd2_journal_try_to_free_buffers(journal, &folio->page);
 	else
-		return try_to_free_buffers(page);
+		return try_to_free_buffers(&folio->page);
 }
 
 static bool ext4_inode_datasync_dirty(struct inode *inode)
@@ -3618,7 +3618,7 @@ static const struct address_space_operations ext4_aops = {
 	.dirty_folio		= ext4_dirty_folio,
 	.bmap			= ext4_bmap,
 	.invalidate_folio	= ext4_invalidate_folio,
-	.releasepage		= ext4_releasepage,
+	.release_folio		= ext4_release_folio,
 	.direct_IO		= noop_direct_IO,
 	.migratepage		= buffer_migrate_page,
 	.is_partially_uptodate  = block_is_partially_uptodate,
@@ -3636,7 +3636,7 @@ static const struct address_space_operations ext4_journalled_aops = {
 	.dirty_folio		= ext4_journalled_dirty_folio,
 	.bmap			= ext4_bmap,
 	.invalidate_folio	= ext4_journalled_invalidate_folio,
-	.releasepage		= ext4_releasepage,
+	.release_folio		= ext4_release_folio,
 	.direct_IO		= noop_direct_IO,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
@@ -3653,7 +3653,7 @@ static const struct address_space_operations ext4_da_aops = {
 	.dirty_folio		= ext4_dirty_folio,
 	.bmap			= ext4_bmap,
 	.invalidate_folio	= ext4_invalidate_folio,
-	.releasepage		= ext4_releasepage,
+	.release_folio		= ext4_release_folio,
 	.direct_IO		= noop_direct_IO,
 	.migratepage		= buffer_migrate_page,
 	.is_partially_uptodate  = block_is_partially_uptodate,
-- 
2.34.1

