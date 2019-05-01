Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E84F10F42
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 00:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfEAWqH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 18:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfEAWqG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 18:46:06 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E47A208C3;
        Wed,  1 May 2019 22:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556750765;
        bh=C8QCwapKW3U1NG9FA0FfajgZX249u2BatzzbutlTbHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xWesjP6+4N/fUY8sdSJYz9/5AYkoS6EJvOsiD+JWTI+4Os9xkz2f/ugmZtas1Mmma
         cZUS6psNpUcyFRIqGQ78jdprtiEFiQSiW+CkONgDZ2k3Rz7VaDuyQWfitlNFiyrnYC
         0ydXH9LfZ/HI982B1LZzpaIXx4QGiQfYd1iVStUY=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Chandan Rajendra <chandan@linux.ibm.com>
Subject: [PATCH 02/13] fscrypt: remove the "write" part of struct fscrypt_ctx
Date:   Wed,  1 May 2019 15:45:04 -0700
Message-Id: <20190501224515.43059-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190501224515.43059-1-ebiggers@kernel.org>
References: <20190501224515.43059-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Now that fscrypt_ctx is not used for writes, remove the 'w' fields.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/bio.c         | 11 +++++------
 fs/crypto/crypto.c      | 14 +++++++-------
 include/linux/fscrypt.h |  7 ++-----
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 9107e8fe55897..548ec6bb569cf 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -54,9 +54,8 @@ EXPORT_SYMBOL(fscrypt_decrypt_bio);
 
 static void completion_pages(struct work_struct *work)
 {
-	struct fscrypt_ctx *ctx =
-		container_of(work, struct fscrypt_ctx, r.work);
-	struct bio *bio = ctx->r.bio;
+	struct fscrypt_ctx *ctx = container_of(work, struct fscrypt_ctx, work);
+	struct bio *bio = ctx->bio;
 
 	__fscrypt_decrypt_bio(bio, true);
 	fscrypt_release_ctx(ctx);
@@ -65,9 +64,9 @@ static void completion_pages(struct work_struct *work)
 
 void fscrypt_enqueue_decrypt_bio(struct fscrypt_ctx *ctx, struct bio *bio)
 {
-	INIT_WORK(&ctx->r.work, completion_pages);
-	ctx->r.bio = bio;
-	fscrypt_enqueue_decrypt_work(&ctx->r.work);
+	INIT_WORK(&ctx->work, completion_pages);
+	ctx->bio = bio;
+	fscrypt_enqueue_decrypt_work(&ctx->work);
 }
 EXPORT_SYMBOL(fscrypt_enqueue_decrypt_bio);
 
diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 4b076f8daab75..ebfa13cfecb7d 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -58,11 +58,11 @@ void fscrypt_enqueue_decrypt_work(struct work_struct *work)
 EXPORT_SYMBOL(fscrypt_enqueue_decrypt_work);
 
 /**
- * fscrypt_release_ctx() - Releases an encryption context
- * @ctx: The encryption context to release.
+ * fscrypt_release_ctx() - Release a decryption context
+ * @ctx: The decryption context to release.
  *
- * If the encryption context was allocated from the pre-allocated pool, returns
- * it to that pool. Else, frees it.
+ * If the decryption context was allocated from the pre-allocated pool, return
+ * it to that pool.  Else, free it.
  */
 void fscrypt_release_ctx(struct fscrypt_ctx *ctx)
 {
@@ -79,12 +79,12 @@ void fscrypt_release_ctx(struct fscrypt_ctx *ctx)
 EXPORT_SYMBOL(fscrypt_release_ctx);
 
 /**
- * fscrypt_get_ctx() - Gets an encryption context
+ * fscrypt_get_ctx() - Get a decryption context
  * @gfp_flags:   The gfp flag for memory allocation
  *
- * Allocates and initializes an encryption context.
+ * Allocate and initialize a decryption context.
  *
- * Return: A new encryption context on success; an ERR_PTR() otherwise.
+ * Return: A new decryption context on success; an ERR_PTR() otherwise.
  */
 struct fscrypt_ctx *fscrypt_get_ctx(gfp_t gfp_flags)
 {
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 77837e72e4add..11e7187fa2e52 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -63,16 +63,13 @@ struct fscrypt_operations {
 	unsigned int max_namelen;
 };
 
+/* Decryption work */
 struct fscrypt_ctx {
 	union {
-		struct {
-			struct page *bounce_page;	/* Ciphertext page */
-			struct page *control_page;	/* Original page  */
-		} w;
 		struct {
 			struct bio *bio;
 			struct work_struct work;
-		} r;
+		};
 		struct list_head free_list;	/* Free list */
 	};
 	u8 flags;				/* Flags */
-- 
2.21.0.593.g511ec345e18-goog

