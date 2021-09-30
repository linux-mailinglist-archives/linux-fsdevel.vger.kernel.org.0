Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B7541DC7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 16:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350935AbhI3OlC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 10:41:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53625 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349383AbhI3Okz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633012752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jiLS8XApW9VZIpvV4gJd0qiBAQUUcTvEoIZE1yWjx7c=;
        b=TB25m12jASBhrfB9h6rMrN/jYHGA6OvbJnMvnwIg9DJtLShqBKZfghi1ulIC6t4Uqs/50n
        g5q9MFWVlWzm+dSM394mPcCHE9mRxW3rnftAXBiYLzVAnM1FASk/9GCN8fKN6p/5zWlSBi
        EyeBgCRt1U5uhJA1oa1vulhBQ6s6GTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-1JuoCIkFM-u3ErcFNkUlfw-1; Thu, 30 Sep 2021 10:39:10 -0400
X-MC-Unique: 1JuoCIkFM-u3ErcFNkUlfw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38A568464D0;
        Thu, 30 Sep 2021 14:39:08 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.16.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB92A5DF26;
        Thu, 30 Sep 2021 14:39:07 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D242A228284; Thu, 30 Sep 2021 10:39:06 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu, stefanha@redhat.com
Cc:     vgoyal@redhat.com, iangelak@redhat.com, jaggel@bu.edu,
        dgilbert@redhat.com
Subject: [PATCH 5/8] virtiofs: Add a virtqueue for notifications
Date:   Thu, 30 Sep 2021 10:38:47 -0400
Message-Id: <20210930143850.1188628-6-vgoyal@redhat.com>
In-Reply-To: <20210930143850.1188628-1-vgoyal@redhat.com>
References: <20210930143850.1188628-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
 fs/fuse/virtio_fs.c            | 203 +++++++++++++++++++++++++++++++--
 include/uapi/linux/virtio_fs.h |   5 +
 2 files changed, 196 insertions(+), 12 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index eef9591de640..b70a22a79901 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -25,6 +25,7 @@
 #define FUSE_HEADER_OVERHEAD    4
 
 #define VQ_HIPRIO_IDX	0
+#define VQ_NOTIFY_IDX	1
 
 /* List of virtio-fs device instances and a lock for the list. Also provides
  * mutual exclusion in device removal and mounting path
@@ -34,10 +35,12 @@ static LIST_HEAD(virtio_fs_instances);
 
 enum {
 	VQ_TYPE_HIPRIO,
-	VQ_TYPE_REQUEST
+	VQ_TYPE_REQUEST,
+	VQ_TYPE_NOTIFY
 };
 
 #define VQ_NAME_LEN	24
+#define VQ_NOTIFY_ELEMS 16	/* Number of notification elements */
 
 /* Per-virtqueue state */
 struct virtio_fs_vq {
@@ -46,6 +49,8 @@ struct virtio_fs_vq {
 	struct work_struct done_work;
 	struct list_head queued_reqs;
 	struct list_head end_reqs;	/* End these requests */
+	struct virtio_fs_notify_node *notify_nodes;
+	struct list_head notify_reqs;	/* List for queuing notify requests */
 	struct delayed_work dispatch_work;
 	struct fuse_dev *fud;
 	bool connected;
@@ -64,6 +69,8 @@ struct virtio_fs {
 	unsigned int num_request_queues; /* number of request queues */
 	struct dax_device *dax_dev;
 	unsigned int first_reqq_idx;     /* First request queue idx */
+	bool notify_enabled;
+	unsigned int notify_buf_size;    /* Size of notification buffer */
 
 	/* DAX memory window where file contents are mapped */
 	void *window_kaddr;
@@ -91,6 +98,19 @@ struct virtio_fs_req_work {
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
@@ -136,6 +156,11 @@ static inline struct virtio_fs_vq *vq_to_fsvq(struct virtqueue *vq)
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
@@ -151,10 +176,17 @@ static inline void dec_in_flight_req(struct virtio_fs_vq *fsvq)
 		complete(&fsvq->in_flight_zero);
 }
 
+static void virtio_fs_free_notify_nodes(struct virtio_fs *fs)
+{
+	if (fs->notify_enabled && fs->vqs)
+		kfree(fs->vqs[VQ_NOTIFY_IDX].notify_nodes);
+}
+
 static void release_virtio_fs_obj(struct kref *ref)
 {
 	struct virtio_fs *vfs = container_of(ref, struct virtio_fs, refcount);
 
+	virtio_fs_free_notify_nodes(vfs);
 	kfree(vfs->vqs);
 	kfree(vfs);
 }
@@ -201,6 +233,13 @@ static void virtio_fs_drain_all_queues_locked(struct virtio_fs *fs)
 	int i;
 
 	for (i = 0; i < fs->nvqs; i++) {
+		/*
+		 * Can't wait to drain notification queue as it always
+		 * had pending requests so that server can use those
+		 * to send notifications
+		 */
+		if (fs->notify_enabled && (i == VQ_NOTIFY_IDX))
+			continue;
 		fsvq = &fs->vqs[i];
 		virtio_fs_drain_queue(fsvq);
 	}
@@ -229,6 +268,8 @@ static void virtio_fs_start_all_queues(struct virtio_fs *fs)
 		spin_lock(&fsvq->lock);
 		fsvq->connected = true;
 		spin_unlock(&fsvq->lock);
+		if (fs->notify_enabled && (i == VQ_NOTIFY_IDX))
+			virtio_fs_enqueue_all_notify(fsvq);
 	}
 }
 
@@ -477,6 +518,98 @@ static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
 	}
 }
 
+static int virtio_fs_init_notify_vq(struct virtio_fs *fs,
+				    struct virtio_fs_vq *fsvq)
+{
+	struct virtio_fs_notify_node *notifyn;
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
+		notifyn = (void *)fsvq->notify_nodes + (i * notify_node_sz);
+		list_add_tail(&notifyn->list, &fsvq->notify_reqs);
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
+	struct virtio_fs_notify_node *notifyn, *next;
+	unsigned int notify_sz;
+
+	notify_sz = fs->notify_buf_size;
+	spin_lock(&fsvq->lock);
+	list_for_each_entry_safe(notifyn, next, &fsvq->notify_reqs, list) {
+		list_del_init(&notifyn->list);
+		sg_init_one(sg, &notifyn->notify, notify_sz);
+		ret = virtqueue_add_inbuf(fsvq->vq, sg, 1, notifyn, GFP_ATOMIC);
+		if (ret) {
+			list_add_tail(&notifyn->list, &fsvq->notify_reqs);
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
+	struct virtio_fs_notify_node *notifyn, *next;
+
+	spin_lock(&fsvq->lock);
+	do {
+		unsigned int len;
+
+		virtqueue_disable_cb(vq);
+
+		while ((notifyn = virtqueue_get_buf(vq, &len)) != NULL)
+			list_add_tail(&notifyn->list, &reqs);
+
+	} while (!virtqueue_enable_cb(vq) && likely(!virtqueue_is_broken(vq)));
+	spin_unlock(&fsvq->lock);
+
+	/* Process notify */
+	list_for_each_entry_safe(notifyn, next, &reqs, list) {
+		spin_lock(&fsvq->lock);
+		dec_in_flight_req(fsvq);
+		list_del_init(&notifyn->list);
+		list_add_tail(&notifyn->list, &fsvq->notify_reqs);
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
@@ -644,24 +777,34 @@ static void virtio_fs_vq_done(struct virtqueue *vq)
 	schedule_work(&fsvq->done_work);
 }
 
-static void virtio_fs_init_vq(struct virtio_fs_vq *fsvq, char *name,
-			      int vq_type)
+static int virtio_fs_init_vq(struct virtio_fs *fs, struct virtio_fs_vq *fsvq,
+			     char *name, int vq_type)
 {
+	int ret = 0;
+
 	strncpy(fsvq->name, name, VQ_NAME_LEN);
 	spin_lock_init(&fsvq->lock);
 	INIT_LIST_HEAD(&fsvq->queued_reqs);
 	INIT_LIST_HEAD(&fsvq->end_reqs);
+	INIT_LIST_HEAD(&fsvq->notify_reqs);
 	init_completion(&fsvq->in_flight_zero);
 
 	if (vq_type == VQ_TYPE_REQUEST) {
 		INIT_WORK(&fsvq->done_work, virtio_fs_requests_done_work);
 		INIT_DELAYED_WORK(&fsvq->dispatch_work,
 				  virtio_fs_request_dispatch_work);
+	} else if (vq_type == VQ_TYPE_NOTIFY) {
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
@@ -679,9 +822,28 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
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
+			pr_err("virtio-fs: Invalid value %d of notification buffer size\n",
+			       fs->notify_buf_size);
+			return -EINVAL;
+		}
+		pr_info("virtio-fs: device supports notification. Notification_buf_size=%u\n",
+			fs->notify_buf_size);
+	}
+
+	if (fs->notify_enabled) {
+		/* One additional queue for hiprio and one for notifications */
+		fs->nvqs = 2 + fs->num_request_queues;
+		fs->first_reqq_idx = VQ_NOTIFY_IDX + 1;
+	} else {
+		fs->nvqs = 1 + fs->num_request_queues;
+		fs->first_reqq_idx = 1;
+	}
+
 	fs->vqs = kcalloc(fs->nvqs, sizeof(fs->vqs[VQ_HIPRIO_IDX]), GFP_KERNEL);
 	if (!fs->vqs)
 		return -ENOMEM;
@@ -698,16 +860,32 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 
 	/* Initialize the hiprio/forget request virtqueue */
 	callbacks[VQ_HIPRIO_IDX] = virtio_fs_vq_done;
-	virtio_fs_init_vq(&fs->vqs[VQ_HIPRIO_IDX], "hiprio", VQ_TYPE_HIPRIO);
+	ret = virtio_fs_init_vq(fs, &fs->vqs[VQ_HIPRIO_IDX], "hiprio",
+				VQ_TYPE_HIPRIO);
+	if (ret < 0)
+		goto out;
 	names[VQ_HIPRIO_IDX] = fs->vqs[VQ_HIPRIO_IDX].name;
 
+	/* Initialize notification queue */
+	if (fs->notify_enabled) {
+		callbacks[VQ_NOTIFY_IDX] = virtio_fs_vq_done;
+		ret = virtio_fs_init_vq(fs, &fs->vqs[VQ_NOTIFY_IDX],
+					"notification", VQ_TYPE_NOTIFY);
+		if (ret < 0)
+			goto out;
+		names[VQ_NOTIFY_IDX] = fs->vqs[VQ_NOTIFY_IDX].name;
+	}
+
 	/* Initialize the requests virtqueues */
 	for (i = fs->first_reqq_idx; i < fs->nvqs; i++) {
 		char vq_name[VQ_NAME_LEN];
 
 		snprintf(vq_name, VQ_NAME_LEN, "requests.%u",
 			 i - fs->first_reqq_idx);
-		virtio_fs_init_vq(&fs->vqs[i], vq_name, VQ_TYPE_REQUEST);
+		ret = virtio_fs_init_vq(fs, &fs->vqs[i], vq_name,
+					VQ_TYPE_REQUEST);
+		if (ret < 0)
+			goto out;
 		callbacks[i] = virtio_fs_vq_done;
 		names[i] = fs->vqs[i].name;
 	}
@@ -718,14 +896,14 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 
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
 
@@ -889,6 +1067,7 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 	 * requests need to be sent before we return.
 	 */
 	virtio_device_ready(vdev);
+	virtio_fs_start_all_queues(fs);
 
 	ret = virtio_fs_add_instance(fs);
 	if (ret < 0)
@@ -958,7 +1137,7 @@ static const struct virtio_device_id id_table[] = {
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
2.31.1

