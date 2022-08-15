Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20982595265
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 08:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiHPGKg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 02:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiHPGKG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:10:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7683033FB;
        Mon, 15 Aug 2022 16:51:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 059BBB811BF;
        Mon, 15 Aug 2022 23:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEFEC433D6;
        Mon, 15 Aug 2022 23:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660607503;
        bh=iXxQk1hszc9wAswA+G0HsmfnsoSaY8rCsUwpSpNAKas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PE3mHYNg8gf6VY/wUxXUPk+CieVfAFv6IoPfxXHTYHB7hpnZsLGz0ebeNs5loaX5u
         TZYKPOq1OmnJel+b5QLpzXOS6hzgKekPAbMpTuaW88/CVMbauXE+MUbRXBGpKh2Hml
         meWjr654b2+5w+m2pfkTbFpYqd5PH7XzYRSRjo+WE6hW+ARHxn0n2Xeo/KEX7By9Rb
         68h9CQoAwGDmdnggPStzgUKbYPXT/4GUWrEnX+Q7MAltJT8N9SiIumpJ9TQE+iYhoP
         9gD4dv19gqmYnsVtG2xr4N3fDC5x3WyUR9M8Y+QIJW92pR4EmyXF4zIsirnYW/MlMH
         wOkCmJG+2xebA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 1/2] fscrypt: stop using PG_error to track error status
Date:   Mon, 15 Aug 2022 16:50:51 -0700
Message-Id: <20220815235052.86545-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815235052.86545-1-ebiggers@kernel.org>
References: <20220815235052.86545-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 fs/f2fs/data.c          | 18 ++++++++++--------
 include/linux/fscrypt.h |  5 +++--
 4 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 2217fe5ece6f9b..1b4403136d05c0 100644
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
index e02a5f14e0211e..5ce4706f68a7c6 100644
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
index aa3ccddfa03761..93cc2ec51c2aeb 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -139,7 +139,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 			continue;
 		}
 
-		/* PG_error was set if decryption or verity failed. */
+		/* PG_error was set if verity failed. */
 		if (bio->bi_status || PageError(page)) {
 			ClearPageUptodate(page);
 			/* will re-read again later */
@@ -185,7 +185,7 @@ static void f2fs_verify_bio(struct work_struct *work)
 			struct page *page = bv->bv_page;
 
 			if (!f2fs_is_compressed_page(page) &&
-			    !PageError(page) && !fsverity_verify_page(page))
+			    !fsverity_verify_page(page))
 				SetPageError(page);
 		}
 	} else {
@@ -236,10 +236,9 @@ static void f2fs_handle_step_decompress(struct bio_post_read_ctx *ctx,
 	bio_for_each_segment_all(bv, ctx->bio, iter_all) {
 		struct page *page = bv->bv_page;
 
-		/* PG_error was set if decryption failed. */
 		if (f2fs_is_compressed_page(page))
-			f2fs_end_read_compressed_page(page, PageError(page),
-						blkaddr, in_task);
+			f2fs_end_read_compressed_page(page, false, blkaddr,
+						      in_task);
 		else
 			all_compressed = false;
 
@@ -259,14 +258,17 @@ static void f2fs_post_read_work(struct work_struct *work)
 {
 	struct bio_post_read_ctx *ctx =
 		container_of(work, struct bio_post_read_ctx, work);
+	struct bio *bio = ctx->bio;
 
-	if (ctx->enabled_steps & STEP_DECRYPT)
-		fscrypt_decrypt_bio(ctx->bio);
+	if ((ctx->enabled_steps & STEP_DECRYPT) && !fscrypt_decrypt_bio(bio)) {
+		f2fs_finish_read_bio(bio, true);
+		return;
+	}
 
 	if (ctx->enabled_steps & STEP_DECOMPRESS)
 		f2fs_handle_step_decompress(ctx, true);
 
-	f2fs_verify_and_finish_bio(ctx->bio, true);
+	f2fs_verify_and_finish_bio(bio, true);
 }
 
 static void f2fs_read_end_io(struct bio *bio)
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 7d2f1e0f23b1fe..10c645685b32c2 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -353,7 +353,7 @@ u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name);
 int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags);
 
 /* bio.c */
-void fscrypt_decrypt_bio(struct bio *bio);
+bool fscrypt_decrypt_bio(struct bio *bio);
 int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 			  sector_t pblk, unsigned int len);
 
@@ -646,8 +646,9 @@ static inline int fscrypt_d_revalidate(struct dentry *dentry,
 }
 
 /* bio.c */
-static inline void fscrypt_decrypt_bio(struct bio *bio)
+static inline bool fscrypt_decrypt_bio(struct bio *bio)
 {
+	return true;
 }
 
 static inline int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
-- 
2.37.1

