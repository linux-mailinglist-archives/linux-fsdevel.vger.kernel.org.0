Return-Path: <linux-fsdevel+bounces-31251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8BC993672
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 20:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29F91C22FD3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 18:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2354D1DE2D9;
	Mon,  7 Oct 2024 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDzVk+4f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8617F1DE2C4
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728326641; cv=none; b=NNDj7ZaPb3wP0x0+JNQ+LwNOl5UT9IgSuMkZRHd2dC91dol3Dlu6TEUAZS1oZ5OZA1TIrA+yYRI3MXxx0rP9qVvbJdOauaRLIw6u/MYsiOYosCcKXKe5Dfnn8ahi6UXfKjqnZEqdENAipdcIxjmvmjOYqMiEoCtUtImk2gfefxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728326641; c=relaxed/simple;
	bh=av+IQMsX+TvXaqZwih1O8bLY+jAsx/OMkUcQypMZNMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/bb06UH7R90O9x9qmCiarxzZHMt+rK6uUMT+GRf6aguoQJ4vXmwF0IZOtH6gPU0VzLEfSOxC8cK1B7QVlpTJeu9zk3wYOumIt9TCL+YHUBNOUFmyGu+ezBAb0hxwpioVHq/6I+dCAJZ5b8DSGVN2bvlIPNGQvxsGdBAf6KM9u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDzVk+4f; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6db20e22c85so37954787b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 11:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728326637; x=1728931437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0+O7egh7UtDFLTTKkW+l38cOJ903EtAPnpT5rGSPwk=;
        b=bDzVk+4fwnUdggiURJQy0b/4c8l4DbAgRgDBZcv084sQ7LbBCn2SMno1w2Pd3uQXjr
         IZF2kj1g3Lv7IHAo980JDv1o9gCd/8Fv9khiUrFZRS+2T1wxyGuduWnp09mPBiFpFxWA
         8LztP5HNGlACSOPWAGognqQ/OfP1LqzH+SuCG0oPMr8601ScWq1GVhBnSqa7KBrwkI1H
         s/Dfh+Rdx2XPjMjnDsZhIi+cCUL/hLoDa2wo+gAWThAEsENUyy0i5/59KSBB3BQnxNVi
         PDtjyDrCXZi8sXRSZbr3JRGYdlbcnD2jnvvsYvbWzHijOliENNECl0vrdHz9M/M05ho+
         kEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728326637; x=1728931437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0+O7egh7UtDFLTTKkW+l38cOJ903EtAPnpT5rGSPwk=;
        b=W+GMbDzlVGBOeqXTxmlGmunNaD9AAYVCifE9cFh9G/6iM8Jh1eiwOpj4Q6rZ/koVdc
         JZe/3OzuzPZsuu51zKzROFNFIb50rDi9snEJ7dUl03Ueq3PmbI35cWxFcI9x7TwopUb3
         exvThkEm9HSChVlyJXURnMlxIcZJS0Tq2rVt2iaL45Fve1mo9IgB/UhrI5hFmFrJ2Wni
         vjnNMkM/tuTZ3hrrF0R6lH1TI0LBTc7xdMNFYHnUPrV99IGdfzDqjHHxKMrEQ+btY+Yf
         zfzV6I6Ma1Oj/lTsYCHQ5S1d5SPcCKAoRDeoZuuDakkmMeAICjUTeJMkmnG/ih1SfcaY
         Mxng==
X-Forwarded-Encrypted: i=1; AJvYcCW+4AoiEfpI3yD6icuA06mpvF7kUpEmpCJBih9jGnW45kvBO5Hx8xWqTtO2CQN/joUQSECYUzsOTyueYm6E@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm/yqZJjk39qn5wjkW4Y7eLSpXB/lvcDc+M8Qsu1JPnCF4eMkC
	az2TrCAt+E/T2bEvUwuBtfjuK9wtlu++5PtGhVK+vyaAvcrGCzMw
X-Google-Smtp-Source: AGHT+IFbjrSudBqQV8k68F75iK1byl0RLJUGngtoehTpfSrhdL4FSW87hrVYTNCtIfPqA2/4t6+Adw==
X-Received: by 2002:a05:690c:385:b0:6e2:c4d8:cfe9 with SMTP id 00721157ae682-6e2c729665bmr116937277b3.34.1728326637438;
        Mon, 07 Oct 2024 11:43:57 -0700 (PDT)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d927f55csm11394657b3.47.2024.10.07.11.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 11:43:57 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v7 2/3] fuse: add optional kernel-enforced timeout for requests
Date: Mon,  7 Oct 2024 11:42:57 -0700
Message-ID: <20241007184258.2837492-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241007184258.2837492-1-joannelkoong@gmail.com>
References: <20241007184258.2837492-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are situations where fuse servers can become unresponsive or
stuck, for example if the server is deadlocked. Currently, there's no
good way to detect if a server is stuck and needs to be killed manually.

This commit adds an option for enforcing a timeout (in minutes) for
requests where if the timeout elapses without the server responding to
the request, the connection will be automatically aborted.

Please note that these timeouts are not 100% precise. The request may
take an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the set max timeout
due to how it's internally implemented.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c    | 63 +++++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h | 45 ++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c  | 22 +++++++++++++++++
 3 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1f64ae6d7a69..429c91c59e3a 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -45,14 +45,62 @@ static struct fuse_dev *fuse_get_dev(struct file *file)
 	return READ_ONCE(file->private_data);
 }
 
+void fuse_check_timeout(struct timer_list *timer)
+{
+	struct fuse_conn *fc = container_of(timer, struct fuse_conn, timeout.timer);
+	struct fuse_req *req;
+	bool expired = false;
+
+	spin_lock(&fc->timeout.lock);
+	req = list_first_entry_or_null(&fc->timeout.list, struct fuse_req,
+				       timer_entry);
+	if (req)
+		expired = jiffies > req->create_time + fc->timeout.req_timeout;
+	spin_unlock(&fc->timeout.lock);
+
+	/*
+	 * Don't rearm the timer if the list was empty in case the filesystem
+	 * is inactive. When the next request is sent, it'll rearm the timer.
+	 */
+	if (!req)
+		return;
+
+	if (expired)
+		fuse_abort_conn(fc);
+	else
+		mod_timer(&fc->timeout.timer, jiffies + FUSE_TIMEOUT_TIMER_FREQ);
+}
+
+static void add_req_timeout_entry(struct fuse_conn *fc, struct fuse_req *req)
+{
+	spin_lock(&fc->timeout.lock);
+	if (!timer_pending(&fc->timeout.timer))
+		mod_timer(&fc->timeout.timer, jiffies + FUSE_TIMEOUT_TIMER_FREQ);
+	list_add_tail(&req->timer_entry, &fc->timeout.list);
+	spin_unlock(&fc->timeout.lock);
+}
+
+static void remove_req_timeout_entry(struct fuse_conn *fc, struct fuse_req *req)
+{
+	spin_lock(&fc->timeout.lock);
+	list_del(&req->timer_entry);
+	spin_unlock(&fc->timeout.lock);
+}
+
 static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
 {
+	struct fuse_conn *fc = fm->fc;
+
 	INIT_LIST_HEAD(&req->list);
 	INIT_LIST_HEAD(&req->intr_entry);
 	init_waitqueue_head(&req->waitq);
 	refcount_set(&req->count, 1);
 	__set_bit(FR_PENDING, &req->flags);
 	req->fm = fm;
+	if (fc->timeout.req_timeout) {
+		INIT_LIST_HEAD(&req->timer_entry);
+		req->create_time = jiffies;
+	}
 }
 
 static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t flags)
@@ -359,6 +407,9 @@ void fuse_request_end(struct fuse_req *req)
 	if (test_and_set_bit(FR_FINISHED, &req->flags))
 		goto put_request;
 
+	if (fc->timeout.req_timeout)
+		remove_req_timeout_entry(fc, req);
+
 	trace_fuse_request_end(req);
 	/*
 	 * test_and_set_bit() implies smp_mb() between bit
@@ -450,6 +501,8 @@ static void request_wait_answer(struct fuse_req *req)
 		if (test_bit(FR_PENDING, &req->flags)) {
 			list_del(&req->list);
 			spin_unlock(&fiq->lock);
+			if (fc->timeout.req_timeout)
+				remove_req_timeout_entry(fc, req);
 			__fuse_put_request(req);
 			req->out.h.error = -EINTR;
 			return;
@@ -466,13 +519,16 @@ static void request_wait_answer(struct fuse_req *req)
 
 static void __fuse_request_send(struct fuse_req *req)
 {
-	struct fuse_iqueue *fiq = &req->fm->fc->iq;
+	struct fuse_conn *fc = req->fm->fc;
+	struct fuse_iqueue *fiq = &fc->iq;
 
 	BUG_ON(test_bit(FR_BACKGROUND, &req->flags));
 
 	/* acquire extra reference, since request is still needed after
 	   fuse_request_end() */
 	__fuse_get_request(req);
+	if (fc->timeout.req_timeout)
+		add_req_timeout_entry(fc, req);
 	fuse_send_one(fiq, req);
 
 	request_wait_answer(req);
@@ -598,6 +654,8 @@ static bool fuse_request_queue_background(struct fuse_req *req)
 		if (fc->num_background == fc->max_background)
 			fc->blocked = 1;
 		list_add_tail(&req->list, &fc->bg_queue);
+		if (fc->timeout.req_timeout)
+			add_req_timeout_entry(fc, req);
 		flush_bg_queue(fc);
 		queued = true;
 	}
@@ -2296,6 +2354,9 @@ void fuse_abort_conn(struct fuse_conn *fc)
 		spin_unlock(&fc->lock);
 
 		end_requests(&to_end);
+
+		if (fc->timeout.req_timeout)
+			timer_delete(&fc->timeout.timer);
 	} else {
 		spin_unlock(&fc->lock);
 	}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7ff00bae4a84..4c3998c28519 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -435,6 +435,16 @@ struct fuse_req {
 
 	/** fuse_mount this request belongs to */
 	struct fuse_mount *fm;
+
+	/*
+	 * These fields are only used if the connection enforces request
+	 * timeouts.
+	 *
+	 * timer_entry is the entry on the fuse connection's timeout list.
+	 * create_time (in jiffies) tracks when the request was created.
+	 */
+	struct list_head timer_entry;
+	unsigned long create_time;
 };
 
 struct fuse_iqueue;
@@ -525,6 +535,33 @@ struct fuse_pqueue {
 	struct list_head io;
 };
 
+/* Frequency (in seconds) of request timeout checks, if opted into */
+#define FUSE_TIMEOUT_TIMER_FREQ 60 * HZ
+
+/*
+ * If the connection enforces request timeouts, then all requests get
+ * added to the list when created and removed from the list when fulfilled by
+ * the server.
+ *
+ * The timer is triggered every FUSE_TIMEOUT_TIMER_FREQ seconds. It will
+ * check the head of the list for whether that request's start_time
+ * exceeds the timeout. If so, then the connection will be aborted.
+ *
+ * In the worst case, this guarantees that all requests will take
+ * the specified timeout + FUSE_TIMEOUT_TIMER_FREQ time to fulfill.
+ */
+struct fuse_timeout {
+	struct timer_list timer;
+
+	/* Request timeout (in jiffies). 0 = no timeout */
+	unsigned long req_timeout;
+
+	spinlock_t lock;
+
+	/* List of all requests that haven't been completed yet */
+	struct list_head list;
+};
+
 /**
  * Fuse device instance
  */
@@ -571,6 +608,8 @@ struct fuse_fs_context {
 	enum fuse_dax_mode dax_mode;
 	unsigned int max_read;
 	unsigned int blksize;
+	/*  Request timeout (in minutes). 0 = no timeout (infinite wait) */
+	unsigned int req_timeout;
 	const char *subtype;
 
 	/* DAX device, may be NULL */
@@ -914,6 +953,9 @@ struct fuse_conn {
 	/** IDR for backing files ids */
 	struct idr backing_files_map;
 #endif
+
+	/** Only used if the connection enforces request timeouts */
+	struct fuse_timeout timeout;
 };
 
 /*
@@ -1175,6 +1217,9 @@ void fuse_request_end(struct fuse_req *req);
 void fuse_abort_conn(struct fuse_conn *fc);
 void fuse_wait_aborted(struct fuse_conn *fc);
 
+/* Check if any requests timed out */
+void fuse_check_timeout(struct timer_list *timer);
+
 /**
  * Invalidate inode attributes
  */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index f1779ff3f8d1..e5c7a214a222 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -735,6 +735,7 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
+	OPT_REQUEST_TIMEOUT,
 	OPT_ERR
 };
 
@@ -749,6 +750,7 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_u32	("max_read",		OPT_MAX_READ),
 	fsparam_u32	("blksize",		OPT_BLKSIZE),
 	fsparam_string	("subtype",		OPT_SUBTYPE),
+	fsparam_u16	("request_timeout",	OPT_REQUEST_TIMEOUT),
 	{}
 };
 
@@ -844,6 +846,10 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		ctx->blksize = result.uint_32;
 		break;
 
+	case OPT_REQUEST_TIMEOUT:
+		ctx->req_timeout = result.uint_16;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -973,6 +979,8 @@ void fuse_conn_put(struct fuse_conn *fc)
 
 		if (IS_ENABLED(CONFIG_FUSE_DAX))
 			fuse_dax_conn_free(fc);
+		if (fc->timeout.req_timeout)
+			timer_delete_sync(&fc->timeout.timer);
 		if (fiq->ops->release)
 			fiq->ops->release(fiq);
 		put_pid_ns(fc->pid_ns);
@@ -1691,6 +1699,19 @@ int fuse_init_fs_context_submount(struct fs_context *fsc)
 }
 EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount);
 
+static void fuse_init_fc_timeout(struct fuse_conn *fc, struct fuse_fs_context *ctx)
+{
+	if (ctx->req_timeout) {
+		if (check_mul_overflow(ctx->req_timeout * 60, HZ, &fc->timeout.req_timeout))
+			fc->timeout.req_timeout = U32_MAX;
+		INIT_LIST_HEAD(&fc->timeout.list);
+		spin_lock_init(&fc->timeout.lock);
+		timer_setup(&fc->timeout.timer, fuse_check_timeout, 0);
+	} else {
+		fc->timeout.req_timeout = 0;
+	}
+}
+
 int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 {
 	struct fuse_dev *fud = NULL;
@@ -1753,6 +1774,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->destroy = ctx->destroy;
 	fc->no_control = ctx->no_control;
 	fc->no_force_umount = ctx->no_force_umount;
+	fuse_init_fc_timeout(fc, ctx);
 
 	err = -ENOMEM;
 	root = fuse_get_root_inode(sb, ctx->rootmode);
-- 
2.43.5


