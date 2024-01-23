Return-Path: <linux-fsdevel+bounces-8579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5DB83902C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417111F2490F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E27461687;
	Tue, 23 Jan 2024 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ir/MvjP9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA93604A3;
	Tue, 23 Jan 2024 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016501; cv=none; b=UC4ExPa2OS5QM9v7tf4L15LUCLG0pEDc+OmzfsKPYgxxNQzoHXm1yiCsT+GezEWAu3p5WINIbmDPObtThLmiJVmx5+ASr5JDBXE4eMefGCp8BkIbbCY78YLpaw3C6WDdsftT2Xv9+MIhZQy57gDEpThZd4noq5VLZpyUT73y3uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016501; c=relaxed/simple;
	bh=8czXCgs+iZq1VSEgQwQKgvFS6RHuOM0VTa52UzDIm1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dPG0//FjtL9FdNnSIFfQpJksqMJBszmENIiqHg3gMbryqthptGmlw//JT9egNJnujQcQ87jLtzeRMSD0L5CtHt6HEb8RSU6Chyn1sA5ydTMKyKrRfPT6MrJO8HCTdji5K62Yh7etPUzCZl15fRf/R1s9NkfugXeIoCtBy4MA8PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ir/MvjP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B351C32792;
	Tue, 23 Jan 2024 13:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016501;
	bh=8czXCgs+iZq1VSEgQwQKgvFS6RHuOM0VTa52UzDIm1g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ir/MvjP9gnOfmHt7yjAV0nNbvqJGry/7gNM+wmjOYTQHyycqs3/C4Ik+S+h+j6x5K
	 Bs5Qs2EKAnA6ZKGUqJrClIOVKNVU42RZh7x0epg6LhVgxiNPu5Sfb6n13XwRXes3Sg
	 AQFEGImX+n83jZvQ5Apfr6NZ16O2aC/1PnKWvMySRV98oagMuqYLRbx0hjc6rohhau
	 Cmcm4rAL3hcmdtHpZgEAR8adyr+CyNxSgJy3EzX35C6jAIlJGCgsNnidbp86X0fGIy
	 3YCtrDvhrsWrl/aF3LsGTlp6KZNa1yKpFY34SIBfbc94GZBna1JKpZhkkVP7KsqXKH
	 x5WVnoXJOXwKA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:51 +0100
Subject: [PATCH v2 34/34] ext4: rely on sb->f_bdev only
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-34-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=9976; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8czXCgs+iZq1VSEgQwQKgvFS6RHuOM0VTa52UzDIm1g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu37dQeP1DBbEH+xs0GkON/u/nWacVEvRG0/4Hj9rTu
 aq9rqL7OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaSeIzhr8R9kbmBH/yry3s8
 fGJtWDRk7dMv6fPZTeWq+2D3pWnFXYa/Ik66Ryps6+4lfsg7E/BP+EHyBysXpjkvDzdPD8r+Yb6
 RBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

(1) Instead of bdev->bd_inode->i_mapping we do f_bdev->f_mapping
(2) Instead of bdev->bd_inode we could do f_bdev->f_inode

I mention this explicitly because (1) is dependent on how the block
device is opened while (2) isn't. Consider:

mount -t tmpfs tmpfs /mnt
mknod /mnt/foo b <minor> <major>
open("/mnt/foo", O_RDWR);

then (1) doesn't work because f_bdev->f_inode is a tmpfs inode _not_ the
actual bdev filesystem inode. But (2) is still the bd_inode->i_mapping
as that's set up during bdev_open().

IOW, I'm explicitly _not_ going via f_bdev->f_inode but via
f_bdev->f_mapping->host aka bdev_file_inode(f_bdev). Currently this
isn't a problem because sb->s_bdev_file stashes the a block device file
opened via bdev_open_by_*() which is always a file on the bdev
filesystem.

_If_ we ever wanted to allow userspace to pass a block device file
descriptor during superblock creation. Say:

fsconfig(fs_fd, FSCONFIG_CMD_CREATE_EXCL, "source", bdev_fd);

then using f_bdev->f_inode would be very wrong. Another thing to keep in
mind there would be that this would implicitly pin another filesystem.
Say:

mount -t ext4 /dev/sda /mnt
mknod /mnt/foo b <minor> <major>
bdev_fd = open("/mnt/foo", O_RDWR);

fd_fs = fsopen("xfs")
fsconfig(fd_fs, FSCONFIG_CMD_CREATE, "source", bdev_fd);
fd_mnt = fsmount(fd_fs);
move_mount(fd_mnt, "/mnt2");

umount /mnt # EBUSY

Because the xfs filesystem now pins the ext4 filesystem via the
bdev_file we're keeping. In other words, this is probably a bad idea and
if we allow userspace to do this then we should only use the provided fd
to lookup the block device and open our own handle to it.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ext4/dir.c         |  2 +-
 fs/ext4/ext4_jbd2.c   |  2 +-
 fs/ext4/fast_commit.c |  2 +-
 fs/ext4/super.c       | 37 +++++++++++++++++++------------------
 4 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 3985f8c33f95..0733bc1eec7a 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -192,7 +192,7 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 					(PAGE_SHIFT - inode->i_blkbits);
 			if (!ra_has_index(&file->f_ra, index))
 				page_cache_sync_readahead(
-					sb->s_bdev->bd_inode->i_mapping,
+					sb->s_bdev_file->f_mapping,
 					&file->f_ra, file,
 					index, 1);
 			file->f_ra.prev_pos = (loff_t)index << PAGE_SHIFT;
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 5d8055161acd..dbb9aff07ac1 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -206,7 +206,7 @@ static void ext4_journal_abort_handle(const char *caller, unsigned int line,
 
 static void ext4_check_bdev_write_error(struct super_block *sb)
 {
-	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
+	struct address_space *mapping = sb->s_bdev_file->f_mapping;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	int err;
 
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 87c009e0c59a..9a4eb542735e 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1605,7 +1605,7 @@ static int ext4_fc_replay_inode(struct super_block *sb,
 out:
 	iput(inode);
 	if (!ret)
-		blkdev_issue_flush(sb->s_bdev);
+		blkdev_issue_flush(file_bdev(sb->s_bdev_file));
 
 	return 0;
 }
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index aa007710cfc3..edb7221dce18 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -244,7 +244,7 @@ static struct buffer_head *__ext4_sb_bread_gfp(struct super_block *sb,
 struct buffer_head *ext4_sb_bread(struct super_block *sb, sector_t block,
 				   blk_opf_t op_flags)
 {
-	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev->bd_inode->i_mapping,
+	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev_file->f_mapping,
 			~__GFP_FS) | __GFP_MOVABLE;
 
 	return __ext4_sb_bread_gfp(sb, block, op_flags, gfp);
@@ -253,7 +253,7 @@ struct buffer_head *ext4_sb_bread(struct super_block *sb, sector_t block,
 struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 					    sector_t block)
 {
-	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev->bd_inode->i_mapping,
+	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev_file->f_mapping,
 			~__GFP_FS);
 
 	return __ext4_sb_bread_gfp(sb, block, 0, gfp);
@@ -261,7 +261,7 @@ struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 
 void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
 {
-	struct buffer_head *bh = bdev_getblk(sb->s_bdev, block,
+	struct buffer_head *bh = bdev_getblk(file_bdev(sb->s_bdev_file), block,
 			sb->s_blocksize, GFP_NOWAIT | __GFP_NOWARN);
 
 	if (likely(bh)) {
@@ -477,7 +477,7 @@ static void ext4_maybe_update_superblock(struct super_block *sb)
 		return;
 
 	lifetime_write_kbytes = sbi->s_kbytes_written +
-		((part_stat_read(sb->s_bdev, sectors[STAT_WRITE]) -
+		((part_stat_read(file_bdev(sb->s_bdev_file), sectors[STAT_WRITE]) -
 		  sbi->s_sectors_written_start) >> 1);
 
 	/* Get the number of kilobytes not written to disk to account
@@ -502,7 +502,7 @@ static void ext4_maybe_update_superblock(struct super_block *sb)
  */
 static int block_device_ejected(struct super_block *sb)
 {
-	struct inode *bd_inode = sb->s_bdev->bd_inode;
+	struct inode *bd_inode = bdev_file_inode(sb->s_bdev_file);
 	struct backing_dev_info *bdi = inode_to_bdi(bd_inode);
 
 	return bdi->dev == NULL;
@@ -722,7 +722,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 			jbd2_journal_abort(journal, -EIO);
 	}
 
-	if (!bdev_read_only(sb->s_bdev)) {
+	if (!bdev_read_only(file_bdev(sb->s_bdev_file))) {
 		save_error_info(sb, error, ino, block, func, line);
 		/*
 		 * In case the fs should keep running, we need to writeout
@@ -1084,7 +1084,7 @@ __acquires(bitlock)
 		if (test_opt(sb, WARN_ON_ERROR))
 			WARN_ON_ONCE(1);
 		EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
-		if (!bdev_read_only(sb->s_bdev)) {
+		if (!bdev_read_only(file_bdev(sb->s_bdev_file))) {
 			save_error_info(sb, EFSCORRUPTED, ino, block, function,
 					line);
 			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
@@ -1357,8 +1357,8 @@ static void ext4_put_super(struct super_block *sb)
 		dump_orphan_list(sb, sbi);
 	ASSERT(list_empty(&sbi->s_orphan));
 
-	sync_blockdev(sb->s_bdev);
-	invalidate_bdev(sb->s_bdev);
+	sync_blockdev(file_bdev(sb->s_bdev_file));
+	invalidate_bdev(file_bdev(sb->s_bdev_file));
 	if (sbi->s_journal_bdev_file) {
 		/*
 		 * Invalidate the journal device's buffers.  We don't want them
@@ -4329,7 +4329,7 @@ static struct ext4_sb_info *ext4_alloc_sbi(struct super_block *sb)
 	if (!sbi)
 		return NULL;
 
-	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off,
+	sbi->s_daxdev = fs_dax_get_by_bdev(file_bdev(sb->s_bdev_file), &sbi->s_dax_part_off,
 					   NULL, NULL);
 
 	sbi->s_blockgroup_lock =
@@ -5222,7 +5222,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 
 	sbi->s_inode_readahead_blks = EXT4_DEF_INODE_READAHEAD_BLKS;
 	sbi->s_sectors_written_start =
-		part_stat_read(sb->s_bdev, sectors[STAT_WRITE]);
+		part_stat_read(file_bdev(sb->s_bdev_file), sectors[STAT_WRITE]);
 
 	err = ext4_load_super(sb, &logical_sb_block, silent);
 	if (err)
@@ -5576,7 +5576,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	 * used to detect the metadata async write error.
 	 */
 	spin_lock_init(&sbi->s_bdev_wb_lock);
-	errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
+	errseq_check_and_advance(&sb->s_bdev_file->f_mapping->wb_err,
 				 &sbi->s_bdev_wb_err);
 	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
 	ext4_orphan_cleanup(sb, es);
@@ -5596,7 +5596,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 			goto failed_mount10;
 	}
 
-	if (test_opt(sb, DISCARD) && !bdev_max_discard_sectors(sb->s_bdev))
+	if (test_opt(sb, DISCARD) && !bdev_max_discard_sectors(file_bdev(sb->s_bdev_file)))
 		ext4_msg(sb, KERN_WARNING,
 			 "mounting with \"discard\" option, but the device does not support discard");
 
@@ -5675,7 +5675,7 @@ failed_mount9: __maybe_unused
 		fput(sbi->s_journal_bdev_file);
 	}
 out_fail:
-	invalidate_bdev(sb->s_bdev);
+	invalidate_bdev(file_bdev(sb->s_bdev_file));
 	sb->s_fs_info = NULL;
 	return err;
 }
@@ -5934,7 +5934,8 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
 	if (IS_ERR(bdev_file))
 		return ERR_CAST(bdev_file);
 
-	journal = jbd2_journal_init_dev(file_bdev(bdev_file), sb->s_bdev, j_start,
+	journal = jbd2_journal_init_dev(file_bdev(bdev_file),
+					file_bdev(sb->s_bdev_file), j_start,
 					j_len, sb->s_blocksize);
 	if (IS_ERR(journal)) {
 		ext4_msg(sb, KERN_ERR, "failed to create device journal");
@@ -5999,7 +6000,7 @@ static int ext4_load_journal(struct super_block *sb,
 	}
 
 	journal_dev_ro = bdev_read_only(journal->j_dev);
-	really_read_only = bdev_read_only(sb->s_bdev) | journal_dev_ro;
+	really_read_only = bdev_read_only(file_bdev(sb->s_bdev_file)) | journal_dev_ro;
 
 	if (journal_dev_ro && !sb_rdonly(sb)) {
 		ext4_msg(sb, KERN_ERR,
@@ -6116,7 +6117,7 @@ static void ext4_update_super(struct super_block *sb)
 		ext4_update_tstamp(es, s_wtime);
 	es->s_kbytes_written =
 		cpu_to_le64(sbi->s_kbytes_written +
-		    ((part_stat_read(sb->s_bdev, sectors[STAT_WRITE]) -
+		    ((part_stat_read(file_bdev(sb->s_bdev_file), sectors[STAT_WRITE]) -
 		      sbi->s_sectors_written_start) >> 1));
 	if (percpu_counter_initialized(&sbi->s_freeclusters_counter))
 		ext4_free_blocks_count_set(es,
@@ -6350,7 +6351,7 @@ static int ext4_sync_fs(struct super_block *sb, int wait)
 		needs_barrier = true;
 	if (needs_barrier) {
 		int err;
-		err = blkdev_issue_flush(sb->s_bdev);
+		err = blkdev_issue_flush(file_bdev(sb->s_bdev_file));
 		if (!ret)
 			ret = err;
 	}

-- 
2.43.0


