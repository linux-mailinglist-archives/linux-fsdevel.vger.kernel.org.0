Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1431A29667C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 23:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372273AbgJVVWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 17:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S370489AbgJVVWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 17:22:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F27C0613D5;
        Thu, 22 Oct 2020 14:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gL/c6EulWmWo4TRA2GCRaD9qXTLuixWc7vV5ZfmfHIc=; b=dRymKTfpPXjP0X6UMe31yGzaTt
        +heaOvNc/Z/Kg92wigLlVB4sE4PbXVt0ZgSEF7mW+QGpO6QyZdgjtrewCc4mkeG1Ag2RKj15Co4Mz
        n76+oCvKbkx7kMm5DVXkSwT9XkZYirElJ7/CgcOJ4elVpEmXeXaUrxfKdVSZq/WBBz6UK3R6uv/WH
        +gAzcbWgEoMovy2kC4841N5dLQacRD2hwClEtoNGpEev4B137Vq0MUVCcr3qbu+kp5EKGsWMVUQSM
        t3Mbaru+h6CZktUdWmG7KVfSCAe7uoOoxWy+sxMEzlci5jIoBHKU92lqrnjpSR6fUXs9g+lTLcixm
        FbE4s6DQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVi2Y-00046X-Ua; Thu, 22 Oct 2020 21:22:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 4/6] fs: Hoist fscrypt decryption to bio completion handler
Date:   Thu, 22 Oct 2020 22:22:26 +0100
Message-Id: <20201022212228.15703-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201022212228.15703-1-willy@infradead.org>
References: <20201022212228.15703-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is prep work for doing decryption at the BIO level instead of
the BH level.  It still works on one BH at a time for now.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ccb90081117c..627ae1d853c0 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -241,6 +241,10 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 	return ret;
 }
 
+/*
+ * I/O completion handler for block_read_full_page() - pages
+ * which come unlocked at the end of I/O.
+ */
 static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 {
 	unsigned long flags;
@@ -313,28 +317,6 @@ static void decrypt_bh(struct work_struct *work)
 	kfree(ctx);
 }
 
-/*
- * I/O completion handler for block_read_full_page() - pages
- * which come unlocked at the end of I/O.
- */
-static void end_buffer_async_read_io(struct buffer_head *bh, int uptodate)
-{
-	/* Decrypt if needed */
-	if (uptodate &&
-	    fscrypt_inode_uses_fs_layer_crypto(bh->b_page->mapping->host)) {
-		struct decrypt_bh_ctx *ctx = kmalloc(sizeof(*ctx), GFP_ATOMIC);
-
-		if (ctx) {
-			INIT_WORK(&ctx->work, decrypt_bh);
-			ctx->bh = bh;
-			fscrypt_enqueue_decrypt_work(&ctx->work);
-			return;
-		}
-		uptodate = 0;
-	}
-	end_buffer_async_read(bh, uptodate);
-}
-
 /*
  * Completion handler for block_write_full_page() - pages which are unlocked
  * during I/O, and which have PageWriteback cleared upon I/O completion.
@@ -404,7 +386,7 @@ EXPORT_SYMBOL(end_buffer_async_write);
  */
 static void mark_buffer_async_read(struct buffer_head *bh)
 {
-	bh->b_end_io = end_buffer_async_read_io;
+	bh->b_end_io = end_buffer_async_read;
 	set_buffer_async_read(bh);
 }
 
@@ -3103,11 +3085,26 @@ EXPORT_SYMBOL(generic_block_bmap);
 static void end_bio_bh_io_sync(struct bio *bio)
 {
 	struct buffer_head *bh = bio->bi_private;
+	int uptodate = !bio->bi_status;
 
 	if (unlikely(bio_flagged(bio, BIO_QUIET)))
 		set_bit(BH_Quiet, &bh->b_state);
 
-	bh->b_end_io(bh, !bio->bi_status);
+	/* Decrypt if needed */
+	if ((bio_data_dir(bio) == READ) && uptodate &&
+	    fscrypt_inode_uses_fs_layer_crypto(bh->b_page->mapping->host)) {
+		struct decrypt_bh_ctx *ctx = kmalloc(sizeof(*ctx), GFP_ATOMIC);
+
+		if (ctx) {
+			INIT_WORK(&ctx->work, decrypt_bh);
+			ctx->bh = bh;
+			fscrypt_enqueue_decrypt_work(&ctx->work);
+			bio_put(bio);
+			return;
+		}
+		uptodate = 0;
+	}
+	bh->b_end_io(bh, uptodate);
 	bio_put(bio);
 }
 
-- 
2.28.0

