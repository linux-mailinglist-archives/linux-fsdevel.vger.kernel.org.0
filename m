Return-Path: <linux-fsdevel+bounces-17644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 944F58B0BC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 16:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5129328CE53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 14:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4522015DBB3;
	Wed, 24 Apr 2024 13:59:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1384B15CD7B
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967190; cv=none; b=tICTTfvcwcwUZpImrJj/eNIBX20kaNyvwXKZHlxYngEZG3Adp8H+lyaPU9dGb8VNuguX5fy7Ha69Get4h9TAEZtF0G7v/SwqTczL592pWJ1Q78VIbvvgsVw+AOZkFEEjFr2Vq0Qv3c78wHn0ggbW1LeH6dPtR38nYvvBFvJU59s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967190; c=relaxed/simple;
	bh=3cqbqsVipzL1POu1W/AME+aT9CfHJZyM7TcRZvG9M1A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jw6HfnCM0Mc9ByLIM02Xo885fVAp939m1FF3fR4+tOjEOtpd3cPKfTwVJPBEyPcMCWOFymymcOQKD58SGn0Xjx9nY+WlDoXaF7kkp8acmhFca5KG8eMDuO4pga5G7YWhQsx2OuiYA0ZqQnRH2N2QoK3pGGDrYjosSvQVpNxVNk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VPgZ720KBz1wr57;
	Wed, 24 Apr 2024 21:58:39 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id E92A81403D4;
	Wed, 24 Apr 2024 21:59:40 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 21:59:40 +0800
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
Subject: [PATCH v2 10/10] mm: migrate: remove folio_migrate_copy()
Date: Wed, 24 Apr 2024 21:59:29 +0800
Message-ID: <20240424135929.2847185-11-wangkefeng.wang@huawei.com>
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
index dc7a10f2a6e2..ea7b956fd900 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -455,7 +455,8 @@ static int aio_migrate_folio(struct address_space *mapping, struct folio *dst,
 	 * events from being lost.
 	 */
 	spin_lock_irqsave(&ctx->completion_lock, flags);
-	folio_migrate_copy(dst, src);
+	folio_copy(dst, src);
+	folio_migrate_flags(dst, src);
 	BUG_ON(ctx->ring_folios[idx] != src);
 	ctx->ring_folios[idx] = dst;
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 535d1a5561c4..b9966d4355d0 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -76,7 +76,6 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
 void migration_entry_wait_on_locked(swp_entry_t entry, spinlock_t *ptl)
 		__releases(ptl);
 void folio_migrate_flags(struct folio *newfolio, struct folio *folio);
-void folio_migrate_copy(struct folio *newfolio, struct folio *folio);
 int folio_migrate_mapping(struct address_space *mapping,
 		struct folio *newfolio, struct folio *folio, int extra_count);
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 4493ef57c99f..f393e66813dc 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -687,13 +687,6 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
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


