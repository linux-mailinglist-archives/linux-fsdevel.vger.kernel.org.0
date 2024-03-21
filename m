Return-Path: <linux-fsdevel+bounces-14935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148B8881B7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 04:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329231C21561
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 03:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA58BE47;
	Thu, 21 Mar 2024 03:28:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D5A79E1
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 03:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710991736; cv=none; b=C46zTm2kXb5IoTBGG6O80EhcU7/9lhAm1mf7CehjEOG5R49EDT48uZsw5pQlbeexBNLbQ05JLHMG5ZOTBH8l04PciKPFP+/8KKlU7ljvGKMsd3ir1YeizFSuaOAN9ssOB6l/rjqSpRloBht65pEMfqaeUXEbh7amB8LIgPDnl7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710991736; c=relaxed/simple;
	bh=ISH9wAZPnU+1Is9tJGTWxzb+PKLeQYNPAz+moZGVp1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RmQSqXQ6kwkvQuG+7L1uWq5/Kf3176BxZMa/AcNHFh82uybDIVxMz719KbUHx8MK5PSHQxPE8E5FyrefwEuakV+VmM6/7G3EEEo0J+catYnlKo6zhIUR+tJ/+70F4szVSWFstQOLpq2ogTW6nrOjtNdTxQkNf/jRef/wxNzLxtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V0W8W07vkztQWk;
	Thu, 21 Mar 2024 11:26:35 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 22A3714011F;
	Thu, 21 Mar 2024 11:28:52 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 11:28:51 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	Zi Yan <ziy@nvidia.com>, Jiaqi Yan <jiaqiyan@google.com>, Hugh Dickins
	<hughd@google.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v1 06/11] mm: migrate: split folio_migrate_mapping()
Date: Thu, 21 Mar 2024 11:27:42 +0800
Message-ID: <20240321032747.87694-7-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240321032747.87694-1-wangkefeng.wang@huawei.com>
References: <20240321032747.87694-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
index 669c6c2a1868..59c7d66aacba 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -393,50 +393,49 @@ static int folio_expected_refs(struct address_space *mapping,
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
@@ -452,7 +451,7 @@ int folio_migrate_mapping(struct address_space *mapping,
 		entries = 1;
 	}
 
-	/* Move dirty while page refs frozen and newpage not yet exposed */
+	/* Move dirty while folio refs frozen and newfolio not yet exposed */
 	dirty = folio_test_dirty(folio);
 	if (dirty) {
 		folio_clear_dirty(folio);
@@ -466,22 +465,22 @@ int folio_migrate_mapping(struct address_space *mapping,
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
@@ -518,7 +517,18 @@ int folio_migrate_mapping(struct address_space *mapping,
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


