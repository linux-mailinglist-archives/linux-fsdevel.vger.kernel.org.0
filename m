Return-Path: <linux-fsdevel+bounces-50737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F36AACF02A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 15:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB7716392C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 13:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEBB238C25;
	Thu,  5 Jun 2025 13:17:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53A32367A0;
	Thu,  5 Jun 2025 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749129428; cv=none; b=gW6s2SAgpaPR3VtHJ7/B7EYNa66+KixxNSx0tUG3r+tI+qJ1hnBosYwqHpkrdE7dGtxw9iU62OWrdrhaFvi2TMDCvOz1mR1S1l3oXfJApAdFOF/NC/oKTGjr38rY4FEA+leD+fjHDp3LIoJDrKzGo9XnXP5ET6GgM8B14ISxLjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749129428; c=relaxed/simple;
	bh=bxP6ruCV7zx069YSAO6SPdxMnRuAAUrp+nIT1wZtMHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JfYT62K6M4Cqhjj6oipu3AWaTNSpSfZCbj5YBxomVhYxtywHBAVGrRFBecKNjS/Uo1h2Rscc7w9GbzHDuHRDzKmuTr0dRlF4iRT+GVeBbGmv6Q4rUILsNqyOKwW6GcO7zDvl9XDutIW2S4o8STyCtsmBPCFacP4u46wwbFwm2lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bClNC4ztCzKHMyJ;
	Thu,  5 Jun 2025 21:16:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1294F1A11BD;
	Thu,  5 Jun 2025 21:16:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgDnTH3HmEFobD9lOQ--.29489S4;
	Thu, 05 Jun 2025 21:16:57 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: hughd@google.com,
	baolin.wang@linux.alibaba.com,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/7] mm: shmem: avoid setting error on splited entries in shmem_set_folio_swapin_error()
Date: Fri,  6 Jun 2025 06:10:32 +0800
Message-Id: <20250605221037.7872-3-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgDnTH3HmEFobD9lOQ--.29489S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KF43Gw4rGr4DGw18Zr13Arb_yoW8tr48pa
	1UG3ZYyr48WrW2kr1xJa1vvr1a9ayrWayUJrZ3W3WfAFnxJryUtFW09ryrXFyjkrykJw4F
	qF47Kr98ur4YqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI
	0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUaknY
	DUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

When large entry is splited, the first entry splited from large entry
retains the same entry value and index as original large entry but it's
order is reduced. In shmem_set_folio_swapin_error(), if large entry is
splited before xa_cmpxchg_irq(), we may replace the first splited entry
with error entry while using the size of original large entry for release
operations. This could lead to a WARN_ON(i_blocks) due to incorrect
nr_pages used by shmem_recalc_inode() and could lead to used after free
due to incorrect nr_pages used by swap_free_nr().
Skip setting error if entry spliiting is detected to fix the issue. The
bad entry will be replaced with error entry anyway as we will still get
IO error when we swap in the bad entry at next time.

Fixes: 12885cbe88ddf ("mm: shmem: split large entry if the swapin folio is not large")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/shmem.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index e27d19867e03..f1062910a4de 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2127,16 +2127,25 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	struct address_space *mapping = inode->i_mapping;
 	swp_entry_t swapin_error;
 	void *old;
-	int nr_pages;
+	int nr_pages = folio_nr_pages(folio);
+	int order;
 
 	swapin_error = make_poisoned_swp_entry();
-	old = xa_cmpxchg_irq(&mapping->i_pages, index,
-			     swp_to_radix_entry(swap),
-			     swp_to_radix_entry(swapin_error), 0);
-	if (old != swp_to_radix_entry(swap))
+	xa_lock_irq(&mapping->i_pages);
+	order = xa_get_order(&mapping->i_pages, index);
+	if (nr_pages != (1 << order)) {
+		xa_unlock_irq(&mapping->i_pages);
 		return;
+	}
+	old = __xa_cmpxchg(&mapping->i_pages, index,
+			   swp_to_radix_entry(swap),
+			   swp_to_radix_entry(swapin_error), 0);
+	if (old != swp_to_radix_entry(swap)) {
+		xa_unlock_irq(&mapping->i_pages);
+		return;
+	}
+	xa_unlock_irq(&mapping->i_pages);
 
-	nr_pages = folio_nr_pages(folio);
 	folio_wait_writeback(folio);
 	if (!skip_swapcache)
 		delete_from_swap_cache(folio);
-- 
2.30.0


