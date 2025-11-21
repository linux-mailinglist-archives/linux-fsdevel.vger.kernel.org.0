Return-Path: <linux-fsdevel+bounces-69354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B22DC7789C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 07:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5EBEC358FA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 06:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B367303A1C;
	Fri, 21 Nov 2025 06:10:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8562FFDEB;
	Fri, 21 Nov 2025 06:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763705435; cv=none; b=DpibThHfaZ5Jeck8JRzBNg9VPKbPUujLo5GWyYN8kbK7OY0AKH6gO4WoUSkL5UoKu45tdp8TzBBXk7PwgoRqE25jWKtAcUX3elzALTK8VJmyp56qwIIVMoy3tXHL1LVCvbQJbWXNLsYpob4hyWA+UwbO7RaAqfo6DEXVvzHf0ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763705435; c=relaxed/simple;
	bh=wIbAMO9b2CGV/QT3DLQZdhKQ3uPbTj5pyfA0UQ8r71E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWNYvAlj3a7m8l74t/oZ2FjUgjNIU7ui2R12t9SauvFquZYQxJcoJOrOgumpRhkFrH/wgHr9TfmnyV6xRHmO8AzbnmiD9djEbrTvYI8Tpro/AmzvPnYlLRtC80jHjHB1DYD+2CLLd+wLvpMPMCttSB89JqfQUh/IFyE6DIy5TNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dCPvS3vdkzKHMgB;
	Fri, 21 Nov 2025 14:09:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 4CA2E1A07BB;
	Fri, 21 Nov 2025 14:10:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgD3VHtAAiBp_of0BQ--.63807S16;
	Fri, 21 Nov 2025 14:10:27 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 12/13] ext4: replace ext4_es_insert_extent() when caching on-disk extents
Date: Fri, 21 Nov 2025 14:08:10 +0800
Message-ID: <20251121060811.1685783-13-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD3VHtAAiBp_of0BQ--.63807S16
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4fuF4DGr1DCrWDKr4xtFb_yoW5AF48pr
	ZrCr1rGws8Ww1q9ayxtF4UZF15Ca4akrW7Gw4xX34rAayrJFyfJF1UtF42vFWvqrW8Xw1r
	XF4Ut34UCayfGa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUQFxUUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

In ext4, the remaining places for inserting extents into the extent
status tree within ext4_ext_determine_insert_hole() and
ext4_map_query_blocks() directly cache on-disk extents. We can use
ext4_es_cache_extent() instead of ext4_es_insert_extent() in these
cases. This will help reduce unnecessary increases in extent sequence
numbers and cache invalidations after supporting IOMAP in the future.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c |  3 +--
 fs/ext4/inode.c   | 18 +++++++++---------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 9bb80af4b5cf..f61a1b57974e 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4184,8 +4184,7 @@ static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
 insert_hole:
 	/* Put just found gap into cache to speed up subsequent requests */
 	ext_debug(inode, " -> %u:%u\n", hole_start, len);
-	ext4_es_insert_extent(inode, hole_start, len, ~0,
-			      EXTENT_STATUS_HOLE, false);
+	ext4_es_cache_extent(inode, hole_start, len, ~0, EXTENT_STATUS_HOLE);
 
 	/* Update hole_len to reflect hole size after lblk */
 	if (hole_start != lblk)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5e588accc35a..6ac7602afc39 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -503,8 +503,8 @@ static int ext4_map_query_blocks_next_in_leaf(handle_t *handle,
 	retval = ext4_ext_map_blocks(handle, inode, &map2, 0);
 
 	if (retval <= 0) {
-		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-				      map->m_pblk, status, false);
+		ext4_es_cache_extent(inode, map->m_lblk, map->m_len,
+				     map->m_pblk, status);
 		return map->m_len;
 	}
 
@@ -525,13 +525,13 @@ static int ext4_map_query_blocks_next_in_leaf(handle_t *handle,
 	 */
 	if (map->m_pblk + map->m_len == map2.m_pblk &&
 			status == status2) {
-		ext4_es_insert_extent(inode, map->m_lblk,
-				      map->m_len + map2.m_len, map->m_pblk,
-				      status, false);
+		ext4_es_cache_extent(inode, map->m_lblk,
+				     map->m_len + map2.m_len, map->m_pblk,
+				     status);
 		map->m_len += map2.m_len;
 	} else {
-		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-				      map->m_pblk, status, false);
+		ext4_es_cache_extent(inode, map->m_lblk, map->m_len,
+				     map->m_pblk, status);
 	}
 
 	return map->m_len;
@@ -573,8 +573,8 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
 			map->m_len == orig_mlen) {
 		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
 				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
-		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-				      map->m_pblk, status, false);
+		ext4_es_cache_extent(inode, map->m_lblk, map->m_len,
+				     map->m_pblk, status);
 	} else {
 		retval = ext4_map_query_blocks_next_in_leaf(handle, inode, map,
 							    orig_mlen);
-- 
2.46.1


