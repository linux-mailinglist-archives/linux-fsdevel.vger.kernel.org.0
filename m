Return-Path: <linux-fsdevel+bounces-10444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD5284B358
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 12:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9F11F23C0F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 11:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD1612F395;
	Tue,  6 Feb 2024 11:21:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844D012E1FB
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218509; cv=none; b=YYtsWyU8kHQC+DMpMoEcD2nx5jP/bpiOnRBE/sirRswL3GAOdd7WZ03Ke2ueA7OPj3Pr41XVYL6xExYTrCQfuM36vbxeSYfj8HC9O7XuIXt2vZ7F7lwmnB5MszqvaNZvAL+RbGWfy/IVw1UJ9jdiFx4KMgjWfKPfkn2R0KQMsJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218509; c=relaxed/simple;
	bh=vHSDo7KCx0btHIALBG2VZBAVy2FOXYkJrMaofV4+8TM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrD1XhcRYJpNTtEIPjXuew/hDf7i2LO7dHwe953xWppePyb+hhio/0WR7JrcaPBXA4pxqHO2bOe9DRVlUo6VrLK9CdvPo8OHbIS6t6YM9eCVfihDZ142c9A1K9MEU8oSk01JeSBcQXKnQetB+Jfn9nS3wx76O4+CfjnlX/A/wHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TTgks0LBbz1Q8qq;
	Tue,  6 Feb 2024 19:19:49 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 2334D140412;
	Tue,  6 Feb 2024 19:21:45 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 19:21:44 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfcv2 04/11] mm: migrate: remove migrate_folio_extra()
Date: Tue, 6 Feb 2024 19:21:27 +0800
Message-ID: <20240206112134.1479464-5-wangkefeng.wang@huawei.com>
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
index 2ce13e8a309b..517f70b70620 100644
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
index cdae25b7105f..461badf26eb2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -655,18 +655,19 @@ EXPORT_SYMBOL(folio_migrate_copy);
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
@@ -687,9 +688,10 @@ int migrate_folio_extra(struct address_space *mapping, struct folio *dst,
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
 
@@ -843,20 +845,7 @@ EXPORT_SYMBOL_GPL(buffer_migrate_folio_norefs);
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


