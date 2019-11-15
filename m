Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E081FE6AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 21:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKOU5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 15:57:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42052 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726973AbfKOU50 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 15:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573851444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ICpl1dCSTPeWq4PqGDLc+T74X3Z/8UnHIlFIyRGASU4=;
        b=haEoxlNk+DoHuSwBL38vjXoABO3Q+bbPDYsaH2MiePM0MNIZeAcUsVc0qP3q9vbA9Ggcth
        JfgG5DxYE2ta3HAl2fkwyRzCRt32xgXXfMk8TvklBFwiCo80k2axMS+E/DfHVFX/ivgf6a
        M2BS7YJVtNhWwFdvN0Fmj+HVkCNVolY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-WEoh9eGbPdGLNGmdrG7Iig-1; Fri, 15 Nov 2019 15:57:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 579DD107ACC5;
        Fri, 15 Nov 2019 20:57:20 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 214C45C548;
        Fri, 15 Nov 2019 20:57:15 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id ADA7E224777; Fri, 15 Nov 2019 15:57:14 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        miklos@szeredi.hu
Subject: [PATCH 3/4] virtiofs: Add a virtqueue for notifications
Date:   Fri, 15 Nov 2019 15:57:04 -0500
Message-Id: <20191115205705.2046-4-vgoyal@redhat.com>
In-Reply-To: <20191115205705.2046-1-vgoyal@redhat.com>
References: <20191115205705.2046-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: WEoh9eGbPdGLNGmdrG7Iig-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a new virtqueue for notifications. This will allow device to send
notifications to guest. This queue is created only if device supports
it. This is negotiated using feature bit VIRTIO_FS_F_NOTIFICATION.

Given the architecture of virtqueue, one needs to queue up pre-allocated
elements in notication queue and device can pop these elements and fill
the notification info and send it back. Size of notication buffer is
negotiable and is specified by device through config space. This will
allow us to add and support more notification types without having to
change the spec.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c            | 199 +++++++++++++++++++++++++++++++--
 include/uapi/linux/virtio_fs.h |   5 +
 2 files changed, 193 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 1ab4b7b83707..21d8d9d7d317 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -21,10 +21,12 @@ static LIST_HEAD(virtio_fs_instances);
=20
 enum {
 =09VQ_HIPRIO,
+=09VQ_NOTIFY,
 =09VQ_REQUEST
 };
=20
 #define VQ_NAME_LEN=0924
+#define VQ_NOTIFY_ELEMS=09=0916 /* Number of notification elements */
=20
 /* Per-virtqueue state */
 struct virtio_fs_vq {
@@ -33,6 +35,8 @@ struct virtio_fs_vq {
 =09struct work_struct done_work;
 =09struct list_head queued_reqs;
 =09struct list_head end_reqs;=09/* End these requests */
+=09struct virtio_fs_notify_node *notify_nodes;
+=09struct list_head notify_reqs;=09/* List for queuing notify requests */
 =09struct delayed_work dispatch_work;
 =09struct fuse_dev *fud;
 =09bool connected;
@@ -50,6 +54,8 @@ struct virtio_fs {
 =09unsigned int nvqs;               /* number of virtqueues */
 =09unsigned int num_request_queues; /* number of request queues */
 =09unsigned int first_reqq_idx;=09/* First request queue idx */
+=09bool notify_enabled;
+=09unsigned int notify_buf_size;=09/* Size of notification buffer */
 };
=20
 struct virtio_fs_forget_req {
@@ -66,6 +72,20 @@ struct virtio_fs_forget {
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 =09=09=09=09 struct fuse_req *req, bool in_flight);
=20
+struct virtio_fs_notify {
+=09struct fuse_out_header=09out_hdr;
+=09/* Size of notify data specified by fs->notify_buf_size */
+=09char outarg[];
+};
+
+struct virtio_fs_notify_node {
+=09struct list_head list;
+=09struct virtio_fs_notify notify;
+};
+
+static int virtio_fs_enqueue_all_notify(struct virtio_fs_vq *fsvq);
+
+
 static inline struct virtio_fs_vq *vq_to_fsvq(struct virtqueue *vq)
 {
 =09struct virtio_fs *fs =3D vq->vdev->priv;
@@ -78,6 +98,11 @@ static inline struct fuse_pqueue *vq_to_fpq(struct virtq=
ueue *vq)
 =09return &vq_to_fsvq(vq)->fud->pq;
 }
=20
+static inline struct virtio_fs *fsvq_to_fs(struct virtio_fs_vq *fsvq)
+{
+=09return (struct virtio_fs *)fsvq->vq->vdev->priv;
+}
+
 /* Should be called with fsvq->lock held. */
 static inline void inc_in_flight_req(struct virtio_fs_vq *fsvq)
 {
@@ -93,10 +118,17 @@ static inline void dec_in_flight_req(struct virtio_fs_=
vq *fsvq)
 =09=09complete(&fsvq->in_flight_zero);
 }
=20
+static void virtio_fs_free_notify_nodes(struct virtio_fs *fs)
+{
+=09if (fs->notify_enabled && fs->vqs)
+=09=09kfree(fs->vqs[VQ_NOTIFY].notify_nodes);
+}
+
 static void release_virtio_fs_obj(struct kref *ref)
 {
 =09struct virtio_fs *vfs =3D container_of(ref, struct virtio_fs, refcount)=
;
=20
+=09virtio_fs_free_notify_nodes(vfs);
 =09kfree(vfs->vqs);
 =09kfree(vfs);
 }
@@ -143,6 +175,13 @@ static void virtio_fs_drain_all_queues_locked(struct v=
irtio_fs *fs)
 =09int i;
=20
 =09for (i =3D 0; i < fs->nvqs; i++) {
+=09=09/*
+=09=09 * Can't wait to drain notification queue as it always
+=09=09 * has pending requests so that server can use those
+=09=09 * to send notifications.
+=09=09 */
+=09=09if (fs->notify_enabled && (i =3D=3D VQ_NOTIFY))
+=09=09=09continue;
 =09=09fsvq =3D &fs->vqs[i];
 =09=09virtio_fs_drain_queue(fsvq);
 =09}
@@ -171,6 +210,8 @@ static void virtio_fs_start_all_queues(struct virtio_fs=
 *fs)
 =09=09spin_lock(&fsvq->lock);
 =09=09fsvq->connected =3D true;
 =09=09spin_unlock(&fsvq->lock);
+=09=09if (fs->notify_enabled && (i =3D=3D VQ_NOTIFY))
+=09=09=09virtio_fs_enqueue_all_notify(fsvq);
 =09}
 }
=20
@@ -420,6 +461,99 @@ static void virtio_fs_hiprio_dispatch_work(struct work=
_struct *work)
 =09}
 }
=20
+/* Allocate memory for event requests in notify queue */
+static int virtio_fs_init_notify_vq(struct virtio_fs *fs,
+=09=09=09=09    struct virtio_fs_vq *fsvq)
+{
+=09struct virtio_fs_notify_node *notify;
+=09unsigned notify_node_sz =3D sizeof(struct virtio_fs_notify_node) +
+=09=09=09=09  fs->notify_buf_size;
+=09int i;
+
+=09fsvq->notify_nodes =3D kcalloc(VQ_NOTIFY_ELEMS, notify_node_sz,
+=09=09=09=09     GFP_KERNEL);
+=09if (!fsvq->notify_nodes)
+=09=09return -ENOMEM;
+
+=09for (i =3D 0; i < VQ_NOTIFY_ELEMS; i++) {
+=09=09notify =3D (void *)fsvq->notify_nodes + (i * notify_node_sz);
+=09=09list_add_tail(&notify->list, &fsvq->notify_reqs);
+=09}
+
+=09return 0;
+}
+
+static int virtio_fs_enqueue_all_notify(struct virtio_fs_vq *fsvq)
+{
+=09struct scatterlist sg[1];
+=09int ret;
+=09bool kick;
+=09struct virtio_fs *fs =3D fsvq_to_fs(fsvq);
+=09struct virtio_fs_notify_node *notify, *next;
+=09unsigned notify_sz;
+
+=09notify_sz =3D sizeof(struct fuse_out_header) + fs->notify_buf_size;
+=09spin_lock(&fsvq->lock);
+=09list_for_each_entry_safe(notify, next, &fsvq->notify_reqs, list) {
+=09=09list_del_init(&notify->list);
+=09=09sg_init_one(sg, &notify->notify, notify_sz);
+=09=09ret =3D virtqueue_add_inbuf(fsvq->vq, sg, 1, notify, GFP_ATOMIC);
+=09=09if (ret) {
+=09=09=09list_add_tail(&notify->list, &fsvq->notify_reqs);
+=09=09=09spin_unlock(&fsvq->lock);
+=09=09=09return ret;
+=09=09}
+=09=09inc_in_flight_req(fsvq);
+=09}
+
+=09kick =3D virtqueue_kick_prepare(fsvq->vq);
+=09spin_unlock(&fsvq->lock);
+=09if (kick)
+=09=09virtqueue_notify(fsvq->vq);
+=09return 0;
+}
+
+static void virtio_fs_notify_done_work(struct work_struct *work)
+{
+=09struct virtio_fs_vq *fsvq =3D container_of(work, struct virtio_fs_vq,
+=09=09=09=09=09=09 done_work);
+=09struct virtqueue *vq =3D fsvq->vq;
+=09LIST_HEAD(reqs);
+=09struct virtio_fs_notify_node *notify, *next;
+
+=09spin_lock(&fsvq->lock);
+=09do {
+=09=09unsigned int len;
+
+=09=09virtqueue_disable_cb(vq);
+
+=09=09while ((notify =3D virtqueue_get_buf(vq, &len)) !=3D NULL) {
+=09=09=09list_add_tail(&notify->list, &reqs);
+=09=09}
+=09} while (!virtqueue_enable_cb(vq) && likely(!virtqueue_is_broken(vq)));
+=09spin_unlock(&fsvq->lock);
+
+=09/* Process notify */
+=09list_for_each_entry_safe(notify, next, &reqs, list) {
+=09=09spin_lock(&fsvq->lock);
+=09=09dec_in_flight_req(fsvq);
+=09=09list_del_init(&notify->list);
+=09=09list_add_tail(&notify->list, &fsvq->notify_reqs);
+=09=09spin_unlock(&fsvq->lock);
+=09}
+
+=09/*
+=09 * If queue is connected, queue notifications again. If not,
+=09 * these will be queued again when virtuqueue is restarted.
+=09 */
+=09if (fsvq->connected)
+=09=09virtio_fs_enqueue_all_notify(fsvq);
+}
+
+static void virtio_fs_notify_dispatch_work(struct work_struct *work)
+{
+}
+
 /* Allocate and copy args into req->argbuf */
 static int copy_args_to_argbuf(struct fuse_req *req)
 {
@@ -563,24 +697,34 @@ static void virtio_fs_vq_done(struct virtqueue *vq)
 =09schedule_work(&fsvq->done_work);
 }
=20
-static void virtio_fs_init_vq(struct virtio_fs_vq *fsvq, char *name,
-=09=09=09      int vq_type)
+static int virtio_fs_init_vq(struct virtio_fs *fs, struct virtio_fs_vq *fs=
vq,
+=09=09=09     char *name, int vq_type)
 {
+=09int ret =3D 0;
+
 =09strncpy(fsvq->name, name, VQ_NAME_LEN);
 =09spin_lock_init(&fsvq->lock);
 =09INIT_LIST_HEAD(&fsvq->queued_reqs);
 =09INIT_LIST_HEAD(&fsvq->end_reqs);
+=09INIT_LIST_HEAD(&fsvq->notify_reqs);
 =09init_completion(&fsvq->in_flight_zero);
=20
 =09if (vq_type =3D=3D VQ_REQUEST) {
 =09=09INIT_WORK(&fsvq->done_work, virtio_fs_requests_done_work);
 =09=09INIT_DELAYED_WORK(&fsvq->dispatch_work,
 =09=09=09=09  virtio_fs_request_dispatch_work);
+=09} else if (vq_type =3D=3D VQ_NOTIFY) {
+=09=09INIT_WORK(&fsvq->done_work, virtio_fs_notify_done_work);
+=09=09INIT_DELAYED_WORK(&fsvq->dispatch_work,
+=09=09=09=09  virtio_fs_notify_dispatch_work);
+=09=09ret =3D virtio_fs_init_notify_vq(fs, fsvq);
 =09} else {
 =09=09INIT_WORK(&fsvq->done_work, virtio_fs_hiprio_done_work);
 =09=09INIT_DELAYED_WORK(&fsvq->dispatch_work,
 =09=09=09=09  virtio_fs_hiprio_dispatch_work);
 =09}
+
+=09return ret;
 }
=20
 /* Initialize virtqueues */
@@ -598,9 +742,27 @@ static int virtio_fs_setup_vqs(struct virtio_device *v=
dev,
 =09if (fs->num_request_queues =3D=3D 0)
 =09=09return -EINVAL;
=20
-=09/* One hiprio queue and rest are request queues */
-=09fs->nvqs =3D 1 + fs->num_request_queues;
-=09fs->first_reqq_idx =3D 1;
+=09if (virtio_has_feature(vdev, VIRTIO_FS_F_NOTIFICATION)) {
+=09=09pr_debug("virtio_fs: device supports notification.\n");
+=09=09fs->notify_enabled =3D true;
+=09=09virtio_cread(vdev, struct virtio_fs_config, notify_buf_size,
+=09=09=09     &fs->notify_buf_size);
+=09=09if (fs->notify_buf_size =3D=3D 0) {
+=09=09=09printk("virtio-fs: Invalid value %d of notification"
+=09=09=09       " buffer size\n", fs->notify_buf_size);
+=09=09=09return -EINVAL;
+=09=09}
+=09}
+
+=09if (fs->notify_enabled) {
+=09=09/* One additional queue for hiprio and one for notifications */
+=09=09fs->nvqs =3D 2 + fs->num_request_queues;
+=09=09fs->first_reqq_idx =3D 2;
+=09} else {
+=09=09fs->nvqs =3D 1 + fs->num_request_queues;
+=09=09fs->first_reqq_idx =3D 1;
+=09}
+
 =09fs->vqs =3D kcalloc(fs->nvqs, sizeof(fs->vqs[VQ_HIPRIO]), GFP_KERNEL);
 =09if (!fs->vqs)
 =09=09return -ENOMEM;
@@ -616,16 +778,30 @@ static int virtio_fs_setup_vqs(struct virtio_device *=
vdev,
=20
 =09/* Initialize the hiprio/forget request virtqueue */
 =09callbacks[VQ_HIPRIO] =3D virtio_fs_vq_done;
-=09virtio_fs_init_vq(&fs->vqs[VQ_HIPRIO], "hiprio", VQ_HIPRIO);
+=09ret =3D virtio_fs_init_vq(fs, &fs->vqs[VQ_HIPRIO], "hiprio", VQ_HIPRIO)=
;
+=09if (ret < 0)
+=09=09goto out;
 =09names[VQ_HIPRIO] =3D fs->vqs[VQ_HIPRIO].name;
=20
+=09/* Initialize notification queue */
+=09if (fs->notify_enabled) {
+=09=09callbacks[VQ_NOTIFY] =3D virtio_fs_vq_done;
+=09=09ret =3D virtio_fs_init_vq(fs, &fs->vqs[VQ_NOTIFY], "notification",
+=09=09=09=09=09VQ_NOTIFY);
+=09=09if (ret < 0)
+=09=09=09goto out;
+=09=09names[VQ_NOTIFY] =3D fs->vqs[VQ_NOTIFY].name;
+=09}
+
 =09/* Initialize the requests virtqueues */
 =09for (i =3D fs->first_reqq_idx; i < fs->nvqs; i++) {
 =09=09char vq_name[VQ_NAME_LEN];
=20
 =09=09snprintf(vq_name, VQ_NAME_LEN, "requests.%u",
 =09=09=09 i - fs->first_reqq_idx);
-=09=09virtio_fs_init_vq(&fs->vqs[i], vq_name, VQ_REQUEST);
+=09=09ret =3D virtio_fs_init_vq(fs, &fs->vqs[i], vq_name, VQ_REQUEST);
+=09=09if (ret < 0)
+=09=09=09goto out;
 =09=09callbacks[i] =3D virtio_fs_vq_done;
 =09=09names[i] =3D fs->vqs[i].name;
 =09}
@@ -636,14 +812,14 @@ static int virtio_fs_setup_vqs(struct virtio_device *=
vdev,
=20
 =09for (i =3D 0; i < fs->nvqs; i++)
 =09=09fs->vqs[i].vq =3D vqs[i];
-
-=09virtio_fs_start_all_queues(fs);
 out:
 =09kfree(names);
 =09kfree(callbacks);
 =09kfree(vqs);
-=09if (ret)
+=09if (ret) {
+=09=09virtio_fs_free_notify_nodes(fs);
 =09=09kfree(fs->vqs);
+=09}
 =09return ret;
 }
=20
@@ -679,6 +855,7 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 =09 * requests need to be sent before we return.
 =09 */
 =09virtio_device_ready(vdev);
+=09virtio_fs_start_all_queues(fs);
=20
 =09ret =3D virtio_fs_add_instance(fs);
 =09if (ret < 0)
@@ -747,7 +924,7 @@ const static struct virtio_device_id id_table[] =3D {
 =09{},
 };
=20
-const static unsigned int feature_table[] =3D {};
+const static unsigned int feature_table[] =3D {VIRTIO_FS_F_NOTIFICATION};
=20
 static struct virtio_driver virtio_fs_driver =3D {
 =09.driver.name=09=09=3D KBUILD_MODNAME,
diff --git a/include/uapi/linux/virtio_fs.h b/include/uapi/linux/virtio_fs.=
h
index b02eb2ac3d99..f3f2ba3399a4 100644
--- a/include/uapi/linux/virtio_fs.h
+++ b/include/uapi/linux/virtio_fs.h
@@ -8,12 +8,17 @@
 #include <linux/virtio_config.h>
 #include <linux/virtio_types.h>
=20
+/* Feature bits */
+#define VIRTIO_FS_F_NOTIFICATION=090=09/* Notification queue supported */
+
 struct virtio_fs_config {
 =09/* Filesystem name (UTF-8, not NUL-terminated, padded with NULs) */
 =09__u8 tag[36];
=20
 =09/* Number of request queues */
 =09__u32 num_request_queues;
+=09/* Size of notification buffer */
+=09__u32 notify_buf_size;
 } __attribute__((packed));
=20
 #endif /* _UAPI_LINUX_VIRTIO_FS_H */
--=20
2.20.1

