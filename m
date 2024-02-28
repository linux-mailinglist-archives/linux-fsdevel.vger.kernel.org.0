Return-Path: <linux-fsdevel+bounces-13089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FBD86B1F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 15:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FB21F24D0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 14:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D749415B962;
	Wed, 28 Feb 2024 14:40:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6816015A4B9;
	Wed, 28 Feb 2024 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131248; cv=none; b=RSQqi/xG6bGWDeS2UshEOdnGJ6jvfh14YHdMCtfq2QNuUHiwv70dPzk7VT8Vj6GX7DP1kI4kcolbso27/LuzDXos+WvMR8irLTvrDsGo+ql6LcQu679AaJregYb9BPlTuuo9Rxo6umxp/FDTi5vNo0ZTA4jYL8hKaTC5Mv7hHUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131248; c=relaxed/simple;
	bh=2KwL01sAiXpjiF+csHP1C/1iZ97LREkkPfTG1NxGkm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pi7FFIktczMPf9zMs/6h9tGzJ8ostc9NxbYEjeh90t+4Kwkw8B8Z8USjNOSLvAqn12LfheKhMdIAyaIP9ZXPy2lPm6yrG75u06ZiPakxhmCSbfkzNKy6Z/qF2g3sXpW+6vF2v4HkcrItsEVVprfgWT9oLHquuxK11GzhoPttHEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TlH8R52DLz4f3kJr;
	Wed, 28 Feb 2024 22:40:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 14E0D1A0DAF;
	Wed, 28 Feb 2024 22:40:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBHkRd9lwGKzFQ--.18779S6;
	Wed, 28 Feb 2024 22:40:42 +0800 (CST)
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
Subject: [PATCH v2 2/6] virtiofs: move alloc/free of argbuf into separated helpers
Date: Wed, 28 Feb 2024 22:41:22 +0800
Message-Id: <20240228144126.2864064-3-houtao@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBnOBHkRd9lwGKzFQ--.18779S6
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4kAFyDuF1rZF1fKrWUtwb_yoWrGry5pr
	43tw15ZFZ3XFZrWF95KF4UAw1Fy3yS93WUGrZ3W3sxKF1UXw47XFy0yFy0qr90vrWkCF4x
	Ar4FqF4UWF4rXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
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
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UC9aPUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

The bounce buffer for fuse args in virtiofs will be extended to support
scatterd pages later. Therefore, move the allocation and the free of
argbuf out of the copy procedures and factor them into
virtio_fs_argbuf_{new|free}() helpers.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/fuse/virtio_fs.c | 52 +++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 5f1be1da92ce9..cd1330506daba 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -404,6 +404,24 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 	}
 }
 
+static void virtio_fs_argbuf_free(void *argbuf)
+{
+	kfree(argbuf);
+}
+
+static void *virtio_fs_argbuf_new(struct fuse_args *args, gfp_t gfp)
+{
+	unsigned int numargs;
+	unsigned int len;
+
+	numargs = args->in_numargs - args->in_pages;
+	len = fuse_len_args(numargs, (struct fuse_arg *) args->in_args);
+	numargs = args->out_numargs - args->out_pages;
+	len += fuse_len_args(numargs, args->out_args);
+
+	return kmalloc(len, gfp);
+}
+
 /*
  * Returns 1 if queue is full and sender should wait a bit before sending
  * next request, 0 otherwise.
@@ -487,36 +505,24 @@ static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
 	}
 }
 
-/* Allocate and copy args into req->argbuf */
-static int copy_args_to_argbuf(struct fuse_req *req)
+/* Copy args into req->argbuf */
+static void copy_args_to_argbuf(struct fuse_req *req)
 {
 	struct fuse_args *args = req->args;
 	unsigned int offset = 0;
 	unsigned int num_in;
-	unsigned int num_out;
-	unsigned int len;
 	unsigned int i;
 
 	num_in = args->in_numargs - args->in_pages;
-	num_out = args->out_numargs - args->out_pages;
-	len = fuse_len_args(num_in, (struct fuse_arg *) args->in_args) +
-	      fuse_len_args(num_out, args->out_args);
-
-	req->argbuf = kmalloc(len, GFP_ATOMIC);
-	if (!req->argbuf)
-		return -ENOMEM;
-
 	for (i = 0; i < num_in; i++) {
 		memcpy(req->argbuf + offset,
 		       args->in_args[i].value,
 		       args->in_args[i].size);
 		offset += args->in_args[i].size;
 	}
-
-	return 0;
 }
 
-/* Copy args out of and free req->argbuf */
+/* Copy args out of req->argbuf */
 static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 {
 	unsigned int remaining;
@@ -549,9 +555,6 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 	/* Store the actual size of the variable-length arg */
 	if (args->out_argvar)
 		args->out_args[args->out_numargs - 1].size = remaining;
-
-	kfree(req->argbuf);
-	req->argbuf = NULL;
 }
 
 /* Work function for request completion */
@@ -571,6 +574,9 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 	args = req->args;
 	copy_args_from_argbuf(args, req);
 
+	virtio_fs_argbuf_free(req->argbuf);
+	req->argbuf = NULL;
+
 	if (args->out_pages && args->page_zeroing) {
 		len = args->out_args[args->out_numargs - 1].size;
 		ap = container_of(args, typeof(*ap), args);
@@ -1149,9 +1155,13 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	}
 
 	/* Use a bounce buffer since stack args cannot be mapped */
-	ret = copy_args_to_argbuf(req);
-	if (ret < 0)
+	req->argbuf = virtio_fs_argbuf_new(args, GFP_ATOMIC);
+	if (!req->argbuf) {
+		ret = -ENOMEM;
 		goto out;
+	}
+
+	copy_args_to_argbuf(req);
 
 	/* Request elements */
 	sg_init_one(&sg[out_sgs++], &req->in.h, sizeof(req->in.h));
@@ -1210,7 +1220,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 
 out:
 	if (ret < 0 && req->argbuf) {
-		kfree(req->argbuf);
+		virtio_fs_argbuf_free(req->argbuf);
 		req->argbuf = NULL;
 	}
 	if (sgs != stack_sgs) {
-- 
2.29.2


