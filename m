Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46698E9E70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 16:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfJ3PIP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 11:08:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39194 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726772AbfJ3PHv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572448069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X/BAPwzaK/VJWK6Euc/hOkg2V08gfO99tWNJkHvuumY=;
        b=BqNmjNu88ryFH2Mg0xNhZ2PO3P7D753sI+6IB6YAqLi0BkkbcWwduCfiz0Fbeh42BaJBHg
        g1CYarYiq+IcmmniJkXpsT1HIVngvUobNSIg0LGAFUnYCwTHCDVgkcD1Qf+LSb2Y12fE88
        Jxl6gJDo5p64jjJ966wvwFe+I+AvhVw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-71cRbL-gN9-DhBO2t6aLVw-1; Wed, 30 Oct 2019 11:07:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFE5F107ACC0;
        Wed, 30 Oct 2019 15:07:44 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B6C160C85;
        Wed, 30 Oct 2019 15:07:39 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E0B832256E4; Wed, 30 Oct 2019 11:07:38 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Cc:     virtualization@lists.linux-foundation.org, vgoyal@redhat.com,
        miklos@szeredi.hu, stefanha@redhat.com, dgilbert@redhat.com
Subject: [PATCH 3/3] virtiofs: Use completions while waiting for queue to be drained
Date:   Wed, 30 Oct 2019 11:07:19 -0400
Message-Id: <20191030150719.29048-4-vgoyal@redhat.com>
In-Reply-To: <20191030150719.29048-1-vgoyal@redhat.com>
References: <20191030150719.29048-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 71cRbL-gN9-DhBO2t6aLVw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While we wait for queue to finish draining, use completions instead of
uslee_range(). This is better way of waiting for event.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 43224db8d9ed..b5ba83ef1914 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -35,6 +35,7 @@ struct virtio_fs_vq {
 =09struct fuse_dev *fud;
 =09bool connected;
 =09long in_flight;
+=09struct completion in_flight_zero; /* No inflight requests */
 =09char name[24];
 } ____cacheline_aligned_in_smp;
=20
@@ -85,6 +86,8 @@ static inline void dec_in_flight_req(struct virtio_fs_vq =
*fsvq)
 {
 =09WARN_ON(fsvq->in_flight <=3D 0);
 =09fsvq->in_flight--;
+=09if (!fsvq->in_flight)
+=09=09complete(&fsvq->in_flight_zero);
 }
=20
 static void release_virtio_fs_obj(struct kref *ref)
@@ -115,22 +118,23 @@ static void virtio_fs_drain_queue(struct virtio_fs_vq=
 *fsvq)
 =09WARN_ON(fsvq->in_flight < 0);
=20
 =09/* Wait for in flight requests to finish.*/
-=09while (1) {
-=09=09spin_lock(&fsvq->lock);
-=09=09if (!fsvq->in_flight) {
-=09=09=09spin_unlock(&fsvq->lock);
-=09=09=09break;
-=09=09}
+=09spin_lock(&fsvq->lock);
+=09if (fsvq->in_flight) {
+=09=09/* We are holding virtio_fs_mutex. There should not be any
+=09=09 * waiters waiting for completion.
+=09=09 */
+=09=09reinit_completion(&fsvq->in_flight_zero);
+=09=09spin_unlock(&fsvq->lock);
+=09=09wait_for_completion(&fsvq->in_flight_zero);
+=09} else {
 =09=09spin_unlock(&fsvq->lock);
-=09=09/* TODO use completion instead of timeout */
-=09=09usleep_range(1000, 2000);
 =09}
=20
 =09flush_work(&fsvq->done_work);
 =09flush_delayed_work(&fsvq->dispatch_work);
 }
=20
-static void virtio_fs_drain_all_queues(struct virtio_fs *fs)
+static void virtio_fs_drain_all_queues_locked(struct virtio_fs *fs)
 {
 =09struct virtio_fs_vq *fsvq;
 =09int i;
@@ -141,6 +145,19 @@ static void virtio_fs_drain_all_queues(struct virtio_f=
s *fs)
 =09}
 }
=20
+static void virtio_fs_drain_all_queues(struct virtio_fs *fs)
+{
+=09/* Provides mutual exclusion between ->remove and ->kill_sb
+=09 * paths. We don't want both of these draining queue at the
+=09 * same time. Current completion logic reinits completion
+=09 * and that means there should not be any other thread
+=09 * doing reinit or waiting for completion already.
+=09 */
+=09mutex_lock(&virtio_fs_mutex);
+=09virtio_fs_drain_all_queues_locked(fs);
+=09mutex_unlock(&virtio_fs_mutex);
+}
+
 static void virtio_fs_start_all_queues(struct virtio_fs *fs)
 {
 =09struct virtio_fs_vq *fsvq;
@@ -581,6 +598,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vd=
ev,
 =09INIT_LIST_HEAD(&fs->vqs[VQ_HIPRIO].end_reqs);
 =09INIT_DELAYED_WORK(&fs->vqs[VQ_HIPRIO].dispatch_work,
 =09=09=09virtio_fs_hiprio_dispatch_work);
+=09init_completion(&fs->vqs[VQ_HIPRIO].in_flight_zero);
 =09spin_lock_init(&fs->vqs[VQ_HIPRIO].lock);
=20
 =09/* Initialize the requests virtqueues */
@@ -591,6 +609,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vd=
ev,
 =09=09=09=09  virtio_fs_request_dispatch_work);
 =09=09INIT_LIST_HEAD(&fs->vqs[i].queued_reqs);
 =09=09INIT_LIST_HEAD(&fs->vqs[i].end_reqs);
+=09=09init_completion(&fs->vqs[i].in_flight_zero);
 =09=09snprintf(fs->vqs[i].name, sizeof(fs->vqs[i].name),
 =09=09=09 "requests.%u", i - VQ_REQUEST);
 =09=09callbacks[i] =3D virtio_fs_vq_done;
@@ -684,7 +703,7 @@ static void virtio_fs_remove(struct virtio_device *vdev=
)
 =09/* This device is going away. No one should get new reference */
 =09list_del_init(&fs->list);
 =09virtio_fs_stop_all_queues(fs);
-=09virtio_fs_drain_all_queues(fs);
+=09virtio_fs_drain_all_queues_locked(fs);
 =09vdev->config->reset(vdev);
 =09virtio_fs_cleanup_vqs(vdev, fs);
=20
--=20
2.20.1

