Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E55ED8A3BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 18:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfHLQsq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 12:48:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39712 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbfHLQsp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:48:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so15053597wra.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 09:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cvYk4jh2lOF/oOU4nofwtOHLyp4ne26FTkfM3SIxyeM=;
        b=T2DZAExppPy+H0vMuYToPSiCJwtX5rAgTT4dJyl3M/1nUVQTq7CJ2pdEg5H6+nLfMg
         sqIwPQ0ZhgN9VcBRk+gv1mTQKyV9JtYznienj+MRe5mWZfugsiwKv3QMn2+v2vY1EqjJ
         bGKd8yVYQv1268+64ZP4564s1puvur3DaKhgUyFxJtpssaQQUcvck/3Jnn3yEj3rObNA
         qczENRk6wMELAMnmCI1suD/cd2mD+imuL6HgiJ43T1Ll1XN0rHamS6OKbaVhuMj01emH
         b03OBCIJzLTxT+sJ2wpsuAULgMFEUC+i1OzmX89WAOP058b73eJr82lAQhjEPUD1p1gI
         iHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cvYk4jh2lOF/oOU4nofwtOHLyp4ne26FTkfM3SIxyeM=;
        b=d5OAvQ0/PQOZsPNdlE2QF/I5fZ44DX/yGs7P32y5wnPTY+EUx2S3YhI+ZKZgTmMDMR
         5sT0tpSG1nDtU63elTfDc9Nw2/bdYMnfr+sh0fZ4OnbLa9QO5pt0j0Q2vVuuCUC0Dazh
         azDnHqMPbI+vCMRRnkhRukrsWaAQYYSuMcOoaVaow9RoTdP2/bhMZBp7pOiu1A3WmSRc
         qHrOIQRJ5BBj6KyqWxHhMSy7UcKdtBvMC/TlCMq6JkHSIvlh8zrKkWZiy1Cspjiwore4
         F72w4ash0VBKfp9UCrb8QPNkTdWRaqXg0j/T4DtGvp6GvcLFpC4UhYuLq+KM3kN2RmEP
         XlCA==
X-Gm-Message-State: APjAAAWnDC/cy5xGLlfC6llM3B/fGa4QpuzIkijZHYdJA4Teu4Y15VGu
        Og0m0N+GrgP6ws0hqhwP/WNzjmCr+To=
X-Google-Smtp-Source: APXvYqwmMhoBY66QcBLIeIS6dq4SvmTGuucw+gY1Wt31hAH1LerEQaAM/T8zxSNzW2uYoloHtQ6HMg==
X-Received: by 2002:a5d:4b83:: with SMTP id b3mr36769808wrt.104.1565628522927;
        Mon, 12 Aug 2019 09:48:42 -0700 (PDT)
Received: from Bfire.plexistor.com ([217.70.211.18])
        by smtp.googlemail.com with ESMTPSA id g7sm100334wmg.8.2019.08.12.09.48.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 09:48:42 -0700 (PDT)
From:   Boaz Harrosh <boaz@plexistor.com>
X-Google-Original-From: Boaz Harrosh <boazh@netapp.com>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Amit Golander <Amit.Golander@netapp.com>,
        Sagi Manole <sagim@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 12/16] zuf: mmap & sync
Date:   Mon, 12 Aug 2019 19:48:02 +0300
Message-Id: <20190812164806.15852-13-boazh@netapp.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812164806.15852-1-boazh@netapp.com>
References: <20190812164806.15852-1-boazh@netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On page-fault call the zusFS for the page information. We always
mmap pmem pages directly. (No page cache)

With write-mmap and pmem. We need to keep track of dirty inodes
and call the zusFS when one of the sync variants are called.
This is because the Server will need to do a cl_flush on all
dirty pages.

If we did not have any write-mmaped pages on the inode sync does
nothing.

Signed-off-by: Boaz Harrosh <boazh@netapp.com>
---
 fs/zuf/Makefile   |   2 +-
 fs/zuf/_extern.h  |   6 +
 fs/zuf/file.c     |  67 +++++++++++
 fs/zuf/inode.c    |  11 ++
 fs/zuf/mmap.c     | 300 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/zuf/rw.c       |  17 +++
 fs/zuf/super.c    |  89 ++++++++++++++
 fs/zuf/zuf-core.c |   2 +
 fs/zuf/zuf.h      |   3 +
 fs/zuf/zus_api.h  |  26 ++++
 10 files changed, 522 insertions(+), 1 deletion(-)
 create mode 100644 fs/zuf/mmap.c

diff --git a/fs/zuf/Makefile b/fs/zuf/Makefile
index 23bc3791a001..02df1374a946 100644
--- a/fs/zuf/Makefile
+++ b/fs/zuf/Makefile
@@ -17,6 +17,6 @@ zuf-y += md.o t1.o t2.o
 zuf-y += zuf-core.o zuf-root.o
 
 # Main FS
-zuf-y += rw.o
+zuf-y += rw.o mmap.o
 zuf-y += super.o inode.o directory.o namei.o file.o symlink.o
 zuf-y += module.o
diff --git a/fs/zuf/_extern.h b/fs/zuf/_extern.h
index 724c6c5e5d3c..34fde591cf92 100644
--- a/fs/zuf/_extern.h
+++ b/fs/zuf/_extern.h
@@ -54,6 +54,9 @@ int zufr_register_fs(struct super_block *sb, struct zufs_ioc_register_fs *rfs);
 int zuf_init_inodecache(void);
 void zuf_destroy_inodecache(void);
 
+void zuf_sync_inc(struct inode *inode);
+void zuf_sync_dec(struct inode *inode, ulong write_unmapped);
+
 struct dentry *zuf_mount(struct file_system_type *fs_type, int flags,
 			 const char *dev_name, void *data);
 
@@ -118,6 +121,9 @@ int zuf_iom_execute_async(struct super_block *sb, struct zus_iomap_build *iomb,
 int zuf_rw_file_range_compare(struct inode *i_in, loff_t pos_in,
 			      struct inode *i_out, loff_t pos_out, loff_t len);
 
+/* mmap.c */
+int zuf_file_mmap(struct file *file, struct vm_area_struct *vma);
+
 /* t1.c */
 int zuf_pmem_mmap(struct file *file, struct vm_area_struct *vma);
 
diff --git a/fs/zuf/file.c b/fs/zuf/file.c
index aeed46f3b9f3..58142c825230 100644
--- a/fs/zuf/file.c
+++ b/fs/zuf/file.c
@@ -23,6 +23,71 @@ long __zuf_fallocate(struct inode *inode, int mode, loff_t offset, loff_t len)
 	return -ENOTSUPP;
 }
 
+/* This function is called by both msync() and fsync(). */
+int zuf_isync(struct inode *inode, loff_t start, loff_t end, int datasync)
+{
+	struct zuf_inode_info *zii = ZUII(inode);
+	struct zufs_ioc_sync ioc_range = {
+		.hdr.in_len = sizeof(ioc_range),
+		.hdr.operation = ZUFS_OP_SYNC,
+		.zus_ii = zii->zus_ii,
+		.offset = start,
+		.flags = datasync ? ZUFS_SF_DATASYNC : 0,
+	};
+	loff_t isize;
+	ulong uend = end + 1;
+	int err = 0;
+
+	zuf_dbg_vfs(
+		"[%ld] start=0x%llx end=0x%llx  datasync=%d write_mapped=%d\n",
+		inode->i_ino, start, end, datasync,
+		atomic_read(&zii->write_mapped));
+
+	/* We want to serialize the syncs so they don't fight with each other
+	 * and is though more efficient, but we do not want to lock out
+	 * read/writes and page-faults so we have a special sync semaphore
+	 */
+	zuf_smw_lock(zii);
+
+	isize = i_size_read(inode);
+	if (!isize) {
+		zuf_dbg_mmap("[%ld] file is empty\n", inode->i_ino);
+		goto out;
+	}
+	if (isize < uend)
+		uend = isize;
+	if (uend < start) {
+		zuf_dbg_mmap("[%ld] isize=0x%llx start=0x%llx end=0x%lx\n",
+				 inode->i_ino, isize, start, uend);
+		err = -ENODATA;
+		goto out;
+	}
+
+	if (!atomic_read(&zii->write_mapped))
+		goto out; /* Nothing to do on this inode */
+
+	ioc_range.length = uend - start;
+	unmap_mapping_range(inode->i_mapping, start, ioc_range.length, 0);
+	zufc_goose_all_zts(ZUF_ROOT(SBI(inode->i_sb)), inode);
+
+	err = zufc_dispatch(ZUF_ROOT(SBI(inode->i_sb)), &ioc_range.hdr,
+			    NULL, 0);
+	if (unlikely(err))
+		zuf_dbg_err("zufc_dispatch failed => %d\n", err);
+
+	zuf_sync_dec(inode, ioc_range.write_unmapped);
+
+out:
+	zuf_smw_unlock(zii);
+	return err;
+}
+
+static int zuf_fsync(struct file *file, loff_t start, loff_t end, int datasync)
+{
+	return zuf_isync(file_inode(file), start, end, datasync);
+}
+
+
 ssize_t zuf_read_iter(struct kiocb *kiocb, struct iov_iter *ii)
 {
 	struct inode *inode = file_inode(kiocb->ki_filp);
@@ -95,6 +160,8 @@ const struct file_operations zuf_file_operations = {
 	.open			= generic_file_open,
 	.read_iter		= zuf_read_iter,
 	.write_iter		= zuf_write_iter,
+	.mmap			= zuf_file_mmap,
+	.fsync			= zuf_fsync,
 };
 
 const struct inode_operations zuf_file_inode_operations = {
diff --git a/fs/zuf/inode.c b/fs/zuf/inode.c
index b4d06fe6bf89..567fb4117371 100644
--- a/fs/zuf/inode.c
+++ b/fs/zuf/inode.c
@@ -273,6 +273,8 @@ void zuf_evict_inode(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	struct zuf_inode_info *zii = ZUII(inode);
+	int write_mapped;
+
 	zufc_goose_all_zts(ZUF_ROOT(SBI(sb)), inode);
 
 	if (!inode->i_nlink) {
@@ -310,6 +312,15 @@ void zuf_evict_inode(struct inode *inode)
 	zii->zus_ii = NULL;
 	zii->zi = NULL;
 
+	/* ZUS on evict has synced all mmap dirty pages, YES? */
+	write_mapped = atomic_read(&zii->write_mapped);
+	if (unlikely(write_mapped || !list_empty(&zii->i_mmap_dirty))) {
+		zuf_dbg_mmap("[%ld] !!!! write_mapped=%d list_empty=%d\n",
+			      inode->i_ino, write_mapped,
+			      list_empty(&zii->i_mmap_dirty));
+		zuf_sync_dec(inode, write_mapped);
+	}
+
 	clear_inode(inode);
 }
 
diff --git a/fs/zuf/mmap.c b/fs/zuf/mmap.c
new file mode 100644
index 000000000000..318c701f7d7d
--- /dev/null
+++ b/fs/zuf/mmap.c
@@ -0,0 +1,300 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BRIEF DESCRIPTION
+ *
+ * mmap operations.
+ *
+ * Copyright (c) 2018 NetApp Inc. All rights reserved.
+ *
+ * ZUFS-License: GPL-2.0. See module.c for LICENSE details.
+ *
+ * Authors:
+ *	Boaz Harrosh <boazh@netapp.com>
+ */
+
+#include <linux/pfn_t.h>
+#include "zuf.h"
+
+/* ~~~ Functions for mmap and page faults ~~~ */
+
+/* MAP_PRIVATE, copy data to user private page (cow_page) */
+static int _cow_private_page(struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	struct inode *inode = vma->vm_file->f_mapping->host;
+	struct zuf_sb_info *sbi = SBI(inode->i_sb);
+	int err;
+
+	/* Basically a READ into vmf->cow_page */
+	err = zuf_rw_read_page(sbi, inode, vmf->cow_page,
+			       md_p2o(vmf->pgoff));
+	if (unlikely(err && err != -EINTR)) {
+		zuf_err("[%ld] read_page failed bn=0x%lx address=0x%lx => %d\n",
+			inode->i_ino, vmf->pgoff, vmf->address, err);
+		/* FIXME: Probably return VM_FAULT_SIGBUS */
+	}
+
+	/*HACK: This is an hack since Kernel v4.7 where a VM_FAULT_LOCKED with
+	 * vmf->page==NULL is no longer supported. Looks like for now this way
+	 * works well. We let mm mess around with unlocking and putting its own
+	 * cow_page.
+	 */
+	vmf->page = vmf->cow_page;
+	get_page(vmf->page);
+	lock_page(vmf->page);
+
+	return VM_FAULT_LOCKED;
+}
+
+static inline ulong _gb_bn(struct zufs_ioc_IO *get_block)
+{
+	if (unlikely(!get_block->ziom.iom_n))
+		return 0;
+
+	return _zufs_iom_t1_bn(get_block->iom_e[0]);
+}
+
+static vm_fault_t zuf_write_fault(struct vm_area_struct *vma,
+				  struct vm_fault *vmf)
+{
+	struct inode *inode = vma->vm_file->f_mapping->host;
+	struct zuf_sb_info *sbi = SBI(inode->i_sb);
+	struct zuf_inode_info *zii = ZUII(inode);
+	struct zus_inode *zi = zii->zi;
+	ulong bn;
+	struct _io_gb_multy io_gb = {
+		.IO.rw = WRITE | ZUFS_RW_MMAP,
+		.bns = &bn,
+	};
+	vm_fault_t fault = VM_FAULT_SIGBUS;
+	ulong addr = vmf->address;
+	ulong pmem_bn;
+	pgoff_t size;
+	pfn_t pfnt;
+	ulong pfn;
+	int err;
+
+	zuf_dbg_mmap("[%ld] vm_start=0x%lx vm_end=0x%lx VA=0x%lx "
+		    "pgoff=0x%lx vmf_flags=0x%x cow_page=%p page=%p\n",
+		    _zi_ino(zi), vma->vm_start, vma->vm_end, addr, vmf->pgoff,
+		    vmf->flags, vmf->cow_page, vmf->page);
+
+	sb_start_pagefault(inode->i_sb);
+	zuf_smr_lock_pagefault(zii);
+
+	size = md_o2p_up(i_size_read(inode));
+	if (unlikely(vmf->pgoff >= size)) {
+		ulong pgoff = vma->vm_pgoff + md_o2p(addr - vma->vm_start);
+
+		zuf_dbg_err("[%ld] pgoff(0x%lx)(0x%lx) >= size(0x%lx) => SIGBUS\n",
+			    _zi_ino(zi), vmf->pgoff, pgoff, size);
+
+		fault = VM_FAULT_SIGBUS;
+		goto out;
+	}
+
+	if (vmf->cow_page) {
+		fault = _cow_private_page(vma, vmf);
+		goto out;
+	}
+
+	zus_inode_cmtime_now(inode, zi);
+	/* NOTE: zus needs to flush the zi */
+
+	err = _zufs_IO_get_multy(sbi, inode, md_p2o(vmf->pgoff), PAGE_SIZE,
+				 &io_gb);
+	if (unlikely(err)) {
+		zuf_dbg_err("_get_put_block failed => %d\n", err);
+		goto out;
+	}
+	pmem_bn = _gb_bn(&io_gb.IO);
+	if (unlikely(pmem_bn == 0)) {
+		zuf_err("[%ld] pmem_bn=0  rw=0x%llx ret_flags=0x%x but no error?\n",
+			_zi_ino(zi), io_gb.IO.rw, io_gb.IO.ret_flags);
+		fault = VM_FAULT_SIGBUS;
+		goto out;
+	}
+
+	if (io_gb.IO.ret_flags & ZUFS_RET_NEW) {
+		/* newly created block */
+		inode->i_blocks = le64_to_cpu(zii->zi->i_blocks);
+	}
+	unmap_mapping_range(inode->i_mapping, vmf->pgoff << PAGE_SHIFT,
+				    PAGE_SIZE, 0);
+
+	pfn = md_pfn(sbi->md, pmem_bn);
+	pfnt = phys_to_pfn_t(PFN_PHYS(pfn), PFN_MAP | PFN_DEV);
+	fault = vmf_insert_mixed_mkwrite(vma, addr, pfnt);
+	err = zuf_flt_to_err(fault);
+	if (unlikely(err)) {
+		zuf_err("[%ld] vm_insert_mixed_mkwrite failed => fault=0x%x err=%d\n",
+			_zi_ino(zi), (int)fault, err);
+		goto put;
+	}
+
+	zuf_dbg_mmap("[%ld] vm_insert_mixed 0x%lx prot=0x%lx => %d\n",
+		    _zi_ino(zi), pfn, vma->vm_page_prot.pgprot, err);
+
+	zuf_sync_inc(inode);
+put:
+	_zufs_IO_put_multy(sbi, inode, &io_gb);
+out:
+	zuf_smr_unlock(zii);
+	sb_end_pagefault(inode->i_sb);
+	return fault;
+}
+
+static vm_fault_t zuf_pfn_mkwrite(struct vm_fault *vmf)
+{
+	return zuf_write_fault(vmf->vma, vmf);
+}
+
+static vm_fault_t zuf_read_fault(struct vm_area_struct *vma,
+				 struct vm_fault *vmf)
+{
+	struct inode *inode = vma->vm_file->f_mapping->host;
+	struct zuf_sb_info *sbi = SBI(inode->i_sb);
+	struct zuf_inode_info *zii = ZUII(inode);
+	struct zus_inode *zi = zii->zi;
+	ulong bn;
+	struct _io_gb_multy io_gb = {
+		.IO.rw = READ | ZUFS_RW_MMAP,
+		.bns = &bn,
+	};
+	vm_fault_t fault = VM_FAULT_SIGBUS;
+	ulong addr = vmf->address;
+	ulong pmem_bn;
+	pgoff_t size;
+	pfn_t pfnt;
+	int err;
+
+	zuf_dbg_mmap("[%ld] vm_start=0x%lx vm_end=0x%lx VA=0x%lx "
+		    "pgoff=0x%lx vmf_flags=0x%x cow_page=%p page=%p\n",
+		    _zi_ino(zi), vma->vm_start, vma->vm_end, addr, vmf->pgoff,
+		    vmf->flags, vmf->cow_page, vmf->page);
+
+	zuf_smr_lock_pagefault(zii);
+
+	size = md_o2p_up(i_size_read(inode));
+	if (unlikely(vmf->pgoff >= size)) {
+		ulong pgoff = vma->vm_pgoff + md_o2p(addr - vma->vm_start);
+
+		zuf_dbg_err("[%ld] pgoff(0x%lx)(0x%lx) >= size(0x%lx) => SIGBUS\n",
+			    _zi_ino(zi), vmf->pgoff, pgoff, size);
+		goto out;
+	}
+
+	if (vmf->cow_page) {
+		zuf_warn("cow is read\n");
+		fault = _cow_private_page(vma, vmf);
+		goto out;
+	}
+
+	file_accessed(vma->vm_file);
+	/* NOTE: zus needs to flush the zi */
+
+	err = _zufs_IO_get_multy(sbi, inode, md_p2o(vmf->pgoff), PAGE_SIZE,
+				 &io_gb);
+	if (unlikely(err && err != -EINTR)) {
+		zuf_err("_get_put_block failed => %d\n", err);
+		goto out;
+	}
+
+	pmem_bn = _gb_bn(&io_gb.IO);
+	if (pmem_bn == 0) {
+		/* Hole in file */
+		pfnt = pfn_to_pfn_t(my_zero_pfn(vmf->address));
+	} else {
+		/* We have a real page */
+		pfnt = phys_to_pfn_t(PFN_PHYS(md_pfn(sbi->md, pmem_bn)),
+				     PFN_MAP | PFN_DEV);
+	}
+	fault = vmf_insert_mixed(vma, addr, pfnt);
+	err = zuf_flt_to_err(fault);
+	if (unlikely(err)) {
+		zuf_err("[%ld] vm_insert_mixed => fault=0x%x err=%d\n",
+			_zi_ino(zi), (int)fault, err);
+		goto put;
+	}
+
+	zuf_dbg_mmap("[%ld] vm_insert_mixed pmem_bn=0x%lx fault=%d\n",
+		     _zi_ino(zi), pmem_bn, fault);
+
+put:
+	if (pmem_bn)
+		_zufs_IO_put_multy(sbi, inode, &io_gb);
+out:
+	zuf_smr_unlock(zii);
+	return fault;
+}
+
+static vm_fault_t zuf_fault(struct vm_fault *vmf)
+{
+	bool write_fault = (0 != (vmf->flags & FAULT_FLAG_WRITE));
+
+	if (write_fault)
+		return zuf_write_fault(vmf->vma, vmf);
+	else
+		return zuf_read_fault(vmf->vma, vmf);
+}
+
+static void zuf_mmap_open(struct vm_area_struct *vma)
+{
+	struct zuf_inode_info *zii = ZUII(file_inode(vma->vm_file));
+
+	atomic_inc(&zii->vma_count);
+}
+
+static void zuf_mmap_close(struct vm_area_struct *vma)
+{
+	struct inode *inode = file_inode(vma->vm_file);
+	int vma_count = atomic_dec_return(&ZUII(inode)->vma_count);
+
+	if (unlikely(vma_count < 0))
+		zuf_err("[%ld] WHAT??? vma_count=%d\n",
+			 inode->i_ino, vma_count);
+	else if (unlikely(vma_count == 0)) {
+		struct zuf_inode_info *zii = ZUII(inode);
+		struct zufs_ioc_mmap_close mmap_close = {};
+		int err;
+
+		mmap_close.hdr.operation = ZUFS_OP_MMAP_CLOSE;
+		mmap_close.hdr.in_len = sizeof(mmap_close);
+
+		mmap_close.zus_ii = zii->zus_ii;
+		mmap_close.rw = 0; /* TODO: Do we need this */
+
+		zuf_smr_lock(zii);
+
+		err = zufc_dispatch(ZUF_ROOT(SBI(inode->i_sb)), &mmap_close.hdr,
+				    NULL, 0);
+		if (unlikely(err))
+			zuf_dbg_err("[%ld] err=%d\n", inode->i_ino, err);
+
+		zuf_smr_unlock(zii);
+	}
+}
+
+static const struct vm_operations_struct zuf_vm_ops = {
+	.fault		= zuf_fault,
+	.pfn_mkwrite	= zuf_pfn_mkwrite,
+	.open           = zuf_mmap_open,
+	.close		= zuf_mmap_close,
+};
+
+int zuf_file_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct inode *inode = file_inode(file);
+	struct zuf_inode_info *zii = ZUII(inode);
+
+	file_accessed(file);
+
+	vma->vm_ops = &zuf_vm_ops;
+
+	atomic_inc(&zii->vma_count);
+
+	zuf_dbg_vfs("[%ld] start=0x%lx end=0x%lx flags=0x%lx page_prot=0x%lx\n",
+		     file->f_mapping->host->i_ino, vma->vm_start, vma->vm_end,
+		     vma->vm_flags, pgprot_val(vma->vm_page_prot));
+
+	return 0;
+}
diff --git a/fs/zuf/rw.c b/fs/zuf/rw.c
index 4048d52b48ba..6107dcb801a3 100644
--- a/fs/zuf/rw.c
+++ b/fs/zuf/rw.c
@@ -649,12 +649,29 @@ static int _fadv_willneed(struct super_block *sb, struct inode *inode,
 	return err;
 }
 
+static int _fadv_dontneed(struct super_block *sb, struct inode *inode,
+			  loff_t offset, loff_t len)
+{
+	struct zufs_ioc_sync ioc_range = {
+		.hdr.in_len = sizeof(ioc_range),
+		.hdr.operation = ZUFS_OP_SYNC,
+		.zus_ii = ZUII(inode)->zus_ii,
+		.offset = offset,
+		.length = len,
+		.flags = ZUFS_SF_DONTNEED,
+	};
+
+	return zufc_dispatch(ZUF_ROOT(SBI(sb)), &ioc_range.hdr, NULL, 0);
+}
+
 int zuf_rw_fadvise(struct super_block *sb, struct inode *inode,
 		   loff_t offset, loff_t len, int advise, bool rand)
 {
 	switch (advise) {
 	case POSIX_FADV_WILLNEED:
 		return _fadv_willneed(sb, inode, offset, len, rand);
+	case POSIX_FADV_DONTNEED:
+		return _fadv_dontneed(sb, inode, offset, len);
 	case POSIX_FADV_NOREUSE: /* TODO */
 	case POSIX_FADV_SEQUENTIAL: /* TODO: turn off random */
 	case POSIX_FADV_NORMAL:
diff --git a/fs/zuf/super.c b/fs/zuf/super.c
index 49f2c62e22b7..91586b92099a 100644
--- a/fs/zuf/super.c
+++ b/fs/zuf/super.c
@@ -734,6 +734,90 @@ static int zuf_update_s_wtime(struct super_block *sb)
 	return 0;
 }
 
+static void _sync_add_inode(struct inode *inode)
+{
+	struct zuf_sb_info *sbi = SBI(inode->i_sb);
+	struct zuf_inode_info *zii = ZUII(inode);
+
+	zuf_dbg_mmap("[%ld] write_mapped=%d\n",
+		      inode->i_ino, atomic_read(&zii->write_mapped));
+
+	spin_lock(&sbi->s_mmap_dirty_lock);
+
+	/* Because we are lazy removing the inodes, only in case of an fsync
+	 * or an evict_inode. It is fine if we are call multiple times.
+	 */
+	if (list_empty(&zii->i_mmap_dirty))
+		list_add(&zii->i_mmap_dirty, &sbi->s_mmap_dirty);
+
+	spin_unlock(&sbi->s_mmap_dirty_lock);
+}
+
+static void _sync_remove_inode(struct inode *inode)
+{
+	struct zuf_sb_info *sbi = SBI(inode->i_sb);
+	struct zuf_inode_info *zii = ZUII(inode);
+
+	zuf_dbg_mmap("[%ld] write_mapped=%d\n",
+		      inode->i_ino, atomic_read(&zii->write_mapped));
+
+	spin_lock(&sbi->s_mmap_dirty_lock);
+	list_del_init(&zii->i_mmap_dirty);
+	spin_unlock(&sbi->s_mmap_dirty_lock);
+}
+
+void zuf_sync_inc(struct inode *inode)
+{
+	struct zuf_inode_info *zii = ZUII(inode);
+
+	if (1 == atomic_inc_return(&zii->write_mapped))
+		_sync_add_inode(inode);
+}
+
+/* zuf_sync_dec will unmapped in batches */
+void zuf_sync_dec(struct inode *inode, ulong write_unmapped)
+{
+	struct zuf_inode_info *zii = ZUII(inode);
+
+	if (0 == atomic_sub_return(write_unmapped, &zii->write_mapped))
+		_sync_remove_inode(inode);
+}
+
+/*
+ * We must fsync any mmap-active inodes
+ */
+static int zuf_sync_fs(struct super_block *sb, int wait)
+{
+	struct zuf_sb_info *sbi = SBI(sb);
+	struct zuf_inode_info *zii, *t;
+	enum {to_clean_size = 120};
+	struct zuf_inode_info *zii_to_clean[to_clean_size];
+	uint i, to_clean;
+
+	zuf_dbg_vfs("Syncing wait=%d\n", wait);
+more_inodes:
+	spin_lock(&sbi->s_mmap_dirty_lock);
+	to_clean = 0;
+	list_for_each_entry_safe(zii, t, &sbi->s_mmap_dirty, i_mmap_dirty) {
+		list_del_init(&zii->i_mmap_dirty);
+		zii_to_clean[to_clean++] = zii;
+		if (to_clean >= to_clean_size)
+			break;
+	}
+	spin_unlock(&sbi->s_mmap_dirty_lock);
+
+	if (!to_clean)
+		return 0;
+
+	for (i = 0; i < to_clean; ++i)
+		zuf_isync(&zii_to_clean[i]->vfs_inode, 0, ~0 - 1, 1);
+
+	if (to_clean == to_clean_size)
+		goto more_inodes;
+
+	return 0;
+}
+
 static struct inode *zuf_alloc_inode(struct super_block *sb)
 {
 	struct zuf_inode_info *zii;
@@ -756,7 +840,11 @@ static void _init_once(void *foo)
 	struct zuf_inode_info *zii = foo;
 
 	inode_init_once(&zii->vfs_inode);
+	INIT_LIST_HEAD(&zii->i_mmap_dirty);
 	zii->zi = NULL;
+	init_rwsem(&zii->in_sync);
+	atomic_set(&zii->vma_count, 0);
+	atomic_set(&zii->write_mapped, 0);
 }
 
 int __init zuf_init_inodecache(void)
@@ -786,6 +874,7 @@ static struct super_operations zuf_sops = {
 	.put_super	= zuf_put_super,
 	.freeze_fs	= zuf_update_s_wtime,
 	.unfreeze_fs	= zuf_update_s_wtime,
+	.sync_fs	= zuf_sync_fs,
 	.statfs		= zuf_statfs,
 	.remount_fs	= zuf_remount,
 	.show_options	= zuf_show_options,
diff --git a/fs/zuf/zuf-core.c b/fs/zuf/zuf-core.c
index 449f47272072..ff04c6912c17 100644
--- a/fs/zuf/zuf-core.c
+++ b/fs/zuf/zuf-core.c
@@ -99,7 +99,9 @@ const char *zuf_op_name(enum e_zufs_operation op)
 		CASE_ENUM_NAME(ZUFS_OP_READ);
 		CASE_ENUM_NAME(ZUFS_OP_PRE_READ);
 		CASE_ENUM_NAME(ZUFS_OP_WRITE);
+		CASE_ENUM_NAME(ZUFS_OP_MMAP_CLOSE);
 		CASE_ENUM_NAME(ZUFS_OP_SETATTR);
+		CASE_ENUM_NAME(ZUFS_OP_SYNC);
 
 		CASE_ENUM_NAME(ZUFS_OP_GET_MULTY);
 		CASE_ENUM_NAME(ZUFS_OP_PUT_MULTY);
diff --git a/fs/zuf/zuf.h b/fs/zuf/zuf.h
index 04e962d7db86..e78515d7a3fe 100644
--- a/fs/zuf/zuf.h
+++ b/fs/zuf/zuf.h
@@ -131,6 +131,9 @@ struct zuf_inode_info {
 
 	/* Stuff for mmap write */
 	struct rw_semaphore	in_sync;
+	struct list_head	i_mmap_dirty;
+	atomic_t		write_mapped;
+	atomic_t		vma_count;
 
 	/* cookies from Server */
 	struct zus_inode	*zi;
diff --git a/fs/zuf/zus_api.h b/fs/zuf/zus_api.h
index 3e7160c48ba8..42d3086a4262 100644
--- a/fs/zuf/zus_api.h
+++ b/fs/zuf/zus_api.h
@@ -463,7 +463,9 @@ enum e_zufs_operation {
 	ZUFS_OP_READ		= 14,
 	ZUFS_OP_PRE_READ	= 15,
 	ZUFS_OP_WRITE		= 16,
+	ZUFS_OP_MMAP_CLOSE	= 17,
 	ZUFS_OP_SETATTR		= 19,
+	ZUFS_OP_SYNC		= 20,
 	ZUFS_OP_FALLOCATE	= 21,
 
 	ZUFS_OP_GET_MULTY	= 29,
@@ -649,6 +651,13 @@ static inline bool zufs_zde_emit(struct zufs_readdir_iter *rdi, __u64 ino,
 }
 #endif /* ndef __cplusplus */
 
+struct zufs_ioc_mmap_close {
+	struct zufs_ioc_hdr hdr;
+	 /* IN */
+	struct zus_inode_info *zus_ii;
+	__u64 rw; /* Some flags + READ or WRITE */
+};
+
 /* ZUFS_OP_SETATTR */
 struct zufs_ioc_attr {
 	struct zufs_ioc_hdr hdr;
@@ -658,6 +667,23 @@ struct zufs_ioc_attr {
 	__u32 pad;
 };
 
+/* ZUFS_OP_SYNC */
+enum ZUFS_SYNC_FLAGS {
+	ZUFS_SF_DATASYNC		= 0x00000001,
+	ZUFS_SF_DONTNEED		= 0x00000100,
+};
+
+struct zufs_ioc_sync {
+	struct zufs_ioc_hdr hdr;
+	/* IN */
+	struct zus_inode_info *zus_ii;
+	__u64 offset, length;
+	__u64 flags;
+
+	/* OUT */
+	__u64 write_unmapped;
+};
+
 /* ~~~~ io_map structures && IOCTL(s) ~~~~ */
 /*
  * These set of structures and helpers are used in return of zufs_ioc_IO and
-- 
2.20.1

