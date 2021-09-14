Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A4640AB1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 11:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhINJtf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 05:49:35 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:34879 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229906AbhINJtc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:49:32 -0400
Received: from MTA-06-4.privateemail.com (mta-06-1.privateemail.com [68.65.122.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 0025D80E09;
        Tue, 14 Sep 2021 05:48:14 -0400 (EDT)
Received: from mta-06.privateemail.com (localhost [127.0.0.1])
        by mta-06.privateemail.com (Postfix) with ESMTP id D04331800222;
        Tue, 14 Sep 2021 05:48:13 -0400 (EDT)
Received: from hal-station.. (unknown [10.20.151.241])
        by mta-06.privateemail.com (Postfix) with ESMTPA id 1A995180021A;
        Tue, 14 Sep 2021 05:48:13 -0400 (EDT)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hamza Mahfooz <someguy@effective-light.com>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] aio: convert active_reqs into a hashtable
Date:   Tue, 14 Sep 2021 05:46:25 -0400
Message-Id: <20210914094625.171211-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 833f4154ed56 ("aio: fold lookup_kiocb() into its sole caller")
suggests that, the fact that active_reqs is a linked-list means aio_kiocb
lookups in io_cancel() are inefficient. So, to get faster lookups (on
average) while maintaining similar insertion and deletion characteristics,
turn active_reqs into a hashtable.

Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
 fs/aio.c | 76 ++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 27 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 51b08ab01dff..4d692d9d6fb9 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -116,6 +116,8 @@ struct kioctx {
 	 */
 	unsigned		max_reqs;
 
+	unsigned int		hash_bits;
+
 	/* Size of ringbuffer, in units of struct io_event */
 	unsigned		nr_events;
 
@@ -146,7 +148,7 @@ struct kioctx {
 
 	struct {
 		spinlock_t	ctx_lock;
-		struct list_head active_reqs;	/* used for cancellation */
+		struct hlist_head *active_reqs;	/* used for cancellation */
 	} ____cacheline_aligned_in_smp;
 
 	struct {
@@ -206,7 +208,7 @@ struct aio_kiocb {
 
 	struct io_event		ki_res;
 
-	struct list_head	ki_list;	/* the aio core uses this
+	struct hlist_node	ki_node;	/* the aio core uses this
 						 * for cancellation */
 	refcount_t		ki_refcnt;
 
@@ -563,11 +565,13 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 	struct kioctx *ctx = req->ki_ctx;
 	unsigned long flags;
 
-	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
+	if (WARN_ON_ONCE(hash_hashed(&req->ki_node)))
 		return;
 
 	spin_lock_irqsave(&ctx->ctx_lock, flags);
-	list_add_tail(&req->ki_list, &ctx->active_reqs);
+	hlist_add_head(&req->ki_node,
+		       &ctx->active_reqs[hash_min(req->ki_res.obj,
+						  ctx->hash_bits)]);
 	req->ki_cancel = cancel;
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 }
@@ -584,6 +588,7 @@ static void free_ioctx(struct work_struct *work)
 					  free_rwork);
 	pr_debug("freeing %p\n", ctx);
 
+	kfree(ctx->active_reqs);
 	aio_free_ring(ctx);
 	free_percpu(ctx->cpu);
 	percpu_ref_exit(&ctx->reqs);
@@ -611,16 +616,21 @@ static void free_ioctx_reqs(struct percpu_ref *ref)
  */
 static void free_ioctx_users(struct percpu_ref *ref)
 {
+	int i;
 	struct kioctx *ctx = container_of(ref, struct kioctx, users);
 	struct aio_kiocb *req;
+	struct hlist_head *list;
+	struct hlist_node *node;
 
 	spin_lock_irq(&ctx->ctx_lock);
 
-	while (!list_empty(&ctx->active_reqs)) {
-		req = list_first_entry(&ctx->active_reqs,
-				       struct aio_kiocb, ki_list);
-		req->ki_cancel(&req->rw);
-		list_del_init(&req->ki_list);
+	for (i = 0; i < (1U << ctx->hash_bits); i++) {
+		list = &ctx->active_reqs[i];
+
+		hlist_for_each_entry_safe(req, node, list, ki_node) {
+			req->ki_cancel(&req->rw);
+			hash_del(&req->ki_node);
+		}
 	}
 
 	spin_unlock_irq(&ctx->ctx_lock);
@@ -735,6 +745,7 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
 		return ERR_PTR(-ENOMEM);
 
 	ctx->max_reqs = max_reqs;
+	ctx->hash_bits = ilog2(max_reqs);
 
 	spin_lock_init(&ctx->ctx_lock);
 	spin_lock_init(&ctx->completion_lock);
@@ -744,7 +755,14 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
 	mutex_lock(&ctx->ring_lock);
 	init_waitqueue_head(&ctx->wait);
 
-	INIT_LIST_HEAD(&ctx->active_reqs);
+	ctx->active_reqs = kmalloc_array(1U << ctx->hash_bits,
+					 sizeof(struct hlist_head),
+					 GFP_KERNEL);
+
+	if (!ctx->active_reqs)
+		goto err;
+
+	__hash_init(ctx->active_reqs, 1U << ctx->hash_bits);
 
 	if (percpu_ref_init(&ctx->users, free_ioctx_users, 0, GFP_KERNEL))
 		goto err;
@@ -799,6 +817,7 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
 	aio_free_ring(ctx);
 err:
 	mutex_unlock(&ctx->ring_lock);
+	kfree(ctx->active_reqs);
 	free_percpu(ctx->cpu);
 	percpu_ref_exit(&ctx->reqs);
 	percpu_ref_exit(&ctx->users);
@@ -1037,7 +1056,7 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 
 	percpu_ref_get(&ctx->reqs);
 	req->ki_ctx = ctx;
-	INIT_LIST_HEAD(&req->ki_list);
+	INIT_HLIST_NODE(&req->ki_node);
 	refcount_set(&req->ki_refcnt, 2);
 	req->ki_eventfd = NULL;
 	return req;
@@ -1407,22 +1426,17 @@ SYSCALL_DEFINE1(io_destroy, aio_context_t, ctx)
 	return -EINVAL;
 }
 
-static void aio_remove_iocb(struct aio_kiocb *iocb)
+static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
 {
-	struct kioctx *ctx = iocb->ki_ctx;
 	unsigned long flags;
+	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
+	struct kioctx *ctx = iocb->ki_ctx;
 
 	spin_lock_irqsave(&ctx->ctx_lock, flags);
-	list_del(&iocb->ki_list);
+	if (hash_hashed(&iocb->ki_node))
+		hlist_del(&iocb->ki_node);
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
-}
 
-static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
-{
-	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
-
-	if (!list_empty_careful(&iocb->ki_list))
-		aio_remove_iocb(iocb);
 
 	if (kiocb->ki_flags & IOCB_WRITE) {
 		struct inode *inode = file_inode(kiocb->ki_filp);
@@ -1644,7 +1658,7 @@ static void aio_poll_complete_work(struct work_struct *work)
 		spin_unlock_irq(&ctx->ctx_lock);
 		return;
 	}
-	list_del_init(&iocb->ki_list);
+	hash_del(&iocb->ki_node);
 	iocb->ki_res.res = mangle_poll(mask);
 	req->done = true;
 	spin_unlock_irq(&ctx->ctx_lock);
@@ -1692,7 +1706,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		 * call this function with IRQs disabled and because IRQs
 		 * have to be disabled before ctx_lock is obtained.
 		 */
-		list_del(&iocb->ki_list);
+		hlist_del(&iocb->ki_node);
 		iocb->ki_res.res = mangle_poll(mask);
 		req->done = true;
 		if (iocb->ki_eventfd && eventfd_signal_allowed()) {
@@ -1739,6 +1753,7 @@ static int aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 	struct aio_poll_table apt;
 	bool cancel = false;
 	__poll_t mask;
+	struct hlist_head *list;
 
 	/* reject any unknown events outside the normal event mask. */
 	if ((u16)iocb->aio_buf != iocb->aio_buf)
@@ -1778,7 +1793,9 @@ static int aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 		} else if (cancel) {
 			WRITE_ONCE(req->cancelled, true);
 		} else if (!req->done) { /* actually waiting for an event */
-			list_add_tail(&aiocb->ki_list, &ctx->active_reqs);
+			list = &ctx->active_reqs[hash_min(aiocb->ki_res.obj,
+							  ctx->hash_bits)];
+			hlist_add_head(&aiocb->ki_node, list);
 			aiocb->ki_cancel = aio_poll_cancel;
 		}
 		spin_unlock(&req->head->lock);
@@ -2007,6 +2024,8 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 	struct aio_kiocb *kiocb;
 	int ret = -EINVAL;
 	u32 key;
+	struct hlist_head *list;
+	struct hlist_node *node;
 	u64 obj = (u64)(unsigned long)iocb;
 
 	if (unlikely(get_user(key, &iocb->aio_key)))
@@ -2019,14 +2038,17 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 		return -EINVAL;
 
 	spin_lock_irq(&ctx->ctx_lock);
-	/* TODO: use a hash or array, this sucks. */
-	list_for_each_entry(kiocb, &ctx->active_reqs, ki_list) {
+
+	list = &ctx->active_reqs[hash_min(kiocb->ki_res.obj, ctx->hash_bits)];
+
+	hlist_for_each_entry_safe(kiocb, node, list, ki_node) {
 		if (kiocb->ki_res.obj == obj) {
 			ret = kiocb->ki_cancel(&kiocb->rw);
-			list_del_init(&kiocb->ki_list);
+			hash_del(&kiocb->ki_node);
 			break;
 		}
 	}
+
 	spin_unlock_irq(&ctx->ctx_lock);
 
 	if (!ret) {
-- 
2.33.0

