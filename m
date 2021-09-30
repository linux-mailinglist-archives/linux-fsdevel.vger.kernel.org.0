Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07B541DC77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 16:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350934AbhI3Ok6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 10:40:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29376 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350879AbhI3Okx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633012750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UtUkQWJbDRAqbfT3IX+l0UQCv/ZZhkQb3oKNdmjXXWQ=;
        b=T65eObLUKUuRz0BcQTWv4Xyvl4O+lmpiJPEGEWdeO80ZdBto3S6cS2XjyJNYpu2Bm4HvJ3
        ysMX/hCUSWAB7ISOmIYKTjVuR3VUbT5pPFCkdVBN7L8K69KIjsoi2e4HVVVOfEO+kydTUj
        UUw4lrGZqAlSBMUB/LcUEDB+dtjhloc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-douBEBxUPGKUfpWHua6YJw-1; Thu, 30 Sep 2021 10:39:08 -0400
X-MC-Unique: douBEBxUPGKUfpWHua6YJw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84CD4802947;
        Thu, 30 Sep 2021 14:39:07 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.16.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 315C65F4E1;
        Thu, 30 Sep 2021 14:39:07 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C756C228282; Thu, 30 Sep 2021 10:39:06 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu, stefanha@redhat.com
Cc:     vgoyal@redhat.com, iangelak@redhat.com, jaggel@bu.edu,
        dgilbert@redhat.com
Subject: [PATCH 3/8] virtiofs: Add an index to keep track of first request queue
Date:   Thu, 30 Sep 2021 10:38:45 -0400
Message-Id: <20210930143850.1188628-4-vgoyal@redhat.com>
In-Reply-To: <20210930143850.1188628-1-vgoyal@redhat.com>
References: <20210930143850.1188628-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have many virtqueues and first queue which carries fuse normal requests
(except forget requests) has index pointed to by enum VQ_REQUEST. This
works fine as long as number of queues are not dynamic.

I am about to introduce one more virtqueue, called notification queue,
which will be present only if device on host supports it. That means index
of request queue will change depending on if notification queue is present
or not.

So, add a variable to keep track of that index and this will help when
notification queue is added in next patch.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Ioannis Angelakopoulos <iangelak@redhat.com>
---
 fs/fuse/virtio_fs.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index f7c58a4b996d..cb3c7bf8cce4 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -61,6 +61,7 @@ struct virtio_fs {
 	unsigned int nvqs;               /* number of virtqueues */
 	unsigned int num_request_queues; /* number of request queues */
 	struct dax_device *dax_dev;
+	unsigned int first_reqq_idx;     /* First request queue idx */
 
 	/* DAX memory window where file contents are mapped */
 	void *window_kaddr;
@@ -676,7 +677,9 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	if (fs->num_request_queues == 0)
 		return -EINVAL;
 
-	fs->nvqs = VQ_REQUEST + fs->num_request_queues;
+	/* One hiprio queue and rest are request queues */
+	fs->nvqs = 1 + fs->num_request_queues;
+	fs->first_reqq_idx = 1;
 	fs->vqs = kcalloc(fs->nvqs, sizeof(fs->vqs[VQ_HIPRIO]), GFP_KERNEL);
 	if (!fs->vqs)
 		return -ENOMEM;
@@ -696,10 +699,11 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	names[VQ_HIPRIO] = fs->vqs[VQ_HIPRIO].name;
 
 	/* Initialize the requests virtqueues */
-	for (i = VQ_REQUEST; i < fs->nvqs; i++) {
+	for (i = fs->first_reqq_idx; i < fs->nvqs; i++) {
 		char vq_name[VQ_NAME_LEN];
 
-		snprintf(vq_name, VQ_NAME_LEN, "requests.%u", i - VQ_REQUEST);
+		snprintf(vq_name, VQ_NAME_LEN, "requests.%u",
+			 i - fs->first_reqq_idx);
 		virtio_fs_init_vq(&fs->vqs[i], vq_name, VQ_REQUEST);
 		callbacks[i] = virtio_fs_vq_done;
 		names[i] = fs->vqs[i].name;
@@ -1217,7 +1221,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 static void virtio_fs_wake_pending_and_unlock(struct fuse_iqueue *fiq)
 __releases(fiq->lock)
 {
-	unsigned int queue_id = VQ_REQUEST; /* TODO multiqueue */
+	unsigned int queue_id;
 	struct virtio_fs *fs;
 	struct fuse_req *req;
 	struct virtio_fs_vq *fsvq;
@@ -1231,6 +1235,7 @@ __releases(fiq->lock)
 	spin_unlock(&fiq->lock);
 
 	fs = fiq->priv;
+	queue_id = fs->first_reqq_idx;
 
 	pr_debug("%s: opcode %u unique %#llx nodeid %#llx in.len %u out.len %u\n",
 		  __func__, req->in.h.opcode, req->in.h.unique,
@@ -1411,6 +1416,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	struct fuse_mount *fm;
 	unsigned int virtqueue_size;
 	int err = -EIO;
+	struct virtio_fs_vq *first_req_fsvq;
 
 	/* This gets a reference on virtio_fs object. This ptr gets installed
 	 * in fc->iq->priv. Once fuse_conn is going away, it calls ->put()
@@ -1422,7 +1428,8 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 		return -EINVAL;
 	}
 
-	virtqueue_size = virtqueue_get_vring_size(fs->vqs[VQ_REQUEST].vq);
+	first_req_fsvq = &fs->vqs[fs->first_reqq_idx];
+	virtqueue_size = virtqueue_get_vring_size(first_req_fsvq->vq);
 	if (WARN_ON(virtqueue_size <= FUSE_HEADER_OVERHEAD))
 		goto out_err;
 
-- 
2.31.1

