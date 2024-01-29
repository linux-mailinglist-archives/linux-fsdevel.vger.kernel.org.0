Return-Path: <linux-fsdevel+bounces-9306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F4483FEE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 08:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FEF8285537
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 07:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05D64F1ED;
	Mon, 29 Jan 2024 07:09:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A174D5BC
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 07:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706512192; cv=none; b=CPoa+dsljkzYjBOn1ErE6TRrFnuOrGa8R+RAIIAKcu1lM7R6g3EdhEnYjkrBZGpc6F2uPr9KskK4iTdvfg9ekjre1V5x8+zWXnf6tY8w9NvgkuPi3STJT2vYZIe76AoBV4G1Ae0DFOQhSblgZhsPVaTr8CO5QnIDr4Ef9C5eiM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706512192; c=relaxed/simple;
	bh=S8COkUAX4yp2X4nwG3hiWpYBmc9Kpk11az7+/gTVf5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAya7eX8RmN59t/zNNX9bLOjNbmsILv6I5Oad846kVQhROHvZ5G3ulCe0OKFK4Vdffffvhpt8yjwY/VHXdFHOS19OufuxPNAzgu8bD5WUrMGWwMAmMK6LfIelZTtD4mQzDtqyuz57iqAjzKT4Zg990gPgkxbSX0k9J+UNeDPYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TNfXB0VdCzvTXb;
	Mon, 29 Jan 2024 15:08:10 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 80BAD18005E;
	Mon, 29 Jan 2024 15:09:47 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 15:09:46 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfc 2/9] mm: migrate_device: use more folio in __migrate_device_pages()
Date: Mon, 29 Jan 2024 15:09:27 +0800
Message-ID: <20240129070934.3717659-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240129070934.3717659-1-wangkefeng.wang@huawei.com>
References: <20240129070934.3717659-1-wangkefeng.wang@huawei.com>
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
save three compound_head() calls.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/migrate_device.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index b6c27c76e1a0..d49a48d87d72 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -694,6 +694,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 		struct page *newpage = migrate_pfn_to_page(dst_pfns[i]);
 		struct page *page = migrate_pfn_to_page(src_pfns[i]);
 		struct address_space *mapping;
+		struct folio *newfolio, *folio;
 		int r;
 
 		if (!newpage) {
@@ -729,13 +730,12 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 		}
 
 		mapping = page_mapping(page);
+		folio = page_folio(page);
+		newfolio = page_folio(newpage);
 
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


