Return-Path: <linux-fsdevel+bounces-17903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6308B3A2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 16:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C937E286B20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 14:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FA6147C63;
	Fri, 26 Apr 2024 14:38:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8526012C7FB;
	Fri, 26 Apr 2024 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142319; cv=none; b=pBC1hgb+YLabiY9bdFcGkozsMQxwEKF5GrA/v99xxtXQgufp9mhLKe4GuOeWmfHzMcE2eEglvlqsfVireObDkgSUolSj20SrDmWNY9Fo8xoqAoxxpxezGb1LSecbT7EHyS+v0S3NOxwNKXVUPKV0gGVOGWla0t4gXiDzU3/FYcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142319; c=relaxed/simple;
	bh=Qd5gSaCdGK5d5Hzl6jhOhlcU5fmdXpAq9K7L2Zxq930=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rdDVtR/gNTH0larkImd+uL7DU7eqexSZpaR2mo+MnGQ5Jr3VmaGgQ9aFMCtC3OOG5VCZaCxjEnlECicLcxp1jj1Ui7pYqtTSlaLiTqKzVxmbTb5/ojA9d5hHBYk3orJOlvPGlgtFbYW+iCVBtpzCBW7/Xm0gcTFCKphoQDr6SxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VQwM16fjbz4f3m6w;
	Fri, 26 Apr 2024 22:38:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3E16B1A1002;
	Fri, 26 Apr 2024 22:38:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5gvCtmAU4WLA--.35655S5;
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
Subject: [PATCH v3 1/2] virtiofs: use pages instead of pointer for kernel direct IO
Date: Fri, 26 Apr 2024 22:39:02 +0800
Message-Id: <20240426143903.1305919-2-houtao@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX5g5gvCtmAU4WLA--.35655S5
X-Coremail-Antispam: 1UD129KBjvJXoW3AF4UWF1Utw4DuFWfAFW5Jrb_yoW7tFy7pF
	W5KF4q9rs7XrW7Can7CF1UuFyxAwn3AF47WrZ5Ww1fur17Xry2kFyjya4YgFW7ZrWkArs2
	qrs0yw42qw4qvaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2CD7DUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When trying to insert a 10MB kernel module kept in a virtio-fs with cache
disabled, the following warning was reported:

  ------------[ cut here ]------------
  WARNING: CPU: 1 PID: 404 at mm/page_alloc.c:4551 ......
  Modules linked in:
  CPU: 1 PID: 404 Comm: insmod Not tainted 6.9.0-rc5+ #123
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ......
  RIP: 0010:__alloc_pages+0x2bf/0x380
  ......
  Call Trace:
   <TASK>
   ? __warn+0x8e/0x150
   ? __alloc_pages+0x2bf/0x380
   __kmalloc_large_node+0x86/0x160
   __kmalloc+0x33c/0x480
   virtio_fs_enqueue_req+0x240/0x6d0
   virtio_fs_wake_pending_and_unlock+0x7f/0x190
   queue_request_and_unlock+0x55/0x60
   fuse_simple_request+0x152/0x2b0
   fuse_direct_io+0x5d2/0x8c0
   fuse_file_read_iter+0x121/0x160
   __kernel_read+0x151/0x2d0
   kernel_read+0x45/0x50
   kernel_read_file+0x1a9/0x2a0
   init_module_from_file+0x6a/0xe0
   idempotent_init_module+0x175/0x230
   __x64_sys_finit_module+0x5d/0xb0
   x64_sys_call+0x1c3/0x9e0
   do_syscall_64+0x3d/0xc0
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
   ......
   </TASK>
  ---[ end trace 0000000000000000 ]---

The warning is triggered as follows:

1) syscall finit_module() handles the module insertion and it invokes
kernel_read_file() to read the content of the module first.

2) kernel_read_file() allocates a 10MB buffer by using vmalloc() and
passes it to kernel_read(). kernel_read() constructs a kvec iter by
using iov_iter_kvec() and passes it to fuse_file_read_iter().

3) virtio-fs disables the cache, so fuse_file_read_iter() invokes
fuse_direct_io(). As for now, the maximal read size for kvec iter is
only limited by fc->max_read. For virtio-fs, max_read is UINT_MAX, so
fuse_direct_io() doesn't split the 10MB buffer. It saves the address and
the size of the 10MB-sized buffer in out_args[0] of a fuse request and
passes the fuse request to virtio_fs_wake_pending_and_unlock().

4) virtio_fs_wake_pending_and_unlock() uses virtio_fs_enqueue_req() to
queue the request. Because virtiofs need DMA-able address, so
virtio_fs_enqueue_req() uses kmalloc() to allocate a bounce buffer for
all fuse args, copies these args into the bounce buffer and passed the
physical address of the bounce buffer to virtiofsd. The total length of
these fuse args for the passed fuse request is about 10MB, so
copy_args_to_argbuf() invokes kmalloc() with a 10MB size parameter and
it triggers the warning in __alloc_pages():

	if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))
		return NULL;

5) virtio_fs_enqueue_req() will retry the memory allocation in a
kworker, but it won't help, because kmalloc() will always return NULL
due to the abnormal size and finit_module() will hang forever.

A feasible solution is to limit the value of max_read for virtio-fs, so
the length passed to kmalloc() will be limited. However it will affect
the maximal read size for normal read. And for virtio-fs write initiated
from kernel, it has the similar problem but now there is no way to limit
fc->max_write in kernel.

So instead of limiting both the values of max_read and max_write in
kernel, introducing use_pages_for_kvec_io in fuse_conn and setting it as
true in virtiofs. When use_pages_for_kvec_io is enabled, fuse will use
pages instead of pointer to pass the KVEC_IO data.

Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/fuse/file.c      | 12 ++++++++----
 fs/fuse/fuse_i.h    |  3 +++
 fs/fuse/virtio_fs.c |  1 +
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b57ce41576407..82b77c5d8c643 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1471,13 +1471,17 @@ static inline size_t fuse_get_frag_size(const struct iov_iter *ii,
 
 static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 			       size_t *nbytesp, int write,
-			       unsigned int max_pages)
+			       unsigned int max_pages,
+			       bool use_pages_for_kvec_io)
 {
 	size_t nbytes = 0;  /* # bytes already packed in req */
 	ssize_t ret = 0;
 
-	/* Special case for kernel I/O: can copy directly into the buffer */
-	if (iov_iter_is_kvec(ii)) {
+	/* Special case for kernel I/O: can copy directly into the buffer.
+	 * However if the implementation of fuse_conn requires pages instead of
+	 * pointer (e.g., virtio-fs), use iov_iter_extract_pages() instead.
+	 */
+	if (iov_iter_is_kvec(ii) && !use_pages_for_kvec_io) {
 		unsigned long user_addr = fuse_get_user_addr(ii);
 		size_t frag_size = fuse_get_frag_size(ii, *nbytesp);
 
@@ -1585,7 +1589,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 		size_t nbytes = min(count, nmax);
 
 		err = fuse_get_user_pages(&ia->ap, iter, &nbytes, write,
-					  max_pages);
+					  max_pages, fc->use_pages_for_kvec_io);
 		if (err && !nbytes)
 			break;
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f239196103137..d4f04e19058c1 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -860,6 +860,9 @@ struct fuse_conn {
 	/** Passthrough support for read/write IO */
 	unsigned int passthrough:1;
 
+	/* Use pages instead of pointer for kernel I/O */
+	unsigned int use_pages_for_kvec_io:1;
+
 	/** Maximum stack depth for passthrough backing files */
 	int max_stack_depth;
 
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 322af827a2329..36984c0e23d14 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1512,6 +1512,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	fc->delete_stale = true;
 	fc->auto_submounts = true;
 	fc->sync_fs = true;
+	fc->use_pages_for_kvec_io = true;
 
 	/* Tell FUSE to split requests that exceed the virtqueue's size */
 	fc->max_pages_limit = min_t(unsigned int, fc->max_pages_limit,
-- 
2.29.2


