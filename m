Return-Path: <linux-fsdevel+bounces-9309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 320C983FEE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 08:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62D1A1C23721
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 07:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F7C4EB41;
	Mon, 29 Jan 2024 07:09:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2524EB4F
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 07:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706512194; cv=none; b=F+zsxqQcQ4eTn9dG41BAGXZM6n6AzHCNxP9L4pM2pWUjVTGQ3lRHlaaQKakVV5rD9QuDfwtQEtraPN6ljAh1nq61kDIBq7yDre4ceqtva8189IWjZQgevBOrINxn8jMc6wSTvRUs0Oc+jarNbRx2qVWzhxn+NDHMUreHwMorQlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706512194; c=relaxed/simple;
	bh=V7M+0Fp1OF8A80wDbqI2JxZrDXw8gZEKK23kxEWwrWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3ZJaOk3ancZsPLmRjuvm44HyuNDzQJ5gJJolYKcHyf3B7Q0CkGLNZow9fLKNkHlbtVVICQA1d/UeZZ7zpkT3riKvUMLco6JgOn4V1XOfQxPFn3FsqxgdNPoOtWhTx1QLyLdBrniUOzp5RedcTTRYj2JhznI4lFCPgr/VDONyxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TNfSz2Kfxz1FJmJ;
	Mon, 29 Jan 2024 15:05:23 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 1734A1400DD;
	Mon, 29 Jan 2024 15:09:50 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 15:09:49 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfc 6/9] mm: migrate: support poisoned recover from migrate folio
Date: Mon, 29 Jan 2024 15:09:31 +0800
Message-ID: <20240129070934.3717659-7-wangkefeng.wang@huawei.com>
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

In order to support poisoned folio copy recover from migrate folio,
let's use folio_mc_copy() and move it in the begin of the function
of __migrate_folio(), which could simply error handling since there
is no turning back if folio_migrate_mapping() return success, the
downside is the folio copied even though folio_migrate_mapping()
return fail, a small optimization is to check whether folio does
not have extra refs before we do more work ahead in __migrate_folio(),
which could help us avoid unnecessary folio copy.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/migrate.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 107965bbc852..99286394b5e5 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -661,6 +661,14 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
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
 	rc = folio_migrate_mapping(mapping, dst, src, 0);
 	if (rc != MIGRATEPAGE_SUCCESS)
 		return rc;
@@ -668,7 +676,7 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
 	if (src_private)
 		folio_attach_private(dst, folio_detach_private(src));
 
-	folio_migrate_copy(dst, src);
+	folio_migrate_flags(dst, src);
 
 	return MIGRATEPAGE_SUCCESS;
 }
-- 
2.27.0


