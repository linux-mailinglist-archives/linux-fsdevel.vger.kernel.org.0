Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83176AAC59
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 21:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391496AbfIETuR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 15:50:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388106AbfIETt1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:49:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E8FA9307D851;
        Thu,  5 Sep 2019 19:49:26 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C33BA5D6A3;
        Thu,  5 Sep 2019 19:49:26 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 160592253A5; Thu,  5 Sep 2019 15:49:18 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu
Cc:     linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com
Subject: [PATCH 13/18] virtiofs: Do not access virtqueue in request submission path
Date:   Thu,  5 Sep 2019 15:48:54 -0400
Message-Id: <20190905194859.16219-14-vgoyal@redhat.com>
In-Reply-To: <20190905194859.16219-1-vgoyal@redhat.com>
References: <20190905194859.16219-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 05 Sep 2019 19:49:27 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In request submission path it is possible that virtqueue is already gone
due to driver->remove(). So do not access it in dev_dbg(). Use pr_debug()
instead.

If virtuqueue is gone, this will result in NULL pointer deference.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 40259368a6bd..01bbf2c0e144 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -888,10 +888,10 @@ __releases(fiq->waitq.lock)
 	fs = fiq->priv;
 	fc = fs->vqs[queue_id].fud->fc;
 
-	dev_dbg(&fs->vqs[queue_id].vq->vdev->dev,
-		"%s: opcode %u unique %#llx nodeid %#llx in.len %u out.len %u\n",
-		__func__, req->in.h.opcode, req->in.h.unique, req->in.h.nodeid,
-		req->in.h.len, fuse_len_args(req->out.numargs, req->out.args));
+	pr_debug("%s: opcode %u unique %#llx nodeid %#llx in.len %u out.len %u"
+		 "\n", __func__, req->in.h.opcode, req->in.h.unique,
+		 req->in.h.nodeid, req->in.h.len,
+		 fuse_len_args(req->out.numargs, req->out.args));
 
 	fpq = &fs->vqs[queue_id].fud->pq;
 	spin_lock(&fpq->lock);
-- 
2.20.1

