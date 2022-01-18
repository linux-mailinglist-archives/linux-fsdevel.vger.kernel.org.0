Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E792D492723
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243315AbiARNXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:23:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:61766 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243250AbiARNWw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:22:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642512172; x=1674048172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=HZ8RoYPmQ6m9k6Lgoc+xE+GTQI3+IhGwWjUNoTgoWzo=;
  b=NmBFGKmpotwKOwBv+D6JKs5/omJF7hoy3fMSgu7H/EtBN0H7ndm2ehsp
   ozGAojo9sTYfJQHDxVE/rMDtpDciPEKaM8+MjChFLGEKrZqLDDO1kN4GV
   gEUzV7uJ/6wqDMsDlZhHHctraj2RWwC7b0e/JlbD0ihpOlmivJAXrz1Nm
   jvnPuv77pf7oFlD7UDQqj2VEr61qPKvj3I4/+98xmJrOLfSg9clLcPiVk
   EZspeLZ3jLTz50LqEEvJySdi1M/dTDWK6td+vs9/yN5IVTNLNRRWquy2p
   k0yLbJUHfvQpUy6qPC1U7JvTiQuIgcPfBP94wnd7dsLFMBcdc+rPNs6To
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="308149127"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="308149127"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 05:22:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="531791758"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 18 Jan 2022 05:22:20 -0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
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
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: [PATCH v4 04/12] mm/shmem: Support memfile_notifier
Date:   Tue, 18 Jan 2022 21:21:13 +0800
Message-Id: <20220118132121.31388-5-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It maintains a memfile_notifier list in shmem_inode_info structure and
implements memfile_pfn_ops callbacks defined by memfile_notifier. It
then exposes them to memfile_notifier via
shmem_get_memfile_notifier_info.

We use SGP_NOALLOC in shmem_get_lock_pfn since the pages should be
allocated by userspace for private memory. If there is no pages
allocated at the offset then error should be returned so KVM knows that
the memory is not private memory.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/linux/shmem_fs.h |  4 ++
 mm/memfile_notifier.c    | 12 +++++-
 mm/shmem.c               | 81 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 166158b6e917..461633587eaf 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -9,6 +9,7 @@
 #include <linux/percpu_counter.h>
 #include <linux/xattr.h>
 #include <linux/fs_parser.h>
+#include <linux/memfile_notifier.h>
 
 /* inode in-kernel data */
 
@@ -24,6 +25,9 @@ struct shmem_inode_info {
 	struct shared_policy	policy;		/* NUMA memory alloc policy */
 	struct simple_xattrs	xattrs;		/* list of xattrs */
 	atomic_t		stop_eviction;	/* hold when working on inode */
+#ifdef CONFIG_MEMFILE_NOTIFIER
+	struct memfile_notifier_list memfile_notifiers;
+#endif
 	struct inode		vfs_inode;
 };
 
diff --git a/mm/memfile_notifier.c b/mm/memfile_notifier.c
index 8171d4601a04..b4699cbf629e 100644
--- a/mm/memfile_notifier.c
+++ b/mm/memfile_notifier.c
@@ -41,11 +41,21 @@ void memfile_notifier_fallocate(struct memfile_notifier_list *list,
 	srcu_read_unlock(&srcu, id);
 }
 
+#ifdef CONFIG_SHMEM
+extern int shmem_get_memfile_notifier_info(struct inode *inode,
+					struct memfile_notifier_list **list,
+					struct memfile_pfn_ops **ops);
+#endif
+
 static int memfile_get_notifier_info(struct inode *inode,
 				     struct memfile_notifier_list **list,
 				     struct memfile_pfn_ops **ops)
 {
-	return -EOPNOTSUPP;
+	int ret = -EOPNOTSUPP;
+#ifdef CONFIG_SHMEM
+	ret = shmem_get_memfile_notifier_info(inode, list, ops);
+#endif
+	return ret;
 }
 
 int memfile_register_notifier(struct inode *inode,
diff --git a/mm/shmem.c b/mm/shmem.c
index 72185630e7c4..00af869d26ce 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -906,6 +906,28 @@ static bool shmem_punch_compound(struct page *page, pgoff_t start, pgoff_t end)
 	return split_huge_page(page) >= 0;
 }
 
+static void notify_fallocate(struct inode *inode, pgoff_t start, pgoff_t end)
+{
+#ifdef CONFIG_MEMFILE_NOTIFIER
+	struct shmem_inode_info *info = SHMEM_I(inode);
+
+	memfile_notifier_fallocate(&info->memfile_notifiers, start, end);
+#endif
+}
+
+static void notify_invalidate_page(struct inode *inode, struct page *page,
+				   pgoff_t start, pgoff_t end)
+{
+#ifdef CONFIG_MEMFILE_NOTIFIER
+	struct shmem_inode_info *info = SHMEM_I(inode);
+
+	start = max(start, page->index);
+	end = min(end, page->index + thp_nr_pages(page));
+
+	memfile_notifier_invalidate(&info->memfile_notifiers, start, end);
+#endif
+}
+
 /*
  * Remove range of pages and swap entries from page cache, and free them.
  * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocate.
@@ -949,6 +971,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			}
 			index += thp_nr_pages(page) - 1;
 
+			notify_invalidate_page(inode, page, start, end);
+
 			if (!unfalloc || !PageUptodate(page))
 				truncate_inode_page(mapping, page);
 			unlock_page(page);
@@ -1025,6 +1049,9 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 					index--;
 					break;
 				}
+
+				notify_invalidate_page(inode, page, start, end);
+
 				VM_BUG_ON_PAGE(PageWriteback(page), page);
 				if (shmem_punch_compound(page, start, end))
 					truncate_inode_page(mapping, page);
@@ -2313,6 +2340,9 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 		info->flags = flags & VM_NORESERVE;
 		INIT_LIST_HEAD(&info->shrinklist);
 		INIT_LIST_HEAD(&info->swaplist);
+#ifdef CONFIG_MEMFILE_NOTIFIER
+		memfile_notifier_list_init(&info->memfile_notifiers);
+#endif
 		simple_xattrs_init(&info->xattrs);
 		cache_no_acl(inode);
 		mapping_set_large_folios(inode->i_mapping);
@@ -2818,6 +2848,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 	if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode->i_size)
 		i_size_write(inode, offset + len);
 	inode->i_ctime = current_time(inode);
+	notify_fallocate(inode, start, end);
 undone:
 	spin_lock(&inode->i_lock);
 	inode->i_private = NULL;
@@ -4002,6 +4033,56 @@ struct kobj_attribute shmem_enabled_attr =
 	__ATTR(shmem_enabled, 0644, shmem_enabled_show, shmem_enabled_store);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE && CONFIG_SYSFS */
 
+#ifdef CONFIG_MEMFILE_NOTIFIER
+static long shmem_get_lock_pfn(struct inode *inode, pgoff_t offset, int *order)
+{
+	struct page *page;
+	int ret;
+
+	ret = shmem_getpage(inode, offset, &page, SGP_NOALLOC);
+	if (ret)
+		return ret;
+
+	*order = thp_order(compound_head(page));
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
+static struct memfile_pfn_ops shmem_pfn_ops = {
+	.get_lock_pfn = shmem_get_lock_pfn,
+	.put_unlock_pfn = shmem_put_unlock_pfn,
+};
+
+int shmem_get_memfile_notifier_info(struct inode *inode,
+				    struct memfile_notifier_list **list,
+				    struct memfile_pfn_ops **ops)
+{
+	struct shmem_inode_info *info;
+
+	if (!shmem_mapping(inode->i_mapping))
+		return -EINVAL;
+
+	info = SHMEM_I(inode);
+	*list = &info->memfile_notifiers;
+	if (ops)
+		*ops = &shmem_pfn_ops;
+
+	return 0;
+}
+
+#endif /* CONFIG_MEMFILE_NOTIFIER */
+
 #else /* !CONFIG_SHMEM */
 
 /*
-- 
2.17.1

