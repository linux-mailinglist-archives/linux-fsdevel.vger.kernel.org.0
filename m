Return-Path: <linux-fsdevel+bounces-7213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8CF822DDC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766E41C21079
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161181CA89;
	Wed,  3 Jan 2024 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQX0LUdT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F4C1CA80;
	Wed,  3 Jan 2024 12:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4962C433D9;
	Wed,  3 Jan 2024 12:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286596;
	bh=9hbRiu68kYsy/jUGxdkcNWylp3C8+yNikd5BhdPMZsM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nQX0LUdT3jsjKtIH9qbxIAVt5YU+FjMjTLUnZ34+3mWlyUSjEYnUSp+r/VbM7ZBDO
	 5dRIeoAn8TsKms7UoH4jKUJca+UMTOGCgJ5mne/uUGzB0Qr56Z8L/b1qKB++am9oRZ
	 LZDTFG9R5ae8/NPcsg/W8Fq9uLolXDKJhVNuG3cdDgL8sSKNCqnH3t726WPdkE9jfO
	 c52dny5YLAEMo5sdGdxuw5APgjsf2KA2ftlumwEVayoqHNckxBOVj2eMc8+sOOFqtC
	 bxl28LjwE/L4gjKMsowkxG8lXPFQlu8Cfn5whwn+efIh1FLR8sqAiDZYszvXF1pFLi
	 DraIEHYSdIsZg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:30 +0100
Subject: [PATCH RFC 32/34] block: expose bdev_file_inode()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-32-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9hbRiu68kYsy/jUGxdkcNWylp3C8+yNikd5BhdPMZsM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbR7kD5B5OIefrvauRVLTwQJCoktChd+m+oZyfjpC
 F/2Oxf5jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlcOszwv2jW4QP5CXq5d0L2
 MQfui15QX5VwIJp7/s7Sxxen/98TFsTI8IZ1xY+Oe9Pu+ZX/zJ4suPJrZMPsvw1yTmYMT7k/K4e
 VMQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Now that we open block devices as files we don't need to rely on
bd_inode to get to the correct inode. Use the helper.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/fops.c           | 5 -----
 include/linux/blkdev.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index ed7be8b5810e..e831196dafac 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -19,11 +19,6 @@
 #include <linux/module.h>
 #include "blk.h"
 
-static inline struct inode *bdev_file_inode(struct file *file)
-{
-	return file->f_mapping->host;
-}
-
 static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
 {
 	blk_opf_t opf = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5599a33e78a6..4bde3e87817d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1513,6 +1513,11 @@ void blkdev_put_no_open(struct block_device *bdev);
 struct block_device *I_BDEV(struct inode *inode);
 struct block_device *F_BDEV(struct file *file);
 
+static inline struct inode *bdev_file_inode(struct file *file)
+{
+	return file->f_mapping->host;
+}
+
 #ifdef CONFIG_BLOCK
 void invalidate_bdev(struct block_device *bdev);
 int sync_blockdev(struct block_device *bdev);

-- 
2.42.0


