Return-Path: <linux-fsdevel+bounces-13092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE31586B1FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 15:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D79D1C21C8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 14:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D9515CD5C;
	Wed, 28 Feb 2024 14:40:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D12B15A4BA;
	Wed, 28 Feb 2024 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131249; cv=none; b=jZKQY3iMpuAKbYr1iyC/hrV+gwvtU02b/DRk2oVN3CDy0cPZD6FBNeIZL4mvz93DkRWqyB7Z0yeXyxVZL1hmqTvLVef85IbAXHLp+e2ryN7Mqm5gICnSy6cuQX5+D2101gVozO082qGxsDiEdEvmFw4ULZNo/XbRMEQHkSvLGHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131249; c=relaxed/simple;
	bh=gGrqqWhOprABAylbdHf6d3Bgw6OyAPvbcs/3s/7xVEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M53DM6yh8G3ytdjXlJb9tmli41yWyG1ON0crpdB8xy8nZwUceX6+VeAGDdQ2dRKzHYmB71cRh7YowtO9493J5Jspze0Ahxf8Ap5tDjRsIGbXkIiqg0uj1dwhJF7mEiEl8D/axYkjdKMWA4f0mrBt3WzmVypISKaZXIerz9Pjdeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TlH8S4ZRtz4f3kK1;
	Wed, 28 Feb 2024 22:40:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0377C1A0172;
	Wed, 28 Feb 2024 22:40:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBHkRd9lwGKzFQ--.18779S8;
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
Subject: [PATCH v2 4/6] virtiofs: support bounce buffer backed by scattered pages
Date: Wed, 28 Feb 2024 22:41:24 +0800
Message-Id: <20240228144126.2864064-5-houtao@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBnOBHkRd9lwGKzFQ--.18779S8
X-Coremail-Antispam: 1UD129KBjvJXoW3GrW5XFyxKFWrJr1rJw1fWFg_yoW3Gr1xpF
	4Fyw15JrWfJrW7Kry8GF48AF1Skws3uw1xGrZ3X3sIkw1UXw4xXFyUAry0vrnxJrykCF1x
	JF1FqF18Wr4q9aUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When reading a file kept in virtiofs from kernel (e.g., insmod a kernel
module), if the cache of virtiofs is disabled, the read buffer will be
passed to virtiofs through out_args[0].value instead of pages. Because
virtiofs can't get the pages for the read buffer, virtio_fs_argbuf_new()
will create a bounce buffer for the read buffer by using kmalloc() and
copy the read buffer into bounce buffer. If the read buffer is large
(e.g., 1MB), the allocation will incur significant stress on the memory
subsystem.

So instead of allocating bounce buffer by using kmalloc(), allocate a
bounce buffer which is backed by scattered pages. The original idea is
to use vmap(), but the use of GFP_ATOMIC is no possible for vmap(). To
simplify the copy operations in the bounce buffer, use a bio_vec flex
array to represent the argbuf. Also add an is_flat field in struct
virtio_fs_argbuf to distinguish between kmalloc-ed and scattered bounce
buffer.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/fuse/virtio_fs.c | 163 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 149 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index f10fff7f23a0f..ffea684bd100d 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -86,10 +86,27 @@ struct virtio_fs_req_work {
 	struct work_struct done_work;
 };
 
-struct virtio_fs_argbuf {
+struct virtio_fs_flat_argbuf {
 	DECLARE_FLEX_ARRAY(u8, buf);
 };
 
+struct virtio_fs_scattered_argbuf {
+	unsigned int size;
+	unsigned int nr;
+	DECLARE_FLEX_ARRAY(struct bio_vec, bvec);
+};
+
+struct virtio_fs_argbuf {
+	bool is_flat;
+	/* There is flexible array in the end of these two struct
+	 * definitions, so they must be the last field.
+	 */
+	union {
+		struct virtio_fs_flat_argbuf f;
+		struct virtio_fs_scattered_argbuf s;
+	};
+};
+
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 				 struct fuse_req *req, bool in_flight);
 
@@ -408,42 +425,143 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 	}
 }
 
+static unsigned int virtio_fs_argbuf_len(unsigned int in_args_len,
+					 unsigned int out_args_len,
+					 bool is_flat)
+{
+	if (is_flat)
+		return in_args_len + out_args_len;
+
+	/*
+	 * Align in_args_len with PAGE_SIZE to reduce the total number of
+	 * sg entries when the value of out_args_len (e.g., the length of
+	 * read buffer) is page-aligned.
+	 */
+	return round_up(in_args_len, PAGE_SIZE) +
+	       round_up(out_args_len, PAGE_SIZE);
+}
+
 static void virtio_fs_argbuf_free(struct virtio_fs_argbuf *argbuf)
 {
+	unsigned int i;
+
+	if (!argbuf)
+		return;
+
+	if (argbuf->is_flat)
+		goto free_argbuf;
+
+	for (i = 0; i < argbuf->s.nr; i++)
+		__free_page(argbuf->s.bvec[i].bv_page);
+
+free_argbuf:
 	kfree(argbuf);
 }
 
 static struct virtio_fs_argbuf *virtio_fs_argbuf_new(struct fuse_args *args,
-						     gfp_t gfp)
+						     gfp_t gfp, bool is_flat)
 {
 	struct virtio_fs_argbuf *argbuf;
 	unsigned int numargs;
-	unsigned int len;
+	unsigned int in_len, out_len, len;
+	unsigned int i, nr;
 
 	numargs = args->in_numargs - args->in_pages;
-	len = fuse_len_args(numargs, (struct fuse_arg *) args->in_args);
+	in_len = fuse_len_args(numargs, (struct fuse_arg *) args->in_args);
 	numargs = args->out_numargs - args->out_pages;
-	len += fuse_len_args(numargs, args->out_args);
+	out_len = fuse_len_args(numargs, args->out_args);
+	len = virtio_fs_argbuf_len(in_len, out_len, is_flat);
+
+	if (is_flat) {
+		argbuf = kmalloc(struct_size(argbuf, f.buf, len), gfp);
+		if (argbuf)
+			argbuf->is_flat = true;
+
+		return argbuf;
+	}
+
+	nr = len >> PAGE_SHIFT;
+	argbuf = kmalloc(struct_size(argbuf, s.bvec, nr), gfp);
+	if (!argbuf)
+		return NULL;
+
+	argbuf->is_flat = false;
+	argbuf->s.size = len;
+	argbuf->s.nr = 0;
+	for (i = 0; i < nr; i++) {
+		struct page *page;
+
+		page = alloc_page(gfp);
+		if (!page) {
+			virtio_fs_argbuf_free(argbuf);
+			return NULL;
+		}
+		bvec_set_page(&argbuf->s.bvec[i], page, PAGE_SIZE, 0);
+		argbuf->s.nr++;
+	}
+
+	/* Zero the unused space for in_args */
+	if (in_len & ~PAGE_MASK) {
+		struct iov_iter iter;
+		unsigned int to_zero;
+
+		iov_iter_bvec(&iter, ITER_DEST, argbuf->s.bvec, argbuf->s.nr,
+			      argbuf->s.size);
+		iov_iter_advance(&iter, in_len);
 
-	argbuf = kmalloc(struct_size(argbuf, buf, len), gfp);
+		to_zero = PAGE_SIZE - (in_len & ~PAGE_MASK);
+		iov_iter_zero(to_zero, &iter);
+	}
 
 	return argbuf;
 }
 
 static unsigned int virtio_fs_argbuf_setup_sg(struct virtio_fs_argbuf *argbuf,
 					      unsigned int offset,
-					      unsigned int len,
+					      unsigned int *len,
 					      struct scatterlist *sg)
 {
-	sg_init_one(sg, argbuf->buf + offset, len);
-	return 1;
+	struct bvec_iter bi = {
+		.bi_size = offset + *len,
+	};
+	struct scatterlist *cur;
+	struct bio_vec bv;
+
+	if (argbuf->is_flat) {
+		sg_init_one(sg, argbuf->f.buf + offset, *len);
+		return 1;
+	}
+
+	cur = sg;
+	bvec_iter_advance(argbuf->s.bvec, &bi, offset);
+	for_each_bvec(bv, argbuf->s.bvec, bi, bi) {
+		sg_init_table(cur, 1);
+		sg_set_page(cur, bv.bv_page, bv.bv_len, bv.bv_offset);
+		cur++;
+	}
+	*len = round_up(*len, PAGE_SIZE);
+
+	return cur - sg;
 }
 
 static void virtio_fs_argbuf_copy_from_in_arg(struct virtio_fs_argbuf *argbuf,
 					      unsigned int offset,
 					      const void *src, unsigned int len)
 {
-	memcpy(argbuf->buf + offset, src, len);
+	struct iov_iter iter;
+	unsigned int copied;
+
+	if (argbuf->is_flat) {
+		memcpy(argbuf->f.buf + offset, src, len);
+		return;
+	}
+
+	iov_iter_bvec(&iter, ITER_DEST, argbuf->s.bvec,
+		      argbuf->s.nr, argbuf->s.size);
+	iov_iter_advance(&iter, offset);
+
+	copied = _copy_to_iter(src, len, &iter);
+	WARN_ON_ONCE(copied != len);
 }
 
 static unsigned int
@@ -451,15 +569,32 @@ virtio_fs_argbuf_out_args_offset(struct virtio_fs_argbuf *argbuf,
 				 const struct fuse_args *args)
 {
 	unsigned int num_in = args->in_numargs - args->in_pages;
+	unsigned int offset = fuse_len_args(num_in,
+					    (struct fuse_arg *)args->in_args);
 
-	return fuse_len_args(num_in, (struct fuse_arg *)args->in_args);
+	if (argbuf->is_flat)
+		return offset;
+	return round_up(offset, PAGE_SIZE);
 }
 
 static void virtio_fs_argbuf_copy_to_out_arg(struct virtio_fs_argbuf *argbuf,
 					     unsigned int offset, void *dst,
 					     unsigned int len)
 {
-	memcpy(dst, argbuf->buf + offset, len);
+	struct iov_iter iter;
+	unsigned int copied;
+
+	if (argbuf->is_flat) {
+		memcpy(dst, argbuf->f.buf + offset, len);
+		return;
+	}
+
+	iov_iter_bvec(&iter, ITER_SOURCE, argbuf->s.bvec,
+		      argbuf->s.nr, argbuf->s.size);
+	iov_iter_advance(&iter, offset);
+
+	copied = _copy_from_iter(dst, len, &iter);
+	WARN_ON_ONCE(copied != len);
 }
 
 /*
@@ -1154,7 +1289,7 @@ static unsigned int sg_init_fuse_args(struct scatterlist *sg,
 	len = fuse_len_args(numargs - argpages, args);
 	if (len)
 		total_sgs += virtio_fs_argbuf_setup_sg(req->argbuf, *len_used,
-						       len, &sg[total_sgs]);
+						       &len, &sg[total_sgs]);
 
 	if (argpages)
 		total_sgs += sg_init_fuse_pages(&sg[total_sgs],
@@ -1199,7 +1334,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	}
 
 	/* Use a bounce buffer since stack args cannot be mapped */
-	req->argbuf = virtio_fs_argbuf_new(args, GFP_ATOMIC);
+	req->argbuf = virtio_fs_argbuf_new(args, GFP_ATOMIC, true);
 	if (!req->argbuf) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.29.2


