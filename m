Return-Path: <linux-fsdevel+bounces-10449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A1584B35D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 12:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011671C23069
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 11:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE7B12FF7B;
	Tue,  6 Feb 2024 11:21:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AED012F5AC
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218512; cv=none; b=ffRMCck6cuLFTN4G83U1D5cPQ6jAAHHFDWYd9drBgyeIEhL+6ZboyED78jGnTCcHfh32wWCLsR3qIrOiKDPEhos8YCx590z98n4pQSRIbwQsz/Zg2kt7tKULtrr+9EHj8+Ee3nYg8psgyL+nZo57Vx2R2TEWB7SEJslB72fJGhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218512; c=relaxed/simple;
	bh=Tysrh8IojnJr7/+K0fHZvPpQVeEHj15iTYCABW1rytk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OvU4nfrnMPakK4p8z1FvPmeHp4KCl2vxq9KhrZx7uDxHpLWUJhsoe3XpzxIhX82NZqHuiYotH8qBR3xfmDBJEuWwUMFwUGDiXA8FrbD1GmCD2i25tDLC4oA15C/JL7Naiq7v/yCnDr7epYLVHhRAgPkwRtIocIXgsXTbKyPtOa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TTgkw5npnz1Q8mm;
	Tue,  6 Feb 2024 19:19:52 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id DD363140412;
	Tue,  6 Feb 2024 19:21:48 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 19:21:48 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfcv2 10/11] mm: migrate: remove folio_migrate_copy()
Date: Tue, 6 Feb 2024 19:21:33 +0800
Message-ID: <20240206112134.1479464-11-wangkefeng.wang@huawei.com>
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
index 517f70b70620..f9d92482d117 100644
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
index db189ed8ae06..7a3aa0294031 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -658,13 +658,6 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
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


