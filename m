Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6ADA3E9E0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 07:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbhHLFqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 01:46:46 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:58186 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234365AbhHLFqq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 01:46:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UilCXZJ_1628747179;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UilCXZJ_1628747179)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Aug 2021 13:46:20 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com
Subject: [PATCH 2/2] virtiofs: reduce lock contention on fpq->lock
Date:   Thu, 12 Aug 2021 13:46:18 +0800
Message-Id: <20210812054618.26057-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210812054618.26057-1-jefflexu@linux.alibaba.com>
References: <20210812054618.26057-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Liu Bo <bo.liu@linux.alibaba.com>

Since %req has been removed from fpq->processing_list, no one except
request_wait_answer() is looking at this %req and request_wait_answer()
waits only on FINISH flag, it's OK to remove fpq->lock after %req is
dropped from the list.

Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/virtio_fs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 0050132e2787..7dbf5502c57e 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -557,7 +557,6 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 static void virtio_fs_request_complete(struct fuse_req *req,
 				       struct virtio_fs_vq *fsvq)
 {
-	struct fuse_pqueue *fpq = &fsvq->fud->pq;
 	struct fuse_args *args;
 	struct fuse_args_pages *ap;
 	unsigned int len, i, thislen;
@@ -586,9 +585,7 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 		}
 	}
 
-	spin_lock(&fpq->lock);
 	clear_bit(FR_SENT, &req->flags);
-	spin_unlock(&fpq->lock);
 
 	fuse_request_end(req);
 	spin_lock(&fsvq->lock);
-- 
2.27.0

