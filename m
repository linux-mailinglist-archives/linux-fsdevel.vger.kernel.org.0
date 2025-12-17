Return-Path: <linux-fsdevel+bounces-71517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C0224CC623A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 07:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 26D1730125FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 06:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74D22D6407;
	Wed, 17 Dec 2025 06:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V5c1i97z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477632D592D;
	Wed, 17 Dec 2025 06:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765951704; cv=none; b=dI8MlgYKebW2plX00Vz/uft1NQQiYYUkh0IcqI+OkyOMlmdLJT5uocj00I/wazdZqCSfQH94Ihlub2FodAubLlooxnsEDPfO4tgaTToa/9Mw9eB2WBPKbN/UWTV4l4+ta2HLX+MLcbYHL816cdw7uzNHnyl0I8oN+vBkcNUw3Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765951704; c=relaxed/simple;
	bh=q+q0kAJkDcHxmiay2Q7KyhxsBWs1GxeZPAYbLxz8KPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAlMB2dMCdtCqT8ODoYKy9615xy4j777PuFW8zGIuzo3F6lOZhwOZPzU+hfBhfKI5OUtipiqb87J9oumYX4gY730ASs9H5YCoSIaPZwnqHWLDedM1yeB+aCNaTAlkdqMJp7J15iJrC/dN2P0NLjRBe/YXZFUHoZClX9qkE2FOOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V5c1i97z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TKeVIOVvzGw1Nv5RkMVu5btUi6jsl1j0Qo4fryX+tQM=; b=V5c1i97zH5W/E5htFzdVcmMTz1
	rudE6fYwhYxv6ibx+GE7x+pueYIHY0N+4fJQ5WFG22pOgwUf0MiAM5bWGkKjNAuDJlJTuhGsbEU63
	mNmf7NFDo5cvJO6WcBSzk+8AbI9PyIqylcIxXt7kSXv2TbHr9XkOo2+buoIoo5scf8PMx2BjawGiY
	yQuhJUAo5LNdi7NJxVz3lQOHTjWe4h5i/7j4mb+4dBoR2+E0+7gfFO5HrS7RGCnRbyNM1V37rg4sF
	/IifaGqG25nulqmgQ8zP1vF4f8inqG7rL8Q9Dv5LyYflQDLOtmMQWr2yp6zCQj+WmKYhOgcWT3qzf
	9GY/3Xmw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVkhx-00000006DGV-0jIU;
	Wed, 17 Dec 2025 06:08:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: [PATCH 9/9] blk-crypto: handle the fallback above the block layer
Date: Wed, 17 Dec 2025 07:06:52 +0100
Message-ID: <20251217060740.923397-10-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251217060740.923397-1-hch@lst.de>
References: <20251217060740.923397-1-hch@lst.de>
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

Note that if the submitter knows that inline enctryption is known to
be supported by the underyling driver, it can still use plain
submit_bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
---
 Documentation/block/inline-encryption.rst |  6 ++++++
 block/blk-core.c                          | 10 +++++++---
 block/blk-crypto-internal.h               | 19 +++++++++++--------
 block/blk-crypto.c                        | 23 ++++++-----------------
 fs/buffer.c                               |  3 ++-
 fs/crypto/bio.c                           |  2 +-
 fs/ext4/page-io.c                         |  3 ++-
 fs/ext4/readpage.c                        |  9 +++++----
 fs/f2fs/data.c                            |  4 ++--
 fs/f2fs/file.c                            |  3 ++-
 fs/iomap/direct-io.c                      |  3 ++-
 include/linux/blk-crypto.h                | 22 ++++++++++++++++++++++
 12 files changed, 68 insertions(+), 39 deletions(-)

diff --git a/Documentation/block/inline-encryption.rst b/Documentation/block/inline-encryption.rst
index 6380e6ab492b..7e0703a12dfb 100644
--- a/Documentation/block/inline-encryption.rst
+++ b/Documentation/block/inline-encryption.rst
@@ -206,6 +206,12 @@ it to a bio, given the blk_crypto_key and the data unit number that will be used
 for en/decryption.  Users don't need to worry about freeing the bio_crypt_ctx
 later, as that happens automatically when the bio is freed or reset.
 
+To submit a bio that uses inline encryption, users must call
+``blk_crypto_submit_bio()`` instead of the usual ``submit_bio()``.  This will
+submit the bio to the underlying driver if it supports inline crypto, or else
+call the blk-crypto fallback routines before submitting normal bios to the
+underlying drivers.
+
 Finally, when done using inline encryption with a blk_crypto_key on a
 block_device, users must call ``blk_crypto_evict_key()``.  This ensures that
 the key is evicted from all keyslots it may be programmed into and unlinked from
diff --git a/block/blk-core.c b/block/blk-core.c
index f87e5f1a101f..a0bf5174e9e9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -628,9 +628,6 @@ static void __submit_bio(struct bio *bio)
 	/* If plug is not used, add new plug here to cache nsecs time. */
 	struct blk_plug plug;
 
-	if (unlikely(!blk_crypto_bio_prep(bio)))
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
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index d65023120341..742694213529 100644
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
 
-bool __blk_crypto_bio_prep(struct bio *bio);
-static inline bool blk_crypto_bio_prep(struct bio *bio)
-{
-	if (bio_has_crypt_ctx(bio))
-		return __blk_crypto_bio_prep(bio);
-	return true;
-}
-
 blk_status_t __blk_crypto_rq_get_keyslot(struct request *rq);
 static inline blk_status_t blk_crypto_rq_get_keyslot(struct request *rq)
 {
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 0b2535d8dbcc..856d3c5b1fa0 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -242,25 +242,13 @@ void __blk_crypto_free_request(struct request *rq)
 	rq->crypt_ctx = NULL;
 }
 
-/**
- * __blk_crypto_bio_prep - Prepare bio for inline encryption
- * @bio: bio to prepare
- *
- * If the bio crypt context provided for the bio is supported by the underlying
- * device's inline encryption hardware, do nothing.
- *
- * Otherwise, try to perform en/decryption for this bio by falling back to the
- * kernel crypto API.  For encryption this means submitting newly allocated
- * bios for the encrypted payload while keeping back the source bio until they
- * complete, while for reads the decryption happens in-place by a hooked in
- * completion handler.
- *
- * Caller must ensure bio has bio_crypt_ctx.
+/*
+ * Process a bio with a crypto context.  Returns true if the caller should
+ * submit the passed in bio, false if the bio is consumed.
  *
- * Return: true if @bio should be submitted to the driver by the caller, else
- * false.  Sets bio->bi_status, calls bio_endio and returns false on error.
+ * See the kerneldoc comment for blk_crypto_submit_bio for further details.
  */
-bool __blk_crypto_bio_prep(struct bio *bio)
+bool __blk_crypto_submit_bio(struct bio *bio)
 {
 	const struct blk_crypto_key *bc_key = bio->bi_crypt_context->bc_key;
 	struct block_device *bdev = bio->bi_bdev;
@@ -288,6 +276,7 @@ bool __blk_crypto_bio_prep(struct bio *bio)
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(__blk_crypto_submit_bio);
 
 int __blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio,
 			     gfp_t gfp_mask)
diff --git a/fs/buffer.c b/fs/buffer.c
index 838c0c571022..da18053f66e8 100644
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
index c2b3ca100f8d..6da683ea69dc 100644
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
index e7f2350c725b..49a6d36a8dba 100644
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
@@ -345,7 +346,7 @@ int ext4_mpage_readpages(struct inode *inode,
 		if (bio && (last_block_in_bio != first_block - 1 ||
 			    !fscrypt_mergeable_bio(bio, inode, next_block))) {
 		submit_and_realloc:
-			submit_bio(bio);
+			blk_crypto_submit_bio(bio);
 			bio = NULL;
 		}
 		if (bio == NULL) {
@@ -371,14 +372,14 @@ int ext4_mpage_readpages(struct inode *inode,
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
@@ -389,7 +390,7 @@ int ext4_mpage_readpages(struct inode *inode,
 		; /* A label shall be followed by a statement until C23 */
 	}
 	if (bio)
-		submit_bio(bio);
+		blk_crypto_submit_bio(bio);
 	return 0;
 }
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c30e69392a62..c3dd8a5c8589 100644
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
index d7047ca6b98d..914790f37915 100644
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
@@ -5046,7 +5047,7 @@ static void f2fs_dio_write_submit_io(const struct iomap_iter *iter,
 	enum temp_type temp = f2fs_get_segment_temp(sbi, type);
 
 	bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi, DATA, temp);
-	submit_bio(bio);
+	blk_crypto_submit_bio(bio);
 }
 
 static const struct iomap_dio_ops f2fs_iomap_dio_write_ops = {
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 8e273408453a..4000c8596d9b 100644
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
@@ -74,7 +75,7 @@ static void iomap_dio_submit_bio(const struct iomap_iter *iter,
 		dio->dops->submit_io(iter, bio, pos);
 	} else {
 		WARN_ON_ONCE(iter->iomap.flags & IOMAP_F_ANON_WRITE);
-		submit_bio(bio);
+		blk_crypto_submit_bio(bio);
 	}
 }
 
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
index eb80df19be68..f7c3cb4a342f 100644
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -181,6 +181,28 @@ static inline struct bio_crypt_ctx *bio_crypt_ctx(struct bio *bio)
 
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
 
+bool __blk_crypto_submit_bio(struct bio *bio);
+
+/**
+ * blk_crypto_submit_bio - Submit a bio that may have a crypto context
+ * @bio: bio to submit
+ *
+ * If @bio has no crypto context, or the crypt context attached to @bio is
+ * supported by the underlying device's inline encryption hardware, just submit
+ * @bio.
+ *
+ * Otherwise, try to perform en/decryption for this bio by falling back to the
+ * kernel crypto API. For encryption this means submitting newly allocated
+ * bios for the encrypted payload while keeping back the source bio until they
+ * complete, while for reads the decryption happens in-place by a hooked in
+ * completion handler.
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


