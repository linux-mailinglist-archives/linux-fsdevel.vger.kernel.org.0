Return-Path: <linux-fsdevel+bounces-17634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79BF8B0BBB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 15:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8CA51C227B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 13:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2EA15DBC1;
	Wed, 24 Apr 2024 13:59:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC0A15CD6F
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967180; cv=none; b=ElZ3FHE5B3sxQsG6DYYJKPaiQjib0yB5zJwk13Uim2C1FzNtuQ358MfS+DvSAevh5C8wZxleDipce6CnfKOWK73iy+q9oC0niJiWQeWBCHMM8Q/eEZjGlhnfZSeTc9fgVhL2N0Q+0N1cVB5f2/NhbpUd24Gp0LJlzkq/vZcgkzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967180; c=relaxed/simple;
	bh=HuDQWv0KsbWgmwFbdMShqmM9Vv5suRhpKApIK9zBXIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KuzcUUIjBbzWsVpOAXH//vxwWqzUnBLpnyv7bUw8Qdd26tNQNxpE8PCTHraCXXYjKRnbjD4vGyADIGJaojWbA1wjIgOUwBalDRnaEoGZe+zQvVZvmerCTtBfqlNMSZU24DcgRpsVavEX70vCdtdV0J8+iooQUe8LoB6NHUNxzWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VPgYz1RCnzShcs;
	Wed, 24 Apr 2024 21:58:31 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id CFF1F18006B;
	Wed, 24 Apr 2024 21:59:35 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 21:59:35 +0800
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
Subject: [PATCH v2 03/10] mm: migrate_device: unify migrate folio for MIGRATE_SYNC_NO_COPY
Date: Wed, 24 Apr 2024 21:59:22 +0800
Message-ID: <20240424135929.2847185-4-wangkefeng.wang@huawei.com>
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

The __migrate_device_pages() won't copy page so MIGRATE_SYNC_NO_COPY
passed into migrate_folio()/migrate_folio_extra(), actually a easy
way is just to call folio_migrate_mapping()/folio_migrate_flags(),
converting it to unify and simplify the migrate device pages, which
also remove the only call for MIGRATE_SYNC_NO_COPY.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/migrate_device.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 1b6658519f64..5c0237b7f26b 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -691,7 +691,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 		struct page *page = migrate_pfn_to_page(src_pfns[i]);
 		struct address_space *mapping;
 		struct folio *newfolio, *folio;
-		int r;
+		int r, extra_cnt = 0;
 
 		if (!newpage) {
 			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
@@ -753,14 +753,15 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 			continue;
 		}
 
+		BUG_ON(folio_test_writeback(folio));
+
 		if (migrate && migrate->fault_page == page)
-			r = migrate_folio_extra(mapping, newfolio, folio,
-						MIGRATE_SYNC_NO_COPY, 1);
-		else
-			r = migrate_folio(mapping, newfolio, folio,
-					  MIGRATE_SYNC_NO_COPY);
+			extra_cnt = 1;
+		r = folio_migrate_mapping(mapping, newfolio, folio, extra_cnt);
 		if (r != MIGRATEPAGE_SUCCESS)
 			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
+		else
+			folio_migrate_flags(newfolio, folio);
 	}
 
 	if (notified)
-- 
2.27.0


