Return-Path: <linux-fsdevel+bounces-39871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E9EA19A92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 22:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900AE1692BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 21:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51D11C8FD6;
	Wed, 22 Jan 2025 21:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azZTgHUo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F571C5D66
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 21:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737583019; cv=none; b=CkTQ/hGpTKgfLIuyVzuelVGc+yfieK0K7ijF64UIrEQAoMgaQ1EfKx8tUHyD4C1k7xur/R2WDlGiWqIOWumVVJBy10PZWbRRforVOncREVfkT9/8422AbRJUCPZy7OD72fwjA9rmJ2Z/6AmEKUo8fnmjl8sczWAYdM1tZb1KMoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737583019; c=relaxed/simple;
	bh=UIiJjxWJSG+zAUDpzP1dJX729H6ZhvEB/g8x/cQjMf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lN6jOrTEl9uv1Q30lGSWtga5liy9xLSglmvR23qM1C0aV+rOEDI7DPj2SmV56h9R3Bt8VL0ThOHbKgHF6bnjj5pN+blXhSLt5vMyB+8XYjDPJpy9bFa+6criWVm17L47/qwhgsQCNOIfSdh8mAtObCt1Qey4SsRxqjMYTFmiZ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azZTgHUo; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e3c9ec344efso361066276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 13:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737583016; x=1738187816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xp0GfIqPvm7WqrC/PZjS0Dlv0YXKy8k9F0zlVbowvmA=;
        b=azZTgHUo4gwx08gqUaC+aUjYUdf+Q0A9ZHt5Bcni2XnVtVRfq0ogyIlaQdqmkT2f2Q
         0u5QJhvMzhqT4+ot9tmP9W98WaVgDXAu4zJ/IYLDieJOB+neFPZ2Dz8/X1xXtCLWim9n
         mPJpalhGHsAHLSPQZjvzMGEAlFjrkZY9TopbvEEAJWQZKKw9ai83YIkY2A0XQsZp9HxG
         fPuYWOiIOnyZ9lnQtUq/FCEC3bf2kKyEDRXfZLlR8VqetfyYaAjb9H8Va59OycMZGNds
         4iD5k8iVIaDWVFSplgsRZEWQflmp9dwHYGpkIf6zlaFfmwwzwrcTkKneNF6SElqo/TBT
         d5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737583016; x=1738187816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xp0GfIqPvm7WqrC/PZjS0Dlv0YXKy8k9F0zlVbowvmA=;
        b=hrWdXNs2yjCkX5U06VPtVxjecJbEBenSI4sCDtT9xco+7TMv4gi1eKBf7bz79ChTEZ
         syNsKzJEV0avQVeD63NHQ235EtSg21ztxzCLd68IcwKdQps8YA7rL9YQXFOuxjXpDwI4
         /aI6aU7u94V/aBicp4cR3FHQjtJNsH4wcm2QFCjrgUuzkGWS3RxqilVD1PCBBli2B42R
         Uuai5WPt4iIMrX7TE+ltG7YtH/PGZefAUGb4ddnf81dPFZ341GIX/nhszbGAS+ADT7Ha
         VZOjgktCOK5Q0CGS5JAMd3a5Pu2aPWph8t91Z/AgTXTKcjqRuKGYEltFiM5kFO5Hguul
         cGsA==
X-Forwarded-Encrypted: i=1; AJvYcCUQeaDxr+NS+tHMwUTxaRL0+qVEibCtrBm1XkESSBVamtkR4Kl++eePh8Zte9AXtG1VlcUwfVZzQS/aGuM4@vger.kernel.org
X-Gm-Message-State: AOJu0YxjE07OsNkCHoNckQqz3bI5bkobQwE7fv6fNB39NeR9VCZrN1Mm
	gFHwUMyRFPJHxPolKWqiLkTa35GSFg+uPoISJrfUee18zfjcCVZX
X-Gm-Gg: ASbGncuY5820wHIJAzS2s8djOaTWxJV4+TZ6WItENF+69iLilMFmZSWIQuZ9IrWNqdn
	77XyERbqL5n8Oi98Y4cw0H1u9wKq78bT+Hjy/V1KvczqJvfnVC94qQrBxbB1b6CtXaPdNQ8vQ3m
	MXOMr86jwTZ7Mxv5bC/GsAKyJfkCwriBKF5iPkakhqA1rZm94RMxsbLaLc8jXYb9hyG0T5Rvep1
	EPLAETxhSRNqsAdf8FjJ89jKPbEcG9/ElSLtVPAY90uM9i5NauX8hkHU5qGX6t0
X-Google-Smtp-Source: AGHT+IGdCAymatk2BLZyDwaMFAy9iwbkdJ95U3+Sjrt5SKI7P28mPlyX8iUbNbmnj7Mq++q91/Wd/w==
X-Received: by 2002:a05:690c:690d:b0:6f4:beb3:1f1c with SMTP id 00721157ae682-6f6eb922174mr189948257b3.26.1737583016288;
        Wed, 22 Jan 2025 13:56:56 -0800 (PST)
Received: from localhost ([2a03:2880:25ff::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e647d7f3sm22368137b3.65.2025.01.22.13.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 13:56:56 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	jlayton@kernel.org,
	senozhatsky@chromium.org,
	tfiga@chromium.org,
	bgeffon@google.com,
	etmartin4313@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v12 1/2] fuse: add kernel-enforced timeout option for requests
Date: Wed, 22 Jan 2025 13:55:27 -0800
Message-ID: <20250122215528.1270478-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250122215528.1270478-1-joannelkoong@gmail.com>
References: <20250122215528.1270478-1-joannelkoong@gmail.com>
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
 fs/fuse/dev.c             | 101 ++++++++++++++++++++++++++++++++++++++
 fs/fuse/dev_uring.c       |  27 ++++++++++
 fs/fuse/dev_uring_i.h     |   6 +++
 fs/fuse/fuse_dev_i.h      |   3 ++
 fs/fuse/fuse_i.h          |  17 +++++++
 fs/fuse/inode.c           |  17 ++++++-
 include/uapi/linux/fuse.h |  10 +++-
 7 files changed, 178 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5b5f789b37eb..a9d8c739229d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -32,6 +32,103 @@ MODULE_ALIAS("devname:fuse");
 
 static struct kmem_cache *fuse_req_cachep;
 
+/* Frequency (in seconds) of request timeout checks, if opted into */
+#define FUSE_TIMEOUT_TIMER_FREQ 15
+
+const unsigned long fuse_timeout_timer_freq =
+	secs_to_jiffies(FUSE_TIMEOUT_TIMER_FREQ);
+
+bool fuse_request_expired(struct fuse_conn *fc, struct list_head *list)
+{
+	struct fuse_req *req;
+
+	req = list_first_entry_or_null(list, struct fuse_req, list);
+	if (!req)
+		return false;
+	return time_is_before_jiffies(req->create_time + fc->timeout.req_timeout);
+}
+
+bool fuse_fpq_processing_expired(struct fuse_conn *fc, struct list_head *processing)
+{
+	int i;
+
+	for (i = 0; i < FUSE_PQ_HASH_SIZE; i++)
+		if (fuse_request_expired(fc, &processing[i]))
+			return true;
+
+	return false;
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
+
+	if (!atomic_read(&fc->num_waiting))
+	    goto out;
+
+	spin_lock(&fiq->lock);
+	expired = fuse_request_expired(fc, &fiq->pending);
+	spin_unlock(&fiq->lock);
+	if (expired)
+		goto abort_conn;
+
+	spin_lock(&fc->bg_lock);
+	expired = fuse_request_expired(fc, &fc->bg_queue);
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
+		if (fuse_request_expired(fc, &fpq->io) ||
+		    fuse_fpq_processing_expired(fc, fpq->processing)) {
+			spin_unlock(&fpq->lock);
+			spin_unlock(&fc->lock);
+			goto abort_conn;
+		}
+
+		spin_unlock(&fpq->lock);
+	}
+	spin_unlock(&fc->lock);
+
+	if (fuse_uring_request_expired(fc))
+	    goto abort_conn;
+
+out:
+	queue_delayed_work(system_wq, &fc->timeout.work,
+			   fuse_timeout_timer_freq);
+	return;
+
+abort_conn:
+	fuse_abort_conn(fc);
+}
+
 static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
 {
 	INIT_LIST_HEAD(&req->list);
@@ -40,6 +137,7 @@ static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
 	refcount_set(&req->count, 1);
 	__set_bit(FR_PENDING, &req->flags);
 	req->fm = fm;
+	req->create_time = jiffies;
 }
 
 static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t flags)
@@ -2270,6 +2368,9 @@ void fuse_abort_conn(struct fuse_conn *fc)
 		LIST_HEAD(to_end);
 		unsigned int i;
 
+		if (fc->timeout.req_timeout)
+			cancel_delayed_work(&fc->timeout.work);
+
 		/* Background queuing checks fc->connected under bg_lock */
 		spin_lock(&fc->bg_lock);
 		fc->connected = 0;
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 5f10f3880d5a..4f935b11e96f 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -140,6 +140,33 @@ void fuse_uring_abort_end_requests(struct fuse_ring *ring)
 	}
 }
 
+bool fuse_uring_request_expired(struct fuse_conn *fc)
+{
+	struct fuse_ring *ring = fc->ring;
+	struct fuse_ring_queue *queue;
+	int qid;
+
+	if (!ring)
+		return false;
+
+	for (qid = 0; qid < ring->nr_queues; qid++) {
+		queue = READ_ONCE(ring->queues[qid]);
+		if (!queue)
+			continue;
+
+		spin_lock(&queue->lock);
+		if (fuse_request_expired(fc, &queue->fuse_req_queue) ||
+		    fuse_request_expired(fc, &queue->fuse_req_bg_queue) ||
+		    fuse_fpq_processing_expired(fc, queue->fpq.processing)) {
+			spin_unlock(&queue->lock);
+			return true;
+		}
+		spin_unlock(&queue->lock);
+	}
+
+	return false;
+}
+
 void fuse_uring_destruct(struct fuse_conn *fc)
 {
 	struct fuse_ring *ring = fc->ring;
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 2102b3d0c1ae..a37991d17d34 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -142,6 +142,7 @@ void fuse_uring_abort_end_requests(struct fuse_ring *ring);
 int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
 void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req);
 bool fuse_uring_queue_bq_req(struct fuse_req *req);
+bool fuse_uring_request_expired(struct fuse_conn *fc);
 
 static inline void fuse_uring_abort(struct fuse_conn *fc)
 {
@@ -200,6 +201,11 @@ static inline bool fuse_uring_ready(struct fuse_conn *fc)
 	return false;
 }
 
+static inline bool fuse_uring_request_expired(struct fuse_conn *fc)
+{
+	return false;
+}
+
 #endif /* CONFIG_FUSE_IO_URING */
 
 #endif /* _FS_FUSE_DEV_URING_I_H */
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 429661ae0654..5bb91cac400f 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -63,5 +63,8 @@ void fuse_dev_queue_forget(struct fuse_iqueue *fiq,
 			   struct fuse_forget_link *forget);
 void fuse_dev_queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req);
 
+bool fuse_request_expired(struct fuse_conn *fc, struct list_head *list);
+bool fuse_fpq_processing_expired(struct fuse_conn *fc, struct list_head *processing);
+
 #endif
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 886c3af21958..1321cc4ed2ab 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -44,6 +44,9 @@
 /** Number of dentries for each connection in the control filesystem */
 #define FUSE_CTL_NUM_DENTRIES 5
 
+/** Frequency (in jiffies) of request timeout checks, if opted into */
+extern const unsigned long fuse_timeout_timer_freq;
+
 /** Maximum of max_pages received in init_out */
 extern unsigned int fuse_max_pages_limit;
 
@@ -442,6 +445,8 @@ struct fuse_req {
 #ifdef CONFIG_FUSE_IO_URING
 	void *ring_entry;
 #endif
+	/** When (in jiffies) the request was created */
+	unsigned long create_time;
 };
 
 struct fuse_iqueue;
@@ -935,6 +940,15 @@ struct fuse_conn {
 	/**  uring connection information*/
 	struct fuse_ring *ring;
 #endif
+
+	/** Only used if the connection opts into request timeouts */
+	struct {
+		/* Worker for checking if any requests have timed out */
+		struct delayed_work work;
+
+		/* Request timeout (in jiffies). 0 = no timeout */
+		unsigned int req_timeout;
+	} timeout;
 };
 
 /*
@@ -1216,6 +1230,9 @@ void fuse_request_end(struct fuse_req *req);
 void fuse_abort_conn(struct fuse_conn *fc);
 void fuse_wait_aborted(struct fuse_conn *fc);
 
+/* Check if any requests timed out */
+void fuse_check_timeout(struct work_struct *work);
+
 /**
  * Invalidate inode attributes
  */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e9db2cb8c150..79ebeb60015c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -979,6 +979,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->user_ns = get_user_ns(user_ns);
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
 	fc->max_pages_limit = fuse_max_pages_limit;
+	fc->timeout.req_timeout = 0;
 
 	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		fuse_backing_files_init(fc);
@@ -1007,6 +1008,8 @@ void fuse_conn_put(struct fuse_conn *fc)
 
 		if (IS_ENABLED(CONFIG_FUSE_DAX))
 			fuse_dax_conn_free(fc);
+		if (fc->timeout.req_timeout)
+			cancel_delayed_work_sync(&fc->timeout.work);
 		if (fiq->ops->release)
 			fiq->ops->release(fiq);
 		put_pid_ns(fc->pid_ns);
@@ -1257,6 +1260,14 @@ static void process_init_limits(struct fuse_conn *fc, struct fuse_init_out *arg)
 	spin_unlock(&fc->bg_lock);
 }
 
+static void set_request_timeout(struct fuse_conn *fc, unsigned int timeout)
+{
+	fc->timeout.req_timeout = secs_to_jiffies(timeout);
+	INIT_DELAYED_WORK(&fc->timeout.work, fuse_check_timeout);
+	queue_delayed_work(system_wq, &fc->timeout.work,
+			   fuse_timeout_timer_freq);
+}
+
 struct fuse_init_args {
 	struct fuse_args args;
 	struct fuse_init_in in;
@@ -1392,6 +1403,9 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			}
 			if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled())
 				fc->io_uring = 1;
+
+			if ((flags & FUSE_REQUEST_TIMEOUT) && arg->request_timeout)
+				set_request_timeout(fc, arg->request_timeout);
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1439,7 +1453,8 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
 		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
-		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALLOW_IDMAP;
+		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALLOW_IDMAP |
+		FUSE_REQUEST_TIMEOUT;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 5e0eb41d967e..42db04c0c5b1 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -229,6 +229,9 @@
  *    - FUSE_URING_IN_OUT_HEADER_SZ
  *    - FUSE_URING_OP_IN_OUT_SZ
  *    - enum fuse_uring_cmd
+ *
+ *  7.43
+ *  - add FUSE_REQUEST_TIMEOUT
  */
 
 #ifndef _LINUX_FUSE_H
@@ -435,6 +438,8 @@ struct fuse_file_lock {
  *		    of the request ID indicates resend requests
  * FUSE_ALLOW_IDMAP: allow creation of idmapped mounts
  * FUSE_OVER_IO_URING: Indicate that client supports io-uring
+ * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
+ *			 init_out.request_timeout contains the timeout (in secs)
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -477,11 +482,11 @@ struct fuse_file_lock {
 #define FUSE_PASSTHROUGH	(1ULL << 37)
 #define FUSE_NO_EXPORT_SUPPORT	(1ULL << 38)
 #define FUSE_HAS_RESEND		(1ULL << 39)
-
 /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
 #define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
 #define FUSE_OVER_IO_URING	(1ULL << 41)
+#define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
 
 /**
  * CUSE INIT request/reply flags
@@ -909,7 +914,8 @@ struct fuse_init_out {
 	uint16_t	map_alignment;
 	uint32_t	flags2;
 	uint32_t	max_stack_depth;
-	uint32_t	unused[6];
+	uint16_t	request_timeout;
+	uint16_t	unused[11];
 };
 
 #define CUSE_INIT_INFO_MAX 4096
-- 
2.43.5


