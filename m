Return-Path: <linux-fsdevel+bounces-52312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36DCAE1A38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 13:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9754A66C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 11:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5C525F984;
	Fri, 20 Jun 2025 11:50:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4910430E841;
	Fri, 20 Jun 2025 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750420223; cv=none; b=oj41v4V/uftzu2d4XeX/PMNYtyMRV03+dup603LMNlgaJBIhXBzZ8/SrNgywCiJhlHzKn8gvvYvLZUOawzb75Y3t15eqVTT+V+lxk0cEXqicY4dJcGNhVn58JiXcb2xxLblSQ++f1IbkP05LXuUJ6+XenBNJy5y6ZGebl7AHZ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750420223; c=relaxed/simple;
	bh=nkpgK2qx0Maj3Ks5WDMYbHXp9o2yShyl8cyss/4J/sQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nxpVkTsf6BeJbi3YKJxErw68JCqfkdbAk3cpXuB8reO2LD4B2axsm/WM1taMlISvPB8XBgdePdjuLQhFu9tPHnKi1gHmUnDdg2ZiBjQVEOaeL4VyCsywBPlLuWStIB5kXYWSFKC4lRNpWYeq+xK4horYxwNPqS2ZfKYTkPhqPMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <vgoyal@redhat.com>, <stefanha@redhat.com>, <miklos@szeredi.hu>,
	<eperezma@redhat.com>, <virtualization@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] virtio_fs: Remove request addition to processing list
Date: Fri, 20 Jun 2025 19:49:25 +0800
Message-ID: <20250620114925.2671-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc6.internal.baidu.com (172.31.3.16) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.41
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

Since virtio_fs does not utilize the fuse_pqueue->processing list, we
can safely omit adding requests to this list. This change eliminates the
associated spin_lock operations, thereby improving performance.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 fs/fuse/virtio_fs.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 82afe78..7a598ea5 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -814,7 +814,6 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 {
 	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
 						 done_work);
-	struct fuse_pqueue *fpq = &fsvq->fud->pq;
 	struct virtqueue *vq = fsvq->vq;
 	struct fuse_req *req;
 	struct fuse_req *next;
@@ -827,9 +826,7 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 		virtqueue_disable_cb(vq);
 
 		while ((req = virtqueue_get_buf(vq, &len)) != NULL) {
-			spin_lock(&fpq->lock);
-			list_move_tail(&req->list, &reqs);
-			spin_unlock(&fpq->lock);
+			list_add_tail(&req->list, &reqs);
 		}
 	} while (!virtqueue_enable_cb(vq));
 	spin_unlock(&fsvq->lock);
@@ -1389,7 +1386,6 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	unsigned int i;
 	int ret;
 	bool notify;
-	struct fuse_pqueue *fpq;
 
 	/* Does the sglist fit on the stack? */
 	total_sgs = sg_count_fuse_req(req);
@@ -1445,10 +1441,6 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	}
 
 	/* Request successfully sent. */
-	fpq = &fsvq->fud->pq;
-	spin_lock(&fpq->lock);
-	list_add_tail(&req->list, fpq->processing);
-	spin_unlock(&fpq->lock);
 	set_bit(FR_SENT, &req->flags);
 	/* matches barrier in request_wait_answer() */
 	smp_mb__after_atomic();
-- 
2.9.4


