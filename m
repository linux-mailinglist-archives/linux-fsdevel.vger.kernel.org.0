Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57FA3CB8DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 16:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240480AbhGPOnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 10:43:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232988AbhGPOnl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 10:43:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91DAC613FD;
        Fri, 16 Jul 2021 14:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626446446;
        bh=vCaSCO/j0nnx7bQBFUHP3HyLFhbsFlt0djzBlzFWNVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=heWdLJ77bkT+cizJPQddge0HRDTv8RP4gB/Y9JoCQQ8YgeCIZs1H/JdlbkfOak+P6
         cL2Hgy4MV1eyJJdcK97O3cMaYiCpKctuiUjheBeFLum7g5IPO+Mc5ole84MqdE/lQ1
         D3hlSmfpvp+YNKOyImOgM3yigZ7jHQdZCaTR86w3HiQhBkG/ZFd+mBsEN5+vSf+CQb
         +sS2eVqTIO5N/s+fvvBfDRNDNE1esy5clptU7uzPCNmP7+JE86+Ft3nNkQwu9430r/
         ZCuuHWw95zL6ao8TmFI+SL4WHmAsl+FyhCM9dky2DfC2dk/0ppsGpd8t3tTPDa6WbW
         ojDvCSfGHmY4g==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: [PATCH 4/9] f2fs: reduce indentation in f2fs_file_write_iter()
Date:   Fri, 16 Jul 2021 09:39:14 -0500
Message-Id: <20210716143919.44373-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210716143919.44373-1-ebiggers@kernel.org>
References: <20210716143919.44373-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Replace 'if (ret > 0)' with 'if (ret <= 0) goto out_unlock;'.
No change in behavior.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/file.c | 73 +++++++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9b12004e78c6..878b2460f79b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4316,49 +4316,50 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	ret = generic_write_checks(iocb, from);
-	if (ret > 0) {
-		if (iocb->ki_flags & IOCB_NOWAIT) {
-			if (!f2fs_overwrite_io(inode, iocb->ki_pos,
-						iov_iter_count(from)) ||
-				f2fs_has_inline_data(inode) ||
-				f2fs_force_buffered_io(inode, iocb, from)) {
-				ret = -EAGAIN;
-				goto out_unlock;
-			}
-		}
-		if (iocb->ki_flags & IOCB_DIRECT) {
-			/*
-			 * Convert inline data for Direct I/O before entering
-			 * f2fs_direct_IO().
-			 */
-			ret = f2fs_convert_inline_inode(inode);
-			if (ret)
-				goto out_unlock;
-		}
+	if (ret <= 0)
+		goto out_unlock;
 
-		/* Possibly preallocate the blocks for the write. */
-		target_size = iocb->ki_pos + iov_iter_count(from);
-		preallocated = f2fs_preallocate_blocks(iocb, from);
-		if (preallocated < 0) {
-			ret = preallocated;
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!f2fs_overwrite_io(inode, iocb->ki_pos,
+				       iov_iter_count(from)) ||
+		    f2fs_has_inline_data(inode) ||
+		    f2fs_force_buffered_io(inode, iocb, from)) {
+			ret = -EAGAIN;
 			goto out_unlock;
 		}
+	}
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		/*
+		 * Convert inline data for Direct I/O before entering
+		 * f2fs_direct_IO().
+		 */
+		ret = f2fs_convert_inline_inode(inode);
+		if (ret)
+			goto out_unlock;
+	}
 
-		ret = __generic_file_write_iter(iocb, from);
+	/* Possibly preallocate the blocks for the write. */
+	target_size = iocb->ki_pos + iov_iter_count(from);
+	preallocated = f2fs_preallocate_blocks(iocb, from);
+	if (preallocated < 0) {
+		ret = preallocated;
+		goto out_unlock;
+	}
 
-		/* Don't leave any preallocated blocks around past i_size. */
-		if (preallocated > 0 && inode->i_size < target_size) {
-			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-			down_write(&F2FS_I(inode)->i_mmap_sem);
-			f2fs_truncate(inode);
-			up_write(&F2FS_I(inode)->i_mmap_sem);
-			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-		}
-		clear_inode_flag(inode, FI_PREALLOCATED_ALL);
+	ret = __generic_file_write_iter(iocb, from);
 
-		if (ret > 0)
-			f2fs_update_iostat(F2FS_I_SB(inode), APP_WRITE_IO, ret);
+	/* Don't leave any preallocated blocks around past i_size. */
+	if (preallocated > 0 && inode->i_size < target_size) {
+		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+		down_write(&F2FS_I(inode)->i_mmap_sem);
+		f2fs_truncate(inode);
+		up_write(&F2FS_I(inode)->i_mmap_sem);
+		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	}
+	clear_inode_flag(inode, FI_PREALLOCATED_ALL);
+
+	if (ret > 0)
+		f2fs_update_iostat(F2FS_I_SB(inode), APP_WRITE_IO, ret);
 out_unlock:
 	inode_unlock(inode);
 out:
-- 
2.32.0

