Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA042AAC3F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 21:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390311AbfIETtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 15:49:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390162AbfIETte (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:49:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4DB32308FBAC;
        Thu,  5 Sep 2019 19:49:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66C2419C77;
        Thu,  5 Sep 2019 19:49:26 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D781822539D; Thu,  5 Sep 2019 15:49:17 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu
Cc:     linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com
Subject: [PATCH 05/18] Maintain count of in flight requests for VQ_REQUEST queue
Date:   Thu,  5 Sep 2019 15:48:46 -0400
Message-Id: <20190905194859.16219-6-vgoyal@redhat.com>
In-Reply-To: <20190905194859.16219-1-vgoyal@redhat.com>
References: <20190905194859.16219-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 05 Sep 2019 19:49:34 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As of now we maintain this count only for VQ_HIPRIO. Maintain it for
VQ_REQUEST as well so that later it can be used to drain VQ_REQUEST
queue.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index c46dd4d284d6..5df97dfee37d 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -360,6 +360,9 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 		spin_unlock(&fpq->lock);
 
 		fuse_request_end(fc, req);
+		spin_lock(&fsvq->lock);
+		fsvq->in_flight--;
+		spin_unlock(&fsvq->lock);
 	}
 }
 
@@ -769,6 +772,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 		goto out;
 	}
 
+	fsvq->in_flight++;
 	notify = virtqueue_kick_prepare(vq);
 
 	spin_unlock(&fsvq->lock);
-- 
2.20.1

