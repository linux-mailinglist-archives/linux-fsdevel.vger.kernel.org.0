Return-Path: <linux-fsdevel+bounces-32837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9C69AF6C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 03:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B06F2846E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 01:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBD8535DC;
	Fri, 25 Oct 2024 01:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GrsC3TDa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0630B14A4C3
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 01:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819428; cv=none; b=buyLqj6ckFw2ZnIvVFC3OzQNSt7DHmmxjelMbY3P8fV+mjWB6emp6IY43VGx+RfuxoUR2MOMurfVN5uuKDmbfqgqz4dJ4SEvWhhTacWwS3Klt7P3H9g/4d5WLPbws+MpfHpcxjebb3LCtI2RLSnlS2ug00Gz9FlezxHMgQ1WKs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819428; c=relaxed/simple;
	bh=2vVIbPTjuGZzuTLlvwh0Z4F0lPkA1XI9De5NLdAdO34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hh02D6p4oGclqTtI0XBBuLk1mpbuIDtVHP5fNC0ol1jRg5a163Q//btpRoquBvYmgH+rwJ/kNxotYvWea9JU8rOMZQrXNpdVwsnxX5iS//+iJs91mfsJJ47r4PY6huKVE9rugYbq0vdim/c3Ovv4zkAvqscSTVmF/5EESVbsCIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GrsC3TDa; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729819424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iejBIQWD2OAhZkVfaU63yScFrNJ6h4kxppqkG7YGNik=;
	b=GrsC3TDaVDfYh+TUdZFQPVmDb83cgTuYqF7TK1rwrc6JkwUX3NwN47+8aVi9qNqpCYg9I5
	oYRZ+6lJYSOJw+Zsn2rtkf6E3JCqoEbsRETnHxv6dd9lUBtB1tqCkB80WWWonbPuzHynDI
	kNuvqZMBg1LZe3LcBjV/jtUeMaZu/ig=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v1 5/6] memcg-v1: no need for memcg locking for MGLRU
Date: Thu, 24 Oct 2024 18:23:02 -0700
Message-ID: <20241025012304.2473312-6-shakeel.butt@linux.dev>
In-Reply-To: <20241025012304.2473312-1-shakeel.butt@linux.dev>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

While updating the generation of the folios, MGLRU requires that the
folio's memcg association remains stable. With the charge migration
deprecated, there is no need for MGLRU to acquire locks to keep the
folio and memcg association stable.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/vmscan.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 29c098790b01..fd7171658b63 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3662,10 +3662,6 @@ static void walk_mm(struct mm_struct *mm, struct lru_gen_mm_walk *walk)
 		if (walk->seq != max_seq)
 			break;
 
-		/* folio_update_gen() requires stable folio_memcg() */
-		if (!mem_cgroup_trylock_pages(memcg))
-			break;
-
 		/* the caller might be holding the lock for write */
 		if (mmap_read_trylock(mm)) {
 			err = walk_page_range(mm, walk->next_addr, ULONG_MAX, &mm_walk_ops, walk);
@@ -3673,8 +3669,6 @@ static void walk_mm(struct mm_struct *mm, struct lru_gen_mm_walk *walk)
 			mmap_read_unlock(mm);
 		}
 
-		mem_cgroup_unlock_pages();
-
 		if (walk->batched) {
 			spin_lock_irq(&lruvec->lru_lock);
 			reset_batch_size(walk);
@@ -4096,10 +4090,6 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 		}
 	}
 
-	/* folio_update_gen() requires stable folio_memcg() */
-	if (!mem_cgroup_trylock_pages(memcg))
-		return true;
-
 	arch_enter_lazy_mmu_mode();
 
 	pte -= (addr - start) / PAGE_SIZE;
@@ -4144,7 +4134,6 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	}
 
 	arch_leave_lazy_mmu_mode();
-	mem_cgroup_unlock_pages();
 
 	/* feedback from rmap walkers to page table walkers */
 	if (mm_state && suitable_to_scan(i, young))
-- 
2.43.5


