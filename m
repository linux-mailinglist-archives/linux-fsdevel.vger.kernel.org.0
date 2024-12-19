Return-Path: <linux-fsdevel+bounces-37850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 936D39F8244
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5FD165CE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43271BD9E7;
	Thu, 19 Dec 2024 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sYnnqaC6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1751AA786;
	Thu, 19 Dec 2024 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630025; cv=none; b=S/DmaZhCyxM0YU8kuYREQyNnBHYdVLOTUZN0kcBlMunUwnbHBj0qCtudO83Hhugec+/atx2LPp6gcWYm3FfaBQJYfmFZY1aPCNKvoADJRwbtEsYTezLagGnnN6Vd9VWpRR6UUBi0a9BMnbG9LWXW6JAJso4+0YAiPgLXX3HZgx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630025; c=relaxed/simple;
	bh=c0256ab6s4RzlTFVqzLbDJEct14Ar+zqj7YC2ykLF10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3sC+4B9pF9b+GirepWSsvsgqbBZsMKG1vpbJHY/JxG5sopxV65g2ipGCLUwCa0vPzHVqNm5teTj6fyxaulEh5PbYcmZbqkv1nHKffDFUErOaz/TLL+UhGcF1ubfu1vboIQdd1F1mIOgX+vppXlMpVEtq7T18sw3CD0ISiL+EII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sYnnqaC6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YQxJ4rwHOwckc5rBWCjXB2hM8LfZsXPiFkmOW/A08r0=; b=sYnnqaC6LxFgM3U4eIx34zDHP/
	UPIQ+OX8I7PQR7GK/74R1mdfCKSqBdPrGosJhTW6XFd76VAS4MD6+Zm1LRdi+kyGrLJnNwB/JBikK
	EzgB6nQjvpA9y3q9X6RkeTneV4hPCoFHRdxdORCQgMvdXlsuUrQOX6RsRvIRR39XgKjwYRt2Eo+32
	uhQvGKpD4ZMnR8p/OyHaXCq6wBUoUxS6jn3xjpGdlBlxlt4/eLz6wjlL9cZlB3iW7RMfVQ/NKMFfy
	CAX+ASvI3LHeBguUEzVRtPtguILsdAun3+2tu8Pa7omnNvogvdZPUqDh1YuzORSfdu4XJnO2SpZgN
	He5WcsSQ==;
Received: from [2001:4bb8:2ae:97bf:7b0d:9cbd:e369:c821] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tOKVa-00000002ayu-3K8r;
	Thu, 19 Dec 2024 17:40:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/10] iomap: factor out a iomap_dio_done helper
Date: Thu, 19 Dec 2024 17:39:11 +0000
Message-ID: <20241219173954.22546-7-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241219173954.22546-1-hch@lst.de>
References: <20241219173954.22546-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Split out the struct iomap-dio level final completion from
iomap_dio_bio_end_io into a helper to clean up the code and make it
reusable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c | 76 ++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 641649a04614..ed658eb09a1a 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -165,43 +165,31 @@ static inline void iomap_dio_set_error(struct iomap_dio *dio, int ret)
 	cmpxchg(&dio->error, 0, ret);
 }
 
-void iomap_dio_bio_end_io(struct bio *bio)
+/*
+ * Called when dio->ref reaches zero from and I/O completion.
+ */
+static void iomap_dio_done(struct iomap_dio *dio)
 {
-	struct iomap_dio *dio = bio->bi_private;
-	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
 	struct kiocb *iocb = dio->iocb;
 
-	if (bio->bi_status)
-		iomap_dio_set_error(dio, blk_status_to_errno(bio->bi_status));
-	if (!atomic_dec_and_test(&dio->ref))
-		goto release_bio;
-
-	/*
-	 * Synchronous dio, task itself will handle any completion work
-	 * that needs after IO. All we need to do is wake the task.
-	 */
 	if (dio->wait_for_completion) {
+		/*
+		 * Synchronous I/O, task itself will handle any completion work
+		 * that needs after IO. All we need to do is wake the task.
+		 */
 		struct task_struct *waiter = dio->submit.waiter;
 
 		WRITE_ONCE(dio->submit.waiter, NULL);
 		blk_wake_io_task(waiter);
-		goto release_bio;
-	}
-
-	/*
-	 * Flagged with IOMAP_DIO_INLINE_COMP, we can complete it inline
-	 */
-	if (dio->flags & IOMAP_DIO_INLINE_COMP) {
+	} else if (dio->flags & IOMAP_DIO_INLINE_COMP) {
 		WRITE_ONCE(iocb->private, NULL);
 		iomap_dio_complete_work(&dio->aio.work);
-		goto release_bio;
-	}
-
-	/*
-	 * If this dio is flagged with IOMAP_DIO_CALLER_COMP, then schedule
-	 * our completion that way to avoid an async punt to a workqueue.
-	 */
-	if (dio->flags & IOMAP_DIO_CALLER_COMP) {
+	} else if (dio->flags & IOMAP_DIO_CALLER_COMP) {
+		/*
+		 * If this dio is flagged with IOMAP_DIO_CALLER_COMP, then
+		 * schedule our completion that way to avoid an async punt to a
+		 * workqueue.
+		 */
 		/* only polled IO cares about private cleared */
 		iocb->private = dio;
 		iocb->dio_complete = iomap_dio_deferred_complete;
@@ -219,19 +207,31 @@ void iomap_dio_bio_end_io(struct bio *bio)
 		 * issuer.
 		 */
 		iocb->ki_complete(iocb, 0);
-		goto release_bio;
+	} else {
+		struct inode *inode = file_inode(iocb->ki_filp);
+
+		/*
+		 * Async DIO completion that requires filesystem level
+		 * completion work gets punted to a work queue to complete as
+		 * the operation may require more IO to be issued to finalise
+		 * filesystem metadata changes or guarantee data integrity.
+		 */
+		INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
+		queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
 	}
+}
+
+void iomap_dio_bio_end_io(struct bio *bio)
+{
+	struct iomap_dio *dio = bio->bi_private;
+	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
+
+	if (bio->bi_status)
+		iomap_dio_set_error(dio, blk_status_to_errno(bio->bi_status));
+
+	if (atomic_dec_and_test(&dio->ref))
+		iomap_dio_done(dio);
 
-	/*
-	 * Async DIO completion that requires filesystem level completion work
-	 * gets punted to a work queue to complete as the operation may require
-	 * more IO to be issued to finalise filesystem metadata changes or
-	 * guarantee data integrity.
-	 */
-	INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
-	queue_work(file_inode(iocb->ki_filp)->i_sb->s_dio_done_wq,
-			&dio->aio.work);
-release_bio:
 	if (should_dirty) {
 		bio_check_pages_dirty(bio);
 	} else {
-- 
2.45.2


