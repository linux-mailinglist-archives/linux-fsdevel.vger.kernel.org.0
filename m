Return-Path: <linux-fsdevel+bounces-14938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D48881B82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 04:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EB1BB21EC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 03:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3E2D510;
	Thu, 21 Mar 2024 03:28:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B14BA22
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 03:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710991738; cv=none; b=md5xp52dM/Hbpdm+zDQmDc7RcZsNWwfU7EUOG6CuIN2EXuUEwD75afsRwpCiIHjosrRxo/ymBah2E9NOutzLzgab37peNMxruqfGO1dYZCVJHbx21y7vqLHBmZ5D4EEBoEHwxMAwQdh2Vk49Em/8IFl8rk4uPImV8AgUDPq8p+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710991738; c=relaxed/simple;
	bh=+xSI33Ctpx/bUH+/mJn3VEE9zcVf/YdBiPv68fRsots=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGqn1AJ6QKbTOgOJxHrzGNVUsGbMu2mwedIiI2WSpAL6fY+PiWO/TAEYopLqf9DQPIycVlTqO3pmUZkxKlVEyd7u9GtiOjmV7YnlBSLzFo1boJB8wneLy4urdeBFjUnPUa811RO/NielF8eZs8J9QLlxUbEu7wZaiyAngNDPqrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4V0WBH50m5z1vxCr;
	Thu, 21 Mar 2024 11:28:07 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 481061400CA;
	Thu, 21 Mar 2024 11:28:54 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 11:28:53 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	Zi Yan <ziy@nvidia.com>, Jiaqi Yan <jiaqiyan@google.com>, Hugh Dickins
	<hughd@google.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v1 09/11] fs: hugetlbfs: support poison recover from hugetlbfs_migrate_folio()
Date: Thu, 21 Mar 2024 11:27:45 +0800
Message-ID: <20240321032747.87694-10-wangkefeng.wang@huawei.com>
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

This is similar to __migrate_folio(), use folio_mc_copy() in HugeTLB
folio migration to avoid panic when copy from poisoned folio.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/hugetlbfs/inode.c |  2 +-
 mm/migrate.c         | 14 +++++++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index d0c496af8d43..e6733f3b6bf1 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1131,7 +1131,7 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
 		hugetlb_set_folio_subpool(src, NULL);
 	}
 
-	folio_migrate_copy(dst, src);
+	folio_migrate_flags(dst, src);
 
 	return MIGRATEPAGE_SUCCESS;
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index a31dd2cfc646..c0e2a26df30b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -541,15 +541,19 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
 				   struct folio *dst, struct folio *src)
 {
 	XA_STATE(xas, &mapping->i_pages, folio_index(src));
-	int expected_count;
+	int rc, expected_count = folio_expected_refs(mapping, src);
 
-	xas_lock_irq(&xas);
-	expected_count = folio_expected_refs(mapping, src);
-	if (!folio_ref_freeze(src, expected_count)) {
-		xas_unlock_irq(&xas);
+	if (!folio_ref_freeze(src, expected_count))
 		return -EAGAIN;
+
+	rc = folio_mc_copy(dst, src);
+	if (rc) {
+		folio_ref_unfreeze(src, expected_count);
+		return rc;
 	}
 
+	xas_lock_irq(&xas);
+
 	dst->index = src->index;
 	dst->mapping = src->mapping;
 
-- 
2.27.0


