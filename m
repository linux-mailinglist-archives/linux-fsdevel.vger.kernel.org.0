Return-Path: <linux-fsdevel+bounces-48693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CA0AB2FCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 08:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25BA11687BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 06:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9295255F4F;
	Mon, 12 May 2025 06:39:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8667228F3;
	Mon, 12 May 2025 06:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747031998; cv=none; b=pAOoU4wxms8qiS/SqaUvh0hwRzOMY6rKIxZUSYdDvO3nm8004ox582pS5Kk2wStjfgSjo4+80Hdc1pMXT5Uviksj7Hmin1LFG1eMGbglAODoIApNPCxaK7gZbTvo3CKgVzKA+l2MzXLu1oSOLay7CMTotR+ocQqVFi1RwbE9hMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747031998; c=relaxed/simple;
	bh=tG3i34NXkJj0qQvZ6/E4WhLAPBSDdSQVOh3UElbonBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f2dREMu3FaAWhVBkl85h2nd9pub6RJFHiA9Ek40geOCIJgdyEbSFTAMK1U0hcWvWn/S8KI/dcz1VPe3ne9IvatAlM4A/bDxM/WNjhIgIRXhWZ2WnoUNpraOlFO6N0PCMXMoKKLqG/mgWCFvMVXQwn0VCuJ3/WhSa0/pBmh9+kuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zwqhh4s3Bz4f3jv0;
	Mon, 12 May 2025 14:39:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 295BA1A0DE9;
	Mon, 12 May 2025 14:39:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgAni1+xlyFoYAesMA--.11556S4;
	Mon, 12 May 2025 14:39:51 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	akpm@linux-foundation.org,
	ziy@nvidia.com,
	wangkefeng.wang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH] mm/truncate: fix out-of-bounds when doing a right-aligned split
Date: Mon, 12 May 2025 14:28:25 +0800
Message-ID: <20250512062825.3533342-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAni1+xlyFoYAesMA--.11556S4
X-Coremail-Antispam: 1UD129KBjvJXoWxur1kCrWrurWxZw48ury5XFb_yoWrJFWUp3
	4UKr1DCr4kGr17Gr47ZF45Aw45tasrCFWUAFyxGr17JFn8Xw1DKF18Ka4j93yUJw1kZryx
	Gr1Dta1IgF1UJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUotCzDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When performing a right split on a folio, the split_at2 may point to a
not-present page if the offset + length equals the original folio size,
which will trigger the following error:

 BUG: unable to handle page fault for address: ffffea0006000008
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 143ffb9067 P4D 143ffb9067 PUD 143ffb8067 PMD 0
 Oops: Oops: 0000 [#1] SMP PTI
 CPU: 0 UID: 0 PID: 502640 Comm: fsx Not tainted 6.15.0-rc3-gc6156189fc6b #889 PR
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/4
 RIP: 0010:truncate_inode_partial_folio+0x208/0x620
 Code: ff 03 48 01 da e8 78 7e 13 00 48 83 05 10 b5 5a 0c 01 85 c0 0f 85 1c 02 001
 RSP: 0018:ffffc90005bafab0 EFLAGS: 00010286
 RAX: 0000000000000000 RBX: ffffea0005ffff00 RCX: 0000000000000002
 RDX: 000000000000000c RSI: 0000000000013975 RDI: ffffc90005bafa30
 RBP: ffffea0006000000 R08: 0000000000000000 R09: 00000000000009bf
 R10: 00000000000007e0 R11: 0000000000000000 R12: 0000000000001633
 R13: 0000000000000000 R14: ffffea0005ffff00 R15: fffffffffffffffe
 FS:  00007f9f9a161740(0000) GS:ffff8894971fd000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ffffea0006000008 CR3: 000000017c2ae000 CR4: 00000000000006f0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  truncate_inode_pages_range+0x226/0x720
  truncate_pagecache+0x57/0x90
  ...

Fix this issue by skipping the split if truncation aligns with the folio
size, make sure the split page number lies within the folio.

Fixes: 7460b470a131 ("mm/truncate: use folio_split() in truncate operation")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 mm/truncate.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 5d98054094d1..f2aaf99f2990 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -191,6 +191,7 @@ int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
 bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 {
 	loff_t pos = folio_pos(folio);
+	size_t size = folio_size(folio);
 	unsigned int offset, length;
 	struct page *split_at, *split_at2;
 
@@ -198,14 +199,13 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		offset = start - pos;
 	else
 		offset = 0;
-	length = folio_size(folio);
-	if (pos + length <= (u64)end)
-		length = length - offset;
+	if (pos + size <= (u64)end)
+		length = size - offset;
 	else
 		length = end + 1 - pos - offset;
 
 	folio_wait_writeback(folio);
-	if (length == folio_size(folio)) {
+	if (length == size) {
 		truncate_inode_folio(folio->mapping, folio);
 		return true;
 	}
@@ -224,16 +224,20 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		return true;
 
 	split_at = folio_page(folio, PAGE_ALIGN_DOWN(offset) / PAGE_SIZE);
-	split_at2 = folio_page(folio,
-			PAGE_ALIGN_DOWN(offset + length) / PAGE_SIZE);
-
 	if (!try_folio_split(folio, split_at, NULL)) {
 		/*
 		 * try to split at offset + length to make sure folios within
 		 * the range can be dropped, especially to avoid memory waste
 		 * for shmem truncate
 		 */
-		struct folio *folio2 = page_folio(split_at2);
+		struct folio *folio2;
+
+		if (offset + length == size)
+			goto no_split;
+
+		split_at2 = folio_page(folio,
+				PAGE_ALIGN_DOWN(offset + length) / PAGE_SIZE);
+		folio2 = page_folio(split_at2);
 
 		if (!folio_try_get(folio2))
 			goto no_split;
-- 
2.46.1


