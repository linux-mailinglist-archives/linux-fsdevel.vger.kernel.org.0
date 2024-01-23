Return-Path: <linux-fsdevel+bounces-8566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 229A8839014
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4674E1C2759D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55725FB84;
	Tue, 23 Jan 2024 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLCE1ZyR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8CC5F843;
	Tue, 23 Jan 2024 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016470; cv=none; b=QKCG+MFdzk619AbqxR9cX4IJLvmkM/lYYM8eZTtn2bDjmpeIjexbZo5NyjZ1MXg7xQSjSAq1UGBXJgVrfaoGUQThajvEgl3+qz6SFo3Jjisp/mSRKcurHBLPCkAEwmeTU0n285fjbUZEsQyZbi2BdP+8qzBwVbtuCeHgwPAvT3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016470; c=relaxed/simple;
	bh=pGjrOxtkCxI7qKbjAi+XbZBqv1L/rE4b7FEcDVknDHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L+a7bcFbwDJS7B/bty4xsRbeIeTqB9sFaJJv9slBbm+Yw/gZsTVGdTVHDLQF9KXu0TmEIOplVy79AnFDCfPN88qYy8NnzWB/O1RvJ0aTFLTHIcCjvZWS2SkX+kbe4DE4erS1/YxlxqKmSUWCJIuiItLCWctzq0EA2wF2zU/LeuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLCE1ZyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B143FC43390;
	Tue, 23 Jan 2024 13:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016469;
	bh=pGjrOxtkCxI7qKbjAi+XbZBqv1L/rE4b7FEcDVknDHE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OLCE1ZyRIce6S/X3u0/UqBF/1kwjVunapEKJkTaLcEGcZHmay4LKBmGYK+PElAc/k
	 JSU2j9oTwOXJHzL37xGSbX/NvX3jTsQ53NaWGShc6ZOeWH1RFWdIi+FFZtc85yBXtL
	 krvh/cq6xXu2o6Jr7azqNV+cvKbZUusOUYNA+8bcaLIhumfNbnaQBx0k03Uqajj0nZ
	 FKTPxcg7ZNazyvPNpZ7kOUPwZRr6J8ocISj0fvdI/LvpKy+ZkekbdwuJZq5AgESGSC
	 +XgmG/JuVoxQQChTJ4DTfuTe+fD9FQZgfGbSZkfdsXRj3xh82+f3ZH0NRNsMsbpmmg
	 pLMdRxkqUpuaQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:38 +0100
Subject: [PATCH v2 21/34] ext4: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-21-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=7000; i=brauner@kernel.org;
 h=from:subject:message-id; bh=pGjrOxtkCxI7qKbjAi+XbZBqv1L/rE4b7FEcDVknDHE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu37dgs33z7UPSKcpqmqvNS2LucITukoiWTJ/3VeSUh
 g1HYpNaRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQ+7GP4yVj1tNgkdnJRZdHm
 cp/701I213jVGjGZN37oOv1vos/Gq4wMmwLaX9fMKVN42vL4v9SBx5PeX3rmIzxj7eIfYv+sOpl
 ZeAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ext4/ext4.h  |  2 +-
 fs/ext4/fsmap.c |  8 ++++----
 fs/ext4/super.c | 52 ++++++++++++++++++++++++++--------------------------
 3 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index a5d784872303..dcdad5da419e 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1548,7 +1548,7 @@ struct ext4_sb_info {
 	unsigned long s_commit_interval;
 	u32 s_max_batch_time;
 	u32 s_min_batch_time;
-	struct bdev_handle *s_journal_bdev_handle;
+	struct file *s_journal_bdev_file;
 #ifdef CONFIG_QUOTA
 	/* Names of quota files with journalled quota */
 	char __rcu *s_qf_names[EXT4_MAXQUOTAS];
diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index 11e6f33677a2..df853c4d3a8c 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -576,9 +576,9 @@ static bool ext4_getfsmap_is_valid_device(struct super_block *sb,
 	if (fm->fmr_device == 0 || fm->fmr_device == UINT_MAX ||
 	    fm->fmr_device == new_encode_dev(sb->s_bdev->bd_dev))
 		return true;
-	if (EXT4_SB(sb)->s_journal_bdev_handle &&
+	if (EXT4_SB(sb)->s_journal_bdev_file &&
 	    fm->fmr_device ==
-	    new_encode_dev(EXT4_SB(sb)->s_journal_bdev_handle->bdev->bd_dev))
+	    new_encode_dev(file_bdev(EXT4_SB(sb)->s_journal_bdev_file)->bd_dev))
 		return true;
 	return false;
 }
@@ -648,9 +648,9 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
 	memset(handlers, 0, sizeof(handlers));
 	handlers[0].gfd_dev = new_encode_dev(sb->s_bdev->bd_dev);
 	handlers[0].gfd_fn = ext4_getfsmap_datadev;
-	if (EXT4_SB(sb)->s_journal_bdev_handle) {
+	if (EXT4_SB(sb)->s_journal_bdev_file) {
 		handlers[1].gfd_dev = new_encode_dev(
-			EXT4_SB(sb)->s_journal_bdev_handle->bdev->bd_dev);
+			file_bdev(EXT4_SB(sb)->s_journal_bdev_file)->bd_dev);
 		handlers[1].gfd_fn = ext4_getfsmap_logdev;
 	}
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dcba0f85dfe2..aa007710cfc3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1359,14 +1359,14 @@ static void ext4_put_super(struct super_block *sb)
 
 	sync_blockdev(sb->s_bdev);
 	invalidate_bdev(sb->s_bdev);
-	if (sbi->s_journal_bdev_handle) {
+	if (sbi->s_journal_bdev_file) {
 		/*
 		 * Invalidate the journal device's buffers.  We don't want them
 		 * floating about in memory - the physical journal device may
 		 * hotswapped, and it breaks the `ro-after' testing code.
 		 */
-		sync_blockdev(sbi->s_journal_bdev_handle->bdev);
-		invalidate_bdev(sbi->s_journal_bdev_handle->bdev);
+		sync_blockdev(file_bdev(sbi->s_journal_bdev_file));
+		invalidate_bdev(file_bdev(sbi->s_journal_bdev_file));
 	}
 
 	ext4_xattr_destroy_cache(sbi->s_ea_inode_cache);
@@ -4233,7 +4233,7 @@ int ext4_calculate_overhead(struct super_block *sb)
 	 * Add the internal journal blocks whether the journal has been
 	 * loaded or not
 	 */
-	if (sbi->s_journal && !sbi->s_journal_bdev_handle)
+	if (sbi->s_journal && !sbi->s_journal_bdev_file)
 		overhead += EXT4_NUM_B2C(sbi, sbi->s_journal->j_total_len);
 	else if (ext4_has_feature_journal(sb) && !sbi->s_journal && j_inum) {
 		/* j_inum for internal journal is non-zero */
@@ -5670,9 +5670,9 @@ failed_mount9: __maybe_unused
 #endif
 	fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);
 	brelse(sbi->s_sbh);
-	if (sbi->s_journal_bdev_handle) {
-		invalidate_bdev(sbi->s_journal_bdev_handle->bdev);
-		bdev_release(sbi->s_journal_bdev_handle);
+	if (sbi->s_journal_bdev_file) {
+		invalidate_bdev(file_bdev(sbi->s_journal_bdev_file));
+		fput(sbi->s_journal_bdev_file);
 	}
 out_fail:
 	invalidate_bdev(sb->s_bdev);
@@ -5842,30 +5842,30 @@ static journal_t *ext4_open_inode_journal(struct super_block *sb,
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
+	struct file *bdev_file;
 	int hblock, blocksize;
 	ext4_fsblk_t sb_block;
 	unsigned long offset;
 	struct ext4_super_block *es;
 	int errno;
 
-	bdev_handle = bdev_open_by_dev(j_dev,
+	bdev_file = bdev_file_open_by_dev(j_dev,
 		BLK_OPEN_READ | BLK_OPEN_WRITE | BLK_OPEN_RESTRICT_WRITES,
 		sb, &fs_holder_ops);
-	if (IS_ERR(bdev_handle)) {
+	if (IS_ERR(bdev_file)) {
 		ext4_msg(sb, KERN_ERR,
 			 "failed to open journal device unknown-block(%u,%u) %ld",
-			 MAJOR(j_dev), MINOR(j_dev), PTR_ERR(bdev_handle));
-		return bdev_handle;
+			 MAJOR(j_dev), MINOR(j_dev), PTR_ERR(bdev_file));
+		return bdev_file;
 	}
 
-	bdev = bdev_handle->bdev;
+	bdev = file_bdev(bdev_file);
 	blocksize = sb->s_blocksize;
 	hblock = bdev_logical_block_size(bdev);
 	if (blocksize < hblock) {
@@ -5912,12 +5912,12 @@ static struct bdev_handle *ext4_get_journal_blkdev(struct super_block *sb,
 	*j_start = sb_block + 1;
 	*j_len = ext4_blocks_count(es);
 	brelse(bh);
-	return bdev_handle;
+	return bdev_file;
 
 out_bh:
 	brelse(bh);
 out_bdev:
-	bdev_release(bdev_handle);
+	fput(bdev_file);
 	return ERR_PTR(errno);
 }
 
@@ -5927,14 +5927,14 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
 	journal_t *journal;
 	ext4_fsblk_t j_start;
 	ext4_fsblk_t j_len;
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	int errno = 0;
 
-	bdev_handle = ext4_get_journal_blkdev(sb, j_dev, &j_start, &j_len);
-	if (IS_ERR(bdev_handle))
-		return ERR_CAST(bdev_handle);
+	bdev_file = ext4_get_journal_blkdev(sb, j_dev, &j_start, &j_len);
+	if (IS_ERR(bdev_file))
+		return ERR_CAST(bdev_file);
 
-	journal = jbd2_journal_init_dev(bdev_handle->bdev, sb->s_bdev, j_start,
+	journal = jbd2_journal_init_dev(file_bdev(bdev_file), sb->s_bdev, j_start,
 					j_len, sb->s_blocksize);
 	if (IS_ERR(journal)) {
 		ext4_msg(sb, KERN_ERR, "failed to create device journal");
@@ -5949,14 +5949,14 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
 		goto out_journal;
 	}
 	journal->j_private = sb;
-	EXT4_SB(sb)->s_journal_bdev_handle = bdev_handle;
+	EXT4_SB(sb)->s_journal_bdev_file = bdev_file;
 	ext4_init_journal_params(sb, journal);
 	return journal;
 
 out_journal:
 	jbd2_journal_destroy(journal);
 out_bdev:
-	bdev_release(bdev_handle);
+	fput(bdev_file);
 	return ERR_PTR(errno);
 }
 
@@ -7314,12 +7314,12 @@ static inline int ext3_feature_set_ok(struct super_block *sb)
 static void ext4_kill_sb(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	struct bdev_handle *handle = sbi ? sbi->s_journal_bdev_handle : NULL;
+	struct file *bdev_file = sbi ? sbi->s_journal_bdev_file : NULL;
 
 	kill_block_super(sb);
 
-	if (handle)
-		bdev_release(handle);
+	if (bdev_file)
+		fput(bdev_file);
 }
 
 static struct file_system_type ext4_fs_type = {

-- 
2.43.0


