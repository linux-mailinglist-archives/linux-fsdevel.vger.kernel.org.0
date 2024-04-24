Return-Path: <linux-fsdevel+bounces-17637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECE48B0BBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 15:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D7628CC53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 13:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E49F15D5A3;
	Wed, 24 Apr 2024 13:59:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC5115D5B1
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967181; cv=none; b=ClnQaA49rBg7oKE6r3iMIfOnNdsFD0g3UbxfRG9X13ILnlBpG2hDHnVeDX9aNjhEz02nwmmHiHCQBvy76IEcB/qNW4pE4BXa6s17K6H7uCMXjfI/DBkf8nEnIsZ7OL7ESAok6snYQuVeXOX9ycYSUFfVwOkcN+ushQx4YMRFKHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967181; c=relaxed/simple;
	bh=Vb5Yeo9UqfEUz2RCAINvwtuPjLrXdDBpzvEyql6zdKY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ERUOPhw+OIG+t5GsPH8HXCayIFuoK0x1sF8l8J5HuAmtg9N66ya5zzRfLMnOX5ML3mVjVhG3MukWEcUrLk6ed7VanLrKJzBW0AtUA63m3MsPRSr+ggpoMNf0lJa4/5c0roMqSD0/yjYULOYMAVJVunt5SrMf/QLVe/HEckIFgsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VPgWY4SdxzwSNk;
	Wed, 24 Apr 2024 21:56:25 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 8AF18140156;
	Wed, 24 Apr 2024 21:59:36 +0800 (CST)
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
Subject: [PATCH v2 04/10] mm: migrate: remove migrate_folio_extra()
Date: Wed, 24 Apr 2024 21:59:23 +0800
Message-ID: <20240424135929.2847185-5-wangkefeng.wang@huawei.com>
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

The migrate_folio_extra() only called in migrate.c now, convert it
a static function and take a new src_private argument which could
be shared by migrate_folio() and filemap_migrate_folio() to simplify
code a bit.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/migrate.h |  2 --
 mm/migrate.c            | 33 +++++++++++----------------------
 2 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 938efa2fd6d7..535d1a5561c4 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -63,8 +63,6 @@ extern const char *migrate_reason_names[MR_TYPES];
 #ifdef CONFIG_MIGRATION
 
 void putback_movable_pages(struct list_head *l);
-int migrate_folio_extra(struct address_space *mapping, struct folio *dst,
-		struct folio *src, enum migrate_mode mode, int extra_count);
 int migrate_folio(struct address_space *mapping, struct folio *dst,
 		struct folio *src, enum migrate_mode mode);
 int migrate_pages(struct list_head *l, new_folio_t new, free_folio_t free,
diff --git a/mm/migrate.c b/mm/migrate.c
index 9cc5a3e1d97c..ce4142ac8565 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -684,18 +684,19 @@ EXPORT_SYMBOL(folio_migrate_copy);
  *                    Migration functions
  ***********************************************************/
 
-int migrate_folio_extra(struct address_space *mapping, struct folio *dst,
-		struct folio *src, enum migrate_mode mode, int extra_count)
+static int __migrate_folio(struct address_space *mapping, struct folio *dst,
+			   struct folio *src, void *src_private,
+			   enum migrate_mode mode)
 {
 	int rc;
 
-	BUG_ON(folio_test_writeback(src));	/* Writeback must be complete */
-
-	rc = folio_migrate_mapping(mapping, dst, src, extra_count);
-
+	rc = folio_migrate_mapping(mapping, dst, src, 0);
 	if (rc != MIGRATEPAGE_SUCCESS)
 		return rc;
 
+	if (src_private)
+		folio_attach_private(dst, folio_detach_private(src));
+
 	if (mode != MIGRATE_SYNC_NO_COPY)
 		folio_migrate_copy(dst, src);
 	else
@@ -716,9 +717,10 @@ int migrate_folio_extra(struct address_space *mapping, struct folio *dst,
  * Folios are locked upon entry and exit.
  */
 int migrate_folio(struct address_space *mapping, struct folio *dst,
-		struct folio *src, enum migrate_mode mode)
+		  struct folio *src, enum migrate_mode mode)
 {
-	return migrate_folio_extra(mapping, dst, src, mode, 0);
+	BUG_ON(folio_test_writeback(src));	/* Writeback must be complete */
+	return __migrate_folio(mapping, dst, src, NULL, mode);
 }
 EXPORT_SYMBOL(migrate_folio);
 
@@ -872,20 +874,7 @@ EXPORT_SYMBOL_GPL(buffer_migrate_folio_norefs);
 int filemap_migrate_folio(struct address_space *mapping,
 		struct folio *dst, struct folio *src, enum migrate_mode mode)
 {
-	int ret;
-
-	ret = folio_migrate_mapping(mapping, dst, src, 0);
-	if (ret != MIGRATEPAGE_SUCCESS)
-		return ret;
-
-	if (folio_get_private(src))
-		folio_attach_private(dst, folio_detach_private(src));
-
-	if (mode != MIGRATE_SYNC_NO_COPY)
-		folio_migrate_copy(dst, src);
-	else
-		folio_migrate_flags(dst, src);
-	return MIGRATEPAGE_SUCCESS;
+	return __migrate_folio(mapping, dst, src, folio_get_private(src), mode);
 }
 EXPORT_SYMBOL_GPL(filemap_migrate_folio);
 
-- 
2.27.0


