Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBD924A933
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 00:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgHSWWX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 18:22:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24007 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727903AbgHSWVL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 18:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597875670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FE1t/TwDu4PMDFPS8TRkGpVdFOvXwiHJwlwFE0ieZjw=;
        b=fYdZ/Iulfe9rabSC0pEVRvnNtYMf4C2Yme8YNcF2C948ZD+6bCIAjUUgy5iV54jCPE/sgJ
        yHOJTtQx5Uz+ihhppyG7YUosaUA23XO146PyK4bk7LH/4plvPwy6WhQiU3pGvpFI0bESSH
        JYR5u2OL8hDBB0//9cPktbjRjmJfn6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-kvCFBVM0N6m5rIVDDpSkww-1; Wed, 19 Aug 2020 18:21:08 -0400
X-MC-Unique: kvCFBVM0N6m5rIVDDpSkww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75029425DB;
        Wed, 19 Aug 2020 22:21:07 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-197.rdu2.redhat.com [10.10.115.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7777A5D9D5;
        Wed, 19 Aug 2020 22:21:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E76AC2256E4; Wed, 19 Aug 2020 18:20:53 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, dan.j.williams@intel.com
Subject: [PATCH v3 06/18] virtiofs: Provide a helper function for virtqueue initialization
Date:   Wed, 19 Aug 2020 18:19:44 -0400
Message-Id: <20200819221956.845195-7-vgoyal@redhat.com>
In-Reply-To: <20200819221956.845195-1-vgoyal@redhat.com>
References: <20200819221956.845195-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
index 104f35de5270..ed8da4825b70 100644
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

