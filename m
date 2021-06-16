Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2EF3AA0EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 18:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhFPQLb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 12:11:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56312 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhFPQLb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623859764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UtmIfSwnxb+nMU1BnLj+sOaTBn705yvu9+k8rVQNNIc=;
        b=Pc3rhry9ONQvwl8c86n0ll9zBYkDMzD9FiVT+gLCB4ZzdF9pCk+BZxwb424+GAle5Te3di
        9o0LOCITH7iYyoFCYft0Iqzm3suCuAxo7ck1c5dJpDka6CXLYBiiLhTZeH3bCOs2epIzhS
        rhYu/6lFDFf7GQtaUl0AEtYE70OeMCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-ZkvZNiDRO9ad2jaqE1Gdpw-1; Wed, 16 Jun 2021 12:09:22 -0400
X-MC-Unique: ZkvZNiDRO9ad2jaqE1Gdpw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CA901012585;
        Wed, 16 Jun 2021 16:09:21 +0000 (UTC)
Received: from iangelak.remote.csb (ovpn-113-44.rdu2.redhat.com [10.10.113.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B9915C1C5;
        Wed, 16 Jun 2021 16:09:13 +0000 (UTC)
From:   Ioannis Angelakopoulos <iangelak@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com
Cc:     miklos@szeredi.hu, stefanha@redhat.com, vgoyal@redhat.com
Subject: [PATCH 2/3] virtiofs: Add a virtqueue for notifications
Date:   Wed, 16 Jun 2021 12:08:35 -0400
Message-Id: <20210616160836.590206-3-iangelak@redhat.com>
In-Reply-To: <20210616160836.590206-1-iangelak@redhat.com>
References: <20210616160836.590206-1-iangelak@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Vivek Goyal <vgoyal@redhat.com>

Add a new virtqueue for notifications. This will allow the device to send
notifications to guest. This queue is created only if the device supports
it. This is negotiated using feature bit VIRTIO_FS_F_NOTIFICATION.

Given the architecture of virtqueue, one needs to queue up pre-allocated
elements in the notification queue and the device can pop these elements
and fill the notification info and send it back. The size of the
notification buffer is negotiable and is specified by the device through
config space. This will allow us to add and support more notification
types without having to change the spec.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Ioannis Angelakopoulos <iangelak@redhat.com>
---
 fs/fuse/virtio_fs.c            | 199 +++++++++++++++++++++++++++++++--
 include/uapi/linux/virtio_fs.h |   5 +
 2 files changed, 193 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index a545e31cf1ae..f9a6a7252218 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -32,10 +32,12 @@ static LIST_HEAD(virtio_fs_instances);
 
 enum {
 	VQ_HIPRIO,
+	VQ_NOTIFY,
 	VQ_REQUEST
 };
 
 #define VQ_NAME_LEN	24
+#define VQ_NOTIFY_ELEMS 16	/* Number of notification elements */
 
 /* Per-virtqueue state */
 struct virtio_fs_vq {
@@ -44,6 +46,8 @@ struct virtio_fs_vq {
 	struct work_struct done_work;
 	struct list_head queued_reqs;
 	struct list_head end_reqs;	/* End these requests */
+	struct virtio_fs_notify_node *notify_nodes;
+	struct list_head notify_reqs;	/* List for queuing notify requests */
 	struct delayed_work dispatch_work;
 	struct fuse_dev *fud;
 	bool connected;
@@ -62,6 +66,8 @@ struct virtio_fs {
 	unsigned int num_request_queues; /* number of request queues */
 	struct dax_device *dax_dev;
 	unsigned int first_reqq_idx;     /* First request queue idx */
+	bool notify_enabled;
+	unsigned int notify_buf_size;    /* Size of notification buffer */
 
 	/* DAX memory window where file contents are mapped */
 	void *window_kaddr;
@@ -89,6 +95,19 @@ struct virtio_fs_req_work {
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 				 struct fuse_req *req, bool in_flight);
 
+/* Size of virtio_fs_notify specified by fs->notify_buf_size. */
+struct virtio_fs_notify {
+	struct fuse_out_header out_hdr;
+	char outarg[];
+};
+
+struct virtio_fs_notify_node {
+	struct list_head list;
+	struct virtio_fs_notify notify;
+};
+
+static int virtio_fs_enqueue_all_notify(struct virtio_fs_vq *fsvq);
+
 enum {
 	OPT_DAX,
 };
@@ -134,6 +153,11 @@ static inline struct virtio_fs_vq *vq_to_fsvq(struct virtqueue *vq)
 	return &fs->vqs[vq->index];
 }
 
+static inline struct virtio_fs *fsvq_to_fs(struct virtio_fs_vq *fsvq)
+{
+	return (struct virtio_fs *)fsvq->vq->vdev->priv;
+}
+
 /* Should be called with fsvq->lock held. */
 static inline void inc_in_flight_req(struct virtio_fs_vq *fsvq)
 {
@@ -149,10 +173,17 @@ static inline void dec_in_flight_req(struct virtio_fs_vq *fsvq)
 		complete(&fsvq->in_flight_zero);
 }
 
+static void virtio_fs_free_notify_nodes(struct virtio_fs *fs)
+{
+	if (fs->notify_enabled && fs->vqs)
+		kfree(fs->vqs[VQ_NOTIFY].notify_nodes);
+}
+
 static void release_virtio_fs_obj(struct kref *ref)
 {
 	struct virtio_fs *vfs = container_of(ref, struct virtio_fs, refcount);
 
+	virtio_fs_free_notify_nodes(vfs);
 	kfree(vfs->vqs);
 	kfree(vfs);
 }
@@ -199,6 +230,13 @@ static void virtio_fs_drain_all_queues_locked(struct virtio_fs *fs)
 	int i;
 
 	for (i = 0; i < fs->nvqs; i++) {
+		/*
+		 * Can't wait to drain notification queue as it always
+		 * had pending requests so that server can use those
+		 * to send notifications
+		 */
+		if (fs->notify_enabled && (i == VQ_NOTIFY))
+			continue;
 		fsvq = &fs->vqs[i];
 		virtio_fs_drain_queue(fsvq);
 	}
@@ -227,6 +265,8 @@ static void virtio_fs_start_all_queues(struct virtio_fs *fs)
 		spin_lock(&fsvq->lock);
 		fsvq->connected = true;
 		spin_unlock(&fsvq->lock);
+		if (fs->notify_enabled && (i == VQ_NOTIFY))
+			virtio_fs_enqueue_all_notify(fsvq);
 	}
 }
 
@@ -475,6 +515,98 @@ static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
 	}
 }
 
+static int virtio_fs_init_notify_vq(struct virtio_fs *fs,
+				    struct virtio_fs_vq *fsvq)
+{
+	struct virtio_fs_notify_node *notify;
+	unsigned int notify_node_sz = sizeof(struct list_head) +
+				  fs->notify_buf_size;
+	int i;
+
+	fsvq->notify_nodes = kcalloc(VQ_NOTIFY_ELEMS, notify_node_sz,
+				     GFP_KERNEL);
+	if (!fsvq->notify_nodes)
+		return -ENOMEM;
+
+	for (i = 0; i < VQ_NOTIFY_ELEMS; i++) {
+		notify = (void *)fsvq->notify_nodes + (i * notify_node_sz);
+		list_add_tail(&notify->list, &fsvq->notify_reqs);
+	}
+
+	return 0;
+}
+
+static int virtio_fs_enqueue_all_notify(struct virtio_fs_vq *fsvq)
+{
+	struct scatterlist sg[1];
+	int ret;
+	bool kick;
+	struct virtio_fs *fs = fsvq_to_fs(fsvq);
+	struct virtio_fs_notify_node *notify, *next;
+	unsigned int notify_sz;
+
+	notify_sz = fs->notify_buf_size;
+	spin_lock(&fsvq->lock);
+	list_for_each_entry_safe(notify, next, &fsvq->notify_reqs, list) {
+		list_del_init(&notify->list);
+		sg_init_one(sg, &notify->notify, notify_sz);
+		ret = virtqueue_add_inbuf(fsvq->vq, sg, 1, notify, GFP_ATOMIC);
+		if (ret) {
+			list_add_tail(&notify->list, &fsvq->notify_reqs);
+			spin_unlock(&fsvq->lock);
+			return ret;
+		}
+		inc_in_flight_req(fsvq);
+	}
+
+	kick = virtqueue_kick_prepare(fsvq->vq);
+	spin_unlock(&fsvq->lock);
+	if (kick)
+		virtqueue_notify(fsvq->vq);
+	return 0;
+}
+
+static void virtio_fs_notify_done_work(struct work_struct *work)
+{
+	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
+						 done_work);
+	struct virtqueue *vq = fsvq->vq;
+	LIST_HEAD(reqs);
+	struct virtio_fs_notify_node *notify, *next;
+
+	spin_lock(&fsvq->lock);
+	do {
+		unsigned int len;
+
+		virtqueue_disable_cb(vq);
+
+		while ((notify = virtqueue_get_buf(vq, &len)) != NULL)
+			list_add_tail(&notify->list, &reqs);
+
+	} while (!virtqueue_enable_cb(vq) && likely(!virtqueue_is_broken(vq)));
+	spin_unlock(&fsvq->lock);
+
+	/* Process notify */
+	list_for_each_entry_safe(notify, next, &reqs, list) {
+		spin_lock(&fsvq->lock);
+		dec_in_flight_req(fsvq);
+		list_del_init(&notify->list);
+		list_add_tail(&notify->list, &fsvq->notify_reqs);
+		spin_unlock(&fsvq->lock);
+	}
+
+	/*
+	 * If queue is connected, queue notifications again. If not,
+	 * these will be queued again when virtuqueue is restarted.
+	 */
+	if (fsvq->connected)
+		virtio_fs_enqueue_all_notify(fsvq);
+}
+
+static void virtio_fs_notify_dispatch_work(struct work_struct *work)
+{
+}
+
 /* Allocate and copy args into req->argbuf */
 static int copy_args_to_argbuf(struct fuse_req *req)
 {
@@ -647,24 +779,34 @@ static void virtio_fs_vq_done(struct virtqueue *vq)
 	schedule_work(&fsvq->done_work);
 }
 
-static void virtio_fs_init_vq(struct virtio_fs_vq *fsvq, char *name,
-			      int vq_type)
+static int virtio_fs_init_vq(struct virtio_fs *fs, struct virtio_fs_vq *fsvq,
+			      char *name, int vq_type)
 {
+	int ret = 0;
+
 	strncpy(fsvq->name, name, VQ_NAME_LEN);
 	spin_lock_init(&fsvq->lock);
 	INIT_LIST_HEAD(&fsvq->queued_reqs);
 	INIT_LIST_HEAD(&fsvq->end_reqs);
+	INIT_LIST_HEAD(&fsvq->notify_reqs);
 	init_completion(&fsvq->in_flight_zero);
 
 	if (vq_type == VQ_REQUEST) {
 		INIT_WORK(&fsvq->done_work, virtio_fs_requests_done_work);
 		INIT_DELAYED_WORK(&fsvq->dispatch_work,
 				  virtio_fs_request_dispatch_work);
+	} else if (vq_type == VQ_NOTIFY) {
+		INIT_WORK(&fsvq->done_work, virtio_fs_notify_done_work);
+		INIT_DELAYED_WORK(&fsvq->dispatch_work,
+				  virtio_fs_notify_dispatch_work);
+		ret = virtio_fs_init_notify_vq(fs, fsvq);
 	} else {
 		INIT_WORK(&fsvq->done_work, virtio_fs_hiprio_done_work);
 		INIT_DELAYED_WORK(&fsvq->dispatch_work,
 				  virtio_fs_hiprio_dispatch_work);
 	}
+
+	return ret;
 }
 
 /* Initialize virtqueues */
@@ -682,9 +824,28 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	if (fs->num_request_queues == 0)
 		return -EINVAL;
 
-	/* One hiprio queue and rest are request queues */
-	fs->nvqs = 1 + fs->num_request_queues;
-	fs->first_reqq_idx = 1;
+	if (virtio_has_feature(vdev, VIRTIO_FS_F_NOTIFICATION)) {
+		fs->notify_enabled = true;
+		virtio_cread(vdev, struct virtio_fs_config, notify_buf_size,
+			     &fs->notify_buf_size);
+		if (fs->notify_buf_size <= sizeof(struct fuse_out_header)) {
+			pr_err("virtio-fs: Invalid value %d of notification"
+					" buffer size\n", fs->notify_buf_size);
+			return -EINVAL;
+		}
+		pr_info("virtio-fs: device supports notification."
+				" Notification_buf_size=%u\n", fs->notify_buf_size);
+	}
+
+	if (fs->notify_enabled) {
+		/* One additional queue for hiprio and one for notifications */
+		fs->nvqs = 2 + fs->num_request_queues;
+		fs->first_reqq_idx = 2;
+	} else {
+		fs->nvqs = 1 + fs->num_request_queues;
+		fs->first_reqq_idx = 1;
+	}
+
 	fs->vqs = kcalloc(fs->nvqs, sizeof(fs->vqs[VQ_HIPRIO]), GFP_KERNEL);
 	if (!fs->vqs)
 		return -ENOMEM;
@@ -700,16 +861,31 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 
 	/* Initialize the hiprio/forget request virtqueue */
 	callbacks[VQ_HIPRIO] = virtio_fs_vq_done;
-	virtio_fs_init_vq(&fs->vqs[VQ_HIPRIO], "hiprio", VQ_HIPRIO);
+	ret = virtio_fs_init_vq(fs, &fs->vqs[VQ_HIPRIO], "hiprio", VQ_HIPRIO);
+	if (ret < 0)
+		goto out;
 	names[VQ_HIPRIO] = fs->vqs[VQ_HIPRIO].name;
 
+	/* Initialize notification queue */
+	if (fs->notify_enabled) {
+		callbacks[VQ_NOTIFY] = virtio_fs_vq_done;
+		ret = virtio_fs_init_vq(fs, &fs->vqs[VQ_NOTIFY], "notification",
+					VQ_NOTIFY);
+		if (ret < 0)
+			goto out;
+		names[VQ_NOTIFY] = fs->vqs[VQ_NOTIFY].name;
+	}
+
+
 	/* Initialize the requests virtqueues */
 	for (i = fs->first_reqq_idx; i < fs->nvqs; i++) {
 		char vq_name[VQ_NAME_LEN];
 
 		snprintf(vq_name, VQ_NAME_LEN, "requests.%u",
 			 i - fs->first_reqq_idx);
-		virtio_fs_init_vq(&fs->vqs[i], vq_name, VQ_REQUEST);
+		ret = virtio_fs_init_vq(fs, &fs->vqs[i], vq_name, VQ_REQUEST);
+		if (ret < 0)
+			goto out;
 		callbacks[i] = virtio_fs_vq_done;
 		names[i] = fs->vqs[i].name;
 	}
@@ -720,14 +896,14 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 
 	for (i = 0; i < fs->nvqs; i++)
 		fs->vqs[i].vq = vqs[i];
-
-	virtio_fs_start_all_queues(fs);
 out:
 	kfree(names);
 	kfree(callbacks);
 	kfree(vqs);
-	if (ret)
+	if (ret) {
+		virtio_fs_free_notify_nodes(fs);
 		kfree(fs->vqs);
+	}
 	return ret;
 }
 
@@ -891,6 +1067,7 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 	 * requests need to be sent before we return.
 	 */
 	virtio_device_ready(vdev);
+	virtio_fs_start_all_queues(fs);
 
 	ret = virtio_fs_add_instance(fs);
 	if (ret < 0)
@@ -960,7 +1137,7 @@ static const struct virtio_device_id id_table[] = {
 	{},
 };
 
-static const unsigned int feature_table[] = {};
+static const unsigned int feature_table[] = {VIRTIO_FS_F_NOTIFICATION};
 
 static struct virtio_driver virtio_fs_driver = {
 	.driver.name		= KBUILD_MODNAME,
diff --git a/include/uapi/linux/virtio_fs.h b/include/uapi/linux/virtio_fs.h
index bea38291421b..3a9bbccf4115 100644
--- a/include/uapi/linux/virtio_fs.h
+++ b/include/uapi/linux/virtio_fs.h
@@ -8,12 +8,17 @@
 #include <linux/virtio_config.h>
 #include <linux/virtio_types.h>
 
+/* Feature bits */
+#define VIRTIO_FS_F_NOTIFICATION 0	/* Notification queue supported */
+
 struct virtio_fs_config {
 	/* Filesystem name (UTF-8, not NUL-terminated, padded with NULs) */
 	__u8 tag[36];
 
 	/* Number of request queues */
 	__le32 num_request_queues;
+	/* Size of notification buffer */
+	__u32 notify_buf_size;
 } __attribute__((packed));
 
 /* For the id field in virtio_pci_shm_cap */
-- 
2.27.0

