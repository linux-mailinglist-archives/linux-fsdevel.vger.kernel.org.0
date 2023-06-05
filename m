Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70B5722CFB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 18:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjFEQur (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 12:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbjFEQui (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:50:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C675A122
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 09:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Y39+FBraiXLKMk72eXSZr8izj/cd6Fnar3TzALVxBdM=; b=XR9MeB+DfmTA+MHy+COe/5I9Dg
        ezGVCSlvfXQ7j74wgSRhiC1L//JWVHrMwh35PeTCGXjgRPsxuHbgxcMOM2dsLFzWWL7jIPm0/SwNU
        Ky0caPIPF2vfxaMGanwjIYAujatLdr0VjI7DKFaN/Y8psa+xDxrVjFjKsBX/VT5sK1F5bvuIpsmmw
        Cc8A6ItnCjlgbZJTdnoh1aehoq6vL2llhD5CgnB1oN9nKmKFbomamzYAqE2tF52DLhCG+smVtW7kU
        nXThWapyJZV/E9J4X6+Nt+cSmFvs5ILtdpMEvL24dQ/sq4Tu6Cuq1QkZZyeFeya6h2Hk5mdG1UjwI
        IcUBMBFw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6DPa-00CCav-Ng; Mon, 05 Jun 2023 16:50:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] ubifs: Use a folio in do_truncation()
Date:   Mon,  5 Jun 2023 17:50:28 +0100
Message-Id: <20230605165029.2908304-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230605165029.2908304-1-willy@infradead.org>
References: <20230605165029.2908304-1-willy@infradead.org>
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

Convert from the old page APIs to the new folio APIs which saves
a few hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ubifs/file.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 1c7a99c36906..c0e68b3d7582 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1153,11 +1153,11 @@ static int do_truncation(struct ubifs_info *c, struct inode *inode,
 
 	if (offset) {
 		pgoff_t index = new_size >> PAGE_SHIFT;
-		struct page *page;
+		struct folio *folio;
 
-		page = find_lock_page(inode->i_mapping, index);
-		if (page) {
-			if (PageDirty(page)) {
+		folio = filemap_lock_folio(inode->i_mapping, index);
+		if (folio) {
+			if (folio_test_dirty(folio)) {
 				/*
 				 * 'ubifs_jnl_truncate()' will try to truncate
 				 * the last data node, but it contains
@@ -1166,14 +1166,14 @@ static int do_truncation(struct ubifs_info *c, struct inode *inode,
 				 * 'ubifs_jnl_truncate()' will see an already
 				 * truncated (and up to date) data node.
 				 */
-				ubifs_assert(c, PagePrivate(page));
+				ubifs_assert(c, folio->private != NULL);
 
-				clear_page_dirty_for_io(page);
+				folio_clear_dirty_for_io(folio);
 				if (UBIFS_BLOCKS_PER_PAGE_SHIFT)
-					offset = new_size &
-						 (PAGE_SIZE - 1);
-				err = do_writepage(page, offset);
-				put_page(page);
+					offset = offset_in_folio(folio,
+							new_size);
+				err = do_writepage(&folio->page, offset);
+				folio_put(folio);
 				if (err)
 					goto out_budg;
 				/*
@@ -1186,8 +1186,8 @@ static int do_truncation(struct ubifs_info *c, struct inode *inode,
 				 * to 'ubifs_jnl_truncate()' to save it from
 				 * having to read it.
 				 */
-				unlock_page(page);
-				put_page(page);
+				folio_unlock(folio);
+				folio_put(folio);
 			}
 		}
 	}
-- 
2.39.2

