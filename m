Return-Path: <linux-fsdevel+bounces-47079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACD3A984BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 11:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F615A4C26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 09:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41E726A0AE;
	Wed, 23 Apr 2025 09:03:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1788C25C807;
	Wed, 23 Apr 2025 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745399016; cv=none; b=Tnl5bhe1ak63B9td4d3jqIuVr5QK2ZeM2avIrYMZxmfJiwg8Chwe1CBvczQ6VMhyQLEfdoaE9uQlGxiPW3g1GcKnwliY2n3lnpcZvztfsXAm8Sps4Es1gWuUSXtKF9zGA5FCXHVOkBKbc0cG5j9rVjt7NrnmyL7GLhwm/4i6oxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745399016; c=relaxed/simple;
	bh=nbWjo6YQ71Giydu9YT7lfljl3reXvDy4nvKwmznj7xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnP/N5wYyqwaFZHXy01sZhZsz+3KqO7/gndv5zPRcb2A958P28rzZRnF+Vtlfp+RD/6yTWkQ2qujIy0QgedT9ttHro1vZlT3tf4AghUSPf90SAzIWqEiew0TMHepLV0ilG5URwOVYsVvc1oVwnPEJWHuTitBMjk2DSRUaJnmeYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZjCn05Hbrz4f3jdX;
	Wed, 23 Apr 2025 17:03:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A99941A018D;
	Wed, 23 Apr 2025 17:03:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgAXacPQrAhoJkGrKA--.8976S13;
	Wed, 23 Apr 2025 17:03:24 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 9/9] ext4: clairfy the rules for modifying extents
Date: Wed, 23 Apr 2025 16:52:57 +0800
Message-ID: <20250423085257.122685-10-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250423085257.122685-1-yi.zhang@huaweicloud.com>
References: <20250423085257.122685-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXacPQrAhoJkGrKA--.8976S13
X-Coremail-Antispam: 1UD129KBjvJXoWxXr48ArWfWFykXF48Kw1xKrg_yoW5WF1Upr
	Z3C34fJr18G34xGrW3J3W8Jr45G348JrW7Jrn7Jry7AF15JrySyr1UK34UAr1UGrWkAr15
	Zr48tw18Wa17A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUljgxUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Add a comment at the beginning of extents_status.c to clarify the rules
for loading, mapping, modifying, and removing extents and blocks.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index d1401d4a5513..31dc0496f8d0 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -120,9 +120,40 @@
  *      memory.  Hence, we will reclaim written/unwritten/hole extents from
  *      the tree under a heavy memory pressure.
  *
+ * ==========================================================================
+ * 3. Assurance of Ext4 extent status tree consistency
+ *
+ * When mapping blocks, Ext4 queries the extent status tree first and should
+ * always trusts that the extent status tree is consistent and up to date.
+ * Therefore, it is important to adheres to the following rules when createing,
+ * modifying and removing extents.
+ *
+ *  1. Besides fastcommit replay, when Ext4 creates or queries block mappings,
+ *     the extent information should always be processed through the extent
+ *     status tree instead of being organized manually through the on-disk
+ *     extent tree.
+ *
+ *  2. When updating the extent tree, Ext4 should acquire the i_data_sem
+ *     exclusively and update the extent status tree atomically. If the extents
+ *     to be modified are large enough to exceed the range that a single
+ *     i_data_sem can process (as ext4_datasem_ensure_credits() may drop
+ *     i_data_sem to restart a transaction), it must (e.g. as ext4_punch_hole()
+ *     does):
+ *
+ *     a) Hold the i_rwsem and invalidate_lock exclusively. This ensures
+ *        exclusion against page faults, as well as reads and writes that may
+ *        concurrently modify the extent status tree.
+ *     b) Evict all page cache in the affected range and recommend rebuilding
+ *        or dropping the extent status tree after modifying the on-disk
+ *        extent tree. This ensures exclusion against concurrent writebacks
+ *        that do not hold those locks but only holds a folio lock.
+ *
+ *  3. Based on the rules above, when querying block mappings, Ext4 should at
+ *     least hold the i_rwsem or invalidate_lock or folio lock(s) for the
+ *     specified querying range.
  *
  * ==========================================================================
- * 3. Performance analysis
+ * 4. Performance analysis
  *
  *   --	overhead
  *	1. There is a cache extent for write access, so if writes are
@@ -134,7 +165,7 @@
  *
  *
  * ==========================================================================
- * 4. TODO list
+ * 5. TODO list
  *
  *   -- Refactor delayed space reservation
  *
-- 
2.46.1


