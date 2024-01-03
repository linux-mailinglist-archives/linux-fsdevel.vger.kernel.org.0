Return-Path: <linux-fsdevel+bounces-7210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D36A822DD6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38BC1F243A1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB0B1C69D;
	Wed,  3 Jan 2024 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGHsMjcD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BB51C68D;
	Wed,  3 Jan 2024 12:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE51C43391;
	Wed,  3 Jan 2024 12:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286589;
	bh=JzT+e7AdbW0Z5pIn/Ln0oNmceQKsqemFTpG7JXYqnig=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jGHsMjcD/5f7djlJ9tHxZhaaAq12aw+DB4qLwYSaE1qHxtgVzwl1ILuV4IUG9NDCH
	 JswJxzoJx/kYuQ6Kt5aVX0Gg+x3JJ+m2yxx7rOY4hz1yAdSS+suno856ZBSp6gb0WW
	 z1f92kAvpS5ag2keSkXa/m0gPWI11Y7R80vj30AVQwuJPw4rzuiSqdyX7Lztb+7qKF
	 xgzqJBqbNxxtablL1y4IuFOKtxxbmAnlFldbPT24jacw3mDkuxisq5YaycmTRg7XM9
	 3TFfcCUq8vwXUaAuwzXJA8PXw1+b8FZFo/s2mPtEtlfJdYaLEOEDhmztzp7+f8hx3v
	 kExatBq3q+E0g==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:27 +0100
Subject: [PATCH RFC 29/34] bdev: make struct bdev_handle private to the
 block layer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-29-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=2264; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JzT+e7AdbW0Z5pIn/Ln0oNmceQKsqemFTpG7JXYqnig=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbTVefon69fNpWafrOZ/2JheqCctP8v982k1vntZr
 OFr4noUO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCIMLIsKBx34G1BXu/LtUR
 uPIq61Br8YSMJZ0OfYsMyjW9DmZk+jAyND+efbp1xqNrNhHHvv9Yt9SHPSvHZweDac79T7kNbww
 u8AMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c           | 1 -
 block/blk.h            | 6 ++++++
 include/linux/blkdev.h | 6 ------
 include/linux/fs.h     | 6 ------
 4 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 80caa71a65db..b276ef994858 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -49,7 +49,6 @@ struct block_device *I_BDEV(struct inode *inode)
 }
 EXPORT_SYMBOL(I_BDEV);
 
-/* @bdev_handle will become private to block/blk.h soon. */
 struct block_device *F_BDEV(struct file *f_bdev)
 {
 	struct bdev_handle *handle = f_bdev->private_data;
diff --git a/block/blk.h b/block/blk.h
index 3ec5e9b5c26c..d1a2030fa5c3 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -25,6 +25,12 @@ struct blk_flush_queue {
 	struct request		*flush_rq;
 };
 
+struct bdev_handle {
+	struct block_device *bdev;
+	void *holder;
+	blk_mode_t mode;
+};
+
 bool is_flush_rq(struct request *req);
 
 struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2d06f02f6d5e..5599a33e78a6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1498,12 +1498,6 @@ extern const struct blk_holder_ops fs_holder_ops;
 	(BLK_OPEN_READ | BLK_OPEN_RESTRICT_WRITES | \
 	 (((flags) & SB_RDONLY) ? 0 : BLK_OPEN_WRITE))
 
-struct bdev_handle {
-	struct block_device *bdev;
-	void *holder;
-	blk_mode_t mode;
-};
-
 struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		const struct blk_holder_ops *hops);
 struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b0a5e94e8c3a..b23d49f7adfe 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1326,12 +1326,6 @@ struct super_block {
 	struct list_head	s_inodes_wb;	/* writeback inodes */
 } __randomize_layout;
 
-/* Temporary helper that will go away. */
-static inline struct bdev_handle *sb_bdev_handle(struct super_block *sb)
-{
-	return sb->s_f_bdev->private_data;
-}
-
 static inline struct user_namespace *i_user_ns(const struct inode *inode)
 {
 	return inode->i_sb->s_user_ns;

-- 
2.42.0


