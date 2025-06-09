Return-Path: <linux-fsdevel+bounces-51003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB5DAD1A83
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 11:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E546188B1BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 09:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07784252907;
	Mon,  9 Jun 2025 09:27:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1475122ACF7;
	Mon,  9 Jun 2025 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749461269; cv=none; b=RdLRcfnHAQfOvyvbGAXEcQlQW9zCwWWSXxEXiER0ihv+WlDyY1B6JDilELAjLpV/NAD9eDxIo1pi/Gfe84VCtV+pdMOTFPz8kMszHu7YHeN04FklVOuoI+pXFtADkE8oLmQcJudPuIhZ8mX7QJkJZTcbefrZqV2pUbmjncpkJ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749461269; c=relaxed/simple;
	bh=F+EwTiX+NdBRhK78a4yv/r21bHRaKWx+UF/pBWTsGAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUMkOMB9F/WzA8uQ6q0ZASjoMTu44vAMWLknv80eoFJMY9xYm6Zo/npQBUyf2kdy7IKW/UdrB7dSNpLDuZjlUYoR7JBkedyYNxCjwRipMK4p3sCE3BkBI9P/7JP5tCw0rMkXKH7EwXmoSmdf1FGP2rypNP5FwZUkPVDQmFGqdTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 993D1150C;
	Mon,  9 Jun 2025 02:27:28 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 399273F59E;
	Mon,  9 Jun 2025 02:27:45 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	Dave Chinner <david@fromorbit.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	Zi Yan <ziy@nvidia.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 3/5] mm/readahead: Make space in struct file_ra_state
Date: Mon,  9 Jun 2025 10:27:25 +0100
Message-ID: <20250609092729.274960-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250609092729.274960-1-ryan.roberts@arm.com>
References: <20250609092729.274960-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to be able to store the preferred folio order associated with a
readahead request in the struct file_ra_state so that we can more
accurately increase the order across subsequent readahead requests. But
struct file_ra_state is per-struct file, so we don't really want to
increase it's size.

mmap_miss is currently 32 bits but it is only counted up to 10 *
MMAP_LOTSAMISS, which is currently defined as 1000. So 16 bits should be
plenty. Redefine it to unsigned short, making room for order as unsigned
short in follow up commit.

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/fs.h |  2 +-
 mm/filemap.c       | 11 ++++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 05abdabe9db7..87e7d5790e43 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1052,7 +1052,7 @@ struct file_ra_state {
 	unsigned int size;
 	unsigned int async_size;
 	unsigned int ra_pages;
-	unsigned int mmap_miss;
+	unsigned short mmap_miss;
 	loff_t prev_pos;
 };
 
diff --git a/mm/filemap.c b/mm/filemap.c
index a6459874bb2a..7bb4ffca8487 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3217,7 +3217,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
 	struct file *fpin = NULL;
 	unsigned long vm_flags = vmf->vma->vm_flags;
-	unsigned int mmap_miss;
+	unsigned short mmap_miss;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	/* Use the readahead code, even if readahead is disabled */
@@ -3285,7 +3285,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	struct file_ra_state *ra = &file->f_ra;
 	DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, vmf->pgoff);
 	struct file *fpin = NULL;
-	unsigned int mmap_miss;
+	unsigned short mmap_miss;
 
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
@@ -3605,7 +3605,7 @@ static struct folio *next_uptodate_folio(struct xa_state *xas,
 static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 			struct folio *folio, unsigned long start,
 			unsigned long addr, unsigned int nr_pages,
-			unsigned long *rss, unsigned int *mmap_miss)
+			unsigned long *rss, unsigned short *mmap_miss)
 {
 	vm_fault_t ret = 0;
 	struct page *page = folio_page(folio, start);
@@ -3667,7 +3667,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 
 static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
 		struct folio *folio, unsigned long addr,
-		unsigned long *rss, unsigned int *mmap_miss)
+		unsigned long *rss, unsigned short *mmap_miss)
 {
 	vm_fault_t ret = 0;
 	struct page *page = &folio->page;
@@ -3709,7 +3709,8 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	struct folio *folio;
 	vm_fault_t ret = 0;
 	unsigned long rss = 0;
-	unsigned int nr_pages = 0, mmap_miss = 0, mmap_miss_saved, folio_type;
+	unsigned int nr_pages = 0, folio_type;
+	unsigned short mmap_miss = 0, mmap_miss_saved;
 
 	rcu_read_lock();
 	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
-- 
2.43.0


