Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74B22232BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 07:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgGQFFl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 01:05:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgGQFFk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 01:05:40 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43CA420578;
        Fri, 17 Jul 2020 05:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594962339;
        bh=5l82E/2QHFoLujhbouEO+rAl9xdMKFx6N0zLGFHTMhs=;
        h=From:To:Cc:Subject:Date:From;
        b=hPy3AehdaeIYUIxIi6vazUd8VjMAZGkYAA9YuPUVsM/+o1rNDuTZd7rj6tgsqBaCg
         KQUG7GS8hB/15zv/jq/B9imnCHICTViJsaToC9nZuZ8VP3tacmbLxTCo/jxosGmOtv
         mvSEgW/3wMT4bv+EqBY8oCQgS96QiT3FN9l+fZv4=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v2] fs/direct-io: fix one-time init of ->s_dio_done_wq
Date:   Thu, 16 Jul 2020 22:05:10 -0700
Message-Id: <20200717050510.95832-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Correctly implement the "one-time" init pattern for ->s_dio_done_wq.
This fixes the following issues:

- The LKMM doesn't guarantee that the workqueue will be seen initialized
  before being used, if another CPU allocated it.  With regards to
  specific CPU architectures, this is true on at least Alpha, but it may
  be true on other architectures too if the internal implementation of
  workqueues causes use of the workqueue to involve a control
  dependency.  (There doesn't appear to be a control dependency
  currently, but it's hard to tell and it could change in the future.)

- The preliminary checks for sb->s_dio_done_wq are a data race, since
  they do a plain load of a concurrently modified variable.  According
  to the C standard, this undefined behavior.  In practice, the kernel
  does sometimes makes assumptions about data races might be okay in
  practice, but these rules are undocumented and not uniformly agreed
  upon, so it's best to avoid cases where they might come into play.

Following the guidance for one-time init I've proposed at
https://lkml.kernel.org/r/20200717044427.68747-1-ebiggers@kernel.org,
replace it with the simplest implementation that is guaranteed to be
correct while still achieving the following properties:

    - Doesn't make direct I/O users contend on a mutex in the fast path.

    - Doesn't allocate the workqueue when it will never be used.

Fixes: 7b7a8665edd8 ("direct-io: Implement generic deferred AIO completions")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---

v2: new implementation using smp_load_acquire() + smp_store_release()
    and a mutex.

 fs/direct-io.c       | 42 ++++++++++++++++++++++++------------------
 fs/iomap/direct-io.c |  3 +--
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 6d5370eac2a8..c03c2204aadf 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -592,20 +592,28 @@ static inline int dio_bio_reap(struct dio *dio, struct dio_submit *sdio)
  */
 int sb_init_dio_done_wq(struct super_block *sb)
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
+	static DEFINE_MUTEX(sb_init_dio_done_mutex);
+	struct workqueue_struct *wq;
+	int err = 0;
+
+	/* Pairs with the smp_store_release() below */
+	if (smp_load_acquire(&sb->s_dio_done_wq))
+		return 0;
+
+	mutex_lock(&sb_init_dio_done_mutex);
+	if (sb->s_dio_done_wq)
+		goto out;
+
+	wq = alloc_workqueue("dio/%s", WQ_MEM_RECLAIM, 0, sb->s_id);
+	if (!wq) {
+		err = -ENOMEM;
+		goto out;
+	}
+	/* Pairs with the smp_load_acquire() above */
+	smp_store_release(&sb->s_dio_done_wq, wq);
+out:
+	mutex_unlock(&sb_init_dio_done_mutex);
+	return err;
 }
 
 static int dio_set_defer_completion(struct dio *dio)
@@ -615,9 +623,7 @@ static int dio_set_defer_completion(struct dio *dio)
 	if (dio->defer_completion)
 		return 0;
 	dio->defer_completion = true;
-	if (!sb->s_dio_done_wq)
-		return sb_init_dio_done_wq(sb);
-	return 0;
+	return sb_init_dio_done_wq(sb);
 }
 
 /*
@@ -1250,7 +1256,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 		retval = 0;
 		if (iocb->ki_flags & IOCB_DSYNC)
 			retval = dio_set_defer_completion(dio);
-		else if (!dio->inode->i_sb->s_dio_done_wq) {
+		else {
 			/*
 			 * In case of AIO write racing with buffered read we
 			 * need to defer completion. We can't decide this now,
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

