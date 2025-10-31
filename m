Return-Path: <linux-fsdevel+bounces-66551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0259CC2368C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 07:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F816424B75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 06:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9685303A39;
	Fri, 31 Oct 2025 06:31:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596E52848B4;
	Fri, 31 Oct 2025 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761892286; cv=none; b=Nj7KoP+H0Sagc02ieNW5DFPoj/jMNq+dQazOyx0GPTL1ta1Fgw2EGaHpB82N4OI1W15ABEdJ5pdZtsCkDTzRVxrIq3bcvhbyQShZJyHFJ0uUCpgC9X48lvH18l5NxQG92Gv0UgFJK2/83YG50dDU9fl9PqzvWKb9K8+bkgX3QrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761892286; c=relaxed/simple;
	bh=o+LIBORoXhKHcJTxfihkDW044OArupUAC8XHP4fDIVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HCkuDYLjcgXrxusmzFda2c3khv2nd55d6Ai1dAmT+wcxTqkATA/owCY1q4bb/JUz4v/oYrqAbT5WG+9B1PwG/gS8+trIHbcR9uPQBannnsGop7C6GxyshKRiaeKtTYSEdmua/MPG3ZxfS4HjsAvAv3oDgmMvsBcSpSgjq8Asu4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cyWMj1mljzYQthv;
	Fri, 31 Oct 2025 14:31:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 35A1B1A07BD;
	Fri, 31 Oct 2025 14:31:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgBHnESuVwRpEFrWCA--.33311S8;
	Fri, 31 Oct 2025 14:31:21 +0800 (CST)
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
	yangerkun@huawei.com
Subject: [PATCH 4/4] ext4: replace ext4_es_insert_extent() when caching on-disk extents
Date: Fri, 31 Oct 2025 14:29:05 +0800
Message-ID: <20251031062905.4135909-5-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251031062905.4135909-1-yi.zhang@huaweicloud.com>
References: <20251031062905.4135909-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHnESuVwRpEFrWCA--.33311S8
X-Coremail-Antispam: 1UD129KBjvJXoWxWF43tr4DXFyxGrWrtrykGrg_yoW5Ww15pr
	ZrCr1rGws8Ww1q9FWxJF4UZF15C3WakrW7Gw4IvryrAayrGFyfJF1UtFW2vFWvqrW8Xw1F
	qF4UK34UCayfCa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x0JUQFxUUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

In ext4, the remaining places for inserting extents into the extent
status tree within ext4_ext_determine_insert_hole() and
ext4_map_query_blocks() directly cache on-disk extents. We can use
ext4_es_cache_extent() instead of ext4_es_insert_extent() in these
cases. This will help reduce unnecessary increases in extent sequence
numbers and cache invalidations after supporting IOMAP in the future.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c |  4 ++--
 fs/ext4/inode.c   | 18 +++++++++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c42ceb5aae37..7dc80141350d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4160,8 +4160,8 @@ static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
 insert_hole:
 	/* Put just found gap into cache to speed up subsequent requests */
 	ext_debug(inode, " -> %u:%u\n", hole_start, len);
-	ext4_es_insert_extent(inode, hole_start, len, ~0,
-			      EXTENT_STATUS_HOLE, false);
+	ext4_es_cache_extent(inode, hole_start, len, ~0,
+			     EXTENT_STATUS_HOLE, true);
 
 	/* Update hole_len to reflect hole size after lblk */
 	if (hole_start != lblk)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e99306a8f47c..a3c37de552e9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -504,8 +504,8 @@ static int ext4_map_query_blocks_next_in_leaf(handle_t *handle,
 	retval = ext4_ext_map_blocks(handle, inode, &map2, 0);
 
 	if (retval <= 0) {
-		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-				      map->m_pblk, status, false);
+		ext4_es_cache_extent(inode, map->m_lblk, map->m_len,
+				     map->m_pblk, status, true);
 		return map->m_len;
 	}
 
@@ -526,13 +526,13 @@ static int ext4_map_query_blocks_next_in_leaf(handle_t *handle,
 	 */
 	if (map->m_pblk + map->m_len == map2.m_pblk &&
 			status == status2) {
-		ext4_es_insert_extent(inode, map->m_lblk,
-				      map->m_len + map2.m_len, map->m_pblk,
-				      status, false);
+		ext4_es_cache_extent(inode, map->m_lblk,
+				     map->m_len + map2.m_len, map->m_pblk,
+				     status, true);
 		map->m_len += map2.m_len;
 	} else {
-		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-				      map->m_pblk, status, false);
+		ext4_es_cache_extent(inode, map->m_lblk, map->m_len,
+				     map->m_pblk, status, true);
 	}
 
 	return map->m_len;
@@ -571,8 +571,8 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
 			map->m_len == orig_mlen) {
 		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
 				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
-		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-				      map->m_pblk, status, false);
+		ext4_es_cache_extent(inode, map->m_lblk, map->m_len,
+				     map->m_pblk, status, true);
 		return retval;
 	}
 
-- 
2.46.1


