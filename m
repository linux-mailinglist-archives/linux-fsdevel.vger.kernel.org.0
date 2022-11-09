Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD02A622857
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 11:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiKIKYB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 05:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiKIKX7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:23:59 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4223F036;
        Wed,  9 Nov 2022 02:23:49 -0800 (PST)
Received: from localhost.localdomain (unknown [39.45.244.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F095F66029B2;
        Wed,  9 Nov 2022 10:23:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667989428;
        bh=Y69e7SZGLjPBX04Q5GED7xOrYf2B54VxwzriqzxwKtc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gXegS/LFTSXPRPrsnK8MMQzRRjUAEZ/4d/2xgTHRgNOdEFCyA1AbkdksK+RIAApc8
         utFVMXBWeQ36ZV/7xdg4rFLMh85sj7MVLu0TtC/tHRKUwPo3qz2yEbI8V0BUBACzne
         ZO1lTaIzrwhv+pWJpcPdKTg96+GyYLEUjHIwOwJxmKNg0ml+ZNxAXCSY72X8Lv3MK1
         ddLRb07QXn/2CANEGlqnLQmkCs6YxrBfdUxRCp/fzO/X9Rkq/DGbVTs7w6cxWppWXi
         V8Hrk1ecB2ujmUxfF/BauimmPqJV7Ky65xpPFxun6Kni6UPCn0+6YRW/8pB4lGwOyt
         K6XSeZICm0u3g==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Zach O'Keefe" <zokeefe@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        "open list : KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list : PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list : MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Paul Gofman <pgofman@codeweavers.com>
Subject: [PATCH v6 2/3] fs/proc/task_mmu: Implement IOCTL to get and/or the clear info about PTEs
Date:   Wed,  9 Nov 2022 15:23:02 +0500
Message-Id: <20221109102303.851281-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221109102303.851281-1-usama.anjum@collabora.com>
References: <20221109102303.851281-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This IOCTL, PAGEMAP_SCAN can be used to get and/or clear the info about
page table entries. The following operations are supported in this ioctl:
- Get the information if the pages are soft-dirty, file mapped, present
  or swapped.
- Clear the soft-dirty PTE bit of the pages.
- Get and clear the soft-dirty PTE bit of the pages.

Only the soft-dirty bit can be read and cleared atomically. struct
pagemap_sd_args is used as the argument of the IOCTL. In this struct:
- The range is specified through start and len.
- The output buffer and size is specified as vec and vec_len.
- The optional maximum requested pages are specified in the max_pages.
- The flags can be specified in the flags field. The PAGEMAP_SD_CLEAR
  and PAGEMAP_SD_NO_REUSED_REGIONS are supported.
- The masks are specified in rmask, amask, emask and return_mask.

This IOCTL can be extended to get information about more PTE bits.

This is based on a patch from Gabriel Krisman Bertazi.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes in v6:
- Rename variables and update comments
- Make IOCTL independent of soft_dirty config
- Change masks and bitmap type to _u64
- Improve code quality

Changes in v5:
- Remove tlb flushing even for clear operation

Changes in v4:
- Update the interface and implementation

Changes in v3:
- Tighten the user-kernel interface by using explicit types and add more
  error checking

Changes in v2:
- Convert the interface from syscall to ioctl
- Remove pidfd support as it doesn't make sense in ioctl
---
 fs/proc/task_mmu.c            | 328 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/fs.h       |  56 ++++++
 tools/include/uapi/linux/fs.h |  56 ++++++
 3 files changed, 440 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 8235c536ac70..8d6a84ec5ef7 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -19,6 +19,9 @@
 #include <linux/shmem_fs.h>
 #include <linux/uaccess.h>
 #include <linux/pkeys.h>
+#include <uapi/linux/fs.h>
+#include <linux/vmalloc.h>
+#include <linux/minmax.h>
 
 #include <asm/elf.h>
 #include <asm/tlb.h>
@@ -1775,11 +1778,336 @@ static int pagemap_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+#define PAGEMAP_OP_MASK		(PAGE_IS_SOFTDIRTY | PAGE_IS_FILE |	\
+				 PAGE_IS_PRESENT | PAGE_IS_SWAPPED)
+#define PAGEMAP_NONSD_OP_MASK	(PAGE_IS_FILE |	PAGE_IS_PRESENT | PAGE_IS_SWAPPED)
+#define PAGEMAP_SD_FLAGS	(PAGEMAP_SOFTDIRTY_CLEAR | PAGEMAP_NO_REUSED_REGIONS)
+#define IS_CLEAR_OP(a)		(a->flags & PAGEMAP_SOFTDIRTY_CLEAR)
+#define IS_GET_OP(a)		(a->vec)
+#define IS_SD_OP(a)		(a->flags & PAGEMAP_SD_FLAGS)
+
+struct pagemap_scan_private {
+	struct page_region *vec;
+	unsigned long vec_len;
+	unsigned long vec_index;
+	unsigned int max_pages;
+	unsigned int found_pages;
+	unsigned int flags;
+	unsigned long required_mask;
+	unsigned long anyof_mask;
+	unsigned long excluded_mask;
+	unsigned long return_mask;
+};
+
+static int pagemap_scan_pmd_test_walk(unsigned long start, unsigned long end, struct mm_walk *walk)
+{
+	struct pagemap_scan_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+
+	if (IS_GET_OP(p) && p->max_pages && (p->found_pages == p->max_pages))
+		return -1;
+
+	if (vma->vm_flags & VM_PFNMAP)
+		return 1;
+
+	return 0;
+}
+
+static int add_to_out(bool sd, bool file, bool pres, bool swap, struct pagemap_scan_private *p,
+		      unsigned long addr, unsigned int len)
+{
+	unsigned long bitmap, cur = sd | file << 1 | pres << 2 | swap << 3;
+	bool cpy = true;
+
+	if (p->required_mask)
+		cpy = ((p->required_mask & cur) == p->required_mask);
+	if (cpy && p->anyof_mask)
+		cpy = (p->anyof_mask & cur);
+	if (cpy && p->excluded_mask)
+		cpy = !(p->excluded_mask & cur);
+
+	bitmap = cur & p->return_mask;
+
+	if (cpy && bitmap) {
+		if ((p->vec_index) && (p->vec[p->vec_index - 1].bitmap == bitmap) &&
+		    (p->vec[p->vec_index - 1].start + p->vec[p->vec_index - 1].len * PAGE_SIZE ==
+		     addr)) {
+			p->vec[p->vec_index - 1].len += len;
+			p->found_pages += len;
+		} else if (p->vec_index < p->vec_len) {
+			p->vec[p->vec_index].start = addr;
+			p->vec[p->vec_index].len = len;
+			p->found_pages += len;
+			p->vec[p->vec_index].bitmap = bitmap;
+			p->vec_index++;
+		} else {
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long addr,
+				  unsigned long end, struct mm_walk *walk)
+{
+	struct pagemap_scan_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	unsigned int len;
+	spinlock_t *ptl;
+	int ret = 0;
+	pte_t *pte;
+	bool dirty_vma = (p->flags & PAGEMAP_NO_REUSED_REGIONS) ?
+			 (false) : (vma->vm_flags & VM_SOFTDIRTY);
+
+	if ((walk->vma->vm_end < addr) || (p->max_pages && p->found_pages == p->max_pages))
+		return 0;
+
+	end = min(end, walk->vma->vm_end);
+
+	ptl = pmd_trans_huge_lock(pmd, vma);
+	if (ptl) {
+		if (dirty_vma || check_soft_dirty_pmd(vma, addr, pmd, false)) {
+			/*
+			 * Break huge page into small pages if operation needs to be performed is
+			 * on a portion of the huge page or the return buffer cannot store complete
+			 * data.
+			 */
+			if ((IS_CLEAR_OP(p) && (end - addr < HPAGE_SIZE))) {
+				spin_unlock(ptl);
+				split_huge_pmd(vma, pmd, addr);
+				goto process_smaller_pages;
+			}
+
+			if (IS_GET_OP(p)) {
+				len = (end - addr)/PAGE_SIZE;
+				if (p->max_pages && p->found_pages + len > p->max_pages)
+					len = p->max_pages - p->found_pages;
+
+				ret = add_to_out(dirty_vma ||
+						 check_soft_dirty_pmd(vma, addr, pmd, false),
+						 vma->vm_file, pmd_present(*pmd), is_swap_pmd(*pmd),
+						 p, addr, len);
+			}
+			if (!ret && IS_CLEAR_OP(p))
+				check_soft_dirty_pmd(vma, addr, pmd, true);
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
+	for (; addr < end && !ret && (!p->max_pages || (p->found_pages < p->max_pages))
+	     ; pte++, addr += PAGE_SIZE) {
+		if (IS_GET_OP(p))
+			ret = add_to_out(dirty_vma || check_soft_dirty(vma, addr, pte, false),
+					 vma->vm_file, pte_present(*pte),
+					 is_swap_pte(*pte), p, addr, 1);
+		if (!ret && IS_CLEAR_OP(p))
+			check_soft_dirty(vma, addr, pte, true);
+	}
+	pte_unmap_unlock(pte - 1, ptl);
+	cond_resched();
+
+	return 0;
+}
+
+static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end, int depth,
+				 struct mm_walk *walk)
+{
+	struct pagemap_scan_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	unsigned int len;
+	bool sd;
+
+	if (vma) {
+		/* Individual pages haven't been allocated and written */
+		sd = (p->flags & PAGEMAP_NO_REUSED_REGIONS) ? (false) :
+		     (vma->vm_flags & VM_SOFTDIRTY);
+
+		len = (end - addr)/PAGE_SIZE;
+		if (p->max_pages && p->found_pages + len > p->max_pages)
+			len = p->max_pages - p->found_pages;
+
+		add_to_out(sd, vma->vm_file, false, false, p, addr, len);
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_MEM_SOFT_DIRTY
+static int pagemap_scan_pre_vma(unsigned long start, unsigned long end, struct mm_walk *walk)
+{
+	struct pagemap_scan_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	unsigned long end_cut = end;
+	int ret;
+
+	if (!(p->flags & PAGEMAP_NO_REUSED_REGIONS) && IS_CLEAR_OP(p) &&
+	    (vma->vm_flags & VM_SOFTDIRTY)) {
+		if (vma->vm_start < start) {
+			ret = split_vma(vma->vm_mm, vma, start, 1);
+			if (ret)
+				return ret;
+		}
+		/* Calculate end_cut because of max_pages */
+		if (IS_GET_OP(p) && p->max_pages)
+			end_cut = min(start + (p->max_pages - p->found_pages) * PAGE_SIZE, end);
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
+static void pagemap_scan_post_vma(struct mm_walk *walk)
+{
+	struct pagemap_scan_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+
+	if (!(p->flags & PAGEMAP_NO_REUSED_REGIONS) && IS_CLEAR_OP(p) &&
+	    (vma->vm_flags & VM_SOFTDIRTY)) {
+		vma->vm_flags &= ~VM_SOFTDIRTY;
+		vma_set_page_prot(vma);
+	}
+}
+#endif /* CONFIG_MEM_SOFT_DIRTY */
+
+static const struct mm_walk_ops pagemap_scan_ops = {
+	.test_walk = pagemap_scan_pmd_test_walk,
+	.pmd_entry = pagemap_scan_pmd_entry,
+	.pte_hole = pagemap_scan_pte_hole,
+
+#ifdef CONFIG_MEM_SOFT_DIRTY
+	/* Only for clearing SD bit over VMAs */
+	.pre_vma = pagemap_scan_pre_vma,
+	.post_vma = pagemap_scan_post_vma,
+#endif /* CONFIG_MEM_SOFT_DIRTY */
+};
+
+static long do_pagemap_sd_cmd(struct mm_struct *mm, struct pagemap_scan_arg *arg)
+{
+	struct mmu_notifier_range range;
+	unsigned long __user start, end;
+	struct pagemap_scan_private p;
+	int ret;
+
+	start = (unsigned long)untagged_addr(arg->start);
+	if ((!IS_ALIGNED(start, PAGE_SIZE)) || (!access_ok((void __user *)start, arg->len)))
+		return -EINVAL;
+
+	if (IS_GET_OP(arg) &&
+	    ((arg->vec_len == 0) || (!access_ok((struct page_region *)arg->vec, arg->vec_len))))
+		return -ENOMEM;
+
+#ifndef CONFIG_MEM_SOFT_DIRTY
+	if (IS_SD_OP(arg) || (arg->required_mask & PAGE_IS_SOFTDIRTY) ||
+	    (arg->anyof_mask & PAGE_IS_SOFTDIRTY))
+		return -EINVAL;
+#endif
+
+	if ((arg->flags & ~PAGEMAP_SD_FLAGS) || (arg->required_mask & ~PAGEMAP_OP_MASK) ||
+	    (arg->anyof_mask & ~PAGEMAP_OP_MASK) || (arg->excluded_mask & ~PAGEMAP_OP_MASK) ||
+	    (arg->return_mask & ~PAGEMAP_OP_MASK))
+		return -EINVAL;
+
+	if ((!arg->required_mask && !arg->anyof_mask && !arg->excluded_mask) || !arg->return_mask)
+		return -EINVAL;
+
+	if (IS_SD_OP(arg) && ((arg->required_mask & PAGEMAP_NONSD_OP_MASK) ||
+	     (arg->anyof_mask & PAGEMAP_NONSD_OP_MASK)))
+		return -EINVAL;
+
+	end = start + arg->len;
+	p.max_pages = arg->max_pages;
+	p.found_pages = 0;
+	p.flags = arg->flags;
+	p.required_mask = arg->required_mask;
+	p.anyof_mask = arg->anyof_mask;
+	p.excluded_mask = arg->excluded_mask;
+	p.return_mask = arg->return_mask;
+	p.vec_index = 0;
+	p.vec_len = arg->vec_len;
+
+	if (IS_GET_OP(arg)) {
+		p.vec = vzalloc(arg->vec_len * sizeof(struct page_region));
+		if (!p.vec)
+			return -ENOMEM;
+	} else {
+		p.vec = NULL;
+	}
+
+	if (IS_CLEAR_OP(arg)) {
+		mmap_write_lock(mm);
+
+		mmu_notifier_range_init(&range, MMU_NOTIFY_SOFT_DIRTY, 0, NULL, mm, start, end);
+		mmu_notifier_invalidate_range_start(&range);
+		inc_tlb_flush_pending(mm);
+	} else {
+		mmap_read_lock(mm);
+	}
+
+	ret = walk_page_range(mm, start, end, &pagemap_scan_ops, &p);
+
+	if (IS_CLEAR_OP(arg)) {
+		mmu_notifier_invalidate_range_end(&range);
+		dec_tlb_flush_pending(mm);
+
+		mmap_write_unlock(mm);
+	} else {
+		mmap_read_unlock(mm);
+	}
+
+	if (ret < 0)
+		goto free_data;
+
+	if (IS_GET_OP(arg) && p.vec_index) {
+		if (copy_to_user((struct page_region *)arg->vec, p.vec,
+				 p.vec_index * sizeof(struct page_region))) {
+			ret = -EFAULT;
+			goto free_data;
+		}
+		ret = p.vec_index;
+	} else {
+		ret = 0;
+	}
+
+free_data:
+	if (IS_GET_OP(arg))
+		vfree(p.vec);
+
+	return ret;
+}
+
+static long pagemap_sd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct pagemap_scan_arg __user *uarg = (struct pagemap_scan_arg __user *)arg;
+	struct mm_struct *mm = file->private_data;
+	struct pagemap_scan_arg argument;
+
+	if (cmd == PAGEMAP_SCAN) {
+		if (copy_from_user(&argument, uarg, sizeof(struct pagemap_scan_arg)))
+			return -EFAULT;
+		return do_pagemap_sd_cmd(mm, &argument);
+	}
+	return -EINVAL;
+}
+
 const struct file_operations proc_pagemap_operations = {
 	.llseek		= mem_lseek, /* borrow this */
 	.read		= pagemap_read,
 	.open		= pagemap_open,
 	.release	= pagemap_release,
+	.unlocked_ioctl = pagemap_sd_ioctl,
+	.compat_ioctl	= pagemap_sd_ioctl,
 };
 #endif /* CONFIG_PROC_PAGE_MONITOR */
 
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index b7b56871029c..11d232cfc9b3 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -305,4 +305,60 @@ typedef int __bitwise __kernel_rwf_t;
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
 			 RWF_APPEND)
 
+/* Pagemap ioctl */
+#define PAGEMAP_SCAN	_IOWR('f', 16, struct pagemap_scan_arg)
+
+/* Bits are set in the bitmap of the page_region and masks in pagemap_sd_args */
+#define PAGE_IS_SOFTDIRTY	(1 << 0)
+#define PAGE_IS_FILE		(1 << 1)
+#define PAGE_IS_PRESENT		(1 << 2)
+#define PAGE_IS_SWAPPED		(1 << 3)
+
+/*
+ * struct page_region - Page region with bitmap flags
+ * @start:	Start of the region
+ * @len:	Length of the region
+ * bitmap:	Bits sets for the region
+ */
+struct page_region {
+	__u64 start;
+	__u64 len;
+	__u64 bitmap;
+};
+
+/*
+ * struct pagemap_scan_arg - Pagemap ioctl argument
+ * @start:		Starting address of the region
+ * @len:		Length of the region (All the pages in this length are included)
+ * @vec:		Address of page_region struct array for output
+ * @vec_len:		Length of the page_region struct array
+ * @max_pages:		Optional max return pages
+ * @flags:		Flags for the IOCTL
+ * @required_mask:	Required mask - All of these bits have to be set in the PTE
+ * @anyof_mask:		Any mask - Any of these bits are set in the PTE
+ * @excluded_mask:	Exclude mask - None of these bits are set in the PTE
+ * @return_mask:	Bits that are to be reported in page_region
+ */
+struct pagemap_scan_arg {
+	__u64 start;
+	__u64 len;
+	__u64 vec;
+	__u64 vec_len;
+	__u32 max_pages;
+	__u32 flags;
+	__u64 required_mask;
+	__u64 anyof_mask;
+	__u64 excluded_mask;
+	__u64 return_mask;
+};
+
+/* Special flags */
+#define PAGEMAP_SOFTDIRTY_CLEAR		(1 << 0)
+/*
+ * Depend only on the soft dirty PTE bit of individual pages and don't check the soft dirty bit
+ * of the VMA to decide if the region is dirty or not. By using this flag, the newly created
+ * memory doesn't appear to be soft dirty through the IOCTL until the region is written.
+ */
+#define PAGEMAP_NO_REUSED_REGIONS	(1 << 1)
+
 #endif /* _UAPI_LINUX_FS_H */
diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index b7b56871029c..11d232cfc9b3 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -305,4 +305,60 @@ typedef int __bitwise __kernel_rwf_t;
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
 			 RWF_APPEND)
 
+/* Pagemap ioctl */
+#define PAGEMAP_SCAN	_IOWR('f', 16, struct pagemap_scan_arg)
+
+/* Bits are set in the bitmap of the page_region and masks in pagemap_sd_args */
+#define PAGE_IS_SOFTDIRTY	(1 << 0)
+#define PAGE_IS_FILE		(1 << 1)
+#define PAGE_IS_PRESENT		(1 << 2)
+#define PAGE_IS_SWAPPED		(1 << 3)
+
+/*
+ * struct page_region - Page region with bitmap flags
+ * @start:	Start of the region
+ * @len:	Length of the region
+ * bitmap:	Bits sets for the region
+ */
+struct page_region {
+	__u64 start;
+	__u64 len;
+	__u64 bitmap;
+};
+
+/*
+ * struct pagemap_scan_arg - Pagemap ioctl argument
+ * @start:		Starting address of the region
+ * @len:		Length of the region (All the pages in this length are included)
+ * @vec:		Address of page_region struct array for output
+ * @vec_len:		Length of the page_region struct array
+ * @max_pages:		Optional max return pages
+ * @flags:		Flags for the IOCTL
+ * @required_mask:	Required mask - All of these bits have to be set in the PTE
+ * @anyof_mask:		Any mask - Any of these bits are set in the PTE
+ * @excluded_mask:	Exclude mask - None of these bits are set in the PTE
+ * @return_mask:	Bits that are to be reported in page_region
+ */
+struct pagemap_scan_arg {
+	__u64 start;
+	__u64 len;
+	__u64 vec;
+	__u64 vec_len;
+	__u32 max_pages;
+	__u32 flags;
+	__u64 required_mask;
+	__u64 anyof_mask;
+	__u64 excluded_mask;
+	__u64 return_mask;
+};
+
+/* Special flags */
+#define PAGEMAP_SOFTDIRTY_CLEAR		(1 << 0)
+/*
+ * Depend only on the soft dirty PTE bit of individual pages and don't check the soft dirty bit
+ * of the VMA to decide if the region is dirty or not. By using this flag, the newly created
+ * memory doesn't appear to be soft dirty through the IOCTL until the region is written.
+ */
+#define PAGEMAP_NO_REUSED_REGIONS	(1 << 1)
+
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.30.2

