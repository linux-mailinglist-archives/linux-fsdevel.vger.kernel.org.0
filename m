Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6260AE9E5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 16:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfJ3PHv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 11:07:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59856 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726804AbfJ3PHv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572448069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ly9ZLmJFIT1Dvi1Eb6dZoycLAw+2NQKYUEey1TmqA6k=;
        b=MzdBW7u3aLI6i/9mP00Aw3RYlMm0hBdB7rgbdSP5kYD/Jjfaw+Ywer4E8J/+cf4ZR5wY+Y
        2nqjFz2lArnIch6IgLiWXaCcdNjwBQ3gp+kJDgishT1w2Kzp0o+k6qxJOE9ZznRhHwd4Zt
        vvHpboXB/Bihj5o3vDIZCOJ7iuPFQoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-pQEtktDAMAOGDd4mIRTP6Q-1; Wed, 30 Oct 2019 11:07:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24DAC2B8;
        Wed, 30 Oct 2019 15:07:45 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B47B5D6D4;
        Wed, 30 Oct 2019 15:07:39 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D8C39223900; Wed, 30 Oct 2019 11:07:38 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Cc:     virtualization@lists.linux-foundation.org, vgoyal@redhat.com,
        miklos@szeredi.hu, stefanha@redhat.com, dgilbert@redhat.com
Subject: [PATCH 1/3] virtiofs: Use a common function to send forget
Date:   Wed, 30 Oct 2019 11:07:17 -0400
Message-Id: <20191030150719.29048-2-vgoyal@redhat.com>
In-Reply-To: <20191030150719.29048-1-vgoyal@redhat.com>
References: <20191030150719.29048-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: pQEtktDAMAOGDd4mIRTP6Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently we are duplicating logic to send forgets at two places. Consolida=
te
the code by calling one helper function.

This also uses virtqueue_add_outbuf() instead of virtqueue_add_sgs(). Forme=
r
is simpler to call.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 150 +++++++++++++++++++-------------------------
 1 file changed, 63 insertions(+), 87 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index a5c86048b96e..6cc7be170cb8 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -313,17 +313,71 @@ static void virtio_fs_request_dispatch_work(struct wo=
rk_struct *work)
 =09}
 }
=20
+/*
+ * Returns 1 if queue is full and sender should wait a bit before sending
+ * next request, 0 otherwise.
+ */
+static int send_forget_request(struct virtio_fs_vq *fsvq,
+=09=09=09       struct virtio_fs_forget *forget,
+=09=09=09       bool in_flight)
+{
+=09struct scatterlist sg;
+=09struct virtqueue *vq;
+=09int ret =3D 0;
+=09bool notify;
+
+=09spin_lock(&fsvq->lock);
+=09if (!fsvq->connected) {
+=09=09if (in_flight)
+=09=09=09dec_in_flight_req(fsvq);
+=09=09kfree(forget);
+=09=09goto out;
+=09}
+
+=09sg_init_one(&sg, forget, sizeof(*forget));
+=09vq =3D fsvq->vq;
+=09dev_dbg(&vq->vdev->dev, "%s\n", __func__);
+
+=09ret =3D virtqueue_add_outbuf(vq, &sg, 1, forget, GFP_ATOMIC);
+=09if (ret < 0) {
+=09=09if (ret =3D=3D -ENOMEM || ret =3D=3D -ENOSPC) {
+=09=09=09pr_debug("virtio-fs: Could not queue FORGET: err=3D%d."
+=09=09=09=09 " Will try later\n", ret);
+=09=09=09list_add_tail(&forget->list, &fsvq->queued_reqs);
+=09=09=09schedule_delayed_work(&fsvq->dispatch_work,
+=09=09=09=09=09      msecs_to_jiffies(1));
+=09=09=09if (!in_flight)
+=09=09=09=09inc_in_flight_req(fsvq);
+=09=09=09/* Queue is full */
+=09=09=09ret =3D 1;
+=09=09} else {
+=09=09=09pr_debug("virtio-fs: Could not queue FORGET: err=3D%d."
+=09=09=09=09 " Dropping it.\n", ret);
+=09=09=09kfree(forget);
+=09=09=09if (in_flight)
+=09=09=09=09dec_in_flight_req(fsvq);
+=09=09}
+=09=09goto out;
+=09}
+
+=09if (!in_flight)
+=09=09inc_in_flight_req(fsvq);
+=09notify =3D virtqueue_kick_prepare(vq);
+=09spin_unlock(&fsvq->lock);
+
+=09if (notify)
+=09=09virtqueue_notify(vq);
+=09return ret;
+out:
+=09spin_unlock(&fsvq->lock);
+=09return ret;
+}
+
 static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
 {
 =09struct virtio_fs_forget *forget;
 =09struct virtio_fs_vq *fsvq =3D container_of(work, struct virtio_fs_vq,
 =09=09=09=09=09=09 dispatch_work.work);
-=09struct virtqueue *vq =3D fsvq->vq;
-=09struct scatterlist sg;
-=09struct scatterlist *sgs[] =3D {&sg};
-=09bool notify;
-=09int ret;
-
 =09pr_debug("virtio-fs: worker %s called.\n", __func__);
 =09while (1) {
 =09=09spin_lock(&fsvq->lock);
@@ -335,43 +389,9 @@ static void virtio_fs_hiprio_dispatch_work(struct work=
_struct *work)
 =09=09}
=20
 =09=09list_del(&forget->list);
-=09=09if (!fsvq->connected) {
-=09=09=09dec_in_flight_req(fsvq);
-=09=09=09spin_unlock(&fsvq->lock);
-=09=09=09kfree(forget);
-=09=09=09continue;
-=09=09}
-
-=09=09sg_init_one(&sg, forget, sizeof(*forget));
-
-=09=09/* Enqueue the request */
-=09=09dev_dbg(&vq->vdev->dev, "%s\n", __func__);
-=09=09ret =3D virtqueue_add_sgs(vq, sgs, 1, 0, forget, GFP_ATOMIC);
-=09=09if (ret < 0) {
-=09=09=09if (ret =3D=3D -ENOMEM || ret =3D=3D -ENOSPC) {
-=09=09=09=09pr_debug("virtio-fs: Could not queue FORGET: err=3D%d. Will tr=
y later\n",
-=09=09=09=09=09 ret);
-=09=09=09=09list_add_tail(&forget->list,
-=09=09=09=09=09=09&fsvq->queued_reqs);
-=09=09=09=09schedule_delayed_work(&fsvq->dispatch_work,
-=09=09=09=09=09=09msecs_to_jiffies(1));
-=09=09=09} else {
-=09=09=09=09pr_debug("virtio-fs: Could not queue FORGET: err=3D%d. Droppin=
g it.\n",
-=09=09=09=09=09 ret);
-=09=09=09=09dec_in_flight_req(fsvq);
-=09=09=09=09kfree(forget);
-=09=09=09}
-=09=09=09spin_unlock(&fsvq->lock);
-=09=09=09return;
-=09=09}
-
-=09=09notify =3D virtqueue_kick_prepare(vq);
 =09=09spin_unlock(&fsvq->lock);
-
-=09=09if (notify)
-=09=09=09virtqueue_notify(vq);
-=09=09pr_debug("virtio-fs: worker %s dispatched one forget request.\n",
-=09=09=09 __func__);
+=09=09if (send_forget_request(fsvq, forget, true))
+=09=09=09return;
 =09}
 }
=20
@@ -710,14 +730,9 @@ __releases(fiq->lock)
 {
 =09struct fuse_forget_link *link;
 =09struct virtio_fs_forget *forget;
-=09struct scatterlist sg;
-=09struct scatterlist *sgs[] =3D {&sg};
 =09struct virtio_fs *fs;
-=09struct virtqueue *vq;
 =09struct virtio_fs_vq *fsvq;
-=09bool notify;
 =09u64 unique;
-=09int ret;
=20
 =09link =3D fuse_dequeue_forget(fiq, 1, NULL);
 =09unique =3D fuse_get_unique(fiq);
@@ -739,46 +754,7 @@ __releases(fiq->lock)
 =09=09.nlookup =3D link->forget_one.nlookup,
 =09};
=20
-=09sg_init_one(&sg, forget, sizeof(*forget));
-
-=09/* Enqueue the request */
-=09spin_lock(&fsvq->lock);
-
-=09if (!fsvq->connected) {
-=09=09kfree(forget);
-=09=09spin_unlock(&fsvq->lock);
-=09=09goto out;
-=09}
-
-=09vq =3D fsvq->vq;
-=09dev_dbg(&vq->vdev->dev, "%s\n", __func__);
-
-=09ret =3D virtqueue_add_sgs(vq, sgs, 1, 0, forget, GFP_ATOMIC);
-=09if (ret < 0) {
-=09=09if (ret =3D=3D -ENOMEM || ret =3D=3D -ENOSPC) {
-=09=09=09pr_debug("virtio-fs: Could not queue FORGET: err=3D%d. Will try l=
ater.\n",
-=09=09=09=09 ret);
-=09=09=09list_add_tail(&forget->list, &fsvq->queued_reqs);
-=09=09=09schedule_delayed_work(&fsvq->dispatch_work,
-=09=09=09=09=09msecs_to_jiffies(1));
-=09=09=09inc_in_flight_req(fsvq);
-=09=09} else {
-=09=09=09pr_debug("virtio-fs: Could not queue FORGET: err=3D%d. Dropping i=
t.\n",
-=09=09=09=09 ret);
-=09=09=09kfree(forget);
-=09=09}
-=09=09spin_unlock(&fsvq->lock);
-=09=09goto out;
-=09}
-
-=09inc_in_flight_req(fsvq);
-=09notify =3D virtqueue_kick_prepare(vq);
-
-=09spin_unlock(&fsvq->lock);
-
-=09if (notify)
-=09=09virtqueue_notify(vq);
-out:
+=09send_forget_request(fsvq, forget, false);
 =09kfree(link);
 }
=20
--=20
2.20.1

