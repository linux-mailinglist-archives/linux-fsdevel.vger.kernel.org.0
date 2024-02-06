Return-Path: <linux-fsdevel+bounces-10443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0449184B357
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 12:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 953E61F22469
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 11:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C2912F381;
	Tue,  6 Feb 2024 11:21:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CAA12E1DC
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218509; cv=none; b=tJRBaVFYVqWYWfsuW/dZ4wbj9cCaEDX2CJ2dL8+2KuaxKgVhDbOxuJ2EVdg/juVNjK0kt1YllIu1PLUM3Z8sL1mHOXjea0UVeWOxoG65W5I4wG6u+In7UwZfDEkEMqq5Y0TZ1saL6d8Jh6YFBAmakMgs/mJQkU3ieT+yZVTm+fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218509; c=relaxed/simple;
	bh=WhBZb7//qczCh2vYiih2gcMj/njQrQ1K06NmOsOqifk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HlhToMWpAnIgzZnHEolCPS7hwTQI81X6bJLm7EP6MfPIvyyZgQLa8l1RlO/uXBQhdgyyYjhY7pgBTsL6I4I2WKuw6xQdrJ1wqg4YPvmJfcTiIlFKvSdpHfdquuL6DpNbWtm5INEGHP718GBRZBdHSpjduUlUYGhvFWUA3E1rrXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TTggn0Sn1z1FKSg;
	Tue,  6 Feb 2024 19:17:09 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id A25D41A0172;
	Tue,  6 Feb 2024 19:21:44 +0800 (CST)
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
Subject: [PATCH rfcv2 03/11] mm: migrate_device: unify migrate folio for MIGRATE_SYNC_NO_COPY
Date: Tue, 6 Feb 2024 19:21:26 +0800
Message-ID: <20240206112134.1479464-4-wangkefeng.wang@huawei.com>
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
index ee4d60951670..c0547271eaaa 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -695,7 +695,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 		struct page *page = migrate_pfn_to_page(src_pfns[i]);
 		struct address_space *mapping;
 		struct folio *newfolio, *folio;
-		int r;
+		int r, extra_cnt = 0;
 
 		if (!newpage) {
 			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
@@ -757,14 +757,15 @@ static void __migrate_device_pages(unsigned long *src_pfns,
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


