Return-Path: <linux-fsdevel+bounces-7331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC780823A67
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 02:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784B81F26234
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 01:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5B31DFD3;
	Thu,  4 Jan 2024 01:57:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F58A1DDE7;
	Thu,  4 Jan 2024 01:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4T58pk2WMMz4f3jXV;
	Thu,  4 Jan 2024 09:57:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A13D61A09FF;
	Thu,  4 Jan 2024 09:57:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgAneA5vEJZlOVnbFQ--.23128S4;
	Thu, 04 Jan 2024 09:57:05 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	houtao1@huawei.com
Subject: [PATCH] virtiofs: use GFP_NOFS when enqueuing request through kworker
Date: Thu,  4 Jan 2024 09:58:05 +0800
Message-Id: <20240104015805.2103766-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAneA5vEJZlOVnbFQ--.23128S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4kXryDZr4rCw1DXF45GFg_yoWrGr15pr
	WUta15GFZ5JFW2gF95JF4UCw1Yk3sakFW7Ga4fWa4akr15Xw47uFy8ZFy0qrsavrykCF1x
	Jr4FqF4DuF47uaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
	Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
	daVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When invoking virtio_fs_enqueue_req() through kworker, both the
allocation of the sg array and the bounce buffer still use GFP_ATOMIC.
Considering the size of both the sg array and the bounce buffer may be
greater than PAGE_SIZE, use GFP_NOFS instead of GFP_ATOMIC to lower the
possibility of memory allocation failure.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/fuse/virtio_fs.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 3aac31d45198..ec4d0d81a5e2 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -87,7 +87,8 @@ struct virtio_fs_req_work {
 };
 
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
-				 struct fuse_req *req, bool in_flight);
+				 struct fuse_req *req, bool in_flight,
+				 bool in_atomic);
 
 static const struct constant_table dax_param_enums[] = {
 	{"always",	FUSE_DAX_ALWAYS },
@@ -383,7 +384,7 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 		list_del_init(&req->list);
 		spin_unlock(&fsvq->lock);
 
-		ret = virtio_fs_enqueue_req(fsvq, req, true);
+		ret = virtio_fs_enqueue_req(fsvq, req, true, false);
 		if (ret < 0) {
 			if (ret == -ENOMEM || ret == -ENOSPC) {
 				spin_lock(&fsvq->lock);
@@ -488,7 +489,7 @@ static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
 }
 
 /* Allocate and copy args into req->argbuf */
-static int copy_args_to_argbuf(struct fuse_req *req)
+static int copy_args_to_argbuf(struct fuse_req *req, gfp_t gfp)
 {
 	struct fuse_args *args = req->args;
 	unsigned int offset = 0;
@@ -502,7 +503,7 @@ static int copy_args_to_argbuf(struct fuse_req *req)
 	len = fuse_len_args(num_in, (struct fuse_arg *) args->in_args) +
 	      fuse_len_args(num_out, args->out_args);
 
-	req->argbuf = kmalloc(len, GFP_ATOMIC);
+	req->argbuf = kmalloc(len, gfp);
 	if (!req->argbuf)
 		return -ENOMEM;
 
@@ -1119,7 +1120,8 @@ static unsigned int sg_init_fuse_args(struct scatterlist *sg,
 
 /* Add a request to a virtqueue and kick the device */
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
-				 struct fuse_req *req, bool in_flight)
+				 struct fuse_req *req, bool in_flight,
+				 bool in_atomic)
 {
 	/* requests need at least 4 elements */
 	struct scatterlist *stack_sgs[6];
@@ -1128,6 +1130,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	struct scatterlist *sg = stack_sg;
 	struct virtqueue *vq;
 	struct fuse_args *args = req->args;
+	gfp_t gfp = in_atomic ? GFP_ATOMIC : GFP_NOFS;
 	unsigned int argbuf_used = 0;
 	unsigned int out_sgs = 0;
 	unsigned int in_sgs = 0;
@@ -1140,8 +1143,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
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
@@ -1149,7 +1152,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	}
 
 	/* Use a bounce buffer since stack args cannot be mapped */
-	ret = copy_args_to_argbuf(req);
+	ret = copy_args_to_argbuf(req, gfp);
 	if (ret < 0)
 		goto out;
 
@@ -1245,7 +1248,7 @@ __releases(fiq->lock)
 		 fuse_len_args(req->args->out_numargs, req->args->out_args));
 
 	fsvq = &fs->vqs[queue_id];
-	ret = virtio_fs_enqueue_req(fsvq, req, false);
+	ret = virtio_fs_enqueue_req(fsvq, req, false, true);
 	if (ret < 0) {
 		if (ret == -ENOMEM || ret == -ENOSPC) {
 			/*
-- 
2.29.2


