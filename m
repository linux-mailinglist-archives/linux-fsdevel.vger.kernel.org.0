Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D070D6493B6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Dec 2022 11:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiLKKmV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 05:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiLKKkW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 05:40:22 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C969DFAC3
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Dec 2022 02:40:13 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so9310568pjd.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Dec 2022 02:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cxkF/mYZx6aj+5Ygz21Fb/S0r5K5GOn3gye9ZMP6pug=;
        b=pVDqthDQYAAmqfvohGeBDA6PQFeGvJNmli/YkLcZ431HN8Ltsw2yY8zpe2wJ0aYdCj
         Mpa56EttuvuBEW2ho2V2KXkt5eY+6ODXvs2yngSQVU5RBiVuTMBjzRTtaBE8CSyOnpMd
         UVs+JzwE08nqtsm/YG82fmBy0KkD5mp45yCKMiEkEPhNsffihOX/lxVFxEWmWXCdjsUE
         vJBmh10Hnsc0nvpkZPqMDavk1l/bn1bJwwqf1l9RpZYgOCf6URKo0LiNNeCq6LAtcuqL
         v60GduQODF4uXkMTH6flUS4nQwZSnUL8/qxv8Dv77EftGPg7RyUOBqLt/y6lp1/ZWG9I
         e/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxkF/mYZx6aj+5Ygz21Fb/S0r5K5GOn3gye9ZMP6pug=;
        b=CUNubop1863pmRqVLwJCFs3RBpVwdFEyqJGmTIXotKWskC38NGoPkW+HLIpQGj3Ub4
         fwiiMeKCY7uLI7ShIW8RRZAmVQcFghBWlcYNgFCrs/QMDYR3DBTCcLWh1X8AiJDJbas3
         bQKk0H025fS3qjsTqXxB9RVdE8PxhzOut7YbPS+BNTU0Rhxli7dU5Zw3EKgRQcfs2t2w
         ntg3NNzJgC/R07dOtAW4OSHPWNhcsBLwqK1nVysh0YJthGP6BZNtilAdLNQyAP/L8lHI
         xR1aCfCf2+hNewhjYr63oUw7S01XGTgBGOvvmlCXI6xkS1C1xUqsRm8tjpvIZmI2rH0v
         4DQg==
X-Gm-Message-State: ANoB5pnjMar6Tr3QPRUxONIB6XFYTvrrsvFqInBFs0leeoBhz7gCwKfJ
        OZEuuN/4vRt2oAUAPed5RNvHlQ==
X-Google-Smtp-Source: AA0mqf4z1GfStNxQ59ePQ30tIOFm8Kt0e0ZJTLUg5mX25td3XFEAGOPMujpRJbjsNCBYxNodBXos3g==
X-Received: by 2002:a17:902:e8d0:b0:187:3921:2b1c with SMTP id v16-20020a170902e8d000b0018739212b1cmr12699959plg.55.1670755213357;
        Sun, 11 Dec 2022 02:40:13 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id iz17-20020a170902ef9100b001897a8b537asm4151651plb.221.2022.12.11.02.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 02:40:12 -0800 (PST)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Connor Kuehl <ckuehl@redhat.com>
Subject: [PATCH] virtiofs: enable multiple request queues
Date:   Sun, 11 Dec 2022 18:38:57 +0800
Message-Id: <20221211103857.25805-1-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Support virtio-fs multiple virtqueues and distribute requests across the
multiqueue complex automatically based on the IRQ affinity.

This commit is based on Connor's patch in the virtio-fs mailing-list,
and additionally intergates cpu-to-vq map into struct virtio_fs so that
this virtio-fs multi-queue feature can fit into multiple virtio-fs mounts.

Link: https://www.mail-archive.com/virtio-fs@redhat.com/msg03320.html
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Connor Kuehl <ckuehl@redhat.com>
Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
---
 fs/fuse/virtio_fs.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4d8d4f16c727..410968dede0c 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -32,8 +32,9 @@ static DEFINE_MUTEX(virtio_fs_mutex);
 static LIST_HEAD(virtio_fs_instances);
 
 enum {
-	VQ_HIPRIO,
-	VQ_REQUEST
+	VQ_HIPRIO = 0,
+	/* TODO add VQ_NOTIFICATION according to the virtio 1.2 spec. */
+	VQ_REQUEST = 1,
 };
 
 #define VQ_NAME_LEN	24
@@ -59,6 +60,7 @@ struct virtio_fs {
 	struct list_head list;    /* on virtio_fs_instances */
 	char *tag;
 	struct virtio_fs_vq *vqs;
+	struct virtio_fs_vq * __percpu *vq_proxy;
 	unsigned int nvqs;               /* number of virtqueues */
 	unsigned int num_request_queues; /* number of request queues */
 	struct dax_device *dax_dev;
@@ -686,6 +688,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	struct virtqueue **vqs;
 	vq_callback_t **callbacks;
 	const char **names;
+	struct irq_affinity desc = { .pre_vectors = 1, .nr_sets = 1, };
 	unsigned int i;
 	int ret = 0;
 
@@ -694,11 +697,16 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	if (fs->num_request_queues == 0)
 		return -EINVAL;
 
+	fs->num_request_queues = min_t(unsigned int, nr_cpu_ids,
+				       fs->num_request_queues);
+
 	fs->nvqs = VQ_REQUEST + fs->num_request_queues;
 	fs->vqs = kcalloc(fs->nvqs, sizeof(fs->vqs[VQ_HIPRIO]), GFP_KERNEL);
 	if (!fs->vqs)
 		return -ENOMEM;
 
+	pr_debug("virtio-fs: number of vqs: %d\n", fs->nvqs);
+
 	vqs = kmalloc_array(fs->nvqs, sizeof(vqs[VQ_HIPRIO]), GFP_KERNEL);
 	callbacks = kmalloc_array(fs->nvqs, sizeof(callbacks[VQ_HIPRIO]),
 					GFP_KERNEL);
@@ -723,12 +731,26 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 		names[i] = fs->vqs[i].name;
 	}
 
-	ret = virtio_find_vqs(vdev, fs->nvqs, vqs, callbacks, names, NULL);
+	ret = virtio_find_vqs(vdev, fs->nvqs, vqs, callbacks, names, &desc);
 	if (ret < 0)
 		goto out;
 
-	for (i = 0; i < fs->nvqs; i++)
+	fs->vq_proxy = alloc_percpu(struct virtio_fs_vq *);
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
+			struct virtio_fs_vq **cpu_vq = per_cpu_ptr(fs->vq_proxy, cpu);
+			*cpu_vq = &fs->vqs[i];
+			pr_debug("virtio-fs: map cpu %d to vq%d\n", cpu, i);
+		}
+	}
 
 	virtio_fs_start_all_queues(fs);
 out:
@@ -875,8 +897,6 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 	if (ret < 0)
 		goto out;
 
-	/* TODO vq affinity */
-
 	ret = virtio_fs_setup_dax(vdev, fs);
 	if (ret < 0)
 		goto out_vqs;
@@ -926,6 +946,7 @@ static void virtio_fs_remove(struct virtio_device *vdev)
 	virtio_fs_stop_all_queues(fs);
 	virtio_fs_drain_all_queues_locked(fs);
 	virtio_reset_device(vdev);
+	free_percpu(fs->vq_proxy);
 	virtio_fs_cleanup_vqs(vdev);
 
 	vdev->priv = NULL;
@@ -1223,7 +1244,6 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 static void virtio_fs_wake_pending_and_unlock(struct fuse_iqueue *fiq)
 __releases(fiq->lock)
 {
-	unsigned int queue_id = VQ_REQUEST; /* TODO multiqueue */
 	struct virtio_fs *fs;
 	struct fuse_req *req;
 	struct virtio_fs_vq *fsvq;
@@ -1243,7 +1263,8 @@ __releases(fiq->lock)
 		 req->in.h.nodeid, req->in.h.len,
 		 fuse_len_args(req->args->out_numargs, req->args->out_args));
 
-	fsvq = &fs->vqs[queue_id];
+	fsvq = this_cpu_read(*fs->vq_proxy);
+
 	ret = virtio_fs_enqueue_req(fsvq, req, false);
 	if (ret < 0) {
 		if (ret == -ENOMEM || ret == -ENOSPC) {
-- 
2.20.1

