Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75BF29097A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 18:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410674AbgJPQOa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 12:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409919AbgJPQO3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:14:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DA1C061755;
        Fri, 16 Oct 2020 09:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TkgqxWglFUIP1a3J+DuCB1XrlsPf1nbMk8ZxI6MCjpw=; b=MemiQZCTJM0E0lkVqjWBazBk2+
        EyhLZebcySW1MrQOPsM97n8chW3rQJXtnLljHn0SV4YsuqDIC7U4VF7earm8vKAgt9MDZT7D4FuQG
        Zob8uRGzlMRGreTq8dBSIDt9Jt7lOP55ws1h7nYKHttP73M4em8N2v01QILBfF0pO5yvUhweLUlez
        p3iIDilyXyzYzD4RV7cDNh6r3S5TUvGJgVa0ohZ4eSxjfAjkPfrHzJiVHFsvgmAxnZAhdyVIOBmlO
        QNKq9JoIRSH5gzjyD2OnKqkTsyZaHfHf/Q9EAOvs+XCrNWUvbP4+WExuXkuUR+b9sYVUC0jRim2QK
        oZ1/TpSw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTSNA-0005ez-0M; Fri, 16 Oct 2020 16:14:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 1/2] block: Add submit_bio_killable
Date:   Fri, 16 Oct 2020 17:14:25 +0100
Message-Id: <20201016161426.21715-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016161426.21715-1-willy@infradead.org>
References: <20201016161426.21715-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This new function allows the user to interrupt the I/O wait with a fatal
signal, as long as the caller provides an alternative function to clean
up once the I/O does complete.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 block/bio.c                | 87 +++++++++++++++++++++++++++++---------
 include/linux/bio.h        |  1 +
 include/linux/completion.h |  1 +
 kernel/sched/completion.c  |  9 ++--
 4 files changed, 75 insertions(+), 23 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a9931f23d933..83e1d22c053e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1129,39 +1129,88 @@ static void submit_bio_wait_endio(struct bio *bio)
 	complete(bio->bi_private);
 }
 
+static
+int __submit_bio_wait(struct bio *bio, struct completion *done, int state)
+{
+	long timeout;
+	long ret = 0;
+
+	bio->bi_private = done;
+	bio->bi_end_io = submit_bio_wait_endio;
+	bio->bi_opf |= REQ_SYNC;
+	submit_bio(bio);
+
+	/* Prevent hang_check timer from firing at us during very long I/O */
+	timeout = sysctl_hung_task_timeout_secs * (HZ / 2);
+	if (!timeout)
+		timeout = MAX_SCHEDULE_TIMEOUT;
+	while (ret == 0)
+		ret = __wait_for_completion_io(done, timeout, state);
+
+	if (ret < 0)
+		return ret;
+
+	return blk_status_to_errno(bio->bi_status);
+}
+
 /**
- * submit_bio_wait - submit a bio, and wait until it completes
+ * submit_bio_wait - Submit a bio, and wait for it to complete.
  * @bio: The &struct bio which describes the I/O
  *
  * Simple wrapper around submit_bio(). Returns 0 on success, or the error from
  * bio_endio() on failure.
  *
- * WARNING: Unlike to how submit_bio() is usually used, this function does not
- * result in bio reference to be consumed. The caller must drop the reference
- * on his own.
+ * WARNING: Unlike how submit_bio() is usually used, this function does
+ * not result in a bio reference being consumed.  The caller must drop
+ * the reference.
  */
 int submit_bio_wait(struct bio *bio)
 {
 	DECLARE_COMPLETION_ONSTACK_MAP(done, bio->bi_disk->lockdep_map);
-	unsigned long hang_check;
+	return __submit_bio_wait(bio, &done, TASK_UNINTERRUPTIBLE);
+}
+EXPORT_SYMBOL(submit_bio_wait);
 
-	bio->bi_private = &done;
-	bio->bi_end_io = submit_bio_wait_endio;
-	bio->bi_opf |= REQ_SYNC;
-	submit_bio(bio);
+/**
+ * submit_bio_killable - Submit a bio, and wait for it to complete.
+ * @bio: The &struct bio which describes the I/O
+ * @async_end_io: Callback for interrupted waits
+ *
+ * Submits the BIO to the block device and waits for it to complete.
+ * If the wait is interrupted by a fatal signal, the @async_end_io
+ * will be called instead.  Unlike submit_bio_wait(), the bio will
+ * have its reference count consumed by this call (unless we get a
+ * fatal signal; in which case the reference count should be
+ * consumed by @async_end_io).
+ *
+ * Return: 0 if the bio completed successfully, -ERESTARTSYS if we received
+ * a fatal signal, or a different errno if the bio could not complete.
+ */
+int submit_bio_killable(struct bio *bio, bio_end_io_t async_end_io)
+{
+	DECLARE_COMPLETION_ONSTACK_MAP(cmpl, bio->bi_disk->lockdep_map);
+	int err = __submit_bio_wait(bio, &cmpl, TASK_KILLABLE);
 
-	/* Prevent hang_check timer from firing at us during very long I/O */
-	hang_check = sysctl_hung_task_timeout_secs;
-	if (hang_check)
-		while (!wait_for_completion_io_timeout(&done,
-					hang_check * (HZ/2)))
-			;
-	else
-		wait_for_completion_io(&done);
+	if (likely(err != -ERESTARTSYS))
+		goto completed;
 
-	return blk_status_to_errno(bio->bi_status);
+	bio->bi_end_io = async_end_io;
+	synchronize_rcu();
+	/*
+	 * Nobody can touch the completion now, but it may have been
+	 * completed while we waited.  It doesn't really matter what
+	 * error we return since the task is about to die, but we need
+	 * to not leak the bio.
+	 */
+	if (!cmpl.done)
+		return err;
+
+	err = blk_status_to_errno(bio->bi_status);
+completed:
+	bio_put(bio);
+	return err;
 }
-EXPORT_SYMBOL(submit_bio_wait);
+EXPORT_SYMBOL(submit_bio_killable);
 
 /**
  * bio_advance - increment/complete a bio by some number of bytes
diff --git a/include/linux/bio.h b/include/linux/bio.h
index c6d765382926..f254bc79bb3a 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -431,6 +431,7 @@ static inline void bio_wouldblock_error(struct bio *bio)
 struct request_queue;
 
 extern int submit_bio_wait(struct bio *bio);
+extern int submit_bio_killable(struct bio *bio, bio_end_io_t async_end_io);
 extern void bio_advance(struct bio *, unsigned);
 
 extern void bio_init(struct bio *bio, struct bio_vec *table,
diff --git a/include/linux/completion.h b/include/linux/completion.h
index bf8e77001f18..c7d557d5639c 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -108,6 +108,7 @@ extern unsigned long wait_for_completion_timeout(struct completion *x,
 						   unsigned long timeout);
 extern unsigned long wait_for_completion_io_timeout(struct completion *x,
 						    unsigned long timeout);
+long __wait_for_completion_io(struct completion *x, long timeout, int state);
 extern long wait_for_completion_interruptible_timeout(
 	struct completion *x, unsigned long timeout);
 extern long wait_for_completion_killable_timeout(
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index a778554f9dad..3cb97b754b44 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -117,11 +117,12 @@ wait_for_common(struct completion *x, long timeout, int state)
 	return __wait_for_common(x, schedule_timeout, timeout, state);
 }
 
-static long __sched
-wait_for_common_io(struct completion *x, long timeout, int state)
+long __sched
+__wait_for_completion_io(struct completion *x, long timeout, int state)
 {
 	return __wait_for_common(x, io_schedule_timeout, timeout, state);
 }
+EXPORT_SYMBOL_GPL(__wait_for_completion_io);
 
 /**
  * wait_for_completion: - waits for completion of a task
@@ -168,7 +169,7 @@ EXPORT_SYMBOL(wait_for_completion_timeout);
  */
 void __sched wait_for_completion_io(struct completion *x)
 {
-	wait_for_common_io(x, MAX_SCHEDULE_TIMEOUT, TASK_UNINTERRUPTIBLE);
+	__wait_for_completion_io(x, MAX_SCHEDULE_TIMEOUT, TASK_UNINTERRUPTIBLE);
 }
 EXPORT_SYMBOL(wait_for_completion_io);
 
@@ -188,7 +189,7 @@ EXPORT_SYMBOL(wait_for_completion_io);
 unsigned long __sched
 wait_for_completion_io_timeout(struct completion *x, unsigned long timeout)
 {
-	return wait_for_common_io(x, timeout, TASK_UNINTERRUPTIBLE);
+	return __wait_for_completion_io(x, timeout, TASK_UNINTERRUPTIBLE);
 }
 EXPORT_SYMBOL(wait_for_completion_io_timeout);
 
-- 
2.28.0

