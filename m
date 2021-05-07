Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFE8376C56
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 May 2021 00:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhEGWQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 May 2021 18:16:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26586 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229470AbhEGWQc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 May 2021 18:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620425731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jtUv57ArMiro4bTHhEhdlXIGNZ+0agUPq7/A51n97kU=;
        b=W2EKJwGqPbOnIF6JkCCOHaoOWcVps76qpIQlc6jtsH3TsHw6Noe+ZF220SLTSSH/o1P1P0
        C4fvUMbJMqfweCQIo/5kiQPBBOqD1WNPc1TZ9ne7Z859tUJBzD3xI0mYOEK6xYmw6BXR4t
        81VVrb43b2Szs8RFkxRefDVjcxsiUlc=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-9HctKvLpOnKOeUBxtNubXA-1; Fri, 07 May 2021 18:15:29 -0400
X-MC-Unique: 9HctKvLpOnKOeUBxtNubXA-1
Received: by mail-ot1-f71.google.com with SMTP id c17-20020a0568303151b02902a55e7d1747so5901772ots.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 May 2021 15:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jtUv57ArMiro4bTHhEhdlXIGNZ+0agUPq7/A51n97kU=;
        b=nSX7RPCf9+KVh436OXfLvCTE3L7KzY+5sWKqO6Y7YdpTyZX/rxN7X3YMqRR2LSVH20
         M5Poq+FlKaUcUPARTtaEGERBro2I8pSWqnVq70DlrweYLa+uH9rx37Vwo/OqZJA4/fv6
         jtk1oMrw3a7mM+nQnBWEF79Nn4PFTLwRBTCcpd+bQBZKwdBeZOVwWWRcD3AQwsCtjq2C
         O3djn481LOceDAcZmFEvhShAdlUx/sBrGJo7BT7X1Rhvd/vwZrWJfif3uxq8J95yx3GU
         3HcLdLlWc4IsgxFd1v9FYZQIvf7ngHh+JNsb09WzO/gjrnvHOG8bE/90CS1AKR5rZSod
         sOcg==
X-Gm-Message-State: AOAM532BgP08ZNC09BLD+Agi70Zg4RMMApolijwxx7Sj3rHUGNAUdJbQ
        mWHeBUIfSlN4z2vi452AwxVErv9qKAnQ7w7QgRgu3Xrjg5nJDBAASTrSmHeVzU9QJOFslcYov5f
        qpBBfmwfBxcH++QcwyW+Ad9AxYQ==
X-Received: by 2002:aca:db05:: with SMTP id s5mr15825273oig.134.1620425729239;
        Fri, 07 May 2021 15:15:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOP88BBurGoU0f7ioDsjdxBGt9XwNveg3axEkgvcGkjmkgo5INgRySJeIWZ/JqBdbZtM6hfA==
X-Received: by 2002:aca:db05:: with SMTP id s5mr15825262oig.134.1620425729104;
        Fri, 07 May 2021 15:15:29 -0700 (PDT)
Received: from redhat.redhat.com (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id n37sm1464589otn.9.2021.05.07.15.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 15:15:28 -0700 (PDT)
From:   Connor Kuehl <ckuehl@redhat.com>
To:     virtio-fs@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH] virtiofs: Enable multiple request queues
Date:   Fri,  7 May 2021 17:15:27 -0500
Message-Id: <20210507221527.699516-1-ckuehl@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Distribute requests across the multiqueue complex automatically based
on the IRQ affinity.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
---
 fs/fuse/virtio_fs.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index bcb8a02e2d8b..dcdc8b7b1ad5 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -30,6 +30,10 @@
 static DEFINE_MUTEX(virtio_fs_mutex);
 static LIST_HEAD(virtio_fs_instances);
 
+struct virtio_fs_vq;
+
+DEFINE_PER_CPU(struct virtio_fs_vq *, this_cpu_fsvq);
+
 enum {
 	VQ_HIPRIO,
 	VQ_REQUEST
@@ -673,6 +677,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	struct virtqueue **vqs;
 	vq_callback_t **callbacks;
 	const char **names;
+	struct irq_affinity desc = { .pre_vectors = 1, .nr_sets = 1, };
 	unsigned int i;
 	int ret = 0;
 
@@ -681,6 +686,9 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	if (fs->num_request_queues == 0)
 		return -EINVAL;
 
+	fs->num_request_queues = min_t(unsigned int, nr_cpu_ids,
+				       fs->num_request_queues);
+
 	fs->nvqs = VQ_REQUEST + fs->num_request_queues;
 	fs->vqs = kcalloc(fs->nvqs, sizeof(fs->vqs[VQ_HIPRIO]), GFP_KERNEL);
 	if (!fs->vqs)
@@ -710,12 +718,24 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 		names[i] = fs->vqs[i].name;
 	}
 
-	ret = virtio_find_vqs(vdev, fs->nvqs, vqs, callbacks, names, NULL);
+	ret = virtio_find_vqs(vdev, fs->nvqs, vqs, callbacks, names, &desc);
 	if (ret < 0)
 		goto out;
 
-	for (i = 0; i < fs->nvqs; i++)
+	for (i = 0; i < fs->nvqs; i++) {
+		const struct cpumask *mask;
+		unsigned int cpu;
+
 		fs->vqs[i].vq = vqs[i];
+		if (i == VQ_HIPRIO)
+			continue;
+
+		mask = vdev->config->get_vq_affinity(vdev, i);
+		for_each_cpu(cpu, mask) {
+			struct virtio_fs_vq **cpu_vq = per_cpu_ptr(&this_cpu_fsvq, cpu);
+			*cpu_vq = &fs->vqs[i];
+		}
+	}
 
 	virtio_fs_start_all_queues(fs);
 out:
@@ -877,8 +897,6 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 	if (ret < 0)
 		goto out;
 
-	/* TODO vq affinity */
-
 	ret = virtio_fs_setup_dax(vdev, fs);
 	if (ret < 0)
 		goto out_vqs;
@@ -1225,7 +1243,6 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 static void virtio_fs_wake_pending_and_unlock(struct fuse_iqueue *fiq)
 __releases(fiq->lock)
 {
-	unsigned int queue_id = VQ_REQUEST; /* TODO multiqueue */
 	struct virtio_fs *fs;
 	struct fuse_req *req;
 	struct virtio_fs_vq *fsvq;
@@ -1245,7 +1262,8 @@ __releases(fiq->lock)
 		 req->in.h.nodeid, req->in.h.len,
 		 fuse_len_args(req->args->out_numargs, req->args->out_args));
 
-	fsvq = &fs->vqs[queue_id];
+	fsvq = this_cpu_read(this_cpu_fsvq);
+
 	ret = virtio_fs_enqueue_req(fsvq, req, false);
 	if (ret < 0) {
 		if (ret == -ENOMEM || ret == -ENOSPC) {
-- 
2.30.2

