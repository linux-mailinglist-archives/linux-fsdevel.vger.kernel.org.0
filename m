Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBC72D7E10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 19:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbfJORqn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 13:46:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfJORqn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:46:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D0D661B27;
        Tue, 15 Oct 2019 17:46:43 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9242A60CD0;
        Tue, 15 Oct 2019 17:46:35 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 23D462240F3; Tue, 15 Oct 2019 13:46:35 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, chirantan@chromium.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 3/5] virtiofs: Set FR_SENT flag only after request has been sent
Date:   Tue, 15 Oct 2019 13:46:24 -0400
Message-Id: <20191015174626.11593-4-vgoyal@redhat.com>
In-Reply-To: <20191015174626.11593-1-vgoyal@redhat.com>
References: <20191015174626.11593-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 15 Oct 2019 17:46:43 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FR_SENT flag should be set when request has been sent successfuly sent
over virtqueue. This is used by interrupt logic to figure out if interrupt
request should be sent or not.

Also add it to fqp->processing list after sending it successfully.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 3b7f7409e77b..e0fcf3030951 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -857,6 +857,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	unsigned int i;
 	int ret;
 	bool notify;
+	struct fuse_pqueue *fpq;
 
 	/* Does the sglist fit on the stack? */
 	total_sgs = sg_count_fuse_req(req);
@@ -911,6 +912,15 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 		goto out;
 	}
 
+	/* Request successfuly sent. */
+	fpq = &fsvq->fud->pq;
+	spin_lock(&fpq->lock);
+	list_add_tail(&req->list, fpq->processing);
+	spin_unlock(&fpq->lock);
+	set_bit(FR_SENT, &req->flags);
+	/* matches barrier in request_wait_answer() */
+	smp_mb__after_atomic();
+
 	fsvq->in_flight++;
 	notify = virtqueue_kick_prepare(vq);
 
@@ -939,7 +949,6 @@ __releases(fiq->lock)
 	struct virtio_fs *fs;
 	struct fuse_conn *fc;
 	struct fuse_req *req;
-	struct fuse_pqueue *fpq;
 	struct virtio_fs_vq *fsvq;
 	int ret;
 
@@ -958,14 +967,6 @@ __releases(fiq->lock)
 		 req->in.h.nodeid, req->in.h.len,
 		 fuse_len_args(req->args->out_numargs, req->args->out_args));
 
-	fpq = &fs->vqs[queue_id].fud->pq;
-	spin_lock(&fpq->lock);
-	list_add_tail(&req->list, fpq->processing);
-	spin_unlock(&fpq->lock);
-	set_bit(FR_SENT, &req->flags);
-	/* matches barrier in request_wait_answer() */
-	smp_mb__after_atomic();
-
 retry:
 	fsvq = &fs->vqs[queue_id];
 	ret = virtio_fs_enqueue_req(fsvq, req);
@@ -978,10 +979,6 @@ __releases(fiq->lock)
 		}
 		req->out.h.error = ret;
 		pr_err("virtio-fs: virtio_fs_enqueue_req() failed %d\n", ret);
-		spin_lock(&fpq->lock);
-		clear_bit(FR_SENT, &req->flags);
-		list_del_init(&req->list);
-		spin_unlock(&fpq->lock);
 
 		/* Can't end request in submission context. Use a worker */
 		spin_lock(&fsvq->lock);
-- 
2.20.1

