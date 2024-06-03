Return-Path: <linux-fsdevel+bounces-20765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 567938D795B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 02:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799F61C20CD9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 00:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D51A93B;
	Mon,  3 Jun 2024 00:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OuNu0zEO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE34257D
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 00:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717374804; cv=none; b=qlyxCGyqvrWPznebhKKnSllyCVCOz3tTNDEU0bS9oyav5WGVlYcQikWCnX7YtY0qXLGIuOY48PTJShFco0kq/9lVXvPcvvyrRWftE83DdT2FWRGmGcvgwx0OlfZFh48Cc7OgS6QL0ve5+LIc7dOzDGer1a18kwDRQAn8UqBExgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717374804; c=relaxed/simple;
	bh=qSMC0gj3AkpxW0hSfyTZ9g/vn//fUelwGgiKeIwEBeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBS+o0stqgDuPkoTOUPbKkUr3N8mrZqIM5ikoaaeXUWW5Fd8c/OUHwb28tSXS8oN/Kf6j+Bw+t7EKRwas3kcJ8cje5V6LO/jNmftg/kn4Bz4pVSHfhngdL25e6kTWLL3ePFRYRIRdT5uEb2oHTpsn5tSnQWsY0NVrvyW7rXyWyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OuNu0zEO; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717374800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H2TydfRRa//dCB6Galq6U6j5ZOjMw/czyhsIhaMSWj4=;
	b=OuNu0zEOyMeufrI16DKc/EKh/nPSLjcKCAc87NjipsX+6m6ufI/4Mx68CwMPpqwnl4BAGK
	NUadKWxp8+ZnCohqJnLta8pwL4mGdgWyPEXbNdTIJuvRV63wCAK51H9BI3b1ooVZBWSfxT
	FmwkK+XzYUm0tHZSMrDe3JjN5yFMBgg=
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: kent.overstreet@linux.dev
X-Envelope-To: brauner@kernel.org
X-Envelope-To: viro@zeniv.linux.org.uk
X-Envelope-To: bernd.schubert@fastmail.fm
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: josef@toxicpanda.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-mm@kvack.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 3/5] fs: sys_ringbuffer
Date: Sun,  2 Jun 2024 20:33:00 -0400
Message-ID: <20240603003306.2030491-4-kent.overstreet@linux.dev>
In-Reply-To: <20240603003306.2030491-1-kent.overstreet@linux.dev>
References: <20240603003306.2030491-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add new syscalls for generic ringbuffers that can be attached to
arbitrary (supporting) file descriptors.

A ringbuffer consists of:
 - a single page for head/tail pointers, size/mask, and other ancilliary
   metadata, described by 'struct ringbuffer_ptrs'
 - a data buffer, consisting of one or more pages mapped at
   'ringbuffer_ptrs.data_offset' above the address of 'ringbuffer_ptrs'

The data buffer is always a power of two size. Head and tail pointers
are u32 byte offsets, and they are stored unmasked (i.e., they use the
full 32 bit range) - they must be masked for reading.

- ringbuffer(int fd, int rw, u32 size, ulong *addr)

Create or get address of an existing ringbuffer for either reads or
writes, of at least size bytes, and attach it to the given file
descriptor; the address of the ringbuffer is returned via addr.

Since files can be shared between processes in different address spaces
a ringbuffer may be mapped into multiple address spaces via this
syscall.

- ringbuffer_wait(int fd, int rw)

Wait for space to be availaable (on a ringbuffer for writing), or data
to be available (on a ringbuffer for writing).

todo: add parameters for timeout, minimum amount of data/space to wait for

- ringbuffer_wakeup(int fd, int rw)

Required after writing to a previously empty ringbuffer, or reading from
a previously full ringbuffer to notify waiters on the other end

todo - investigate integrating with futexes?
todo - add extra fields to ringbuffer_ptrs for waiting on a minimum
amount of data/space, i.e. to signal when a wakeup is required

Kernel interfaces:
 - To indicate that ringbuffers are supported on a file, set
   FOP_RINGBUFFER_READ and/or FOP_RINGBUFFER_WRITE in your
   file_operations.
 - To read or write to a file's associated ringbuffers
   (file->f_ringbuffer), use ringbuffer_read() or ringbuffer_write().

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 arch/x86/entry/syscalls/syscall_32.tbl |   3 +
 arch/x86/entry/syscalls/syscall_64.tbl |   3 +
 fs/Makefile                            |   1 +
 fs/ringbuffer.c                        | 474 +++++++++++++++++++++++++
 include/linux/fs.h                     |   2 +
 include/linux/mm_types.h               |   4 +
 include/linux/ringbuffer_sys.h         |  18 +
 include/uapi/linux/futex.h             |   1 +
 include/uapi/linux/ringbuffer_sys.h    |  40 +++
 init/Kconfig                           |   9 +
 kernel/fork.c                          |   2 +
 11 files changed, 557 insertions(+)
 create mode 100644 fs/ringbuffer.c
 create mode 100644 include/linux/ringbuffer_sys.h
 create mode 100644 include/uapi/linux/ringbuffer_sys.h

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 7fd1f57ad3d3..2385359eaf75 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -467,3 +467,6 @@
 460	i386	lsm_set_self_attr	sys_lsm_set_self_attr
 461	i386	lsm_list_modules	sys_lsm_list_modules
 462	i386	mseal 			sys_mseal
+463	i386	ringbuffer		sys_ringbuffer
+464	i386	ringbuffer_wait		sys_ringbuffer_wait
+465	i386	ringbuffer_wakeup	sys_ringbuffer_wakeup
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index a396f6e6ab5b..942602ece075 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -384,6 +384,9 @@
 460	common	lsm_set_self_attr	sys_lsm_set_self_attr
 461	common	lsm_list_modules	sys_lsm_list_modules
 462 	common  mseal			sys_mseal
+463	common	ringbuffer		sys_ringbuffer
+464	common	ringbuffer_wait		sys_ringbuffer_wait
+465	common	ringbuffer_wakeup	sys_ringbuffer_wakeup
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/fs/Makefile b/fs/Makefile
index 6ecc9b0a53f2..48e54ac01fb1 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_TIMERFD)		+= timerfd.o
 obj-$(CONFIG_EVENTFD)		+= eventfd.o
 obj-$(CONFIG_USERFAULTFD)	+= userfaultfd.o
 obj-$(CONFIG_AIO)               += aio.o
+obj-$(CONFIG_RINGBUFFER)        += ringbuffer.o
 obj-$(CONFIG_FS_DAX)		+= dax.o
 obj-$(CONFIG_FS_ENCRYPTION)	+= crypto/
 obj-$(CONFIG_FS_VERITY)		+= verity/
diff --git a/fs/ringbuffer.c b/fs/ringbuffer.c
new file mode 100644
index 000000000000..82e042c1c89b
--- /dev/null
+++ b/fs/ringbuffer.c
@@ -0,0 +1,474 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) "%s() " fmt "\n", __func__
+
+#include <linux/darray.h>
+#include <linux/errname.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/mman.h>
+#include <linux/mount.h>
+#include <linux/mutex.h>
+#include <linux/pagemap.h>
+#include <linux/pseudo_fs.h>
+#include <linux/ringbuffer_sys.h>
+#include <linux/syscalls.h>
+#include <linux/uio.h>
+
+#define RINGBUFFER_FS_MAGIC			0xa10a10a2
+
+static DEFINE_MUTEX(ringbuffer_lock);
+
+static struct vfsmount *ringbuffer_mnt;
+
+struct ringbuffer_mapping {
+	ulong			addr;
+	struct mm_struct	*mm;
+};
+
+struct ringbuffer {
+	u32			size;	/* always a power of two */
+	u32			mask;	/* size - 1 */
+	unsigned		order;
+	wait_queue_head_t	wait[2];
+	struct ringbuffer_ptrs	*ptrs;
+	void			*data;
+	/* hidden internal file for the mmap */
+	struct file		*rb_file;
+	DARRAY(struct ringbuffer_mapping) mms;
+};
+
+static const struct address_space_operations ringbuffer_aops = {
+	.dirty_folio	= noop_dirty_folio,
+#if 0
+	.migrate_folio	= ringbuffer_migrate_folio,
+#endif
+};
+
+#if 0
+static int ringbuffer_mremap(struct vm_area_struct *vma)
+{
+	struct file *file = vma->vm_file;
+	struct mm_struct *mm = vma->vm_mm;
+	struct kioctx_table *table;
+	int i, res = -EINVAL;
+
+	spin_lock(&mm->ioctx_lock);
+	rcu_read_lock();
+	table = rcu_dereference(mm->ioctx_table);
+	if (!table)
+		goto out_unlock;
+
+	for (i = 0; i < table->nr; i++) {
+		struct kioctx *ctx;
+
+		ctx = rcu_dereference(table->table[i]);
+		if (ctx && ctx->ringbuffer_file == file) {
+			if (!atomic_read(&ctx->dead)) {
+				ctx->user_id = ctx->mmap_base = vma->vm_start;
+				res = 0;
+			}
+			break;
+		}
+	}
+
+out_unlock:
+	rcu_read_unlock();
+	spin_unlock(&mm->ioctx_lock);
+	return res;
+}
+#endif
+
+static const struct vm_operations_struct ringbuffer_vm_ops = {
+#if 0
+	.mremap		= ringbuffer_mremap,
+#endif
+#if IS_ENABLED(CONFIG_MMU)
+	.fault		= filemap_fault,
+	.map_pages	= filemap_map_pages,
+	.page_mkwrite	= filemap_page_mkwrite,
+#endif
+};
+
+static int ringbuffer_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	vm_flags_set(vma, VM_DONTEXPAND);
+	vma->vm_ops = &ringbuffer_vm_ops;
+	return 0;
+}
+
+static const struct file_operations ringbuffer_fops = {
+	.mmap = ringbuffer_mmap,
+};
+
+void ringbuffer_free(struct ringbuffer *rb)
+{
+	pr_debug("%px", rb);
+
+	lockdep_assert_held(&ringbuffer_lock);
+
+	darray_for_each(rb->mms, map)
+		darray_for_each_reverse(map->mm->ringbuffers, rb2)
+			if (rb == *rb2)
+				darray_remove_item(&map->mm->ringbuffers, rb2);
+
+	if (rb->rb_file) {
+		/* Kills mapping: */
+		truncate_setsize(file_inode(rb->rb_file), 0);
+
+		struct address_space *mapping = rb->rb_file->f_mapping;
+		spin_lock(&mapping->i_private_lock);
+		mapping->i_private_data = NULL;
+		spin_unlock(&mapping->i_private_lock);
+
+		fput(rb->rb_file);
+	}
+
+	free_pages((ulong) rb->data, get_order(rb->size));
+	free_page((ulong) rb->ptrs);
+	kfree(rb);
+}
+
+static int ringbuffer_alloc_inode(struct ringbuffer *rb)
+{
+	struct inode *inode = alloc_anon_inode(ringbuffer_mnt->mnt_sb);
+	int ret = PTR_ERR_OR_ZERO(inode);
+	if (ret)
+		goto err;
+
+	inode->i_mapping->a_ops = &ringbuffer_aops;
+	inode->i_mapping->i_private_data = rb;
+	inode->i_size = rb->size * 2;
+	mapping_set_large_folios(inode->i_mapping);
+
+	rb->rb_file = alloc_file_pseudo(inode, ringbuffer_mnt, "[ringbuffer]",
+				     O_RDWR, &ringbuffer_fops);
+	ret = PTR_ERR_OR_ZERO(rb->rb_file);
+	if (ret)
+		goto err_iput;
+
+	struct folio *f_ptrs = page_folio(virt_to_page(rb->ptrs));
+	struct folio *f_data = page_folio(virt_to_page(rb->data));
+
+	__folio_set_locked(f_ptrs);
+	__folio_mark_uptodate(f_ptrs);
+
+	void *shadow = NULL;
+	ret = __filemap_add_folio(rb->rb_file->f_mapping, f_ptrs,
+				  (1U << rb->order) - 1, GFP_KERNEL, &shadow);
+	if (ret)
+		goto err;
+	folio_unlock(f_ptrs);
+
+	__folio_set_locked(f_data);
+	__folio_mark_uptodate(f_data);
+	shadow = NULL;
+	ret = __filemap_add_folio(rb->rb_file->f_mapping, f_data,
+				  1U << rb->order, GFP_KERNEL, &shadow);
+	if (ret)
+		goto err;
+	folio_unlock(f_data);
+	return 0;
+err_iput:
+	iput(inode);
+	return ret;
+err:
+	truncate_setsize(file_inode(rb->rb_file), 0);
+	fput(rb->rb_file);
+	return ret;
+}
+
+static int ringbuffer_map(struct ringbuffer *rb, ulong *addr)
+{
+	struct mm_struct *mm = current->mm;
+	int ret = 0;
+
+	lockdep_assert_held(&ringbuffer_lock);
+
+	if (!rb->rb_file) {
+		ret = ringbuffer_alloc_inode(rb);
+		if (ret)
+			return ret;
+	}
+
+	ret = darray_make_room(&rb->mms, 1) ?:
+	      darray_make_room(&mm->ringbuffers, 1);
+	if (ret)
+		return ret;
+
+	ret = mmap_write_lock_killable(mm);
+	if (ret)
+		return ret;
+
+	ulong unused;
+	struct ringbuffer_mapping map = {
+		.addr = do_mmap(rb->rb_file, 0, rb->size + PAGE_SIZE,
+				PROT_READ|PROT_WRITE,
+				MAP_SHARED, 0,
+				(1U << rb->order) - 1,
+				&unused, NULL),
+		.mm = mm,
+	};
+	mmap_write_unlock(mm);
+
+	ret = PTR_ERR_OR_ZERO((void *) map.addr);
+	if (ret)
+		return ret;
+
+	ret =   darray_push(&mm->ringbuffers, rb) ?:
+		darray_push(&rb->mms, map);
+	BUG_ON(ret); /* we preallocated */
+
+	*addr = map.addr;
+	return 0;
+}
+
+static int ringbuffer_get_addr_or_map(struct ringbuffer *rb, ulong *addr)
+{
+	lockdep_assert_held(&ringbuffer_lock);
+
+	struct mm_struct *mm = current->mm;
+
+	darray_for_each(rb->mms, map)
+		if (map->mm == mm) {
+			*addr = map->addr;
+			return 0;
+		}
+
+	return ringbuffer_map(rb, addr);
+}
+
+struct ringbuffer *ringbuffer_alloc(u32 size)
+{
+	unsigned order = get_order(size);
+	size = PAGE_SIZE << order;
+
+	struct ringbuffer *rb = kzalloc(sizeof(*rb), GFP_KERNEL);
+	if (!rb)
+		return ERR_PTR(-ENOMEM);
+
+	rb->size	= size;
+	rb->mask	= size - 1;
+	rb->order	= order;
+	init_waitqueue_head(&rb->wait[READ]);
+	init_waitqueue_head(&rb->wait[WRITE]);
+
+	rb->ptrs = (void *) __get_free_page(GFP_KERNEL|__GFP_ZERO);
+	rb->data = (void *) __get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_COMP, order);
+	if (!rb->ptrs || !rb->data) {
+		ringbuffer_free(rb);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* todo - implement a fallback when high order allocation fails */
+
+	rb->ptrs->size	= size;
+	rb->ptrs->mask	= size - 1;
+	rb->ptrs->data_offset = PAGE_SIZE;
+	return rb;
+}
+
+/*
+ * XXX: we require synchronization when killing a ringbuffer (because no longer
+ * mapped anywhere) to a file that is still open (and in use)
+ */
+static void ringbuffer_mm_drop(struct mm_struct *mm, struct ringbuffer *rb)
+{
+	darray_for_each_reverse(rb->mms, map)
+		if (mm == map->mm) {
+			pr_debug("removing %px from %px", rb, mm);
+			darray_remove_item(&rb->mms, map);
+		}
+}
+
+void ringbuffer_mm_exit(struct mm_struct *mm)
+{
+	mutex_lock(&ringbuffer_lock);
+	darray_for_each_reverse(mm->ringbuffers, rb)
+		ringbuffer_mm_drop(mm, *rb);
+	mutex_unlock(&ringbuffer_lock);
+
+	darray_exit(&mm->ringbuffers);
+}
+
+SYSCALL_DEFINE4(ringbuffer, unsigned, fd, int, rw, u32, size, ulong __user *, ringbufferp)
+{
+	ulong rb_addr;
+
+	int ret = get_user(rb_addr, ringbufferp);
+	if (unlikely(ret))
+		return ret;
+
+	if (unlikely(rb_addr || !size || rw > WRITE))
+		return -EINVAL;
+
+	struct fd f = fdget(fd);
+	if (!f.file)
+		return -EBADF;
+
+	struct ringbuffer *rb = f.file->f_op->ringbuffer(f.file, rw);
+	if (!rb) {
+		ret = -EOPNOTSUPP;
+		goto err;
+	}
+
+	mutex_lock(&ringbuffer_lock);
+	ret = ringbuffer_get_addr_or_map(rb, &rb_addr);
+	if (ret)
+		goto err_unlock;
+
+	ret = put_user(rb_addr, ringbufferp);
+err_unlock:
+	mutex_unlock(&ringbuffer_lock);
+err:
+	fdput(f);
+	return ret;
+}
+
+ssize_t ringbuffer_read_iter(struct ringbuffer *rb, struct iov_iter *iter, bool nonblocking)
+{
+	u32 tail = rb->ptrs->tail, orig_tail = tail;
+	u32 head = smp_load_acquire(&rb->ptrs->head);
+
+	if (unlikely(head == tail)) {
+		if (nonblocking)
+			return -EAGAIN;
+		int ret = wait_event_interruptible(rb->wait[READ],
+			(head = smp_load_acquire(&rb->ptrs->head)) != rb->ptrs->tail);
+		if (ret)
+			return ret;
+	}
+
+	while (iov_iter_count(iter)) {
+		u32 tail_masked = tail & rb->mask;
+		u32 len = min(iov_iter_count(iter),
+			  min(head - tail,
+			      rb->size - tail_masked));
+		if (!len)
+			break;
+
+		len = copy_to_iter(rb->data + tail_masked, len, iter);
+
+		tail += len;
+	}
+
+	smp_store_release(&rb->ptrs->tail, tail);
+
+	smp_mb();
+
+	if (rb->ptrs->head - orig_tail >= rb->size)
+		wake_up(&rb->wait[WRITE]);
+
+	return tail - orig_tail;
+}
+EXPORT_SYMBOL_GPL(ringbuffer_read_iter);
+
+ssize_t ringbuffer_write_iter(struct ringbuffer *rb, struct iov_iter *iter, bool nonblocking)
+{
+	u32 head = rb->ptrs->head, orig_head = head;
+	u32 tail = smp_load_acquire(&rb->ptrs->tail);
+
+	if (unlikely(head - tail >= rb->size)) {
+		if (nonblocking)
+			return -EAGAIN;
+		int ret = wait_event_interruptible(rb->wait[WRITE],
+			head - (tail = smp_load_acquire(&rb->ptrs->tail)) < rb->size);
+		if (ret)
+			return ret;
+	}
+
+	while (iov_iter_count(iter)) {
+		u32 head_masked = head & rb->mask;
+		u32 len = min(iov_iter_count(iter),
+			  min(tail + rb->size - head,
+			      rb->size - head_masked));
+		if (!len)
+			break;
+
+		len = copy_from_iter(rb->data + head_masked, len, iter);
+
+		head += len;
+	}
+
+	smp_store_release(&rb->ptrs->head, head);
+
+	smp_mb();
+
+	if ((s32) (rb->ptrs->tail - orig_head) >= 0)
+		wake_up(&rb->wait[READ]);
+
+	return head - orig_head;
+}
+EXPORT_SYMBOL_GPL(ringbuffer_write_iter);
+
+SYSCALL_DEFINE2(ringbuffer_wait, unsigned, fd, int, rw)
+{
+	int ret = 0;
+
+	if (rw > WRITE)
+		return -EINVAL;
+
+	struct fd f = fdget(fd);
+	if (!f.file)
+		return -EBADF;
+
+	struct ringbuffer *rb = f.file->f_op->ringbuffer(f.file, rw);
+	if (!rb) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	struct ringbuffer_ptrs *rp = rb->ptrs;
+	wait_event(rb->wait[rw], rw == READ
+		   ? rp->head != rp->tail
+		   : rp->head - rp->tail < rb->size);
+err:
+	fdput(f);
+	return ret;
+}
+
+SYSCALL_DEFINE2(ringbuffer_wakeup, unsigned, fd, int, rw)
+{
+	int ret = 0;
+
+	if (rw > WRITE)
+		return -EINVAL;
+
+	struct fd f = fdget(fd);
+	if (!f.file)
+		return -EBADF;
+
+	struct ringbuffer *rb = f.file->f_op->ringbuffer(f.file, rw);
+	if (!rb) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	wake_up(&rb->wait[!rw]);
+err:
+	fdput(f);
+	return ret;
+}
+
+static int ringbuffer_init_fs_context(struct fs_context *fc)
+{
+	if (!init_pseudo(fc, RINGBUFFER_FS_MAGIC))
+		return -ENOMEM;
+	fc->s_iflags |= SB_I_NOEXEC;
+	return 0;
+}
+
+static int __init ringbuffer_init(void)
+{
+	static struct file_system_type ringbuffer_fs = {
+		.name		= "ringbuffer",
+		.init_fs_context = ringbuffer_init_fs_context,
+		.kill_sb	= kill_anon_super,
+	};
+	ringbuffer_mnt = kern_mount(&ringbuffer_fs);
+	if (IS_ERR(ringbuffer_mnt))
+		panic("Failed to create ringbuffer fs mount.");
+	return 0;
+}
+__initcall(ringbuffer_init);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0283cf366c2a..3026f8f92d6f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1996,6 +1996,7 @@ struct offset_ctx;
 
 typedef unsigned int __bitwise fop_flags_t;
 
+struct ringbuffer;
 struct file_operations {
 	struct module *owner;
 	fop_flags_t fop_flags;
@@ -2004,6 +2005,7 @@ struct file_operations {
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
 	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
+	struct ringbuffer *(*ringbuffer)(struct file *, int);
 	int (*iopoll)(struct kiocb *kiocb, struct io_comp_batch *,
 			unsigned int flags);
 	int (*iterate_shared) (struct file *, struct dir_context *);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 24323c7d0bd4..6e412718ce7e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -5,6 +5,7 @@
 #include <linux/mm_types_task.h>
 
 #include <linux/auxvec.h>
+#include <linux/darray_types.h>
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
@@ -911,6 +912,9 @@ struct mm_struct {
 		spinlock_t			ioctx_lock;
 		struct kioctx_table __rcu	*ioctx_table;
 #endif
+#ifdef CONFIG_RINGBUFFER
+		DARRAY(struct ringbuffer *)	ringbuffers;
+#endif
 #ifdef CONFIG_MEMCG
 		/*
 		 * "owner" points to a task that is regarded as the canonical
diff --git a/include/linux/ringbuffer_sys.h b/include/linux/ringbuffer_sys.h
new file mode 100644
index 000000000000..843509f72514
--- /dev/null
+++ b/include/linux/ringbuffer_sys.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_RINGBUFFER_SYS_H
+#define _LINUX_RINGBUFFER_SYS_H
+
+#include <linux/darray_types.h>
+#include <linux/spinlock_types.h>
+#include <uapi/linux/ringbuffer_sys.h>
+
+struct mm_struct;
+void ringbuffer_mm_exit(struct mm_struct *mm);
+
+void ringbuffer_free(struct ringbuffer *rb);
+struct ringbuffer *ringbuffer_alloc(u32 size);
+
+ssize_t ringbuffer_read_iter(struct ringbuffer *rb, struct iov_iter *iter, bool nonblock);
+ssize_t ringbuffer_write_iter(struct ringbuffer *rb, struct iov_iter *iter, bool nonblock);
+
+#endif /* _LINUX_RINGBUFFER_SYS_H */
diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index d2ee625ea189..09d94a5cb849 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -22,6 +22,7 @@
 #define FUTEX_WAIT_REQUEUE_PI	11
 #define FUTEX_CMP_REQUEUE_PI	12
 #define FUTEX_LOCK_PI2		13
+#define FUTEX_WAIT_GE		14
 
 #define FUTEX_PRIVATE_FLAG	128
 #define FUTEX_CLOCK_REALTIME	256
diff --git a/include/uapi/linux/ringbuffer_sys.h b/include/uapi/linux/ringbuffer_sys.h
new file mode 100644
index 000000000000..a7afe8647cc1
--- /dev/null
+++ b/include/uapi/linux/ringbuffer_sys.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_RINGBUFFER_SYS_H
+#define _UAPI_LINUX_RINGBUFFER_SYS_H
+
+#include <uapi/linux/types.h>
+
+/*
+ * ringbuffer_ptrs - head and tail pointers for a ringbuffer, mappped to
+ * userspace:
+ */
+struct ringbuffer_ptrs {
+	/*
+	 * We use u32s because this type is shared between the kernel and
+	 * userspace - ulong/size_t won't work here, we might be 32bit userland
+	 * and 64 bit kernel, and u64 would be preferable (reduced probability
+	 * of ABA) but not all architectures can atomically read/write to a u64;
+	 * we need to avoid torn reads/writes.
+	 *
+	 * head and tail pointers are incremented and stored without masking;
+	 * this is to avoid ABA and differentiate between a full and empty
+	 * buffer - they must be masked with @mask to get an actual offset into
+	 * the data buffer.
+	 *
+	 * All units are in bytes.
+	 *
+	 * Data is emitted at head, consumed from tail.
+	 */
+	__u32		head;
+	__u32		tail;
+	__u32		size;	/* always a power of two */
+	__u32		mask;	/* size - 1 */
+
+	/*
+	 * Starting offset of data buffer, from the start of this struct - will
+	 * always be PAGE_SIZE.
+	 */
+	__u32		data_offset;
+};
+
+#endif /* _UAPI_LINUX_RINGBUFFER_SYS_H */
diff --git a/init/Kconfig b/init/Kconfig
index 72404c1f2157..c43d536d4898 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1673,6 +1673,15 @@ config IO_URING
 	  applications to submit and complete IO through submission and
 	  completion rings that are shared between the kernel and application.
 
+config RINGBUFFER
+	bool "Enable ringbuffer() syscall" if EXPERT
+	select XARRAY_MULTI
+	default y
+	help
+	  This option adds support for generic ringbuffers, which can be
+	  attached to any (supported) file descriptor, allowing for reading and
+	  writing without syscall overhead.
+
 config ADVISE_SYSCALLS
 	bool "Enable madvise/fadvise syscalls" if EXPERT
 	default y
diff --git a/kernel/fork.c b/kernel/fork.c
index 99076dbe27d8..9190a06a6365 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -103,6 +103,7 @@
 #include <linux/rseq.h>
 #include <uapi/linux/pidfd.h>
 #include <linux/pidfs.h>
+#include <linux/ringbuffer_sys.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -1340,6 +1341,7 @@ static inline void __mmput(struct mm_struct *mm)
 	VM_BUG_ON(atomic_read(&mm->mm_users));
 
 	uprobe_clear_state(mm);
+	ringbuffer_mm_exit(mm);
 	exit_aio(mm);
 	ksm_exit(mm);
 	khugepaged_exit(mm); /* must run before exit_mmap */
-- 
2.45.1


