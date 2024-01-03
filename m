Return-Path: <linux-fsdevel+bounces-7203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD8A822DC8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B32D2B2211D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A2D1BDCB;
	Wed,  3 Jan 2024 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THAGyi1R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB641BDCA;
	Wed,  3 Jan 2024 12:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E8CC433C7;
	Wed,  3 Jan 2024 12:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286575;
	bh=KmWYP0GscjNbvBwwX9No72a/eIfdzPd72udKmZAR8WI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=THAGyi1R2XgBcsGmVbZlmPq/BHcQgXYU4ICawo+pMFKZH4triQWj6elQVVq2qe0gO
	 bDvK+5/RfL834aqX7EnYLxN9F5vM8v9azSXBXS+qeYVQYacpucbVAEtrbABSapHdQy
	 p7zwecCVTaW/+e/spYhTliBxPPgREPqNa1W7rrBfpU5hn0vO65iqz9N3hciyVBgBgb
	 DQxopo6ZaXxT1uIpiYiaDnRVE+zb5KRcTEu1rKGcBc2spLLmAVYRragXm6NAVNdm6V
	 Rl9FkIZZQUCwJJA7FWbbLQ7Z/DUsJJXk5xjm8QTWMjOfp7lK17zEXuYwdbk1idbyBl
	 PpJuuHGuJvo9A==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:20 +0100
Subject: [PATCH RFC 22/34] f2fs: port block device access to files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-22-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=1956; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KmWYP0GscjNbvBwwX9No72a/eIfdzPd72udKmZAR8WI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbTVt5eS/Gt96IKZWj3rw4OCa5Ln6ex7pdvRF+O13
 DEhLWdvRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQO3GRkuCKxzdWg7hP/fmmm
 tL8bzN/8eWjS/m/nxXMPv94SFviynY3hf8LSPdz7zvKfk/E56Mvc4KxW/vKFYLbZrqOzbtxg0d1
 5nBUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/f2fs/f2fs.h  |  2 +-
 fs/f2fs/super.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9043cedfa12b..9a73eed3b424 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1234,7 +1234,7 @@ struct f2fs_bio_info {
 #define FDEV(i)				(sbi->devs[i])
 #define RDEV(i)				(raw_super->devs[i])
 struct f2fs_dev_info {
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	struct block_device *bdev;
 	char path[MAX_PATH_LEN];
 	unsigned int total_segments;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 93b8a844b207..5e0687a85b4d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1610,7 +1610,7 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
 
 	for (i = 0; i < sbi->s_ndevs; i++) {
 		if (i > 0)
-			bdev_release(FDEV(i).bdev_handle);
+			fput(FDEV(i).f_bdev);
 #ifdef CONFIG_BLK_DEV_ZONED
 		kvfree(FDEV(i).blkz_seq);
 #endif
@@ -4247,7 +4247,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 
 	for (i = 0; i < max_devices; i++) {
 		if (i == 0)
-			FDEV(0).bdev_handle = sb_bdev_handle(sbi->sb);
+			FDEV(0).f_bdev = sbi->sb->s_f_bdev;
 		else if (!RDEV(i).path[0])
 			break;
 
@@ -4267,14 +4267,14 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 				FDEV(i).end_blk = FDEV(i).start_blk +
 					(FDEV(i).total_segments <<
 					sbi->log_blocks_per_seg) - 1;
-				FDEV(i).bdev_handle = bdev_open_by_path(
+				FDEV(i).f_bdev = bdev_file_open_by_path(
 					FDEV(i).path, mode, sbi->sb, NULL);
 			}
 		}
-		if (IS_ERR(FDEV(i).bdev_handle))
-			return PTR_ERR(FDEV(i).bdev_handle);
+		if (IS_ERR(FDEV(i).f_bdev))
+			return PTR_ERR(FDEV(i).f_bdev);
 
-		FDEV(i).bdev = FDEV(i).bdev_handle->bdev;
+		FDEV(i).bdev = F_BDEV(FDEV(i).f_bdev);
 		/* to release errored devices */
 		sbi->s_ndevs = i + 1;
 

-- 
2.42.0


