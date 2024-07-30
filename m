Return-Path: <linux-fsdevel+bounces-24525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C747D940236
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 02:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323A01F21D61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 00:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29D0BE65;
	Tue, 30 Jul 2024 00:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBf4+Ior"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC259473
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 00:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299343; cv=none; b=e6+F86byc0YsclYFfYAUXbrRmZWkZbmIrA+LAiJSu7ZWsiJHfBH+N558UZzfCHRGw4P1Qcm2VVD9ylmyNBv7vUCjf5GOUC34ph4I8XMcOZX20upTOa1NyQe2Ig3lCGNfmviXpMUk4eU+pKYoP+PEDsuqITLANCtTA03HsmxvMZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299343; c=relaxed/simple;
	bh=3DEJn6Y/f5GxQYqouPfEtXD9BcO/Puwj1BkkLjYHCfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QE22iY86fglhVTHr/fziGqVU8zkSaAn72lEt/7Ax9RzBMU7X+C+VX+62jz9gzxy9aVN9lXUkQQGBJHSm7w3Kti8PrOJxKz+x8nZVc5w49qZFbFWhPp6UfSDPW3/OZr3a3pShJJ0MWSn+MLzJm9h/BF2YOvuaEignFb4AHuxipX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBf4+Ior; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6510c0c8e29so25698117b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 17:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722299340; x=1722904140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWW8vnFgbjbPueIbnRnNotWeygdUGCPaZVz0R/5CmOo=;
        b=NBf4+IornUvFbKtqCVAgiqK53Zw1VGX57PmBUCnM8uZzg7cbjKYluy16Rd6KKasoCR
         y0AYJNPuyN55Eclwn9cQ0kleTK0oz6UFpxt+9uU2GR8xeA37ux/5595UI9Uf/oEi9ai0
         1PbbYvfwXuWjDUxOETctduyD4HikK+NOQ1mhqcFsZHkpveOaVW28UUj2RchjtdVI7rUA
         OhmZlyTEW3sE5u4k16rlZFrpI5TzfD6/xwO5wNdjP6IxUpYdG09tDzAn1Yj+wB3B8nqU
         hvH3x3l6vtjVxddO3FJ/fNNZOJk3idoyC7k0gd9TFZt9PCRryBwRg/7yA/Zo4MrwkVGu
         Ze9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722299340; x=1722904140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWW8vnFgbjbPueIbnRnNotWeygdUGCPaZVz0R/5CmOo=;
        b=f1ajVx42HRja5ENEKSVHQ6q6D7wpuXs8qls9mg4GWfNKJmLVJMAmN0w5p2xWtraNQw
         hyOd5lCuhyncBnAZmNK/iNfkr48cbNziUe5OA6pj1uAzat4sA7PV4geFK+izjGMtP3A5
         oXTDROaIN7d6tsixije97rn35ijNsYuIBbaXBPvviJ7zwk87NjqQyB3ZTAJX9B8kp0gG
         EWCSb7eZoV9GVCVujFcpQRJo0asFeCW1or1BTJCMkB9XqlwORblx3/I+DGhuJh2On9Oq
         h8wOmqzrsoESkOaE7ijuGVZi+FnLvfGvR7O1j4PJZpx1y+xg0gb0/M4HxLqXOjeCMZ0U
         0nPw==
X-Forwarded-Encrypted: i=1; AJvYcCUGpiPxJNfw7h/vLrnawZSEAvmG0AcKQLiKaEeYLGMrqXZ3cKMIzwe6aaG0XvFgJgGE3IjveGfyV2DNr3Boy8hkQ8cT/qNoZItcHgSjTg==
X-Gm-Message-State: AOJu0Yy8sUb+vkU3rTZE7yP+aR6kcSwbAijyEQwApHX7zhfsvxp9P/lC
	T6t5KQ075NrsSwjfEg3u7PC6jxvd6lzWPQTBM3qmA1jeAwKx5DPK
X-Google-Smtp-Source: AGHT+IFHjeC8G46pvEUh+4QeqnCMGoRI+QgrO0RsL/HWLfjqCvtqYOBnY4v6S/dcPPu5VOJ0O/gXhw==
X-Received: by 2002:a81:82c5:0:b0:646:3ef4:6ace with SMTP id 00721157ae682-67a07987836mr116780317b3.24.1722299340055;
        Mon, 29 Jul 2024 17:29:00 -0700 (PDT)
Received: from localhost (fwdproxy-nha-112.fbsv.net. [2a03:2880:25ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67567a537f8sm23260117b3.56.2024.07.29.17.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 17:28:59 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	laoar.shao@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v2 1/2] fuse: add optional kernel-enforced timeout for requests
Date: Mon, 29 Jul 2024 17:23:47 -0700
Message-ID: <20240730002348.3431931-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730002348.3431931-1-joannelkoong@gmail.com>
References: <20240730002348.3431931-1-joannelkoong@gmail.com>
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
 fs/fuse/dev.c    | 187 +++++++++++++++++++++++++++++++++++++++++++++--
 fs/fuse/fuse_i.h |  14 ++++
 fs/fuse/inode.c  |   7 ++
 3 files changed, 200 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9eb191b5c4de..9992bc5f4469 100644
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
@@ -277,12 +281,15 @@ static void flush_bg_queue(struct fuse_conn *fc)
  * the 'end' callback is called if given, else the reference to the
  * request is released
  */
-void fuse_request_end(struct fuse_req *req)
+static void do_fuse_request_end(struct fuse_req *req, bool from_timer_callback)
 {
 	struct fuse_mount *fm = req->fm;
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_iqueue *fiq = &fc->iq;
 
+	if (from_timer_callback)
+		req->out.h.error = -ETIME;
+
 	if (test_and_set_bit(FR_FINISHED, &req->flags))
 		goto put_request;
 
@@ -296,8 +303,6 @@ void fuse_request_end(struct fuse_req *req)
 		list_del_init(&req->intr_entry);
 		spin_unlock(&fiq->lock);
 	}
-	WARN_ON(test_bit(FR_PENDING, &req->flags));
-	WARN_ON(test_bit(FR_SENT, &req->flags));
 	if (test_bit(FR_BACKGROUND, &req->flags)) {
 		spin_lock(&fc->bg_lock);
 		clear_bit(FR_BACKGROUND, &req->flags);
@@ -324,13 +329,105 @@ void fuse_request_end(struct fuse_req *req)
 		wake_up(&req->waitq);
 	}
 
+	if (!from_timer_callback && req->timer.function)
+		timer_delete_sync(&req->timer);
+
 	if (test_bit(FR_ASYNC, &req->flags))
 		req->args->end(fm, req->args, req->out.h.error);
 put_request:
 	fuse_put_request(req);
 }
+
+void fuse_request_end(struct fuse_req *req)
+{
+	WARN_ON(test_bit(FR_PENDING, &req->flags));
+	WARN_ON(test_bit(FR_SENT, &req->flags));
+
+	do_fuse_request_end(req, false);
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
+	do_fuse_request_end(req, true);
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
+	do_fuse_request_end(req, true);
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
@@ -409,7 +506,8 @@ static void request_wait_answer(struct fuse_req *req)
 
 static void __fuse_request_send(struct fuse_req *req)
 {
-	struct fuse_iqueue *fiq = &req->fm->fc->iq;
+	struct fuse_conn *fc = req->fm->fc;
+	struct fuse_iqueue *fiq = &fc->iq;
 
 	BUG_ON(test_bit(FR_BACKGROUND, &req->flags));
 	spin_lock(&fiq->lock);
@@ -421,6 +519,10 @@ static void __fuse_request_send(struct fuse_req *req)
 		/* acquire extra reference, since request is still needed
 		   after fuse_request_end() */
 		__fuse_get_request(req);
+		if (req->timer.function) {
+			req->timer.expires = jiffies + fc->req_timeout;
+			add_timer(&req->timer);
+		}
 		queue_request_and_unlock(fiq, req);
 
 		request_wait_answer(req);
@@ -539,6 +641,10 @@ static bool fuse_request_queue_background(struct fuse_req *req)
 		if (fc->num_background == fc->max_background)
 			fc->blocked = 1;
 		list_add_tail(&req->list, &fc->bg_queue);
+		if (req->timer.function) {
+			req->timer.expires = jiffies + fc->req_timeout;
+			add_timer(&req->timer);
+		}
 		flush_bg_queue(fc);
 		queued = true;
 	}
@@ -1268,6 +1374,9 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	req = list_entry(fiq->pending.next, struct fuse_req, list);
 	clear_bit(FR_PENDING, &req->flags);
 	list_del_init(&req->list);
+	/* Acquire a reference in case the timeout handler starts executing */
+	__fuse_get_request(req);
+	req->fpq = fpq;
 	spin_unlock(&fiq->lock);
 
 	args = req->args;
@@ -1280,6 +1389,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 		if (args->opcode == FUSE_SETXATTR)
 			req->out.h.error = -E2BIG;
 		fuse_request_end(req);
+		fuse_put_request(req);
 		goto restart;
 	}
 	spin_lock(&fpq->lock);
@@ -1316,13 +1426,33 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	}
 	hash = fuse_req_hash(req->in.h.unique);
 	list_move_tail(&req->list, &fpq->processing[hash]);
-	__fuse_get_request(req);
 	set_bit(FR_SENT, &req->flags);
 	spin_unlock(&fpq->lock);
 	/* matches barrier in request_wait_answer() */
 	smp_mb__after_atomic();
 	if (test_bit(FR_INTERRUPTED, &req->flags))
 		queue_interrupt(req);
+
+	/*
+	 * Check if the timeout handler is running / ran. If it did, we need to
+	 * remove the request from any lists in case the timeout handler finished
+	 * before dev_do_read moved the request to the processing list.
+	 *
+	 * Check FR_SENT to distinguish whether the timeout or the write handler
+	 * is finishing the request. However, there can be the case where the
+	 * timeout handler and resend handler are running concurrently, so we
+	 * need to also check the FR_PENDING bit.
+	 */
+	if (test_bit(FR_FINISHING, &req->flags) &&
+	    (test_bit(FR_SENT, &req->flags) || test_bit(FR_PENDING, &req->flags))) {
+		spin_lock(&fpq->lock);
+		if (!test_bit(FR_PRIVATE, &req->flags))
+			list_del_init(&req->list);
+		spin_unlock(&fpq->lock);
+		fuse_put_request(req);
+		return -ETIME;
+	}
+
 	fuse_put_request(req);
 
 	return reqsize;
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
@@ -1969,6 +2124,13 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 		goto copy_finish;
 	}
 
+	if (test_and_set_bit(FR_FINISHING, &req->flags)) {
+		/* timeout handler is already finishing the request */
+		spin_unlock(&fpq->lock);
+		fuse_put_request(req);
+		goto copy_finish;
+	}
+
 	clear_bit(FR_SENT, &req->flags);
 	list_move(&req->list, &fpq->io);
 	req->out.h = oh;
@@ -1995,6 +2157,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 	spin_unlock(&fpq->lock);
 
 	fuse_request_end(req);
+	fuse_put_request(req);
 out:
 	return err ? err : nbytes;
 
@@ -2260,13 +2423,21 @@ int fuse_dev_release(struct inode *inode, struct file *file)
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
index f23919610313..2b616c5977b4 100644
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
+	/** page queue this request has been added to */
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
2.43.0


