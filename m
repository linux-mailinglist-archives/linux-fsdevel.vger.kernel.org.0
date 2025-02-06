Return-Path: <linux-fsdevel+bounces-41031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D054CA2A118
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 07:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581FA3A7B02
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC146224AFF;
	Thu,  6 Feb 2025 06:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1gUfIJzv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF31224B11;
	Thu,  6 Feb 2025 06:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738824053; cv=none; b=fVn4+jpwXGoJH6JYxSW6sJzLb8arrE7Fv3IvYtixkh4Yx8k5WbgyOGa3CzPSP7Qi7mMPjSv9hG3zF9mvU5P/EJTPbiKYTRoVw6iN63fr0F32JgtvXxgg8aW85LWlAoqoEeenNEnxPBhZzlWI4b8t74lzyXMvku2OZf0C02GDV30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738824053; c=relaxed/simple;
	bh=T/1kkw4MKmsxZ/tTvd44kbd1WT58dmyJRSr84gsFdcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnSNMSTQw+G76Gd2omPG7LcECUuUXAioZfiR+SdvPGXri6ZZkiTeAM3LoEo+ZbECmMzqn00+EGTki4tVCLazGiz+mauWL4Ss7UTsodTwhIcMr2TAyVUqXiUjQP5fYzjvzrIZmBAK+/dQqPEBCpGF55hMTAuVlYtnYYOOS0MR0DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1gUfIJzv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/hDkmZICzrxCz8uGy2Gtuc9+BUt4GTsX77KkfKVFCZY=; b=1gUfIJzvNfH5Jb5iapYIt3V1vR
	2IZ4pFa4yWciteubvTGdRyg1UT5U7yFE5+vstCQdAvJi6/eCv++EPwnXge4FGq3Fx9OCRAqMxiQX3
	koyQPJu8EKrPUfHcQN2pv0QPImt7bOd0HAxPXpvQkNEQLDwOguiNvV1fVRs4biIZi4UmDvGbWI9zg
	g+BrNUNa0mfoYx5k5TuOwLd3Qn1kAU6MRneOTSOen4pj8p+qgWX1Dw7NQXV8LjcAvLmh39fjLJgbH
	4u5EVo7/d0nZoeoaptkCSPW5GOv7dBygfmXzSkrIh+on2F8L3lVVwUE6lQbLFOb2yBZLT7QS3UrI2
	/DJNvbOw==;
Received: from 2a02-8389-2341-5b80-9d5d-e9d2-4927-2bd6.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9d5d:e9d2:4927:2bd6] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tfvZD-00000005PUf-0byc;
	Thu, 06 Feb 2025 06:40:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/11] iomap: factor out a iomap_dio_done helper
Date: Thu,  6 Feb 2025 07:40:04 +0100
Message-ID: <20250206064035.2323428-7-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206064035.2323428-1-hch@lst.de>
References: <20250206064035.2323428-1-hch@lst.de>
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
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/direct-io.c | 76 ++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 641649a04614..277ece243770 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -165,43 +165,31 @@ static inline void iomap_dio_set_error(struct iomap_dio *dio, int ret)
 	cmpxchg(&dio->error, 0, ret);
 }
 
-void iomap_dio_bio_end_io(struct bio *bio)
+/*
+ * Called when dio->ref reaches zero from an I/O completion.
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


