Return-Path: <linux-fsdevel+bounces-62464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D05B93DD8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 03:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502E619C22AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 01:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B422741DA;
	Tue, 23 Sep 2025 01:29:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9CE2459E5;
	Tue, 23 Sep 2025 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590976; cv=none; b=YmO7njHdJ2pntBjSmVaR/AWqWFZcT7FCYgiyuwC0xgr1+clFWf9sHgsc0DfTjENfQZCndspe4Cd6eDIirqHMDz7J0Kq+wHcgqnFER2t4jPufD1yE1dg50UJ1Ls25rg93dDrUz9CHkn4LIaoiAYeDP6Sb6YmnRLxlA7klnjDUeG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590976; c=relaxed/simple;
	bh=uwXA7214rTZLSUx7YTuJcKawCH8JK9347t+S5f/2ZvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/bLAIfp3f2N/HoE4Q14ot4eSnxvXGb8dSm2tzE5B6BsHw4SVei3lRQQSMLhduLjrI8dX3apfZ8YMiEv3ieGAL6KB0CIosXK1TXMZjdB6L7/HIfsBTBb9JzRW1yBdEkOR+H+EcFYAgY4dSN+EnWp8AJi8p3lJ3w3d01TnmxL5f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cW2Sv6GkczKHLxL;
	Tue, 23 Sep 2025 09:29:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5C16F1A1026;
	Tue, 23 Sep 2025 09:29:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAXKWHq99FoGYYGAg--.10941S8;
	Tue, 23 Sep 2025 09:29:24 +0800 (CST)
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
Subject: [PATCH 04/13] ext4: make ext4_es_lookup_extent() pass out the extent seq counter
Date: Tue, 23 Sep 2025 09:27:14 +0800
Message-ID: <20250923012724.2378858-5-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250923012724.2378858-1-yi.zhang@huaweicloud.com>
References: <20250923012724.2378858-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXKWHq99FoGYYGAg--.10941S8
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4rJFyUAry8Cr13CFy5CFg_yoWrZw15p3
	9xAr4UGw4fZw1v9ayxKF47Zr15K3WYkrW7Cr93Kw1rKa4rXrySyF10yFW2yFyFgrWIqwn0
	vF40kw1UJa1fKFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUriihUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When querying extents in the extent status tree, we should hold the
data_sem if we want to obtain the sequence number as a valid cookie
simultaneously. However, currently, ext4_map_blocks() calls
ext4_es_lookup_extent() without holding data_sem. Therefore, we should
acquire i_es_lock instead, which also ensures that the sequence cookie
and the extent remain consistent. Consequently, make
ext4_es_lookup_extent() to pass out the sequence number when necessary.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c        | 2 +-
 fs/ext4/extents_status.c | 6 ++++--
 fs/ext4/extents_status.h | 2 +-
 fs/ext4/inode.c          | 8 ++++----
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index ca5499e9412b..c7d219e6c6d8 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2213,7 +2213,7 @@ static int ext4_fill_es_cache_info(struct inode *inode,
 	while (block <= end) {
 		next = 0;
 		flags = 0;
-		if (!ext4_es_lookup_extent(inode, block, &next, &es))
+		if (!ext4_es_lookup_extent(inode, block, &next, &es, NULL))
 			break;
 		if (ext4_es_is_unwritten(&es))
 			flags |= FIEMAP_EXTENT_UNWRITTEN;
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 62886e18e2a3..9bf2f48d8ffe 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1035,8 +1035,8 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
  * Return: 1 on found, 0 on not
  */
 int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
-			  ext4_lblk_t *next_lblk,
-			  struct extent_status *es)
+			  ext4_lblk_t *next_lblk, struct extent_status *es,
+			  u64 *pseq)
 {
 	struct ext4_es_tree *tree;
 	struct ext4_es_stats *stats;
@@ -1095,6 +1095,8 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
 			} else
 				*next_lblk = 0;
 		}
+		if (pseq)
+			*pseq = EXT4_I(inode)->i_es_seq;
 	} else {
 		percpu_counter_inc(&stats->es_stats_cache_misses);
 	}
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 8f9c008d11e8..f3396cf32b44 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -148,7 +148,7 @@ extern void ext4_es_find_extent_range(struct inode *inode,
 				      struct extent_status *es);
 extern int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
 				 ext4_lblk_t *next_lblk,
-				 struct extent_status *es);
+				 struct extent_status *es, u64 *pseq);
 extern bool ext4_es_scan_range(struct inode *inode,
 			       int (*matching_fn)(struct extent_status *es),
 			       ext4_lblk_t lblk, ext4_lblk_t end);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..c7fac4b89c88 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -649,7 +649,7 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
 	 * extent status tree.
 	 */
 	if (flags & EXT4_GET_BLOCKS_PRE_IO &&
-	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
+	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, NULL)) {
 		if (ext4_es_is_written(&es))
 			return retval;
 	}
@@ -723,7 +723,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		ext4_check_map_extents_env(inode);
 
 	/* Lookup extent status tree firstly */
-	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
+	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, NULL)) {
 		if (ext4_es_is_written(&es) || ext4_es_is_unwritten(&es)) {
 			map->m_pblk = ext4_es_pblock(&es) +
 					map->m_lblk - es.es_lblk;
@@ -1908,7 +1908,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
 	ext4_check_map_extents_env(inode);
 
 	/* Lookup extent status tree firstly */
-	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
+	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, NULL)) {
 		map->m_len = min_t(unsigned int, map->m_len,
 				   es.es_len - (map->m_lblk - es.es_lblk));
 
@@ -1961,7 +1961,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
 	 * is held in write mode, before inserting a new da entry in
 	 * the extent status tree.
 	 */
-	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
+	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, NULL)) {
 		map->m_len = min_t(unsigned int, map->m_len,
 				   es.es_len - (map->m_lblk - es.es_lblk));
 
-- 
2.46.1


