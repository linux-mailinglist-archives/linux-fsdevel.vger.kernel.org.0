Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C70246E008
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 02:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241842AbhLIBKN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 20:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241788AbhLIBKG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 20:10:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569EEC061746;
        Wed,  8 Dec 2021 17:06:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A3A52CE2339;
        Thu,  9 Dec 2021 01:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D593C341CC;
        Thu,  9 Dec 2021 01:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639011989;
        bh=AazZIUeFHAyu5+0N3r8Kh1o5nJZxTnMKcLOR9skSYuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5VYQPIVldBlhOfnzVrqoXQemjRnJwnM7wMq+QFpTnomUesALgYKC7W+9q4KHpmSa
         calzQXipL6lj8sikFdcECbXmRYr+6KmE3278ZBvTnH22/j4TChTw+IJ2EzgLwltE0Q
         QQxed3Ox99ybTepSk4waUiSDd21HBhQ+LuMrPOB64xJuW0gQRy8jnzSMoUdujSgP/7
         Hx2IkwTj3vum423tSCy531qplOFGspb8IRi0VBO8K/Mjv8P15hQpt7kptXrWmfRrrh
         XiyLA9rDEgnxDRqfqesWG0Q6+S81ikt4Tp2FKpb6KuAis32GYIAeSGmGNRpGAZYmSj
         2uN4ztH7Oc2kw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>
Cc:     linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ramji Jiyani <ramjiyani@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>, stable@vger.kernel.org
Subject: [PATCH v3 4/5] aio: keep poll requests on waitqueue until completed
Date:   Wed,  8 Dec 2021 17:04:54 -0800
Message-Id: <20211209010455.42744-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209010455.42744-1-ebiggers@kernel.org>
References: <20211209010455.42744-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Currently, aio_poll_wake() will always remove the poll request from the
waitqueue.  Then, if aio_poll_complete_work() sees that none of the
polled events are ready and the request isn't cancelled, it re-adds the
request to the waitqueue.  (This can easily happen when polling a file
that doesn't pass an event mask when waking up its waitqueue.)

This is fundamentally broken for two reasons:

  1. If a wakeup occurs between vfs_poll() and the request being
     re-added to the waitqueue, it will be missed because the request
     wasn't on the waitqueue at the time.  Therefore, IOCB_CMD_POLL
     might never complete even if the polled file is ready.

  2. When the request isn't on the waitqueue, there is no way to be
     notified that the waitqueue is being freed (which happens when its
     lifetime is shorter than the struct file's).  This is supposed to
     happen via the waitqueue entries being woken up with POLLFREE.

Therefore, leave the requests on the waitqueue until they are actually
completed (or cancelled).  To keep track of when aio_poll_complete_work
needs to be scheduled, use new fields in struct poll_iocb.  Remove the
'done' field which is now redundant.

Note that this is consistent with how sys_poll() and eventpoll work;
their wakeup functions do *not* remove the waitqueue entries.

Fixes: 2c14fa838cbe ("aio: implement IOCB_CMD_POLL")
Cc: <stable@vger.kernel.org> # v4.18+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/aio.c | 83 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 63 insertions(+), 20 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 9c81cf611d659..2bc1352a83d8b 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -181,8 +181,9 @@ struct poll_iocb {
 	struct file		*file;
 	struct wait_queue_head	*head;
 	__poll_t		events;
-	bool			done;
 	bool			cancelled;
+	bool			work_scheduled;
+	bool			work_need_resched;
 	struct wait_queue_entry	wait;
 	struct work_struct	work;
 };
@@ -1638,14 +1639,26 @@ static void aio_poll_complete_work(struct work_struct *work)
 	 * avoid further branches in the fast path.
 	 */
 	spin_lock_irq(&ctx->ctx_lock);
+	spin_lock(&req->head->lock);
 	if (!mask && !READ_ONCE(req->cancelled)) {
-		add_wait_queue(req->head, &req->wait);
+		/*
+		 * The request isn't actually ready to be completed yet.
+		 * Reschedule completion if another wakeup came in.
+		 */
+		if (req->work_need_resched) {
+			schedule_work(&req->work);
+			req->work_need_resched = false;
+		} else {
+			req->work_scheduled = false;
+		}
+		spin_unlock(&req->head->lock);
 		spin_unlock_irq(&ctx->ctx_lock);
 		return;
 	}
+	list_del_init(&req->wait.entry);
+	spin_unlock(&req->head->lock);
 	list_del_init(&iocb->ki_list);
 	iocb->ki_res.res = mangle_poll(mask);
-	req->done = true;
 	spin_unlock_irq(&ctx->ctx_lock);
 
 	iocb_put(iocb);
@@ -1659,9 +1672,9 @@ static int aio_poll_cancel(struct kiocb *iocb)
 
 	spin_lock(&req->head->lock);
 	WRITE_ONCE(req->cancelled, true);
-	if (!list_empty(&req->wait.entry)) {
-		list_del_init(&req->wait.entry);
+	if (!req->work_scheduled) {
 		schedule_work(&aiocb->poll.work);
+		req->work_scheduled = true;
 	}
 	spin_unlock(&req->head->lock);
 
@@ -1680,20 +1693,26 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 	if (mask && !(mask & req->events))
 		return 0;
 
-	list_del_init(&req->wait.entry);
-
-	if (mask && spin_trylock_irqsave(&iocb->ki_ctx->ctx_lock, flags)) {
+	/*
+	 * Complete the request inline if possible.  This requires that three
+	 * conditions be met:
+	 *   1. An event mask must have been passed.  If a plain wakeup was done
+	 *	instead, then mask == 0 and we have to call vfs_poll() to get
+	 *	the events, so inline completion isn't possible.
+	 *   2. The completion work must not have already been scheduled.
+	 *   3. ctx_lock must not be busy.  We have to use trylock because we
+	 *	already hold the waitqueue lock, so this inverts the normal
+	 *	locking order.  Use irqsave/irqrestore because not all
+	 *	filesystems (e.g. fuse) call this function with IRQs disabled,
+	 *	yet IRQs have to be disabled before ctx_lock is obtained.
+	 */
+	if (mask && !req->work_scheduled &&
+	    spin_trylock_irqsave(&iocb->ki_ctx->ctx_lock, flags)) {
 		struct kioctx *ctx = iocb->ki_ctx;
 
-		/*
-		 * Try to complete the iocb inline if we can. Use
-		 * irqsave/irqrestore because not all filesystems (e.g. fuse)
-		 * call this function with IRQs disabled and because IRQs
-		 * have to be disabled before ctx_lock is obtained.
-		 */
+		list_del_init(&req->wait.entry);
 		list_del(&iocb->ki_list);
 		iocb->ki_res.res = mangle_poll(mask);
-		req->done = true;
 		if (iocb->ki_eventfd && eventfd_signal_allowed()) {
 			iocb = NULL;
 			INIT_WORK(&req->work, aio_poll_put_work);
@@ -1703,7 +1722,20 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		if (iocb)
 			iocb_put(iocb);
 	} else {
-		schedule_work(&req->work);
+		/*
+		 * Schedule the completion work if needed.  If it was already
+		 * scheduled, record that another wakeup came in.
+		 *
+		 * Don't remove the request from the waitqueue here, as it might
+		 * not actually be complete yet (we won't know until vfs_poll()
+		 * is called), and we must not miss any wakeups.
+		 */
+		if (req->work_scheduled) {
+			req->work_need_resched = true;
+		} else {
+			schedule_work(&req->work);
+			req->work_scheduled = true;
+		}
 	}
 	return 1;
 }
@@ -1750,8 +1782,9 @@ static int aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 	req->events = demangle_poll(iocb->aio_buf) | EPOLLERR | EPOLLHUP;
 
 	req->head = NULL;
-	req->done = false;
 	req->cancelled = false;
+	req->work_scheduled = false;
+	req->work_need_resched = false;
 
 	apt.pt._qproc = aio_poll_queue_proc;
 	apt.pt._key = req->events;
@@ -1766,17 +1799,27 @@ static int aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 	spin_lock_irq(&ctx->ctx_lock);
 	if (likely(req->head)) {
 		spin_lock(&req->head->lock);
-		if (unlikely(list_empty(&req->wait.entry))) {
-			if (apt.error)
+		if (list_empty(&req->wait.entry) || req->work_scheduled) {
+			/*
+			 * aio_poll_wake() already either scheduled the async
+			 * completion work, or completed the request inline.
+			 */
+			if (apt.error) /* unsupported case: multiple queues */
 				cancel = true;
 			apt.error = 0;
 			mask = 0;
 		}
 		if (mask || apt.error) {
+			/* Steal to complete synchronously. */
 			list_del_init(&req->wait.entry);
 		} else if (cancel) {
+			/* Cancel if possible (may be too late though). */
 			WRITE_ONCE(req->cancelled, true);
-		} else if (!req->done) { /* actually waiting for an event */
+		} else if (!list_empty(&req->wait.entry)) {
+			/*
+			 * Actually waiting for an event, so add the request to
+			 * active_reqs so that it can be cancelled if needed.
+			 */
 			list_add_tail(&aiocb->ki_list, &ctx->active_reqs);
 			aiocb->ki_cancel = aio_poll_cancel;
 		}
-- 
2.34.1

