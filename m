Return-Path: <linux-fsdevel+bounces-22464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBF891765E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 04:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10983B22BCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 02:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDD43AC16;
	Wed, 26 Jun 2024 02:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PPGQD/Es"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1A714A81;
	Wed, 26 Jun 2024 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719370256; cv=none; b=nmiRB6XwppP0hy1nyOQ2bBSh2jiU7vsgbEBhQsI64/+gz4rNREr7NSfkkyR/OYTJUf5A35b19LSKthJ+T6hYaj3cFeaQF6+salqc5r8RPSKmY4MMUpZwFGCGqzN/xsUtFCXPXmQt4SdjJGOUnuFKxFCQbw6j+rUGQv9btfNMYo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719370256; c=relaxed/simple;
	bh=I+Mmm7O8zWsVG9k4of9tiyj3aKGe9eU+KFhKPGSFyKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r3fSpNCNqMEUcww/oQnOyTvoiCYTXyI+lJxypahmLgYYtoed0kPYN4TNVImTiF0Le8LeOkl3TvWDOy080f+7ZWWuwLpEivab22lHi1+gOktgsjPhVHO/jNPFp2xmA4iyzXzqMTRrKu7/mkxlVOnBZv73jEbAoMr4g1I1H7pVz9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PPGQD/Es; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=fFFOK
	vSRi6Ay443e2K7KzltG1+t1YPDbN1yuinD8/Nk=; b=PPGQD/EsvA0Z+MY/IMniF
	hOPxc8wWMMMHDa1tpDilBGc8lUHnN+ZQgh+p1olSHX5AWzda45w/5lHbj5Y3A23j
	lxuG58iieCXnxglAAMSH+RmrMgEGGtaRkeuC4XigpkPdAEoTJIMpbQ76emlCqK2R
	RYnLsm1NJHgsMugixX8wsk=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wDXT0W6gXtm8PInAg--.40265S6;
	Wed, 26 Jun 2024 10:49:38 +0800 (CST)
From: ran xiaokai <ranxiaokai627@163.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: vbabka@suse.cz,
	svetly.todorov@memverge.com,
	ran.xiaokai@zte.com.cn,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	peterx@redhat.com,
	ziy@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable compound pages
Date: Wed, 26 Jun 2024 02:49:24 +0000
Message-Id: <20240626024924.1155558-3-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240626024924.1155558-1-ranxiaokai627@163.com>
References: <20240626024924.1155558-1-ranxiaokai627@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXT0W6gXtm8PInAg--.40265S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF4rKrW3uF43urykAryxKrg_yoW8WFykpr
	Z3GF9rArWkW3Z8Ar18Xw1qkry8Kr98WF4Utayakw1Iv3ZxXwnrKFW8tw4FyFy7XFyxAan2
	vayDuF13Za4DuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UMuWJUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiMwQKTGXAmE8lKgABsN

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

KPF_COMPOUND_HEAD and KPF_COMPOUND_TAIL are set on "common" compound
pages, which means of any order, but KPF_THP should only be set
when the folio is a 2M pmd mappable THP. Since commit 19eaf44954df
("mm: thp: support allocation of anonymous multi-size THP"),
multiple orders of folios can be allocated and mapped to userspace,
so the folio_test_large() check is not sufficient here,
replace it with folio_test_pmd_mappable() to fix this.

Also kpageflags is not only for userspace memory but for all valid pfn
pages,including slab pages or drivers used pages, so the PG_lru and
is_anon check are unnecessary here.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 fs/proc/page.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 2fb64bdb64eb..3e7b70449c2f 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -146,19 +146,13 @@ u64 stable_page_flags(const struct page *page)
 		u |= kpf_copy_bit(k, KPF_COMPOUND_HEAD, PG_head);
 	else
 		u |= 1 << KPF_COMPOUND_TAIL;
+
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
+	else if (folio_test_pmd_mappable(folio)) {
+		u |= 1 << KPF_THP;
+		if (is_huge_zero_folio(folio))
 			u |= 1 << KPF_ZERO_PAGE;
-			u |= 1 << KPF_THP;
-		}
 	} else if (is_zero_pfn(page_to_pfn(page)))
 		u |= 1 << KPF_ZERO_PAGE;
 
-- 
2.15.2



