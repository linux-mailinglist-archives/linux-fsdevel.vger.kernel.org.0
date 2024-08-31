Return-Path: <linux-fsdevel+bounces-28103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A27967080
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 11:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C88728464A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 09:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9C417BB26;
	Sat, 31 Aug 2024 09:37:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E4A170A1B;
	Sat, 31 Aug 2024 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725097078; cv=none; b=npsInTCWrKCUCAC3/CMLyrlH8S52423OTxtlF+4tpbHvDZ0IZ/YVXD8ZgYiYJb88Y5L9K0P1omXdjraquX6aisC0ahBN5+9QAhnlvZ/nFGFbQBlDVEMuuDdfrZlmU9eYyq2gX5SA8XwAZodJ1e2zLf9isF2i+HQ7IfyQYa4Q7RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725097078; c=relaxed/simple;
	bh=Is8gMZiYzT6REmkxrkgk5qT74fiRXbxvg1E/pyuAfeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FwnG/fAVncclY+rOQI+oOi8/Nmjs0B+/3vFWci0n/x5DGFZZt3B/QRHfg2mv+qx0alvAC++8nmypQj2y/nrf8fEzY3ZZHtmBxJDQJfopccW1YfdN6vUgSTpIiVb5+9DHftrFrtlgOdLI6LMk83P3VC0rtNOIpWhfiNDJLNdG28M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WwqgW2BGXz4f3jYx;
	Sat, 31 Aug 2024 17:37:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 666461A018D;
	Sat, 31 Aug 2024 17:37:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBXzIJj5NJm0I_lDA--.58191S6;
	Sat, 31 Aug 2024 17:37:53 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	houtao1@huawei.com
Subject: [PATCH v4 2/2] virtiofs: use GFP_NOFS when enqueuing request through kworker
Date: Sat, 31 Aug 2024 17:37:50 +0800
Message-Id: <20240831093750.1593871-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20240831093750.1593871-1-houtao@huaweicloud.com>
References: <20240831093750.1593871-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXzIJj5NJm0I_lDA--.58191S6
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4kXrWrXFy5Xry3GF15urg_yoWrAFykpr
	WDAa15CFWrJ3y2gFWkJF4UGr1akws3CFW7Ja4fXa4Skr4Yqr17CF18ZFy0qrZavrWkAF1x
	Wr4FqF4DuF47Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrJPE
	DUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When invoking virtio_fs_enqueue_req() through kworker, both the
allocation of the sg array and the bounce buffer still use GFP_ATOMIC.
Considering the size of the sg array may be greater than PAGE_SIZE, use
GFP_NOFS instead of GFP_ATOMIC to lower the possibility of memory
allocation failure and to avoid unnecessarily depleting the atomic
reserves. GFP_NOFS is not passed to virtio_fs_enqueue_req() directly,
GFP_KERNEL and memalloc_nofs_{save|restore} helpers are used instead.

It may seem OK to pass GFP_NOFS to virtio_fs_enqueue_req() as well when
queuing the request for the first time, but this is not the case. The
reason is that fuse_request_queue_background() may call
->queue_request_and_unlock() while holding fc->bg_lock, which is a
spin-lock. Therefore, still use GFP_ATOMIC for it.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/fuse/virtio_fs.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 43d66ab5e891..9bc48b3ca384 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -95,7 +95,8 @@ struct virtio_fs_req_work {
 };
 
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
-				 struct fuse_req *req, bool in_flight);
+				 struct fuse_req *req, bool in_flight,
+				 gfp_t gfp);
 
 static const struct constant_table dax_param_enums[] = {
 	{"always",	FUSE_DAX_ALWAYS },
@@ -439,6 +440,8 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 
 	/* Dispatch pending requests */
 	while (1) {
+		unsigned int flags;
+
 		spin_lock(&fsvq->lock);
 		req = list_first_entry_or_null(&fsvq->queued_reqs,
 					       struct fuse_req, list);
@@ -449,7 +452,9 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 		list_del_init(&req->list);
 		spin_unlock(&fsvq->lock);
 
-		ret = virtio_fs_enqueue_req(fsvq, req, true);
+		flags = memalloc_nofs_save();
+		ret = virtio_fs_enqueue_req(fsvq, req, true, GFP_KERNEL);
+		memalloc_nofs_restore(flags);
 		if (ret < 0) {
 			if (ret == -ENOSPC) {
 				spin_lock(&fsvq->lock);
@@ -550,7 +555,7 @@ static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
 }
 
 /* Allocate and copy args into req->argbuf */
-static int copy_args_to_argbuf(struct fuse_req *req)
+static int copy_args_to_argbuf(struct fuse_req *req, gfp_t gfp)
 {
 	struct fuse_args *args = req->args;
 	unsigned int offset = 0;
@@ -564,7 +569,7 @@ static int copy_args_to_argbuf(struct fuse_req *req)
 	len = fuse_len_args(num_in, (struct fuse_arg *) args->in_args) +
 	      fuse_len_args(num_out, args->out_args);
 
-	req->argbuf = kmalloc(len, GFP_ATOMIC);
+	req->argbuf = kmalloc(len, gfp);
 	if (!req->argbuf)
 		return -ENOMEM;
 
@@ -1239,7 +1244,8 @@ static unsigned int sg_init_fuse_args(struct scatterlist *sg,
 
 /* Add a request to a virtqueue and kick the device */
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
-				 struct fuse_req *req, bool in_flight)
+				 struct fuse_req *req, bool in_flight,
+				 gfp_t gfp)
 {
 	/* requests need at least 4 elements */
 	struct scatterlist *stack_sgs[6];
@@ -1260,8 +1266,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
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
@@ -1269,7 +1275,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	}
 
 	/* Use a bounce buffer since stack args cannot be mapped */
-	ret = copy_args_to_argbuf(req);
+	ret = copy_args_to_argbuf(req, gfp);
 	if (ret < 0)
 		goto out;
 
@@ -1367,7 +1373,7 @@ __releases(fiq->lock)
 		 queue_id);
 
 	fsvq = &fs->vqs[queue_id];
-	ret = virtio_fs_enqueue_req(fsvq, req, false);
+	ret = virtio_fs_enqueue_req(fsvq, req, false, GFP_ATOMIC);
 	if (ret < 0) {
 		if (ret == -ENOSPC) {
 			/*
-- 
2.29.2


