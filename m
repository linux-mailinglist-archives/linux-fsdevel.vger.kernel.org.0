Return-Path: <linux-fsdevel+bounces-25841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F72C951079
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 01:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B481F259CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 23:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B111ABEA2;
	Tue, 13 Aug 2024 23:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFtfDU2W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471A116DEA9
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723591448; cv=none; b=q9E/mymTqEw4qS2cL6yC5tB7FafWcfBki4YkYiL2pBLhINAvs6KbF0rNfmqBeU8LjIc0YHu0yRBt29000s49xFj89Fht1cTavvdplCxTk68YdcZ4VLvUzukcsHp9QorKBnyR2sxTVeFkQEqVIPQdz/cW0yMcfRiX2X6AanYD5Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723591448; c=relaxed/simple;
	bh=Tg9J7aruibXYbrfC9mEnR2cB+YvvL3JmjtbK7jAp0g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uC0BtGMOn73+Anu88zvvwIX3eBe52hPR0XNJspgwS9hANxVjpmh0GueVFFXs7cdaScQiJxIhHZYfKBwsFkX55uPVy/BBlpxu2W222GyY5AO7a1QzdJhIEo6EBu+B4mXptpGVCZz7f0R9O6sJ59A4/bgqbp7HNEL6C8nKrXStnIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFtfDU2W; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e0ea24477f0so5392350276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 16:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723591445; x=1724196245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Wx6Eoh3YJi7Z2noO/l025cL+axAhPxlkr6JqaTHxb8=;
        b=gFtfDU2WU+guF8SrYz8AL3VWzJhwj3fhZ66Ok76uuZnXBlxghHVq4bmw6UqWvDgJ6R
         oXx9WgwzOxLYDNeuX0p2tQUi3Pu2TsMQQqkx2yv3WqQs/XJ0cC4w6W28E8atdg/xy0ip
         VXt3TT4tmY/NVy47JiAWOxenn9vGGeRTPTKxqLHVwoG9IXsuXx2gjf9meDoQda7UsB+N
         RhoAzcOnL85rQqgp+HaMlAHP1k7LatUL2q5C92NbZoLPFyv9SCoIpp1dhhdVhFKbA616
         ERz1PVvEmH4GleFmQHNHZrGE4DjH8Kz0FjGq1KjLzW44dR8+rm4nClHDFPoPAfuUy3OO
         tTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723591445; x=1724196245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Wx6Eoh3YJi7Z2noO/l025cL+axAhPxlkr6JqaTHxb8=;
        b=kCMWH8NPPd9GPTeWwzpAsQbxkPM07PnKezHVTBrh9WWdiQIK/MjikaZw7/xvT3ZMie
         RE1V4jG7P6cy3B7whx+ve389ZQIeVMJ3iyIpoqPdNjU9lpGMdoV9fc+oPwg9kg1DHtsI
         vk2kiwx0XEsqbSA55ALm3vg690Vh6i04OTXRWtZnhJrVXh7hQtYnWrFUtgdkqxrz79nf
         VNcVIlFkFnD/uenOR71jsoskRikCVheLDaP5JHNuAWKHu2Ot95VcCUthJNsYSvAXGx8C
         8SBQFfB8lf+3Zw/8dHmNirKWVB5fjd+A43vHfw9dNwpxpKxVUhcc03rMXnUKpVyK+fUD
         3LqA==
X-Forwarded-Encrypted: i=1; AJvYcCXB5tuVuFZmp9DF2f4k6W65Nb3UFkGqBPXsqxX3myW/WgHhmQ2mPgLCy40dBHz/Ylsrv8zKkedxFdpBNo8uttRQVVas6YE5G1EmgBEsmQ==
X-Gm-Message-State: AOJu0YwUHqjJrjaNJZucDU96puFtR+p0N8ymfU4edPXq6fkQJOseQGRy
	ZkSZRQOwnNSNKf7w+kOO0zUqjAYi1OcVs5bX06tNeIf4xrrIX3Py
X-Google-Smtp-Source: AGHT+IHjfjHSjpoclA6st0RoovGS5p67j4mZ5Y6Lp45FkN7exl1U7vpUAm+kQ2VXkCLfzGmUkUQCOg==
X-Received: by 2002:a05:6902:228f:b0:e08:70e7:91d3 with SMTP id 3f1490d57ef6-e1155c0624dmr977534276.56.1723591445033;
        Tue, 13 Aug 2024 16:24:05 -0700 (PDT)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0ec8a44878sm1679228276.0.2024.08.13.16.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 16:24:04 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v4 1/2] fuse: add optional kernel-enforced timeout for requests
Date: Tue, 13 Aug 2024 16:22:40 -0700
Message-ID: <20240813232241.2369855-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240813232241.2369855-1-joannelkoong@gmail.com>
References: <20240813232241.2369855-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are situations where fuse servers can become unresponsive or take
too long to reply to a request. Currently there is no upper bound on
how long a request may take, which may be frustrating to users who get
stuck waiting for a request to complete.

This commit adds a timeout option (in seconds) for requests. If the
timeout elapses before the server replies to the request, the request
will fail with -ETIME.

There are 3 possibilities for a request that times out:
a) The request times out before the request has been sent to userspace
b) The request times out after the request has been sent to userspace
and before it receives a reply from the server
c) The request times out after the request has been sent to userspace
and the server replies while the kernel is timing out the request

While a request timeout is being handled, there may be other handlers
running at the same time if:
a) the kernel is forwarding the request to the server
b) the kernel is processing the server's reply to the request
c) the request is being re-sent
d) the connection is aborting
e) the device is getting released

Proper synchronization must be added to ensure that the request is
handled correctly in all of these cases. To this effect, there is a new
FR_FINISHING bit added to the request flags, which is set atomically by
either the timeout handler (see fuse_request_timeout()) which is invoked
after the request timeout elapses or set by the request reply handler
(see dev_do_write()), whichever gets there first. If the reply handler
and the timeout handler are executing simultaneously and the reply handler
sets FR_FINISHING before the timeout handler, then the request will be
handled as if the timeout did not elapse. If the timeout handler sets
FR_FINISHING before the reply handler, then the request will fail with
-ETIME and the request will be cleaned up.

Currently, this is the refcount lifecycle of a request:

Synchronous request is created:
fuse_simple_request -> allocates request, sets refcount to 1
  __fuse_request_send -> acquires refcount
    queues request and waits for reply...
fuse_simple_request -> drops refcount

Background request is created:
fuse_simple_background -> allocates request, sets refcount to 1

Request is replied to:
fuse_dev_do_write
  fuse_request_end -> drops refcount on request

Proper acquires on the request reference must be added to ensure that the
timeout handler does not drop the last refcount on the request while
other handlers may be operating on the request. Please note that the
timeout handler may get invoked at any phase of the request's
lifetime (eg before the request has been forwarded to userspace, etc).

It is always guaranteed that there is a refcount on the request when the
timeout handler is executing. The timeout handler will be either
deactivated by the reply/abort/release handlers, or if the timeout
handler is concurrently executing on another CPU, the reply/abort/release
handlers will wait for the timeout handler to finish executing first before
it drops the final refcount on the request.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c    | 192 +++++++++++++++++++++++++++++++++++++++++++++--
 fs/fuse/fuse_i.h |  14 ++++
 fs/fuse/inode.c  |   7 ++
 3 files changed, 205 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9eb191b5c4de..cdfbce07bbfa 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -31,6 +31,8 @@ MODULE_ALIAS("devname:fuse");
 
 static struct kmem_cache *fuse_req_cachep;
 
+static void fuse_request_timeout(struct timer_list *timer);
+
 static struct fuse_dev *fuse_get_dev(struct file *file)
 {
 	/*
@@ -48,6 +50,8 @@ static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
 	refcount_set(&req->count, 1);
 	__set_bit(FR_PENDING, &req->flags);
 	req->fm = fm;
+	if (fm->fc->req_timeout)
+		timer_setup(&req->timer, fuse_request_timeout, 0);
 }
 
 static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t flags)
@@ -277,7 +281,7 @@ static void flush_bg_queue(struct fuse_conn *fc)
  * the 'end' callback is called if given, else the reference to the
  * request is released
  */
-void fuse_request_end(struct fuse_req *req)
+static void do_fuse_request_end(struct fuse_req *req)
 {
 	struct fuse_mount *fm = req->fm;
 	struct fuse_conn *fc = fm->fc;
@@ -296,8 +300,6 @@ void fuse_request_end(struct fuse_req *req)
 		list_del_init(&req->intr_entry);
 		spin_unlock(&fiq->lock);
 	}
-	WARN_ON(test_bit(FR_PENDING, &req->flags));
-	WARN_ON(test_bit(FR_SENT, &req->flags));
 	if (test_bit(FR_BACKGROUND, &req->flags)) {
 		spin_lock(&fc->bg_lock);
 		clear_bit(FR_BACKGROUND, &req->flags);
@@ -329,8 +331,104 @@ void fuse_request_end(struct fuse_req *req)
 put_request:
 	fuse_put_request(req);
 }
+
+void fuse_request_end(struct fuse_req *req)
+{
+	WARN_ON(test_bit(FR_PENDING, &req->flags));
+	WARN_ON(test_bit(FR_SENT, &req->flags));
+
+	if (req->timer.function)
+		timer_delete_sync(&req->timer);
+
+	do_fuse_request_end(req);
+}
 EXPORT_SYMBOL_GPL(fuse_request_end);
 
+static void timeout_inflight_req(struct fuse_req *req)
+{
+	struct fuse_conn *fc = req->fm->fc;
+	struct fuse_iqueue *fiq = &fc->iq;
+	struct fuse_pqueue *fpq;
+
+	spin_lock(&fiq->lock);
+	fpq = req->fpq;
+	spin_unlock(&fiq->lock);
+
+	/*
+	 * If fpq has not been set yet, then the request is aborting (which
+	 * clears FR_PENDING flag) before dev_do_read (which sets req->fpq)
+	 * has been called. Let the abort handler handle this request.
+	 */
+	if (!fpq)
+		return;
+
+	spin_lock(&fpq->lock);
+	if (!fpq->connected || req->out.h.error == -ECONNABORTED) {
+		/*
+		 * Connection is being aborted or the fuse_dev is being released.
+		 * The abort / release will clean up the request
+		 */
+		spin_unlock(&fpq->lock);
+		return;
+	}
+
+	if (!test_bit(FR_PRIVATE, &req->flags))
+		list_del_init(&req->list);
+
+	spin_unlock(&fpq->lock);
+
+	req->out.h.error = -ETIME;
+
+	do_fuse_request_end(req);
+}
+
+static void timeout_pending_req(struct fuse_req *req)
+{
+	struct fuse_conn *fc = req->fm->fc;
+	struct fuse_iqueue *fiq = &fc->iq;
+	bool background = test_bit(FR_BACKGROUND, &req->flags);
+
+	if (background)
+		spin_lock(&fc->bg_lock);
+	spin_lock(&fiq->lock);
+
+	if (!test_bit(FR_PENDING, &req->flags)) {
+		spin_unlock(&fiq->lock);
+		if (background)
+			spin_unlock(&fc->bg_lock);
+		timeout_inflight_req(req);
+		return;
+	}
+
+	if (!test_bit(FR_PRIVATE, &req->flags))
+		list_del_init(&req->list);
+
+	spin_unlock(&fiq->lock);
+	if (background)
+		spin_unlock(&fc->bg_lock);
+
+	req->out.h.error = -ETIME;
+
+	do_fuse_request_end(req);
+}
+
+static void fuse_request_timeout(struct timer_list *timer)
+{
+	struct fuse_req *req = container_of(timer, struct fuse_req, timer);
+
+	/*
+	 * Request reply is being finished by the kernel right now.
+	 * No need to time out the request.
+	 */
+	if (test_and_set_bit(FR_FINISHING, &req->flags))
+		return;
+
+	if (test_bit(FR_PENDING, &req->flags))
+		timeout_pending_req(req);
+	else
+		timeout_inflight_req(req);
+}
+
 static int queue_interrupt(struct fuse_req *req)
 {
 	struct fuse_iqueue *fiq = &req->fm->fc->iq;
@@ -393,6 +491,8 @@ static void request_wait_answer(struct fuse_req *req)
 		if (test_bit(FR_PENDING, &req->flags)) {
 			list_del(&req->list);
 			spin_unlock(&fiq->lock);
+			if (req->timer.function && !timer_delete_sync(&req->timer))
+				return;
 			__fuse_put_request(req);
 			req->out.h.error = -EINTR;
 			return;
@@ -409,7 +509,8 @@ static void request_wait_answer(struct fuse_req *req)
 
 static void __fuse_request_send(struct fuse_req *req)
 {
-	struct fuse_iqueue *fiq = &req->fm->fc->iq;
+	struct fuse_conn *fc = req->fm->fc;
+	struct fuse_iqueue *fiq = &fc->iq;
 
 	BUG_ON(test_bit(FR_BACKGROUND, &req->flags));
 	spin_lock(&fiq->lock);
@@ -421,6 +522,8 @@ static void __fuse_request_send(struct fuse_req *req)
 		/* acquire extra reference, since request is still needed
 		   after fuse_request_end() */
 		__fuse_get_request(req);
+		if (req->timer.function)
+			mod_timer(&req->timer, jiffies + fc->req_timeout);
 		queue_request_and_unlock(fiq, req);
 
 		request_wait_answer(req);
@@ -539,6 +642,8 @@ static bool fuse_request_queue_background(struct fuse_req *req)
 		if (fc->num_background == fc->max_background)
 			fc->blocked = 1;
 		list_add_tail(&req->list, &fc->bg_queue);
+		if (req->timer.function)
+			mod_timer(&req->timer, jiffies + fc->req_timeout);
 		flush_bg_queue(fc);
 		queued = true;
 	}
@@ -594,6 +699,8 @@ static int fuse_simple_notify_reply(struct fuse_mount *fm,
 
 	spin_lock(&fiq->lock);
 	if (fiq->connected) {
+		if (req->timer.function)
+			mod_timer(&req->timer, jiffies + fm->fc->req_timeout);
 		queue_request_and_unlock(fiq, req);
 	} else {
 		err = -ENODEV;
@@ -1268,8 +1375,26 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	req = list_entry(fiq->pending.next, struct fuse_req, list);
 	clear_bit(FR_PENDING, &req->flags);
 	list_del_init(&req->list);
+	/* Acquire a reference in case the timeout handler starts executing */
+	__fuse_get_request(req);
+	req->fpq = fpq;
 	spin_unlock(&fiq->lock);
 
+	if (req->timer.function) {
+		/*
+		 * Temporarily disable the timer on the request to avoid race
+		 * conditions between this code and the timeout handler.
+		 *
+		 * The timer is readded at the end of this function.
+		 */
+		if (!timer_delete_sync(&req->timer)) {
+			/* sanity check that the timer handler did run */
+			WARN_ON(!test_bit(FR_FINISHING, &req->flags));
+			fuse_put_request(req);
+			goto restart;
+		}
+	}
+
 	args = req->args;
 	reqsize = req->in.h.len;
 
@@ -1280,6 +1405,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 		if (args->opcode == FUSE_SETXATTR)
 			req->out.h.error = -E2BIG;
 		fuse_request_end(req);
+		fuse_put_request(req);
 		goto restart;
 	}
 	spin_lock(&fpq->lock);
@@ -1316,8 +1442,12 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	}
 	hash = fuse_req_hash(req->in.h.unique);
 	list_move_tail(&req->list, &fpq->processing[hash]);
-	__fuse_get_request(req);
 	set_bit(FR_SENT, &req->flags);
+
+	/* re-arm the original timer */
+	if (req->timer.function)
+		add_timer(&req->timer);
+
 	spin_unlock(&fpq->lock);
 	/* matches barrier in request_wait_answer() */
 	smp_mb__after_atomic();
@@ -1332,6 +1462,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 		list_del_init(&req->list);
 	spin_unlock(&fpq->lock);
 	fuse_request_end(req);
+	fuse_put_request(req);
 	return err;
 
  err_unlock:
@@ -1806,8 +1937,25 @@ static void fuse_resend(struct fuse_conn *fc)
 		struct fuse_pqueue *fpq = &fud->pq;
 
 		spin_lock(&fpq->lock);
-		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++)
+		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++) {
+			list_for_each_entry(req, &fpq->processing[i], list) {
+				/*
+				 * We must acquire a reference here in case the timeout
+				 * handler is running at the same time. Else the
+				 * request might get freed out from under us
+				 */
+				__fuse_get_request(req);
+
+				/*
+				 * While we have an acquired reference on the request,
+				 * the request must remain on the list so that we
+				 * can release the reference on it
+				 */
+				set_bit(FR_PRIVATE, &req->flags);
+			}
+
 			list_splice_tail_init(&fpq->processing[i], &to_queue);
+		}
 		spin_unlock(&fpq->lock);
 	}
 	spin_unlock(&fc->lock);
@@ -1820,6 +1968,12 @@ static void fuse_resend(struct fuse_conn *fc)
 	}
 
 	spin_lock(&fiq->lock);
+	list_for_each_entry_safe(req, next, &to_queue, list) {
+		if (test_bit(FR_FINISHING, &req->flags))
+			list_del_init(&req->list);
+		clear_bit(FR_PRIVATE, &req->flags);
+		fuse_put_request(req);
+	}
 	/* iq and pq requests are both oldest to newest */
 	list_splice(&to_queue, &fiq->pending);
 	fiq->ops->wake_pending_and_unlock(fiq);
@@ -1951,9 +2105,10 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 		goto copy_finish;
 	}
 
+	__fuse_get_request(req);
+
 	/* Is it an interrupt reply ID? */
 	if (oh.unique & FUSE_INT_REQ_BIT) {
-		__fuse_get_request(req);
 		spin_unlock(&fpq->lock);
 
 		err = 0;
@@ -1969,6 +2124,18 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 		goto copy_finish;
 	}
 
+	if (test_and_set_bit(FR_FINISHING, &req->flags)) {
+		/* timeout handler is already finishing the request */
+		spin_unlock(&fpq->lock);
+		fuse_put_request(req);
+		goto copy_finish;
+	}
+
+	/*
+	 * FR_FINISHING ensures the timeout handler will be a no-op if it runs,
+	 * but unset req->fpq here as an extra safeguard
+	 */
+	req->fpq = NULL;
 	clear_bit(FR_SENT, &req->flags);
 	list_move(&req->list, &fpq->io);
 	req->out.h = oh;
@@ -1995,6 +2162,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 	spin_unlock(&fpq->lock);
 
 	fuse_request_end(req);
+	fuse_put_request(req);
 out:
 	return err ? err : nbytes;
 
@@ -2260,13 +2428,21 @@ int fuse_dev_release(struct inode *inode, struct file *file)
 	if (fud) {
 		struct fuse_conn *fc = fud->fc;
 		struct fuse_pqueue *fpq = &fud->pq;
+		struct fuse_req *req;
 		LIST_HEAD(to_end);
 		unsigned int i;
 
 		spin_lock(&fpq->lock);
 		WARN_ON(!list_empty(&fpq->io));
-		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++)
+		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++) {
+			/*
+			 * Set the req error here so that the timeout
+			 * handler knows it's being released
+			 */
+			list_for_each_entry(req, &fpq->processing[i], list)
+				req->out.h.error = -ECONNABORTED;
 			list_splice_init(&fpq->processing[i], &to_end);
+		}
 		spin_unlock(&fpq->lock);
 
 		end_requests(&to_end);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f23919610313..0a2fa487a3bf 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -375,6 +375,8 @@ struct fuse_io_priv {
  * FR_FINISHED:		request is finished
  * FR_PRIVATE:		request is on private list
  * FR_ASYNC:		request is asynchronous
+ * FR_FINISHING:	request is being finished, by either the timeout handler
+ *			or the reply handler
  */
 enum fuse_req_flag {
 	FR_ISREPLY,
@@ -389,6 +391,7 @@ enum fuse_req_flag {
 	FR_FINISHED,
 	FR_PRIVATE,
 	FR_ASYNC,
+	FR_FINISHING,
 };
 
 /**
@@ -435,6 +438,12 @@ struct fuse_req {
 
 	/** fuse_mount this request belongs to */
 	struct fuse_mount *fm;
+
+	/** processing queue for the fuse_dev this request belongs to */
+	struct fuse_pqueue *fpq;
+
+	/** optional timer for request replies, if timeout is enabled */
+	struct timer_list timer;
 };
 
 struct fuse_iqueue;
@@ -574,6 +583,8 @@ struct fuse_fs_context {
 	enum fuse_dax_mode dax_mode;
 	unsigned int max_read;
 	unsigned int blksize;
+	/*  Request timeout (in seconds). 0 = no timeout (infinite wait) */
+	unsigned int req_timeout;
 	const char *subtype;
 
 	/* DAX device, may be NULL */
@@ -633,6 +644,9 @@ struct fuse_conn {
 	/** Constrain ->max_pages to this value during feature negotiation */
 	unsigned int max_pages_limit;
 
+	/* Request timeout (in jiffies). 0 = no timeout (infinite wait) */
+	unsigned long req_timeout;
+
 	/** Input queue */
 	struct fuse_iqueue iq;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 99e44ea7d875..9e69006fc026 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -733,6 +733,7 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
+	OPT_REQUEST_TIMEOUT,
 	OPT_ERR
 };
 
@@ -747,6 +748,7 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_u32	("max_read",		OPT_MAX_READ),
 	fsparam_u32	("blksize",		OPT_BLKSIZE),
 	fsparam_string	("subtype",		OPT_SUBTYPE),
+	fsparam_u32	("request_timeout",	OPT_REQUEST_TIMEOUT),
 	{}
 };
 
@@ -830,6 +832,10 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		ctx->blksize = result.uint_32;
 		break;
 
+	case OPT_REQUEST_TIMEOUT:
+		ctx->req_timeout = result.uint_32;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -1724,6 +1730,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->group_id = ctx->group_id;
 	fc->legacy_opts_show = ctx->legacy_opts_show;
 	fc->max_read = max_t(unsigned int, 4096, ctx->max_read);
+	fc->req_timeout = ctx->req_timeout * HZ;
 	fc->destroy = ctx->destroy;
 	fc->no_control = ctx->no_control;
 	fc->no_force_umount = ctx->no_force_umount;
-- 
2.43.5


