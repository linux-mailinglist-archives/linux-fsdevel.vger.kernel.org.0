Return-Path: <linux-fsdevel+bounces-22481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AB7917B4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 10:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E72E285A08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 08:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D453016B381;
	Wed, 26 Jun 2024 08:48:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81591684A3;
	Wed, 26 Jun 2024 08:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391723; cv=none; b=F+NJREnm5JuOnXxmWNlRHeUCJH/5GrD0OOAbg/0rngw+Q13Nz7AM1mxWxH82sKkKvVGTMsFIiduVytiEc4pNATDgJ+0fgr66mzYWjSSBMuEXOYhVaLr2IqOieNcd5kLpIos98y7yE5deDAUd2X2Iw3h+xe4psTW83VWWa9rvq+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391723; c=relaxed/simple;
	bh=gVe3FZNSeWFXzNdM+NW+WvLJ4x0CtX/MXlsGAlIPRtY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a8gJ//obDt3GPROx0XkyAqKHdH56HCP7Ic7dWW5AMVljmQosPOrQYDC9KKvvBGmIWL1jJ0NKwb0jNbGy8XACkTqx2zun8Rc4ZHqt6DxE54V4ZV/up5KRmiEPw5/xXFbzJbxHQmXx/S7uocTz4Byl+iau1+kvJe+GUWDWJU8Xqjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 45Q8iCJx045005;
	Wed, 26 Jun 2024 16:44:12 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4W8FVp1GfDz2K8nj0;
	Wed, 26 Jun 2024 16:39:30 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 26 Jun 2024 16:44:10 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand
	<david@redhat.com>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [RFC PATCH] mm: introduce gen information in /proc/xxx/smaps
Date: Wed, 26 Jun 2024 16:44:06 +0800
Message-ID: <20240626084406.2106291-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 45Q8iCJx045005

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Madvise_cold_and_pageout could break the LRU's balance by
colding or moving the folio without taking activity information into
consideration. This commit would like to introduce the folios' gen
information based on VMA block via which the userspace could query
the VA's activity before madvise.

eg. The VMA(56c00000-56e14000) which has big Rss/Gen value suggest that
it possesses larger proportion active folios than VMA(70dd7000-71090000)
does and is not good candidate for madvise.

56c00000-56e14000 rw-p 00000000 00:00 0                                  [anon:dalvik-/system/framework/oat/arm64/services.art]
Size:               2128 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                2128 kB
Pss:                2128 kB
Pss_Dirty:          2128 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:      2128 kB
Referenced:         2128 kB
Anonymous:          2128 kB
KSM:                   0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
FilePmdMapped:         0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
Gen:                 664
THPeligible:           0
VmFlags: rd wr mr mw me ac
70dd7000-71090000 rw-p 00000000 00:00 0                                  [anon:dalvik-/system/framework/boot.art]
Size:               2788 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                2788 kB
Pss:                 275 kB
Pss_Dirty:           275 kB
Shared_Clean:          0 kB
Shared_Dirty:       2584 kB
Private_Clean:         0 kB
Private_Dirty:       204 kB
Referenced:         2716 kB
Anonymous:          2788 kB
KSM:                   0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
FilePmdMapped:         0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
Gen:                1394
THPeligible:           0

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 fs/proc/task_mmu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f8d35f993fe5..9731f43aa639 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -408,12 +408,23 @@ struct mem_size_stats {
 	u64 pss_dirty;
 	u64 pss_locked;
 	u64 swap_pss;
+#ifdef CONFIG_LRU_GEN
+	u64 gen;
+#endif
 };
 
 static void smaps_page_accumulate(struct mem_size_stats *mss,
 		struct folio *folio, unsigned long size, unsigned long pss,
 		bool dirty, bool locked, bool private)
 {
+#ifdef CONFIG_LRU_GEN
+	int gen = folio_lru_gen(folio);
+	struct lru_gen_folio *lrugen = &folio_lruvec(folio)->lrugen;
+
+	if (gen >= 0)
+		mss->gen += (lru_gen_from_seq(lrugen->max_seq) - gen + MAX_NR_GENS) % MAX_NR_GENS;
+#endif
+
 	mss->pss += pss;
 
 	if (folio_test_anon(folio))
@@ -852,6 +863,10 @@ static void __show_smap(struct seq_file *m, const struct mem_size_stats *mss,
 	SEQ_PUT_DEC(" kB\nLocked:         ",
 					mss->pss_locked >> PSS_SHIFT);
 	seq_puts(m, " kB\n");
+#ifdef CONFIG_LRU_GEN
+	seq_put_decimal_ull_width(m, "Gen:            ",  mss->gen, 8);
+	seq_puts(m, "\n");
+#endif
 }
 
 static int show_smap(struct seq_file *m, void *v)
-- 
2.25.1


