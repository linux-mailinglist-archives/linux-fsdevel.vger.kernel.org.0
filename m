Return-Path: <linux-fsdevel+bounces-17642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8588B0BC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 16:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E089E1F270F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 14:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1708F15E809;
	Wed, 24 Apr 2024 13:59:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED5015E210
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967183; cv=none; b=RLIuAduObyOg/uvR5nofowLlhk79wZmNJRjSupQN9yWvb+msie26R2bL2hk6q8XXYqTeG6f7146Ega3egtsxXwn0JNiZCI4U29VIDN4z+Mi97hVfR+We3bXbh7Y0i1fRYIpzyieYm89l8QsDD5KYvAYyEkeWBC/4uvh0YpuRNeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967183; c=relaxed/simple;
	bh=P789ho92uNEUmncRaYTfDOLcjGEobGtCeSNP6Cyu9wY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEaDUp+EEti8EsZIB58Gbx01QPIBlFVR4SBKr4amjWeN9X8HkSmpgkvuvlZ5qsKpne8+tVd5Nu5wjSCnl2Zu2Bhkq0AxKu+gMrQU6kCsufmuKWemizXLcJPbknsEwfzvXboFsGy5nWBEfW8/qCE9sFpTPs+LyH1giowrO266B1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VPgZ25zHVzShMx;
	Wed, 24 Apr 2024 21:58:34 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B3F418006B;
	Wed, 24 Apr 2024 21:59:39 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 21:59:38 +0800
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
Subject: [PATCH v2 08/10] mm: migrate: support poisoned recover from migrate folio
Date: Wed, 24 Apr 2024 21:59:27 +0800
Message-ID: <20240424135929.2847185-9-wangkefeng.wang@huawei.com>
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

The folio migration is widely used in kernel, memory compaction, memory
hotplug, soft offline page, numa balance, memory demote/promotion, etc,
but once access a poisoned source folio when migrating, the kerenl will
panic.

There is a mechanism in the kernel to recover from uncorrectable memory
errors, ARCH_HAS_COPY_MC, which is already used in other core-mm paths,
eg, CoW, khugepaged, coredump, ksm copy, see copy_mc_to_{user,kernel},
copy_mc_{user_}highpage callers.

In order to support poisoned folio copy recover from migrate folio, we
chose to make folio migration tolerant of memory failures and return
error for folio migration, because folio migration is no guarantee
of success, this could avoid the similar panic shown below.

  CPU: 1 PID: 88343 Comm: test_softofflin Kdump: loaded Not tainted 6.6.0
  pc : copy_page+0x10/0xc0
  lr : copy_highpage+0x38/0x50
  ...
  Call trace:
   copy_page+0x10/0xc0
   folio_copy+0x78/0x90
   migrate_folio_extra+0x54/0xa0
   move_to_new_folio+0xd8/0x1f0
   migrate_folio_move+0xb8/0x300
   migrate_pages_batch+0x528/0x788
   migrate_pages_sync+0x8c/0x258
   migrate_pages+0x440/0x528
   soft_offline_in_use_page+0x2ec/0x3c0
   soft_offline_page+0x238/0x310
   soft_offline_page_store+0x6c/0xc0
   dev_attr_store+0x20/0x40
   sysfs_kf_write+0x4c/0x68
   kernfs_fop_write_iter+0x130/0x1c8
   new_sync_write+0xa4/0x138
   vfs_write+0x238/0x2d8
   ksys_write+0x74/0x110

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/migrate.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index b27c66af385d..60d4e29c5186 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -698,16 +698,25 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
 			   struct folio *src, void *src_private,
 			   enum migrate_mode mode)
 {
-	int rc;
+	int rc, expected_cnt = folio_expected_refs(mapping, src);
 
-	rc = folio_migrate_mapping(mapping, dst, src, 0);
-	if (rc != MIGRATEPAGE_SUCCESS)
+	rc = folio_refs_check_and_freeze(mapping, src, expected_cnt);
+	if (rc)
 		return rc;
 
+	rc = folio_mc_copy(dst, src);
+	if (rc) {
+		if (mapping)
+			folio_ref_unfreeze(src, expected_cnt);
+		return rc;
+	}
+
+	folio_replace_mapping_and_unfreeze(mapping, dst, src, expected_cnt);
+
 	if (src_private)
 		folio_attach_private(dst, folio_detach_private(src));
 
-	folio_migrate_copy(dst, src);
+	folio_migrate_flags(dst, src);
 	return MIGRATEPAGE_SUCCESS;
 }
 
-- 
2.27.0


