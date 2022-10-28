Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D12611DAC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Oct 2022 00:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiJ1Wrw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 18:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiJ1Wrs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:47:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99331DE3EC;
        Fri, 28 Oct 2022 15:47:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 859D162AC8;
        Fri, 28 Oct 2022 22:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B18C4347C;
        Fri, 28 Oct 2022 22:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666997266;
        bh=TIPDTx2LUw4vx8E38rt9OO0EAC7WyDogJc0vLXFp3gY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=prnT5TA3ENz77NTNdV+c9bCieHMI/QrZSKTizjWQ916UJ5X+s6Hlh7fbZl1PMmUgL
         QkTU8Z3btWM3HLzOSZUqqqdDaXKhHD0o5Nd1YZJ2npy4WCgiK8CAcBkqej4hle22sH
         44SNdI2+T0ES5EaHJpEqv6+BoLJ57ZeFnNegqpzzb98VrADluq9B6Ri5kihaeVwaV+
         9/CuWdrJARI/nCuTkX8vmeL4XFs3c7/1I4KxtxKFOCPGQvjzR0b2s08P8TdYnePpMC
         dQ5Z5aX/75R806VvVd0wU4GyDfweo1mAQ+zFAordRj1+Ca/upMrLi8CCY0yaNIEB0j
         Cgr3K4lrGKwFA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org
Subject: [PATCH 5/6] fs/buffer.c: support fsverity in block_read_full_folio()
Date:   Fri, 28 Oct 2022 15:45:38 -0700
Message-Id: <20221028224539.171818-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221028224539.171818-1-ebiggers@kernel.org>
References: <20221028224539.171818-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 fs/buffer.c | 66 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 10 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index d9c6d1fbb6dde..bea0f63031129 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -48,6 +48,7 @@
 #include <linux/sched/mm.h>
 #include <trace/events/block.h>
 #include <linux/fscrypt.h>
+#include <linux/fsverity.h>
 
 #include "internal.h"
 
@@ -295,20 +296,51 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
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
+	struct inode *inode = bh->b_page->mapping->host;
+
+	return fsverity_active(inode) &&
+		/* needed by ext4 */
+		bh->b_page->index < DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
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
@@ -319,15 +351,24 @@ static void decrypt_bh(struct work_struct *work)
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
@@ -2245,6 +2286,11 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 	int nr, i;
 	int fully_mapped = 1;
 	bool page_error = false;
+	loff_t limit = i_size_read(inode);
+
+	/* This is needed for ext4. */
+	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
+		limit = inode->i_sb->s_maxbytes;
 
 	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
 
@@ -2253,7 +2299,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 	bbits = block_size_bits(blocksize);
 
 	iblock = (sector_t)folio->index << (PAGE_SHIFT - bbits);
-	lblock = (i_size_read(inode)+blocksize-1) >> bbits;
+	lblock = (limit+blocksize-1) >> bbits;
 	bh = head;
 	nr = 0;
 	i = 0;
-- 
2.38.0

