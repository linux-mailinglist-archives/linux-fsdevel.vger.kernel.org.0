Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A47F179600
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 17:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbgCDQ7p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 11:59:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25871 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730075AbgCDQ7Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583341163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=in8wBUneqY4n7qVAOIf0MzORUcroBTFmXBeAbVWzZG0=;
        b=Bwd3wUeHQCeyrpPBZ+GhFHql8A8dEaS9IsdfEuhbT8pRQBx5HuVPKcQ/ss86ks+2UjdLLt
        sIuOoHiANiLLbdtnGX7lmwZg9Fb3zHkGY6+xeopaMZmg/yfghlG+aqPXWYoRkCMfC7aksW
        BYi8cttbCAr3kewIxjwcO9USrg0eSyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98--3o4On_SN2qq9T5t_4VqQQ-1; Wed, 04 Mar 2020 11:59:20 -0500
X-MC-Unique: -3o4On_SN2qq9T5t_4VqQQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B1F1DB67;
        Wed,  4 Mar 2020 16:59:19 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92D8E1001B09;
        Wed,  4 Mar 2020 16:59:11 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 4ECA52257D8; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com
Subject: [PATCH 06/20] virtiofs: Provide a helper function for virtqueue initialization
Date:   Wed,  4 Mar 2020 11:58:31 -0500
Message-Id: <20200304165845.3081-7-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
index bade74768903..a16cc9195087 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -24,6 +24,8 @@ enum {
 	VQ_REQUEST
 };
=20
+#define VQ_NAME_LEN	24
+
 /* Per-virtqueue state */
 struct virtio_fs_vq {
 	spinlock_t lock;
@@ -36,7 +38,7 @@ struct virtio_fs_vq {
 	bool connected;
 	long in_flight;
 	struct completion in_flight_zero; /* No inflight requests */
-	char name[24];
+	char name[VQ_NAME_LEN];
 } ____cacheline_aligned_in_smp;
=20
 /* A virtio-fs device instance */
@@ -560,6 +562,26 @@ static void virtio_fs_vq_done(struct virtqueue *vq)
 	schedule_work(&fsvq->done_work);
 }
=20
+static void virtio_fs_init_vq(struct virtio_fs_vq *fsvq, char *name,
+			      int vq_type)
+{
+	strncpy(fsvq->name, name, VQ_NAME_LEN);
+	spin_lock_init(&fsvq->lock);
+	INIT_LIST_HEAD(&fsvq->queued_reqs);
+	INIT_LIST_HEAD(&fsvq->end_reqs);
+	init_completion(&fsvq->in_flight_zero);
+
+	if (vq_type =3D=3D VQ_REQUEST) {
+		INIT_WORK(&fsvq->done_work, virtio_fs_requests_done_work);
+		INIT_DELAYED_WORK(&fsvq->dispatch_work,
+				  virtio_fs_request_dispatch_work);
+	} else {
+		INIT_WORK(&fsvq->done_work, virtio_fs_hiprio_done_work);
+		INIT_DELAYED_WORK(&fsvq->dispatch_work,
+				  virtio_fs_hiprio_dispatch_work);
+	}
+}
+
 /* Initialize virtqueues */
 static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 			       struct virtio_fs *fs)
@@ -575,7 +597,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *=
vdev,
 	if (fs->num_request_queues =3D=3D 0)
 		return -EINVAL;
=20
-	fs->nvqs =3D 1 + fs->num_request_queues;
+	fs->nvqs =3D VQ_REQUEST + fs->num_request_queues;
 	fs->vqs =3D kcalloc(fs->nvqs, sizeof(fs->vqs[VQ_HIPRIO]), GFP_KERNEL);
 	if (!fs->vqs)
 		return -ENOMEM;
@@ -589,29 +611,17 @@ static int virtio_fs_setup_vqs(struct virtio_device=
 *vdev,
 		goto out;
 	}
=20
+	/* Initialize the hiprio/forget request virtqueue */
 	callbacks[VQ_HIPRIO] =3D virtio_fs_vq_done;
-	snprintf(fs->vqs[VQ_HIPRIO].name, sizeof(fs->vqs[VQ_HIPRIO].name),
-			"hiprio");
+	virtio_fs_init_vq(&fs->vqs[VQ_HIPRIO], "hiprio", VQ_HIPRIO);
 	names[VQ_HIPRIO] =3D fs->vqs[VQ_HIPRIO].name;
-	INIT_WORK(&fs->vqs[VQ_HIPRIO].done_work, virtio_fs_hiprio_done_work);
-	INIT_LIST_HEAD(&fs->vqs[VQ_HIPRIO].queued_reqs);
-	INIT_LIST_HEAD(&fs->vqs[VQ_HIPRIO].end_reqs);
-	INIT_DELAYED_WORK(&fs->vqs[VQ_HIPRIO].dispatch_work,
-			virtio_fs_hiprio_dispatch_work);
-	init_completion(&fs->vqs[VQ_HIPRIO].in_flight_zero);
-	spin_lock_init(&fs->vqs[VQ_HIPRIO].lock);
=20
 	/* Initialize the requests virtqueues */
 	for (i =3D VQ_REQUEST; i < fs->nvqs; i++) {
-		spin_lock_init(&fs->vqs[i].lock);
-		INIT_WORK(&fs->vqs[i].done_work, virtio_fs_requests_done_work);
-		INIT_DELAYED_WORK(&fs->vqs[i].dispatch_work,
-				  virtio_fs_request_dispatch_work);
-		INIT_LIST_HEAD(&fs->vqs[i].queued_reqs);
-		INIT_LIST_HEAD(&fs->vqs[i].end_reqs);
-		init_completion(&fs->vqs[i].in_flight_zero);
-		snprintf(fs->vqs[i].name, sizeof(fs->vqs[i].name),
-			 "requests.%u", i - VQ_REQUEST);
+		char vq_name[VQ_NAME_LEN];
+
+		snprintf(vq_name, VQ_NAME_LEN, "requests.%u", i - VQ_REQUEST);
+		virtio_fs_init_vq(&fs->vqs[i], vq_name, VQ_REQUEST);
 		callbacks[i] =3D virtio_fs_vq_done;
 		names[i] =3D fs->vqs[i].name;
 	}
--=20
2.20.1

