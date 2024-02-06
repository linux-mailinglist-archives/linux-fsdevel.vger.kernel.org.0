Return-Path: <linux-fsdevel+bounces-10446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B3F84B35A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 12:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2326D1C232A6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 11:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A8E12F5A5;
	Tue,  6 Feb 2024 11:21:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BD812EBF0
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218510; cv=none; b=kP28n5aRYg02x1XVlpUTQEA06fq2WCDJTt0LbCah+fWl7o4AYq3qHjFcu/dh8+IlubElwrt5dacwIDSnQev02a9TM/IAidw8Xz1D/Z0Y6xAXIGSjCBuGMw89iDAOza6PZukcur088/yYWDqOES7fxyEYskuTBFn49iU0ifmuGJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218510; c=relaxed/simple;
	bh=VVRpiIX6spEAIhGUwRjcivCyd92PWvZcp4CPAkmtyCk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjGHXi9Ih/lvCfiU9Dxabi0ClwlnTPAz7c2HVmUue/KLpyJ8JULji8DUHA0aW8QVvxVLEBI2Z4TKEXNa+KTT2vVf5/UdVniM/gcuZKi9ZPZ7w/CgK8az5C2J5KYnvrQiA9bKggoG10T/E0lE70pEwVcuRh+NC3rDjqZMoa21Us0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TTgkt69Stz1gyfQ;
	Tue,  6 Feb 2024 19:19:50 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B9D2140412;
	Tue,  6 Feb 2024 19:21:46 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 19:21:45 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfcv2 06/11] mm: migrate: split folio_migrate_mapping()
Date: Tue, 6 Feb 2024 19:21:29 +0800
Message-ID: <20240206112134.1479464-7-wangkefeng.wang@huawei.com>
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

The folio_migrate_mapping() function is splitted into two parts,
folio_refs_check_and_freeze() and folio_replace_mapping_and_unfreeze(),
also update comment from page to folio.

Note, the folio_ref_freeze() is moved out of xas_lock_irq(), since the
folio is already isolated and locked during migration, so suppose that
there is no functional change.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/migrate.c | 74 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 32 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 2dcd0d422056..1db93b5eb819 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -390,50 +390,49 @@ static int folio_expected_refs(struct address_space *mapping,
 }
 
 /*
- * Replace the page in the mapping.
- *
  * The number of remaining references must be:
- * 1 for anonymous pages without a mapping
- * 2 for pages with a mapping
- * 3 for pages with a mapping and PagePrivate/PagePrivate2 set.
+ * 1 for anonymous folios without a mapping
+ * 2 for folios with a mapping
+ * 3 for folios with a mapping and PagePrivate/PagePrivate2 set.
  */
-int folio_migrate_mapping(struct address_space *mapping,
-		struct folio *newfolio, struct folio *folio, int extra_count)
+static int folio_refs_check_and_freeze(struct address_space *mapping,
+				       struct folio *folio, int expected_cnt)
+{
+	if (!mapping) {
+		if (folio_ref_count(folio) != expected_cnt)
+			return -EAGAIN;
+	} else {
+		if (!folio_ref_freeze(folio, expected_cnt))
+			return -EAGAIN;
+	}
+
+	return 0;
+}
+
+/* The folio refcount must be freezed if folio with a mapping */
+static void folio_replace_mapping_and_unfreeze(struct address_space *mapping,
+		struct folio *newfolio, struct folio *folio, int expected_cnt)
 {
 	XA_STATE(xas, &mapping->i_pages, folio_index(folio));
 	struct zone *oldzone, *newzone;
-	int dirty;
-	int expected_count = folio_expected_refs(mapping, folio) + extra_count;
 	long nr = folio_nr_pages(folio);
 	long entries, i;
+	int dirty;
 
 	if (!mapping) {
-		/* Anonymous page without mapping */
-		if (folio_ref_count(folio) != expected_count)
-			return -EAGAIN;
-
-		/* No turning back from here */
+		/* Anonymous folio without mapping */
 		newfolio->index = folio->index;
 		newfolio->mapping = folio->mapping;
 		if (folio_test_swapbacked(folio))
 			__folio_set_swapbacked(newfolio);
-
-		return MIGRATEPAGE_SUCCESS;
+		return;
 	}
 
 	oldzone = folio_zone(folio);
 	newzone = folio_zone(newfolio);
 
+	/* Now we know that no one else is looking at the folio */
 	xas_lock_irq(&xas);
-	if (!folio_ref_freeze(folio, expected_count)) {
-		xas_unlock_irq(&xas);
-		return -EAGAIN;
-	}
-
-	/*
-	 * Now we know that no one else is looking at the folio:
-	 * no turning back from here.
-	 */
 	newfolio->index = folio->index;
 	newfolio->mapping = folio->mapping;
 	folio_ref_add(newfolio, nr); /* add cache reference */
@@ -449,7 +448,7 @@ int folio_migrate_mapping(struct address_space *mapping,
 		entries = 1;
 	}
 
-	/* Move dirty while page refs frozen and newpage not yet exposed */
+	/* Move dirty while folio refs frozen and newfolio not yet exposed */
 	dirty = folio_test_dirty(folio);
 	if (dirty) {
 		folio_clear_dirty(folio);
@@ -463,22 +462,22 @@ int folio_migrate_mapping(struct address_space *mapping,
 	}
 
 	/*
-	 * Drop cache reference from old page by unfreezing
-	 * to one less reference.
+	 * Since old folio's refcount freezed, now drop cache reference from
+	 * old folio by unfreezing to one less reference.
 	 * We know this isn't the last reference.
 	 */
-	folio_ref_unfreeze(folio, expected_count - nr);
+	folio_ref_unfreeze(folio, expected_cnt - nr);
 
 	xas_unlock(&xas);
 	/* Leave irq disabled to prevent preemption while updating stats */
 
 	/*
 	 * If moved to a different zone then also account
-	 * the page for that zone. Other VM counters will be
+	 * the folio for that zone. Other VM counters will be
 	 * taken care of when we establish references to the
-	 * new page and drop references to the old page.
+	 * new folio and drop references to the old folio.
 	 *
-	 * Note that anonymous pages are accounted for
+	 * Note that anonymous folios are accounted for
 	 * via NR_FILE_PAGES and NR_ANON_MAPPED if they
 	 * are mapped to swap space.
 	 */
@@ -515,7 +514,18 @@ int folio_migrate_mapping(struct address_space *mapping,
 		}
 	}
 	local_irq_enable();
+}
+
+int folio_migrate_mapping(struct address_space *mapping, struct folio *newfolio,
+			  struct folio *folio, int extra_count)
+{
+	int ret, expected = folio_expected_refs(mapping, folio) + extra_count;
+
+	ret = folio_refs_check_and_freeze(mapping, folio, expected);
+	if (ret)
+		return ret;
 
+	folio_replace_mapping_and_unfreeze(mapping, newfolio, folio, expected);
 	return MIGRATEPAGE_SUCCESS;
 }
 EXPORT_SYMBOL(folio_migrate_mapping);
-- 
2.27.0


