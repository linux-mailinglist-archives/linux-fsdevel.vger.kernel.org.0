Return-Path: <linux-fsdevel+bounces-7214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42485822DDE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B75285C2F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8541CA9A;
	Wed,  3 Jan 2024 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGMJdUHO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C901CA91;
	Wed,  3 Jan 2024 12:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E205CC433C7;
	Wed,  3 Jan 2024 12:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286598;
	bh=tPqM8fijq6blpWamnlfJkZOMMoILtCDc5JxFYa0RI7M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YGMJdUHOSZ0JJJZ3y9VWIhncM60aZg5+psgdZE0iMo7ARQjaCbBSm5C+CoTbSVvZ8
	 lQGYEdrwE46Q2nVeOL7wctZaqRlsQv4r3s6GHWxqoqd/MI/U1dhIVRILumUUf1XASG
	 UnoKESje6PjCPbYLDbq7JSjzzHb08yC20BiGQmPgmC7DzHGof58XitASLPZ3YEQCmk
	 dO76PrFMhU7JklFgE0crbjkKtBid/I9UjPF4FJ6jXRY9pSCEAxzP0Y1Xd5rp4X3HM8
	 awoXVNMcM1QBIsFVlmvtMLdhfjphHORp9M7ieNA8G3Ne8FkKV9EecVkh1+QayJ2Uma
	 DcrnO4QTcbaEg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:31 +0100
Subject: [PATCH RFC 33/34] ext4: use bdev_file_inode()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-33-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=3248; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tPqM8fijq6blpWamnlfJkZOMMoILtCDc5JxFYa0RI7M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbQTWdJRz7R2XeMuheR1fqbubS1P+iyNZ3C55igWq
 lxcKhbQUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBH1pQx/eA8LZ7Y5rhTPr2t9
 4uJrcdfc2rhgwr83nwrjJeY7HZ5YyfCHS8FjKqNz5/uVebuVC95FxbWVcPXoJC2wazNUimZ2f8c
 NAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

There's no need to access bd_inode directly anymore now that we use a
struct file for block device opening.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ext4/dir.c       | 2 +-
 fs/ext4/ext4_jbd2.c | 2 +-
 fs/ext4/super.c     | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 992f09aff438..5037329f35c7 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -192,7 +192,7 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 					(PAGE_SHIFT - inode->i_blkbits);
 			if (!ra_has_index(&file->f_ra, index))
 				page_cache_sync_readahead(
-					F_BDEV(sb->s_f_bdev)->bd_inode->i_mapping,
+					bdev_file_inode(sb->s_f_bdev)->i_mapping,
 					&file->f_ra, file,
 					index, 1);
 			file->f_ra.prev_pos = (loff_t)index << PAGE_SHIFT;
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 97f9ba412f1e..eaec6d2429cc 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -206,7 +206,7 @@ static void ext4_journal_abort_handle(const char *caller, unsigned int line,
 
 static void ext4_check_bdev_write_error(struct super_block *sb)
 {
-	struct address_space *mapping = F_BDEV(sb->s_f_bdev)->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_file_inode(sb->s_f_bdev)->i_mapping;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	int err;
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6ea654105076..40387ba598f4 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -244,7 +244,7 @@ static struct buffer_head *__ext4_sb_bread_gfp(struct super_block *sb,
 struct buffer_head *ext4_sb_bread(struct super_block *sb, sector_t block,
 				   blk_opf_t op_flags)
 {
-	gfp_t gfp = mapping_gfp_constraint(F_BDEV(sb->s_f_bdev)->bd_inode->i_mapping,
+	gfp_t gfp = mapping_gfp_constraint(bdev_file_inode(sb->s_f_bdev)->i_mapping,
 			~__GFP_FS) | __GFP_MOVABLE;
 
 	return __ext4_sb_bread_gfp(sb, block, op_flags, gfp);
@@ -253,7 +253,7 @@ struct buffer_head *ext4_sb_bread(struct super_block *sb, sector_t block,
 struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 					    sector_t block)
 {
-	gfp_t gfp = mapping_gfp_constraint(F_BDEV(sb->s_f_bdev)->bd_inode->i_mapping,
+	gfp_t gfp = mapping_gfp_constraint(bdev_file_inode(sb->s_f_bdev)->i_mapping,
 			~__GFP_FS);
 
 	return __ext4_sb_bread_gfp(sb, block, 0, gfp);
@@ -502,7 +502,7 @@ static void ext4_maybe_update_superblock(struct super_block *sb)
  */
 static int block_device_ejected(struct super_block *sb)
 {
-	struct inode *bd_inode = F_BDEV(sb->s_f_bdev)->bd_inode;
+	struct inode *bd_inode = bdev_file_inode(sb->s_f_bdev);
 	struct backing_dev_info *bdi = inode_to_bdi(bd_inode);
 
 	return bdi->dev == NULL;
@@ -5585,7 +5585,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	 * used to detect the metadata async write error.
 	 */
 	spin_lock_init(&sbi->s_bdev_wb_lock);
-	errseq_check_and_advance(&F_BDEV(sb->s_f_bdev)->bd_inode->i_mapping->wb_err,
+	errseq_check_and_advance(&bdev_file_inode(sb->s_f_bdev)->i_mapping->wb_err,
 				 &sbi->s_bdev_wb_err);
 	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
 	ext4_orphan_cleanup(sb, es);

-- 
2.42.0


