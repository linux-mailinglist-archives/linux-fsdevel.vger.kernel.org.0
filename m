Return-Path: <linux-fsdevel+bounces-31775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B61B099AC7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 21:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCD428A701
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 19:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BAF1CF286;
	Fri, 11 Oct 2024 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aw30rBsD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717A01CC176
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 19:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728674074; cv=none; b=YA/lTgrx2r3KhnSGxWyd3Rwy7Z/6mBA9+SyXaRuq1M+O6KVcA9Npiwqq9UWpWego6Xrl0lfrk01kUJ2K1v5FgyQEyQZ0USmvDcxyJWUHklOs+Emg2g661Xw1kG/a0k1VablUlN2nfkSOAKJg08s9icpkfjpeJnbBBtjiS8qHvfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728674074; c=relaxed/simple;
	bh=xFZykLGsFkOKQ9Jx3PswQTMGyrlEP1+SC2EUrIHLE0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOk77nXAnWkpdSUpZuq7oggx+glzfZ3vU3PhjEQHTG5S7fVIhf7z6QFcaWB+MkyhYu6MnWs6dCsMhr6rq5HdaugPuxs14dESjp6fnuerUoUswrrA3hKRpKGYZ/KfkBSWuin10UOvx1NHJiLyDpdJHSec811UX4DbHjjeo4k9JKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aw30rBsD; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e2fef23839so20120297b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 12:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728674071; x=1729278871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lF7OK3RiYQd+eh4mUJsSsZ4gtBhqcuJl4MMVNb5h+Og=;
        b=aw30rBsDH5iJPzKc1reE87dz24iFTQOQXqlU2uUv5rnjaXJp2bXsrfgD240aCxdlXn
         gTYrKivfeh2mUtgK/2X7juEY3sKg71/mI4ShMVuDjZZlt932tRmJoI05U5qNlULB0xHt
         05ezRaFapPBSwj32zNENJq9CBStBQpOOicIACIav+l9RWt5/v/RY5FGwmBiehA7S5Ecp
         7cUCL8jjwMDY3MmrPlefJT+IUEAlUHjHvqIIQDO2j6V3bLeLsAOojByGiAHR4HVbG89a
         HoMS+vkGhQWHov+e5rQNTzpo56RuWco+Mef9RIkXTfxXqo9AsVJvWsju/UXD48SW7FPg
         +9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728674071; x=1729278871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lF7OK3RiYQd+eh4mUJsSsZ4gtBhqcuJl4MMVNb5h+Og=;
        b=SqOog+1WimOqXxGZaDxYxUAxlw1iocIqLzyoeWS34i3AILmJR6rXcE7XCFuyLPYQK9
         eRwls0g70FBaLSrHVh1T6IAD3J03F+UdDWdpIMI/5dgG9Yfgd+84DoGKMf0SOkGQiLyX
         qb5c0qXgP53REH+PF68TjFXCwOiBKV6vciCZc7U+NZOJrz4HUvbcZndXBaeV7Bg0iY9+
         4ZlLu0kG5W6qWcUPPHhVLIBBb+ATXSMT9HLzw8/5+ooWwa6okMcSA0MajbNYYlBHFAcZ
         ZM1jhbmBbD0+/1h4y+xy5oAgqsweC230dNQfZ/Detj1iLsxVWKWlzP6UE+2cDW3TVtwm
         2z2w==
X-Forwarded-Encrypted: i=1; AJvYcCWYSkDkp41VmXw6KzD5EnaIdeTQlkcRE2bsz6mQLux158uqMwWaxQBfs14ja3bLz7bDBhAqZEu6IuW5SvZp@vger.kernel.org
X-Gm-Message-State: AOJu0YyhzQzSVOAg6WfYXEkmeVw9hQK8sChV3/SDMpMZWx99b64J04Nq
	3G174S5hKpWLVdYRxfAMgV7qbuR9szKNlou+hXzpqeZHqflQKsqJCtnK8A==
X-Google-Smtp-Source: AGHT+IEEEYAW+m6LtHxmT3W4WfmjAa8zvCiR330uwpdCSI8Uc4P91syXnah7WxzBv5lS+zLOneUX7w==
X-Received: by 2002:a05:690c:9685:b0:6e3:3007:249d with SMTP id 00721157ae682-6e36434e5a3mr6960387b3.25.1728674071288;
        Fri, 11 Oct 2024 12:14:31 -0700 (PDT)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332c71084sm7050987b3.118.2024.10.11.12.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:14:31 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v8 2/3] fuse: add optional kernel-enforced timeout for requests
Date: Fri, 11 Oct 2024 12:13:19 -0700
Message-ID: <20241011191320.91592-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241011191320.91592-1-joannelkoong@gmail.com>
References: <20241011191320.91592-1-joannelkoong@gmail.com>
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
---
 fs/fuse/dev.c    | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h | 21 +++++++++++++
 fs/fuse/inode.c  | 21 +++++++++++++
 3 files changed, 122 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1f64ae6d7a69..054bfa2a26ed 100644
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
@@ -2296,6 +2373,9 @@ void fuse_abort_conn(struct fuse_conn *fc)
 		spin_unlock(&fc->lock);
 
 		end_requests(&to_end);
+
+		if (fc->timeout.req_timeout)
+			timer_delete(&fc->timeout.timer);
 	} else {
 		spin_unlock(&fc->lock);
 	}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7ff00bae4a84..ef4558c2c44e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -435,6 +435,9 @@ struct fuse_req {
 
 	/** fuse_mount this request belongs to */
 	struct fuse_mount *fm;
+
+	/** When (in jiffies) the request was created */
+	unsigned long create_time;
 };
 
 struct fuse_iqueue;
@@ -525,6 +528,16 @@ struct fuse_pqueue {
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
@@ -571,6 +584,8 @@ struct fuse_fs_context {
 	enum fuse_dax_mode dax_mode;
 	unsigned int max_read;
 	unsigned int blksize;
+	/*  Request timeout (in minutes). 0 = no timeout (infinite wait) */
+	unsigned int req_timeout;
 	const char *subtype;
 
 	/* DAX device, may be NULL */
@@ -914,6 +929,9 @@ struct fuse_conn {
 	/** IDR for backing files ids */
 	struct idr backing_files_map;
 #endif
+
+	/** Only used if the connection enforces request timeouts */
+	struct fuse_timeout timeout;
 };
 
 /*
@@ -1175,6 +1193,9 @@ void fuse_request_end(struct fuse_req *req);
 void fuse_abort_conn(struct fuse_conn *fc);
 void fuse_wait_aborted(struct fuse_conn *fc);
 
+/* Check if any requests timed out */
+void fuse_check_timeout(struct timer_list *timer);
+
 /**
  * Invalidate inode attributes
  */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index f1779ff3f8d1..a78aac76b942 100644
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
+			fc->timeout.req_timeout = U32_MAX;
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


