Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9485151F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379570AbiD2RaQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379555AbiD2R3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEABCA2060
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bwi7+MWtzB6nmt/BL53YCai3AHddZpQBVdmLo8uttkU=; b=gL3IgrOd9w1aNvGX4ZO8XkXYWD
        Do0tCP70xzRVz/6ejUTD9vSoOhcEetnoa2uegZg2F4QSmt9jh6SsqiSX4LS3O5oZQXFymUB3ia5uF
        V+OJSDEoCS+QlmOVyKJwYn4o7nOeGDoAfsMLfbUay+LPIsZZWv2837zVEcN3w1WncU0dENcg7/uOM
        Vc/p8Pbz/eejDmolMNDZyQdfD51CNljklfPjguA9dv9GEj0WFiThoPlH11d9qDDhHu7OBbM7IGkFN
        bmkNRjUMpZe+6PiNrbLe4ihaKHirF8fQNrxCg9kZPSoLJtLpD4CH9XlGN9Z8al6gA5Ido9Srs3nGI
        w4gX0TMg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNa-00CdaR-Ts; Fri, 29 Apr 2022 17:26:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 39/69] fs: Convert simple_readpage to simple_read_folio
Date:   Fri, 29 Apr 2022 18:25:26 +0100
Message-Id: <20220429172556.3011843-40-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
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

This is a full folio conversion; it is prepared to handle folios of
arbitrary size.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/libfs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index a1c10d3163e0..31b0ddf01c31 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -539,12 +539,12 @@ int simple_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 }
 EXPORT_SYMBOL(simple_setattr);
 
-static int simple_readpage(struct file *file, struct page *page)
+static int simple_read_folio(struct file *file, struct folio *folio)
 {
-	clear_highpage(page);
-	flush_dcache_page(page);
-	SetPageUptodate(page);
-	unlock_page(page);
+	folio_zero_range(folio, 0, folio_size(folio));
+	flush_dcache_folio(folio);
+	folio_mark_uptodate(folio);
+	folio_unlock(folio);
 	return 0;
 }
 
@@ -592,7 +592,7 @@ EXPORT_SYMBOL(simple_write_begin);
  * should extend on what's done here with a call to mark_inode_dirty() in the
  * case that i_size has changed.
  *
- * Use *ONLY* with simple_readpage()
+ * Use *ONLY* with simple_read_folio()
  */
 static int simple_write_end(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
@@ -628,7 +628,7 @@ static int simple_write_end(struct file *file, struct address_space *mapping,
  * Provides ramfs-style behavior: data in the pagecache, but no writeback.
  */
 const struct address_space_operations ram_aops = {
-	.readpage	= simple_readpage,
+	.read_folio	= simple_read_folio,
 	.write_begin	= simple_write_begin,
 	.write_end	= simple_write_end,
 	.dirty_folio	= noop_dirty_folio,
-- 
2.34.1

