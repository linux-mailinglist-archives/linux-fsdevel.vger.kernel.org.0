Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D142E0FD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 03:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732395AbfJWBzv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 21:55:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36318 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730121AbfJWBzv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 21:55:51 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B6ACE866F11496B27A05;
        Wed, 23 Oct 2019 09:55:48 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 09:55:40 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <vgoyal@redhat.com>, <stefanha@redhat.com>, <mszeredi@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] virtiofs: Remove set but not used variable 'fc'
Date:   Wed, 23 Oct 2019 10:02:49 +0800
Message-ID: <1571796169-61061-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

fs/fuse/virtio_fs.c: In function virtio_fs_wake_pending_and_unlock:
fs/fuse/virtio_fs.c:983:20: warning: variable fc set but not used [-Wunused-but-set-variable]

It is not used since commit 7ee1e2e631db ("virtiofs:
No need to check fpq->connected state")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 fs/fuse/virtio_fs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 2de8fc0..a5c8604 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -980,7 +980,6 @@ __releases(fiq->lock)
 {
 	unsigned int queue_id = VQ_REQUEST; /* TODO multiqueue */
 	struct virtio_fs *fs;
-	struct fuse_conn *fc;
 	struct fuse_req *req;
 	struct virtio_fs_vq *fsvq;
 	int ret;
@@ -993,7 +992,6 @@ __releases(fiq->lock)
 	spin_unlock(&fiq->lock);

 	fs = fiq->priv;
-	fc = fs->vqs[queue_id].fud->fc;

 	pr_debug("%s: opcode %u unique %#llx nodeid %#llx in.len %u out.len %u\n",
 		  __func__, req->in.h.opcode, req->in.h.unique,
--
2.7.4

