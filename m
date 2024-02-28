Return-Path: <linux-fsdevel+bounces-13093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ECD86B1FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 15:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329641C21589
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 14:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE7F15CD7A;
	Wed, 28 Feb 2024 14:40:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2B415AADD;
	Wed, 28 Feb 2024 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131249; cv=none; b=k6tUObvYpDv2VPHSnwhndFJ4BawoCg92Z0lVxVl0zhiGkVUe+BsldCKTqxudZ2hlIG19A1zaYaLZJD5r4DpNxuvOGVODnQFezHGMYAnrxML8eBwPKC2vvmZmWL/bwp9BYN+ntijjDpgwUUj+u1wP1FnM0wPpFjdCe7GCbgEQo88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131249; c=relaxed/simple;
	bh=5tKZoLoQHsYKSVgtcARv6ya8kA/+8jNNy0nuW/K4E4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jaT2Hm8dY5KDfkyEPM4x2EhSna98zYmKGMuofjiNns3t8pkF53lboEjhrZpCk8OayDfFHOXyxBUoLwoNdU9Jbi+jV3fcotHm0nYg3aFnJyyK/OHWdfBWatdnkinFEyRs+wAX7SEDC9VqED5GMzdxiX1zQ94QL8w74E9ZenDDr+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TlH8P0yqxz4f3m75;
	Wed, 28 Feb 2024 22:40:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 75E491A0232;
	Wed, 28 Feb 2024 22:40:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBHkRd9lwGKzFQ--.18779S9;
	Wed, 28 Feb 2024 22:40:44 +0800 (CST)
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
Subject: [PATCH v2 5/6] virtiofs: use scattered bounce buffer for ITER_KVEC dio
Date: Wed, 28 Feb 2024 22:41:25 +0800
Message-Id: <20240228144126.2864064-6-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20240228144126.2864064-1-houtao@huaweicloud.com>
References: <20240228144126.2864064-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnOBHkRd9lwGKzFQ--.18779S9
X-Coremail-Antispam: 1UD129KBjvJXoWxKF4UZry3tr17ur43Gr4kJFb_yoW7ArW5pr
	47t3W5XFWftFZrWryfKw45GFySyrsaka18KrWfJ3sxKF17Z39rXFy0ya45ZFsIqrykAF4x
	uF1FqF1DWF48ZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

To prevent unnecessary request for large contiguous physical memory
chunk, use bounce buffer backed by scattered pages for ITER_KVEC
direct-io read/write when the total size of its args is greater than
PAGE_SIZE.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/fuse/virtio_fs.c | 78 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 19 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index ffea684bd100d..34b9370beba6d 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -458,20 +458,15 @@ static void virtio_fs_argbuf_free(struct virtio_fs_argbuf *argbuf)
 	kfree(argbuf);
 }
 
-static struct virtio_fs_argbuf *virtio_fs_argbuf_new(struct fuse_args *args,
+static struct virtio_fs_argbuf *virtio_fs_argbuf_new(unsigned int in_len,
+						     unsigned int out_len,
 						     gfp_t gfp, bool is_flat)
 {
 	struct virtio_fs_argbuf *argbuf;
-	unsigned int numargs;
-	unsigned int in_len, out_len, len;
+	unsigned int len;
 	unsigned int i, nr;
 
-	numargs = args->in_numargs - args->in_pages;
-	in_len = fuse_len_args(numargs, (struct fuse_arg *) args->in_args);
-	numargs = args->out_numargs - args->out_pages;
-	out_len = fuse_len_args(numargs, args->out_args);
 	len = virtio_fs_argbuf_len(in_len, out_len, is_flat);
-
 	if (is_flat) {
 		argbuf = kmalloc(struct_size(argbuf, f.buf, len), gfp);
 		if (argbuf)
@@ -1222,14 +1217,17 @@ static unsigned int sg_count_fuse_pages(struct fuse_page_desc *page_descs,
 }
 
 /* Return the number of scatter-gather list elements required */
-static unsigned int sg_count_fuse_req(struct fuse_req *req)
+static unsigned int sg_count_fuse_req(struct fuse_req *req,
+				      unsigned int in_args_len,
+				      unsigned int out_args_len,
+				      bool flat_argbuf)
 {
 	struct fuse_args *args = req->args;
 	struct fuse_args_pages *ap = container_of(args, typeof(*ap), args);
 	unsigned int size, total_sgs = 1 /* fuse_in_header */;
+	unsigned int num_in, num_out;
 
-	if (args->in_numargs - args->in_pages)
-		total_sgs += 1;
+	num_in = args->in_numargs - args->in_pages;
 
 	if (args->in_pages) {
 		size = args->in_args[args->in_numargs - 1].size;
@@ -1237,20 +1235,25 @@ static unsigned int sg_count_fuse_req(struct fuse_req *req)
 						 size);
 	}
 
-	if (!test_bit(FR_ISREPLY, &req->flags))
-		return total_sgs;
+	if (!test_bit(FR_ISREPLY, &req->flags)) {
+		num_out = 0;
+		goto done;
+	}
 
 	total_sgs += 1 /* fuse_out_header */;
-
-	if (args->out_numargs - args->out_pages)
-		total_sgs += 1;
+	num_out = args->out_numargs - args->out_pages;
 
 	if (args->out_pages) {
 		size = args->out_args[args->out_numargs - 1].size;
 		total_sgs += sg_count_fuse_pages(ap->descs, ap->num_pages,
 						 size);
 	}
-
+done:
+	if (flat_argbuf)
+		total_sgs += !!num_in + !!num_out;
+	else
+		total_sgs += virtio_fs_argbuf_len(in_args_len, out_args_len,
+						  false) >> PAGE_SHIFT;
 	return total_sgs;
 }
 
@@ -1302,6 +1305,31 @@ static unsigned int sg_init_fuse_args(struct scatterlist *sg,
 	return total_sgs;
 }
 
+static bool use_scattered_argbuf(struct fuse_req *req)
+{
+	struct fuse_args *args = req->args;
+
+	/*
+	 * To prevent unnecessary request for contiguous physical memory chunk,
+	 * use argbuf backed by scattered pages for ITER_KVEC direct-io
+	 * read/write when the total size of its args is greater than PAGE_SIZE.
+	 */
+	if ((req->in.h.opcode == FUSE_WRITE && !args->in_pages) ||
+	    (req->in.h.opcode == FUSE_READ && !args->out_pages)) {
+		unsigned int numargs;
+		unsigned int len;
+
+		numargs = args->in_numargs - args->in_pages;
+		len = fuse_len_args(numargs, (struct fuse_arg *)args->in_args);
+		numargs = args->out_numargs - args->out_pages;
+		len += fuse_len_args(numargs, args->out_args);
+		if (len > PAGE_SIZE)
+			return true;
+	}
+
+	return false;
+}
+
 /* Add a request to a virtqueue and kick the device */
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 				 struct fuse_req *req, bool in_flight)
@@ -1317,13 +1345,24 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	unsigned int out_sgs = 0;
 	unsigned int in_sgs = 0;
 	unsigned int total_sgs;
+	unsigned int numargs;
+	unsigned int in_args_len;
+	unsigned int out_args_len;
 	unsigned int i;
 	int ret;
 	bool notify;
+	bool flat_argbuf;
 	struct fuse_pqueue *fpq;
 
+	flat_argbuf = !use_scattered_argbuf(req);
+	numargs = args->in_numargs - args->in_pages;
+	in_args_len = fuse_len_args(numargs, (struct fuse_arg *) args->in_args);
+	numargs = args->out_numargs - args->out_pages;
+	out_args_len = fuse_len_args(numargs, args->out_args);
+
 	/* Does the sglist fit on the stack? */
-	total_sgs = sg_count_fuse_req(req);
+	total_sgs = sg_count_fuse_req(req, in_args_len, out_args_len,
+				      flat_argbuf);
 	if (total_sgs > ARRAY_SIZE(stack_sgs)) {
 		sgs = kmalloc_array(total_sgs, sizeof(sgs[0]), GFP_ATOMIC);
 		sg = kmalloc_array(total_sgs, sizeof(sg[0]), GFP_ATOMIC);
@@ -1334,7 +1373,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	}
 
 	/* Use a bounce buffer since stack args cannot be mapped */
-	req->argbuf = virtio_fs_argbuf_new(args, GFP_ATOMIC, true);
+	req->argbuf = virtio_fs_argbuf_new(in_args_len, out_args_len,
+					   GFP_ATOMIC, flat_argbuf);
 	if (!req->argbuf) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.29.2


