Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2914AAC56
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 21:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391506AbfIETuS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 15:50:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388034AbfIETt0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:49:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F37C10A8122;
        Thu,  5 Sep 2019 19:49:26 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6861160166;
        Thu,  5 Sep 2019 19:49:26 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E940B2253A0; Thu,  5 Sep 2019 15:49:17 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu
Cc:     linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com
Subject: [PATCH 08/18] virtiofs: Drain all pending requests during ->remove time
Date:   Thu,  5 Sep 2019 15:48:49 -0400
Message-Id: <20190905194859.16219-9-vgoyal@redhat.com>
In-Reply-To: <20190905194859.16219-1-vgoyal@redhat.com>
References: <20190905194859.16219-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Thu, 05 Sep 2019 19:49:26 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When device is going away, drain all pending requests.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 83 ++++++++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 32 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 90e7b2f345e5..d5730a50b303 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -63,6 +63,55 @@ static inline struct fuse_pqueue *vq_to_fpq(struct virtqueue *vq)
 	return &vq_to_fsvq(vq)->fud->pq;
 }
 
+static void virtio_fs_drain_queue(struct virtio_fs_vq *fsvq)
+{
+	WARN_ON(fsvq->in_flight < 0);
+
+	/* Wait for in flight requests to finish.*/
+	while (1) {
+		spin_lock(&fsvq->lock);
+		if (!fsvq->in_flight) {
+			spin_unlock(&fsvq->lock);
+			break;
+		}
+		spin_unlock(&fsvq->lock);
+		usleep_range(1000, 2000);
+	}
+
+	flush_work(&fsvq->done_work);
+	flush_delayed_work(&fsvq->dispatch_work);
+}
+
+static inline void drain_hiprio_queued_reqs(struct virtio_fs_vq *fsvq)
+{
+	struct virtio_fs_forget *forget;
+
+	spin_lock(&fsvq->lock);
+	while (1) {
+		forget = list_first_entry_or_null(&fsvq->queued_reqs,
+						struct virtio_fs_forget, list);
+		if (!forget)
+			break;
+		list_del(&forget->list);
+		kfree(forget);
+	}
+	spin_unlock(&fsvq->lock);
+}
+
+static void virtio_fs_drain_all_queues(struct virtio_fs *fs)
+{
+	struct virtio_fs_vq *fsvq;
+	int i;
+
+	for (i = 0; i < fs->nvqs; i++) {
+		fsvq = &fs->vqs[i];
+		if (i == VQ_HIPRIO)
+			drain_hiprio_queued_reqs(fsvq);
+
+		virtio_fs_drain_queue(fsvq);
+	}
+}
+
 /* Add a new instance to the list or return -EEXIST if tag name exists*/
 static int virtio_fs_add_instance(struct virtio_fs *fs)
 {
@@ -511,6 +560,7 @@ static void virtio_fs_remove(struct virtio_device *vdev)
 	struct virtio_fs *fs = vdev->priv;
 
 	virtio_fs_stop_all_queues(fs);
+	virtio_fs_drain_all_queues(fs);
 	vdev->config->reset(vdev);
 	virtio_fs_cleanup_vqs(vdev, fs);
 
@@ -865,37 +915,6 @@ __releases(fiq->waitq.lock)
 	}
 }
 
-static void virtio_fs_flush_hiprio_queue(struct virtio_fs_vq *fsvq)
-{
-	struct virtio_fs_forget *forget;
-
-	WARN_ON(fsvq->in_flight < 0);
-
-	/* Go through pending forget requests and free them */
-	spin_lock(&fsvq->lock);
-	while (1) {
-		forget = list_first_entry_or_null(&fsvq->queued_reqs,
-					struct virtio_fs_forget, list);
-		if (!forget)
-			break;
-		list_del(&forget->list);
-		kfree(forget);
-	}
-
-	spin_unlock(&fsvq->lock);
-
-	/* Wait for in flight requests to finish.*/
-	while (1) {
-		spin_lock(&fsvq->lock);
-		if (!fsvq->in_flight) {
-			spin_unlock(&fsvq->lock);
-			break;
-		}
-		spin_unlock(&fsvq->lock);
-		usleep_range(1000, 2000);
-	}
-}
-
 const static struct fuse_iqueue_ops virtio_fs_fiq_ops = {
 	.wake_forget_and_unlock		= virtio_fs_wake_forget_and_unlock,
 	.wake_interrupt_and_unlock	= virtio_fs_wake_interrupt_and_unlock,
@@ -988,7 +1007,7 @@ static void virtio_kill_sb(struct super_block *sb)
 	spin_lock(&fsvq->lock);
 	fsvq->connected = false;
 	spin_unlock(&fsvq->lock);
-	virtio_fs_flush_hiprio_queue(fsvq);
+	virtio_fs_drain_all_queues(vfs);
 
 	fuse_kill_sb_anon(sb);
 	virtio_fs_free_devs(vfs);
-- 
2.20.1

