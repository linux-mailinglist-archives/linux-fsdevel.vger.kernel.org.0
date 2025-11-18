Return-Path: <linux-fsdevel+bounces-68952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86918C6A4EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 6FB452C504
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC071364030;
	Tue, 18 Nov 2025 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MXwsZ5rF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A3831770F
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763479781; cv=none; b=SfM9t/AdpYDDZrRVliz8ocLs5qLcxLS436OT3LvPBADxvLezu+PTD5egwQzDehDCvoIrPlqS+1N91hAUhoaCTcKgsQnKYQ8VW9mpVQr3EJzUqR8jZBu9tq+8wvqdTLsPAHvNJqnWj0OS6w1y4maIgtvCqQk7zXxV6XP3/pTFWjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763479781; c=relaxed/simple;
	bh=eQ+8hKPx0XpTMHsJSYSHhV+ijJCD9u25JYikDqFdWBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u0wm8QHW6zUREtAfjdfQxTktFnfMjIDyr15IAeLLmKkkaF+ualadxz2bBKcmQ8xl3+wfeplhIL4mrcOJC3Gu8RIM4/KuRfv4PAPbkxLv0YUCeF7THoRv+WM0xqmqkhJ9nM893nh39V0eKIfR0Qhdcbvh7vkk1Fpl4ITH4RdLhek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MXwsZ5rF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=vfZiX7wznAvtDODkuSMzlx7Ahjg1kuchR1T7I45xBlk=; b=MXwsZ5rFDZfZnNgkflNZC3gMPi
	OEFiK76GgHVOE/oc+eIluWmgC3he1QF+k5rTI2g8lCNWZJ+jR6HdG01eDw7NPBtCp1pxbh+/FUIAv
	1u+1UT8abXfYh+on75A4UDxANYtJD9kYK+nA2cxQlxeoaKBDS2mRjyf/laYdUXHUQXmmtM/JVk5vF
	4sg237zsjJoOcOv/b9zyU66VPyc5pGg9rz5HhCzvUC3/bVAyk6tlCzSGZzOhCjYfKMxn8a8+bHEwu
	RzlHKX409H1490FnNVySLcXGgkLVr+zUW83jJg7W/GYD6PBZq+qDjlmVNxCItV4VUAHH3lMQEtiws
	WPTcDNgA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLNeD-0000000Fflz-0M2N;
	Tue, 18 Nov 2025 15:29:37 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: Add uoff_t
Date: Tue, 18 Nov 2025 15:29:33 +0000
Message-ID: <20251118152935.3735484-1-willy@infradead.org>
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
 include/linux/mm.h                     | 8 ++++----
 include/linux/shmem_fs.h               | 2 +-
 include/linux/types.h                  | 1 +
 include/uapi/asm-generic/posix_types.h | 1 +
 mm/shmem.c                             | 4 ++--
 mm/truncate.c                          | 2 +-
 6 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fe995cc3ba5c..a69ab017c370 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3650,10 +3650,10 @@ struct vm_unmapped_area_info {
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
index 08f497673b06..94c6237acdc9 100644
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
index 0a25ee095b86..728f2e04911e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1105,7 +1105,7 @@ static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
  * Remove range of pages and swap entries from page cache, and free them.
  * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocate.
  */
-static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
+static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 								 bool unfalloc)
 {
 	struct address_space *mapping = inode->i_mapping;
@@ -1256,7 +1256,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	shmem_recalc_inode(inode, 0, -nr_swaps_freed);
 }
 
-void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
+void shmem_truncate_range(struct inode *inode, loff_t lstart, uoff_t lend)
 {
 	shmem_undo_range(inode, lstart, lend, false);
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
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


