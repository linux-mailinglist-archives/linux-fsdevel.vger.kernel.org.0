Return-Path: <linux-fsdevel+bounces-25778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAD5950545
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 14:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290E4285609
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 12:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6164D19DF78;
	Tue, 13 Aug 2024 12:39:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C9619B59F;
	Tue, 13 Aug 2024 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552768; cv=none; b=ZDjshC4VYwlyeEUwL5co+CyB8iZoPkuYvXoR/TIFAMxi/RlO342dN3oZ5SwL95WyI0zR8yz6ur8EqZheNLWeSHO7OuqvHlYP7kO2dTfe1xfxars9QXO7th3dhTEZM3U7I+Nb9QBjlrPaR3A7Zqke6zOUgG9x9/TvrK9rBcJxnFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552768; c=relaxed/simple;
	bh=w5S/Rpk/SCinJlK6X6VYpvfgL+QV+Eg9Z4KwTHRyQqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hBQJDKX/ooVzMAMi9CuWL6pqjgkWwQUlI++bgncH2Ug5qk0GSdQqg33jA5yhnszXINT89TbuiC9Z9VB11YZ/+LXxIa/UL3W3plfrbxOM4xiOau/vhLe+FY48o7NGwNYHl1PceLKXbXBRLry3Pso8mAEjDpr7+LN+C2lrzSdk9/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WjrY26Sfqz4f3m7T;
	Tue, 13 Aug 2024 20:39:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8BC301A058E;
	Tue, 13 Aug 2024 20:39:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBnj4XkU7tmejNSBg--.17625S6;
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
Subject: [PATCH v3 02/12] ext4: optimize the EXT4_GET_BLOCKS_DELALLOC_RESERVE flag set
Date: Tue, 13 Aug 2024 20:34:42 +0800
Message-Id: <20240813123452.2824659-3-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBnj4XkU7tmejNSBg--.17625S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1UXrWUZry7WrWkXr1UJrb_yoW5CrW5pr
	W3CFyrGF4qg345ua93Xw4rWr1fCw4kGF4UArWSg3yUZ39IyrySgF98tF1F9FW8Krs3ZFn0
	qF15u34xua45CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
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
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUQXo7UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When doing block allocation, magic EXT4_GET_BLOCKS_DELALLOC_RESERVE
means the allocating range covers a range of delayed allocated clusters,
the blocks and quotas have already been reserved in ext4_da_map_blocks(),
we should update the reserved space and don't need to claim them again.

At the moment, we only set this magic in mpage_map_one_extent() when
allocating a range of delayed allocated clusters in the write back path,
it makes things complicated since we have to notice and deal with the
case of allocating non-delayed allocated clusters separately in
ext4_ext_map_blocks(). For example, it we fallocate some blocks that
have been delayed allocated, free space would be claimed again in
ext4_mb_new_blocks() (this is wrong exactily), and we can't claim quota
space again, we have to release the quota reservations made for that
previously delayed allocated clusters.

Move the position thats set the EXT4_GET_BLOCKS_DELALLOC_RESERVE to
where we actually do block allocation, it could simplify above handling
a lot, it means that we always set this magic once the allocation range
covers delalloc blocks, no need to take care of the allocation path.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 112aec171ee9..91b2610a6dc5 100644
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
@@ -2224,11 +2232,6 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
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
@@ -2236,8 +2239,6 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 	dioread_nolock = ext4_should_dioread_nolock(inode);
 	if (dioread_nolock)
 		get_blocks_flags |= EXT4_GET_BLOCKS_IO_CREATE_EXT;
-	if (map->m_flags & BIT(BH_Delay))
-		get_blocks_flags |= EXT4_GET_BLOCKS_DELALLOC_RESERVE;
 
 	err = ext4_map_blocks(handle, inode, map, get_blocks_flags);
 	if (err < 0)
-- 
2.39.2


