Return-Path: <linux-fsdevel+bounces-17636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 497238B0BBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 15:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6BF1F26C9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 13:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BE815CD6F;
	Wed, 24 Apr 2024 13:59:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F02915D5A3
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967180; cv=none; b=XP14JqxNlGTDZzQi5NwU9ZHYce9hILPRBE312O/6z0CvdiJ1h2LVcmQ6lXyzWgKzHTkPgGpeh8FyFEECE5tnN+Nj6PToSFo7bIryBGqikqeQEY+ydlm9S5D5UuCxn0DoK6pUaNHBsQI8EDno2cQTlbLj2ZVacRYHNGvDRdE+Z4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967180; c=relaxed/simple;
	bh=Jjb5BkjYXfM5kndYfhpwyXV8RPdgyha5HT8mnlVDEsA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bThYDphFnBzZUkpicJSulTzJJgfP5iMbfzedqKQokQ5htztUp2kiLigyh8H1ey3moyhTfAZFtcbMUyqhWinDlcFY8BENTUx26fa+Z+NXY+aDgCJR/7OgWIgQyxOoa7iirnZbEBXLxoyvh4QRQ2/R36fP6sYw4uskJXjUfG/Gk2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VPgWj2kcpz1R8X0;
	Wed, 24 Apr 2024 21:56:33 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 16E7C18007D;
	Wed, 24 Apr 2024 21:59:35 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 21:59:34 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Miaohe Lin <linmiaohe@huawei.com>, Naoya
 Horiguchi <nao.horiguchi@gmail.com>, Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>, Muchun Song <muchun.song@linux.dev>,
	Benjamin LaHaise <bcrl@kvack.org>, <jglisse@redhat.com>,
	<linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>, Zi Yan
	<ziy@nvidia.com>, Jiaqi Yan <jiaqiyan@google.com>, Hugh Dickins
	<hughd@google.com>, Vishal Moola <vishal.moola@gmail.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH v2 02/10] mm: migrate_device: use more folio in __migrate_device_pages()
Date: Wed, 24 Apr 2024 21:59:21 +0800
Message-ID: <20240424135929.2847185-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240424135929.2847185-1-wangkefeng.wang@huawei.com>
References: <20240424135929.2847185-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Use newfolio/folio for migrate_folio_extra()/migrate_folio() to
save four compound_head() calls.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/migrate_device.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index a1f87aada1bd..1b6658519f64 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -690,6 +690,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 		struct page *newpage = migrate_pfn_to_page(dst_pfns[i]);
 		struct page *page = migrate_pfn_to_page(src_pfns[i]);
 		struct address_space *mapping;
+		struct folio *newfolio, *folio;
 		int r;
 
 		if (!newpage) {
@@ -724,14 +725,13 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 			continue;
 		}
 
-		mapping = page_mapping(page);
+		newfolio = page_folio(newpage);
+		folio = page_folio(page);
+		mapping = folio_mapping(folio);
 
-		if (is_device_private_page(newpage) ||
-		    is_device_coherent_page(newpage)) {
+		if (folio_is_device_private(newfolio) ||
+		    folio_is_device_coherent(newfolio)) {
 			if (mapping) {
-				struct folio *folio;
-
-				folio = page_folio(page);
 
 				/*
 				 * For now only support anonymous memory migrating to
@@ -745,7 +745,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 					continue;
 				}
 			}
-		} else if (is_zone_device_page(newpage)) {
+		} else if (folio_is_zone_device(newfolio)) {
 			/*
 			 * Other types of ZONE_DEVICE page are not supported.
 			 */
@@ -754,12 +754,11 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 		}
 
 		if (migrate && migrate->fault_page == page)
-			r = migrate_folio_extra(mapping, page_folio(newpage),
-						page_folio(page),
+			r = migrate_folio_extra(mapping, newfolio, folio,
 						MIGRATE_SYNC_NO_COPY, 1);
 		else
-			r = migrate_folio(mapping, page_folio(newpage),
-					page_folio(page), MIGRATE_SYNC_NO_COPY);
+			r = migrate_folio(mapping, newfolio, folio,
+					  MIGRATE_SYNC_NO_COPY);
 		if (r != MIGRATEPAGE_SUCCESS)
 			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
 	}
-- 
2.27.0


