Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39FF91FA8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 21:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfEOT1y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 15:27:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727717AbfEOT1g (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 15:27:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8414A12B43;
        Wed, 15 May 2019 19:27:35 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C59EA600C4;
        Wed, 15 May 2019 19:27:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9648622547D; Wed, 15 May 2019 15:27:29 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, swhiteho@redhat.com
Subject: [PATCH v2 09/30] fuse: add fuse_iqueue_ops callbacks
Date:   Wed, 15 May 2019 15:26:54 -0400
Message-Id: <20190515192715.18000-10-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-1-vgoyal@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 15 May 2019 19:27:35 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

The /dev/fuse device uses fiq->waitq and fasync to signal that requests
are available.  These mechanisms do not apply to virtio-fs.  This patch
introduces callbacks so alternative behavior can be used.

Note that queue_interrupt() changes along these lines:

  spin_lock(&fiq->waitq.lock);
  wake_up_locked(&fiq->waitq);
+ kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
  spin_unlock(&fiq->waitq.lock);
- kill_fasync(&fiq->fasync, SIGIO, POLL_IN);

Since queue_request() and queue_forget() also call kill_fasync() inside
the spinlock this should be safe.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/cuse.c   |  2 +-
 fs/fuse/dev.c    | 50 ++++++++++++++++++++++++++++++++----------------
 fs/fuse/fuse_i.h | 48 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/inode.c  | 16 ++++++++++++----
 4 files changed, 94 insertions(+), 22 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 55a26f351467..a6ed7a036b50 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -504,7 +504,7 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
 	 * Limit the cuse channel to requests that can
 	 * be represented in file->f_cred->user_ns.
 	 */
-	fuse_conn_init(&cc->fc, file->f_cred->user_ns);
+	fuse_conn_init(&cc->fc, file->f_cred->user_ns, &fuse_dev_fiq_ops, NULL);
 
 	fud = fuse_dev_alloc(&cc->fc);
 	if (!fud) {
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 42fd3b576686..ef489beadf58 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -375,13 +375,33 @@ static unsigned int fuse_req_hash(u64 unique)
 	return hash_long(unique & ~FUSE_INT_REQ_BIT, FUSE_PQ_HASH_BITS);
 }
 
-static void queue_request(struct fuse_iqueue *fiq, struct fuse_req *req)
+/**
+ * A new request is available, wake fiq->waitq
+ */
+static void fuse_dev_wake_and_unlock(struct fuse_iqueue *fiq)
+__releases(fiq->waitq.lock)
 {
-	req->in.h.len = sizeof(struct fuse_in_header) +
-		fuse_len_args(req->in.numargs, (struct fuse_arg *) req->in.args);
-	list_add_tail(&req->list, &fiq->pending);
 	wake_up_locked(&fiq->waitq);
 	kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
+	spin_unlock(&fiq->waitq.lock);
+}
+
+const struct fuse_iqueue_ops fuse_dev_fiq_ops = {
+	.wake_forget_and_unlock		= fuse_dev_wake_and_unlock,
+	.wake_interrupt_and_unlock	= fuse_dev_wake_and_unlock,
+	.wake_pending_and_unlock	= fuse_dev_wake_and_unlock,
+};
+EXPORT_SYMBOL_GPL(fuse_dev_fiq_ops);
+
+static void queue_request_and_unlock(struct fuse_iqueue *fiq,
+				     struct fuse_req *req)
+__releases(fiq->waitq.lock)
+{
+	req->in.h.len = sizeof(struct fuse_in_header) +
+		fuse_len_args(req->in.numargs,
+			      (struct fuse_arg *) req->in.args);
+	list_add_tail(&req->list, &fiq->pending);
+	fiq->ops->wake_pending_and_unlock(fiq);
 }
 
 void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
@@ -396,12 +416,11 @@ void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
 	if (fiq->connected) {
 		fiq->forget_list_tail->next = forget;
 		fiq->forget_list_tail = forget;
-		wake_up_locked(&fiq->waitq);
-		kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
+		fiq->ops->wake_forget_and_unlock(fiq);
 	} else {
 		kfree(forget);
+		spin_unlock(&fiq->waitq.lock);
 	}
-	spin_unlock(&fiq->waitq.lock);
 }
 
 static void flush_bg_queue(struct fuse_conn *fc)
@@ -417,8 +436,7 @@ static void flush_bg_queue(struct fuse_conn *fc)
 		fc->active_background++;
 		spin_lock(&fiq->waitq.lock);
 		req->in.h.unique = fuse_get_unique(fiq);
-		queue_request(fiq, req);
-		spin_unlock(&fiq->waitq.lock);
+		queue_request_and_unlock(fiq, req);
 	}
 }
 
@@ -506,10 +524,10 @@ static int queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
 			spin_unlock(&fiq->waitq.lock);
 			return 0;
 		}
-		wake_up_locked(&fiq->waitq);
-		kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
+		fiq->ops->wake_interrupt_and_unlock(fiq);
+	} else {
+		spin_unlock(&fiq->waitq.lock);
 	}
-	spin_unlock(&fiq->waitq.lock);
 	return 0;
 }
 
@@ -569,11 +587,10 @@ static void __fuse_request_send(struct fuse_conn *fc, struct fuse_req *req)
 		req->out.h.error = -ENOTCONN;
 	} else {
 		req->in.h.unique = fuse_get_unique(fiq);
-		queue_request(fiq, req);
 		/* acquire extra reference, since request is still needed
 		   after fuse_request_end() */
 		__fuse_get_request(req);
-		spin_unlock(&fiq->waitq.lock);
+		queue_request_and_unlock(fiq, req);
 
 		request_wait_answer(fc, req);
 		/* Pairs with smp_wmb() in fuse_request_end() */
@@ -706,10 +723,11 @@ static int fuse_request_send_notify_reply(struct fuse_conn *fc,
 	req->in.h.unique = unique;
 	spin_lock(&fiq->waitq.lock);
 	if (fiq->connected) {
-		queue_request(fiq, req);
+		queue_request_and_unlock(fiq, req);
 		err = 0;
+	} else {
+		spin_unlock(&fiq->waitq.lock);
 	}
-	spin_unlock(&fiq->waitq.lock);
 
 	return err;
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 84f094e4ac36..0b578e07156d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -71,6 +71,12 @@ struct fuse_mount_data {
 	unsigned max_read;
 	unsigned blksize;
 
+	/* fuse input queue operations */
+	const struct fuse_iqueue_ops *fiq_ops;
+
+	/* device-specific state for fuse_iqueue */
+	void *fiq_priv;
+
 	/* fuse_dev pointer to fill in, should contain NULL on entry */
 	void **fudptr;
 };
@@ -461,6 +467,39 @@ struct fuse_req {
 	struct file *stolen_file;
 };
 
+struct fuse_iqueue;
+
+/**
+ * Input queue callbacks
+ *
+ * Input queue signalling is device-specific.  For example, the /dev/fuse file
+ * uses fiq->waitq and fasync to wake processes that are waiting on queue
+ * readiness.  These callbacks allow other device types to respond to input
+ * queue activity.
+ */
+struct fuse_iqueue_ops {
+	/**
+	 * Signal that a forget has been queued
+	 */
+	void (*wake_forget_and_unlock)(struct fuse_iqueue *fiq)
+	__releases(fiq->waitq.lock);
+
+	/**
+	 * Signal that an INTERRUPT request has been queued
+	 */
+	void (*wake_interrupt_and_unlock)(struct fuse_iqueue *fiq)
+	__releases(fiq->waitq.lock);
+
+	/**
+	 * Signal that a request has been queued
+	 */
+	void (*wake_pending_and_unlock)(struct fuse_iqueue *fiq)
+	__releases(fiq->waitq.lock);
+};
+
+/** /dev/fuse input queue operations */
+extern const struct fuse_iqueue_ops fuse_dev_fiq_ops;
+
 struct fuse_iqueue {
 	/** Connection established */
 	unsigned connected;
@@ -486,6 +525,12 @@ struct fuse_iqueue {
 
 	/** O_ASYNC requests */
 	struct fasync_struct *fasync;
+
+	/** Device-specific callbacks */
+	const struct fuse_iqueue_ops *ops;
+
+	/** Device-specific state */
+	void *priv;
 };
 
 #define FUSE_PQ_HASH_BITS 8
@@ -997,7 +1042,8 @@ struct fuse_conn *fuse_conn_get(struct fuse_conn *fc);
 /**
  * Initialize fuse_conn
  */
-void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns);
+void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
+		    const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv);
 
 /**
  * Release reference to fuse_conn
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index baf2966a753a..126e77854dac 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -570,7 +570,9 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
-static void fuse_iqueue_init(struct fuse_iqueue *fiq)
+static void fuse_iqueue_init(struct fuse_iqueue *fiq,
+			     const struct fuse_iqueue_ops *ops,
+			     void *priv)
 {
 	memset(fiq, 0, sizeof(struct fuse_iqueue));
 	init_waitqueue_head(&fiq->waitq);
@@ -578,6 +580,8 @@ static void fuse_iqueue_init(struct fuse_iqueue *fiq)
 	INIT_LIST_HEAD(&fiq->interrupts);
 	fiq->forget_list_tail = &fiq->forget_list_head;
 	fiq->connected = 1;
+	fiq->ops = ops;
+	fiq->priv = priv;
 }
 
 static void fuse_pqueue_init(struct fuse_pqueue *fpq)
@@ -591,7 +595,8 @@ static void fuse_pqueue_init(struct fuse_pqueue *fpq)
 	fpq->connected = 1;
 }
 
-void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns)
+void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
+		    const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv)
 {
 	memset(fc, 0, sizeof(*fc));
 	spin_lock_init(&fc->lock);
@@ -601,7 +606,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns)
 	atomic_set(&fc->dev_count, 1);
 	init_waitqueue_head(&fc->blocked_waitq);
 	init_waitqueue_head(&fc->reserved_req_waitq);
-	fuse_iqueue_init(&fc->iq);
+	fuse_iqueue_init(&fc->iq, fiq_ops, fiq_priv);
 	INIT_LIST_HEAD(&fc->bg_queue);
 	INIT_LIST_HEAD(&fc->entry);
 	INIT_LIST_HEAD(&fc->devices);
@@ -1113,7 +1118,8 @@ int fuse_fill_super_common(struct super_block *sb,
 	if (!fc)
 		goto err;
 
-	fuse_conn_init(fc, sb->s_user_ns);
+	fuse_conn_init(fc, sb->s_user_ns, mount_data->fiq_ops,
+		       mount_data->fiq_priv);
 	fc->release = fuse_free_conn;
 
 	fud = fuse_dev_alloc(fc);
@@ -1215,6 +1221,8 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 		goto err_fput;
 	__set_bit(FR_BACKGROUND, &init_req->flags);
 
+	d.fiq_ops = &fuse_dev_fiq_ops;
+	d.fiq_priv = NULL;
 	d.fudptr = &file->private_data;
 	err = fuse_fill_super_common(sb, &d);
 	if (err < 0)
-- 
2.20.1

