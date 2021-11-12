Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6CC44ED43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 20:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbhKLTbM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 14:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbhKLTbL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 14:31:11 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6E9C0613F5
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Nov 2021 11:28:20 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bu18so24933292lfb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Nov 2021 11:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I3Jdyl4A835mRDu9LUSfQLFNXVClr48PpVSr6STmYrA=;
        b=eylhe87rQBFCmqeyt0zrJzoAi5Wcq4n3o0yZWwV/5GRf5REIWbmkWhSGyMPjqHOVcQ
         zAyDiRbBQ4Jd14YkJXhM1+g91KFPPLXlCpLtg6nugKchpf6rgZpNug8N9CPlaT6pGVUN
         qX0V2BfRAPbrTZEnV0oGXKAUwsTlZS2ObctfgFU6LCMvAVQtefnmhzn0FzDj2OxOZGlU
         YKkfVtJgyOwscxqXq4+y4M2Uz0/9xvs65RzfU3gWFR4lrzQMWPFuf28eKQkK4etGvvSH
         HgQfsqK5fVYxiWR97k2yD9c5dfg/I2OwOuEVuEfEBtifkuwaOCURZ6hhSV7cgFMNF5T+
         NVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I3Jdyl4A835mRDu9LUSfQLFNXVClr48PpVSr6STmYrA=;
        b=V2BYqJ9r2ksRvAuQP4bnKb0EJOnwqJoHZgPtPnPA1IYXLj1qo/+OI6UgkP5vLoa1IN
         2Md64CTadAFO2P4lhaicxRyZV71qEhVE2/8706kqEfitcfB7My3wWRTRCS2hpoP70Caf
         On00YCjHCvNHD4FpxBYdHvxJd7Ov13pLbccyvDBmE2VyVgO1nmokhulWKJmOaE0k4Ed0
         vdZe3Xq4+ikbhu9SAhJfutqNj09zqOZOAB/moFACg+nfV95+EBDEV9XlokYcSvXmf4AH
         HRvjYi/WhslyJ9i0psPpuaMKLw/lzZ3trvudr7uBozz9LIv49NdGbEldRMVK1Y6qppdo
         kj1A==
X-Gm-Message-State: AOAM530O8PrMRF1YE1gVccu5ql4lJN2McF2TQPuFero4C7L2PxOthXbj
        BQl2Nx3TkMImqUkLxDLUy620z90ZpUT1wA==
X-Google-Smtp-Source: ABdhPJwHDhdQu8nxYifvWVA1Ipkf/IYlwAyXfsb7DgYQ5qbB9BC6t8i3+ipPUJDJ+C9Hu7Qo3FCK0Q==
X-Received: by 2002:ac2:4c4d:: with SMTP id o13mr2675889lfk.196.1636745298130;
        Fri, 12 Nov 2021 11:28:18 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e10sm645855lfr.213.2021.11.12.11.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 11:28:17 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id AE1FE1034DC; Fri, 12 Nov 2021 22:28:20 +0300 (+03)
Date:   Fri, 12 Nov 2021 22:28:20 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: Re: [RFC PATCH 1/6] mm: Add F_SEAL_GUEST to shmem/memfd
Message-ID: <20211112192820.dbxxnqhgnqaz6dgn@box.shutemov.name>
References: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
 <20211111141352.26311-2-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111141352.26311-2-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 11, 2021 at 10:13:40PM +0800, Chao Peng wrote:
> The new seal is only allowed if there's no pre-existing pages in the fd
> and there's no existing mapping of the file. After the seal is set, no
> read/write/mmap from userspace is allowed.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>

Below is replacement patch with fallocate callback support.

I also replaced page_level if order of the page because PG_LEVEL_2M/4K is
x86-specific can cannot be used in the generic code.

There's also bugix in guest_invalidate_page().


From 9419ccb4bc3c1df4cc88f6c8ba212f4b16955559 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Fri, 12 Nov 2021 21:27:40 +0300
Subject: [PATCH] mm/shmem: Introduce F_SEAL_GUEST

The new seal type provides semantics required for KVM guest private
memory support. A file descriptor with the seal set is going to be used
as source of guest memory in confidential computing environments such as
Intel TDX and AMD SEV.

F_SEAL_GUEST can only be set on empty memfd. After the seal is set
userspace cannot read, write or mmap the memfd.

Userspace is in charge of guest memory lifecycle: it can allocate the
memory with falloc or punch hole to free memory from the guest.

The file descriptor passed down to KVM as guest memory backend. KVM
register itself as the owner of the memfd via memfd_register_guest().

KVM provides callback that needed to be called on fallocate and punch
hole.

memfd_register_guest() returns callbacks that need be used for
requesting a new page from memfd.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/memfd.h      |  24 ++++++++
 include/linux/shmem_fs.h   |   9 +++
 include/uapi/linux/fcntl.h |   1 +
 mm/memfd.c                 |  32 +++++++++-
 mm/shmem.c                 | 117 ++++++++++++++++++++++++++++++++++++-
 5 files changed, 179 insertions(+), 4 deletions(-)

diff --git a/include/linux/memfd.h b/include/linux/memfd.h
index 4f1600413f91..500dfe88043e 100644
--- a/include/linux/memfd.h
+++ b/include/linux/memfd.h
@@ -4,13 +4,37 @@
 
 #include <linux/file.h>
 
+struct guest_ops {
+	void (*invalidate_page_range)(struct inode *inode, void *owner,
+				      pgoff_t start, pgoff_t end);
+	void (*fallocate)(struct inode *inode, void *owner,
+			  pgoff_t start, pgoff_t end);
+};
+
+struct guest_mem_ops {
+	unsigned long (*get_lock_pfn)(struct inode *inode, pgoff_t offset,
+				      int *order);
+	void (*put_unlock_pfn)(unsigned long pfn);
+
+};
+
 #ifdef CONFIG_MEMFD_CREATE
 extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg);
+
+extern inline int memfd_register_guest(struct inode *inode, void *owner,
+				       const struct guest_ops *guest_ops,
+				       const struct guest_mem_ops **guest_mem_ops);
 #else
 static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned long a)
 {
 	return -EINVAL;
 }
+static inline int memfd_register_guest(struct inode *inode, void *owner,
+				       const struct guest_ops *guest_ops,
+				       const struct guest_mem_ops **guest_mem_ops)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif /* __LINUX_MEMFD_H */
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 8e775ce517bb..265d0c13bc5e 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -12,6 +12,9 @@
 
 /* inode in-kernel data */
 
+struct guest_ops;
+struct guest_mem_ops;
+
 struct shmem_inode_info {
 	spinlock_t		lock;
 	unsigned int		seals;		/* shmem seals */
@@ -24,6 +27,8 @@ struct shmem_inode_info {
 	struct simple_xattrs	xattrs;		/* list of xattrs */
 	atomic_t		stop_eviction;	/* hold when working on inode */
 	struct inode		vfs_inode;
+	void			*guest_owner;
+	const struct guest_ops	*guest_ops;
 };
 
 struct shmem_sb_info {
@@ -90,6 +95,10 @@ extern unsigned long shmem_swap_usage(struct vm_area_struct *vma);
 extern unsigned long shmem_partial_swap_usage(struct address_space *mapping,
 						pgoff_t start, pgoff_t end);
 
+extern int shmem_register_guest(struct inode *inode, void *owner,
+				const struct guest_ops *guest_ops,
+				const struct guest_mem_ops **guest_mem_ops);
+
 /* Flag allocation requirements to shmem_getpage */
 enum sgp_type {
 	SGP_READ,	/* don't exceed i_size, don't allocate page */
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 2f86b2ad6d7e..c79bc8572721 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -43,6 +43,7 @@
 #define F_SEAL_GROW	0x0004	/* prevent file from growing */
 #define F_SEAL_WRITE	0x0008	/* prevent writes */
 #define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
+#define F_SEAL_GUEST		0x0020
 /* (1U << 31) is reserved for signed error codes */
 
 /*
diff --git a/mm/memfd.c b/mm/memfd.c
index 081dd33e6a61..ae43454789f4 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -130,11 +130,24 @@ static unsigned int *memfd_file_seals_ptr(struct file *file)
 	return NULL;
 }
 
+int memfd_register_guest(struct inode *inode, void *owner,
+			 const struct guest_ops *guest_ops,
+			 const struct guest_mem_ops **guest_mem_ops)
+{
+	if (shmem_mapping(inode->i_mapping)) {
+		return shmem_register_guest(inode, owner,
+					    guest_ops, guest_mem_ops);
+	}
+
+	return -EINVAL;
+}
+
 #define F_ALL_SEALS (F_SEAL_SEAL | \
 		     F_SEAL_SHRINK | \
 		     F_SEAL_GROW | \
 		     F_SEAL_WRITE | \
-		     F_SEAL_FUTURE_WRITE)
+		     F_SEAL_FUTURE_WRITE | \
+		     F_SEAL_GUEST)
 
 static int memfd_add_seals(struct file *file, unsigned int seals)
 {
@@ -203,10 +216,27 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 		}
 	}
 
+	if (seals & F_SEAL_GUEST) {
+		i_mmap_lock_read(inode->i_mapping);
+
+		if (!RB_EMPTY_ROOT(&inode->i_mapping->i_mmap.rb_root)) {
+			error = -EBUSY;
+			goto unlock;
+		}
+
+		if (i_size_read(inode)) {
+			error = -EBUSY;
+			goto unlock;
+		}
+	}
+
 	*file_seals |= seals;
 	error = 0;
 
 unlock:
+	if (seals & F_SEAL_GUEST)
+		i_mmap_unlock_read(inode->i_mapping);
+
 	inode_unlock(inode);
 	return error;
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index dacda7463d54..5d8ea4f02a94 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -80,6 +80,7 @@ static struct vfsmount *shm_mnt;
 #include <linux/userfaultfd_k.h>
 #include <linux/rmap.h>
 #include <linux/uuid.h>
+#include <linux/memfd.h>
 
 #include <linux/uaccess.h>
 
@@ -883,6 +884,18 @@ static bool shmem_punch_compound(struct page *page, pgoff_t start, pgoff_t end)
 	return split_huge_page(page) >= 0;
 }
 
+static void guest_invalidate_page(struct inode *inode,
+				  struct page *page, pgoff_t start, pgoff_t end)
+{
+	struct shmem_inode_info *info = SHMEM_I(inode);
+
+	start = max(start, page->index);
+	end = min(end, page->index + thp_nr_pages(page)) - 1;
+
+	info->guest_ops->invalidate_page_range(inode, info->guest_owner,
+					       start, end);
+}
+
 /*
  * Remove range of pages and swap entries from page cache, and free them.
  * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocate.
@@ -923,6 +936,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			}
 			index += thp_nr_pages(page) - 1;
 
+			guest_invalidate_page(inode, page, start, end);
+
 			if (!unfalloc || !PageUptodate(page))
 				truncate_inode_page(mapping, page);
 			unlock_page(page);
@@ -999,6 +1014,9 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 					index--;
 					break;
 				}
+
+				guest_invalidate_page(inode, page, start, end);
+
 				VM_BUG_ON_PAGE(PageWriteback(page), page);
 				if (shmem_punch_compound(page, start, end))
 					truncate_inode_page(mapping, page);
@@ -1074,6 +1092,9 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
 		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
 			return -EPERM;
 
+		if ((info->seals & F_SEAL_GUEST) && (newsize & ~PAGE_MASK))
+			return -EINVAL;
+
 		if (newsize != oldsize) {
 			error = shmem_reacct_size(SHMEM_I(inode)->flags,
 					oldsize, newsize);
@@ -1348,6 +1369,8 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 		goto redirty;
 	if (!total_swap_pages)
 		goto redirty;
+	if (info->seals & F_SEAL_GUEST)
+		goto redirty;
 
 	/*
 	 * Our capabilities prevent regular writeback or sync from ever calling
@@ -2274,6 +2297,9 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	if (ret)
 		return ret;
 
+	if (info->seals & F_SEAL_GUEST)
+		return -EPERM;
+
 	/* arm64 - allow memory tagging on RAM-based files */
 	vma->vm_flags |= VM_MTE_ALLOWED;
 
@@ -2471,12 +2497,14 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 	pgoff_t index = pos >> PAGE_SHIFT;
 
 	/* i_mutex is held by caller */
-	if (unlikely(info->seals & (F_SEAL_GROW |
-				   F_SEAL_WRITE | F_SEAL_FUTURE_WRITE))) {
+	if (unlikely(info->seals & (F_SEAL_GROW | F_SEAL_WRITE |
+				    F_SEAL_FUTURE_WRITE | F_SEAL_GUEST))) {
 		if (info->seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE))
 			return -EPERM;
 		if ((info->seals & F_SEAL_GROW) && pos + len > inode->i_size)
 			return -EPERM;
+		if (info->seals & F_SEAL_GUEST)
+			return -EPERM;
 	}
 
 	return shmem_getpage(inode, index, pagep, SGP_WRITE);
@@ -2550,6 +2578,20 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		end_index = i_size >> PAGE_SHIFT;
 		if (index > end_index)
 			break;
+
+		/*
+		 * inode_lock protects setting up seals as well as write to
+		 * i_size. Setting F_SEAL_GUEST only allowed with i_size == 0.
+		 *
+		 * Check F_SEAL_GUEST after i_size. It effectively serialize
+		 * read vs. setting F_SEAL_GUEST without taking inode_lock in
+		 * read path.
+		 */
+		if (SHMEM_I(inode)->seals & F_SEAL_GUEST) {
+			error = -EPERM;
+			break;
+		}
+
 		if (index == end_index) {
 			nr = i_size & ~PAGE_MASK;
 			if (nr <= offset)
@@ -2675,6 +2717,12 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 			goto out;
 		}
 
+		if ((info->seals & F_SEAL_GUEST) &&
+		    (offset & ~PAGE_MASK || len & ~PAGE_MASK)) {
+			error = -EINVAL;
+			goto out;
+		}
+
 		shmem_falloc.waitq = &shmem_falloc_waitq;
 		shmem_falloc.start = (u64)unmap_start >> PAGE_SHIFT;
 		shmem_falloc.next = (unmap_end + 1) >> PAGE_SHIFT;
@@ -2771,6 +2819,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 	if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode->i_size)
 		i_size_write(inode, offset + len);
 	inode->i_ctime = current_time(inode);
+	info->guest_ops->fallocate(inode, info->guest_owner, start, end);
 undone:
 	spin_lock(&inode->i_lock);
 	inode->i_private = NULL;
@@ -3761,6 +3810,20 @@ static void shmem_destroy_inodecache(void)
 	kmem_cache_destroy(shmem_inode_cachep);
 }
 
+#ifdef CONFIG_MIGRATION
+int shmem_migrate_page(struct address_space *mapping,
+		struct page *newpage, struct page *page,
+		enum migrate_mode mode)
+{
+	struct inode *inode = mapping->host;
+	struct shmem_inode_info *info = SHMEM_I(inode);
+
+	if (info->seals & F_SEAL_GUEST)
+		return -ENOTSUPP;
+	return migrate_page(mapping, newpage, page, mode);
+}
+#endif
+
 const struct address_space_operations shmem_aops = {
 	.writepage	= shmem_writepage,
 	.set_page_dirty	= __set_page_dirty_no_writeback,
@@ -3769,12 +3832,60 @@ const struct address_space_operations shmem_aops = {
 	.write_end	= shmem_write_end,
 #endif
 #ifdef CONFIG_MIGRATION
-	.migratepage	= migrate_page,
+	.migratepage	= shmem_migrate_page,
 #endif
 	.error_remove_page = generic_error_remove_page,
 };
 EXPORT_SYMBOL(shmem_aops);
 
+static unsigned long shmem_get_lock_pfn(struct inode *inode, pgoff_t offset,
+					int *order)
+{
+	struct page *page;
+	int ret;
+
+	ret = shmem_getpage(inode, offset, &page, SGP_WRITE);
+	if (ret)
+		return ret;
+
+	*order = thp_order(thp_head(page));
+
+	return page_to_pfn(page);
+}
+
+static void shmem_put_unlock_pfn(unsigned long pfn)
+{
+	struct page *page = pfn_to_page(pfn);
+
+	VM_BUG_ON_PAGE(!PageLocked(page), page);
+
+	set_page_dirty(page);
+	unlock_page(page);
+	put_page(page);
+}
+
+static const struct guest_mem_ops shmem_guest_ops = {
+	.get_lock_pfn = shmem_get_lock_pfn,
+	.put_unlock_pfn = shmem_put_unlock_pfn,
+};
+
+int shmem_register_guest(struct inode *inode, void *owner,
+			 const struct guest_ops *guest_ops,
+			 const struct guest_mem_ops **guest_mem_ops)
+{
+	struct shmem_inode_info *info = SHMEM_I(inode);
+
+	if (!owner)
+		return -EINVAL;
+
+	if (info->guest_owner && info->guest_owner != owner)
+		return -EPERM;
+
+	info->guest_ops = guest_ops;
+	*guest_mem_ops = &shmem_guest_ops;
+	return 0;
+}
+
 static const struct file_operations shmem_file_operations = {
 	.mmap		= shmem_mmap,
 	.get_unmapped_area = shmem_get_unmapped_area,
-- 
 Kirill A. Shutemov
