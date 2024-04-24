Return-Path: <linux-fsdevel+bounces-17643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5748B0BC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 16:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BDCF28CE85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 14:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2542815E80F;
	Wed, 24 Apr 2024 13:59:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5527015D5C8
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967183; cv=none; b=uYS6ihXSj0GrNpAYf0I+rgJJDaca3tkbQHl5Q0nE+So+tm/yWn/nn+cAqHJVQ8mernsHeeZYDJWnn8jb7OItx1uiQ426XTpePDHZ1bE0OEKllAgiZPrharP+nAfX2A016aXMsGFfjyi9XKtz1mlId/yEPr6jsNys+xfXXapnUnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967183; c=relaxed/simple;
	bh=0SuPq0SAkD/qjwjuqurAT0sDhQQz1M1HXLL7V58KzZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UoYokejZSSgJKY/bLS2VPONX9ZNl/wTsyco2Y+NHwOpN0wKQ95d7OFsNS4LYLlgoPj+nU6wo+hLxNjZUUF8G7SvPsIhrJ5njGTjf89sRPDAdQSFXtw7Hlpc9qPB9dutx2klIMHwSEZDNDfeBXR44Pr8S0vDaVSE+WAjYR2s9pFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VPgWp2WqqzvPrC;
	Wed, 24 Apr 2024 21:56:38 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 39DE518007B;
	Wed, 24 Apr 2024 21:59:40 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 21:59:39 +0800
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
Subject: [PATCH v2 09/10] fs: hugetlbfs: support poison recover from hugetlbfs_migrate_folio()
Date: Wed, 24 Apr 2024 21:59:28 +0800
Message-ID: <20240424135929.2847185-10-wangkefeng.wang@huawei.com>
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

This is similar to __migrate_folio(), use folio_mc_copy() in HugeTLB
folio migration to avoid panic when copy from poisoned folio.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/hugetlbfs/inode.c |  2 +-
 mm/migrate.c         | 14 +++++++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 6df794ed4066..1107e5aa8343 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1128,7 +1128,7 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
 		hugetlb_set_folio_subpool(src, NULL);
 	}
 
-	folio_migrate_copy(dst, src);
+	folio_migrate_flags(dst, src);
 
 	return MIGRATEPAGE_SUCCESS;
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index 60d4e29c5186..4493ef57c99f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -567,15 +567,19 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
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


