Return-Path: <linux-fsdevel+bounces-13088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E5E86B1F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 15:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4C1285B8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 14:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EA815B961;
	Wed, 28 Feb 2024 14:40:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6812615A4B0;
	Wed, 28 Feb 2024 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131248; cv=none; b=YRO1PDpTOEdYVH3vDS2VVoWk2grxU3XNmCUFPfjw16d2Uu5QKIAfJz/4wOu+z0t2BvCpGZaCM5xpYfiODaGoW5GAUJuZg2NvUAC+d6Frd6+YJiUpEpQ3ol71mouBXdWDJ02sHScbUyilzOo1XsrVRRxvZSWIQbUxBRi7xzrtATM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131248; c=relaxed/simple;
	bh=GOzQd1+4k7aY5WsMAE+wWu8EQfHg2z+crAl/K709Yoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HFIj0C36qOA8GHd/vvDYATftft931gi6d+lr2P0Ppp2itCkYOoOTrbaiaHRNNKpg3H6+OjisdST/0MuAiG5+Xz5A16jdLwYOBTBh2dhmUd0bq/AqEo/vZAEDaFOm4yG90Dz7Nkt61Rv7OPkLB3THtufYZ4nCwxenXpUTwfdLGH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TlH8M1vbnz4f3lfH;
	Wed, 28 Feb 2024 22:40:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 961511A0DAF;
	Wed, 28 Feb 2024 22:40:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBHkRd9lwGKzFQ--.18779S5;
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
Subject: [PATCH v2 1/6] fuse: limit the length of ITER_KVEC dio by max_pages
Date: Wed, 28 Feb 2024 22:41:21 +0800
Message-Id: <20240228144126.2864064-2-houtao@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBnOBHkRd9lwGKzFQ--.18779S5
X-Coremail-Antispam: 1UD129KBjvJXoW3AF1DtrW3ur4UCFWrXry5Arb_yoW7Gw43pr
	W3KF17uFs3XF47uws3JF1UuFyrCwnrJF43Xr95Z3s3ur1UZryIkF98K3Wa9FW7CrZ7Jw1x
	XrsYy3sFvwn0vaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jesjbUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When trying to insert a 10MB kernel module kept in a virtio-fs with cache
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

The warning is triggered when:

1) inserting a 10MB sized kernel module kept in a virtiofs.
syscall finit_module() will handle the module insertion and it will
invoke kernel_read_file() to read the content of the module first.

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
queue the request. Because the arguments in fuse request may be kept in
stack, so virtio_fs_enqueue_req() uses kmalloc() to allocate a bounce
buffer for all fuse args, copies these args into the bounce buffer and
passed the physical address of the bounce buffer to virtiofsd. The total
length of these fuse args for the passed fuse request is about 10MB, so
copy_args_to_argbuf() invokes kmalloc() with a 10MB size parameter
and it triggers the warning in __alloc_pages():

	if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))
		return NULL;

5) virtio_fs_enqueue_req() will retry the memory allocation in a
kworker, but it won't help, because kmalloc() will always return NULL
due to the abnormal size and finit_module() will hang forever.

A feasible solution is to limit the value of max_read for virtio-fs, so
the length passed to kmalloc() will be limited. However it will affect
the maximal read size for normal fuse read. And for virtio-fs write
initiated from kernel, it has the similar problem and now there is no
way to limit fc->max_write in kernel.

So instead of limiting both the values of max_read and max_write in
kernel, capping the maximal length of kvec iter IO by using max_pages in
fuse_direct_io() just like it does for ubuf/iovec iter IO. Now the max
value for max_pages is 256, so on host with 4KB page size, the maximal
size passed to kmalloc() in copy_args_to_argbuf() is about 1MB+40B. The
allocation of 2MB of physically contiguous memory will still incur
significant stress on the memory subsystem, but the warning is fixed.
Additionally, the requirement for huge physically contiguous memory will
be removed in the following patch.

Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/fuse/file.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 148a71b8b4d0e..f90ea25e366f0 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1423,6 +1423,16 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 	return ret < 0 ? ret : 0;
 }
 
+static size_t fuse_max_dio_rw_size(const struct fuse_conn *fc,
+				   const struct iov_iter *iter, int write)
+{
+	unsigned int nmax = write ? fc->max_write : fc->max_read;
+
+	if (iov_iter_is_kvec(iter))
+		nmax = min(nmax, fc->max_pages << PAGE_SHIFT);
+	return nmax;
+}
+
 ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 		       loff_t *ppos, int flags)
 {
@@ -1433,7 +1443,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 	struct inode *inode = mapping->host;
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = ff->fm->fc;
-	size_t nmax = write ? fc->max_write : fc->max_read;
+	size_t nmax = fuse_max_dio_rw_size(fc, iter, write);
 	loff_t pos = *ppos;
 	size_t count = iov_iter_count(iter);
 	pgoff_t idx_from = pos >> PAGE_SHIFT;
-- 
2.29.2


