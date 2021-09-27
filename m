Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5112D419893
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 18:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbhI0QMw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 12:12:52 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:44518 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235365AbhI0QMs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:12:48 -0400
Received: from MTA-07-4.privateemail.com (mta-07-1.privateemail.com [198.54.122.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 9C3D68019F
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Sep 2021 12:11:09 -0400 (EDT)
Received: from mta-07.privateemail.com (localhost [127.0.0.1])
        by mta-07.privateemail.com (Postfix) with ESMTP id 81A6018000A3;
        Mon, 27 Sep 2021 12:11:06 -0400 (EDT)
Received: from hal-station.. (unknown [10.20.151.201])
        by mta-07.privateemail.com (Postfix) with ESMTPA id 8980B18000A1;
        Mon, 27 Sep 2021 12:11:05 -0400 (EDT)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hamza Mahfooz <someguy@effective-light.com>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] aio: convert active_reqs into an array
Date:   Mon, 27 Sep 2021 12:10:47 -0400
Message-Id: <20210927161047.200526-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 833f4154ed56 ("aio: fold lookup_kiocb() into its sole caller")
suggests that, the fact that active_reqs is a linked-list means aio_kiocb
lookups in io_cancel() are inefficient. So, to get faster lookups while
maintaining similar characteristics elsewhere, turn active_reqs into an
array and keep track of the free indices of the array (so we know which
indices are safe to use).

Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
 fs/aio.c | 131 ++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 92 insertions(+), 39 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 51b08ab01dff..d23a861dbe95 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -48,8 +48,6 @@
 
 #include "internal.h"
 
-#define KIOCB_KEY		0
-
 #define AIO_RING_MAGIC			0xa10a10a1
 #define AIO_RING_COMPAT_FEATURES	1
 #define AIO_RING_INCOMPAT_FEATURES	0
@@ -146,7 +144,9 @@ struct kioctx {
 
 	struct {
 		spinlock_t	ctx_lock;
-		struct list_head active_reqs;	/* used for cancellation */
+		u32		req_cnt;
+		struct aio_kiocb **active_reqs;	/* used for cancellation */
+		struct list_head free_indices;
 	} ____cacheline_aligned_in_smp;
 
 	struct {
@@ -187,6 +187,11 @@ struct poll_iocb {
 	struct work_struct	work;
 };
 
+struct free_iocb {
+	u32 index;
+	struct list_head list;
+};
+
 /*
  * NOTE! Each of the iocb union members has the file pointer
  * as the first entry in their struct definition. So you can
@@ -206,8 +211,9 @@ struct aio_kiocb {
 
 	struct io_event		ki_res;
 
-	struct list_head	ki_list;	/* the aio core uses this
+	u32			ki_index;	/* the aio core uses this
 						 * for cancellation */
+
 	refcount_t		ki_refcnt;
 
 	/*
@@ -563,12 +569,12 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 	struct kioctx *ctx = req->ki_ctx;
 	unsigned long flags;
 
-	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
-		return;
-
 	spin_lock_irqsave(&ctx->ctx_lock, flags);
-	list_add_tail(&req->ki_list, &ctx->active_reqs);
+	if (WARN_ON_ONCE(ctx->active_reqs[req->ki_index]))
+		goto out;
+	ctx->active_reqs[req->ki_index] = req;
 	req->ki_cancel = cancel;
+out:
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 }
 EXPORT_SYMBOL(kiocb_set_cancel_fn);
@@ -588,6 +594,7 @@ static void free_ioctx(struct work_struct *work)
 	free_percpu(ctx->cpu);
 	percpu_ref_exit(&ctx->reqs);
 	percpu_ref_exit(&ctx->users);
+	kfree(ctx->active_reqs);
 	kmem_cache_free(kioctx_cachep, ctx);
 }
 
@@ -613,16 +620,32 @@ static void free_ioctx_users(struct percpu_ref *ref)
 {
 	struct kioctx *ctx = container_of(ref, struct kioctx, users);
 	struct aio_kiocb *req;
+	struct free_iocb *fiocb;
+	u32 i;
 
 	spin_lock_irq(&ctx->ctx_lock);
 
-	while (!list_empty(&ctx->active_reqs)) {
-		req = list_first_entry(&ctx->active_reqs,
-				       struct aio_kiocb, ki_list);
-		req->ki_cancel(&req->rw);
-		list_del_init(&req->ki_list);
+	if (unlikely(!ctx->active_reqs))
+		goto skip;
+
+	for (i = 0; i < (ctx->nr_events - 1); i++) {
+		req = ctx->active_reqs[i];
+		if (req) {
+			req->ki_cancel(&req->rw);
+			ctx->active_reqs[i] = NULL;
+		}
+	}
+
+skip:
+	while (!list_empty(&ctx->free_indices)) {
+		fiocb = list_first_entry(&ctx->free_indices, struct free_iocb,
+					 list);
+		list_del_init(&fiocb->list);
+		kfree(fiocb);
 	}
 
+	ctx->req_cnt = 0;
+
 	spin_unlock_irq(&ctx->ctx_lock);
 
 	percpu_ref_kill(&ctx->reqs);
@@ -744,7 +767,7 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
 	mutex_lock(&ctx->ring_lock);
 	init_waitqueue_head(&ctx->wait);
 
-	INIT_LIST_HEAD(&ctx->active_reqs);
+	INIT_LIST_HEAD(&ctx->free_indices);
 
 	if (percpu_ref_init(&ctx->users, free_ioctx_users, 0, GFP_KERNEL))
 		goto err;
@@ -760,6 +783,12 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
 	if (err < 0)
 		goto err;
 
+	ctx->active_reqs = kzalloc((ctx->nr_events - 1) *
+				   sizeof(struct aio_kiocb *), GFP_KERNEL);
+
+	if (!ctx->active_reqs)
+		goto err;
+
 	atomic_set(&ctx->reqs_available, ctx->nr_events - 1);
 	ctx->req_batch = (ctx->nr_events - 1) / (num_possible_cpus() * 4);
 	if (ctx->req_batch < 1)
@@ -802,6 +831,7 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
 	free_percpu(ctx->cpu);
 	percpu_ref_exit(&ctx->reqs);
 	percpu_ref_exit(&ctx->users);
+	kfree(ctx->active_reqs);
 	kmem_cache_free(kioctx_cachep, ctx);
 	pr_debug("error allocating ioctx %d\n", err);
 	return ERR_PTR(err);
@@ -1037,7 +1067,6 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 
 	percpu_ref_get(&ctx->reqs);
 	req->ki_ctx = ctx;
-	INIT_LIST_HEAD(&req->ki_list);
 	refcount_set(&req->ki_refcnt, 2);
 	req->ki_eventfd = NULL;
 	return req;
@@ -1091,6 +1120,16 @@ static void aio_complete(struct aio_kiocb *iocb)
 	struct io_event	*ev_page, *event;
 	unsigned tail, pos, head;
 	unsigned long	flags;
+	struct free_iocb *fiocb = kmalloc(sizeof(*fiocb), GFP_KERNEL);
+
+	if (!WARN_ON(!fiocb)) {
+		INIT_LIST_HEAD(&fiocb->list);
+
+		spin_lock_irq(&ctx->ctx_lock);
+		fiocb->index = iocb->ki_index;
+		list_add_tail(&fiocb->list, &ctx->free_indices);
+		spin_unlock_irq(&ctx->ctx_lock);
+	}
 
 	/*
 	 * Add a completion event to the ring buffer. Must be done holding
@@ -1407,22 +1446,15 @@ SYSCALL_DEFINE1(io_destroy, aio_context_t, ctx)
 	return -EINVAL;
 }
 
-static void aio_remove_iocb(struct aio_kiocb *iocb)
+static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
 {
+	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
 	struct kioctx *ctx = iocb->ki_ctx;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ctx->ctx_lock, flags);
-	list_del(&iocb->ki_list);
+	ctx->active_reqs[iocb->ki_index] = NULL;
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
-}
-
-static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
-{
-	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
-
-	if (!list_empty_careful(&iocb->ki_list))
-		aio_remove_iocb(iocb);
 
 	if (kiocb->ki_flags & IOCB_WRITE) {
 		struct inode *inode = file_inode(kiocb->ki_filp);
@@ -1644,7 +1676,7 @@ static void aio_poll_complete_work(struct work_struct *work)
 		spin_unlock_irq(&ctx->ctx_lock);
 		return;
 	}
-	list_del_init(&iocb->ki_list);
+	ctx->active_reqs[iocb->ki_index] = NULL;
 	iocb->ki_res.res = mangle_poll(mask);
 	req->done = true;
 	spin_unlock_irq(&ctx->ctx_lock);
@@ -1692,7 +1724,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		 * call this function with IRQs disabled and because IRQs
 		 * have to be disabled before ctx_lock is obtained.
 		 */
-		list_del(&iocb->ki_list);
+		ctx->active_reqs[iocb->ki_index] = NULL;
 		iocb->ki_res.res = mangle_poll(mask);
 		req->done = true;
 		if (iocb->ki_eventfd && eventfd_signal_allowed()) {
@@ -1778,7 +1810,7 @@ static int aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 		} else if (cancel) {
 			WRITE_ONCE(req->cancelled, true);
 		} else if (!req->done) { /* actually waiting for an event */
-			list_add_tail(&aiocb->ki_list, &ctx->active_reqs);
+			ctx->active_reqs[aiocb->ki_index] = aiocb;
 			aiocb->ki_cancel = aio_poll_cancel;
 		}
 		spin_unlock(&req->head->lock);
@@ -1816,7 +1848,7 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 		req->ki_eventfd = eventfd;
 	}
 
-	if (unlikely(put_user(KIOCB_KEY, &user_iocb->aio_key))) {
+	if (unlikely(put_user(req->ki_index, &user_iocb->aio_key))) {
 		pr_debug("EFAULT: aio_key\n");
 		return -EFAULT;
 	}
@@ -1853,6 +1885,7 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 	struct aio_kiocb *req;
 	struct iocb iocb;
 	int err;
+	struct free_iocb *fiocb = NULL;
 
 	if (unlikely(copy_from_user(&iocb, user_iocb, sizeof(iocb))))
 		return -EFAULT;
@@ -1877,6 +1910,25 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 	if (unlikely(!req))
 		return -EAGAIN;
 
+	spin_lock_irq(&ctx->ctx_lock);
+	if (!list_empty(&ctx->free_indices)) {
+		fiocb = list_first_entry(&ctx->free_indices, struct free_iocb,
+					 list);
+		list_del_init(&fiocb->list);
+		req->ki_index = fiocb->index;
+	} else {
+		if (unlikely(ctx->req_cnt >= (ctx->nr_events - 1))) {
+			spin_unlock_irq(&ctx->ctx_lock);
+			err = -EAGAIN;
+			goto out;
+		}
+		req->ki_index = ctx->req_cnt;
+		ctx->req_cnt++;
+	}
+	spin_unlock_irq(&ctx->ctx_lock);
+
+	kfree(fiocb);
+
 	err = __io_submit_one(ctx, &iocb, user_iocb, req, compat);
 
 	/* Done with the synchronous reference */
@@ -1888,6 +1940,7 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 	 * means that we need to destroy req ourselves.
 	 */
 	if (unlikely(err)) {
+out:
 		iocb_destroy(req);
 		put_reqs_available(ctx, 1);
 	}
@@ -2007,25 +2060,25 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 	struct aio_kiocb *kiocb;
 	int ret = -EINVAL;
 	u32 key;
-	u64 obj = (u64)(unsigned long)iocb;
 
 	if (unlikely(get_user(key, &iocb->aio_key)))
 		return -EFAULT;
-	if (unlikely(key != KIOCB_KEY))
-		return -EINVAL;
 
 	ctx = lookup_ioctx(ctx_id);
+
 	if (unlikely(!ctx))
 		return -EINVAL;
 
+	if (unlikely(key >= (ctx->nr_events - 1)))
+		return -EINVAL;
+
+
 	spin_lock_irq(&ctx->ctx_lock);
-	/* TODO: use a hash or array, this sucks. */
-	list_for_each_entry(kiocb, &ctx->active_reqs, ki_list) {
-		if (kiocb->ki_res.obj == obj) {
-			ret = kiocb->ki_cancel(&kiocb->rw);
-			list_del_init(&kiocb->ki_list);
-			break;
-		}
+	kiocb = ctx->active_reqs[key];
+	if (kiocb) {
+		WARN_ON_ONCE(key != kiocb->ki_index);
+		ret = kiocb->ki_cancel(&kiocb->rw);
+		ctx->active_reqs[key] = NULL;
 	}
 	spin_unlock_irq(&ctx->ctx_lock);
 
-- 
2.33.0

