Return-Path: <linux-fsdevel+bounces-1904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E3C7DFF6A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 08:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04AB1C2102E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 07:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F748BE6;
	Fri,  3 Nov 2023 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2327468
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 07:29:15 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB6F1A6;
	Fri,  3 Nov 2023 00:29:13 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SMC6W4d5RzvPrQ;
	Fri,  3 Nov 2023 15:29:07 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 3 Nov 2023 15:29:10 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, Matthew Wilcox <willy@infradead.org>, David Hildenbrand
	<david@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 5/5] page_idle: kill page idle and young wrapper
Date: Fri, 3 Nov 2023 15:29:06 +0800
Message-ID: <20231103072906.2000381-6-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231103072906.2000381-1-wangkefeng.wang@huawei.com>
References: <20231103072906.2000381-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected

Since all the calls of page idle and young functions are gone,
let's remove all the wrapper.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/page_idle.h | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/include/linux/page_idle.h b/include/linux/page_idle.h
index d8f344840643..1168d5f58ff2 100644
--- a/include/linux/page_idle.h
+++ b/include/linux/page_idle.h
@@ -119,29 +119,4 @@ static inline void folio_clear_idle(struct folio *folio)
 }
 
 #endif /* CONFIG_PAGE_IDLE_FLAG */
-
-static inline bool page_is_young(struct page *page)
-{
-	return folio_test_young(page_folio(page));
-}
-
-static inline void set_page_young(struct page *page)
-{
-	folio_set_young(page_folio(page));
-}
-
-static inline bool test_and_clear_page_young(struct page *page)
-{
-	return folio_test_clear_young(page_folio(page));
-}
-
-static inline bool page_is_idle(struct page *page)
-{
-	return folio_test_idle(page_folio(page));
-}
-
-static inline void set_page_idle(struct page *page)
-{
-	folio_set_idle(page_folio(page));
-}
 #endif /* _LINUX_MM_PAGE_IDLE_H */
-- 
2.27.0


