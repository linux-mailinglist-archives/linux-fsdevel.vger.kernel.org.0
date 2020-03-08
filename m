Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E37F17D1F5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Mar 2020 06:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgCHFzA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Mar 2020 00:55:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:37462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgCHFy7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Mar 2020 00:54:59 -0500
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B8C12072A;
        Sun,  8 Mar 2020 05:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583646898;
        bh=1kQMlWH6pdS6zFvlUSLfkr6buLEg0l6yyW/ZCkMmBb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PesqVv6TgnoNZ+bIhnVPsQjLMq5UD3k+Zfix2fA5/DiAElnwXQO7GV+MN1yjn454Y
         nLQWG0/k+qa7kp0IWCyIT3dx4cdpzMdTt6HDGbCx9WTABuhws2D/2M9CRUzhGWoQux
         IWG+Fcsdr1SqBl0VDXtMn8VXza84wRtVoiZswGgU=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: [PATCH] fs/direct-io.c: avoid workqueue allocation race
Date:   Sat,  7 Mar 2020 21:52:21 -0800
Message-Id: <20200308055221.1088089-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CACT4Y+Zt+fjBwJk-TcsccohBgxRNs37Hb4m6ZkZGy7u5P2+aaA@mail.gmail.com>
References: <CACT4Y+Zt+fjBwJk-TcsccohBgxRNs37Hb4m6ZkZGy7u5P2+aaA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

When a thread loses the workqueue allocation race in
sb_init_dio_done_wq(), lockdep reports that the call to
destroy_workqueue() can deadlock waiting for work to complete.  This is
a false positive since the workqueue is empty.  But we shouldn't simply
skip the lockdep check for empty workqueues for everyone.

Just avoid this issue by using a mutex to serialize the workqueue
allocation.  We still keep the preliminary check for ->s_dio_done_wq, so
this doesn't affect direct I/O performance.

Also fix the preliminary check for ->s_dio_done_wq to use READ_ONCE(),
since it's a data race.  (That part wasn't actually found by syzbot yet,
but it could be detected by KCSAN in the future.)

Note: the lockdep false positive could alternatively be fixed by
introducing a new function like "destroy_unused_workqueue()" to the
workqueue API as previously suggested.  But I think it makes sense to
avoid the double allocation anyway.

Reported-by: syzbot+a50c7541a4a55cd49b02@syzkaller.appspotmail.com
Reported-by: syzbot+5cd33f0e6abe2bb3e397@syzkaller.appspotmail.com
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/direct-io.c       | 39 ++++++++++++++++++++-------------------
 fs/internal.h        |  9 ++++++++-
 fs/iomap/direct-io.c |  3 +--
 3 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 00b4d15bb811..8b73a2501c03 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -590,22 +590,25 @@ static inline int dio_bio_reap(struct dio *dio, struct dio_submit *sdio)
  * filesystems that don't need it and also allows us to create the workqueue
  * late enough so the we can include s_id in the name of the workqueue.
  */
-int sb_init_dio_done_wq(struct super_block *sb)
+int __sb_init_dio_done_wq(struct super_block *sb)
 {
-	struct workqueue_struct *old;
-	struct workqueue_struct *wq = alloc_workqueue("dio/%s",
-						      WQ_MEM_RECLAIM, 0,
-						      sb->s_id);
-	if (!wq)
-		return -ENOMEM;
-	/*
-	 * This has to be atomic as more DIOs can race to create the workqueue
-	 */
-	old = cmpxchg(&sb->s_dio_done_wq, NULL, wq);
-	/* Someone created workqueue before us? Free ours... */
-	if (old)
-		destroy_workqueue(wq);
-	return 0;
+	static DEFINE_MUTEX(sb_init_dio_done_wq_mutex);
+	struct workqueue_struct *wq;
+	int err = 0;
+
+	mutex_lock(&sb_init_dio_done_wq_mutex);
+	if (sb->s_dio_done_wq)
+		goto out;
+	wq = alloc_workqueue("dio/%s", WQ_MEM_RECLAIM, 0, sb->s_id);
+	if (!wq) {
+		err = -ENOMEM;
+		goto out;
+	}
+	/* pairs with READ_ONCE() in sb_init_dio_done_wq() */
+	smp_store_release(&sb->s_dio_done_wq, wq);
+out:
+	mutex_unlock(&sb_init_dio_done_wq_mutex);
+	return err;
 }
 
 static int dio_set_defer_completion(struct dio *dio)
@@ -615,9 +618,7 @@ static int dio_set_defer_completion(struct dio *dio)
 	if (dio->defer_completion)
 		return 0;
 	dio->defer_completion = true;
-	if (!sb->s_dio_done_wq)
-		return sb_init_dio_done_wq(sb);
-	return 0;
+	return sb_init_dio_done_wq(sb);
 }
 
 /*
@@ -1250,7 +1251,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 		retval = 0;
 		if (iocb->ki_flags & IOCB_DSYNC)
 			retval = dio_set_defer_completion(dio);
-		else if (!dio->inode->i_sb->s_dio_done_wq) {
+		else {
 			/*
 			 * In case of AIO write racing with buffered read we
 			 * need to defer completion. We can't decide this now,
diff --git a/fs/internal.h b/fs/internal.h
index f3f280b952a3..7813dae1dbcd 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -183,7 +183,14 @@ extern void mnt_pin_kill(struct mount *m);
 extern const struct dentry_operations ns_dentry_operations;
 
 /* direct-io.c: */
-int sb_init_dio_done_wq(struct super_block *sb);
+int __sb_init_dio_done_wq(struct super_block *sb);
+static inline int sb_init_dio_done_wq(struct super_block *sb)
+{
+	/* pairs with smp_store_release() in __sb_init_dio_done_wq() */
+	if (likely(READ_ONCE(sb->s_dio_done_wq)))
+		return 0;
+	return __sb_init_dio_done_wq(sb);
+}
 
 /*
  * fs/stat.c:
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 23837926c0c5..5d81faada8a0 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -484,8 +484,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		dio_warn_stale_pagecache(iocb->ki_filp);
 	ret = 0;
 
-	if (iov_iter_rw(iter) == WRITE && !wait_for_completion &&
-	    !inode->i_sb->s_dio_done_wq) {
+	if (iov_iter_rw(iter) == WRITE && !wait_for_completion) {
 		ret = sb_init_dio_done_wq(inode->i_sb);
 		if (ret < 0)
 			goto out_free_dio;
-- 
2.25.1

