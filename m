Return-Path: <linux-fsdevel+bounces-17681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B558B1731
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 01:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B292881B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 23:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E6016F0E6;
	Wed, 24 Apr 2024 23:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="k+gsUF74"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0F7157467;
	Wed, 24 Apr 2024 23:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714001665; cv=none; b=M31zI9PFdGKHcjDwgJm2cM8DiXKFgt+tgicTWpmHFilC84Qu2MWg4OSu6kWVNlX0vA+6fRQzuek8sxLQnjaUaAqrNmcnzO4NZaHMazfU1iUC9uBnKaqLbq7U8ahgprLrwslJLj2BCPQYJVXrNWbUeFp9MeYkef++35rfFzrVHJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714001665; c=relaxed/simple;
	bh=r1lFMQ9tjlwDCB+yNR4sMxDGzxvWoPx/ZEFghdtGbrE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FJQg/5mD9t2dJefsRTUOne9uZfB8RT2vKD1XCW3+O24Du1AkqqN7+6RqKC34+r4Wy81JQc+zJeCkbHXSHlewz9JLWuQpS9NdW0muCM94pCzyP7AJHep16FyEXK8obAl23Z04HjJqY6XGhlKe9lxtnRDvDT2PHwpbTi7HhCSTCm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=k+gsUF74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8602C113CD;
	Wed, 24 Apr 2024 23:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1714001665;
	bh=r1lFMQ9tjlwDCB+yNR4sMxDGzxvWoPx/ZEFghdtGbrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k+gsUF74AM8tc617xiGEq89jMawYHg31Zlp93tTbs31afiLDVMXfdX/JXO6FR8DMm
	 LSNG5DF6NtQKO+OqHklIjrbfJfilPNIunu38rKI43bKf2sIy9nLSJb0oclb5r5vbtu
	 +zpCLAhE++JJx79s6IYUd5Ola9Hudc52ne9h+oKg=
Date: Wed, 24 Apr 2024 16:34:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 6/6] mm: Remove page_mapping()
Message-Id: <20240424163423.ad6e23a984deb731e2de497c@linux-foundation.org>
In-Reply-To: <7c52ae2a-8f72-4c3c-b4b3-24b50bdb5486@redhat.com>
References: <20240423225552.4113447-1-willy@infradead.org>
	<20240423225552.4113447-7-willy@infradead.org>
	<7c52ae2a-8f72-4c3c-b4b3-24b50bdb5486@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Apr 2024 13:55:32 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 24.04.24 00:55, Matthew Wilcox (Oracle) wrote:
> > All callers are now converted, delete this compatibility wrapper.
> > 

For some reason,

mm/hugetlb.c: In function 'hugetlb_page_mapping_lock_write':
mm/hugetlb.c:2164:41: error: implicit declaration of function 'page_mapping'; did you mean 'page_mapped'? [-Werror=implicit-function-declaration]
 2164 |         struct address_space *mapping = page_mapping(hpage);
      |                                         ^~~~~~~~~~~~
      |                                         page_mapped
mm/hugetlb.c:2164:41: error: initialization of 'struct address_space *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]


I'll disable "mm: Remove page_mapping()" pending review of the below,
please.


From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm: convert hugetlb_page_mapping_lock_write() to hugetlb_folio_mapping_lock_write
Date: Wed Apr 24 04:20:30 PM PDT 2024

Convert this to use folios, so we can remove page_mapping()

Cc: David Hildenbrand <david@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/hugetlb.h |    6 +++---
 mm/hugetlb.c            |    6 +++---
 mm/memory-failure.c     |    4 ++--
 mm/migrate.c            |    2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

--- a/mm/hugetlb.c~mm-convert-hugetlb_page_mapping_lock_write-to-hugetlb_folio_mapping_lock_write
+++ a/mm/hugetlb.c
@@ -2155,13 +2155,13 @@ static bool prep_compound_gigantic_folio
 /*
  * Find and lock address space (mapping) in write mode.
  *
- * Upon entry, the page is locked which means that page_mapping() is
+ * Upon entry, the folio is locked which means that folio_mapping() is
  * stable.  Due to locking order, we can only trylock_write.  If we can
  * not get the lock, simply return NULL to caller.
  */
-struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage)
+struct address_space *hugetlb_folio_mapping_lock_write(struct folio *folio)
 {
-	struct address_space *mapping = page_mapping(hpage);
+	struct address_space *mapping = folio_mapping(folio);
 
 	if (!mapping)
 		return mapping;
--- a/mm/memory-failure.c~mm-convert-hugetlb_page_mapping_lock_write-to-hugetlb_folio_mapping_lock_write
+++ a/mm/memory-failure.c
@@ -1595,7 +1595,7 @@ static bool hwpoison_user_mappings(struc
 	 * XXX: the dirty test could be racy: set_page_dirty() may not always
 	 * be called inside page lock (it's recommended but not enforced).
 	 */
-	mapping = page_mapping(hpage);
+	mapping = folio_mapping(folio);
 	if (!(flags & MF_MUST_KILL) && !PageDirty(hpage) && mapping &&
 	    mapping_can_writeback(mapping)) {
 		if (page_mkclean(hpage)) {
@@ -1622,7 +1622,7 @@ static bool hwpoison_user_mappings(struc
 		 * TTU_RMAP_LOCKED to indicate we have taken the lock
 		 * at this higher level.
 		 */
-		mapping = hugetlb_page_mapping_lock_write(hpage);
+		mapping = hugetlb_folio_mapping_lock_write(folio);
 		if (mapping) {
 			try_to_unmap(folio, ttu|TTU_RMAP_LOCKED);
 			i_mmap_unlock_write(mapping);
--- a/include/linux/hugetlb.h~mm-convert-hugetlb_page_mapping_lock_write-to-hugetlb_folio_mapping_lock_write
+++ a/include/linux/hugetlb.h
@@ -178,7 +178,7 @@ bool hugetlbfs_pagecache_present(struct
 				 struct vm_area_struct *vma,
 				 unsigned long address);
 
-struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage);
+struct address_space *hugetlb_folio_mapping_lock_write(struct folio *folio);
 
 extern int sysctl_hugetlb_shm_group;
 extern struct list_head huge_boot_pages[MAX_NUMNODES];
@@ -297,8 +297,8 @@ static inline unsigned long hugetlb_tota
 	return 0;
 }
 
-static inline struct address_space *hugetlb_page_mapping_lock_write(
-							struct page *hpage)
+static inline struct address_space *hugetlb_folio_mapping_lock_write(
+							struct folio *folio)
 {
 	return NULL;
 }
--- a/mm/migrate.c~mm-convert-hugetlb_page_mapping_lock_write-to-hugetlb_folio_mapping_lock_write
+++ a/mm/migrate.c
@@ -1425,7 +1425,7 @@ static int unmap_and_move_huge_page(new_
 			 * semaphore in write mode here and set TTU_RMAP_LOCKED
 			 * to let lower levels know we have taken the lock.
 			 */
-			mapping = hugetlb_page_mapping_lock_write(&src->page);
+			mapping = hugetlb_folio_mapping_lock_write(src);
 			if (unlikely(!mapping))
 				goto unlock_put_anon;
 
_


