Return-Path: <linux-fsdevel+bounces-36970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487A59EB823
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 18:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0DF1888BF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 17:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EC823025C;
	Tue, 10 Dec 2024 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyS+SVzq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007DF22FACA
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851023; cv=none; b=UblysrWMXFMrxlAUuetGDNjogCQ5ajXpTi0KDY1f7eJARPx4Kdm+VUgRGvyXMrHFgWPsCu9q8r5d1S6t7KkJ/d+14OWB9wl2KNBXB683S0UMAJ1p4ANjkTFs/LTh8bJCUv0Z9fTo/Q7pjfcgT7ZidYPVOZtblS1xN7OE4falsis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851023; c=relaxed/simple;
	bh=0bSUPDvOcN3UkTpGhyxWL2blohaOlSs+apj+crfUhYM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iwh0+/0+BVLayNllr/4MCOazqvcCEp4Q9PB5lYmPEQhpLt+S1HGU8IjC9g+skyjLMQl/v5MaWLaiRKDp5010+uSIuINZO9Cd/VKs9gXxiUeM9TI3ymzvty+XBc7rLMQUCT/f1FFP7RrpHC4UIVC7XiwufgVJuZB8q6yYBENKJeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyS+SVzq; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-46750537450so25943461cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 09:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733851021; x=1734455821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6Glait0CeGW+XUQGdqtpv9R4Ac+Y7T3+AYUepPlzqM=;
        b=RyS+SVzqkbkltSCw2jEe6c3Kh3ZW+1YMJud0xuSz/Mf+oC059mdfe2BXBYCrkQHvep
         tzsZLH6TkYtZi9RghF89iwsaZwjPXRKi8FJVnsJdn1IiSo3mc3y0za5cFSSrPyQ9ehXi
         loTkVjeBdZ2Lojw0KBA46J22ocilsO1Hyt23HGLHDcZR++YL665iK+nZzm/w0W0ReDmR
         vmnX/PaM9kwF9SwM2ekKTKYBzjiVtMfHykjz0g9wZyD+143crJ/uabHfK79ZxRZdFpYW
         x1hVrJZpDTtjjrcrSImy0g28RcGuddP3spKKF9QNusYSPOzpl24kDuBTxyHJ6M+ocjdE
         mnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733851021; x=1734455821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z6Glait0CeGW+XUQGdqtpv9R4Ac+Y7T3+AYUepPlzqM=;
        b=Q3W1b+Dk01niU2n701gVzvT6nRvmhyRPwZt3egT1RJr2gkDXItGcCnjp+7O0n/K669
         SGzSJzfKfNSPjY4BT91GV+/Woyi+NS7dZ8tYCorm3O7hTiJh1A2KwHTUXLBK5JtONG0p
         MXnPI7+bUcBoFAU5Wv06vX9X2KxdPFrXEuNm5Z1dmXa44DUjbGRN1K0+PK/edB5+UlcY
         AnpkisZC76hOB7EptgZ7KGw/Owo+sOVHwNN/zU+q4VxbylhOpzJfLWmTDBIJ30n8/SQh
         GsaPL221x4CviV3e25bilRuUqPxNPKC+kFdJCegvPcsbGd7W4zBYpghZEKz2shEMnoW8
         sQyg==
X-Gm-Message-State: AOJu0YxDrw5IIcjuOTx26q1tpkYkmSqLWHlJgSXtkVxQIbzpSJrQFZN6
	9yQLMghEO2SzP+nFa3PBueUD76inRpdAo8Hev3l4XBiLiMMQykxdNW/0FQ==
X-Gm-Gg: ASbGncvl+zzCZ2zeJYMqbZBqUjweVoZqeE4YtjrCvOKCeXx5L+PA7wR1cjOlDpTyOYc
	Y07XUrn2lGKxfkALSKNmU68f1mulU3Z1+jARwh7qPfJII/0CCWHe3nTkdk/9W56JtCTNmJg9kzo
	+tO6Hzg97O4UKXAHIyUTmw4abu+vFJWrtDCOE5ZI7n8+47OJb62xK4RPr8a6Eo8deggAPGLroO3
	3r8ySnRUI0wQ5trcMZfP31eEYOoEsXwuB2XUsdWC0uSAOHrmOnsNwC4ezdqKZtw88Qe8xYmiYLe
	dpxvXPV89Z0KLbB9tyRtko7UVziAKCEn1dO7cWww7Wl1rfcBrktbBVq/P5+u
X-Google-Smtp-Source: AGHT+IEQwf9axaUjvT6LDccLsc1TOlRtzCIrPh5e4BbS2EBFx0WlnqC3LGdkjLPLBpcUa4zTN8NgUg==
X-Received: by 2002:a05:622a:1104:b0:460:9ac7:8fcd with SMTP id d75a77b69052e-46771e95c73mr79998611cf.1.1733851020503;
        Tue, 10 Dec 2024 09:17:00 -0800 (PST)
Received: from localhost.localdomain (lnsm3-toronto63-142-127-175-73.internet.virginmobile.ca. [142.127.175.73])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46761e8c79bsm25452361cf.49.2024.12.10.09.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:17:00 -0800 (PST)
From: etmartin4313@gmail.com
To: linux-fsdevel@vger.kernel.org,
	miklos@szeredi.hu
Cc: joannelkoong@gmail.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	laoar.shao@gmail.com,
	etmartin@cisco.com,
	Etienne Martineau <etmartin4313@gmail.com>
Subject: [PATCH] fuse: Abort connection if FUSE server get stuck
Date: Tue, 10 Dec 2024 12:16:21 -0500
Message-Id: <20241210171621.64645-1-etmartin4313@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Etienne Martineau <etmartin4313@gmail.com>

This patch abort connection if HUNG_TASK_PANIC is set and a FUSE server
is getting stuck for too long.

Without this patch, an unresponsive / buggy / malicious FUSE server can
leave the clients in D state for a long period of time and on system where
HUNG_TASK_PANIC is set, trigger a catastrophic reload.

So, if HUNG_TASK_PANIC checking is enabled, we should wake up periodically
to abort connections that exceed the timeout value which is define to be
half the HUNG_TASK_TIMEOUT period, which keeps overhead low.

This patch introduce a list of request waiting for answer that is time
sorted to minimize the overhead.

When HUNG_TASK_PANIC is enable there is a timeout check per connection
that is running at low frequency only if there are active FUSE request
pending.

A FUSE client can get into D state as such ( see below Scenario #1 / #2 )
 1) request_wait_answer() -> wait_event() is UNINTERRUPTIBLE
    OR
 2) request_wait_answer() -> wait_event_(interruptible / killable) is head
    of line blocking for subsequent clients accessing the same file

	Scenario #1:
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

	Scenario #2:
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
 fs/fuse/dev.c                | 56 ++++++++++++++++++++++++++++++++++--
 fs/fuse/fuse_i.h             | 14 +++++++++
 fs/fuse/inode.c              |  4 +++
 include/linux/sched/sysctl.h |  8 ++++--
 kernel/hung_task.c           |  3 +-
 5 files changed, 79 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 27ccae63495d..294b6ad8a90f 100644
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
@@ -418,18 +420,56 @@ static int queue_interrupt(struct fuse_req *req)
 	return 0;
 }
 
+/*
+ * Prevent hung task timer from firing at us
+ * Periodically poll the request waiting list on a per-connection basis
+ * and abort if the oldest request exceed the timeout. The oldest request
+ * is the first element on the list by definition
+ */
+void fuse_wait_answer_timeout(struct work_struct *wk)
+{
+	unsigned long hang_check_timer = sysctl_hung_task_timeout_secs * (HZ / 2);
+	struct fuse_conn *fc = container_of(wk, struct fuse_conn, work.work);
+	struct fuse_req *req;
+
+	spin_lock(&fc->lock);
+	req = list_first_entry_or_null(&fc->req_waiting, struct fuse_req, timeout_list);
+	if (req && time_after(jiffies, req->wait_start + hang_check_timer)) {
+		spin_unlock(&fc->lock);
+		fuse_abort_conn(fc);
+		return;
+	}
+
+	/* Keep the ball rolling but don't re-arm when only one req is pending */
+	if (atomic_read(&fc->num_waiting) != 1)
+		queue_delayed_work(system_wq, &fc->work, hang_check_timer);
+	spin_unlock(&fc->lock);
+}
+
 static void request_wait_answer(struct fuse_req *req)
 {
+	unsigned long hang_check_timer = sysctl_hung_task_timeout_secs * (HZ / 2);
+	unsigned int hang_check = sysctl_hung_task_panic;
 	struct fuse_conn *fc = req->fm->fc;
 	struct fuse_iqueue *fiq = &fc->iq;
 	int err;
 
+	if (hang_check) {
+		spin_lock(&fc->lock);
+		/* Get the ball rolling if we are the first request */
+		if (atomic_read(&fc->num_waiting) == 1)
+			queue_delayed_work(system_wq, &fc->work, hang_check_timer);
+		req->wait_start = jiffies;
+		list_add_tail(&req->timeout_list, &fc->req_waiting);
+		spin_unlock(&fc->lock);
+	}
+
 	if (!fc->no_interrupt) {
 		/* Any signal may interrupt this */
 		err = wait_event_interruptible(req->waitq,
 					test_bit(FR_FINISHED, &req->flags));
 		if (!err)
-			return;
+			goto out;
 
 		set_bit(FR_INTERRUPTED, &req->flags);
 		/* matches barrier in fuse_dev_do_read() */
@@ -443,7 +483,7 @@ static void request_wait_answer(struct fuse_req *req)
 		err = wait_event_killable(req->waitq,
 					test_bit(FR_FINISHED, &req->flags));
 		if (!err)
-			return;
+			goto out;
 
 		spin_lock(&fiq->lock);
 		/* Request is not yet in userspace, bail out */
@@ -452,7 +492,7 @@ static void request_wait_answer(struct fuse_req *req)
 			spin_unlock(&fiq->lock);
 			__fuse_put_request(req);
 			req->out.h.error = -EINTR;
-			return;
+			goto out;
 		}
 		spin_unlock(&fiq->lock);
 	}
@@ -462,6 +502,16 @@ static void request_wait_answer(struct fuse_req *req)
 	 * Wait it out.
 	 */
 	wait_event(req->waitq, test_bit(FR_FINISHED, &req->flags));
+
+out:
+	if (hang_check) {
+		spin_lock(&fc->lock);
+		/* Stop the timeout check if we are the last request */
+		if (atomic_read(&fc->num_waiting) == 1)
+			cancel_delayed_work_sync(&fc->work);
+		list_del(&req->timeout_list);
+		spin_unlock(&fc->lock);
+	}
 }
 
 static void __fuse_request_send(struct fuse_req *req)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 74744c6f2860..7cbfbd8e4e54 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -438,6 +438,12 @@ struct fuse_req {
 
 	/** fuse_mount this request belongs to */
 	struct fuse_mount *fm;
+
+	/** Entry on req_waiting list */
+	struct list_head timeout_list;
+
+	/** Wait start time in jiffies */
+	unsigned long wait_start;
 };
 
 struct fuse_iqueue;
@@ -923,6 +929,12 @@ struct fuse_conn {
 	/** IDR for backing files ids */
 	struct idr backing_files_map;
 #endif
+
+	/** Request wait timeout */
+	struct delayed_work work;
+
+	/** List of request waiting for answer */
+	struct list_head req_waiting;
 };
 
 /*
@@ -1190,6 +1202,8 @@ void fuse_request_end(struct fuse_req *req);
 /* Abort all requests */
 void fuse_abort_conn(struct fuse_conn *fc);
 void fuse_wait_aborted(struct fuse_conn *fc);
+/* Connection timeout */
+void fuse_wait_answer_timeout(struct work_struct *wk);
 
 /**
  * Invalidate inode attributes
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 3ce4f4e81d09..ce78c2b5ad8c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -23,6 +23,7 @@
 #include <linux/exportfs.h>
 #include <linux/posix_acl.h>
 #include <linux/pid_namespace.h>
+#include <linux/completion.h>
 #include <uapi/linux/magic.h>
 
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
@@ -964,6 +965,8 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	INIT_LIST_HEAD(&fc->entry);
 	INIT_LIST_HEAD(&fc->devices);
 	atomic_set(&fc->num_waiting, 0);
+	INIT_DELAYED_WORK(&fc->work, fuse_wait_answer_timeout);
+	INIT_LIST_HEAD(&fc->req_waiting);
 	fc->max_background = FUSE_DEFAULT_MAX_BACKGROUND;
 	fc->congestion_threshold = FUSE_DEFAULT_CONGESTION_THRESHOLD;
 	atomic64_set(&fc->khctr, 0);
@@ -1015,6 +1018,7 @@ void fuse_conn_put(struct fuse_conn *fc)
 		if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 			fuse_backing_files_free(fc);
 		call_rcu(&fc->rcu, delayed_release);
+		cancel_delayed_work_sync(&fc->work);
 	}
 }
 EXPORT_SYMBOL_GPL(fuse_conn_put);
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 5a64582b086b..65ab6313fe74 100644
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


