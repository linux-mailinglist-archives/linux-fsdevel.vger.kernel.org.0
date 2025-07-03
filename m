Return-Path: <linux-fsdevel+bounces-53768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 163F6AF6ABB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 08:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2DE188F962
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 06:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12657293C53;
	Thu,  3 Jul 2025 06:48:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E145B291C3B;
	Thu,  3 Jul 2025 06:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751525307; cv=none; b=f/YOwBsMj9Fju7XNHRqU/hHf36FhU4GXzrw918Z7L5gJrdEHCWshW8Lsnm63I0CxMWSGz08xjrOhAdcd/gPh5QxgKh8pd3ANtR+Lya5PSxpYC2txyOszsfKFh4gd+C9B5vDVdeUN5QDmU8H81muuZaeWa7+HkrgHMm3tR4ApcsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751525307; c=relaxed/simple;
	bh=LnsEpGxDtvoAsm6ceZ7Zgj8qH0jfanHvQzlEfk/g9iU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VIEeFqRdwoNh5/ffWKtEK07h0pFaDd6P5nOhZhulRhLe0qCVW+mGDt/nJxH8hd9XAvFkMZUjTHpb5X2fmsDYIjXM/+f46Lq7OEx2m5HpqS21Ud2UdrY/NgkBtx9ETW1H79/23LHiAbegEflJvgUCCHNH7qO7XFqpHvWipibBEAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <vgoyal@redhat.com>, <stefanha@redhat.com>, <miklos@szeredi.hu>,
	<eperezma@redhat.com>, <virtualization@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>, Fushuai Wang <wangfushuai@baidu.com>
Subject: [PATCH] virtio_fs: fix the hash table using in virtio_fs_enqueue_req()
Date: Thu, 3 Jul 2025 14:47:38 +0800
Message-ID: <20250703064738.2631-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc14.internal.baidu.com (172.31.51.14) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.41
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

The original commit be2ff42c5d6e ("fuse: Use hash table to link
processing request") converted fuse_pqueue->processing to a hash table,
but virtio_fs_enqueue_req() was not updated to use it correctly.
So use fuse_pqueue->processing as a hash table, this make the code
more coherent

Co-developed-by: Fushuai Wang <wangfushuai@baidu.com>
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 fs/fuse/dev.c       | 1 +
 fs/fuse/virtio_fs.c | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e80cd8f..4659bc8 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -322,6 +322,7 @@ unsigned int fuse_req_hash(u64 unique)
 {
 	return hash_long(unique & ~FUSE_INT_REQ_BIT, FUSE_PQ_HASH_BITS);
 }
+EXPORT_SYMBOL_GPL(fuse_req_hash);
 
 /*
  * A new request is available, wake fiq->waitq
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index b8a99d3..d050470 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -21,6 +21,7 @@
 #include <linux/cleanup.h>
 #include <linux/uio.h>
 #include "fuse_i.h"
+#include "fuse_dev_i.h"
 
 /* Used to help calculate the FUSE connection's max_pages limit for a request's
  * size. Parts of the struct fuse_req are sliced into scattergather lists in
@@ -1382,7 +1383,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	unsigned int out_sgs = 0;
 	unsigned int in_sgs = 0;
 	unsigned int total_sgs;
-	unsigned int i;
+	unsigned int i, hash;
 	int ret;
 	bool notify;
 	struct fuse_pqueue *fpq;
@@ -1442,8 +1443,9 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 
 	/* Request successfully sent. */
 	fpq = &fsvq->fud->pq;
+	hash = fuse_req_hash(req->in.h.unique);
 	spin_lock(&fpq->lock);
-	list_add_tail(&req->list, fpq->processing);
+	list_add_tail(&req->list, &fpq->processing[hash]);
 	spin_unlock(&fpq->lock);
 	set_bit(FR_SENT, &req->flags);
 	/* matches barrier in request_wait_answer() */
-- 
2.9.4


