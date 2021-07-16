Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408733CB8D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 16:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240469AbhGPOnk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 10:43:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232988AbhGPOnj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 10:43:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A126C613FC;
        Fri, 16 Jul 2021 14:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626446444;
        bh=hCHntWrZmULEajsGnxh4y43wXlCSz6CxDtKDb0Kydp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XT6yq9RX9AO2TALWFY7xtOHA7gvRHNaqMtQSptevzwfZZ+SoATRNotr62tyNxSFPO
         wE24hrpMqJngEMs6huxGVqnHe4cHREt34MRbAlUuT/8Lf975adG2YOfeVk2ADkClKz
         GTHGGYHM9QHqYLmyG/p/AcvuAd8jUyjAfN+FAAhUEww/KlwzJ9Q4f2242Z/Fjy7mFZ
         lk5psGsFSNq96V5nRhafZIuj2R/zMoDfiZKqkJrD9koK/nKT/mnawcyDVhv2vUe+Co
         bd+xngXcXlHrsq3CN5EOKwTLMUBlPSShwlKd8i0CRrNr14IUkAHQ0gSSA+gh5lg/3X
         ttIkzd+qRCL3A==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: [PATCH 2/9] f2fs: remove allow_outplace_dio()
Date:   Fri, 16 Jul 2021 09:39:12 -0500
Message-Id: <20210716143919.44373-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210716143919.44373-1-ebiggers@kernel.org>
References: <20210716143919.44373-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

We can just check f2fs_lfs_mode() directly.  The block_unaligned_IO()
check is redundant because in LFS mode, f2fs doesn't do direct I/O
writes that aren't block-aligned (due to f2fs_force_buffered_io()
returning true in this case, triggering the fallback to buffered I/O).

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/data.c |  2 +-
 fs/f2fs/f2fs.h | 10 ----------
 fs/f2fs/file.c |  2 +-
 3 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c478964a5695..18cb28a514e6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3551,7 +3551,7 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	if (f2fs_force_buffered_io(inode, iocb, iter))
 		return 0;
 
-	do_opu = allow_outplace_dio(inode, iocb, iter);
+	do_opu = (rw == WRITE && f2fs_lfs_mode(sbi));
 
 	trace_f2fs_direct_IO_enter(inode, offset, count, rw);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ee8eb33e2c25..ad7c1b94e23a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4305,16 +4305,6 @@ static inline int block_unaligned_IO(struct inode *inode,
 	return align & blocksize_mask;
 }
 
-static inline int allow_outplace_dio(struct inode *inode,
-				struct kiocb *iocb, struct iov_iter *iter)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	int rw = iov_iter_rw(iter);
-
-	return (f2fs_lfs_mode(sbi) && (rw == WRITE) &&
-				!block_unaligned_IO(inode, iocb, iter));
-}
-
 static inline bool f2fs_force_buffered_io(struct inode *inode,
 				struct kiocb *iocb, struct iov_iter *iter)
 {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6afd4562335f..b1cb5b50faac 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4292,7 +4292,7 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			 * back to buffered IO.
 			 */
 			if (!f2fs_force_buffered_io(inode, iocb, from) &&
-					allow_outplace_dio(inode, iocb, from))
+					f2fs_lfs_mode(F2FS_I_SB(inode)))
 				goto write;
 		}
 		preallocated = true;
-- 
2.32.0

