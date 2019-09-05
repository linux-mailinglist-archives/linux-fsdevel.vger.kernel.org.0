Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 285BEAAC3A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 21:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390304AbfIETtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 15:49:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390132AbfIETte (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:49:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 299CC7E423;
        Thu,  5 Sep 2019 19:49:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 670905D9CA;
        Thu,  5 Sep 2019 19:49:26 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id EFC332253A1; Thu,  5 Sep 2019 15:49:17 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu
Cc:     linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com
Subject: [PATCH 09/18] virtiofs: Add an helper to start all the queues
Date:   Thu,  5 Sep 2019 15:48:50 -0400
Message-Id: <20190905194859.16219-10-vgoyal@redhat.com>
In-Reply-To: <20190905194859.16219-1-vgoyal@redhat.com>
References: <20190905194859.16219-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 05 Sep 2019 19:49:34 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This just marks are the queues are connected and ready to accept the
request.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index d5730a50b303..f2936daca39c 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -112,6 +112,19 @@ static void virtio_fs_drain_all_queues(struct virtio_fs *fs)
 	}
 }
 
+static void virtio_fs_start_all_queues(struct virtio_fs *fs)
+{
+	struct virtio_fs_vq *fsvq;
+	int i;
+
+	for (i = 0; i < fs->nvqs; i++) {
+		fsvq = &fs->vqs[i];
+		spin_lock(&fsvq->lock);
+		fsvq->connected = true;
+		spin_unlock(&fsvq->lock);
+	}
+}
+
 /* Add a new instance to the list or return -EEXIST if tag name exists*/
 static int virtio_fs_add_instance(struct virtio_fs *fs)
 {
@@ -483,10 +496,10 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	if (ret < 0)
 		goto out;
 
-	for (i = 0; i < fs->nvqs; i++) {
+	for (i = 0; i < fs->nvqs; i++)
 		fs->vqs[i].vq = vqs[i];
-		fs->vqs[i].connected = true;
-	}
+
+	virtio_fs_start_all_queues(fs);
 out:
 	kfree(names);
 	kfree(callbacks);
-- 
2.20.1

