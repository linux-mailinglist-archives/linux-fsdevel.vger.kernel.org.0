Return-Path: <linux-fsdevel+bounces-70224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8626AC93C78
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 11:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA24734AF7C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 10:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2762BE053;
	Sat, 29 Nov 2025 10:35:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE69F19C540;
	Sat, 29 Nov 2025 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764412542; cv=none; b=J3HbnYCIcc6tYKmIRkiUesNg79NIlYedqOAoBJGvRpo1KIMWvumsoFcGoLbDQvfIxxcZqNOJLvUKvrXcJnHG924wjPLRFxzvTxEt25+DssOrl9G0QGTA3hcOjH3Mw21aACyrgUs/Vue2+CsHhxMspX9hQZwOUccN8YFQjM2ym/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764412542; c=relaxed/simple;
	bh=HVBoB5IHmQ720ZdZa49JC6bOZSiel3XlOev/OUMySSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8yYuBM3hwv0jV4euVkhLzTDxMUeW5mWQoblGAZZ6VOIivyaj0mPUc4234uH4TuSFqcvVrsL9sTAVaJkGU/Trt50yFTHBE3InoMb7MbNRfMm8k8EGIj8lIa3tuEVrnn6XwM6fOXWVpGduEvw/TNwIGwOj9ffgPG6GGK+HxKb/oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dJRPM3Lh4zKHMQS;
	Sat, 29 Nov 2025 18:34:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id A50DF1A1728;
	Sat, 29 Nov 2025 18:35:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgAnhXtfzCpp_56qCQ--.62661S9;
	Sat, 29 Nov 2025 18:35:30 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v3 05/14] ext4: don't cache extent during splitting extent
Date: Sat, 29 Nov 2025 18:32:37 +0800
Message-ID: <20251129103247.686136-6-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251129103247.686136-1-yi.zhang@huaweicloud.com>
References: <20251129103247.686136-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnhXtfzCpp_56qCQ--.62661S9
X-Coremail-Antispam: 1UD129KBjvJXoWxAw17tF17tr1xKrW7Ww4fAFb_yoW5WF4kpF
	ZakF1UGr4kCw1vk34xAF4kK3409w4kGrW7Ar95Gw1Y9FyUJFyagF1xtw1YvFyrWr48Za45
	Zr40kF1UCa4DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VU1zpBDUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Caching extents during the splitting process is risky, as it may result
in stale extents remaining in the status tree. Moreover, in most cases,
the corresponding extent block entries are likely already cached before
the split happens, making caching here not particularly useful.

Assume we have an unwritten extent, and then DIO writes the first half.

  [UUUUUUUUUUUUUUUU] on-disk extent        U: unwritten extent
  [UUUUUUUUUUUUUUUU] extent status tree
  |<-   ->| ----> dio write this range

First, when ext4_split_extent_at() splits this extent, it truncates the
existing extent and then inserts a new one. During this process, this
extent status entry may be shrunk, and calls to ext4_find_extent() and
ext4_cache_extents() may occur, which could potentially insert the
truncated range as a hole into the extent status tree. After the split
is completed, this hole is not replaced with the correct status.

  [UUUUUUU|UUUUUUUU] on-disk extent        U: unwritten extent
  [UUUUUUU|HHHHHHHH] extent status tree    H: hole

Then, the outer calling functions will not correct this remaining hole
extent either. Finally, if we perform a delayed buffer write on this
latter part, it will re-insert the delayed extent and cause an error in
space accounting.

In adition, if the unwritten extent cache is not shrunk during the
splitting, ext4_cache_extents() also conflicts with existing extents
when caching extents. In the future, we will add checks when caching
extents, which will trigger a warning. Therefore, Do not cache extents
that are being split.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Cc: stable@kernel.org
---
 fs/ext4/extents.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index daecf3f0b367..be9fd2ab8667 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3199,6 +3199,9 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 	BUG_ON((split_flag & EXT4_EXT_DATA_VALID1) &&
 	       (split_flag & EXT4_EXT_DATA_VALID2));
 
+	/* Do not cache extents that are in the process of being modified. */
+	flags |= EXT4_EX_NOCACHE;
+
 	ext_debug(inode, "logical block %llu\n", (unsigned long long)split);
 
 	ext4_ext_show_leaf(inode, path);
@@ -3381,6 +3384,9 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 	ee_len = ext4_ext_get_actual_len(ex);
 	unwritten = ext4_ext_is_unwritten(ex);
 
+	/* Do not cache extents that are in the process of being modified. */
+	flags |= EXT4_EX_NOCACHE;
+
 	if (map->m_lblk + map->m_len < ee_block + ee_len) {
 		split_flag1 = split_flag & EXT4_EXT_MAY_ZEROOUT;
 		flags1 = flags | EXT4_GET_BLOCKS_SPLIT_NOMERGE;
-- 
2.46.1


