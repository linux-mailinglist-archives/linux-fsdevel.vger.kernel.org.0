Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAFDFE6AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 21:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfKOU52 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 15:57:28 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51820 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726980AbfKOU50 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 15:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573851445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2QEJbiz+89oQBqVefvp57/tK+Zdt+Qq0QP+KzJjkhEg=;
        b=aqYGFAQ45XJacNXBR+BEKQxU3LhIVPQWlNKG8Zwf+2V6tpBFz1+QFR4G71+owak+b0veyf
        uG9ZK4uV6wDb5Zmxfty2ysARB3fld019CBn6cbQp2plQTt9q9Tyu/gDG2dB0vdKdVkzCWW
        Unm5yaakOrAySKABgMS6NDWg6VcDjz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-WxEv-1IUOTq9QO01IYm4bA-1; Fri, 15 Nov 2019 15:57:21 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF51F18B9FAA;
        Fri, 15 Nov 2019 20:57:20 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B58260BF7;
        Fri, 15 Nov 2019 20:57:15 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A79D7224776; Fri, 15 Nov 2019 15:57:14 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        miklos@szeredi.hu
Subject: [PATCH 2/4] virtiofs: Add an index to keep track of first request queue
Date:   Fri, 15 Nov 2019 15:57:03 -0500
Message-Id: <20191115205705.2046-3-vgoyal@redhat.com>
In-Reply-To: <20191115205705.2046-1-vgoyal@redhat.com>
References: <20191115205705.2046-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: WxEv-1IUOTq9QO01IYm4bA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have many virtqueues and first queue which carries fuse normal requests
(except forget requests) has index pointed to by enum VQ_REQUEST. This work=
s
fine as long as number of queues are not dynamic.

I am about to introduce one more virtqueue, called notification queue, whic=
h
will be present only if device on host supports it. That means index of
request queue will change depending on if notification queue is present
or not.

So, add a variable to keep track of that index and this will help when
notification queue is added in next patch.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index a0fb0a93980c..1ab4b7b83707 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -49,6 +49,7 @@ struct virtio_fs {
 =09struct virtio_fs_vq *vqs;
 =09unsigned int nvqs;               /* number of virtqueues */
 =09unsigned int num_request_queues; /* number of request queues */
+=09unsigned int first_reqq_idx;=09/* First request queue idx */
 };
=20
 struct virtio_fs_forget_req {
@@ -597,7 +598,9 @@ static int virtio_fs_setup_vqs(struct virtio_device *vd=
ev,
 =09if (fs->num_request_queues =3D=3D 0)
 =09=09return -EINVAL;
=20
-=09fs->nvqs =3D VQ_REQUEST + fs->num_request_queues;
+=09/* One hiprio queue and rest are request queues */
+=09fs->nvqs =3D 1 + fs->num_request_queues;
+=09fs->first_reqq_idx =3D 1;
 =09fs->vqs =3D kcalloc(fs->nvqs, sizeof(fs->vqs[VQ_HIPRIO]), GFP_KERNEL);
 =09if (!fs->vqs)
 =09=09return -ENOMEM;
@@ -617,10 +620,11 @@ static int virtio_fs_setup_vqs(struct virtio_device *=
vdev,
 =09names[VQ_HIPRIO] =3D fs->vqs[VQ_HIPRIO].name;
=20
 =09/* Initialize the requests virtqueues */
-=09for (i =3D VQ_REQUEST; i < fs->nvqs; i++) {
+=09for (i =3D fs->first_reqq_idx; i < fs->nvqs; i++) {
 =09=09char vq_name[VQ_NAME_LEN];
=20
-=09=09snprintf(vq_name, VQ_NAME_LEN, "requests.%u", i - VQ_REQUEST);
+=09=09snprintf(vq_name, VQ_NAME_LEN, "requests.%u",
+=09=09=09 i - fs->first_reqq_idx);
 =09=09virtio_fs_init_vq(&fs->vqs[i], vq_name, VQ_REQUEST);
 =09=09callbacks[i] =3D virtio_fs_vq_done;
 =09=09names[i] =3D fs->vqs[i].name;
@@ -990,7 +994,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *f=
svq,
 static void virtio_fs_wake_pending_and_unlock(struct fuse_iqueue *fiq)
 __releases(fiq->lock)
 {
-=09unsigned int queue_id =3D VQ_REQUEST; /* TODO multiqueue */
+=09unsigned int queue_id;
 =09struct virtio_fs *fs;
 =09struct fuse_req *req;
 =09struct virtio_fs_vq *fsvq;
@@ -1004,6 +1008,7 @@ __releases(fiq->lock)
 =09spin_unlock(&fiq->lock);
=20
 =09fs =3D fiq->priv;
+=09queue_id =3D fs->first_reqq_idx;
=20
 =09pr_debug("%s: opcode %u unique %#llx nodeid %#llx in.len %u out.len %u\=
n",
 =09=09  __func__, req->in.h.opcode, req->in.h.unique,
@@ -1077,7 +1082,7 @@ static int virtio_fs_fill_super(struct super_block *s=
b)
=20
 =09err =3D -ENOMEM;
 =09/* Allocate fuse_dev for hiprio and notification queues */
-=09for (i =3D 0; i < VQ_REQUEST; i++) {
+=09for (i =3D 0; i < fs->first_reqq_idx; i++) {
 =09=09struct virtio_fs_vq *fsvq =3D &fs->vqs[i];
=20
 =09=09fsvq->fud =3D fuse_dev_alloc();
@@ -1085,17 +1090,17 @@ static int virtio_fs_fill_super(struct super_block =
*sb)
 =09=09=09goto err_free_fuse_devs;
 =09}
=20
-=09ctx.fudptr =3D (void **)&fs->vqs[VQ_REQUEST].fud;
+=09ctx.fudptr =3D (void **)&fs->vqs[fs->first_reqq_idx].fud;
 =09err =3D fuse_fill_super_common(sb, &ctx);
 =09if (err < 0)
 =09=09goto err_free_fuse_devs;
=20
-=09fc =3D fs->vqs[VQ_REQUEST].fud->fc;
+=09fc =3D fs->vqs[fs->first_reqq_idx].fud->fc;
=20
 =09for (i =3D 0; i < fs->nvqs; i++) {
 =09=09struct virtio_fs_vq *fsvq =3D &fs->vqs[i];
=20
-=09=09if (i =3D=3D VQ_REQUEST)
+=09=09if (i =3D=3D fs->first_reqq_idx)
 =09=09=09continue; /* already initialized */
 =09=09fuse_dev_install(fsvq->fud, fc);
 =09}
--=20
2.20.1

