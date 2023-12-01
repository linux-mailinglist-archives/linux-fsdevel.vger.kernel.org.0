Return-Path: <linux-fsdevel+bounces-4656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B30801663
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3FF281C15
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435B6619CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="YCSDwGDw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AA0D50
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:42 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b86f3cdca0so672928b6e.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468762; x=1702073562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1CXtGZj8aSs4z9SIQWwUOQcwGx+Gif/0Em+QUOV9hY=;
        b=YCSDwGDwcI8uSIj7zZuOR4t4LVp99HovpLccGfdJ+6JyPiKUXWok8K9MEEpAa7FCUu
         s0XPjVkNJZ3HN82tFLwdGolBDw/7URMJqYYzU35lw75BZj+f7f9dVqdSJYHSX8CLwlre
         lbpdaM2UpBPNkP17COrN9H9QlzUHzX2hjFB/gZE85FDY/l3KZJVQG2OFKMBJl9LwfHzH
         HGwX9SdbXsw4u5Fgb4Hhwzh5BMQB2ETXR8OHmQ+b+2RWls4mlji73sL86mDrCgJPfDcZ
         5G7WFlvI+D9YwdzDNPbCiw+dz+PwZq39EmqUz2M9RNnHawblH6YCP5m/vPxFk9ttGxVD
         BkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468762; x=1702073562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1CXtGZj8aSs4z9SIQWwUOQcwGx+Gif/0Em+QUOV9hY=;
        b=AsoVxhM+xUJWMLurvaYsiavNJIvuSGu81W3O1w/XCVQqZSPIh7lya/l3fx9JKTU+3U
         kNmevT42BpJmL1jdJ4asmJ80/DSBGXUYOCEvUTfikthDcxC6bTzF8rGwsQ+LHEOgB9SY
         zrRngxjvfHyY1oa2K0puHp2rVjGQgHOB32jYpfcAmr+cN7CUctynlIDU8t2b1ByRGlnc
         uD2v9c/23Z/hc02UVR+PHDiS/OOw+6cc+1d4rkc85HZzVaopPcb2VpaVvxqCBfXXfPNW
         xUZHk6fLTyYMu81JLHYwiUlnImCMDtSEQgB2HOU7F/BlzZxKcX4pMKcx7Hvv3oJWy54f
         jSvQ==
X-Gm-Message-State: AOJu0YwC/Eb03f/vz/au1nnDZAm3pwEoMNR1RHzfA0ETY7iWB4IR2kUX
	C/w6O5R8YHB/i9bSK7SZkLrabQ==
X-Google-Smtp-Source: AGHT+IGmK971rBsW1VRYTTXnV7cJUDtBlM2T7O/hse/3XKOvVh6tKvC4KObxrGlz18VvEQeUulw6wg==
X-Received: by 2002:a54:4014:0:b0:3b8:9025:57d7 with SMTP id x20-20020a544014000000b003b8902557d7mr214732oie.3.1701468760678;
        Fri, 01 Dec 2023 14:12:40 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d3-20020a256803000000b00d9ca9243ad5sm640348ybc.38.2023.12.01.14.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:40 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 34/46] btrfs: set the bio fscrypt context when applicable
Date: Fri,  1 Dec 2023 17:11:31 -0500
Message-ID: <cfb67d4a11cdc6c9d0685b5c505b1170bb7b9bb4.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have the fscrypt_info plumbed through everywhere, add the
code to setup the bio encryption context from the extent context.

We use the per-extent fscrypt_extent_info for encryption/decryption.
We use the offset into the extent as the lblk for fscrypt.  So the start
of the extent has the lblk of 0, 4k into the extent has the lblk of 4k,
etc.  This is done to allow things like relocation to continue to work
properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/compression.c |  6 ++++
 fs/btrfs/extent_io.c   | 76 +++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/fscrypt.c     | 36 ++++++++++++++++++++
 fs/btrfs/fscrypt.h     | 22 ++++++++++++
 fs/btrfs/inode.c       | 10 ++++++
 5 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 05595d113ff8..a71614359c33 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -37,6 +37,7 @@
 #include "zoned.h"
 #include "file-item.h"
 #include "super.h"
+#include "fscrypt.h"
 
 static struct bio_set btrfs_compressed_bioset;
 
@@ -396,6 +397,9 @@ void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
 	cb->bbio.ordered = ordered;
 	btrfs_add_compressed_bio_pages(cb);
 
+	btrfs_set_bio_crypt_ctx_from_extent(&cb->bbio.bio, inode,
+					    ordered->fscrypt_info, 0);
+
 	btrfs_submit_bio(&cb->bbio, 0);
 }
 
@@ -599,6 +603,8 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	cb->compress_type = em->compress_type;
 	cb->orig_bbio = bbio;
 
+	btrfs_set_bio_crypt_ctx_from_extent(&cb->bbio.bio, inode,
+					    em->fscrypt_info, 0);
 	free_extent_map(em);
 
 	cb->nr_pages = DIV_ROUND_UP(compressed_len, PAGE_SIZE);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 42544c0d9ee1..9824dd356e3c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -36,6 +36,7 @@
 #include "dev-replace.h"
 #include "super.h"
 #include "transaction.h"
+#include "fscrypt.h"
 
 static struct kmem_cache *extent_buffer_cache;
 
@@ -102,6 +103,10 @@ struct btrfs_bio_ctrl {
 	blk_opf_t opf;
 	btrfs_bio_end_io_t end_io_func;
 	struct writeback_control *wbc;
+
+	/* This is set for reads and we have encryption. */
+	struct fscrypt_extent_info *fscrypt_info;
+	u64 orig_start;
 };
 
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
@@ -708,10 +713,31 @@ static bool btrfs_bio_is_contig(struct btrfs_bio_ctrl *bio_ctrl,
 				struct page *page, u64 disk_bytenr,
 				unsigned int pg_offset)
 {
-	struct bio *bio = &bio_ctrl->bbio->bio;
+	struct inode *inode = page->mapping->host;
+	struct btrfs_bio *bbio = bio_ctrl->bbio;
+	struct bio *bio = &bbio->bio;
 	struct bio_vec *bvec = bio_last_bvec_all(bio);
 	const sector_t sector = disk_bytenr >> SECTOR_SHIFT;
 
+	if (IS_ENCRYPTED(inode)) {
+		u64 file_offset = page_offset(page) + pg_offset;
+		u64 offset = 0;
+		struct fscrypt_extent_info *fscrypt_info = NULL;
+
+		/* bio_ctrl->fscrypt_info is only set in the READ case. */
+		if (bio_ctrl->fscrypt_info) {
+			offset = file_offset - bio_ctrl->orig_start;
+			fscrypt_info = bio_ctrl->fscrypt_info;
+		} else if (bbio->ordered) {
+			fscrypt_info = bbio->ordered->fscrypt_info;
+			offset = file_offset - bbio->ordered->orig_offset;
+		}
+
+		if (!btrfs_mergeable_encrypted_bio(bio, inode, fscrypt_info,
+						   offset))
+			return false;
+	}
+
 	if (bio_ctrl->compress_type != BTRFS_COMPRESS_NONE) {
 		/*
 		 * For compression, all IO should have its logical bytenr set
@@ -742,6 +768,8 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_bio *bbio;
+	struct fscrypt_extent_info *fscrypt_info = NULL;
+	u64 offset = 0;
 
 	bbio = btrfs_bio_alloc(BIO_MAX_VECS, bio_ctrl->opf, fs_info,
 			       bio_ctrl->end_io_func, NULL);
@@ -761,6 +789,8 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 					ordered->file_offset +
 					ordered->disk_num_bytes - file_offset);
 			bbio->ordered = ordered;
+			fscrypt_info = ordered->fscrypt_info;
+			offset = file_offset - ordered->orig_offset;
 		}
 
 		/*
@@ -771,7 +801,13 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 		 */
 		bio_set_dev(&bbio->bio, fs_info->fs_devices->latest_dev->bdev);
 		wbc_init_bio(bio_ctrl->wbc, &bbio->bio);
+	} else {
+		fscrypt_info = bio_ctrl->fscrypt_info;
+		offset = file_offset - bio_ctrl->orig_start;
 	}
+
+	btrfs_set_bio_crypt_ctx_from_extent(&bbio->bio, inode, fscrypt_info,
+					    offset);
 }
 
 /*
@@ -815,6 +851,19 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
 			len = bio_ctrl->len_to_oe_boundary;
 		}
 
+		/*
+		 * Encryption has to allocate bounce buffers to encrypt the bio,
+		 * and we need to make sure that it doesn't split the bio so we
+		 * retain all of our special info in the btrfs_bio, so submit
+		 * any bio that gets up to BIO_MAX_VECS worth of segments.
+		 */
+		if (IS_ENCRYPTED(&inode->vfs_inode) &&
+		    bio_data_dir(&bio_ctrl->bbio->bio) == WRITE &&
+		    bio_segments(&bio_ctrl->bbio->bio) == BIO_MAX_VECS) {
+			submit_one_bio(bio_ctrl);
+			continue;
+		}
+
 		if (bio_add_page(&bio_ctrl->bbio->bio, page, len, pg_offset) != len) {
 			/* bio full: move on to a new one */
 			submit_one_bio(bio_ctrl);
@@ -1008,6 +1057,8 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		bool force_bio_submit = false;
 		u64 disk_bytenr;
 
+		bio_ctrl->fscrypt_info = NULL;
+
 		ASSERT(IS_ALIGNED(cur, fs_info->sectorsize));
 		if (cur >= last_byte) {
 			iosize = PAGE_SIZE - pg_offset;
@@ -1082,6 +1133,22 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		if (prev_em_start)
 			*prev_em_start = em->start;
 
+		/*
+		 * We use the extent offset for the IV when decrypting the page,
+		 * so we have to set the extent_offset based on the orig_start
+		 * for this extent.  Also save the fscrypt_info so the bio ctx
+		 * can be set properly.  If this inode isn't encrypted this
+		 * won't do anything.
+		 *
+		 * If we're compressed we'll handle all of this in
+		 * btrfs_submit_compressed_read.
+		 */
+		if (compress_type == BTRFS_COMPRESS_NONE) {
+			bio_ctrl->orig_start = em->orig_start;
+			bio_ctrl->fscrypt_info =
+				fscrypt_get_extent_info(em->fscrypt_info);
+		}
+
 		free_extent_map(em);
 		em = NULL;
 
@@ -1093,6 +1160,9 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			end_page_read(page, true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
+
+			/* This shouldn't be set, but clear it just in case. */
+			fscrypt_put_extent_info(bio_ctrl->fscrypt_info);
 			continue;
 		}
 		/* the get_extent function already copied into the page */
@@ -1101,6 +1171,9 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			end_page_read(page, true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
+
+			/* This shouldn't be set, but clear it just in case. */
+			fscrypt_put_extent_info(bio_ctrl->fscrypt_info);
 			continue;
 		}
 
@@ -1113,6 +1186,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			submit_one_bio(bio_ctrl);
 		submit_extent_page(bio_ctrl, disk_bytenr, page, iosize,
 				   pg_offset);
+		fscrypt_put_extent_info(bio_ctrl->fscrypt_info);
 		cur = cur + iosize;
 		pg_offset += iosize;
 	}
diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
index 7a7272cb83ec..726cb6121934 100644
--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -262,6 +262,42 @@ size_t btrfs_fscrypt_extent_context_size(struct btrfs_inode *inode)
 		fscrypt_extent_context_size(&inode->vfs_inode);
 }
 
+void btrfs_set_bio_crypt_ctx_from_extent(struct bio *bio,
+					 struct btrfs_inode *inode,
+					 struct fscrypt_extent_info *fi,
+					 u64 logical_offset)
+{
+	if (!fi)
+		return;
+
+	/*
+	 * fscrypt uses bytes >> s_blocksize_bits for the block numbers, so we
+	 * have to adjust everything based on our sectorsize so that the DUN
+	 * calculations are correct.
+	 */
+	logical_offset = div64_u64(logical_offset,
+				   inode->root->fs_info->sectorsize);
+	fscrypt_set_bio_crypt_ctx_from_extent(bio, &inode->vfs_inode, fi,
+					      logical_offset, GFP_NOFS);
+}
+
+bool btrfs_mergeable_encrypted_bio(struct bio *bio, struct inode *inode,
+				   struct fscrypt_extent_info *fi,
+				   u64 logical_offset)
+{
+	if (!fi)
+		return true;
+
+	/*
+	 * fscrypt uses bytes >> s_blocksize_bits for the block numbers, so we
+	 * have to adjust everything based on our sectorsize so that the DUN
+	 * calculations are correct.
+	 */
+	logical_offset = div64_u64(logical_offset,
+				   BTRFS_I(inode)->root->fs_info->sectorsize);
+	return fscrypt_mergeable_extent_bio(bio, inode, fi, logical_offset);
+}
+
 const struct fscrypt_operations btrfs_fscrypt_ops = {
 	.has_per_extent_encryption = 1,
 	.get_context = btrfs_fscrypt_get_context,
diff --git a/fs/btrfs/fscrypt.h b/fs/btrfs/fscrypt.h
index 2882a4a9d978..756375ade0b6 100644
--- a/fs/btrfs/fscrypt.h
+++ b/fs/btrfs/fscrypt.h
@@ -28,6 +28,13 @@ int btrfs_fscrypt_save_extent_info(struct btrfs_inode *inode,
 				   struct btrfs_path *path,
 				   struct fscrypt_extent_info *fi);
 size_t btrfs_fscrypt_extent_context_size(struct btrfs_inode *inode);
+void btrfs_set_bio_crypt_ctx_from_extent(struct bio *bio,
+					 struct btrfs_inode *inode,
+					 struct fscrypt_extent_info *fi,
+					 u64 logical_offset);
+bool btrfs_mergeable_encrypted_bio(struct bio *bio, struct inode *inode,
+				   struct fscrypt_extent_info *fi,
+				   u64 logical_offset);
 
 #else
 static inline int btrfs_fscrypt_save_extent_info(struct btrfs_inode *inode,
@@ -66,6 +73,21 @@ static inline size_t btrfs_fscrypt_extent_context_size(struct btrfs_inode *inode
 {
 	return 0;
 }
+
+static inline void btrfs_set_bio_crypt_ctx_from_extent(struct bio *bio,
+						       struct btrfs_inode *inode,
+						       struct fscrypt_extent_info *fi,
+						       u64 logical_offset)
+{
+}
+
+static inline bool btrfs_mergeable_encrypted_bio(struct bio *bio,
+						 struct inode *inode,
+						 struct fscrypt_extent_info *fi,
+						 u64 logical_offset)
+{
+	return true;
+}
 #endif /* CONFIG_FS_ENCRYPTION */
 
 extern const struct fscrypt_operations btrfs_fscrypt_ops;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3dce53601915..c5878da937d3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7932,6 +7932,8 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 	struct btrfs_dio_private *dip =
 		container_of(bbio, struct btrfs_dio_private, bbio);
 	struct btrfs_dio_data *dio_data = iter->private;
+	struct fscrypt_extent_info *fscrypt_info = NULL;
+	u64 offset = 0;
 
 	btrfs_bio_init(bbio, BTRFS_I(iter->inode)->root->fs_info,
 		       btrfs_dio_end_io, bio->bi_private);
@@ -7953,6 +7955,9 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 	if (iter->flags & IOMAP_WRITE) {
 		int ret;
 
+		offset = file_offset - dio_data->ordered->orig_offset;
+		fscrypt_info = dio_data->ordered->fscrypt_info;
+
 		ret = btrfs_extract_ordered_extent(bbio, dio_data->ordered);
 		if (ret) {
 			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
@@ -7962,8 +7967,13 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 			iomap_dio_bio_end_io(bio);
 			return;
 		}
+	} else {
+		fscrypt_info = dio_data->fscrypt_info;
+		offset = file_offset - dio_data->orig_start;
 	}
 
+	btrfs_set_bio_crypt_ctx_from_extent(&bbio->bio, bbio->inode,
+					    fscrypt_info, offset);
 	btrfs_submit_bio(bbio, 0);
 }
 
-- 
2.41.0


