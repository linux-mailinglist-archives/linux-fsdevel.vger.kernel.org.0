Return-Path: <linux-fsdevel+bounces-37402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FA89F1C19
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 03:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53F4188EBAE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 02:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FCB18AE2;
	Sat, 14 Dec 2024 02:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQ+tUSVa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF3914293
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Dec 2024 02:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734143380; cv=none; b=Lcqy56o3J6XKeZGm7yIXhXBp4XzPpRtyUVEXA13i8GeaBXpPYQh4gg2zU08qYo+bBY26kwTMbDKV4bdBFLeJKxeEL6kXYQiKUaB+k7XCZWfiDqsYeAR127tpdshRYYFaW1FerUWlDSNsOrYPBOXD7J2Y8FLUnksSIGU88KbkU3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734143380; c=relaxed/simple;
	bh=Bw8XMU34rli4sVYvvVYYhVfMRg2/nyHLJAupVAxA9ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fhum3S4Dl3IQTCztuiHIEOG5M0oxV6t0cPmQkPBsBZCkBRjXv3hqm85XXfVBDLRcWqOXqCxFt47oKDqSJcqOPqbre8JuNhoteYflgvlyqOKy6ar1BZhN7J1qYKq4JQH8fYb0/LVZXkuPlcqiHCYegRiv+sloE5KA4llfzY/l+Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQ+tUSVa; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ef7640e484so26619647b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 18:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734143377; x=1734748177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlH8voEEB3BIw+mQ9j2+09tcx57P8fjAPn8zUtRLH6g=;
        b=GQ+tUSVaMd4OS2YN2NUcMdt+gBZyL6GpBY2yFXLQoXorbHHS/ENiWJojwkyp1PDJnB
         +xOz0nowq3I9hHXE2q15yDfzOTl/QimpXluqsKMvPAHrlZQKEAlrV6S6qRHihe5J/Vg5
         jRtay+KF/xiXhip7+RbBBrbRwZT3YiLrxbcH5yxZk1HzrDnK+Grp2px5B6OG4sH95Pdx
         e9XUd7BL9fsxz8W3aUqHNJefr2z4UEW+PxN8PrPORaT1jX7nLWLx0ro9xYp/1SIcxdX0
         nOF1zutni/ENvofY8odBMsgnOt9zBEdqzHVix5z6bwvgZ1H0UYomhgHDiPb9DJ1kPJdb
         7D0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734143377; x=1734748177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QlH8voEEB3BIw+mQ9j2+09tcx57P8fjAPn8zUtRLH6g=;
        b=scsVQvJmWrVbvTyZij7J1XhhDUvIfPg9z4SnwAiNyuj++CjxgnWR4R4OKHlF31HK2A
         EEo73JlnjKWIAlLSXGIWF+/OntX3vxNz/RKczQAjy7EVyORUg7CCbx7Xk/tNruAyMf/C
         wgJiuaoWoQNXsxoFO17TVhCeUYv0wZGZVMmmrXMLrsG5F5wr9uxOdJ8BkcMKs3CmINZc
         T0S2CmTvwnJ+Hcgfc2fedlcIarL37JtssyxR/rHEwo9wdlc1GVLb8B4C86M4YxrDxLDJ
         Utj6u62lZdSXIFWfRHMUBGFP+O/y7bEMq96eh+80OXgviyklKz3z2yiFt73O4H+WyxSt
         CB6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVekLm6gD7Cj0cwPO2riUgndy0+MdOL/SJemW9NA7eV/dqxcjz2zfqzD6/oYYgOMgDScn0s1eQfkwAnCUBE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb98XMvOcLCQ4UO9eBhYfp0LSN5AtZQlTiLKWfkRSu1vGp097Q
	BBrKGpgf+lFpxabHu3gXaQclZ8KaO1bY5qXgRKhoOQNcMhOlI/8S
X-Gm-Gg: ASbGnct2kM6IWj0zW0gWNtmbArnQrgWlR4as6ArYtXEjt+J0D/1YRc2g+cMMH/wYVRU
	5czVDtWXVtPzH2DgpMlL7CmkChkQEqPwxNsB9y3EXGEQ81wm6wXGJKUkoURSMrAWeI284OY/Bu9
	JWtH/QmlhuO0AgbygfvmRr7Btb7+YQrjiN/LZZCLy535HyoA3EPBHMR5fT2YVAuPWSnVzeHq7WP
	7GjMcCaBPkcodkBLVX1AIb+6uzZDCoZQvWBUceTlNLeDB57GG6IfNdZ3sqXPdWYDmNkBE4QFKyM
	Iu0s+P8Hvl8lcj0=
X-Google-Smtp-Source: AGHT+IGMCN1Z1t1V02jorXKKwMA/neLOi2h9z11Nk9zVz6TVhko6pIsXoFPDV7O9Yu94W0pqxJqDbA==
X-Received: by 2002:a05:690c:660c:b0:6e5:bf26:578 with SMTP id 00721157ae682-6f279af810emr48630617b3.17.1734143377097;
        Fri, 13 Dec 2024 18:29:37 -0800 (PST)
Received: from localhost (fwdproxy-nha-011.fbsv.net. [2a03:2880:25ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f2891eef96sm2079487b3.108.2024.12.13.18.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 18:29:36 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	jlayton@kernel.org,
	senozhatsky@chromium.org,
	tfiga@chromium.org,
	bgeffon@google.com,
	etmartin4313@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v10 1/2] fuse: add kernel-enforced timeout option for requests
Date: Fri, 13 Dec 2024 18:28:26 -0800
Message-ID: <20241214022827.1773071-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241214022827.1773071-1-joannelkoong@gmail.com>
References: <20241214022827.1773071-1-joannelkoong@gmail.com>
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

This commit adds an option for enforcing a timeout (in seconds) for
requests where if the timeout elapses without the server responding to
the request, the connection will be automatically aborted.

Please note that these timeouts are not 100% precise. For example, the
request may take roughly an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond
the requested timeout due to internal implementation, in order to
mitigate overhead.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c    | 83 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h | 22 +++++++++++++
 fs/fuse/inode.c  | 23 ++++++++++++++
 3 files changed, 128 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 27ccae63495d..e97ba860ffcd 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -45,6 +45,85 @@ static struct fuse_dev *fuse_get_dev(struct file *file)
 	return READ_ONCE(file->private_data);
 }
 
+static bool request_expired(struct fuse_conn *fc, struct fuse_req *req)
+{
+	return time_is_before_jiffies(req->create_time + fc->timeout.req_timeout);
+}
+
+/*
+ * Check if any requests aren't being completed by the time the request timeout
+ * elapses. To do so, we:
+ * - check the fiq pending list
+ * - check the bg queue
+ * - check the fpq io and processing lists
+ *
+ * To make this fast, we only check against the head request on each list since
+ * these are generally queued in order of creation time (eg newer requests get
+ * queued to the tail). We might miss a few edge cases (eg requests transitioning
+ * between lists, re-sent requests at the head of the pending list having a
+ * later creation time than other requests on that list, etc.) but that is fine
+ * since if the request never gets fulfilled, it will eventually be caught.
+ */
+void fuse_check_timeout(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct fuse_conn *fc = container_of(dwork, struct fuse_conn,
+					    timeout.work);
+	struct fuse_iqueue *fiq = &fc->iq;
+	struct fuse_req *req;
+	struct fuse_dev *fud;
+	struct fuse_pqueue *fpq;
+	bool expired = false;
+	int i;
+
+	spin_lock(&fiq->lock);
+	req = list_first_entry_or_null(&fiq->pending, struct fuse_req, list);
+	if (req)
+		expired = request_expired(fc, req);
+	spin_unlock(&fiq->lock);
+	if (expired)
+		goto abort_conn;
+
+	spin_lock(&fc->bg_lock);
+	req = list_first_entry_or_null(&fc->bg_queue, struct fuse_req, list);
+	if (req)
+		expired = request_expired(fc, req);
+	spin_unlock(&fc->bg_lock);
+	if (expired)
+		goto abort_conn;
+
+	spin_lock(&fc->lock);
+	if (!fc->connected) {
+		spin_unlock(&fc->lock);
+		return;
+	}
+	list_for_each_entry(fud, &fc->devices, entry) {
+		fpq = &fud->pq;
+		spin_lock(&fpq->lock);
+		req = list_first_entry_or_null(&fpq->io, struct fuse_req, list);
+		if (req && request_expired(fc, req))
+			goto fpq_abort;
+
+		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++) {
+			req = list_first_entry_or_null(&fpq->processing[i], struct fuse_req, list);
+			if (req && request_expired(fc, req))
+				goto fpq_abort;
+		}
+		spin_unlock(&fpq->lock);
+	}
+	spin_unlock(&fc->lock);
+
+	queue_delayed_work(system_wq, &fc->timeout.work,
+			   secs_to_jiffies(FUSE_TIMEOUT_TIMER_FREQ));
+	return;
+
+fpq_abort:
+	spin_unlock(&fpq->lock);
+	spin_unlock(&fc->lock);
+abort_conn:
+	fuse_abort_conn(fc);
+}
+
 static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
 {
 	INIT_LIST_HEAD(&req->list);
@@ -53,6 +132,7 @@ static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
 	refcount_set(&req->count, 1);
 	__set_bit(FR_PENDING, &req->flags);
 	req->fm = fm;
+	req->create_time = jiffies;
 }
 
 static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t flags)
@@ -2308,6 +2388,9 @@ void fuse_abort_conn(struct fuse_conn *fc)
 		spin_unlock(&fc->lock);
 
 		end_requests(&to_end);
+
+		if (fc->timeout.req_timeout)
+			cancel_delayed_work(&fc->timeout.work);
 	} else {
 		spin_unlock(&fc->lock);
 	}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 74744c6f2860..26eb00e5f043 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -438,6 +438,9 @@ struct fuse_req {
 
 	/** fuse_mount this request belongs to */
 	struct fuse_mount *fm;
+
+	/** When (in jiffies) the request was created */
+	unsigned long create_time;
 };
 
 struct fuse_iqueue;
@@ -528,6 +531,17 @@ struct fuse_pqueue {
 	struct list_head io;
 };
 
+/* Frequency (in seconds) of request timeout checks, if opted into */
+#define FUSE_TIMEOUT_TIMER_FREQ 15
+
+struct fuse_timeout {
+	/* Worker for checking if any requests have timed out */
+	struct delayed_work work;
+
+	/* Request timeout (in jiffies). 0 = no timeout */
+	unsigned long req_timeout;
+};
+
 /**
  * Fuse device instance
  */
@@ -574,6 +588,8 @@ struct fuse_fs_context {
 	enum fuse_dax_mode dax_mode;
 	unsigned int max_read;
 	unsigned int blksize;
+	/*  Request timeout (in seconds). 0 = no timeout (infinite wait) */
+	unsigned int req_timeout;
 	const char *subtype;
 
 	/* DAX device, may be NULL */
@@ -923,6 +939,9 @@ struct fuse_conn {
 	/** IDR for backing files ids */
 	struct idr backing_files_map;
 #endif
+
+	/** Only used if the connection enforces request timeouts */
+	struct fuse_timeout timeout;
 };
 
 /*
@@ -1191,6 +1210,9 @@ void fuse_request_end(struct fuse_req *req);
 void fuse_abort_conn(struct fuse_conn *fc);
 void fuse_wait_aborted(struct fuse_conn *fc);
 
+/* Check if any requests timed out */
+void fuse_check_timeout(struct work_struct *work);
+
 /**
  * Invalidate inode attributes
  */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 3ce4f4e81d09..02dac88d922e 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -765,6 +765,7 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
+	OPT_REQUEST_TIMEOUT,
 	OPT_ERR
 };
 
@@ -779,6 +780,7 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_u32	("max_read",		OPT_MAX_READ),
 	fsparam_u32	("blksize",		OPT_BLKSIZE),
 	fsparam_string	("subtype",		OPT_SUBTYPE),
+	fsparam_u32	("request_timeout",	OPT_REQUEST_TIMEOUT),
 	{}
 };
 
@@ -874,6 +876,10 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		ctx->blksize = result.uint_32;
 		break;
 
+	case OPT_REQUEST_TIMEOUT:
+		ctx->req_timeout = result.uint_32;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -1004,6 +1010,8 @@ void fuse_conn_put(struct fuse_conn *fc)
 
 		if (IS_ENABLED(CONFIG_FUSE_DAX))
 			fuse_dax_conn_free(fc);
+		if (fc->timeout.req_timeout)
+			cancel_delayed_work_sync(&fc->timeout.work);
 		if (fiq->ops->release)
 			fiq->ops->release(fiq);
 		put_pid_ns(fc->pid_ns);
@@ -1723,6 +1731,20 @@ int fuse_init_fs_context_submount(struct fs_context *fsc)
 }
 EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount);
 
+static void fuse_init_fc_timeout(struct fuse_conn *fc, struct fuse_fs_context *ctx)
+{
+	if (ctx->req_timeout) {
+		if (check_mul_overflow(ctx->req_timeout, HZ, &fc->timeout.req_timeout))
+			fc->timeout.req_timeout = ULONG_MAX;
+
+		INIT_DELAYED_WORK(&fc->timeout.work, fuse_check_timeout);
+		queue_delayed_work(system_wq, &fc->timeout.work,
+				   secs_to_jiffies(FUSE_TIMEOUT_TIMER_FREQ));
+	} else {
+		fc->timeout.req_timeout = 0;
+	}
+}
+
 int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 {
 	struct fuse_dev *fud = NULL;
@@ -1785,6 +1807,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->destroy = ctx->destroy;
 	fc->no_control = ctx->no_control;
 	fc->no_force_umount = ctx->no_force_umount;
+	fuse_init_fc_timeout(fc, ctx);
 
 	err = -ENOMEM;
 	root = fuse_get_root_inode(sb, ctx->rootmode);
-- 
2.43.5


