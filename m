Return-Path: <linux-fsdevel+bounces-50733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA30ACF021
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 15:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F851788D7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 13:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054FA231854;
	Thu,  5 Jun 2025 13:17:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAFE21ADC5;
	Thu,  5 Jun 2025 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749129423; cv=none; b=pMMrtITMWfGIIXuWucPMFELmLUin8WAx120VL6LeVXBNPlrHvl94CZmwSyExw1NZte+rph+9ZYr+X1jOf/NZh7W3Yh5YjUEwQTxjwpVa8Y+lNZjeh16OLgJVLEkNwRyGAUr/fmds010bD+5GKOW2zFGFwE+4P1ZGcr6/aqpswmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749129423; c=relaxed/simple;
	bh=TcgClPKK1QHmvqc70ATZ3pT3crClJTqGkcaAyfXDC90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WXKwPaY3QzYxGBhalrIpURQ1mVy7ZXT5M11Lb0PefcZTW1TmYNJuxtKHbWDhEWa6pK6aARGMi67qhq5PWiGKRgfGSJp4TUB2VgCtfh9Nd7QM19T90Qi7RDZDETL5qcS0zalUpLC1RxRPjpSjTXOqs9U/Y2241sFNRKSMxt6IUr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bClND5DY6zYQvhR;
	Thu,  5 Jun 2025 21:17:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BFF8C1A0BA9;
	Thu,  5 Jun 2025 21:16:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgDnTH3HmEFobD9lOQ--.29489S9;
	Thu, 05 Jun 2025 21:16:59 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: hughd@google.com,
	baolin.wang@linux.alibaba.com,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/7] mm: shmem: eliminate unneeded page counting in shmem_unuse_swap_entries()
Date: Fri,  6 Jun 2025 06:10:37 +0800
Message-Id: <20250605221037.7872-8-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgDnTH3HmEFobD9lOQ--.29489S9
X-Coremail-Antispam: 1UD129KBjvJXoW7urWxCFW7tFWUKFWUKFW7urg_yoW8Aw48pF
	W3W3srJr4kXFW8Cr97A34kZw1aq393KFWjqFy3Gwn3Z3WUJw12krySkryjqF15C348G34S
	qw4UKry5ua1Utr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2
	AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r
	1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U09YFtUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Caller of shmem_unuse_swap_entries() will not use the count of pages
swapped in, so eliminate unneeded page counting in
shmem_unuse_swap_entries().

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/shmem.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index c6ea45d542d2..c83baabc169d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1480,14 +1480,13 @@ static unsigned int shmem_find_swap_entries(struct address_space *mapping,
 }
 
 /*
- * Move the swapped pages for an inode to page cache. Returns the count
- * of pages swapped in, or the error in case of failure.
+ * Move the swapped pages for an inode to page cache. Returns 0 if success,
+ * or returns error in case of failure.
  */
 static int shmem_unuse_swap_entries(struct inode *inode,
 		struct folio_batch *fbatch, pgoff_t *indices)
 {
 	int i = 0;
-	int ret = 0;
 	int error = 0;
 	struct address_space *mapping = inode->i_mapping;
 
@@ -1499,13 +1498,11 @@ static int shmem_unuse_swap_entries(struct inode *inode,
 		if (error == 0) {
 			folio_unlock(folio);
 			folio_put(folio);
-			ret++;
 		}
 		if (error == -ENOMEM)
-			break;
-		error = 0;
+			return error;
 	}
-	return error ? error : ret;
+	return 0;
 }
 
 /*
@@ -1517,24 +1514,20 @@ static int shmem_unuse_inode(struct inode *inode, unsigned int type)
 	pgoff_t start = 0;
 	struct folio_batch fbatch;
 	pgoff_t indices[PAGEVEC_SIZE];
-	int ret = 0;
+	int ret;
 
 	do {
 		folio_batch_init(&fbatch);
 		if (!shmem_find_swap_entries(mapping, start, &fbatch,
-					     indices, type)) {
-			ret = 0;
-			break;
-		}
+					     indices, type))
+			return 0;
 
 		ret = shmem_unuse_swap_entries(inode, &fbatch, indices);
 		if (ret < 0)
-			break;
+			return ret;
 
 		start = indices[folio_batch_count(&fbatch) - 1];
 	} while (true);
-
-	return ret;
 }
 
 /*
-- 
2.30.0


