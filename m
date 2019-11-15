Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00AD7FE6B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 21:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfKOU5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 15:57:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58818 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726988AbfKOU50 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 15:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573851445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wqZh8WFz+rw4kCLzz4RvfREDZuSAew5iqveqbHXa07M=;
        b=cy+jaVXRA7lgpL54bgFieL9LZi+2We+R+M/JSRLMICBE0S7C0tN0tj0lyli8cpFcDnPBlF
        BuRWphVBgfYwJl1UTkQG+4LKKM3Kjku9FmYOb6t+8bzAGz2hhAsLfEZr2v4Aw+GIiu/k2u
        YjD5hdYnd45ka2aMQyC7giNEhHIviho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-E-TN1873ON2HnAiMFtSHLQ-1; Fri, 15 Nov 2019 15:57:22 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2FB6DC24;
        Fri, 15 Nov 2019 20:57:20 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18D196055E;
        Fri, 15 Nov 2019 20:57:15 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A2BE7224775; Fri, 15 Nov 2019 15:57:14 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        miklos@szeredi.hu
Subject: [PATCH 1/4] virtiofs: Provide a helper function for virtqueue initialization
Date:   Fri, 15 Nov 2019 15:57:02 -0500
Message-Id: <20191115205705.2046-2-vgoyal@redhat.com>
In-Reply-To: <20191115205705.2046-1-vgoyal@redhat.com>
References: <20191115205705.2046-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: E-TN1873ON2HnAiMFtSHLQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This reduces code duplication and make it little easier to read code.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 50 +++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index b5ba83ef1914..a0fb0a93980c 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -24,6 +24,8 @@ enum {
 =09VQ_REQUEST
 };
=20
+#define VQ_NAME_LEN=0924
+
 /* Per-virtqueue state */
 struct virtio_fs_vq {
 =09spinlock_t lock;
@@ -36,7 +38,7 @@ struct virtio_fs_vq {
 =09bool connected;
 =09long in_flight;
 =09struct completion in_flight_zero; /* No inflight requests */
-=09char name[24];
+=09char name[VQ_NAME_LEN];
 } ____cacheline_aligned_in_smp;
=20
 /* A virtio-fs device instance */
@@ -560,6 +562,26 @@ static void virtio_fs_vq_done(struct virtqueue *vq)
 =09schedule_work(&fsvq->done_work);
 }
=20
+static void virtio_fs_init_vq(struct virtio_fs_vq *fsvq, char *name,
+=09=09=09      int vq_type)
+{
+=09strncpy(fsvq->name, name, VQ_NAME_LEN);
+=09spin_lock_init(&fsvq->lock);
+=09INIT_LIST_HEAD(&fsvq->queued_reqs);
+=09INIT_LIST_HEAD(&fsvq->end_reqs);
+=09init_completion(&fsvq->in_flight_zero);
+
+=09if (vq_type =3D=3D VQ_REQUEST) {
+=09=09INIT_WORK(&fsvq->done_work, virtio_fs_requests_done_work);
+=09=09INIT_DELAYED_WORK(&fsvq->dispatch_work,
+=09=09=09=09  virtio_fs_request_dispatch_work);
+=09} else {
+=09=09INIT_WORK(&fsvq->done_work, virtio_fs_hiprio_done_work);
+=09=09INIT_DELAYED_WORK(&fsvq->dispatch_work,
+=09=09=09=09  virtio_fs_hiprio_dispatch_work);
+=09}
+}
+
 /* Initialize virtqueues */
 static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 =09=09=09       struct virtio_fs *fs)
@@ -575,7 +597,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vd=
ev,
 =09if (fs->num_request_queues =3D=3D 0)
 =09=09return -EINVAL;
=20
-=09fs->nvqs =3D 1 + fs->num_request_queues;
+=09fs->nvqs =3D VQ_REQUEST + fs->num_request_queues;
 =09fs->vqs =3D kcalloc(fs->nvqs, sizeof(fs->vqs[VQ_HIPRIO]), GFP_KERNEL);
 =09if (!fs->vqs)
 =09=09return -ENOMEM;
@@ -589,29 +611,17 @@ static int virtio_fs_setup_vqs(struct virtio_device *=
vdev,
 =09=09goto out;
 =09}
=20
+=09/* Initialize the hiprio/forget request virtqueue */
 =09callbacks[VQ_HIPRIO] =3D virtio_fs_vq_done;
-=09snprintf(fs->vqs[VQ_HIPRIO].name, sizeof(fs->vqs[VQ_HIPRIO].name),
-=09=09=09"hiprio");
+=09virtio_fs_init_vq(&fs->vqs[VQ_HIPRIO], "hiprio", VQ_HIPRIO);
 =09names[VQ_HIPRIO] =3D fs->vqs[VQ_HIPRIO].name;
-=09INIT_WORK(&fs->vqs[VQ_HIPRIO].done_work, virtio_fs_hiprio_done_work);
-=09INIT_LIST_HEAD(&fs->vqs[VQ_HIPRIO].queued_reqs);
-=09INIT_LIST_HEAD(&fs->vqs[VQ_HIPRIO].end_reqs);
-=09INIT_DELAYED_WORK(&fs->vqs[VQ_HIPRIO].dispatch_work,
-=09=09=09virtio_fs_hiprio_dispatch_work);
-=09init_completion(&fs->vqs[VQ_HIPRIO].in_flight_zero);
-=09spin_lock_init(&fs->vqs[VQ_HIPRIO].lock);
=20
 =09/* Initialize the requests virtqueues */
 =09for (i =3D VQ_REQUEST; i < fs->nvqs; i++) {
-=09=09spin_lock_init(&fs->vqs[i].lock);
-=09=09INIT_WORK(&fs->vqs[i].done_work, virtio_fs_requests_done_work);
-=09=09INIT_DELAYED_WORK(&fs->vqs[i].dispatch_work,
-=09=09=09=09  virtio_fs_request_dispatch_work);
-=09=09INIT_LIST_HEAD(&fs->vqs[i].queued_reqs);
-=09=09INIT_LIST_HEAD(&fs->vqs[i].end_reqs);
-=09=09init_completion(&fs->vqs[i].in_flight_zero);
-=09=09snprintf(fs->vqs[i].name, sizeof(fs->vqs[i].name),
-=09=09=09 "requests.%u", i - VQ_REQUEST);
+=09=09char vq_name[VQ_NAME_LEN];
+
+=09=09snprintf(vq_name, VQ_NAME_LEN, "requests.%u", i - VQ_REQUEST);
+=09=09virtio_fs_init_vq(&fs->vqs[i], vq_name, VQ_REQUEST);
 =09=09callbacks[i] =3D virtio_fs_vq_done;
 =09=09names[i] =3D fs->vqs[i].name;
 =09}
--=20
2.20.1

