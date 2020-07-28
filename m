Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D50230B14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 15:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgG1NLH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 09:11:07 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37738 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729956AbgG1NLD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:11:03 -0400
Received: from localhost.localdomain (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7A6CC20B4909;
        Tue, 28 Jul 2020 06:11:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A6CC20B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595941861;
        bh=c0m/icnHpfgTfp+pXFs520StvNMbxQAtleLNrAWcPjU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=X8qUTBwIWeQnVYrbZS7ouQXlSVntZVheFTmDs5TpIxtLqydyb/88wJjmrbrX2y4oQ
         ov4U984dl9LZvXw0T5QhmZKHQC7gK25kBx+Tx7jTgBcdw6jqz/RFUMf+jbtFNouE2z
         j05/BCVAbVYgHlXDu5mVeO0QU+Y6vDpNCVvCQR3I=
From:   madvenka@linux.microsoft.com
To:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, madvenka@linux.microsoft.com
Subject: [PATCH v1 1/4] [RFC] fs/trampfd: Implement the trampoline file descriptor API
Date:   Tue, 28 Jul 2020 08:10:47 -0500
Message-Id: <20200728131050.24443-2-madvenka@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728131050.24443-1-madvenka@linux.microsoft.com>
References: <aefc85852ea518982e74b233e11e16d2e707bc32>
 <20200728131050.24443-1-madvenka@linux.microsoft.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>

There are many applications that use trampoline code. Trampoline code is
usually placed in a data page or a stack page. In order to execute a
trampoline, the page that contains the trampoline needs to have execute
permissions.

Writable pages with execute permissions provide an attack surface for
hackers. To mitigate this, LSMs such as SELinux may prevent a page from
having both write and execute permissions.

An application may attempt to circumvent this by writing the trampoline
code into a temporary file and mapping the file into its process
address space with just execute permissions. This presents the same
opportunity to hackers as before. LSMs that implement cryptographic
verification of files can prevent such temporary files from being mapped.

Such security mitigations prevent genuine trampoline code from running
as well.

Typically, trampolines simply load some values in some registers and/or
push some values on the stack and jump to a target PC. For such simple
trampolines, an application could request the kernel to do that work
instead of executing trampoline code to do that work. trampfd allows
applications to do exactly this.

Such applications can then run without having to relax security
settings for them. For instance, libffi trampolines can easily be
replaced by trampfd. libffi is used by a variety of applications.

trampfd_create() system call
----------------------------

A new system call is introduced to create a trampoline. The system call
number for this is 440. The system call is invoked like this:

	int	trampfd;

	trampfd = syscall(440, type, data);

	type	Trampoline type.
	data	Trampoline type-specific data.

Types of trampolines
--------------------

Different types of trampolines can be defined based on the desired
functionality. In this initial work, the following type is defined:

	TRAMPFD_USER

This implements the simple trampoline type I referred to earlier.
The type-specific structure for TRAMPFD_USER is struct trampfd_user.

Trampoline contexts
-------------------

A trampoline can have one or more contexts associated with it. Contexts
are of two kinds:

	- Contexts that can be specified by the user. These can be added,
	  retrieved and removed by user code.

	- Contexts that are specified by the kernel. This can only be
	  added by the kernel. But these can be read by the user.

In this initial work, I define the following contexts:

User specifiable:

	Register Context
	----------------

	Contains register name-value pairs. When a trampoline is invoked,
	the specified values are loaded in the specified registers. This
	includes the value of the PC register. The kernel specifies the
	subset of registers that can be specified.

	Stack Context
	-------------

	Contains data to push on the user stack when a trampoline is
	invoked.

	Allowed PCs
	-----------

	This specifies a list of PCs that the trampoline is allowed to
	jump to. This prevents a hacker from modifying the trampoline's
	target PC.

Kernel specified:

	Mapping parameters
	------------------

	Used to map a trampoline into an address space. Mapping parameters
	are determined by the kernel based on the trampoline type and
	type-specific information.

Other contexts can be defined in the future.

How to set and read contexts
----------------------------

A symbolic file offset is associated with each context type.

	TRAMPFD_MAP_OFFSET
	TRAMPFD_REGS_OFFSET
	TRAMPFD_STACK_OFFSET
	TRAMPFD_PCS_OFFSET

A structure is defined for each context type as well:

	struct trampfd_map
	struct trampfd_regs
	struct trampfd_stack
	struct trampfd_pcs

To set/retrieve a context, seek to the corresponding offset and
write()/read() the corresponding structure. As a convenience, pread()
and pwrite() can be used so it can be done in one call instead of two.

Invoking a trampoline
---------------------

Map the file descriptor into process address space using mmap(). The
kernel returns an address to invoke the trampoline with. The protection
for the mapping is set to PROT_NONE.

Execute the trampoline in one of two ways depending upon what the target
PC points to:

   - Branch to the trampoline address.

   - Use the trampoline address as a function pointer and call it.

Because the user process does not have execute permissions on the
trampoline address, it traps into the kernel. The kernel recognizes
it as a trampoline invocation and performs the action indicated by the
trampoline's type and context. In the case of TRAMPFD_USER, the
kernel loads the user registers with the values specified in the
register context, pushes the values specfied in the stack context on
the user stack and sets the user PC to point to the PC register value
in the register context. Then, the process returns to user land and
continues execution at the target PC.

Removing a context
------------------

To remove a context, write the context structure into trampfd but
specify a zero context. For example, for register context, specify
the number of registers as 0. For stack context, specify size of
stack data as 0.

Removing a trampoline
---------------------

To remove a trampoline, unmap it and close the file descriptor. When
the last reference on the trampoline goes away, the trampoline is freed.

Sharing trampolines
-------------------

A trampoline created by one thread can be used by other threads sharing
the same address space.

Trampolines, in general, may be shared across processes by the usual
mechanism of sending the file descriptor to another process over a Unix
domain socket.

Architecture support
--------------------

The handling of the trampoline page fault and the setting up of the
register and stack contexts are architecture specific. Architecture
specific patches will implement support for the API.

The signal delivery code in the kernel already implements the elements
needed for this work. That will be leveraged.

Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
---
 fs/Makefile                       |   1 +
 fs/trampfd/Makefile               |   6 ++
 fs/trampfd/trampfd_data.c         |  43 ++++++++
 fs/trampfd/trampfd_fops.c         | 131 +++++++++++++++++++++++
 fs/trampfd/trampfd_map.c          |  78 ++++++++++++++
 fs/trampfd/trampfd_pcs.c          |  95 +++++++++++++++++
 fs/trampfd/trampfd_regs.c         | 137 ++++++++++++++++++++++++
 fs/trampfd/trampfd_stack.c        | 131 +++++++++++++++++++++++
 fs/trampfd/trampfd_stubs.c        |  41 +++++++
 fs/trampfd/trampfd_syscall.c      |  92 ++++++++++++++++
 include/linux/syscalls.h          |   3 +
 include/linux/trampfd.h           |  82 ++++++++++++++
 include/uapi/asm-generic/unistd.h |   4 +-
 include/uapi/linux/trampfd.h      | 171 ++++++++++++++++++++++++++++++
 init/Kconfig                      |   8 ++
 kernel/sys_ni.c                   |   3 +
 16 files changed, 1025 insertions(+), 1 deletion(-)
 create mode 100644 fs/trampfd/Makefile
 create mode 100644 fs/trampfd/trampfd_data.c
 create mode 100644 fs/trampfd/trampfd_fops.c
 create mode 100644 fs/trampfd/trampfd_map.c
 create mode 100644 fs/trampfd/trampfd_pcs.c
 create mode 100644 fs/trampfd/trampfd_regs.c
 create mode 100644 fs/trampfd/trampfd_stack.c
 create mode 100644 fs/trampfd/trampfd_stubs.c
 create mode 100644 fs/trampfd/trampfd_syscall.c
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
index 000000000000..bdf5e487facc
--- /dev/null
+++ b/fs/trampfd/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_TRAMPFD) += trampfd.o
+
+trampfd-y += trampfd_data.o trampfd_fops.o trampfd_map.o trampfd_pcs.o
+trampfd-y += trampfd_regs.o trampfd_stack.o trampfd_stubs.o trampfd_syscall.o
diff --git a/fs/trampfd/trampfd_data.c b/fs/trampfd/trampfd_data.c
new file mode 100644
index 000000000000..0a316754cbe4
--- /dev/null
+++ b/fs/trampfd/trampfd_data.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Trampoline File Descriptor - Trampoline type-specific code.
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
+#include <linux/trampfd.h>
+
+int trampfd_create_data(struct trampfd *trampfd, const void __user *tramp_data)
+{
+	struct trampfd_map	*map = &trampfd->map;
+	struct trampfd_user	*user;
+
+	if (trampfd->type == TRAMPFD_USER) {
+		user = kmalloc(sizeof(*user), GFP_KERNEL);
+		if (!user)
+			return -ENOMEM;
+
+		if (copy_from_user(user, tramp_data, sizeof(*user))) {
+			kfree(user);
+			return -EFAULT;
+		}
+		if (user->flags || user->reserved) {
+			kfree(user);
+			return -EINVAL;
+		}
+		trampfd->data = user;
+
+		map->size = PAGE_SIZE;
+		map->prot = PROT_NONE;
+		map->flags = MAP_PRIVATE;
+		map->offset = 0;
+		map->ioffset = 0;
+	}
+	return 0;
+}
diff --git a/fs/trampfd/trampfd_fops.c b/fs/trampfd/trampfd_fops.c
new file mode 100644
index 000000000000..94b82e0da75b
--- /dev/null
+++ b/fs/trampfd/trampfd_fops.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Trampoline File Descriptor - File operations.
+ *
+ * Author: Madhavan T. Venkataraman (madvenka@microsoft.com)
+ *
+ * Copyright (C) 2020 Microsoft Corporation.
+ */
+
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/seq_file.h>
+#include <linux/trampfd.h>
+
+#ifdef CONFIG_PROC_FS
+static const char * const trampfd_type_names[TRAMPFD_NUM_TYPES] = {
+	"TRAMPFD_USER",
+};
+
+static void trampfd_show_fdinfo(struct seq_file *sfile, struct file *file)
+{
+	struct trampfd		*trampfd = file->private_data;
+
+	seq_printf(sfile, "type: %s\n", trampfd_type_names[trampfd->type]);
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
+static ssize_t trampfd_read(struct file *file, char __user *arg,
+			    size_t count, loff_t *ppos)
+{
+	int		rc;
+
+	if (!arg || !count)
+		return -EINVAL;
+
+	switch (*ppos) {
+	case TRAMPFD_MAP_OFFSET:
+		rc = trampfd_get_map(file, arg, count);
+		break;
+
+	case TRAMPFD_REGS_OFFSET:
+		rc = trampfd_get_regs(file, arg, count);
+		break;
+
+	case TRAMPFD_STACK_OFFSET:
+		rc = trampfd_get_stack(file, arg, count);
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
+static ssize_t trampfd_write(struct file *file, const char __user *arg,
+			     size_t count, loff_t *ppos)
+{
+	int		rc;
+
+	if (!arg || !count)
+		return -EINVAL;
+
+	switch (*ppos) {
+	case TRAMPFD_REGS_OFFSET:
+		rc = trampfd_set_regs(file, arg, count);
+		break;
+
+	case TRAMPFD_STACK_OFFSET:
+		rc = trampfd_set_stack(file, arg, count);
+		break;
+
+	case TRAMPFD_ALLOWED_PCS_OFFSET:
+		rc = trampfd_set_allowed_pcs(file, arg, count);
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
+	if (trampfd->type == TRAMPFD_USER) {
+		kfree(trampfd->regs);
+		kfree(trampfd->stack);
+		kfree(trampfd->allowed_pcs);
+	}
+	kfree(trampfd->data);
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
+	.read			= trampfd_read,
+	.write			= trampfd_write,
+	.release		= trampfd_release,
+	.mmap			= trampfd_mmap,
+	.get_unmapped_area	= trampfd_get_unmapped_area,
+};
diff --git a/fs/trampfd/trampfd_map.c b/fs/trampfd/trampfd_map.c
new file mode 100644
index 000000000000..1a156c850ca8
--- /dev/null
+++ b/fs/trampfd/trampfd_map.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Trampoline File Descriptor - Memory mapping.
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
+#include <linux/security.h>
+#include <linux/trampfd.h>
+
+int trampfd_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct trampfd		*trampfd = file->private_data;
+
+	if (trampfd->type == TRAMPFD_USER) {
+		/*
+		 * These mappings are special mappings that should not be
+		 * merged or inherited. No physical page is currently allocated
+		 * to these mappings. So, there is nothing to read/write.
+		 * When the trampoline is invoked, an execute fault must be
+		 * encountered so the kernel can intercept the invocation and
+		 * set up user context.
+		 */
+		if (vma->vm_flags & (VM_READ | VM_WRITE | VM_EXEC))
+			return -EINVAL;
+		vma->vm_flags = VM_SPECIAL | VM_DONTCOPY | VM_DONTDUMP;
+	}
+	vma->vm_private_data = trampfd;
+	return 0;
+}
+
+unsigned long
+trampfd_get_unmapped_area(struct file *file, unsigned long orig_addr,
+			  unsigned long len, unsigned long pgoff,
+			  unsigned long flags)
+{
+	struct trampfd		*trampfd = file->private_data;
+	struct trampfd_map	*map = &trampfd->map;
+	unsigned long		map_pgoff = map->offset >> PAGE_SHIFT;
+
+	const typeof_member(struct file_operations, get_unmapped_area)
+	get_area = current->mm->get_unmapped_area;
+
+	if (len != map->size || pgoff != map_pgoff || (flags != map->flags))
+		return -EINVAL;
+
+	return get_area(file, orig_addr, len, pgoff, flags);
+}
+
+/*
+ * Retrieve the mapping parameters of a trampoline.
+ */
+int trampfd_get_map(struct file *file, char __user *arg, size_t count)
+{
+	struct trampfd		*trampfd = file->private_data;
+
+	if (count != sizeof(trampfd->map))
+		return -EINVAL;
+	if (copy_to_user(arg, &trampfd->map, count))
+		return -EFAULT;
+	return 0;
+}
+
+bool is_trampfd_vma(struct vm_area_struct *vma)
+{
+	struct file	*file = vma->vm_file;
+
+	if (!file)
+		return false;
+	return !strcmp(file->f_path.dentry->d_name.name, trampfd_name);
+}
+EXPORT_SYMBOL_GPL(is_trampfd_vma);
diff --git a/fs/trampfd/trampfd_pcs.c b/fs/trampfd/trampfd_pcs.c
new file mode 100644
index 000000000000..0ed36fd2169f
--- /dev/null
+++ b/fs/trampfd/trampfd_pcs.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Trampoline File Descriptor - Allowed PCs context.
+ *
+ * Author: Madhavan T. Venkataraman (madvenka@microsoft.com)
+ *
+ * Copyright (C) 2020 Microsoft Corporation.
+ */
+
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/trampfd.h>
+
+/*
+ * Copy list of allowed PCs from the user and validate it.
+ */
+static int trampfd_copy_allowed_pcs(struct trampfd_values *allowed_pcs,
+			    const void __user *arg, size_t count)
+{
+	u32			npcs;
+	size_t			size;
+	u64			*values;
+	int			i;
+
+	if (copy_from_user(allowed_pcs, arg, count))
+		return -EFAULT;
+
+	if (allowed_pcs->reserved)
+		return -EINVAL;
+
+	npcs = allowed_pcs->nvalues;
+	if (npcs > TRAMPFD_MAX_PCS)
+		return -EINVAL;
+
+	size = sizeof(*allowed_pcs);
+	size += npcs * sizeof(u64);
+	if (size != count)
+		return -EINVAL;
+
+	values = allowed_pcs->values;
+	for (i = 0; i < npcs; i++) {
+		if (!values[i])
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Set the allowed PCs for a trampoline. If the trampoline has a register
+ * context at this point, the PC register value in that register context is
+ * not checked against this list of allowed PCs.
+ */
+int trampfd_set_allowed_pcs(struct file *file, const char __user *arg,
+			    size_t count)
+{
+	struct trampfd			*trampfd = file->private_data;
+	struct trampfd_values		*allowed_pcs, *cur_allowed_pcs;
+	int				rc;
+
+	if (count < sizeof(*allowed_pcs) || count > TRAMPFD_MAX_PCS_SIZE)
+		return -EINVAL;
+
+	allowed_pcs = kmalloc(count, GFP_KERNEL);
+	if (!allowed_pcs)
+		return -ENOMEM;
+
+	rc = trampfd_copy_allowed_pcs(allowed_pcs, arg, count);
+	if (rc)
+		goto out;
+
+	/*
+	 * If number of PCs is 0, there is no new PCS to set.
+	 */
+	if (!allowed_pcs->nvalues) {
+		kfree(allowed_pcs);
+		allowed_pcs = NULL;
+	}
+
+	/*
+	 * Swap the new PCs with the current one and free the current one,
+	 * if any.
+	 */
+	mutex_lock(&trampfd->lock);
+
+	cur_allowed_pcs = trampfd->allowed_pcs;
+	trampfd->allowed_pcs = allowed_pcs;
+	allowed_pcs = cur_allowed_pcs;
+
+	mutex_unlock(&trampfd->lock);
+out:
+	kfree(allowed_pcs);
+	return rc;
+}
diff --git a/fs/trampfd/trampfd_regs.c b/fs/trampfd/trampfd_regs.c
new file mode 100644
index 000000000000..35114d647385
--- /dev/null
+++ b/fs/trampfd/trampfd_regs.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Trampoline File Descriptor - Register context.
+ *
+ * Author: Madhavan T. Venkataraman (madvenka@microsoft.com)
+ *
+ * Copyright (C) 2020 Microsoft Corporation.
+ */
+
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/trampfd.h>
+
+/*
+ * Copy context from the user and validate it.
+ */
+static int trampfd_copy_regs(struct trampfd_regs *regs, const void __user *arg,
+			     size_t count)
+{
+	u32			nregs;
+	size_t			size;
+
+	if (copy_from_user(regs, arg, count))
+		return -EFAULT;
+
+	if (regs->reserved)
+		return -EINVAL;
+
+	nregs = regs->nregs;
+	if (nregs > TRAMPFD_MAX_REGS)
+		return -EINVAL;
+
+	size = sizeof(*regs);
+	size += nregs * sizeof(struct trampfd_reg);
+	if (size != count)
+		return -EINVAL;
+
+	if (nregs && !trampfd_valid_regs(regs))
+		return -EINVAL;
+	return 0;
+}
+
+/*
+ * Set the register context for a trampoline.
+ */
+int trampfd_set_regs(struct file *file, const char __user *arg, size_t count)
+{
+	struct trampfd			*trampfd = file->private_data;
+	struct trampfd_regs		*regs, *cur_regs;
+	int				rc;
+
+	if (count < sizeof(*regs) || count > TRAMPFD_MAX_REGS_SIZE)
+		return -EINVAL;
+
+	regs = kmalloc(count, GFP_KERNEL);
+	if (!regs)
+		return -ENOMEM;
+
+	rc = trampfd_copy_regs(regs, arg, count);
+	if (rc)
+		goto out;
+
+	/*
+	 * If nregs is 0, there is no new register context to set.
+	 */
+	if (!regs->nregs) {
+		kfree(regs);
+		regs = NULL;
+	}
+
+	/*
+	 * Swap the new register context with the current one and free the
+	 * current one, if any.
+	 */
+	mutex_lock(&trampfd->lock);
+
+	/*
+	 * Check if the specified PC is allowed.
+	 */
+	if (!regs || trampfd_allowed_pc(trampfd, regs)) {
+		cur_regs = trampfd->regs;
+		trampfd->regs = regs;
+		regs = cur_regs;
+	} else {
+		rc = -EINVAL;
+	}
+
+	mutex_unlock(&trampfd->lock);
+out:
+	kfree(regs);
+	return rc;
+}
+
+/*
+ * Retrieve the register context of a trampoline.
+ */
+int trampfd_get_regs(struct file *file, char __user *arg, size_t count)
+{
+	struct trampfd			*trampfd = file->private_data;
+	struct trampfd_regs		*regs, *cur_regs;
+	size_t				size;
+	int				rc = 0;
+
+	if (count < sizeof(*regs) || count > TRAMPFD_MAX_REGS_SIZE)
+		return -EINVAL;
+
+	regs = kmalloc(count, GFP_KERNEL);
+	if (!regs)
+		return -ENOMEM;
+
+	mutex_lock(&trampfd->lock);
+
+	/*
+	 * Copy the current register context into a local buffer so we can
+	 * copy it to the user outside the lock.
+	 */
+	cur_regs = trampfd->regs;
+	if (cur_regs) {
+		size = sizeof(*cur_regs);
+		size += sizeof(struct trampfd_reg) * cur_regs->nregs;
+		if (size > count)
+			size = count;
+		memcpy(regs, cur_regs, size);
+	} else {
+		size = sizeof(*regs);
+		memset(regs, 0, size);
+	}
+
+	mutex_unlock(&trampfd->lock);
+
+	if (copy_to_user(arg, regs, size))
+		rc = -EFAULT;
+
+	kfree(regs);
+	return rc;
+}
diff --git a/fs/trampfd/trampfd_stack.c b/fs/trampfd/trampfd_stack.c
new file mode 100644
index 000000000000..032c5ed70d57
--- /dev/null
+++ b/fs/trampfd/trampfd_stack.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Trampoline File Descriptor - Stack context.
+ *
+ * Author: Madhavan T. Venkataraman (madvenka@microsoft.com)
+ *
+ * Copyright (C) 2020 Microsoft Corporation.
+ */
+
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/trampfd.h>
+
+/*
+ * Copy context from the user and validate it.
+ */
+static int trampfd_copy_stack(struct trampfd_stack *stack,
+			      const void __user *arg, size_t count)
+{
+	size_t			size;
+
+	if (copy_from_user(stack, arg, count))
+		return -EFAULT;
+
+	if (stack->reserved)
+		return -EINVAL;
+
+	size = stack->size;
+	if (size > TRAMPFD_MAX_DATA_SIZE)
+		return -EINVAL;
+
+	size += sizeof(*stack);
+	if (size != count)
+		return -EINVAL;
+
+	if (!stack->size)
+		return 0;
+
+	if ((stack->flags & ~TRAMPFD_SFLAGS) ||
+	    stack->offset > TRAMPFD_MAX_STACK_OFFSET)
+		return -EINVAL;
+	return 0;
+}
+
+/*
+ * Set the register context for a trampoline.
+ */
+int trampfd_set_stack(struct file *file, const char __user *arg, size_t count)
+{
+	struct trampfd			*trampfd = file->private_data;
+	struct trampfd_stack		*stack, *cur_stack;
+	int				rc;
+
+	if (count < sizeof(*stack) || count > TRAMPFD_MAX_STACK_SIZE)
+		return -EINVAL;
+
+	stack = kmalloc(count, GFP_KERNEL);
+	if (!stack)
+		return -ENOMEM;
+
+	rc = trampfd_copy_stack(stack, arg, count);
+	if (rc)
+		goto out;
+
+	/*
+	 * If size is 0, there is no new stack context to set.
+	 */
+	if (!stack->size) {
+		kfree(stack);
+		stack = NULL;
+	}
+
+	/*
+	 * Swap the new stack context with the current one and free the
+	 * current one, if any.
+	 */
+	mutex_lock(&trampfd->lock);
+
+	cur_stack = trampfd->stack;
+	trampfd->stack = stack;
+	stack = cur_stack;
+
+	mutex_unlock(&trampfd->lock);
+out:
+	kfree(stack);
+	return rc;
+}
+
+/*
+ * Retrieve the register context of a trampoline.
+ */
+int trampfd_get_stack(struct file *file, char __user *arg, size_t count)
+{
+	struct trampfd			*trampfd = file->private_data;
+	struct trampfd_stack		*stack, *cur_stack;
+	size_t				size;
+	int				rc = 0;
+
+	if (count < sizeof(*stack) || count > TRAMPFD_MAX_STACK_SIZE)
+		return -EINVAL;
+
+	stack = kmalloc(count, GFP_KERNEL);
+	if (!stack)
+		return -ENOMEM;
+
+	mutex_lock(&trampfd->lock);
+
+	/*
+	 * Copy the current register context into a local buffer so we can
+	 * copy it to the user outside the lock.
+	 */
+	cur_stack = trampfd->stack;
+	if (cur_stack) {
+		size = sizeof(*cur_stack) + cur_stack->size;
+		if (size > count)
+			size = count;
+		memcpy(stack, cur_stack, size);
+	} else {
+		size = sizeof(*stack);
+		memset(stack, 0, size);
+	}
+
+	mutex_unlock(&trampfd->lock);
+
+	if (copy_to_user(arg, stack, size))
+		rc = -EFAULT;
+
+	kfree(stack);
+	return rc;
+}
diff --git a/fs/trampfd/trampfd_stubs.c b/fs/trampfd/trampfd_stubs.c
new file mode 100644
index 000000000000..8ca29dccbbf7
--- /dev/null
+++ b/fs/trampfd/trampfd_stubs.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Trampoline File Descriptor - Stub functions.
+ *
+ * Author: Madhavan T. Venkataraman (madvenka@microsoft.com)
+ *
+ * Copyright (C) 2020 Microsoft Corporation.
+ */
+
+#include <linux/trampfd.h>
+
+/*
+ * Stub for the arch function that checks if a trampoline type is supported
+ * by the architecture. Return an error for all types that require architecture
+ * support. Return success for the rest as they are generic.
+ */
+int __attribute__((weak)) trampfd_check_arch(struct trampfd *trampfd)
+{
+	if (trampfd->type == TRAMPFD_USER)
+		return -EINVAL;
+	return 0;
+}
+
+/*
+ * Stub for the arch function that checks if a specified register context
+ * is valid.
+ */
+bool __attribute__((weak)) trampfd_valid_regs(struct trampfd_regs *regs)
+{
+	return false;
+}
+
+/*
+ * Stub for the arch function that checks if the PC register in a specified
+ * register context is allowed.
+ */
+bool __attribute__((weak)) trampfd_allowed_pc(struct trampfd *trampfd,
+					      struct trampfd_regs *regs)
+{
+	return false;
+}
diff --git a/fs/trampfd/trampfd_syscall.c b/fs/trampfd/trampfd_syscall.c
new file mode 100644
index 000000000000..675460afc521
--- /dev/null
+++ b/fs/trampfd/trampfd_syscall.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Trampoline File Descriptor - System call.
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
+#include <linux/syscalls.h>
+#include <linux/anon_inodes.h>
+#include <linux/trampfd.h>
+
+char	*trampfd_name = "[trampfd]";
+
+struct kmem_cache	*trampfd_cache;
+
+SYSCALL_DEFINE3(trampfd_create,
+		int, tramp_type,
+		const void __user *, tramp_data,
+		unsigned int, flags)
+{
+	struct trampfd		*trampfd;
+	struct file		*file;
+	int			fd, rc = 0;
+
+	if (!trampfd_cache)
+		return -ENOMEM;
+
+	/*
+	 * Flags are for future use.
+	 */
+	if (flags || !tramp_data)
+		return -EINVAL;
+
+	if (tramp_type < 0 || tramp_type >= TRAMPFD_NUM_TYPES)
+		return -EINVAL;
+
+	trampfd = kmem_cache_zalloc(trampfd_cache, GFP_KERNEL);
+	if (!trampfd)
+		return -ENOMEM;
+
+	mutex_init(&trampfd->lock);
+	trampfd->type = tramp_type;
+
+	rc = trampfd_create_data(trampfd, tramp_data);
+	if (rc)
+		goto freetramp;
+
+	rc = trampfd_check_arch(trampfd);
+	if (rc)
+		goto freedata;
+
+	rc = get_unused_fd_flags(O_CLOEXEC);
+	if (rc < 0)
+		goto freedata;
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
+freedata:
+	kfree(trampfd->data);
+freetramp:
+	kmem_cache_free(trampfd_cache, trampfd);
+	return rc;
+}
+
+int __init trampfd_init(void)
+{
+	trampfd_cache = kmem_cache_create("trampfd_cache",
+		sizeof(struct trampfd), 0, SLAB_HWCACHE_ALIGN, NULL);
+
+	if (trampfd_cache == NULL) {
+		pr_warn("%s: kmem_cache_create failed", __func__);
+		return -ENOMEM;
+	}
+	return 0;
+}
+core_initcall(trampfd_init);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index b951a87da987..25ddf29477bc 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1005,6 +1005,9 @@ asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 				       siginfo_t __user *info,
 				       unsigned int flags);
 asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
+asmlinkage long sys_trampfd_create(int tramp_type,
+				   const void __user *tramp_data,
+				   unsigned int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/linux/trampfd.h b/include/linux/trampfd.h
new file mode 100644
index 000000000000..383d7eeda2d1
--- /dev/null
+++ b/include/linux/trampfd.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Trampoline File Descriptor - Internal structures and definitions.
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
+#define TRAMPFD_MAX_REGS_SIZE						\
+	(sizeof(struct trampfd_regs) +					\
+	(sizeof(struct trampfd_reg) * TRAMPFD_MAX_REGS))
+
+#define TRAMPFD_MAX_STACK_SIZE						\
+	(sizeof(struct trampfd_stack) + TRAMPFD_MAX_DATA_SIZE)
+
+#define TRAMPFD_MAX_PCS_SIZE						\
+	(sizeof(struct trampfd_values) + sizeof(u64) * TRAMPFD_MAX_PCS)
+
+/*
+ * Trampoline structure.
+ */
+struct trampfd {
+	struct mutex		lock;		/* to serialize access */
+	enum trampfd_type	type;		/* type of trampoline */
+	void			*data;		/* type specific data */
+	struct trampfd_map	map;		/* mmap() parameters */
+	struct trampfd_regs	*regs;		/* register context */
+	struct trampfd_stack	*stack;		/* stack context */
+	struct trampfd_values	*allowed_pcs;	/* allowed PCs */
+};
+
+#ifdef CONFIG_TRAMPFD
+
+/* Trampoline mapping */
+int trampfd_mmap(struct file *file, struct vm_area_struct *vma);
+unsigned long trampfd_get_unmapped_area(struct file *file,
+					unsigned long orig_addr,
+					unsigned long len,
+					unsigned long pgoff,
+					unsigned long flags);
+bool is_trampfd_vma(struct vm_area_struct *vma);
+
+/* Trampoline context */
+int trampfd_get_map(struct file *file, char __user *arg, size_t count);
+int trampfd_set_regs(struct file *file, const char __user *arg, size_t count);
+int trampfd_get_regs(struct file *file, char __user *arg, size_t count);
+int trampfd_set_stack(struct file *file, const char __user *arg, size_t count);
+int trampfd_get_stack(struct file *file, char __user *arg, size_t count);
+int trampfd_set_allowed_pcs(struct file *file, const char __user *arg,
+			    size_t count);
+
+/* Arch functions */
+bool trampfd_fault(struct vm_area_struct *vma, struct pt_regs *pt_regs);
+bool trampfd_valid_regs(struct trampfd_regs *regs);
+bool trampfd_allowed_pc(struct trampfd *trampfd, struct trampfd_regs *regs);
+int trampfd_check_arch(struct trampfd *trampfd);
+
+/* Trampoline type-specific */
+int trampfd_create_data(struct trampfd *trampfd, const void __user *tramp_data);
+
+extern char				*trampfd_name;
+extern struct kmem_cache		*trampfd_cache;
+extern const struct file_operations	trampfd_fops;
+
+#define USERPTR(ptr)	((void __user *)(uintptr_t)(ptr))
+
+#else
+
+static inline bool trampfd_fault(struct vm_area_struct *vma,
+				 struct pt_regs *pt_regs)
+{
+	return false;
+}
+
+#endif /* CONFIG_TRAMPFD */
+
+#endif /* _LINUX_TRAMPFD_H */
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index f4a01305d9a6..14e526a45624 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -857,9 +857,11 @@ __SYSCALL(__NR_openat2, sys_openat2)
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 #define __NR_faccessat2 439
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
+#define __NR_trampfd_create 440
+__SYSCALL(__NR_trampfd_create, sys_trampfd_create)
 
 #undef __NR_syscalls
-#define __NR_syscalls 440
+#define __NR_syscalls 441
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/trampfd.h b/include/uapi/linux/trampfd.h
new file mode 100644
index 000000000000..bf9a6ef3683b
--- /dev/null
+++ b/include/uapi/linux/trampfd.h
@@ -0,0 +1,171 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Trampoline File Descriptor - API structures and definitions.
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
+/* ------------------------- Types of Trampolines ------------------------- */
+
+/*
+ * TRAMPFD_USER
+ *	User programs use the kernel as a trampoline to setup a user context
+ *	and jump to a user function. This trampoline type can be used to
+ *	replace user trampoline code.
+ */
+enum trampfd_type {
+	TRAMPFD_USER,
+	TRAMPFD_NUM_TYPES,
+};
+
+/* ---------------------------- Context offsets ---------------------------- */
+
+/*
+ * A trampoline has different types of context associated with it. Each context
+ * type has a symbolic offset into trampfd. The context can be read from or
+ * written to at its symbolic offset in trampfd.
+ *
+ * TRAMPFD_MAP_OFFSET
+ *	To read trampoline mapping parameters - struct ktramp_map.
+ *
+ * TRAMPFD_REGS_OFFSET
+ *	To read/write trampoline register context - struct ktramp_regs.
+ *
+ * TRAMPFD_STACK_OFFSET
+ *	To read/write trampoline stack context - struct ktramp_stack.
+ *
+ * TRAMPFD_ALLOWED_PCS_OFFSET
+ *	To write a list of allowed PCs - struct trampfd_values.
+ */
+enum trampfd_offsets {
+	TRAMPFD_MAP_OFFSET,
+	TRAMPFD_REGS_OFFSET,
+	TRAMPFD_STACK_OFFSET,
+	TRAMPFD_ALLOWED_PCS_OFFSET,
+	TRAMPFD_NUM_OFFSETS,
+};
+
+/* ------------------- Trampoline type specific data -------------------- */
+
+/*
+ * For TRAMPFD_USER.
+ */
+struct trampfd_user {
+	__u32		flags;		/* for future enhancements */
+	__u32		reserved;
+};
+
+/* ------------------- Trampoline mapping parameters ---------------------- */
+
+/*
+ * Since the kernel implements the trampoline object, the kernel specifies
+ * how a trampoline should be mapped. User code must obtain these parameters
+ * and do an mmap() to map the trampoline. The first four parameters are used
+ * in the mmap() call. User code must add ioffset to the address returned by
+ * mmap() to get the actual invocation address for the trampoline.
+ */
+struct trampfd_map {
+	__u32			size;		/* Size of the mapping */
+	__u32			prot;		/* memory protection */
+	__u32			flags;		/* map flags */
+	__u32			offset;		/* file offset */
+	__u32			ioffset;	/* invocation offset */
+	__u32			reserved;
+};
+
+/* -------------------------- Register context -------------------------- */
+
+/*
+ * A register context may be specified for a trampoline, if applicable
+ * to the trampoline type. E.g., TRAMPFD_USER. The register context is
+ * an array of name-value pairs. When a trampoline is invoked, its user
+ * registers are loaded with the specified values. Register names are
+ * architecture specific and can be found in <linux/ptrace.h> for architectures
+ * that support trampolines. Enumerations reg_32_name and reg_64_name in
+ * <linux/ptrace.h> refer to 32-bit and 64-bit respectively.
+ */
+struct trampfd_reg {
+	__u32		name;		/* Register name */
+	__u32		reserved;
+	__u64		value;		/* Register value */
+};
+
+/*
+ * Register context. It is a variable sized structure sized by the number
+ * of registers.
+ */
+struct trampfd_regs {
+	__u32			nregs;		/* Number of registers */
+	__u32			reserved;
+	struct trampfd_reg	regs[0];	/* Array of registers */
+};
+
+#define TRAMPFD_MAX_REGS		40
+
+/* ---------------------------- Stack context ---------------------------- */
+
+/*
+ * A stack context may be specified for a trampoline, if applicable
+ * to the trampoline type. E.g., TRAMPFD_USER. The stack context contains
+ * a data buffer. When a trampoline is invoked, the specified data is pushed
+ * on the stack at a specified offset from the current stack pointer.
+ * Optionally, the stack pointer can be moved to the top of the data.
+ *
+ * This is a variable sized structure sized by the amount of data that is
+ * to be pushed on the user stack.
+ */
+struct trampfd_stack {
+	__u32		flags;			/* TRAMPFD_SFLAGS */
+	__u32		offset;			/* Offset from top of stack */
+	__u32		size;			/* Size of data to push */
+	__u32		reserved;
+	__u8		data[0];		/* Data to push on the stack */
+};
+
+#define TRAMPFD_MAX_DATA_SIZE		64
+#define TRAMPFD_MAX_STACK_OFFSET	256
+
+/*
+ * Stack context flags:
+ *
+ * TRAMPFD_SET_SP
+ *	After pushing the data to user stack, move the stack pointer to the
+ *	base of the data pushed. Note that the kernel will align the stack
+ *	pointer based on the alignment requirements of the architecture.
+ */
+#define TRAMPFD_SET_SP		0x1
+#define TRAMPFD_SFLAGS		(TRAMPFD_SET_SP)
+
+/* ---------------------------- Values context ---------------------------- */
+
+/*
+ * Some contexts may be just a list of values. For instance, the user can
+ * specify a list of allowed PCs for a trampoline. The following structure
+ * is used for those contexts.
+ */
+struct trampfd_values {
+	__u32		nvalues;		/* number of values */
+	__u32		reserved;
+	__u64		values[0];		/* Array of values */
+};
+
+#define TRAMPFD_MAX_PCS		16
+
+/* -------------------------------------------------------------------------- */
+
+#endif /* _UAPI_LINUX_TRAMPFD_H */
diff --git a/init/Kconfig b/init/Kconfig
index 0498af567f70..783a0b98fce1 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2313,3 +2313,11 @@ config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 # <asm/syscall_wrapper.h>.
 config ARCH_HAS_SYSCALL_WRAPPER
 	def_bool n
+
+config TRAMPFD
+	bool "Enable trampfd_create() system call"
+	depends on MMU
+	help
+	  Enable the trampfd_create() system call that allows a process to
+	  map trampolines within its address space that can be invoked
+	  with the help of the kernel.
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 3b69a560a7ac..136acf9234a3 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -349,6 +349,9 @@ COND_SYSCALL(pkey_mprotect);
 COND_SYSCALL(pkey_alloc);
 COND_SYSCALL(pkey_free);
 
+/* Trampoline fd */
+COND_SYSCALL(trampfd_create);
+
 
 /*
  * Architecture specific weak syscall entries.
-- 
2.17.1

