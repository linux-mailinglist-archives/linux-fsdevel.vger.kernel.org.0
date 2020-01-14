Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D85913AEDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 17:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgANQNU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 11:13:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43562 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbgANQMr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kuBKhMklw+YxwJKcgxxO2S9Flu8Wk6bhNkWsODoSOE0=; b=sCB1kcD90uIUWLGF48wprnsXiX
        3TB+jsOI4Y2LkRdrKtxH7i+aXulnTirR1Cm/o8Nz6e4INd8u4uc0mJ3rPB5SzAwsKj5VfFRQAJBVr
        3fUFDOuZm+DBrQQWkhuoNqedHFyFeIuI8r927b3PwWgcpgLD/Am4ErzsYUPEBFxz7sZuTCsVinp4t
        b/PWVC2rKPI1UPEI1qNqzum+uHVMcQA2gZRteVU9VeEFHkzOfP20VFKZOc1tfVxyDUniazlYLshgf
        FZcWjN50VlbXvGJKA5TxSQ7uDk2TOGwTCR8IhGlGSp9FaxaAyGjBKQ3+KxCIelMg+ZEfos510Jftn
        QT84XA8Q==;
Received: from [2001:4bb8:18c:4f54:fcbb:a92b:61e1:719] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irOoA-0000CC-CW; Tue, 14 Jan 2020 16:12:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 07/12] iomap: allow holding i_rwsem until aio completion
Date:   Tue, 14 Jan 2020 17:12:20 +0100
Message-Id: <20200114161225.309792-8-hch@lst.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114161225.309792-1-hch@lst.de>
References: <20200114161225.309792-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The direct I/O code currently uses a hand crafted i_dio_count that needs
to be incremented under i_rwsem and then is decremented when I/O
completes.  That scheme means file system code needs to be very careful
to wait for i_dio_count to reach zero under i_rwsem in various places
that are very cumbersome to get rid.  It also means we can't get the
effect of an exclusive i_rwsem for actually asynchronous I/O, forcing
pointless synchronous execution of sub-blocksize writes.

Replace the i_dio_count scheme with holding i_rwsem over the duration
of the whole I/O.  While this introduces a non-owner unlock that isn't
nice to RT workload, the open coded locking primitive using i_dio_count
isn't any better.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c  | 44 +++++++++++++++++++++++++++++++++++++------
 include/linux/iomap.h |  2 ++
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index e706329d71a0..0113ac33b0a0 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -70,7 +70,7 @@ static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
 	dio->submit.cookie = submit_bio(bio);
 }
 
-static ssize_t iomap_dio_complete(struct iomap_dio *dio)
+static ssize_t iomap_dio_complete(struct iomap_dio *dio, bool unlock)
 {
 	const struct iomap_dio_ops *dops = dio->dops;
 	struct kiocb *iocb = dio->iocb;
@@ -112,6 +112,13 @@ static ssize_t iomap_dio_complete(struct iomap_dio *dio)
 			dio_warn_stale_pagecache(iocb->ki_filp);
 	}
 
+	if (unlock) {
+		if (dio->flags & IOMAP_DIO_RWSEM_EXCL)
+			up_write(&inode->i_rwsem);
+		else if (dio->flags & IOMAP_DIO_RWSEM_SHARED)
+			up_read(&inode->i_rwsem);
+	}
+
 	/*
 	 * If this is a DSYNC write, make sure we push it to stable storage now
 	 * that we've written data.
@@ -129,8 +136,22 @@ static void iomap_dio_complete_work(struct work_struct *work)
 {
 	struct iomap_dio *dio = container_of(work, struct iomap_dio, aio.work);
 	struct kiocb *iocb = dio->iocb;
+	struct inode *inode = file_inode(iocb->ki_filp);
 
-	iocb->ki_complete(iocb, iomap_dio_complete(dio), 0);
+	/*
+	 * XXX: For reads this code is directly called from bio ->end_io, which
+	 * often is hard or softirq context.  In that case lockdep records the
+	 * below as lock acquisitions from irq context and causes warnings.
+	 */
+	if (dio->flags & IOMAP_DIO_RWSEM_EXCL) {
+		rwsem_acquire(&inode->i_rwsem.dep_map, 0, 0, _THIS_IP_);
+		if (IS_ENABLED(CONFIG_RWSEM_SPIN_ON_OWNER))
+			atomic_long_set(&inode->i_rwsem.owner, (long)current);
+	} else if (dio->flags & IOMAP_DIO_RWSEM_SHARED) {
+		rwsem_acquire_read(&inode->i_rwsem.dep_map, 0, 0, _THIS_IP_);
+	}
+
+	iocb->ki_complete(iocb, iomap_dio_complete(dio, true), 0);
 }
 
 /*
@@ -430,7 +451,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio->i_size = i_size_read(inode);
 	dio->dops = dops;
 	dio->error = 0;
-	dio->flags = 0;
+	dio->flags = dio_flags;
 
 	dio->submit.iter = iter;
 	dio->submit.waiter = current;
@@ -551,8 +572,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio->wait_for_completion = wait_for_completion;
 	if (!atomic_dec_and_test(&dio->ref)) {
 		if (!wait_for_completion)
-			return -EIOCBQUEUED;
-
+			goto async_completion;
 		for (;;) {
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			if (!READ_ONCE(dio->submit.waiter))
@@ -567,10 +587,22 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		__set_current_state(TASK_RUNNING);
 	}
 
-	return iomap_dio_complete(dio);
+	return iomap_dio_complete(dio, false);
 
 out_free_dio:
 	kfree(dio);
 	return ret;
+
+async_completion:
+	/*
+	 * We are returning to userspace now, but i_rwsem is still held until
+	 * the I/O completion comes back.
+	 */
+	if (dio_flags & (IOMAP_DIO_RWSEM_EXCL | IOMAP_DIO_RWSEM_SHARED))
+		rwsem_release(&inode->i_rwsem.dep_map, _THIS_IP_);
+	if ((dio_flags & IOMAP_DIO_RWSEM_EXCL) &&
+	    IS_ENABLED(CONFIG_RWSEM_SPIN_ON_OWNER))
+		atomic_long_set(&inode->i_rwsem.owner, RWSEM_OWNER_UNKNOWN);
+	return -EIOCBQUEUED;
 }
 EXPORT_SYMBOL_GPL(iomap_dio_rw);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 3faeb8fd0961..f259bb979d7f 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -249,6 +249,8 @@ int iomap_writepages(struct address_space *mapping,
 #define IOMAP_DIO_UNWRITTEN	(1 << 0)	/* covers unwritten extent(s) */
 #define IOMAP_DIO_COW		(1 << 1)	/* covers COW extent(s) */
 #define IOMAP_DIO_SYNCHRONOUS	(1 << 2)	/* no async completion */
+#define IOMAP_DIO_RWSEM_EXCL	(1 << 3)	/* holds shared i_rwsem */
+#define IOMAP_DIO_RWSEM_SHARED	(1 << 4)	/* holds exclusive i_rwsem */
 
 struct iomap_dio_ops {
 	int (*end_io)(struct kiocb *iocb, ssize_t size, int error,
-- 
2.24.1

