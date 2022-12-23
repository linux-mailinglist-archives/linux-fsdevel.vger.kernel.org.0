Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E5F655472
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 21:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbiLWUhU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 15:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbiLWUhB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 15:37:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC261DA60;
        Fri, 23 Dec 2022 12:37:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C5FD61EF8;
        Fri, 23 Dec 2022 20:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B74C433F2;
        Fri, 23 Dec 2022 20:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671827819;
        bh=ZAQDnq69vyL+/4co41JjRU2DGFFuthO5Y0yROMIMgR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L42jWAOPyzBsjZyV0RC2uRBBHb7VQUDo04SQEsVfPfM53O/1p3GzZc4xc6RppHs+P
         vXqNUSIOR7PAsynDU3iVs91NeXitcgNOZ28uYx8buGakL4eLsy+6ziBLsoh84A4xKs
         jIXj8Svc/d3rSr+W4lEL2SIsI3KJr+DdmJ6KsD6q68Jje2NpEXrAQe8bi3lVx6wtRK
         hTDqJJKLxPT/DpT4Gp8Elk0qVHHi0dwq6Zu28JZuOOwChUAwwHaY/C/1iIaoObhjp6
         cUy2KXNv7jrNlVfhF5Y8RD/xD2jk7I3uqQnwfvVITMe2wZPMNF6Ec7c3sV7fE9hAUA
         N8ThIDpVWIdxg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 10/11] fs/buffer.c: support fsverity in block_read_full_folio()
Date:   Fri, 23 Dec 2022 12:36:37 -0800
Message-Id: <20221223203638.41293-11-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221223203638.41293-1-ebiggers@kernel.org>
References: <20221223203638.41293-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

After each filesystem block (as represented by a buffer_head) has been
read from disk by block_read_full_folio(), verify it if needed.  The
verification is done on the fsverity_read_workqueue.  Also allow reads
of verity metadata past i_size, as required by ext4.

This is needed to support fsverity on ext4 filesystems where the
filesystem block size is less than the page size.

The new code is compiled away when CONFIG_FS_VERITY=n.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/buffer.c | 67 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 57 insertions(+), 10 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index d9c6d1fbb6dde..2e65ba2b3919b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -48,6 +48,7 @@
 #include <linux/sched/mm.h>
 #include <trace/events/block.h>
 #include <linux/fscrypt.h>
+#include <linux/fsverity.h>
 
 #include "internal.h"
 
@@ -295,20 +296,52 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 	return;
 }
 
-struct decrypt_bh_ctx {
+struct postprocess_bh_ctx {
 	struct work_struct work;
 	struct buffer_head *bh;
 };
 
+static void verify_bh(struct work_struct *work)
+{
+	struct postprocess_bh_ctx *ctx =
+		container_of(work, struct postprocess_bh_ctx, work);
+	struct buffer_head *bh = ctx->bh;
+	bool valid;
+
+	valid = fsverity_verify_blocks(bh->b_page, bh->b_size, bh_offset(bh));
+	end_buffer_async_read(bh, valid);
+	kfree(ctx);
+}
+
+static bool need_fsverity(struct buffer_head *bh)
+{
+	struct page *page = bh->b_page;
+	struct inode *inode = page->mapping->host;
+
+	return fsverity_active(inode) &&
+		/* needed by ext4 */
+		page->index < DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
+}
+
 static void decrypt_bh(struct work_struct *work)
 {
-	struct decrypt_bh_ctx *ctx =
-		container_of(work, struct decrypt_bh_ctx, work);
+	struct postprocess_bh_ctx *ctx =
+		container_of(work, struct postprocess_bh_ctx, work);
 	struct buffer_head *bh = ctx->bh;
 	int err;
 
 	err = fscrypt_decrypt_pagecache_blocks(bh->b_page, bh->b_size,
 					       bh_offset(bh));
+	if (err == 0 && need_fsverity(bh)) {
+		/*
+		 * We use different work queues for decryption and for verity
+		 * because verity may require reading metadata pages that need
+		 * decryption, and we shouldn't recurse to the same workqueue.
+		 */
+		INIT_WORK(&ctx->work, verify_bh);
+		fsverity_enqueue_verify_work(&ctx->work);
+		return;
+	}
 	end_buffer_async_read(bh, err == 0);
 	kfree(ctx);
 }
@@ -319,15 +352,24 @@ static void decrypt_bh(struct work_struct *work)
  */
 static void end_buffer_async_read_io(struct buffer_head *bh, int uptodate)
 {
-	/* Decrypt if needed */
-	if (uptodate &&
-	    fscrypt_inode_uses_fs_layer_crypto(bh->b_page->mapping->host)) {
-		struct decrypt_bh_ctx *ctx = kmalloc(sizeof(*ctx), GFP_ATOMIC);
+	struct inode *inode = bh->b_page->mapping->host;
+	bool decrypt = fscrypt_inode_uses_fs_layer_crypto(inode);
+	bool verify = need_fsverity(bh);
+
+	/* Decrypt (with fscrypt) and/or verify (with fsverity) if needed. */
+	if (uptodate && (decrypt || verify)) {
+		struct postprocess_bh_ctx *ctx =
+			kmalloc(sizeof(*ctx), GFP_ATOMIC);
 
 		if (ctx) {
-			INIT_WORK(&ctx->work, decrypt_bh);
 			ctx->bh = bh;
-			fscrypt_enqueue_decrypt_work(&ctx->work);
+			if (decrypt) {
+				INIT_WORK(&ctx->work, decrypt_bh);
+				fscrypt_enqueue_decrypt_work(&ctx->work);
+			} else {
+				INIT_WORK(&ctx->work, verify_bh);
+				fsverity_enqueue_verify_work(&ctx->work);
+			}
 			return;
 		}
 		uptodate = 0;
@@ -2245,6 +2287,11 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 	int nr, i;
 	int fully_mapped = 1;
 	bool page_error = false;
+	loff_t limit = i_size_read(inode);
+
+	/* This is needed for ext4. */
+	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
+		limit = inode->i_sb->s_maxbytes;
 
 	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
 
@@ -2253,7 +2300,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 	bbits = block_size_bits(blocksize);
 
 	iblock = (sector_t)folio->index << (PAGE_SHIFT - bbits);
-	lblock = (i_size_read(inode)+blocksize-1) >> bbits;
+	lblock = (limit+blocksize-1) >> bbits;
 	bh = head;
 	nr = 0;
 	i = 0;
-- 
2.39.0

