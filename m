Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91F555C885
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiF0Gv5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 02:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiF0Gv4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:51:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2FD26C5;
        Sun, 26 Jun 2022 23:51:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D61A2612DB;
        Mon, 27 Jun 2022 06:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B4BC341CA;
        Mon, 27 Jun 2022 06:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656312714;
        bh=+AyvxCvn4yrPcBcWfqYEVWf1b1GQlpHfuY/Cybxb1qo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u0kyDImxb6ZyniuA/XFG2ZruQkJXYj/PfvDeFPPIezA765VThYsDr0ji2oiz5QF3F
         s1jByKAMJMVVEXc5AuuOQLBnBq86wBerTj9/815un4oI9ozaoP0eeS8AWP9+7tAT6R
         7RX3MwLUokZiHug3h6a3TdaiphQDUbgY2Uzbsm5xq75/eqw0FN1OcWMYObRQLFxedC
         mn2dPEufhuVilIqA//hKPekPP9ycmFsNDul+tU66lBUF/sVnnJTaiJf0nDTcB+KBaS
         l2sT2EGU5EygVJobO9Jr3V9xkWr750hBsJUGi3Tg3rMkO8virBGT3EjrFsh0tGIULe
         48KLCemLgTGpQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 1/2] fscrypt: stop using PG_error to track error status
Date:   Sun, 26 Jun 2022 23:50:49 -0700
Message-Id: <20220627065050.274716-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627065050.274716-1-ebiggers@kernel.org>
References: <20220627065050.274716-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

As a step towards freeing the PG_error flag for other uses, change ext4
and f2fs to stop using PG_error to track decryption errors.  Instead, if
a decryption error occurs, just mark the whole bio as failed.  The
coarser granularity isn't really a problem since it isn't any worse than
what the block layer provides, and errors from a multi-page readahead
aren't reported to applications unless a single-page read fails too.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/bio.c         | 16 ++++++++++------
 fs/ext4/readpage.c      |  8 +++++---
 fs/f2fs/data.c          | 17 +++++++++--------
 include/linux/fscrypt.h |  5 +++--
 4 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 2217fe5ece6f9..1b4403136d05c 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -25,21 +25,25 @@
  * then this function isn't applicable.  This function may sleep, so it must be
  * called from a workqueue rather than from the bio's bi_end_io callback.
  *
- * This function sets PG_error on any pages that contain any blocks that failed
- * to be decrypted.  The filesystem must not mark such pages uptodate.
+ * Return: %true on success; %false on failure.  On failure, bio->bi_status is
+ *	   also set to an error status.
  */
-void fscrypt_decrypt_bio(struct bio *bio)
+bool fscrypt_decrypt_bio(struct bio *bio)
 {
 	struct bio_vec *bv;
 	struct bvec_iter_all iter_all;
 
 	bio_for_each_segment_all(bv, bio, iter_all) {
 		struct page *page = bv->bv_page;
-		int ret = fscrypt_decrypt_pagecache_blocks(page, bv->bv_len,
+		int err = fscrypt_decrypt_pagecache_blocks(page, bv->bv_len,
 							   bv->bv_offset);
-		if (ret)
-			SetPageError(page);
+
+		if (err) {
+			bio->bi_status = errno_to_blk_status(err);
+			return false;
+		}
 	}
+	return true;
 }
 EXPORT_SYMBOL(fscrypt_decrypt_bio);
 
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index e02a5f14e0211..5ce4706f68a7c 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -96,10 +96,12 @@ static void decrypt_work(struct work_struct *work)
 {
 	struct bio_post_read_ctx *ctx =
 		container_of(work, struct bio_post_read_ctx, work);
+	struct bio *bio = ctx->bio;
 
-	fscrypt_decrypt_bio(ctx->bio);
-
-	bio_post_read_processing(ctx);
+	if (fscrypt_decrypt_bio(bio))
+		bio_post_read_processing(ctx);
+	else
+		__read_end_io(bio);
 }
 
 static void verity_work(struct work_struct *work)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7fcbcf9797372..47065f17d579c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -138,7 +138,7 @@ static void f2fs_finish_read_bio(struct bio *bio)
 			continue;
 		}
 
-		/* PG_error was set if decryption or verity failed. */
+		/* PG_error was set if verity failed. */
 		if (bio->bi_status || PageError(page)) {
 			ClearPageUptodate(page);
 			/* will re-read again later */
@@ -184,7 +184,7 @@ static void f2fs_verify_bio(struct work_struct *work)
 			struct page *page = bv->bv_page;
 
 			if (!f2fs_is_compressed_page(page) &&
-			    !PageError(page) && !fsverity_verify_page(page))
+			    !fsverity_verify_page(page))
 				SetPageError(page);
 		}
 	} else {
@@ -234,10 +234,8 @@ static void f2fs_handle_step_decompress(struct bio_post_read_ctx *ctx)
 	bio_for_each_segment_all(bv, ctx->bio, iter_all) {
 		struct page *page = bv->bv_page;
 
-		/* PG_error was set if decryption failed. */
 		if (f2fs_is_compressed_page(page))
-			f2fs_end_read_compressed_page(page, PageError(page),
-						blkaddr);
+			f2fs_end_read_compressed_page(page, false, blkaddr);
 		else
 			all_compressed = false;
 
@@ -257,14 +255,17 @@ static void f2fs_post_read_work(struct work_struct *work)
 {
 	struct bio_post_read_ctx *ctx =
 		container_of(work, struct bio_post_read_ctx, work);
+	struct bio *bio = ctx->bio;
 
-	if (ctx->enabled_steps & STEP_DECRYPT)
-		fscrypt_decrypt_bio(ctx->bio);
+	if ((ctx->enabled_steps & STEP_DECRYPT) && !fscrypt_decrypt_bio(bio)) {
+		f2fs_finish_read_bio(bio);
+		return;
+	}
 
 	if (ctx->enabled_steps & STEP_DECOMPRESS)
 		f2fs_handle_step_decompress(ctx);
 
-	f2fs_verify_and_finish_bio(ctx->bio);
+	f2fs_verify_and_finish_bio(bio);
 }
 
 static void f2fs_read_end_io(struct bio *bio)
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index e60d57c99cb6f..e9a3a51f29632 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -348,7 +348,7 @@ u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name);
 int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags);
 
 /* bio.c */
-void fscrypt_decrypt_bio(struct bio *bio);
+bool fscrypt_decrypt_bio(struct bio *bio);
 int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 			  sector_t pblk, unsigned int len);
 
@@ -641,8 +641,9 @@ static inline int fscrypt_d_revalidate(struct dentry *dentry,
 }
 
 /* bio.c */
-static inline void fscrypt_decrypt_bio(struct bio *bio)
+static inline bool fscrypt_decrypt_bio(struct bio *bio)
 {
+	return true;
 }
 
 static inline int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,

-- 
2.36.1

