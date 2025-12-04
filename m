Return-Path: <linux-fsdevel+bounces-70622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 691F2CA2303
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 03:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B61163025F8D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 02:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C903A2F83B5;
	Thu,  4 Dec 2025 02:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="f0ttTimU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D72D1914
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 02:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764816160; cv=none; b=Q57JNmhAXszzATYIhkCOARMO6nOxlUMuPyOFlwlqyp4gAMpOsdWCW+65SNZbXxW8lc9wASdXpvkJA3sMmLx2Zyxh8m0srNjOh9qHlMkB9W3AhtTQ9HbyaOH4wOxXJsqo0esbrjmWT81JBUJlHk7Req9B8V6yLT25sOLOckdco5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764816160; c=relaxed/simple;
	bh=TgXgKycc6jVPCSr4bHW86OigfKEJ6SHi4n1I2zd1mEk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z3YWuRFig2Krjd++Yh7tykzYe+AzpyLEh/7QO4dfOLsJVOww88o65qoMYm4DClAZ+z69McNwU8ZhOY/LdEVnmELMSwIgGb9Q8LbXe3hCZQiSnc75jeJrSSAS0CGp4alWA47SIGEyfx10R2XTeH+ZmYvTNdYrUxoYGv9k6SZJFy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=f0ttTimU; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=D2yZu2ujRoItjte/BexFbPN/FUcGVNT3pO8t0TUZX0Q=;
	b=f0ttTimUyqSzN9wZmAWd4sJlmFSCby6slhCAVkTJgkP9+IYi6w4BT66+hKn3rBOwUtovJEevz
	j5Qh+jlK0cuKJCoH7YuYq/5b2zU1n0i5cDrp/lNK/g/cDm44+XzzcvMsqqSkdb6jmyi+/K7dqZD
	Op7ZLPllaflmdYnGgMwwfeA=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dMJf23zr2z1K96D;
	Thu,  4 Dec 2025 10:40:42 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 878FD1A0188;
	Thu,  4 Dec 2025 10:42:33 +0800 (CST)
Received: from kwepemn100013.china.huawei.com (7.202.194.116) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Dec 2025 10:42:33 +0800
Received: from huawei.com (10.50.87.129) by kwepemn100013.china.huawei.com
 (7.202.194.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 4 Dec
 2025 10:42:32 +0800
From: Long Li <leo.lilong@huawei.com>
To: <miklos@szeredi.hu>
CC: <linux-fsdevel@vger.kernel.org>, <bschubert@ddn.com>,
	<leo.lilong@huawei.com>, <yangerkun@huawei.com>, <lonuxli.64@gmail.com>
Subject: [PATCH v2] fuse: limit debug log output during ring teardown
Date: Thu, 4 Dec 2025 10:32:19 +0800
Message-ID: <20251204023219.1249542-1-leo.lilong@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100013.china.huawei.com (7.202.194.116)

Currently, if there are pending entries in the queue after the teardown
timeout, the system keeps printing entry state information at very short
intervals (FUSE_URING_TEARDOWN_INTERVAL). This can flood the system logs.
Additionally, ring->stop_debug_log is set but not used.

Clean up unused ring->stop_debug_log, update teardown time after each
log entry state, and change the log entry state interval to
FUSE_URING_TEARDOWN_TIMEOUT.

Signed-off-by: Long Li <leo.lilong@huawei.com>
---
v1->v2: Update teardown time to limit entry state output interval
 fs/fuse/dev_uring.c   | 7 ++++---
 fs/fuse/dev_uring_i.h | 5 -----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 5ceb217ced1b..68d2fbdc3a7c 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -426,7 +426,6 @@ static void fuse_uring_log_ent_state(struct fuse_ring *ring)
 		}
 		spin_unlock(&queue->lock);
 	}
-	ring->stop_debug_log = 1;
 }
 
 static void fuse_uring_async_stop_queues(struct work_struct *work)
@@ -453,9 +452,11 @@ static void fuse_uring_async_stop_queues(struct work_struct *work)
 	 * If there are still queue references left
 	 */
 	if (atomic_read(&ring->queue_refs) > 0) {
-		if (time_after(jiffies,
-			       ring->teardown_time + FUSE_URING_TEARDOWN_TIMEOUT))
+		if (time_after(jiffies, ring->teardown_time +
+					FUSE_URING_TEARDOWN_TIMEOUT)) {
 			fuse_uring_log_ent_state(ring);
+			ring->teardown_time = jiffies;
+		}
 
 		schedule_delayed_work(&ring->async_teardown_work,
 				      FUSE_URING_TEARDOWN_INTERVAL);
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 51a563922ce1..4cd3cbd51c7a 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -117,11 +117,6 @@ struct fuse_ring {
 
 	struct fuse_ring_queue **queues;
 
-	/*
-	 * Log ring entry states on stop when entries cannot be released
-	 */
-	unsigned int stop_debug_log : 1;
-
 	wait_queue_head_t stop_waitq;
 
 	/* async tear down */
-- 
2.39.2


