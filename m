Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA03A51F15E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbiEHUgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiEHUfe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354262AE8
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=LMGCME+l7x4GzgKB/yPRpDrmevCiF9Q8eBSQcevd08A=; b=KyVBRKcP4CV80yaiDWTqPLP/G0
        PWME1Krv58EsDYeSfa8Qq4ORLyQClp53kX0ULr/vMnZ25ZCLYn4Gu3lWtlrPaNirvjjI5lR8EelC8
        fj7BNMF9GvAH1CeM5gp/7kZ3fF5oTtvradhuPr3OSakNBmZb1zx6Nlm7eJgz8zBRW90euSQbv104I
        dNzj3Q0BtspEwEPDJNwRc89ML8RHVQI6a3/8ShfaYnmfinwXkwBuagjBD2Z5OdErxJisTRniqbMlQ
        KKlmDnPuNkOKlIvS1iUsFcWVrhSMRfY+LcJPi4e0D6JmmKWHU+cPQobi25JAbxYfEJ4s2a55RX04l
        41KiJudQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnZ4-002no8-PC; Sun, 08 May 2022 20:31:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 15/37] ecryptfs: Convert ecryptfs to read_folio
Date:   Sun,  8 May 2022 21:31:09 +0100
Message-Id: <20220508203131.667959-16-willy@infradead.org>
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
A full conversion should be performed at some point, hopefully by
someone familiar with the filesystem.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ecryptfs/mmap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 47904d40ef88..19af229eb7ca 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -170,16 +170,17 @@ ecryptfs_copy_up_encrypted_with_header(struct page *page,
 }
 
 /**
- * ecryptfs_readpage
+ * ecryptfs_read_folio
  * @file: An eCryptfs file
- * @page: Page from eCryptfs inode mapping into which to stick the read data
+ * @folio: Folio from eCryptfs inode mapping into which to stick the read data
  *
- * Read in a page, decrypting if necessary.
+ * Read in a folio, decrypting if necessary.
  *
  * Returns zero on success; non-zero on error.
  */
-static int ecryptfs_readpage(struct file *file, struct page *page)
+static int ecryptfs_read_folio(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct ecryptfs_crypt_stat *crypt_stat =
 		&ecryptfs_inode_to_private(page->mapping->host)->crypt_stat;
 	int rc = 0;
@@ -549,7 +550,7 @@ const struct address_space_operations ecryptfs_aops = {
 	.invalidate_folio = block_invalidate_folio,
 #endif
 	.writepage = ecryptfs_writepage,
-	.readpage = ecryptfs_readpage,
+	.read_folio = ecryptfs_read_folio,
 	.write_begin = ecryptfs_write_begin,
 	.write_end = ecryptfs_write_end,
 	.bmap = ecryptfs_bmap,
-- 
2.34.1

