Return-Path: <linux-fsdevel+bounces-9304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9EE83FEE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 08:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8F34B20B84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 07:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359604EB35;
	Mon, 29 Jan 2024 07:09:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5845E4C3D4
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 07:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706512191; cv=none; b=oAO1+tXQegH4N0gBOjkHtPUGOczhPH0V+ajB7qTh7k2Qfz4Xv06AQ4ovcJJBpWOVu1dn0hVDFj7sUzYAQmThAB4U37ZPLbLS1SSBiwFDF1Er+sSXwZUxAMbKm5l3N8/2uQYTuJ9+OPUg+Px7VMaDbxR9G+CxptDUH4JR/1JMhSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706512191; c=relaxed/simple;
	bh=K4j5vV5W8SUNav/bqfyNtctL/KXkyroOru+ZZAhrAU8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mv0aFV8MX6sr+5c+F2r1ux5E1kfemSxJ+2yUwKOmQtzpxQGFhidcPpYlpV5b3BKzhJOvTA90kyX3ETmGrmRI+P9D6MOW+GXAlC+oabqT8qebyqb5N6I6E4oTTV9XNKBqS1dGPAGZrGLuNrYwBj0+uLNWjStsPpS0ermNdrLREPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TNfXj5rQ5z1Q8Xf;
	Mon, 29 Jan 2024 15:08:37 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id D604D140EB7;
	Mon, 29 Jan 2024 15:09:46 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 15:09:46 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfc 1/9] mm: migrate: simplify __buffer_migrate_folio()
Date: Mon, 29 Jan 2024 15:09:26 +0800
Message-ID: <20240129070934.3717659-2-wangkefeng.wang@huawei.com>
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

Use filemap_migrate_folio() helper to simplify __buffer_migrate_folio().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/migrate.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index cc9f2bcd73b4..cdae25b7105f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -774,24 +774,16 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 		}
 	}
 
-	rc = folio_migrate_mapping(mapping, dst, src, 0);
+	rc = filemap_migrate_folio(mapping, dst, src, mode);
 	if (rc != MIGRATEPAGE_SUCCESS)
 		goto unlock_buffers;
 
-	folio_attach_private(dst, folio_detach_private(src));
-
 	bh = head;
 	do {
 		folio_set_bh(bh, dst, bh_offset(bh));
 		bh = bh->b_this_page;
 	} while (bh != head);
 
-	if (mode != MIGRATE_SYNC_NO_COPY)
-		folio_migrate_copy(dst, src);
-	else
-		folio_migrate_flags(dst, src);
-
-	rc = MIGRATEPAGE_SUCCESS;
 unlock_buffers:
 	if (check_refs)
 		spin_unlock(&mapping->i_private_lock);
-- 
2.27.0


