Return-Path: <linux-fsdevel+bounces-7207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BBD822DD0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607CD282E5E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719931C29B;
	Wed,  3 Jan 2024 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EufAEbFw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD67B1C291;
	Wed,  3 Jan 2024 12:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D731EC433C9;
	Wed,  3 Jan 2024 12:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286583;
	bh=VeQ5X6STl1UPSpfWkHXbTgSmv5B3HWmkIlnZ+Gc7KiU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EufAEbFw7i6quxIaVUMcxAtSpFAlfUVyhpBfzXJej+7HkR8WE6U2sms9tAM5fxiJH
	 6Z/1poXtFYD+GjReLgybRWLoDDjbBm3rJBdva/gFP/43juGzPeFOANsvDquizLUpGB
	 nLVS3GVmG+9BD6chH96cr0Zqh1/b9NtjJ0TQHT0pCTt6y23SkeqUFb7knatbDZDB3M
	 vI6JyPLIFfF2OFi4hoF6EmvL/Izbwyvw90yZhZ4RPnoXdU5AI+2AEYKfbe5x8+kg/s
	 HvgJXiRqV7vzobXA5C0Bs0bp4p2BQI0gd+oocV08YOyugfZ4rTZ2HCTYnBQMBXw6xA
	 S5EXJ/8H9v5Rw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:24 +0100
Subject: [PATCH RFC 26/34] reiserfs: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-26-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=6027; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VeQ5X6STl1UPSpfWkHXbTgSmv5B3HWmkIlnZ+Gc7KiU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbR1TLoYebOisLp/5tFKgW8TFzwz6dLh4lm5btvcy
 8Fv4q+od5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkaybDP6NE/udzD7OdeC18
 yOL3XpEpsbd2xh3QrPx0LbnSdKWbeRQjw03blwuvPha7/2Mxe4Qt79nlmRvWvZ25KHReWM3yXTu
 FNrMDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/reiserfs/journal.c  | 38 +++++++++++++++++++-------------------
 fs/reiserfs/procfs.c   |  2 +-
 fs/reiserfs/reiserfs.h |  8 ++++----
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 171c912af50f..177ccb4d9bc3 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2386,7 +2386,7 @@ static int journal_read(struct super_block *sb)
 
 	cur_dblock = SB_ONDISK_JOURNAL_1st_BLOCK(sb);
 	reiserfs_info(sb, "checking transaction log (%pg)\n",
-		      journal->j_bdev_handle->bdev);
+		      F_BDEV(journal->j_f_bdev));
 	start = ktime_get_seconds();
 
 	/*
@@ -2447,7 +2447,7 @@ static int journal_read(struct super_block *sb)
 		 * device and journal device to be the same
 		 */
 		d_bh =
-		    reiserfs_breada(journal->j_bdev_handle->bdev, cur_dblock,
+		    reiserfs_breada(F_BDEV(journal->j_f_bdev), cur_dblock,
 				    sb->s_blocksize,
 				    SB_ONDISK_JOURNAL_1st_BLOCK(sb) +
 				    SB_ONDISK_JOURNAL_SIZE(sb));
@@ -2588,9 +2588,9 @@ static void journal_list_init(struct super_block *sb)
 
 static void release_journal_dev(struct reiserfs_journal *journal)
 {
-	if (journal->j_bdev_handle) {
-		bdev_release(journal->j_bdev_handle);
-		journal->j_bdev_handle = NULL;
+	if (journal->j_f_bdev) {
+		fput(journal->j_f_bdev);
+		journal->j_f_bdev = NULL;
 	}
 }
 
@@ -2605,7 +2605,7 @@ static int journal_init_dev(struct super_block *super,
 
 	result = 0;
 
-	journal->j_bdev_handle = NULL;
+	journal->j_f_bdev = NULL;
 	jdev = SB_ONDISK_JOURNAL_DEVICE(super) ?
 	    new_decode_dev(SB_ONDISK_JOURNAL_DEVICE(super)) : super->s_dev;
 
@@ -2616,37 +2616,37 @@ static int journal_init_dev(struct super_block *super,
 	if ((!jdev_name || !jdev_name[0])) {
 		if (jdev == super->s_dev)
 			holder = NULL;
-		journal->j_bdev_handle = bdev_open_by_dev(jdev, blkdev_mode,
+		journal->j_f_bdev = bdev_file_open_by_dev(jdev, blkdev_mode,
 							  holder, NULL);
-		if (IS_ERR(journal->j_bdev_handle)) {
-			result = PTR_ERR(journal->j_bdev_handle);
-			journal->j_bdev_handle = NULL;
+		if (IS_ERR(journal->j_f_bdev)) {
+			result = PTR_ERR(journal->j_f_bdev);
+			journal->j_f_bdev = NULL;
 			reiserfs_warning(super, "sh-458",
 					 "cannot init journal device unknown-block(%u,%u): %i",
 					 MAJOR(jdev), MINOR(jdev), result);
 			return result;
 		} else if (jdev != super->s_dev)
-			set_blocksize(journal->j_bdev_handle->bdev,
+			set_blocksize(F_BDEV(journal->j_f_bdev),
 				      super->s_blocksize);
 
 		return 0;
 	}
 
-	journal->j_bdev_handle = bdev_open_by_path(jdev_name, blkdev_mode,
+	journal->j_f_bdev = bdev_file_open_by_path(jdev_name, blkdev_mode,
 						   holder, NULL);
-	if (IS_ERR(journal->j_bdev_handle)) {
-		result = PTR_ERR(journal->j_bdev_handle);
-		journal->j_bdev_handle = NULL;
+	if (IS_ERR(journal->j_f_bdev)) {
+		result = PTR_ERR(journal->j_f_bdev);
+		journal->j_f_bdev = NULL;
 		reiserfs_warning(super, "sh-457",
 				 "journal_init_dev: Cannot open '%s': %i",
 				 jdev_name, result);
 		return result;
 	}
 
-	set_blocksize(journal->j_bdev_handle->bdev, super->s_blocksize);
+	set_blocksize(F_BDEV(journal->j_f_bdev), super->s_blocksize);
 	reiserfs_info(super,
 		      "journal_init_dev: journal device: %pg\n",
-		      journal->j_bdev_handle->bdev);
+		      F_BDEV(journal->j_f_bdev));
 	return 0;
 }
 
@@ -2804,7 +2804,7 @@ int journal_init(struct super_block *sb, const char *j_dev_name,
 				 "journal header magic %x (device %pg) does "
 				 "not match to magic found in super block %x",
 				 jh->jh_journal.jp_journal_magic,
-				 journal->j_bdev_handle->bdev,
+				 F_BDEV(journal->j_f_bdev),
 				 sb_jp_journal_magic(rs));
 		brelse(bhjh);
 		goto free_and_return;
@@ -2828,7 +2828,7 @@ int journal_init(struct super_block *sb, const char *j_dev_name,
 	reiserfs_info(sb, "journal params: device %pg, size %u, "
 		      "journal first block %u, max trans len %u, max batch %u, "
 		      "max commit age %u, max trans age %u\n",
-		      journal->j_bdev_handle->bdev,
+		      F_BDEV(journal->j_f_bdev),
 		      SB_ONDISK_JOURNAL_SIZE(sb),
 		      SB_ONDISK_JOURNAL_1st_BLOCK(sb),
 		      journal->j_trans_max,
diff --git a/fs/reiserfs/procfs.c b/fs/reiserfs/procfs.c
index 83cb9402e0f9..ff90a822e8eb 100644
--- a/fs/reiserfs/procfs.c
+++ b/fs/reiserfs/procfs.c
@@ -354,7 +354,7 @@ static int show_journal(struct seq_file *m, void *unused)
 		   "prepare: \t%12lu\n"
 		   "prepare_retry: \t%12lu\n",
 		   DJP(jp_journal_1st_block),
-		   SB_JOURNAL(sb)->j_bdev_handle->bdev,
+		   F_BDEV(SB_JOURNAL(sb)->j_f_bdev),
 		   DJP(jp_journal_dev),
 		   DJP(jp_journal_size),
 		   DJP(jp_journal_trans_max),
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index 725667880e62..ea2f5950e5c6 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -299,7 +299,7 @@ struct reiserfs_journal {
 	/* oldest journal block.  start here for traverse */
 	struct reiserfs_journal_cnode *j_first;
 
-	struct bdev_handle *j_bdev_handle;
+	struct file *j_f_bdev;
 
 	/* first block on s_dev of reserved area journal */
 	int j_1st_reserved_block;
@@ -2810,10 +2810,10 @@ struct reiserfs_journal_header {
 
 /* We need these to make journal.c code more readable */
 #define journal_find_get_block(s, block) __find_get_block(\
-		SB_JOURNAL(s)->j_bdev_handle->bdev, block, s->s_blocksize)
-#define journal_getblk(s, block) __getblk(SB_JOURNAL(s)->j_bdev_handle->bdev,\
+		F_BDEV(SB_JOURNAL(s)->j_f_bdev), block, s->s_blocksize)
+#define journal_getblk(s, block) __getblk(F_BDEV(SB_JOURNAL(s)->j_f_bdev),\
 		block, s->s_blocksize)
-#define journal_bread(s, block) __bread(SB_JOURNAL(s)->j_bdev_handle->bdev,\
+#define journal_bread(s, block) __bread(F_BDEV(SB_JOURNAL(s)->j_f_bdev),\
 		block, s->s_blocksize)
 
 enum reiserfs_bh_state_bits {

-- 
2.42.0


