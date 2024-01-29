Return-Path: <linux-fsdevel+bounces-9311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8439883FEEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 08:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7571F23D16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 07:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C7D53803;
	Mon, 29 Jan 2024 07:09:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1EC4F1F4
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 07:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706512195; cv=none; b=cj+wT3ohL3uE9tduA7QguehJWKuqGIZeEgCaSjBT4osQUTX1s2Vm4uMW0LQknaftlEzWeszBVHDkF7PWbqhWqQk7cLNB/9DSiGSdj+l5cYQYcWCi6swcB4garRc0YavduZYsgVXycQh3xoXLESz8Ey1Sb6xAdvyzgsG1GIuQozQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706512195; c=relaxed/simple;
	bh=m97ZBq0AA6ttca8MItlb8f7ljFZPiZuy8xuicbGrIqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKMN5Gh8BU1HdtgRLR5Fm/ov0b+85P4rnq0lBrjetZ70EJMjM4HiMjeeNcHEImWStZrHukSBsvcwVRvQbaK2zy0gQ8xEGiwZKiClcuaRLa9F1ioSSe/QarglaJn0rQpcMAJsZNmYUlp30qVwMjRsDGW/cYMK7Io8OnT2N6ljQrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TNfXp2JQ8z1Q8Z6;
	Mon, 29 Jan 2024 15:08:42 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C8D518005E;
	Mon, 29 Jan 2024 15:09:51 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 15:09:50 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfc 8/9] mm: migrate: remove folio_migrate_copy()
Date: Mon, 29 Jan 2024 15:09:33 +0800
Message-ID: <20240129070934.3717659-9-wangkefeng.wang@huawei.com>
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

The folio_migrate_copy() is just a wrapper of folio_copy() and
folio_migrate_flags(), it is simple and only aio use it for now,
unfold it and remove folio_migrate_copy().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/aio.c                | 3 ++-
 include/linux/migrate.h | 1 -
 mm/migrate.c            | 7 -------
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 1d0ca2a2776d..631e83eee5a1 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -454,7 +454,8 @@ static int aio_migrate_folio(struct address_space *mapping, struct folio *dst,
 	 * events from being lost.
 	 */
 	spin_lock_irqsave(&ctx->completion_lock, flags);
-	folio_migrate_copy(dst, src);
+	folio_copy(dst, src);
+	folio_migrate_flags(dst, src);
 	BUG_ON(ctx->ring_pages[idx] != &src->page);
 	ctx->ring_pages[idx] = &dst->page;
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index ab387ea66365..13fff8f7832b 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -76,7 +76,6 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
 void migration_entry_wait_on_locked(swp_entry_t entry, spinlock_t *ptl)
 		__releases(ptl);
 void folio_migrate_flags(struct folio *newfolio, struct folio *folio);
-void folio_migrate_copy(struct folio *newfolio, struct folio *folio);
 int folio_migrate_mapping(struct address_space *mapping,
 		struct folio *newfolio, struct folio *folio, int extra_count);
 int folio_expected_refs(struct address_space *mapping, struct folio *folio);
diff --git a/mm/migrate.c b/mm/migrate.c
index 097d67c82f8b..d5c1b1542335 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -643,13 +643,6 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 }
 EXPORT_SYMBOL(folio_migrate_flags);
 
-void folio_migrate_copy(struct folio *newfolio, struct folio *folio)
-{
-	folio_copy(newfolio, folio);
-	folio_migrate_flags(newfolio, folio);
-}
-EXPORT_SYMBOL(folio_migrate_copy);
-
 /************************************************************
  *                    Migration functions
  ***********************************************************/
-- 
2.27.0


