Return-Path: <linux-fsdevel+bounces-8568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A45839016
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6EC01F23FCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67DE60DE9;
	Tue, 23 Jan 2024 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfr6cBeQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123E25F843;
	Tue, 23 Jan 2024 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016475; cv=none; b=U/1GpzRkCivYObJVIlpPAOrWvcJT6MbDwG5VymJ7h4kgWfiO92bXOb9LUBKlsoT3S3FCrMpt/aflvWkxA4uV2CQqo/4eyhf0hSNcy9QBn8lKzfTJCZ65jqykrKDIy6PTznQqNVtGtSDZgZIsqGLuTtgnlreqwEIZe7kT5aV+teU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016475; c=relaxed/simple;
	bh=1pKpRyZzbEWoe9HWPSIabjOOrVBTrYBmixrE/2k1vq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZJ5zwrR25A3S2IDYf9IKEzYmNrZstAJHZ3MKLIB92gQcsgFhCgmZON5dS8xLXUF+gKW7iCDkmyzmEIZMGUno32lL+7vWsX9Ls9ZVRrc4hgtYsrJsLaTTOrQdtbtA5uTIYgXPOYZRGjAaKtq5tAxgCrxVc1yB2hozXlHaNr4yjWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfr6cBeQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B698DC43141;
	Tue, 23 Jan 2024 13:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016474;
	bh=1pKpRyZzbEWoe9HWPSIabjOOrVBTrYBmixrE/2k1vq4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pfr6cBeQbpuIsANZxUBJQ5CdqhI/V6nO51zTtLT8YfXuqNITPgoD9cmo9wNTx7Vik
	 dUnqV+34uyCUFLAqk5GGsMVUQ/NnZeUNzuoUVpD08KUF0ayYSCibA97UV2+idt6f8k
	 gTWDZdoPv/KB8Pb0/RLZnX5ATJ3EpzaiM+XX++/yNn6yFA6BFfYaCIjviYYgyLp+Qp
	 zk4fcJG+M+QXmpHBtfU0oV474LeIHgYCWMyYMyBPCqKSmAo75l23Ta4DLaPMw1uhX7
	 ZWTiouQ+E7OCI4512AbWPcNpQf1+/JX+AX6PWCkXlsjE4AiyInSrDTKbasHSfQKWVV
	 cUs9tz/DJhmqw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:40 +0100
Subject: [PATCH v2 23/34] jfs: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-23-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=4582; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1pKpRyZzbEWoe9HWPSIabjOOrVBTrYBmixrE/2k1vq4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu37dgh4XelbetljE9W+eLv93y6UpP4Md/6/d+C64N3
 PVxRUjFpo5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ6L5h+GfE3lpz/WNogLpi
 oLjV1A9Fk78XneBZ+6Nt3YZDHi/ezfvP8D+kznd17N7Ss5/89E0S11zazzr/qOjlivbIewKNBzj
 Vt/MAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/jfs/jfs_logmgr.c | 26 +++++++++++++-------------
 fs/jfs/jfs_logmgr.h |  2 +-
 fs/jfs/jfs_mount.c  |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 8691463956d1..73389c68e251 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1058,7 +1058,7 @@ void jfs_syncpt(struct jfs_log *log, int hard_sync)
 int lmLogOpen(struct super_block *sb)
 {
 	int rc;
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	struct jfs_log *log;
 	struct jfs_sb_info *sbi = JFS_SBI(sb);
 
@@ -1070,7 +1070,7 @@ int lmLogOpen(struct super_block *sb)
 
 	mutex_lock(&jfs_log_mutex);
 	list_for_each_entry(log, &jfs_external_logs, journal_list) {
-		if (log->bdev_handle->bdev->bd_dev == sbi->logdev) {
+		if (file_bdev(log->bdev_file)->bd_dev == sbi->logdev) {
 			if (!uuid_equal(&log->uuid, &sbi->loguuid)) {
 				jfs_warn("wrong uuid on JFS journal");
 				mutex_unlock(&jfs_log_mutex);
@@ -1100,14 +1100,14 @@ int lmLogOpen(struct super_block *sb)
 	 * file systems to log may have n-to-1 relationship;
 	 */
 
-	bdev_handle = bdev_open_by_dev(sbi->logdev,
+	bdev_file = bdev_file_open_by_dev(sbi->logdev,
 			BLK_OPEN_READ | BLK_OPEN_WRITE, log, NULL);
-	if (IS_ERR(bdev_handle)) {
-		rc = PTR_ERR(bdev_handle);
+	if (IS_ERR(bdev_file)) {
+		rc = PTR_ERR(bdev_file);
 		goto free;
 	}
 
-	log->bdev_handle = bdev_handle;
+	log->bdev_file = bdev_file;
 	uuid_copy(&log->uuid, &sbi->loguuid);
 
 	/*
@@ -1141,7 +1141,7 @@ int lmLogOpen(struct super_block *sb)
 	lbmLogShutdown(log);
 
       close:		/* close external log device */
-	bdev_release(bdev_handle);
+	fput(bdev_file);
 
       free:		/* free log descriptor */
 	mutex_unlock(&jfs_log_mutex);
@@ -1162,7 +1162,7 @@ static int open_inline_log(struct super_block *sb)
 	init_waitqueue_head(&log->syncwait);
 
 	set_bit(log_INLINELOG, &log->flag);
-	log->bdev_handle = sb_bdev_handle(sb);
+	log->bdev_file = sb->s_bdev_file;
 	log->base = addressPXD(&JFS_SBI(sb)->logpxd);
 	log->size = lengthPXD(&JFS_SBI(sb)->logpxd) >>
 	    (L2LOGPSIZE - sb->s_blocksize_bits);
@@ -1436,7 +1436,7 @@ int lmLogClose(struct super_block *sb)
 {
 	struct jfs_sb_info *sbi = JFS_SBI(sb);
 	struct jfs_log *log = sbi->log;
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	int rc = 0;
 
 	jfs_info("lmLogClose: log:0x%p", log);
@@ -1482,10 +1482,10 @@ int lmLogClose(struct super_block *sb)
 	 *	external log as separate logical volume
 	 */
 	list_del(&log->journal_list);
-	bdev_handle = log->bdev_handle;
+	bdev_file = log->bdev_file;
 	rc = lmLogShutdown(log);
 
-	bdev_release(bdev_handle);
+	fput(bdev_file);
 
 	kfree(log);
 
@@ -1972,7 +1972,7 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
 
 	bp->l_flag |= lbmREAD;
 
-	bio = bio_alloc(log->bdev_handle->bdev, 1, REQ_OP_READ, GFP_NOFS);
+	bio = bio_alloc(file_bdev(log->bdev_file), 1, REQ_OP_READ, GFP_NOFS);
 	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
 	__bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
 	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
@@ -2115,7 +2115,7 @@ static void lbmStartIO(struct lbuf * bp)
 	jfs_info("lbmStartIO");
 
 	if (!log->no_integrity)
-		bdev = log->bdev_handle->bdev;
+		bdev = file_bdev(log->bdev_file);
 
 	bio = bio_alloc(bdev, 1, REQ_OP_WRITE | REQ_SYNC,
 			GFP_NOFS);
diff --git a/fs/jfs/jfs_logmgr.h b/fs/jfs/jfs_logmgr.h
index 84aa2d253907..8b8994e48cd0 100644
--- a/fs/jfs/jfs_logmgr.h
+++ b/fs/jfs/jfs_logmgr.h
@@ -356,7 +356,7 @@ struct jfs_log {
 				 *    before writing syncpt.
 				 */
 	struct list_head journal_list; /* Global list */
-	struct bdev_handle *bdev_handle; /* 4: log lv pointer */
+	struct file *bdev_file;	/* 4: log lv pointer */
 	int serial;		/* 4: log mount serial number */
 
 	s64 base;		/* @8: log extent address (inline log ) */
diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
index 9b5c6a20b30c..98f9a432c336 100644
--- a/fs/jfs/jfs_mount.c
+++ b/fs/jfs/jfs_mount.c
@@ -431,7 +431,7 @@ int updateSuper(struct super_block *sb, uint state)
 	if (state == FM_MOUNT) {
 		/* record log's dev_t and mount serial number */
 		j_sb->s_logdev = cpu_to_le32(
-			new_encode_dev(sbi->log->bdev_handle->bdev->bd_dev));
+			new_encode_dev(file_bdev(sbi->log->bdev_file)->bd_dev));
 		j_sb->s_logserial = cpu_to_le32(sbi->log->serial);
 	} else if (state == FM_CLEAN) {
 		/*

-- 
2.43.0


