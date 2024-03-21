Return-Path: <linux-fsdevel+bounces-14941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B53881B86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 04:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E50D283BF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 03:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED61A8BF3;
	Thu, 21 Mar 2024 03:29:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC126EADF
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 03:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710991744; cv=none; b=fZ7Pf0k1y922rVMQOMXqgNh6RRo1KoQRrmryaSWNJJGRbr5a07ECGl/2id9ImCiy3IRTWKKYuWzaluoaw8YvrEQUHcOO8smJuolz4Kh66IMK+APdyp/6fQNUvMoLAFsmrTwVrTSB8SzBEFPPAqOsQlyN+LX8LBviCOiPCdYAtuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710991744; c=relaxed/simple;
	bh=EM0DdorH+JzN8J47Em0KbcJV581Iie7J5E3onZdtlqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opXe7k7cjk+KKh+vehzjlmb3xTk+EO8spn17V0e7Tv627K5/LcK8teiEv4buM/n/56gQRLuPgTScpkvc+qKLAmPU1NZz2Ha6VReEXSj9GUnyh4Fl5VSmnF3bZNq/TLHqIQZxg9v/W9LFDEJNxiN4bxG5+FFRNQtBKMYba8KW50k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4V0W8Z226Xz1Q9rf;
	Thu, 21 Mar 2024 11:26:38 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 3911E14011F;
	Thu, 21 Mar 2024 11:28:55 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 11:28:54 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	Zi Yan <ziy@nvidia.com>, Jiaqi Yan <jiaqiyan@google.com>, Hugh Dickins
	<hughd@google.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v1 10/11] mm: migrate: remove folio_migrate_copy()
Date: Thu, 21 Mar 2024 11:27:46 +0800
Message-ID: <20240321032747.87694-11-wangkefeng.wang@huawei.com>
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
index e36849a38f13..9783bb5d81e7 100644
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
index c0e2a26df30b..2228ca681afb 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -661,13 +661,6 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
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


