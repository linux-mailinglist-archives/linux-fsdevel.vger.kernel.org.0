Return-Path: <linux-fsdevel+bounces-7170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EED54822BB6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 11:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738381F22629
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 10:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E81218E35;
	Wed,  3 Jan 2024 10:58:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017AA18E1C;
	Wed,  3 Jan 2024 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T4msr3CzDz4f3lV6;
	Wed,  3 Jan 2024 18:58:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1EEE31A0807;
	Wed,  3 Jan 2024 18:58:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDHyhDUPZVlW02hFQ--.58083S4;
	Wed, 03 Jan 2024 18:58:29 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	houtao1@huawei.com
Subject: [PATCH] virtiofs: limit the length of ITER_KVEC dio by max_nopage_rw
Date: Wed,  3 Jan 2024 18:59:29 +0800
Message-Id: <20240103105929.1902658-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHyhDUPZVlW02hFQ--.58083S4
X-Coremail-Antispam: 1UD129KBjvJXoW3ArWfGw4UurWftrWDJr4rAFb_yoW7AFWxpr
	4ftFy5ZF4xXF47urZxJF4j9ryfCwn3GF42gr95W3Z3uF17Z342kF1FvFyUuFy7urW8JrWI
	qr4ktry2vrs0vaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
	Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
	CTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When trying to insert a 10MB kernel module kept in a virtiofs with cache
disabled, the following warning was reported:

  ------------[ cut here ]------------
  WARNING: CPU: 2 PID: 439 at mm/page_alloc.c:4544 ......
  Modules linked in:
  CPU: 2 PID: 439 Comm: insmod Not tainted 6.7.0-rc7+ #33
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), ......
  RIP: 0010:__alloc_pages+0x2c4/0x360
  ......
  Call Trace:
   <TASK>
   ? __warn+0x8f/0x150
   ? __alloc_pages+0x2c4/0x360
   __kmalloc_large_node+0x86/0x160
   __kmalloc+0xcd/0x140
   virtio_fs_enqueue_req+0x240/0x6d0
   virtio_fs_wake_pending_and_unlock+0x7f/0x190
   queue_request_and_unlock+0x58/0x70
   fuse_simple_request+0x18b/0x2e0
   fuse_direct_io+0x58a/0x850
   fuse_file_read_iter+0xdb/0x130
   __kernel_read+0xf3/0x260
   kernel_read+0x45/0x60
   kernel_read_file+0x1ad/0x2b0
   init_module_from_file+0x6a/0xe0
   idempotent_init_module+0x179/0x230
   __x64_sys_finit_module+0x5d/0xb0
   do_syscall_64+0x36/0xb0
   entry_SYSCALL_64_after_hwframe+0x6e/0x76
   ......
   </TASK>
  ---[ end trace 0000000000000000 ]---

The warning happened as follow. In copy_args_to_argbuf(), virtiofs uses
kmalloc-ed memory as bound buffer for fuse args, but
fuse_get_user_pages() only limits the length of fuse arg by max_read or
max_write for IOV_KVEC io (e.g., kernel_read_file from finit_module()).
For virtiofs, max_read is UINT_MAX, so a big read request which is about
10MB is passed to copy_args_to_argbuf(), kmalloc() is called in turn
with len=10MB, and triggers the warning in __alloc_pages():
WARN_ON_ONCE_GFP(order > MAX_ORDER, gfp)).

A feasible solution is to limit the value of max_read for virtiofs, so
the length passed to kmalloc() will be limited. However it will affects
the max read size for ITER_IOVEC io and the value of max_write also needs
limitation. So instead of limiting the values of max_read and max_write,
introducing max_nopage_rw to cap both the values of max_read and
max_write when the fuse dio read/write request is initiated from kernel.

Considering that fuse read/write request from kernel is uncommon and to
decrease the demand for large contiguous pages, set max_nopage_rw as
256KB instead of KMALLOC_MAX_SIZE - 4096 or similar.

Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/fuse/file.c      | 12 +++++++++++-
 fs/fuse/fuse_i.h    |  3 +++
 fs/fuse/inode.c     |  1 +
 fs/fuse/virtio_fs.c |  6 ++++++
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a660f1f21540..f1beb7c0b782 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1422,6 +1422,16 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 	return ret < 0 ? ret : 0;
 }
 
+static size_t fuse_max_dio_rw_size(const struct fuse_conn *fc,
+				   const struct iov_iter *iter, int write)
+{
+	unsigned int nmax = write ? fc->max_write : fc->max_read;
+
+	if (iov_iter_is_kvec(iter))
+		nmax = min(nmax, fc->max_nopage_rw);
+	return nmax;
+}
+
 ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 		       loff_t *ppos, int flags)
 {
@@ -1432,7 +1442,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 	struct inode *inode = mapping->host;
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = ff->fm->fc;
-	size_t nmax = write ? fc->max_write : fc->max_read;
+	size_t nmax = fuse_max_dio_rw_size(fc, iter, write);
 	loff_t pos = *ppos;
 	size_t count = iov_iter_count(iter);
 	pgoff_t idx_from = pos >> PAGE_SHIFT;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1df83eebda92..fc753cd34211 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -594,6 +594,9 @@ struct fuse_conn {
 	/** Constrain ->max_pages to this value during feature negotiation */
 	unsigned int max_pages_limit;
 
+	/** Maximum read/write size when there is no page in request */
+	unsigned int max_nopage_rw;
+
 	/** Input queue */
 	struct fuse_iqueue iq;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2a6d44f91729..4cbbcb4a4b71 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -923,6 +923,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->user_ns = get_user_ns(user_ns);
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
 	fc->max_pages_limit = FUSE_MAX_MAX_PAGES;
+	fc->max_nopage_rw = UINT_MAX;
 
 	INIT_LIST_HEAD(&fc->mounts);
 	list_add(&fm->fc_entry, &fc->mounts);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 5f1be1da92ce..3aac31d45198 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1452,6 +1452,12 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	/* Tell FUSE to split requests that exceed the virtqueue's size */
 	fc->max_pages_limit = min_t(unsigned int, fc->max_pages_limit,
 				    virtqueue_size - FUSE_HEADER_OVERHEAD);
+	/* copy_args_to_argbuf() uses kmalloc-ed memory as bounce buffer
+	 * for fuse args, so limit the total size of these args to prevent
+	 * the warning in __alloc_pages() and decrease the demand for large
+	 * contiguous pages.
+	 */
+	fc->max_nopage_rw = min(fc->max_nopage_rw, 256U << 10);
 
 	fsc->s_fs_info = fm;
 	sb = sget_fc(fsc, virtio_fs_test_super, set_anon_super_fc);
-- 
2.29.2


