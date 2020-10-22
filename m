Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAF6296691
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 23:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372287AbgJVVW6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 17:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372232AbgJVVWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 17:22:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCD1C0613D6;
        Thu, 22 Oct 2020 14:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ljAA4PGd/GSmX+kkh/i6lw2/EaP+AhT2hL7GA28WXSQ=; b=AF9rUsfI+8g5rTMEZGeaJnZ8QA
        Rt/ef7DEtRmk8GSl6EY20t+Gf/mTE+Dc9s8MDNmXl283W3Pppo8IVftue49/Qpq/DqwQEzVWwh/YN
        KZ8w8VrMsbjOmDE3wlx5LESl0wk84wJry96DjMVtSqP5J973VE820NPe+afNVOccPGbawER146eve
        y0tnsnpUYZRfDdapTk8Dr5VJj46BpIVFp1bgqiHWNXUFm6OjWVS8gUIibYrP2a707LppAfsEDBnwr
        5RLTxDg2Zpp4LgB8mxoD8Go5WKOOhx6Y5yh3kUwmOmNjztLxOdKxNbfirsrifgQz80Jz2fPq7Q/Sj
        BQaOhQfA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVi2Z-00046d-6A; Thu, 22 Oct 2020 21:22:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 5/6] fs: Turn decrypt_bh into decrypt_bio
Date:   Thu, 22 Oct 2020 22:22:27 +0100
Message-Id: <20201022212228.15703-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201022212228.15703-1-willy@infradead.org>
References: <20201022212228.15703-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass a bio to decrypt_bio instead of a buffer_head to decrypt_bh.
Another step towards doing decryption per-BIO instead of per-BH.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 627ae1d853c0..f859e0929b7e 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -299,22 +299,24 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 	return;
 }
 
-struct decrypt_bh_ctx {
+struct decrypt_bio_ctx {
 	struct work_struct work;
-	struct buffer_head *bh;
+	struct bio *bio;
 };
 
-static void decrypt_bh(struct work_struct *work)
+static void decrypt_bio(struct work_struct *work)
 {
-	struct decrypt_bh_ctx *ctx =
-		container_of(work, struct decrypt_bh_ctx, work);
-	struct buffer_head *bh = ctx->bh;
+	struct decrypt_bio_ctx *ctx =
+		container_of(work, struct decrypt_bio_ctx, work);
+	struct bio *bio = ctx->bio;
+	struct buffer_head *bh = bio->bi_private;
 	int err;
 
 	err = fscrypt_decrypt_pagecache_blocks(bh->b_page, bh->b_size,
 					       bh_offset(bh));
 	end_buffer_async_read(bh, err == 0);
 	kfree(ctx);
+	bio_put(bio);
 }
 
 /*
@@ -3093,13 +3095,12 @@ static void end_bio_bh_io_sync(struct bio *bio)
 	/* Decrypt if needed */
 	if ((bio_data_dir(bio) == READ) && uptodate &&
 	    fscrypt_inode_uses_fs_layer_crypto(bh->b_page->mapping->host)) {
-		struct decrypt_bh_ctx *ctx = kmalloc(sizeof(*ctx), GFP_ATOMIC);
+		struct decrypt_bio_ctx *ctx = kmalloc(sizeof(*ctx), GFP_ATOMIC);
 
 		if (ctx) {
-			INIT_WORK(&ctx->work, decrypt_bh);
-			ctx->bh = bh;
+			INIT_WORK(&ctx->work, decrypt_bio);
+			ctx->bio = bio;
 			fscrypt_enqueue_decrypt_work(&ctx->work);
-			bio_put(bio);
 			return;
 		}
 		uptodate = 0;
-- 
2.28.0

