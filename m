Return-Path: <linux-fsdevel+bounces-8578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 377CF839031
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85AE28840C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3CD6166B;
	Tue, 23 Jan 2024 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4ey1i4T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2ED604A3;
	Tue, 23 Jan 2024 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016499; cv=none; b=bNYMEd8/gWJX0Wdcdu/Hej9ZCz6HjEo6SNvm3U5OTE/eqbYgzIqHeewEQmLUSa+mc0Bx26Kk1bv2R7aVTf/xvX8dQO7hv2BmWBmVvEtACNwTx2qcz+jL+pxLrYkt8lpUeKsrvIrqL845EjrX0ch3vCllKFkedH2VNjICgwwSkHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016499; c=relaxed/simple;
	bh=HvkjMM4UilMWeIyvLwzGDCKX81U6qywNG74AYux5zoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MSoGE13bq/QqeJbk/1mNMEKWQ2b8Agcq8LqlmM8PbwEeLYJ/ThEndcPYNdDTISQzU20pCUKTTcONXr5FouJbpvrxQ4wDpEP43mepSHrdzGCf3cLehKduRtSU/gvFk76ulne1MsVhzav88rEw0f3Fh9D57fu/msZ9BwGpHJvKH1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4ey1i4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BABC3278F;
	Tue, 23 Jan 2024 13:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016498;
	bh=HvkjMM4UilMWeIyvLwzGDCKX81U6qywNG74AYux5zoc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O4ey1i4TJ53o3VvEBefsUZPsDS62s3g2uPdutjE/pFNatZZeqL2QsWvbFuNTlvnem
	 E6zT7wvJn1zVCgqgOuP8gDs0c+TUZwXbXue7UxZqrMqxLw7Y0HqNxGcRGF796XlJh7
	 4MQjRnoFBpqmlvG1uds8HjvcLb+END7zfCEmR95NEzlf6D2YyWq+e5EQzrZpJ4YA5Z
	 pP/Q3/Rs8K+s2AujOFYW/ZT6587S95dFYv4380UMEJzwNobpFIqFJzwX5oIHuKjoj3
	 ae5ovVPWS1HcZ4ykcZBOsy90OavxyHlVCpBHieYrXiQRgtZk1T+kDykoR2zgnv0zzh
	 MfTaM2OGe3fEg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:50 +0100
Subject: [PATCH v2 33/34] block: expose bdev_file_inode()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-33-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=1942; i=brauner@kernel.org;
 h=from:subject:message-id; bh=HvkjMM4UilMWeIyvLwzGDCKX81U6qywNG74AYux5zoc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu37fwv5ZLe9LZf3pl7rc4+0QLF7UfaI1Zd0uLd3Jj0
 byTqrF/O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYim87w3+WCd+HZG9/0g99e
 us27Q2a2rYqWxIp01fvM9sxMizZeC2VkeHb4sUimMY/SYrUnEwsWCC/Zmnvs0etf3677NN/8Pv1
 rOg8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Now that we open block devices as files we don't need to rely on
bd_inode to get to the correct inode. Use the helper.

We could use bdev_file->f_inode directly here since we know that
@f_inode refers to a bdev fs inode but it is generically correct to use
bdev_file->f_mapping->host since that will also work for bdev_files
opened from userspace.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c           | 2 +-
 block/fops.c           | 5 -----
 include/linux/blkdev.h | 5 +++++
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 4b47003d8082..185c43ebeea5 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -51,7 +51,7 @@ EXPORT_SYMBOL(I_BDEV);
 
 struct block_device *file_bdev(struct file *bdev_file)
 {
-	return I_BDEV(bdev_file->f_mapping->host);
+	return I_BDEV(bdev_file_inode(bdev_file));
 }
 EXPORT_SYMBOL(file_bdev);
 
diff --git a/block/fops.c b/block/fops.c
index a0bff2c0d88d..240d968c281c 100644
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
index 2f5dbde23094..4b7080e56e44 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1490,6 +1490,11 @@ void blkdev_put_no_open(struct block_device *bdev);
 struct block_device *I_BDEV(struct inode *inode);
 struct block_device *file_bdev(struct file *bdev_file);
 
+static inline struct inode *bdev_file_inode(struct file *file)
+{
+	return file->f_mapping->host;
+}
+
 #ifdef CONFIG_BLOCK
 void invalidate_bdev(struct block_device *bdev);
 int sync_blockdev(struct block_device *bdev);

-- 
2.43.0


