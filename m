Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8709AAC4B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 21:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388314AbfIETt1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 15:49:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732717AbfIETt0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:49:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 554507EB88;
        Thu,  5 Sep 2019 19:49:26 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 400FF5D6A3;
        Thu,  5 Sep 2019 19:49:18 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C87AA22539B; Thu,  5 Sep 2019 15:49:17 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu
Cc:     linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com
Subject: [PATCH 03/18] virtiofs: Pass fsvq instead of vq as parameter to virtio_fs_enqueue_req
Date:   Thu,  5 Sep 2019 15:48:44 -0400
Message-Id: <20190905194859.16219-4-vgoyal@redhat.com>
In-Reply-To: <20190905194859.16219-1-vgoyal@redhat.com>
References: <20190905194859.16219-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Thu, 05 Sep 2019 19:49:26 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass fsvq instead of vq as parameter to virtio_fs_enqueue_req(). We will
retrieve vq from fsvq under spin lock.

Later in the patch series we will retrieve vq only if fsvq is still connected
other vq might have been cleaned up by device ->remove code and we will
return error.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index e9497b565dd8..9d30530e3ca9 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -698,14 +698,15 @@ static unsigned int sg_init_fuse_args(struct scatterlist *sg,
 }
 
 /* Add a request to a virtqueue and kick the device */
-static int virtio_fs_enqueue_req(struct virtqueue *vq, struct fuse_req *req)
+static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
+				 struct fuse_req *req)
 {
 	/* requests need at least 4 elements */
 	struct scatterlist *stack_sgs[6];
 	struct scatterlist stack_sg[ARRAY_SIZE(stack_sgs)];
 	struct scatterlist **sgs = stack_sgs;
 	struct scatterlist *sg = stack_sg;
-	struct virtio_fs_vq *fsvq;
+	struct virtqueue *vq;
 	unsigned int argbuf_used = 0;
 	unsigned int out_sgs = 0;
 	unsigned int in_sgs = 0;
@@ -752,9 +753,9 @@ static int virtio_fs_enqueue_req(struct virtqueue *vq, struct fuse_req *req)
 	for (i = 0; i < total_sgs; i++)
 		sgs[i] = &sg[i];
 
-	fsvq = vq_to_fsvq(vq);
 	spin_lock(&fsvq->lock);
 
+	vq = fsvq->vq;
 	ret = virtqueue_add_sgs(vq, sgs, out_sgs, in_sgs, req, GFP_ATOMIC);
 	if (ret < 0) {
 		/* TODO handle full virtqueue */
@@ -824,7 +825,7 @@ __releases(fiq->waitq.lock)
 	/* TODO check for FR_INTERRUPTED? */
 
 retry:
-	ret = virtio_fs_enqueue_req(fs->vqs[queue_id].vq, req);
+	ret = virtio_fs_enqueue_req(&fs->vqs[queue_id], req);
 	if (ret < 0) {
 		if (ret == -ENOMEM || ret == -ENOSPC) {
 			/* Virtqueue full. Retry submission */
-- 
2.20.1

