Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B753AA0E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 18:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhFPQLU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 12:11:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234803AbhFPQLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623859752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=khts0PFFhiAVECLijFaUcEW8ZVab28Cd+CX3nPIw14w=;
        b=hbOct9XyVWkXZBChfvxxMjJRGEvWFEqyoYViCprq1M5+BDtDX8vpJSZPpS4LXAAMahwuXK
        uWXyYEQRO2DhQKPnFwyvZyqc1nSTnL7558keSo3kaLAH+qVQ/qrALMMvEAHrMS5cnvnVOf
        MCb15uQP5Vjrj2EGlusp9LnuQTtELcE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-nksdADxqP_yF_hZaN-3qJg-1; Wed, 16 Jun 2021 12:09:10 -0400
X-MC-Unique: nksdADxqP_yF_hZaN-3qJg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB1D2192AB7C;
        Wed, 16 Jun 2021 16:09:09 +0000 (UTC)
Received: from iangelak.remote.csb (ovpn-113-44.rdu2.redhat.com [10.10.113.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 611D15C1C5;
        Wed, 16 Jun 2021 16:09:06 +0000 (UTC)
From:   Ioannis Angelakopoulos <iangelak@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com
Cc:     miklos@szeredi.hu, stefanha@redhat.com, vgoyal@redhat.com
Subject: [PATCH 1/3] virtiofs: Add an index to keep track of first request queue
Date:   Wed, 16 Jun 2021 12:08:34 -0400
Message-Id: <20210616160836.590206-2-iangelak@redhat.com>
In-Reply-To: <20210616160836.590206-1-iangelak@redhat.com>
References: <20210616160836.590206-1-iangelak@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Vivek Goyal <vgoyal@redhat.com>

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
 fs/fuse/virtio_fs.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index bcb8a02e2d8b..a545e31cf1ae 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -61,6 +61,7 @@ struct virtio_fs {
 	unsigned int nvqs;               /* number of virtqueues */
 	unsigned int num_request_queues; /* number of request queues */
 	struct dax_device *dax_dev;
+	unsigned int first_reqq_idx;     /* First request queue idx */
 
 	/* DAX memory window where file contents are mapped */
 	void *window_kaddr;
@@ -681,7 +682,9 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	if (fs->num_request_queues == 0)
 		return -EINVAL;
 
-	fs->nvqs = VQ_REQUEST + fs->num_request_queues;
+	/* One hiprio queue and rest are request queues */
+	fs->nvqs = 1 + fs->num_request_queues;
+	fs->first_reqq_idx = 1;
 	fs->vqs = kcalloc(fs->nvqs, sizeof(fs->vqs[VQ_HIPRIO]), GFP_KERNEL);
 	if (!fs->vqs)
 		return -ENOMEM;
@@ -701,10 +704,11 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
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
@@ -1225,7 +1229,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 static void virtio_fs_wake_pending_and_unlock(struct fuse_iqueue *fiq)
 __releases(fiq->lock)
 {
-	unsigned int queue_id = VQ_REQUEST; /* TODO multiqueue */
+	unsigned int queue_id;
 	struct virtio_fs *fs;
 	struct fuse_req *req;
 	struct virtio_fs_vq *fsvq;
@@ -1239,6 +1243,7 @@ __releases(fiq->lock)
 	spin_unlock(&fiq->lock);
 
 	fs = fiq->priv;
+	queue_id = fs->first_reqq_idx;
 
 	pr_debug("%s: opcode %u unique %#llx nodeid %#llx in.len %u out.len %u\n",
 		  __func__, req->in.h.opcode, req->in.h.unique,
@@ -1316,7 +1321,7 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
 
 	err = -ENOMEM;
 	/* Allocate fuse_dev for hiprio and notification queues */
-	for (i = 0; i < fs->nvqs; i++) {
+	for (i = 0; i < fs->first_reqq_idx; i++) {
 		struct virtio_fs_vq *fsvq = &fs->vqs[i];
 
 		fsvq->fud = fuse_dev_alloc();
@@ -1325,7 +1330,7 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
 	}
 
 	/* virtiofs allocates and installs its own fuse devices */
-	ctx->fudptr = NULL;
+	ctx->fudptr = (void **)&fs->vqs[fs->first_reqq_idx].fud;
 	if (ctx->dax) {
 		if (!fs->dax_dev) {
 			err = -EINVAL;
@@ -1339,9 +1344,14 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
 	if (err < 0)
 		goto err_free_fuse_devs;
 
+	fc = fs->vqs[fs->first_reqq_idx].fud->fc;
+
 	for (i = 0; i < fs->nvqs; i++) {
 		struct virtio_fs_vq *fsvq = &fs->vqs[i];
 
+		if (i == fs->first_reqq_idx)
+			continue;
+
 		fuse_dev_install(fsvq->fud, fc);
 	}
 
-- 
2.27.0

