Return-Path: <linux-fsdevel+bounces-66571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93302C24315
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 10:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31251886FB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 09:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4363321C0;
	Fri, 31 Oct 2025 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IfAUy+nw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339B2329E7C;
	Fri, 31 Oct 2025 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903362; cv=none; b=AfE82B/xKeSYa7zsUVdA+mumxR5tO6QhXZfXsYKzLXJqlO/8z46/h6Vnvhb2y9XFZNLUzE0lPJ9g2DuCl9g+nf6YpDCR2jnOAt2lOcDniE51Klp0gzoIVpjycMdq7kBCFHa7bXgFfidDE2CuxW9Ul3g2H/jvttUIGkTlFCmmpgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903362; c=relaxed/simple;
	bh=EhEDiouZ0XSRg6A1nq3V0bZ5tMrUeNEvhN8TaIPNHbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xkql+crnWuJVGJ6eSH/4PX3zNXXB4T+3qaP2B5iEgV5+3OHYJyv7LhifzJglMlBu/ovblh+u/Q8aOkaZUZuoC9tnorByo8iHOlLMimqD8hx3ZldxmEEsEDc+eOLe1s4OiaCaSuY/sc9HEWsFLFDMrSTyrIrqHjpLvEWKlz4QxOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IfAUy+nw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9bgCK/HDxzSzQrdE+Xf4XP2+fNlLmDG4ZZ31ZtAuHoo=; b=IfAUy+nwyydQcgX6j7d3A7Eej+
	WHee4l4K7br2TNcG+/G0N5dX+aotB6xOIYftqesme0rFmAFMcqHo6lqAI42hz/bQkcVWpcyjMyzbF
	kKVyfrCQ+N6AazSJ0zjjNGw56cSnMh0nJgsFGEMLnmBcc+AdxLNvrHe0CCMbUZOry7HDoKfW+ko91
	yybjt8SWqtCzDIXYzMpiaNSBCqIOJrBem2U3jbrItwb2GfBlhWWdMgClLk4eseAp4A3titDJWkgM/
	6BYU6mWHmYFX5qquUwJ77QbH8j6t7/3ezgXfJyhNXAb2qR2D9TGsiqZuwQRxWB6emSc4JAdwMAzWg
	4NNQmj9g==;
Received: from [2001:4bb8:2dc:1001:a959:25cf:98e9:329b] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vElY5-00000005osF-2QQ0;
	Fri, 31 Oct 2025 09:35:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 7/9] blk-crypto: handle the fallback above the block layer
Date: Fri, 31 Oct 2025 10:34:37 +0100
Message-ID: <20251031093517.1603379-8-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251031093517.1603379-1-hch@lst.de>
References: <20251031093517.1603379-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a blk_crypto_submit_bio helper that either submits the bio when
it is not encrypted or inline encryption is provided, but otherwise
handles the encryption before going down into the low-level driver.
This reduces the risk from bio reordering and keeps memory allocation
as high up in the stack as possible.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c            | 10 ++--
 block/blk-crypto-fallback.c | 97 ++++++++++++++++---------------------
 block/blk-crypto-internal.h | 31 ++++++------
 block/blk-crypto.c          | 65 +++++++++----------------
 fs/buffer.c                 |  3 +-
 fs/crypto/bio.c             |  2 +-
 fs/ext4/page-io.c           |  3 +-
 fs/ext4/readpage.c          |  9 ++--
 fs/f2fs/data.c              |  4 +-
 fs/f2fs/file.c              |  3 +-
 fs/iomap/direct-io.c        |  3 +-
 include/linux/blk-crypto.h  | 16 ++++++
 12 files changed, 116 insertions(+), 130 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 14ae73eebe0d..108b85eb3b9d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -628,9 +628,6 @@ static void __submit_bio(struct bio *bio)
 	/* If plug is not used, add new plug here to cache nsecs time. */
 	struct blk_plug plug;
 
-	if (unlikely(!blk_crypto_bio_prep(&bio)))
-		return;
-
 	blk_start_plug(&plug);
 
 	if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
@@ -794,6 +791,13 @@ void submit_bio_noacct(struct bio *bio)
 	if ((bio->bi_opf & REQ_NOWAIT) && !bdev_nowait(bdev))
 		goto not_supported;
 
+	if (bio_has_crypt_ctx(bio)) {
+		if (WARN_ON_ONCE(!bio_has_data(bio)))
+			goto end_io;
+		if (!blk_crypto_supported(bio))
+			goto not_supported;
+	}
+
 	if (should_fail_bio(bio))
 		goto end_io;
 	bio_check_ro(bio);
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 1f58010fb437..16a1809e2667 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -141,6 +141,26 @@ static const struct blk_crypto_ll_ops blk_crypto_fallback_ll_ops = {
 	.keyslot_evict          = blk_crypto_fallback_keyslot_evict,
 };
 
+static bool blk_crypto_fallback_bio_valid(struct bio *bio)
+{
+	struct bio_crypt_ctx *bc = bio->bi_crypt_context;
+
+	if (WARN_ON_ONCE(!tfms_inited[bc->bc_key->crypto_cfg.crypto_mode])) {
+		/* User didn't call blk_crypto_start_using_key() first */
+		bio_io_error(bio);
+		return false;
+	}
+
+	if (!__blk_crypto_cfg_supported(blk_crypto_fallback_profile,
+					&bc->bc_key->crypto_cfg)) {
+		bio->bi_status = BLK_STS_NOTSUPP;
+		bio_endio(bio);
+		return false;
+	}
+
+	return true;
+}
+
 static void blk_crypto_fallback_encrypt_endio(struct bio *enc_bio)
 {
 	struct bio *src_bio = enc_bio->bi_private;
@@ -214,15 +234,12 @@ static void blk_crypto_dun_to_iv(const u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
 }
 
 /*
- * The crypto API fallback's encryption routine.
- * Allocate a bounce bio for encryption, encrypt the input bio using crypto API,
- * and replace *bio_ptr with the bounce bio. May split input bio if it's too
- * large. Returns true on success. Returns false and sets bio->bi_status on
- * error.
+ * The crypto API fallback's encryption routine.  Allocates a bounce bio for
+ * encryption, encrypts the input bio using crypto API and submits the bounce
+ * bio.
  */
-static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
+void blk_crypto_fallback_encrypt_bio(struct bio *src_bio)
 {
-	struct bio *src_bio = *bio_ptr;
 	struct bio_crypt_ctx *bc = src_bio->bi_crypt_context;
 	int data_unit_size = bc->bc_key->crypto_cfg.data_unit_size;
 	struct skcipher_request *ciph_req = NULL;
@@ -235,9 +252,11 @@ static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
 	unsigned int nr_segs;
 	unsigned int enc_idx = 0;
 	unsigned int j;
-	bool ret = false;
 	blk_status_t blk_st;
 
+	if (!blk_crypto_fallback_bio_valid(src_bio))
+		return;
+
 	/*
 	 * Get a blk-crypto-fallback keyslot that contains a crypto_skcipher for
 	 * this bio's algorithm and key.
@@ -246,7 +265,7 @@ static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
 					bc->bc_key, &slot);
 	if (blk_st != BLK_STS_OK) {
 		src_bio->bi_status = blk_st;
-		return false;
+		goto endio;
 	}
 
 	/* and then allocate an skcipher_request for it */
@@ -313,13 +332,10 @@ static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
 		nr_segs--;
 	}
 
-	*bio_ptr = enc_bio;
-	ret = true;
-out_free_ciph_req:
 	skcipher_request_free(ciph_req);
-out_release_keyslot:
 	blk_crypto_put_keyslot(slot);
-	return ret;
+	submit_bio(enc_bio);
+	return;
 
 out_ioerror:
 	while (enc_idx > 0)
@@ -327,7 +343,11 @@ static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
 			     blk_crypto_bounce_page_pool);
 	bio_put(enc_bio);
 	src_bio->bi_status = BLK_STS_IOERR;
-	goto out_free_ciph_req;
+	skcipher_request_free(ciph_req);
+out_release_keyslot:
+	blk_crypto_put_keyslot(slot);
+endio:
+	bio_endio(src_bio);
 }
 
 /*
@@ -428,60 +448,25 @@ static void blk_crypto_fallback_decrypt_endio(struct bio *bio)
 	queue_work(blk_crypto_wq, &f_ctx->work);
 }
 
-/**
- * blk_crypto_fallback_bio_prep - Prepare a bio to use fallback en/decryption
- *
- * @bio_ptr: pointer to the bio to prepare
- *
- * If bio is doing a WRITE operation, this splits the bio into two parts if it's
- * too big (see blk_crypto_fallback_split_bio_if_needed()). It then allocates a
- * bounce bio for the first part, encrypts it, and updates bio_ptr to point to
- * the bounce bio.
- *
- * For a READ operation, we mark the bio for decryption by using bi_private and
- * bi_end_io.
- *
- * In either case, this function will make the bio look like a regular bio (i.e.
- * as if no encryption context was ever specified) for the purposes of the rest
- * of the stack except for blk-integrity (blk-integrity and blk-crypto are not
- * currently supported together).
- *
- * Return: true on success. Sets bio->bi_status and returns false on error.
+/*
+ * bio READ case: Set up a f_ctx in the bio's bi_private and set the bi_end_io
+ * appropriately to trigger decryption when the bio is ended.
  */
-bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr)
+bool blk_crypto_fallback_prep_decrypt_bio(struct bio *bio)
 {
-	struct bio *bio = *bio_ptr;
-	struct bio_crypt_ctx *bc = bio->bi_crypt_context;
 	struct bio_fallback_crypt_ctx *f_ctx;
 
-	if (WARN_ON_ONCE(!tfms_inited[bc->bc_key->crypto_cfg.crypto_mode])) {
-		/* User didn't call blk_crypto_start_using_key() first */
-		bio->bi_status = BLK_STS_IOERR;
+	if (!blk_crypto_fallback_bio_valid(bio))
 		return false;
-	}
 
-	if (!__blk_crypto_cfg_supported(blk_crypto_fallback_profile,
-					&bc->bc_key->crypto_cfg)) {
-		bio->bi_status = BLK_STS_NOTSUPP;
-		return false;
-	}
-
-	if (bio_data_dir(bio) == WRITE)
-		return blk_crypto_fallback_encrypt_bio(bio_ptr);
-
-	/*
-	 * bio READ case: Set up a f_ctx in the bio's bi_private and set the
-	 * bi_end_io appropriately to trigger decryption when the bio is ended.
-	 */
 	f_ctx = mempool_alloc(bio_fallback_crypt_ctx_pool, GFP_NOIO);
-	f_ctx->crypt_ctx = *bc;
+	f_ctx->crypt_ctx = *bio->bi_crypt_context;
 	f_ctx->crypt_iter = bio->bi_iter;
 	f_ctx->bi_private_orig = bio->bi_private;
 	f_ctx->bi_end_io_orig = bio->bi_end_io;
 	bio->bi_private = (void *)f_ctx;
 	bio->bi_end_io = blk_crypto_fallback_decrypt_endio;
 	bio_crypt_free_ctx(bio);
-
 	return true;
 }
 
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index ccf6dff6ff6b..22ac87f44b46 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -86,6 +86,12 @@ bool __blk_crypto_cfg_supported(struct blk_crypto_profile *profile,
 int blk_crypto_ioctl(struct block_device *bdev, unsigned int cmd,
 		     void __user *argp);
 
+static inline bool blk_crypto_supported(struct bio *bio)
+{
+	return blk_crypto_config_supported_natively(bio->bi_bdev,
+			&bio->bi_crypt_context->bc_key->crypto_cfg);
+}
+
 #else /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 static inline int blk_crypto_sysfs_register(struct gendisk *disk)
@@ -139,6 +145,11 @@ static inline int blk_crypto_ioctl(struct block_device *bdev, unsigned int cmd,
 	return -ENOTTY;
 }
 
+static inline bool blk_crypto_supported(struct bio *bio)
+{
+	return false;
+}
+
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 void __bio_crypt_advance(struct bio *bio, unsigned int bytes);
@@ -165,14 +176,6 @@ static inline void bio_crypt_do_front_merge(struct request *rq,
 #endif
 }
 
-bool __blk_crypto_bio_prep(struct bio **bio_ptr);
-static inline bool blk_crypto_bio_prep(struct bio **bio_ptr)
-{
-	if (bio_has_crypt_ctx(*bio_ptr))
-		return __blk_crypto_bio_prep(bio_ptr);
-	return true;
-}
-
 blk_status_t __blk_crypto_rq_get_keyslot(struct request *rq);
 static inline blk_status_t blk_crypto_rq_get_keyslot(struct request *rq)
 {
@@ -215,12 +218,13 @@ static inline int blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio,
 	return 0;
 }
 
+bool blk_crypto_fallback_prep_decrypt_bio(struct bio *bio);
+void blk_crypto_fallback_encrypt_bio(struct bio *orig_bio);
+
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK
 
 int blk_crypto_fallback_start_using_mode(enum blk_crypto_mode_num mode_num);
 
-bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr);
-
 int blk_crypto_fallback_evict_key(const struct blk_crypto_key *key);
 
 #else /* CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK */
@@ -232,13 +236,6 @@ blk_crypto_fallback_start_using_mode(enum blk_crypto_mode_num mode_num)
 	return -ENOPKG;
 }
 
-static inline bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr)
-{
-	pr_warn_once("crypto API fallback disabled; failing request.\n");
-	(*bio_ptr)->bi_status = BLK_STS_NOTSUPP;
-	return false;
-}
-
 static inline int
 blk_crypto_fallback_evict_key(const struct blk_crypto_key *key)
 {
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 4b1ad84d1b5a..a8f2dc2a75f6 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -258,57 +258,36 @@ void __blk_crypto_free_request(struct request *rq)
 	rq->crypt_ctx = NULL;
 }
 
-/**
- * __blk_crypto_bio_prep - Prepare bio for inline encryption
- *
- * @bio_ptr: pointer to original bio pointer
- *
- * If the bio crypt context provided for the bio is supported by the underlying
- * device's inline encryption hardware, do nothing.
- *
- * Otherwise, try to perform en/decryption for this bio by falling back to the
- * kernel crypto API. When the crypto API fallback is used for encryption,
- * blk-crypto may choose to split the bio into 2 - the first one that will
- * continue to be processed and the second one that will be resubmitted via
- * submit_bio_noacct. A bounce bio will be allocated to encrypt the contents
- * of the aforementioned "first one", and *bio_ptr will be updated to this
- * bounce bio.
- *
- * Caller must ensure bio has bio_crypt_ctx.
- *
- * Return: true on success; false on error (and bio->bi_status will be set
- *	   appropriately, and bio_endio() will have been called so bio
- *	   submission should abort).
- */
-bool __blk_crypto_bio_prep(struct bio **bio_ptr)
+bool __blk_crypto_submit_bio(struct bio *bio)
 {
-	struct bio *bio = *bio_ptr;
 	const struct blk_crypto_key *bc_key = bio->bi_crypt_context->bc_key;
 
-	/* Error if bio has no data. */
-	if (WARN_ON_ONCE(!bio_has_data(bio))) {
-		bio->bi_status = BLK_STS_IOERR;
-		goto fail;
+	if (!bio_crypt_check_alignment(bio)) {
+		bio_io_error(bio);
+		return false;
 	}
 
-	if (!bio_crypt_check_alignment(bio)) {
-		bio->bi_status = BLK_STS_IOERR;
-		goto fail;
+	if (!blk_crypto_config_supported_natively(bio->bi_bdev,
+			&bc_key->crypto_cfg)) {
+		if (!IS_ENABLED(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)) {
+			pr_warn_once("crypto API fallback disabled; failing request.\n");
+			bio->bi_status = BLK_STS_NOTSUPP;
+			bio_endio(bio);
+			return false;
+		}
+
+		if (bio_data_dir(bio) == WRITE) {
+			blk_crypto_fallback_encrypt_bio(bio);
+			return false;
+		}
+
+		if (!blk_crypto_fallback_prep_decrypt_bio(bio))
+			return false;
 	}
 
-	/*
-	 * Success if device supports the encryption context, or if we succeeded
-	 * in falling back to the crypto API.
-	 */
-	if (blk_crypto_config_supported_natively(bio->bi_bdev,
-						 &bc_key->crypto_cfg))
-		return true;
-	if (blk_crypto_fallback_bio_prep(bio_ptr))
-		return true;
-fail:
-	bio_endio(*bio_ptr);
-	return false;
+	return true;
 }
+EXPORT_SYMBOL_GPL(__blk_crypto_submit_bio);
 
 int __blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio,
 			     gfp_t gfp_mask)
diff --git a/fs/buffer.c b/fs/buffer.c
index 6a8752f7bbed..f82d2ef4276f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -29,6 +29,7 @@
 #include <linux/slab.h>
 #include <linux/capability.h>
 #include <linux/blkdev.h>
+#include <linux/blk-crypto.h>
 #include <linux/file.h>
 #include <linux/quotaops.h>
 #include <linux/highmem.h>
@@ -2821,7 +2822,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 		wbc_account_cgroup_owner(wbc, bh->b_folio, bh->b_size);
 	}
 
-	submit_bio(bio);
+	blk_crypto_submit_bio(bio);
 }
 
 void submit_bh(blk_opf_t opf, struct buffer_head *bh)
diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index e59d342b4240..f53eb0a21912 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -105,7 +105,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 		}
 
 		atomic_inc(&done.pending);
-		submit_bio(bio);
+		blk_crypto_submit_bio(bio);
 	}
 
 	fscrypt_zeroout_range_done(&done);
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 39abfeec5f36..a8c95eee91b7 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -7,6 +7,7 @@
  * Written by Theodore Ts'o, 2010.
  */
 
+#include <linux/blk-crypto.h>
 #include <linux/fs.h>
 #include <linux/time.h>
 #include <linux/highuid.h>
@@ -401,7 +402,7 @@ void ext4_io_submit(struct ext4_io_submit *io)
 	if (bio) {
 		if (io->io_wbc->sync_mode == WB_SYNC_ALL)
 			io->io_bio->bi_opf |= REQ_SYNC;
-		submit_bio(io->io_bio);
+		blk_crypto_submit_bio(io->io_bio);
 	}
 	io->io_bio = NULL;
 }
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index f329daf6e5c7..ad785dcba826 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -36,6 +36,7 @@
 #include <linux/bio.h>
 #include <linux/fs.h>
 #include <linux/buffer_head.h>
+#include <linux/blk-crypto.h>
 #include <linux/blkdev.h>
 #include <linux/highmem.h>
 #include <linux/prefetch.h>
@@ -348,7 +349,7 @@ int ext4_mpage_readpages(struct inode *inode,
 		if (bio && (last_block_in_bio != first_block - 1 ||
 			    !fscrypt_mergeable_bio(bio, inode, next_block))) {
 		submit_and_realloc:
-			submit_bio(bio);
+			blk_crypto_submit_bio(bio);
 			bio = NULL;
 		}
 		if (bio == NULL) {
@@ -374,14 +375,14 @@ int ext4_mpage_readpages(struct inode *inode,
 		if (((map.m_flags & EXT4_MAP_BOUNDARY) &&
 		     (relative_block == map.m_len)) ||
 		    (first_hole != blocks_per_folio)) {
-			submit_bio(bio);
+			blk_crypto_submit_bio(bio);
 			bio = NULL;
 		} else
 			last_block_in_bio = first_block + blocks_per_folio - 1;
 		continue;
 	confused:
 		if (bio) {
-			submit_bio(bio);
+			blk_crypto_submit_bio(bio);
 			bio = NULL;
 		}
 		if (!folio_test_uptodate(folio))
@@ -392,7 +393,7 @@ int ext4_mpage_readpages(struct inode *inode,
 		; /* A label shall be followed by a statement until C23 */
 	}
 	if (bio)
-		submit_bio(bio);
+		blk_crypto_submit_bio(bio);
 	return 0;
 }
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 775aa4f63aa3..b5816f229ae2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -513,7 +513,7 @@ void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, struct bio *bio,
 	trace_f2fs_submit_read_bio(sbi->sb, type, bio);
 
 	iostat_update_submit_ctx(bio, type);
-	submit_bio(bio);
+	blk_crypto_submit_bio(bio);
 }
 
 static void f2fs_submit_write_bio(struct f2fs_sb_info *sbi, struct bio *bio,
@@ -522,7 +522,7 @@ static void f2fs_submit_write_bio(struct f2fs_sb_info *sbi, struct bio *bio,
 	WARN_ON_ONCE(is_read_io(bio_op(bio)));
 	trace_f2fs_submit_write_bio(sbi->sb, type, bio);
 	iostat_update_submit_ctx(bio, type);
-	submit_bio(bio);
+	blk_crypto_submit_bio(bio);
 }
 
 static void __submit_merged_bio(struct f2fs_bio_info *io)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ffa045b39c01..11b394dc2d5e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
  */
+#include <linux/blk-crypto.h>
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
 #include <linux/stat.h>
@@ -5042,7 +5043,7 @@ static void f2fs_dio_write_submit_io(const struct iomap_iter *iter,
 	enum temp_type temp = f2fs_get_segment_temp(sbi, type);
 
 	bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi, DATA, temp);
-	submit_bio(bio);
+	blk_crypto_submit_bio(bio);
 }
 
 static const struct iomap_dio_ops f2fs_iomap_dio_write_ops = {
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5d5d63efbd57..c69dd24be663 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2010 Red Hat, Inc.
  * Copyright (c) 2016-2025 Christoph Hellwig.
  */
+#include <linux/blk-crypto.h>
 #include <linux/fscrypt.h>
 #include <linux/pagemap.h>
 #include <linux/iomap.h>
@@ -82,7 +83,7 @@ static void iomap_dio_submit_bio(const struct iomap_iter *iter,
 		dio->dops->submit_io(iter, bio, pos);
 	} else {
 		WARN_ON_ONCE(iter->iomap.flags & IOMAP_F_ANON_WRITE);
-		submit_bio(bio);
+		blk_crypto_submit_bio(bio);
 	}
 }
 
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
index 58b0c5254a67..ffe815c09696 100644
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -171,6 +171,22 @@ static inline bool bio_has_crypt_ctx(struct bio *bio)
 
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
 
+bool __blk_crypto_submit_bio(struct bio *bio);
+
+/**
+ * blk_crypto_submit_bio - Submit a bio using inline encryption
+ * @bio: bio to submit
+ *
+ * If the bio crypt context attached to @bio is supported by the underlying
+ * device's inline encryption hardware, just submit @bio.  Otherwise, try to
+ * perform en/decryption for this bio by falling back to the kernel crypto API.
+ */
+static inline void blk_crypto_submit_bio(struct bio *bio)
+{
+	if (!bio_has_crypt_ctx(bio) || __blk_crypto_submit_bio(bio))
+		submit_bio(bio);
+}
+
 int __bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask);
 /**
  * bio_crypt_clone - clone bio encryption context
-- 
2.47.3


