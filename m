Return-Path: <linux-fsdevel+bounces-28104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591D3967082
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 11:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4951F22E78
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 09:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E20917B4F9;
	Sat, 31 Aug 2024 09:37:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065F516F8E5;
	Sat, 31 Aug 2024 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725097079; cv=none; b=eVjl7oPkrspaUiFq0ot8ExxXFVy2wbx+5aob+/EaWfMKijDMo0d5TttsmOksyb4PsPpWuz/XxLGfseQDSHMu8ZweCy5uPgTfd1AMgFmhaaMzOMICqYfiv5p+Po2L+StGH1fA+0w4N2BrhgRxbLrti8so5BZ+CkGfgyjntvq3wIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725097079; c=relaxed/simple;
	bh=9h1fXSXnjuNL7q6kkM0w7OT0IYhBTu9tKK4j9NAvXzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OfCMCGHFnIFFF47hN1QMtCgh6v7Bz5Lb2wUWzZBo5X0PSKS23DvRVFNY0STjEU6qsnt18sHQ3ocHe47XxDjZIMnuOnq3bUV00zC1ze1U3DdrD0GzWw1v/3G7skR4uoIJ2+FBrntQ9TK3JvZFMtx39+MEfZi9JLW+V+n0sg6wN4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WwqgQ160zz4f3jcr;
	Sat, 31 Aug 2024 17:37:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E1BBB1A06D7;
	Sat, 31 Aug 2024 17:37:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBXzIJj5NJm0I_lDA--.58191S5;
	Sat, 31 Aug 2024 17:37:52 +0800 (CST)
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
Subject: [PATCH v4 1/2] virtiofs: use pages instead of pointer for kernel direct IO
Date: Sat, 31 Aug 2024 17:37:49 +0800
Message-Id: <20240831093750.1593871-2-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBXzIJj5NJm0I_lDA--.58191S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Cr4ftr45ZFyktrW3Ar4rAFb_yoWDAr1UpF
	W3ta1YyFWxXFW7Crs3JF4UuF1S9wn5CF4xKrZ5Wa4Svr1UtryakF90ya4UuFy7ArykJr47
	Xrs0vrnFqr4DXw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2Izu
	DUUUU
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

After switching to pages for KVEC_IO data, these pages will be used for
DMA through virtio-fs. If these pages are backed by vmalloc(),
{flush|invalidate}_kernel_vmap_range() are necessary to flush or
invalidate the cache before the DMA operation. So add two new fields in
fuse_args_pages to record the base address of vmalloc area and the
condition indicating whether invalidation is needed. Perform the flush
in fuse_get_user_pages() for write operations and the invalidation in
fuse_release_user_pages() for read operations.

It may seem necessary to introduce another field in fuse_conn to
indicate that these KVEC_IO pages are used for DMA, However, considering
that virtio-fs is currently the only user of use_pages_for_kvec_io, just
reuse use_pages_for_kvec_io to indicate that these pages will be used
for DMA.

Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/fuse/file.c      | 62 +++++++++++++++++++++++++++++++--------------
 fs/fuse/fuse_i.h    |  6 +++++
 fs/fuse/virtio_fs.c |  1 +
 3 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f39456c65ed7..331208d3e4d1 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -645,7 +645,7 @@ void fuse_read_args_fill(struct fuse_io_args *ia, struct file *file, loff_t pos,
 	args->out_args[0].size = count;
 }
 
-static void fuse_release_user_pages(struct fuse_args_pages *ap,
+static void fuse_release_user_pages(struct fuse_args_pages *ap, ssize_t nres,
 				    bool should_dirty)
 {
 	unsigned int i;
@@ -656,6 +656,9 @@ static void fuse_release_user_pages(struct fuse_args_pages *ap,
 		if (ap->args.is_pinned)
 			unpin_user_page(ap->pages[i]);
 	}
+
+	if (nres > 0 && ap->args.invalidate_vmap)
+		invalidate_kernel_vmap_range(ap->args.vmap_base, nres);
 }
 
 static void fuse_io_release(struct kref *kref)
@@ -754,25 +757,29 @@ static void fuse_aio_complete_req(struct fuse_mount *fm, struct fuse_args *args,
 	struct fuse_io_args *ia = container_of(args, typeof(*ia), ap.args);
 	struct fuse_io_priv *io = ia->io;
 	ssize_t pos = -1;
-
-	fuse_release_user_pages(&ia->ap, io->should_dirty);
+	size_t nres;
 
 	if (err) {
 		/* Nothing */
 	} else if (io->write) {
 		if (ia->write.out.size > ia->write.in.size) {
 			err = -EIO;
-		} else if (ia->write.in.size != ia->write.out.size) {
-			pos = ia->write.in.offset - io->offset +
-				ia->write.out.size;
+		} else {
+			nres = ia->write.out.size;
+			if (ia->write.in.size != ia->write.out.size)
+				pos = ia->write.in.offset - io->offset +
+				      ia->write.out.size;
 		}
 	} else {
 		u32 outsize = args->out_args[0].size;
 
+		nres = outsize;
 		if (ia->read.in.size != outsize)
 			pos = ia->read.in.offset - io->offset + outsize;
 	}
 
+	fuse_release_user_pages(&ia->ap, err ?: nres, io->should_dirty);
+
 	fuse_aio_complete(io, err, pos);
 	fuse_io_free(ia);
 }
@@ -1467,24 +1474,37 @@ static inline size_t fuse_get_frag_size(const struct iov_iter *ii,
 
 static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 			       size_t *nbytesp, int write,
-			       unsigned int max_pages)
+			       unsigned int max_pages,
+			       bool use_pages_for_kvec_io)
 {
+	bool flush_or_invalidate = false;
 	size_t nbytes = 0;  /* # bytes already packed in req */
 	ssize_t ret = 0;
 
-	/* Special case for kernel I/O: can copy directly into the buffer */
+	/* Special case for kernel I/O: can copy directly into the buffer.
+	 * However if the implementation of fuse_conn requires pages instead of
+	 * pointer (e.g., virtio-fs), use iov_iter_extract_pages() instead.
+	 */
 	if (iov_iter_is_kvec(ii)) {
-		unsigned long user_addr = fuse_get_user_addr(ii);
-		size_t frag_size = fuse_get_frag_size(ii, *nbytesp);
+		void *user_addr = (void *)fuse_get_user_addr(ii);
 
-		if (write)
-			ap->args.in_args[1].value = (void *) user_addr;
-		else
-			ap->args.out_args[0].value = (void *) user_addr;
+		if (!use_pages_for_kvec_io) {
+			size_t frag_size = fuse_get_frag_size(ii, *nbytesp);
 
-		iov_iter_advance(ii, frag_size);
-		*nbytesp = frag_size;
-		return 0;
+			if (write)
+				ap->args.in_args[1].value = user_addr;
+			else
+				ap->args.out_args[0].value = user_addr;
+
+			iov_iter_advance(ii, frag_size);
+			*nbytesp = frag_size;
+			return 0;
+		}
+
+		if (is_vmalloc_addr(user_addr)) {
+			ap->args.vmap_base = user_addr;
+			flush_or_invalidate = true;
+		}
 	}
 
 	while (nbytes < *nbytesp && ap->num_pages < max_pages) {
@@ -1513,6 +1533,10 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 			(PAGE_SIZE - ret) & (PAGE_SIZE - 1);
 	}
 
+	if (write && flush_or_invalidate)
+		flush_kernel_vmap_range(ap->args.vmap_base, nbytes);
+
+	ap->args.invalidate_vmap = !write && flush_or_invalidate;
 	ap->args.is_pinned = iov_iter_extract_will_pin(ii);
 	ap->args.user_pages = true;
 	if (write)
@@ -1581,7 +1605,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 		size_t nbytes = min(count, nmax);
 
 		err = fuse_get_user_pages(&ia->ap, iter, &nbytes, write,
-					  max_pages);
+					  max_pages, fc->use_pages_for_kvec_io);
 		if (err && !nbytes)
 			break;
 
@@ -1595,7 +1619,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 		}
 
 		if (!io->async || nres < 0) {
-			fuse_release_user_pages(&ia->ap, io->should_dirty);
+			fuse_release_user_pages(&ia->ap, nres, io->should_dirty);
 			fuse_io_free(ia);
 		}
 		ia = NULL;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f23919610313..79add14c363f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -309,9 +309,12 @@ struct fuse_args {
 	bool may_block:1;
 	bool is_ext:1;
 	bool is_pinned:1;
+	bool invalidate_vmap:1;
 	struct fuse_in_arg in_args[3];
 	struct fuse_arg out_args[2];
 	void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
+	/* Used for kvec iter backed by vmalloc address */
+	void *vmap_base;
 };
 
 struct fuse_args_pages {
@@ -860,6 +863,9 @@ struct fuse_conn {
 	/** Passthrough support for read/write IO */
 	unsigned int passthrough:1;
 
+	/* Use pages instead of pointer for kernel I/O */
+	unsigned int use_pages_for_kvec_io:1;
+
 	/** Maximum stack depth for passthrough backing files */
 	int max_stack_depth;
 
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index dd5260141615..43d66ab5e891 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1568,6 +1568,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	fc->delete_stale = true;
 	fc->auto_submounts = true;
 	fc->sync_fs = true;
+	fc->use_pages_for_kvec_io = true;
 
 	/* Tell FUSE to split requests that exceed the virtqueue's size */
 	fc->max_pages_limit = min_t(unsigned int, fc->max_pages_limit,
-- 
2.29.2


