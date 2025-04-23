Return-Path: <linux-fsdevel+bounces-47010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0463A97BF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 03:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD3497A6AC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 01:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFB8257AE8;
	Wed, 23 Apr 2025 01:04:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB75C4086A;
	Wed, 23 Apr 2025 01:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745370256; cv=none; b=Yk1MMOUJQd1nARZWoAhawTxlo2iCXGcQxkQf4TTCfhUR6zsOAXYx3FuF+XmMIDgT9ZlDl1q0TorqZq9Y6OLisWhOusCcNr4BijEAze8G4MYZ7fWpWAec9+km/iCdbewHli+cStzMifzBmlnEwu1dgonTpIabTgpQ/zRLujwMmOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745370256; c=relaxed/simple;
	bh=W3DxN2VaTw1K8QlTyBS2uB6WKXda3G3BaJSemLmTAy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cli3WUPMvI2y5TK2wF716zRSPvpRw1S66Lu1qJQrtxD/9ItzjqW7tfHKX1+DzSU+JFqAh75Z999FUuzAZ4cB3cggjVvHPCvR6XESbSpE7IO45MCVwstwBzlA2ZdO59eqZTp7yglz4EDbtRVwiOo5U71i2FNmeFSHQWULHX9W02Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.207.111.194])
	by gateway (Coremail) with SMTP id _____8Axz3OHPAhoI1nEAA--.62416S3;
	Wed, 23 Apr 2025 09:04:07 +0800 (CST)
Received: from ubuntu.. (unknown [111.207.111.194])
	by front1 (Coremail) with SMTP id qMiowMDxvhuCPAhoP92QAA--.46847S2;
	Wed, 23 Apr 2025 09:04:02 +0800 (CST)
From: Ming Wang <wangming01@loongson.cn>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Michal Hocko <mhocko@suse.cz>,
	David Rientjes <rientjes@google.com>,
	Joern Engel <joern@logfs.org>,
	Hugh Dickins <hughd@google.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
	lixuefeng@loongson.cn,
	Hongchen Zhang <zhanghongchen@loongson.cn>
Subject: [PATCH] smaps: Fix crash in smaps_hugetlb_range for non-present hugetlb entries
Date: Wed, 23 Apr 2025 09:03:59 +0800
Message-ID: <20250423010359.2030576-1-wangming01@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxvhuCPAhoP92QAA--.46847S2
X-CM-SenderInfo: 5zdqwzxlqjiio6or00hjvr0hdfq/1tbiAQEBEmgIG+UBeQAAs1
X-Coremail-Antispam: 1Uk129KBj93XoWxCw4fCF48tF1kAF18Xr4kZrc_yoWrGrW3pF
	9akw4rXr18G34kGws7Jw4jq345Zws3WFW8GFs8Gr4Fk3sxJr9F9FyFgw4aqFy8A3s5G3y2
	9F4jq3sFk3WYy3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUP529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_Jw0_GFylnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij2
	8IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jfTmhUUU
	UU=

When reading /proc/pid/smaps for a process that has mapped a hugetlbfs
file with MAP_PRIVATE, the kernel might crash inside pfn_swap_entry_to_page.
This occurs on LoongArch under specific conditions.

The root cause involves several steps:
1. When the hugetlbfs file is mapped (MAP_PRIVATE), the initial PMD
   (or relevant level) entry is often populated by the kernel during mmap()
   with a non-present entry pointing to the architecture's invalid_pte_table
   On the affected LoongArch system, this address was observed to
   be 0x90000000031e4000.
2. The smaps walker (walk_hugetlb_range -> smaps_hugetlb_range) reads
   this entry.
3. The generic is_swap_pte() macro checks `!pte_present() && !pte_none()`.
   The entry (invalid_pte_table address) is not present. Crucially,
   the generic pte_none() check (`!(pte_val(pte) & ~_PAGE_GLOBAL)`)
   returns false because the invalid_pte_table address is non-zero.
   Therefore, is_swap_pte() incorrectly returns true.
4. The code enters the `else if (is_swap_pte(...))` block.
5. Inside this block, it checks `is_pfn_swap_entry()`. Due to a bit
   pattern coincidence in the invalid_pte_table address on LoongArch,
   the embedded generic `is_migration_entry()` check happens to return
   true (misinterpreting parts of the address as a migration type).
6. This leads to a call to pfn_swap_entry_to_page() with the bogus
   swap entry derived from the invalid table address.
7. pfn_swap_entry_to_page() extracts a meaningless PFN, finds an
   unrelated struct page, checks its lock status (unlocked), and hits
   the `BUG_ON(is_migration_entry(entry) && !PageLocked(p))` assertion.

The original code's intent in the `else if` block seems aimed at handling
potential migration entries, as indicated by the inner `is_pfn_swap_entry()`
check. The issue arises because the outer `is_swap_pte()` check incorrectly
includes the invalid table pointer case on LoongArch.

This patch fixes the issue by changing the condition in
smaps_hugetlb_range() from the broad `is_swap_pte()` to the specific
`is_hugetlb_entry_migration()`.

The `is_hugetlb_entry_migration()` helper function correctly handles this
by first checking `huge_pte_none()`. Architectures like LoongArch can
provide an override for `huge_pte_none()` that specifically recognizes
the `invalid_pte_table` address as a "none" state for HugeTLB entries.
This ensures `is_hugetlb_entry_migration()` returns false for the invalid
entry, preventing the code from entering the faulty block.

This change makes the code reflect the likely original intent (handling
migration) more accurately and leverages architecture-specific helpers
(`huge_pte_none`) to correctly interpret special PTE/PMD values in the
HugeTLB context, fixing the crash on LoongArch without altering the
generic is_swap_pte() behavior.

Fixes: 25ee01a2fca0 ("mm: hugetlb: proc: add hugetlb-related fields to /proc/PID/smaps")
Co-developed-by: Hongchen Zhang <zhanghongchen@loongson.cn>
Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
Signed-off-by: Ming Wang <wangming01@loongson.cn>
---
 fs/proc/task_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 994cde10e3f4..95a0093ae87c 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1027,7 +1027,7 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 	if (pte_present(ptent)) {
 		folio = page_folio(pte_page(ptent));
 		present = true;
-	} else if (is_swap_pte(ptent)) {
+	} else if (is_hugetlb_entry_migration(ptent)) {
 		swp_entry_t swpent = pte_to_swp_entry(ptent);
 
 		if (is_pfn_swap_entry(swpent))
-- 
2.43.0


