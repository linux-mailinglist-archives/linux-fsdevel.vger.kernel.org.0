Return-Path: <linux-fsdevel+bounces-7204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D2A822DC9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2D71C23362
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E815B1BDDD;
	Wed,  3 Jan 2024 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqEiOYe+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFDF1BDDA;
	Wed,  3 Jan 2024 12:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CBDC433CB;
	Wed,  3 Jan 2024 12:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286577;
	bh=7+5QOJ3fzNoJt3ZM8Bte3iZde2IiCDpBP+rwce7BPr0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DqEiOYe+CfkuKcG3qQ3ZrKHenT45sotVFtKbQTsEqHT9UY0eAOwjw+LTj4pTynJ6a
	 2H75j4xDsTAVQorp4F4D23yfLocJaQbpjULsjQjMTKwSQzDr+AaJ3+0fZw4nCxQSVg
	 9tYvKsflYDf0LxP3kXxMQnOFBvIPB/VXXMCUKNNsCvaoS1KyYXG4HOn371cjTDRiE8
	 q9paBo+08AJQy/QbznyLHEF+A/txEVXE1IKf1S41JdAVJT+913EPbb1SZsh1jkJiL5
	 mS0Q2S1/rNkdgc7ewc+KZQLAnp0TmchvI+75BTz3zx9qTzgP0/KgrpbHyvqjT4ngOp
	 PfpSA4m6xi5yg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:21 +0100
Subject: [PATCH RFC 23/34] jfs: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-23-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=4516; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7+5QOJ3fzNoJt3ZM8Bte3iZde2IiCDpBP+rwce7BPr0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbTlij+26o/1iriGLqH4m68mls+70dbJLNryMffE+
 19/lqy36ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI6j9GhkfxxbNeblGa/+Ll
 i5PX1H5dXVzMbht/4tHW3RODEmdET5zAyHBujnm1nb3trvieX+liCwPvOATwGE0q+raHKfPorW3
 fTrICAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/jfs/jfs_logmgr.c | 26 +++++++++++++-------------
 fs/jfs/jfs_logmgr.h |  2 +-
 fs/jfs/jfs_mount.c  |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 8691463956d1..7dd6b3b6fde0 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1058,7 +1058,7 @@ void jfs_syncpt(struct jfs_log *log, int hard_sync)
 int lmLogOpen(struct super_block *sb)
 {
 	int rc;
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	struct jfs_log *log;
 	struct jfs_sb_info *sbi = JFS_SBI(sb);
 
@@ -1070,7 +1070,7 @@ int lmLogOpen(struct super_block *sb)
 
 	mutex_lock(&jfs_log_mutex);
 	list_for_each_entry(log, &jfs_external_logs, journal_list) {
-		if (log->bdev_handle->bdev->bd_dev == sbi->logdev) {
+		if (F_BDEV(log->f_bdev)->bd_dev == sbi->logdev) {
 			if (!uuid_equal(&log->uuid, &sbi->loguuid)) {
 				jfs_warn("wrong uuid on JFS journal");
 				mutex_unlock(&jfs_log_mutex);
@@ -1100,14 +1100,14 @@ int lmLogOpen(struct super_block *sb)
 	 * file systems to log may have n-to-1 relationship;
 	 */
 
-	bdev_handle = bdev_open_by_dev(sbi->logdev,
+	f_bdev = bdev_file_open_by_dev(sbi->logdev,
 			BLK_OPEN_READ | BLK_OPEN_WRITE, log, NULL);
-	if (IS_ERR(bdev_handle)) {
-		rc = PTR_ERR(bdev_handle);
+	if (IS_ERR(f_bdev)) {
+		rc = PTR_ERR(f_bdev);
 		goto free;
 	}
 
-	log->bdev_handle = bdev_handle;
+	log->f_bdev = f_bdev;
 	uuid_copy(&log->uuid, &sbi->loguuid);
 
 	/*
@@ -1141,7 +1141,7 @@ int lmLogOpen(struct super_block *sb)
 	lbmLogShutdown(log);
 
       close:		/* close external log device */
-	bdev_release(bdev_handle);
+	fput(f_bdev);
 
       free:		/* free log descriptor */
 	mutex_unlock(&jfs_log_mutex);
@@ -1162,7 +1162,7 @@ static int open_inline_log(struct super_block *sb)
 	init_waitqueue_head(&log->syncwait);
 
 	set_bit(log_INLINELOG, &log->flag);
-	log->bdev_handle = sb_bdev_handle(sb);
+	log->f_bdev = sb->s_f_bdev;
 	log->base = addressPXD(&JFS_SBI(sb)->logpxd);
 	log->size = lengthPXD(&JFS_SBI(sb)->logpxd) >>
 	    (L2LOGPSIZE - sb->s_blocksize_bits);
@@ -1436,7 +1436,7 @@ int lmLogClose(struct super_block *sb)
 {
 	struct jfs_sb_info *sbi = JFS_SBI(sb);
 	struct jfs_log *log = sbi->log;
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	int rc = 0;
 
 	jfs_info("lmLogClose: log:0x%p", log);
@@ -1482,10 +1482,10 @@ int lmLogClose(struct super_block *sb)
 	 *	external log as separate logical volume
 	 */
 	list_del(&log->journal_list);
-	bdev_handle = log->bdev_handle;
+	f_bdev = log->f_bdev;
 	rc = lmLogShutdown(log);
 
-	bdev_release(bdev_handle);
+	fput(f_bdev);
 
 	kfree(log);
 
@@ -1972,7 +1972,7 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
 
 	bp->l_flag |= lbmREAD;
 
-	bio = bio_alloc(log->bdev_handle->bdev, 1, REQ_OP_READ, GFP_NOFS);
+	bio = bio_alloc(F_BDEV(log->f_bdev), 1, REQ_OP_READ, GFP_NOFS);
 	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
 	__bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
 	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
@@ -2115,7 +2115,7 @@ static void lbmStartIO(struct lbuf * bp)
 	jfs_info("lbmStartIO");
 
 	if (!log->no_integrity)
-		bdev = log->bdev_handle->bdev;
+		bdev = F_BDEV(log->f_bdev);
 
 	bio = bio_alloc(bdev, 1, REQ_OP_WRITE | REQ_SYNC,
 			GFP_NOFS);
diff --git a/fs/jfs/jfs_logmgr.h b/fs/jfs/jfs_logmgr.h
index 84aa2d253907..c7d2d8fb0204 100644
--- a/fs/jfs/jfs_logmgr.h
+++ b/fs/jfs/jfs_logmgr.h
@@ -356,7 +356,7 @@ struct jfs_log {
 				 *    before writing syncpt.
 				 */
 	struct list_head journal_list; /* Global list */
-	struct bdev_handle *bdev_handle; /* 4: log lv pointer */
+	struct file *f_bdev;	/* 4: log lv pointer */
 	int serial;		/* 4: log mount serial number */
 
 	s64 base;		/* @8: log extent address (inline log ) */
diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
index 415eb65a36ff..035ab9de4b4f 100644
--- a/fs/jfs/jfs_mount.c
+++ b/fs/jfs/jfs_mount.c
@@ -431,7 +431,7 @@ int updateSuper(struct super_block *sb, uint state)
 	if (state == FM_MOUNT) {
 		/* record log's dev_t and mount serial number */
 		j_sb->s_logdev = cpu_to_le32(
-			new_encode_dev(sbi->log->bdev_handle->bdev->bd_dev));
+			new_encode_dev(F_BDEV(sbi->log->f_bdev)->bd_dev));
 		j_sb->s_logserial = cpu_to_le32(sbi->log->serial);
 	} else if (state == FM_CLEAN) {
 		/*

-- 
2.42.0


