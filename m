Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282574D48A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 15:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242728AbiCJOLH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 09:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242724AbiCJOLF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:11:05 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF44E7B572;
        Thu, 10 Mar 2022 06:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646921401; x=1678457401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=LshKgds1U2bNEdA3l08Zy9WrXI0Fxarkx0V/cuLKyUc=;
  b=azREEZj2WvSF3w5S7E5ujiwkNVcuTS3IHPy1PcR6ATAXKfa3BWeQ+Nwb
   qFfbO+iRa5ME16b5s4jVN+a1NQ/EX5ieWQppWEvZTzOKUrFy3EyzZ5sHs
   YodjDaLpPvbQNSqRc+o+rY76Czi2vwZ+QRXMiZJDAsYK1DZq0K6G1DP2A
   7E2yRIIgBdicB24Jcwo+LK3l2E/bDlsplluNzDBY0mvEjNz2WEhGeSLR/
   S32Y9mVJUGSf5fMzXu+LhBqNva62LoorwBO6cw3I9cOi1zOnR/fFGQyID
   mLX2N0jlpxdKMNc3yjxOp5UVNdOYyMjBH35uWfpEGZpl1Pih6juZzAfAA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="315975650"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="315975650"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 06:10:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="554654872"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 10 Mar 2022 06:09:52 -0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org
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
        ak@linux.intel.com, david@redhat.com
Subject: [PATCH v5 03/13] mm/shmem: Support memfile_notifier
Date:   Thu, 10 Mar 2022 22:09:01 +0800
Message-Id: <20220310140911.50924-4-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

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
 include/linux/shmem_fs.h |  4 +++
 mm/shmem.c               | 76 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 2dde843f28ef..7bb16f2d2825 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -9,6 +9,7 @@
 #include <linux/percpu_counter.h>
 #include <linux/xattr.h>
 #include <linux/fs_parser.h>
+#include <linux/memfile_notifier.h>
 
 /* inode in-kernel data */
 
@@ -28,6 +29,9 @@ struct shmem_inode_info {
 	struct simple_xattrs	xattrs;		/* list of xattrs */
 	atomic_t		stop_eviction;	/* hold when working on inode */
 	unsigned int		xflags;		/* shmem extended flags */
+#ifdef CONFIG_MEMFILE_NOTIFIER
+	struct memfile_notifier_list memfile_notifiers;
+#endif
 	struct inode		vfs_inode;
 };
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 9b31a7056009..7b43e274c9a2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -903,6 +903,28 @@ static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
 	return page ? page_folio(page) : NULL;
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
+static void notify_invalidate_page(struct inode *inode, struct folio *folio,
+				   pgoff_t start, pgoff_t end)
+{
+#ifdef CONFIG_MEMFILE_NOTIFIER
+	struct shmem_inode_info *info = SHMEM_I(inode);
+
+	start = max(start, folio->index);
+	end = min(end, folio->index + folio_nr_pages(folio));
+
+	memfile_notifier_invalidate(&info->memfile_notifiers, start, end);
+#endif
+}
+
 /*
  * Remove range of pages and swap entries from page cache, and free them.
  * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocate.
@@ -946,6 +968,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			}
 			index += folio_nr_pages(folio) - 1;
 
+			notify_invalidate_page(inode, folio, start, end);
+
 			if (!unfalloc || !folio_test_uptodate(folio))
 				truncate_inode_folio(mapping, folio);
 			folio_unlock(folio);
@@ -1019,6 +1043,9 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 					index--;
 					break;
 				}
+
+				notify_invalidate_page(inode, folio, start, end);
+
 				VM_BUG_ON_FOLIO(folio_test_writeback(folio),
 						folio);
 				truncate_inode_folio(mapping, folio);
@@ -2279,6 +2306,9 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 		info->flags = flags & VM_NORESERVE;
 		INIT_LIST_HEAD(&info->shrinklist);
 		INIT_LIST_HEAD(&info->swaplist);
+#ifdef CONFIG_MEMFILE_NOTIFIER
+		memfile_notifier_list_init(&info->memfile_notifiers);
+#endif
 		simple_xattrs_init(&info->xattrs);
 		cache_no_acl(inode);
 		mapping_set_large_folios(inode->i_mapping);
@@ -2802,6 +2832,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 	if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode->i_size)
 		i_size_write(inode, offset + len);
 	inode->i_ctime = current_time(inode);
+	notify_fallocate(inode, start, end);
 undone:
 	spin_lock(&inode->i_lock);
 	inode->i_private = NULL;
@@ -3909,6 +3940,47 @@ static struct file_system_type shmem_fs_type = {
 	.fs_flags	= FS_USERNS_MOUNT,
 };
 
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
+static struct memfile_notifier_list* shmem_get_notifier_list(struct inode *inode)
+{
+	if (!shmem_mapping(inode->i_mapping))
+		return NULL;
+
+	return  &SHMEM_I(inode)->memfile_notifiers;
+}
+
+static struct memfile_backing_store shmem_backing_store = {
+	.pfn_ops.get_lock_pfn = shmem_get_lock_pfn,
+	.pfn_ops.put_unlock_pfn = shmem_put_unlock_pfn,
+	.get_notifier_list = shmem_get_notifier_list,
+};
+#endif /* CONFIG_MEMFILE_NOTIFIER */
+
 int __init shmem_init(void)
 {
 	int error;
@@ -3934,6 +4006,10 @@ int __init shmem_init(void)
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
2.17.1

