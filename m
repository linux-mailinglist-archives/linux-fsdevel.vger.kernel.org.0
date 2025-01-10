Return-Path: <linux-fsdevel+bounces-38880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B37D5A09652
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 16:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2F497A210D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 15:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0F7212D72;
	Fri, 10 Jan 2025 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kyfxonJm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF7F212B04;
	Fri, 10 Jan 2025 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524040; cv=none; b=eyCt3SPDOSJK71zVt2s6IJfkPPWhs7XuKoRkH2FSNgDi2O5hv1CpzD7oWf1RFLjc1u7/wVQO8pAabiJKdB3sKsp8qsdFUJXYRpTqIpRDoNYKvtWPjNSwoiRyCbN15mGN1W7OcSeZ86sPXqpDKD2ADN86A8dWvDIS/0v5CkXpjUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524040; c=relaxed/simple;
	bh=kspl/aS8jqixCyYDrjMvbWTsH0rrPCAtad7Ys+V0UGU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FiNuCHKiL3V0jLHrji3lmZrezoFFOeYD5yggLl5U3kkKU8UW2ZnSK4CmwPI4qMOHNfbWFnNb9J3RBa2N5xDSG6AePMhizsEyB4+phvjC9rmwAX0NNDjBQouiZZZGrVTRF8UXK5CWCyBrBtn025XEWVopNEnOErZd7WeGlxKepRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kyfxonJm; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736524038; x=1768060038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OXivU7M5CXSyTYrNpqb9X3JfzB/3lICobLVQuajiBEU=;
  b=kyfxonJmJBsXeGrerHIxEO8L3GClwbPamFkvdhRoG6J8V5coxzRgh6yz
   fPxE+PV0lUMc73V4Na/v2OAmq7+1/f0pz/Qby6/oqBw22hZWv9hEbAFsp
   PRk/M2g4zttLkoTjL5LUkF9l/tjJTQyH8pEzFXPGz4C5nPLTnw2CUwlPJ
   o=;
X-IronPort-AV: E=Sophos;i="6.12,303,1728950400"; 
   d="scan'208";a="160494933"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 15:47:15 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:57625]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.65:2525] with esmtp (Farcaster)
 id 31d70eba-0d84-47e0-86c1-973ac7aa0042; Fri, 10 Jan 2025 15:47:15 +0000 (UTC)
X-Farcaster-Flow-ID: 31d70eba-0d84-47e0-86c1-973ac7aa0042
Received: from EX19D020UWC002.ant.amazon.com (10.13.138.147) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 15:47:15 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D020UWC002.ant.amazon.com (10.13.138.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 15:47:14 +0000
Received: from email-imr-corp-prod-pdx-all-2c-8a67eb17.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Fri, 10 Jan 2025 15:47:14 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-pdx-all-2c-8a67eb17.us-west-2.amazon.com (Postfix) with ESMTPS id 5990140258;
	Fri, 10 Jan 2025 15:47:12 +0000 (UTC)
From: Nikita Kalyazin <kalyazin@amazon.com>
To: <willy@infradead.org>, <pbonzini@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <michael.day@amd.com>, <david@redhat.com>, <jthoughton@google.com>,
	<michael.roth@amd.com>, <ackerleytng@google.com>, <graf@amazon.de>,
	<jgowans@amazon.com>, <roypat@amazon.co.uk>, <derekmn@amazon.com>,
	<nsaenz@amazon.es>, <xmarcalx@amazon.com>, <kalyazin@amazon.com>
Subject: [RFC PATCH 1/2] mm: filemap: add filemap_grab_folios
Date: Fri, 10 Jan 2025 15:46:58 +0000
Message-ID: <20250110154659.95464-2-kalyazin@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250110154659.95464-1-kalyazin@amazon.com>
References: <20250110154659.95464-1-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Similar to filemap_grab_folio, but grabs multiple folios at a time.
filemap_grab_folios attempts to get 128 adjacent folios in the pagecache
starting at the specified index.  Whenever a folio is not found, it
allocates a new one and adds it to the pagecache.

The following is not currently supported:
 - large folios
 - reclaim effects in the pagecache (shadows)

An equivalent of the following callstack is implemented to work on
multiple folios:
 - filemap_grab_folio
 - __filemap_get_folio
 - filemap_add_folio
 - __filemap_add_folio

Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
---
 include/linux/pagemap.h |  31 +++++
 mm/filemap.c            | 263 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 294 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 68a5f1ff3301..fd10d77c07c1 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -747,9 +747,16 @@ static inline fgf_t fgf_set_order(size_t size)
 	return (__force fgf_t)((shift - PAGE_SHIFT) << 26);
 }
 
+/**
+ * Folio batch size used by __filemap_get_folios.
+ */
+#define FILEMAP_GET_FOLIOS_BATCH_SIZE 128
+
 void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
 struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		fgf_t fgp_flags, gfp_t gfp);
+int __filemap_get_folios(struct address_space *mapping, pgoff_t index,
+		fgf_t fgp_flags, gfp_t gfp, struct folio **folios, int num);
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		fgf_t fgp_flags, gfp_t gfp);
 
@@ -808,6 +815,30 @@ static inline struct folio *filemap_grab_folio(struct address_space *mapping,
 			mapping_gfp_mask(mapping));
 }
 
+/**
+ * filemap_grab_folios - grab folios from the page cache
+ * @mapping: The address space to search
+ * @index: The page index to start with
+ * @folios: Output buffer for found or created folios
+ * @num: Number of folios to grab
+ *
+ * Looks up @num page cache entries at @mapping starting from @index. If no
+ * folio is found at the index, a new folio is created. The folios are locked,
+ * and marked as accessed.
+ *
+ * Return: The total number of found and created folios. Returned folios will
+ * always have adjacent indexes starting from @index. If no folios are found
+ * and created, -ENOMEM is returned.
+ */
+static inline int filemap_grab_folios(struct address_space *mapping,
+				      pgoff_t index, struct folio **folios,
+				      int num)
+{
+	return __filemap_get_folios(mapping, index,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+			mapping_gfp_mask(mapping), folios, num);
+}
+
 /**
  * find_get_page - find and get a page reference
  * @mapping: the address_space to search
diff --git a/mm/filemap.c b/mm/filemap.c
index 56fa431c52af..b5bc203e3350 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -958,6 +958,60 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 }
 ALLOW_ERROR_INJECTION(__filemap_add_folio, ERRNO);
 
+static int __filemap_add_folios(struct address_space *mapping,
+				struct folio **folios, pgoff_t index,
+				int num, unsigned long *exclude_bm,
+				bool *conflict)
+{
+	XA_STATE(xas, &mapping->i_pages, index);
+	int i;
+
+	mapping_set_update(&xas, mapping);
+	xas_lock_irq(&xas);
+
+	for (i = 0; i < num; i++) {
+		struct folio *folio = folios[i];
+
+		if (test_bit(i, exclude_bm)) {
+			xas_next(&xas);
+			if (i == 0)
+				xas_set(&xas, index + i + 1);
+			continue;
+		}
+
+		VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+		VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
+		VM_BUG_ON_FOLIO(folio_order(folio) != 0, folio);
+		VM_BUG_ON_FOLIO(folio_nr_pages(folio) != 1, folio);
+
+		if (xas_find_conflict(&xas)) {
+			xas_set_err(&xas, -EEXIST);
+			*conflict = true;
+			break;
+		}
+
+		folio_ref_inc(folio);
+		folio->mapping = mapping;
+		folio->index = xas.xa_index;
+
+		xas_store(&xas, folio);
+		if (xas_error(&xas)) {
+			folio->mapping = NULL;
+			folio_put(folio);
+			break;
+		}
+
+		__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, 1);
+		trace_mm_filemap_add_to_page_cache(folio);
+		xas_next(&xas);
+		mapping->nrpages++;
+	}
+
+	xas_unlock_irq(&xas);
+
+	return i ?: xas_error(&xas);
+}
+
 int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 				pgoff_t index, gfp_t gfp)
 {
@@ -991,6 +1045,45 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 }
 EXPORT_SYMBOL_GPL(filemap_add_folio);
 
+static int filemap_add_folios(struct address_space *mapping,
+			      struct folio **folios,
+			      pgoff_t index, gfp_t gfp, int num,
+			      unsigned long *exclude_bm, bool *conflict)
+{
+	int ret, i, num_charged, num_added;
+
+	for (i = 0; i < num; i++) {
+		if (test_bit(i, exclude_bm))
+			continue;
+		ret = mem_cgroup_charge(folios[i], NULL, gfp);
+		if (unlikely(ret))
+			break;
+		__folio_set_locked(folios[i]);
+	}
+
+	num_charged = i;
+	if (!num_charged)
+		return ret;
+
+	num_added = __filemap_add_folios(mapping, folios, index, num_charged,
+					 exclude_bm, conflict);
+
+	for (i = 0; i < num_added; i++) {
+		if (test_bit(i, exclude_bm))
+			continue;
+		folio_add_lru(folios[i]);
+	}
+
+	for (i = num_added; i < num_charged; i++) {
+		if (test_bit(i, exclude_bm))
+			continue;
+		mem_cgroup_uncharge(folios[i]);
+		__folio_clear_locked(folios[i]);
+	}
+
+	return num_added;
+}
+
 #ifdef CONFIG_NUMA
 struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
 {
@@ -1982,6 +2075,176 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 }
 EXPORT_SYMBOL(__filemap_get_folio);
 
+static int __filemap_get_folios_inner(struct address_space *mapping,
+				      pgoff_t index, fgf_t fgp_flags,
+				      gfp_t gfp, struct folio **folios,
+				      int num, bool *conflict)
+{
+	DECLARE_BITMAP(present_bm, FILEMAP_GET_FOLIOS_BATCH_SIZE);
+	int i, err, num_present, num_alloced = 0, num_added = 0;
+	struct folio *folio;
+
+	bitmap_zero(present_bm, FILEMAP_GET_FOLIOS_BATCH_SIZE);
+
+	for (i = 0; i < num; i++) {
+		folio = filemap_get_entry(mapping, index + i);
+		if (xa_is_value(folio))
+			folio = NULL;
+
+		if (!folio) {
+			if (!(fgp_flags & FGP_CREAT)) {
+				err = -ENOENT;
+				break;
+			}
+			continue;
+		}
+
+		if (fgp_flags & FGP_LOCK) {
+			if (fgp_flags & FGP_NOWAIT) {
+				if (!folio_trylock(folio)) {
+					folio_put(folio);
+					err = -EAGAIN;
+					break;
+				}
+			} else {
+				folio_lock(folio);
+			}
+
+			/* Has the page been truncated? */
+			if (unlikely(folio->mapping != mapping)) {
+				folio_unlock(folio);
+				folio_put(folio);
+				i--;
+				continue;
+			}
+			VM_BUG_ON_FOLIO(!folio_contains(folio, index + i), folio);
+		}
+
+		if (fgp_flags & FGP_ACCESSED)
+			folio_mark_accessed(folio);
+		else if (fgp_flags & FGP_WRITE) {
+			/* Clear idle flag for buffer write */
+			if (folio_test_idle(folio))
+				folio_clear_idle(folio);
+		}
+
+		if (fgp_flags & FGP_STABLE)
+			folio_wait_stable(folio);
+
+		folios[i] = folio;
+		set_bit(i, present_bm);
+	}
+
+	num_present = i ?: err;
+
+	if ((fgp_flags & FGP_CREAT)) {
+		if ((fgp_flags & FGP_WRITE) && mapping_can_writeback(mapping))
+			gfp |= __GFP_WRITE;
+		if (fgp_flags & FGP_NOFS)
+			gfp &= ~__GFP_FS;
+		if (fgp_flags & FGP_NOWAIT) {
+			gfp &= ~GFP_KERNEL;
+			gfp |= GFP_NOWAIT | __GFP_NOWARN;
+		}
+		if (WARN_ON_ONCE(!(fgp_flags & (FGP_LOCK | FGP_FOR_MMAP))))
+			fgp_flags |= FGP_LOCK;
+
+		for (i = 0; i < num; i++) {
+			if (test_bit(i, present_bm))
+				continue;
+
+			folios[i] = filemap_alloc_folio(gfp, 0);
+			if (!folios[i])
+				break;
+
+			/* Init accessed so avoid atomic mark_page_accessed later */
+			if (fgp_flags & FGP_ACCESSED)
+				__folio_set_referenced(folios[i]);
+		}
+
+		num_alloced = i;
+
+		if (num_alloced > 0) {
+			num_added = filemap_add_folios(mapping, folios, index, gfp, num_alloced, present_bm, conflict);
+
+			/*
+			 * filemap_add_folios locks the page, and for mmap
+			 * we expect an unlocked page.
+			 */
+			if ((fgp_flags & FGP_FOR_MMAP))
+				for (i = 0; i < num_added; i++) {
+					if (!test_bit(i, present_bm))
+						folio_unlock(folios[i]);
+				}
+
+			/*
+			 * Clean up folios that failed to get added.
+			 */
+			for (i = num_added; i < num_alloced; i++) {
+				if (!test_bit(i, present_bm)) {
+					folio_unlock(folios[i]);
+					folio_put(folios[i]);
+				}
+			}
+		}
+
+		if (fgp_flags & FGP_LOCK)
+			/*
+			 * Clean up folios that failed to get allocated.
+			 */
+			for (i = num_alloced; i < num; i++) {
+				if (test_bit(i, present_bm))
+					folio_unlock(folios[i]);
+			}
+	}
+
+	if (fgp_flags & FGP_CREAT)
+		return num_added ?: (num_alloced ?: num_present);
+	else
+		return num_present;
+}
+
+/**
+ * __filemap_get_folios - Find and get references to folios.
+ * @mapping: The address_space to search.
+ * @index: The page index to start with.
+ * @fgp_flags: %FGP flags modify how the folio is returned.
+ * @gfp: Memory allocation flags to use if %FGP_CREAT is specified.
+ * @folios: Output buffer for found folios.
+ * @num: Number of folios to find.
+ *
+ * Looks up @num page cache entries at @mapping starting at @index.
+ *
+ * If %FGP_LOCK or %FGP_CREAT are specified then the function may sleep even
+ * if the %GFP flags specified for %FGP_CREAT are atomic.
+ *
+ * If this function returns @folios, they are returned with an increased
+ * refcount.
+ *
+ * Return: The number of found folios or an error otherwise.
+ */
+int __filemap_get_folios(struct address_space *mapping, pgoff_t index,
+			 fgf_t fgp_flags, gfp_t gfp, struct folio **folios,
+			 int num)
+{
+	int ret, processed = 0;
+	bool conflict;
+
+	do {
+		conflict = false;
+		ret = __filemap_get_folios_inner(mapping, index, fgp_flags,
+						 gfp, folios, num, &conflict);
+		if (ret > 0) {
+			index += ret;
+			folios += ret;
+			num -= ret;
+			processed += ret;
+		}
+	} while (ret > 0 && conflict && num);
+
+	return processed ?: ret;
+}
+
 static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
 		xa_mark_t mark)
 {
-- 
2.40.1


