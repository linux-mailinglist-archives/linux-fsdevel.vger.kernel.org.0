Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 912F7AAC3B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 21:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390321AbfIETtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 15:49:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60875 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390115AbfIETtd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:49:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7683930089A1;
        Thu,  5 Sep 2019 19:49:33 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 675FA6060D;
        Thu,  5 Sep 2019 19:49:26 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 022522253A2; Thu,  5 Sep 2019 15:49:18 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu
Cc:     linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com
Subject: [PATCH 10/18] virtiofs: Do not use device managed mem for virtio_fs and virtio_fs_vq
Date:   Thu,  5 Sep 2019 15:48:51 -0400
Message-Id: <20190905194859.16219-11-vgoyal@redhat.com>
In-Reply-To: <20190905194859.16219-1-vgoyal@redhat.com>
References: <20190905194859.16219-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 05 Sep 2019 19:49:33 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These data structures should go away when virtio_fs object is going away.
When deivce is going away, we need to just make sure virtqueues can go
away and after that none of the code accesses vq and all the requests
get error.

So allocate memory for virtio_fs and virtio_fs_vq normally and free it
at right time.

This patch still frees up memory during device remove time. A later patch
will make virtio_fs object reference counted and this memory will be
freed when last reference to object is dropped.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index f2936daca39c..1ea0f889e804 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -446,7 +446,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	vq_callback_t **callbacks;
 	const char **names;
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
 	virtio_cread(vdev, struct virtio_fs_config, num_queues,
 		     &fs->num_queues);
@@ -454,9 +454,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 		return -EINVAL;
 
 	fs->nvqs = 1 + fs->num_queues;
-
-	fs->vqs = devm_kcalloc(&vdev->dev, fs->nvqs,
-				sizeof(fs->vqs[VQ_HIPRIO]), GFP_KERNEL);
+	fs->vqs = kcalloc(fs->nvqs, sizeof(fs->vqs[VQ_HIPRIO]), GFP_KERNEL);
 	if (!fs->vqs)
 		return -ENOMEM;
 
@@ -504,6 +502,8 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	kfree(names);
 	kfree(callbacks);
 	kfree(vqs);
+	if (ret)
+		kfree(fs->vqs);
 	return ret;
 }
 
@@ -519,7 +519,7 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 	struct virtio_fs *fs;
 	int ret;
 
-	fs = devm_kzalloc(&vdev->dev, sizeof(*fs), GFP_KERNEL);
+	fs = kzalloc(sizeof(*fs), GFP_KERNEL);
 	if (!fs)
 		return -ENOMEM;
 	vdev->priv = fs;
@@ -552,6 +552,7 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 
 out:
 	vdev->priv = NULL;
+	kfree(fs);
 	return ret;
 }
 
@@ -582,6 +583,8 @@ static void virtio_fs_remove(struct virtio_device *vdev)
 	mutex_unlock(&virtio_fs_mutex);
 
 	vdev->priv = NULL;
+	kfree(fs->vqs);
+	kfree(fs);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.20.1

