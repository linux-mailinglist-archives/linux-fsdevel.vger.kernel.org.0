Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7633BD7E12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 19:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbfJORqp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 13:46:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730749AbfJORqp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:46:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 800BF7FDE5;
        Tue, 15 Oct 2019 17:46:45 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88B8A101E248;
        Tue, 15 Oct 2019 17:46:35 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 1D9002240F2; Tue, 15 Oct 2019 13:46:35 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, chirantan@chromium.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 2/5] virtiofs: No need to check fpq->connected state
Date:   Tue, 15 Oct 2019 13:46:23 -0400
Message-Id: <20191015174626.11593-3-vgoyal@redhat.com>
In-Reply-To: <20191015174626.11593-1-vgoyal@redhat.com>
References: <20191015174626.11593-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 15 Oct 2019 17:46:45 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In virtiofs we keep per queue connected state in virtio_fs_vq->connected
and use that to end request if queue is not connected. And virtiofs does
not even touch fpq->connected state.

We probably need to merge these two at some point of time. For now, simplify
the code a bit and do not worry about checking state of fpq->connected.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 24ac6f8bf3f7..3b7f7409e77b 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -960,13 +960,6 @@ __releases(fiq->lock)
 
 	fpq = &fs->vqs[queue_id].fud->pq;
 	spin_lock(&fpq->lock);
-	if (!fpq->connected) {
-		spin_unlock(&fpq->lock);
-		req->out.h.error = -ENODEV;
-		pr_err("virtio-fs: %s disconnected\n", __func__);
-		fuse_request_end(fc, req);
-		return;
-	}
 	list_add_tail(&req->list, fpq->processing);
 	spin_unlock(&fpq->lock);
 	set_bit(FR_SENT, &req->flags);
-- 
2.20.1

