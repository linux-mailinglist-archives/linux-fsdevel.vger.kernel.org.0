Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 540AD18FEAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 21:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgCWUXD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 16:23:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgCWUXC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QsAKRlkWbh2P6dRsQvzMX+jO7/N+AwQGAjR//jua188=; b=ugV1ih3KtlXBjnDQ4K73/74XiB
        9gm+5cQfx6G8gN9Ns/jiDPL69XHREREKRS67SoBn243HTrIoG55Hu2ggQ4taxCnTDun/FAKTQd/h1
        1kYBolkdc7VZXhnnez/FEG0HfkDVbPEwzvxSH/qZt7y6QF5AlGkaparl84iw5n8WtaV1ta40BwbMj
        Ga8IHtdd45fYQSpIKB7Ljm3TqVHtlViQiR1WFeonh+3p60BmDxVclMYq9je7O5NZgEfX4tM0UlwQX
        A9aiBDu+gH+3RoNHaMnrtJduaQfTN8GqkyzYm+iqCAYnPPJd+3KiItq9CmKNyKXbRfgv7eLFftx0v
        ad/RXqaw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGTbB-0003UV-DC; Mon, 23 Mar 2020 20:23:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v10 01/25] mm: Move readahead prototypes from mm.h
Date:   Mon, 23 Mar 2020 13:22:35 -0700
Message-Id: <20200323202259.13363-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200323202259.13363-1-willy@infradead.org>
References: <20200323202259.13363-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The readahead code is part of the page cache so should be found in the
pagemap.h file.  force_page_cache_readahead is only used within mm,
so move it to mm/internal.h instead.  Remove the parameter names where
they add no value, and rename the ones which were actively misleading.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 block/blk-core.c        |  1 +
 include/linux/mm.h      | 19 -------------------
 include/linux/pagemap.h |  8 ++++++++
 mm/fadvise.c            |  2 ++
 mm/internal.h           |  2 ++
 5 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index abfdcf81a228..b5b6b17bcd5d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -20,6 +20,7 @@
 #include <linux/blk-mq.h>
 #include <linux/highmem.h>
 #include <linux/mm.h>
+#include <linux/pagemap.h>
 #include <linux/kernel_stat.h>
 #include <linux/string.h>
 #include <linux/init.h>
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bfd79d21cfd5..bc3fbde6d081 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2605,25 +2605,6 @@ extern vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf);
 int __must_check write_one_page(struct page *page);
 void task_dirty_inc(struct task_struct *tsk);
 
-/* readahead.c */
-#define VM_READAHEAD_PAGES	(SZ_128K / PAGE_SIZE)
-
-int force_page_cache_readahead(struct address_space *mapping, struct file *filp,
-			pgoff_t offset, unsigned long nr_to_read);
-
-void page_cache_sync_readahead(struct address_space *mapping,
-			       struct file_ra_state *ra,
-			       struct file *filp,
-			       pgoff_t offset,
-			       unsigned long size);
-
-void page_cache_async_readahead(struct address_space *mapping,
-				struct file_ra_state *ra,
-				struct file *filp,
-				struct page *pg,
-				pgoff_t offset,
-				unsigned long size);
-
 extern unsigned long stack_guard_gap;
 /* Generic expand stack which grows the stack according to GROWS{UP,DOWN} */
 extern int expand_stack(struct vm_area_struct *vma, unsigned long address);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 25408958958f..7d43a464b2a4 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -612,6 +612,14 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask);
 void delete_from_page_cache_batch(struct address_space *mapping,
 				  struct pagevec *pvec);
 
+#define VM_READAHEAD_PAGES	(SZ_128K / PAGE_SIZE)
+
+void page_cache_sync_readahead(struct address_space *, struct file_ra_state *,
+		struct file *, pgoff_t index, unsigned long req_count);
+void page_cache_async_readahead(struct address_space *, struct file_ra_state *,
+		struct file *, struct page *, pgoff_t index,
+		unsigned long req_count);
+
 /*
  * Like add_to_page_cache_locked, but used to add newly allocated pages:
  * the page is new, so we can just run __SetPageLocked() against it.
diff --git a/mm/fadvise.c b/mm/fadvise.c
index 4f17c83db575..3efebfb9952c 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -22,6 +22,8 @@
 
 #include <asm/unistd.h>
 
+#include "internal.h"
+
 /*
  * POSIX_FADV_WILLNEED could set PG_Referenced, and POSIX_FADV_NOREUSE could
  * deactivate the pages and clear PG_Referenced.
diff --git a/mm/internal.h b/mm/internal.h
index b5634e78f01d..25fee17c7334 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -49,6 +49,8 @@ void unmap_page_range(struct mmu_gather *tlb,
 			     unsigned long addr, unsigned long end,
 			     struct zap_details *details);
 
+int force_page_cache_readahead(struct address_space *, struct file *,
+		pgoff_t index, unsigned long nr_to_read);
 extern unsigned int __do_page_cache_readahead(struct address_space *mapping,
 		struct file *filp, pgoff_t offset, unsigned long nr_to_read,
 		unsigned long lookahead_size);
-- 
2.25.1

