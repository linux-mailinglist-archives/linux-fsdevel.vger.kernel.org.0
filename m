Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8D2515207
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiD2Rar (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379635AbiD2R3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B01A6E36
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8H/SPWZE91QCw1tKsAIWypBRoIZkX5Fqb49XpUP2PFg=; b=VI3eZ48LXcQp2H8NqcJWC+U3+6
        b+RNC2dlMjB0alnnu7ywzn4VGIhEP7i/zbB3siFHe9ZS98rG6HgJYAlYJleR2mvOMuga0Fu9ARHzi
        7H2T/FxLe2Z79dgl3UPSFAGTOmb6aE/tGEb3sbcrbZJD9UIRd6KHmBwTbQu0SfwvfADUJzO10UCJS
        9e9BB0Netnh0BPk9/vAhU5E/BjPX5mhuG3x2yq0oC9fheGIVeW/bZayTea5VvT8LsCBRhXGvZFQRU
        95l8Q+Cvw1PRy0tcCdVPrHKINZ0qCYYV0BDSzg+dv8FT7vxbChpUh+xavgUdxSRLvfjhCzj5hv2im
        mi38AF/A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNe-00CddE-KY; Fri, 29 Apr 2022 17:26:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 63/69] romfs: Convert romfs to read_folio
Date:   Fri, 29 Apr 2022 18:25:50 +0100
Message-Id: <20220429172556.3011843-64-willy@infradead.org>
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
 fs/romfs/super.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 9e6bbb4219de..c59b230d55b4 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -18,7 +18,7 @@
  *					Changed for 2.1.19 modules
  *	Jan 1997			Initial release
  *	Jun 1997			2.1.43+ changes
- *					Proper page locking in readpage
+ *					Proper page locking in read_folio
  *					Changed to work with 2.1.45+ fs
  *	Jul 1997			Fixed follow_link
  *			2.1.47
@@ -41,7 +41,7 @@
  *					  dentries in lookup
  *					clean up page flags setting
  *					  (error, uptodate, locking) in
- *					  in readpage
+ *					  in read_folio
  *					use init_special_inode for
  *					  fifos/sockets (and streamline) in
  *					  read_inode, fix _ops table order
@@ -99,8 +99,9 @@ static struct inode *romfs_iget(struct super_block *sb, unsigned long pos);
 /*
  * read a page worth of data from the image
  */
-static int romfs_readpage(struct file *file, struct page *page)
+static int romfs_read_folio(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	loff_t offset, size;
 	unsigned long fillsize, pos;
@@ -142,7 +143,7 @@ static int romfs_readpage(struct file *file, struct page *page)
 }
 
 static const struct address_space_operations romfs_aops = {
-	.readpage	= romfs_readpage
+	.read_folio	= romfs_read_folio
 };
 
 /*
-- 
2.34.1

