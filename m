Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B0323F355
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 21:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgHGT4m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 15:56:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56044 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726918AbgHGTzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596830154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BDe9SblDEhv0vLYedGkGVjAfd7sAv5XmgCgw2xWVnkQ=;
        b=LYwLNsSJxAb4BlEna2haVqnaPUvb2Y+kj4v94gSi8+LUVnIdL94GKwW6kOMUkgLMlhJUxn
        jhrkoEmt61WXmki1xoLsR0BrurHsjUBy6IoZwJdA6xWtCJnH6FNvnkzfK6BXaFeFeIteWv
        YKB9RSM3/p44VIJ1eux3gAwkSzsIzeo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-3zX15gWgNwKG-A13e8PxxQ-1; Fri, 07 Aug 2020 15:55:52 -0400
X-MC-Unique: 3zX15gWgNwKG-A13e8PxxQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BAB857;
        Fri,  7 Aug 2020 19:55:51 +0000 (UTC)
Received: from horse.redhat.com (ovpn-113-142.rdu2.redhat.com [10.10.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 793DE5C1C3;
        Fri,  7 Aug 2020 19:55:45 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id BEEC8222E4A; Fri,  7 Aug 2020 15:55:38 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com
Subject: [PATCH v2 06/20] virtiofs: Provide a helper function for virtqueue initialization
Date:   Fri,  7 Aug 2020 15:55:12 -0400
Message-Id: <20200807195526.426056-7-vgoyal@redhat.com>
In-Reply-To: <20200807195526.426056-1-vgoyal@redhat.com>
References: <20200807195526.426056-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
index 4c4ef5d69298..e615edfbd09c 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -24,6 +24,8 @@ enum {
 	VQ_REQUEST
 };
 
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
 
 /* A virtio-fs device instance */
@@ -596,6 +598,26 @@ static void virtio_fs_vq_done(struct virtqueue *vq)
 	schedule_work(&fsvq->done_work);
 }
 
+static void virtio_fs_init_vq(struct virtio_fs_vq *fsvq, char *name,
+			      int vq_type)
+{
+	strncpy(fsvq->name, name, VQ_NAME_LEN);
+	spin_lock_init(&fsvq->lock);
+	INIT_LIST_HEAD(&fsvq->queued_reqs);
+	INIT_LIST_HEAD(&fsvq->end_reqs);
+	init_completion(&fsvq->in_flight_zero);
+
+	if (vq_type == VQ_REQUEST) {
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
@@ -611,7 +633,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	if (fs->num_request_queues == 0)
 		return -EINVAL;
 
-	fs->nvqs = 1 + fs->num_request_queues;
+	fs->nvqs = VQ_REQUEST + fs->num_request_queues;
 	fs->vqs = kcalloc(fs->nvqs, sizeof(fs->vqs[VQ_HIPRIO]), GFP_KERNEL);
 	if (!fs->vqs)
 		return -ENOMEM;
@@ -625,29 +647,17 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 		goto out;
 	}
 
+	/* Initialize the hiprio/forget request virtqueue */
 	callbacks[VQ_HIPRIO] = virtio_fs_vq_done;
-	snprintf(fs->vqs[VQ_HIPRIO].name, sizeof(fs->vqs[VQ_HIPRIO].name),
-			"hiprio");
+	virtio_fs_init_vq(&fs->vqs[VQ_HIPRIO], "hiprio", VQ_HIPRIO);
 	names[VQ_HIPRIO] = fs->vqs[VQ_HIPRIO].name;
-	INIT_WORK(&fs->vqs[VQ_HIPRIO].done_work, virtio_fs_hiprio_done_work);
-	INIT_LIST_HEAD(&fs->vqs[VQ_HIPRIO].queued_reqs);
-	INIT_LIST_HEAD(&fs->vqs[VQ_HIPRIO].end_reqs);
-	INIT_DELAYED_WORK(&fs->vqs[VQ_HIPRIO].dispatch_work,
-			virtio_fs_hiprio_dispatch_work);
-	init_completion(&fs->vqs[VQ_HIPRIO].in_flight_zero);
-	spin_lock_init(&fs->vqs[VQ_HIPRIO].lock);
 
 	/* Initialize the requests virtqueues */
 	for (i = VQ_REQUEST; i < fs->nvqs; i++) {
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
 		callbacks[i] = virtio_fs_vq_done;
 		names[i] = fs->vqs[i].name;
 	}
-- 
2.25.4

