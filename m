Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11DD41DC7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 16:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350941AbhI3OlA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 10:41:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58891 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350885AbhI3Oky (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633012751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=85YKaekpqa4GzE6JJfO31w2ZdTF4VUZmgvqMvc0z83A=;
        b=XTfaWjW8gMIZuiFZv/IZVnA4VwW+A5W5QUYO0qfT3JZYIavE1MKsOrDEY/aJjO+jaPZeQ5
        FVMX/BfaIdWbtNK1rEvkBiAwHELAHD++BGMhIGsCbmHabtKnbfzgLIRBwoxCnpgjEbfmXq
        aa1T2Wv7CJdAVgHcZOBjXVOm+kvyHMo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-HeAQVmKePcG_Zx7npk-dbQ-1; Thu, 30 Sep 2021 10:39:09 -0400
X-MC-Unique: HeAQVmKePcG_Zx7npk-dbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2234B1882FB1;
        Thu, 30 Sep 2021 14:39:08 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.16.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D11ED60BD8;
        Thu, 30 Sep 2021 14:39:07 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E0875228287; Thu, 30 Sep 2021 10:39:06 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu, stefanha@redhat.com
Cc:     vgoyal@redhat.com, iangelak@redhat.com, jaggel@bu.edu,
        dgilbert@redhat.com
Subject: [PATCH 8/8] virtiofs: Handle reordering of reply and notification event
Date:   Thu, 30 Sep 2021 10:38:50 -0400
Message-Id: <20210930143850.1188628-9-vgoyal@redhat.com>
In-Reply-To: <20210930143850.1188628-1-vgoyal@redhat.com>
References: <20210930143850.1188628-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So far we are relying that for a locking requrest reply always comes
first and then notification comes in. Both of these travel on different
virtqueues and there is no guarantee that client will always see/process
them in this order.

Though it is a very unlikely event, but it is possible that notification
comes first and then reply to lock request comes. Hence take care
of this possibility. If notification arrives and does not find a
corresponding request waiting, queue up notification in a list. When
request reply will come, it will check if corresponding notification
has already arrived. If yes, it will finish the request otherwise
wait for notification to arrive.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 134 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 116 insertions(+), 18 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 1634ea2d0555..028ca9198bc4 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -42,6 +42,17 @@ enum {
 #define VQ_NAME_LEN	24
 #define VQ_NOTIFY_ELEMS 16	/* Number of notification elements */
 
+/*
+ * virtio_fs_vq->lock spinlock nesting subclasses:
+ *
+ * 0: normal
+ * 1: nested
+ */
+enum {
+	VQ_LOCK_NORMAL,
+	VQ_LOCK_NESTED
+};
+
 /* Per-virtqueue state */
 struct virtio_fs_vq {
 	spinlock_t lock;
@@ -52,6 +63,8 @@ struct virtio_fs_vq {
 	struct list_head end_reqs;	/* End these requests */
 	struct virtio_fs_notify_node *notify_nodes;
 	struct list_head notify_reqs;	/* List for queuing notify requests */
+	/* Notifications to be processed when request reply arrives. */
+	struct list_head wait_notify;
 	struct delayed_work dispatch_work;
 	struct fuse_dev *fud;
 	bool connected;
@@ -576,13 +589,32 @@ static int virtio_fs_enqueue_all_notify(struct virtio_fs_vq *fsvq)
 	return 0;
 }
 
+/*
+ * Find a waiting process/request and complete it. If request and
+ * notification got re-ordered, it is possible that there is no
+ * waiting request yet. In that case queue up notification and
+ * return 1 so that caller does not try to reuse notifiy node yet.
+ *
+ * Return:
+ * negative value :  in case of error
+ * 0		  : If request processed successfully
+ * 1		  : Could not find waiting processed. Request got queued.
+ *		    Do not reuse this notify node yet.
+ */
 static int notify_complete_waiting_req(struct virtio_fs *vfs,
 				       struct fuse_notify_lock_out *out_args)
 {
 	/* TODO: Handle multiqueue */
 	struct virtio_fs_vq *fsvq = &vfs->vqs[vfs->first_reqq_idx];
+	struct virtio_fs_vq *notify_fsvq = &vfs->vqs[VQ_NOTIFY_IDX];
 	struct fuse_req *req, *next;
+	struct virtio_fs_notify *notify;
+	struct virtio_fs_notify_node *notifyn;
 	bool found = false;
+	int ret = 0;
+
+	notify = container_of((void *)out_args, struct virtio_fs_notify, outarg);
+	notifyn = container_of(notify, struct virtio_fs_notify_node, notify);
 
 	/* Find waiting request with the unique number and end it */
 	spin_lock(&fsvq->lock);
@@ -596,25 +628,39 @@ static int notify_complete_waiting_req(struct virtio_fs *vfs,
 			break;
 		}
 	}
-	spin_unlock(&fsvq->lock);
-
 	/*
-	 * TODO: It is possible that some re-ordering happens in notify
-	 * comes before request is complete. Deal with it.
+	 * It probably is a rare case of re-ordering where notification
+	 * arrived/processed before reply. Queue up the notification.
 	 */
+	spin_lock_nested(&notify_fsvq->lock, VQ_LOCK_NESTED);
+	if (!found) {
+		list_add_tail(&notifyn->list, &notify_fsvq->wait_notify);
+		ret = 1;
+	}
+	spin_unlock(&notify_fsvq->lock);
+	spin_unlock(&fsvq->lock);
+
 	if (found) {
 		end_req_dec_in_flight(req, fsvq);
-	} else
-		pr_debug("virtio-fs: Did not find waiting request with unique=0x%llx\n",
-			 out_args->unique);
+	}
 
-	return 0;
+	return ret;
+}
+
+static void notify_node_reuse(struct virtio_fs_vq *notify_fsvq,
+			      struct virtio_fs_notify_node *notifyn)
+{
+	spin_lock(&notify_fsvq->lock);
+	list_add_tail(&notifyn->list, &notify_fsvq->notify_reqs);
+	spin_unlock(&notify_fsvq->lock);
 }
 
 static int virtio_fs_handle_notify(struct virtio_fs *vfs,
-				   struct virtio_fs_notify *notify)
+				   struct virtio_fs_notify_node *notifyn)
 {
-	int ret = 0;
+	int ret = 0, no_reuse = 0;
+	struct virtio_fs_notify *notify = &notifyn->notify;
+	struct virtio_fs_vq *notify_fsvq = &vfs->vqs[VQ_NOTIFY_IDX];
 	struct fuse_out_header *oh = &notify->out_hdr;
 	struct fuse_notify_lock_out *lo;
 
@@ -625,11 +671,15 @@ static int virtio_fs_handle_notify(struct virtio_fs *vfs,
 	switch (oh->error) {
 	case FUSE_NOTIFY_LOCK:
 		lo = (struct fuse_notify_lock_out *) &notify->outarg;
-		notify_complete_waiting_req(vfs, lo);
+		no_reuse = notify_complete_waiting_req(vfs, lo);
 		break;
 	default:
 		pr_err("virtio-fs: Unexpected notification %d\n", oh->error);
 	}
+
+	if (!no_reuse)
+		notify_node_reuse(notify_fsvq, notifyn);
+
 	return ret;
 }
 
@@ -659,12 +709,11 @@ static void virtio_fs_notify_done_work(struct work_struct *work)
 	list_for_each_entry_safe(notifyn, next, &reqs, list) {
 		oh = &notifyn->notify.out_hdr;
 		WARN_ON(oh->unique);
+		list_del_init(&notifyn->list);
 		/* Handle notification */
-		virtio_fs_handle_notify(vfs, &notifyn->notify);
+		virtio_fs_handle_notify(vfs, notifyn);
 		spin_lock(&fsvq->lock);
 		dec_in_flight_req(fsvq);
-		list_del_init(&notifyn->list);
-		list_add_tail(&notifyn->list, &fsvq->notify_reqs);
 		spin_unlock(&fsvq->lock);
 	}
 
@@ -747,6 +796,57 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 	req->argbuf = NULL;
 }
 
+static void virtio_fs_wait_or_complete_request(struct virtio_fs_vq *fsvq,
+					       struct fuse_req *req)
+{
+	struct virtqueue *vq = fsvq->vq;
+	struct virtio_fs *vfs = vq->vdev->priv;
+	struct virtio_fs_vq *notify_fsvq = &vfs->vqs[VQ_NOTIFY_IDX];
+	bool found = false;
+	struct virtio_fs_notify_node *notifyn, *next;
+
+	/*
+	 * Note, notification queue lock nests inside request queue
+	 * lock and not otherwise.
+	 */
+	spin_lock(&fsvq->lock);
+	spin_lock_nested(&notify_fsvq->lock, VQ_LOCK_NESTED);
+	/*
+	 * Check if there is already a notification event in case of
+	 * reply and notification event got re-ordered. Very unlikley.
+	 */
+	list_for_each_entry_safe(notifyn, next, &notify_fsvq->wait_notify,
+				 list) {
+		struct fuse_notify_lock_out *lo;
+
+		lo = (struct fuse_notify_lock_out *) &notifyn->notify.outarg;
+
+		if (req->in.h.unique == lo->unique) {
+			list_del_init(&notifyn->list);
+			clear_bit(FR_SENT, &req->flags);
+			/* Transfer error code from notify */
+			req->out.h.error = lo->error;
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		/* Wait for notification to arrive. */
+		list_add_tail(&req->list, &fsvq->wait_reqs);
+	}
+
+	spin_unlock(&notify_fsvq->lock);
+	spin_unlock(&fsvq->lock);
+
+	if (found) {
+		end_req_dec_in_flight(req, fsvq);
+		notify_node_reuse(notify_fsvq, notifyn);
+		if (fsvq->connected)
+			virtio_fs_enqueue_all_notify(fsvq);
+	}
+}
+
 /* Work function for request completion */
 static void virtio_fs_request_complete(struct fuse_req *req,
 				       struct virtio_fs_vq *fsvq)
@@ -762,10 +862,7 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 	 */
 	if (req->out.h.error == 1) {
 		/* Wait for notification to complete request */
-		spin_lock(&fsvq->lock);
-		list_add_tail(&req->list, &fsvq->wait_reqs);
-		spin_unlock(&fsvq->lock);
-		return;
+		return virtio_fs_wait_or_complete_request(fsvq, req);
 	}
 
 	args = req->args;
@@ -863,6 +960,7 @@ static int virtio_fs_init_vq(struct virtio_fs *fs, struct virtio_fs_vq *fsvq,
 	INIT_LIST_HEAD(&fsvq->wait_reqs);
 	INIT_LIST_HEAD(&fsvq->end_reqs);
 	INIT_LIST_HEAD(&fsvq->notify_reqs);
+	INIT_LIST_HEAD(&fsvq->wait_notify);
 	init_completion(&fsvq->in_flight_zero);
 
 	if (vq_type == VQ_TYPE_REQUEST) {
-- 
2.31.1

