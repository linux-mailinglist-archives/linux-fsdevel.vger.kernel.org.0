Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA9D51F15A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiEHUfs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiEHUfb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC4E2DE7
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ulnnpW7LCqHVAAAx5GiwIjukDKStgvzrHinbZXC+krM=; b=MB+lXDflz3H+RnFdnprohZzGJ5
        1mBCfylLMBa+TDnpaAqUDV90uicuVRSmUbdj27N9ZrL9SXhKiWO/3ApM2vtPxPQ9DBtfM8YNP8ASV
        +DCmI7uBjy+HPDCvMENSn3EwJATQvxzVggSQPN1z67ID5F33AWtoGh89Y9CS0EkQdehIr/VLm5LeO
        s6jivhTksMh4pMOArfbVf7mowi7amKY/eyQmL/JWwlP6MRGgJI1woA6Qov89UYFkk7XetRK35EWqm
        gUw+j+tGZ4I8eAq7ahqMFF++L9IffJRcDLBzCfe/30780rQYJ+sIV4V0aGvfS3Y+/OqrorOYsS2UM
        g8p7JNfw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnZ4-002nnt-97; Sun, 08 May 2022 20:31:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 12/37] cifs: Convert cifs to read_folio
Date:   Sun,  8 May 2022 21:31:06 +0100
Message-Id: <20220508203131.667959-13-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203131.667959-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203131.667959-1-willy@infradead.org>
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

