Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFEE12E62F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 22:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfE2U37 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 16:29:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40989 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfE2U36 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 16:29:58 -0400
Received: by mail-io1-f65.google.com with SMTP id w25so3034185ioc.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2019 13:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FiMMbeOgt7UGFUO506JoMeT/q2pB3Wh15xaT7cNRhrY=;
        b=ortJPsL2Mads5bRbW+6qzN00oD76LmXstSHqf1g23dA9W9gvk2D7xHEBeB9LTL6NE+
         MJYyR++oAf64dOcgkKFcZyN+b2Txn3BD9ZJb7QpnruSWx7C4byGOtA3u0kiwrfGuc16a
         QJEfiC5s2AXEvnlCKmjzK6/T4y1sVMKvtMMnBppC8LPupsXlprvfmift7WqXspFw2TM+
         hkU1xvWUr1UllVwarI29m9ShVAHeOPQnrG6EE6HJBY9w+TaW+zOqqd3LS3pizaLBlTVj
         7tVtxuKET4ZK6RCGmmZDvPO253EvX2iN/8HK1hDqc0OEiQEcMTZzeSWpWrgz1390WJzJ
         LA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FiMMbeOgt7UGFUO506JoMeT/q2pB3Wh15xaT7cNRhrY=;
        b=pqv66f8wt1bQqLJcYQmCiFyuU4D5Y6qtwycq0TlzgOGsGu4RHIdYQHYVdp+RG+7THI
         QgQIrx2yzRQksqQyhtuOPep08Utd/8lv83Ll4FRIAgN7U5Yf9wxO2y8gWLLV8npKfq6O
         ucmhrRZVjChfNcX8epOum3ewC9ZZjjP2OMFhqGR/LvtHZX8ViEDUj7aoJiC/4Ge1AGm2
         DyLSsI5cDt/Ch8iQ+T12IWlNG+89Jg9/iYrBbs3xjaMWooc6A+MNiBkJJD48Fw07SdQm
         5cci9a6ZmJ7U3pqrnPfQnV66YghRYcOKdnQx1GnNDcb0E2Dhp5D+x0nnuoUiNyot5lFi
         NSag==
X-Gm-Message-State: APjAAAWPpcbtpzuuXJlnl2yCkH2G/4cVxdGb2YXqi6oYI/H4z/xC06V8
        Jda3T3IRtDax33MFQMugbtCp7PUxyp6gig==
X-Google-Smtp-Source: APXvYqwenv0XOpGGgEiwsRSz0NEY3b+gMzjyRyCkXl7hDoG+KaXqk9EpxPVkKcLJ2Zs6dy0eT+o4JA==
X-Received: by 2002:a6b:5106:: with SMTP id f6mr8762554iob.15.1559161796690;
        Wed, 29 May 2019 13:29:56 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k76sm179105ita.6.2019.05.29.13.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:29:55 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] io_uring: add support for sqe links
Date:   Wed, 29 May 2019 14:29:48 -0600
Message-Id: <20190529202948.20833-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529202948.20833-1-axboe@kernel.dk>
References: <20190529202948.20833-1-axboe@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With SQE links, we can create chains of dependent SQEs. One example
would be queueing an SQE that's a read from one file descriptor, with
the linked SQE being a write to another with the same set of buffers.

An SQE link will not stall the pipeline, it'll just ensure that
dependent SQEs aren't issued before the previous link has completed.

Any error at submission or completion time will break the chain of SQEs.
For completions, this also includes short reads or writes, as the next
SQE could depend on the previous one being fully completed.

Any SQE in a chain that gets canceled due to any of the above errors,
will get an CQE fill with -ECANCELED as the error value.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 239 +++++++++++++++++++++++++++-------
 include/uapi/linux/io_uring.h |   1 +
 2 files changed, 192 insertions(+), 48 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 92debd8be535..df803a73849b 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -322,6 +322,7 @@ struct io_kiocb {
 
 	struct io_ring_ctx	*ctx;
 	struct list_head	list;
+	struct list_head	link_list;
 	unsigned int		flags;
 	refcount_t		refs;
 #define REQ_F_NOWAIT		1	/* must not punt to workers */
@@ -330,8 +331,10 @@ struct io_kiocb {
 #define REQ_F_SEQ_PREV		8	/* sequential with previous */
 #define REQ_F_IO_DRAIN		16	/* drain existing IO first */
 #define REQ_F_IO_DRAINED	32	/* drain done */
+#define REQ_F_LINK		64	/* linked sqes */
+#define REQ_F_FAIL_LINK		128	/* fail rest of links */
 	u64			user_data;
-	u32			error;	/* iopoll result from callback */
+	u32			result;
 	u32			sequence;
 
 	struct work_struct	work;
@@ -583,6 +586,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 	req->flags = 0;
 	/* one is dropped after submission, the other at completion */
 	refcount_set(&req->refs, 2);
+	req->result = 0;
 	return req;
 out:
 	io_ring_drop_ctx_refs(ctx, 1);
@@ -598,7 +602,7 @@ static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
 	}
 }
 
-static void io_free_req(struct io_kiocb *req)
+static void __io_free_req(struct io_kiocb *req)
 {
 	if (req->file && !(req->flags & REQ_F_FIXED_FILE))
 		fput(req->file);
@@ -606,6 +610,63 @@ static void io_free_req(struct io_kiocb *req)
 	kmem_cache_free(req_cachep, req);
 }
 
+static void io_req_link_next(struct io_kiocb *req)
+{
+	struct io_kiocb *nxt;
+
+	/*
+	 * The list should never be empty when we are called here. But could
+	 * potentially happen if the chain is messed up, check to be on the
+	 * safe side.
+	 */
+	nxt = list_first_entry_or_null(&req->link_list, struct io_kiocb, list);
+	if (nxt) {
+		list_del(&nxt->list);
+		if (!list_empty(&req->link_list)) {
+			INIT_LIST_HEAD(&nxt->link_list);
+			list_splice(&req->link_list, &nxt->link_list);
+			nxt->flags |= REQ_F_LINK;
+		}
+
+		INIT_WORK(&nxt->work, io_sq_wq_submit_work);
+		queue_work(req->ctx->sqo_wq, &nxt->work);
+	}
+}
+
+/*
+ * Called if REQ_F_LINK is set, and we fail the head request
+ */
+static void io_fail_links(struct io_kiocb *req)
+{
+	struct io_kiocb *link;
+
+	while (!list_empty(&req->link_list)) {
+		link = list_first_entry(&req->link_list, struct io_kiocb, list);
+		list_del(&link->list);
+
+		io_cqring_add_event(req->ctx, link->user_data, -ECANCELED);
+		__io_free_req(link);
+	}
+}
+
+static void io_free_req(struct io_kiocb *req)
+{
+	/*
+	 * If LINK is set, we have dependent requests in this chain. If we
+	 * didn't fail this request, queue the first one up, moving any other
+	 * dependencies to the next request. In case of failure, fail the rest
+	 * of the chain.
+	 */
+	if (req->flags & REQ_F_LINK) {
+		if (req->flags & REQ_F_FAIL_LINK)
+			io_fail_links(req);
+		else
+			io_req_link_next(req);
+	}
+
+	__io_free_req(req);
+}
+
 static void io_put_req(struct io_kiocb *req)
 {
 	if (refcount_dec_and_test(&req->refs))
@@ -627,16 +688,17 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 		req = list_first_entry(done, struct io_kiocb, list);
 		list_del(&req->list);
 
-		io_cqring_fill_event(ctx, req->user_data, req->error);
+		io_cqring_fill_event(ctx, req->user_data, req->result);
 		(*nr_events)++;
 
 		if (refcount_dec_and_test(&req->refs)) {
 			/* If we're not using fixed files, we have to pair the
 			 * completion part with the file put. Use regular
 			 * completions for those, only batch free for fixed
-			 * file.
+			 * file and non-linked commands.
 			 */
-			if (req->flags & REQ_F_FIXED_FILE) {
+			if ((req->flags & (REQ_F_FIXED_FILE|REQ_F_LINK)) ==
+			    REQ_F_FIXED_FILE) {
 				reqs[to_free++] = req;
 				if (to_free == ARRAY_SIZE(reqs))
 					io_free_req_many(ctx, reqs, &to_free);
@@ -775,6 +837,8 @@ static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 
 	kiocb_end_write(kiocb);
 
+	if ((req->flags & REQ_F_LINK) && res != req->result)
+		req->flags |= REQ_F_FAIL_LINK;
 	io_cqring_add_event(req->ctx, req->user_data, res);
 	io_put_req(req);
 }
@@ -785,7 +849,9 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res, long res2)
 
 	kiocb_end_write(kiocb);
 
-	req->error = res;
+	if ((req->flags & REQ_F_LINK) && res != req->result)
+		req->flags |= REQ_F_FAIL_LINK;
+	req->result = res;
 	if (res != -EAGAIN)
 		req->flags |= REQ_F_IOPOLL_COMPLETED;
 }
@@ -928,7 +994,6 @@ static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
 		    !kiocb->ki_filp->f_op->iopoll)
 			return -EOPNOTSUPP;
 
-		req->error = 0;
 		kiocb->ki_flags |= IOCB_HIPRI;
 		kiocb->ki_complete = io_complete_rw_iopoll;
 	} else {
@@ -1106,6 +1171,9 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 		return ret;
 
 	read_size = ret;
+	if (req->flags & REQ_F_LINK)
+		req->result = read_size;
+
 	iov_count = iov_iter_count(&iter);
 	ret = rw_verify_area(READ, file, &kiocb->ki_pos, iov_count);
 	if (!ret) {
@@ -1163,6 +1231,9 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 	if (ret < 0)
 		return ret;
 
+	if (req->flags & REQ_F_LINK)
+		req->result = ret;
+
 	iov_count = iov_iter_count(&iter);
 
 	ret = -EAGAIN;
@@ -1266,6 +1337,8 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 				end > 0 ? end : LLONG_MAX,
 				fsync_flags & IORING_FSYNC_DATASYNC);
 
+	if (ret < 0)
+		req->flags |= REQ_F_FAIL_LINK;
 	io_cqring_add_event(req->ctx, sqe->user_data, ret);
 	io_put_req(req);
 	return 0;
@@ -1310,6 +1383,8 @@ static int io_sync_file_range(struct io_kiocb *req,
 
 	ret = sync_file_range(req->rw.ki_filp, sqe_off, sqe_len, flags);
 
+	if (ret < 0)
+		req->flags |= REQ_F_FAIL_LINK;
 	io_cqring_add_event(req->ctx, sqe->user_data, ret);
 	io_put_req(req);
 	return 0;
@@ -1562,9 +1637,10 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 {
 	int ret, opcode;
 
+	req->user_data = READ_ONCE(s->sqe->user_data);
+
 	if (unlikely(s->index >= ctx->sq_entries))
 		return -EINVAL;
-	req->user_data = READ_ONCE(s->sqe->user_data);
 
 	opcode = READ_ONCE(s->sqe->opcode);
 	switch (opcode) {
@@ -1608,7 +1684,7 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		return ret;
 
 	if (ctx->flags & IORING_SETUP_IOPOLL) {
-		if (req->error == -EAGAIN)
+		if (req->result == -EAGAIN)
 			return -EAGAIN;
 
 		/* workqueue context doesn't hold uring_lock, grab it now */
@@ -1834,31 +1910,11 @@ static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 	return 0;
 }
 
-static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
-			 struct io_submit_state *state)
+static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
+			struct sqe_submit *s)
 {
-	struct io_kiocb *req;
 	int ret;
 
-	/* enforce forwards compatibility on users */
-	if (unlikely(s->sqe->flags & ~(IOSQE_FIXED_FILE | IOSQE_IO_DRAIN)))
-		return -EINVAL;
-
-	req = io_get_req(ctx, state);
-	if (unlikely(!req))
-		return -EAGAIN;
-
-	ret = io_req_set_file(ctx, s, state, req);
-	if (unlikely(ret))
-		goto out;
-
-	ret = io_req_defer(ctx, req, s->sqe);
-	if (ret) {
-		if (ret == -EIOCBQUEUED)
-			ret = 0;
-		return ret;
-	}
-
 	ret = __io_submit_sqe(ctx, req, s, true);
 	if (ret == -EAGAIN && !(req->flags & REQ_F_NOWAIT)) {
 		struct io_uring_sqe *sqe_copy;
@@ -1881,24 +1937,91 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 
 			/*
 			 * Queued up for async execution, worker will release
-			 * submit reference when the iocb is actually
-			 * submitted.
+			 * submit reference when the iocb is actually submitted.
 			 */
 			return 0;
 		}
 	}
 
-out:
 	/* drop submission reference */
 	io_put_req(req);
 
 	/* and drop final reference, if we failed */
-	if (ret)
+	if (ret) {
+		io_cqring_add_event(ctx, req->user_data, ret);
+		if (req->flags & REQ_F_LINK)
+			req->flags |= REQ_F_FAIL_LINK;
 		io_put_req(req);
+	}
 
 	return ret;
 }
 
+#define SQE_VALID_FLAGS	(IOSQE_FIXED_FILE|IOSQE_IO_DRAIN|IOSQE_IO_LINK)
+
+static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
+			  struct io_submit_state *state, struct io_kiocb **link)
+{
+	struct io_uring_sqe *sqe_copy;
+	struct io_kiocb *req = NULL;
+	int ret;
+
+	/* enforce forwards compatibility on users */
+	if (unlikely(s->sqe->flags & ~SQE_VALID_FLAGS)) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	req = io_get_req(ctx, state);
+	if (unlikely(!req)) {
+		ret = -EAGAIN;
+		goto err;
+	}
+
+	ret = io_req_set_file(ctx, s, state, req);
+	if (unlikely(ret))
+		goto err;
+
+	ret = io_req_defer(ctx, req, s->sqe);
+	if (ret && ret != -EIOCBQUEUED)
+		goto err;
+
+	/*
+	 * If we already have a head request, queue this one for async
+	 * submittal once the head completes. If we don't have a head but
+	 * IOSQE_IO_LINK is set in the sqe, start a new head. This one will be
+	 * submitted sync once the chain is complete. If none of those
+	 * conditions are true (normal request), then just queue it.
+	 */
+	if (*link) {
+		struct io_kiocb *prev = *link;
+
+		sqe_copy = kmemdup(s->sqe, sizeof(*sqe_copy), GFP_KERNEL);
+		if (!sqe_copy) {
+			ret = -EAGAIN;
+			goto err;
+		}
+
+		s->sqe = sqe_copy;
+		memcpy(&req->submit, s, sizeof(*s));
+		list_add_tail(&req->list, &prev->link_list);
+	} else if (s->sqe->flags & IOSQE_IO_LINK) {
+		req->flags |= REQ_F_LINK;
+
+		memcpy(&req->submit, s, sizeof(*s));
+		INIT_LIST_HEAD(&req->link_list);
+		*link = req;
+	} else {
+		io_queue_sqe(ctx, req, s);
+	}
+
+	return;
+err:
+	io_cqring_add_event(ctx, s->sqe->user_data, ret);
+	if (req)
+		io_free_req(req);
+}
+
 /*
  * Batched submission is done, ensure local IO is flushed out.
  */
@@ -1981,7 +2104,9 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 			  unsigned int nr, bool has_user, bool mm_fault)
 {
 	struct io_submit_state state, *statep = NULL;
-	int ret, i, submitted = 0;
+	struct io_kiocb *link = NULL;
+	bool prev_was_link = false;
+	int i, submitted = 0;
 
 	if (nr > IO_PLUG_THRESHOLD) {
 		io_submit_state_start(&state, ctx, nr);
@@ -1989,22 +2114,30 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 	}
 
 	for (i = 0; i < nr; i++) {
+		/*
+		 * If previous wasn't linked and we have a linked command,
+		 * that's the end of the chain. Submit the previous link.
+		 */
+		if (!prev_was_link && link) {
+			io_queue_sqe(ctx, link, &link->submit);
+			link = NULL;
+		}
+		prev_was_link = (sqes[i].sqe->flags & IOSQE_IO_LINK) != 0;
+
 		if (unlikely(mm_fault)) {
-			ret = -EFAULT;
+			io_cqring_add_event(ctx, sqes[i].sqe->user_data,
+						-EFAULT);
 		} else {
 			sqes[i].has_user = has_user;
 			sqes[i].needs_lock = true;
 			sqes[i].needs_fixed_file = true;
-			ret = io_submit_sqe(ctx, &sqes[i], statep);
-		}
-		if (!ret) {
+			io_submit_sqe(ctx, &sqes[i], statep, &link);
 			submitted++;
-			continue;
 		}
-
-		io_cqring_add_event(ctx, sqes[i].sqe->user_data, ret);
 	}
 
+	if (link)
+		io_queue_sqe(ctx, link, &link->submit);
 	if (statep)
 		io_submit_state_end(&state);
 
@@ -2145,6 +2278,8 @@ static int io_sq_thread(void *data)
 static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 {
 	struct io_submit_state state, *statep = NULL;
+	struct io_kiocb *link = NULL;
+	bool prev_was_link = false;
 	int i, submit = 0;
 
 	if (to_submit > IO_PLUG_THRESHOLD) {
@@ -2154,22 +2289,30 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 
 	for (i = 0; i < to_submit; i++) {
 		struct sqe_submit s;
-		int ret;
 
 		if (!io_get_sqring(ctx, &s))
 			break;
 
+		/*
+		 * If previous wasn't linked and we have a linked command,
+		 * that's the end of the chain. Submit the previous link.
+		 */
+		if (!prev_was_link && link) {
+			io_queue_sqe(ctx, link, &link->submit);
+			link = NULL;
+		}
+		prev_was_link = (s.sqe->flags & IOSQE_IO_LINK) != 0;
+
 		s.has_user = true;
 		s.needs_lock = false;
 		s.needs_fixed_file = false;
 		submit++;
-
-		ret = io_submit_sqe(ctx, &s, statep);
-		if (ret)
-			io_cqring_add_event(ctx, s.sqe->user_data, ret);
+		io_submit_sqe(ctx, &s, statep, &link);
 	}
 	io_commit_sqring(ctx);
 
+	if (link)
+		io_queue_sqe(ctx, link, &link->submit);
 	if (statep)
 		io_submit_state_end(statep);
 
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index a0c460025036..10b7c45f6d57 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -40,6 +40,7 @@ struct io_uring_sqe {
  */
 #define IOSQE_FIXED_FILE	(1U << 0)	/* use fixed fileset */
 #define IOSQE_IO_DRAIN		(1U << 1)	/* issue after inflight IO */
+#define IOSQE_IO_LINK		(1U << 2)	/* links next sqe */
 
 /*
  * io_uring_setup() flags
-- 
2.17.1

