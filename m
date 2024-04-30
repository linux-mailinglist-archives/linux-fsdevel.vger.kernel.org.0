Return-Path: <linux-fsdevel+bounces-18224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 526EA8B6869
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60C21F22358
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D38A101CE;
	Tue, 30 Apr 2024 03:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1sutzYc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFE0DF78;
	Tue, 30 Apr 2024 03:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447369; cv=none; b=iDebB0vFUlUJfkrwSt4lwfTUwMSKBAdRby2lXWlcJSLvQpWEFcp8pd2kgXrrA70XaU94LXGeS6T2zCFJPGpTYDgKKlo6vzj/jIbz7utnkS+zLnb7PhgJwxos7iwn8yQKKeVJ9A0rNILofdyWt9tFWWUIn5AgATXR3q5DptUeX6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447369; c=relaxed/simple;
	bh=ojc4zoxHfnXRxrt/MXmCm6Sg7KyoTJ4+MSzWsO6IrLo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DGN/sSJfT2wHMot13BtigoUezMYvdg7q94bcg06qo2zcIOHYQJTHOUhhs0x2GVIqVrH7u0Xj35WQsHPVC09yvznblyzZxfVGGKLsuG9YNIwlxWFjZdKB+28JKlxjYh+a4aPpcFMVeQjCBGXWd88DTWJ7M3mAjG9YUOBS6ydYRlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1sutzYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4C9C116B1;
	Tue, 30 Apr 2024 03:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447368;
	bh=ojc4zoxHfnXRxrt/MXmCm6Sg7KyoTJ4+MSzWsO6IrLo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=S1sutzYcCimCy0KPDkAVaes5nuxAbrsSN1/tjjeyYivtk+93+gKXlgtV6yCjM43ce
	 XmdKdI3GN3c3pxGuA+hKICrudJXOi8TJZV75mNdgqc2x6DdO2LVl/g0yynCQ6qoZ91
	 l9kEpd/BkoPlsSXmY25Hr4R/WnGtbZoR6/+gXRi6IaAbyuWHd8yhSZpnQ0NNzrttaa
	 +69xJUxgOVnPuBb07QY8gkHLhb3OtEgl5Hf4o/a4u1D2a2baxftqXOMZDhMODcfX0r
	 WhHSuhG/rKfG12bN5mlHwOIhTSQN6xZUlEZxwOLsMUlBwVIARSGSHzAJ//upagP/ey
	 C6Fx4+K+n9dXg==
Date: Mon, 29 Apr 2024 20:22:48 -0700
Subject: [PATCH 13/18] fsverity: pass super_block to
 fsverity_enqueue_verify_work
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444679808.955480.3704351386206183587.stgit@frogsfrogsfrogs>
In-Reply-To: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
References: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

In preparation for having per-superblock fsverity workqueues, pass the
super_block object to fsverity_enqueue_verify_work.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/buffer.c              |    7 +++++--
 fs/ext4/readpage.c       |    4 +++-
 fs/f2fs/compress.c       |    3 ++-
 fs/f2fs/data.c           |    2 +-
 fs/verity/verify.c       |    6 ++++--
 include/linux/fsverity.h |    6 ++++--
 6 files changed, 19 insertions(+), 9 deletions(-)


diff --git a/fs/buffer.c b/fs/buffer.c
index 4f73d23c2c469..b871fbc796e83 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -327,13 +327,15 @@ static void decrypt_bh(struct work_struct *work)
 	err = fscrypt_decrypt_pagecache_blocks(bh->b_folio, bh->b_size,
 					       bh_offset(bh));
 	if (err == 0 && need_fsverity(bh)) {
+		struct super_block *sb = bh->b_folio->mapping->host->i_sb;
+
 		/*
 		 * We use different work queues for decryption and for verity
 		 * because verity may require reading metadata pages that need
 		 * decryption, and we shouldn't recurse to the same workqueue.
 		 */
 		INIT_WORK(&ctx->work, verify_bh);
-		fsverity_enqueue_verify_work(&ctx->work);
+		fsverity_enqueue_verify_work(sb, &ctx->work);
 		return;
 	}
 	end_buffer_async_read(bh, err == 0);
@@ -362,7 +364,8 @@ static void end_buffer_async_read_io(struct buffer_head *bh, int uptodate)
 				fscrypt_enqueue_decrypt_work(&ctx->work);
 			} else {
 				INIT_WORK(&ctx->work, verify_bh);
-				fsverity_enqueue_verify_work(&ctx->work);
+				fsverity_enqueue_verify_work(inode->i_sb,
+							     &ctx->work);
 			}
 			return;
 		}
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 21e8f0aebb3c6..d3915a3f5da7c 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -61,6 +61,7 @@ enum bio_post_read_step {
 
 struct bio_post_read_ctx {
 	struct bio *bio;
+	struct super_block *sb;
 	struct work_struct work;
 	unsigned int cur_step;
 	unsigned int enabled_steps;
@@ -132,7 +133,7 @@ static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
 	case STEP_VERITY:
 		if (ctx->enabled_steps & (1 << STEP_VERITY)) {
 			INIT_WORK(&ctx->work, verity_work);
-			fsverity_enqueue_verify_work(&ctx->work);
+			fsverity_enqueue_verify_work(ctx->sb, &ctx->work);
 			return;
 		}
 		ctx->cur_step++;
@@ -195,6 +196,7 @@ static void ext4_set_bio_post_read_ctx(struct bio *bio,
 			mempool_alloc(bio_post_read_ctx_pool, GFP_NOFS);
 
 		ctx->bio = bio;
+		ctx->sb = inode->i_sb;
 		ctx->enabled_steps = post_read_steps;
 		bio->bi_private = ctx;
 	}
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 8892c82621414..efd0b0a3a2c37 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1775,7 +1775,8 @@ void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed,
 		 * file, and these metadata pages may be compressed.
 		 */
 		INIT_WORK(&dic->verity_work, f2fs_verify_cluster);
-		fsverity_enqueue_verify_work(&dic->verity_work);
+		fsverity_enqueue_verify_work(dic->inode->i_sb,
+					     &dic->verity_work);
 		return;
 	}
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d9494b5fc7c18..994339216a06e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -221,7 +221,7 @@ static void f2fs_verify_and_finish_bio(struct bio *bio, bool in_task)
 
 	if (ctx && (ctx->enabled_steps & STEP_VERITY)) {
 		INIT_WORK(&ctx->work, f2fs_verify_bio);
-		fsverity_enqueue_verify_work(&ctx->work);
+		fsverity_enqueue_verify_work(ctx->sbi->sb, &ctx->work);
 	} else {
 		f2fs_finish_read_bio(bio, in_task);
 	}
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 2c1de3cdf24c8..e1fab60303d6d 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -367,13 +367,15 @@ EXPORT_SYMBOL_GPL(fsverity_init_wq);
 
 /**
  * fsverity_enqueue_verify_work() - enqueue work on the fs-verity workqueue
+ * @sb: superblock for this filesystem
  * @work: the work to enqueue
  *
  * Enqueue verification work for asynchronous processing.
  */
-void fsverity_enqueue_verify_work(struct work_struct *work)
+void fsverity_enqueue_verify_work(struct super_block *sb,
+				  struct work_struct *work)
 {
-	queue_work(fsverity_read_workqueue, work);
+	queue_work(sb->s_verity_wq ?: fsverity_read_workqueue, work);
 }
 EXPORT_SYMBOL_GPL(fsverity_enqueue_verify_work);
 
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 6849c4e8268f8..1336f4b9011ea 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -297,7 +297,8 @@ int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg);
 
 bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset);
 void fsverity_verify_bio(struct bio *bio);
-void fsverity_enqueue_verify_work(struct work_struct *work);
+void fsverity_enqueue_verify_work(struct super_block *sb,
+				  struct work_struct *work);
 
 int fsverity_init_wq(struct super_block *sb, unsigned int wq_flags,
 		       int max_active);
@@ -389,7 +390,8 @@ static inline void fsverity_verify_bio(struct bio *bio)
 	WARN_ON_ONCE(1);
 }
 
-static inline void fsverity_enqueue_verify_work(struct work_struct *work)
+static inline void fsverity_enqueue_verify_work(struct super_block *sb,
+						struct work_struct *work)
 {
 	WARN_ON_ONCE(1);
 }


