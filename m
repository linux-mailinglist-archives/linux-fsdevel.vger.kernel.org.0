Return-Path: <linux-fsdevel+bounces-19640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F55D8C832B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 11:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8268B1C202F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 09:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09412200D2;
	Fri, 17 May 2024 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yshyn.com header.i=@yshyn.com header.b="s8qF9X+x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from phoenix.uberspace.de (phoenix.uberspace.de [95.143.172.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B1A1EB3E
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 09:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715937644; cv=none; b=XwJB7Te3a63r/WgzfNvlbVc6hJ2kTP8k8qZCXRmOSjk/Mb0UGJ+YAJ3O8+thg0D2LqDrEtPRHDIOuQGkoOnMy+HL+15mVAtgRw+8wgBC8UNhjXaKeDqcCR802lDmXCIyL/20NXrShnhlzhqS00gykCLoims4gtGisXvOuUzElTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715937644; c=relaxed/simple;
	bh=zUX5qNIfW548vNLMV3YfOWr2RVuk/rIW/JNspwwgaDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M3O9E7cHzX856zBMnInrCai4QoNu0pjbhpNzbLdiffc7L7QGr2SgvC5VHmrH8CeomMIFrYJ48upQ1YHlxVV/Lx6Tzxrp18FbwzQDgGAzW2S7D+BbV6BHxYIUO1ltgB9kbloP8WAdJvJYb7I5pEp913ccC+lyj1m5pK/xVOw/iMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yshyn.com; spf=pass smtp.mailfrom=yshyn.com; dkim=pass (2048-bit key) header.d=yshyn.com header.i=@yshyn.com header.b=s8qF9X+x; arc=none smtp.client-ip=95.143.172.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yshyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yshyn.com
Received: (qmail 13005 invoked by uid 988); 17 May 2024 09:13:58 -0000
Authentication-Results: phoenix.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by phoenix.uberspace.de (Haraka/3.0.1) with ESMTPSA; Fri, 17 May 2024 11:13:57 +0200
From: Illia Ostapyshyn <illia@yshyn.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Illia Ostapyshyn <illia@yshyn.com>
Subject: [PATCH] mm/vmscan: Update stale references to shrink_page_list
Date: Fri, 17 May 2024 11:13:48 +0200
Message-Id: <20240517091348.1185566-1-illia@yshyn.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: +
X-Rspamd-Report: MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: 1.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=yshyn.com; s=uberspace;
	h=from:to:cc:subject:date;
	bh=zUX5qNIfW548vNLMV3YfOWr2RVuk/rIW/JNspwwgaDA=;
	b=s8qF9X+xASJEWN/cMfdXpv37+eChv24TVme12xnLdvA65YeLPvsTXzosKqg8OeC49J5W76JCJG
	jXt8b3WBCoWyHOW6ZAXTIEhwcx3HgSKo7GNhhPzlmOFAiMkpfbb/Qr2+tBLxzjpAAPK2KqHIAS3X
	dun0Pvmwj1DQ5Ikf7ijj4Y6RxzPpcYrN9nNzeGMn0R0Thnq6Z3unRuYKkAK98CKUGmfeVqggYD8j
	7pWiuwES3hWX1bm0vSyKHopIQGsB0IWLRKFbBd0pEPGW4zAG8AmBYKOyWdHAm1T2zG3TdRB4+fRv
	qKhYjDH39qcYIOrnRP/Z7LvFijc0MOp8VK/n/Kiw==

Commit 49fd9b6df54e ("mm/vmscan: fix a lot of comments") renamed
shrink_page_list() to shrink_folio_list().  Fix up the remaining
references to the old name in comments and documentation.

Signed-off-by: Illia Ostapyshyn <illia@yshyn.com>
---
 Documentation/mm/unevictable-lru.rst | 10 +++++-----
 mm/memory.c                          |  2 +-
 mm/swap_state.c                      |  2 +-
 mm/truncate.c                        |  2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/mm/unevictable-lru.rst b/Documentation/mm/unevictable-lru.rst
index b6a07a26b10d..2feb2ed51ae2 100644
--- a/Documentation/mm/unevictable-lru.rst
+++ b/Documentation/mm/unevictable-lru.rst
@@ -191,13 +191,13 @@ have become evictable again (via munlock() for example) and have been "rescued"
 from the unevictable list.  However, there may be situations where we decide,
 for the sake of expediency, to leave an unevictable folio on one of the regular
 active/inactive LRU lists for vmscan to deal with.  vmscan checks for such
-folios in all of the shrink_{active|inactive|page}_list() functions and will
+folios in all of the shrink_{active|inactive|folio}_list() functions and will
 "cull" such folios that it encounters: that is, it diverts those folios to the
 unevictable list for the memory cgroup and node being scanned.
 
 There may be situations where a folio is mapped into a VM_LOCKED VMA,
 but the folio does not have the mlocked flag set.  Such folios will make
-it all the way to shrink_active_list() or shrink_page_list() where they
+it all the way to shrink_active_list() or shrink_folio_list() where they
 will be detected when vmscan walks the reverse map in folio_referenced()
 or try_to_unmap().  The folio is culled to the unevictable list when it
 is released by the shrinker.
@@ -269,7 +269,7 @@ the LRU.  Such pages can be "noticed" by memory management in several places:
 
  (4) in the fault path and when a VM_LOCKED stack segment is expanded; or
 
- (5) as mentioned above, in vmscan:shrink_page_list() when attempting to
+ (5) as mentioned above, in vmscan:shrink_folio_list() when attempting to
      reclaim a page in a VM_LOCKED VMA by folio_referenced() or try_to_unmap().
 
 mlocked pages become unlocked and rescued from the unevictable list when:
@@ -548,12 +548,12 @@ Some examples of these unevictable pages on the LRU lists are:
  (3) pages still mapped into VM_LOCKED VMAs, which should be marked mlocked,
      but events left mlock_count too low, so they were munlocked too early.
 
-vmscan's shrink_inactive_list() and shrink_page_list() also divert obviously
+vmscan's shrink_inactive_list() and shrink_folio_list() also divert obviously
 unevictable pages found on the inactive lists to the appropriate memory cgroup
 and node unevictable list.
 
 rmap's folio_referenced_one(), called via vmscan's shrink_active_list() or
-shrink_page_list(), and rmap's try_to_unmap_one() called via shrink_page_list(),
+shrink_folio_list(), and rmap's try_to_unmap_one() called via shrink_folio_list(),
 check for (3) pages still mapped into VM_LOCKED VMAs, and call mlock_vma_folio()
 to correct them.  Such pages are culled to the unevictable list when released
 by the shrinker.
diff --git a/mm/memory.c b/mm/memory.c
index 0201f50d8307..c58b3d92e6a8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4511,7 +4511,7 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 	 * lock_page(B)
 	 *				lock_page(B)
 	 * pte_alloc_one
-	 *   shrink_page_list
+	 *   shrink_folio_list
 	 *     wait_on_page_writeback(A)
 	 *				SetPageWriteback(B)
 	 *				unlock_page(B)
diff --git a/mm/swap_state.c b/mm/swap_state.c
index bfc7e8c58a6d..3d163ec1364a 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -28,7 +28,7 @@
 
 /*
  * swapper_space is a fiction, retained to simplify the path through
- * vmscan's shrink_page_list.
+ * vmscan's shrink_folio_list.
  */
 static const struct address_space_operations swap_aops = {
 	.writepage	= swap_writepage,
diff --git a/mm/truncate.c b/mm/truncate.c
index 725b150e47ac..e1c352bb026b 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -554,7 +554,7 @@ EXPORT_SYMBOL(invalidate_mapping_pages);
  * This is like mapping_evict_folio(), except it ignores the folio's
  * refcount.  We do this because invalidate_inode_pages2() needs stronger
  * invalidation guarantees, and cannot afford to leave folios behind because
- * shrink_page_list() has a temp ref on them, or because they're transiently
+ * shrink_folio_list() has a temp ref on them, or because they're transiently
  * sitting in the folio_add_lru() caches.
  */
 static int invalidate_complete_folio2(struct address_space *mapping,
-- 
2.39.2


