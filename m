Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFD24691BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 09:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239624AbhLFIvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 03:51:09 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:33786 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239616AbhLFIvJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638780461; x=1670316461;
  h=from:to:cc:subject:date:message-id;
  bh=fIK00iL2CMcq5agFccrsssgX3o8eNDJnqOT0OhIAeWo=;
  b=TMuCEKVMqL64HM1vpSWWX1mI42z5miK+BKJo6RG5vVsJV0JlsM+0KlNZ
   1R1j3ZsJnlEO1Ww59hgws7PjR0qHs/n784ZK4kJP77d+1uQZvkpnd1NCF
   VIzG9k9Qvc6fyWw9hAIeCiJRQH7yEcdNcT4D9tPjRQxCJx8zf0bogglsm
   w=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 06 Dec 2021 00:47:41 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 06 Dec 2021 00:47:25 -0800
X-QCInternal: smtphost
Received: from hydcbspbld03.qualcomm.com ([10.242.221.48])
  by ironmsg02-blr.qualcomm.com with ESMTP; 06 Dec 2021 14:17:08 +0530
Received: by hydcbspbld03.qualcomm.com (Postfix, from userid 2304101)
        id D0E7021E56; Mon,  6 Dec 2021 14:17:06 +0530 (IST)
From:   Pradeep P V K <quic_pragalla@quicinc.com>
To:     miklos@szeredi.hu
Cc:     quic_stummala@quicinc.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_sayalil@quicinc.com, quic_aiquny@quicinc.com,
        quic_zljing@quicinc.com, quic_blong@quicinc.com,
        quic_richardp@quicinc.com, quic_cdevired@quicinc.com,
        Pradeep P V K <quic_pragalla@quicinc.com>
Subject: [PATCH V1] fuse: give wakeup hints to the scheduler
Date:   Mon,  6 Dec 2021 14:16:45 +0530
Message-Id: <1638780405-38026-1-git-send-email-quic_pragalla@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The synchronous wakeup interface is available only for the
interruptible wakeup. Add it for normal wakeup and use this
synchronous wakeup interface to wakeup the userspace daemon.
Scheduler can make use of this hint to find a better CPU for
the waker task.

With this change the performance numbers for compress, decompress
and copy use-cases on /sdcard path has improved by ~30%.

Use-case details:
1. copy 10000 files of each 4k size into /sdcard path
2. use any File explorer application that has compress/decompress
support
3. start compress/decompress and capture the time.

-------------------------------------------------
| Default   | wakeup support | Improvement/Diff |
-------------------------------------------------
| 13.8 sec  | 9.9 sec        | 3.9 sec (28.26%) |
-------------------------------------------------

Co-developed-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Signed-off-by: Pradeep P V K <quic_pragalla@quicinc.com>
---
 fs/fuse/dev.c        | 22 +++++++++++++---------
 fs/fuse/fuse_i.h     |  6 +++---
 fs/fuse/virtio_fs.c  |  8 +++++---
 include/linux/wait.h |  1 +
 4 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index cd54a52..fef2e23 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -207,10 +207,13 @@ static unsigned int fuse_req_hash(u64 unique)
 /**
  * A new request is available, wake fiq->waitq
  */
-static void fuse_dev_wake_and_unlock(struct fuse_iqueue *fiq)
+static void fuse_dev_wake_and_unlock(struct fuse_iqueue *fiq, bool sync)
 __releases(fiq->lock)
 {
-	wake_up(&fiq->waitq);
+	if (sync)
+		wake_up_sync(&fiq->waitq);
+	else
+		wake_up(&fiq->waitq);
 	kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
 	spin_unlock(&fiq->lock);
 }
@@ -223,14 +226,15 @@ const struct fuse_iqueue_ops fuse_dev_fiq_ops = {
 EXPORT_SYMBOL_GPL(fuse_dev_fiq_ops);
 
 static void queue_request_and_unlock(struct fuse_iqueue *fiq,
-				     struct fuse_req *req)
+				     struct fuse_req *req,
+				     bool sync)
 __releases(fiq->lock)
 {
 	req->in.h.len = sizeof(struct fuse_in_header) +
 		fuse_len_args(req->args->in_numargs,
 			      (struct fuse_arg *) req->args->in_args);
 	list_add_tail(&req->list, &fiq->pending);
-	fiq->ops->wake_pending_and_unlock(fiq);
+	fiq->ops->wake_pending_and_unlock(fiq, sync);
 }
 
 void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
@@ -245,7 +249,7 @@ void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
 	if (fiq->connected) {
 		fiq->forget_list_tail->next = forget;
 		fiq->forget_list_tail = forget;
-		fiq->ops->wake_forget_and_unlock(fiq);
+		fiq->ops->wake_forget_and_unlock(fiq, 0);
 	} else {
 		kfree(forget);
 		spin_unlock(&fiq->lock);
@@ -265,7 +269,7 @@ static void flush_bg_queue(struct fuse_conn *fc)
 		fc->active_background++;
 		spin_lock(&fiq->lock);
 		req->in.h.unique = fuse_get_unique(fiq);
-		queue_request_and_unlock(fiq, req);
+		queue_request_and_unlock(fiq, req, 0);
 	}
 }
 
@@ -358,7 +362,7 @@ static int queue_interrupt(struct fuse_req *req)
 			spin_unlock(&fiq->lock);
 			return 0;
 		}
-		fiq->ops->wake_interrupt_and_unlock(fiq);
+		fiq->ops->wake_interrupt_and_unlock(fiq, 0);
 	} else {
 		spin_unlock(&fiq->lock);
 	}
@@ -425,7 +429,7 @@ static void __fuse_request_send(struct fuse_req *req)
 		/* acquire extra reference, since request is still needed
 		   after fuse_request_end() */
 		__fuse_get_request(req);
-		queue_request_and_unlock(fiq, req);
+		queue_request_and_unlock(fiq, req, 1);
 
 		request_wait_answer(req);
 		/* Pairs with smp_wmb() in fuse_request_end() */
@@ -600,7 +604,7 @@ static int fuse_simple_notify_reply(struct fuse_mount *fm,
 
 	spin_lock(&fiq->lock);
 	if (fiq->connected) {
-		queue_request_and_unlock(fiq, req);
+		queue_request_and_unlock(fiq, req, 0);
 	} else {
 		err = -ENODEV;
 		spin_unlock(&fiq->lock);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c1a8b31..363e0ba 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -389,19 +389,19 @@ struct fuse_iqueue_ops {
 	/**
 	 * Signal that a forget has been queued
 	 */
-	void (*wake_forget_and_unlock)(struct fuse_iqueue *fiq)
+	void (*wake_forget_and_unlock)(struct fuse_iqueue *fiq, bool sync)
 		__releases(fiq->lock);
 
 	/**
 	 * Signal that an INTERRUPT request has been queued
 	 */
-	void (*wake_interrupt_and_unlock)(struct fuse_iqueue *fiq)
+	void (*wake_interrupt_and_unlock)(struct fuse_iqueue *fiq, bool sync)
 		__releases(fiq->lock);
 
 	/**
 	 * Signal that a request has been queued
 	 */
-	void (*wake_pending_and_unlock)(struct fuse_iqueue *fiq)
+	void (*wake_pending_and_unlock)(struct fuse_iqueue *fiq, bool sync)
 		__releases(fiq->lock);
 
 	/**
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4cfa4bc..bdc3dcc 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -972,7 +972,7 @@ static struct virtio_driver virtio_fs_driver = {
 #endif
 };
 
-static void virtio_fs_wake_forget_and_unlock(struct fuse_iqueue *fiq)
+static void virtio_fs_wake_forget_and_unlock(struct fuse_iqueue *fiq, bool sync)
 __releases(fiq->lock)
 {
 	struct fuse_forget_link *link;
@@ -1007,7 +1007,8 @@ __releases(fiq->lock)
 	kfree(link);
 }
 
-static void virtio_fs_wake_interrupt_and_unlock(struct fuse_iqueue *fiq)
+static void virtio_fs_wake_interrupt_and_unlock(struct fuse_iqueue *fiq,
+						bool sync)
 __releases(fiq->lock)
 {
 	/*
@@ -1222,7 +1223,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	return ret;
 }
 
-static void virtio_fs_wake_pending_and_unlock(struct fuse_iqueue *fiq)
+static void virtio_fs_wake_pending_and_unlock(struct fuse_iqueue *fiq,
+					bool sync)
 __releases(fiq->lock)
 {
 	unsigned int queue_id = VQ_REQUEST; /* TODO multiqueue */
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 2d0df57..690572ee 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -228,6 +228,7 @@ void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode);
 #define wake_up_interruptible_nr(x, nr)	__wake_up(x, TASK_INTERRUPTIBLE, nr, NULL)
 #define wake_up_interruptible_all(x)	__wake_up(x, TASK_INTERRUPTIBLE, 0, NULL)
 #define wake_up_interruptible_sync(x)	__wake_up_sync((x), TASK_INTERRUPTIBLE)
+#define wake_up_sync(x)			__wake_up_sync(x, TASK_NORMAL)
 
 /*
  * Wakeup macros to be used to report events to the targets.
-- 
2.7.4

