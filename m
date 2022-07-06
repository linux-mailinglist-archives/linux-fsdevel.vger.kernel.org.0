Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D7C568136
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 10:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiGFIYy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 04:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiGFIYd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:24:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0805248C3;
        Wed,  6 Jul 2022 01:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657095871; x=1688631871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MKQ/rcKgV3drdHlWuFoH8sIMBaUN6eYji0w3R3tli4U=;
  b=HkSexBI8iotE10lNxXJYeNtQWP+CackIKTyXVfkd9yZPbztQMxwjnJ5D
   euu6Apo6Fh6FA4R07YCc6Zb4UGITL7DXzsU4SJFogP3kbLnSSWZz52uSa
   12IwMn3X1zGzUm1Gt/1/OMUOV9qTImUCtvJ1NErEKsTIOh5e3yOTENjmt
   iq+lXgvLr39r0MzGseH32qiw7V0mHV/0GcPwhZH75SqgK04mNeildGCsC
   cBoeVaCHjU9n6tZSiX4M7pmKUImAPFJgbj1xwL4N0guFtfHEryUU/du36
   WrPXDy+KyF9YmrTpX2LTWwDGhICHIoD0hjZ2KfIxFTHZGaXY1bka11ntv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="264100019"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="264100019"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 01:24:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="567967895"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2022 01:24:19 -0700
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org
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
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v7 04/14] mm/shmem: Support memfile_notifier
Date:   Wed,  6 Jul 2022 16:20:06 +0800
Message-Id: <20220706082016.2603916-5-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 mm/shmem.c               | 109 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index a68f982f22d1..6031c0b08d26 100644
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
index 6c8aef15a17d..627e315c3b4d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -905,6 +905,17 @@ static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
 	return page ? page_folio(page) : NULL;
 }
 
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
@@ -948,6 +959,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			}
 			index += folio_nr_pages(folio) - 1;
 
+			notify_invalidate(inode, folio, start, end);
+
 			if (!unfalloc || !folio_test_uptodate(folio))
 				truncate_inode_folio(mapping, folio);
 			folio_unlock(folio);
@@ -1021,6 +1034,9 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 					index--;
 					break;
 				}
+
+				notify_invalidate(inode, folio, start, end);
+
 				VM_BUG_ON_FOLIO(folio_test_writeback(folio),
 						folio);
 				truncate_inode_folio(mapping, folio);
@@ -1092,6 +1108,13 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
 		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
 			return -EPERM;
 
+		if (info->memfile_node.flags & MEMFILE_F_USER_INACCESSIBLE) {
+			if (oldsize)
+				return -EPERM;
+			if (!PAGE_ALIGNED(newsize))
+				return -EINVAL;
+		}
+
 		if (newsize != oldsize) {
 			error = shmem_reacct_size(SHMEM_I(inode)->flags,
 					oldsize, newsize);
@@ -1336,6 +1359,8 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 		goto redirty;
 	if (!total_swap_pages)
 		goto redirty;
+	if (info->memfile_node.flags & MEMFILE_F_UNRECLAIMABLE)
+		goto redirty;
 
 	/*
 	 * Our capabilities prevent regular writeback or sync from ever calling
@@ -2271,6 +2296,9 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	if (ret)
 		return ret;
 
+	if (info->memfile_node.flags & MEMFILE_F_USER_INACCESSIBLE)
+		return -EPERM;
+
 	/* arm64 - allow memory tagging on RAM-based files */
 	vma->vm_flags |= VM_MTE_ALLOWED;
 
@@ -2306,6 +2334,7 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 		info->i_crtime = inode->i_mtime;
 		INIT_LIST_HEAD(&info->shrinklist);
 		INIT_LIST_HEAD(&info->swaplist);
+		memfile_node_init(&info->memfile_node);
 		simple_xattrs_init(&info->xattrs);
 		cache_no_acl(inode);
 		mapping_set_large_folios(inode->i_mapping);
@@ -2477,6 +2506,8 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 		if ((info->seals & F_SEAL_GROW) && pos + len > inode->i_size)
 			return -EPERM;
 	}
+	if (unlikely(info->memfile_node.flags & MEMFILE_F_USER_INACCESSIBLE))
+		return -EPERM;
 
 	if (unlikely(info->seals & F_SEAL_AUTO_ALLOCATE))
 		sgp = SGP_NOALLOC;
@@ -2556,6 +2587,13 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
@@ -2697,6 +2735,12 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
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
@@ -3806,6 +3850,20 @@ static int shmem_error_remove_page(struct address_space *mapping,
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
+		return -EOPNOTSUPP;
+	return migrate_page(mapping, newpage, page, mode);
+}
+#endif
+
 const struct address_space_operations shmem_aops = {
 	.writepage	= shmem_writepage,
 	.dirty_folio	= noop_dirty_folio,
@@ -3814,7 +3872,7 @@ const struct address_space_operations shmem_aops = {
 	.write_end	= shmem_write_end,
 #endif
 #ifdef CONFIG_MIGRATION
-	.migratepage	= migrate_page,
+	.migratepage	= shmem_migrate_page,
 #endif
 	.error_remove_page = shmem_error_remove_page,
 };
@@ -3931,6 +3989,51 @@ static struct file_system_type shmem_fs_type = {
 	.fs_flags	= FS_USERNS_MOUNT,
 };
 
+#ifdef CONFIG_MEMFILE_NOTIFIER
+static struct memfile_node *shmem_lookup_memfile_node(struct file *file)
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
+static int shmem_get_pfn(struct file *file, pgoff_t offset, pfn_t *pfn,
+			 int *order)
+{
+	struct page *page;
+	int ret;
+
+	ret = shmem_getpage(file_inode(file), offset, &page, SGP_WRITE);
+	if (ret)
+		return ret;
+
+	unlock_page(page);
+	*pfn = page_to_pfn_t(page);
+	*order = thp_order(compound_head(page));
+	return 0;
+}
+
+static void shmem_put_pfn(pfn_t pfn)
+{
+	struct page *page = pfn_t_to_page(pfn);
+
+	if (!page)
+		return;
+
+	put_page(page);
+}
+
+static struct memfile_backing_store shmem_backing_store = {
+	.lookup_memfile_node = shmem_lookup_memfile_node,
+	.get_pfn = shmem_get_pfn,
+	.put_pfn = shmem_put_pfn,
+};
+#endif /* CONFIG_MEMFILE_NOTIFIER */
+
 void __init shmem_init(void)
 {
 	int error;
@@ -3956,6 +4059,10 @@ void __init shmem_init(void)
 	else
 		shmem_huge = SHMEM_HUGE_NEVER; /* just in case it was patched */
 #endif
+
+#ifdef CONFIG_MEMFILE_NOTIFIER
+	memfile_register_backing_store(&shmem_backing_store);
+#endif
 	return;
 
 out1:
-- 
2.25.1

