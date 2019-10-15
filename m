Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B48B1D7E11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 19:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbfJORqo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 13:46:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730749AbfJORqn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:46:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 703F576521;
        Tue, 15 Oct 2019 17:46:43 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8929860CCD;
        Tue, 15 Oct 2019 17:46:35 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 1751B2240DB; Tue, 15 Oct 2019 13:46:35 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, chirantan@chromium.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 1/5] virtiofs: Do not end request in submission context
Date:   Tue, 15 Oct 2019 13:46:22 -0400
Message-Id: <20191015174626.11593-2-vgoyal@redhat.com>
In-Reply-To: <20191015174626.11593-1-vgoyal@redhat.com>
References: <20191015174626.11593-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 15 Oct 2019 17:46:43 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Submission context can hold some locks which end request code tries to
hold again and deadlock can occur. For example, fc->bg_lock. If a background
request is being submitted, it might hold fc->bg_lock and if we could not
submit request (because device went away) and tried to end request,
then deadlock happens. During testing, I also got a warning from deadlock
detection code.

So put requests on a list and end requests from a worker thread.

I got following warning from deadlock detector.

[  603.137138] WARNING: possible recursive locking detected
[  603.137142] --------------------------------------------
[  603.137144] blogbench/2036 is trying to acquire lock:
[  603.137149] 00000000f0f51107 (&(&fc->bg_lock)->rlock){+.+.}, at: fuse_request_end+0xdf/0x1c0 [fuse]
[  603.140701]
[  603.140701] but task is already holding lock:
[  603.140703] 00000000f0f51107 (&(&fc->bg_lock)->rlock){+.+.}, at: fuse_simple_background+0x92/0x1d0 [fuse]
[  603.140713]
[  603.140713] other info that might help us debug this:
[  603.140714]  Possible unsafe locking scenario:
[  603.140714]
[  603.140715]        CPU0
[  603.140716]        ----
[  603.140716]   lock(&(&fc->bg_lock)->rlock);
[  603.140718]   lock(&(&fc->bg_lock)->rlock);
[  603.140719]
[  603.140719]  *** DEADLOCK ***

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 6af3f131e468..24ac6f8bf3f7 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -30,6 +30,7 @@ struct virtio_fs_vq {
 	struct virtqueue *vq;     /* protected by ->lock */
 	struct work_struct done_work;
 	struct list_head queued_reqs;
+	struct list_head end_reqs;	/* End these requests */
 	struct delayed_work dispatch_work;
 	struct fuse_dev *fud;
 	bool connected;
@@ -259,8 +260,27 @@ static void virtio_fs_hiprio_done_work(struct work_struct *work)
 	spin_unlock(&fsvq->lock);
 }
 
-static void virtio_fs_dummy_dispatch_work(struct work_struct *work)
+static void virtio_fs_request_dispatch_work(struct work_struct *work)
 {
+	struct fuse_req *req;
+	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
+						 dispatch_work.work);
+	struct fuse_conn *fc = fsvq->fud->fc;
+
+	pr_debug("virtio-fs: worker %s called.\n", __func__);
+	while (1) {
+		spin_lock(&fsvq->lock);
+		req = list_first_entry_or_null(&fsvq->end_reqs, struct fuse_req,
+					       list);
+		if (!req) {
+			spin_unlock(&fsvq->lock);
+			return;
+		}
+
+		list_del_init(&req->list);
+		spin_unlock(&fsvq->lock);
+		fuse_request_end(fc, req);
+	}
 }
 
 static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
@@ -502,6 +522,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	names[VQ_HIPRIO] = fs->vqs[VQ_HIPRIO].name;
 	INIT_WORK(&fs->vqs[VQ_HIPRIO].done_work, virtio_fs_hiprio_done_work);
 	INIT_LIST_HEAD(&fs->vqs[VQ_HIPRIO].queued_reqs);
+	INIT_LIST_HEAD(&fs->vqs[VQ_HIPRIO].end_reqs);
 	INIT_DELAYED_WORK(&fs->vqs[VQ_HIPRIO].dispatch_work,
 			virtio_fs_hiprio_dispatch_work);
 	spin_lock_init(&fs->vqs[VQ_HIPRIO].lock);
@@ -511,8 +532,9 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 		spin_lock_init(&fs->vqs[i].lock);
 		INIT_WORK(&fs->vqs[i].done_work, virtio_fs_requests_done_work);
 		INIT_DELAYED_WORK(&fs->vqs[i].dispatch_work,
-					virtio_fs_dummy_dispatch_work);
+				  virtio_fs_request_dispatch_work);
 		INIT_LIST_HEAD(&fs->vqs[i].queued_reqs);
+		INIT_LIST_HEAD(&fs->vqs[i].end_reqs);
 		snprintf(fs->vqs[i].name, sizeof(fs->vqs[i].name),
 			 "requests.%u", i - VQ_REQUEST);
 		callbacks[i] = virtio_fs_vq_done;
@@ -918,6 +940,7 @@ __releases(fiq->lock)
 	struct fuse_conn *fc;
 	struct fuse_req *req;
 	struct fuse_pqueue *fpq;
+	struct virtio_fs_vq *fsvq;
 	int ret;
 
 	WARN_ON(list_empty(&fiq->pending));
@@ -951,7 +974,8 @@ __releases(fiq->lock)
 	smp_mb__after_atomic();
 
 retry:
-	ret = virtio_fs_enqueue_req(&fs->vqs[queue_id], req);
+	fsvq = &fs->vqs[queue_id];
+	ret = virtio_fs_enqueue_req(fsvq, req);
 	if (ret < 0) {
 		if (ret == -ENOMEM || ret == -ENOSPC) {
 			/* Virtqueue full. Retry submission */
@@ -965,7 +989,13 @@ __releases(fiq->lock)
 		clear_bit(FR_SENT, &req->flags);
 		list_del_init(&req->list);
 		spin_unlock(&fpq->lock);
-		fuse_request_end(fc, req);
+
+		/* Can't end request in submission context. Use a worker */
+		spin_lock(&fsvq->lock);
+		list_add_tail(&req->list, &fsvq->end_reqs);
+		schedule_delayed_work(&fsvq->dispatch_work,
+				      msecs_to_jiffies(1));
+		spin_unlock(&fsvq->lock);
 		return;
 	}
 }
-- 
2.20.1

