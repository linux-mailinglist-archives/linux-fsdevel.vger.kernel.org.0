Return-Path: <linux-fsdevel+bounces-16605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0226689FB35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 17:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840BB1F2560C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 15:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE83016F285;
	Wed, 10 Apr 2024 15:11:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3806815444A;
	Wed, 10 Apr 2024 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761916; cv=none; b=Y29Ce8oxHE1+kZQN2cIbblZG0s2mu7uRwZ7fqVjjaiQwhQPY2GdmP8VWch0PoeckP4y54ygbqzkLLKVbYZdmChcQcPurrZVmRgCyG5z2jdlE1cSnh88waMbmgRa+kJmxxoxfBMS5XV4LwdJFk6fT30WlKPwa8uah/NN92Tnq96s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761916; c=relaxed/simple;
	bh=qedOqUe8njcEX0z1KrWk7ZkIOm2CEHudY9JaQgkVuTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OZlMHso4LQeAYd+HztC73yJTt77N8alaazxphub0B82AEjW6yzLjGbCpeDwIskBDIV8OO5S7cyVrKeYYQc6Cx56E/NNl1R0jYDclMq7ICbB2u/R6RAmgCukY0P1JawCa2jKRT7uRlJWQ5YkQfr6FAF5zpD1t26+gR9znspnW/tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VF5rv0Y5qz4f3kjF;
	Wed, 10 Apr 2024 23:11:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E1FCE1A0175;
	Wed, 10 Apr 2024 23:11:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g4orBZmFSt+Jg--.51485S6;
	Wed, 10 Apr 2024 23:11:49 +0800 (CST)
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
	david@fromorbit.com,
	willy@infradead.org,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [RFC PATCH v4 31/34] filemap: support disable large folios on active inode
Date: Wed, 10 Apr 2024 23:03:10 +0800
Message-Id: <20240410150313.2820364-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
References: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g4orBZmFSt+Jg--.51485S6
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW7KF13Ar18tF1DXFy3XFb_yoW8uryfpF
	W7uw4rGrWUWFsYvr93AFy2yF4fWa4kWayUAF9xGwn8AasxKF42gFWvk3W3X3yUJr4rAa1f
	ZF4Uury3GFyjg3DanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUljb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y40E4IxF1VCIxcxG6Fyj6r
	4UJwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2
	xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JF
	I_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s
	0DYxBIdaVFxhVjvjDU0xZFpf9x0zRjNtcUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Since commit 730633f0b7f9 ("mm: Protect operations adding pages to page
cache with invalidate_lock"), mapping->invalidate_lock can protect us
from adding new folios into page cache. So it's possible to disable
active inodes' large folios support, even through it might be dangerous.
Filesystems can disable it under mapping->invalidate_lock and drop all
page cache before dropping AS_LARGE_FOLIO_SUPPORT.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 include/linux/pagemap.h | 14 ++++++++++++++
 mm/readahead.c          |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2df35e65557d..7e963bc64158 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -360,6 +360,20 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
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
index 130c0e7df99f..481fe355485c 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -505,6 +505,12 @@ void page_cache_ra_order(struct readahead_control *ractl,
 	}
 
 	filemap_invalidate_lock_shared(mapping);
+
+	if (unlikely(!mapping_large_folio_support(mapping))) {
+		filemap_invalidate_unlock_shared(mapping);
+		goto fallback;
+	}
+
 	while (index <= limit) {
 		unsigned int order = new_order;
 
-- 
2.39.2


