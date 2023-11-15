Return-Path: <linux-fsdevel+bounces-2886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 792EF7EBFB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 10:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E98C1F26A3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 09:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6759947F;
	Wed, 15 Nov 2023 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01369455
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 09:49:36 +0000 (UTC)
Received: from out0-210.mail.aliyun.com (out0-210.mail.aliyun.com [140.205.0.210])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FC511C
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 01:49:34 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047206;MF=winters.zc@antgroup.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---.VNyPFhB_1700041772;
Received: from localhost(mailfrom:winters.zc@antgroup.com fp:SMTPD_---.VNyPFhB_1700041772)
          by smtp.aliyun-inc.com;
          Wed, 15 Nov 2023 17:49:32 +0800
From: "Zhao Chen" <winters.zc@antgroup.com>
To: linux-fsdevel@vger.kernel.org
Cc: miklos@szeredi.hu
Subject: [PATCH v2 1/2] fuse: Introduce sysfs API for resend pending reque
Date: Wed, 15 Nov 2023 17:49:29 +0800
Message-Id: <20231115094930.296218-2-winters.zc@antgroup.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231115094930.296218-1-winters.zc@antgroup.com>
References: <20231115094930.296218-1-winters.zc@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peng Tao <bergwolf@antgroup.com>

When a FUSE daemon panic and failover, we aim to minimize the impact on
applications by reusing the existing FUSE connection. During this
process, another daemon is employed to preserve the FUSE connection's file
descriptor.

However, it is possible for some inflight requests to be lost and never
returned. As a result, applications awaiting replies would become stuck
forever. To address this, we can resend these pending requests to the
FUSE daemon, which is done by fuse_resend_pqueue(), ensuring they are
properly processed again.

Signed-off-by: Peng Tao <bergwolf@antgroup.com>
Signed-off-by: Zhao Chen <winters.zc@antgroup.com>
---
 fs/fuse/control.c | 20 ++++++++++++++++
 fs/fuse/dev.c     | 59 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h  |  5 +++-
 3 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 284a35006462..fd2258d701dd 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -44,6 +44,18 @@ static ssize_t fuse_conn_abort_write(struct file *file, const char __user *buf,
 	return count;
 }
 
+static ssize_t fuse_conn_resend_write(struct file *file, const char __user *buf,
+				      size_t count, loff_t *ppos)
+{
+	struct fuse_conn *fc = fuse_ctl_file_conn_get(file);
+
+	if (fc) {
+		fuse_resend_pqueue(fc);
+		fuse_conn_put(fc);
+	}
+	return count;
+}
+
 static ssize_t fuse_conn_waiting_read(struct file *file, char __user *buf,
 				      size_t len, loff_t *ppos)
 {
@@ -190,6 +202,12 @@ static const struct file_operations fuse_ctl_abort_ops = {
 	.llseek = no_llseek,
 };
 
+static const struct file_operations fuse_ctl_resend_ops = {
+	.open = nonseekable_open,
+	.write = fuse_conn_resend_write,
+	.llseek = no_llseek,
+};
+
 static const struct file_operations fuse_ctl_waiting_ops = {
 	.open = nonseekable_open,
 	.read = fuse_conn_waiting_read,
@@ -274,6 +292,8 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
 				 NULL, &fuse_ctl_waiting_ops) ||
 	    !fuse_ctl_add_dentry(parent, fc, "abort", S_IFREG | 0200, 1,
 				 NULL, &fuse_ctl_abort_ops) ||
+	    !fuse_ctl_add_dentry(parent, fc, "resend", S_IFREG | 0200, 1,
+				 NULL, &fuse_ctl_resend_ops) ||
 	    !fuse_ctl_add_dentry(parent, fc, "max_background", S_IFREG | 0600,
 				 1, NULL, &fuse_conn_max_background_ops) ||
 	    !fuse_ctl_add_dentry(parent, fc, "congestion_threshold",
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1a8f82f478cb..c91cb2bd511b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2223,6 +2223,65 @@ int fuse_dev_release(struct inode *inode, struct file *file)
 }
 EXPORT_SYMBOL_GPL(fuse_dev_release);
 
+/*
+ * Resending all processing queue requests.
+ *
+ * In the event of a FUSE daemon panic and failover, we aim to minimize the
+ * impact on applications by reusing the existing FUSE connection. During this
+ * process, another daemon is employed to preserve the FUSE connection's file
+ * descriptor.
+ *
+ * However, it is possible for some inflight requests to be lost and never
+ * returned. As a result, applications awaiting replies would become stuck
+ * forever. To address this, we can resend these pending requests to the FUSE
+ * daemon, ensuring they are properly processed again.
+ *
+ * Please note that this strategy is applicable only to idempotent requests or
+ * if the FUSE daemon takes careful measures to avoid processing duplicated
+ * non-idempotent requests.
+ */
+void fuse_resend_pqueue(struct fuse_conn *fc)
+{
+	struct fuse_dev *fud;
+	struct fuse_req *req, *next;
+	struct fuse_iqueue *fiq = &fc->iq;
+	LIST_HEAD(to_queue);
+	unsigned int i;
+
+	spin_lock(&fc->lock);
+	if (!fc->connected) {
+		spin_unlock(&fc->lock);
+		return;
+	}
+
+	list_for_each_entry(fud, &fc->devices, entry) {
+		struct fuse_pqueue *fpq = &fud->pq;
+
+		spin_lock(&fpq->lock);
+		list_for_each_entry_safe(req, next, &fpq->io, list) {
+			spin_lock(&req->waitq.lock);
+			if (!test_bit(FR_LOCKED, &req->flags)) {
+				__fuse_get_request(req);
+				list_move(&req->list, &to_queue);
+			}
+			spin_unlock(&req->waitq.lock);
+		}
+		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++)
+			list_splice_tail_init(&fpq->processing[i], &to_queue);
+		spin_unlock(&fpq->lock);
+	}
+	spin_unlock(&fc->lock);
+
+	list_for_each_entry_safe(req, next, &to_queue, list) {
+		__set_bit(FR_PENDING, &req->flags);
+	}
+
+	spin_lock(&fiq->lock);
+	/* iq and pq requests are both oldest to newest */
+	list_splice(&to_queue, &fiq->pending);
+	fiq->ops->wake_pending_and_unlock(fiq);
+}
+
 static int fuse_dev_fasync(int fd, struct file *file, int on)
 {
 	struct fuse_dev *fud = fuse_get_dev(file);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1df83eebda92..5142537c3471 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -45,7 +45,7 @@
 #define FUSE_NAME_MAX 1024
 
 /** Number of dentries for each connection in the control filesystem */
-#define FUSE_CTL_NUM_DENTRIES 5
+#define FUSE_CTL_NUM_DENTRIES 6
 
 /** List of active connections */
 extern struct list_head fuse_conn_list;
@@ -1122,6 +1122,9 @@ void fuse_request_end(struct fuse_req *req);
 void fuse_abort_conn(struct fuse_conn *fc);
 void fuse_wait_aborted(struct fuse_conn *fc);
 
+/* Resend all requests in processing queue so they can represent to userspace */
+void fuse_resend_pqueue(struct fuse_conn *fc);
+
 /**
  * Invalidate inode attributes
  */
-- 
2.32.0.3.g01195cf9f


