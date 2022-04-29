Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034A3515215
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379693AbiD2RbI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379578AbiD2R3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988EEA27F9
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ulnnpW7LCqHVAAAx5GiwIjukDKStgvzrHinbZXC+krM=; b=D3FSbBmPq0bC6ueZiZjT02KXst
        0zX5TH8EuTVALAt2r1f5RGQ4iI/XEnNg2hxZaX1MDf55v4NUAYy8KlP5sr+GOS5Z9yaN3rlYjMuFt
        8WbqhfYPeZc7vO4pVzFk+nOPV4g5jwFZT46SsnsPynqS3IzQh/dVqdEZw1RWvcGFvEm4P9zRUcEk7
        p1wLE7E0SUBlL75w7y70tGqRhwlZJKmBGQE6Z2V58jqhcP1FZNYMsB6fWAnr1Q4JewhrcHNQLnKWm
        S6dk6Gl6PnGHPC0tqWHyGxRSsZK0lTTxaFvBG1cP9znI3AH3vluJquIP58g4ypmu9P1YYCToC7NgE
        GCbfj2CA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNb-00Cdat-IJ; Fri, 29 Apr 2022 17:26:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 44/69] cifs: Convert cifs to read_folio
Date:   Fri, 29 Apr 2022 18:25:31 +0100
Message-Id: <20220429172556.3011843-45-willy@infradead.org>
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

This is a "weak" conversion which converts straight back to using pages.
CIFS should probably be converted to use netfs_read_folio() by someone
familiar with it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/cifs/file.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index da362b5a0c96..bc6d88e2e672 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4612,8 +4612,9 @@ static int cifs_readpage_worker(struct file *file, struct page *page,
 	return rc;
 }
 
-static int cifs_readpage(struct file *file, struct page *page)
+static int cifs_read_folio(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	loff_t offset = page_file_offset(page);
 	int rc = -EACCES;
 	unsigned int xid;
@@ -4626,7 +4627,7 @@ static int cifs_readpage(struct file *file, struct page *page)
 		return rc;
 	}
 
-	cifs_dbg(FYI, "readpage %p at offset %d 0x%x\n",
+	cifs_dbg(FYI, "read_folio %p at offset %d 0x%x\n",
 		 page, (int)offset, (int)offset);
 
 	rc = cifs_readpage_worker(file, page, &offset);
@@ -4965,7 +4966,7 @@ static bool cifs_dirty_folio(struct address_space *mapping, struct folio *folio)
 #endif
 
 const struct address_space_operations cifs_addr_ops = {
-	.readpage = cifs_readpage,
+	.read_folio = cifs_read_folio,
 	.readahead = cifs_readahead,
 	.writepage = cifs_writepage,
 	.writepages = cifs_writepages,
@@ -4986,12 +4987,12 @@ const struct address_space_operations cifs_addr_ops = {
 };
 
 /*
- * cifs_readpages requires the server to support a buffer large enough to
+ * cifs_readahead requires the server to support a buffer large enough to
  * contain the header plus one complete page of data.  Otherwise, we need
- * to leave cifs_readpages out of the address space operations.
+ * to leave cifs_readahead out of the address space operations.
  */
 const struct address_space_operations cifs_addr_ops_smallbuf = {
-	.readpage = cifs_readpage,
+	.read_folio = cifs_read_folio,
 	.writepage = cifs_writepage,
 	.writepages = cifs_writepages,
 	.write_begin = cifs_write_begin,
-- 
2.34.1

