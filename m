Return-Path: <linux-fsdevel+bounces-37088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 131709ED6BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 20:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DEE3188420A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 19:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224FB1DE4D8;
	Wed, 11 Dec 2024 19:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdOoYBdX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8C52594BD
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733946358; cv=none; b=PipG3Xk7wagWLAeq/X5l93Zm5XHBYavKs7uDmaQB377mdCV22ELJM9AKnQdTxtMi/s3Phqx/PlQ+ha5CB2R0poPmQEFLjjAqkSBfm87PbG941kT9iUW/YStfPwXhaIeOVZGQIkw0Wzp0oVS98ILG9As3LOFOPniO0Ija4OHGjpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733946358; c=relaxed/simple;
	bh=r/5xr6m8F3x23W3alCOzgYy5gm4ReQ1biTcH12riAqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eU3a7Fxq+Vzfy0xk0SJDsRgtuldyPWfif4B41eEGlwIFiaRZ5SLhOeKwyScXGnDK4VPwaRF9Fjn7E8u2TbOwM6jSktVPD1KTttLmVkacq4BwBwjk+oH3WO6j1N8SAwSM4dQbISJfOk/vU83xXNJ4v56KxSUkmp/a6iyQnM5xQKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdOoYBdX; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d8f75b31bfso39893986d6.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 11:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733946355; x=1734551155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppzNUML21uR9gxiYzKGJsx59+XhyehHmQBZoLut6nTs=;
        b=BdOoYBdX0rhiRuUj9hVmCnjbgH2ORAskLqiRKNpizOCzp4wbiNld8Lfs7FbKBV/kvM
         LT4lCVoDUeD/g9x+OCWoAKcCuGwCFYI2VjTtCypE4qzzEEFOYatRWIq3UBO+eeC+PXlF
         r/5bLccyPjc4arqPK5PT2PUSD2P2OgE3LsKFRGfW0luisZLj9H6XFkTDVW6JDFyqDGuo
         P2oUky7JthLEuz9qbaH7XNvXtWbXwR6lAPVsmKC4Ujm0lXt2jUJG9tzMoIJMSXLky9jn
         MNPEBjaBU8/wj7ji1ofDWGhD0lbjq5C2KYVkOpesABpEXyvtB9wfSwTI1eAZng8HKJns
         9k9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733946355; x=1734551155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppzNUML21uR9gxiYzKGJsx59+XhyehHmQBZoLut6nTs=;
        b=VFF0ALZAimYGe9xlCLrWITx8rvwrAvrvGvjD0huC/hFYoujhQRzVTXMOvIweTTvOJW
         r/JxhB/xg26vfXHEy/i94xBcm8eaRYVzZWLQoDkqIr1LLhFzOar2joud/nz/FUvHxgGM
         S93vmwu+MQTqKG2ANWSVmnKSKCdOup3jE4nzFWtx5nUsxyZtzfo0TXk9sw/LwGLRZWC7
         Z9GrZY+iPKj6N8B8EvKgVNf0IyVNIjwoGLFl/IcL/9lLlJ04+r2hrS9079KYDptiWwoy
         oMRFfHyGZWwJ3V9GeQ2pFYg3XhHdLGyYkGhTCcbgRNGxL5acaAKOw+DAYEcTnikS5GBs
         TE+A==
X-Gm-Message-State: AOJu0YycLRZ3U8Oic1u6V6Ap4N++ii/ykPfLwPmlOaA6g3Hh5WneQELx
	key76WEYHQS3JIm1U7skPoOUqzC8KWO8ClTTDiC+ThScIhyiTVIhV1NzqA==
X-Gm-Gg: ASbGnctwEwGa5GeHz1KdnPX4qcgECSIhi/EY02S+IT4DSmujjEusORrWfkF45NQeQY5
	7u21zOtwgBujzKPoa5FzEeFsKdJd57WtwNVvaE23kO90U2JButvZGDhQCcPtyVbSOz1dH0nIo3N
	CU67QUGJBKUvWG7v2PoytTU2cMNjXIFf2hFpPm3wkyo/ZBfXbcZweDFnsFaP/WXrWMyGh2jh8Oa
	F241wUoIlo7lRcARbsMgAQKyT0fpINSHM6WCC7w0DVlH/4xMNC8FTDU1oJE262YXHJrG4wqkd2G
	6FIh9AkjpRAK65W/GGKxgvTbK6vvRsLn9HM1EZKbctUkvbUZppngs91PHgmp
X-Google-Smtp-Source: AGHT+IHu8aZyjiNVcMjKF2++cVoh+e1hT3PB22eK21vMNyBYupYZxiCgiR+byq2foM9CvhrsMO6EfQ==
X-Received: by 2002:a05:6214:b69:b0:6d8:8874:2131 with SMTP id 6a1803df08f44-6dae38f2f08mr8257676d6.13.1733946355498;
        Wed, 11 Dec 2024 11:45:55 -0800 (PST)
Received: from localhost.localdomain (lnsm3-toronto63-142-127-175-73.internet.virginmobile.ca. [142.127.175.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da9fdecesm73063626d6.77.2024.12.11.11.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 11:45:55 -0800 (PST)
From: etmartin4313@gmail.com
To: linux-fsdevel@vger.kernel.org,
	miklos@szeredi.hu
Cc: joannelkoong@gmail.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	laoar.shao@gmail.com,
	senozhatsky@chromium.org,
	etmartin@cisco.com,
	Etienne Martineau <etmartin4313@gmail.com>
Subject: [PATCH v2] fuse: Abort connection if FUSE server get stuck
Date: Wed, 11 Dec 2024 14:45:22 -0500
Message-Id: <20241211194522.31977-2-etmartin4313@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211194522.31977-1-etmartin4313@gmail.com>
References: <20241211194522.31977-1-etmartin4313@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Etienne Martineau <etmartin4313@gmail.com>

This patch abort connection if HUNG_TASK_PANIC is set and a FUSE server
is getting stuck for too long. A slow FUSE server may tripped the
hang check timer for legitimate reasons hence consider disabling
HUNG_TASK_PANIC in that scenario.

Without this patch, an unresponsive / buggy / malicious FUSE server can
leave the clients in D state for a long period of time and on system where
HUNG_TASK_PANIC is set, trigger a catastrophic reload.

So, if HUNG_TASK_PANIC checking is enabled, we should wake up periodically
to abort connections that exceed the timeout value which is define to be
half the HUNG_TASK_TIMEOUT period, which keeps overhead low. The timer
is per connection and runs only if there are active FUSE request pending.

A FUSE client can get into D state as such ( see below scenario #1 / #2 )
 1) request_wait_answer() -> wait_event() is UNINTERRUPTIBLE
    OR
 2) request_wait_answer() -> wait_event_(interruptible / killable) is head
    of line blocking for subsequent clients accessing the same file

	scenario #1:
	2716 pts/2    D+     0:00 cat
	$ cat /proc/2716/stack
		[<0>] request_wait_answer+0x22e/0x340
		[<0>] __fuse_simple_request+0xd8/0x2c0
		[<0>] fuse_perform_write+0x3ec/0x760
		[<0>] fuse_file_write_iter+0x3d5/0x3f0
		[<0>] vfs_write+0x313/0x430
		[<0>] ksys_write+0x6a/0xf0
		[<0>] __x64_sys_write+0x19/0x30
		[<0>] x64_sys_call+0x18ab/0x26f0
		[<0>] do_syscall_64+0x7c/0x170
		[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

	scenario #2:
	2962 pts/2    S+     0:00 cat
	2963 pts/3    D+     0:00 cat
	$ cat /proc/2962/stack
		[<0>] request_wait_answer+0x140/0x340
		[<0>] __fuse_simple_request+0xd8/0x2c0
		[<0>] fuse_perform_write+0x3ec/0x760
		[<0>] fuse_file_write_iter+0x3d5/0x3f0
		[<0>] vfs_write+0x313/0x430
		[<0>] ksys_write+0x6a/0xf0
		[<0>] __x64_sys_write+0x19/0x30
		[<0>] x64_sys_call+0x18ab/0x26f0
		[<0>] do_syscall_64+0x7c/0x170
		[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
	$ cat /proc/2963/stack
		[<0>] fuse_file_write_iter+0x252/0x3f0
		[<0>] vfs_write+0x313/0x430
		[<0>] ksys_write+0x6a/0xf0
		[<0>] __x64_sys_write+0x19/0x30
		[<0>] x64_sys_call+0x18ab/0x26f0
		[<0>] do_syscall_64+0x7c/0x170
		[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

Please note that this patch doesn't prevent the HUNG_TASK_WARNING.

Signed-off-by: Etienne Martineau <etmartin4313@gmail.com>
---
 fs/fuse/dev.c                | 100 +++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h             |   8 +++
 fs/fuse/inode.c              |   3 ++
 include/linux/sched/sysctl.h |   8 ++-
 kernel/hung_task.c           |   3 +-
 5 files changed, 119 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 27ccae63495d..73d19de14e51 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -21,6 +21,8 @@
 #include <linux/swap.h>
 #include <linux/splice.h>
 #include <linux/sched.h>
+#include <linux/completion.h>
+#include <linux/sched/sysctl.h>
 
 #define CREATE_TRACE_POINTS
 #include "fuse_trace.h"
@@ -45,14 +47,104 @@ static struct fuse_dev *fuse_get_dev(struct file *file)
 	return READ_ONCE(file->private_data);
 }
 
+static bool request_expired(struct fuse_conn *fc, struct fuse_req *req,
+		int timeout)
+{
+	return time_after(jiffies, req->create_time + timeout);
+}
+
+/*
+ * Prevent hung task timer from firing at us
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
+void fuse_check_timeout(struct work_struct *wk)
+{
+	unsigned long hang_check_timer = sysctl_hung_task_timeout_secs * (HZ / 2);
+	struct fuse_conn *fc = container_of(wk, struct fuse_conn, work.work);
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
+		expired = request_expired(fc, req, hang_check_timer);
+	spin_unlock(&fiq->lock);
+	if (expired)
+		goto abort_conn;
+
+	spin_lock(&fc->bg_lock);
+	req = list_first_entry_or_null(&fc->bg_queue, struct fuse_req, list);
+	if (req)
+		expired = request_expired(fc, req, hang_check_timer);
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
+		if (req && request_expired(fc, req, hang_check_timer))
+			goto fpq_abort;
+
+		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++) {
+			req = list_first_entry_or_null(&fpq->processing[i], struct fuse_req, list);
+			if (req && request_expired(fc, req, hang_check_timer))
+				goto fpq_abort;
+		}
+		spin_unlock(&fpq->lock);
+	}
+	/* Keep the ball rolling */
+	if (atomic_read(&fc->num_waiting) != 0)
+		queue_delayed_work(system_wq, &fc->work, hang_check_timer);
+	spin_unlock(&fc->lock);
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
+	struct fuse_conn *fc = fm->fc;
 	INIT_LIST_HEAD(&req->list);
 	INIT_LIST_HEAD(&req->intr_entry);
 	init_waitqueue_head(&req->waitq);
 	refcount_set(&req->count, 1);
 	__set_bit(FR_PENDING, &req->flags);
 	req->fm = fm;
+	req->create_time = jiffies;
+
+	if (sysctl_hung_task_panic) {
+		spin_lock(&fc->lock);
+		/* Get the ball rolling */
+		queue_delayed_work(system_wq, &fc->work,
+				sysctl_hung_task_timeout_secs * (HZ / 2));
+		spin_unlock(&fc->lock);
+	}
 }
 
 static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t flags)
@@ -200,6 +292,14 @@ static void fuse_put_request(struct fuse_req *req)
 			fuse_drop_waiting(fc);
 		}
 
+		if (sysctl_hung_task_panic) {
+			spin_lock(&fc->lock);
+			/* Stop the timeout check if we are the last request */
+			if (atomic_read(&fc->num_waiting) == 0)
+				cancel_delayed_work_sync(&fc->work);
+			spin_unlock(&fc->lock);
+		}
+
 		fuse_request_free(req);
 	}
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 74744c6f2860..aba3ffd0fb67 100644
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
@@ -923,6 +926,9 @@ struct fuse_conn {
 	/** IDR for backing files ids */
 	struct idr backing_files_map;
 #endif
+
+	/** Request wait timeout check */
+	struct delayed_work work;
 };
 
 /*
@@ -1190,6 +1196,8 @@ void fuse_request_end(struct fuse_req *req);
 /* Abort all requests */
 void fuse_abort_conn(struct fuse_conn *fc);
 void fuse_wait_aborted(struct fuse_conn *fc);
+/* Connection timeout */
+void fuse_check_timeout(struct work_struct *wk);
 
 /**
  * Invalidate inode attributes
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 3ce4f4e81d09..ed96154df0fd 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -23,6 +23,7 @@
 #include <linux/exportfs.h>
 #include <linux/posix_acl.h>
 #include <linux/pid_namespace.h>
+#include <linux/completion.h>
 #include <uapi/linux/magic.h>
 
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
@@ -964,6 +965,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	INIT_LIST_HEAD(&fc->entry);
 	INIT_LIST_HEAD(&fc->devices);
 	atomic_set(&fc->num_waiting, 0);
+	INIT_DELAYED_WORK(&fc->work, fuse_check_timeout);
 	fc->max_background = FUSE_DEFAULT_MAX_BACKGROUND;
 	fc->congestion_threshold = FUSE_DEFAULT_CONGESTION_THRESHOLD;
 	atomic64_set(&fc->khctr, 0);
@@ -1015,6 +1017,7 @@ void fuse_conn_put(struct fuse_conn *fc)
 		if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 			fuse_backing_files_free(fc);
 		call_rcu(&fc->rcu, delayed_release);
+		cancel_delayed_work_sync(&fc->work);
 	}
 }
 EXPORT_SYMBOL_GPL(fuse_conn_put);
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 5a64582b086b..1ed3a511060d 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -5,11 +5,15 @@
 #include <linux/types.h>
 
 #ifdef CONFIG_DETECT_HUNG_TASK
-/* used for hung_task and block/ */
+/* used for hung_task, block/ and fuse */
 extern unsigned long sysctl_hung_task_timeout_secs;
+extern unsigned int sysctl_hung_task_panic;
 #else
 /* Avoid need for ifdefs elsewhere in the code */
-enum { sysctl_hung_task_timeout_secs = 0 };
+enum {
+	sysctl_hung_task_timeout_secs = 0,
+	sysctl_hung_task_panic = 0,
+};
 #endif
 
 enum sched_tunable_scaling {
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index c18717189f32..16602d3754b1 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -78,8 +78,9 @@ static unsigned int __read_mostly sysctl_hung_task_all_cpu_backtrace;
  * Should we panic (and reboot, if panic_timeout= is set) when a
  * hung task is detected:
  */
-static unsigned int __read_mostly sysctl_hung_task_panic =
+unsigned int __read_mostly sysctl_hung_task_panic =
 	IS_ENABLED(CONFIG_BOOTPARAM_HUNG_TASK_PANIC);
+EXPORT_SYMBOL_GPL(sysctl_hung_task_panic);
 
 static int
 hung_task_panic(struct notifier_block *this, unsigned long event, void *ptr)
-- 
2.34.1


