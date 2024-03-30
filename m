Return-Path: <linux-fsdevel+bounces-15714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11080892837
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6A2282713
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83301869;
	Sat, 30 Mar 2024 00:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEcWSwiy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE1B15A8;
	Sat, 30 Mar 2024 00:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711758949; cv=none; b=ReXSZdNJwmpC831a8D/+shSQFJ0A1/2pk95lWN4ST41/mXzWQX94Af/Nvq0edX7MnIqwP0TuW2wm/MlRd/uJG7X5T7sKKa1csWl3wrUeRa8NMd3h+w2e98whEWbW2k0hHLak8YsAs/4vW986mduBaF8ep5yQZs+hxl3InutCwF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711758949; c=relaxed/simple;
	bh=YD5IkqxojuqXv2orMPlMpmUuWmhiGdvtiuKlINtd5Qg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i6/5MYeG10wCIKxII6quFkXY5QeWIWvLaZqURohcXvmjU+kExSGsxf95RfdG02XnsnUD9MHnjDxcrm/xoG8t/LJhmzld0ygvpYHsKbqi/e8ngIDkuH2P12fkeva8nJbf456PbJ9ZvrRD+/mrZLY0LM7sJd5al8ewzNJwutgiu3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEcWSwiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D089AC433C7;
	Sat, 30 Mar 2024 00:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711758948;
	bh=YD5IkqxojuqXv2orMPlMpmUuWmhiGdvtiuKlINtd5Qg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=mEcWSwiykw+EMAy7sYL60me+x0An67SPWui6iQyeGXB9aP8XLQSpzhI2i/n/yoIzA
	 HRLFqFuPAYJF4sgtkNaueYl/gQ9o8jE0m86U5uXH3OO9KYw3gR3pA7SBCUXI9ty9Vk
	 BMXtNBuigYiOB/c/eWi8ftUwE/o9/YBagBMNpKvV+rAgSclxnFAxDeJtjZEbmpwx1/
	 5nI1O1Po0rKTad6Vi3/FrIfKTnPkBLUczPgh5zuL42CzhZybbBKw+jUwprZtjQKddD
	 AVhdH53+7rKISRxMR1oeKGyqO0sneV09xKluW28GhTYamYTXfIZc/ej+YHW5g+Ko5G
	 eo6Z6v96SJBdA==
Date: Fri, 29 Mar 2024 17:35:48 -0700
Subject: [PATCH 12/13] fsverity: remove system-wide workqueue
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868064.1987804.7068231057141413548.stgit@frogsfrogsfrogs>
In-Reply-To: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
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

Now that we've made the verity workqueue per-superblock, we don't need
the systemwide workqueue.  Get rid of the old implementation.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/btrfs/super.c             |    6 ++++++
 fs/buffer.c                  |    7 +++++--
 fs/ext4/readpage.c           |    5 ++++-
 fs/ext4/super.c              |    3 +++
 fs/f2fs/compress.c           |    3 ++-
 fs/f2fs/data.c               |    2 +-
 fs/f2fs/super.c              |    3 +++
 fs/verity/fsverity_private.h |    2 --
 fs/verity/init.c             |    1 -
 fs/verity/verify.c           |   25 ++++---------------------
 include/linux/fsverity.h     |    6 ++++--
 11 files changed, 32 insertions(+), 31 deletions(-)


diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 7e44ccaf348f2..c2da9a0009e26 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -28,6 +28,7 @@
 #include <linux/btrfs.h>
 #include <linux/security.h>
 #include <linux/fs_parser.h>
+#include <linux/fsverity.h>
 #include "messages.h"
 #include "delayed-inode.h"
 #include "ctree.h"
@@ -924,6 +925,11 @@ static int btrfs_fill_super(struct super_block *sb,
 	sb->s_export_op = &btrfs_export_ops;
 #ifdef CONFIG_FS_VERITY
 	sb->s_vop = &btrfs_verityops;
+	err = fsverity_init_verify_wq(sb);
+	if (err) {
+		btrfs_err(fs_info, "fsverity_init_verify_wq failed");
+		return err;
+	}
 #endif
 	sb->s_xattr = btrfs_xattr_handlers;
 	sb->s_time_gran = 1;
diff --git a/fs/buffer.c b/fs/buffer.c
index 4f73d23c2c469..a2cb50ecfb829 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -327,13 +327,15 @@ static void decrypt_bh(struct work_struct *work)
 	err = fscrypt_decrypt_pagecache_blocks(bh->b_folio, bh->b_size,
 					       bh_offset(bh));
 	if (err == 0 && need_fsverity(bh)) {
+		struct inode *inode = bh->b_folio->mapping->host;
+
 		/*
 		 * We use different work queues for decryption and for verity
 		 * because verity may require reading metadata pages that need
 		 * decryption, and we shouldn't recurse to the same workqueue.
 		 */
 		INIT_WORK(&ctx->work, verify_bh);
-		fsverity_enqueue_verify_work(&ctx->work);
+		fsverity_enqueue_verify_work(inode->i_sb, &ctx->work);
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
index 21e8f0aebb3c6..e40566b0ddb65 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -61,6 +61,7 @@ enum bio_post_read_step {
 
 struct bio_post_read_ctx {
 	struct bio *bio;
+	const struct inode *inode;
 	struct work_struct work;
 	unsigned int cur_step;
 	unsigned int enabled_steps;
@@ -132,7 +133,8 @@ static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
 	case STEP_VERITY:
 		if (ctx->enabled_steps & (1 << STEP_VERITY)) {
 			INIT_WORK(&ctx->work, verity_work);
-			fsverity_enqueue_verify_work(&ctx->work);
+			fsverity_enqueue_verify_work(ctx->inode->i_sb,
+						     &ctx->work);
 			return;
 		}
 		ctx->cur_step++;
@@ -195,6 +197,7 @@ static void ext4_set_bio_post_read_ctx(struct bio *bio,
 			mempool_alloc(bio_post_read_ctx_pool, GFP_NOFS);
 
 		ctx->bio = bio;
+		ctx->inode = inode;
 		ctx->enabled_steps = post_read_steps;
 		bio->bi_private = ctx;
 	}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index cfb8449c731f9..f7c834f4e2b1f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5332,6 +5332,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 #endif
 #ifdef CONFIG_FS_VERITY
 	sb->s_vop = &ext4_verityops;
+	err = fsverity_init_verify_wq(sb);
+	if (err)
+		goto failed_mount3a;
 #endif
 #ifdef CONFIG_QUOTA
 	sb->dq_op = &ext4_quota_operations;
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
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a6867f26f1418..422527d9f6baf 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4423,6 +4423,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 #endif
 #ifdef CONFIG_FS_VERITY
 	sb->s_vop = &f2fs_verityops;
+	err = fsverity_init_verify_wq(sb);
+	if (err)
+		goto free_bio_info;
 #endif
 	sb->s_xattr = f2fs_xattr_handlers;
 	sb->s_export_op = &f2fs_export_ops;
diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index 195a92f203bba..24846d475502d 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -154,8 +154,6 @@ static inline void fsverity_init_signature(void)
 
 /* verify.c */
 
-void __init fsverity_init_workqueue(void);
-
 static inline bool fsverity_caches_blocks(const struct inode *inode)
 {
 	const struct fsverity_operations *vops = inode->i_sb->s_vop;
diff --git a/fs/verity/init.c b/fs/verity/init.c
index 3769d2dc9e3b4..4663696c6996c 100644
--- a/fs/verity/init.c
+++ b/fs/verity/init.c
@@ -66,7 +66,6 @@ static int __init fsverity_init(void)
 {
 	fsverity_check_hash_algs();
 	fsverity_init_info_cache();
-	fsverity_init_workqueue();
 	fsverity_init_sysctl();
 	fsverity_init_signature();
 	fsverity_init_bpf();
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 4acfd02b0e42d..99c6d31fbcfba 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -10,8 +10,6 @@
 #include <crypto/hash.h>
 #include <linux/bio.h>
 
-static struct workqueue_struct *fsverity_read_workqueue;
-
 /*
  * Returns true if the hash block with index @hblock_idx in the tree has
  * already been verified.
@@ -384,33 +382,18 @@ EXPORT_SYMBOL_GPL(__fsverity_init_verify_wq);
 
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
+	queue_work(sb->s_verify_wq, work);
 }
 EXPORT_SYMBOL_GPL(fsverity_enqueue_verify_work);
 
-void __init fsverity_init_workqueue(void)
-{
-	/*
-	 * Use a high-priority workqueue to prioritize verification work, which
-	 * blocks reads from completing, over regular application tasks.
-	 *
-	 * For performance reasons, don't use an unbound workqueue.  Using an
-	 * unbound workqueue for crypto operations causes excessive scheduler
-	 * latency on ARM64.
-	 */
-	fsverity_read_workqueue = alloc_workqueue("fsverity_read_queue",
-						  WQ_HIGHPRI,
-						  num_online_cpus());
-	if (!fsverity_read_workqueue)
-		panic("failed to allocate fsverity_read_queue");
-}
-
 /**
  * fsverity_read_merkle_tree_block() - read Merkle tree block
  * @inode: inode to which this Merkle tree blocks belong
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index dcf9d9cffcb9f..ed93ca06ade5f 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -302,7 +302,8 @@ int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg);
 
 bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset);
 void fsverity_verify_bio(struct bio *bio);
-void fsverity_enqueue_verify_work(struct work_struct *work);
+void fsverity_enqueue_verify_work(struct super_block *sb,
+				  struct work_struct *work);
 
 int __fsverity_init_verify_wq(struct super_block *sb);
 static inline int fsverity_init_verify_wq(struct super_block *sb)
@@ -384,7 +385,8 @@ static inline void fsverity_verify_bio(struct bio *bio)
 	WARN_ON_ONCE(1);
 }
 
-static inline void fsverity_enqueue_verify_work(struct work_struct *work)
+static inline void fsverity_enqueue_verify_work(struct super_block *sb,
+						struct work_struct *work)
 {
 	WARN_ON_ONCE(1);
 }


