Return-Path: <linux-fsdevel+bounces-9313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1038083FEEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 08:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB8911F22355
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 07:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694CB53E1E;
	Mon, 29 Jan 2024 07:10:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2C053E0A
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706512201; cv=none; b=qRHuXo3bn+hOxNpuLIidXWPSpKV4wDIQYvEeXKlSsO7jgPzrNzVnTBEvHpEbeRFbXht7dTKAVHLKGF0RDPMS4U3EqN9qsQ+Rsjs0ecusOUn1ajVBNEQvA/NK4ioAOndiSSfWnhqVUz7N/fMHr/ZMkiduF2frKkie0OE4ffrEOPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706512201; c=relaxed/simple;
	bh=xvRmbiCe3uFmI2Ro2YnCQcX0/T58SJo8chgd4C8Q/wU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NB+zI/Ms7sb/GdNDb8jwU6PTdUvTo7mvwDrFBwv8I4+KrBE/Wk1TFWbz6UG5ZrIejHJg2rplteKzeY4r/ehTeviwQSu3/8yJRFS2bnjfwzjslVy0jtkngGn5/5bKD+ZGURi7gHRXaZRdP7rvklj8Zq1TwLdwjS5kZpxeFeVmi5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TNfY112ytz1xmk8;
	Mon, 29 Jan 2024 15:08:53 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id C3D1918002F;
	Mon, 29 Jan 2024 15:09:50 +0800 (CST)
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
Subject: [PATCH rfc 7/9] fs: hugetlbfs: support poison recover from hugetlbfs_migrate_folio()
Date: Mon, 29 Jan 2024 15:09:32 +0800
Message-ID: <20240129070934.3717659-8-wangkefeng.wang@huawei.com>
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

This is similar to __migrate_folio(), use folio_mc_copy() to avoid
panic when copy poisoned folio.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/hugetlbfs/inode.c    | 10 +++++++++-
 include/linux/migrate.h |  1 +
 mm/migrate.c            |  3 +--
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 52839ffdd9a1..3871968d1780 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1119,6 +1119,14 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
 {
 	int rc;
 
+	/* Check whether src does not have extra refs before we do more work */
+	if (folio_ref_count(src) != folio_expected_refs(mapping, src))
+		return -EAGAIN;
+
+	rc = folio_mc_copy(dst, src);
+	if (rc)
+		return rc;
+
 	rc = migrate_huge_page_move_mapping(mapping, dst, src);
 	if (rc != MIGRATEPAGE_SUCCESS)
 		return rc;
@@ -1129,7 +1137,7 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
 		hugetlb_set_folio_subpool(src, NULL);
 	}
 
-	folio_migrate_copy(dst, src);
+	folio_migrate_flags(dst, src);
 
 	return MIGRATEPAGE_SUCCESS;
 }
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 517f70b70620..ab387ea66365 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -79,6 +79,7 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio);
 void folio_migrate_copy(struct folio *newfolio, struct folio *folio);
 int folio_migrate_mapping(struct address_space *mapping,
 		struct folio *newfolio, struct folio *folio, int extra_count);
+int folio_expected_refs(struct address_space *mapping, struct folio *folio);
 
 #else
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 99286394b5e5..097d67c82f8b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -375,8 +375,7 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
 }
 #endif
 
-static int folio_expected_refs(struct address_space *mapping,
-		struct folio *folio)
+int folio_expected_refs(struct address_space *mapping, struct folio *folio)
 {
 	int refs = 1;
 	if (!mapping)
-- 
2.27.0


