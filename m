Return-Path: <linux-fsdevel+bounces-7113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9549D821C02
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 13:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436C8282CB4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 12:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CF511734;
	Tue,  2 Jan 2024 12:42:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45052156E7;
	Tue,  2 Jan 2024 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T4CD84W1cz4f3l81;
	Tue,  2 Jan 2024 20:42:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 599821A07FD;
	Tue,  2 Jan 2024 20:42:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBnwUGUBJRl+EvDFQ--.31823S28;
	Tue, 02 Jan 2024 20:42:18 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [RFC PATCH v2 24/25] filemap: support disable large folios on active inode
Date: Tue,  2 Jan 2024 20:39:17 +0800
Message-Id: <20240102123918.799062-25-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240102123918.799062-1-yi.zhang@huaweicloud.com>
References: <20240102123918.799062-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnwUGUBJRl+EvDFQ--.31823S28
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW7KF13Ar18uFW5Kw47CFg_yoW8Kw47pF
	y7Cw4rtrW8XF4YyrykAFsFvF4ag348WayUAFy3Was8A3ZxKF42gFWDCa43Xry7Ar4rAa1x
	Za1UAry7GFyYg3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUl
	2NtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Since commit 730633f0b7f9 ("mm: Protect operations adding pages to page
cache with invalidate_lock"), mapping->invalidate_lock can protect us
from adding new folios into page cache. So it's possible to disable
active inodes' large folios support, even through it might be dangerous.
Filesystems can disable it under mapping->invalidate_lock and drop all
page cache before dropping AS_LARGE_FOLIO_SUPPORT, besides, the order of
folio must also be determined under the lock.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 include/linux/pagemap.h | 13 +++++++++++++
 mm/readahead.c          |  6 ++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 06142ff7f9ce..2554699ba7e3 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -343,6 +343,19 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
 	__set_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
 }
 
+/**
+ * mapping_clear_large_folios() - The file disable supports large folios.
+ * @mapping: The file.
+ *
+ * The filesystem have to make sure the file is in atomic context and all
+ * cached folios have been cleared under mapping->invalidate_lock before
+ * calling this function.
+ */
+static inline void mapping_clear_large_folios(struct address_space *mapping)
+{
+	__clear_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
+}
+
 /*
  * Large folio support currently depends on THP.  These dependencies are
  * being worked on but are not yet fixed.
diff --git a/mm/readahead.c b/mm/readahead.c
index 6925e6959fd3..c97eceaf7214 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -493,8 +493,11 @@ void page_cache_ra_order(struct readahead_control *ractl,
 	int err = 0;
 	gfp_t gfp = readahead_gfp_mask(mapping);
 
-	if (!mapping_large_folio_support(mapping) || ra->size < 4)
+	filemap_invalidate_lock_shared(mapping);
+	if (!mapping_large_folio_support(mapping) || ra->size < 4) {
+		filemap_invalidate_unlock_shared(mapping);
 		goto fallback;
+	}
 
 	limit = min(limit, index + ra->size - 1);
 
@@ -506,7 +509,6 @@ void page_cache_ra_order(struct readahead_control *ractl,
 			new_order--;
 	}
 
-	filemap_invalidate_lock_shared(mapping);
 	while (index <= limit) {
 		unsigned int order = new_order;
 
-- 
2.39.2


