Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BB1274B9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 23:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgIVVxt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 17:53:49 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55264 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgIVVxk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:53:40 -0400
Received: from localhost.localdomain (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id B3E6920B36E7;
        Tue, 22 Sep 2020 14:53:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3E6920B36E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600811617;
        bh=nDFEfQDC2lbLTYnGJ2HCgyGbCrVZr82PA/GetuDWHoY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WG0qfkCX3mN+TcFDmNFXTXji0kf0wjOy3CUhpFO7hUKbAxGt8Qj7qQ5I3S22uGZdQ
         E0ZnSN7TIoR6GNPSDZS+IsiZmJTPUHJlATRZbvUTR7b/3WIbdaWK0kOBuMXKqut8W5
         0aqokugTkazpsTOyOF2mhXnwEeWWEFzp4EzNeOzg=
From:   madvenka@linux.microsoft.com
To:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, luto@kernel.org, David.Laight@ACULAB.COM,
        fweimer@redhat.com, mark.rutland@arm.com, mic@digikod.net,
        pavel@ucw.cz, madvenka@linux.microsoft.com
Subject: [PATCH v2 1/4] [RFC] fs/trampfd: Implement the trampoline file descriptor API
Date:   Tue, 22 Sep 2020 16:53:23 -0500
Message-Id: <20200922215326.4603-2-madvenka@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922215326.4603-1-madvenka@linux.microsoft.com>
References: <210d7cd762d5307c2aa1676705b392bd445f1baa>
 <20200922215326.4603-1-madvenka@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>

Introduction
============

Dynamic code is used in many different user applications. Dynamic code is
often generated at runtime. Dynamic code can also just be a pre-defined
sequence of machine instructions in a data buffer. Examples of dynamic
code are trampolines, JIT code, DBT code, etc.

Dynamic code is placed either in a data page or in a stack page. In order
to execute dynamic code, the page it resides in needs to be mapped with
execute permissions. Writable pages with execute permissions provide an
attack surface for hackers. Attackers can use this to inject malicious
code, modify existing code or do other harm.

To mitigate this, LSMs such as SELinux implement W^X. That is, they may not
allow pages to have both write and execute permissions. This prevents
dynamic code from executing and blocks applications that use it. To allow
genuine applications to run, exceptions have to be made for them (by setting
execmem, etc) which opens the door to security issues.

The W^X implementation today is not complete. There exist many user level
tricks that can be used to load and execute dynamic code. E.g.,

- Load the code into a file and map the file with R-X.

- Load the code in an RW- page. Change the permissions to R--. Then,
  change the permissions to R-X.

- Load the code in an RW- page. Remap the page with R-X to get a separate
  mapping to the same underlying physical page.

IMO, these are all security holes as an attacker can exploit them to inject
his own code.

In the future, these holes will definitely be closed. For instance, LSMs
(such as the IPE proposal [1]) may only allow code in properly signed object
files to be mapped with execute permissions. This will do two things:

	- user level tricks using anonymous pages will fail as anonymous
	  pages have no file identity

	- loading the code in a temporary file and mapping it with R-X
	  will fail as the temporary file would not have a signature

We need a way to execute such code without making security exceptions.
Trampolines are a good example of dynamic code. A couple of examples
of trampolines are given below. My first use case for this RFC is
libffi.

Solution
========

The solution is to convert dynamic code to static code and place it in a
source file. The binary generated from the source can be signed. The kernel
can use signature verification to authenticate the binary and allow the code
to be mapped and executed.

The problem is that the static code has to be able to find the data that it
needs when it executes. For functions, the ABI defines the way to pass
parameters. But, for arbitrary dynamic code, there isn't a standard ABI
compliant way to pass data to the code for most architectures. Each instance
of dynamic code defines its own way. For instance, co-location of code and
data and PC-relative data referencing are used in cases where the ISA
supports it.

We need one standard way that would work for all architectures and ABIs.

The solution has two parts:

1. The maintainer of the code writes the static code assuming that the data
   needed by the code is already pointed to by a designated register.

2. The kernel supplies a small universal trampoline that does the following:

	- Load the address of the data in a designated register
	- Load the address of the static code in a designated register
	- Jump to the static code

User code would use a kernel supplied API to create and map the trampoline.
The address values would be baked into the code so that no special ISA
features are needed.

To conserve memory, the kernel will pack as many trampolines as possible in
a page and provide a trampoline table to user code. The table itself is
managed by the user.

Kernel API
==========

A kernel API based on anonymous file descriptors is defined to create
trampolines. The following sections describe the API.

Create trampfd
==============

This feature introduces a new trampfd system call.

	struct trampfd_info	info;
	int			trampfd;

	trampfd = syscall(440, &info);

The kernel creates a trampoline file object and returns the following items
in info:

ntrampolines
	The number of trampolines that can be created with one trampfd. The
	user may create fewer trampolines if he wishes.

code_size
	The size of each trampoline.

code_offset
	The file offset to be used in mmap() to map the trampoline code.

Initialize trampfd
==================

A trampfd is initialized in this manner:

	struct trampfd_code	code;
	struct trampfd_data	data;

	/*
	 * Code descriptor.
	 */
	code.ntrampolines = number of desired trampolines;
	code.reg = code register name;
	code.table = array of code addresses

	/*
	 * Data descriptor.
	 */
	data.reg = data register name;
	data.table = array of data addresses

	pwrite(trampfd, &code, sizeof(init), TRAMPFD_CODE);
	pwrite(trampfd, &data, sizeof(init), TRAMPFD_DATA);

The register names are defined in ptrace.h (reg_32_name and reg_64_name).

It is recommended that the code descriptor and code array be placed in the
.rodata section so that an attacker cannot modify its contents.

Instead of pwrite(), the user can also do lseek() and write().

Map trampfd
===========

The user uses mmap() to map the trampoline table into user address space.

	len = info.code_size * code.ntrampolines;
	prot = PROT_READ | PROT_EXEC;
	flags = MAP_PRIVATE;
	offset = info.code_offset;

	trampoline_table = mmap(NULL, len, prot, flags, trampfd, offset);

The kernel generates the trampoline table. The code for trampoline X in the
table is:

	load	&code_table[X], code_reg
	load	(code_reg), code_reg
	load	&data_table[X], data_reg
	load	(data_reg), data_reg
	jump	code_reg

Each mmap() will only map a single base page. Large pages are not supported.

A trampoline file can only be mmapped once in an address space.

Trampoline file mappings cannot be shared across address spaces. So,
sending the trampoline file descriptor over a unix domain socket and
mapping it in another process will not work.

The trampoline code is generated with &code_table[X] and &data_table[X] hard
coded in it. But code_table[X] and data_table[X] can be modified by user
code dynamically so supply the code and data to trampoline X.

Trampoline table management
===========================

The user manages the trampoline table. The address of trampoline X is:

	trampoline_table + info.code_size * X;

Prior to invoking trampoline X, the user must initialize code_table[X] and
data_table[X].

Unmap trampfd
=============

Once the user is done with the trampoline table, it may be unmapped:

	len = info.code_size * code.ntrampolines;
	munmap(trampoline_table, len);

Remove trampfd
==============

To remove the trampfd:

	close(trampfd);

Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
---
 fs/Makefile                       |   1 +
 fs/trampfd/Makefile               |   5 +
 fs/trampfd/trampfd_fops.c         | 241 ++++++++++++++++++++++++++++++
 fs/trampfd/trampfd_map.c          | 142 ++++++++++++++++++
 include/linux/syscalls.h          |   2 +
 include/linux/trampfd.h           |  49 ++++++
 include/uapi/asm-generic/unistd.h |   4 +-
 include/uapi/linux/trampfd.h      | 184 +++++++++++++++++++++++
 init/Kconfig                      |   7 +
 kernel/sys_ni.c                   |   3 +
 10 files changed, 637 insertions(+), 1 deletion(-)
 create mode 100644 fs/trampfd/Makefile
 create mode 100644 fs/trampfd/trampfd_fops.c
 create mode 100644 fs/trampfd/trampfd_map.c
 create mode 100644 include/linux/trampfd.h
 create mode 100644 include/uapi/linux/trampfd.h

diff --git a/fs/Makefile b/fs/Makefile
index 2ce5112b02c8..227761302000 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -136,3 +136,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
+obj-$(CONFIG_TRAMPFD)		+= trampfd/
diff --git a/fs/trampfd/Makefile b/fs/trampfd/Makefile
new file mode 100644
index 000000000000..ae09a0b1f841
--- /dev/null
+++ b/fs/trampfd/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_TRAMPFD) += trampfd.o
+
+trampfd-y += trampfd_fops.o trampfd_map.o
diff --git a/fs/trampfd/trampfd_fops.c b/fs/trampfd/trampfd_fops.c
new file mode 100644
index 000000000000..7164dd4d9039
--- /dev/null
+++ b/fs/trampfd/trampfd_fops.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Trampoline FD - System call and File operations.
+ *
+ * Author: Madhavan T. Venkataraman (madvenka@microsoft.com)
+ *
+ * Copyright (C) 2020 Microsoft Corporation.
+ */
+
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/syscalls.h>
+#include <linux/seq_file.h>
+#include <linux/anon_inodes.h>
+#include <linux/trampfd.h>
+
+char	*trampfd_name = "[trampfd]";
+
+struct kmem_cache	*trampfd_cache;
+
+/*
+ * Arch stub function to return info for the trampfd syscall.
+ */
+int __attribute__((weak)) trampfd_arch(struct trampfd_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+/*
+ * Arch stub function to do arch specific initialization for a code
+ * descriptor.
+ */
+int __attribute__((weak)) trampfd_code_arch(struct trampfd_code *code)
+{
+	return -EOPNOTSUPP;
+}
+
+/*
+ * Arch stub function to do arch specific initialization for a data
+ * descriptor.
+ */
+int __attribute__((weak)) trampfd_data_arch(struct trampfd_data *data)
+{
+	return -EOPNOTSUPP;
+}
+
+#ifdef CONFIG_PROC_FS
+static void trampfd_show_fdinfo(struct seq_file *sfile, struct file *file)
+{
+	seq_puts(sfile, "Trampoline FD\n");
+}
+#endif
+
+static loff_t trampfd_llseek(struct file *file, loff_t offset, int whence)
+{
+	struct trampfd		*trampfd = file->private_data;
+
+	if (whence != SEEK_SET)
+		return -EINVAL;
+
+	if ((offset < 0) || (offset >= TRAMPFD_NUM_OFFSETS))
+		return -EINVAL;
+
+	mutex_lock(&trampfd->lock);
+	if (offset != file->f_pos) {
+		file->f_pos = offset;
+		file->f_version = 0;
+	}
+	mutex_unlock(&trampfd->lock);
+	return offset;
+}
+
+int trampfd_code(struct file *file, const char __user *arg, size_t count)
+{
+	struct trampfd		*trampfd = file->private_data;
+	struct trampfd_code	code;
+	int			rc = 0;
+
+	if (count != sizeof(code))
+		return -EINVAL;
+
+	if (copy_from_user(&code, arg, sizeof(code)))
+		return -EFAULT;
+
+	mutex_lock(&trampfd->lock);
+
+	if (trampfd->code) {
+		rc = -EEXIST;
+		goto unlock;
+	}
+
+	rc = trampfd_code_arch(&code);
+	if (rc)
+		goto unlock;
+
+	trampfd->code_reg = code.reg;
+	trampfd->ntrampolines = code.ntrampolines;
+	trampfd->code = (void *) (uintptr_t) code.table;
+unlock:
+	mutex_unlock(&trampfd->lock);
+	return rc;
+}
+
+int trampfd_data(struct file *file, const char __user *arg, size_t count)
+{
+	struct trampfd		*trampfd = file->private_data;
+	struct trampfd_data	data;
+	int			rc = 0;
+
+	if (count != sizeof(data))
+		return -EINVAL;
+
+	if (copy_from_user(&data, arg, sizeof(data)))
+		return -EFAULT;
+
+	if (data.reserved)
+		return -EINVAL;
+
+	mutex_lock(&trampfd->lock);
+
+	if (trampfd->data) {
+		rc = -EEXIST;
+		goto unlock;
+	}
+
+	rc = trampfd_data_arch(&data);
+	if (rc)
+		goto unlock;
+
+	trampfd->data_reg = data.reg;
+	trampfd->data = (void *) (uintptr_t) data.table;
+unlock:
+	mutex_unlock(&trampfd->lock);
+	return rc;
+}
+
+static ssize_t trampfd_write(struct file *file, const char __user *arg,
+			     size_t count, loff_t *ppos)
+{
+	int		rc;
+
+	if (!arg || !count)
+		return -EINVAL;
+
+	switch (*ppos) {
+	case TRAMPFD_CODE:
+		rc = trampfd_code(file, arg, count);
+		break;
+
+	case TRAMPFD_DATA:
+		rc = trampfd_data(file, arg, count);
+		break;
+
+	default:
+		rc = -EINVAL;
+		goto out;
+	}
+out:
+	return rc ? rc : (ssize_t) count;
+}
+
+static int trampfd_release(struct inode *inode, struct file *file)
+{
+	struct trampfd		*trampfd = file->private_data;
+
+	mutex_destroy(&trampfd->lock);
+	kmem_cache_free(trampfd_cache, trampfd);
+	return 0;
+}
+
+const struct file_operations trampfd_fops = {
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo		= trampfd_show_fdinfo,
+#endif
+	.llseek			= trampfd_llseek,
+	.write			= trampfd_write,
+	.release		= trampfd_release,
+	.mmap			= trampfd_mmap,
+	.get_unmapped_area	= trampfd_get_unmapped_area,
+};
+
+SYSCALL_DEFINE1(trampfd, struct trampfd_info *, info_arg)
+{
+	struct trampfd		*trampfd;
+	struct trampfd_info	info;
+	struct file		*file;
+	int			fd;
+	int			rc;
+
+	if (!trampfd_cache)
+		return -ENOMEM;
+
+	if (!info_arg)
+		return -EINVAL;
+
+	trampfd = kmem_cache_zalloc(trampfd_cache, GFP_KERNEL);
+	if (!trampfd)
+		return -ENOMEM;
+	mutex_init(&trampfd->lock);
+	trampfd->creator = current->pid;
+
+	trampfd_arch(&info);
+
+	if (copy_to_user(info_arg, &info, sizeof(info))) {
+		rc = -EFAULT;
+		goto freetramp;
+	}
+
+	rc = get_unused_fd_flags(O_CLOEXEC);
+	if (rc < 0)
+		goto freetramp;
+	fd = rc;
+
+	file = anon_inode_getfile(trampfd_name, &trampfd_fops, trampfd, O_RDWR);
+	if (IS_ERR(file)) {
+		rc = PTR_ERR(file);
+		goto freefd;
+	}
+	file->f_mode |= (FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE);
+
+	fd_install(fd, file);
+	return fd;
+freefd:
+	put_unused_fd(fd);
+freetramp:
+	kmem_cache_free(trampfd_cache, trampfd);
+	return rc;
+}
+
+int __init trampfd_feature_init(void)
+{
+	trampfd_cache = kmem_cache_create("trampfd_cache",
+		sizeof(struct trampfd), 0, SLAB_HWCACHE_ALIGN, NULL);
+	if (trampfd_cache == NULL) {
+		pr_warn("%s: kmem_cache_create failed", __func__);
+		return -ENOMEM;
+	}
+	return 0;
+}
+core_initcall(trampfd_feature_init);
diff --git a/fs/trampfd/trampfd_map.c b/fs/trampfd/trampfd_map.c
new file mode 100644
index 000000000000..679b29768491
--- /dev/null
+++ b/fs/trampfd/trampfd_map.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Trampoline FD - Memory mapping.
+ *
+ * Author: Madhavan T. Venkataraman (madvenka@microsoft.com)
+ *
+ * Copyright (C) 2020 Microsoft Corporation.
+ */
+
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/mman.h>
+#include <linux/highmem.h>
+#include <linux/trampfd.h>
+
+/*
+ * Arch stub function to populate a page with trampolines based on a
+ * trampoline specification.
+ */
+void __attribute__((weak)) trampfd_code_fill(struct trampfd *trampfd,
+					     char *addr)
+{
+}
+
+static void trampfd_close(struct vm_area_struct *vma)
+{
+	struct trampfd		*trampfd = vma->vm_file->private_data;
+
+	mutex_lock(&trampfd->lock);
+
+	if (trampfd->page) {
+		__free_pages(trampfd->page, 0);
+		trampfd->page = NULL;
+	}
+	trampfd->mapped = false;
+
+	mutex_unlock(&trampfd->lock);
+}
+
+static vm_fault_t trampfd_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct	*vma = vmf->vma;
+	struct trampfd		*trampfd = vma->vm_file->private_data;
+	struct page		*new_page = NULL;
+	void			*addr;
+
+	/*
+	 * Check this outside the lock so the lock does not have to be
+	 * dropped in order to allocate a page. Races are benign.
+	 */
+	if (!trampfd->page) {
+		new_page = alloc_pages(GFP_KERNEL, 0);
+		if (!new_page)
+			return VM_FAULT_OOM;
+	}
+
+	mutex_lock(&trampfd->lock);
+
+	if (!trampfd->page) {
+		trampfd->page = new_page;
+		new_page = NULL;
+		/*
+		 * Populate the page with trampolines.
+		 */
+		addr = kmap(trampfd->page);
+		trampfd_code_fill(trampfd, addr);
+		kunmap(trampfd->page);
+	}
+	vmf->page = trampfd->page;
+	get_page(vmf->page);
+
+	mutex_unlock(&trampfd->lock);
+
+	if (new_page)
+		__free_pages(new_page, 0);
+	return 0;
+}
+
+static const struct vm_operations_struct trampfd_vm_ops = {
+	.close	= trampfd_close,
+	.fault	= trampfd_fault,
+};
+
+int trampfd_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct trampfd		*trampfd = vma->vm_file->private_data;
+	int			rc = 0;
+
+	/*
+	 * A trampfd cannot be mapped into multiple address spaces.
+	 */
+	if (current->pid != trampfd->creator)
+		return -EINVAL;
+
+	mutex_lock(&trampfd->lock);
+
+	/*
+	 * trampfd must be initialized before it can be mapped.
+	 */
+	if (!trampfd->code || !trampfd->data) {
+		rc = -EINVAL;
+		goto unlock;
+	}
+
+	/*
+	 * A trampfd cannot be mapped multiple times in the same address space.
+	 */
+	if (trampfd->mapped) {
+		rc = -EEXIST;
+		goto unlock;
+	}
+
+	/*
+	 * prot should be R-X.
+	 */
+	if ((vma->vm_flags & VM_WRITE) || !(vma->vm_flags & VM_READ) ||
+	    !(vma->vm_flags & VM_EXEC)) {
+		rc = -EINVAL;
+		goto unlock;
+	}
+	trampfd->mapped = true;
+	vma->vm_ops = &trampfd_vm_ops;
+unlock:
+	mutex_unlock(&trampfd->lock);
+	return rc;
+}
+
+unsigned long
+trampfd_get_unmapped_area(struct file *file, unsigned long orig_addr,
+			  unsigned long len, unsigned long pgoff,
+			  unsigned long flags)
+{
+	const typeof_member(struct file_operations, get_unmapped_area)
+	get_area = current->mm->get_unmapped_area;
+
+	if (pgoff != TRAMPFD_CODE_PGOFF || flags != MAP_PRIVATE ||
+	    len != PAGE_SIZE)
+		return -EINVAL;
+
+	return get_area(file, orig_addr, len, pgoff, flags);
+}
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index b951a87da987..91f55ff3cdac 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -69,6 +69,7 @@ union bpf_attr;
 struct io_uring_params;
 struct clone_args;
 struct open_how;
+struct trampfd_info;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -1005,6 +1006,7 @@ asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 				       siginfo_t __user *info,
 				       unsigned int flags);
 asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
+asmlinkage long sys_trampfd(struct trampfd_info *info);
 
 /*
  * Architecture-specific system calls
diff --git a/include/linux/trampfd.h b/include/linux/trampfd.h
new file mode 100644
index 000000000000..c98fa1741c36
--- /dev/null
+++ b/include/linux/trampfd.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Trampoline FD - Internal structures and definitions.
+ *
+ * Author: Madhavan T. Venkataraman (madvenka@linux.microsoft.com)
+ *
+ * Copyright (c) 2020, Microsoft Corporation.
+ */
+#ifndef _LINUX_TRAMPFD_H
+#define _LINUX_TRAMPFD_H
+
+#include <uapi/linux/trampfd.h>
+
+/*
+ * mmap() offsets.
+ */
+enum trampfd_pgoff {
+	TRAMPFD_CODE_PGOFF = 1,
+	TRAMPFD_NUM_PGOFF,
+};
+
+/*
+ * Trampoline structure.
+ */
+struct trampfd {
+	struct mutex		lock;		/* to serialize access */
+	pid_t			creator;	/* to prevent sharing */
+
+	short			code_reg;	/* code register name */
+	short			data_reg;	/* data register name */
+	int			ntrampolines;	/* number of trampolines */
+
+	void			*code;		/* user code address table */
+	void			*data;		/* user data address table */
+
+	struct page		*page;		/* code page */
+	bool			mapped;		/* mapped into address space? */
+};
+
+#ifdef CONFIG_TRAMPFD
+
+int trampfd_mmap(struct file *file, struct vm_area_struct *vma);
+unsigned long trampfd_get_unmapped_area(struct file *file, unsigned long addr,
+					unsigned long len, unsigned long pgoff,
+					unsigned long flags);
+
+#endif /* CONFIG_TRAMPFD */
+
+#endif /* _LINUX_TRAMPFD_H */
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index f4a01305d9a6..3b1ad4b75c7a 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -857,9 +857,11 @@ __SYSCALL(__NR_openat2, sys_openat2)
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 #define __NR_faccessat2 439
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
+#define __NR_trampfd 440
+__SYSCALL(__NR_trampfd, sys_trampfd)
 
 #undef __NR_syscalls
-#define __NR_syscalls 440
+#define __NR_syscalls 441
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/trampfd.h b/include/uapi/linux/trampfd.h
new file mode 100644
index 000000000000..9bbc0450e16d
--- /dev/null
+++ b/include/uapi/linux/trampfd.h
@@ -0,0 +1,184 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Trampoline FD - API structures and definitions.
+ *
+ * Author: Madhavan T. Venkataraman (madvenka@linux.microsoft.com)
+ *
+ * Copyright (c) 2020, Microsoft Corporation.
+ */
+#ifndef _UAPI_LINUX_TRAMPFD_H
+#define _UAPI_LINUX_TRAMPFD_H
+
+#include <linux/types.h>
+#include <linux/ptrace.h>
+
+/*
+ * All structure fields are defined so that they are the same width and at the
+ * same structure offset on 32-bit and 64-bit to avoid compat code.
+ *
+ * All fields named "reserved" must be set to 0. They are there primarily for
+ * alignment. But they may be used in the future.
+ */
+
+/* ---------------------------- Trampfd Feature --------------------------- */
+
+/*
+ * This feature can be used to help convert dynamic user code to static user
+ * code so that the code can be in the text segment of a binary file. This
+ * allows the kernel to authenticate the code. E.g., using signature
+ * verification of the binary file.
+ *
+ * The problem in converting dynamic code to static code is that the static
+ * code needs to be able to locate its data dynamically. So, its data needs
+ * to be loaded in a designated register before jumping to the static code.
+ *
+ * This feature uses the kernel to generate a small, secure trampoline to do
+ * this. The trampoline code looks like this:
+ *
+ *	- load the address of the static code in a register (code_reg)
+ *	- load the address of its data in a register (data_reg)
+ *	- jump to code_reg
+ *
+ * The kernel places the trampoline in a user page and maps it into the user
+ * address space. To conserve memory, the kernel packs multiple trampolines in
+ * a page and creates a trampoline table.
+ */
+
+/* -------------------------- Trampoline Creation ------------------------- */
+
+/*
+ * This feature introduces a new trampfd system call.
+ *
+ *	struct trampfd_info	info;
+ *
+ *	trampfd = syscall(430, &info);
+ *
+ * The kernel returns the following items in info:
+ *
+ * ntrampolines
+ *	The number of trampolines that can be created with one trampfd. The
+ *	user may create fewer trampolines if he wishes.
+ *
+ * code_size
+ *	The size of each trampoline.
+ *
+ * code_offset
+ *	The file offset to be used in mmap() to map the trampoline code.
+ */
+struct trampfd_info {
+	__u32		ntrampolines;
+	__u32		code_size;
+	__u32		code_offset;
+	__u32		reserved;
+};
+
+/* ----------------------- Trampoline Initialization ---------------------- */
+
+/*
+ * Trampoline code descriptor.
+ *
+ * ntrampolines
+ *	User specified number of trampolines. This number cannot exceed
+ *	info.ntrampolines.
+ *
+ * reg
+ *	User specified code register name. This is architecture specific and
+ *	can be obtained from ptrace.h.
+ *
+ * table
+ *	User array of code addresses, one address per trampoline.
+ *
+ */
+struct trampfd_code {
+	__u32		ntrampolines;
+	__u32		reg;
+	__u64		table;
+};
+
+/*
+ * Trampoline data descriptor.
+ *
+ * reg
+ *	User specified data register name. This is architecture specific and
+ *	can be obtained from ptrace.h.
+ *
+ * table
+ *	User array of data addresses, one address per trampoline.
+ *
+ */
+struct trampfd_data {
+	__u32		reg;
+	__u32		reserved;
+	__u64		table;
+};
+
+/*
+ * A trampfd is initialized in this manner:
+ *
+ *	struct trampfd_code	code;
+ *	struct trampfd_data	data;
+ *
+ *	code.ntrampolines = number of desired trampolines;
+ *	code.reg = code register name;
+ *	code.table = array of code addresses
+ *
+ *	data.reg = data register name;
+ *	data.table = array of data addresses
+ *
+ *	pwrite(trampfd, &code, sizeof(init), TRAMPFD_CODE);
+ *	pwrite(trampfd, &data, sizeof(init), TRAMPFD_DATA);
+ *
+ * It is recommended that the code descriptor and code array be placed in the
+ * .rodata section so that an attacker cannot modify its contents.
+ */
+
+/* ---------------------------- Trampoline mapping ------------------------ */
+
+/*
+ * The user uses mmap() to map the trampoline table into user address space.
+ *
+ *	len = info.code_size * code.ntrampolines;
+ *	prot = PROT_READ | PROT_EXEC;
+ *	flags = MAP_PRIVATE;
+ *	offset = info.code_offset;
+ *
+ *	trampoline_table = mmap(NULL, len, prot, flags, trampfd, offset);
+ *
+ * The kernel generates the trampoline table. The code for trampoline X in the
+ * table is:
+ *
+ *	load code_table[X] into code_reg
+ *	load data_table[X] into data_reg
+ *	jump code_reg
+ *
+ * The user manages the trampoline table. The address of trampoline X is:
+ *
+ *	trampoline_table + info.code_size * X;
+ *
+ * Prior to invoking trampoline X, the user must initialize code_table[X] and
+ * data_table[X].
+ */
+
+/* ------------------------- Symbolic offsets -------------------------- */
+
+/*
+ * trampfd can have different actions/parameters associated with it. Each one
+ * has a symbolic file offset. Action/Parameter structures are read or written
+ * at their file offsets.
+ *
+ * Offset		Operation	Data
+ * ------------------------------------------------------------------------
+ * TRAMPFD_CODE		Write		struct trampfd_code
+ * TRAMPFD_DATA		Write		struct trampfd_data
+ * ------------------------------------------------------------------------
+ */
+enum trampfd_offsets {
+	TRAMPFD_CODE,
+	TRAMPFD_DATA,
+	TRAMPFD_NUM_OFFSETS,
+};
+
+
+/* ----------------------------------------------------------------------- */
+
+#endif /* _UAPI_LINUX_TRAMPFD_H */
diff --git a/init/Kconfig b/init/Kconfig
index 0498af567f70..bb3ecca5b8e7 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2313,3 +2313,10 @@ config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 # <asm/syscall_wrapper.h>.
 config ARCH_HAS_SYSCALL_WRAPPER
 	def_bool n
+
+config TRAMPFD
+	bool "Enable trampfd() system call"
+	depends on MMU
+	help
+	  Enable the trampfd() system call that allows a process to map
+	  kernel generated trampolines within its address space.
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 3b69a560a7ac..93c5972aba85 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -349,6 +349,9 @@ COND_SYSCALL(pkey_mprotect);
 COND_SYSCALL(pkey_alloc);
 COND_SYSCALL(pkey_free);
 
+/* Trampoline fd */
+COND_SYSCALL(trampfd);
+
 
 /*
  * Architecture specific weak syscall entries.
-- 
2.17.1

