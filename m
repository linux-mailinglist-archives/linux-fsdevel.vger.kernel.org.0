Return-Path: <linux-fsdevel+bounces-13090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DB586B1F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 15:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A885281FA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 14:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7361015B98A;
	Wed, 28 Feb 2024 14:40:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680DC15A4AF;
	Wed, 28 Feb 2024 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131249; cv=none; b=gZ3e3cZX3zcX/OrEOesDduPn6j6+1h8pIIZanX529C85tBBCa2KGKGTG4Te/Iq1G23IgreKkWCPfZfVhSmSpuyp+gWp6xptijLuz54sUkQqNWfm0UIHSbNGqGXG+gPFq/qok1DqP2KrAN8UyRhk1LCUFsMm9aj26FtvNwU20I6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131249; c=relaxed/simple;
	bh=huCSXdGFSbPcRPMpXRU5L/75Pdi/x+LgE/kzjwzotB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JCfbRNJ0ZUYJ8zTBzynjn2P++DALyyW+REZ4sVxLSVxvQQElHurXcg7K/joRXDYuAaulPISwYKBnLxxJa1VENwoE5m0d/vv88tpY4tM/LV6AwD3rvy/sOJPKn/RKyChPm0PV6sAp1SflSK9N98TcwEhNGmwzyXfjhalZhqI1Pgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TlH8N1SVSz4f3lVP;
	Wed, 28 Feb 2024 22:40:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 86C1B1A016E;
	Wed, 28 Feb 2024 22:40:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBHkRd9lwGKzFQ--.18779S7;
	Wed, 28 Feb 2024 22:40:43 +0800 (CST)
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
Subject: [PATCH v2 3/6] virtiofs: factor out more common methods for argbuf
Date: Wed, 28 Feb 2024 22:41:23 +0800
Message-Id: <20240228144126.2864064-4-houtao@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBnOBHkRd9lwGKzFQ--.18779S7
X-Coremail-Antispam: 1UD129KBjvJXoWxKFWkCryDJFy3Ar47Gr1xZrb_yoWxJrykpF
	45tw15XFWfJFZFgFyrGF4rA3WSk393uw1xGrZ3G3sxKF1UXw47XFy8AryjkrnIvrykAF4x
	AFsaqr4UWF48uaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Factor out more common methods for bounce buffer of fuse args:

1) virtio_fs_argbuf_setup_sg: set-up sgs for bounce buffer
2) virtio_fs_argbuf_copy_from_in_arg: copy each in-arg to bounce buffer
3) virtio_fs_argbuf_out_args_offset: calc the start offset of out-arg
4) virtio_fs_argbuf_copy_to_out_arg: copy bounce buffer to each out-arg

These methods will be used to implement bounce buffer backed by
scattered pages which are allocated separatedly.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/fuse/virtio_fs.c | 77 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 60 insertions(+), 17 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index cd1330506daba..f10fff7f23a0f 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -86,6 +86,10 @@ struct virtio_fs_req_work {
 	struct work_struct done_work;
 };
 
+struct virtio_fs_argbuf {
+	DECLARE_FLEX_ARRAY(u8, buf);
+};
+
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 				 struct fuse_req *req, bool in_flight);
 
@@ -404,13 +408,15 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 	}
 }
 
-static void virtio_fs_argbuf_free(void *argbuf)
+static void virtio_fs_argbuf_free(struct virtio_fs_argbuf *argbuf)
 {
 	kfree(argbuf);
 }
 
-static void *virtio_fs_argbuf_new(struct fuse_args *args, gfp_t gfp)
+static struct virtio_fs_argbuf *virtio_fs_argbuf_new(struct fuse_args *args,
+						     gfp_t gfp)
 {
+	struct virtio_fs_argbuf *argbuf;
 	unsigned int numargs;
 	unsigned int len;
 
@@ -419,7 +425,41 @@ static void *virtio_fs_argbuf_new(struct fuse_args *args, gfp_t gfp)
 	numargs = args->out_numargs - args->out_pages;
 	len += fuse_len_args(numargs, args->out_args);
 
-	return kmalloc(len, gfp);
+	argbuf = kmalloc(struct_size(argbuf, buf, len), gfp);
+
+	return argbuf;
+}
+
+static unsigned int virtio_fs_argbuf_setup_sg(struct virtio_fs_argbuf *argbuf,
+					      unsigned int offset,
+					      unsigned int len,
+					      struct scatterlist *sg)
+{
+	sg_init_one(sg, argbuf->buf + offset, len);
+	return 1;
+}
+
+static void virtio_fs_argbuf_copy_from_in_arg(struct virtio_fs_argbuf *argbuf,
+					      unsigned int offset,
+					      const void *src, unsigned int len)
+{
+	memcpy(argbuf->buf + offset, src, len);
+}
+
+static unsigned int
+virtio_fs_argbuf_out_args_offset(struct virtio_fs_argbuf *argbuf,
+				 const struct fuse_args *args)
+{
+	unsigned int num_in = args->in_numargs - args->in_pages;
+
+	return fuse_len_args(num_in, (struct fuse_arg *)args->in_args);
+}
+
+static void virtio_fs_argbuf_copy_to_out_arg(struct virtio_fs_argbuf *argbuf,
+					     unsigned int offset, void *dst,
+					     unsigned int len)
+{
+	memcpy(dst, argbuf->buf + offset, len);
 }
 
 /*
@@ -515,9 +555,9 @@ static void copy_args_to_argbuf(struct fuse_req *req)
 
 	num_in = args->in_numargs - args->in_pages;
 	for (i = 0; i < num_in; i++) {
-		memcpy(req->argbuf + offset,
-		       args->in_args[i].value,
-		       args->in_args[i].size);
+		virtio_fs_argbuf_copy_from_in_arg(req->argbuf, offset,
+						  args->in_args[i].value,
+						  args->in_args[i].size);
 		offset += args->in_args[i].size;
 	}
 }
@@ -525,17 +565,19 @@ static void copy_args_to_argbuf(struct fuse_req *req)
 /* Copy args out of req->argbuf */
 static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 {
+	struct virtio_fs_argbuf *argbuf;
 	unsigned int remaining;
 	unsigned int offset;
-	unsigned int num_in;
 	unsigned int num_out;
 	unsigned int i;
 
 	remaining = req->out.h.len - sizeof(req->out.h);
-	num_in = args->in_numargs - args->in_pages;
 	num_out = args->out_numargs - args->out_pages;
-	offset = fuse_len_args(num_in, (struct fuse_arg *)args->in_args);
+	if (!num_out)
+		goto out;
 
+	argbuf = req->argbuf;
+	offset = virtio_fs_argbuf_out_args_offset(argbuf, args);
 	for (i = 0; i < num_out; i++) {
 		unsigned int argsize = args->out_args[i].size;
 
@@ -545,13 +587,16 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 			argsize = remaining;
 		}
 
-		memcpy(args->out_args[i].value, req->argbuf + offset, argsize);
+		virtio_fs_argbuf_copy_to_out_arg(argbuf, offset,
+						 args->out_args[i].value,
+						 argsize);
 		offset += argsize;
 
 		if (i != args->out_numargs - 1)
 			remaining -= argsize;
 	}
 
+out:
 	/* Store the actual size of the variable-length arg */
 	if (args->out_argvar)
 		args->out_args[args->out_numargs - 1].size = remaining;
@@ -1100,7 +1145,6 @@ static unsigned int sg_init_fuse_args(struct scatterlist *sg,
 				      struct fuse_arg *args,
 				      unsigned int numargs,
 				      bool argpages,
-				      void *argbuf,
 				      unsigned int *len_used)
 {
 	struct fuse_args_pages *ap = container_of(req->args, typeof(*ap), args);
@@ -1109,7 +1153,8 @@ static unsigned int sg_init_fuse_args(struct scatterlist *sg,
 
 	len = fuse_len_args(numargs - argpages, args);
 	if (len)
-		sg_init_one(&sg[total_sgs++], argbuf, len);
+		total_sgs += virtio_fs_argbuf_setup_sg(req->argbuf, *len_used,
+						       len, &sg[total_sgs]);
 
 	if (argpages)
 		total_sgs += sg_init_fuse_pages(&sg[total_sgs],
@@ -1117,8 +1162,7 @@ static unsigned int sg_init_fuse_args(struct scatterlist *sg,
 						ap->num_pages,
 						args[numargs - 1].size);
 
-	if (len_used)
-		*len_used = len;
+	*len_used = len;
 
 	return total_sgs;
 }
@@ -1168,7 +1212,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	out_sgs += sg_init_fuse_args(&sg[out_sgs], req,
 				     (struct fuse_arg *)args->in_args,
 				     args->in_numargs, args->in_pages,
-				     req->argbuf, &argbuf_used);
+				     &argbuf_used);
 
 	/* Reply elements */
 	if (test_bit(FR_ISREPLY, &req->flags)) {
@@ -1176,8 +1220,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 			    &req->out.h, sizeof(req->out.h));
 		in_sgs += sg_init_fuse_args(&sg[out_sgs + in_sgs], req,
 					    args->out_args, args->out_numargs,
-					    args->out_pages,
-					    req->argbuf + argbuf_used, NULL);
+					    args->out_pages, &argbuf_used);
 	}
 
 	WARN_ON(out_sgs + in_sgs != total_sgs);
-- 
2.29.2


