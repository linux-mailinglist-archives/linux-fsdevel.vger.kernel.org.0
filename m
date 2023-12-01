Return-Path: <linux-fsdevel+bounces-4658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88466801665
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42341281C28
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F148F3F8C4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="dDyXAWAr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB666128
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:45 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id 3f1490d57ef6-dae7cc31151so987904276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468765; x=1702073565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NcN10ZukHzvXtGLikAWaW+PN73UabSkdq95rYCkOREY=;
        b=dDyXAWArS/r6i3q8gXSfP2sMZ1xMeV5n7EcKBeW0wxdbL0oUt7zJ78hHr92BNrNRoX
         BcsbJYE0/fS1Jdl8npp8zxDoENPYOk8+vDQTKidThFx4F11S5qx+9X3Ftks+cFsbST5E
         8ZKqO4XT0vLBeZrmeu+NTx5vbz28PUzn4Vxtz++vsnHXg6D46ZPQOsuP+Z0WCfEcv8M3
         dyE1mhEUf1rW9MmvJd+8FjXqNzAusnroE5dM4PtaUKcbtaBDRNfGMAdoyzobqQGYGXEo
         iaXzQbkdve618h79bhTc0e5zfruHt68cuujhuAXwoOF0go1iMSx476kvzrfj29APmCHJ
         CRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468765; x=1702073565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcN10ZukHzvXtGLikAWaW+PN73UabSkdq95rYCkOREY=;
        b=DDhWpfAclANwzt1GDlMQK22xZtxFUEJTk0PmD1m80X/ty8nbh9+aJfhM6G9xVOArY/
         MiWnEKQREblT2xYdYNwS7vAQxmgrnmJh6YXKS5vu8xUg7o4UYhaPWKOeO7Am9/9rfrvD
         r3/sVOcFdY6dI3YRRxjZqRsE/iea+HZKmgIMEQvZwos+qgpLgCypFiRr+N0mboJu+/vE
         rhUKmGrGH8p+awHSp25iBIg8RnEvW5NJ8Xm+gEdgSJ7EuPDXqCsrZ5Vg7OifskreGmp0
         hElsZkzLr2s9A6jWyDU47vDOWGfsXEnPpyhzFMuqlbEfYM9RH+sL8v27dDFG9pi1hib5
         zrDg==
X-Gm-Message-State: AOJu0YxC1oFw4g3OQ002Jsg6Z+HmfpwNz8tYpW6DM3Wq9LnTom4qP8Eh
	2NmL+ClpoaI1IAKpJvz2FSukjQ==
X-Google-Smtp-Source: AGHT+IGRxL5QDtjRhHUSGIEwY5tp/SmY4vl8W5gVcz79mjyNqKo4FBLtFZK3vQmACXmbpwabqNbw/Q==
X-Received: by 2002:a25:ccd5:0:b0:db7:dacf:6ff4 with SMTP id l204-20020a25ccd5000000b00db7dacf6ff4mr146647ybf.124.1701468765014;
        Fri, 01 Dec 2023 14:12:45 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id z17-20020a25bb11000000b00d8679407796sm615186ybg.48.2023.12.01.14.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:44 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 38/46] btrfs: implement process_bio cb for fscrypt
Date: Fri,  1 Dec 2023 17:11:35 -0500
Message-ID: <f87a5ad8085998d751665d34b794403973c51ae9.1701468306.git.josef@toxicpanda.com>
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

We are going to be checksumming the encrypted data, so we have to
implement the ->process_bio fscrypt callback.  This will provide us with
the original bio and the encrypted bio to do work on.  For WRITE's this
will happen after the encrypted bio has been encrypted.  For READ's this
will happen after the read has completed and before the decryption step
is done.

For write's this is straightforward, we can just pass in the encrypted
bio to btrfs_csum_one_bio and then the csums will be added to the bbio
as normal.

For read's this is relatively straightforward, but requires some care.
We assume (because that's how it works currently) that the encrypted bio
match the original bio, this is important because we save the iter of
the bio before we submit.  If this changes in the future we'll need a
hook to give us the bi_iter of the decryption bio before it's submitted.
We check the csums before decryption.  If it doesn't match we simply
error out and we let the normal path handle the repair work.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/bio.c     | 34 +++++++++++++++++++++++++++++++++-
 fs/btrfs/bio.h     |  3 +++
 fs/btrfs/fscrypt.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index ef3f98b3ec3f..494b3ba05f7a 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -282,6 +282,34 @@ static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
 	return fbio;
 }
 
+blk_status_t btrfs_check_encrypted_read_bio(struct btrfs_bio *bbio,
+					    struct bio *enc_bio)
+{
+	struct btrfs_inode *inode = bbio->inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	u32 sectorsize = fs_info->sectorsize;
+	struct bvec_iter iter = bbio->saved_iter;
+	struct btrfs_device *dev = bbio->bio.bi_private;
+	u32 offset = 0;
+
+	/*
+	 * We have to use a copy of iter in case there's an error,
+	 * btrfs_check_read_bio will handle submitting the repair bios.
+	 */
+	while (iter.bi_size) {
+		struct bio_vec bv = bio_iter_iovec(enc_bio, iter);
+
+		bv.bv_len = min(bv.bv_len, sectorsize);
+		if (!btrfs_data_csum_ok(bbio, dev, offset, &bv))
+			return BLK_STS_IOERR;
+		bio_advance_iter_single(enc_bio, &iter, sectorsize);
+		offset += sectorsize;
+	}
+
+	bbio->csum_done = true;
+	return BLK_STS_OK;
+}
+
 static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *dev)
 {
 	struct btrfs_inode *inode = bbio->inode;
@@ -307,6 +335,10 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
 	/* Clear the I/O error. A failed repair will reset it. */
 	bbio->bio.bi_status = BLK_STS_OK;
 
+	/* This was an encrypted bio and we've already done the csum check. */
+	if (status == BLK_STS_OK && bbio->csum_done)
+		goto out;
+
 	while (iter->bi_size) {
 		struct bio_vec bv = bio_iter_iovec(&bbio->bio, *iter);
 
@@ -317,7 +349,7 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
 		bio_advance_iter_single(&bbio->bio, iter, sectorsize);
 		offset += sectorsize;
 	}
-
+out:
 	if (bbio->csum != bbio->csum_inline)
 		kfree(bbio->csum);
 
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 5d3f53dcd6d5..393ef32f5321 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -45,6 +45,7 @@ struct btrfs_bio {
 		struct {
 			u8 *csum;
 			u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
+			bool csum_done;
 			struct bvec_iter saved_iter;
 		};
 
@@ -110,5 +111,7 @@ void btrfs_submit_repair_write(struct btrfs_bio *bbio, int mirror_num, bool dev_
 int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 			    u64 length, u64 logical, struct page *page,
 			    unsigned int pg_offset, int mirror_num);
+blk_status_t btrfs_check_encrypted_read_bio(struct btrfs_bio *bbio,
+					    struct bio *enc_bio);
 
 #endif
diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
index 419b0f6d8629..85b596711371 100644
--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -15,6 +15,7 @@
 #include "transaction.h"
 #include "volumes.h"
 #include "xattr.h"
+#include "file-item.h"
 
 /*
  * From a given location in a leaf, read a name into a qstr (usually a
@@ -214,6 +215,33 @@ static struct block_device **btrfs_fscrypt_get_devices(struct super_block *sb,
 	return devs;
 }
 
+static blk_status_t btrfs_process_encrypted_bio(struct bio *orig_bio,
+						struct bio *enc_bio)
+{
+	struct btrfs_bio *bbio;
+
+	/*
+	 * If our bio is from the normal fs_bio_set then we know this is a
+	 * mirror split and we can skip it, we'll get the real bio on the last
+	 * mirror and we can process that one.
+	 */
+	if (orig_bio->bi_pool == &fs_bio_set)
+		return BLK_STS_OK;
+
+	bbio = btrfs_bio(orig_bio);
+
+	if (bio_op(orig_bio) == REQ_OP_READ) {
+		/*
+		 * We have ->saved_iter based on the orig_bio, so if the block
+		 * layer changes we need to notice this asap so we can update
+		 * our code to handle the new world order.
+		 */
+		ASSERT(orig_bio == enc_bio);
+		return btrfs_check_encrypted_read_bio(bbio, enc_bio);
+	}
+	return btrfs_csum_one_bio(bbio, enc_bio);
+}
+
 int btrfs_fscrypt_load_extent_info(struct btrfs_inode *inode,
 				   struct extent_map *em,
 				   struct btrfs_fscrypt_ctx *ctx)
@@ -328,4 +356,5 @@ const struct fscrypt_operations btrfs_fscrypt_ops = {
 	.set_context = btrfs_fscrypt_set_context,
 	.empty_dir = btrfs_fscrypt_empty_dir,
 	.get_devices = btrfs_fscrypt_get_devices,
+	.process_bio = btrfs_process_encrypted_bio,
 };
-- 
2.41.0


