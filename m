Return-Path: <linux-fsdevel+bounces-16592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5477789FA58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 16:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF57285A38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 14:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93059180A6B;
	Wed, 10 Apr 2024 14:38:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBBA179657;
	Wed, 10 Apr 2024 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759925; cv=none; b=JZCzM3p19RLo11vs4Id8ieRmxqt9lKX3IgWkWZZWI/BrIrgVmwQUnBzoU4aAjShkjgjmH1TURIJ48OT60iGHIFnk1GTvmQIuU7ih7c1t+s2TsJZkNjbtHlewqrxdyyC6lXetCM/tBuKhCo2t0NjLnWTUaKKflHWbjhpLX2kIhwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759925; c=relaxed/simple;
	bh=aX2gfX0qKYkUHf7H0T+1mAzhQZIXwn9a3KNHcyddJUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KXrsprj4gzyaslnJXw54rR8gdE8gDDxPlxa5BwKNqR2SC+W9E2CqdtgIFrLmKVgsIFSw0VPHXUlZmc7aRpHIsUISSmO69apAM67DrqueO0LIlVZzBw6Y1gKm0aC7tQObU6gJevW/9SVt58c3nYKHUO3O6mJ7YqrZvXLW0eOCBqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VF56f2K67z4f3k6m;
	Wed, 10 Apr 2024 22:38:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B75FD1A0DA9;
	Wed, 10 Apr 2024 22:38:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFSpBZmcwR8Jg--.63000S24;
	Wed, 10 Apr 2024 22:38:38 +0800 (CST)
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
Subject: [RFC PATCH v4 20/34] ext4: use reserved metadata blocks when splitting extent on endio
Date: Wed, 10 Apr 2024 22:29:34 +0800
Message-Id: <20240410142948.2817554-21-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX6RFSpBZmcwR8Jg--.63000S24
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1UXw4xWrW5ZFy8Ary5Jwb_yoW8Wryfpr
	9rAF1xWr40v3Wj9FW8u3WUJryrC3WUWF47GrZ8t3y29ay7Jr1ruF47K3WrZFyFqrZ7Xw4j
	vr40qa48Zwn5Aa7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4
	xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCa
	FVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI4
	02YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4U
	JwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x0pRDPE-UUU
	UU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

ext4 only reserved space for delalloc for data blocks, doesn't reserve
space for metadata blocks in ext4_da_reserve_space(). Besides, if we
enable dioread_nolock mount option, it also doesn't reserve metadata
blocks for the extent status conversion.

In order to prevent data loss caused by fail to allocate metadata blocks
on writeback, we reserve 2% space or 4096 blocks for meta data, and use
EXT4_GET_BLOCKS_PRE_IO to do the potential split in advance. But all
these two methods were just best efforts, if it's really running out of
sapce, there is no difference between splitting extent on writeback and
on IO completed, both will lead to data loss.

The best way is to reserve enough space for metadata. Before that, we
can at least make sure that things won't get worse if we postpone
splitting extent to endio. So let's use reserved sapce in endio too.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 8bc8a519f745..fcb1916a7c29 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3722,7 +3722,8 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
 			     (unsigned long long)map->m_lblk, map->m_len);
 #endif
 		err = ext4_split_convert_extents(handle, inode, map, ppath,
-						 EXT4_GET_BLOCKS_CONVERT);
+					EXT4_GET_BLOCKS_CONVERT |
+					EXT4_GET_BLOCKS_METADATA_NOFAIL);
 		if (err < 0)
 			return err;
 		path = ext4_find_extent(inode, map->m_lblk, ppath, 0);
-- 
2.39.2


