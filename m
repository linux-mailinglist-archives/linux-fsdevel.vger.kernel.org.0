Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D18D21FD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 23:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfEQVlp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 17:41:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42636 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbfEQVlm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 17:41:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id x15so3905999pln.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2019 14:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=203ULvcqchdXRyFRjwUMpCGtfQTE/xI1Zq4IJe/er60=;
        b=zQZQh0kiidK3+1zSHzTXqZeZGy7G+LcPsIDMEPSDNeBIJapW1OYVOrv2zMZ+xWZY75
         sBrPaoWGYhrpZ0iQ8loUkQblRAHT9Rm1zEA+KqCFo2fQGpLo4+nZUk7gm0Bzo1OjuNNe
         kDqRYTEU5TX+5yvYTa1TZvT3Rhi+OkemVlLSWG4RYINC2bgGktEEldNWW9/ORnrXg4Do
         2eeeqfuNGxtHWcUHTBEmvXCk2K3D7RyJ30/bshIaKxnGnLb0wsTE8JvXh83cVFSKM7F+
         cs8qzzybq61O73wpxCAnshmVqgwclL2k4w2HDRwNnd0SkIEQ5YYIwwmafauu+tWTRWGw
         0ksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=203ULvcqchdXRyFRjwUMpCGtfQTE/xI1Zq4IJe/er60=;
        b=itNG9DTcZnjZVyS4MBGS2dJJ5sct1geWzGS5Y7xQZ6tbhQHXLX8KW15SXKx+t5+ABJ
         2Gy0ySj3y+46F/KFgByavW1Pc111X1ck3Ul4bCtsKlN5J6xQFHBSh3a4dfTunijoCY2n
         +4SJDbafcsFN0dbTAXkNPtvo35mioO16E23Zs9+e9w3fvirjjB+pmn+k5mJt6vK2JE5V
         6gB+w/gIX+gAsAVlCPg2R0mgUmrLOiAO459Z/f3zpDQfbSahYRAiFAHeWZh+d9qxV93v
         JyWitBYlFnK5HFpyt7aCK2drEfxnBQFH3J4UT1LqK6xyU5/d0MLoIDMF50IVfA6Wtgbc
         A14Q==
X-Gm-Message-State: APjAAAWd9cc9Gk/lb643I42GRIqRrCtiFJ4ZS0WGJYZzbDwSdoY5H9Av
        MBvmnFhqXfkXMa0vgGr3OUxosadIF3W/1A==
X-Google-Smtp-Source: APXvYqxDKwBocKF0kHsI0v5Qd+lcW+QNKcn+4JoUvDlJBO0No4eQvS0wNQszTTzpBb8RW6z2P0BWhw==
X-Received: by 2002:a17:902:2a07:: with SMTP id i7mr61366174plb.125.1558129301540;
        Fri, 17 May 2019 14:41:41 -0700 (PDT)
Received: from x1.localdomain (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id z125sm15885331pfb.75.2019.05.17.14.41.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 14:41:40 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] io_uring: add support for sqe links
Date:   Fri, 17 May 2019 15:41:31 -0600
Message-Id: <20190517214131.5925-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517214131.5925-1-axboe@kernel.dk>
References: <20190517214131.5925-1-axboe@kernel.dk>
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
 fs/io_uring.c                 | 211 +++++++++++++++++++++++++++-------
 include/uapi/linux/io_uring.h |   1 +
 2 files changed, 172 insertions(+), 40 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 3e7f08094a85..b45313ed8337 100644
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
@@ -606,6 +610,56 @@ static void io_free_req(struct io_kiocb *req)
 	kmem_cache_free(req_cachep, req);
 }
 
+static void io_req_link_next(struct io_kiocb *req)
+{
+	struct io_kiocb *nxt;
+
+	nxt = list_first_entry_or_null(&req->link_list, struct io_kiocb, list);
+	list_del(&nxt->list);
+	if (!list_empty(&req->link_list)) {
+		INIT_LIST_HEAD(&nxt->link_list);
+		list_splice(&req->link_list, &nxt->link_list);
+		nxt->flags |= REQ_F_LINK;
+	}
+
+	INIT_WORK(&nxt->work, io_sq_wq_submit_work);
+	queue_work(req->ctx->sqo_wq, &nxt->work);
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
@@ -627,7 +681,7 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 		req = list_first_entry(done, struct io_kiocb, list);
 		list_del(&req->list);
 
-		io_cqring_fill_event(ctx, req->user_data, req->error);
+		io_cqring_fill_event(ctx, req->user_data, req->result);
 		(*nr_events)++;
 
 		if (refcount_dec_and_test(&req->refs)) {
@@ -636,7 +690,8 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 			 * completions for those, only batch free for fixed
 			 * file.
 			 */
-			if (req->flags & REQ_F_FIXED_FILE) {
+			if ((req->flags & (REQ_F_FIXED_FILE|REQ_F_LINK)) ==
+			    REQ_F_FIXED_FILE) {
 				reqs[to_free++] = req;
 				if (to_free == ARRAY_SIZE(reqs))
 					io_free_req_many(ctx, reqs, &to_free);
@@ -775,6 +830,8 @@ static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 
 	kiocb_end_write(kiocb);
 
+	if ((req->flags & REQ_F_LINK) && res != req->result)
+		req->flags |= REQ_F_FAIL_LINK;
 	io_cqring_add_event(req->ctx, req->user_data, res);
 	io_put_req(req);
 }
@@ -785,7 +842,9 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res, long res2)
 
 	kiocb_end_write(kiocb);
 
-	req->error = res;
+	if ((req->flags & REQ_F_LINK) && res != req->result)
+		req->flags |= REQ_F_FAIL_LINK;
+	req->result = res;
 	if (res != -EAGAIN)
 		req->flags |= REQ_F_IOPOLL_COMPLETED;
 }
@@ -928,7 +987,6 @@ static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
 		    !kiocb->ki_filp->f_op->iopoll)
 			return -EOPNOTSUPP;
 
-		req->error = 0;
 		kiocb->ki_flags |= IOCB_HIPRI;
 		kiocb->ki_complete = io_complete_rw_iopoll;
 	} else {
@@ -1106,6 +1164,9 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 		return ret;
 
 	read_size = ret;
+	if (req->flags & REQ_F_LINK)
+		req->result = read_size;
+
 	iov_count = iov_iter_count(&iter);
 	ret = rw_verify_area(READ, file, &kiocb->ki_pos, iov_count);
 	if (!ret) {
@@ -1163,6 +1224,9 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 	if (ret < 0)
 		return ret;
 
+	if (req->flags & REQ_F_LINK)
+		req->result = ret;
+
 	iov_count = iov_iter_count(&iter);
 
 	ret = -EAGAIN;
@@ -1266,6 +1330,8 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 				end > 0 ? end : LLONG_MAX,
 				fsync_flags & IORING_FSYNC_DATASYNC);
 
+	if (ret < 0)
+		req->flags |= REQ_F_FAIL_LINK;
 	io_cqring_add_event(req->ctx, sqe->user_data, ret);
 	io_put_req(req);
 	return 0;
@@ -1310,6 +1376,8 @@ static int io_sync_file_range(struct io_kiocb *req,
 
 	ret = sync_file_range(req->rw.ki_filp, sqe_off, sqe_len, flags);
 
+	if (ret < 0)
+		req->flags |= REQ_F_FAIL_LINK;
 	io_cqring_add_event(req->ctx, sqe->user_data, ret);
 	io_put_req(req);
 	return 0;
@@ -1337,6 +1405,8 @@ static int io_sendmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		ret = __sys_sendmsg_sock(sock, msg, flags);
 	}
 
+	if (ret < 0)
+		req->flags |= REQ_F_FAIL_LINK;
 	io_cqring_add_event(req->ctx, sqe->user_data, ret);
 	io_put_req(req);
 	return 0;
@@ -1367,6 +1437,8 @@ static int io_recvmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		ret = __sys_recvmsg_sock(sock, msg, flags);
 	}
 
+	if (ret < 0)
+		req->flags |= REQ_F_FAIL_LINK;
 	io_cqring_add_event(req->ctx, sqe->user_data, ret);
 	io_put_req(req);
 	return 0;
@@ -1622,9 +1694,10 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 {
 	int ret, opcode;
 
+	req->user_data = READ_ONCE(s->sqe->user_data);
+
 	if (unlikely(s->index >= ctx->sq_entries))
 		return -EINVAL;
-	req->user_data = READ_ONCE(s->sqe->user_data);
 
 	opcode = READ_ONCE(s->sqe->opcode);
 	switch (opcode) {
@@ -1674,7 +1747,7 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		return ret;
 
 	if (ctx->flags & IORING_SETUP_IOPOLL) {
-		if (req->error == -EAGAIN)
+		if (req->result == -EAGAIN)
 			return -EAGAIN;
 
 		/* workqueue context doesn't hold uring_lock, grab it now */
@@ -1900,31 +1973,11 @@ static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
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
@@ -1947,20 +2000,82 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 
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
+
+	return ret;
+}
+
+#define SQE_VALID_FLAGS	(IOSQE_FIXED_FILE|IOSQE_IO_DRAIN|IOSQE_IO_LINK)
+
+static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
+			 struct io_submit_state *state, struct io_kiocb **link)
+{
+	struct io_uring_sqe *sqe_copy;
+	struct io_kiocb *req;
+	int ret;
+
+	/* enforce forwards compatibility on users */
+	if (unlikely(s->sqe->flags & ~SQE_VALID_FLAGS))
+		return -EINVAL;
+
+	req = io_get_req(ctx, state);
+	if (unlikely(!req))
+		return -EAGAIN;
+
+	ret = io_req_set_file(ctx, s, state, req);
+	if (unlikely(ret)) {
+		io_free_req(req);
+		return ret;
+	}
+
+	ret = io_req_defer(ctx, req, s->sqe);
+	if (ret) {
+		if (ret == -EIOCBQUEUED)
+			ret = 0;
+		return ret;
+	}
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
+		if (!sqe_copy)
+			return -EAGAIN;
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
+		ret = io_queue_sqe(ctx, req, s);
+	}
 
 	return ret;
 }
@@ -2047,6 +2162,8 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 			  unsigned int nr, bool has_user, bool mm_fault)
 {
 	struct io_submit_state state, *statep = NULL;
+	struct io_kiocb *link = NULL;
+	bool prev_was_link = false;
 	int ret, i, submitted = 0;
 
 	if (nr > IO_PLUG_THRESHOLD) {
@@ -2055,22 +2172,28 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 	}
 
 	for (i = 0; i < nr; i++) {
+		if (!prev_was_link && link) {
+			io_queue_sqe(ctx, link, &link->submit);
+			link = NULL;
+		}
+		prev_was_link = (sqes[i].sqe->flags & IOSQE_IO_LINK) != 0;
+
 		if (unlikely(mm_fault)) {
 			ret = -EFAULT;
 		} else {
 			sqes[i].has_user = has_user;
 			sqes[i].needs_lock = true;
 			sqes[i].needs_fixed_file = true;
-			ret = io_submit_sqe(ctx, &sqes[i], statep);
+			ret = io_submit_sqe(ctx, &sqes[i], statep, &link);
 		}
 		if (!ret) {
 			submitted++;
 			continue;
 		}
-
-		io_cqring_add_event(ctx, sqes[i].sqe->user_data, ret);
 	}
 
+	if (link)
+		io_queue_sqe(ctx, link, &link->submit);
 	if (statep)
 		io_submit_state_end(&state);
 
@@ -2211,6 +2334,8 @@ static int io_sq_thread(void *data)
 static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 {
 	struct io_submit_state state, *statep = NULL;
+	struct io_kiocb *link = NULL;
+	bool prev_was_link = false;
 	int i, submit = 0;
 
 	if (to_submit > IO_PLUG_THRESHOLD) {
@@ -2225,17 +2350,23 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 		if (!io_get_sqring(ctx, &s))
 			break;
 
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
 
-		ret = io_submit_sqe(ctx, &s, statep);
-		if (ret)
-			io_cqring_add_event(ctx, s.sqe->user_data, ret);
+		ret = io_submit_sqe(ctx, &s, statep, &link);
 	}
 	io_commit_sqring(ctx);
 
+	if (link)
+		io_queue_sqe(ctx, link, &link->submit);
 	if (statep)
 		io_submit_state_end(statep);
 
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index c5ea202684e3..1e1652f25cc1 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -41,6 +41,7 @@ struct io_uring_sqe {
  */
 #define IOSQE_FIXED_FILE	(1U << 0)	/* use fixed fileset */
 #define IOSQE_IO_DRAIN		(1U << 1)	/* issue after inflight IO */
+#define IOSQE_IO_LINK		(1U << 2)	/* links next sqe */
 
 /*
  * io_uring_setup() flags
-- 
2.17.1

