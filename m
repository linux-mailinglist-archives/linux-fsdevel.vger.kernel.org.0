Return-Path: <linux-fsdevel+bounces-69161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2EEC71615
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 23:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DC214E7B3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 22:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D2A33F8C0;
	Wed, 19 Nov 2025 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="2MSEAwWs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E393254BB;
	Wed, 19 Nov 2025 22:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592181; cv=none; b=QMgfjXfxux7IMdLq9SvUO5xJaOze/+H6k858crzqMcEqwBYI8oeXT95XJNwxDVnV15NhxJJ56sUCjz7t6QChxTYKxbTKKwa3FXv6WwdPXN6N6Vq080Qf0vze/tTbshP4Z1sS+ojHUql+IPOdp80he1iO+Fk43NX9Ivl/UfyP7Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592181; c=relaxed/simple;
	bh=S1JWZWHps5oB2+XqOWFcKuBPtA2Qc3WxgVUUxNnDDsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HlzPZb7X7S/6RrOud97NNxHtL3hg0scgeHPpu+CRu/wkTaVSnUWI4pmpeAlhVlvjOEca5194lUZ7tr0xOrglklHA9uLjMr2WZfdpD0JW5t8RFn3zfmlYJ9xdfntLvpahwQ55aU5vDWUyE9JT5YC1J81KP+TYu0ef9Oo1Viqeqz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=2MSEAwWs; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqt5-006yxs-80; Wed, 19 Nov 2025 23:42:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=o+Rdz9XE+xMk74y5kxcFhHgKXAV3hOzijtaYCtjqLa8=; b=2MSEAwWsRWnpmx2KozxLIc3TCp
	fQz+D+xxRjulKigGVoT2f8G/zFfb8Be2OpUl4PIgJjI2gG4p1DAgJabwb2ZJYDjx9uvyuWwAazeuC
	TihdwSi9vFZrMsO5atbzEaAVyo++vo4dyC+FxBToKwAafGMwgpD8StbcMCD5qv1sto7K0bPYYROdR
	2F3iF2wuR3QoPzWzzQh1YEu7Qhbj1+Ce44VCYVWJYvNycekAymvoTihGlp0lsBlG4c4iGH6GYZ9Bs
	fLqCcLMvnOd64VC0SWpdJIgzKyUa7C32ql6Chy6o06dF+6r0HL3jzWp9bqt/T92uQXcSwilM5CYbJ
	oX5wb5dw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqt4-0000EV-IL; Wed, 19 Nov 2025 23:42:54 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLqsn-00Fos6-8l; Wed, 19 Nov 2025 23:42:37 +0100
From: david.laight.linux@gmail.com
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Hildenbrand <david@redhat.com>,
	Dennis Zhou <dennis@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Yuanchu Xie <yuanchu@google.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 39/44] mm: use min() instead of min_t()
Date: Wed, 19 Nov 2025 22:41:35 +0000
Message-Id: <20251119224140.8616-40-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
and so cannot discard significant bits.

In this case the 'unsigned long' values are small enough that the result
is ok.

(Similarly for clamp_t().)

Detected by an extra check added to min_t().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 mm/gup.c      | 4 ++--
 mm/memblock.c | 2 +-
 mm/memory.c   | 2 +-
 mm/percpu.c   | 2 +-
 mm/truncate.c | 3 +--
 mm/vmscan.c   | 2 +-
 6 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a8ba5112e4d0..55435b90dcc3 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -237,8 +237,8 @@ static inline struct folio *gup_folio_range_next(struct page *start,
 	unsigned int nr = 1;
 
 	if (folio_test_large(folio))
-		nr = min_t(unsigned int, npages - i,
-			   folio_nr_pages(folio) - folio_page_idx(folio, next));
+		nr = min(npages - i,
+			 folio_nr_pages(folio) - folio_page_idx(folio, next));
 
 	*ntails = nr;
 	return folio;
diff --git a/mm/memblock.c b/mm/memblock.c
index e23e16618e9b..19b491d39002 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2208,7 +2208,7 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
 		 * the case.
 		 */
 		if (start)
-			order = min_t(int, MAX_PAGE_ORDER, __ffs(start));
+			order = min(MAX_PAGE_ORDER, __ffs(start));
 		else
 			order = MAX_PAGE_ORDER;
 
diff --git a/mm/memory.c b/mm/memory.c
index 74b45e258323..72f7bd71d65f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2375,7 +2375,7 @@ static int insert_pages(struct vm_area_struct *vma, unsigned long addr,
 
 	while (pages_to_write_in_pmd) {
 		int pte_idx = 0;
-		const int batch_size = min_t(int, pages_to_write_in_pmd, 8);
+		const int batch_size = min(pages_to_write_in_pmd, 8);
 
 		start_pte = pte_offset_map_lock(mm, pmd, addr, &pte_lock);
 		if (!start_pte) {
diff --git a/mm/percpu.c b/mm/percpu.c
index 81462ce5866e..cad59221d298 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1228,7 +1228,7 @@ static int pcpu_alloc_area(struct pcpu_chunk *chunk, int alloc_bits,
 	/*
 	 * Search to find a fit.
 	 */
-	end = min_t(int, start + alloc_bits + PCPU_BITMAP_BLOCK_BITS,
+	end = umin(start + alloc_bits + PCPU_BITMAP_BLOCK_BITS,
 		    pcpu_chunk_map_bits(chunk));
 	bit_off = pcpu_find_zero_area(chunk->alloc_map, end, start, alloc_bits,
 				      align_mask, &area_off, &area_bits);
diff --git a/mm/truncate.c b/mm/truncate.c
index 91eb92a5ce4f..7a56372d39a3 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -849,8 +849,7 @@ void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to)
 		unsigned int offset, end;
 
 		offset = from - folio_pos(folio);
-		end = min_t(unsigned int, to - folio_pos(folio),
-			    folio_size(folio));
+		end = umin(to - folio_pos(folio), folio_size(folio));
 		folio_zero_segment(folio, offset, end);
 	}
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b2fc8b626d3d..82cd99a5d843 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3489,7 +3489,7 @@ static struct folio *get_pfn_folio(unsigned long pfn, struct mem_cgroup *memcg,
 
 static bool suitable_to_scan(int total, int young)
 {
-	int n = clamp_t(int, cache_line_size() / sizeof(pte_t), 2, 8);
+	int n = clamp(cache_line_size() / sizeof(pte_t), 2, 8);
 
 	/* suitable if the average number of young PTEs per cacheline is >=1 */
 	return young * n >= total;
-- 
2.39.5


