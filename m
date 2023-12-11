Return-Path: <linux-fsdevel+bounces-5471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 646D880C8F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 13:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836731C2124F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 12:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5FE3984E;
	Mon, 11 Dec 2023 12:06:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out0-202.mail.aliyun.com (out0-202.mail.aliyun.com [140.205.0.202])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE695DB
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 04:06:14 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047211;MF=winters.zc@antgroup.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---.VhZeNJ2_1702296372;
Received: from localhost(mailfrom:winters.zc@antgroup.com fp:SMTPD_---.VhZeNJ2_1702296372)
          by smtp.aliyun-inc.com;
          Mon, 11 Dec 2023 20:06:12 +0800
From: "Zhao Chen" <winters.zc@antgroup.com>
To: linux-fsdevel@vger.kernel.org
Cc: miklos@szeredi.hu
Subject: [PATCH v3 RESEND 1/2] fuse: Introduce a new notification type for resend pending requests
Date: Mon, 11 Dec 2023 20:06:10 +0800
Message-Id: <20231211120611.39543-2-winters.zc@antgroup.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231211120611.39543-1-winters.zc@antgroup.com>
References: <20231211120611.39543-1-winters.zc@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a FUSE daemon panics and failover, we aim to minimize the impact on
applications by reusing the existing FUSE connection. During this process,
another daemon is employed to preserve the FUSE connection's file
descriptor. The new started FUSE Daemon will takeover the fd and continue
to provide service.

However, it is possible for some inflight requests to be lost and never
returned. As a result, applications awaiting replies would become stuck
forever. To address this, we can resend these pending requests to the
new started FUSE daemon.

This patch introduces a new notification type "FUSE_NOTIFY_RESEND", which
can trigger resending of the pending requests, ensuring they are properly
processed again.

Signed-off-by: Zhao Chen <winters.zc@antgroup.com>
---
 fs/fuse/dev.c             | 64 +++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |  1 +
 2 files changed, 65 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1a8f82f478cb..a5a874b2f2e2 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1775,6 +1775,67 @@ static int fuse_notify_retrieve(struct fuse_conn *fc, unsigned int size,
 	return err;
 }
 
+/*
+ * Resending all processing queue requests.
+ *
+ * During a FUSE daemon panics and failover, it is possible for some inflight
+ * requests to be lost and never returned. As a result, applications awaiting
+ * replies would become stuck forever. To address this, we can use notification
+ * to trigger resending of these pending requests to the FUSE daemon, ensuring
+ * they are properly processed again.
+ *
+ * Please note that this strategy is applicable only to idempotent requests or
+ * if the FUSE daemon takes careful measures to avoid processing duplicated
+ * non-idempotent requests.
+ */
+static void fuse_resend(struct fuse_conn *fc)
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
+static int fuse_notify_resend(struct fuse_conn *fc)
+{
+	fuse_resend(fc);
+	return 0;
+}
+
 static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 		       unsigned int size, struct fuse_copy_state *cs)
 {
@@ -1800,6 +1861,9 @@ static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 	case FUSE_NOTIFY_DELETE:
 		return fuse_notify_delete(fc, size, cs);
 
+	case FUSE_NOTIFY_RESEND:
+		return fuse_notify_resend(fc);
+
 	default:
 		fuse_copy_finish(cs);
 		return -EINVAL;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index e7418d15fe39..277dc25b7863 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -635,6 +635,7 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_STORE = 4,
 	FUSE_NOTIFY_RETRIEVE = 5,
 	FUSE_NOTIFY_DELETE = 6,
+	FUSE_NOTIFY_RESEND = 7,
 	FUSE_NOTIFY_CODE_MAX,
 };
 
-- 
2.32.0.3.g01195cf9f


