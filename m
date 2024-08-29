Return-Path: <linux-fsdevel+bounces-27915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C94BF964C6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE8F1C22A38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCD41BA86E;
	Thu, 29 Aug 2024 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGlITaHl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FF51B86D1
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950749; cv=none; b=qpf7P2aFBpekw1n/ZuJX9N5aL6ArTlK2coWBhVdhsS92CDvXbgAOJJjwiVneY+LXxVl9qwcPbZMYSf5erSiyVJzNtBP1M2DAJdQn0vR7kTZ/k3eTbh9sOzO1Boj8fC1QmZi1WyePTTzBTzaF1HrR9cnbX9FrDpv60JTyc020hIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950749; c=relaxed/simple;
	bh=K+woEaTnjUmqkdB8pKxZ/xg0ooE3m8DTsy83tmmcGy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJAdGciBvKLY2tqaxGPLLzOoZhdZi1vhLW6twJC2uOeM1tJKf80jwGPA4dePkS8cgEvcZWjHZ2cL0W/lHtvpKQZARLjTlAYWSIzn5/72ptnBoqITpqGuLfqVHJqRzkBb+GXS25oMK8f3afd0SGv+v9L40polrk+03gh7AUWpGB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGlITaHl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724950746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cKf6dQguD8Od23K0wDaepWW4S0v2e9lLNnYaNj5b1cU=;
	b=UGlITaHltMNzqQGpq8hJ+HSNs/wIhFYff+GPM6DsjJSSUoDNSthFXNT19D2aibOOKc5MHL
	Wt9MMlY8+mURMGvFByu3iSBZTDhHLa7MlGG+PvMUxt0alA+X6sPUzCZy6UHdGgizhGIu7k
	OLGJqYJLXe8gLt3yoJDwP/ZKsiZnGs4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-ui0rW_eRM6iDl2qZZuTgKA-1; Thu,
 29 Aug 2024 12:59:02 -0400
X-MC-Unique: ui0rW_eRM6iDl2qZZuTgKA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AA1D18F498B;
	Thu, 29 Aug 2024 16:59:00 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.245])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6ACD61955F66;
	Thu, 29 Aug 2024 16:58:51 +0000 (UTC)
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
Subject: [PATCH v1 14/17] fs/proc/task_mmu: remove per-page mapcount dependency for PM_MMAP_EXCLUSIVE (CONFIG_NO_PAGE_MAPCOUNT)
Date: Thu, 29 Aug 2024 18:56:17 +0200
Message-ID: <20240829165627.2256514-15-david@redhat.com>
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

Let's implement an alternative when per-page mapcounts in large folios are
no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.

PM_MMAP_EXCLUSIVE will now be set if folio_likely_mapped_shared() is
true -- when the folio is considered "mapped shared", including when
it once was "mapped shared" but no longer is, as documented.

This might result in and under-indication of "exclusively mapped", which
is considered better than over-indicating it: under-estimating the USS
(Unique Set Size) is better than over-estimating it.

As an alternative, we could simply remove that flag with
CONFIG_NO_PAGE_MAPCOUNT completely, but there might be value to it. So,
let's keep it like that and document the behavior.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/admin-guide/mm/pagemap.rst |  9 +++++++++
 fs/proc/task_mmu.c                       | 16 ++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index 49590306c61a0..131c86574c39a 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -37,6 +37,15 @@ There are four components to pagemap:
    precisely which pages are mapped (or in swap) and comparing mapped
    pages between processes.
 
+   Note that in some kernel configurations, all pages part of a larger
+   allocation (e.g., THP) might be considered "mapped shared" if the large
+   allocation is considered "mapped shared": if not all pages are exclusive to
+   the same process. Further, some kernel configurations might consider larger
+   allocations "mapped shared", if they were at one point considered
+   "mapped shared", even if they would now be considered "exclusively mapped".
+   Consequently, in these kernel configurations, bit 56 might be set although
+   the page is actually "exclusively mapped"
+
    Efficient users of this interface will use ``/proc/pid/maps`` to
    determine which areas of memory are actually mapped and llseek to
    skip over unmapped regions.
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5f171ad7b436b..f35a63c4b7c7a 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -29,6 +29,18 @@
 #include <asm/tlbflush.h>
 #include "internal.h"
 
+#ifdef CONFIG_PAGE_MAPCOUNT
+static bool __folio_page_mapped_exclusively(struct folio *folio, struct page *page)
+{
+	return folio_precise_page_mapcount(folio, page) == 1;
+}
+#else /* !CONFIG_PAGE_MAPCOUNT */
+static bool __folio_page_mapped_exclusively(struct folio *folio, struct page *page)
+{
+	return !folio_likely_mapped_shared(folio);
+}
+#endif /* CONFIG_PAGE_MAPCOUNT */
+
 #define SEQ_PUT_DEC(str, val) \
 		seq_put_decimal_ull_width(m, str, (val) << (PAGE_SHIFT-10), 8)
 void task_mem(struct seq_file *m, struct mm_struct *mm)
@@ -1746,7 +1758,7 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		if (!folio_test_anon(folio))
 			flags |= PM_FILE;
 		if ((flags & PM_PRESENT) &&
-		    folio_precise_page_mapcount(folio, page) == 1)
+		    __folio_page_mapped_exclusively(folio, page))
 			flags |= PM_MMAP_EXCLUSIVE;
 	}
 	if (vma->vm_flags & VM_SOFTDIRTY)
@@ -1821,7 +1833,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 			pagemap_entry_t pme;
 
 			if (folio && (flags & PM_PRESENT) &&
-			    folio_precise_page_mapcount(folio, page + idx) == 1)
+			    __folio_page_mapped_exclusively(folio, page))
 				cur_flags |= PM_MMAP_EXCLUSIVE;
 
 			pme = make_pme(frame, cur_flags);
-- 
2.46.0


