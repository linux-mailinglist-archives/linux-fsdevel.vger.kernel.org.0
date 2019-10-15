Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9ACD7E13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 19:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbfJORqu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 13:46:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbfJORqt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:46:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A32E30ADBBB;
        Tue, 15 Oct 2019 17:46:49 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 748545D6A9;
        Tue, 15 Oct 2019 17:46:41 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 2EDA12240F5; Tue, 15 Oct 2019 13:46:35 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, chirantan@chromium.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 5/5] virtiofs: Retry request submission from worker context
Date:   Tue, 15 Oct 2019 13:46:26 -0400
Message-Id: <20191015174626.11593-6-vgoyal@redhat.com>
In-Reply-To: <20191015174626.11593-1-vgoyal@redhat.com>
References: <20191015174626.11593-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 15 Oct 2019 17:46:49 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If regular request queue gets full, currently we sleep for a bit and
retrying submission in submitter's context. This assumes submitter is
not holding any spin lock. But this assumption is not true for background
requests. For background requests, we are called with fc->bg_lock held.

This can lead to deadlock where one thread is trying submission with
fc->bg_lock held while request completion thread has called fuse_request_end()
which tries to acquire fc->bg_lock and gets blocked. As request completion
thread gets blocked, it does not make further progress and that means queue
does not get empty and submitter can't submit more requests.

To solve this issue, retry submission with the help of a worker, instead of
retrying in submitter's context. We already do this for hiprio/forget
requests.

Reported-by: Chirantan Ekbote <chirantan@chromium.org>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 59 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 625de45fa471..58e568ef54ef 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -55,6 +55,9 @@ struct virtio_fs_forget {
 	struct list_head list;
 };
 
+static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
+				 struct fuse_req *req, bool in_flight);
+
 static inline struct virtio_fs_vq *vq_to_fsvq(struct virtqueue *vq)
 {
 	struct virtio_fs *fs = vq->vdev->priv;
@@ -260,6 +263,7 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
 						 dispatch_work.work);
 	struct fuse_conn *fc = fsvq->fud->fc;
+	int ret;
 
 	pr_debug("virtio-fs: worker %s called.\n", __func__);
 	while (1) {
@@ -268,13 +272,43 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 					       list);
 		if (!req) {
 			spin_unlock(&fsvq->lock);
-			return;
+			break;
 		}
 
 		list_del_init(&req->list);
 		spin_unlock(&fsvq->lock);
 		fuse_request_end(fc, req);
 	}
+
+	/* Dispatch pending requests */
+	while (1) {
+		spin_lock(&fsvq->lock);
+		req = list_first_entry_or_null(&fsvq->queued_reqs,
+					       struct fuse_req, list);
+		if (!req) {
+			spin_unlock(&fsvq->lock);
+			return;
+		}
+		list_del_init(&req->list);
+		spin_unlock(&fsvq->lock);
+
+		ret = virtio_fs_enqueue_req(fsvq, req, true);
+		if (ret < 0) {
+			if (ret == -ENOMEM || ret == -ENOSPC) {
+				spin_lock(&fsvq->lock);
+				list_add_tail(&req->list, &fsvq->queued_reqs);
+				schedule_delayed_work(&fsvq->dispatch_work,
+						      msecs_to_jiffies(1));
+				spin_unlock(&fsvq->lock);
+				return;
+			}
+			req->out.h.error = ret;
+			dec_in_flight_req(fsvq);
+			pr_err("virtio-fs: virtio_fs_enqueue_req() failed %d\n",
+			       ret);
+			fuse_request_end(fc, req);
+		}
+	}
 }
 
 static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
@@ -837,7 +871,7 @@ static unsigned int sg_init_fuse_args(struct scatterlist *sg,
 
 /* Add a request to a virtqueue and kick the device */
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
-				 struct fuse_req *req)
+				 struct fuse_req *req, bool in_flight)
 {
 	/* requests need at least 4 elements */
 	struct scatterlist *stack_sgs[6];
@@ -917,7 +951,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	/* matches barrier in request_wait_answer() */
 	smp_mb__after_atomic();
 
-	inc_in_flight_req(fsvq);
+	if (!in_flight)
+		inc_in_flight_req(fsvq);
 	notify = virtqueue_kick_prepare(vq);
 
 	spin_unlock(&fsvq->lock);
@@ -963,15 +998,21 @@ __releases(fiq->lock)
 		 req->in.h.nodeid, req->in.h.len,
 		 fuse_len_args(req->args->out_numargs, req->args->out_args));
 
-retry:
 	fsvq = &fs->vqs[queue_id];
-	ret = virtio_fs_enqueue_req(fsvq, req);
+	ret = virtio_fs_enqueue_req(fsvq, req, false);
 	if (ret < 0) {
 		if (ret == -ENOMEM || ret == -ENOSPC) {
-			/* Virtqueue full. Retry submission */
-			/* TODO use completion instead of timeout */
-			usleep_range(20, 30);
-			goto retry;
+			/*
+			 * Virtqueue full. Retry submission from worker
+			 * context as we might be holding fc->bg_lock.
+			 */
+			spin_lock(&fsvq->lock);
+			list_add_tail(&req->list, &fsvq->queued_reqs);
+			inc_in_flight_req(fsvq);
+			schedule_delayed_work(&fsvq->dispatch_work,
+						msecs_to_jiffies(1));
+			spin_unlock(&fsvq->lock);
+			return;
 		}
 		req->out.h.error = ret;
 		pr_err("virtio-fs: virtio_fs_enqueue_req() failed %d\n", ret);
-- 
2.20.1

