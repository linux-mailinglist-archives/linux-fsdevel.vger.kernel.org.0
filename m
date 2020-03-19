Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDE418BA86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 16:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgCSPIM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 11:08:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:56254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbgCSPIM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:08:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1085CACC2;
        Thu, 19 Mar 2020 15:08:10 +0000 (UTC)
Date:   Thu, 19 Mar 2020 10:08:05 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     riteshh@linux.ibm.com, linux-ext4@vger.kernel.org,
        hch@infradead.org, darrick.wong@oracle.com, willy@infradead.org
Subject: [PATCH v2] iomap: return partial I/O count on error in
 iomap_dio_bio_actor
Message-ID: <20200319150805.uaggnfue5xgaougx@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, I/Os that complete with an error indicate this by passing
written == 0 to the iomap_end function.  However, btrfs needs to know how
many bytes were written for its own accounting.  Change the convention
to pass the number of bytes which were actually written, and change the
only user (ext4) to check for a short write instead of a zero length
write.

For filesystems that do not define ->iomap_end(), check for
dio->error again after the iomap_apply() call to diagnose the error.

Changes since v1:
 - Considerate of iov_iter rollback functions
 - Double check errors for filesystems not implementing iomap_end()

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fa0ff78..d52c70f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3475,7 +3475,7 @@ static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
 	 * the I/O. Any blocks that may have been allocated in preparation for
 	 * the direct I/O will be reused during buffered I/O.
 	 */
-	if (flags & (IOMAP_WRITE | IOMAP_DIRECT) && written == 0)
+	if (flags & (IOMAP_WRITE | IOMAP_DIRECT) && written < length)
 		return -ENOTBLK;
 
 	return 0;
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 41c1e7c..b5f4d4a 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -264,7 +264,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		size_t n;
 		if (dio->error) {
 			iov_iter_revert(dio->submit.iter, copied);
-			copied = ret = 0;
+			ret = dio->error;
 			goto out;
 		}
 
@@ -325,8 +325,17 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 			iomap_dio_zero(dio, iomap, pos, fs_block_size - pad);
 	}
 out:
-	/* Undo iter limitation to current extent */
-	iov_iter_reexpand(dio->submit.iter, orig_count - copied);
+	/*
+	 * Undo iter limitation to current extent
+	 * If there is an error, undo the entire extent. However, return the
+	 * bytes copied so far for filesystems such as btrfs to account for
+	 * submitted I/O.
+	 */
+	if (ret < 0)
+		iov_iter_reexpand(dio->submit.iter, orig_count);
+	else
+		iov_iter_reexpand(dio->submit.iter, orig_count - copied);
+
 	if (copied)
 		return copied;
 	return ret;
@@ -499,6 +508,10 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	do {
 		ret = iomap_apply(inode, pos, count, flags, ops, dio,
 				iomap_dio_actor);
+
+		if (ret >= 0 && dio->error)
+			ret = dio->error;
+
 		if (ret <= 0) {
 			/* magic error code to fall back to buffered I/O */
 			if (ret == -ENOTBLK) {

-- 
Goldwyn
