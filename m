Return-Path: <linux-fsdevel+bounces-10448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E1B84B35C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 12:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5ED91F22469
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 11:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6273012FB3C;
	Tue,  6 Feb 2024 11:21:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608DF12F580
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218512; cv=none; b=TgyHhHoIlD7RL83a7w0kkymhE3IC6YdtDbVnSw2sySBZFA1qsQ2VRlOjRyZNe9Gx0ys6TSh7LNmd9jk+eEPmKVhOqPPcJPzRSYqJOoRGK+9Mvme2L5CDIcomomyk+LtK4X29QOwpgidW65Spu8Gy+iV9IJ/Y6vdPQlb5k061XqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218512; c=relaxed/simple;
	bh=93skTBsuEIfA6QeTG061hMbvfsFMa8kp9YWjv2Ol4YA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvHp6GtEkwfhpBF8DFXWttTOkVsCGt7waZhwent08GgfdIqc54QeBvD5XAz6K5cPEIXC+Prch+KkRoDsFUU8+s7ZThU8HfRLf2XTX6f0V7nj1pFbDBRzhCkGYDVNMk7pElb0zSD66HzgaL5yf4N2stSuB+T38UGHHr0n36ePS5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TTgkw56FLz1gykT;
	Tue,  6 Feb 2024 19:19:52 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 4690F1A0178;
	Tue,  6 Feb 2024 19:21:48 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 19:21:47 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfcv2 09/11] fs: hugetlbfs: support poison recover from hugetlbfs_migrate_folio()
Date: Tue, 6 Feb 2024 19:21:32 +0800
Message-ID: <20240206112134.1479464-10-wangkefeng.wang@huawei.com>
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

This is similar to __migrate_folio(), use folio_mc_copy() in HugeTLB
folio migration to avoid panic when copy from poisoned folio.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/hugetlbfs/inode.c |  2 +-
 mm/migrate.c         | 14 +++++++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 4f2a423037b6..b4861a69ff34 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1129,7 +1129,7 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
 		hugetlb_set_folio_subpool(src, NULL);
 	}
 
-	folio_migrate_copy(dst, src);
+	folio_migrate_flags(dst, src);
 
 	return MIGRATEPAGE_SUCCESS;
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index 6d99052848b4..db189ed8ae06 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -538,15 +538,19 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
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


