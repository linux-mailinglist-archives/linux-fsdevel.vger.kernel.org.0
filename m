Return-Path: <linux-fsdevel+bounces-7212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CFD822DDA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562E2285BCC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BA61C6B2;
	Wed,  3 Jan 2024 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIiE1LN9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E021C696;
	Wed,  3 Jan 2024 12:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F543C433C7;
	Wed,  3 Jan 2024 12:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286594;
	bh=SNksmdREYQ4G4E9enbuAVrHtdHDfuHJxBC6kFZXSeMc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JIiE1LN9TuT3otlMK8p4cQarxYhmikjja9bRzW0+Sff/+XTEUKS7WoJt4UxhreaIE
	 Sh2QwbH1CywvpwM3pXt++f04lJ3aUb9Rh1Cp2z5gojzv0JVBZ9EZvJDUuHbSSXCHjT
	 u1TFEh7D5tx5StHVH7UFW9twKnGpSqM9FpRuLphN8MbGbyAshux9+TKogSHxuOglXe
	 +8z2joTahRWS6Ir+t0KcoWGNZw/JONDZ7/zTiSQFpTxVr3LsjDs8QoswUB0rVnKs09
	 y3PDTSihwRko6j0l5dM49z8a0aVWJ91OLe6nMMiWk3Qs+2/uAZqn3j5C3B9n/N3KEs
	 YhFU4U29xigGw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:29 +0100
Subject: [PATCH RFC 31/34] ext4: rely on sb->f_bdev only
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-31-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=8254; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SNksmdREYQ4G4E9enbuAVrHtdHDfuHJxBC6kFZXSeMc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbTNFLwgcerw4gPXfT84WrhsVVw5Va+bfZ/817T1l
 frLTzdGd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykvYeRoUcp2903k0Nt5bxM
 xkPuGxaJ3Pv1xjTc69HcasUTfAu3VjAyHOtQPB5XE2jweZJ63kbzNkGROR9fG1946NPHJX8nprW
 GEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ext4/dir.c         |  2 +-
 fs/ext4/ext4_jbd2.c   |  2 +-
 fs/ext4/fast_commit.c |  2 +-
 fs/ext4/super.c       | 36 ++++++++++++++++++------------------
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 3985f8c33f95..992f09aff438 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -192,7 +192,7 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 					(PAGE_SHIFT - inode->i_blkbits);
 			if (!ra_has_index(&file->f_ra, index))
 				page_cache_sync_readahead(
-					sb->s_bdev->bd_inode->i_mapping,
+					F_BDEV(sb->s_f_bdev)->bd_inode->i_mapping,
 					&file->f_ra, file,
 					index, 1);
 			file->f_ra.prev_pos = (loff_t)index << PAGE_SHIFT;
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index d1a2e6624401..97f9ba412f1e 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -206,7 +206,7 @@ static void ext4_journal_abort_handle(const char *caller, unsigned int line,
 
 static void ext4_check_bdev_write_error(struct super_block *sb)
 {
-	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
+	struct address_space *mapping = F_BDEV(sb->s_f_bdev)->bd_inode->i_mapping;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	int err;
 
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 87c009e0c59a..60ca93b7df81 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1605,7 +1605,7 @@ static int ext4_fc_replay_inode(struct super_block *sb,
 out:
 	iput(inode);
 	if (!ret)
-		blkdev_issue_flush(sb->s_bdev);
+		blkdev_issue_flush(F_BDEV(sb->s_f_bdev));
 
 	return 0;
 }
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 3fec1decccbf..6ea654105076 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -244,7 +244,7 @@ static struct buffer_head *__ext4_sb_bread_gfp(struct super_block *sb,
 struct buffer_head *ext4_sb_bread(struct super_block *sb, sector_t block,
 				   blk_opf_t op_flags)
 {
-	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev->bd_inode->i_mapping,
+	gfp_t gfp = mapping_gfp_constraint(F_BDEV(sb->s_f_bdev)->bd_inode->i_mapping,
 			~__GFP_FS) | __GFP_MOVABLE;
 
 	return __ext4_sb_bread_gfp(sb, block, op_flags, gfp);
@@ -253,7 +253,7 @@ struct buffer_head *ext4_sb_bread(struct super_block *sb, sector_t block,
 struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 					    sector_t block)
 {
-	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev->bd_inode->i_mapping,
+	gfp_t gfp = mapping_gfp_constraint(F_BDEV(sb->s_f_bdev)->bd_inode->i_mapping,
 			~__GFP_FS);
 
 	return __ext4_sb_bread_gfp(sb, block, 0, gfp);
@@ -261,7 +261,7 @@ struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 
 void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
 {
-	struct buffer_head *bh = bdev_getblk(sb->s_bdev, block,
+	struct buffer_head *bh = bdev_getblk(F_BDEV(sb->s_f_bdev), block,
 			sb->s_blocksize, GFP_NOWAIT | __GFP_NOWARN);
 
 	if (likely(bh)) {
@@ -477,7 +477,7 @@ static void ext4_maybe_update_superblock(struct super_block *sb)
 		return;
 
 	lifetime_write_kbytes = sbi->s_kbytes_written +
-		((part_stat_read(sb->s_bdev, sectors[STAT_WRITE]) -
+		((part_stat_read(F_BDEV(sb->s_f_bdev), sectors[STAT_WRITE]) -
 		  sbi->s_sectors_written_start) >> 1);
 
 	/* Get the number of kilobytes not written to disk to account
@@ -502,7 +502,7 @@ static void ext4_maybe_update_superblock(struct super_block *sb)
  */
 static int block_device_ejected(struct super_block *sb)
 {
-	struct inode *bd_inode = sb->s_bdev->bd_inode;
+	struct inode *bd_inode = F_BDEV(sb->s_f_bdev)->bd_inode;
 	struct backing_dev_info *bdi = inode_to_bdi(bd_inode);
 
 	return bdi->dev == NULL;
@@ -722,7 +722,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 			jbd2_journal_abort(journal, -EIO);
 	}
 
-	if (!bdev_read_only(sb->s_bdev)) {
+	if (!bdev_read_only(F_BDEV(sb->s_f_bdev))) {
 		save_error_info(sb, error, ino, block, func, line);
 		/*
 		 * In case the fs should keep running, we need to writeout
@@ -1084,7 +1084,7 @@ __acquires(bitlock)
 		if (test_opt(sb, WARN_ON_ERROR))
 			WARN_ON_ONCE(1);
 		EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
-		if (!bdev_read_only(sb->s_bdev)) {
+		if (!bdev_read_only(F_BDEV(sb->s_f_bdev))) {
 			save_error_info(sb, EFSCORRUPTED, ino, block, function,
 					line);
 			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
@@ -1357,8 +1357,8 @@ static void ext4_put_super(struct super_block *sb)
 		dump_orphan_list(sb, sbi);
 	ASSERT(list_empty(&sbi->s_orphan));
 
-	sync_blockdev(sb->s_bdev);
-	invalidate_bdev(sb->s_bdev);
+	sync_blockdev(F_BDEV(sb->s_f_bdev));
+	invalidate_bdev(F_BDEV(sb->s_f_bdev));
 	if (sbi->s_journal_f_bdev) {
 		/*
 		 * Invalidate the journal device's buffers.  We don't want them
@@ -4338,7 +4338,7 @@ static struct ext4_sb_info *ext4_alloc_sbi(struct super_block *sb)
 	if (!sbi)
 		return NULL;
 
-	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off,
+	sbi->s_daxdev = fs_dax_get_by_bdev(F_BDEV(sb->s_f_bdev), &sbi->s_dax_part_off,
 					   NULL, NULL);
 
 	sbi->s_blockgroup_lock =
@@ -5231,7 +5231,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 
 	sbi->s_inode_readahead_blks = EXT4_DEF_INODE_READAHEAD_BLKS;
 	sbi->s_sectors_written_start =
-		part_stat_read(sb->s_bdev, sectors[STAT_WRITE]);
+		part_stat_read(F_BDEV(sb->s_f_bdev), sectors[STAT_WRITE]);
 
 	err = ext4_load_super(sb, &logical_sb_block, silent);
 	if (err)
@@ -5585,7 +5585,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	 * used to detect the metadata async write error.
 	 */
 	spin_lock_init(&sbi->s_bdev_wb_lock);
-	errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
+	errseq_check_and_advance(&F_BDEV(sb->s_f_bdev)->bd_inode->i_mapping->wb_err,
 				 &sbi->s_bdev_wb_err);
 	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
 	ext4_orphan_cleanup(sb, es);
@@ -5605,7 +5605,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 			goto failed_mount10;
 	}
 
-	if (test_opt(sb, DISCARD) && !bdev_max_discard_sectors(sb->s_bdev))
+	if (test_opt(sb, DISCARD) && !bdev_max_discard_sectors(F_BDEV(sb->s_f_bdev)))
 		ext4_msg(sb, KERN_WARNING,
 			 "mounting with \"discard\" option, but the device does not support discard");
 
@@ -5684,7 +5684,7 @@ failed_mount9: __maybe_unused
 		fput(sbi->s_journal_f_bdev);
 	}
 out_fail:
-	invalidate_bdev(sb->s_bdev);
+	invalidate_bdev(F_BDEV(sb->s_f_bdev));
 	sb->s_fs_info = NULL;
 	return err;
 }
@@ -5943,7 +5943,7 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
 	if (IS_ERR(f_bdev))
 		return ERR_CAST(f_bdev);
 
-	journal = jbd2_journal_init_dev(F_BDEV(f_bdev), sb->s_bdev, j_start,
+	journal = jbd2_journal_init_dev(F_BDEV(f_bdev), F_BDEV(sb->s_f_bdev), j_start,
 					j_len, sb->s_blocksize);
 	if (IS_ERR(journal)) {
 		ext4_msg(sb, KERN_ERR, "failed to create device journal");
@@ -6008,7 +6008,7 @@ static int ext4_load_journal(struct super_block *sb,
 	}
 
 	journal_dev_ro = bdev_read_only(journal->j_dev);
-	really_read_only = bdev_read_only(sb->s_bdev) | journal_dev_ro;
+	really_read_only = bdev_read_only(F_BDEV(sb->s_f_bdev)) | journal_dev_ro;
 
 	if (journal_dev_ro && !sb_rdonly(sb)) {
 		ext4_msg(sb, KERN_ERR,
@@ -6125,7 +6125,7 @@ static void ext4_update_super(struct super_block *sb)
 		ext4_update_tstamp(es, s_wtime);
 	es->s_kbytes_written =
 		cpu_to_le64(sbi->s_kbytes_written +
-		    ((part_stat_read(sb->s_bdev, sectors[STAT_WRITE]) -
+		    ((part_stat_read(F_BDEV(sb->s_f_bdev), sectors[STAT_WRITE]) -
 		      sbi->s_sectors_written_start) >> 1));
 	if (percpu_counter_initialized(&sbi->s_freeclusters_counter))
 		ext4_free_blocks_count_set(es,
@@ -6359,7 +6359,7 @@ static int ext4_sync_fs(struct super_block *sb, int wait)
 		needs_barrier = true;
 	if (needs_barrier) {
 		int err;
-		err = blkdev_issue_flush(sb->s_bdev);
+		err = blkdev_issue_flush(F_BDEV(sb->s_f_bdev));
 		if (!ret)
 			ret = err;
 	}

-- 
2.42.0


