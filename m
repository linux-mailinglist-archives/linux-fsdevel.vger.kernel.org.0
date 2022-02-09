Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340EB4AFE52
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiBIUXK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:10 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiBIUWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21404E039E07
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Z3nBOwjLzloE91zY7k0ixQLoB+TRN9T2R8FH9ttaP9w=; b=EqlzrV4nYcQR37MnJxSsru879r
        cFmVTDOpds0h+//iDG3wRa9wPV5KoV8IVkjDVXAJWE6pVOcbpu9gtBAWrPi4nHytBN3EEAYQiC56G
        K51hW4YQ80yIguqnJcvlA6UAipt2gcP0Re3noa4JdONlhTOHiGlXbBeEhyKxjH9EaepQNgngulgDl
        D5eG7fW3crSuKSO5X7zEpe6l3e9/O92ZK30HrSPWmD7xakJouGLr39nmjG9Da04fuHItrOEaAJWSc
        6xiG8tFkpMVTA5IsJgU6oife3sQ6C0uCTGuPfM11e8r8sx1lYalO8jC3N0JiGo2Rbyvnwz5pTLNJL
        UB+r9vMw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTv-008csG-DY; Wed, 09 Feb 2022 20:22:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 38/56] nfs: Convert from launder_page to launder_folio
Date:   Wed,  9 Feb 2022 20:21:57 +0000
Message-Id: <20220209202215.2055748-39-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
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

We don't need to use page_file_mapping() here because launder_folio
is never called for swap cache pages.  We also don't need to
cast an loff_t in order to print it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nfs/file.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 30c7d6f949c1..ce4fa598ddfa 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -472,15 +472,15 @@ static void nfs_check_dirty_writeback(struct page *page,
  * - Caller holds page lock
  * - Return 0 if successful, -error otherwise
  */
-static int nfs_launder_page(struct page *page)
+static int nfs_launder_folio(struct folio *folio)
 {
-	struct inode *inode = page_file_mapping(page)->host;
+	struct inode *inode = folio->mapping->host;
 
-	dfprintk(PAGECACHE, "NFS: launder_page(%ld, %llu)\n",
-		inode->i_ino, (long long)page_offset(page));
+	dfprintk(PAGECACHE, "NFS: launder_folio(%ld, %llu)\n",
+		inode->i_ino, folio_pos(folio));
 
-	wait_on_page_fscache(page);
-	return nfs_wb_page(inode, page);
+	folio_wait_fscache(folio);
+	return nfs_wb_page(inode, &folio->page);
 }
 
 static int nfs_swap_activate(struct swap_info_struct *sis, struct file *file,
@@ -526,7 +526,7 @@ const struct address_space_operations nfs_file_aops = {
 #ifdef CONFIG_MIGRATION
 	.migratepage = nfs_migrate_page,
 #endif
-	.launder_page = nfs_launder_page,
+	.launder_folio = nfs_launder_folio,
 	.is_dirty_writeback = nfs_check_dirty_writeback,
 	.error_remove_page = generic_error_remove_page,
 	.swap_activate = nfs_swap_activate,
-- 
2.34.1

