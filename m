Return-Path: <linux-fsdevel+bounces-17905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 003C18B3A32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 16:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2681C23F5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 14:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C7813D27A;
	Fri, 26 Apr 2024 14:38:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E667214883C;
	Fri, 26 Apr 2024 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142322; cv=none; b=VOAT/5t6pvKRVJXj+bNpBvWcF97u4BJ4Y5TmUqc+7UhN3bf5UoSqXSpR1pa5327k12o3GVHMnmQMh9hj6BmWn09gRkZquHCYe7zapwB0HllfQJGKBLvO/cQg5X3U/JzRl8DLNN1WqSwJlIJyCHkqshwpE/9M3uw7cSTcGzCeEjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142322; c=relaxed/simple;
	bh=JMSxd5BKXqrS2nIQ7JUSZYFhBSpIng25jtbCRriXoyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r3Z7beC3+ycqbMhKVb0a9drSRZnZC8YO2CTKsgq9WAFdu4QExbCBDE+PjIExStTHUTbUjeWS4VeMlLqGT4MKoljOeedBXU8q+OVWei2hmB4ZD6GunogywiizQS+1RXD/0xYO7vg41xG0GvErvCNnvmyt71m9GjOOWCvpEDIZ5K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VQwM403zDz4f3jrn;
	Fri, 26 Apr 2024 22:38:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A6E171A1002;
	Fri, 26 Apr 2024 22:38:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5gvCtmAU4WLA--.35655S6;
	Fri, 26 Apr 2024 22:38:31 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	houtao1@huawei.com
Subject: [PATCH v3 2/2] virtiofs: use GFP_NOFS when enqueuing request through kworker
Date: Fri, 26 Apr 2024 22:39:03 +0800
Message-Id: <20240426143903.1305919-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20240426143903.1305919-1-houtao@huaweicloud.com>
References: <20240426143903.1305919-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g5gvCtmAU4WLA--.35655S6
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4kXrW3Cr4UArykJrWUArb_yoWrXFWDpr
	WDAa15GFWrJrW2gFWkGF4UCw4Yk3sakFy7Ja4fX34akr1Yqw17CF18ZFy0qrZavrykAF1x
	Wr4Fqr4DuF47Zw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFa9-UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When invoking virtio_fs_enqueue_req() through kworker, both the
allocation of the sg array and the bounce buffer still use GFP_ATOMIC.
Considering the size of the sg array may be greater than PAGE_SIZE, use
GFP_NOFS instead of GFP_ATOMIC to lower the possibility of memory
allocation failure and to avoid unnecessarily depleting the atomic
reserves. GFP_NOFS is not passed to virtio_fs_enqueue_req() directly,
GFP_KERNEL and memalloc_nofs_{save|restore} helpers are used instead.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/fuse/virtio_fs.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 36984c0e23d14..096b589ed2fcc 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -91,7 +91,8 @@ struct virtio_fs_req_work {
 };
 
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
-				 struct fuse_req *req, bool in_flight);
+				 struct fuse_req *req, bool in_flight,
+				 gfp_t gfp);
 
 static const struct constant_table dax_param_enums[] = {
 	{"always",	FUSE_DAX_ALWAYS },
@@ -430,6 +431,8 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 
 	/* Dispatch pending requests */
 	while (1) {
+		unsigned int flags;
+
 		spin_lock(&fsvq->lock);
 		req = list_first_entry_or_null(&fsvq->queued_reqs,
 					       struct fuse_req, list);
@@ -440,7 +443,9 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 		list_del_init(&req->list);
 		spin_unlock(&fsvq->lock);
 
-		ret = virtio_fs_enqueue_req(fsvq, req, true);
+		flags = memalloc_nofs_save();
+		ret = virtio_fs_enqueue_req(fsvq, req, true, GFP_KERNEL);
+		memalloc_nofs_restore(flags);
 		if (ret < 0) {
 			if (ret == -ENOMEM || ret == -ENOSPC) {
 				spin_lock(&fsvq->lock);
@@ -545,7 +550,7 @@ static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
 }
 
 /* Allocate and copy args into req->argbuf */
-static int copy_args_to_argbuf(struct fuse_req *req)
+static int copy_args_to_argbuf(struct fuse_req *req, gfp_t gfp)
 {
 	struct fuse_args *args = req->args;
 	unsigned int offset = 0;
@@ -559,7 +564,7 @@ static int copy_args_to_argbuf(struct fuse_req *req)
 	len = fuse_len_args(num_in, (struct fuse_arg *) args->in_args) +
 	      fuse_len_args(num_out, args->out_args);
 
-	req->argbuf = kmalloc(len, GFP_ATOMIC);
+	req->argbuf = kmalloc(len, gfp);
 	if (!req->argbuf)
 		return -ENOMEM;
 
@@ -1183,7 +1188,8 @@ static unsigned int sg_init_fuse_args(struct scatterlist *sg,
 
 /* Add a request to a virtqueue and kick the device */
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
-				 struct fuse_req *req, bool in_flight)
+				 struct fuse_req *req, bool in_flight,
+				 gfp_t gfp)
 {
 	/* requests need at least 4 elements */
 	struct scatterlist *stack_sgs[6];
@@ -1204,8 +1210,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	/* Does the sglist fit on the stack? */
 	total_sgs = sg_count_fuse_req(req);
 	if (total_sgs > ARRAY_SIZE(stack_sgs)) {
-		sgs = kmalloc_array(total_sgs, sizeof(sgs[0]), GFP_ATOMIC);
-		sg = kmalloc_array(total_sgs, sizeof(sg[0]), GFP_ATOMIC);
+		sgs = kmalloc_array(total_sgs, sizeof(sgs[0]), gfp);
+		sg = kmalloc_array(total_sgs, sizeof(sg[0]), gfp);
 		if (!sgs || !sg) {
 			ret = -ENOMEM;
 			goto out;
@@ -1213,7 +1219,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	}
 
 	/* Use a bounce buffer since stack args cannot be mapped */
-	ret = copy_args_to_argbuf(req);
+	ret = copy_args_to_argbuf(req, gfp);
 	if (ret < 0)
 		goto out;
 
@@ -1309,7 +1315,7 @@ __releases(fiq->lock)
 		 fuse_len_args(req->args->out_numargs, req->args->out_args));
 
 	fsvq = &fs->vqs[queue_id];
-	ret = virtio_fs_enqueue_req(fsvq, req, false);
+	ret = virtio_fs_enqueue_req(fsvq, req, false, GFP_ATOMIC);
 	if (ret < 0) {
 		if (ret == -ENOMEM || ret == -ENOSPC) {
 			/*
-- 
2.29.2


