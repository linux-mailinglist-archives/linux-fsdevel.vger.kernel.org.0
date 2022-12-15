Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EF664E36F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 22:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiLOVoS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 16:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiLOVoE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:44:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DDA5C74B
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 13:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=d4Jtz4zVUN9lysY3cHa9FMXu2AtjTw5WKWoJYsuMphg=; b=hi1RS1jwlkAAXN9uZGvcmwRl7/
        TOcjb7x/iJmBbgjj9BWxZ8aUjK+IxwiTGvW8BRqMm/0iJqvkA5J6N0fvKxMZ3MxSugSE4xF2CYSOv
        v/xSgEnpNn2q/X7xG9oqH1BscecrH+TehIWL4lyFk7wcZXNFW5nWE1Z/Rs3fcLBxyobaZ1LzdbClv
        9WXLcOqaLy8cHjp+gxLvM5SMPZpUxROO5ZzYc6t1ZvvXv6UcV74OvE8rKl760K1+1tAZnwug8vlAM
        YJlRucHKEuVlBaxPza5SMOANDiJoPIDeT8W3RuSfoCufnWpagO1X1Ntr/i9ixP9UpsXplIibw9ILb
        cnoEnqCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5w1O-00EmLE-9B; Thu, 15 Dec 2022 21:44:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/12] buffer: Replace obvious uses of b_page with b_folio
Date:   Thu, 15 Dec 2022 21:43:52 +0000
Message-Id: <20221215214402.3522366-3-willy@infradead.org>
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

These cases just check if it's NULL, or use b_page to get to the page's
address space.  They are assumptions that b_page never points to a
tail page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index d9c6d1fbb6dd..e1055fe0b366 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -321,7 +321,7 @@ static void end_buffer_async_read_io(struct buffer_head *bh, int uptodate)
 {
 	/* Decrypt if needed */
 	if (uptodate &&
-	    fscrypt_inode_uses_fs_layer_crypto(bh->b_page->mapping->host)) {
+	    fscrypt_inode_uses_fs_layer_crypto(bh->b_folio->mapping->host)) {
 		struct decrypt_bh_ctx *ctx = kmalloc(sizeof(*ctx), GFP_ATOMIC);
 
 		if (ctx) {
@@ -570,7 +570,7 @@ void write_boundary_block(struct block_device *bdev,
 void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
 {
 	struct address_space *mapping = inode->i_mapping;
-	struct address_space *buffer_mapping = bh->b_page->mapping;
+	struct address_space *buffer_mapping = bh->b_folio->mapping;
 
 	mark_buffer_dirty(bh);
 	if (!mapping->private_data) {
@@ -1073,7 +1073,7 @@ __getblk_slow(struct block_device *bdev, sector_t block,
  * and then attach the address_space's inode to its superblock's dirty
  * inode list.
  *
- * mark_buffer_dirty() is atomic.  It takes bh->b_page->mapping->private_lock,
+ * mark_buffer_dirty() is atomic.  It takes bh->b_folio->mapping->private_lock,
  * i_pages lock and mapping->host->i_lock.
  */
 void mark_buffer_dirty(struct buffer_head *bh)
@@ -1117,8 +1117,8 @@ void mark_buffer_write_io_error(struct buffer_head *bh)
 
 	set_buffer_write_io_error(bh);
 	/* FIXME: do we need to set this in both places? */
-	if (bh->b_page && bh->b_page->mapping)
-		mapping_set_error(bh->b_page->mapping, -EIO);
+	if (bh->b_folio && bh->b_folio->mapping)
+		mapping_set_error(bh->b_folio->mapping, -EIO);
 	if (bh->b_assoc_map)
 		mapping_set_error(bh->b_assoc_map, -EIO);
 	rcu_read_lock();
@@ -1154,7 +1154,7 @@ void __bforget(struct buffer_head *bh)
 {
 	clear_buffer_dirty(bh);
 	if (bh->b_assoc_map) {
-		struct address_space *buffer_mapping = bh->b_page->mapping;
+		struct address_space *buffer_mapping = bh->b_folio->mapping;
 
 		spin_lock(&buffer_mapping->private_lock);
 		list_del_init(&bh->b_assoc_buffers);
-- 
2.35.1

