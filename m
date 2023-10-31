Return-Path: <linux-fsdevel+bounces-1648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C377DCF61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 15:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1B11B21161
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D541DFC5;
	Tue, 31 Oct 2023 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDCA1DDD4
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 14:41:19 +0000 (UTC)
Received: from out0-216.mail.aliyun.com (out0-216.mail.aliyun.com [140.205.0.216])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E06E10A
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 07:41:17 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047203;MF=winters.zc@antgroup.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---.VC.iDTU_1698763272;
Received: from localhost(mailfrom:winters.zc@antgroup.com fp:SMTPD_---.VC.iDTU_1698763272)
          by smtp.aliyun-inc.com;
          Tue, 31 Oct 2023 22:41:13 +0800
From: "=?UTF-8?B?6LW15pmo?=" <winters.zc@antgroup.com>
To: linux-fsdevel@vger.kernel.org
Cc:  <miklos@szeredi.hu>,
  "Peng Tao" <tao.peng@linux.alibaba.com>,
  "Liu Bo" <bo.liu@linux.alibaba.com>,
  "Joseph Qi" <joseph.qi@linux.alibaba.com>,
  "Jeffle Xu" <jefflexu@linux.alibaba.com>,
  "Gao Xiang" <hsiangkao@linux.alibaba.com>,
  "=?UTF-8?B?6LW15pmo?=" <winters.zc@antgroup.com>
Subject: [PATCH v[n] 2/2] fuse: Introduce sysfs API for resend pending requests
Date: Tue, 31 Oct 2023 22:40:43 +0800
Message-Id: <20231031144043.68534-3-winters.zc@antgroup.com>
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

From: Peng Tao <tao.peng@linux.alibaba.com>

When a FUSE daemon panics and fails over, we want to reuse the existing
FUSE connection and avoid affecting applications as little as possible.
During FUSE daemon failover, the FUSE processing queue requests are
waiting forreplies from user space daemon that never come back and
applications would stuck forever.

Besides flushing the processing queue requests like being done in
fuse_flush_pq(), we can also resend these requests to user space daemon
so that they can be processed properly again. Such strategy can only be
done for idempotent requests or if the user space daemon takes good care
to record and avoid processing duplicated non-idempotent requests,
otherwise there can be consistency issues. We trust users to know what
they are doing by calling writing to this interface.

Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Zhao Chen <winters.zc@antgroup.com>
---
 fs/fuse/control.c | 20 +++++++++++++++++
 fs/fuse/dev.c     | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h  |  5 ++++-
 3 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index e60daec8c16a..e53514b2bce2 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -56,6 +56,18 @@ static ssize_t fuse_conn_flush_write(struct file *file, const char __user *buf,
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
@@ -208,6 +220,12 @@ static const struct file_operations fuse_ctl_flush_ops = {
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
@@ -294,6 +312,8 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
 				 NULL, &fuse_ctl_abort_ops) ||
 	    !fuse_ctl_add_dentry(parent, fc, "flush", S_IFREG | 0200, 1,
 				 NULL, &fuse_ctl_flush_ops) ||
+	    !fuse_ctl_add_dentry(parent, fc, "resend", S_IFREG | 0200, 1,
+				 NULL, &fuse_ctl_resend_ops) ||
 	    !fuse_ctl_add_dentry(parent, fc, "max_background", S_IFREG | 0600,
 				 1, NULL, &fuse_conn_max_background_ops) ||
 	    !fuse_ctl_add_dentry(parent, fc, "congestion_threshold",
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index c7666f95979e..d70b25115b1c 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2260,6 +2260,63 @@ void fuse_flush_pq(struct fuse_conn *fc)
 	end_requests(&to_end);
 }
 
+/**
+ * Resend all processing queue requests.
+ *
+ * When a FUSE daemon panics and fails over, we want to reuse the existing FUSE
+ * connection and avoid affecting applications as little as possible. During
+ * FUSE daemon failover, the FUSE processing queue requests are waiting for
+ * replies from user space daemon that never come back and applications would
+ * stuck forever.
+ *
+ * Besides flushing the processing queue requests like being done in fuse_flush_pq(),
+ * we can also resend these requests to user space daemon so that they can be
+ * processed properly again. Such strategy can only be done for idempotent requests
+ * or if the user space daemon takes good care to record and avoid processing
+ * duplicated non-idempotent requests.
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
+	spin_unlock(&fiq->lock);
+}
+
 static int fuse_dev_fasync(int fd, struct file *file, int on)
 {
 	struct fuse_dev *fud = fuse_get_dev(file);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 62b46da033e3..7581c023f61a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -45,7 +45,7 @@
 #define FUSE_NAME_MAX 1024
 
 /** Number of dentries for each connection in the control filesystem */
-#define FUSE_CTL_NUM_DENTRIES 6
+#define FUSE_CTL_NUM_DENTRIES 7
 
 /** List of active connections */
 extern struct list_head fuse_conn_list;
@@ -1110,6 +1110,9 @@ void fuse_wait_aborted(struct fuse_conn *fc);
 /* Flush all requests in processing queue */
 void fuse_flush_pq(struct fuse_conn *fc);
 
+/* Resend all requests in processing queue so they can represent to userspace */
+void fuse_resend_pqueue(struct fuse_conn *fc);
+
 /**
  * Invalidate inode attributes
  */
-- 
2.32.0.3.g01195cf9f


