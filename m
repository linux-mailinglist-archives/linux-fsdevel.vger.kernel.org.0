Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8965A2128
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 08:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245174AbiHZGqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 02:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245108AbiHZGqR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 02:46:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3A1D1E2D;
        Thu, 25 Aug 2022 23:46:03 -0700 (PDT)
Received: from lenovo.Home (unknown [39.53.61.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CF8946601EC8;
        Fri, 26 Aug 2022 07:45:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661496362;
        bh=1jHw5sa9fTu8NOc1dlqFzISRY1ZlcDb3kYV3xpKJeTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XfGOdhKFwYd0TiLxAexIHGbGSvw0lmUiYdoKcDv2Ecga3r6OM2J0nZ+xn8dRa9o6H
         /NDzorWLIIy0X8arNr1NM3PIqLhghL14q7iJouwp0AMDvqr6aV8iN8UzX2H+0XvPhx
         by0zS13MJKFrMhmuelxfwedd56Rf+BNi/AtbYqsJb1cKpeHJJ9LwKhJmRNijjOZM5P
         3x6LrWPI6EPfnPy4bBuxyCcsJVH17Hg7QHcxB8bPqOYFcdct47ysc0/Euj4pAZ71IU
         Um744KAE7cSeuGbrftvVPQCAhpvhRv9AqHeHbfQaMHe+RptUAzwMKjr9yOjV/g70Sm
         2VY2kuxPXtB9w==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        linux-fsdevel@vger.kernel.org (open list:PROC FILESYSTEM),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH v3 2/4] fs/proc/task_mmu: Implement IOCTL to get and clear soft dirty PTE bit
Date:   Fri, 26 Aug 2022 11:45:33 +0500
Message-Id: <20220826064535.1941190-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220826064535.1941190-1-usama.anjum@collabora.com>
References: <20220826064535.1941190-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This ioctl can be used to watch the process's memory and perform
atomic operations which aren't possible through procfs. Three
operations have been implemented:

- PAGEMAP_SD_GET gets the soft dirty pages in a address range.
- PAGEMAP_SD_CLEAR clears the soft dirty bit from dirty pages in a
  address range.
- PAGEMAP_SD_GET_AND_CLEAR gets and clears the soft dirty bit in a
  address range.

struct pagemap_sd_args is used as the argument of the IOCTL. In this
struct:
- The range is specified through start and len.
- The output buffer and size is specified as vec and vec_len.
- The flags can be specified in the flags field. Currently only one
  PAGEMAP_SD_NO_REUSED_REGIONS is supported which can be specified to
  ignore the VMA dirty flags.

This is based on a patch from Gabriel Krisman Bertazi.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes in v3:
- Tighten the user-kernel interface by using explicit types and add more
  error checking

Changes in v2:
- Convert the interface from syscall to ioctl
- Remove pidfd support as it doesn't make sense in ioctl
---
 fs/proc/task_mmu.c            | 260 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/fs.h       |  23 +++
 tools/include/uapi/linux/fs.h |  23 +++
 3 files changed, 306 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f66674033207..33d3d5c2ab40 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -19,6 +19,8 @@
 #include <linux/shmem_fs.h>
 #include <linux/uaccess.h>
 #include <linux/pkeys.h>
+#include <uapi/linux/fs.h>
+#include <linux/vmalloc.h>
 
 #include <asm/elf.h>
 #include <asm/tlb.h>
@@ -1775,11 +1777,269 @@ static int pagemap_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+#ifdef CONFIG_MEM_SOFT_DIRTY
+#define IS_CLEAR_SD_OP(op) (op == PAGEMAP_SD_CLEAR || op == PAGEMAP_SD_GET_AND_CLEAR)
+#define IS_GET_SD_OP(op) (op == PAGEMAP_SD_GET || op == PAGEMAP_SD_GET_AND_CLEAR)
+#define PAGEMAP_SD_FLAGS_MASK (PAGEMAP_SD_NO_REUSED_REGIONS)
+
+struct pagemap_sd_private {
+	unsigned long start;
+	__u64 *vec;
+	unsigned long vec_len;
+	unsigned long index;
+	unsigned int op;
+	unsigned int flags;
+};
+
+static int pagemap_sd_pmd_entry(pmd_t *pmd, unsigned long addr,
+				unsigned long end, struct mm_walk *walk)
+{
+	struct pagemap_sd_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	unsigned long start = addr;
+	spinlock_t *ptl;
+	pte_t *pte;
+	int dirty;
+	bool dirty_vma = (p->flags & PAGEMAP_SD_NO_REUSED_REGIONS) ? 0 :
+			 (vma->vm_flags & VM_SOFTDIRTY);
+
+	end = min(end, walk->vma->vm_end);
+	ptl = pmd_trans_huge_lock(pmd, vma);
+	if (ptl) {
+		if (dirty_vma || check_soft_dirty_pmd(vma, addr, pmd, false)) {
+			/*
+			 * Break huge page into small pages if operation needs to be performed is
+			 * on a portion of the huge page or the return buffer cannot store complete
+			 * data. Then process this PMD as having normal pages.
+			 */
+			if ((IS_CLEAR_SD_OP(p->op) && (end - addr < HPAGE_SIZE)) ||
+			    (IS_GET_SD_OP(p->op) && (p->index + HPAGE_SIZE/PAGE_SIZE > p->vec_len))) {
+				spin_unlock(ptl);
+				split_huge_pmd(vma, pmd, addr);
+				goto process_smaller_pages;
+			} else {
+				dirty = check_soft_dirty_pmd(vma, addr, pmd, IS_CLEAR_SD_OP(p->op));
+				if (IS_GET_SD_OP(p->op) && (dirty_vma || dirty)) {
+					for (; addr != end && p->index < p->vec_len;
+					     addr += PAGE_SIZE)
+						p->vec[p->index++] = addr - p->start;
+				}
+			}
+		}
+		spin_unlock(ptl);
+		return 0;
+	}
+
+process_smaller_pages:
+	if (pmd_trans_unstable(pmd))
+		return 0;
+
+	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	for (; addr != end; pte++, addr += PAGE_SIZE) {
+		dirty = check_soft_dirty(vma, addr, pte, IS_CLEAR_SD_OP(p->op));
+
+		if (IS_GET_SD_OP(p->op) && (dirty_vma || dirty)) {
+			p->vec[p->index++] = addr - p->start;
+			WARN_ON(p->index > p->vec_len);
+		}
+	}
+	pte_unmap_unlock(pte - 1, ptl);
+	cond_resched();
+
+	if (IS_CLEAR_SD_OP(p->op))
+		flush_tlb_mm_range(vma->vm_mm, start, end, PAGE_SHIFT, false);
+
+	return 0;
+}
+
+static int pagemap_sd_pte_hole(unsigned long addr, unsigned long end, int depth,
+			       struct mm_walk *walk)
+{
+	struct pagemap_sd_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+
+	if (p->flags & PAGEMAP_SD_NO_REUSED_REGIONS)
+		return 0;
+
+	if (vma && (vma->vm_flags & VM_SOFTDIRTY) && IS_GET_SD_OP(p->op)) {
+		for (; addr != end && p->index < p->vec_len; addr += PAGE_SIZE)
+			p->vec[p->index++] = addr - p->start;
+	}
+
+	return 0;
+}
+
+static int pagemap_sd_pre_vma(unsigned long start, unsigned long end, struct mm_walk *walk)
+{
+	struct pagemap_sd_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	int ret;
+	unsigned long end_cut = end;
+
+	if (p->flags & PAGEMAP_SD_NO_REUSED_REGIONS)
+		return 0;
+
+	if (IS_CLEAR_SD_OP(p->op) && (vma->vm_flags & VM_SOFTDIRTY)) {
+		if (vma->vm_start < start) {
+			ret = split_vma(vma->vm_mm, vma, start, 1);
+			if (ret)
+				return ret;
+		}
+
+		if (IS_GET_SD_OP(p->op))
+			end_cut = min(start + p->vec_len * PAGE_SIZE, end);
+
+		if (vma->vm_end > end_cut) {
+			ret = split_vma(vma->vm_mm, vma, end_cut, 0);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void pagemap_sd_post_vma(struct mm_walk *walk)
+{
+	struct pagemap_sd_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+
+	if (p->flags & PAGEMAP_SD_NO_REUSED_REGIONS)
+		return;
+
+	if (IS_CLEAR_SD_OP(p->op) && (vma->vm_flags & VM_SOFTDIRTY)) {
+		vma->vm_flags &= ~VM_SOFTDIRTY;
+		vma_set_page_prot(vma);
+	}
+}
+
+static int pagemap_sd_pmd_test_walk(unsigned long start, unsigned long end,
+				    struct mm_walk *walk)
+{
+	struct pagemap_sd_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+
+	if (IS_GET_SD_OP(p->op) && (p->index == p->vec_len))
+		return -1;
+
+	if (vma->vm_flags & VM_PFNMAP)
+		return 1;
+
+	return 0;
+}
+
+static const struct mm_walk_ops pagemap_sd_ops = {
+	.test_walk = pagemap_sd_pmd_test_walk,
+	.pre_vma = pagemap_sd_pre_vma,
+	.pmd_entry = pagemap_sd_pmd_entry,
+	.pte_hole = pagemap_sd_pte_hole,
+	.post_vma = pagemap_sd_post_vma,
+};
+
+static long do_pagemap_sd_cmd(struct mm_struct *mm, unsigned int cmd, struct pagemap_sd_args *arg)
+{
+	struct pagemap_sd_private sd_data;
+	struct mmu_notifier_range range;
+	unsigned long start, end;
+	int ret;
+
+	start = (unsigned long)untagged_addr(arg->start);
+	if ((!IS_ALIGNED(start, PAGE_SIZE)) || (!access_ok((void __user *)start, arg->len)))
+		return -EINVAL;
+
+	if (IS_GET_SD_OP(cmd) &&
+	    ((arg->vec_len == 0) || (!arg->vec) || (!access_ok((loff_t *)arg->vec, arg->vec_len))))
+		return -EINVAL;
+
+	if ((arg->flags & ~PAGEMAP_SD_FLAGS_MASK) || (arg->__reserved))
+		return -EINVAL;
+
+	end = start + arg->len;
+	sd_data.start = start;
+	sd_data.op = cmd;
+	sd_data.flags = arg->flags;
+	sd_data.index = 0;
+	sd_data.vec_len = arg->vec_len;
+
+	if (IS_GET_SD_OP(cmd)) {
+		sd_data.vec = vzalloc(arg->vec_len * sizeof(loff_t));
+		if (!sd_data.vec)
+			return -ENOMEM;
+	}
+
+	if (IS_CLEAR_SD_OP(cmd)) {
+		mmap_write_lock(mm);
+
+		mmu_notifier_range_init(&range, MMU_NOTIFY_SOFT_DIRTY, 0, NULL,
+					mm, start, end);
+		mmu_notifier_invalidate_range_start(&range);
+		inc_tlb_flush_pending(mm);
+	} else {
+		mmap_read_lock(mm);
+	}
+
+	ret = walk_page_range(mm, start, end, &pagemap_sd_ops, &sd_data);
+
+	if (IS_CLEAR_SD_OP(cmd)) {
+		mmu_notifier_invalidate_range_end(&range);
+		dec_tlb_flush_pending(mm);
+
+		mmap_write_unlock(mm);
+	} else {
+		mmap_read_unlock(mm);
+	}
+
+	if (ret < 0)
+		goto free_sd_data;
+
+	if (IS_GET_SD_OP(cmd)) {
+		ret = copy_to_user((loff_t *)arg->vec, sd_data.vec, sd_data.index * sizeof(loff_t));
+		if (ret) {
+			ret = -EIO;
+			goto free_sd_data;
+		}
+		ret = sd_data.index;
+	} else {
+		ret = 0;
+	}
+
+free_sd_data:
+	if (IS_GET_SD_OP(cmd))
+		vfree(sd_data.vec);
+
+	return ret;
+}
+
+static long pagemap_sd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct pagemap_sd_args __user *uarg = (struct pagemap_sd_args __user *)arg;
+	struct mm_struct *mm = file->private_data;
+	struct pagemap_sd_args arguments;
+
+	switch (cmd) {
+	case PAGEMAP_SD_GET:
+		fallthrough;
+	case PAGEMAP_SD_CLEAR:
+		fallthrough;
+	case PAGEMAP_SD_GET_AND_CLEAR:
+		if (copy_from_user(&arguments, uarg, sizeof(struct pagemap_sd_args)))
+			return -EFAULT;
+		return do_pagemap_sd_cmd(mm, cmd, &arguments);
+	default:
+		return -EINVAL;
+	}
+}
+#endif /* CONFIG_MEM_SOFT_DIRTY */
+
 const struct file_operations proc_pagemap_operations = {
 	.llseek		= mem_lseek, /* borrow this */
 	.read		= pagemap_read,
 	.open		= pagemap_open,
 	.release	= pagemap_release,
+#ifdef CONFIG_MEM_SOFT_DIRTY
+	.unlocked_ioctl = pagemap_sd_ioctl,
+	.compat_ioctl = pagemap_sd_ioctl,
+#endif /* CONFIG_MEM_SOFT_DIRTY */
 };
 #endif /* CONFIG_PROC_PAGE_MONITOR */
 
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index b7b56871029c..4f6d1c0ae524 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -305,4 +305,27 @@ typedef int __bitwise __kernel_rwf_t;
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
 			 RWF_APPEND)
 
+/**
+ * struct pagemap_sd_args - Soft-dirty IOCTL argument
+ * @start:	Starting address
+ * @len:	Length of the region
+ * @vec:	Output buffer address
+ * @vec_len:	Length of the output buffer
+ * @flags:	Special flags for the IOCTL
+ * @__reserved:	Reserved member to preserve data alignment. Should be 0.
+ */
+struct pagemap_sd_args {
+	__u64 __user start;
+	__u64 len;
+	__u64 __user vec;
+	__u64 vec_len;
+	__u32 flags;
+	__u32 __reserved;
+};
+
+#define PAGEMAP_SD_GET			_IOWR('f', 16, struct pagemap_sd_args)
+#define PAGEMAP_SD_CLEAR		_IOWR('f', 17, struct pagemap_sd_args)
+#define PAGEMAP_SD_GET_AND_CLEAR	_IOWR('f', 18, struct pagemap_sd_args)
+#define PAGEMAP_SD_NO_REUSED_REGIONS	0x1
+
 #endif /* _UAPI_LINUX_FS_H */
diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index b7b56871029c..4f6d1c0ae524 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -305,4 +305,27 @@ typedef int __bitwise __kernel_rwf_t;
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
 			 RWF_APPEND)
 
+/**
+ * struct pagemap_sd_args - Soft-dirty IOCTL argument
+ * @start:	Starting address
+ * @len:	Length of the region
+ * @vec:	Output buffer address
+ * @vec_len:	Length of the output buffer
+ * @flags:	Special flags for the IOCTL
+ * @__reserved:	Reserved member to preserve data alignment. Should be 0.
+ */
+struct pagemap_sd_args {
+	__u64 __user start;
+	__u64 len;
+	__u64 __user vec;
+	__u64 vec_len;
+	__u32 flags;
+	__u32 __reserved;
+};
+
+#define PAGEMAP_SD_GET			_IOWR('f', 16, struct pagemap_sd_args)
+#define PAGEMAP_SD_CLEAR		_IOWR('f', 17, struct pagemap_sd_args)
+#define PAGEMAP_SD_GET_AND_CLEAR	_IOWR('f', 18, struct pagemap_sd_args)
+#define PAGEMAP_SD_NO_REUSED_REGIONS	0x1
+
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.30.2

