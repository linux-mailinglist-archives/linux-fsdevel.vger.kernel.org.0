Return-Path: <linux-fsdevel+bounces-24862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D98945D74
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 13:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F201F21BCE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 11:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849191E3CA9;
	Fri,  2 Aug 2024 11:55:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2ED1DF66F;
	Fri,  2 Aug 2024 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722599708; cv=none; b=GydDUGe4EYsSPEjrckDCv07iPR+kw+xgkyUaTJAhgYIMwkKNdPjNA8k8lp4VYb0Nha1VBH7VuYQJSRY9OH7gnZUncOy/ruf5E/Wla/0TmkkJUH94IF4Xf2v7JNsMXWb8Bcw++jIQPvpI3zojSV7Z8TzbWqIZYBE6QKpIwdNkUUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722599708; c=relaxed/simple;
	bh=YYP9qKP0/QjsHmLTzTZRlusRA1xlwgqRm13oyhOlwR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XTxC3lsA/JPQcDZjwh1TgmApq/HkcoxCQj3K1RUDYp3X0zMM718g20F7DBDFSLnIZpCeZAcIFZ2LAMpF6X05cLA6S7J66UBfZa49gS8kW57yZUTVliWKEY0RJ5o6axlgpF1HjOch0c6EuFq+YiNaFB2NajobPXAWrW/A2XkY3M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wb45B4v16z4f3jtT;
	Fri,  2 Aug 2024 19:54:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7317D1A07B6;
	Fri,  2 Aug 2024 19:55:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4UJyaxmamI8Ag--.7970S6;
	Fri, 02 Aug 2024 19:55:03 +0800 (CST)
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
Subject: [PATCH v2 02/10] ext4: optimize the EXT4_GET_BLOCKS_DELALLOC_RESERVE flag set
Date: Fri,  2 Aug 2024 19:51:12 +0800
Message-Id: <20240802115120.362902-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
References: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3n4UJyaxmamI8Ag--.7970S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1UXrWUZry7WrWkXr1UJrb_yoW5Aw4kpr
	W3CFyrGa1qg345ua93Xw4rWr1fCw4kGF4UArWSg3yUZ39IyrySgF98tF1F9FWxKrs3Z3Z0
	qF1Y934xua45CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7VU1c18PUUUUU==
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


