Return-Path: <linux-fsdevel+bounces-16576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A81DA89FA27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 16:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B35281F14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 14:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B8617334A;
	Wed, 10 Apr 2024 14:38:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA4B16F0FE;
	Wed, 10 Apr 2024 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759914; cv=none; b=sic6GY/Wofx3SDUdartvkGW3A21Lni2tBrZpGuaNNqb+JFExbh54uRMq+EB3UpJsusa+B9tQLV52n01snbOiFqlXjqaz8Lnh4tnLvPVfoxOBrc8sUQLVtl9OKfbr79PwFhpnKrq5f5wxL4gNjhYwFJqam8kZ8gR+L8HP+AcNitA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759914; c=relaxed/simple;
	bh=4aKBF6J1JifebI88IbB+j6VQBFGLK9Ep7hy6nrxj5rE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QKrEqN6H3TElRwO76ZDA0dA/FZ16Hg2jPJ630/wIJjcfF7Wb5hTBCFSJZi8GI3RvKIvvy33hGRCAzYCahiBEaZAHDhFvK/VBma6iH4dNs72Vx00mjrA90qm+NBvDjTBulRikSIjIejKo6ZzfJHbZAqetKp+egFroG8kQ/ncPEss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VF56M0kcNz4f3lgM;
	Wed, 10 Apr 2024 22:38:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B9A5B1A0572;
	Wed, 10 Apr 2024 22:38:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFSpBZmcwR8Jg--.63000S7;
	Wed, 10 Apr 2024 22:38:27 +0800 (CST)
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
Subject: [PATCH v4 03/34] ext4: trim delalloc extent
Date: Wed, 10 Apr 2024 22:29:17 +0800
Message-Id: <20240410142948.2817554-4-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX6RFSpBZmcwR8Jg--.63000S7
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1xWF1Dtr17tF15Aw4Utwb_yoW8CFyUp3
	93CFn5Gr4fWw18WayxJF15XF1rK3WUKrW7GrWfKw1rZas8Gw1fKaykAF17tFyUtrZ3Xrs5
	XFWDtw18Cw4ftrDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxc
	IEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWxJr1l
	IxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7sRizVb3UUUU
	U==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The cached delalloc or hole extent should be trimed to the map->map_len
if we map delalloc blocks in ext4_da_map_blocks(). But it doesn't
trigger any issue now because the map->m_len is always set to one and we
always insert one delayed block once a time. Fix this by trim the extent
once we get one from the cached extent tree, prearing for mapping a
extent with multiple delalloc blocks.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 118b0497a954..e4043ddb07a5 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1734,6 +1734,11 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 
 	/* Lookup extent status tree firstly */
 	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
+		retval = es.es_len - (iblock - es.es_lblk);
+		if (retval > map->m_len)
+			retval = map->m_len;
+		map->m_len = retval;
+
 		if (ext4_es_is_hole(&es))
 			goto add_delayed;
 
@@ -1750,10 +1755,6 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 		}
 
 		map->m_pblk = ext4_es_pblock(&es) + iblock - es.es_lblk;
-		retval = es.es_len - (iblock - es.es_lblk);
-		if (retval > map->m_len)
-			retval = map->m_len;
-		map->m_len = retval;
 		if (ext4_es_is_written(&es))
 			map->m_flags |= EXT4_MAP_MAPPED;
 		else if (ext4_es_is_unwritten(&es))
@@ -1788,6 +1789,11 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 	 * whitout holding i_rwsem and folio lock.
 	 */
 	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
+		retval = es.es_len - (iblock - es.es_lblk);
+		if (retval > map->m_len)
+			retval = map->m_len;
+		map->m_len = retval;
+
 		if (!ext4_es_is_hole(&es)) {
 			up_write(&EXT4_I(inode)->i_data_sem);
 			goto found;
-- 
2.39.2


