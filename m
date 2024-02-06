Return-Path: <linux-fsdevel+bounces-10442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D373384B356
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 12:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6F71F22A3D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 11:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4ED512EBF1;
	Tue,  6 Feb 2024 11:21:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761DD12B14E
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218508; cv=none; b=nkU74dZ5qKAyu2VUozUAF1H5NLJ9oNTVgm0FFcyRDIfOwfSCoUq6/kT7WRAEH0+RPke2xNE+NrFKqTZMffLnd6zHVnzYv150p6QEjb/adtce2wCKU08SvTH303tysSCOK/FZF5ozijMgMf5TxxFHCaGAUXK6/ouCtfxaWhJgHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218508; c=relaxed/simple;
	bh=svY+K3CxHpyohwSkLf918SxSZeEhG7+w30nEQPogCnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/xnQb8lGb60R++bB0fmBm9WKggRi9U6m6slVuO24lJRmo0m+bNvzT9h5FcpK4ulbr64pCL+SaObxleS8GMRj6mCVo8S5KQSsp1iKuf4Mb9b99VI0Sr//9/JCjY3it/BxLtDSMHa0hxv5j5NOnuznONO76raCBPdUdeo1MI4z/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TTggm22wyz1FKQL;
	Tue,  6 Feb 2024 19:17:08 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id D97971402C7;
	Tue,  6 Feb 2024 19:21:43 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 19:21:43 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfcv2 02/11] mm: migrate_device: use more folio in __migrate_device_pages()
Date: Tue, 6 Feb 2024 19:21:25 +0800
Message-ID: <20240206112134.1479464-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240206112134.1479464-1-wangkefeng.wang@huawei.com>
References: <20240206112134.1479464-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Use newfolio/folio for migrate_folio_extra()/migrate_folio() to
save four compound_head() calls.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/migrate_device.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index b6c27c76e1a0..ee4d60951670 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -694,6 +694,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 		struct page *newpage = migrate_pfn_to_page(dst_pfns[i]);
 		struct page *page = migrate_pfn_to_page(src_pfns[i]);
 		struct address_space *mapping;
+		struct folio *newfolio, *folio;
 		int r;
 
 		if (!newpage) {
@@ -728,14 +729,13 @@ static void __migrate_device_pages(unsigned long *src_pfns,
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
@@ -749,7 +749,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 					continue;
 				}
 			}
-		} else if (is_zone_device_page(newpage)) {
+		} else if (folio_is_zone_device(newfolio)) {
 			/*
 			 * Other types of ZONE_DEVICE page are not supported.
 			 */
@@ -758,12 +758,11 @@ static void __migrate_device_pages(unsigned long *src_pfns,
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


