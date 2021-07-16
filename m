Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6330D3CB8E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 16:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240502AbhGPOnp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 10:43:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240468AbhGPOnn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 10:43:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 332E461402;
        Fri, 16 Jul 2021 14:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626446448;
        bh=3us48jNa9I6IXFuMymwZsiIPZW4iBWQog9USG1tv/Hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPzme+1YH9+pJGMmH+B7yMOcWBcNLcaRgKEWnlef7evwiL8MLTPxjl+WlFfZKHUNC
         nxSr9WTzXgFR0jDJMLZ+RifFTUJbGnq95c222aNVMpBK+IDk5wndqTvW1mIwDm5Fpy
         MMWYQPLv0/wvyUnB3ZYLeo0JNg6WXZtJcQp+JfESh7bmrsIlQycJMnBR2pxrj5lNHb
         +ddNU9dJQycz9ciN/+ijalSmTCvenB2SyFMYHJ/AOiOS5xZcjdrXrIVWFEeznoeYet
         s7IIRwtvj+usVaOFg/LydfdFuhG/qQVSmkXpHxuzpzNqCesmrXxKnwzJo3LjTBYIt6
         TJs4zJpFMZ+vQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: [PATCH 7/9] f2fs: use iomap for direct I/O reads
Date:   Fri, 16 Jul 2021 09:39:17 -0500
Message-Id: <20210716143919.44373-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210716143919.44373-1-ebiggers@kernel.org>
References: <20210716143919.44373-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Convert f2fs_file_read_iter() to use iomap_dio_rw() for direct I/O
rather than using f2fs_direct_IO() via generic_file_read_iter().

Besides the new direct I/O implementation being more efficient
(especially with regards to the block mapping), this change retains the
existing f2fs behavior such as the conditions for falling back to
buffered I/O, the locking of i_gc_rwsem[READ], the iostat gathering, and
the f2fs_direct_IO_{enter,exit} tracepoints.  An exception is that we no
longer fall back to a buffered I/O read if a direct I/O read returns a
short read (previously this was done by generic_file_read_iter()), as
this doesn't appear to be a useful thing to do on f2fs.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/f2fs.h |  7 ++---
 fs/f2fs/file.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 82 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d2b1ef6976c4..f869c4a2f79f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3243,10 +3243,9 @@ static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi,
 			sbi->rw_iostat[APP_WRITE_IO] -
 			sbi->rw_iostat[APP_DIRECT_IO];
 
-	if (type == APP_READ_IO || type == APP_DIRECT_READ_IO)
-		sbi->rw_iostat[APP_BUFFERED_READ_IO] =
-			sbi->rw_iostat[APP_READ_IO] -
-			sbi->rw_iostat[APP_DIRECT_READ_IO];
+	if (type == APP_BUFFERED_READ_IO || type == APP_DIRECT_READ_IO)
+		sbi->rw_iostat[APP_READ_IO] += io_bytes;
+
 	spin_unlock(&sbi->iostat_lock);
 
 	f2fs_record_iostat(sbi);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 279252c7f7bc..52de655ef833 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -23,6 +23,7 @@
 #include <linux/nls.h>
 #include <linux/sched/signal.h>
 #include <linux/fileattr.h>
+#include <linux/iomap.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -4201,20 +4202,93 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	return __f2fs_ioctl(filp, cmd, arg);
 }
 
-static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+/*
+ * Return %true if the given read or write request should use direct I/O, or
+ * %false if it should use buffered I/O.
+ */
+static bool f2fs_should_use_dio(struct inode *inode, struct kiocb *iocb,
+				struct iov_iter *iter)
+{
+	unsigned int align;
+
+	if (!(iocb->ki_flags & IOCB_DIRECT))
+		return false;
+
+	if (f2fs_force_buffered_io(inode, iocb, iter))
+		return false;
+
+	/*
+	 * Direct I/O not aligned to the disk's logical_block_size will be
+	 * attempted, but will fail with -EINVAL.
+	 *
+	 * f2fs additionally requires that direct I/O be aligned to the
+	 * filesystem block size, which is often a stricter requirement.
+	 * However, f2fs traditionally falls back to buffered I/O on requests
+	 * that are logical_block_size-aligned but not fs-block aligned.
+	 *
+	 * The below logic implements this behavior.
+	 */
+	align = iocb->ki_pos | iov_iter_alignment(iter);
+	if (!IS_ALIGNED(align, i_blocksize(inode)) &&
+	    IS_ALIGNED(align, bdev_logical_block_size(inode->i_sb->s_bdev)))
+		return false;
+
+	return true;
+}
+
+static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
-	int ret;
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	const loff_t pos = iocb->ki_pos;
+	const size_t count = iov_iter_count(to);
+	ssize_t ret;
+
+	if (count == 0)
+		return 0; /* skip atime update */
+
+	trace_f2fs_direct_IO_enter(inode, pos, count, READ);
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!down_read_trylock(&fi->i_gc_rwsem[READ])) {
+			ret = -EAGAIN;
+			goto out;
+		}
+	} else {
+		down_read(&fi->i_gc_rwsem[READ]);
+	}
+
+	ret = iomap_dio_rw(iocb, to, &f2fs_iomap_ops, &f2fs_iomap_dio_ops, 0);
+
+	up_read(&fi->i_gc_rwsem[READ]);
+
+	file_accessed(file);
+
+	if (ret > 0)
+		f2fs_update_iostat(F2FS_I_SB(inode), APP_DIRECT_READ_IO, ret);
+	else if (ret == -EIOCBQUEUED)
+		f2fs_update_iostat(F2FS_I_SB(inode), APP_DIRECT_READ_IO,
+				   count - iov_iter_count(to));
+out:
+	trace_f2fs_direct_IO_exit(inode, pos, count, READ, ret);
+	return ret;
+}
+
+static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret;
 
 	if (!f2fs_is_compress_backend_ready(inode))
 		return -EOPNOTSUPP;
 
-	ret = generic_file_read_iter(iocb, iter);
+	if (f2fs_should_use_dio(inode, iocb, to))
+		return f2fs_dio_read_iter(iocb, to);
 
+	ret = filemap_read(iocb, to, 0);
 	if (ret > 0)
-		f2fs_update_iostat(F2FS_I_SB(inode), APP_READ_IO, ret);
-
+		f2fs_update_iostat(F2FS_I_SB(inode), APP_BUFFERED_READ_IO, ret);
 	return ret;
 }
 
-- 
2.32.0

