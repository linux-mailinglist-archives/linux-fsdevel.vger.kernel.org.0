Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 512D9A67A5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 13:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfICLmO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 07:42:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729068AbfICLmO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:42:14 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 466DC85365
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2019 11:42:13 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id o11so10240471wrq.22
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 04:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0x8qDwpkzp8hPqMYiq7wJpXIGMjYgitiz9e6L8AggZE=;
        b=CEP0/krdAAdgOVMIQukx8uKqTRsiO35IXHlUKwyc769DACwefJllRH6nrqlk/qnTlA
         icViKKouYahy48Kbddv/QF6gPobidNKxAAVRhuxglLiJ6c7u5Mg2GpMRMVAOO6M6x/VC
         HIToiEq6KUyuSIhNwjHBiGdy1ItqcP6f+OmUmnUvCXwGgxoH0RXoxk4pLZafCW6Z5D/n
         9WbQvnF6oJ3bEZKwpC8M/SM8rqOZXyA4YSHnR1H8CqvEGRbarFHFzXgs/vg6eoBuXp9i
         L1a4c+c3QkEA3yUWwX6o85wr3f7hoDWFEV2AVaJvdqsH8OLYyQIEJSLx0QpWf4vi8lbr
         9wSw==
X-Gm-Message-State: APjAAAVreZJBQNoUk13mJvLK/Ik9wkHJyOAfdvzJ0t+fZNUDGV2BRUv/
        Q/pGPncF4aNjuiCRMP3znMUjH7bk+ASRFbTWrRxbHlfJl4+81J/mykzp6TXr7ngS5YMRhh7oAeF
        cg/7goQTXxilOB6v90Bm4JVDcJw==
X-Received: by 2002:a7b:c5d1:: with SMTP id n17mr38607378wmk.164.1567510931865;
        Tue, 03 Sep 2019 04:42:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxix6xifnIa/uSOy91E2XmPVqVDUXLvawz0YDDoCn/GOJvP0CtO+2mgDZGmPzbWh+0e183fdg==
X-Received: by 2002:a7b:c5d1:: with SMTP id n17mr38607334wmk.164.1567510931534;
        Tue, 03 Sep 2019 04:42:11 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id x6sm2087551wmf.38.2019.09.03.04.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:42:10 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v4 10/16] fuse: add fuse_iqueue_ops callbacks
Date:   Tue,  3 Sep 2019 13:41:57 +0200
Message-Id: <20190903114203.8278-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903113640.7984-1-mszeredi@redhat.com>
References: <20190903113640.7984-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

The /dev/fuse device uses fiq->waitq and fasync to signal that requests are
available.  These mechanisms do not apply to virtio-fs.  This patch
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
 fs/fuse/fuse_i.h | 42 +++++++++++++++++++++++++++++++++++++++-
 fs/fuse/inode.c  | 13 +++++++++----
 4 files changed, 85 insertions(+), 22 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index d011a1ad1d4f..7bad5d428ce1 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -503,7 +503,7 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
 	 * Limit the cuse channel to requests that can
 	 * be represented in file->f_cred->user_ns.
 	 */
-	fuse_conn_init(&cc->fc, file->f_cred->user_ns);
+	fuse_conn_init(&cc->fc, file->f_cred->user_ns, &fuse_dev_fiq_ops, NULL);
 
 	fud = fuse_dev_alloc(&cc->fc);
 	if (!fud) {
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index c0c30a225e78..0bdb98a3b251 100644
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
index d0c8f131fb5d..617eca6046d2 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -446,6 +446,39 @@ struct fuse_req {
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
+		__releases(fiq->waitq.lock);
+
+	/**
+	 * Signal that an INTERRUPT request has been queued
+	 */
+	void (*wake_interrupt_and_unlock)(struct fuse_iqueue *fiq)
+		__releases(fiq->waitq.lock);
+
+	/**
+	 * Signal that a request has been queued
+	 */
+	void (*wake_pending_and_unlock)(struct fuse_iqueue *fiq)
+		__releases(fiq->waitq.lock);
+};
+
+/** /dev/fuse input queue operations */
+extern const struct fuse_iqueue_ops fuse_dev_fiq_ops;
+
 struct fuse_iqueue {
 	/** Connection established */
 	unsigned connected;
@@ -471,6 +504,12 @@ struct fuse_iqueue {
 
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
@@ -1009,7 +1048,8 @@ struct fuse_conn *fuse_conn_get(struct fuse_conn *fc);
 /**
  * Initialize fuse_conn
  */
-void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns);
+void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
+		    const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv);
 
 /**
  * Release reference to fuse_conn
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 048816c95b69..e42e600e885b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -569,7 +569,9 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
-static void fuse_iqueue_init(struct fuse_iqueue *fiq)
+static void fuse_iqueue_init(struct fuse_iqueue *fiq,
+			     const struct fuse_iqueue_ops *ops,
+			     void *priv)
 {
 	memset(fiq, 0, sizeof(struct fuse_iqueue));
 	init_waitqueue_head(&fiq->waitq);
@@ -577,6 +579,8 @@ static void fuse_iqueue_init(struct fuse_iqueue *fiq)
 	INIT_LIST_HEAD(&fiq->interrupts);
 	fiq->forget_list_tail = &fiq->forget_list_head;
 	fiq->connected = 1;
+	fiq->ops = ops;
+	fiq->priv = priv;
 }
 
 static void fuse_pqueue_init(struct fuse_pqueue *fpq)
@@ -590,7 +594,8 @@ static void fuse_pqueue_init(struct fuse_pqueue *fpq)
 	fpq->connected = 1;
 }
 
-void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns)
+void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
+		    const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv)
 {
 	memset(fc, 0, sizeof(*fc));
 	spin_lock_init(&fc->lock);
@@ -600,7 +605,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns)
 	atomic_set(&fc->dev_count, 1);
 	init_waitqueue_head(&fc->blocked_waitq);
 	init_waitqueue_head(&fc->reserved_req_waitq);
-	fuse_iqueue_init(&fc->iq);
+	fuse_iqueue_init(&fc->iq, fiq_ops, fiq_priv);
 	INIT_LIST_HEAD(&fc->bg_queue);
 	INIT_LIST_HEAD(&fc->entry);
 	INIT_LIST_HEAD(&fc->devices);
@@ -1205,7 +1210,7 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 	if (!fc)
 		goto err_free_init_req;
 
-	fuse_conn_init(fc, sb->s_user_ns);
+	fuse_conn_init(fc, sb->s_user_ns, &fuse_dev_fiq_ops, NULL);
 	fc->release = fuse_free_conn;
 	sb->s_fs_info = fc;
 
-- 
2.21.0

