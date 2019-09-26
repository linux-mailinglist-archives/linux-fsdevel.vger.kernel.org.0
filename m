Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4B6ABEA7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 04:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732347AbfIZCNy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 22:13:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37636 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfIZCNy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 22:13:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id i1so797091wro.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2019 19:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wObfJysS/RlUT4xr16i7dOiNQaPqoRhMjGposlvVU7Y=;
        b=A5ztylp+VNDhItVHtNtGgGC34aYwhPcHb1BEIFQYcLH+TjrE1wqOQYCSPaTSnO6DWr
         AldtdY5C1+XW9koFqHzZ9qqV89cz2/6yfRlIdEvFCbvCTwl8EASXp8ArCJRgs+3tsBg4
         yI5wbHtXVh7IwUk1nfEDPi1PTzdPlV0uefZiVBS5Av2uNU4SA4uwE6hqXJWf11Zac8vS
         IFFh0QlIiSCURLvqRH/kH12FJNyVMSJ+54FeNWKdoga0WxBuQ6tMi0qIlm22lkkBXLKP
         /0y3mH1M9iVEJ5dVToEdbGyiiCsaKT//Z4zCWnN0KAPYy4pXsrX1P4N3Xh9RQpFbli9B
         8BFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wObfJysS/RlUT4xr16i7dOiNQaPqoRhMjGposlvVU7Y=;
        b=bxF+iGcmV/0RNXAlP5WRAsjpoMo8OdcC/9/+hrFk0lhoQtPd/v40/6afMO5ZaluLs5
         feJ+d50xxmX9AjuVaDBKsttNAxHEUquDQWXPFfL3zqt6j6ngu4d1BeeksRuSE1tVM3r2
         yNfkQXkIv7t7/3i6XIdCwBQLluz1AfmbBfeIjKQ3nYOYjdyLFl9Tq5Z2coP+4o0fKN6A
         lK7ggxODeI3BjB/NeK5HqKjSie/fVyeDmubIVpSSl6ylLC0QT9+hg/+C/2GAWSosxPzs
         k2NufQXKlBxtkuR5mh+zH+ROM84DP09QtSIUb37bXt4XrFsH+7irejNDwfizTOv1IB8T
         8TxQ==
X-Gm-Message-State: APjAAAWq8UPCE+AHdOt6Ov9pGzN4ceovxvUmA/5OlUOMeguPlZW3bbnw
        +N45fK2QvKoRe4hYedqxtJ3zQmwd1ec=
X-Google-Smtp-Source: APXvYqxUxQk+Mx+itWsU+f+N265U66lyK/ZZwV1YzjpRGK8ZD/6du2CRIlIXfuNny5QGQbUw9GVYxw==
X-Received: by 2002:adf:e4c9:: with SMTP id v9mr839674wrm.396.1569464028718;
        Wed, 25 Sep 2019 19:13:48 -0700 (PDT)
Received: from Bfire.plexistor.com ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id o19sm968751wro.50.2019.09.25.19.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 19:13:48 -0700 (PDT)
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
Subject: [PATCH 12/16] zuf: mmap & sync
Date:   Thu, 26 Sep 2019 05:07:21 +0300
Message-Id: <20190926020725.19601-13-boazh@netapp.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926020725.19601-1-boazh@netapp.com>
References: <20190926020725.19601-1-boazh@netapp.com>
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

[v2]
  zuf: pmem mmap must be 2M aligned

  We only support huge pages on pmem mmap (2M).
  Prevent mmap on pmem with VM addresses unaligned to 2M.

  [Under valgrind it would try to give us address not aligned
   and bypass the zufr_get_unmapped_area(). By returning
   an error valgrind backs off and everything works again
  ]

Signed-off-by: Boaz Harrosh <boazh@netapp.com>
---
 fs/zuf/Makefile   |   2 +-
 fs/zuf/_extern.h  |   6 +
 fs/zuf/file.c     |  66 ++++++++++
 fs/zuf/inode.c    |  10 ++
 fs/zuf/mmap.c     | 300 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/zuf/super.c    |  89 ++++++++++++++
 fs/zuf/t1.c       |   9 ++
 fs/zuf/zuf-core.c |   2 +
 fs/zuf/zuf.h      |   3 +
 fs/zuf/zus_api.h  |  26 ++++
 10 files changed, 512 insertions(+), 1 deletion(-)
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
index 745d0cc9e719..cafda97c973c 100644
--- a/fs/zuf/_extern.h
+++ b/fs/zuf/_extern.h
@@ -64,8 +64,11 @@ int zuf_private_mount(struct zuf_root_info *zri, struct register_fs_info *rfi,
 int zuf_private_umount(struct zuf_root_info *zri, struct super_block *sb);
 struct super_block *zuf_sb_from_id(struct zuf_root_info *zri, __u64 sb_id,
 				   struct zus_sb_info *zus_sbi);
+void zuf_sync_inc(struct inode *inode);
+void zuf_sync_dec(struct inode *inode, ulong write_unmapped);
 
 /* file.c */
+int zuf_isync(struct inode *inode, loff_t start, loff_t end, int datasync);
 long __zuf_fallocate(struct inode *inode, int mode, loff_t offset, loff_t len);
 
 /* namei.c */
@@ -114,6 +117,9 @@ int zuf_iom_execute_async(struct super_block *sb, struct zus_iomap_build *iomb,
 int zuf_rw_file_range_compare(struct inode *i_in, loff_t pos_in,
 			      struct inode *i_out, loff_t pos_out, loff_t len);
 
+/* mmap.c */
+int zuf_file_mmap(struct file *file, struct vm_area_struct *vma);
+
 /* t1.c */
 int zuf_pmem_mmap(struct file *file, struct vm_area_struct *vma);
 
diff --git a/fs/zuf/file.c b/fs/zuf/file.c
index 8711b44371e0..7fcaf085bf8e 100644
--- a/fs/zuf/file.c
+++ b/fs/zuf/file.c
@@ -23,6 +23,70 @@ long __zuf_fallocate(struct inode *inode, int mode, loff_t offset, loff_t len)
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
 static ssize_t zuf_read_iter(struct kiocb *kiocb, struct iov_iter *ii)
 {
 	struct inode *inode = file_inode(kiocb->ki_filp);
@@ -95,6 +159,8 @@ const struct file_operations zuf_file_operations = {
 	.open			= generic_file_open,
 	.read_iter		= zuf_read_iter,
 	.write_iter		= zuf_write_iter,
+	.mmap			= zuf_file_mmap,
+	.fsync			= zuf_fsync,
 };
 
 const struct inode_operations zuf_file_inode_operations = {
diff --git a/fs/zuf/inode.c b/fs/zuf/inode.c
index 27660979ed6f..1e3dba654f34 100644
--- a/fs/zuf/inode.c
+++ b/fs/zuf/inode.c
@@ -271,6 +271,7 @@ void zuf_evict_inode(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	struct zuf_inode_info *zii = ZUII(inode);
+	int write_mapped;
 
 	if (!inode->i_nlink) {
 		if (unlikely(!zii->zi)) {
@@ -311,6 +312,15 @@ void zuf_evict_inode(struct inode *inode)
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
diff --git a/fs/zuf/super.c b/fs/zuf/super.c
index abd7e6cb2a4a..2a0db11b51d6 100644
--- a/fs/zuf/super.c
+++ b/fs/zuf/super.c
@@ -737,6 +737,90 @@ static int zuf_update_s_wtime(struct super_block *sb)
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
@@ -759,7 +843,11 @@ static void _init_once(void *foo)
 	struct zuf_inode_info *zii = foo;
 
 	inode_init_once(&zii->vfs_inode);
+	INIT_LIST_HEAD(&zii->i_mmap_dirty);
 	zii->zi = NULL;
+	init_rwsem(&zii->in_sync);
+	atomic_set(&zii->vma_count, 0);
+	atomic_set(&zii->write_mapped, 0);
 }
 
 int __init zuf_init_inodecache(void)
@@ -789,6 +877,7 @@ static struct super_operations zuf_sops = {
 	.put_super	= zuf_put_super,
 	.freeze_fs	= zuf_update_s_wtime,
 	.unfreeze_fs	= zuf_update_s_wtime,
+	.sync_fs	= zuf_sync_fs,
 	.statfs		= zuf_statfs,
 	.remount_fs	= zuf_remount,
 	.show_options	= zuf_show_options,
diff --git a/fs/zuf/t1.c b/fs/zuf/t1.c
index 46ea7f6181fc..1f2db5a674d5 100644
--- a/fs/zuf/t1.c
+++ b/fs/zuf/t1.c
@@ -124,6 +124,15 @@ int zuf_pmem_mmap(struct file *file, struct vm_area_struct *vma)
 	if (!zsf || zsf->type != zlfs_e_pmem)
 		return -EPERM;
 
+	/* Valgrined may interfere with our 2M mmap aligned vma start
+	 * (See zufr_get_unmapped_area). Tell the guys to back off
+	 */
+	if (unlikely(vma->vm_start & ~PMD_MASK)) {
+		zuf_err("mmap is not 2M aligned vm_start=0x%lx\n",
+				vma->vm_start);
+		return -EINVAL;
+	}
+
 	vma->vm_flags |= VM_HUGEPAGE;
 	vma->vm_ops = &t1_vm_ops;
 
diff --git a/fs/zuf/zuf-core.c b/fs/zuf/zuf-core.c
index 11300fd79929..cb4a4def646f 100644
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
index 2c57c51a2099..fe479cb70f97 100644
--- a/fs/zuf/zuf.h
+++ b/fs/zuf/zuf.h
@@ -132,6 +132,9 @@ struct zuf_inode_info {
 
 	/* Stuff for mmap write */
 	struct rw_semaphore	in_sync;
+	struct list_head	i_mmap_dirty;
+	atomic_t		write_mapped;
+	atomic_t		vma_count;
 
 	/* cookies from Server */
 	struct zus_inode	*zi;
diff --git a/fs/zuf/zus_api.h b/fs/zuf/zus_api.h
index e3a783748ce6..e70bd8b7ff69 100644
--- a/fs/zuf/zus_api.h
+++ b/fs/zuf/zus_api.h
@@ -459,7 +459,9 @@ enum e_zufs_operation {
 	ZUFS_OP_READ		= 14,
 	ZUFS_OP_PRE_READ	= 15,
 	ZUFS_OP_WRITE		= 16,
+	ZUFS_OP_MMAP_CLOSE	= 17,
 	ZUFS_OP_SETATTR		= 19,
+	ZUFS_OP_SYNC		= 20,
 	ZUFS_OP_FALLOCATE	= 21,
 
 	ZUFS_OP_GET_MULTY	= 29,
@@ -645,6 +647,13 @@ static inline bool zufs_zde_emit(struct zufs_readdir_iter *rdi, __u64 ino,
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
@@ -654,6 +663,23 @@ struct zufs_ioc_attr {
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
2.21.0

