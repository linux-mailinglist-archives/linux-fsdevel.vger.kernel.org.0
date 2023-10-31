Return-Path: <linux-fsdevel+bounces-1647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834D17DCF60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 15:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA28280F83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 14:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4731DFC2;
	Tue, 31 Oct 2023 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E194A1C69D
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 14:41:17 +0000 (UTC)
Received: from out0-202.mail.aliyun.com (out0-202.mail.aliyun.com [140.205.0.202])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED03EA
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 07:41:14 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047193;MF=winters.zc@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.VC.yDYS_1698763270;
Received: from localhost(mailfrom:winters.zc@antgroup.com fp:SMTPD_---.VC.yDYS_1698763270)
          by smtp.aliyun-inc.com;
          Tue, 31 Oct 2023 22:41:11 +0800
From: "=?UTF-8?B?6LW15pmo?=" <winters.zc@antgroup.com>
To: linux-fsdevel@vger.kernel.org
Cc:  <miklos@szeredi.hu>,
  "Ma Jie Yue" <majieyue@linux.alibaba.com>,
  "Joseph Qi" <joseph.qi@linux.alibaba.com>,
  "Hao Xu" <haoxu@linux.alibaba.com>,
  "=?UTF-8?B?6LW15pmo?=" <winters.zc@antgroup.com>
Subject: [PATCH v[n] 1/2] fuse: Introduce sysfs API for flushing pending requests
Date: Tue, 31 Oct 2023 22:40:42 +0800
Message-Id: <20231031144043.68534-2-winters.zc@antgroup.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231031144043.68534-1-winters.zc@antgroup.com>
References: <20231031144043.68534-1-winters.zc@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ma Jie Yue <majieyue@linux.alibaba.com>

In certain scenarios, to enhance availability, a new FUSE userspace
daemon is launched to continue providing services after a crash of the
previous daemon. This is achieved by performing an fd takeover from a
dedicated watchdog daemon. However, if some inflight requests are lost
during the crash, the application becomes stuck as it never receives a
reply.

To address this issue, this commit introduces a sysfs API that allows
for flushing these pending requests after a daemon crash, prior to
initiating the recovery procedure. Instead of remaining stuck, the flush
operation returns an error to the application, causing the inflight
requests to fail quickly.

While returning an error may not be suitable for all scenarios, we have
also submitted a separate patch to enable the ability to resend the
inflight requests.

Signed-off-by: Ma Jie Yue <majieyue@linux.alibaba.com>
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
Signed-off-by: Zhao Chen <winters.zc@antgroup.com>
---
 fs/fuse/control.c | 20 ++++++++++++++++++++
 fs/fuse/dev.c     | 37 +++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h  |  5 ++++-
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 284a35006462..e60daec8c16a 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -44,6 +44,18 @@ static ssize_t fuse_conn_abort_write(struct file *file, const char __user *buf,
 	return count;
 }
 
+static ssize_t fuse_conn_flush_write(struct file *file, const char __user *buf,
+				     size_t count, loff_t *ppos)
+{
+	struct fuse_conn *fc = fuse_ctl_file_conn_get(file);
+
+	if (fc) {
+		fuse_flush_pq(fc);
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
 
+static const struct file_operations fuse_ctl_flush_ops = {
+	.open = nonseekable_open,
+	.write = fuse_conn_flush_write,
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
+	    !fuse_ctl_add_dentry(parent, fc, "flush", S_IFREG | 0200, 1,
+				 NULL, &fuse_ctl_flush_ops) ||
 	    !fuse_ctl_add_dentry(parent, fc, "max_background", S_IFREG | 0600,
 				 1, NULL, &fuse_conn_max_background_ops) ||
 	    !fuse_ctl_add_dentry(parent, fc, "congestion_threshold",
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1a8f82f478cb..c7666f95979e 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2223,6 +2223,43 @@ int fuse_dev_release(struct inode *inode, struct file *file)
 }
 EXPORT_SYMBOL_GPL(fuse_dev_release);
 
+/*
+ * Flush all pending processing requests.
+ *
+ * The failover procedure reuses the fuse_conn after a userspace crash and
+ * recovery. However, the requests in the processing queue will never receive a
+ * reply, causing the application to become stuck indefinitely.
+ *
+ * To resolve this issue, we need to flush these requests using the sysfs API.
+ * We only flush the requests in the processing queue, as these requests have
+ * already been sent to userspace. First, we dequeue the request from the
+ * processing queue, and then we call request_end to finalize it.
+ */
+void fuse_flush_pq(struct fuse_conn *fc)
+{
+	struct fuse_dev *fud;
+	LIST_HEAD(to_end);
+	unsigned int i;
+
+	spin_lock(&fc->lock);
+	if (!fc->connected) {
+		spin_unlock(&fc->lock);
+		return;
+	}
+	list_for_each_entry(fud, &fc->devices, entry) {
+		struct fuse_pqueue *fpq = &fud->pq;
+
+		spin_lock(&fpq->lock);
+		WARN_ON(!list_empty(&fpq->io));
+		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++)
+			list_splice_init(&fpq->processing[i], &to_end);
+		spin_unlock(&fpq->lock);
+	}
+	spin_unlock(&fc->lock);
+
+	end_requests(&to_end);
+}
+
 static int fuse_dev_fasync(int fd, struct file *file, int on)
 {
 	struct fuse_dev *fud = fuse_get_dev(file);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 69bcffaf4832..62b46da033e3 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -45,7 +45,7 @@
 #define FUSE_NAME_MAX 1024
 
 /** Number of dentries for each connection in the control filesystem */
-#define FUSE_CTL_NUM_DENTRIES 5
+#define FUSE_CTL_NUM_DENTRIES 6
 
 /** List of active connections */
 extern struct list_head fuse_conn_list;
@@ -1107,6 +1107,9 @@ void fuse_request_end(struct fuse_req *req);
 void fuse_abort_conn(struct fuse_conn *fc);
 void fuse_wait_aborted(struct fuse_conn *fc);
 
+/* Flush all requests in processing queue */
+void fuse_flush_pq(struct fuse_conn *fc);
+
 /**
  * Invalidate inode attributes
  */
-- 
2.32.0.3.g01195cf9f


