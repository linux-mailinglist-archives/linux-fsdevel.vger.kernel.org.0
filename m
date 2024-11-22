Return-Path: <linux-fsdevel+bounces-35604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9D69D64EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 21:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8143F1617E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 20:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1915A18870F;
	Fri, 22 Nov 2024 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5a1lVs+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1697B17B428
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732307935; cv=none; b=JWcvlVtVDsqc2hiRbOAD4tI4zVU3CZHIEGtg63pyQTtNhOWPadr1eoxAhfJtum/i9YZWfDxO+NUPJ2G71UnIBCLj6iGD7mBMrWFKGrIJiVkJHcjlats5nyefNso5hCK7UVD8yrmAxlYGKz4zXmrrnyry5mrxY+Ea/Q2UJXl6+x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732307935; c=relaxed/simple;
	bh=gGtI5P/MJV/wLpXhshQc6As3k2RtJRqrL/omL+D2zFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cat6NHyDeZ/CDGaakvdxc/Ih4r+mTPjgd6O4O/yg7U6Pq0kNt7Qe7l1MCMgHU75MH5GAM1Xv4qfHMT/CQcfLM/t3Wbmix89akObXWFZoLYXq1rcuiVbaU7vGDieh5LLQmxlx6dvwgh+yso6uwFoX1/NBUilpFJ/wNUuJzdjFKDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5a1lVs+; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a7222089aaso9868095ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 12:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732307932; x=1732912732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCXfx2p9j24LDeZHTikLC43EcClPxrOAh9xxUfo2iK4=;
        b=X5a1lVs+TAR21W0JKsZZ+rCJ1ArVlT5GFxrO6oy5DMcbDZyDUncBj+AiGbYyPO+L+F
         Xx1H0Xcm8jZi6mNjq9uegVjeffrVVu0x5WkIegbThdmeABtffl9BbPN81J/IaJKh/Aq/
         v79vb5nVIN4n2Vx6IMLsJJZCeGy8L/EZbsb78TAqAAkhEA1wslfhQ874CTCVvIMhmZQa
         N0Y77Uo/lapdEC9wkbFY5tHxenhhYT1FS9rNVHQ4fRfj6zQPsf7ZsB5/Lun8HCqiWR6P
         iA2DpvPzFOg25un49pd9ZcTL+ug3BWkyU1bwM1dSWltDzAlUfuENLC5jfG7Y0LjUnL0u
         H+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732307932; x=1732912732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCXfx2p9j24LDeZHTikLC43EcClPxrOAh9xxUfo2iK4=;
        b=tUApEK3PmYPm41u10EHwyiZKAGWckbxNFDqOX9jm5IMsDc+gHeajK7NeP6XyswVcsn
         qx0eTFsQSX0l8L9PSnpDNIa8jVH3z8YetdYsdG7Ck/3tir7q/IezrJVFI/Fx3G1IeGtv
         qP511z4NU2LL12d2kZMyG/gKH/i5nG6GfvDI0tz7/MzO3QEXt9I0Zyq3gTGx3qU/smCM
         9zKeNUqrqB2o5G9h2qmTMkVWb180KIjcZtKYMprrDpZVpVoe/oXlsaP2xsQTC0OHEeE4
         m8Jt4j3lLyuObjQcFrKFjFCDNlf2rQHBRJ/ChiqXke1/n+f5ZKUK6ysqu5QoNeJabEHR
         27EQ==
X-Gm-Message-State: AOJu0YwabaHuXCZMnLbyzvm9MV2qKSxDSvamqfHqLvlosPuqn4OOHCMT
	JwfUuGqDJTn1XwA2mUn5AXLQJ9tZZisjYbDoeeVpCCHejW8vR6s6CxJ3Cq8s
X-Gm-Gg: ASbGncuWMgEImGRj+ab/lKHQ1R3zzdo2z4D7SdM4v66zjTvh5GyGfzGBO7xEyQF4rlK
	hTZsB8N65WzsYcwg7PKeHuw7vvJwxcD450InJJG90sQxV1rsX60w7mCb15x3/CAmXp+6lshTwKn
	LQsvurRdb8N/QeKHrAC2dvN7dt7nD+CRlB8I+biBVNdj3ohDU5UA1NfD1FTonzDZJpJM7B0E67S
	v0Ei5TJ2SchMB/cKTOA2ffEt11HmHV99gnccwxir5OoCbaO3bO5abmK1JluUaiR09Vs92ZiNuw=
X-Google-Smtp-Source: AGHT+IGhAevHULnuw2kVw09A4K8gopPCWCRR5mKOHt8mTprpWkBU3zWTbyGNcMgt0jm5HEZ5jaRiQw==
X-Received: by 2002:a92:db11:0:b0:3a7:a352:213d with SMTP id e9e14a558f8ab-3a7a352237bmr30117455ab.7.1732307931628;
        Fri, 22 Nov 2024 12:38:51 -0800 (PST)
Received: from manaslu.cs.wisc.edu (manaslu.cs.wisc.edu. [128.105.15.4])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e1cfe52506sm794682173.77.2024.11.22.12.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 12:38:51 -0800 (PST)
From: Bijan Tabatabai <bijan311@gmail.com>
X-Google-Original-From: Bijan Tabatabai <btabatabai@wisc.edu>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	btabatabai@wisc.edu
Cc: akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	mingo@redhat.com
Subject: [RFC PATCH 1/4] mm: Add support for File Based Memory Management
Date: Fri, 22 Nov 2024 14:38:27 -0600
Message-Id: <20241122203830.2381905-2-btabatabai@wisc.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122203830.2381905-1-btabatabai@wisc.edu>
References: <20241122203830.2381905-1-btabatabai@wisc.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces File Based Memory Management (FBMM), which allows for
memory managers that are written as filesystems, similar to HugeTLBFS, to
be used transparently by applications.

The steps for using FBMM are the following:
1) Mount the memory management filesystem (MFS)
2) Enable FBMM by writing 1 to /sys/kernel/mm/fbmm/state
3) Set the MFS an application should allocate its memory from by writing
the MFS's mount directory to /proc/<pid>/fbmm_mnt_dir, where <pid> is the
PID of the target process.

To have a process use an MFS for the entirety of the execution, one could
use a shim program that writes /proc/self/fbmm_mount_dir then calls exec
for the target process. We have created such a shim, which can be found
at [1].

Providing this transparency is useful since it allows applications to use
an arbitrary MFS to mange its memory without having to modify that
application.

Writing memory management functionality as an MFS is useful for more easily
prototyping MM functionality and maintaining support for a variety of
different hardware configurations or application needs.

FBMM was originally created as a research project at the University of
Wisconsin-Madison [2].

The core of FBMM is found in fs/file_based_mm.c. Other parts of the kernel
call into functions in that file to allow processes to allocate their
memory from an MFS without changing the application's code. For example,
the do_mmap function is modified so that when it is called with the
MAP_ANONYMOUS flag by a process using FBMM, fbmm_get_file is called to
acquire a file in the MFS used by the process along with the page offset to
map that file to. do_mmap then proceeds to map that file instead of
anonymous memory, allowing the desired MFS to control the memory behavior
of the mapped region. A similar process happens inside of the brk syscall
implementation. Another example is handle_mm_fault being modified to call
fbmm_fault for regions using FBMM which will invoke the MFS's page fault
handler.

The main overhead of FBMM comes from creating the files for the process
to memory map. To ammortize this cost, we give files created by FBMM a
large virtual size (currently 128GB) and have multiple calls to mmap/brk
share a file. The fbmm_get_file function handles this logic. It takes the
size of a new allocation and the virtual address it will be mapped to. On
a process's first call to fbmm_get_file, it creates a new file and assigns
the file a virtual address range that it can be mapped to. Files created by
FBMM are added to a per-process tree indexed by the files's virtual address
range. On subsequent calls to fbmm_get_file, it searches the tree for a
file that can fit the new memory allocation. If such a file does not exist,
a new file is created and added to the tree of files.

A pointer to a fbmm_info struct is added to task_struct to keep track of
the state used by FBMM. This includes the path to the MFS used by the
process and the tree of files used by the process.

Signed-off-by: Bijan Tabatabai <btabatabai@wisc.edu>

[1] https://github.com/multifacet/fbmm-workspace/blob/main/bmks/fbmm_wrapper.c
[2] https://www.usenix.org/conference/atc24/presentation/tabatabai
---
 fs/Kconfig                    |   7 +
 fs/Makefile                   |   1 +
 fs/file_based_mm.c            | 564 ++++++++++++++++++++++++++++++++++
 fs/proc/base.c                |   4 +
 include/linux/file_based_mm.h |  81 +++++
 include/linux/mm.h            |  10 +
 include/linux/sched.h         |   4 +
 kernel/exit.c                 |   3 +
 kernel/fork.c                 |   3 +
 mm/gup.c                      |   1 +
 mm/memory.c                   |   2 +
 mm/mmap.c                     |  42 ++-
 12 files changed, 719 insertions(+), 3 deletions(-)
 create mode 100644 fs/file_based_mm.c
 create mode 100644 include/linux/file_based_mm.h

diff --git a/fs/Kconfig b/fs/Kconfig
index a46b0cbc4d8f..52994b2491fe 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -96,6 +96,13 @@ config FS_DAX_PMD
 	depends on ZONE_DEVICE
 	depends on TRANSPARENT_HUGEPAGE
 
+config FILE_BASED_MM
+	bool "File Based Memory Management"
+	help
+	  This option enables file based memory management (FBMM). FBMM allows users
+	  to have a process transparently allocate its memory from a memory manager
+	  that is written as a filesystem.
+
 # Selected by DAX drivers that do not expect filesystem DAX to support
 # get_user_pages() of DAX mappings. I.e. "limited" indicates no support
 # for fork() of processes with MAP_SHARED mappings or support for
diff --git a/fs/Makefile b/fs/Makefile
index 6ecc9b0a53f2..f1a5e540fe72 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_FS_POSIX_ACL)	+= posix_acl.o
 obj-$(CONFIG_NFS_COMMON)	+= nfs_common/
 obj-$(CONFIG_COREDUMP)		+= coredump.o
 obj-$(CONFIG_SYSCTL)		+= drop_caches.o sysctls.o
+obj-$(CONFIG_FILE_BASED_MM)	+= file_based_mm.o
 
 obj-$(CONFIG_FHANDLE)		+= fhandle.o
 obj-y				+= iomap/
diff --git a/fs/file_based_mm.c b/fs/file_based_mm.c
new file mode 100644
index 000000000000..c05797d51cb3
--- /dev/null
+++ b/fs/file_based_mm.c
@@ -0,0 +1,564 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/types.h>
+#include <linux/file_based_mm.h>
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
+#include <linux/namei.h>
+#include <linux/fs.h>
+#include <linux/mman.h>
+#include <linux/security.h>
+#include <linux/vmalloc.h>
+#include <linux/falloc.h>
+#include <linux/timekeeping.h>
+#include <linux/maple_tree.h>
+#include <linux/sched.h>
+#include <linux/kthread.h>
+#include <linux/pagemap.h>
+#include <linux/mm.h>
+
+#include "proc/internal.h"
+
+enum file_based_mm_state {
+	FBMM_OFF = 0,
+	FBMM_ON = 1,
+};
+
+#define FBMM_DEFAULT_FILE_SIZE (128L << 30)
+struct fbmm_file {
+	struct file *f;
+	/* The starting virtual address assigned to this file (inclusive) */
+	unsigned long va_start;
+	/* The ending virtual address assigned to this file (exclusive) */
+	unsigned long va_end;
+};
+
+static enum file_based_mm_state fbmm_state = FBMM_OFF;
+
+const int GUA_OPEN_FLAGS = O_EXCL | O_TMPFILE | O_RDWR;
+const umode_t GUA_OPEN_MODE = S_IFREG | 0600;
+
+static struct fbmm_info *fbmm_create_new_info(char *mnt_dir_str)
+{
+	struct fbmm_info *info;
+	int ret;
+
+	info = kmalloc(sizeof(struct fbmm_info), GFP_KERNEL);
+	if (!info)
+		return NULL;
+
+	info->mnt_dir_str = mnt_dir_str;
+	ret = kern_path(mnt_dir_str, LOOKUP_DIRECTORY | LOOKUP_FOLLOW, &info->mnt_dir_path);
+	if (ret) {
+		kfree(info);
+		return NULL;
+	}
+
+	info->get_unmapped_area_file = file_open_root(&info->mnt_dir_path, "",
+		GUA_OPEN_FLAGS, GUA_OPEN_MODE);
+	if (IS_ERR(info->get_unmapped_area_file)) {
+		path_put(&info->mnt_dir_path);
+		kfree(info);
+		return NULL;
+	}
+
+	mt_init(&info->files_mt);
+
+	return info;
+}
+
+static void drop_fbmm_file(struct fbmm_file *file)
+{
+	if (atomic_dec_return(&file->refcount) == 0) {
+		fput(file->f);
+		kfree(file);
+	}
+}
+
+static pmdval_t fbmm_alloc_pmd(struct vm_fault *vmf)
+{
+	struct mm_struct *mm = vmf->vma->vm_mm;
+	unsigned long address = vmf->address;
+	pgd_t *pgd;
+	p4d_t *p4d;
+
+	pgd = pgd_offset(mm, address);
+	p4d = p4d_alloc(mm, pgd, address);
+	if (!p4d)
+		return VM_FAULT_OOM;
+
+	vmf->pud = pud_alloc(mm, p4d, address);
+	if (!vmf->pud)
+		return VM_FAULT_OOM;
+
+	vmf->pmd = pmd_alloc(mm, vmf->pud, address);
+	if (!vmf->pmd)
+		return VM_FAULT_OOM;
+
+	vmf->orig_pmd = pmdp_get_lockless(vmf->pmd);
+
+	return pmd_val(*vmf->pmd);
+}
+
+inline bool is_vm_fbmm_page(struct vm_area_struct *vma)
+{
+	return !!(vma->vm_flags & VM_FBMM);
+}
+
+int fbmm_fault(struct vm_area_struct *vma, unsigned long address, unsigned int flags)
+{
+	struct vm_fault vmf = {
+		.vma = vma,
+		.address = address & PAGE_MASK,
+		.real_address = address,
+		.flags = flags,
+		.pgoff = linear_page_index(vma, address),
+		.gfp_mask = mapping_gfp_mask(vma->vm_file->f_mapping) | __GFP_FS | __GFP_IO,
+	};
+
+	if (fbmm_alloc_pmd(&vmf) == VM_FAULT_OOM)
+		return VM_FAULT_OOM;
+
+	return vma->vm_ops->fault(&vmf);
+}
+
+bool use_file_based_mm(struct task_struct *tsk)
+{
+	if (fbmm_state == FBMM_OFF)
+		return false;
+	else
+		return tsk->fbmm_info && tsk->fbmm_info->mnt_dir_str;
+}
+
+unsigned long fbmm_get_unmapped_area(unsigned long addr, unsigned long len,
+		unsigned long pgoff, unsigned long flags)
+{
+	struct fbmm_info *info;
+
+	info = current->fbmm_info;
+	if (!info)
+		return -EINVAL;
+
+	return get_unmapped_area(info->get_unmapped_area_file, addr, len, pgoff, flags);
+}
+
+struct file *fbmm_get_file(struct task_struct *tsk, unsigned long addr, unsigned long len,
+		unsigned long prot, int flags, bool topdown, unsigned long *pgoff)
+{
+	struct file *f;
+	struct fbmm_file *fbmm_file;
+	struct fbmm_info *info;
+	struct path *path;
+	int open_flags = O_EXCL | O_TMPFILE;
+	unsigned long truncate_len;
+	umode_t open_mode = S_IFREG;
+	s64 ret = 0;
+
+	info = tsk->fbmm_info;
+	if (!info)
+		return NULL;
+
+	/* Does a file exist that will already fit this mmap call? */
+	fbmm_file = mt_prev(&info->files_mt, addr + 1, 0);
+	if (fbmm_file) {
+		/*
+		 * Just see if this mmap will fit inside the file.
+		 * We don't need to check if other mappings in the file overlap
+		 * because get_unmapped_area should have done that already.
+		 */
+		if (fbmm_file->va_start <= addr && addr + len <= fbmm_file->va_end) {
+			f = fbmm_file->f;
+			goto end;
+		}
+	}
+
+	/* Determine what flags to use for the call to open */
+	if (prot & PROT_EXEC)
+		open_mode |= 0100;
+
+	if ((prot & (PROT_READ | PROT_WRITE)) == (PROT_READ | PROT_WRITE)) {
+		open_flags |= O_RDWR;
+		open_mode |= 0600;
+	} else if (prot & PROT_WRITE) {
+		open_flags |= O_WRONLY;
+		open_mode |= 0200;
+	} else if (prot & PROT_READ) {
+		/* It doesn't make sense for anon memory to be read only */
+		return NULL;
+	}
+
+	path = &info->mnt_dir_path;
+	f = file_open_root(path, "", open_flags, open_mode);
+	if (IS_ERR(f))
+		return NULL;
+
+	/*
+	 * It takes time to create new files and create new VMAs for mappings
+	 * with different files, so we want to create huge files that we can reuse
+	 * for different calls to mmap
+	 */
+	if (len < FBMM_DEFAULT_FILE_SIZE)
+		truncate_len = FBMM_DEFAULT_FILE_SIZE;
+	else
+		truncate_len = len;
+	ret = vfs_truncate(&f->f_path, truncate_len);
+	if (ret) {
+		filp_close(f, current->files);
+		return (struct file *)ret;
+	}
+
+	fbmm_file = kmalloc(sizeof(struct fbmm_file), GFP_KERNEL);
+	if (!fbmm_file) {
+		filp_close(f, current->files);
+		return NULL;
+	}
+	fbmm_file->f = f;
+	if (topdown) {
+		/*
+		 * Since VAs in this region grow down, this mapping will be the
+		 * "end" of the file
+		 */
+		fbmm_file->va_end = addr + len;
+		fbmm_file->va_start = fbmm_file->va_end - truncate_len;
+	} else {
+		fbmm_file->va_start = addr;
+		fbmm_file->va_end = addr + truncate_len;
+	}
+
+	mtree_store(&info->files_mt, fbmm_file->va_start, fbmm_file, GFP_KERNEL);
+
+end:
+	if (f && !IS_ERR(f))
+		*pgoff = (addr - fbmm_file->va_start) >> PAGE_SHIFT;
+
+	return f;
+}
+
+void fbmm_populate_file(unsigned long start, unsigned long len)
+{
+	struct fbmm_info *info;
+	struct fbmm_file *file = NULL;
+	loff_t offset;
+
+	info = current->fbmm_info;
+	if (!info)
+		return;
+
+	file = mt_prev(&info->files_mt, start, 0);
+	if (!file || file->va_end <= start)
+		return;
+
+	offset = start - file->va_start;
+	vfs_fallocate(file->f, 0, offset, len);
+}
+
+int fbmm_munmap(struct task_struct *tsk, unsigned long start, unsigned long len)
+{
+	struct fbmm_info *info = NULL;
+	struct fbmm_file *fbmm_file = NULL;
+	struct fbmm_file *prev_file = NULL;
+	unsigned long end = start + len;
+	unsigned long falloc_start_offset, falloc_end_offset, falloc_len;
+	int ret = 0;
+
+	info = tsk->fbmm_info;
+	if (!info)
+		return 0;
+
+	/*
+	 * Finds the last (by va_start) mapping where file->va_start <= start, so we have to
+	 * check this file is actually within the range
+	 */
+	fbmm_file = mt_prev(&info->files_mt, start + 1, 0);
+	if (!fbmm_file || fbmm_file->va_end <= start)
+		goto exit;
+
+	/*
+	 * Since the ranges overlap, we have to keep going backwards until we
+	 * the first mapping where file->va_start <= start and file->va_end > start
+	 */
+	while (1) {
+		prev_file = mt_prev(&info->files_mt, fbmm_file->va_start, 0);
+		if (!prev_file || prev_file->va_end <= start)
+			break;
+		fbmm_file = prev_file;
+	}
+
+	/*
+	 * A munmap call can span multiple memory ranges, so we might have to do this
+	 * multiple times
+	 */
+	while (fbmm_file) {
+		if (start > fbmm_file->va_start)
+			falloc_start_offset = start - fbmm_file->va_start;
+		else
+			falloc_start_offset = 0;
+
+		if (fbmm_file->va_end <= end)
+			falloc_end_offset = fbmm_file->va_end - fbmm_file->va_start;
+		else
+			falloc_end_offset = end - fbmm_file->va_start;
+
+		falloc_len = falloc_end_offset - falloc_start_offset;
+
+		ret = vfs_fallocate(fbmm_file->f,
+				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				falloc_start_offset, falloc_len);
+
+		fbmm_file = mt_next(&info->files_mt, fbmm_file->va_start, ULONG_MAX);
+		if (!fbmm_file || fbmm_file->va_end <= start)
+			break;
+	}
+
+exit:
+	return ret;
+}
+
+static void fbmm_free_info(struct task_struct *tsk)
+{
+	struct fbmm_file *file;
+	struct fbmm_info *info = tsk->fbmm_info;
+	unsigned long index = 0;
+
+	mt_for_each(&info->files_mt, file, index, ULONG_MAX) {
+		drop_fbmm_file(file);
+	}
+	mtree_destroy(&info->files_mt);
+
+	if (info->mnt_dir_str) {
+		path_put(&info->mnt_dir_path);
+		fput(info->get_unmapped_area_file);
+		kfree(info->mnt_dir_str);
+	}
+	kfree(info);
+}
+
+void fbmm_exit(struct task_struct *tsk)
+{
+	if (tsk->tgid != tsk->pid)
+		return;
+
+	if (!tsk->fbmm_info)
+		return;
+
+	fbmm_free_info(tsk);
+}
+
+int fbmm_copy(struct task_struct *src_tsk, struct task_struct *dst_tsk, u64 clone_flags)
+{
+	struct fbmm_info *info;
+	char *buffer;
+	char *src_dir;
+
+	/* If this new task is just a thread, not a new process, just copy fbmm info */
+	if (clone_flags & CLONE_THREAD) {
+		dst_tsk->fbmm_info = src_tsk->fbmm_info;
+		return 0;
+	}
+
+	/* Does the src actually have a default mnt dir */
+	if (!use_file_based_mm(src_tsk)) {
+		dst_tsk->fbmm_info = NULL;
+		return 0;
+	}
+	info = src_tsk->fbmm_info;
+
+	/* Make a new fbmm_info with the same mnt dir */
+	src_dir = info->mnt_dir_str;
+
+	buffer = kstrndup(src_dir, PATH_MAX, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	dst_tsk->fbmm_info = fbmm_create_new_info(buffer);
+	if (!dst_tsk->fbmm_info) {
+		kfree(buffer);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static ssize_t fbmm_state_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", fbmm_state);
+}
+
+static ssize_t fbmm_state_store(struct kobject *kobj,
+		struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	int state;
+	int ret;
+
+	ret = kstrtoint(buf, 0, &state);
+
+	if (ret != 0) {
+		fbmm_state = FBMM_OFF;
+		return ret;
+	} else if (state == 0) {
+		fbmm_state = FBMM_OFF;
+	} else {
+		fbmm_state = FBMM_ON;
+	}
+	return count;
+}
+static struct kobj_attribute fbmm_state_attribute =
+__ATTR(state, 0644, fbmm_state_show, fbmm_state_store);
+
+static struct attribute *file_based_mm_attr[] = {
+	&fbmm_state_attribute.attr,
+	NULL,
+};
+
+static const struct attribute_group file_based_mm_attr_group = {
+	.attrs = file_based_mm_attr,
+};
+
+static ssize_t fbmm_mnt_dir_read(struct file *file, char __user *ubuf,
+		size_t count, loff_t *ppos)
+{
+	struct task_struct *task = get_proc_task(file_inode(file));
+	char *buffer;
+	struct fbmm_info *info;
+	size_t len, ret;
+
+	if (!task)
+		return -ESRCH;
+
+	buffer = kmalloc(PATH_MAX + 1, GFP_KERNEL);
+	if (!buffer) {
+		put_task_struct(task);
+		return -ENOMEM;
+	}
+
+	info = task->fbmm_info;
+	if (info && info->mnt_dir_str)
+		len = sprintf(buffer, "%s\n", info->mnt_dir_str);
+	else
+		len = sprintf(buffer, "not enabled\n");
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, buffer, len);
+
+	kfree(buffer);
+	put_task_struct(task);
+
+	return ret;
+}
+
+static ssize_t fbmm_mnt_dir_write(struct file *file, const char __user *ubuf,
+		size_t count, loff_t *ppos)
+{
+	struct task_struct *task;
+	struct path p;
+	char *buffer;
+	struct fbmm_info *info;
+	int ret = 0;
+
+	if (count > PATH_MAX)
+		return -ENOMEM;
+
+	buffer = kmalloc(count + 1, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	if (copy_from_user(buffer, ubuf, count)) {
+		kfree(buffer);
+		return -EFAULT;
+	}
+	buffer[count] = 0;
+
+	/*
+	 * echo likes to put an extra \n at the end of the string
+	 * if it's there, remove it
+	 */
+	if (buffer[count - 1] == '\n')
+		buffer[count - 1] = 0;
+
+	task = get_proc_task(file_inode(file));
+	if (!task) {
+		kfree(buffer);
+		return -ESRCH;
+	}
+
+	/* Check if the given path is actually a valid directory */
+	ret = kern_path(buffer, LOOKUP_DIRECTORY | LOOKUP_FOLLOW, &p);
+	if (!ret) {
+		path_put(&p);
+		info = task->fbmm_info;
+
+		if (!info) {
+			info = fbmm_create_new_info(buffer);
+			task->fbmm_info = info;
+			if (!info)
+				ret = -ENOMEM;
+		} else {
+			/*
+			 * Cleanup the old directory info, but keep the fbmm files
+			 * stuff because the application may still be using them
+			 */
+			if (info->mnt_dir_str) {
+				path_put(&info->mnt_dir_path);
+				fput(info->get_unmapped_area_file);
+				kfree(info->mnt_dir_str);
+			}
+
+			info->mnt_dir_str = buffer;
+			ret = kern_path(buffer, LOOKUP_DIRECTORY | LOOKUP_FOLLOW,
+				&info->mnt_dir_path);
+			if (ret)
+				goto end;
+
+			fput(info->get_unmapped_area_file);
+			info->get_unmapped_area_file = file_open_root(&info->mnt_dir_path, "",
+				GUA_OPEN_FLAGS, GUA_OPEN_MODE);
+			if (IS_ERR(info->get_unmapped_area_file))
+				ret = PTR_ERR(info->get_unmapped_area_file);
+		}
+	} else {
+		kfree(buffer);
+
+		info = task->fbmm_info;
+		if (info && info->mnt_dir_str) {
+			kfree(info->mnt_dir_str);
+			path_put(&info->mnt_dir_path);
+			fput(info->get_unmapped_area_file);
+			info->mnt_dir_str = NULL;
+		}
+	}
+
+end:
+	put_task_struct(task);
+	if (ret)
+		return ret;
+	return count;
+}
+
+const struct file_operations proc_fbmm_mnt_dir = {
+	.read = fbmm_mnt_dir_read,
+	.write = fbmm_mnt_dir_write,
+	.llseek = default_llseek,
+};
+
+
+static int __init file_based_mm_init(void)
+{
+	struct kobject *fbmm_kobj;
+	int err;
+
+	fbmm_kobj = kobject_create_and_add("fbmm", mm_kobj);
+	if (unlikely(!fbmm_kobj)) {
+		pr_warn("failed to create the fbmm kobject\n");
+		return -ENOMEM;
+	}
+
+	err = sysfs_create_group(fbmm_kobj, &file_based_mm_attr_group);
+	if (err) {
+		pr_warn("failed to register the fbmm group\n");
+		kobject_put(fbmm_kobj);
+		return err;
+	}
+
+	return 0;
+}
+subsys_initcall(file_based_mm_init);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 72a1acd03675..ef5688f0ab95 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -97,6 +97,7 @@
 #include <linux/resctrl.h>
 #include <linux/cn_proc.h>
 #include <linux/ksm.h>
+#include <linux/file_based_mm.h>
 #include <uapi/linux/lsm.h>
 #include <trace/events/oom.h>
 #include "internal.h"
@@ -3359,6 +3360,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
 	ONE("ksm_stat",  S_IRUSR, proc_pid_ksm_stat),
 #endif
+#ifdef CONFIG_FILE_BASED_MM
+	REG("fbmm_mnt_dir", S_IRUGO|S_IWUSR, proc_fbmm_mnt_dir),
+#endif
 };
 
 static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
diff --git a/include/linux/file_based_mm.h b/include/linux/file_based_mm.h
new file mode 100644
index 000000000000..c1c5e82e36ec
--- /dev/null
+++ b/include/linux/file_based_mm.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _FILE_BASED_MM_H_
+#define _FILE_BASED_MM_H_
+
+#include <linux/types.h>
+#include <linux/mm_types.h>
+#include <linux/fs.h>
+#include <linux/maple_tree.h>
+
+struct fbmm_info {
+	char *mnt_dir_str;
+	struct path mnt_dir_path;
+	/* This file exists just to be passed to get_unmapped_area in mmap */
+	struct file *get_unmapped_area_file;
+	struct maple_tree files_mt;
+};
+
+
+#ifdef CONFIG_FILE_BASED_MM
+extern const struct file_operations proc_fbmm_mnt_dir;
+
+bool use_file_based_mm(struct task_struct *task);
+
+bool is_vm_fbmm_page(struct vm_area_struct *vma);
+int fbmm_fault(struct vm_area_struct *vma, unsigned long address, unsigned int flags);
+unsigned long fbmm_get_unmapped_area(unsigned long addr, unsigned long len, unsigned long pgoff,
+	unsigned long flags);
+struct file *fbmm_get_file(struct task_struct *tsk, unsigned long addr, unsigned long len,
+	unsigned long prot, int flags, bool topdown, unsigned long *pgoff);
+void fbmm_populate_file(unsigned long start, unsigned long len);
+int fbmm_munmap(struct task_struct *tsk, unsigned long start, unsigned long len);
+void fbmm_exit(struct task_struct *tsk);
+int fbmm_copy(struct task_struct *src_tsk, struct task_struct *dst_tsk, u64 clone_flags);
+
+#else /* CONFIG_FILE_BASED_MM */
+
+static inline bool is_vm_fbmm_page(struct vm_area_struct *vma)
+{
+	return 0;
+}
+
+static inline bool use_file_based_mm(struct task_struct *tsk)
+{
+	return false;
+}
+
+static inline int fbmm_fault(struct vm_area_struct *vma, unsigned long address, unsigned int flags)
+{
+	return 0;
+}
+
+static inline unsigned long fbmm_get_unmapped_area(unsigned long addr, unsigned long len,
+		unsigned long pgoff, unsigned long flags)
+{
+	return 0;
+}
+
+static inline struct file *fbmm_get_file(struct task_struct *tsk, unsigned long addr,
+		unsigned long len, unsigned long prot, int flags, bool topdown,
+		unsigned long *pgoff)
+{
+	return NULL;
+}
+
+static inline void fbmm_populate_file(unsigned long start, unsigned long len) {}
+
+static inline int fbmm_munmap(struct task_struct *tsk, unsigned long start, unsigned long len)
+{
+	return 0;
+}
+
+static inline void fbmm_exit(struct task_struct *tsk) {}
+
+static inline int fbmm_copy(struct task_struct *src_tsk, struct task_struct *dst_tsk,
+		u64 clone_flags)
+{
+	return 0;
+}
+#endif /* CONFIG_FILE_BASED_MM */
+
+#endif /* __FILE_BASED_MM_H */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index eb7c96d24ac0..614d40ef249a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -31,6 +31,7 @@
 #include <linux/kasan.h>
 #include <linux/memremap.h>
 #include <linux/slab.h>
+#include <linux/file_based_mm.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -321,12 +322,14 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
+#define VM_HIGH_ARCH_BIT_6	38	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
 #define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
 #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
 #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
 #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
 #define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
+#define VM_HIGH_ARCH_6	BIT(VM_HIGH_ARCH_BIT_6)
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
@@ -357,6 +360,12 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_SHADOW_STACK	VM_NONE
 #endif
 
+#ifdef CONFIG_FILE_BASED_MM
+# define VM_FBMM	VM_HIGH_ARCH_6
+#else
+# define VM_FBMM	VM_NONE
+#endif
+
 #if defined(CONFIG_X86)
 # define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
 #elif defined(CONFIG_PPC)
@@ -3465,6 +3474,7 @@ extern int __mm_populate(unsigned long addr, unsigned long len,
 			 int ignore_errors);
 static inline void mm_populate(unsigned long addr, unsigned long len)
 {
+	fbmm_populate_file(addr, len);
 	/* Ignore errors */
 	(void) __mm_populate(addr, len, 1);
 }
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a5f4b48fca18..8a98490618b0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1554,6 +1554,10 @@ struct task_struct {
 	struct user_event_mm		*user_event_mm;
 #endif
 
+#ifdef CONFIG_FILE_BASED_MM
+	struct fbmm_info *fbmm_info;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/kernel/exit.c b/kernel/exit.c
index 81fcee45d630..49a76f7f6cc6 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -70,6 +70,7 @@
 #include <linux/sysfs.h>
 #include <linux/user_events.h>
 #include <linux/uaccess.h>
+#include <linux/file_based_mm.h>
 
 #include <uapi/linux/wait.h>
 
@@ -824,6 +825,8 @@ void __noreturn do_exit(long code)
 
 	WARN_ON(tsk->plug);
 
+	fbmm_exit(tsk);
+
 	kcov_task_exit(tsk);
 	kmsan_task_exit(tsk);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 99076dbe27d8..2b47276b1300 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2369,6 +2369,9 @@ __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_cleanup_perf;
 	/* copy all the process information */
 	shm_init_task(p);
+	retval = fbmm_copy(current, p, clone_flags);
+	if (retval)
+		goto bad_fork_cleanup_audit;
 	retval = security_task_alloc(p, clone_flags);
 	if (retval)
 		goto bad_fork_cleanup_audit;
diff --git a/mm/gup.c b/mm/gup.c
index f1d6bc06eb52..762bbaf1cabf 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -22,6 +22,7 @@
 
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
+#include <linux/file_based_mm.h>
 
 #include "internal.h"
 
diff --git a/mm/memory.c b/mm/memory.c
index d10e616d7389..fa2fe3ee0867 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5685,6 +5685,8 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 
 	if (unlikely(is_vm_hugetlb_page(vma)))
 		ret = hugetlb_fault(vma->vm_mm, vma, address, flags);
+	else if (unlikely(is_vm_fbmm_page(vma)))
+		ret = fbmm_fault(vma, address, flags);
 	else
 		ret = __handle_mm_fault(vma, address, flags);
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 83b4682ec85c..d684d8bd218b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -182,6 +182,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	struct vm_area_struct *brkvma, *next = NULL;
 	unsigned long min_brk;
 	bool populate = false;
+	bool used_fbmm = false;
 	LIST_HEAD(uf);
 	struct vma_iterator vmi;
 
@@ -256,8 +257,23 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 
 	brkvma = vma_prev_limit(&vmi, mm->start_brk);
 	/* Ok, looks good - let it rip. */
-	if (do_brk_flags(&vmi, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
-		goto out;
+	if (use_file_based_mm(current)) {
+		vm_flags_t vm_flags;
+		unsigned long prot = PROT_READ | PROT_WRITE;
+		unsigned long pgoff = 0;
+		struct file *f = fbmm_get_file(current, oldbrk, newbrk-oldbrk, prot, 0, false,
+			&pgoff);
+
+		if (f) {
+			vm_flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags | VM_FBMM;
+			mmap_region(f, oldbrk, newbrk-oldbrk, vm_flags, pgoff, NULL);
+			used_fbmm = true;
+		}
+	}
+	if (!used_fbmm) {
+		if (do_brk_flags(&vmi, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
+			goto out;
+	}
 
 	mm->brk = brk;
 	if (mm->def_flags & VM_LOCKED)
@@ -1219,6 +1235,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	int pkey = 0;
+	bool used_fbmm = false;
 
 	*populate = 0;
 
@@ -1278,10 +1295,28 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	vm_flags |= calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
+	/* Do we want to use FBMM? */
+	if (!file && (flags & MAP_ANONYMOUS) && use_file_based_mm(current)) {
+		addr = fbmm_get_unmapped_area(addr, len, pgoff, flags);
+
+		if (!IS_ERR_VALUE(addr)) {
+			bool topdown = test_bit(MMF_TOPDOWN, &mm->flags);
+
+			file = fbmm_get_file(current, addr, len, prot, flags, topdown, &pgoff);
+
+			if (file) {
+				used_fbmm = true;
+				flags = flags & ~MAP_ANONYMOUS;
+				vm_flags |= VM_FBMM;
+			}
+		}
+	}
+
 	/* Obtain the address to map to. we verify (or select) it and ensure
 	 * that it represents a valid section of the address space.
 	 */
-	addr = __get_unmapped_area(file, addr, len, pgoff, flags, vm_flags);
+	if (!used_fbmm)
+		addr = __get_unmapped_area(file, addr, len, pgoff, flags, vm_flags);
 	if (IS_ERR_VALUE(addr))
 		return addr;
 
@@ -2690,6 +2725,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		mmap_read_unlock(mm);
 
 	__mt_destroy(&mt_detach);
+	fbmm_munmap(current, start, end - start);
 	return 0;
 
 clear_tree_failed:
-- 
2.34.1


