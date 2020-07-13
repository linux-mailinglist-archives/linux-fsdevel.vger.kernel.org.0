Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3BD21CDCC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 05:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgGMDfE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Jul 2020 23:35:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgGMDfE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Jul 2020 23:35:04 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D2E320722;
        Mon, 13 Jul 2020 03:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594611303;
        bh=41IYY+/hX2sb2b1GBvHrVsrCwrGfmHuoNNwcohgG4Us=;
        h=From:To:Cc:Subject:Date:From;
        b=zKLykD+ebs0yY0QSgcLifTmGtf0olv8jsDAubALRq2trmmLiErvOdj5Lt9Q5pktgz
         UerZhze4E3Z8Vnq8R++twoa81O8L6/XVIA6/7fKEO0o0KQBh9sBm7yvNt/Xd4/ZOtB
         J3u9YYUlHTWNLZLawnI+60HlK4L2C0qCxnhIAL2w=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH] fs/direct-io: avoid data race on ->s_dio_done_wq
Date:   Sun, 12 Jul 2020 20:33:30 -0700
Message-Id: <20200713033330.205104-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Fix the preliminary checks for ->s_dio_done_wq to use READ_ONCE(), since
it's a data race, and technically the behavior is undefined without
READ_ONCE().  Also, on one CPU architecture (Alpha), the data read
dependency barrier included in READ_ONCE() is needed to guarantee that
the pointed-to struct is seen as fully initialized.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/direct-io.c       | 8 +++-----
 fs/internal.h        | 9 ++++++++-
 fs/iomap/direct-io.c | 3 +--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 6d5370eac2a8..26221ae24156 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -590,7 +590,7 @@ static inline int dio_bio_reap(struct dio *dio, struct dio_submit *sdio)
  * filesystems that don't need it and also allows us to create the workqueue
  * late enough so the we can include s_id in the name of the workqueue.
  */
-int sb_init_dio_done_wq(struct super_block *sb)
+int __sb_init_dio_done_wq(struct super_block *sb)
 {
 	struct workqueue_struct *old;
 	struct workqueue_struct *wq = alloc_workqueue("dio/%s",
@@ -615,9 +615,7 @@ static int dio_set_defer_completion(struct dio *dio)
 	if (dio->defer_completion)
 		return 0;
 	dio->defer_completion = true;
-	if (!sb->s_dio_done_wq)
-		return sb_init_dio_done_wq(sb);
-	return 0;
+	return sb_init_dio_done_wq(sb);
 }
 
 /*
@@ -1250,7 +1248,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 		retval = 0;
 		if (iocb->ki_flags & IOCB_DSYNC)
 			retval = dio_set_defer_completion(dio);
-		else if (!dio->inode->i_sb->s_dio_done_wq) {
+		else {
 			/*
 			 * In case of AIO write racing with buffered read we
 			 * need to defer completion. We can't decide this now,
diff --git a/fs/internal.h b/fs/internal.h
index 9b863a7bd708..6736c9eee978 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -178,7 +178,14 @@ extern void mnt_pin_kill(struct mount *m);
 extern const struct dentry_operations ns_dentry_operations;
 
 /* direct-io.c: */
-int sb_init_dio_done_wq(struct super_block *sb);
+int __sb_init_dio_done_wq(struct super_block *sb);
+static inline int sb_init_dio_done_wq(struct super_block *sb)
+{
+	/* pairs with cmpxchg() in __sb_init_dio_done_wq() */
+	if (likely(READ_ONCE(sb->s_dio_done_wq)))
+		return 0;
+	return __sb_init_dio_done_wq(sb);
+}
 
 /*
  * fs/stat.c:
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index ec7b78e6feca..dc7fe898dab8 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -487,8 +487,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		dio_warn_stale_pagecache(iocb->ki_filp);
 	ret = 0;
 
-	if (iov_iter_rw(iter) == WRITE && !wait_for_completion &&
-	    !inode->i_sb->s_dio_done_wq) {
+	if (iov_iter_rw(iter) == WRITE && !wait_for_completion) {
 		ret = sb_init_dio_done_wq(inode->i_sb);
 		if (ret < 0)
 			goto out_free_dio;
-- 
2.27.0

