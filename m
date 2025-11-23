Return-Path: <linux-fsdevel+bounces-69580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4441C7E80E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 23:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99E2F4E1176
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 22:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271942749F1;
	Sun, 23 Nov 2025 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mARQy8GO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064EDCA4E
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763935528; cv=none; b=bOQbKG+q4doaCdRGu0PswJBtEzi1/rX1PWD/AgD4FOi/eItArXPVozMRABP7tDk/PCZV2g7WZKeYw/ICY17QvbTgf5QFFwokS8KgDt9hLAFkE9GSeO3N5Lky0cX7+A9TQbQuSGkMrqtowUAGOZjqJNHz2pObVjqIjX65RIMSWAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763935528; c=relaxed/simple;
	bh=qNk/dYXPkdaz5IIv2+NfciyiOjH3cZzFaoBKbFfn8S0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gs4C5Pf8IEe5U09JkIlgylmJpPpVsBeN42dfJopi2v/yx70NrpijUoAtXG0CPE/dUGhByInQ7VkFsm2sAz8BmEjnqZZmWHEe6UjZhJ3bDo65VjbeYfVXlA8vjj+2vLN47A4FZbXyYtUMS9omb/WMjhdv1AtTBLjbBh90rGcmscI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mARQy8GO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=h2x6BPYxlmrzlwlCQjCWbuDK8MSa/19CwD8lUoKIvNg=; b=mARQy8GOiu/djBe0ovZedzJhUA
	glAS2HX/t6Xr08DvLwbEExhvzaHXmaynqvVbozjGOhgtaPN9juzIecsYRxETw1dWQe4/f/amXk49T
	64Lykd407bTFRFAw3DozFNcq0PVanFbAq/h9s4WHoWmz26ExKYW15z5ZRFVPnGGaaI8tLoUkbOkuh
	IT7/oW0Jhg/wZlaORKgWIinM7Qtg8PoF4KJy+x3FDzaFNSCEG+FvUnlXptZ1Z2ccExZ7pbe8e+4S9
	q/cROJ/Pkp10n2Ih6OL2+ubio6TIjNukkWDXfXzg4uTo/3TKGFeiOLXUwlfxhPmkjBz9HBKWaeRcU
	RTpjJl4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNICv-000000064V9-1uMA;
	Sun, 23 Nov 2025 22:05:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] fs: Add uoff_t
Date: Sun, 23 Nov 2025 22:05:15 +0000
Message-ID: <20251123220518.1447261-1-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a recent commit, I inadvertently changed a comparison from being an
unsigned comparison (on 64-bit systems) to being a signed comparison
(which it had always been on 32-bit systems).  This led to a sporadic
fstests failure.

To make sure this comparison is always unsigned, introduce a new type,
uoff_t which is the unsigned version of loff_t.  Generally file sizes
are restricted to being a signed integer, but in these two places it is
convenient to pass -1 to indicate "up to the end of the file".

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---

v2: Fix build issue caused by not converting the !CONFIG_SHMEM case
With this patch and reverting b94488503277 ("iomap: use loff_t for file
positions and offsets in writeback code"), fstets passes on next-20251121

 include/linux/mm.h                     | 8 ++++----
 include/linux/shmem_fs.h               | 2 +-
 include/linux/types.h                  | 1 +
 include/uapi/asm-generic/posix_types.h | 1 +
 mm/shmem.c                             | 6 +++---
 mm/truncate.c                          | 2 +-
 6 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6b7dfb5e6871..18656b5f329b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3716,10 +3716,10 @@ struct vm_unmapped_area_info {
 extern unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info);
 
 /* truncate.c */
-extern void truncate_inode_pages(struct address_space *, loff_t);
-extern void truncate_inode_pages_range(struct address_space *,
-				       loff_t lstart, loff_t lend);
-extern void truncate_inode_pages_final(struct address_space *);
+void truncate_inode_pages(struct address_space *mapping, loff_t lstart);
+void truncate_inode_pages_range(struct address_space *mapping, loff_t lstart,
+		uoff_t lend);
+void truncate_inode_pages_final(struct address_space *mapping);
 
 /* generic vm_area_ops exported for stackable file systems */
 extern vm_fault_t filemap_fault(struct vm_fault *vmf);
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 2f3c36d92c03..f6aa916f4d1e 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -126,7 +126,7 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 					pgoff_t index, gfp_t gfp_mask);
 int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
 		struct list_head *folio_list);
-void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
+void shmem_truncate_range(struct inode *inode, loff_t start, uoff_t end);
 int shmem_unuse(unsigned int type);
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/include/linux/types.h b/include/linux/types.h
index 6dfdb8e8e4c3..d4437e9c452c 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -50,6 +50,7 @@ typedef __kernel_old_gid_t	old_gid_t;
 
 #if defined(__GNUC__)
 typedef __kernel_loff_t		loff_t;
+typedef __kernel_uoff_t		uoff_t;
 #endif
 
 /*
diff --git a/include/uapi/asm-generic/posix_types.h b/include/uapi/asm-generic/posix_types.h
index b5f7594eee7a..0a90ad92dbf3 100644
--- a/include/uapi/asm-generic/posix_types.h
+++ b/include/uapi/asm-generic/posix_types.h
@@ -86,6 +86,7 @@ typedef struct {
  */
 typedef __kernel_long_t	__kernel_off_t;
 typedef long long	__kernel_loff_t;
+typedef unsigned long long	__kernel_uoff_t;
 typedef __kernel_long_t	__kernel_old_time_t;
 #ifndef __KERNEL__
 typedef __kernel_long_t	__kernel_time_t;
diff --git a/mm/shmem.c b/mm/shmem.c
index 7950f2a3f6d7..c33e9471ec78 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1093,7 +1093,7 @@ static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
  * Remove range of pages and swap entries from page cache, and free them.
  * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocate.
  */
-static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
+static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 								 bool unfalloc)
 {
 	struct address_space *mapping = inode->i_mapping;
@@ -1244,7 +1244,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	shmem_recalc_inode(inode, 0, -nr_swaps_freed);
 }
 
-void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
+void shmem_truncate_range(struct inode *inode, loff_t lstart, uoff_t lend)
 {
 	shmem_undo_range(inode, lstart, lend, false);
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
@@ -5784,7 +5784,7 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 }
 #endif
 
-void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
+void shmem_truncate_range(struct inode *inode, loff_t lstart, uoff_t lend)
 {
 	truncate_inode_pages_range(inode->i_mapping, lstart, lend);
 }
diff --git a/mm/truncate.c b/mm/truncate.c
index d08340afc768..12467c1bd711 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -364,7 +364,7 @@ long mapping_evict_folio(struct address_space *mapping, struct folio *folio)
  * page aligned properly.
  */
 void truncate_inode_pages_range(struct address_space *mapping,
-				loff_t lstart, loff_t lend)
+				loff_t lstart, uoff_t lend)
 {
 	pgoff_t		start;		/* inclusive */
 	pgoff_t		end;		/* exclusive */
-- 
2.47.2


