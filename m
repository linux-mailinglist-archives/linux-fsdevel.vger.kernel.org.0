Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCA1FE287
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 17:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfKOQRi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 11:17:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:36930 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727607AbfKOQRh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:17:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 374CFB1BA;
        Fri, 15 Nov 2019 16:17:36 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 5/7] btrfs: Use iomap_dio_ops.submit_io()
Date:   Fri, 15 Nov 2019 10:16:58 -0600
Message-Id: <20191115161700.12305-6-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191115161700.12305-1-rgoldwyn@suse.de>
References: <20191115161700.12305-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Use iomap_dio_ops.submit_io() to submit the bio for btrfs.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/inode.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e2e4dfb7a568..8e55b0d343bd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8471,7 +8471,7 @@ static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 	return 0;
 }
 
-static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
+static blk_qc_t btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 				loff_t file_offset)
 {
 	struct btrfs_dio_private *dip = NULL;
@@ -8524,7 +8524,7 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 
 	ret = btrfs_submit_direct_hook(dip);
 	if (!ret)
-		return;
+		return BLK_QC_T_NONE;
 
 	btrfs_io_bio_free_csum(io_bio);
 
@@ -8567,6 +8567,7 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 	if (bio)
 		bio_put(bio);
 	kfree(dip);
+	return BLK_QC_T_NONE;
 }
 
 static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
@@ -8606,6 +8607,10 @@ static const struct iomap_ops dio_iomap_ops = {
 	.iomap_begin		= direct_iomap_begin,
 };
 
+static struct iomap_dio_ops btrfs_dops = {
+	.submit_io		= btrfs_submit_direct,
+};
+
 ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
@@ -8665,7 +8670,8 @@ ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		flags = DIO_LOCKING | DIO_SKIP_HOLES;
 	}
 
-	ret = iomap_dio_rw(iocb, iter, &dio_iomap_ops, NULL, is_sync_kiocb(iocb));
+	ret = iomap_dio_rw(iocb, iter, &dio_iomap_ops, &btrfs_dops,
+			   is_sync_kiocb(iocb));
 
 	if (iov_iter_rw(iter) == WRITE) {
 		up_read(&BTRFS_I(inode)->dio_sem);
-- 
2.16.4

