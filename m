Return-Path: <linux-fsdevel+bounces-50732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD28ACF01E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 15:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FAF918989F3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 13:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8810D22D7BF;
	Thu,  5 Jun 2025 13:17:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C810B20C016;
	Thu,  5 Jun 2025 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749129423; cv=none; b=WtIMQG9VKOVEiUfTf5hsFji0EYwM1O3ju/+nlTqIu8hbuFm5Y1DMmW/azglH7lOTgjAgL0zgN72c9tt16xpf8GFH9EUCooKo5SMXeh+gAD8uuLbQuMxGScSki5g5aq2Wv6EpHjtANuJB9Cl2uE7nDdnfeEshR5/umRDwZ5/wMS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749129423; c=relaxed/simple;
	bh=k2P5OpcOAeXgHAFYS+maLDSEn8kZiMRnQx6FsDhYg4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nA1CaMkk6kNw7OVqz1pL621R3lAo9s+btkAoFqIctbR3jUmOc1ukdi2NizgX1HNxXA9zn4Q27zaL+1DciLGyigldHcbc0kyOUje0PhR0hAhaZr16tgnXiG8vlK0zgqD3qpXtg/K4POR4Hb6QMjMHR8kbo1yYRuOIiWY+y9qp5NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bClNC58GKzYQtws;
	Thu,  5 Jun 2025 21:16:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BD0811A11C4;
	Thu,  5 Jun 2025 21:16:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgDnTH3HmEFobD9lOQ--.29489S6;
	Thu, 05 Jun 2025 21:16:58 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: hughd@google.com,
	baolin.wang@linux.alibaba.com,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/7] mm: shmem: handle special case of shmem_recalc_inode() in it's caller
Date: Fri,  6 Jun 2025 06:10:34 +0800
Message-Id: <20250605221037.7872-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250605221037.7872-1-shikemeng@huaweicloud.com>
References: <20250605221037.7872-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDnTH3HmEFobD9lOQ--.29489S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw48CFyDtrW3Zw4DKr1rJFb_yoW8Zw1xpr
	ZrK3yDJrWrAFyI9r9aya1kZrWag3y8GrWUt343u3s5u3WDJr17Kr4IyFy8Za4UCr9rJ3yS
	vr4xCr18ZF4Dt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2
	AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r
	1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	s3kuDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

The sepcial case in shmem_recalc_inode() is tailored for shmem_writepage().
By raising swapped before nrpages is lowered directly within
shmem_writepage(), we can simplify code of shmem_recalc_inode() and
eliminate the need of executing the special case code for all callers of
shmem_recalc_inode().

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/shmem.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 2349673b239b..9f5e1eccaacb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -443,15 +443,6 @@ static void shmem_recalc_inode(struct inode *inode, long alloced, long swapped)
 	info->swapped += swapped;
 	freed = info->alloced - info->swapped -
 		READ_ONCE(inode->i_mapping->nrpages);
-	/*
-	 * Special case: whereas normally shmem_recalc_inode() is called
-	 * after i_mapping->nrpages has already been adjusted (up or down),
-	 * shmem_writepage() has to raise swapped before nrpages is lowered -
-	 * to stop a racing shmem_recalc_inode() from thinking that a page has
-	 * been freed.  Compensate here, to avoid the need for a followup call.
-	 */
-	if (swapped > 0)
-		freed += swapped;
 	if (freed > 0)
 		info->alloced -= freed;
 	spin_unlock(&info->lock);
@@ -1694,9 +1685,16 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 		list_add(&info->swaplist, &shmem_swaplist);
 
 	if (!folio_alloc_swap(folio, __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN)) {
-		shmem_recalc_inode(inode, 0, nr_pages);
+		/*
+		 * Raise swapped before nrpages is lowered to stop racing
+		 * shmem_recalc_inode() from thinking that a page has been freed.
+		 */
+		spin_lock(&info->lock);
+		info->swapped += nr_pages;
+		spin_unlock(&info->lock);
 		swap_shmem_alloc(folio->swap, nr_pages);
 		shmem_delete_from_page_cache(folio, swp_to_radix_entry(folio->swap));
+		shmem_recalc_inode(inode, 0, 0);
 
 		mutex_unlock(&shmem_swaplist_mutex);
 		BUG_ON(folio_mapped(folio));
-- 
2.30.0


