Return-Path: <linux-fsdevel+bounces-7778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5099F82A94F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 09:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 916A1B25C80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 08:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E75C10957;
	Thu, 11 Jan 2024 08:45:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89869101FB;
	Thu, 11 Jan 2024 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W-P1z6j_1704962735;
Received: from i85c04085.eu95sqa.tbsite.net(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0W-P1z6j_1704962735)
          by smtp.aliyun-inc.com;
          Thu, 11 Jan 2024 16:45:43 +0800
From: Hui Zhu <teawaterz@linux.alibaba.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	avagin@google.com,
	usama.anjum@collabora.com,
	peterx@redhat.com,
	hughd@google.com,
	ryan.roberts@arm.com,
	wangkefeng.wang@huawei.com,
	Liam.Howlett@Oracle.com,
	adobriyan@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: teawater@gmail.com,
	Hui Zhu <teawater@antgroup.com>
Subject: [PATCH] fs/proc/task_mmu.c: add_to_pagemap: Remove useless parameter addr
Date: Thu, 11 Jan 2024 08:45:33 +0000
Message-Id: <20240111084533.40038-1-teawaterz@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hui Zhu <teawater@antgroup.com>

Function parameters addr of add_to_pagemap is useless.
This commit remove it.

Signed-off-by: Hui Zhu <teawater@antgroup.com>
---
 fs/proc/task_mmu.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 62b16f42d5d2..882e2569fc31 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1352,8 +1352,7 @@ static inline pagemap_entry_t make_pme(u64 frame, u64 flags)
 	return (pagemap_entry_t) { .pme = (frame & PM_PFRAME_MASK) | flags };
 }
 
-static int add_to_pagemap(unsigned long addr, pagemap_entry_t *pme,
-			  struct pagemapread *pm)
+static int add_to_pagemap(pagemap_entry_t *pme, struct pagemapread *pm)
 {
 	pm->buffer[pm->pos++] = *pme;
 	if (pm->pos >= pm->len)
@@ -1380,7 +1379,7 @@ static int pagemap_pte_hole(unsigned long start, unsigned long end,
 			hole_end = end;
 
 		for (; addr < hole_end; addr += PAGE_SIZE) {
-			err = add_to_pagemap(addr, &pme, pm);
+			err = add_to_pagemap(&pme, pm);
 			if (err)
 				goto out;
 		}
@@ -1392,7 +1391,7 @@ static int pagemap_pte_hole(unsigned long start, unsigned long end,
 		if (vma->vm_flags & VM_SOFTDIRTY)
 			pme = make_pme(0, PM_SOFT_DIRTY);
 		for (; addr < min(end, vma->vm_end); addr += PAGE_SIZE) {
-			err = add_to_pagemap(addr, &pme, pm);
+			err = add_to_pagemap(&pme, pm);
 			if (err)
 				goto out;
 		}
@@ -1519,7 +1518,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		for (; addr != end; addr += PAGE_SIZE) {
 			pagemap_entry_t pme = make_pme(frame, flags);
 
-			err = add_to_pagemap(addr, &pme, pm);
+			err = add_to_pagemap(&pme, pm);
 			if (err)
 				break;
 			if (pm->show_pfn) {
@@ -1547,7 +1546,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		pagemap_entry_t pme;
 
 		pme = pte_to_pagemap_entry(pm, vma, addr, ptep_get(pte));
-		err = add_to_pagemap(addr, &pme, pm);
+		err = add_to_pagemap(&pme, pm);
 		if (err)
 			break;
 	}
@@ -1597,7 +1596,7 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 	for (; addr != end; addr += PAGE_SIZE) {
 		pagemap_entry_t pme = make_pme(frame, flags);
 
-		err = add_to_pagemap(addr, &pme, pm);
+		err = add_to_pagemap(&pme, pm);
 		if (err)
 			return err;
 		if (pm->show_pfn && (flags & PM_PRESENT))
-- 
2.19.1.6.gb485710b


