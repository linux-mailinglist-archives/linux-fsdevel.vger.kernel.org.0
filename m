Return-Path: <linux-fsdevel+bounces-23194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834E7928703
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 12:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA15283976
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 10:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C50D1487EF;
	Fri,  5 Jul 2024 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TqmhA/5d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A9F13C8F9;
	Fri,  5 Jul 2024 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176282; cv=none; b=mN8W1Layj3gdhIQkEBsQOHqphccMXz0/K9yEACtSnLoW3hhHkX3f9MjAaamq9e6YX1YqH00wKZ2aGa9VU+LNMsZRFM/QNv4qxZwhrMgXArfxdJ0sRQ3YMSs1aJkN3jEaoc9QrO+kDyzf5JLdcgdVooPSk7CPQsbbeCEa/TQ3L7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176282; c=relaxed/simple;
	bh=ZpjXXPZ8qVUIBIolYv7O+9WBJ4v+A/hx7t2YGbTwshU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D9FSM+hmqoOi4s4aD8WiVLwoJDH2h5wUeL2kl80XrcQ3tB75e46AKB7fanu2YgUO+IM0XKhDIh5Gm1jGmRz/DRT8ouUrS/L609cExATfBFMkNIMsJ+phxo7OfCkDzm3ARtk2zNGtiwC928RauMeeAHd9ZmdSC+2cjvCNl1IeRY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TqmhA/5d; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=RUOJ1
	0eaGUze/yBhI0ONWdyqGscp0Lrf+4xt2Q4q/u8=; b=TqmhA/5dpL7RyrhdvkPTI
	WkYOuTI/JQ2w8b5snfjSFS0KJjsHKqEFIMZpU3RWsypFGrOo8gsSBDs7VydZNyGO
	AOGtK3550w6N2oFFa2VFEr+bCcjWB7GOXmBXwlGyDW6y85SQXpPkenikP+/XfDtZ
	+yEgOgcJ7axoIIbZKi2SGc=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g2-5 (Coremail) with SMTP id _____wD3v2hjzodm7nZVAQ--.39915S4;
	Fri, 05 Jul 2024 18:43:49 +0800 (CST)
From: ran xiaokai <ranxiaokai627@163.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	corbet@lwn.net,
	usama.anjum@collabora.com,
	avagin@google.com
Cc: linux-mm@kvack.org,
	vbabka@suse.cz,
	svetly.todorov@memverge.com,
	ran.xiaokai@zte.com.cn,
	ryan.roberts@arm.com,
	ziy@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] kpageflags: detect isolated KPF_THP folios
Date: Fri,  5 Jul 2024 10:43:43 +0000
Message-Id: <20240705104343.112680-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v2hjzodm7nZVAQ--.39915S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw18KFW5GrW8Kr4xXw4fXwb_yoW5Ary5pa
	98Ga42vr4kJ3ZxJry8JrnFyr1YkrZxWFWjka4akw1SvFnxZryvgF1xK34Fka4aqFyxAay0
	vFWqgF1fua4jyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6q2_UUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiMwYTTGXAmSSQlQAAs3

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

When folio is isolated, the PG_lru bit is cleared. So the PG_lru
check in stable_page_flags() will miss this kind of isolated folios.
Use folio_test_large_rmappable() instead to also include isolated folios.

Since pagecache supports large folios and the introduction of mTHP,
the semantics of KPF_THP have been expanded, now it indicates
not only PMD-sized THP. Update related documentation to clearly state
that KPF_THP indicates multiple order THPs.

v1:
  https://lore.kernel.org/lkml/20240626024924.1155558-3-ranxiaokai627@163.com/
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 Documentation/admin-guide/mm/pagemap.rst |  4 ++--
 fs/proc/page.c                           | 21 +++++++++------------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index f5f065c67615..0a8a4decdb72 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -118,7 +118,7 @@ Short descriptions to the page flags
 21 - KSM
     Identical memory pages dynamically shared between one or more processes.
 22 - THP
-    Contiguous pages which construct transparent hugepages.
+    Contiguous pages which construct THP of any size and mapped by any granularity.
 23 - OFFLINE
     The page is logically offline.
 24 - ZERO_PAGE
@@ -252,7 +252,7 @@ Following flags about pages are currently supported:
 - ``PAGE_IS_PRESENT`` - Page is present in the memory
 - ``PAGE_IS_SWAPPED`` - Page is in swapped
 - ``PAGE_IS_PFNZERO`` - Page has zero PFN
-- ``PAGE_IS_HUGE`` - Page is THP or Hugetlb backed
+- ``PAGE_IS_HUGE`` - Page is PMD-mapped THP or Hugetlb backed
 - ``PAGE_IS_SOFT_DIRTY`` - Page is soft-dirty
 
 The ``struct pm_scan_arg`` is used as the argument of the IOCTL.
diff --git a/fs/proc/page.c b/fs/proc/page.c
index 2fb64bdb64eb..76f2a412aa93 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -148,19 +148,16 @@ u64 stable_page_flags(const struct page *page)
 		u |= 1 << KPF_COMPOUND_TAIL;
 	if (folio_test_hugetlb(folio))
 		u |= 1 << KPF_HUGE;
-	/*
-	 * We need to check PageLRU/PageAnon
-	 * to make sure a given page is a thp, not a non-huge compound page.
-	 */
-	else if (folio_test_large(folio)) {
-		if ((k & (1 << PG_lru)) || is_anon)
-			u |= 1 << KPF_THP;
-		else if (is_huge_zero_folio(folio)) {
-			u |= 1 << KPF_ZERO_PAGE;
-			u |= 1 << KPF_THP;
-		}
-	} else if (is_zero_pfn(page_to_pfn(page)))
+	else if (folio_test_large(folio) &&
+	         folio_test_large_rmappable(folio)) {
+		/* Note: we indicate any THPs here, not just PMD-sized ones */
+		u |= 1 << KPF_THP;
+	} else if (is_huge_zero_folio(folio)) {
 		u |= 1 << KPF_ZERO_PAGE;
+		u |= 1 << KPF_THP;
+	} else if (is_zero_pfn(page_to_pfn(page))) {
+		u |= 1 << KPF_ZERO_PAGE;
+	}
 
 	/*
 	 * Caveats on high order pages: PG_buddy and PG_slab will only be set
-- 
2.15.2



