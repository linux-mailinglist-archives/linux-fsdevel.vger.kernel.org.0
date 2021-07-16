Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849463CB8DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 16:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbhGPOnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 10:43:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240468AbhGPOnm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 10:43:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E5E961404;
        Fri, 16 Jul 2021 14:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626446447;
        bh=4AdX2bJE2x9cvVYUnKuR/I++uGU3+MB3vzYu6IeuHxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NWTviJbOiFoyzawLrUv/ZDlPkFMqjbS2jQj/kfy836Lm4XqWN1iCc4t0zuGvypRX0
         CqoJBaXxKVtnmgOh+yZK5p8EDb+qBcjVM+yVqT7wfGVRwrjWoDZgdslqFMolA0W3wl
         So/fKNnnQp/1BH3nxhDa7b1huuHDdHSpsli0xqKqIoXXp2XYbF74Zbt2Eui4DyzQ4L
         bsN43hqSN5plYEoxEK4fsfy2lgXU1ueKv8KWDddaj74CxSAxk/NM8kX6kQ8oVh926f
         r3axRiPhuOfquS/SdgJ1lUoObJbYWNv/dMwjYLD/kU1+D8gkvZmWm+Lw+35J2yk4OC
         HBWN+KlJKdh9w==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: [PATCH 5/9] f2fs: fix the f2fs_file_write_iter tracepoint
Date:   Fri, 16 Jul 2021 09:39:15 -0500
Message-Id: <20210716143919.44373-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210716143919.44373-1-ebiggers@kernel.org>
References: <20210716143919.44373-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Pass in the original position and count rather than the position and
count that were updated by the write.  Also use the correct types for
all arguments, in particular the file offset which was being truncated
to 32 bits on 32-bit platforms.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/file.c              |  5 +++--
 include/trace/events/f2fs.h | 12 ++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 878b2460f79b..279252c7f7bc 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4282,6 +4282,8 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
+	const loff_t orig_pos = iocb->ki_pos;
+	const size_t orig_count = iov_iter_count(from);
 	loff_t target_size;
 	int preallocated;
 	ssize_t ret;
@@ -4363,8 +4365,7 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 out_unlock:
 	inode_unlock(inode);
 out:
-	trace_f2fs_file_write_iter(inode, iocb->ki_pos,
-					iov_iter_count(from), ret);
+	trace_f2fs_file_write_iter(inode, orig_pos, orig_count, ret);
 	if (ret > 0)
 		ret = generic_write_sync(iocb, ret);
 	return ret;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 56b113e3cd6a..bffb38622e9b 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -540,17 +540,17 @@ TRACE_EVENT(f2fs_truncate_partial_nodes,
 
 TRACE_EVENT(f2fs_file_write_iter,
 
-	TP_PROTO(struct inode *inode, unsigned long offset,
-		unsigned long length, int ret),
+	TP_PROTO(struct inode *inode, loff_t offset, size_t length,
+		 ssize_t ret),
 
 	TP_ARGS(inode, offset, length, ret),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(ino_t,	ino)
-		__field(unsigned long, offset)
-		__field(unsigned long, length)
-		__field(int,	ret)
+		__field(loff_t, offset)
+		__field(size_t, length)
+		__field(ssize_t, ret)
 	),
 
 	TP_fast_assign(
@@ -562,7 +562,7 @@ TRACE_EVENT(f2fs_file_write_iter,
 	),
 
 	TP_printk("dev = (%d,%d), ino = %lu, "
-		"offset = %lu, length = %lu, written(err) = %d",
+		"offset = %lld, length = %zu, written(err) = %zd",
 		show_dev_ino(__entry),
 		__entry->offset,
 		__entry->length,
-- 
2.32.0

