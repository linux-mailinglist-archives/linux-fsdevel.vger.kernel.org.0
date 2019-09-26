Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 490E6BEA7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 04:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbfIZCNh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 22:13:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45715 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfIZCNh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 22:13:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id r5so478158wrm.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2019 19:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YrpOaPQLD5Jn7KZmM5HKkpm2ZuROLPYaVDN60R153Dg=;
        b=j4g8CuNTXWw9n3m8mffCwJuNA+PA+Hb6QMdufOp6oW+zr2d788h5EAi13pP01dJzd5
         bVs+2ejbaK9sG4OOGBg0xMo7ZJskBDopWQ05u8UKIW7n1mtn6ceXkOozRagN4+CCjG2h
         uKKT7FXWvMKgw4kiAfZ0MTtsSK+wcxOdSVIbhOXjzsABFJ2JVti4hEfomR/hZdp+v3oJ
         O7K9kaocTb1EkoZkDhoUonzIwQOyY+3gFBT8E6/PMC7BbJEIKBw7hU82ngIOXcM71Wwc
         /LjonYbJw2FxEPy8+OGGwpuzrFOqteKiV7JUABD7eb63VhI8tV+PGWoFsUwGR2gbsXmB
         9KVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YrpOaPQLD5Jn7KZmM5HKkpm2ZuROLPYaVDN60R153Dg=;
        b=Nd/NL5yFggLPQnZvgwgzvg1s7KJHlFYpb3FyH/yfv4NSoX6DLNkOm5X3GsB14C7TRu
         H9Gk4jZTCWEejlaNzKku0oBK3ZnkennIBv3F62HOA8BUMdC3U6W2WUmxYSHQzAfTn1Y8
         GTj/BOkVW8nUKAAeeehpt/buk2GOIP38Az1vhltiEfTX3IwRLZ4r0NHJbasJbgjvrbB6
         l5NYnVnO1pxx7wHPPiT0qKA6z0aVAs9T+QF96l7rlGZaVStv7C3FRHW5KCQfvQLc3Yxv
         gp6WZ50AABhh0ucRMOs231/4wa3DmQIA8FWNOACR/PdJTdEM+EndG7GwtMyBtfTTpsI4
         u10w==
X-Gm-Message-State: APjAAAX+CZjBDxI7QrQ+VDSWfmVJ8pXz/FENbMm7+DgxftouelMqBJV1
        09A8tjnvtu0gfSp953csM4FhySZM750=
X-Google-Smtp-Source: APXvYqylDWaqgEqmxxFXmsAbL+2r+weaOoWOV8cQKKFETCvPOqz+p7IzwBGzY9VsUA74PYRf0dnkZw==
X-Received: by 2002:a5d:40c4:: with SMTP id b4mr839063wrq.214.1569464007263;
        Wed, 25 Sep 2019 19:13:27 -0700 (PDT)
Received: from Bfire.plexistor.com ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id o19sm968751wro.50.2019.09.25.19.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 19:13:26 -0700 (PDT)
From:   Boaz Harrosh <boaz@plexistor.com>
X-Google-Original-From: Boaz Harrosh <boazh@netapp.com>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matt Benjamin <mbenjami@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Sagi Manole <sagim@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 11/16] zuf: Write/Read implementation
Date:   Thu, 26 Sep 2019 05:07:20 +0300
Message-Id: <20190926020725.19601-12-boazh@netapp.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926020725.19601-1-boazh@netapp.com>
References: <20190926020725.19601-1-boazh@netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

zufs Has two ways to do IO.

1. The elegant way:
   By mapping application buffers into Server VM. This is much simpler
   to implement by zusFS. But is slow and does not scale well.

2. The fast way: (called NIO)
   Server returns physical block information. And the pmem_memcpy
   is done in Kernel.

   This way is more complicated. Each block needs to ZUFS_GET_MULTI
   But also ZUFS_PUT_MULTI to indicate that Kernel has finished the
   copy, and pmem block may be recycled.
   But if we will go to server and back twice for each IOP this will
   kill our performance. So what we do is the pigi_put mechanisim
   (See zuf-core.c). pigi_put is a way to delay the put operation for
   later so when a new operation is going to Server it will take on the
   way all accumulated put operations. So in one go I might fetch
   new block info as well as PUT the previous IO. Don't worry all
   this is done zuf-core style without any locks or atomics.
   There are times that Server may request an immediate PUT and/or
   keep the ZT-channel locked for guaranty forward progress.

It is up to the zusFS to decide which mode it wants to operate in
[1] or [2] above. And more flags govern aspects of the IO requested.

The dispatch to the server can operate on buffers up to
ZUS_API_MAP_MAX_SIZE (4M). Any bigger operations are split
up and dispatched at this size.

Also if a multy-segments aio is used each segment is dispatched
on its own.

rw.c here also includes some operations for mmap. Will be used
in next patch.

The fallocate operation with its various mode flags is also dispatched
through the rw.c IO API because it might need to do some t1/t2 IO as
part of the operation. If it is for COW of cloned inodes or read/write
of the unaligned edges. zufs also implements truncate via a private
fallocate flag.

There is also code for comparing two buffers for the implementation
of the dedup operation.

Also in this patch the facility to SWAP on a zufs system.

There is also an IOCTL fasility to execute IO (ZU_IOC_IOMAP_EXEC)
from a Server background threads. We use this in Netapp for
tiering down cold blocks to slower storage.
Both ZU_IOC_IOMAP_EXEC and the IO despatch operate on facility
we call zufs_iomap which is a varlen buffer that may request and
encode many types of operations and block/memory targets for IO.
It is kind of an IO executor of sorts. zusFS encodes such iomap
to tell Kernel what needs to be done.

[v2]
  zuf: Range of _IO_gm_inner must fit API (PXS-5151)
   Zuf must never request pages which may fall out-of-range of
  ZUS_API_MAP_MAX_PAGES. When IO request is not page-aligned, limit
  size based on start offset.

[v3]
  zufc: bad bugs in zufc_goose_all_zts

 * The BAD Bug was that we called the internal smp_call_function
   instead of the proper on_each_cpu.
   This was bad because smp_call_function calls all other CPUs
   but us. Anyway the proper public API for this is on_each_cpu.

 * Another BUG is that zufc_goose_all_zts needs to be always called
   with an inode. This is because we are assuming that we are holding
   the inode_w_lock and no more puts can come in parallel to the goose_all.

 * In clone the goose target is the destination file which is going
   to be truncated. (See above we must have a locked inode at hand)

 * Call zufc_goose_all_zts under the inode_w_lock in evict.

 * One more change is to *not* relay on Server to turn off the
   ZUFS_H_HAS_PIGY_PUT flag. We will use this later to fix another
   theoretical Race window with pigi_put
   (In fact there is a zus patch to stop resetting that bit)

[v4]
  Remove the swap activate code. It will come in later Kernels.
  This is because to do it properly we should send a small patch
  to Kernel so to not force the FS to use page_cache. The code
  had an Hack to bypass this bug. But I rather remove the code
  instead.

[v5]
  Fix the warning of type:
    warning: the frame size of 8712 bytes is larger than 8192 bytes

  We allocate the maximum stack space allowed by the Kernel
  configuration, without warning. If the needed space fits in the
  stack it is used. If not we allocate from a new dedicated kmem_cache
  an 8K buffer to store our block-numbers. 8k is the maximum allowed
  in the zufs API which is 1024 data blocks,
  The above logic is hidden under the big_alloc facility that was already
  used in other places.

Signed-off-by: Sagi Manole <sagim@netapp.com>
Signed-off-by: Boaz Harrosh <boazh@netapp.com>
---
 fs/zuf/Makefile   |   1 +
 fs/zuf/_extern.h  |  22 ++
 fs/zuf/file.c     |  73 ++++
 fs/zuf/inode.c    |  13 +
 fs/zuf/rw.c       | 959 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/zuf/zuf-core.c | 400 ++++++++++++++++++-
 fs/zuf/zuf.h      |   7 +
 fs/zuf/zus_api.h  | 251 ++++++++++++
 8 files changed, 1724 insertions(+), 2 deletions(-)
 create mode 100644 fs/zuf/rw.c

diff --git a/fs/zuf/Makefile b/fs/zuf/Makefile
index 04c31b7bb9ff..23bc3791a001 100644
--- a/fs/zuf/Makefile
+++ b/fs/zuf/Makefile
@@ -17,5 +17,6 @@ zuf-y += md.o t1.o t2.o
 zuf-y += zuf-core.o zuf-root.o
 
 # Main FS
+zuf-y += rw.o
 zuf-y += super.o inode.o directory.o namei.o file.o symlink.o
 zuf-y += module.o
diff --git a/fs/zuf/_extern.h b/fs/zuf/_extern.h
index 95413f65c47f..745d0cc9e719 100644
--- a/fs/zuf/_extern.h
+++ b/fs/zuf/_extern.h
@@ -43,6 +43,9 @@ int zufc_dispatch(struct zuf_root_info *zri, struct zufs_ioc_hdr *hdr,
 	zuf_dispatch_init(&zdo, hdr, pages, nump);
 	return __zufc_dispatch(zri, &zdo);
 }
+int zufc_pigy_put(struct zuf_root_info *zri, struct zuf_dispatch_op *zdo,
+		  struct zufs_ioc_IO *io, uint iom_n, ulong *bns, bool do_now);
+void zufc_goose_all_zts(struct zuf_root_info *zri, struct inode *inode);
 
 /* zuf-root.c */
 int zufr_register_fs(struct super_block *sb, struct zufs_ioc_register_fs *rfs);
@@ -92,6 +95,25 @@ int zuf_remove_dentry(struct inode *dir, struct qstr *str, struct inode *inode);
 uint zuf_prepare_symname(struct zufs_ioc_new_inode *ioc_new_inode,
 			const char *symname, ulong len, struct page *pages[2]);
 
+/* rw.c */
+int zuf_rw_read_page(struct zuf_sb_info *sbi, struct inode *inode,
+		     struct page *page, u64 filepos);
+ssize_t zuf_rw_read_iter(struct super_block *sb, struct inode *inode,
+			 struct kiocb *kiocb, struct iov_iter *ii);
+ssize_t zuf_rw_write_iter(struct super_block *sb, struct inode *inode,
+			  struct kiocb *kiocb, struct iov_iter *ii);
+int _zufs_IO_get_multy(struct zuf_sb_info *sbi, struct inode *inode,
+		       loff_t pos, ulong len, struct _io_gb_multy *io_gb);
+void _zufs_IO_put_multy(struct zuf_sb_info *sbi, struct inode *inode,
+			struct _io_gb_multy *io_gb);
+int zuf_rw_fallocate(struct inode *inode, uint mode, loff_t offset, loff_t len);
+int zuf_iom_execute_sync(struct super_block *sb, struct inode *inode,
+			 __u64 *iom_e, uint iom_n);
+int zuf_iom_execute_async(struct super_block *sb, struct zus_iomap_build *iomb,
+			 __u64 *iom_e_user, uint iom_n);
+int zuf_rw_file_range_compare(struct inode *i_in, loff_t pos_in,
+			      struct inode *i_out, loff_t pos_out, loff_t len);
+
 /* t1.c */
 int zuf_pmem_mmap(struct file *file, struct vm_area_struct *vma);
 
diff --git a/fs/zuf/file.c b/fs/zuf/file.c
index 619dada43666..8711b44371e0 100644
--- a/fs/zuf/file.c
+++ b/fs/zuf/file.c
@@ -13,6 +13,9 @@
  *	Sagi Manole <sagim@netapp.com>"
  */
 
+#include <linux/fs.h>
+#include <linux/uio.h>
+
 #include "zuf.h"
 
 long __zuf_fallocate(struct inode *inode, int mode, loff_t offset, loff_t len)
@@ -20,8 +23,78 @@ long __zuf_fallocate(struct inode *inode, int mode, loff_t offset, loff_t len)
 	return -ENOTSUPP;
 }
 
+static ssize_t zuf_read_iter(struct kiocb *kiocb, struct iov_iter *ii)
+{
+	struct inode *inode = file_inode(kiocb->ki_filp);
+	struct zuf_inode_info *zii = ZUII(inode);
+	ssize_t ret;
+
+	zuf_dbg_rw("[%ld] ppos=0x%llx len=0x%zx\n",
+		     inode->i_ino, kiocb->ki_pos, iov_iter_count(ii));
+
+	file_accessed(kiocb->ki_filp);
+
+	zuf_r_lock(zii);
+
+	ret = zuf_rw_read_iter(inode->i_sb, inode, kiocb, ii);
+
+	zuf_r_unlock(zii);
+
+	zuf_dbg_rw("[%ld] => 0x%lx\n", inode->i_ino, ret);
+	return ret;
+}
+
+static ssize_t zuf_write_iter(struct kiocb *kiocb, struct iov_iter *ii)
+{
+	struct inode *inode = file_inode(kiocb->ki_filp);
+	struct zuf_inode_info *zii = ZUII(inode);
+	ssize_t ret;
+	loff_t end_offset;
+
+	ret = generic_write_checks(kiocb, ii);
+	if (unlikely(ret < 0)) {
+		zuf_dbg_vfs("[%ld] generic_write_checks => 0x%lx\n",
+			    inode->i_ino, ret);
+		return ret;
+	}
+
+	zuf_r_lock(zii);
+
+	ret = file_remove_privs(kiocb->ki_filp);
+	if (unlikely(ret < 0))
+		goto out;
+
+	end_offset = kiocb->ki_pos + iov_iter_count(ii);
+	if (inode->i_size < end_offset) {
+		spin_lock(&inode->i_lock);
+		if (inode->i_size < end_offset) {
+			zii->zi->i_size = cpu_to_le64(end_offset);
+			i_size_write(inode, end_offset);
+		}
+		spin_unlock(&inode->i_lock);
+	}
+
+	zus_inode_cmtime_now(inode, zii->zi);
+
+	ret = zuf_rw_write_iter(inode->i_sb, inode, kiocb, ii);
+	if (unlikely(ret < 0)) {
+		/* TODO(sagi): do we want to truncate i_size? */
+		goto out;
+	}
+
+	inode->i_blocks = le64_to_cpu(zii->zi->i_blocks);
+
+out:
+	zuf_r_unlock(zii);
+
+	zuf_dbg_rw("[%ld] => 0x%lx\n", inode->i_ino, ret);
+	return ret;
+}
+
 const struct file_operations zuf_file_operations = {
 	.open			= generic_file_open,
+	.read_iter		= zuf_read_iter,
+	.write_iter		= zuf_write_iter,
 };
 
 const struct inode_operations zuf_file_inode_operations = {
diff --git a/fs/zuf/inode.c b/fs/zuf/inode.c
index bf3f8b27f918..27660979ed6f 100644
--- a/fs/zuf/inode.c
+++ b/fs/zuf/inode.c
@@ -287,6 +287,8 @@ void zuf_evict_inode(struct inode *inode)
 
 		zuf_w_lock(zii);
 
+		zufc_goose_all_zts(ZUF_ROOT(SBI(sb)), inode);
+
 		zuf_evict_dispatch(sb, zii->zus_ii, ZUFS_OP_FREE_INODE, 0);
 
 		inode->i_mtime = inode->i_ctime = current_time(inode);
@@ -298,6 +300,8 @@ void zuf_evict_inode(struct inode *inode)
 
 		zuf_smw_lock(zii);
 
+		zufc_goose_all_zts(ZUF_ROOT(SBI(sb)), inode);
+
 		zuf_evict_dispatch(sb, zii->zus_ii, ZUFS_OP_EVICT_INODE, 0);
 
 		zuf_smw_unlock(zii);
@@ -585,5 +589,14 @@ void zuf_set_inode_flags(struct inode *inode, struct zus_inode *zi)
 		inode_has_no_xattr(inode);
 }
 
+/* direct_IO is not called. We set an empty one so open(O_DIRECT) will be happy
+ */
+static ssize_t zuf_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
+{
+	WARN_ON(1);
+	return 0;
+}
+
 const struct address_space_operations zuf_aops = {
+	.direct_IO		= zuf_direct_IO,
 };
diff --git a/fs/zuf/rw.c b/fs/zuf/rw.c
new file mode 100644
index 000000000000..48f584e71a03
--- /dev/null
+++ b/fs/zuf/rw.c
@@ -0,0 +1,959 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BRIEF DESCRIPTION
+ *
+ * Read/Write operations.
+ *
+ * Copyright (c) 2018 NetApp Inc. All rights reserved.
+ *
+ * ZUFS-License: GPL-2.0. See module.c for LICENSE details.
+ *
+ * Authors:
+ *	Boaz Harrosh <boazh@netapp.com>
+ */
+#include <linux/fadvise.h>
+#include <linux/uio.h>
+#include <linux/delay.h>
+#include <asm/cacheflush.h>
+
+#include "zuf.h"
+#include "t2.h"
+
+#define	rand_tag(kiocb)	\
+	((kiocb->ki_filp->f_mode & FMODE_RANDOM) ? ZUFS_RW_RAND : 0)
+#define	kiocb_ra(kiocb)	(&kiocb->ki_filp->f_ra)
+
+static const char *_pr_rw(uint rw)
+{
+	return (rw & WRITE) ? "WRITE" : "READ";
+}
+
+static int _ioc_bounds_check(struct zufs_iomap *ziom,
+			     struct zufs_iomap *user_ziom, void *ziom_end)
+{
+	size_t iom_max_bytes = ziom_end - (void *)&user_ziom->iom_e;
+
+	if (unlikely((iom_max_bytes / sizeof(__u64) < ziom->iom_max))) {
+		zuf_err("kernel-buff-size(0x%zx) < ziom->iom_max(0x%x)\n",
+			(iom_max_bytes / sizeof(__u64)), ziom->iom_max);
+		return -EINVAL;
+	}
+
+	if (unlikely(ziom->iom_max < ziom->iom_n)) {
+		zuf_err("ziom->iom_max(0x%x) < ziom->iom_n(0x%x)\n",
+			ziom->iom_max, ziom->iom_n);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void _extract_gb_multy_bns(struct _io_gb_multy *io_gb,
+				  struct zufs_ioc_IO *io_user)
+{
+	uint i;
+
+	/* Return of some T1 pages from GET_MULTY */
+	io_gb->iom_n = 0;
+	for (i = 0; i < io_gb->IO.ziom.iom_n; ++i) {
+		ulong bn = _zufs_iom_t1_bn(io_user->iom_e[i]);
+
+		if (unlikely(bn == -1)) {
+			zuf_err("!!!!");
+			break;
+		}
+		io_gb->bns[io_gb->iom_n++] = bn;
+	}
+}
+
+static int rw_overflow_handler(struct zuf_dispatch_op *zdo, void *arg,
+			       ulong max_bytes)
+{
+	struct zufs_ioc_IO *io = container_of(zdo->hdr, typeof(*io), hdr);
+	struct zufs_ioc_IO *io_user = arg;
+	int err;
+
+	*io = *io_user;
+
+	err = _ioc_bounds_check(&io->ziom, &io_user->ziom, arg + max_bytes);
+	if (unlikely(err))
+		return err;
+
+	if ((io->hdr.err == -EZUFS_RETRY) &&
+	    io->ziom.iom_n && _zufs_iom_pop(io->iom_e)) {
+
+		zuf_dbg_rw(
+			"[%s]zuf_iom_execute_sync(%d) max=0x%lx iom_e[%d] => %d\n",
+			zuf_op_name(io->hdr.operation), io->ziom.iom_n,
+			max_bytes, _zufs_iom_opt_type(io_user->iom_e),
+			io->hdr.err);
+
+		io->hdr.err = zuf_iom_execute_sync(zdo->sb, zdo->inode,
+						   io_user->iom_e,
+						   io->ziom.iom_n);
+		return EZUF_RETRY_DONE;
+	}
+
+	/* No tier ups needed */
+
+	if (io->hdr.err == -EZUFS_RETRY) {
+		zuf_warn("ZUSfs violating API EZUFS_RETRY with no payload\n");
+		/* continue any way because we want to PUT all these GETs
+		 * we did. But the Server is buggy
+		 */
+		io->hdr.err = 0;
+	}
+
+	if (io->hdr.operation != ZUFS_OP_GET_MULTY)
+		return 0; /* We are finished */
+
+	/* ZUFS_OP_GET_MULTY Decoding at ZT context  */
+
+	if (io->ziom.iom_n) {
+		struct _io_gb_multy *io_gb =
+					container_of(io, typeof(*io_gb), IO);
+
+		zuf_dbg_rw("[%s] _extract_bns(%d) iom_e[0x%llx]\n",
+			   zuf_op_name(io->hdr.operation), io->ziom.iom_n,
+			   io_user->iom_e[0]);
+
+		if (unlikely(ZUS_API_MAP_MAX_PAGES < io->ziom.iom_n)) {
+			zuf_err("[%s] leaking T1 (%d) iom_e[0x%llx]\n",
+				zuf_op_name(io->hdr.operation), io->ziom.iom_n,
+				io_user->iom_e[0]);
+
+			io->ziom.iom_n = ZUS_API_MAP_MAX_PAGES;
+		}
+
+		_extract_gb_multy_bns(io_gb, io_user);
+	}
+
+	return 0;
+}
+
+static int _IO_dispatch(struct zuf_sb_info *sbi, struct zufs_ioc_IO *IO,
+			struct zuf_inode_info *zii, int operation,
+			uint pgoffset, struct page **pages, uint nump,
+			u64 filepos, uint len)
+{
+	struct zuf_dispatch_op zdo;
+	int err;
+
+	IO->hdr.operation = operation;
+	IO->hdr.in_len = sizeof(*IO);
+	IO->hdr.out_len = sizeof(*IO);
+	IO->hdr.offset = pgoffset;
+	IO->hdr.len = len;
+	IO->zus_ii = zii->zus_ii;
+	IO->filepos = filepos;
+
+	zuf_dispatch_init(&zdo, &IO->hdr, pages, nump);
+	zdo.oh = rw_overflow_handler;
+	zdo.sb = sbi->sb;
+	zdo.inode = &zii->vfs_inode;
+
+	zuf_dbg_verbose("[%ld][%s] fp=0x%llx nump=0x%x len=0x%x\n",
+			zdo.inode ? zdo.inode->i_ino : -1,
+			zuf_op_name(operation), filepos, nump, len);
+
+	err = __zufc_dispatch(ZUF_ROOT(sbi), &zdo);
+	if (unlikely(err == -EZUFS_RETRY)) {
+		zuf_err("Unexpected ZUS return => %d\n", err);
+		err = -EIO;
+	}
+	return err;
+}
+
+int zuf_rw_read_page(struct zuf_sb_info *sbi, struct inode *inode,
+		     struct page *page, u64 filepos)
+{
+	struct zufs_ioc_IO io = {};
+	struct page *pages[1];
+	uint nump;
+	int err;
+
+	pages[0] = page;
+	nump = 1;
+
+	err = _IO_dispatch(sbi, &io, ZUII(inode), ZUFS_OP_READ, 0, pages, nump,
+			   filepos, PAGE_SIZE);
+	return err;
+}
+
+
+/* return < 0 - is err. 0 compairs */
+int zuf_rw_file_range_compare(struct inode *i_in, loff_t pos_in,
+			      struct inode *i_out, loff_t pos_out, loff_t len)
+{
+	struct super_block *sb = i_in->i_sb;
+	ulong bs = sb->s_blocksize;
+	struct page *p_in, *p_out;
+	void *a_in, *a_out;
+	int err = 0;
+
+	if (unlikely((pos_in & (bs - 1)) || (pos_out & (bs - 1)) ||
+		     (bs != PAGE_SIZE))) {
+		zuf_err("[%ld]@0x%llx & [%ld]@0x%llx len=0x%llx bs=0x%lx\n",
+			   i_in->i_ino, pos_in, i_out->i_ino, pos_out, len, bs);
+		return -EINVAL;
+	}
+
+	zuf_dbg_rw("[%ld]@0x%llx & [%ld]@0x%llx len=0x%llx\n",
+		   i_in->i_ino, pos_in, i_out->i_ino, pos_out, len);
+
+	p_in = alloc_page(GFP_KERNEL);
+	p_out = alloc_page(GFP_KERNEL);
+	if (unlikely(!p_in || !p_out)) {
+		err = -ENOMEM;
+		goto out;
+	}
+	a_in = page_address(p_in);
+	a_out = page_address(p_out);
+
+	while (len) {
+		ulong l;
+
+		err = zuf_rw_read_page(SBI(sb), i_in, p_in, pos_in);
+		if (unlikely(err))
+			goto out;
+
+		err = zuf_rw_read_page(SBI(sb), i_out, p_out, pos_out);
+		if (unlikely(err))
+			goto out;
+
+		l = min_t(ulong, PAGE_SIZE, len);
+		if (memcmp(a_in, a_out, l)) {
+			err = -EBADE;
+			goto out;
+		}
+
+		pos_in += l;
+		pos_out += l;
+		len -= l;
+	}
+
+out:
+	__free_page(p_in);
+	__free_page(p_out);
+
+	return err;
+}
+
+/* ZERO a part of a single block. len does not cross a block boundary */
+int zuf_rw_fallocate(struct inode *inode, uint mode, loff_t pos, loff_t len)
+{
+	struct zufs_ioc_IO io = {};
+	int err;
+
+	io.last_pos = (len == ~0ULL) ? ~0ULL : pos + len;
+	io.rw = mode;
+
+	err = _IO_dispatch(SBI(inode->i_sb), &io, ZUII(inode),
+			   ZUFS_OP_FALLOCATE, 0, NULL, 0, pos, 0);
+	return err;
+
+}
+
+static struct page *_addr_to_page(unsigned long addr)
+{
+	const void *p = (const void *)addr;
+
+	return is_vmalloc_addr(p) ? vmalloc_to_page(p) : virt_to_page(p);
+}
+
+static ssize_t _iov_iter_get_pages_kvec(struct iov_iter *ii,
+		   struct page **pages, size_t maxsize, uint maxpages,
+		   size_t *start)
+{
+	ssize_t bytes;
+	size_t i, nump;
+	unsigned long addr = (unsigned long)ii->kvec->iov_base;
+
+	*start = addr & (PAGE_SIZE - 1);
+	bytes = min_t(ssize_t, iov_iter_single_seg_count(ii), maxsize);
+	nump = min_t(size_t, DIV_ROUND_UP(bytes + *start, PAGE_SIZE), maxpages);
+
+	/* TODO: FUSE assumes single page for ITER_KVEC. Boaz: Remove? */
+	WARN_ON(nump > 1);
+
+	for (i = 0; i < nump; ++i) {
+		pages[i] = _addr_to_page(addr + (i * PAGE_SIZE));
+
+		get_page(pages[i]);
+	}
+	return bytes;
+}
+
+static ssize_t _iov_iter_get_pages_any(struct iov_iter *ii,
+		   struct page **pages, size_t maxsize, uint maxpages,
+		   size_t *start)
+{
+	ssize_t bytes;
+
+	bytes = unlikely(ii->type & ITER_KVEC) ?
+		_iov_iter_get_pages_kvec(ii, pages, maxsize, maxpages, start) :
+		iov_iter_get_pages(ii, pages, maxsize, maxpages, start);
+
+	if (unlikely(bytes < 0))
+		zuf_dbg_err("[%d] bytes=%ld type=%d count=%lu",
+			smp_processor_id(), bytes, ii->type, ii->count);
+
+	return bytes;
+}
+
+static ssize_t _zufs_IO(struct zuf_sb_info *sbi, struct inode *inode,
+			void *on_stack, uint max_on_stack,
+			struct iov_iter *ii, struct kiocb *kiocb,
+			struct file_ra_state *ra, int operation, uint rw)
+{
+	int err = 0;
+	loff_t start_pos = kiocb->ki_pos;
+	loff_t pos = start_pos;
+	enum big_alloc_type bat;
+	struct page **pages;
+	uint max_pages = min_t(uint,
+			md_o2p_up(iov_iter_count(ii) + (pos & ~PAGE_MASK)),
+			ZUS_API_MAP_MAX_PAGES);
+
+	pages = big_alloc(max_pages * sizeof(*pages), max_on_stack, on_stack,
+			  GFP_NOFS, &bat);
+	if (unlikely(!pages)) {
+		zuf_err("Sigh on stack is best max_pages=%d\n", max_pages);
+		return -ENOMEM;
+	};
+
+	while (iov_iter_count(ii)) {
+		struct zufs_ioc_IO io = {};
+		uint nump;
+		ssize_t bytes;
+		size_t pgoffset;
+		uint i;
+
+		if (ra) {
+			io.ra.start	= ra->start;
+			io.ra.ra_pages	= ra->ra_pages;
+			io.ra.prev_pos	= ra->prev_pos;
+		}
+		io.rw = rw;
+
+		bytes = _iov_iter_get_pages_any(ii, pages,
+					ZUS_API_MAP_MAX_SIZE,
+					ZUS_API_MAP_MAX_PAGES, &pgoffset);
+		if (unlikely(bytes < 0)) {
+			err = bytes;
+			break;
+		}
+
+		nump = DIV_ROUND_UP(bytes + pgoffset, PAGE_SIZE);
+
+		io.last_pos = pos;
+		err = _IO_dispatch(sbi, &io, ZUII(inode), operation,
+				   pgoffset, pages, nump, pos, bytes);
+
+		bytes = io.last_pos - pos;
+
+		zuf_dbg_rw("[%ld]	%s [0x%llx-0x%zx]\n",
+			    inode->i_ino, _pr_rw(rw), pos, bytes);
+
+		iov_iter_advance(ii, bytes);
+		pos += bytes;
+
+		if (ra) {
+			ra->start	= io.ra.start;
+			ra->ra_pages	= io.ra.ra_pages;
+			ra->prev_pos	= io.ra.prev_pos;
+		}
+		if (io.wr_unmap.len)
+			unmap_mapping_range(inode->i_mapping,
+					    io.wr_unmap.offset,
+					    io.wr_unmap.len, 0);
+
+		for (i = 0; i < nump; ++i)
+			put_page(pages[i]);
+
+		if (unlikely(err))
+			break;
+	}
+
+	big_free(pages, bat);
+
+	if (unlikely(pos == start_pos))
+		return err;
+
+	kiocb->ki_pos = pos;
+	return pos - start_pos;
+}
+
+int _zufs_IO_get_multy(struct zuf_sb_info *sbi, struct inode *inode,
+		       loff_t pos, ulong len, struct _io_gb_multy *io_gb)
+{
+	struct zufs_ioc_IO *IO = &io_gb->IO;
+	int err;
+
+	IO->hdr.operation = ZUFS_OP_GET_MULTY;
+	IO->hdr.in_len = sizeof(*IO);
+	IO->hdr.out_len = sizeof(*IO);
+	IO->hdr.len = len;
+	IO->zus_ii = ZUII(inode)->zus_ii;
+	IO->filepos = pos;
+	IO->last_pos = pos;
+
+	zuf_dispatch_init(&io_gb->zdo, &IO->hdr, NULL, 0);
+	io_gb->zdo.oh = rw_overflow_handler;
+	io_gb->zdo.sb = sbi->sb;
+	io_gb->zdo.inode = inode;
+	io_gb->zdo.bns = io_gb->bns;
+
+
+	err = __zufc_dispatch(ZUF_ROOT(sbi), &io_gb->zdo);
+	if (unlikely(err == -EZUFS_RETRY)) {
+		zuf_err("Unexpected ZUS return => %d\n", err);
+		err = -EIO;
+	}
+
+	if (unlikely(err)) {
+		/* err from Server means no contract and NO bns locked
+		 * so no puts
+		 */
+		if ((err != -ENOSPC) && (err != -EIO) && (err != -EINTR))
+			zuf_warn("At this early stage show me %d\n", err);
+		if (io_gb->IO.ziom.iom_n)
+			zuf_err("Server Smoking iom_n=%u err=%d\n",
+				io_gb->IO.ziom.iom_n, err);
+		zuf_dbg_err("_IO_dispatch => %d\n", err);
+		return err;
+	}
+	if (unlikely(!io_gb->iom_n)) {
+		if (!io_gb->IO.ziom.iom_n) {
+			zuf_err("WANT tO SEE => %d\n", err);
+			return err;
+		}
+
+		_extract_gb_multy_bns(io_gb, &io_gb->IO);
+		if (unlikely(!io_gb->iom_n)) {
+			zuf_err("WHAT ????\n");
+			return err;
+		}
+	}
+	/* Even if _IO_dispatch returned a theoretical error but also some
+	 * pages, we do the few pages and do an OP_PUT_MULTY (error ignored)
+	 */
+	return 0;
+}
+
+void _zufs_IO_put_multy(struct zuf_sb_info *sbi, struct inode *inode,
+			struct _io_gb_multy *io_gb)
+{
+	bool put_now;
+	int err;
+
+	put_now = io_gb->IO.ret_flags &
+		  (ZUFS_RET_PUT_NOW | ZUFS_RET_NEW | ZUFS_RET_LOCKED_PUT);
+
+	err  = zufc_pigy_put(ZUF_ROOT(sbi), &io_gb->zdo, &io_gb->IO,
+			     io_gb->iom_n, io_gb->bns, put_now);
+	if (unlikely(err))
+		zuf_warn("zufc_pigy_put => %d\n", err);
+}
+
+static inline int _read_one(struct zuf_sb_info *sbi, struct iov_iter *ii,
+			     ulong bn, uint offset, uint len, int i)
+{
+	uint retl;
+
+	if (!bn) {
+		retl = iov_iter_zero(len, ii);
+	} else {
+		void *addr = md_addr_verify(sbi->md, md_p2o(bn));
+
+		if (unlikely(!addr)) {
+			zuf_err("Server bad bn[%d]=0x%lx bytes_more=0x%lx\n",
+				i, bn, iov_iter_count(ii));
+			return -EIO;
+		}
+		retl = copy_to_iter(addr + offset, len, ii);
+	}
+	if (unlikely(retl != len)) {
+		/* This can happen if we get a read_only Prt from App */
+		zuf_dbg_err("copy_to_iter bn=0x%lx off=0x%x len=0x%x retl=0x%x\n",
+			bn, offset, len, retl);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static inline int _write_one(struct zuf_sb_info *sbi, struct iov_iter *ii,
+			     ulong bn, uint offset, uint len, int i)
+{
+	void *addr = md_addr_verify(sbi->md, md_p2o(bn));
+	uint retl;
+
+	if (unlikely(!addr)) {
+		zuf_err("Server bad page[%d] bn=0x%lx bytes_more=0x%lx\n",
+			i, bn, iov_iter_count(ii));
+		return -EIO;
+	}
+
+	retl = _copy_from_iter_flushcache(addr + offset, len, ii);
+	if (unlikely(retl != len)) {
+		/* FIXME: This can happen if we get a read_only Prt from App */
+		zuf_err("copy_to_iter bn=0x%lx off=0x%x len=0x%x retl=0x%x\n",
+			bn, offset, len, retl);
+		return -EFAULT;
+	}
+	return 0;
+}
+
+static ssize_t _IO_gm_inner(struct zuf_sb_info *sbi, struct inode *inode,
+			    ulong *bns, uint max_bns,
+			    struct iov_iter *ii, struct file_ra_state *ra,
+			    loff_t start, uint rw)
+{
+	loff_t pos = start;
+	uint offset = pos & (PAGE_SIZE - 1);
+	struct _io_gb_multy io_gb = { .bns = bns, };
+	ssize_t size;
+	int err;
+	uint i;
+
+	if (ra) {
+		io_gb.IO.ra.start	= ra->start;
+		io_gb.IO.ra.ra_pages	= ra->ra_pages;
+		io_gb.IO.ra.prev_pos	= ra->prev_pos;
+	}
+	io_gb.IO.rw = rw;
+
+	size = min_t(ssize_t, ZUS_API_MAP_MAX_SIZE - offset,
+		     iov_iter_count(ii));
+	err = _zufs_IO_get_multy(sbi, inode, pos, size, &io_gb);
+	if (unlikely(err))
+		return err;
+
+	if (ra) {
+		ra->start	= io_gb.IO.ra.start;
+		ra->ra_pages	= io_gb.IO.ra.ra_pages;
+		ra->prev_pos	= io_gb.IO.ra.prev_pos;
+	}
+
+	if (unlikely(io_gb.IO.last_pos != (pos + size))) {
+		if (unlikely(io_gb.IO.last_pos < pos)) {
+			zuf_err("Server bad last_pos(0x%llx) <= pos(0x%llx) len=0x%lx\n",
+				 io_gb.IO.last_pos, pos, iov_iter_count(ii));
+			err = -EIO;
+			goto out;
+		}
+
+		zuf_dbg_err("Short %s start(0x%llx) len=0x%lx last_pos(0x%llx)\n",
+			    _pr_rw(rw), pos, iov_iter_count(ii),
+			    io_gb.IO.last_pos);
+		size = io_gb.IO.last_pos - pos;
+	}
+
+	i = 0;
+	while (size) {
+		uint len;
+		ulong bn;
+
+		len = min_t(uint, PAGE_SIZE - offset, size);
+
+		bn = io_gb.bns[i];
+		if (rw & WRITE)
+			err = _write_one(sbi, ii, bn, offset, len, i);
+		else
+			err = _read_one(sbi, ii, bn, offset, len, i);
+		if (unlikely(err))
+			break;
+
+		zuf_dbg_rw("[%ld]	%s [0x%llx-0x%x] bn=0x%lx [%d]\n",
+			    inode->i_ino, _pr_rw(rw), pos, len, bn, i);
+
+		pos += len;
+		size -= len;
+		offset = 0;
+		if (io_gb.iom_n <= ++i)
+			break;
+	}
+out:
+	_zufs_IO_put_multy(sbi, inode, &io_gb);
+	if (io_gb.IO.wr_unmap.len)
+		unmap_mapping_range(inode->i_mapping, io_gb.IO.wr_unmap.offset,
+				    io_gb.IO.wr_unmap.len, 0);
+
+	return unlikely(pos == start) ? err : pos - start;
+}
+
+static ssize_t _IO_gm(struct zuf_sb_info *sbi, struct inode *inode,
+		      ulong *on_stack, uint max_on_stack,
+		      struct iov_iter *ii, struct kiocb *kiocb,
+		      struct file_ra_state *ra, uint rw)
+{
+	ssize_t size = 0;
+	ssize_t ret = 0;
+	enum big_alloc_type bat;
+	ulong *bns;
+	uint max_bns = min_t(uint,
+		md_o2p_up(iov_iter_count(ii) + (kiocb->ki_pos & ~PAGE_MASK)),
+		ZUS_API_MAP_MAX_PAGES);
+
+	bns = big_alloc(max_bns * sizeof(ulong), max_on_stack, on_stack,
+			GFP_NOFS, &bat);
+	if (unlikely(!bns)) {
+		zuf_err("life was more simple on the stack max_bns=%d\n",
+			max_bns);
+		return -ENOMEM;
+	}
+
+	while (iov_iter_count(ii)) {
+		ret = _IO_gm_inner(sbi, inode, bns, max_bns, ii, ra,
+				   kiocb->ki_pos, rw);
+		if (unlikely(ret < 0))
+			break;
+
+		kiocb->ki_pos += ret;
+		size += ret;
+	}
+
+	big_free(bns, bat);
+
+	return size ?: ret;
+}
+
+ssize_t zuf_rw_read_iter(struct super_block *sb, struct inode *inode,
+			 struct kiocb *kiocb, struct iov_iter *ii)
+{
+	long on_stack[ZUF_MAX_STACK(8) / sizeof(long)];
+	ulong rw = READ | rand_tag(kiocb);
+
+	/* EOF protection */
+	if (unlikely(kiocb->ki_pos > i_size_read(inode)))
+		return 0;
+
+	iov_iter_truncate(ii, i_size_read(inode) - kiocb->ki_pos);
+	if (unlikely(!iov_iter_count(ii))) {
+		/* Don't let zero len reads have any effect */
+		zuf_dbg_rw("called with NULL len\n");
+		return 0;
+	}
+
+	if (zuf_is_nio_reads(inode))
+		return _IO_gm(SBI(sb), inode, on_stack, sizeof(on_stack),
+			      ii, kiocb, kiocb_ra(kiocb), rw);
+
+	return _zufs_IO(SBI(sb), inode, on_stack, sizeof(on_stack), ii,
+			kiocb, kiocb_ra(kiocb), ZUFS_OP_READ, rw);
+}
+
+ssize_t zuf_rw_write_iter(struct super_block *sb, struct inode *inode,
+			  struct kiocb *kiocb, struct iov_iter *ii)
+{
+	long on_stack[ZUF_MAX_STACK(8) / sizeof(long)];
+	ulong rw = WRITE;
+
+	if (kiocb->ki_filp->f_flags & O_DSYNC ||
+	    IS_SYNC(kiocb->ki_filp->f_mapping->host))
+		rw |= ZUFS_RW_DSYNC;
+	if (kiocb->ki_filp->f_flags & O_DIRECT)
+		rw |= ZUFS_RW_DIRECT;
+
+	if (zuf_is_nio_writes(inode))
+		return _IO_gm(SBI(sb), inode, on_stack, sizeof(on_stack),
+			      ii, kiocb, kiocb_ra(kiocb), rw);
+
+	return _zufs_IO(SBI(sb), inode, on_stack, sizeof(on_stack),
+			ii, kiocb, kiocb_ra(kiocb), ZUFS_OP_WRITE, rw);
+}
+
+/* ~~~~ iom_dec.c ~~~ */
+/* for now here (at rw.c) looks logical */
+
+static int __iom_add_t2_io_len(struct super_block *sb, struct t2_io_state *tis,
+			       zu_dpp_t t1, ulong t2_bn, __u64 num_pages)
+{
+	void *ptr;
+	struct page *page;
+	int i, err;
+
+	ptr = zuf_dpp_t_addr(sb, t1);
+	if (unlikely(!ptr)) {
+		zuf_err("Bad t1 zu_dpp_t t1=0x%llx t2=0x%lx num_pages=0x%llx\n",
+			t1, t2_bn, num_pages);
+		return -EFAULT; /* zuf_dpp_t_addr already yeld */
+	}
+
+	page = virt_to_page(ptr);
+	if (unlikely(!page)) {
+		zuf_err("bad t1(0x%llx)\n", t1);
+		return -EFAULT;
+	}
+
+	for (i = 0; i < num_pages; ++i) {
+		err = t2_io_add(tis, t2_bn++, page++);
+		if (unlikely(err))
+			return err;
+	}
+	return 0;
+}
+
+static int iom_add_t2_io_len(struct super_block *sb, struct t2_io_state *tis,
+			     __u64 **cur_e)
+{
+	struct zufs_iom_t2_io_len *t2iol = (void *)*cur_e;
+	int err = __iom_add_t2_io_len(sb, tis, t2iol->iom.t1_val,
+				      _zufs_iom_first_val(&t2iol->iom.t2_val),
+				      t2iol->num_pages);
+
+	*cur_e = (void *)(t2iol + 1);
+	return err;
+}
+
+static int iom_add_t2_io(struct super_block *sb, struct t2_io_state *tis,
+			 __u64 **cur_e)
+{
+	struct zufs_iom_t2_io *t2io = (void *)*cur_e;
+
+	int err = __iom_add_t2_io_len(sb, tis, t2io->t1_val,
+				      _zufs_iom_first_val(&t2io->t2_val), 1);
+
+	*cur_e = (void *)(t2io + 1);
+	return err;
+}
+
+static int iom_t2_zusmem_io(struct super_block *sb, struct t2_io_state *tis,
+			    __u64 **cur_e)
+{
+	struct zufs_iom_t2_zusmem_io *mem_io = (void *)*cur_e;
+	ulong t2_bn = _zufs_iom_first_val(&mem_io->t2_val);
+	ulong user_ptr = (ulong)mem_io->zus_mem_ptr;
+	int rw = _zufs_iom_opt_type(*cur_e) == IOM_T2_ZUSMEM_WRITE ?
+						WRITE : READ;
+	int num_p = md_o2p_up(mem_io->len);
+	int num_p_r;
+	struct page *pages[16];
+	int i, err = 0;
+
+	if (16 < num_p) {
+		zuf_err("num_p(%d) > 16\n", num_p);
+		return -EINVAL;
+	}
+
+	num_p_r = get_user_pages_fast(user_ptr, num_p, rw,
+				      pages);
+	if (num_p_r != num_p) {
+		zuf_err("!!!! get_user_pages_fast num_p_r(%d) != num_p(%d)\n",
+			num_p_r, num_p);
+		err = -EFAULT;
+		goto out;
+	}
+
+	for (i = 0; i < num_p_r && !err; ++i)
+		err = t2_io_add(tis, t2_bn++, pages[i]);
+
+out:
+	for (i = 0; i < num_p_r; ++i)
+		put_page(pages[i]);
+
+	*cur_e = (void *)(mem_io + 1);
+	return err;
+}
+
+static int iom_unmap(struct super_block *sb, struct inode *inode, __u64 **cur_e)
+{
+	struct zufs_iom_unmap *iom_unmap = (void *)*cur_e;
+	struct inode *inode_look = NULL;
+	ulong	unmap_index = _zufs_iom_first_val(&iom_unmap->unmap_index);
+	ulong	unmap_n = iom_unmap->unmap_n;
+	ulong	ino = iom_unmap->ino;
+
+	if (!inode || ino) {
+		if (WARN_ON(!ino)) {
+			zuf_err("[%ld] 0x%lx-0x%lx\n",
+				inode ? inode->i_ino : -1, unmap_index,
+				unmap_n);
+			goto out;
+		}
+		inode_look = ilookup(sb, ino);
+		if (!inode_look) {
+			/* From the time we requested an unmap to now
+			 * inode was evicted from cache so surely it no longer
+			 * have any mappings. Cool job was already done for us.
+			 * Even if a racing thread reloads the inode it will
+			 * not have this mapping we wanted to clear, but only
+			 * new ones.
+			 * TODO: For now warn when this happen, because in
+			 *    current usage it cannot happen. But before
+			 *    upstream we should convert to zuf_dbg_err
+			 */
+			zuf_warn("[%ld] 0x%lx-0x%lx\n",
+				 ino, unmap_index, unmap_n);
+			goto out;
+		}
+
+		inode = inode_look;
+	}
+
+	zuf_dbg_rw("[%ld] 0x%lx-0x%lx\n", inode->i_ino, unmap_index, unmap_n);
+
+	unmap_mapping_range(inode->i_mapping, md_p2o(unmap_index),
+			    md_p2o(unmap_n), 0);
+
+	if (inode_look)
+		iput(inode_look);
+
+out:
+	*cur_e = (void *)(iom_unmap + 1);
+	return 0;
+}
+
+static int iom_wbinv(__u64 **cur_e)
+{
+	wbinvd();
+
+	++*cur_e;
+
+	return 0;
+}
+
+struct _iom_exec_info {
+	struct super_block *sb;
+	struct inode *inode;
+	struct t2_io_state *rd_tis;
+	struct t2_io_state *wr_tis;
+	__u64 *iom_e;
+	uint iom_n;
+	bool print;
+};
+
+static int _iom_execute_inline(struct _iom_exec_info *iei)
+{
+	__u64 *cur_e, *end_e;
+	int err = 0;
+#ifdef CONFIG_ZUF_DEBUG
+	uint wrs = 0;
+	uint rds = 0;
+	uint uns = 0;
+	uint wrmem = 0;
+	uint rdmem = 0;
+	uint wbinv = 0;
+#	define	WRS()	(++wrs)
+#	define	RDS()	(++rds)
+#	define	UNS()	(++uns)
+#	define	WRMEM()	(++wrmem)
+#	define	RDMEM()	(++rdmem)
+#	define	WBINV()	(++wbinv)
+#else
+#	define	WRS()
+#	define	RDS()
+#	define	UNS()
+#	define	WRMEM()
+#	define	RDMEM()
+#	define	WBINV()
+#endif /* !def CONFIG_ZUF_DEBUG */
+
+	cur_e =  iei->iom_e;
+	end_e = cur_e + iei->iom_n;
+	while (cur_e && (cur_e < end_e)) {
+		uint op;
+
+		op = _zufs_iom_opt_type(cur_e);
+
+		switch (op) {
+		case IOM_NONE:
+			return 0;
+
+		case IOM_T2_WRITE:
+			err = iom_add_t2_io(iei->sb, iei->wr_tis, &cur_e);
+			WRS();
+			break;
+		case IOM_T2_READ:
+			err = iom_add_t2_io(iei->sb, iei->rd_tis, &cur_e);
+			RDS();
+			break;
+
+		case IOM_T2_WRITE_LEN:
+			err = iom_add_t2_io_len(iei->sb, iei->wr_tis, &cur_e);
+			WRS();
+			break;
+		case IOM_T2_READ_LEN:
+			err = iom_add_t2_io_len(iei->sb, iei->rd_tis, &cur_e);
+			RDS();
+			break;
+
+		case IOM_T2_ZUSMEM_WRITE:
+			err = iom_t2_zusmem_io(iei->sb, iei->wr_tis, &cur_e);
+			WRMEM();
+			break;
+		case IOM_T2_ZUSMEM_READ:
+			err = iom_t2_zusmem_io(iei->sb, iei->rd_tis, &cur_e);
+			RDMEM();
+			break;
+
+		case IOM_UNMAP:
+			err = iom_unmap(iei->sb, iei->inode, &cur_e);
+			UNS();
+			break;
+
+		case IOM_WBINV:
+			err = iom_wbinv(&cur_e);
+			WBINV();
+			break;
+
+		default:
+			zuf_err("!!!!! Bad opt %d\n",
+				_zufs_iom_opt_type(cur_e));
+			err = -EIO;
+			break;
+		}
+
+		if (unlikely(err))
+			break;
+	}
+
+#ifdef CONFIG_ZUF_DEBUG
+	zuf_dbg_rw("exec wrs=%d rds=%d uns=%d rdmem=%d wrmem=%d => %d\n",
+		   wrs, rds, uns, rdmem, wrmem, err);
+#endif
+
+	return err;
+}
+
+/* inode here is the default inode if ioc_unmap->ino is zero
+ * this is an optimization for the unmap done at write_iter hot path.
+ */
+int zuf_iom_execute_sync(struct super_block *sb, struct inode *inode,
+			 __u64 *iom_e_user, uint iom_n)
+{
+	struct zuf_sb_info *sbi = SBI(sb);
+	struct t2_io_state rd_tis = {};
+	struct t2_io_state wr_tis = {};
+	struct _iom_exec_info iei = {};
+	int err, err_r, err_w;
+
+	t2_io_begin(sbi->md, READ, NULL, 0, -1, &rd_tis);
+	t2_io_begin(sbi->md, WRITE, NULL, 0, -1, &wr_tis);
+
+	iei.sb = sb;
+	iei.inode = inode;
+	iei.rd_tis = &rd_tis;
+	iei.wr_tis = &wr_tis;
+	iei.iom_e = iom_e_user;
+	iei.iom_n = iom_n;
+	iei.print = 0;
+
+	err = _iom_execute_inline(&iei);
+
+	err_r = t2_io_end(&rd_tis, true);
+	err_w = t2_io_end(&wr_tis, true);
+
+	/* TODO: not sure if OK when _iom_execute return with -ENOMEM
+	 * In such a case, we might be better of skiping t2_io_ends.
+	 */
+	return err ?: (err_r ?: err_w);
+}
+
+int zuf_iom_execute_async(struct super_block *sb, struct zus_iomap_build *iomb,
+			 __u64 *iom_e_user, uint iom_n)
+{
+	zuf_err("Async IOM NOT supported Yet!!!\n");
+	return -EFAULT;
+}
diff --git a/fs/zuf/zuf-core.c b/fs/zuf/zuf-core.c
index c0049c1d5ba3..11300fd79929 100644
--- a/fs/zuf/zuf-core.c
+++ b/fs/zuf/zuf-core.c
@@ -25,6 +25,20 @@
 #include "relay.h"
 
 enum { INITIAL_ZT_CHANNELS = 3 };
+#define _ZT_MAX_PIGY_PUT \
+	((ZUS_API_MAP_MAX_PAGES * sizeof(__u64) + \
+	  sizeof(struct zufs_ioc_IO)) * INITIAL_ZT_CHANNELS)
+
+enum { PG0 = 0, PG1 = 1, PG2 = 2, PG3 = 3, PG4 = 4, PG5 = 5 };
+struct __pigi_put_it {
+	void *buff;
+	void *waiter;
+	uint s; /* total encoded bytes */
+	uint last; /* So we can update last zufs_ioc_hdr->flags */
+	bool needs_goosing;
+	ulong inodes[PG5 + 1];
+	uint ic;
+};
 
 struct zufc_thread {
 	struct zuf_special_file hdr;
@@ -40,6 +54,12 @@ struct zufc_thread {
 
 	/* Next operation*/
 	struct zuf_dispatch_op *zdo;
+
+	/* Secondary chans point to the 0-channel's
+	 * pigi_put_chan0
+	 */
+	struct __pigi_put_it pigi_put_chan0;
+	struct __pigi_put_it *pigi_put;
 };
 
 struct zuf_threads_pool {
@@ -76,7 +96,14 @@ const char *zuf_op_name(enum e_zufs_operation op)
 		CASE_ENUM_NAME(ZUFS_OP_RENAME);
 		CASE_ENUM_NAME(ZUFS_OP_READDIR);
 
+		CASE_ENUM_NAME(ZUFS_OP_READ);
+		CASE_ENUM_NAME(ZUFS_OP_PRE_READ);
+		CASE_ENUM_NAME(ZUFS_OP_WRITE);
 		CASE_ENUM_NAME(ZUFS_OP_SETATTR);
+
+		CASE_ENUM_NAME(ZUFS_OP_GET_MULTY);
+		CASE_ENUM_NAME(ZUFS_OP_PUT_MULTY);
+		CASE_ENUM_NAME(ZUFS_OP_NOOP);
 	case ZUFS_OP_MAX_OPT:
 	default:
 		return "UNKNOWN";
@@ -543,6 +570,238 @@ static void _prep_header_size_op(struct zufs_ioc_hdr *hdr,
 	hdr->err = err;
 }
 
+/* ~~~~~ pigi_put logic ~~~~~ */
+struct _goose_waiter {
+	struct kref kref;
+	struct zuf_root_info *zri;
+	ulong inode; /* We use the inode address as a unique tag */
+};
+
+static void _last_goose(struct kref *kref)
+{
+	struct _goose_waiter *gw = container_of(kref, typeof(*gw), kref);
+
+	wake_up_var(&gw->kref);
+}
+
+static void _goose_put(struct _goose_waiter *gw)
+{
+	kref_put(&gw->kref, _last_goose);
+}
+
+static void _goose_get(struct _goose_waiter *gw)
+{
+	kref_get(&gw->kref);
+}
+
+static void _goose_wait(struct _goose_waiter *gw)
+{
+	wait_var_event(&gw->kref, !kref_read(&gw->kref));
+}
+
+static void _pigy_put_encode(struct zufs_ioc_IO *io,
+			     struct zufs_ioc_IO *io_user, ulong *bns)
+{
+	uint i;
+
+	*io_user = *io;
+	for (i = 0; i < io->ziom.iom_n; ++i)
+		_zufs_iom_enc_bn(&io_user->ziom.iom_e[i], bns[i], 0);
+
+	io_user->hdr.in_len = _ioc_IO_size(io->ziom.iom_n);
+}
+
+static void pigy_put_dh(struct zuf_dispatch_op *zdo, void *pzt, void *parg)
+{
+	struct zufs_ioc_IO *io = container_of(zdo->hdr, typeof(*io), hdr);
+	struct zufs_ioc_IO *io_user = parg;
+
+	_pigy_put_encode(io, io_user, zdo->bns);
+}
+
+static int _pigy_put_now(struct zuf_root_info *zri, struct zuf_dispatch_op *zdo)
+{
+	int err;
+
+	zdo->dh = pigy_put_dh;
+
+	err = __zufc_dispatch(zri, zdo);
+	if (unlikely(err == -EZUFS_RETRY)) {
+		zuf_err("Unexpected ZUS return => %d\n", err);
+		err = -EIO;
+	}
+	return err;
+}
+
+int zufc_pigy_put(struct zuf_root_info *zri, struct zuf_dispatch_op *zdo,
+		  struct zufs_ioc_IO *io, uint iom_n, ulong *bns, bool do_now)
+{
+	struct zufc_thread *zt;
+	struct zufs_ioc_IO *io_user;
+	uint pigi_put_s;
+	int cpu;
+
+	io->hdr.operation = ZUFS_OP_PUT_MULTY;
+	io->hdr.out_len = 0;		/* No returns from put */
+	io->ret_flags = 0;
+	io->ziom.iom_n = iom_n;
+	zdo->bns = bns;
+
+	pigi_put_s = _ioc_IO_size(iom_n);
+
+	/* FIXME: Pedantic check remove please */
+	if (WARN_ON(zdo->__locked_zt && !do_now))
+		do_now = true;
+
+	cpu = get_cpu();
+
+	zt = _zt_from_cpu(zri, cpu, 0);
+	if (do_now || (zt->pigi_put->s + pigi_put_s > _ZT_MAX_PIGY_PUT) ||
+	    (zt->pigi_put->ic > PG5)) {
+		put_cpu();
+
+		/* NOTE: pigy_put buffer is full, We dispatch a put NOW
+		 * which will also take with it the full pigy_put buffer.
+		 * At the server the pigy_put will be done first then this
+		 * one, so order of puts is preserved, not that it matters
+		 */
+		if (!do_now)
+			zuf_dbg_perf(
+				"[%ld] iom_n=0x%x zt->pigi_put->s=0x%x + 0x%x > 0x%lx ic=%d\n",
+				zdo->inode->i_ino, iom_n, zt->pigi_put->s,
+				pigi_put_s, _ZT_MAX_PIGY_PUT,
+				zt->pigi_put->ic++);
+
+		return _pigy_put_now(zri, zdo);
+	}
+
+	/* Mark last one as has more */
+	if (zt->pigi_put->s) {
+		io_user = zt->pigi_put->buff + zt->pigi_put->last;
+		io_user->hdr.flags |= ZUFS_H_HAS_PIGY_PUT;
+	}
+
+	io_user = zt->pigi_put->buff + zt->pigi_put->s;
+	_pigy_put_encode(io, io_user, bns);
+	zt->pigi_put->last = zt->pigi_put->s;
+	zt->pigi_put->s += pigi_put_s;
+	zt->pigi_put->inodes[zt->pigi_put->ic++] = (ulong)zdo->inode;
+
+	put_cpu();
+	return 0;
+}
+
+/* Add the pigy_put accumulated buff to current command
+ * Always runs in the context of a ZT
+ */
+static void _pigy_put_add_to_ioc(struct zuf_root_info *zri,
+				 struct zufc_thread *zt)
+{
+	struct zufs_ioc_hdr *hdr = zt->opt_buff;
+	struct __pigi_put_it *pigi = zt->pigi_put;
+
+	if (unlikely(!pigi->s))
+		return;
+
+	if (unlikely(pigi->s + hdr->in_len > zt->max_zt_command)) {
+		zuf_err("!!! Should not pigi_put->s(%d) + in_len(%d) > max_zt_command(%ld)\n",
+			pigi->s, hdr->in_len, zt->max_zt_command);
+		/*TODO we must check at init time that max_zt_command not too
+		 * small
+		 */
+		return;
+	}
+
+	memcpy((void *)hdr + hdr->in_len, pigi->buff, pigi->s);
+	hdr->flags |= ZUFS_H_HAS_PIGY_PUT;
+	pigi->s = pigi->last = 0;
+	pigi->ic = 0;
+	/* for every 3 channels */
+	pigi->inodes[PG0] = pigi->inodes[PG1] = pigi->inodes[PG2] = 0;
+	pigi->inodes[PG3] = pigi->inodes[PG4] = pigi->inodes[PG5] = 0;
+}
+
+static void _goose_prep(struct zuf_root_info *zri,
+			struct zufc_thread *zt)
+{
+	_prep_header_size_op(zt->opt_buff, ZUFS_OP_NOOP, 0);
+	_pigy_put_add_to_ioc(zri, zt);
+
+	zt->pigi_put->needs_goosing = false;
+}
+
+static inline bool _zt_pigi_has_inode(struct __pigi_put_it *pigi,
+				      ulong inode)
+{
+	return	pigi->ic &&
+		((pigi->inodes[PG0] == inode) ||
+		 (pigi->inodes[PG1] == inode) ||
+		 (pigi->inodes[PG2] == inode) ||
+		 (pigi->inodes[PG3] == inode) ||
+		 (pigi->inodes[PG4] == inode) ||
+		 (pigi->inodes[PG5] == inode));
+}
+
+static void _goose_one(void *info)
+{
+	struct _goose_waiter *gw = info;
+	struct zuf_root_info *zri = gw->zri;
+	struct zufc_thread *zt;
+	int cpu = smp_processor_id();
+	uint c;
+
+	/* Look for least busy channel. All busy we are left with zt0 */
+	for (c = INITIAL_ZT_CHANNELS; c; --c) {
+		zt = _zt_from_cpu(zri, cpu, c - 1);
+		if (unlikely(!(zt && zt->hdr.file)))
+			return; /* We are crashing */
+
+		if (!zt->pigi_put->s || zt->pigi_put->needs_goosing)
+			return; /* this cpu is goose empty */
+
+		if (!_zt_pigi_has_inode(zt->pigi_put, gw->inode))
+			return;
+		if (!zt->zdo)
+			break;
+	}
+
+	/* Tell them to ... */
+	zt->pigi_put->needs_goosing = true;
+	_goose_get(gw);
+	zt->pigi_put->waiter = gw;
+	if (!zt->zdo)
+		relay_fss_wakeup(&zt->relay);
+}
+
+/* NOTE: @inode must not be NULL */
+void zufc_goose_all_zts(struct zuf_root_info *zri, struct inode *inode)
+{
+	struct _goose_waiter gw;
+
+	if (!S_ISREG(inode->i_mode) || !(inode->i_size || inode->i_blocks))
+		return;
+
+	/* No point in two goosers fighting we are goosing for everyone
+	 * This protects that only one zt->pigi_put->waiter at a time
+	 */
+	mutex_lock(&zri->sbl_lock);
+
+	gw.zri = zri;
+	kref_init(&gw.kref);
+	gw.inode = (ulong)inode;
+
+	on_each_cpu(_goose_one, &gw, true);
+
+	if (kref_read(&gw.kref) == 1)
+		goto out;
+
+	_goose_put(&gw); /* put kref_init's 1 */
+	_goose_wait(&gw);
+
+out:
+	mutex_unlock(&zri->sbl_lock);
+}
+
 /* ~~~~~ ZT thread operations ~~~~~ */
 
 static int _zu_init(struct file *file, void *parg)
@@ -591,6 +850,24 @@ static int _zu_init(struct file *file, void *parg)
 		goto out;
 	}
 
+	if (zt->chan == 0) {
+		zt->pigi_put = &zt->pigi_put_chan0;
+
+		zt->pigi_put->buff = vmalloc(_ZT_MAX_PIGY_PUT);
+		if (unlikely(!zt->pigi_put->buff)) {
+			vfree(zt->opt_buff);
+			zi_init.hdr.err = -ENOMEM;
+			goto out;
+		}
+		zt->pigi_put->needs_goosing = false;
+		zt->pigi_put->last = zt->pigi_put->s = 0;
+	} else {
+		struct zufc_thread *zt0;
+
+		zt0 = _zt_from_cpu(ZRI(file->f_inode->i_sb), cpu, 0);
+		zt->pigi_put = &zt0->pigi_put_chan0;
+	}
+
 	file->private_data = &zt->hdr;
 out:
 	err = copy_to_user(parg, &zi_init, sizeof(zi_init));
@@ -625,6 +902,9 @@ static void zufc_zt_release(struct file *file)
 		msleep(1000); /* crap */
 	}
 
+	if (zt->chan == 0)
+		vfree(zt->pigi_put->buff);
+
 	vfree(zt->opt_buff);
 	memset(zt, 0, sizeof(*zt));
 }
@@ -706,9 +986,25 @@ static int _copy_outputs(struct zufc_thread *zt, void *arg)
 	}
 }
 
+static bool _need_channel_lock(struct zufc_thread *zt)
+{
+	struct zufs_ioc_IO *ret_io = zt->opt_buff;
+
+	/* Only ZUF_GET_MULTY is allowed channel locking
+	 * because it absolutely must and I truest the code.
+	 * If You need a new channel locking command come talk
+	 * to me first.
+	 */
+	return	(ret_io->hdr.err == 0) &&
+		(ret_io->hdr.operation == ZUFS_OP_GET_MULTY) &&
+		(ret_io->ret_flags & ZUFS_RET_LOCKED_PUT) &&
+		(ret_io->ziom.iom_n != 0);
+}
+
 static int _zu_wait(struct file *file, void *parg)
 {
 	struct zufc_thread *zt;
+	struct zufs_ioc_hdr *user_hdr;
 	bool __chan_is_locked = false;
 	int err;
 
@@ -730,6 +1026,10 @@ static int _zu_wait(struct file *file, void *parg)
 		goto err;
 	}
 
+	user_hdr = zt->opt_buff;
+	if (user_hdr->flags & ZUFS_H_HAS_PIGY_PUT)
+		user_hdr->flags &= ~ZUFS_H_HAS_PIGY_PUT;
+
 	if (relay_is_app_waiting(&zt->relay)) {
 		if (unlikely(!zt->zdo)) {
 			zuf_err("User has gone...\n");
@@ -751,13 +1051,29 @@ static int _zu_wait(struct file *file, void *parg)
 
 		_unmap_pages(zt, zt->zdo->pages, zt->zdo->nump);
 
-		zt->zdo = NULL;
+		if (unlikely(!err && _need_channel_lock(zt))) {
+			zt->zdo->__locked_zt = zt;
+			__chan_is_locked = true;
+		} else {
+			zt->zdo = NULL;
+		}
 		if (unlikely(err)) /* _copy_outputs returned an err */
 			goto err;
 
 		relay_app_wakeup(&zt->relay);
 	}
 
+	if (zt->pigi_put->needs_goosing && !__chan_is_locked) {
+		/* go do a cycle and come back */
+		_goose_prep(ZRI(file->f_inode->i_sb), zt);
+		return 0;
+	}
+
+	if (zt->pigi_put->waiter) {
+		_goose_put(zt->pigi_put->waiter);
+		zt->pigi_put->waiter = NULL;
+	}
+
 	err = __relay_fss_wait(&zt->relay, __chan_is_locked);
 	if (err)
 		zuf_dbg_err("[%d] relay error: %d\n", zt->no, err);
@@ -770,8 +1086,16 @@ static int _zu_wait(struct file *file, void *parg)
 		 * we should have a bit set in zt->zdo->hdr set per operation.
 		 * TODO: Why this does not work?
 		 */
-		_map_pages(zt, zt->zdo->pages, zt->zdo->nump, 0);
+		_map_pages(zt, zt->zdo->pages, zt->zdo->nump,
+			   zt->zdo->hdr->operation == ZUFS_OP_WRITE);
+		if (zt->pigi_put->s)
+			_pigy_put_add_to_ioc(ZRI(file->f_inode->i_sb), zt);
 	} else {
+		if (zt->pigi_put->needs_goosing) {
+			_goose_prep(ZRI(file->f_inode->i_sb), zt);
+			return 0;
+		}
+
 		/* This Means we were released by _zu_break */
 		zuf_dbg_zus("_zu_break? => %d\n", err);
 		_prep_header_size_op(zt->opt_buff, ZUFS_OP_BREAK, err);
@@ -953,6 +1277,30 @@ static inline struct zu_exec_buff *_ebuff_from_file(struct file *file)
 	return ebuff;
 }
 
+static int _ebuff_bounds_check(struct zu_exec_buff *ebuff, ulong buff,
+			       struct zufs_iomap *ziom,
+			       struct zufs_iomap *user_ziom, void *ziom_end)
+{
+	size_t iom_max_bytes = ziom_end - (void *)&user_ziom->iom_e;
+
+	if (buff != ebuff->vma->vm_start ||
+	    ebuff->vma->vm_end < buff + iom_max_bytes) {
+		WARN_ON_ONCE(1);
+		zuf_err("Executing out off bound vm_start=0x%lx vm_end=0x%lx buff=0x%lx buff_end=0x%lx\n",
+			ebuff->vma->vm_start, ebuff->vma->vm_end, buff,
+			buff + iom_max_bytes);
+		return -EINVAL;
+	}
+
+	if (unlikely((iom_max_bytes / sizeof(__u64) < ziom->iom_max)))
+		return -EINVAL;
+
+	if (unlikely(ziom->iom_max < ziom->iom_n))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int _zu_ebuff_alloc(struct file *file, void *arg)
 {
 	struct zufs_ioc_alloc_buffer ioc_alloc;
@@ -1004,6 +1352,52 @@ static void zufc_ebuff_release(struct file *file)
 	kfree(ebuff);
 }
 
+static int _zu_iomap_exec(struct file *file, void *arg)
+{
+	struct zuf_root_info *zri = ZRI(file->f_inode->i_sb);
+	struct zu_exec_buff *ebuff = _ebuff_from_file(file);
+	struct zufs_ioc_iomap_exec ioc_iomap;
+	struct zufs_ioc_iomap_exec *user_iomap;
+
+	struct super_block *sb;
+	int err;
+
+	if (unlikely(!ebuff))
+		return -EINVAL;
+
+	user_iomap = ebuff->opt_buff;
+	/* do all checks on a kernel copy so malicious Server cannot
+	 * crash the Kernel
+	 */
+	ioc_iomap = *user_iomap;
+
+	err = _ebuff_bounds_check(ebuff, (ulong)arg, &ioc_iomap.ziom,
+				  &user_iomap->ziom,
+				  ebuff->opt_buff + ebuff->alloc_size);
+	if (unlikely(err)) {
+		zuf_err("illegal iomap: iom_max=%u iom_n=%u\n",
+			ioc_iomap.ziom.iom_max, ioc_iomap.ziom.iom_n);
+		return err;
+	}
+
+	/* The ID of the super block received in mount */
+	sb = zuf_sb_from_id(zri, ioc_iomap.sb_id, ioc_iomap.zus_sbi);
+	if (unlikely(!sb))
+		return -EINVAL;
+
+	if (ioc_iomap.wait_for_done)
+		err = zuf_iom_execute_sync(sb, NULL, user_iomap->ziom.iom_e,
+					   ioc_iomap.ziom.iom_n);
+	else
+		err =  zuf_iom_execute_async(sb, ioc_iomap.ziom.iomb,
+					     user_iomap->ziom.iom_e,
+					     ioc_iomap.ziom.iom_n);
+
+	user_iomap->hdr.err = err;
+	zuf_dbg_core("OUT => %d\n", err);
+	return 0; /* report err at hdr, but the command was executed */
+};
+
 /* ~~~~ ioctl & release handlers ~~~~ */
 static int _zu_register_fs(struct file *file, void *parg)
 {
@@ -1069,6 +1463,8 @@ long zufc_ioctl(struct file *file, unsigned int cmd, ulong arg)
 		return _zu_wait(file, parg);
 	case ZU_IOC_ALLOC_BUFFER:
 		return _zu_ebuff_alloc(file, parg);
+	case ZU_IOC_IOMAP_EXEC:
+		return _zu_iomap_exec(file, parg);
 	case ZU_IOC_PRIVATE_MOUNT:
 		return _zu_private_mounter(file, parg);
 	case ZU_IOC_BREAK_ALL:
diff --git a/fs/zuf/zuf.h b/fs/zuf/zuf.h
index 2d5327e1d2b1..2c57c51a2099 100644
--- a/fs/zuf/zuf.h
+++ b/fs/zuf/zuf.h
@@ -402,6 +402,13 @@ static inline int zuf_flt_to_err(vm_fault_t flt)
 	return -EACCES;
 }
 
+struct _io_gb_multy {
+	struct zuf_dispatch_op zdo;
+	struct zufs_ioc_IO IO;
+	ulong iom_n;
+	ulong *bns;
+};
+
 /* Keep this include last thing in file */
 #include "_extern.h"
 
diff --git a/fs/zuf/zus_api.h b/fs/zuf/zus_api.h
index 2bdf047282e8..e3a783748ce6 100644
--- a/fs/zuf/zus_api.h
+++ b/fs/zuf/zus_api.h
@@ -456,7 +456,15 @@ enum e_zufs_operation {
 	ZUFS_OP_RENAME		= 10,
 	ZUFS_OP_READDIR		= 11,
 
+	ZUFS_OP_READ		= 14,
+	ZUFS_OP_PRE_READ	= 15,
+	ZUFS_OP_WRITE		= 16,
 	ZUFS_OP_SETATTR		= 19,
+	ZUFS_OP_FALLOCATE	= 21,
+
+	ZUFS_OP_GET_MULTY	= 29,
+	ZUFS_OP_PUT_MULTY	= 30,
+	ZUFS_OP_NOOP		= 31,
 
 	ZUFS_OP_MAX_OPT,
 };
@@ -646,10 +654,253 @@ struct zufs_ioc_attr {
 	__u32 pad;
 };
 
+/* ~~~~ io_map structures && IOCTL(s) ~~~~ */
+/*
+ * These set of structures and helpers are used in return of zufs_ioc_IO and
+ * also at ZU_IOC_IOMAP_EXEC, NULL terminating list (array)
+ *
+ * Each iom_elemet stars with an __u64 of which the 8 hight bits carry an
+ * operation_type, And the 56 bits value denotes a page offset, (md_o2p()) or a
+ * length. operation_type is one of ZUFS_IOM_TYPE enum.
+ * The interpreter then jumps to the next operation depending on the size
+ * of the defined operation.
+ */
+
+enum ZUFS_IOM_TYPE {
+	IOM_NONE	= 0,
+	IOM_T1_WRITE	= 1,
+	IOM_T1_READ	= 2,
+
+	IOM_T2_WRITE	= 3,
+	IOM_T2_READ	= 4,
+	IOM_T2_WRITE_LEN = 5,
+	IOM_T2_READ_LEN	= 6,
+
+	IOM_T2_ZUSMEM_WRITE = 7,
+	IOM_T2_ZUSMEM_READ = 8,
+
+	IOM_UNMAP	= 9,
+	IOM_WBINV	= 10,
+	IOM_REPEAT	= 11,
+
+	IOM_NUM_LEGAL_OPT,
+};
+
+#define ZUFS_IOM_VAL_BITS	56
+#define ZUFS_IOM_FIRST_VAL_MASK ((1UL << ZUFS_IOM_VAL_BITS) - 1)
+
+static inline enum ZUFS_IOM_TYPE _zufs_iom_opt_type(__u64 *iom_e)
+{
+	uint ret = (*iom_e) >> ZUFS_IOM_VAL_BITS;
+
+	if (ret >= IOM_NUM_LEGAL_OPT)
+		return IOM_NONE;
+	return (enum ZUFS_IOM_TYPE)ret;
+}
+
+static inline bool _zufs_iom_pop(__u64 *iom_e)
+{
+	return _zufs_iom_opt_type(iom_e) != IOM_NONE;
+}
+
+static inline ulong _zufs_iom_first_val(__u64 *iom_elemets)
+{
+	return *iom_elemets & ZUFS_IOM_FIRST_VAL_MASK;
+}
+
+static inline void _zufs_iom_enc_type_val(__u64 *ptr, enum ZUFS_IOM_TYPE type,
+					 ulong val)
+{
+	*ptr = (__u64)val | ((__u64)type << ZUFS_IOM_VAL_BITS);
+}
+
+static inline ulong _zufs_iom_t1_bn(__u64 val)
+{
+	if (unlikely(_zufs_iom_opt_type(&val) != IOM_T1_READ))
+		return -1;
+
+	return zu_dpp_t_bn(_zufs_iom_first_val(&val));
+}
+
+static inline void _zufs_iom_enc_bn(__u64 *ptr, ulong bn, uint pool)
+{
+	_zufs_iom_enc_type_val(ptr, IOM_T1_READ, zu_enc_dpp_t_bn(bn, pool));
+}
+
+/* IOM_T1_WRITE / IOM_T1_READ
+ * May be followed by an IOM_REPEAT
+ */
+struct zufs_iom_t1_io {
+	/* Special dpp_t that denote a page ie: bn << 3 | zu_dpp_t_pool  */
+	__u64	t1_val;
+};
+
+/* IOM_T2_WRITE / IOM_T2_READ */
+struct zufs_iom_t2_io {
+	__u64	t2_val;
+	zu_dpp_t t1_val;
+};
+
+/* IOM_T2_WRITE_LEN / IOM_T2_READ_LEN */
+struct zufs_iom_t2_io_len {
+	struct zufs_iom_t2_io iom;
+	__u64 num_pages;
+};
+
+/* IOM_T2_ZUSMEM_WRITE / IOM_T2_ZUSMEM_READ */
+struct zufs_iom_t2_zusmem_io {
+	__u64	t2_val;
+	__u64	zus_mem_ptr; /* needs an get_user_pages() */
+	__u64	len;
+};
+
+/* IOM_UNMAP:
+ *	Executes unmap_mapping_range & remove of zuf's block-caching
+ *
+ * For now iom_unmap means even_cows=0, because Kernel takes care of all
+ * the cases of the even_cows=1. In future if needed it will be on the high
+ * bit of unmap_n.
+ */
+struct zufs_iom_unmap {
+	__u64	unmap_index;	/* Offset in pages of inode */
+	__u64	unmap_n;	/* Num pages to unmap (0 means: to eof) */
+	__u64	ino;		/* Pages of this inode */
+};
+
+#define ZUFS_WRITE_OP_SPACE						\
+	((sizeof(struct zufs_iom_unmap) +				\
+	  sizeof(struct zufs_iom_t2_io)) / sizeof(__u64) + sizeof(__u64))
+
+struct zus_iomap_build;
+/* For ZUFS_OP_IOM_DONE */
+struct zufs_ioc_iomap_done {
+	struct zufs_ioc_hdr hdr;
+	/* IN */
+	struct zus_sb_info *zus_sbi;
+
+	/* The cookie received from zufs_ioc_iomap_exec */
+	struct	zus_iomap_build *iomb;
+};
+
+struct zufs_iomap {
+	/* A cookie from zus to return when execution is done */
+	struct	zus_iomap_build *iomb;
+
+	__u32	iom_max;	/* num of __u64 allocated	 */
+	__u32	iom_n;		/* num of valid __u64 in iom_e	 */
+	__u64	iom_e[0];	/* encoded operations to execute */
+
+	/* This struct must be last */
+};
+
+/*
+ * Execute an iomap in behalf of the Server
+ *
+ * NOTE: this IOCTL must come on an above ZU_IOC_ALLOC_BUFFER type file
+ * and the passed arg-buffer must be the pointer returned from an mmap
+ * call preformed in the file, before the call to this IOC.
+ * If this is not done the IOCTL will return EINVAL.
+ */
+struct zufs_ioc_iomap_exec {
+	struct zufs_ioc_hdr hdr;
+	/* The ID of the super block received in mount */
+	__u64	sb_id;
+	/* We verify the sb_id validity against zus_sbi */
+	struct zus_sb_info *zus_sbi;
+	/* If application buffers they are from this IO*/
+	__u64	zt_iocontext;
+	/* Only return from IOCTL when finished. iomap_done NOT called */
+	__u32	wait_for_done;
+	__u32	__pad;
+
+	struct zufs_iomap ziom; /* must be last */
+};
+#define ZU_IOC_IOMAP_EXEC	_IOWR('Z', 19, struct zufs_ioc_iomap_exec)
+
+/*
+ * ZUFS_OP_READ / ZUFS_OP_WRITE / ZUFS_OP_FALLOCATE
+ *       also
+ * ZUFS_OP_GET_MULTY / ZUFS_OP_PUT_MULTY
+ */
+/* flags for zufs_ioc_IO->ret_flags */
+enum {
+	ZUFS_RET_RESERVED	= 0x0001, /* Not used */
+	ZUFS_RET_NEW		= 0x0002, /* In WRITE, allocated a new block */
+	ZUFS_RET_IOM_ALL_PMEM	= 0x0004, /* iom_e[] is encoded with pmem-bn */
+	ZUFS_RET_PUT_NOW	= 0x0008, /* GET_MULTY demands no pigi-puts  */
+	ZUFS_RET_LOCKED_PUT	= 0x0010, /* Same as PUT_NOW but must lock a zt
+					   * channel, Because GET took a lock
+					   */
+};
+
+/* flags for zufs_ioc_IO->rw */
+#define ZUFS_RW_WRITE	BIT(0)	/* SAME as WRITE in Kernel */
+#define ZUFS_RW_MMAP	BIT(1)
+
+#define ZUFS_RW_RAND	BIT(4)	/* fadvise(random) */
+
+/* Same meaning as IOCB_XXXX different bits */
+#define ZUFS_RW_KERN	8
+#define ZUFS_RW_EVENTFD	BIT(ZUFS_RW_KERN + 0)
+#define ZUFS_RW_APPEND	BIT(ZUFS_RW_KERN + 1)
+#define ZUFS_RW_DIRECT	BIT(ZUFS_RW_KERN + 2)
+#define ZUFS_RW_HIPRI	BIT(ZUFS_RW_KERN + 3)
+#define ZUFS_RW_DSYNC	BIT(ZUFS_RW_KERN + 4)
+#define ZUFS_RW_SYNC	BIT(ZUFS_RW_KERN + 5)
+#define ZUFS_RW_NOWAIT	BIT(ZUFS_RW_KERN + 7)
+#define ZUFS_RW_LAST_USED_BIT (ZUFS_RW_KERN + 7)
+/* ^^ PLEASE update (keep last) ^^ */
+
+/* 8 bits left for user */
+#define ZUFS_RW_USER_BITS 0xFF000000
+#define ZUFS_RW_USER	BIT(24)
+
 /* Special flag for ZUFS_OP_FALLOCATE to specify a setattr(SIZE)
  * IE. same as punch hole but set_i_size to be @filepos. In this
  * case @last_pos == ~0ULL
  */
 #define ZUFS_FL_TRUNCATE 0x80000000
 
+struct zufs_ioc_IO {
+	struct zufs_ioc_hdr hdr;
+
+	/* IN */
+	struct zus_inode_info *zus_ii;
+	__u64 filepos;
+	__u64 rw;		/* One or more of ZUFS_RW_XXX		*/
+	__u32 ret_flags;	/* OUT - ZUFS_RET_XXX OUT		*/
+	__u32 pool;		/* All dpp_t(s) belong to this pool	*/
+	__u64 cookie;		/* For FS private use			*/
+
+	/* in / OUT */
+	/* For read-ahead (or alloc ahead) */
+	struct __zufs_ra {
+		union {
+			ulong start;
+			__u64 __start;
+		};
+		__u64 prev_pos;
+		__u32 ra_pages;
+		__u32 ra_pad; /* we need this */
+	} ra;
+
+	/* For writes TODO: encode at iom_e? */
+	struct __zufs_write_unmap {
+		__u32  offset;
+		__u32  len;
+	} wr_unmap;
+
+	/* The last offset in this IO. If 0, than error code at .hdr.err */
+	/* for ZUFS_OP_FALLOCATE this is the requested end offset */
+	__u64 last_pos;
+
+	struct zufs_iomap ziom;
+	__u64 iom_e[ZUFS_WRITE_OP_SPACE]; /* One tier_up for WRITE or GB */
+};
+
+static inline uint _ioc_IO_size(uint iom_n)
+{
+	return offsetof(struct zufs_ioc_IO, iom_e) + iom_n * sizeof(__u64);
+}
+
 #endif /* _LINUX_ZUFS_API_H */
-- 
2.21.0

