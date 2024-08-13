Return-Path: <linux-fsdevel+bounces-25780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6305795054B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 14:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F8A1F2522C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 12:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7136C19E7FA;
	Tue, 13 Aug 2024 12:39:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF56319D08A;
	Tue, 13 Aug 2024 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552769; cv=none; b=Tvg6ikoU/3bwu+0dVrIIUor781UAYOHcegD/uLV22EuSkt0dBpJWWWaMFNxJVHm/S0nMDpliDHSTSdOhUMd3qqeEhzdx2cotwXACnpJIxf1+sMj1yNKlk4RRcSDkUP/jfccvpOlHsRx4LI6LuWnrL/y8W6sX+Rws417J2AabUkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552769; c=relaxed/simple;
	bh=9TbKrN2FkPfhF+u9zT16jdracmqOr0DyA+Eu0S0ashI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hJvFVkZsVqomiv1ZtcVnadkaF0Qm2lNfhvnpqXuLzfdU7S8OS44fdWY5NQOpt7dY9G9cTTj0gPlTg2xW1clwfXBX54fzPXYZEqAWFCGDOHix4jKdoIvbzB2/I1RRZJJd3SDabnUzKUeCcyTxbja83s3eZpE3U5Sz8GdNUeDUTzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WjrY85Q6mz4f3k6W;
	Tue, 13 Aug 2024 20:39:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0DEFA1A058E;
	Tue, 13 Aug 2024 20:39:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBnj4XkU7tmejNSBg--.17625S7;
	Tue, 13 Aug 2024 20:39:17 +0800 (CST)
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
Subject: [PATCH v3 03/12] ext4: don't set EXTENT_STATUS_DELAYED on allocated blocks
Date: Tue, 13 Aug 2024 20:34:43 +0800
Message-Id: <20240813123452.2824659-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
References: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnj4XkU7tmejNSBg--.17625S7
X-Coremail-Antispam: 1UD129KBjvJXoWxGFyxuF48CrWkKrW5KFWkXrb_yoW5Gr1kp3
	sxAr1rWF4UWw1UuayI9r48Wr15GayFkrW7ur409r1rXayfCrySkF1jyFW0qFyqqrW8Zr4Y
	qFWruw1UCay3GFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIev
	Ja73UjIFyTuYvjfUO_MaUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Currently, we release delayed allocation reservation when removing
delayed extent from extent status tree (which also happens when
overwriting one extent with another one). When we allocated unwritten
extent under some delayed allocated extent, we don't need the
reservation anymore and hence we don't need to preserve the
EXT4_MAP_DELAYED status bit. Allocating the new extent blocks will
properly release the reservation.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/extents_status.c |  9 +--------
 fs/ext4/inode.c          | 11 -----------
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 17dcf13adde2..024cd37d53b3 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -869,14 +869,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
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
index 91b2610a6dc5..e9ce1e4e6acb 100644
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
2.39.2


