Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A65C570A72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 22:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbfGVUNk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 16:13:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41112 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbfGVUNk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 16:13:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id x15so7843650pgg.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jul 2019 13:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MBGXoEQOWEoS+pbE8WDgU6eaM9JwlPKYmsQ8uHe+ttk=;
        b=mgvA6dvVpsSaAJwSrYoBJ8sO2zK9oMVEl920BIbYhhvZFMXbxZ63GL01SDviu+rqrx
         wBW2IycmqAZWic5EYWRq0K5401vu4EJh7ECzEeZpfwNUZnUQUCQQpJi708i6pY65DF5u
         EZS1vBkRR7DbQnsULHXCpZvzdvYiHduNLzt7My/NTa4Iow8ojUpcpwQRlQVYiSFTdiUZ
         YEcxq0BqA6GfZgnv76apux2buXziZb4c0q5rBykIekW/Y4+wkgmlVA2qu3hiGskCO7XY
         Dgv3dj1PeNR2Xv5033GQQQA7u54BCDoZIvD62U8CKBQ7iJK3G6RtKWAVXQcLt8AXl0pk
         PLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MBGXoEQOWEoS+pbE8WDgU6eaM9JwlPKYmsQ8uHe+ttk=;
        b=MPHwSGdrGhpIsS/o96JBxHRh5/R0UmyVPB9cE6xAUOiLacFXi5hpRe3Z5ED/91xL7y
         Kl8yvGo1OcINk/wFicVyUR1EIPxElRxU07NcU4D76Aav8YeEVz56MgEc83D5lq54kO9R
         r8UhaA9OwQyurrgtaDRZovQ1K1EucxrhQgZDdYgR9E6tbKUeJOb2ehGcQqKfdqMB40Pt
         76ZkHob2ZaTQ8AhcABsQMQYdYdrwqImYDzQc7qaDXhYOQeujc5rNcYlfjzPUtZHFuHn2
         kBFk7+fhQIbKAF9YSVTI27Axsq+U0aVbSAKapp9FfzalBFIOcRvvyeVCKeXOiSOhMkdd
         vMcg==
X-Gm-Message-State: APjAAAU01saLQpB/55wGK6y6MCHNlTfJYSCOW9vlc6S8ndo6/ePUN9gl
        OYZXc7w5yumpVq0paGKnQ/E=
X-Google-Smtp-Source: APXvYqw/Um+g/iT+9qb/uPFGojm/jNklGnE7v4+XD0EyF+itpqQx1L3l0yRsC/Xzq9vpOqzw8+BjBA==
X-Received: by 2002:a17:90a:e397:: with SMTP id b23mr78935506pjz.117.1563826419241;
        Mon, 22 Jul 2019 13:13:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:c914])
        by smtp.gmail.com with ESMTPSA id 137sm50328560pfz.112.2019.07.22.13.13.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 13:13:38 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] psi: annotate refault stalls from IO submission
Date:   Mon, 22 Jul 2019 16:13:37 -0400
Message-Id: <20190722201337.19180-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

psi tracks the time tasks wait for refaulting pages to become
uptodate, but it does not track the time spent submitting the IO. The
submission part can be significant if backing storage is contended or
when cgroup throttling (io.latency) is in effect - a lot of time is
spent in submit_bio(). In that case, we underreport memory pressure.

Annotate the submit_bio() paths (or the indirection through readpage)
for refaults and swapin to get proper psi coverage of delays there.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 fs/btrfs/extent_io.c | 14 ++++++++++++--
 fs/ext4/readpage.c   |  9 +++++++++
 fs/f2fs/data.c       |  8 ++++++++
 fs/mpage.c           |  9 +++++++++
 mm/filemap.c         | 20 ++++++++++++++++++++
 mm/page_io.c         | 11 ++++++++---
 mm/readahead.c       | 24 +++++++++++++++++++++++-
 7 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1eb671c16ff1..2d2b3239965a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -13,6 +13,7 @@
 #include <linux/pagevec.h>
 #include <linux/prefetch.h>
 #include <linux/cleancache.h>
+#include <linux/psi.h>
 #include "extent_io.h"
 #include "extent_map.h"
 #include "ctree.h"
@@ -4267,6 +4268,9 @@ int extent_readpages(struct address_space *mapping, struct list_head *pages,
 	struct extent_io_tree *tree = &BTRFS_I(mapping->host)->io_tree;
 	int nr = 0;
 	u64 prev_em_start = (u64)-1;
+	int ret = 0;
+	bool refault = false;
+	unsigned long pflags;
 
 	while (!list_empty(pages)) {
 		u64 contig_end = 0;
@@ -4281,6 +4285,10 @@ int extent_readpages(struct address_space *mapping, struct list_head *pages,
 				put_page(page);
 				break;
 			}
+			if (PageWorkingset(page) && !refault) {
+				psi_memstall_enter(&pflags);
+				refault = true;
+			}
 
 			pagepool[nr++] = page;
 			contig_end = page_offset(page) + PAGE_SIZE - 1;
@@ -4301,8 +4309,10 @@ int extent_readpages(struct address_space *mapping, struct list_head *pages,
 		free_extent_map(em_cached);
 
 	if (bio)
-		return submit_one_bio(bio, 0, bio_flags);
-	return 0;
+		ret = submit_one_bio(bio, 0, bio_flags);
+	if (refault)
+		psi_memstall_leave(&pflags);
+	return ret;
 }
 
 /*
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index c916017db334..f28385900b64 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -44,6 +44,7 @@
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
 #include <linux/cleancache.h>
+#include <linux/psi.h>
 
 #include "ext4.h"
 
@@ -116,6 +117,8 @@ int ext4_mpage_readpages(struct address_space *mapping,
 	int length;
 	unsigned relative_block = 0;
 	struct ext4_map_blocks map;
+	bool refault = false;
+	unsigned long pflags;
 
 	map.m_pblk = 0;
 	map.m_lblk = 0;
@@ -134,6 +137,10 @@ int ext4_mpage_readpages(struct address_space *mapping,
 			if (add_to_page_cache_lru(page, mapping, page->index,
 				  readahead_gfp_mask(mapping)))
 				goto next_page;
+			if (PageWorkingset(page) && !refault) {
+				psi_memstall_enter(&pflags);
+				refault = true;
+			}
 		}
 
 		if (page_has_buffers(page))
@@ -291,5 +298,7 @@ int ext4_mpage_readpages(struct address_space *mapping,
 	BUG_ON(pages && !list_empty(pages));
 	if (bio)
 		submit_bio(bio);
+	if (refault)
+		psi_memstall_leave(&pflags);
 	return 0;
 }
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2d0a1a97d3fd..fe9c34247be4 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1699,6 +1699,8 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 	sector_t last_block_in_bio = 0;
 	struct inode *inode = mapping->host;
 	struct f2fs_map_blocks map;
+	bool refault = false;
+	unsigned long pflags;
 	int ret = 0;
 
 	map.m_pblk = 0;
@@ -1720,6 +1722,10 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 						  page_index(page),
 						  readahead_gfp_mask(mapping)))
 				goto next_page;
+			if (PageWorkingset(page) && !refault) {
+				psi_memstall_enter(&pflags);
+				refault = true;
+			}
 		}
 
 		ret = f2fs_read_single_page(inode, page, nr_pages, &map, &bio,
@@ -1736,6 +1742,8 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 	BUG_ON(pages && !list_empty(pages));
 	if (bio)
 		__submit_bio(F2FS_I_SB(inode), bio, DATA);
+	if (refault)
+		psi_memstall_leave(&pflags);
 	return pages ? 0 : ret;
 }
 
diff --git a/fs/mpage.c b/fs/mpage.c
index 436a85260394..f4ef57f1ea06 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -30,6 +30,7 @@
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
 #include <linux/cleancache.h>
+#include <linux/psi.h>
 #include "internal.h"
 
 /*
@@ -389,6 +390,8 @@ mpage_readpages(struct address_space *mapping, struct list_head *pages,
 		.get_block = get_block,
 		.is_readahead = true,
 	};
+	bool refault = false;
+	unsigned long pflags;
 	unsigned page_idx;
 
 	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
@@ -404,10 +407,16 @@ mpage_readpages(struct address_space *mapping, struct list_head *pages,
 			args.bio = do_mpage_readpage(&args);
 		}
 		put_page(page);
+		if (PageWorkingset(page) && !refault) {
+			psi_memstall_enter(&pflags);
+			refault = true;
+		}
 	}
 	BUG_ON(!list_empty(pages));
 	if (args.bio)
 		mpage_bio_submit(REQ_OP_READ, REQ_RAHEAD, args.bio);
+	if (refault)
+		psi_memstall_leave(&pflags);
 	return 0;
 }
 EXPORT_SYMBOL(mpage_readpages);
diff --git a/mm/filemap.c b/mm/filemap.c
index 8129eaa5f257..667fbd3f7eb2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2009,6 +2009,8 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		pgoff_t end_index;
 		loff_t isize;
 		unsigned long nr, ret;
+		unsigned long pflags;
+		bool refault;
 
 		cond_resched();
 find_page:
@@ -2157,9 +2159,17 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		 * PG_error will be set again if readpage fails.
 		 */
 		ClearPageError(page);
+
+		refault = PageWorkingset(page);
+		if (refault)
+			psi_memstall_enter(&pflags);
+
 		/* Start the actual read. The read will unlock the page. */
 		error = mapping->a_ops->readpage(filp, page);
 
+		if (refault)
+			psi_memstall_leave(&pflags);
+
 		if (unlikely(error)) {
 			if (error == AOP_TRUNCATED_PAGE) {
 				put_page(page);
@@ -2753,11 +2763,14 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 				void *data,
 				gfp_t gfp)
 {
+	bool refault = false;
 	struct page *page;
 	int err;
 repeat:
 	page = find_get_page(mapping, index);
 	if (!page) {
+		unsigned long pflags;
+
 		page = __page_cache_alloc(gfp);
 		if (!page)
 			return ERR_PTR(-ENOMEM);
@@ -2770,12 +2783,19 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 			return ERR_PTR(err);
 		}
 
+		refault = PageWorkingset(page);
 filler:
+		if (refault)
+			psi_memstall_enter(&pflags);
+
 		if (filler)
 			err = filler(data, page);
 		else
 			err = mapping->a_ops->readpage(data, page);
 
+		if (refault)
+			psi_memstall_leave(&pflags);
+
 		if (err < 0) {
 			put_page(page);
 			return ERR_PTR(err);
diff --git a/mm/page_io.c b/mm/page_io.c
index 24ee600f9131..e878e9559015 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -24,6 +24,7 @@
 #include <linux/blkdev.h>
 #include <linux/uio.h>
 #include <linux/sched/task.h>
+#include <linux/psi.h>
 #include <asm/pgtable.h>
 
 static struct bio *get_swap_bio(gfp_t gfp_flags,
@@ -354,10 +355,14 @@ int swap_readpage(struct page *page, bool synchronous)
 	struct swap_info_struct *sis = page_swap_info(page);
 	blk_qc_t qc;
 	struct gendisk *disk;
+	unsigned long pflags;
 
 	VM_BUG_ON_PAGE(!PageSwapCache(page) && !synchronous, page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(PageUptodate(page), page);
+
+	psi_memstall_enter(&pflags);
+
 	if (frontswap_load(page) == 0) {
 		SetPageUptodate(page);
 		unlock_page(page);
@@ -371,7 +376,7 @@ int swap_readpage(struct page *page, bool synchronous)
 		ret = mapping->a_ops->readpage(swap_file, page);
 		if (!ret)
 			count_vm_event(PSWPIN);
-		return ret;
+		goto out;
 	}
 
 	ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
@@ -382,7 +387,7 @@ int swap_readpage(struct page *page, bool synchronous)
 		}
 
 		count_vm_event(PSWPIN);
-		return 0;
+		goto out;
 	}
 
 	ret = 0;
@@ -416,8 +421,8 @@ int swap_readpage(struct page *page, bool synchronous)
 	}
 	__set_current_state(TASK_RUNNING);
 	bio_put(bio);
-
 out:
+	psi_memstall_leave(&pflags);
 	return ret;
 }
 
diff --git a/mm/readahead.c b/mm/readahead.c
index 2fe72cd29b47..a89522a053ce 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -22,6 +22,7 @@
 #include <linux/mm_inline.h>
 #include <linux/blk-cgroup.h>
 #include <linux/fadvise.h>
+#include <linux/psi.h>
 
 #include "internal.h"
 
@@ -92,6 +93,9 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
 	int ret = 0;
 
 	while (!list_empty(pages)) {
+		unsigned long pflags;
+		bool refault;
+
 		page = lru_to_page(pages);
 		list_del(&page->lru);
 		if (add_to_page_cache_lru(page, mapping, page->index,
@@ -101,7 +105,15 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
 		}
 		put_page(page);
 
+		refault = PageWorkingset(page);
+		if (refault)
+			psi_memstall_enter(&pflags);
+
 		ret = filler(data, page);
+
+		if (refault)
+			psi_memstall_leave(&pflags);
+
 		if (unlikely(ret)) {
 			read_cache_pages_invalidate_pages(mapping, pages);
 			break;
@@ -132,8 +144,18 @@ static int read_pages(struct address_space *mapping, struct file *filp,
 	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
 		struct page *page = lru_to_page(pages);
 		list_del(&page->lru);
-		if (!add_to_page_cache_lru(page, mapping, page->index, gfp))
+		if (!add_to_page_cache_lru(page, mapping, page->index, gfp)) {
+			bool refault = PageWorkingset(page);
+			unsigned long pflags;
+
+			if (refault)
+				psi_memstall_enter(&pflags);
+
 			mapping->a_ops->readpage(filp, page);
+
+			if (refault)
+				psi_memstall_leave(&pflags);
+		}
 		put_page(page);
 	}
 	ret = 0;
-- 
2.22.0

