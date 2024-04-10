Return-Path: <linux-fsdevel+bounces-16542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B62A989F838
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 15:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A86E1F220CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 13:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC86160780;
	Wed, 10 Apr 2024 13:37:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2BF15F3E2;
	Wed, 10 Apr 2024 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756219; cv=none; b=LY2J7DHpDQvJK+AOg66h2SbvsET+JaL4KxTkk5U05PuKfYZZ9UQDqCanzRX0MfNN5VHkD02Pd6xHS4k9A+Q1A2VOIm5HLdWKkdSXmRtnrbEINUwxTBc6Y10+eMtBEb+ZZTprVlfFISqozDvwuWUb2vsuD0bgE0Z2jqJlgAdmzsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756219; c=relaxed/simple;
	bh=jZ9QuHKWjFnW4Mhr01Zx0Dlq6tt8dMlb+kosdcApHUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XveLXoKLN1cjMQFZyMKbDuFdISyJTAdgiT+fNjPDetKtiBV4hfedYrQt3DBNGeuhsU/1+GQ4cyPLrz1mxF9L4eYHXtHx8yhqQ+ARjTj7Mik/zu4nQYaGBBxw8FiOkEqkjyHJhsXjvTVZXJoCfjtpHyuGu6Ft07qYFzCGVxDYRuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VF3lQ2jFZz4f3jkC;
	Wed, 10 Apr 2024 21:36:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C4CE51A0DE2;
	Wed, 10 Apr 2024 21:36:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RHolRZmeCl4Jg--.8806S15;
	Wed, 10 Apr 2024 21:36:54 +0800 (CST)
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
Subject: [RFC PATCH v4 11/34] ext4: optimize the EXT4_GET_BLOCKS_DELALLOC_RESERVE flag set
Date: Wed, 10 Apr 2024 21:27:55 +0800
Message-Id: <20240410132818.2812377-12-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410132818.2812377-1-yi.zhang@huaweicloud.com>
References: <20240410132818.2812377-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RHolRZmeCl4Jg--.8806S15
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWUuryxGrWDCFy3CFyrtFb_yoW5XryDpr
	WfCFyrGan2ga45Za93Ww18Wr1akan7GF4UArWS93yUZ3yakryfKF98tFyrZFyxKrsxZ3Z0
	qF15u34xCFykCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUA
	rcfUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Magic EXT4_GET_BLOCKS_DELALLOC_RESERVE means caller is from the delayed
allocation writeout path, and the blocks and quotas has already been
checked when the data was copied into the page cache, there is no need
to check them again when we do the real allocation. But now we only set
this magic when allocating delayed allocated clusters, it makes things
complicated because we have to deal with the case of allocating
non-delayed allocated clusters, e.g. from fallocate, because in this
case, free space has already been claimed by ext4_mb_new_blocks(), we
shouldn't claim it again. Move setting EXT4_GET_BLOCKS_DELALLOC_RESERVE
to where we actually do block allocation could simplify the handling
process a lot, it means that we always set this magic once the
allocation range covers delalloc blocks, don't distinguish the
allocation path.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 10a256cfcaa1..fd5a27db62c0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -489,6 +489,14 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
 	unsigned int status;
 	int err, retval = 0;
 
+	/*
+	 * We pass in the magic EXT4_GET_BLOCKS_DELALLOC_RESERVE
+	 * indicates that the blocks and quotas has already been
+	 * checked when the data was copied into the page cache.
+	 */
+	if (map->m_flags & EXT4_MAP_DELAYED)
+		flags |= EXT4_GET_BLOCKS_DELALLOC_RESERVE;
+
 	/*
 	 * Here we clear m_flags because after allocating an new extent,
 	 * it will be set again.
@@ -2216,11 +2224,6 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 	 * writeback and there is nothing we can do about it so it might result
 	 * in data loss.  So use reserved blocks to allocate metadata if
 	 * possible.
-	 *
-	 * We pass in the magic EXT4_GET_BLOCKS_DELALLOC_RESERVE if
-	 * the blocks in question are delalloc blocks.  This indicates
-	 * that the blocks and quotas has already been checked when
-	 * the data was copied into the page cache.
 	 */
 	get_blocks_flags = EXT4_GET_BLOCKS_CREATE |
 			   EXT4_GET_BLOCKS_METADATA_NOFAIL |
@@ -2228,8 +2231,6 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 	dioread_nolock = ext4_should_dioread_nolock(inode);
 	if (dioread_nolock)
 		get_blocks_flags |= EXT4_GET_BLOCKS_IO_CREATE_EXT;
-	if (map->m_flags & BIT(BH_Delay))
-		get_blocks_flags |= EXT4_GET_BLOCKS_DELALLOC_RESERVE;
 
 	err = ext4_map_blocks(handle, inode, map, get_blocks_flags);
 	if (err < 0)
-- 
2.39.2


