Return-Path: <linux-fsdevel+bounces-7516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7375982679F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 05:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D60281DBD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 04:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA386AD6;
	Mon,  8 Jan 2024 04:48:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC23522D
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 04:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4T7hQ94ytcz1Q7Dk;
	Mon,  8 Jan 2024 12:48:01 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 1EE9C140384;
	Mon,  8 Jan 2024 12:48:43 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Jan
 2024 12:48:42 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <patchwork@huawei.com>, <willy@infradead.org>, <akpm@linux-foundation.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<ruanjinjie@huawei.com>, <lihongbo22@huawei.com>
Subject: [PATCH -next] mm/filemap: avoid type conversion
Date: Mon, 8 Jan 2024 12:48:15 +0800
Message-ID: <20240108044815.3291487-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)

The return type of function folio_test_hugetlb is bool type, there is no
need to assign it to an integer type.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 750e779c23db..0d7e20edf46f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -843,7 +843,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 		struct folio *folio, pgoff_t index, gfp_t gfp, void **shadowp)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
-	int huge = folio_test_hugetlb(folio);
+	bool huge = folio_test_hugetlb(folio);
 	bool charged = false;
 	long nr = 1;
 
-- 
2.34.1


