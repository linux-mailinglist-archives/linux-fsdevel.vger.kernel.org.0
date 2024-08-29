Return-Path: <linux-fsdevel+bounces-27913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0D3964C65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C76D1C238C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5E11B654C;
	Thu, 29 Aug 2024 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwrkiuT3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F296D1B6546
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950729; cv=none; b=LVQaiyJw2yiEnLdi583lHaP0p0V+KmmyWgvfxWCcx1+CronOnf2ypoNBkFa1UmUGZIfHaC5fnMeBp7bKdLxz/c6eAeAs7FNAKZmyJE+dDmGVcPpAbPwAk18Y571otYon12L6T68yNqbAuuDDscfg9tXtCHIlg/gxmp6ZXDsU5eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950729; c=relaxed/simple;
	bh=wEDT3WYv5QAv16j+geOxf9Xm27ml+se5kydOVg5W9Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+KONgF7s7YUyfdoW/dUnRmOwwPHoKRLDek1A1+cLYHUIRLKrYoFhOoczgxbvpcAcQZ5yTxsUFdF2wXoM/DzYOe7T+7qH75BDlj/A7Epy8J4PubRAmw7GPW8oakXC13/emdxX5mi9PtBCpKop2uBTfFOIAefYdLOwLRAG0H/cRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TwrkiuT3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724950727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xlz/Hr/MLXsaGBmeoyntSanirDE8WH40+jKnaAIxWt4=;
	b=TwrkiuT39S+U7orQ0EU3/Cv+JGECGl+zrdtpOPql9e4BFOrqO68YOPrxGNEeFrAucHVDc+
	rgTEtqYGYgpQuqHNs9IQHIxV1z8vrNojcEiBgJVl/AZAg6X++B+yfuALBZbnM/Xhr/RH4/
	1tSZ2rA3m8d4PxDVRyk7XnOW7k0CpZY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-FFTH9f1IPp2QjlcNQc8UoQ-1; Thu,
 29 Aug 2024 12:58:45 -0400
X-MC-Unique: FFTH9f1IPp2QjlcNQc8UoQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6ADE190308D;
	Thu, 29 Aug 2024 16:58:43 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.245])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3F3A51955F21;
	Thu, 29 Aug 2024 16:58:31 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	x86@kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v1 12/17] mm: remove per-page mapcount dependency in folio_likely_mapped_shared() (CONFIG_NO_PAGE_MAPCOUNT)
Date: Thu, 29 Aug 2024 18:56:15 +0200
Message-ID: <20240829165627.2256514-13-david@redhat.com>
In-Reply-To: <20240829165627.2256514-1-david@redhat.com>
References: <20240829165627.2256514-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Let's remove the dependency on the mapcount of the first folio page in
large folios and consequently any "false negatives" from
folio_likely_mapped_shared().

In theory, we could implement this change only with CONFIG_MM_ID,
without gluing it to another config option. But we'll be a bit
careful for the time being, because folio_likely_mapped_shared() can now
return "false positives" more frequently. Glue it to
CONFIG_NO_PAGE_MAPCOUNT, which expresses the "EXPERIMENTAL" character for
now.

Let's reuse our new MM ownership tracking infrastructure for large folios.
Thoroughly document the changed semantics. We might now detect that a
folio as "mapped shared" although it no longer is -- this can only happen
if more than two MMs mapped a folio at the same time, and neither of the
first two is the last one mapping the folio.

"false positives" in this context are certainly better than "false
negatives" when it comes to enforcing policies (e.g., is process 1
allowed to migrate a folio that might also be used by another process?),
but in an ideal world we wouldn't have these "false positives" either.

It's worth noting that there will not be a change for small folios and
hugetlb folios. In general, for PMD-mapped THP we don't expect a change,
only for PTE-mapped THP.

This will affect various users of folio_likely_mapped_shared():

(1) khugepaged counts PTEs that target shared folios towards the
    max_ptes_shared. With false positives we might collapse too little,
    with false negatives too much.

(2) NUMA hinting: PROT_NONE NUMA protection will be skipped for shared
    folios in COW mappings. With false positives we skip too many, with
    false negatives we don't skip some we should be skipping.

    During NUMA hinting faults, we will set TNF_SHARED with shared folios
    in shared mappings. With false positives we set it too often, with
    false negatives not often enough.

    During NUMA hinting faults, we will reject to migrate shared folios in
    mappings with execute permissions (expectation: shared libraries).
    With false positives we reject to migrate some, with false negatives
    we migrate too many.

(3) MADV_COLD / MADV_PAGEOUT / MADV_FREE will not try splitting PTE-mapped
    THPs that are considered shared but not fully covered by the
    requested range, consequently not processing them. With false
    positives we will not split+process some we could have processed, with
    false negatives we split some folios we probably shouldn't have split.

(4) mbind() / migrate_pages() / move_pages() will refuse to migrate shared
    folios unless MPOL_MF_MOVE_ALL is effective (requires CAP_SYS_NICE).
    With false positives we reject to migrate some folios that could be
    migrated, with false negatives we migrate some folios that shouldn't
    have been migrated.

(5) folio_referenced_one() will skip exclusive swapbacked folios in
    dying processes. Shared folios will not be skipped. With false
    positives we might skip this optimization, with false negatives we
    might apply this optimization wrongly.

Likely (3) and (4) are not really used a lot on folios that are heavily
shared among processes -- rather on anonymous memory (mostly from a
single parent process) or almost-exclusively mmap'ed files.

Similarly (1) is not expected to matter much in practice, and if so,
only for long-running child processes after fork(). But even here, it's
unlikely that it matters in practice.

(5) is not expected to matter much at all, it's a new optimization
either way.

(2) is interesting: the expectation here is that for anon folios it
might not make a big difference. For file-backed pages it might,
we'll have to learn about that.

Long story short: this paves the way for a complete
CONFIG_NO_PAGE_MAPCOUNT implementation, but maybe we'll have to
switch to another MM ownership tracking later.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 98411e53da916..b37f20b26776d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2142,9 +2142,9 @@ static inline size_t folio_size(const struct folio *folio)
  * are independent.
  *
  * As precise information is not easily available for all folios, this function
- * estimates the number of MMs ("sharers") that are currently mapping a folio
- * using the number of times the first page of the folio is currently mapped
- * into page tables.
+ * must sometimes estimate the number of MMs ("sharers") that are currently
+ * mapping a folio using the number of times the first page of the folio is
+ * currently mapped into page tables.
  *
  * For small anonymous folios and anonymous hugetlb folios, the return
  * value will be exactly correct: non-KSM folios can only be mapped at most once
@@ -2152,13 +2152,21 @@ static inline size_t folio_size(const struct folio *folio)
  * considered shared even if mapped multiple times into the same MM.
  *
  * For other folios, the result can be fuzzy:
- *    #. For partially-mappable large folios (THP), the return value can wrongly
- *       indicate "mapped exclusively" (false negative) when the folio is
- *       only partially mapped into at least one MM.
+ *    #. With CONFIG_PAGE_MAPCOUNT: For partially-mappable large folios (THP),
+ *       the return value can wrongly indicate "mapped exclusively" (false
+ *       negative) when the folio is only partially mapped into at least one MM.
+ *    #. With CONFIG_NO_PAGE_MAPCOUNT: For partially-mappable large folios
+ *       (THP), the return value can wrongly indicate "mapped shared" (false
+ *       positive) in some scenarios. This can only happen if two MMs are
+ *       already mapping a folio and a more MM starts mapping the folio. We
+ *       would still the detect the folio as "mapped shared" after the first
+ *       two MMs no longer map the folio.
  *    #. For pagecache folios (including hugetlb), the return value can wrongly
  *       indicate "mapped shared" (false positive) when two VMAs in the same MM
  *       cover the same file range.
  *
+ * With CONFIG_MM_ID, this function will never return "false negatives".
+ *
  * Further, this function only considers current page table mappings that
  * are tracked using the folio mapcount(s).
  *
@@ -2183,12 +2191,16 @@ static inline bool folio_likely_mapped_shared(struct folio *folio)
 	if (mapcount <= 1)
 		return false;
 
+#ifdef CONFIG_PAGE_MAPCOUNT
 	/* If any page is mapped more than once we treat it "mapped shared". */
 	if (folio_entire_mapcount(folio) || mapcount > folio_large_nr_pages(folio))
 		return true;
 
 	/* Let's guess based on the first subpage. */
 	return atomic_read(&folio->_mapcount) > 0;
+#else /* !CONFIG_PAGE_MAPCOUNT */
+	return !folio_test_large_mapped_exclusively(folio);
+#endif /* !CONFIG_PAGE_MAPCOUNT */
 }
 
 #ifndef HAVE_ARCH_MAKE_FOLIO_ACCESSIBLE
-- 
2.46.0


