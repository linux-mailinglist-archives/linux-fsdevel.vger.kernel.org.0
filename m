Return-Path: <linux-fsdevel+bounces-37765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 805CC9F7001
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 23:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485A21893CA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 22:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260DE1FCD15;
	Wed, 18 Dec 2024 22:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dy9dzi40"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB0117A586
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734560850; cv=none; b=n7gsCDz+dJ1zn4lOlsYvzfS/OzFiFl5w0CC0oHeED7pV8ud8v+9VjXBJwVHcXjGiTP8/bUTYs6qxHkJjUGCgK4nFjDKUYSpfNwY+fYY7PXuMzCzmRwn7upheD0i08wc5u2EsRmzAf/GnL2VjKYhMFRr92XxhwrC7LYsvuhumG0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734560850; c=relaxed/simple;
	bh=QKR2e8ZK+gm6XpPlZEZRJnnEo0O7cGnPoZfjRf0n7MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1t8nux2199xrgAJjTCu30jE3yTMRp9uh74W4/NVuYhTKlENIMrnYWQGYmvQH8G6aHfG/F4ybZmLqqH9SE9Ym4L2TFXUgu7H9+OcOmTSA01myzR0Uy01Yz3ZqEgYwGfGA46JFAdoK4WZH00OC/MpvM6Qpgnr/qPmEmGzRzl4rMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dy9dzi40; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6eff8289d0eso1891177b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 14:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734560848; x=1735165648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjnUNJp09N5jqMZtBUT9EJxEXi4xNx2uay8VUsQTWlM=;
        b=dy9dzi40fylZ1NUFLomgyllCVvI9nGI0Ri2frA7ySxqN5klZLa0mL2hYHsO3QaoKfQ
         DeZISksKyk0joTrKTJxbaOOOnJ27w4l4lpi5SAqasw1ukvtY/zyhdoBj1ZA7kDZqCKkA
         mmIsnShkTRpjGyl4SH2M6pRwGFKcK1+90+858cM/Y53W+ATCUNw+Ejh+AeOKGOOQkDO/
         E5edvMFmvgPrGfwzYcbLfhFg/QRGBlu3c8YNFQ4TLGjF5/Hvb9qHGWpknOmxmcNyPw2o
         t1phkMJhC4jyLnLXOO9qKrJn+Q3VqQ1s6FRPMykSmPwSr759DSyEbqsfut4wCvUzIc9x
         BGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734560848; x=1735165648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjnUNJp09N5jqMZtBUT9EJxEXi4xNx2uay8VUsQTWlM=;
        b=VUEs54OhV53dDbXRy8CjzC7z8GddMMbnzAuuNgZLDOPmbGTvWdbx3XxR6yb2yyE/c0
         GakimNDzN26/CwMsddivZcGjimyUPVduqqylSKYfxedWnsNxvwNQWMxRiJqHLtRoIYS7
         xqtyn+rmRzkmwa0rmFlxS5heKaElirSgPo9HKNSpjFaYoD6uIC19qHIB/rvCN5IF75U6
         tpoSwfK+CWq6U5chNLw7GmrZj33MHA7HcJPxE2lhx75SlPvDvYJ6KPbgT+AU05cxZTc7
         uD0uh/B4mLIJhySj7lmMqjNvL604QWWeTNjKvCD2oJVEVUdeP6PnByuhx8ZIisvmUDcP
         PAng==
X-Forwarded-Encrypted: i=1; AJvYcCWUzteEBU0+sd9qwrS1LjjCqIfzh2XUxqvPkKKP9OwbHEW8Sq6PwLACSx39SzWuV80jaJ+X8iNfCdGmmfXv@vger.kernel.org
X-Gm-Message-State: AOJu0YxvgmFc+kfXqVA9mu2Zx0y3P5gHXjLNY0k5y0KllJdN41dPdFmU
	JgmzWah+QsTLVxXzEhnPC6QGbC6BDqoM46xH9I0dQiUepPILcuHtFEzsyg==
X-Gm-Gg: ASbGncumCT/ys+tLANrUwFHAsk8FxBXFwMEa+GGQ5B1L4csGfsv7MxCcStOlIdOE+tp
	YlJP1aSqUVJ3LOcm7FmxL8FsGKdkW9w0pYA3iSfFmlrI/w1vA+iD4FaUYjUUwfDs8PsqHIgM4j6
	Z1nni4q7gektjvhO3fr3hgRZnCbjmPRVRcpDn1Q74vl5MKc3y77KxXG0tpAcZLIwPaZx6lijqSY
	sFjppQaWWNtirbZLkzR8Wwp4yqZ1iijZNCJKFaLAQGFlTbtCKG6SYY=
X-Google-Smtp-Source: AGHT+IG+f08QwKMVtDDytWyBVMGUJaEYdfhjGH+XqzqmmAnPTVOSkaItrfoPVLdxcwUuqFPiGAuXKw==
X-Received: by 2002:a05:690c:6e90:b0:6ef:64e8:c704 with SMTP id 00721157ae682-6f3d269b84fmr38011477b3.36.1734560847624;
        Wed, 18 Dec 2024 14:27:27 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f2890c80b7sm25828007b3.75.2024.12.18.14.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 14:27:27 -0800 (PST)
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
Subject: [PATCH v11 1/2] fuse: add kernel-enforced timeout option for requests
Date: Wed, 18 Dec 2024 14:26:29 -0800
Message-ID: <20241218222630.99920-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218222630.99920-1-joannelkoong@gmail.com>
References: <20241218222630.99920-1-joannelkoong@gmail.com>
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
 fs/fuse/dev.c    | 85 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h | 22 +++++++++++++
 fs/fuse/inode.c  | 23 +++++++++++++
 3 files changed, 130 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 27ccae63495d..bcf8a7994944 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -45,6 +45,87 @@ static struct fuse_dev *fuse_get_dev(struct file *file)
 	return READ_ONCE(file->private_data);
 }
 
+static bool request_expired(struct fuse_conn *fc, struct list_head *list)
+{
+	struct fuse_req *req;
+
+	req = list_first_entry_or_null(list, struct fuse_req, list);
+	if (!req)
+		return false;
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
+	struct fuse_dev *fud;
+	struct fuse_pqueue *fpq;
+	bool expired = false;
+	int i;
+
+	if (!atomic_read(&fc->num_waiting))
+	    goto out;
+
+	spin_lock(&fiq->lock);
+	expired = request_expired(fc, &fiq->pending);
+	spin_unlock(&fiq->lock);
+	if (expired)
+		goto abort_conn;
+
+	spin_lock(&fc->bg_lock);
+	expired = request_expired(fc, &fc->bg_queue);
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
+		if (request_expired(fc, &fpq->io))
+			goto fpq_abort;
+
+		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++) {
+			if (request_expired(fc, &fpq->processing[i]))
+				goto fpq_abort;
+		}
+		spin_unlock(&fpq->lock);
+	}
+	spin_unlock(&fc->lock);
+
+out:
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
@@ -53,6 +134,7 @@ static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
 	refcount_set(&req->count, 1);
 	__set_bit(FR_PENDING, &req->flags);
 	req->fm = fm;
+	req->create_time = jiffies;
 }
 
 static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t flags)
@@ -2260,6 +2342,9 @@ void fuse_abort_conn(struct fuse_conn *fc)
 		LIST_HEAD(to_end);
 		unsigned int i;
 
+		if (fc->timeout.req_timeout)
+			cancel_delayed_work(&fc->timeout.work);
+
 		/* Background queuing checks fc->connected under bg_lock */
 		spin_lock(&fc->bg_lock);
 		fc->connected = 0;
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


