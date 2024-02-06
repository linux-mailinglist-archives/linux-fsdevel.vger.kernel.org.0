Return-Path: <linux-fsdevel+bounces-10447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4820784B35B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 12:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03FFF2835E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 11:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F58E12FB09;
	Tue,  6 Feb 2024 11:21:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E2A12E1DC
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218511; cv=none; b=EUyy1HNQkzgrPkwvjE6XRZc8t8m44/v+muicJYsOZ+Z2rvXKzusVExFEbkAAa4WJazEk7K0eCJdtDa4xQkXWESm5JDRmMW4zlGBKTJ2G7vv+5pjFQ5ZZcrj17nqYCbBD87+jutWSpZ2FY7QUD/je+CXdj8enMQEahGwUqcjC1W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218511; c=relaxed/simple;
	bh=49LqRDXJsgzok9eugjvOkKuAFHOO6VWVYVRyQJxkaGE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+VzoqArPma4+MgSDEQOFOT1slij3C9lpNRsWgrbsb7WR3QX4bE8o6VrU2klS9O6MJwP/MRIOxURhCb6mUaoRuGiFVMGfoTTaswvRCD80CQ5jy/d6dy5LCTo22ElYvhLFVf9TrPuad9ggkI9gqnBYQd+8O1NwEqjEWSJWHAY3mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TTgkv6Chsz29lQd;
	Tue,  6 Feb 2024 19:19:51 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 9CC921402C7;
	Tue,  6 Feb 2024 19:21:47 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 19:21:46 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfcv2 08/11] mm: migrate: support poisoned recover from migrate folio
Date: Tue, 6 Feb 2024 19:21:31 +0800
Message-ID: <20240206112134.1479464-9-wangkefeng.wang@huawei.com>
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
index 1db93b5eb819..6d99052848b4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -669,16 +669,25 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
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


