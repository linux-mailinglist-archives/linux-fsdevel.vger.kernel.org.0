Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8096F52D822
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 17:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241525AbiESPmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 11:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241245AbiESPlQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 11:41:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30EA12A82;
        Thu, 19 May 2022 08:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652974873; x=1684510873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bRcbOpClngbVMiu+0GkVBqXH3D1nHdRIvvjiJPwzM5U=;
  b=Ovcyk7lajrWzlKyvlb6Go8n+kyVcJp38MJ7dRkB1Ihlb1mCvnqAGqhf5
   cqW/xG9qoB+0eAZkUnwTfy3FWOiztz72CNq2nhmrHZ+aCd0jnWBQxR6Rc
   nK2NXuDqCGX5wvD3dX9zrV7Yap8L+c4Afu6MsiwmJBS5WRlGnXCUayr3t
   BkCMBim4agTxUxzkVAcvLoxREV7BGZ5kQxVrhx1s4vK4N33G57Kr2zRDr
   tKEc7X7ADSnXNiSxXXOzCBVIao/CeoHdnVrE7EpfL/fvOpqdV9tlkIs1b
   bmL3Z3qQGG9VKJ8xw9Zvy8EVf665wgV5kjsEvM+LBEkQJsJn/E6t4HZoP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="259828045"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="259828045"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 08:41:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="598635123"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 19 May 2022 08:41:02 -0700
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
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
        Mike Rapoport <rppt@kernel.org>,
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
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Subject: [PATCH v6 2/8] mm/shmem: Support memfile_notifier
Date:   Thu, 19 May 2022 23:37:07 +0800
Message-Id: <20220519153713.819591-3-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Implement shmem as a memfile_notifier backing store. Essentially it
interacts with the memfile_notifier feature flags for userspace
access/page migration/page reclaiming and implements the necessary
memfile_backing_store callbacks.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/linux/shmem_fs.h |   2 +
 mm/shmem.c               | 120 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index ab51d3cd39bd..a8e98bdd121e 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -9,6 +9,7 @@
 #include <linux/percpu_counter.h>
 #include <linux/xattr.h>
 #include <linux/fs_parser.h>
+#include <linux/memfile_notifier.h>
 
 /* inode in-kernel data */
 
@@ -25,6 +26,7 @@ struct shmem_inode_info {
 	struct simple_xattrs	xattrs;		/* list of xattrs */
 	atomic_t		stop_eviction;	/* hold when working on inode */
 	struct timespec64	i_crtime;	/* file creation time */
+	struct memfile_node	memfile_node;	/* memfile node */
 	struct inode		vfs_inode;
 };
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 529c9ad3e926..f97ae328c87a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -905,6 +905,24 @@ static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
 	return page ? page_folio(page) : NULL;
 }
 
+static void notify_populate(struct inode *inode, pgoff_t start, pgoff_t end)
+{
+	struct shmem_inode_info *info = SHMEM_I(inode);
+
+	memfile_notifier_populate(&info->memfile_node, start, end);
+}
+
+static void notify_invalidate(struct inode *inode, struct folio *folio,
+				   pgoff_t start, pgoff_t end)
+{
+	struct shmem_inode_info *info = SHMEM_I(inode);
+
+	start = max(start, folio->index);
+	end = min(end, folio->index + folio_nr_pages(folio));
+
+	memfile_notifier_invalidate(&info->memfile_node, start, end);
+}
+
 /*
  * Remove range of pages and swap entries from page cache, and free them.
  * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocate.
@@ -948,6 +966,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			}
 			index += folio_nr_pages(folio) - 1;
 
+			notify_invalidate(inode, folio, start, end);
+
 			if (!unfalloc || !folio_test_uptodate(folio))
 				truncate_inode_folio(mapping, folio);
 			folio_unlock(folio);
@@ -1021,6 +1041,9 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 					index--;
 					break;
 				}
+
+				notify_invalidate(inode, folio, start, end);
+
 				VM_BUG_ON_FOLIO(folio_test_writeback(folio),
 						folio);
 				truncate_inode_folio(mapping, folio);
@@ -1092,6 +1115,13 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
 		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
 			return -EPERM;
 
+		if (info->memfile_node.flags & MEMFILE_F_USER_INACCESSIBLE) {
+			if(oldsize)
+				return -EPERM;
+			if (!PAGE_ALIGNED(newsize))
+				return -EINVAL;
+		}
+
 		if (newsize != oldsize) {
 			error = shmem_reacct_size(SHMEM_I(inode)->flags,
 					oldsize, newsize);
@@ -1340,6 +1370,8 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 		goto redirty;
 	if (!total_swap_pages)
 		goto redirty;
+	if (info->memfile_node.flags & MEMFILE_F_UNRECLAIMABLE)
+		goto redirty;
 
 	/*
 	 * Our capabilities prevent regular writeback or sync from ever calling
@@ -2234,6 +2266,9 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	if (ret)
 		return ret;
 
+	if (info->memfile_node.flags & MEMFILE_F_USER_INACCESSIBLE)
+		return -EPERM;
+
 	/* arm64 - allow memory tagging on RAM-based files */
 	vma->vm_flags |= VM_MTE_ALLOWED;
 
@@ -2274,6 +2309,7 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 		info->i_crtime = inode->i_mtime;
 		INIT_LIST_HEAD(&info->shrinklist);
 		INIT_LIST_HEAD(&info->swaplist);
+		memfile_node_init(&info->memfile_node);
 		simple_xattrs_init(&info->xattrs);
 		cache_no_acl(inode);
 		mapping_set_large_folios(inode->i_mapping);
@@ -2442,6 +2478,8 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 		if ((info->seals & F_SEAL_GROW) && pos + len > inode->i_size)
 			return -EPERM;
 	}
+	if (unlikely(info->memfile_node.flags & MEMFILE_F_USER_INACCESSIBLE))
+		return -EPERM;
 
 	ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
 
@@ -2518,6 +2556,13 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		end_index = i_size >> PAGE_SHIFT;
 		if (index > end_index)
 			break;
+
+		if (SHMEM_I(inode)->memfile_node.flags &
+				MEMFILE_F_USER_INACCESSIBLE) {
+			error = -EPERM;
+			break;
+		}
+
 		if (index == end_index) {
 			nr = i_size & ~PAGE_MASK;
 			if (nr <= offset)
@@ -2649,6 +2694,12 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 			goto out;
 		}
 
+		if ((info->memfile_node.flags & MEMFILE_F_USER_INACCESSIBLE) &&
+		    (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))) {
+			error = -EINVAL;
+			goto out;
+		}
+
 		shmem_falloc.waitq = &shmem_falloc_waitq;
 		shmem_falloc.start = (u64)unmap_start >> PAGE_SHIFT;
 		shmem_falloc.next = (unmap_end + 1) >> PAGE_SHIFT;
@@ -2768,6 +2819,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 	if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode->i_size)
 		i_size_write(inode, offset + len);
 	inode->i_ctime = current_time(inode);
+	notify_populate(inode, start, end);
 undone:
 	spin_lock(&inode->i_lock);
 	inode->i_private = NULL;
@@ -3754,6 +3806,20 @@ static int shmem_error_remove_page(struct address_space *mapping,
 	return 0;
 }
 
+#ifdef CONFIG_MIGRATION
+static int shmem_migrate_page(struct address_space *mapping,
+			      struct page *newpage, struct page *page,
+			      enum migrate_mode mode)
+{
+	struct inode *inode = mapping->host;
+	struct shmem_inode_info *info = SHMEM_I(inode);
+
+	if (info->memfile_node.flags & MEMFILE_F_UNMOVABLE)
+		return -ENOTSUPP;
+	return migrate_page(mapping, newpage, page, mode);
+}
+#endif
+
 const struct address_space_operations shmem_aops = {
 	.writepage	= shmem_writepage,
 	.dirty_folio	= noop_dirty_folio,
@@ -3762,7 +3828,7 @@ const struct address_space_operations shmem_aops = {
 	.write_end	= shmem_write_end,
 #endif
 #ifdef CONFIG_MIGRATION
-	.migratepage	= migrate_page,
+	.migratepage	= shmem_migrate_page,
 #endif
 	.error_remove_page = shmem_error_remove_page,
 };
@@ -3879,6 +3945,54 @@ static struct file_system_type shmem_fs_type = {
 	.fs_flags	= FS_USERNS_MOUNT,
 };
 
+#ifdef CONFIG_MEMFILE_NOTIFIER
+static struct memfile_node* shmem_lookup_memfile_node(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+
+	if (!shmem_mapping(inode->i_mapping))
+		return NULL;
+
+	return  &SHMEM_I(inode)->memfile_node;
+}
+
+
+static int shmem_get_lock_pfn(struct file *file, pgoff_t offset, pfn_t *pfn,
+			      int *order)
+{
+	struct page *page;
+	int ret;
+
+	ret = shmem_getpage(file_inode(file), offset, &page, SGP_NOALLOC);
+	if (ret)
+		return ret;
+
+	*pfn = page_to_pfn_t(page);
+	*order = thp_order(compound_head(page));
+	return 0;
+}
+
+static void shmem_put_unlock_pfn(pfn_t pfn)
+{
+	struct page *page = pfn_t_to_page(pfn);
+
+	if (!page)
+		return;
+
+	VM_BUG_ON_PAGE(!PageLocked(page), page);
+
+	set_page_dirty(page);
+	unlock_page(page);
+	put_page(page);
+}
+
+static struct memfile_backing_store shmem_backing_store = {
+	.lookup_memfile_node = shmem_lookup_memfile_node,
+	.get_lock_pfn = shmem_get_lock_pfn,
+	.put_unlock_pfn = shmem_put_unlock_pfn,
+};
+#endif /* CONFIG_MEMFILE_NOTIFIER */
+
 int __init shmem_init(void)
 {
 	int error;
@@ -3904,6 +4018,10 @@ int __init shmem_init(void)
 	else
 		shmem_huge = SHMEM_HUGE_NEVER; /* just in case it was patched */
 #endif
+
+#ifdef CONFIG_MEMFILE_NOTIFIER
+	memfile_register_backing_store(&shmem_backing_store);
+#endif
 	return 0;
 
 out1:
-- 
2.25.1

