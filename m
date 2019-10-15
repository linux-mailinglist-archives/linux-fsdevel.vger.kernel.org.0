Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF61D7E0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 19:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfJORqm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 13:46:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfJORql (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:46:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0610776549;
        Tue, 15 Oct 2019 17:46:41 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EA475D9CD;
        Tue, 15 Oct 2019 17:46:35 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 294E52240F4; Tue, 15 Oct 2019 13:46:35 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, chirantan@chromium.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 4/5] virtiofs: Count pending forgets as in_flight forgets
Date:   Tue, 15 Oct 2019 13:46:25 -0400
Message-Id: <20191015174626.11593-5-vgoyal@redhat.com>
In-Reply-To: <20191015174626.11593-1-vgoyal@redhat.com>
References: <20191015174626.11593-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 15 Oct 2019 17:46:41 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If virtqueue is full, we put forget requests on a list and these forgets
are dispatched later using a worker. As of now we don't count these
forgets in fsvq->in_flight variable. This means when queue is being drained,
we have to have special logic to first drain these pending requests and
then wait for fsvq->in_flight to go to zero.

By counting pending forgets in fsvq->in_flight, we can get rid of special
logic and just wait for in_flight to go to zero. Worker thread will
kick and drain all the forgets anyway, leading in_flight to zero.

I also need similar logic for normal request queue in next patch where
I am about to defer request submission in the worker context if queue is
full.

This simplifies the code a bit.

Also add two helper functions to inc/dec in_flight. Decrement in_flight
helper will later used to call completion when in_flight reaches zero.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index e0fcf3030951..625de45fa471 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -67,6 +67,19 @@ static inline struct fuse_pqueue *vq_to_fpq(struct virtqueue *vq)
 	return &vq_to_fsvq(vq)->fud->pq;
 }
 
+/* Should be called with fsvq->lock held. */
+static inline void inc_in_flight_req(struct virtio_fs_vq *fsvq)
+{
+	fsvq->in_flight++;
+}
+
+/* Should be called with fsvq->lock held. */
+static inline void dec_in_flight_req(struct virtio_fs_vq *fsvq)
+{
+	WARN_ON(fsvq->in_flight <= 0);
+	fsvq->in_flight--;
+}
+
 static void release_virtio_fs_obj(struct kref *ref)
 {
 	struct virtio_fs *vfs = container_of(ref, struct virtio_fs, refcount);
@@ -110,22 +123,6 @@ static void virtio_fs_drain_queue(struct virtio_fs_vq *fsvq)
 	flush_delayed_work(&fsvq->dispatch_work);
 }
 
-static inline void drain_hiprio_queued_reqs(struct virtio_fs_vq *fsvq)
-{
-	struct virtio_fs_forget *forget;
-
-	spin_lock(&fsvq->lock);
-	while (1) {
-		forget = list_first_entry_or_null(&fsvq->queued_reqs,
-						struct virtio_fs_forget, list);
-		if (!forget)
-			break;
-		list_del(&forget->list);
-		kfree(forget);
-	}
-	spin_unlock(&fsvq->lock);
-}
-
 static void virtio_fs_drain_all_queues(struct virtio_fs *fs)
 {
 	struct virtio_fs_vq *fsvq;
@@ -133,9 +130,6 @@ static void virtio_fs_drain_all_queues(struct virtio_fs *fs)
 
 	for (i = 0; i < fs->nvqs; i++) {
 		fsvq = &fs->vqs[i];
-		if (i == VQ_HIPRIO)
-			drain_hiprio_queued_reqs(fsvq);
-
 		virtio_fs_drain_queue(fsvq);
 	}
 }
@@ -254,7 +248,7 @@ static void virtio_fs_hiprio_done_work(struct work_struct *work)
 
 		while ((req = virtqueue_get_buf(vq, &len)) != NULL) {
 			kfree(req);
-			fsvq->in_flight--;
+			dec_in_flight_req(fsvq);
 		}
 	} while (!virtqueue_enable_cb(vq) && likely(!virtqueue_is_broken(vq)));
 	spin_unlock(&fsvq->lock);
@@ -306,6 +300,7 @@ static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
 
 		list_del(&forget->list);
 		if (!fsvq->connected) {
+			dec_in_flight_req(fsvq);
 			spin_unlock(&fsvq->lock);
 			kfree(forget);
 			continue;
@@ -327,13 +322,13 @@ static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
 			} else {
 				pr_debug("virtio-fs: Could not queue FORGET: err=%d. Dropping it.\n",
 					 ret);
+				dec_in_flight_req(fsvq);
 				kfree(forget);
 			}
 			spin_unlock(&fsvq->lock);
 			return;
 		}
 
-		fsvq->in_flight++;
 		notify = virtqueue_kick_prepare(vq);
 		spin_unlock(&fsvq->lock);
 
@@ -472,7 +467,7 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 
 		fuse_request_end(fc, req);
 		spin_lock(&fsvq->lock);
-		fsvq->in_flight--;
+		dec_in_flight_req(fsvq);
 		spin_unlock(&fsvq->lock);
 	}
 }
@@ -730,6 +725,7 @@ __releases(fiq->lock)
 			list_add_tail(&forget->list, &fsvq->queued_reqs);
 			schedule_delayed_work(&fsvq->dispatch_work,
 					msecs_to_jiffies(1));
+			inc_in_flight_req(fsvq);
 		} else {
 			pr_debug("virtio-fs: Could not queue FORGET: err=%d. Dropping it.\n",
 				 ret);
@@ -739,7 +735,7 @@ __releases(fiq->lock)
 		goto out;
 	}
 
-	fsvq->in_flight++;
+	inc_in_flight_req(fsvq);
 	notify = virtqueue_kick_prepare(vq);
 
 	spin_unlock(&fsvq->lock);
@@ -921,7 +917,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	/* matches barrier in request_wait_answer() */
 	smp_mb__after_atomic();
 
-	fsvq->in_flight++;
+	inc_in_flight_req(fsvq);
 	notify = virtqueue_kick_prepare(vq);
 
 	spin_unlock(&fsvq->lock);
-- 
2.20.1

