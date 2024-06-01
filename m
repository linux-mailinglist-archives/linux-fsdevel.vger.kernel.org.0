Return-Path: <linux-fsdevel+bounces-20684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 122568D6DBE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 05:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A12A7B2386D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 03:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11703134A8;
	Sat,  1 Jun 2024 03:42:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009CC8F6D;
	Sat,  1 Jun 2024 03:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717213324; cv=none; b=GKJX4H40ZXCVQcd3EZeGn7BT4gv2sUt9lSW9gcrLXojqvvipNApEZflT5W13P/ztO6+LGHc1by80iLnvwLpRp2o+a/W/C7cR7PggEpibIpzmQ5qW9FeuHrtOgy/gNx0AIxdqM2IQHWnvmbxAyaQk4NBZbZY4oaFbgj9wDKZ3EG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717213324; c=relaxed/simple;
	bh=UKb/i9Gdg6pJ8gsBJh7SfFpEikmojMLtJOhdu+iIqE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q7xe2nPkJ9Mjs93TavLvyPumxtHpTNuNz5KnSfC7YifBS0ESdyKA1rzjHusXJnh4KZMMjnnmOJPcWTh+T+eZI2YLxAoY+Wg6HVN+Y4CwI+p+q/2Y+uzH97U/H2oZkw7L1c/2ovt41EWVbqXGxu96ANfbLR327BHlJSVCsJ18zBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vrm4k5jsDz4f3mHS;
	Sat,  1 Jun 2024 11:41:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B4EA51A0A91;
	Sat,  1 Jun 2024 11:41:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFumFpmHN_4OA--.4543S7;
	Sat, 01 Jun 2024 11:41:53 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH 03/10] ext4: don't set EXTENT_STATUS_DELAYED on allocated blocks
Date: Sat,  1 Jun 2024 11:41:42 +0800
Message-Id: <20240601034149.2169771-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240601034149.2169771-1-yi.zhang@huaweicloud.com>
References: <20240601034149.2169771-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RFumFpmHN_4OA--.4543S7
X-Coremail-Antispam: 1UD129KBjvJXoW7uryxXw43tw4rCF48uF18AFb_yoW8tw1Up3
	srAr1rWF4UWw1UuayI9r48ur15GayjkrZrur48uryrXayfCrySkF1qyFW0gF9FqrW8Xw4Y
	qFWru34UCayfKa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUCXdbUUUUU
	=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Since we always set EXT4_GET_BLOCKS_DELALLOC_RESERVE when allocating
delalloc blocks, there is no need to keep delayed flag on the unwritten
extent status entry, so just drop it after allocation.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c |  9 +--------
 fs/ext4/inode.c          | 11 -----------
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 23caf1f028b0..084ea0a753ee 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -867,14 +867,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 		return;
 
 	BUG_ON(end < lblk);
-
-	if ((status & EXTENT_STATUS_DELAYED) &&
-	    (status & EXTENT_STATUS_WRITTEN)) {
-		ext4_warning(inode->i_sb, "Inserting extent [%u/%u] as "
-				" delayed and written which can potentially "
-				" cause data loss.", lblk, len);
-		WARN_ON(1);
-	}
+	WARN_ON_ONCE(status & EXTENT_STATUS_DELAYED);
 
 	newes.es_lblk = lblk;
 	newes.es_len = len;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1f6de35e6216..0dde2bf078ba 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -558,12 +558,6 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
 
 	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
 			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
-	if (!(flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE) &&
-	    !(status & EXTENT_STATUS_WRITTEN) &&
-	    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
-			       map->m_lblk + map->m_len - 1))
-		status |= EXTENT_STATUS_DELAYED;
-
 	ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
 			      map->m_pblk, status);
 
@@ -682,11 +676,6 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 
 		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
 				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
-		if (!(flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE) &&
-		    !(status & EXTENT_STATUS_WRITTEN) &&
-		    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
-				       map->m_lblk + map->m_len - 1))
-			status |= EXTENT_STATUS_DELAYED;
 		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
 				      map->m_pblk, status);
 	}
-- 
2.31.1


