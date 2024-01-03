Return-Path: <linux-fsdevel+bounces-7202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37669822DC5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66E2283F3B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD6C1BDC3;
	Wed,  3 Jan 2024 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEGNaleu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142BC1B298;
	Wed,  3 Jan 2024 12:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50177C433C9;
	Wed,  3 Jan 2024 12:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286572;
	bh=SID0U4+F+emBv7sTRDN938vHGyc2XiVVgq2ljE3R5GY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hEGNaleuS9FdrFAtvpRLClDeHlXiHjQ4tvM5AnC661f8vTm5qF2NmC/2sHl74FuoB
	 83PBtdfUcMsMqCYveUEU5RIuuhW5ndZQCsvIxok8KQK/+AIsv0jzIHj0duMkZsNOP9
	 IqiXz6iyUrxSs04d+HC+1GHUASzS7u3IgYfDKHWTLetjYnAlXZelEv17gqZEyPZpVp
	 07QcdDCScVUmLD0XxWnAtVPdZdhSWwtA8d0QtClIJ69wr6Yn/DcN1mHtCbh6roj91m
	 jYZNaIfqkwQBXJAz/se0+BZ5LKzzCa+MseOD/3UidNw5vwmZqY8cfi37EJFO+AeD3h
	 dJEjJRBraIhHg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:19 +0100
Subject: [PATCH RFC 21/34] ext4: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-21-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=6883; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SID0U4+F+emBv7sTRDN938vHGyc2XiVVgq2ljE3R5GY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbTV1N37Y/q6t+UJW+zfHRPd5bRvmXyM8sQ5Nvd/d
 j5/bZRyt6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiTRcZGY4ceNMetV0q2lnG
 UOSZbpDS1taklitR7FyJYQ8ELecY/GNk2LmY0z50f69/iqBncMAfoYvbfBdpbtFgmbj8ktOLvbr
 XWQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ext4/ext4.h  |  2 +-
 fs/ext4/fsmap.c |  8 ++++----
 fs/ext4/super.c | 52 ++++++++++++++++++++++++++--------------------------
 3 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index a5d784872303..fa0de10ae12b 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1548,7 +1548,7 @@ struct ext4_sb_info {
 	unsigned long s_commit_interval;
 	u32 s_max_batch_time;
 	u32 s_min_batch_time;
-	struct bdev_handle *s_journal_bdev_handle;
+	struct file *s_journal_f_bdev;
 #ifdef CONFIG_QUOTA
 	/* Names of quota files with journalled quota */
 	char __rcu *s_qf_names[EXT4_MAXQUOTAS];
diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index 11e6f33677a2..6dac2866c3f1 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -576,9 +576,9 @@ static bool ext4_getfsmap_is_valid_device(struct super_block *sb,
 	if (fm->fmr_device == 0 || fm->fmr_device == UINT_MAX ||
 	    fm->fmr_device == new_encode_dev(sb->s_bdev->bd_dev))
 		return true;
-	if (EXT4_SB(sb)->s_journal_bdev_handle &&
+	if (EXT4_SB(sb)->s_journal_f_bdev &&
 	    fm->fmr_device ==
-	    new_encode_dev(EXT4_SB(sb)->s_journal_bdev_handle->bdev->bd_dev))
+	    new_encode_dev(F_BDEV(EXT4_SB(sb)->s_journal_f_bdev)->bd_dev))
 		return true;
 	return false;
 }
@@ -648,9 +648,9 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
 	memset(handlers, 0, sizeof(handlers));
 	handlers[0].gfd_dev = new_encode_dev(sb->s_bdev->bd_dev);
 	handlers[0].gfd_fn = ext4_getfsmap_datadev;
-	if (EXT4_SB(sb)->s_journal_bdev_handle) {
+	if (EXT4_SB(sb)->s_journal_f_bdev) {
 		handlers[1].gfd_dev = new_encode_dev(
-			EXT4_SB(sb)->s_journal_bdev_handle->bdev->bd_dev);
+			F_BDEV(EXT4_SB(sb)->s_journal_f_bdev)->bd_dev);
 		handlers[1].gfd_fn = ext4_getfsmap_logdev;
 	}
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0980845c8b8f..3fec1decccbf 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1359,14 +1359,14 @@ static void ext4_put_super(struct super_block *sb)
 
 	sync_blockdev(sb->s_bdev);
 	invalidate_bdev(sb->s_bdev);
-	if (sbi->s_journal_bdev_handle) {
+	if (sbi->s_journal_f_bdev) {
 		/*
 		 * Invalidate the journal device's buffers.  We don't want them
 		 * floating about in memory - the physical journal device may
 		 * hotswapped, and it breaks the `ro-after' testing code.
 		 */
-		sync_blockdev(sbi->s_journal_bdev_handle->bdev);
-		invalidate_bdev(sbi->s_journal_bdev_handle->bdev);
+		sync_blockdev(F_BDEV(sbi->s_journal_f_bdev));
+		invalidate_bdev(F_BDEV(sbi->s_journal_f_bdev));
 	}
 
 	ext4_xattr_destroy_cache(sbi->s_ea_inode_cache);
@@ -4242,7 +4242,7 @@ int ext4_calculate_overhead(struct super_block *sb)
 	 * Add the internal journal blocks whether the journal has been
 	 * loaded or not
 	 */
-	if (sbi->s_journal && !sbi->s_journal_bdev_handle)
+	if (sbi->s_journal && !sbi->s_journal_f_bdev)
 		overhead += EXT4_NUM_B2C(sbi, sbi->s_journal->j_total_len);
 	else if (ext4_has_feature_journal(sb) && !sbi->s_journal && j_inum) {
 		/* j_inum for internal journal is non-zero */
@@ -5679,9 +5679,9 @@ failed_mount9: __maybe_unused
 #endif
 	fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);
 	brelse(sbi->s_sbh);
-	if (sbi->s_journal_bdev_handle) {
-		invalidate_bdev(sbi->s_journal_bdev_handle->bdev);
-		bdev_release(sbi->s_journal_bdev_handle);
+	if (sbi->s_journal_f_bdev) {
+		invalidate_bdev(F_BDEV(sbi->s_journal_f_bdev));
+		fput(sbi->s_journal_f_bdev);
 	}
 out_fail:
 	invalidate_bdev(sb->s_bdev);
@@ -5851,30 +5851,30 @@ static journal_t *ext4_open_inode_journal(struct super_block *sb,
 	return journal;
 }
 
-static struct bdev_handle *ext4_get_journal_blkdev(struct super_block *sb,
+static struct file *ext4_get_journal_blkdev(struct super_block *sb,
 					dev_t j_dev, ext4_fsblk_t *j_start,
 					ext4_fsblk_t *j_len)
 {
 	struct buffer_head *bh;
 	struct block_device *bdev;
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	int hblock, blocksize;
 	ext4_fsblk_t sb_block;
 	unsigned long offset;
 	struct ext4_super_block *es;
 	int errno;
 
-	bdev_handle = bdev_open_by_dev(j_dev,
+	f_bdev = bdev_file_open_by_dev(j_dev,
 		BLK_OPEN_READ | BLK_OPEN_WRITE | BLK_OPEN_RESTRICT_WRITES,
 		sb, &fs_holder_ops);
-	if (IS_ERR(bdev_handle)) {
+	if (IS_ERR(f_bdev)) {
 		ext4_msg(sb, KERN_ERR,
 			 "failed to open journal device unknown-block(%u,%u) %ld",
-			 MAJOR(j_dev), MINOR(j_dev), PTR_ERR(bdev_handle));
-		return bdev_handle;
+			 MAJOR(j_dev), MINOR(j_dev), PTR_ERR(f_bdev));
+		return f_bdev;
 	}
 
-	bdev = bdev_handle->bdev;
+	bdev = F_BDEV(f_bdev);
 	blocksize = sb->s_blocksize;
 	hblock = bdev_logical_block_size(bdev);
 	if (blocksize < hblock) {
@@ -5921,12 +5921,12 @@ static struct bdev_handle *ext4_get_journal_blkdev(struct super_block *sb,
 	*j_start = sb_block + 1;
 	*j_len = ext4_blocks_count(es);
 	brelse(bh);
-	return bdev_handle;
+	return f_bdev;
 
 out_bh:
 	brelse(bh);
 out_bdev:
-	bdev_release(bdev_handle);
+	fput(f_bdev);
 	return ERR_PTR(errno);
 }
 
@@ -5936,14 +5936,14 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
 	journal_t *journal;
 	ext4_fsblk_t j_start;
 	ext4_fsblk_t j_len;
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	int errno = 0;
 
-	bdev_handle = ext4_get_journal_blkdev(sb, j_dev, &j_start, &j_len);
-	if (IS_ERR(bdev_handle))
-		return ERR_CAST(bdev_handle);
+	f_bdev = ext4_get_journal_blkdev(sb, j_dev, &j_start, &j_len);
+	if (IS_ERR(f_bdev))
+		return ERR_CAST(f_bdev);
 
-	journal = jbd2_journal_init_dev(bdev_handle->bdev, sb->s_bdev, j_start,
+	journal = jbd2_journal_init_dev(F_BDEV(f_bdev), sb->s_bdev, j_start,
 					j_len, sb->s_blocksize);
 	if (IS_ERR(journal)) {
 		ext4_msg(sb, KERN_ERR, "failed to create device journal");
@@ -5958,14 +5958,14 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
 		goto out_journal;
 	}
 	journal->j_private = sb;
-	EXT4_SB(sb)->s_journal_bdev_handle = bdev_handle;
+	EXT4_SB(sb)->s_journal_f_bdev = f_bdev;
 	ext4_init_journal_params(sb, journal);
 	return journal;
 
 out_journal:
 	jbd2_journal_destroy(journal);
 out_bdev:
-	bdev_release(bdev_handle);
+	fput(f_bdev);
 	return ERR_PTR(errno);
 }
 
@@ -7323,12 +7323,12 @@ static inline int ext3_feature_set_ok(struct super_block *sb)
 static void ext4_kill_sb(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	struct bdev_handle *handle = sbi ? sbi->s_journal_bdev_handle : NULL;
+	struct file *f_bdev = sbi ? sbi->s_journal_f_bdev : NULL;
 
 	kill_block_super(sb);
 
-	if (handle)
-		bdev_release(handle);
+	if (f_bdev)
+		fput(f_bdev);
 }
 
 static struct file_system_type ext4_fs_type = {

-- 
2.42.0


