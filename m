Return-Path: <linux-fsdevel+bounces-43283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA9CA50793
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 18:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84EF016B483
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 17:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C9E2517AF;
	Wed,  5 Mar 2025 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ccXFIVh4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C731C6FFE;
	Wed,  5 Mar 2025 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197494; cv=none; b=sf494lFG57a84BXWmRGyyWAEjshU120NahyhUjbk9zOe1vT1KbUOeEhVbTMrXS6S7gwAEVp4g+ymkABl3RK+JTASKVPhgxsijF8Sw7+Zkgs8ORLoyBMzdbP11s0C9vE6dvKvt/E/q2o6SGtGNo6e1bq3MaTyuH9w241/wZl4muE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197494; c=relaxed/simple;
	bh=/6xHPLL6GhXalpIRi3UgVjQ+8XkBGM2Q/FIQre3NnhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COiSOGAfoD6CxUhCXsoOaJAyfkDTIb7+0GEwLHgaXoU/kKJF4p3VcVNYZOzph11RwWgMSS4jU1OUNB5hHamCkOdyv72wKCjOkVqhBaHCgf4bh1WR4qz0bqkfuXJ9khAZlPsKRGEqVsRfGfy2xYEmiZ3qUAeKz59AN/m0uWU2c+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ccXFIVh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD9BC4CED1;
	Wed,  5 Mar 2025 17:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197493;
	bh=/6xHPLL6GhXalpIRi3UgVjQ+8XkBGM2Q/FIQre3NnhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ccXFIVh48eiBCWqpU+6gEsuWw7UWwZknfNWHJZ924RvmY4kw3/FnV5KYhnr/KarsS
	 4MeCoEwqC1nUg4PKI8Oodpxrk8HzVSmrK03hL1EuYxmicUhsizfhptgPrzfYMOu16Q
	 jcX4KRP3PIKfCWDg5feWUkXxSRV8YeJtZz6zpikI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Hillf Danton <hdanton@sina.com>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 143/176] mm: Dont pin ZERO_PAGE in pin_user_pages()
Date: Wed,  5 Mar 2025 18:48:32 +0100
Message-ID: <20250305174511.186748725@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.437358097@linuxfoundation.org>
References: <20250305174505.437358097@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit c8070b78751955e59b42457b974bea4a4fe00187 ]

Make pin_user_pages*() leave a ZERO_PAGE unpinned if it extracts a pointer
to it from the page tables and make unpin_user_page*() correspondingly
ignore a ZERO_PAGE when unpinning.  We don't want to risk overrunning a
zero page's refcount as we're only allowed ~2 million pins on it -
something that userspace can conceivably trigger.

Add a pair of functions to test whether a page or a folio is a ZERO_PAGE.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@infradead.org>
cc: David Hildenbrand <david@redhat.com>
cc: Lorenzo Stoakes <lstoakes@gmail.com>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Matthew Wilcox <willy@infradead.org>
cc: Jan Kara <jack@suse.cz>
cc: Jeff Layton <jlayton@kernel.org>
cc: Jason Gunthorpe <jgg@nvidia.com>
cc: Logan Gunthorpe <logang@deltatee.com>
cc: Hillf Danton <hdanton@sina.com>
cc: Christian Brauner <brauner@kernel.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20230526214142.958751-2-dhowells@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: bddf10d26e6e ("uprobes: Reject the shared zeropage in uprobe_write_opcode()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/core-api/pin_user_pages.rst |  6 +++++
 include/linux/mm.h                        | 26 +++++++++++++++++--
 mm/gup.c                                  | 31 ++++++++++++++++++++++-
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core-api/pin_user_pages.rst
index b18416f4500fe..7995ce2b9676a 100644
--- a/Documentation/core-api/pin_user_pages.rst
+++ b/Documentation/core-api/pin_user_pages.rst
@@ -113,6 +113,12 @@ pages:
 This also leads to limitations: there are only 31-10==21 bits available for a
 counter that increments 10 bits at a time.
 
+* Because of that limitation, special handling is applied to the zero pages
+  when using FOLL_PIN.  We only pretend to pin a zero page - we don't alter its
+  refcount or pincount at all (it is permanent, so there's no need).  The
+  unpinning functions also don't do anything to a zero page.  This is
+  transparent to the caller.
+
 * Callers must specifically request "dma-pinned tracking of pages". In other
   words, just calling get_user_pages() will not suffice; a new set of functions,
   pin_user_page() and related, must be used.
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 971186f0b7b07..03357c196e0ba 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1610,6 +1610,28 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
 	return page_maybe_dma_pinned(page);
 }
 
+/**
+ * is_zero_page - Query if a page is a zero page
+ * @page: The page to query
+ *
+ * This returns true if @page is one of the permanent zero pages.
+ */
+static inline bool is_zero_page(const struct page *page)
+{
+	return is_zero_pfn(page_to_pfn(page));
+}
+
+/**
+ * is_zero_folio - Query if a folio is a zero page
+ * @folio: The folio to query
+ *
+ * This returns true if @folio is one of the permanent zero pages.
+ */
+static inline bool is_zero_folio(const struct folio *folio)
+{
+	return is_zero_page(&folio->page);
+}
+
 /* MIGRATE_CMA and ZONE_MOVABLE do not allow pin pages */
 #ifdef CONFIG_MIGRATION
 static inline bool is_longterm_pinnable_page(struct page *page)
@@ -1620,8 +1642,8 @@ static inline bool is_longterm_pinnable_page(struct page *page)
 	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
 		return false;
 #endif
-	/* The zero page may always be pinned */
-	if (is_zero_pfn(page_to_pfn(page)))
+	/* The zero page can be "pinned" but gets special handling. */
+	if (is_zero_page(page))
 		return true;
 
 	/* Coherent device memory must always allow eviction. */
diff --git a/mm/gup.c b/mm/gup.c
index e31d00443c4e6..b1daaa9d89aab 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -51,7 +51,8 @@ static inline void sanity_check_pinned_pages(struct page **pages,
 		struct page *page = *pages;
 		struct folio *folio = page_folio(page);
 
-		if (!folio_test_anon(folio))
+		if (is_zero_page(page) ||
+		    !folio_test_anon(folio))
 			continue;
 		if (!folio_test_large(folio) || folio_test_hugetlb(folio))
 			VM_BUG_ON_PAGE(!PageAnonExclusive(&folio->page), page);
@@ -128,6 +129,13 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 	else if (flags & FOLL_PIN) {
 		struct folio *folio;
 
+		/*
+		 * Don't take a pin on the zero page - it's not going anywhere
+		 * and it is used in a *lot* of places.
+		 */
+		if (is_zero_page(page))
+			return page_folio(page);
+
 		/*
 		 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
 		 * right zone, so fail and let the caller fall back to the slow
@@ -177,6 +185,8 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 {
 	if (flags & FOLL_PIN) {
+		if (is_zero_folio(folio))
+			return;
 		node_stat_mod_folio(folio, NR_FOLL_PIN_RELEASED, refs);
 		if (folio_test_large(folio))
 			atomic_sub(refs, folio_pincount_ptr(folio));
@@ -217,6 +227,13 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
 	if (flags & FOLL_GET)
 		folio_ref_inc(folio);
 	else if (flags & FOLL_PIN) {
+		/*
+		 * Don't take a pin on the zero page - it's not going anywhere
+		 * and it is used in a *lot* of places.
+		 */
+		if (is_zero_page(page))
+			return 0;
+
 		/*
 		 * Similar to try_grab_folio(): be sure to *also*
 		 * increment the normal page refcount field at least once,
@@ -3149,6 +3166,9 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
  *
  * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
  * see Documentation/core-api/pin_user_pages.rst for further details.
+ *
+ * Note that if a zero_page is amongst the returned pages, it will not have
+ * pins in it and unpin_user_page() will not remove pins from it.
  */
 int pin_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages)
@@ -3225,6 +3245,9 @@ EXPORT_SYMBOL_GPL(pin_user_pages_fast_only);
  *
  * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
  * see Documentation/core-api/pin_user_pages.rst for details.
+ *
+ * Note that if a zero_page is amongst the returned pages, it will not have
+ * pins in it and unpin_user_page*() will not remove pins from it.
  */
 long pin_user_pages_remote(struct mm_struct *mm,
 			   unsigned long start, unsigned long nr_pages,
@@ -3260,6 +3283,9 @@ EXPORT_SYMBOL(pin_user_pages_remote);
  *
  * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
  * see Documentation/core-api/pin_user_pages.rst for details.
+ *
+ * Note that if a zero_page is amongst the returned pages, it will not have
+ * pins in it and unpin_user_page*() will not remove pins from it.
  */
 long pin_user_pages(unsigned long start, unsigned long nr_pages,
 		    unsigned int gup_flags, struct page **pages,
@@ -3282,6 +3308,9 @@ EXPORT_SYMBOL(pin_user_pages);
  * pin_user_pages_unlocked() is the FOLL_PIN variant of
  * get_user_pages_unlocked(). Behavior is the same, except that this one sets
  * FOLL_PIN and rejects FOLL_GET.
+ *
+ * Note that if a zero_page is amongst the returned pages, it will not have
+ * pins in it and unpin_user_page*() will not remove pins from it.
  */
 long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 			     struct page **pages, unsigned int gup_flags)
-- 
2.39.5




