Return-Path: <linux-fsdevel+bounces-9178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA35883E988
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 03:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0964A1C21348
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 02:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D0D446C7;
	Sat, 27 Jan 2024 02:03:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70C82E629;
	Sat, 27 Jan 2024 02:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706320980; cv=none; b=E1q5DtkaE4fJ/Ea2ZwCzKxLTqjlV5LpFQsY8B5aE+CSJ1BtkH1GECVX75QbV186U065hZc6ciNcsJL3sjKXgZUmqlRwouXi+eedW+FUx+8KiQUnGt27YR3w95B25i+Fkfk7zzjwQtSuTdAmZbtpqXS4jjnbedqMffL9td62uLLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706320980; c=relaxed/simple;
	bh=8VT+TN0o7B9Wi1Ztljw78qt0VBFKO96Kfs8LfSmgprI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SwJHg9n0WBlcqB0CnCmiS+8j5kBekPtl3dF4Lc362o//Ow3lDijaEdBYFChlhVovZk29E2Ajkq41ODIEAGttSSKN8Qvg54WYBWpWL79rfBhUUHWZesLjPh6jBb1XJDxtQop1iVxK/Dnxtrpsa4+oUkJP9sD21pgnwMyNF29iuas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TMHrn4JPrz4f3lgJ;
	Sat, 27 Jan 2024 10:02:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id EEEF41A017A;
	Sat, 27 Jan 2024 10:02:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g40ZLRlGJtmCA--.7377S29;
	Sat, 27 Jan 2024 10:02:55 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [RFC PATCH v3 25/26] filemap: support disable large folios on active inode
Date: Sat, 27 Jan 2024 09:58:24 +0800
Message-Id: <20240127015825.1608160-26-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g40ZLRlGJtmCA--.7377S29
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW7KF13Ar18uFW5tw4ktFb_yoW5JF47pF
	y7Cw4rJrW8XF4YyrykAFsFvr4ag348WayUAFy3Was8A3ZxKF42gFWUCasxXry7Ar4rAa1x
	Za1UAry7GFyYg3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
	WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbCe
	HDUUUUU==
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
 include/linux/pagemap.h | 14 ++++++++++++++
 mm/readahead.c          |  6 ++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 06142ff7f9ce..7f77670960d8 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -343,6 +343,20 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
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
+	WARN_ON_ONCE(!rwsem_is_locked(&mapping->invalidate_lock));
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


