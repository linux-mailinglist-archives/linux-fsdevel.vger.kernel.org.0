Return-Path: <linux-fsdevel+bounces-14940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E89F881B85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 04:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1EE91C215AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 03:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C50BA22;
	Thu, 21 Mar 2024 03:29:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AB4E570
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 03:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710991741; cv=none; b=cjeWbW7pO9DFiMUeEv97egQDeccLLtOr5ySxYL7vtDeIvAV/jTYkRkpPCELt6L+JN9R324gCDnxalZnYJuE88X4YUkONTy9Dll6zSnxoeQL4Ea07hYn6WghDbrFAVGX5/VUkVXTD55t/2PB5Qbt4wfTAC8grz27GX75rzfP+i0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710991741; c=relaxed/simple;
	bh=FEGDJwjd889UEvq5pc+FtaHqgb2KeiNkEa6A/TQtpKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NJg3Kru2E3xav7Jj62Lq+KKu5apa3xvz2JPyTJ2X9u0vBYxfM2HmMMKqoFfs3uNqMTBi4ZoEdiRWJKJZI8OIAd8WZqJELA7CAtpJ6b7SarhNVXGNN7qIKfO88Zpg3Xcf4XOSdJqN8un8gGhqwaLtAPWtwbiaP5Gusv/Q5B1pzW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4V0W890Dv0z1R7C0;
	Thu, 21 Mar 2024 11:26:17 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 63E381A0172;
	Thu, 21 Mar 2024 11:28:51 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 11:28:50 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	Zi Yan <ziy@nvidia.com>, Jiaqi Yan <jiaqiyan@google.com>, Hugh Dickins
	<hughd@google.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v1 05/11] mm: remove MIGRATE_SYNC_NO_COPY mode
Date: Thu, 21 Mar 2024 11:27:41 +0800
Message-ID: <20240321032747.87694-6-wangkefeng.wang@huawei.com>
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

Commit 2916ecc0f9d4 ("mm/migrate: new migrate mode MIGRATE_SYNC_NO_COPY")
introduce a new MIGRATE_SYNC_NO_COPY mode to allow to offload the copy to
a device DMA engine, which is only used __migrate_device_pages() to decide
whether or not copy the old page, and the MIGRATE_SYNC_NO_COPY mode only
set in hmm, as the MIGRATE_SYNC_NO_COPY set is removed by previous cleanup,
it seems that we could remove the unnecessary MIGRATE_SYNC_NO_COPY.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/aio.c                     | 12 +-----------
 fs/hugetlbfs/inode.c         |  5 +----
 include/linux/migrate_mode.h |  5 -----
 mm/balloon_compaction.c      |  8 --------
 mm/migrate.c                 |  8 +-------
 mm/zsmalloc.c                |  8 --------
 6 files changed, 3 insertions(+), 43 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 9cdaa2faa536..e36849a38f13 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -409,17 +409,7 @@ static int aio_migrate_folio(struct address_space *mapping, struct folio *dst,
 	struct kioctx *ctx;
 	unsigned long flags;
 	pgoff_t idx;
-	int rc;
-
-	/*
-	 * We cannot support the _NO_COPY case here, because copy needs to
-	 * happen under the ctx->completion_lock. That does not work with the
-	 * migration workflow of MIGRATE_SYNC_NO_COPY.
-	 */
-	if (mode == MIGRATE_SYNC_NO_COPY)
-		return -EINVAL;
-
-	rc = 0;
+	int rc = 0;
 
 	/* mapping->i_private_lock here protects against the kioctx teardown.  */
 	spin_lock(&mapping->i_private_lock);
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 6502c7e776d1..d0c496af8d43 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1131,10 +1131,7 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
 		hugetlb_set_folio_subpool(src, NULL);
 	}
 
-	if (mode != MIGRATE_SYNC_NO_COPY)
-		folio_migrate_copy(dst, src);
-	else
-		folio_migrate_flags(dst, src);
+	folio_migrate_copy(dst, src);
 
 	return MIGRATEPAGE_SUCCESS;
 }
diff --git a/include/linux/migrate_mode.h b/include/linux/migrate_mode.h
index f37cc03f9369..9fb482bb7323 100644
--- a/include/linux/migrate_mode.h
+++ b/include/linux/migrate_mode.h
@@ -7,16 +7,11 @@
  *	on most operations but not ->writepage as the potential stall time
  *	is too significant
  * MIGRATE_SYNC will block when migrating pages
- * MIGRATE_SYNC_NO_COPY will block when migrating pages but will not copy pages
- *	with the CPU. Instead, page copy happens outside the migratepage()
- *	callback and is likely using a DMA engine. See migrate_vma() and HMM
- *	(mm/hmm.c) for users of this mode.
  */
 enum migrate_mode {
 	MIGRATE_ASYNC,
 	MIGRATE_SYNC_LIGHT,
 	MIGRATE_SYNC,
-	MIGRATE_SYNC_NO_COPY,
 };
 
 enum migrate_reason {
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 22c96fed70b5..6597ebea8ae2 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -234,14 +234,6 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
 {
 	struct balloon_dev_info *balloon = balloon_page_device(page);
 
-	/*
-	 * We can not easily support the no copy case here so ignore it as it
-	 * is unlikely to be used with balloon pages. See include/linux/hmm.h
-	 * for a user of the MIGRATE_SYNC_NO_COPY mode.
-	 */
-	if (mode == MIGRATE_SYNC_NO_COPY)
-		return -EINVAL;
-
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
 
diff --git a/mm/migrate.c b/mm/migrate.c
index c006b0b44013..669c6c2a1868 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -671,10 +671,7 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
 	if (src_private)
 		folio_attach_private(dst, folio_detach_private(src));
 
-	if (mode != MIGRATE_SYNC_NO_COPY)
-		folio_migrate_copy(dst, src);
-	else
-		folio_migrate_flags(dst, src);
+	folio_migrate_copy(dst, src);
 	return MIGRATEPAGE_SUCCESS;
 }
 
@@ -903,7 +900,6 @@ static int fallback_migrate_folio(struct address_space *mapping,
 		/* Only writeback folios in full synchronous migration */
 		switch (mode) {
 		case MIGRATE_SYNC:
-		case MIGRATE_SYNC_NO_COPY:
 			break;
 		default:
 			return -EBUSY;
@@ -1161,7 +1157,6 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		 */
 		switch (mode) {
 		case MIGRATE_SYNC:
-		case MIGRATE_SYNC_NO_COPY:
 			break;
 		default:
 			rc = -EBUSY;
@@ -1372,7 +1367,6 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 			goto out;
 		switch (mode) {
 		case MIGRATE_SYNC:
-		case MIGRATE_SYNC_NO_COPY:
 			break;
 		default:
 			goto out;
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7d7cb3eaabe0..4467cdb1f565 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1752,14 +1752,6 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	unsigned long old_obj, new_obj;
 	unsigned int obj_idx;
 
-	/*
-	 * We cannot support the _NO_COPY case here, because copy needs to
-	 * happen under the zs lock, which does not work with
-	 * MIGRATE_SYNC_NO_COPY workflow.
-	 */
-	if (mode == MIGRATE_SYNC_NO_COPY)
-		return -EINVAL;
-
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
 
 	/* The page is locked, so this pointer must remain valid */
-- 
2.27.0


