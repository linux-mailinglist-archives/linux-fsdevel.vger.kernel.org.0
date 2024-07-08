Return-Path: <linux-fsdevel+bounces-23268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB381929C28
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 08:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E321C2139B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 06:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABC717545;
	Mon,  8 Jul 2024 06:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nfZCbNCa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A18014A96;
	Mon,  8 Jul 2024 06:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420073; cv=none; b=P/dsjxWlxOA4MtMunbqzzjGiVox/dYw66s6yIqvGyuLD+EWmL1xf0gk+nMi+vVuUrbrgx4hzhMY9nyWg46tcEs/QuKAumvK8HeX7+7PfSgvkDaruYzSoJRmXENegPaFlA+CSxSyGC6reN4+s2nTUQd7f7ktvKpQDl3HBAtC9kD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420073; c=relaxed/simple;
	bh=zUZXGOv2xUoJrPD1neMWOjpl2CBT0LIydrty+iTwh10=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SguzebCi3HQU++m3wQR1ZYy/GbLAzQI1vWgzBXDjOro8lI4oOLtI10E6L99+okqD5B54PlITfbwlYPe2pv1EUlEnBaF78JXUI4DF9JQFnQ5WRtv9wpoOQj9Exr4uCnRzCfWk+BSscDrnsNlHmCvfPhlGn3tuMIjfRaCK2JBnzVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nfZCbNCa; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=upyb9
	37w393WAml9P6J+oTFNrAbx52a2d5ij2dreU80=; b=nfZCbNCa4H7AdMPv7hY7B
	L9r4HrgedrZUogKfP71wz79mkP462VsGZXGP9EHsmoonmnCpL7PmKQAuQuAvh/Ve
	+Usli8W12WC1ynDqALgzgG74Oh3z23RvZOE1kHyu+Zlx67dqC6ahRBd5sAqRoSar
	fwSgXMFiw3usn67/uERigg=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wDHr1h7hotm9x0lCA--.18455S4;
	Mon, 08 Jul 2024 14:26:09 +0800 (CST)
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
	si.hao@zte.com.cn,
	yang.yang29@zte.com.cn,
	ryan.roberts@arm.com,
	ziy@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3] kpageflags: detect isolated KPF_THP folios
Date: Mon,  8 Jul 2024 06:26:01 +0000
Message-Id: <20240708062601.165215-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHr1h7hotm9x0lCA--.18455S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw18KFW5GrW8Kr4xXw4fXwb_yoW5ArW7pa
	98GasFvF4kJ3ZxJryxJrn2yr13KrZxWayjka4akw1SvFnxJ34vgF1xK34Fka4aqFy8Aa10
	vFWjgF1fua4UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UCYLPUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiqRATTGVOBTu8eQABs3

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

When folio is isolated, the PG_lru bit is cleared. So the PG_lru
check in stable_page_flags() will miss this kind of isolated folios.
Use folio_test_large_rmappable() instead to also include isolated folios.

Since pagecache supports large folios and the introduction of mTHP,
the semantics of KPF_THP have been expanded, now it indicates
not only PMD-sized THP. Update related documentation to clearly state
that KPF_THP indicates multiple order THPs.

Changes since v2:
  - directly use is_zero_folio() suggested by David

Acked-by: David Hildenbrand <david@redhat.com>
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
index 2fb64bdb64eb..a718ddc43bdf 100644
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
+	} else if (is_zero_folio(folio)) {
+		u |= 1 << KPF_ZERO_PAGE;
+	}
 
 	/*
 	 * Caveats on high order pages: PG_buddy and PG_slab will only be set
-- 
2.15.2



