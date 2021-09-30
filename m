Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D225541DC7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 16:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350883AbhI3OlB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 10:41:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39871 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350747AbhI3Okz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633012752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nKHXLIf3Jq2uyWxFlT1LB9ypzk2D5+Zf6I6nd7kOZKg=;
        b=aM8Aud4kl6OMhokyefjAMSi61OLsJKKvxL9vx6Vnv5swO+GEAoYak5myG7a6mjef6OBQ1W
        lnGEU474DIg8irHWbp3WQVVymQcju13lpqcY+X2sgxbl5CkPULMZUwOBsnzDqHDB4ZcHVT
        ZOVhfAMxSBSEYi4Ym5G0JfeMKWJgSOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-OLjrOzmePVCCnv8lGe0zjw-1; Thu, 30 Sep 2021 10:39:10 -0400
X-MC-Unique: OLjrOzmePVCCnv8lGe0zjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D80E101AFBD;
        Thu, 30 Sep 2021 14:39:08 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.16.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D90F25F4E2;
        Thu, 30 Sep 2021 14:39:07 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id DB5AE228286; Thu, 30 Sep 2021 10:39:06 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu, stefanha@redhat.com
Cc:     vgoyal@redhat.com, iangelak@redhat.com, jaggel@bu.edu,
        dgilbert@redhat.com
Subject: [PATCH 7/8] virtiofs: Add new notification type FUSE_NOTIFY_LOCK
Date:   Thu, 30 Sep 2021 10:38:49 -0400
Message-Id: <20210930143850.1188628-8-vgoyal@redhat.com>
In-Reply-To: <20210930143850.1188628-1-vgoyal@redhat.com>
References: <20210930143850.1188628-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a new notification type FUSE_NOTIFY_LOCK. This notification can be
sent by file server to signifiy that a previous locking request has
completed and actual caller should be woken up.

As of now we don't support blocking variant of posix locks and daemon
returns -EOPNOTSUPP. Reason being that it can lead to deadlocks.
Virtqueue size is limited and it is possible we fill virtqueue with
all the requests of fcntl(F_SETLKW) and wait for reply. And later a
subsequent unlock request can't make progress because virtqueue is full.
And that means F_SETLKW can't make progress and we are deadlocked.

This problem is not limited to posix locks only. I think blocking remote
flock and open file description locks should face the same issue. Right
now fuse does not support open file description locks, so its not
a problem. But fuse/virtiofs does support remote flock and they can use
same mechanism too.

Use notification queue to solve this problem. After submitting lock
request device will send a reply asking requester to wait. Once lock is
available, requester will get a notification saying lock is available.
That way we don't keep the request virtueue busy while we are waiting for
lock and further unlock requests can make progress.

When we get a reply in response to lock request, we need a way to know
if we need to wait for notification or not. I have overloaded the
fuse_out_header->error field. If value is ->error is 1, that's a signal
to caller to wait for lock notification. Overloading ->error in this way
is not the best way to do it. But I am running out of ideas.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Ioannis Angelakopoulos <iangelak@redhat.com>
---
 fs/fuse/virtio_fs.c       | 73 +++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h | 11 +++++-
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 8d33879d62fb..1634ea2d0555 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -48,6 +48,7 @@ struct virtio_fs_vq {
 	struct virtqueue *vq;     /* protected by ->lock */
 	struct work_struct done_work;
 	struct list_head queued_reqs;
+	struct list_head wait_reqs;     /* Requests waiting for notification  */
 	struct list_head end_reqs;	/* End these requests */
 	struct virtio_fs_notify_node *notify_nodes;
 	struct list_head notify_reqs;	/* List for queuing notify requests */
@@ -575,13 +576,72 @@ static int virtio_fs_enqueue_all_notify(struct virtio_fs_vq *fsvq)
 	return 0;
 }
 
+static int notify_complete_waiting_req(struct virtio_fs *vfs,
+				       struct fuse_notify_lock_out *out_args)
+{
+	/* TODO: Handle multiqueue */
+	struct virtio_fs_vq *fsvq = &vfs->vqs[vfs->first_reqq_idx];
+	struct fuse_req *req, *next;
+	bool found = false;
+
+	/* Find waiting request with the unique number and end it */
+	spin_lock(&fsvq->lock);
+	list_for_each_entry_safe(req, next, &fsvq->wait_reqs, list) {
+		if (req->in.h.unique == out_args->unique) {
+			list_del_init(&req->list);
+			clear_bit(FR_SENT, &req->flags);
+			/* Transfer error code from notify */
+			req->out.h.error = out_args->error;
+			found = true;
+			break;
+		}
+	}
+	spin_unlock(&fsvq->lock);
+
+	/*
+	 * TODO: It is possible that some re-ordering happens in notify
+	 * comes before request is complete. Deal with it.
+	 */
+	if (found) {
+		end_req_dec_in_flight(req, fsvq);
+	} else
+		pr_debug("virtio-fs: Did not find waiting request with unique=0x%llx\n",
+			 out_args->unique);
+
+	return 0;
+}
+
+static int virtio_fs_handle_notify(struct virtio_fs *vfs,
+				   struct virtio_fs_notify *notify)
+{
+	int ret = 0;
+	struct fuse_out_header *oh = &notify->out_hdr;
+	struct fuse_notify_lock_out *lo;
+
+	/*
+	 * For notifications, oh.unique is 0 and oh->error contains code
+	 * for which notification as arrived.
+	 */
+	switch (oh->error) {
+	case FUSE_NOTIFY_LOCK:
+		lo = (struct fuse_notify_lock_out *) &notify->outarg;
+		notify_complete_waiting_req(vfs, lo);
+		break;
+	default:
+		pr_err("virtio-fs: Unexpected notification %d\n", oh->error);
+	}
+	return ret;
+}
+
 static void virtio_fs_notify_done_work(struct work_struct *work)
 {
 	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
 						 done_work);
 	struct virtqueue *vq = fsvq->vq;
+	struct virtio_fs *vfs = vq->vdev->priv;
 	LIST_HEAD(reqs);
 	struct virtio_fs_notify_node *notifyn, *next;
+	struct fuse_out_header *oh;
 
 	spin_lock(&fsvq->lock);
 	do {
@@ -597,6 +657,10 @@ static void virtio_fs_notify_done_work(struct work_struct *work)
 
 	/* Process notify */
 	list_for_each_entry_safe(notifyn, next, &reqs, list) {
+		oh = &notifyn->notify.out_hdr;
+		WARN_ON(oh->unique);
+		/* Handle notification */
+		virtio_fs_handle_notify(vfs, &notifyn->notify);
 		spin_lock(&fsvq->lock);
 		dec_in_flight_req(fsvq);
 		list_del_init(&notifyn->list);
@@ -696,6 +760,14 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 	 * TODO verify that server properly follows FUSE protocol
 	 * (oh.uniq, oh.len)
 	 */
+	if (req->out.h.error == 1) {
+		/* Wait for notification to complete request */
+		spin_lock(&fsvq->lock);
+		list_add_tail(&req->list, &fsvq->wait_reqs);
+		spin_unlock(&fsvq->lock);
+		return;
+	}
+
 	args = req->args;
 	copy_args_from_argbuf(args, req);
 
@@ -788,6 +860,7 @@ static int virtio_fs_init_vq(struct virtio_fs *fs, struct virtio_fs_vq *fsvq,
 	strncpy(fsvq->name, name, VQ_NAME_LEN);
 	spin_lock_init(&fsvq->lock);
 	INIT_LIST_HEAD(&fsvq->queued_reqs);
+	INIT_LIST_HEAD(&fsvq->wait_reqs);
 	INIT_LIST_HEAD(&fsvq->end_reqs);
 	INIT_LIST_HEAD(&fsvq->notify_reqs);
 	init_completion(&fsvq->in_flight_zero);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 36ed092227fa..46838551ea84 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -184,6 +184,8 @@
  *
  *  7.34
  *  - add FUSE_SYNCFS
+ *  7.35
+ *  - add FUSE_NOTIFY_LOCK
  */
 
 #ifndef _LINUX_FUSE_H
@@ -219,7 +221,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 34
+#define FUSE_KERNEL_MINOR_VERSION 35
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -529,6 +531,7 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_STORE = 4,
 	FUSE_NOTIFY_RETRIEVE = 5,
 	FUSE_NOTIFY_DELETE = 6,
+	FUSE_NOTIFY_LOCK = 7,
 	FUSE_NOTIFY_CODE_MAX,
 };
 
@@ -920,6 +923,12 @@ struct fuse_notify_retrieve_in {
 	uint64_t	dummy4;
 };
 
+struct fuse_notify_lock_out {
+	uint64_t	unique;
+	int32_t		error;
+	int32_t		padding;
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
-- 
2.31.1

