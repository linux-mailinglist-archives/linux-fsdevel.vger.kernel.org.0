Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA75640042
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 07:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiLBGTL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 01:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiLBGTG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 01:19:06 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA1ECE41A;
        Thu,  1 Dec 2022 22:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669961911; x=1701497911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t0LZ0YyKrKPl65oG/djA5Wt39fL9WiC+pwAjlkHR9fE=;
  b=nuKeKhbj/Jr6CtLsIapJ+bf98OkmZ6+orHfxeUdKZ1VbJToWHzK2WGoq
   W3J3o2lx/buoTT5BYkSbkmvmVFkU6Ae4ycOVCXNxZ4xj9dOtDxJbTuxuk
   4rmnajxsK35+FH/z1XssOc4f7LenQzswpCUOmKP1PvsPEd5A3irW7aliH
   1d6/UYfqvIInINIlJRi3wxCcR9MPgsp9Z8WAmX+qkxXFLqb83Cf+ZJFpM
   Ov/l45dgT4GR/xyuWmGGAeoYKjogMglQzgeSfQ66kCKsxUu6ApPXDCq9o
   k0zB4ugr8ZCWGnS4Hzw4PjXK/RlpdtLcQxwdcU16qNeb3g8Y7hw8wuBJT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="380170379"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="380170379"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 22:18:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="733698589"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="733698589"
Received: from chaop.bj.intel.com ([10.240.193.75])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Dec 2022 22:18:19 -0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Subject: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to create restricted user memory
Date:   Fri,  2 Dec 2022 14:13:39 +0800
Message-Id: <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Introduce 'memfd_restricted' system call with the ability to create
memory areas that are restricted from userspace access through ordinary
MMU operations (e.g. read/write/mmap). The memory content is expected to
be used through the new in-kernel interface by a third kernel module.

memfd_restricted() is useful for scenarios where a file descriptor(fd)
can be used as an interface into mm but want to restrict userspace's
ability on the fd. Initially it is designed to provide protections for
KVM encrypted guest memory.

Normally KVM uses memfd memory via mmapping the memfd into KVM userspace
(e.g. QEMU) and then using the mmaped virtual address to setup the
mapping in the KVM secondary page table (e.g. EPT). With confidential
computing technologies like Intel TDX, the memfd memory may be encrypted
with special key for special software domain (e.g. KVM guest) and is not
expected to be directly accessed by userspace. Precisely, userspace
access to such encrypted memory may lead to host crash so should be
prevented.

memfd_restricted() provides semantics required for KVM guest encrypted
memory support that a fd created with memfd_restricted() is going to be
used as the source of guest memory in confidential computing environment
and KVM can directly interact with core-mm without the need to expose
the memoy content into KVM userspace.

KVM userspace is still in charge of the lifecycle of the fd. It should
pass the created fd to KVM. KVM uses the new restrictedmem_get_page() to
obtain the physical memory page and then uses it to populate the KVM
secondary page table entries.

The userspace restricted memfd can be fallocate-ed or hole-punched
from userspace. When hole-punched, KVM can get notified through
invalidate_start/invalidate_end() callbacks, KVM then gets chance to
remove any mapped entries of the range in the secondary page tables.

Machine check can happen for memory pages in the restricted memfd,
instead of routing this directly to userspace, we call the error()
callback that KVM registered. KVM then gets chance to handle it
correctly.

memfd_restricted() itself is implemented as a shim layer on top of real
memory file systems (currently tmpfs). Pages in restrictedmem are marked
as unmovable and unevictable, this is required for current confidential
usage. But in future this might be changed.

By default memfd_restricted() prevents userspace read, write and mmap.
By defining new bit in the 'flags', it can be extended to support other
restricted semantics in the future.

The system call is currently wired up for x86 arch.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 include/linux/restrictedmem.h          |  71 ++++++
 include/linux/syscalls.h               |   1 +
 include/uapi/asm-generic/unistd.h      |   5 +-
 include/uapi/linux/magic.h             |   1 +
 kernel/sys_ni.c                        |   3 +
 mm/Kconfig                             |   4 +
 mm/Makefile                            |   1 +
 mm/memory-failure.c                    |   3 +
 mm/restrictedmem.c                     | 318 +++++++++++++++++++++++++
 11 files changed, 408 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/restrictedmem.h
 create mode 100644 mm/restrictedmem.c

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 320480a8db4f..dc70ba90247e 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -455,3 +455,4 @@
 448	i386	process_mrelease	sys_process_mrelease
 449	i386	futex_waitv		sys_futex_waitv
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	i386	memfd_restricted	sys_memfd_restricted
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index c84d12608cd2..06516abc8318 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,7 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	common	memfd_restricted	sys_memfd_restricted
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/restrictedmem.h b/include/linux/restrictedmem.h
new file mode 100644
index 000000000000..c2700c5daa43
--- /dev/null
+++ b/include/linux/restrictedmem.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _LINUX_RESTRICTEDMEM_H
+
+#include <linux/file.h>
+#include <linux/magic.h>
+#include <linux/pfn_t.h>
+
+struct restrictedmem_notifier;
+
+struct restrictedmem_notifier_ops {
+	void (*invalidate_start)(struct restrictedmem_notifier *notifier,
+				 pgoff_t start, pgoff_t end);
+	void (*invalidate_end)(struct restrictedmem_notifier *notifier,
+			       pgoff_t start, pgoff_t end);
+	void (*error)(struct restrictedmem_notifier *notifier,
+			       pgoff_t start, pgoff_t end);
+};
+
+struct restrictedmem_notifier {
+	struct list_head list;
+	const struct restrictedmem_notifier_ops *ops;
+};
+
+#ifdef CONFIG_RESTRICTEDMEM
+
+void restrictedmem_register_notifier(struct file *file,
+				     struct restrictedmem_notifier *notifier);
+void restrictedmem_unregister_notifier(struct file *file,
+				       struct restrictedmem_notifier *notifier);
+
+int restrictedmem_get_page(struct file *file, pgoff_t offset,
+			   struct page **pagep, int *order);
+
+static inline bool file_is_restrictedmem(struct file *file)
+{
+	return file->f_inode->i_sb->s_magic == RESTRICTEDMEM_MAGIC;
+}
+
+void restrictedmem_error_page(struct page *page, struct address_space *mapping);
+
+#else
+
+static inline void restrictedmem_register_notifier(struct file *file,
+				     struct restrictedmem_notifier *notifier)
+{
+}
+
+static inline void restrictedmem_unregister_notifier(struct file *file,
+				       struct restrictedmem_notifier *notifier)
+{
+}
+
+static inline int restrictedmem_get_page(struct file *file, pgoff_t offset,
+					 struct page **pagep, int *order)
+{
+	return -1;
+}
+
+static inline bool file_is_restrictedmem(struct file *file)
+{
+	return false;
+}
+
+static inline void restrictedmem_error_page(struct page *page,
+					    struct address_space *mapping)
+{
+}
+
+#endif /* CONFIG_RESTRICTEDMEM */
+
+#endif /* _LINUX_RESTRICTEDMEM_H */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a34b0f9a9972..f9e9e0c820c5 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1056,6 +1056,7 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
 asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
 					    unsigned long home_node,
 					    unsigned long flags);
+asmlinkage long sys_memfd_restricted(unsigned int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 45fa180cc56a..e93cd35e46d0 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -886,8 +886,11 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 
+#define __NR_memfd_restricted 451
+__SYSCALL(__NR_memfd_restricted, sys_memfd_restricted)
+
 #undef __NR_syscalls
-#define __NR_syscalls 451
+#define __NR_syscalls 452
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 6325d1d0e90f..8aa38324b90a 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -101,5 +101,6 @@
 #define DMA_BUF_MAGIC		0x444d4142	/* "DMAB" */
 #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
 #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
+#define RESTRICTEDMEM_MAGIC	0x5245534d	/* "RESM" */
 
 #endif /* __LINUX_MAGIC_H__ */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 860b2dcf3ac4..7c4a32cbd2e7 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -360,6 +360,9 @@ COND_SYSCALL(pkey_free);
 /* memfd_secret */
 COND_SYSCALL(memfd_secret);
 
+/* memfd_restricted */
+COND_SYSCALL(memfd_restricted);
+
 /*
  * Architecture specific weak syscall entries.
  */
diff --git a/mm/Kconfig b/mm/Kconfig
index 57e1d8c5b505..06b0e1d6b8c1 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1076,6 +1076,10 @@ config IO_MAPPING
 config SECRETMEM
 	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
 
+config RESTRICTEDMEM
+	bool
+	depends on TMPFS
+
 config ANON_VMA_NAME
 	bool "Anonymous VMA name support"
 	depends on PROC_FS && ADVISE_SYSCALLS && MMU
diff --git a/mm/Makefile b/mm/Makefile
index 8e105e5b3e29..bcbb0edf9ba1 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -121,6 +121,7 @@ obj-$(CONFIG_PAGE_EXTENSION) += page_ext.o
 obj-$(CONFIG_PAGE_TABLE_CHECK) += page_table_check.o
 obj-$(CONFIG_CMA_DEBUGFS) += cma_debug.o
 obj-$(CONFIG_SECRETMEM) += secretmem.o
+obj-$(CONFIG_RESTRICTEDMEM) += restrictedmem.o
 obj-$(CONFIG_CMA_SYSFS) += cma_sysfs.o
 obj-$(CONFIG_USERFAULTFD) += userfaultfd.o
 obj-$(CONFIG_IDLE_PAGE_TRACKING) += page_idle.o
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 145bb561ddb3..f91b444e471e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -62,6 +62,7 @@
 #include <linux/page-isolation.h>
 #include <linux/pagewalk.h>
 #include <linux/shmem_fs.h>
+#include <linux/restrictedmem.h>
 #include "swap.h"
 #include "internal.h"
 #include "ras/ras_event.h"
@@ -940,6 +941,8 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
 		goto out;
 	}
 
+	restrictedmem_error_page(p, mapping);
+
 	/*
 	 * The shmem page is kept in page cache instead of truncating
 	 * so is expected to have an extra refcount after error-handling.
diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
new file mode 100644
index 000000000000..56953c204e5c
--- /dev/null
+++ b/mm/restrictedmem.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "linux/sbitmap.h"
+#include <linux/pagemap.h>
+#include <linux/pseudo_fs.h>
+#include <linux/shmem_fs.h>
+#include <linux/syscalls.h>
+#include <uapi/linux/falloc.h>
+#include <uapi/linux/magic.h>
+#include <linux/restrictedmem.h>
+
+struct restrictedmem_data {
+	struct mutex lock;
+	struct file *memfd;
+	struct list_head notifiers;
+};
+
+static void restrictedmem_invalidate_start(struct restrictedmem_data *data,
+					   pgoff_t start, pgoff_t end)
+{
+	struct restrictedmem_notifier *notifier;
+
+	mutex_lock(&data->lock);
+	list_for_each_entry(notifier, &data->notifiers, list) {
+		notifier->ops->invalidate_start(notifier, start, end);
+	}
+	mutex_unlock(&data->lock);
+}
+
+static void restrictedmem_invalidate_end(struct restrictedmem_data *data,
+					 pgoff_t start, pgoff_t end)
+{
+	struct restrictedmem_notifier *notifier;
+
+	mutex_lock(&data->lock);
+	list_for_each_entry(notifier, &data->notifiers, list) {
+		notifier->ops->invalidate_end(notifier, start, end);
+	}
+	mutex_unlock(&data->lock);
+}
+
+static void restrictedmem_notifier_error(struct restrictedmem_data *data,
+					 pgoff_t start, pgoff_t end)
+{
+	struct restrictedmem_notifier *notifier;
+
+	mutex_lock(&data->lock);
+	list_for_each_entry(notifier, &data->notifiers, list) {
+		notifier->ops->error(notifier, start, end);
+	}
+	mutex_unlock(&data->lock);
+}
+
+static int restrictedmem_release(struct inode *inode, struct file *file)
+{
+	struct restrictedmem_data *data = inode->i_mapping->private_data;
+
+	fput(data->memfd);
+	kfree(data);
+	return 0;
+}
+
+static long restrictedmem_punch_hole(struct restrictedmem_data *data, int mode,
+				     loff_t offset, loff_t len)
+{
+	int ret;
+	pgoff_t start, end;
+	struct file *memfd = data->memfd;
+
+	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
+		return -EINVAL;
+
+	start = offset >> PAGE_SHIFT;
+	end = (offset + len) >> PAGE_SHIFT;
+
+	restrictedmem_invalidate_start(data, start, end);
+	ret = memfd->f_op->fallocate(memfd, mode, offset, len);
+	restrictedmem_invalidate_end(data, start, end);
+
+	return ret;
+}
+
+static long restrictedmem_fallocate(struct file *file, int mode,
+				    loff_t offset, loff_t len)
+{
+	struct restrictedmem_data *data = file->f_mapping->private_data;
+	struct file *memfd = data->memfd;
+
+	if (mode & FALLOC_FL_PUNCH_HOLE)
+		return restrictedmem_punch_hole(data, mode, offset, len);
+
+	return memfd->f_op->fallocate(memfd, mode, offset, len);
+}
+
+static const struct file_operations restrictedmem_fops = {
+	.release = restrictedmem_release,
+	.fallocate = restrictedmem_fallocate,
+};
+
+static int restrictedmem_getattr(struct user_namespace *mnt_userns,
+				 const struct path *path, struct kstat *stat,
+				 u32 request_mask, unsigned int query_flags)
+{
+	struct inode *inode = d_inode(path->dentry);
+	struct restrictedmem_data *data = inode->i_mapping->private_data;
+	struct file *memfd = data->memfd;
+
+	return memfd->f_inode->i_op->getattr(mnt_userns, path, stat,
+					     request_mask, query_flags);
+}
+
+static int restrictedmem_setattr(struct user_namespace *mnt_userns,
+				 struct dentry *dentry, struct iattr *attr)
+{
+	struct inode *inode = d_inode(dentry);
+	struct restrictedmem_data *data = inode->i_mapping->private_data;
+	struct file *memfd = data->memfd;
+	int ret;
+
+	if (attr->ia_valid & ATTR_SIZE) {
+		if (memfd->f_inode->i_size)
+			return -EPERM;
+
+		if (!PAGE_ALIGNED(attr->ia_size))
+			return -EINVAL;
+	}
+
+	ret = memfd->f_inode->i_op->setattr(mnt_userns,
+					    file_dentry(memfd), attr);
+	return ret;
+}
+
+static const struct inode_operations restrictedmem_iops = {
+	.getattr = restrictedmem_getattr,
+	.setattr = restrictedmem_setattr,
+};
+
+static int restrictedmem_init_fs_context(struct fs_context *fc)
+{
+	if (!init_pseudo(fc, RESTRICTEDMEM_MAGIC))
+		return -ENOMEM;
+
+	fc->s_iflags |= SB_I_NOEXEC;
+	return 0;
+}
+
+static struct file_system_type restrictedmem_fs = {
+	.owner		= THIS_MODULE,
+	.name		= "memfd:restrictedmem",
+	.init_fs_context = restrictedmem_init_fs_context,
+	.kill_sb	= kill_anon_super,
+};
+
+static struct vfsmount *restrictedmem_mnt;
+
+static __init int restrictedmem_init(void)
+{
+	restrictedmem_mnt = kern_mount(&restrictedmem_fs);
+	if (IS_ERR(restrictedmem_mnt))
+		return PTR_ERR(restrictedmem_mnt);
+	return 0;
+}
+fs_initcall(restrictedmem_init);
+
+static struct file *restrictedmem_file_create(struct file *memfd)
+{
+	struct restrictedmem_data *data;
+	struct address_space *mapping;
+	struct inode *inode;
+	struct file *file;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+
+	data->memfd = memfd;
+	mutex_init(&data->lock);
+	INIT_LIST_HEAD(&data->notifiers);
+
+	inode = alloc_anon_inode(restrictedmem_mnt->mnt_sb);
+	if (IS_ERR(inode)) {
+		kfree(data);
+		return ERR_CAST(inode);
+	}
+
+	inode->i_mode |= S_IFREG;
+	inode->i_op = &restrictedmem_iops;
+	inode->i_mapping->private_data = data;
+
+	file = alloc_file_pseudo(inode, restrictedmem_mnt,
+				 "restrictedmem", O_RDWR,
+				 &restrictedmem_fops);
+	if (IS_ERR(file)) {
+		iput(inode);
+		kfree(data);
+		return ERR_CAST(file);
+	}
+
+	file->f_flags |= O_LARGEFILE;
+
+	/*
+	 * These pages are currently unmovable so don't place them into movable
+	 * pageblocks (e.g. CMA and ZONE_MOVABLE).
+	 */
+	mapping = memfd->f_mapping;
+	mapping_set_unevictable(mapping);
+	mapping_set_gfp_mask(mapping,
+			     mapping_gfp_mask(mapping) & ~__GFP_MOVABLE);
+
+	return file;
+}
+
+SYSCALL_DEFINE1(memfd_restricted, unsigned int, flags)
+{
+	struct file *file, *restricted_file;
+	int fd, err;
+
+	if (flags)
+		return -EINVAL;
+
+	fd = get_unused_fd_flags(0);
+	if (fd < 0)
+		return fd;
+
+	file = shmem_file_setup("memfd:restrictedmem", 0, VM_NORESERVE);
+	if (IS_ERR(file)) {
+		err = PTR_ERR(file);
+		goto err_fd;
+	}
+	file->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
+	file->f_flags |= O_LARGEFILE;
+
+	restricted_file = restrictedmem_file_create(file);
+	if (IS_ERR(restricted_file)) {
+		err = PTR_ERR(restricted_file);
+		fput(file);
+		goto err_fd;
+	}
+
+	fd_install(fd, restricted_file);
+	return fd;
+err_fd:
+	put_unused_fd(fd);
+	return err;
+}
+
+void restrictedmem_register_notifier(struct file *file,
+				     struct restrictedmem_notifier *notifier)
+{
+	struct restrictedmem_data *data = file->f_mapping->private_data;
+
+	mutex_lock(&data->lock);
+	list_add(&notifier->list, &data->notifiers);
+	mutex_unlock(&data->lock);
+}
+EXPORT_SYMBOL_GPL(restrictedmem_register_notifier);
+
+void restrictedmem_unregister_notifier(struct file *file,
+				       struct restrictedmem_notifier *notifier)
+{
+	struct restrictedmem_data *data = file->f_mapping->private_data;
+
+	mutex_lock(&data->lock);
+	list_del(&notifier->list);
+	mutex_unlock(&data->lock);
+}
+EXPORT_SYMBOL_GPL(restrictedmem_unregister_notifier);
+
+int restrictedmem_get_page(struct file *file, pgoff_t offset,
+			   struct page **pagep, int *order)
+{
+	struct restrictedmem_data *data = file->f_mapping->private_data;
+	struct file *memfd = data->memfd;
+	struct folio *folio;
+	struct page *page;
+	int ret;
+
+	ret = shmem_get_folio(file_inode(memfd), offset, &folio, SGP_WRITE);
+	if (ret)
+		return ret;
+
+	page = folio_file_page(folio, offset);
+	*pagep = page;
+	if (order)
+		*order = thp_order(compound_head(page));
+
+	SetPageUptodate(page);
+	unlock_page(page);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(restrictedmem_get_page);
+
+void restrictedmem_error_page(struct page *page, struct address_space *mapping)
+{
+	struct super_block *sb = restrictedmem_mnt->mnt_sb;
+	struct inode *inode, *next;
+
+	if (!shmem_mapping(mapping))
+		return;
+
+	spin_lock(&sb->s_inode_list_lock);
+	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
+		struct restrictedmem_data *data = inode->i_mapping->private_data;
+		struct file *memfd = data->memfd;
+
+		if (memfd->f_mapping == mapping) {
+			pgoff_t start, end;
+
+			spin_unlock(&sb->s_inode_list_lock);
+
+			start = page->index;
+			end = start + thp_nr_pages(page);
+			restrictedmem_notifier_error(data, start, end);
+			return;
+		}
+	}
+	spin_unlock(&sb->s_inode_list_lock);
+}
-- 
2.25.1

