Return-Path: <linux-fsdevel+bounces-34840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB46B9C924D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 20:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB121F23D11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 19:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990121ABEC1;
	Thu, 14 Nov 2024 19:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdvkvxMB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6251ABEA1
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 19:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731611636; cv=none; b=j3HZW90JW00b4MSZzY1DNXaUr81+Ihrb5CUibR/Qv6VCBkS5EGsfyqVMMrrYQkL742t3KZplxXFZtezgpZSI0fGKqjOL1DSBzsvivKpYzyTGpZYY7tf2sh5mVxpI7blrchauYftlqkOBc7pUob9ODgvHw1+lzOWELm/FSCSIYww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731611636; c=relaxed/simple;
	bh=0SuE55RkA5E+LBqO8lUOgOZPPlh2syIt9/gaYS9uTCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EV9d4s7QkiGQ6P7/Toy2ZQa4s+Y+9eSjphfJ/G5CUEqoaxR9DoAt8lkbidORR0wlPCnNKHordzUuLKTWHs+O1cgk0Z1/zHRBnOobTGb8Dx8Luz/HF7svdrswe/wjPxOoHTqNFtljGQ5vPoTXsVofpY0rIia4pRM23UziK41P2PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdvkvxMB; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ea85f7f445so10654587b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 11:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731611633; x=1732216433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Zj6VQ5V5mAxCWloUS8Kj9By1xu0Ish6ebhkeGJjc8Y=;
        b=gdvkvxMB6wGilPUCm0FCbqW1L8ThLk6gE1rNZm7vxy1UhESrvTS9Y5oomrd3uKlgtO
         BvyHCaa7eCu3u5eWLi0LeSWv8ZuPRJDeMa77crpvtFxN//KI0906z1VgHnYaDJfGnXfI
         nJr3cIThYuaPE8HjvhcMGDJnwuU+Wy0437dCGEOIryAQcFNaXzu/2vPlwvTOJCMOF+jF
         d4q2ki0CJmjnPv+AM1IQlfwjEb0cqF0SjRkMa3K4RDqWpSvCYXnv0Kf1B5ExN/RlM+YR
         fzZjXw7gOy/w6jUT4E5QKD4aeu3/dmAhl18lcUJfmyRTY+6Hqn7RfwNLz+e6vGqUvwRU
         z92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731611633; x=1732216433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Zj6VQ5V5mAxCWloUS8Kj9By1xu0Ish6ebhkeGJjc8Y=;
        b=AmS/dAecckJJpIXkHaEKsDDkwIRhnlLQSvPBevtRMmccJ/x2JiwahhFIpVLLPGHSum
         K8nxarFeCdKuL4Ac/1EmOLebDo3pHfWbx5megMcSYM6ozipJ89+c8BIquIHLEhfwXofA
         Jy7/hyy2vv4bbZg5j6WMOHfktUv/+w+yZEYJAC4fjXHrn9YVRcMGRKys1+X9GlGmgQSm
         COrAva5S8alrvrnDGbbVzs1/4NdftAPEiuZG1vL8ntPY3Sj/fU/6SGtL4MIZNJT2XURa
         R1rmmV5awUJqdp+1bBX/izYL6AaiYZHGuA7U/MfGhvN3bN4ZhsFWbEif6dlriVVpzwUy
         5JuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq4/rJsbgGKW9qP24qcBkySUrXeYC8ZaUMEo5WvioEJc0iDU4fSWZmyB4rCKzQqlZ7tv6UkTAtrhtM3MCD@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ozIPNftMNhwe6FYGwHgGap9dgFtJ+kcLL5DjXGT7RRiEF2ai
	fqwntdT0n9wjtzeWHjAmFGrL0UY2eT0uGK5mnPIxrm5bwuNDdN94
X-Google-Smtp-Source: AGHT+IFBHLU86BSfd7LJgLZfK7Hn2l3e+pIEtRJv1E95vcChba7dS26qufPWYDyt70sp4IHD/yTDMg==
X-Received: by 2002:a05:690c:6705:b0:6ee:5158:5909 with SMTP id 00721157ae682-6ee55a3b337mr721017b3.4.1731611633082;
        Thu, 14 Nov 2024 11:13:53 -0800 (PST)
Received: from localhost (fwdproxy-nha-001.fbsv.net. [2a03:2880:25ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee44412699sm3797817b3.83.2024.11.14.11.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:13:52 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	kernel-team@meta.com,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout for requests
Date: Thu, 14 Nov 2024 11:13:31 -0800
Message-ID: <20241114191332.669127-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241114191332.669127-1-joannelkoong@gmail.com>
References: <20241114191332.669127-1-joannelkoong@gmail.com>
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
take an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the requested max
timeout due to how it's internally implemented.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c    | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h | 21 +++++++++++++
 fs/fuse/inode.c  | 21 +++++++++++++
 3 files changed, 122 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 29fc61a072ba..536aa4525e8f 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -45,6 +45,82 @@ static struct fuse_dev *fuse_get_dev(struct file *file)
 	return READ_ONCE(file->private_data);
 }
 
+static bool request_expired(struct fuse_conn *fc, struct fuse_req *req)
+{
+	return jiffies > req->create_time + fc->timeout.req_timeout;
+}
+
+/*
+ * Check if any requests aren't being completed by the specified request
+ * timeout. To do so, we:
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
+void fuse_check_timeout(struct timer_list *timer)
+{
+	struct fuse_conn *fc = container_of(timer, struct fuse_conn, timeout.timer);
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
+	mod_timer(&fc->timeout.timer, jiffies + FUSE_TIMEOUT_TIMER_FREQ);
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
@@ -53,6 +129,7 @@ static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
 	refcount_set(&req->count, 1);
 	__set_bit(FR_PENDING, &req->flags);
 	req->fm = fm;
+	req->create_time = jiffies;
 }
 
 static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t flags)
@@ -2308,6 +2385,9 @@ void fuse_abort_conn(struct fuse_conn *fc)
 		spin_unlock(&fc->lock);
 
 		end_requests(&to_end);
+
+		if (fc->timeout.req_timeout)
+			timer_delete(&fc->timeout.timer);
 	} else {
 		spin_unlock(&fc->lock);
 	}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d35c37ccf9b5..9092201c4e0b 100644
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
@@ -528,6 +531,16 @@ struct fuse_pqueue {
 	struct list_head io;
 };
 
+/* Frequency (in seconds) of request timeout checks, if opted into */
+#define FUSE_TIMEOUT_TIMER_FREQ 60 * HZ
+
+struct fuse_timeout {
+	struct timer_list timer;
+
+	/* Request timeout (in jiffies). 0 = no timeout */
+	unsigned long req_timeout;
+};
+
 /**
  * Fuse device instance
  */
@@ -574,6 +587,8 @@ struct fuse_fs_context {
 	enum fuse_dax_mode dax_mode;
 	unsigned int max_read;
 	unsigned int blksize;
+	/*  Request timeout (in minutes). 0 = no timeout (infinite wait) */
+	unsigned int req_timeout;
 	const char *subtype;
 
 	/* DAX device, may be NULL */
@@ -920,6 +935,9 @@ struct fuse_conn {
 	/** IDR for backing files ids */
 	struct idr backing_files_map;
 #endif
+
+	/** Only used if the connection enforces request timeouts */
+	struct fuse_timeout timeout;
 };
 
 /*
@@ -1181,6 +1199,9 @@ void fuse_request_end(struct fuse_req *req);
 void fuse_abort_conn(struct fuse_conn *fc);
 void fuse_wait_aborted(struct fuse_conn *fc);
 
+/* Check if any requests timed out */
+void fuse_check_timeout(struct timer_list *timer);
+
 /**
  * Invalidate inode attributes
  */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index f1779ff3f8d1..ee006f09cd04 100644
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
+			timer_shutdown_sync(&fc->timeout.timer);
 		if (fiq->ops->release)
 			fiq->ops->release(fiq);
 		put_pid_ns(fc->pid_ns);
@@ -1691,6 +1699,18 @@ int fuse_init_fs_context_submount(struct fs_context *fsc)
 }
 EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount);
 
+static void fuse_init_fc_timeout(struct fuse_conn *fc, struct fuse_fs_context *ctx)
+{
+	if (ctx->req_timeout) {
+		if (check_mul_overflow(ctx->req_timeout * 60, HZ, &fc->timeout.req_timeout))
+			fc->timeout.req_timeout = ULONG_MAX;
+		timer_setup(&fc->timeout.timer, fuse_check_timeout, 0);
+		mod_timer(&fc->timeout.timer, jiffies + FUSE_TIMEOUT_TIMER_FREQ);
+	} else {
+		fc->timeout.req_timeout = 0;
+	}
+}
+
 int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 {
 	struct fuse_dev *fud = NULL;
@@ -1753,6 +1773,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->destroy = ctx->destroy;
 	fc->no_control = ctx->no_control;
 	fc->no_force_umount = ctx->no_force_umount;
+	fuse_init_fc_timeout(fc, ctx);
 
 	err = -ENOMEM;
 	root = fuse_get_root_inode(sb, ctx->rootmode);
-- 
2.43.5


