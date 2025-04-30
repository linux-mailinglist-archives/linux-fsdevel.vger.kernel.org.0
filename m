Return-Path: <linux-fsdevel+bounces-47730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E54AA4F66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 17:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF86500605
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 15:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA0125DCFD;
	Wed, 30 Apr 2025 14:59:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C04113E02D;
	Wed, 30 Apr 2025 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025180; cv=none; b=pQ36ORrHyGYPeXj5ffQtBduqp5bbci2CbXgk7LutixAZEIgxjXAXracBRZq1xgvbOl4DAPk9/9TwT0tPCns7SQA20bLEuIe3dRXQAXRjIc+jolsubu9fr20pZOnpNmMNGCTwgM3bStmcP4rVcSNWMNfFSBfckaGh4fNQvlIure8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025180; c=relaxed/simple;
	bh=pKiHMXgN1CKKfPTJF7z/0J7LkE7fjzM6JNtcw2wFw38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fm4SASS73wDD3xrpvsuFgO8gNZcQrlJQ7m/+J3QVYUB486SUwb6zJT7PjhyqXmKLhOsZChm+yqTx8LZlc/J3QOo7hsNuZ/XjvUVIVDBvWJ/xc6Wd6raq3YoEIFwlMCKA9Xtax8eLs6ZnEBhJLioDrMN+G5SxjQCsWxs4t3OGsPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1430168F;
	Wed, 30 Apr 2025 07:59:30 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BD443F5A1;
	Wed, 30 Apr 2025 07:59:36 -0700 (PDT)
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
Subject: [RFC PATCH v4 3/5] mm/readahead: Make space in struct file_ra_state
Date: Wed, 30 Apr 2025 15:59:16 +0100
Message-ID: <20250430145920.3748738-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430145920.3748738-1-ryan.roberts@arm.com>
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
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

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/fs.h |  2 +-
 mm/filemap.c       | 11 ++++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..44362bef0010 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1042,7 +1042,7 @@ struct file_ra_state {
 	unsigned int size;
 	unsigned int async_size;
 	unsigned int ra_pages;
-	unsigned int mmap_miss;
+	unsigned short mmap_miss;
 	loff_t prev_pos;
 };
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 7b90cbeb4a1a..fa129ecfd80f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3207,7 +3207,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
 	struct file *fpin = NULL;
 	unsigned long vm_flags = vmf->vma->vm_flags;
-	unsigned int mmap_miss;
+	unsigned short mmap_miss;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	/* Use the readahead code, even if readahead is disabled */
@@ -3275,7 +3275,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	struct file_ra_state *ra = &file->f_ra;
 	DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, vmf->pgoff);
 	struct file *fpin = NULL;
-	unsigned int mmap_miss;
+	unsigned short mmap_miss;
 
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
@@ -3595,7 +3595,7 @@ static struct folio *next_uptodate_folio(struct xa_state *xas,
 static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 			struct folio *folio, unsigned long start,
 			unsigned long addr, unsigned int nr_pages,
-			unsigned long *rss, unsigned int *mmap_miss)
+			unsigned long *rss, unsigned short *mmap_miss)
 {
 	vm_fault_t ret = 0;
 	struct page *page = folio_page(folio, start);
@@ -3657,7 +3657,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 
 static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
 		struct folio *folio, unsigned long addr,
-		unsigned long *rss, unsigned int *mmap_miss)
+		unsigned long *rss, unsigned short *mmap_miss)
 {
 	vm_fault_t ret = 0;
 	struct page *page = &folio->page;
@@ -3699,7 +3699,8 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
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


