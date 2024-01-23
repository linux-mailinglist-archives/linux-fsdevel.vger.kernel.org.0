Return-Path: <linux-fsdevel+bounces-8571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E8783901D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7991C27C51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7873D60248;
	Tue, 23 Jan 2024 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6VT+e97"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AE1612CE;
	Tue, 23 Jan 2024 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016481; cv=none; b=sluHjjQwJhS93tVw5hXuitoQwjNQAyGEBYF87VnHhmilJ1YpKZ4ukMDc2WBfOICuBbHaat4bW0aMWoljE5S4e870si5bq63e8rMGMhKQAD+pR8piHJqk7jacxLb6LKvXcdQU4yfn+NtkSFkjquNLgKv67KFy1uQSb2LJfuHCGEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016481; c=relaxed/simple;
	bh=LHWj42eUDreZwbH+JdMcOReWXoXQvG/F1BNQUjgrRv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UCFCYqT0fdNAml+kBEV2h8mALt+y9njKM9H0qQK+UWQJ+E2ErzwvwCEt3MzF8FoHAU6jxTgeTjb4Ute3EvgDxf4yTiiajepNlR930menBFV6tldohdb2Bu4Pq19swNHOm5/CSA5qzjakmJGkN+AYNW3MUvdb+/NxMq53DRkUdwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6VT+e97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DA5C433A6;
	Tue, 23 Jan 2024 13:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016481;
	bh=LHWj42eUDreZwbH+JdMcOReWXoXQvG/F1BNQUjgrRv8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j6VT+e97RmngEEQ8yObLcNCqezKu6u6DIH3s5STVqzW+6Ye/tQepGURG4gPibrbJU
	 xDdgzRsoH04tlmaTSz9JSnLj42iqUsFB79Npd1dOzAmuuz00svNoftvmwhMKhooDLx
	 WpNiaoMFtU3+Hzhpq7kzNggXL8a38QXijFOF2CPvCSD4ebr1Qw/tH+z47/v5OF/5cI
	 cH3WVkM9Uk/t6avhLShr1N4p/FiS1Ts18WYDyOuV+VHIA4O8//td0+CEtI4uSe16Gd
	 n4nPRrzb6F4ibzB3Od995rm8aym99toFB0LS1agWmxWzbF+1zHt74ReEgZOpW5rSSp
	 URqKhBrL0oiRg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:43 +0100
Subject: [PATCH v2 26/34] reiserfs: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-26-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=6132; i=brauner@kernel.org;
 h=from:subject:message-id; bh=LHWj42eUDreZwbH+JdMcOReWXoXQvG/F1BNQUjgrRv8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu37fg/d9XF58/P3DgjFdavGbSQed9P5/wOF9OCpF9/
 Dij9mxrWEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEdr5gZJj4wLpkAdvqZhsL
 52/paxnYFf7OOS9VEzRd91xlgtJNm0JGhiae/8EHFKpt+j0VXScd2blEd+POf7MeSbQZP980N9O
 VkRUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/reiserfs/journal.c  | 38 +++++++++++++++++++-------------------
 fs/reiserfs/procfs.c   |  2 +-
 fs/reiserfs/reiserfs.h |  8 ++++----
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 171c912af50f..6474529c4253 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2386,7 +2386,7 @@ static int journal_read(struct super_block *sb)
 
 	cur_dblock = SB_ONDISK_JOURNAL_1st_BLOCK(sb);
 	reiserfs_info(sb, "checking transaction log (%pg)\n",
-		      journal->j_bdev_handle->bdev);
+		      file_bdev(journal->j_bdev_file));
 	start = ktime_get_seconds();
 
 	/*
@@ -2447,7 +2447,7 @@ static int journal_read(struct super_block *sb)
 		 * device and journal device to be the same
 		 */
 		d_bh =
-		    reiserfs_breada(journal->j_bdev_handle->bdev, cur_dblock,
+		    reiserfs_breada(file_bdev(journal->j_bdev_file), cur_dblock,
 				    sb->s_blocksize,
 				    SB_ONDISK_JOURNAL_1st_BLOCK(sb) +
 				    SB_ONDISK_JOURNAL_SIZE(sb));
@@ -2588,9 +2588,9 @@ static void journal_list_init(struct super_block *sb)
 
 static void release_journal_dev(struct reiserfs_journal *journal)
 {
-	if (journal->j_bdev_handle) {
-		bdev_release(journal->j_bdev_handle);
-		journal->j_bdev_handle = NULL;
+	if (journal->j_bdev_file) {
+		fput(journal->j_bdev_file);
+		journal->j_bdev_file = NULL;
 	}
 }
 
@@ -2605,7 +2605,7 @@ static int journal_init_dev(struct super_block *super,
 
 	result = 0;
 
-	journal->j_bdev_handle = NULL;
+	journal->j_bdev_file = NULL;
 	jdev = SB_ONDISK_JOURNAL_DEVICE(super) ?
 	    new_decode_dev(SB_ONDISK_JOURNAL_DEVICE(super)) : super->s_dev;
 
@@ -2616,37 +2616,37 @@ static int journal_init_dev(struct super_block *super,
 	if ((!jdev_name || !jdev_name[0])) {
 		if (jdev == super->s_dev)
 			holder = NULL;
-		journal->j_bdev_handle = bdev_open_by_dev(jdev, blkdev_mode,
+		journal->j_bdev_file = bdev_file_open_by_dev(jdev, blkdev_mode,
 							  holder, NULL);
-		if (IS_ERR(journal->j_bdev_handle)) {
-			result = PTR_ERR(journal->j_bdev_handle);
-			journal->j_bdev_handle = NULL;
+		if (IS_ERR(journal->j_bdev_file)) {
+			result = PTR_ERR(journal->j_bdev_file);
+			journal->j_bdev_file = NULL;
 			reiserfs_warning(super, "sh-458",
 					 "cannot init journal device unknown-block(%u,%u): %i",
 					 MAJOR(jdev), MINOR(jdev), result);
 			return result;
 		} else if (jdev != super->s_dev)
-			set_blocksize(journal->j_bdev_handle->bdev,
+			set_blocksize(file_bdev(journal->j_bdev_file),
 				      super->s_blocksize);
 
 		return 0;
 	}
 
-	journal->j_bdev_handle = bdev_open_by_path(jdev_name, blkdev_mode,
+	journal->j_bdev_file = bdev_file_open_by_path(jdev_name, blkdev_mode,
 						   holder, NULL);
-	if (IS_ERR(journal->j_bdev_handle)) {
-		result = PTR_ERR(journal->j_bdev_handle);
-		journal->j_bdev_handle = NULL;
+	if (IS_ERR(journal->j_bdev_file)) {
+		result = PTR_ERR(journal->j_bdev_file);
+		journal->j_bdev_file = NULL;
 		reiserfs_warning(super, "sh-457",
 				 "journal_init_dev: Cannot open '%s': %i",
 				 jdev_name, result);
 		return result;
 	}
 
-	set_blocksize(journal->j_bdev_handle->bdev, super->s_blocksize);
+	set_blocksize(file_bdev(journal->j_bdev_file), super->s_blocksize);
 	reiserfs_info(super,
 		      "journal_init_dev: journal device: %pg\n",
-		      journal->j_bdev_handle->bdev);
+		      file_bdev(journal->j_bdev_file));
 	return 0;
 }
 
@@ -2804,7 +2804,7 @@ int journal_init(struct super_block *sb, const char *j_dev_name,
 				 "journal header magic %x (device %pg) does "
 				 "not match to magic found in super block %x",
 				 jh->jh_journal.jp_journal_magic,
-				 journal->j_bdev_handle->bdev,
+				 file_bdev(journal->j_bdev_file),
 				 sb_jp_journal_magic(rs));
 		brelse(bhjh);
 		goto free_and_return;
@@ -2828,7 +2828,7 @@ int journal_init(struct super_block *sb, const char *j_dev_name,
 	reiserfs_info(sb, "journal params: device %pg, size %u, "
 		      "journal first block %u, max trans len %u, max batch %u, "
 		      "max commit age %u, max trans age %u\n",
-		      journal->j_bdev_handle->bdev,
+		      file_bdev(journal->j_bdev_file),
 		      SB_ONDISK_JOURNAL_SIZE(sb),
 		      SB_ONDISK_JOURNAL_1st_BLOCK(sb),
 		      journal->j_trans_max,
diff --git a/fs/reiserfs/procfs.c b/fs/reiserfs/procfs.c
index 83cb9402e0f9..5c68a4a52d78 100644
--- a/fs/reiserfs/procfs.c
+++ b/fs/reiserfs/procfs.c
@@ -354,7 +354,7 @@ static int show_journal(struct seq_file *m, void *unused)
 		   "prepare: \t%12lu\n"
 		   "prepare_retry: \t%12lu\n",
 		   DJP(jp_journal_1st_block),
-		   SB_JOURNAL(sb)->j_bdev_handle->bdev,
+		   file_bdev(SB_JOURNAL(sb)->j_bdev_file),
 		   DJP(jp_journal_dev),
 		   DJP(jp_journal_size),
 		   DJP(jp_journal_trans_max),
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index 725667880e62..0554903f42a9 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -299,7 +299,7 @@ struct reiserfs_journal {
 	/* oldest journal block.  start here for traverse */
 	struct reiserfs_journal_cnode *j_first;
 
-	struct bdev_handle *j_bdev_handle;
+	struct file *j_bdev_file;
 
 	/* first block on s_dev of reserved area journal */
 	int j_1st_reserved_block;
@@ -2810,10 +2810,10 @@ struct reiserfs_journal_header {
 
 /* We need these to make journal.c code more readable */
 #define journal_find_get_block(s, block) __find_get_block(\
-		SB_JOURNAL(s)->j_bdev_handle->bdev, block, s->s_blocksize)
-#define journal_getblk(s, block) __getblk(SB_JOURNAL(s)->j_bdev_handle->bdev,\
+		file_bdev(SB_JOURNAL(s)->j_bdev_file), block, s->s_blocksize)
+#define journal_getblk(s, block) __getblk(file_bdev(SB_JOURNAL(s)->j_bdev_file),\
 		block, s->s_blocksize)
-#define journal_bread(s, block) __bread(SB_JOURNAL(s)->j_bdev_handle->bdev,\
+#define journal_bread(s, block) __bread(file_bdev(SB_JOURNAL(s)->j_bdev_file),\
 		block, s->s_blocksize)
 
 enum reiserfs_bh_state_bits {

-- 
2.43.0


