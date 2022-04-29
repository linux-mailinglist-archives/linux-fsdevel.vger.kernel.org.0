Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2651F51520E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379672AbiD2Ra6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379638AbiD2R3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7722A6E31
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fYNWAWF0UHuB+svW5UzmqrUpnQ209GYdqP5ggOpbJzM=; b=X8q/B7NbfVv6URviCjtAELqTji
        LmAk527mPCzgNJBqtsp+XSsuCeZWnj02CkkrSUcugK90BIeN1yoojyg7m8p3wky7fnCTbuCLchjQk
        LyGufQ32rqeoQ2STs98pYIin1wPaI72es1Q7P6Fr8DmZEBuUzR3ZCsGCKwAYvbnOveuWkbZEN89ha
        3rWfJhU1ochFYo+sF6lYJrBwDcrkkFk9Qc4Xqk9+dNobMdHUXELexx9GRKvXRjtGLa7wXQlRxSlnG
        8kdBRCbl/KlJ9e4nKTuV2YGbVpNDVVaky2TpKdZrdRAkSrZppsEMfZg6YxYtF977lg2O8kLtleoLS
        ucVikgXg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNe-00CddY-Vh; Fri, 29 Apr 2022 17:26:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 65/69] ubifs: Convert ubifs to read_folio
Date:   Fri, 29 Apr 2022 18:25:52 +0100
Message-Id: <20220429172556.3011843-66-willy@infradead.org>
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
A full conversion should be performed at some point, hopefully by
someone familiar with the filesystem.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ubifs/file.c  | 12 +++++++-----
 fs/ubifs/super.c |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 81c085c4decf..7cbf2edf8907 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -31,9 +31,9 @@
  * in the "sys_write -> alloc_pages -> direct reclaim path". So, in
  * 'ubifs_writepage()' we are only guaranteed that the page is locked.
  *
- * Similarly, @i_mutex is not always locked in 'ubifs_readpage()', e.g., the
+ * Similarly, @i_mutex is not always locked in 'ubifs_read_folio()', e.g., the
  * read-ahead path does not lock it ("sys_read -> generic_file_aio_read ->
- * ondemand_readahead -> readpage"). In case of readahead, @I_SYNC flag is not
+ * ondemand_readahead -> read_folio"). In case of readahead, @I_SYNC flag is not
  * set as well. However, UBIFS disables readahead.
  */
 
@@ -889,12 +889,14 @@ static int ubifs_bulk_read(struct page *page)
 	return err;
 }
 
-static int ubifs_readpage(struct file *file, struct page *page)
+static int ubifs_read_folio(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
+
 	if (ubifs_bulk_read(page))
 		return 0;
 	do_readpage(page);
-	unlock_page(page);
+	folio_unlock(folio);
 	return 0;
 }
 
@@ -1641,7 +1643,7 @@ static int ubifs_symlink_getattr(struct user_namespace *mnt_userns,
 }
 
 const struct address_space_operations ubifs_file_address_operations = {
-	.readpage       = ubifs_readpage,
+	.read_folio     = ubifs_read_folio,
 	.writepage      = ubifs_writepage,
 	.write_begin    = ubifs_write_begin,
 	.write_end      = ubifs_write_end,
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index bad67455215f..0978d01b0ea4 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2191,7 +2191,7 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
 
 	/*
 	 * UBIFS provides 'backing_dev_info' in order to disable read-ahead. For
-	 * UBIFS, I/O is not deferred, it is done immediately in readpage,
+	 * UBIFS, I/O is not deferred, it is done immediately in read_folio,
 	 * which means the user would have to wait not just for their own I/O
 	 * but the read-ahead I/O as well i.e. completely pointless.
 	 *
-- 
2.34.1

