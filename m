Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F148353F4D8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 06:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbiFGEKF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 00:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiFGEKA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 00:10:00 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AA5CA3DB
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jun 2022 21:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nibbf6wERzdtu/euoLLS3IxWqBUEolx2993bEKBo+H0=; b=h4qgyuhuEQ1BWNh73rVYBk/RGa
        vyJi4XlWJpUZnGumXdOfRHUlvevJubQU9fYLDN3fiIbHAQfvfnagRkpoMZNM4H0i3NmCMcFc+DsAf
        duA32x03gY0+wxosdmz5NXATFBDOoEQ8iTsCboSVf93ECpEN/4dCIpjGz4HeXtj4ClXyd56Rh1A8c
        UALyyPQmA4Pfcl+pEvS2LvRq6VZUfvnhZDHjcjSPbAEvk6QzFP2xzEdXWMPUzcANRxrFS13T6Cw8Y
        5SPvnRFDrMFSL0BXBbkoIUDx/Qqp0AK1T0XEIFmGYW+FC58fBj2Gg9jNbI9MtgFM0mzhdkzvh2R1j
        aEZHVp5Q==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyQXV-004YkF-Lp; Tue, 07 Jun 2022 04:09:57 +0000
Date:   Tue, 7 Jun 2022 04:09:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 2/9] btrfs_direct_write(): cleaner way to handle
 generic_write_sync() suppression
Message-ID: <Yp7PlaCTJF19m2sG@zeniv-ca.linux.org.uk>
References: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

explicitly tell iomap to do it, rather than messing with IOCB_DSYNC
[folded a fix for braino spotted by willy]

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/btrfs/file.c       | 17 -----------------
 fs/btrfs/inode.c      |  2 +-
 fs/iomap/direct-io.c  |  2 +-
 include/linux/iomap.h |  2 ++
 4 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 1fd827b99c1b..98f81e304eb1 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1848,7 +1848,6 @@ static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
 
 static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	const bool is_sync_write = (iocb->ki_flags & IOCB_DSYNC);
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -1901,15 +1900,6 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		goto buffered;
 	}
 
-	/*
-	 * We remove IOCB_DSYNC so that we don't deadlock when iomap_dio_rw()
-	 * calls generic_write_sync() (through iomap_dio_complete()), because
-	 * that results in calling fsync (btrfs_sync_file()) which will try to
-	 * lock the inode in exclusive/write mode.
-	 */
-	if (is_sync_write)
-		iocb->ki_flags &= ~IOCB_DSYNC;
-
 	/*
 	 * The iov_iter can be mapped to the same file range we are writing to.
 	 * If that's the case, then we will deadlock in the iomap code, because
@@ -1964,13 +1954,6 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 	btrfs_inode_unlock(inode, ilock_flags);
 
-	/*
-	 * Add back IOCB_DSYNC. Our caller, btrfs_file_write_iter(), will do
-	 * the fsync (call generic_write_sync()).
-	 */
-	if (is_sync_write)
-		iocb->ki_flags |= IOCB_DSYNC;
-
 	/* If 'err' is -ENOTBLK then it means we must fallback to buffered IO. */
 	if ((err < 0 && err != -ENOTBLK) || !iov_iter_count(from))
 		goto out;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 81737eff92f3..c9c8f49568d1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8152,7 +8152,7 @@ ssize_t btrfs_dio_rw(struct kiocb *iocb, struct iov_iter *iter, size_t done_befo
 	struct btrfs_dio_data data;
 
 	return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
-			    IOMAP_DIO_PARTIAL, &data, done_before);
+			    IOMAP_DIO_PARTIAL | IOMAP_DIO_NOSYNC, &data, done_before);
 }
 
 static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 370c3241618a..0f16479b13d6 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -548,7 +548,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		}
 
 		/* for data sync or sync, we need sync completion processing */
-		if (iocb->ki_flags & IOCB_DSYNC)
+		if (iocb->ki_flags & IOCB_DSYNC && !(dio_flags & IOMAP_DIO_NOSYNC))
 			dio->flags |= IOMAP_DIO_NEED_SYNC;
 
 		/*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index e552097c67e0..95de0c771d37 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -353,6 +353,8 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_PARTIAL		(1 << 2)
 
+#define IOMAP_DIO_NOSYNC		(1 << 3)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
-- 
2.30.2

